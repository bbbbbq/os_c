#include "driver.h"
#include "config.h"
#include "riscv.h"
#include "string.h"
#include "task.h"
#include "fs.h"
// Define constants for read and write operations

// Define disk structure
static struct disk
{
    char pages[2 * PAGE_SIZE];
    struct virtq_desc *desc;
    struct virtq_avail *avail;
    struct virtq_used *used;
    char free[NUM];
    uint16_t used_idx;
    struct
    {
        struct BlockCache *b;
        char status;
    } info[NUM];
    struct virtio_blk_req ops[NUM];
} __attribute__((aligned(PAGE_SIZE))) disk;

// Function to initialize the virtio disk
void virtio_disk_init()
{
    uint32_t status = 0;

    if (*REG(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
        *REG(VIRTIO_MMIO_VERSION) != 1 || *REG(VIRTIO_MMIO_DEVICE_ID) != 2 ||
        *REG(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551)
    {
        panic("could not find virtio disk\n");
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    *REG(VIRTIO_MMIO_STATUS) = status;

    status |= VIRTIO_CONFIG_S_DRIVER;
    *REG(VIRTIO_MMIO_STATUS) = status;

    // Negotiate features
    uint64_t features = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    *REG(VIRTIO_MMIO_DRIVER_FEATURES) = features;

    // Tell device that feature negotiation is complete
    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    *REG(VIRTIO_MMIO_STATUS) = status;

    // Tell device we're completely ready
    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    *REG(VIRTIO_MMIO_STATUS) = status;

    *REG(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGE_SIZE;

    // Initialize queue 0
    *REG(VIRTIO_MMIO_QUEUE_SEL) = 0;
    uint32_t max = *REG(VIRTIO_MMIO_QUEUE_NUM_MAX);
    if (max == 0)
        panic("virtio disk has no queue 0\n");
    if (max < NUM)
        panic("virtio disk max queue too short\n");
    *REG(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    memset(disk.pages, 0, sizeof(disk.pages));
    *REG(VIRTIO_MMIO_QUEUE_PFN) = ((uint64_t)disk.pages) >> PAGE_SHIFT;

    // Point descriptors, avail, and used to appropriate regions of pages
    disk.desc = (struct virtq_desc *)disk.pages;
    disk.avail =
        (struct virtq_avail *)(disk.pages + NUM * sizeof(struct virtq_desc));
    disk.used = (struct virtq_used *)(disk.pages + PAGE_SIZE);

    // All NUM descriptors start out unused
    for (int i = 0; i < NUM; i++)
        disk.free[i] = 1;
}

// Function to allocate a descriptor
static int alloc_desc()
{
    for (int i = 0; i < NUM; i++)
    {
        if (disk.free[i])
        {
            disk.free[i] = 0;
            return i;
        }
    }
    return -1;
}

// Function to free a descriptor
static void free_desc(int i)
{
    if (i >= NUM)
        panic("free_desc 1\n");
    if (disk.free[i])
        panic("free_desc 2\n");
    disk.desc[i].addr = 0;
    disk.desc[i].len = 0;
    disk.desc[i].flags = 0;
    disk.desc[i].next = 0;
    disk.free[i] = 1;
}

// Function to free a chain of descriptors
static void free_chain(int i)
{
    while (1)
    {
        int flag = disk.desc[i].flags;
        int nxt = disk.desc[i].next;
        free_desc(i);
        if (flag & VRING_DESC_F_NEXT)
            i = nxt;
        else
            break;
    }
}

// Function to allocate three descriptors
static int alloc3_desc(int *idx)
{
    for (int i = 0; i < 3; i++)
    {
        idx[i] = alloc_desc();
        if (idx[i] < 0)
        {
            for (int j = 0; j < i; j++)
                free_desc(idx[j]);
            return -1;
        }
    }
    return 0;
}

// Function to perform read or write operation on the disk
void virtio_disk_rw(struct BlockCache *b, int write)
{
    uint64_t sector = b->block_id * (BLOCK_SIZE / 512);

    // Allocate three descriptors for the operation
    int idx[3];
    while (1)
    {
        if (alloc3_desc(idx) == 0)
        {
            break;
        }
    }

    // Format the descriptors
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    if (write)
        buf0->type = VIRTIO_BLK_T_OUT; // Write operation
    else
        buf0->type = VIRTIO_BLK_T_IN; // Read operation
    buf0->reserved = 0;
    buf0->sector = sector;
    disk.desc[idx[0]].addr = (uint64_t)buf0;
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint64_t)b->cache;
    disk.desc[idx[1]].len = BLOCK_SIZE;
    if (write)
        disk.desc[idx[1]].flags = 0; // Device reads from cache
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // Device writes to cache
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    disk.info[idx[0]].status = 0xfb; // Device writes 0 on success
    disk.desc[idx[2]].addr = (uint64_t)&disk.info[idx[0]].status;
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // Device writes the status
    disk.desc[idx[2]].next = 0;

    // Record BlockCache for virtio_disk_intr
    b->disk = true;
    disk.info[idx[0]].b = b;

    // Tell the device the first index in our chain of descriptors
    disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    __sync_synchronize();

    // Tell the device another avail ring entry is available
    disk.avail->idx += 1; // Not % NUM
    __sync_synchronize();

    *REG(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // Value is queue number

    // Wait for virtio_disk_intr to signal completion
    struct BlockCache volatile *_b = b; // Make sure compiler will load 'b' from memory
    intr_on();
    while (_b->disk)
    {
        // No kernel concurrent support, do not allow kernel yield
    }
    intr_off();
    disk.info[idx[0]].b = 0;
    free_chain(idx[0]);
}

// Function to handle disk interrupt
void virtio_disk_intr()
{
    // Acknowledge the interrupt
    *REG(VIRTIO_MMIO_INTERRUPT_ACK) = *REG(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    __sync_synchronize();

    // Process completion entries in the used ring
    while (disk.used_idx != disk.used->idx)
    {
        __sync_synchronize();
        int id = disk.used->ring[disk.used_idx % NUM].id;

        if (disk.info[id].status != 0)
            panic("virtio_disk_intr status\n");

        struct BlockCache *b = disk.info[id].b;
        b->disk = false; // Disk is done with BlockCache
        disk.used_idx += 1;
    }
}
