#ifndef ADDRESS_H
#define ADDRESS_H
#include "stdint.h"

#define PAGE_SIZE 4096 // 假设页大小为4096字节
#define PAGE_SIZE_BITS 12 // 对应于4096字节页大小的位数
#define MEMORY_END 0x80800000
#define INDEX_BITS 9
#define INDEX_MASK ((1ULL << INDEX_BITS) - 1)
#define OFFSET_MASK ((1ULL << PAGE_SIZE_BITS) - 1)
typedef enum {
    ALIGN_DOWN,
    ALIGN_UP
} AlignDirection;

// 表示物理地址
typedef struct {
    size_t addr;
} PhysAddr;

// 表示虚拟地址
typedef struct {
    size_t addr;
} VirtAddr;

// 表示物理页号
typedef struct {
    size_t num;
} PhysPageNum;

// 表示虚拟页号
typedef struct {
    size_t num;
} VirtPageNum;

#define PhysAddr(val) ((PhysAddr){.addr = (val)})
#define VirtAddr(val) ((VirtAddr){.addr = (val)})
#define PhysPageNum(val) ((PhysPageNum){.num = (val)})
#define VirtPageNum(val) ((VirtPageNum){.num = (val)})


PhysPageNum phys_addr_to_page_num(PhysAddr addr, AlignDirection direction);
VirtPageNum virt_addr_to_page_num(VirtAddr addr, AlignDirection direction);
VirtAddr virt_page_num_to_addr(VirtPageNum vpn);
PhysAddr phys_page_num_to_addr(PhysPageNum ppn);
uint64_t* decompose_vpn(uint64_t vpn);
#endif