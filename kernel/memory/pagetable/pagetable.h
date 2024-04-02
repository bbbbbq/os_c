#ifndef PAGETABLE_H
#define PAGETABLE_H
#include "vector.h"
#include "addr.h"
typedef struct PageTable
{
    PhysPageNum root_ppn; // 根页表位置
    Vector ppns; // 保存使用的页表，便于清理
}PageTable;

typedef struct MemorySet
{
    PageTable page_table;
    Vector areas;  // 一个task的各个逻辑段
}MemorySet;

// 逻辑段类型 
typedef uint32_t MapType;
// 逻辑段的权限 
typedef uint32_t MapPermission;
// 连续虚拟地址的范围 
typedef struct VpnRange
{
    VirtPageNum start_vpn;
    uint64_t size;
}VpnRange;
// 逻辑段（具有相同权限的段，虚拟地址连续） 
typedef struct MapArea
{
    VpnRange vpn_range;
    MapType map_type;
    MapPermission map_premission;
}MapArea;

#endif