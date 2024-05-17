#ifndef BLOCK_CACHE_H
#define BLOCK_CACHE_H
#define BLOCK_SZ 512
#include "driver.h"
#include "stdint.h"
#include "list.h"
#include "vector.h"
#include <assert.h>
#include <stdbool.h>
#define BLOCKCACHE_NUMBER 40
typedef struct
{
    struct vector blockcache_vector;
}BlockCache_Manager;

typedef struct
{
  uint8_t cache[BLOCK_SZ];
  uint64_t block_id;
  Device *block_device;
  bool disk;
  bool modified;
  uint64_t ref;
}BlockCache ;

void BlockCache_manager_init();
BlockCache *BlockCache_find_block_by_index(Device *blockdevice, uint64_t index);
void block_cache_release(BlockCache *b);
void block_cache_sync_all();
void block_cache_new(BlockCache *block_cache, uint64_t block_id, Device *block_device);
void block_cache_sync(BlockCache *block_cache);
#endif