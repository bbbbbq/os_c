#ifndef MEMORY_H
#define MEMORY_H
#include "stdint.h"
#include "console.h"
#include "debug.h"
#define KERNEL_BEGIN_PADDR 0x80200000
#define KERNEL_BEGIN_VADDR 0x80200000
#define PHYSICAL_MEMORY_END 0x88000000
#define MAX_PHYSICAL_MEMORY 0x8000000
#define MAX_PHYSICAL_PAGES (MAX_PHYSICAL_MEMORY >> 12)

typedef struct 
{
    unsigned char a[MAX_PHYSICAL_PAGES << 1];
    unsigned int m, n, offset;
} SegmentTreeAllocator;

static SegmentTreeAllocator sta;
void init_memory(SegmentTreeAllocator* sta, uint32_t l, uint32_t r);
unsigned int alloc(SegmentTreeAllocator* sta);
void dealloc(SegmentTreeAllocator* sta, unsigned int n);

#endif