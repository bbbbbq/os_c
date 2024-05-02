#ifndef BLOCK_CACHE_H
#define BLOCK_CACHE_H

#define BLOCK_SZ 512
#include "stdint.h"
#include "list.h"
#include "vector.h"
#include "debug.h"
#define BLOCKCACHE_NUMBER 40

typedef struct
{
  struct vector blockcache_vector;
} BlockCache_Manager;

typedef struct BlockCache BlockCache;

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
  bool disk;
  bool modified;
  uint64_t ref; // 引用计数
};

// void virtio_read_block(BlockCache *b) { virtio_disk_rw(b, 0); }

// void virtio_write_block(BlockCache *b) { virtio_disk_rw(b, 1); }

static BlockDevice BLOCK_DEVICE;
void BlockCache_manager_init();
BlockCache *BlockCache_find_block_by_index(BlockDevice *blockdevice, uint64_t index);
void block_cache_release(BlockCache *b);
void block_cache_sync_all();
void block_cache_new(BlockCache *block_cache, uint64_t block_id, BlockDevice *block_device);
void block_cache_sync(BlockCache *block_cache);
#endif