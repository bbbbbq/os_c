#include "fs.h"
#include "debug.h"
BlockCache_Manager BLOCKCACHE_MANAGER;
extern BlockDevice fat_device;
void BlockCache_manager_init()
{
    vector_new(&BLOCKCACHE_MANAGER.blockcache_vector, sizeof(struct BlockCache));
}

void block_cache_sync_all()
{
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    uint64_t blockcache_num = blockcache_vector.size;
    for(int i=0;i<blockcache_num;i++)
    {
        struct BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        block_cache_sync(blockcache_ve);
    }
}

void block_cache_sync(struct BlockCache *block_cache)
{
    if (block_cache->modified)
    {
        block_cache->modified = false;
        write_block(&fat_device,block_cache->block_id,block_cache->cache);
    }
}

void block_cache_new(struct BlockCache *block_cache, uint64_t block_id, BlockDevice *block_device)
{
    memset(block_cache->cache, 0, BLOCK_SIZE);
    block_cache->block_id = block_id;
    block_cache->block_device = block_device;
    block_cache->modified = false;
    block_cache->ref = 0;
    read_block(&fat_device,block_cache->block_id,block_cache->cache);
}

struct BlockCache *BlockCache_find_block_by_index(BlockDevice *blockdevice, uint64_t index)
{
    ASSERT(blockdevice != NULL);
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    ASSERT(blockcache_vector.size >= index);
    uint64_t blockcache_num = blockcache_vector.size;
    for(int i=0;i<blockcache_num;i++)
    {
        struct BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if(blockcache_ve->block_device==blockdevice&&blockcache_ve->block_id==index)
        {
            return blockcache_ve;
        }
    }
    for (int i = 0; i < blockcache_num; i++)
    {
        struct BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if(blockcache_ve->ref==0)
        {
            block_cache_sync(blockcache_ve);
            block_cache_new(blockcache_ve, index,blockdevice);
            blockcache_ve->ref = 1;
            return blockcache_ve;
        }
    }
    ASSERT(0);
    return NULL;
}
void block_cache_release(struct BlockCache *b)
{
    if (b == NULL)
    {
        ASSERT(0);
        return;
    }

    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    uint64_t blockcache_num = blockcache_vector.size;
    bool found = false;
    for (int i = 0; i < blockcache_num; i++)
    {
        struct BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if (blockcache_ve == b)
        {
            vector_remove(&blockcache_vector, i);
            found = true;
        }
    }
    if (!found)
        ASSERT(0);
}