#ifndef DRIVER_H
#define DRIVER_H

#include <stdint.h>
#include <stddef.h>

// 设备结构体
typedef struct Device {
    char* name;              // 设备名称
    uint64_t total_blocks;   // 设备总块数
    uint32_t block_size;     // 每个块的大小（字节）

    // 函数指针：读取指定块到缓冲区
    int (*read_block)(struct Device* device, uint64_t block_num, void* buffer);

    // 函数指针：将缓冲区的数据写入到指定的块
    int (*write_block)(struct Device* device, uint64_t block_num, const void* buffer);
} Device;

// 函数声明：初始化设备
int initialize_device(Device* device, const char* name, uint64_t total_blocks, uint32_t block_size);

#endif // DEVICE_DRIVER_H
