#include "pte.h"
#include "stdint.h"
#include "address.h"
// 创建一个新的 PageTableEntry 实例
// @param ppn 物理页号
// @param flags 页表项的标志位
// @return 初始化的 PageTableEntry 结构体实例
PageTableEntry pte_new(uint64_t ppn, PTEFlags flags) 
{
    PageTableEntry pte;
    pte.bits = (ppn << 10) | flags; // 将物理页号左移10位并与标志位进行按位或操作
    return pte;
}

// 创建一个表示空页表项的 PageTableEntry 实例
// @return 全零的 PageTableEntry 结构体实例，表示无效的页表项
PageTableEntry pte_empty(void) 
{
    PageTableEntry pte;
    pte.bits = 0; // 全零表示无效的页表项
    return pte;
}

// 获取页表项中的物理页号
// @param pte 页表项
// @return 页表项中的物理页号
uint64_t pte_ppn(PageTableEntry pte) 
{
    return (((pte.bits) >> 10) & ((1L << 44) - 1)); // 从位域中提取物理页号
}

// 获取页表项中的标志位
// @param pte 页表项
// @return 页表项中的标志位
PTEFlags pte_flags(PageTableEntry pte) 
{
    return pte.bits & 0x3FF; // 提取页表项的最低10位作为标志位
}

// 检查页表项是否有效
// @param pte 页表项
// @return 如果页表项有效返回非零值，否则返回0
int pte_is_valid(PageTableEntry pte) 
{
    return (pte_flags(pte) & PTE_V) != 0; // 检查V标志位是否为1
}

int pte_is_readable(PageTableEntry pte) 
{
    return (pte_flags(pte) & PTE_R) != 0;
}

int pte_is_writable(PageTableEntry pte) 
{
    return (pte_flags(pte) & PTE_W) != 0;
}

int pte_is_executable(PageTableEntry pte) 
{
    return (pte_flags(pte) & PTE_X) != 0;
}


void set_pte(PageTableEntry* entry, uint64_t ppn, uint64_t flags)
{
    uint64_t ppn_part = ppn << PTE_PPN_SHIFT;
    entry->bits = ppn_part | (flags & ((1ULL << PTE_PPN_SHIFT) - 1));
}


PageTableEntry *ppn_get_pte_array(PhysPageNum ppn) 
{
  PhysAddr pa;
  pa.addr = ((ppn.num) << PAGE_SIZE_BITS);
  return (PageTableEntry*)pa.addr; // len = 512 * 8
}
