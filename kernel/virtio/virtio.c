#include "virtio.h"
#include "virt_map.h"

void init_virtio_device()
{
    if (read_addr(VIRTIO_MAGIC_OFFSET) != 0x74726976)
    {
        printk("Error: Invalid Magic Value.\n");
        return;
    }
    if (read_addr(VIRTIO_VERSION_OFFSET) != 1)
    {
        printk("Error: Unsupported version.\n");
        return;
    }
    if (read_addr(VIRTIO_DEVICE_ID_OFFSET) != 2)
    {
        printk("Error: Device is not a block device.\n");
        return;
    }
    printk("Device confirmed as VirtIO block device.\n");

    // 步骤 2: 设备重置
    write_addr(VIRTIO_STATUS_OFFSET, VIRTIO_STATUS_RESET); // Reset device

    // 步骤 3: 设置设备状态和特性协商
    write_addr(VIRTIO_STATUS_OFFSET, VIRTIO_STATUS_ACKNOWLEDGE);
    write_addr(VIRTIO_STATUS_OFFSET, VIRTIO_STATUS_DRIVER);
    uint32_t features = read_addr(VIRTIO_FEATURES_OFFSET);
    write_addr(VIRTIO_FEATURES_OK_OFFSET, features); // 假设不修改特性
    write_addr(VIRTIO_STATUS_OFFSET, VIRTIO_STATUS_FEATURES_OK);

    // 步骤 4: 最终确认特性
    if (!(read_addr(VIRTIO_STATUS_OFFSET) & VIRTIO_STATUS_FEATURES_OK))
    {
        printk("Error");
        return;
    }
    printk("Device initialized successfully with FEATURES_OK.\n");
}