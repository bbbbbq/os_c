#ifndef DRIVER_H
#define DRIVER_H

#include <stdint.h>
#include <stddef.h>
#define SECTOR_SIZE 512
#define CLUSER_SIZE (SECTOR_SIZE*8)
// 设备结构体
typedef struct Device {
    char* name;              // 设备名称
    uint64_t total_blocks;   // 设备总块数
    uint32_t block_size;     // 每个块的大小（字节）
} Device;

// 函数声明：初始化设备
void print_by_cluster(Device *device, uint64_t cluster_num);
int initialize_device(Device* device, const char* name, uint64_t total_blocks, uint32_t block_size);
int read_block(Device *device, uint64_t block_num, void *buffer);
int write_block(Device *device, uint64_t block_num, const void *buffer);
int read_multiple_blocks(Device *device, uint64_t start_block_id, void *buffer, size_t buffer_size);
int write_multiple_blocks(Device *device, uint64_t start_block_id, const void *buffer, size_t buffer_size);
int read_by_cluster(Device *device, uint64_t cluser_num, void *buffer);
int write_by_cluster(Device *device, uint64_t cluser_num, const void *buffer, size_t buffer_size);
int read_by_byte(Device *device, uint64_t block_num, uint64_t offset, uint64_t size_byte, void *buffer);
int write_by_byte(Device *device, uint64_t block_num, uint64_t offset, uint64_t size_byte, const void *buffer);
int copy_block(Device *device, uint64_t src_block_num, uint64_t dest_block_num);
int read_by_byte_cluser(Device *device, uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer);
int write_by_byte_cluser(Device *device, uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer);
void print_hex_data(void *data, size_t size);

#endif