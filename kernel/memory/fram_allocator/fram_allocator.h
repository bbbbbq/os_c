#ifndef FRAM_ALLOCATOR_H
#define FRAM_ALLOCATOR_H
#include "addr.h"
#include "vector.h"
#define ADDR_FLOOR  0  // 向下取整
#define ADDR_CEIL   1  // 向上取整
#define MEMORY_END  ((uint64_t)0x80000000 + (uint64_t)(1024 * 1024))

typedef struct 
{
    PhysPageNum current; // 未分配物理页帧起始页号
    PhysPageNum end; // 未分配物理页帧结束页号
    Vector recycled; // 回收的已使用的物理页
}FrameAllocator;

void frame_allocator_init( void );
#endif