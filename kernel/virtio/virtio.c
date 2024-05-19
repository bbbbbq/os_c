#include "stdint.h"
#include "virtio.h"
#include "config.h"
#include "virtio_disk.h"
#include "riscv.h"

void virtio_disk_init()
{
    uint32_t status = 0;

    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
        *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551)
    {
        panic("could not find virtio disk\n");
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    *R(VIRTIO_MMIO_STATUS) = status;

    status |= VIRTIO_CONFIG_S_DRIVER;
    *R(VIRTIO_MMIO_STATUS) = status;

    // negotiate features
    uint64_t features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;

    // tell device that feature negotiation is complete.
    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    // tell device we're completely ready.
    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGE_SIZE;

    // initialize queue 0.
    *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    uint32_t max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    if (max == 0)
        panic("virtio disk has no queue 0\n");
    if (max < NUM)
        panic("virtio disk max queue too short\n");
    *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    memset(disk.pages, 0, sizeof(disk.pages));
    *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64_t)disk.pages) >> PAGE_SHIFT;

    disk.desc = (struct virtq_desc *)disk.pages;
    disk.avail =
        (struct virtq_avail *)(disk.pages + NUM * sizeof(struct virtq_desc));
    disk.used = (struct virtq_used *)(disk.pages + PAGE_SIZE);

    // all NUM descriptors start out unused.
    for (int i = 0; i < NUM; i++)
        disk.free[i] = 1;

    // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
int alloc3_desc(int *idx)
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

void free_chain(int i)
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

void free_desc(int i)
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

int alloc_desc()
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

static uint32_t virtio_disk_rw_cnt = 1;
void virtio_disk_rw(BlockCache *b, int write)
{
    printk("virtio_disk_rw_cnt : %d\n", virtio_disk_rw_cnt++);
    printk("virtio_disk_rw_start\n");
    uint64_t sector = b->block_id * (BLOCK_SZ / 512);
    int idx[3];
    while (1)
    {
        if (alloc3_desc(idx) == 0)
        {
            break;
        }
    }
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

    if (write)
        buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    else
        buf0->type = VIRTIO_BLK_T_IN; // read the disk
    buf0->reserved = 0;
    buf0->sector = sector;

    disk.desc[idx[0]].addr = (uint64_t)buf0;
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint64_t)b->cache;
    disk.desc[idx[1]].len = BLOCK_SZ;
    if (write)
        disk.desc[idx[1]].flags = 0; // device reads b->cache
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->cache
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    disk.info[idx[2]].status = 0xfb; // device writes 0 on success
    disk.desc[idx[2]].addr = (uint64_t)&disk.info[idx[0]].status;
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    disk.desc[idx[2]].next = 0;

    b->disk = true;
    disk.info[idx[0]].b = b;

    disk.avail->ring[disk.avail->idx % NUM] = idx[0];

    __sync_synchronize();

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM

    __sync_synchronize();

    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number

    // Wait for virtio_disk_intr() to say request has finished.
    BlockCache volatile *_b = b; // Make sure complier will load 'b' form memory
    intr_on();
    while (_b->disk)
    {
        // printk("123");
    }
    intr_off();
    disk.info[idx[0]].b = 0;
    free_chain(idx[0]);
}

void virtio_read_block(BlockCache *b) { virtio_disk_rw(b, 0); }

void virtio_write_block(BlockCache *b) { virtio_disk_rw(b, 1); }

BlockDevice *virtio_block_device_init()
{
    printk("virtio_block_device_init_start\n");
    virtio_disk_init();
    BLOCK_DEVICE.read_block = virtio_read_block;
    BLOCK_DEVICE.write_block = virtio_write_block;
    return &BLOCK_DEVICE;
}

void virtio_disk_intr()
{
    // the device won't raise another interrupt until we tell it
    // we've seen this interrupt, which the following line does.
    // this may race with the device writing new entries to
    // the "used" ring, in which case we may process the new
    // completion entries in this interrupt, and have nothing to do
    // in the next interrupt, which is harmless.
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;

    __sync_synchronize();

    // the device increments disk.used->idx when it
    // adds an entry to the used ring.

    while (disk.used_idx != disk.used->idx)
    {
        __sync_synchronize();
        int id = disk.used->ring[disk.used_idx % NUM].id;

        if (disk.info[id].status != 0)
            panic("virtio_disk_intr status 123\n");

        BlockCache *b = disk.info[id].b;
        b->disk = false;
        disk.used_idx += 1;
    }
}
