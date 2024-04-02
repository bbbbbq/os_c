#ifndef ADDR_H
#define ADDR_H
#include "stdint.h"

#define PAGE_SIZE_BITS 12

typedef struct 
{
    uintptr_t addr;
} PhysAddr;

typedef struct 
{
    uintptr_t addr;
} VirtAddr;

typedef struct 
{
    uintptr_t num;
} PhysPageNum;

typedef struct
{
    uintptr_t num;
} VirtPageNum;


PhysPageNum phys_addr_to_page_num(PhysAddr addr, bool roundUp);
PhysAddr phys_page_num_to_addr(PhysPageNum ppn);
VirtPageNum virt_addr_to_page_num(VirtAddr addr, bool roundUp);
VirtAddr virt_page_num_to_addr(VirtPageNum vpn);

#endif