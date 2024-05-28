#include "drivers.h"
#include "virtio.h"

const int R = 0;
const int W = 1;

void virtio_read_block(struct BlockCache *b) { virtio_disk_rw(b, R); }

void virtio_write_block(struct BlockCache *b) { virtio_disk_rw(b, W); }

BlockDevice BLOCK_DEVICE;

BlockDevice *virtio_block_device_init()
{
    virtio_disk_init();
    BLOCK_DEVICE.read_block = virtio_read_block;
    BLOCK_DEVICE.write_block = virtio_write_block;
    return &BLOCK_DEVICE;
}
