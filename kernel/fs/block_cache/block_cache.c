#include "block_cache.h"
#include "debug.h"
BlockCache_Manager BLOCKCACHE_MANAGER;

void BlockCache_manager_init()
{
    vector_new(&BLOCKCACHE_MANAGER.blockcache_vector, sizeof(BlockCache));
}

void block_cache_sync_all()
{
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    uint64_t blockcache_num = blockcache_vector.size;
    for (int i = 0; i < blockcache_num; i++)
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        block_cache_sync(blockcache_ve);
    }
}

void block_cache_sync(BlockCache *block_cache)
{
    if (block_cache->modified)
    {
        block_cache->modified = false;
        block_cache->block_device->write_block(block_cache);
    }
}

void block_cache_new(BlockCache *block_cache, uint64_t block_id, BlockDevice *block_device)
{
    memset(block_cache->cache, 0, BLOCK_SZ);
    block_cache->block_id = block_id;
    block_cache->block_device = block_device;
    block_cache->modified = false;
    block_cache->ref = 0;
    block_cache->block_device->read_block(block_cache);
}

BlockCache *BlockCache_find_block_by_index(BlockDevice *blockdevice, uint64_t index)
{
    ASSERT(blockdevice != NULL);
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    ASSERT(blockcache_vector.size >= index);
    uint64_t blockcache_num = blockcache_vector.size;
    for (int i = 0; i < blockcache_num; i++)
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if (blockcache_ve->block_device == blockdevice && blockcache_ve->block_id == index)
        {
            return blockcache_ve;
        }
    }
    for (int i = 0; i < blockcache_num; i++)
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if (blockcache_ve->ref == 0)
        {
            block_cache_sync(blockcache_ve);
            block_cache_new(blockcache_ve, index, blockdevice);
            blockcache_ve->ref = 1;
            return blockcache_ve;
        }
    }
    ASSERT(0);
    return NULL;
}
void block_cache_release(BlockCache *b)
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
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
        if (blockcache_ve == b)
        {
            vector_remove(&blockcache_vector, i);
            found = true;
        }
    }
    if (!found)
        ASSERT(0);
}

int alloc3_desc(int *idx)
{
    for (int i = 0; i < 3; i++)
    {
        idx[i] = alloc_desc();
        if (idx[i] < 0)
        {
            for (int j = 0; j < i; j++)
                free_desc(idx[j]);
            return -1;
        }
    }
    return 0;
}

void free_chain(int i)
{
    while (1)
    {
        int flag = disk.desc[i].flags;
        int nxt = disk.desc[i].next;
        free_desc(i);
        if (flag & VRING_DESC_F_NEXT)
            i = nxt;
        else
            break;
    }
}

void free_desc(int i)
{
    if (i >= NUM)
        panic("free_desc 1\n");
    if (disk.free[i])
        panic("free_desc 2\n");
    disk.desc[i].addr = 0;
    disk.desc[i].len = 0;
    disk.desc[i].flags = 0;
    disk.desc[i].next = 0;
    disk.free[i] = 1;
}

int alloc_desc()
{
    for (int i = 0; i < NUM; i++)
    {
        if (disk.free[i])
        {
            disk.free[i] = 0;
            return i;
        }
    }
    return -1;
}

void virtio_disk_rw(BlockCache *b, int write)
{
    uint64_t sector = b->block_id * (BLOCK_SZ / 512);
    // the spec's Section 5.2 says that legacy block operations use
    // three descriptors: one for type/reserved/sector, one for the
    // data, one for a 1-byte status result.
    // allocate the three descriptors.
    int idx[3];
    while (1)
    {
        if (alloc3_desc(idx) == 0)
        {
            break;
        }
        // yield();
    }
    // format the three descriptors.
    // qemu's virtio-blk.c reads them.
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

    if (write)
        buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    else
        buf0->type = VIRTIO_BLK_T_IN; // read the disk
    buf0->reserved = 0;
    buf0->sector = sector;

    disk.desc[idx[0]].addr = (uint64_t)buf0;
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint64_t)b->cache;
    disk.desc[idx[1]].len = BLOCK_SZ;
    if (write)
        disk.desc[idx[1]].flags = 0; // device reads b->cache
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->cache
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    disk.desc[idx[1]].next = idx[2];

    disk.info[idx[0]].status = 0xfb; // device writes 0 on success
    disk.desc[idx[2]].addr = (uint64_t)&disk.info[idx[0]].status;
    disk.desc[idx[2]].len = 1;
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    disk.desc[idx[2]].next = 0;

    // record BlockCache for virtio_disk_intr().
    b->disk = true;
    disk.info[idx[0]].b = b;

    // tell the device the first index in our chain of descriptors.
    disk.avail->ring[disk.avail->idx % NUM] = idx[0];

    __sync_synchronize();

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM ...

    __sync_synchronize();

    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number

    // Wait for virtio_disk_intr() to say request has finished.
    BlockCache volatile *_b = b; // Make sure complier will load 'b' form memory
    intr_on();
    while (_b->disk)
    {
        // WARN: No kernel concurrent support, DO NOT allow kernel yield
        // yield();
    }
    intr_off();
    disk.info[idx[0]].b = 0;
    free_chain(idx[0]);
}