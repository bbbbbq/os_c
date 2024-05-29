#ifndef BLOCK_CACHE_H
#define BLOCK_CACHE_H
#include "drivers.h"

void block_cache_manager_init();
BlockCache *block_cache_get(uint64_t block_id, BlockDevice *block_device);
void block_cache_release(BlockCache *b);
void block_cache_sync_all();

#endif