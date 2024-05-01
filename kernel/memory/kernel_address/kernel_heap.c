#include "kernel_heap.h"
#include "stdint.h"
#include "console.h"
#define HEAP_SIZE 8388608 // 定义堆大小为8M

// 堆块头部结构
typedef struct
{
    uint64_t size; // 堆块大小
    int free;      // 堆块是否空闲
} BlockHeader;

static char heap[HEAP_SIZE]; // 堆空间

// 初始化堆
void init_heap()
{
    // 初始化堆的第一个块
    BlockHeader *header = (BlockHeader *)heap;
    header->size = HEAP_SIZE - sizeof(BlockHeader); // 设置第一个块的大小
    header->free = 1;                               // 设置第一个块为空闲
}

// 分配内存
void *malloc(uint64_t size)
{
    // 从堆的开始处搜索合适的内存块
    BlockHeader *header = (BlockHeader *)heap;

    // 搜索未分配且大小合适的内存块
    while (header->size < size || !header->free)
    {
        header = (BlockHeader *)((char *)header + header->size + sizeof(BlockHeader));
        if ((char *)header >= (char *)heap + HEAP_SIZE)
        {
            // 搜索到堆的末尾还未找到合适的内存块
            return NULL;
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4)
    {
        // 分割内存块以减少浪费
        BlockHeader *new_header = (BlockHeader *)((char *)header + size + sizeof(BlockHeader));
        new_header->size = header->size - size - sizeof(BlockHeader); // 计算新内存块的大小
        new_header->free = 1;                                         // 设置新内存块为空闲
        header->size = size;                                          // 更新当前内存块的大小
    }

    header->free = 0;            // 标记当前内存块为已分配
    return (void *)(header + 1); // 返回内存块数据区的地址
}

// 释放内存
void free(void *ptr)
{
    // 如果指针为空，则不进行操作
    if (ptr == NULL)
    {
        return;
    }

    // 获取内存块头部
    BlockHeader *header = (BlockHeader *)ptr - 1;
    header->free = 1; // 标记内存块为空闲
}

// 打印堆的状态
void print_heap()
{
    BlockHeader *header = (BlockHeader *)heap;

    // 遍历堆中的所有内存块
    while ((char *)header < (char *)heap + HEAP_SIZE)
    {
        print_str("Block size: ");
        print_uint64(header->size); // 打印内存块大小
        print_str(", Free: ");
        print_str(header->free ? "Yes" : "No"); // 打印内存块是否空闲
        print_str("\n");

        // 移动到下一个内存块
        header = (BlockHeader *)((char *)header + header->size + sizeof(BlockHeader));
    }
}

// 重新分配内存
void *realloc(void *ptr, uint64_t new_size)
{
    if (new_size == 0)
    {
        // 如果新大小为0，则释放原有内存并返回NULL
        free(ptr);
        return NULL;
    }

    if (ptr == NULL)
    {
        // 如果原始指针为NULL，则行为等同于malloc
        return malloc(new_size);
    }

    BlockHeader *header = (BlockHeader *)ptr - 1;
    if (header->size >= new_size)
    {
        // 如果原始内存块大小已满足需求，则直接返回原始指针
        return ptr;
    }
    else
    {
        // 如果新大小超出原始大小，则分配一个新的内存块并复制原始数据
        void *new_ptr = malloc(new_size);
        if (new_ptr == NULL)
        {
            // 分配失败
            return NULL;
        }

        // 复制原始内存数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
        for (uint64_t i = 0; i < copy_size; ++i)
        {
            *((char *)new_ptr + i) = *((char *)ptr + i);
        }

        // 释放原始内存块
        free(ptr);
        return new_ptr;
    }
}
