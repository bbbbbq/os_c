#include "fram_allocator.h"
#include "address.h"
#include "stdint.h"

StackFrameAllocator fram_allocator;

// 初始化栈式物理页帧分配器
// @param allocator 分配器的指针
// @param start 可用物理页帧的起始页号
// @param end 可用物理页帧的结束页号（不包括此页号）
extern uint8_t ekernel;
void frame_allocator_init() 
{
  PhysAddr start_addr;
  start_addr.addr = &ekernel; // Manually constructing PhysAddr
  PhysAddr end_addr;                 // Manually constructing PhysAddr
  end_addr.addr = (size_t)MEMORY_END;
  fram_allocator.current = phys_addr_to_page_num(start_addr,0).num;
  fram_allocator.end = phys_addr_to_page_num(end_addr,1).num;
  vector_init(&fram_allocator.recycled);
}

// 分配一个物理页帧
// @param allocator 分配器的指针
// @return 分配的物理页号，如果内存耗尽则返回特殊值(size_t)-1
PhysPageNum StackFrameAllocator_alloc(StackFrameAllocator* allocator) 
{
    if (vector_total(&allocator->recycled) > 0) {
        // 如果回收向量中有页号，优先从回收向量中分配
        size_t index = vector_total(&allocator->recycled) - 1; // 获取最后一个元素的索引
        void* item = vector_get(&allocator->recycled, index); // 获取并移除最后一个元素
        PhysPageNum ppn = { (size_t)item }; // 将void*转换回物理页号
        vector_delete(&allocator->recycled, index); // 从向量中删除该元素
        return ppn;
    } else if (allocator->current < allocator->end) {
        // 如果回收向量为空，且当前还有未分配的页，则从当前可用的页号中分配
        PhysPageNum ppn = { allocator->current++ }; // 分配当前页号，并将current指向下一个页号
        return ppn;
    } else {
        // 如果没有可分配的页号，则返回一个特殊值表示内存耗尽
        return (PhysPageNum){ 0x80000000 };
    }
}

// 回收一个物理页帧
// @param allocator 分配器的指针
// @param ppn 要回收的物理页号
void StackFrameAllocator_dealloc(StackFrameAllocator* allocator, PhysPageNum ppn) {
    // 将回收的物理页号添加到回收向量中，将物理页号转换为void*进行存储
    vector_add(&allocator->recycled, (void*)(uintptr_t)ppn.num);
}

// 释放栈式物理页帧分配器使用的资源
// @param allocator 分配器的指针
void StackFrameAllocator_free(StackFrameAllocator* allocator) {
    // 释放存储回收页号的向量占用的内存
    vector_free(&allocator->recycled);
}
