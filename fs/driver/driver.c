#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fs_globle.h"
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
    return 0;
}

int read_multiple_blocks(Device *device, uint64_t start_block_id, void *buffer, size_t buffer_size)
{
    uint64_t num_blocks_to_read = buffer_size / SECTOR_SIZE;
    uint64_t current_block_id = start_block_id;
    size_t bytes_read = 0;

    while (bytes_read < buffer_size && num_blocks_to_read > 0)
    {
        int result = read_block(device, current_block_id, buffer);
        if (result != 0)
        {
            printf("Error reading block %lu\n", current_block_id);
            return -1; // 读取失败
        }

        bytes_read += SECTOR_SIZE;
        buffer += SECTOR_SIZE;
        current_block_id++;
        num_blocks_to_read--;
    }

    return bytes_read;
}

int write_multiple_blocks(Device *device, uint64_t start_block_id, const void *buffer, size_t buffer_size)
{
    uint64_t num_blocks_to_write = buffer_size / SECTOR_SIZE;
    uint64_t current_block_id = start_block_id;
    size_t bytes_written = 0;

    while (bytes_written < buffer_size && num_blocks_to_write > 0)
    {
        int result = write_block(device, current_block_id, buffer);
        if (result != 0)
        {
            printf("Error writing block %lu\n", current_block_id);
            return -1; // 写入失败
        }

        bytes_written += SECTOR_SIZE;
        buffer += SECTOR_SIZE;
        current_block_id++;
        num_blocks_to_write--;
    }
    return bytes_written;
}

int read_by_cluster(Device *device, uint64_t cluser_num, void *buffer)
{
    uint64_t start_block_id = CLUSTER_TO_LBA(cluser_num);
    size_t buffer_size = CLUSER_SIZE;
    return read_multiple_blocks(device, start_block_id, buffer, buffer_size);
}



int write_by_cluster(Device *device, uint64_t cluser_num, const void *buffer)
{
    uint64_t start_block_id = CLUSTER_TO_LBA(cluser_num);
    size_t buffer_size = CLUSER_SIZE;
    return write_multiple_blocks(device, start_block_id, buffer, buffer_size);
}

int read_by_byte(Device *device, uint64_t block_num, uint64_t offset, uint64_t size_byte, void *buffer)
{
    if (offset + size_byte > BLOCK_SIZE)
    {
        return -1; // 表示错误，偏移量超出范围
    }

    uint8_t block_data[BLOCK_SIZE];
    if (read_block(device, block_num, block_data) != 0)
    {
        return -1; // 读取块数据失败
    }

    for (int i = 0; i < size_byte; ++i)
    {
        ((uint8_t *)buffer)[i] = block_data[offset + i];
    }

    return 0; // 表示成功
}

int write_by_byte(Device *device, uint64_t block_num, uint64_t offset, uint64_t size_byte, const void *buffer)
{
    if (offset + size_byte > BLOCK_SIZE)
    {
        return -1; // 表示错误，偏移量超出范围
    }

    // 读取整个块的数据
    uint8_t block_data[BLOCK_SIZE];
    if (read_block(device, block_num, block_data) != 0)
    {
        return -1; // 读取块数据失败
    }

    // 将缓冲区的数据写入块的指定偏移位置
    for (int i = 0; i < size_byte; ++i)
    {
        block_data[offset + i] = ((const uint8_t *)buffer)[i];
    }

    // 将更新后的数据写回设备
    if (write_block(device, block_num, block_data) != 0)
    {
        return -1; // 写入块数据失败
    }

    return 0; // 表示成功
}

// 将一个指定块号的块复制到指定的块
int copy_block(Device *device, uint64_t src_block_num, uint64_t dest_block_num)
{
    if (device == NULL || src_block_num >= device->total_blocks || dest_block_num >= device->total_blocks)
    {
        return -1;
    }
    void *buffer = malloc(SECTOR_SIZE);
    if (buffer == NULL)
    {
        return -1;
    }
    if (read_block(device, src_block_num, buffer) != 0)
    {
        free(buffer);
        return -1;
    }
    if (write_block(device, dest_block_num, buffer) != 0)
    {
        free(buffer);
        return -1;
    }
    free(buffer);
    return 0;
}