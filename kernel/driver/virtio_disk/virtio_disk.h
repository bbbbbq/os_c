#ifndef VIRTIO_DISK_H
#define VIRTIO_DISK_H
#include "virtio.h"
#include "config.h"
#define BLOCK_SIZE 512
typedef struct
{
    char pages[2 * PAGE_SIZE];
    VirtqDesc *desc;
    VirtqAvail *avail;
    VirtqUsed *used;
    char free[NUM_DESCRIPTORS];
    uint16_t used_idx;
    virtio_blk_req ops[NUM_DESCRIPTORS];
    char info[NUM_DESCRIPTORS];
} __attribute__((aligned(PAGE_SIZE))) DISK;

typedef struct
{
    uint64_t sector_number;   // 起始扇区号
    uint8_t data[BLOCK_SIZE]; // 数据缓冲区，直接存储数据
} Block;
extern DISK disk;
#define R(r) ((volatile uint32_t *)(VIRTIO0 + (r)))
int alloc_desc(void);
void free_desc(int i);
void free_chain(int i);
int alloc3_desc(int *idx);
void virtio_disk_rw(Block *block, int write);
Block read_block(uint32_t block_id);
void write_block(Block block);
void virtio_disk_intr();
#endif