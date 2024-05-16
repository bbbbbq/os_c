#ifndef DRIVER_H
#define DRIVER_H
#include <string.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
// 设备结构体
typedef struct Device
{
    char *name;            // 设备名称
    uint64_t total_blocks; // 设备总块数
    uint32_t block_size;   // 每个块的大小（字节）
    FILE *disk;            // 全局文件指针
} Device;

// 函数声明：初始化设备
int read_block(Device *device, uint64_t block_num, void *buffer);
int write_block(Device *device, uint64_t block_num, const void *buffer);
int initialize_device(Device *device, const char *name, uint64_t total_blocks, uint32_t block_size);
int write_multiple_sectors(Device *device, char *buf, uint64_t start_sector, size_t buf_size);
void close_device(Device *device);
#endif // DEVICE_DRIVER_H
