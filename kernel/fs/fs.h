#ifndef FS_H
#define FS_H
#include "config.h"
#include "stdint.h"
#include "list.h"
#include "vector.h"
#include "debug.h"
#include "driver.h"
#define BLOCK_SIZE 512
struct BlockCache;
typedef struct
{
    void (*read_block)(struct BlockCache *b);
    void (*write_block)(struct BlockCache *b);
} BlockDevice;

struct BlockCache
{
    uint8_t cache[BLOCK_SIZE];
    uint64_t block_id;
    BlockDevice *block_device;
    bool disk;
    bool modified;
    uint64_t ref;
};

// Constants for read and write operations
extern const int R;
extern const int W;

// Function declarations
void virtio_disk_init();
void virtio_disk_rw(struct BlockCache *b, int write);
void virtio_disk_intr();

#define BLOCKCACHE_NUMBER 40
typedef struct
{
    struct vector blockcache_vector;
} BlockCache_Manager;

void BlockCache_manager_init();
struct BlockCache *BlockCache_find_block_by_index(BlockDevice *blockdevice, uint64_t index);
void block_cache_release(struct BlockCache *b);
void block_cache_sync_all();
void block_cache_new(struct BlockCache *block_cache, uint64_t block_id, BlockDevice *block_device);
void block_cache_sync(struct BlockCache *block_cache);

#endif