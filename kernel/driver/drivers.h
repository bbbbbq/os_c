#ifndef _DRIVERS_H_
#define _DRIVERS_H_
typedef struct BlockCache BlockCache;
#define BLOCK_SZ 512
#include "stdint.h"
typedef struct
{
    void (*read_block)(BlockCache *b);
    void (*write_block)(BlockCache *b);
} BlockDevice;

struct BlockCache
{
    uint8_t cache[BLOCK_SZ];
    uint64_t block_id;
    BlockDevice *block_device;
    bool disk; // does disk "own" BlockCache?
    bool modified;
    BlockCache *prev;
    BlockCache *next;
    uint64_t ref;
};

// virtio_disk.c
void virtio_disk_init();
void virtio_disk_rw(BlockCache *, int);
void virtio_disk_intr();

// virtio_blk.c
void virtio_read_block(BlockCache *);
void virtio_write_block(BlockCache *);
BlockDevice *virtio_block_device_init();

// plic.c
void plic_init();
int plic_claim();
void plic_complete(int);

#endif // _DRIVERS_H_
