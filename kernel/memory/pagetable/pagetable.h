#ifndef PAGE_TABLE_H
#define PAGE_TABLE_H

#include "vector.h" // 确保已经定义了Vector结构和相关操作
#include "fram_allocator.h" // 提供frame_alloc函数
#include "address.h" // 提供PhysPageNum和VirtPageNum的定义
#include "pte.h"

typedef struct 
{
    PhysPageNum root_ppn; // 根节点的物理页号
    Vector frames; // 保存页表所有节点的FrameTracker
} PageTable;

// 页表的构造和析构函数
PageTable* PageTable_new(void);
void PageTable_free(PageTable* pt);

// 页表操作函数
void PageTable_map_ppn_2_vpn(PageTable* pt, VirtPageNum vpn, PhysPageNum ppn, PTEFlags flags);
void PageTable_unmap_ppn_2_vpn(PageTable* pt, VirtPageNum vpn);
PageTableEntry* get_pte_address(PhysPageNum current_ppn, uint64_t index);
PhysPageNum pte_get_ppn(PageTableEntry pte);
uint64_t page_table_token(PageTable *pt);
PageTableEntry* page_table_find_pte(PageTable *pt, VirtPageNum vpn);
PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn);
void vpn_indexes(VirtPageNum vpn, uint64_t *idx);
#endif // PAGE_TABLE_H
