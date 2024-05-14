#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 读取指定块到缓冲区
int read_block(Device *device, uint64_t block_num, void *buffer)
{
    if (!device || !buffer)
        return -1;
    if (block_num >= device->total_blocks)
        return -1;

    FILE *disk = fopen(device->name, "rb");
    if (!disk)
        return -1;

    // 定位到块的开始位置
    if (fseek(disk, block_num * device->block_size, SEEK_SET) != 0)
    {
        fclose(disk);
        return -1;
    }

    // 读取块内容
    if (fread(buffer, 1, device->block_size, disk) != device->block_size)
    {
        fclose(disk);
        return -1;
    }

    fclose(disk);
    return 0;
}

// 将缓冲区的数据写入到指定的块
int write_block(Device *device, uint64_t block_num, const void *buffer)
{
    if (!device || !buffer)
        return -1;
    if (block_num >= device->total_blocks)
        return -1;

    FILE *disk = fopen(device->name, "r+b");
    if (!disk)
        return -1;

    // 定位到块的开始位置
    if (fseek(disk, block_num * device->block_size, SEEK_SET) != 0)
    {
        fclose(disk);
        return -1;
    }

    // 写入块内容
    if (fwrite(buffer, 1, device->block_size, disk) != device->block_size)
    {
        fclose(disk);
        return -1;
    }

    fclose(disk);
    return 0;
}

// 初始化设备
int initialize_device(Device *device, const char *name, uint64_t total_blocks, uint32_t block_size)
{
    if (!device || !name)
        return -1;

    device->name = strdup(name); // 复制设备名称
    device->total_blocks = total_blocks;
    device->block_size = block_size;
    device->read_block = read_block;
    device->write_block = write_block;
    return 0;
}
