#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fs_globle.h"
#include "assert.h"
// 读取指定块到缓冲区
int read_block(Device *device, uint64_t block_num, void *buffer)
{
    //printf("block_id:%d\n",block_num);
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
            return 0; // 读取失败
        }

        bytes_read += SECTOR_SIZE;
        buffer += SECTOR_SIZE;
        current_block_id++;
        num_blocks_to_read--;
    }

    return 1;
}

int write_multiple_blocks(Device *device, uint64_t start_block_id, const void *buffer, size_t buffer_size)
{
    // 计算要写入的块数
    uint64_t num_blocks_to_write = buffer_size / SECTOR_SIZE;
    if(buffer_size % SECTOR_SIZE!=0)num_blocks_to_write++;
    // 初始化当前块号
    uint64_t current_block_id = start_block_id;
    // 初始化已写入的字节数
    size_t bytes_written = 0;

    // 循环写入每个块的数据
    while (bytes_written < buffer_size && num_blocks_to_write > 0)
    {
        // 每次只写入一个块的数据
        int result = write_block(device, current_block_id, buffer);
        if (result != 0)
        {
            printf("Error writing block %lu\n", current_block_id);
            return -1; // 写入失败
        }

        // 更新已写入的字节数、缓冲区指针和当前块号
        bytes_written += SECTOR_SIZE;
        buffer += SECTOR_SIZE;
        current_block_id++;
        num_blocks_to_write--;
    }
    if(bytes_written > buffer_size) bytes_written -= SECTOR_SIZE - buffer_size%SECTOR_SIZE;
    // 返回已写入的总字节数
    return 1;
}

int read_by_cluster(Device *device, uint64_t cluser_num, void *buffer)
{
    uint64_t start_block_id = CLUSTER_TO_LBA(cluser_num);
    size_t buffer_size = CLUSER_SIZE;
    int tmp = read_multiple_blocks(device, start_block_id, buffer, buffer_size);
    return tmp;
}



int write_by_cluster(Device *device, uint64_t cluser_num, const void *buffer,size_t buffer_size)
{
    uint64_t start_block_id = CLUSTER_TO_LBA(cluser_num);
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
int read_by_byte_cluser(Device *device, uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer)
{
    // 检查参数有效性
    assert(buffer != NULL && device != NULL);

    // 分配临时缓冲区
    void *buffer_tmp = malloc(CLUSER_SIZE);
    if (buffer_tmp == NULL)
    {
        printf("Error: Memory allocation failed.\n");
        return 0;
    }

    // 读取整个簇的数据到临时缓冲区
    if (read_by_cluster(device, cluser_num, buffer_tmp) == 0)
    {
        printf("Error: Failed to read data from cluster.\n");
        free(buffer_tmp);
        return -1;
    }

    // 拷贝指定偏移量和大小的数据到输出缓冲区
    memcpy(buffer, buffer_tmp + offset, size_byte);

    // 释放临时缓冲区
    free(buffer_tmp);

    return 1;
}


int write_by_byte_cluser(Device *device, uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer)
{
    // 检查参数有效性
    assert(buffer != NULL && device != NULL);

    // 读取整个簇的数据到临时缓冲区
    void *buffer_tmp = malloc(CLUSER_SIZE);
    //print_hex_data(buffer_tmp,CLUSER_SIZE);
    if (buffer_tmp == NULL)
    {
        printf("Error: Memory allocation failed.\n");
        return -1;
    }
    if (read_by_cluster(device, cluser_num, buffer_tmp) == 0)
    {
        printf("Error: Failed to read data from cluster.\n");
        free(buffer_tmp);
        return -1;
    }

    // 将输入缓冲区中的数据写入临时缓冲区指定偏移量和大小的位置
    memcpy(buffer_tmp + offset, buffer, size_byte);
    //print_hex_data(buffer_tmp,CLUSER_SIZE);
    // 将更新后的数据写回簇的数据区
    if (write_by_cluster(device, cluser_num, buffer_tmp,sizeof(buffer_tmp)) == 0)
    {
        printf("Error: Failed to write data back to cluster.\n");
        free(buffer_tmp);
        return -1;
    }

    // 释放临时缓冲区
    free(buffer_tmp);

    return 0;
}

void print_by_cluster(Device *device, uint64_t cluster_num)
{
    // 分配一个缓冲区来存储从设备读取的数据
    uint8_t buffer[CLUSER_SIZE];

    // 读取指定簇的数据到缓冲区中
    if (read_by_cluster(device, cluster_num, buffer) == 0)
    {
        fprintf(stderr, "Error: Failed to read data from cluster %lu\n", cluster_num);
        return;
    }

    // 打印读取到的数据
    printf("Data in cluster %lu:\n", cluster_num);
    for (int i = 0; i < CLUSER_SIZE; ++i)
    {
        printf("%02X ", buffer[i]); // 以十六进制形式打印每个字节的值
        if ((i + 1) % 16 == 0)
        {
            printf("\n"); // 每行打印 16 个字节
        }
    }
    printf("\n");
}

void print_hex_data(void *data, size_t size)
{
    uint8_t *bytes = (uint8_t *)data;
    for (size_t i = 0; i < size; ++i)
    {
        printf("%02X ", bytes[i]); // 以十六进制形式打印每个字节的值
        if ((i + 1) % 16 == 0)
        {
            printf("\n"); // 每行打印 16 个字节
        }
    }
    printf("\n");
}
