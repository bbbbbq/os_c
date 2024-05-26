#include "virtio_disk.h"
#include "stdint.h"
#include "string.h"
#include "virtio.h"
#include "debug.h"
#include "riscv.h"
DISK disk;
void virtio_disk_init()
{
    uint32_t status = 0;

    if (read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_MAGIC_VALUE)) != 0x74726976 ||
        read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_VERSION)) != 1 ||
        read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_DEVICE_ID)) != 2 ||
        read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_VENDOR_ID)) != 0x554d4551)
    {
        panic("could not find virtio disk\n");
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_STATUS), status);

    status |= VIRTIO_CONFIG_S_DRIVER;
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_STATUS), status);

    uint64_t features = read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_DEVICE_FEATURES));
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_DRIVER_FEATURES), features);

    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_STATUS), status);

    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_STATUS), status);

    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_GUEST_PAGE_SIZE), PAGE_SIZE);
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_QUEUE_SEL), 0);
    uint32_t max = read_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_QUEUE_NUM_MAX));
    if (max == 0)
        panic("virtio disk has no queue 0\n");
    if (max < NUM_DESCRIPTORS)
        panic("virtio disk max queue too short\n");
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_QUEUE_NUM), NUM_DESCRIPTORS);

    memset(disk.pages, 0, sizeof(disk.pages));
    write_reg((uint32_t *)(VIRTIO_BASE_ADDRESS + VIRTIO_MMIO_QUEUE_PFN), ((uint64_t)disk.pages) >> PAGE_SHIFT);

    disk.desc = (VirtqDesc *)disk.pages;
    disk.avail = (VirtqAvail *)(disk.pages + NUM_DESCRIPTORS * sizeof(VirtqDesc));
    disk.used = (VirtqUsed *)((uint8_t *)disk.pages + PAGE_SIZE);

    for (int i = 0; i < NUM_DESCRIPTORS; i++)
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
void virtio_disk_rw(Block *block, int write)
{
    uint64_t sector = block->sector_number * (BLOCK_SIZE / 512);
    // the spec's Section 5.2 says that legacy block operations use
    // three descriptors: one for type/reserved/sector, one for the
    // data, one for a 1-byte status result.
    // allocate the three descriptors.
    int idx[3];
    while (1)
    {
        if (alloc3_desc(idx) == 0)
        {
            break;
        }
    }
    virtio_blk_req *buf0 = &disk.ops[idx[0]];

    if (write)
        buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    else
        buf0->type = VIRTIO_BLK_T_IN; // read the disk
    buf0->reserved = 0;
    buf0->sector = sector;

    disk.desc[idx[0]].addr = (uint64_t)buf0;
    disk.desc[idx[0]].len = sizeof(virtio_blk_req);
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint64_t)block->data;
    disk.desc[idx[1]].len = BLOCK_SIZE;
    if (write)
        disk.desc[idx[1]].flags = 0; // device reads b->cache
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->cache
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    disk.info[idx[0]] = 0xfb; // device writes 0 on success
    disk.desc[idx[2]].addr = (uint64_t)&disk.info[idx[0]];
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    disk.desc[idx[2]].next = 0;

    disk.avail->ring[disk.avail->idx % NUM] = idx[0];

    __sync_synchronize();

    disk.avail->idx += 1;

    __sync_synchronize();

    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number

    // Wait for virtio_disk_intr() to say request has finished.
    intr_on();
    int id = 1000000;
    while (disk.info[idx[0]] == 0xfb)
    {
        // WARN: No kernel concurrent support, DO NOT allow kernel yield
        // yield();
    }
    intr_off();
    free_chain(idx[0]);
}

void virtio_disk_intr()
{
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;

    __sync_synchronize();

    while (disk.used_idx != disk.used->idx)
    {
        __sync_synchronize();
        int id = disk.used->ring[disk.used_idx % NUM].id;

        if (disk.info[id] != 0)
            panic("virtio_disk_intr status\n");
        disk.used_idx += 1;
    }
}

Block read_block(uint32_t block_id)
{
    Block block;
    block.sector_number = block_id;
    virtio_disk_rw(&block, 0);
    return block;
}

void write_block(Block block)
{
    virtio_disk_rw(&block, 1);
}