#ifndef FRAME_ALLOCATOR_H
#define FRAME_ALLOCATOR_H

#include "vector.h" // 引入 Vector 的定义
#include "stdint.h"
#include "address.h"
// 物理页号类型
// typedef size_t PhysPageNum;

// 栈式物理页帧管理器结构
typedef struct {
    size_t current;  // 空闲内存的起始物理页号
    size_t end;      // 空闲内存的结束物理页号
    Vector recycled; // 被回收的物理页号栈
} StackFrameAllocator;

extern StackFrameAllocator fram_allocator;
void StackFrameAllocator_init(StackFrameAllocator* allocator, size_t start, size_t end);
PhysPageNum StackFrameAllocator_alloc(StackFrameAllocator* allocator);
void StackFrameAllocator_dealloc(StackFrameAllocator* allocator, PhysPageNum ppn);
void StackFrameAllocator_free(StackFrameAllocator* allocator);

#endif
