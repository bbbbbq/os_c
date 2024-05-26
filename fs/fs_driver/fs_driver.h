#ifndef DRIVER_H
#define DRIVER_H

#include <stdint.h>
#include <stddef.h>
#define SECTOR_SIZE 512
#define CLUSER_SIZE (SECTOR_SIZE * 8)
#define BLOCK_SIZE 512

typedef struct
{
    uint64_t sector_number;   // 起始扇区号
    uint8_t data[BLOCK_SIZE]; // 数据缓冲区，直接存储数据
} Block;
// 函数声明：初始化设备
void print_by_cluster(uint64_t cluster_num);
int read_block_fs(uint64_t block_num, void *buffer);
int write_block_fs(uint64_t block_num, const void *buffer);
int read_multiple_blocks(uint64_t start_block_id, void *buffer, size_t buffer_size);
int write_multiple_blocks(uint64_t start_block_id, const void *buffer, size_t buffer_size);
int read_by_cluster(uint64_t cluser_num, void *buffer);
int write_by_cluster(uint64_t cluser_num, const void *buffer, size_t buffer_size);
int read_by_byte(uint64_t block_num, uint64_t offset, uint64_t size_byte, void *buffer);
int write_by_byte(uint64_t block_num, uint64_t offset, uint64_t size_byte, const void *buffer);
int copy_block(uint64_t src_block_num, uint64_t dest_block_num);
int read_by_byte_cluser(uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer);
int write_by_byte_cluser(uint64_t cluser_num, uint64_t offset, uint64_t size_byte, void *buffer);
void print_hex_data(void *data, size_t size);
void write_block(Block block);
Block read_block(uint64_t block_num);
#endif