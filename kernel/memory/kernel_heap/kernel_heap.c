#include "kernel_heap.h"
#include "stdint.h"
#include "console.h"
#define HEAP_SIZE 8388608  // 8M大小的堆

typedef struct {
    uint64_t size;  // 内存块大小
    int free;     // 是否空闲
} BlockHeader;

static char heap[HEAP_SIZE];  // 堆空间

void init_heap() 
{
    BlockHeader* header = (BlockHeader*)heap;
    header->size = HEAP_SIZE - sizeof(BlockHeader);
    header->free = 1;
}

void* malloc(uint64_t size) {
    // 分配内存块
    BlockHeader* header = (BlockHeader*)heap;

    while (header->size < size || !header->free) {
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
        if ((char*)header >= (char*)heap + HEAP_SIZE) {
            // 没有足够的连续内存可分配
            return NULL;
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4) {
        // 如果该内存块过大，可以分割为两个内存块
        BlockHeader* new_header = (BlockHeader*)((char*)header + size + sizeof(BlockHeader));
        new_header->size = header->size - size - sizeof(BlockHeader);
        new_header->free = 1;
        header->size = size;
    }

    header->free = 0;
    return (void*)(header + 1);
}

void free(void* ptr) {
    // 释放内存块
    if (ptr == NULL) {
        return;
    }

    BlockHeader* header = (BlockHeader*)ptr - 1;
    header->free = 1;
}
void print_heap() {
    // 打印堆的状态
    BlockHeader* header = (BlockHeader*)heap;

    while ((char*)header < (char*)heap + HEAP_SIZE) {
        print_str("Block size: ");
        print_uint64(header->size);
        print_str(", Free: ");
        print_str(header->free ? "Yes" : "No");
        print_str("\n");

        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    }
}

void* realloc(void* ptr, uint64_t new_size) 
{
    if (new_size == 0) {
        // 新大小为0，释放原始内存块并返回NULL
        free(ptr);
        return NULL;
    }

    if (ptr == NULL) {
        // 原始指针为NULL，行为类似于malloc
        return malloc(new_size);
    }

    BlockHeader* header = (BlockHeader*)ptr - 1;
    if (header->size >= new_size) {
        // 如果新大小小于等于原始大小，可以选择在原地调整大小（为简化，这里直接返回原始指针）
        return ptr;
    } else {
        // 新大小大于原始大小，需要分配一个新的内存块并复制数据
        void* new_ptr = malloc(new_size);
        if (new_ptr == NULL) {
            return NULL; // 内存分配失败
        }

        // 复制原始数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
        for (uint64_t i = 0; i < copy_size; ++i) {
            *((char*)new_ptr + i) = *((char*)ptr + i);
        }

        free(ptr); // 释放原始内存块
        return new_ptr;
    }
}
