#include "fram_allocator.h"
#include "console.h"
#include "addr.h"
#include "stdint.h"
#include "debug.h"
extern uint64_t end;
FrameAllocator fram_allocator;
void frame_allocator_init()
{
    PhysAddr end_addr = {.addr = MEMORY_END};
    fram_allocator.current = phys_addr_to_page_num(end_addr, ADDR_CEIL);
    PhysAddr memory_end_addr = {.addr = MEMORY_END};
    fram_allocator.end = phys_addr_to_page_num(memory_end_addr, ADDR_FLOOR);
    Vector tmp;
    vector_resize(&tmp,10);
    fram_allocator.recycled = tmp;
}

PhysPageNum frame_allocator_alloc() 
{
    PhysPageNum ret;
    if(vector_total(&fram_allocator.recycled)==0)
    {
        ret.num = fram_allocator.current.num++;
    }else
    {
        ret.num = vector_pop(&fram_allocator.recycled);
    }
    return ret;
}

void frame_allocator_dealloc(PhysPageNum ppn) 
{
    if(ppn.num >= fram_allocator.current.num || vector_find_elem(&fram_allocator.recycled, (uint64_t)ppn.num) != vector_total(&fram_allocator.recycled))
    {
        ASSERT(0);
    }
    vector_add(&fram_allocator.recycled, (uint64_t)ppn.num);
}

