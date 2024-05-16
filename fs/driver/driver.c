#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fs_globle.h"

void close_device(Device *device)
{
    if (device && device->disk)
    {
        fclose(device->disk);
        free(device->name);
    }
}

int read_block(Device *device, uint64_t block_num, void *buffer)
{
    if (!device || !buffer)
        return -1;
    if (block_num >= device->total_blocks)
        return -1;

    // 定位到块的开始位置
    if (fseek(device->disk, block_num * device->block_size, SEEK_SET) != 0)
    {
        perror("Failed to seek");
        return -1;
    }

    // 读取块内容
    if (fread(buffer, 1, device->block_size, device->disk) != device->block_size)
    {
        perror("Failed to read block");
        return -1;
    }

    return 0;
}

int write_block(Device *device, uint64_t block_num, const void *buffer)
{
    if (!device || !buffer)
        return -1;
    if (block_num >= device->total_blocks)
        return -1;

    // 定位到块的开始位置
    if (fseek(device->disk, block_num * device->block_size, SEEK_SET) != 0)
    {
        perror("Failed to seek");
        return -1;
    }

    // 写入块内容
    if (fwrite(buffer, 1, device->block_size, device->disk) != device->block_size)
    {
        perror("Failed to write block");
        return -1;
    }

    // 刷新缓冲区，确保数据写入磁盘
    fflush(device->disk);

    return 0;
}

// 初始化设备
int initialize_device(Device *device, const char *name, uint64_t total_blocks, uint32_t block_size)
{
    if (!device || !name)
        return -1;
    device->name = strdup(name);
    device->total_blocks = total_blocks;
    device->block_size = block_size;
    device->disk = fopen(name, "r+b");
    if (!device->disk)
    {
        perror("Failed to open disk");
        free(device->name);
        return -1;
    }
    return 0;
}

int write_multiple_sectors(Device *device, char *buf, uint64_t start_sector, size_t buf_size)
{
    if (!device || !buf)
        return -1;

    size_t bytes_remaining = buf_size;
    const char *current_ptr = buf;
    uint64_t current_sector = start_sector;

    while (bytes_remaining > 0)
    {
        // 计算当前要写入的字节数
        size_t bytes_to_write = (bytes_remaining > device->block_size) ? device->block_size : bytes_remaining;

        // 创建一个扇区大小的临时缓冲区并清零
        char sector_buf[device->block_size];
        memset(sector_buf, 0, device->block_size);
        memcpy(sector_buf, current_ptr, bytes_to_write);

        // 写入当前扇区
        if (write_block(device, current_sector, sector_buf) != 0)
        {
            perror("Failed to write block");
            return -1;
        }

        // 更新指针和剩余字节数
        current_ptr += bytes_to_write;
        bytes_remaining -= bytes_to_write;
        current_sector++;
    }

    return 0;
}