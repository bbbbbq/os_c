#include "stdint.h"
#include "virtio.h"
#include "config.h"
#include "virtio_disk.h"
void virtio_disk_init()
{
    uint32_t status = 0;
    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
        *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551)
    {
        panic("无法找到 virtio 磁盘\n");
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    *R(VIRTIO_MMIO_STATUS) = status;

    status |= VIRTIO_CONFIG_S_DRIVER;
    *R(VIRTIO_MMIO_STATUS) = status;

    uint64_t features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;

    // 通知设备特性协商完成
    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    // 通知设备驱动已完全准备好
    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGE_SIZE;

    // 初始化队列0
    *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    uint32_t max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    if (max == 0)
        panic("virtio 磁盘没有队列0\n");
    if (max < NUM)
        panic("virtio 磁盘的最大队列长度太短\n");
    *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    memset(disk.pages, 0, sizeof(disk.pages));
    *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64_t)disk.pages) >> PAGE_SHIFT;

    // 设置描述符、可用环和已用环的位置
    disk.desc = (struct virtq_desc *)disk.pages;
    disk.avail = (struct virtq_avail *)(disk.pages + NUM * sizeof(struct virtq_desc));
    disk.used = (struct virtq_used *)(disk.pages + PAGE_SIZE);

    // 初始化所有 NUM 描述符为未使用状态
    for (int i = 0; i < NUM; i++)
        disk.free[i] = 1;
}