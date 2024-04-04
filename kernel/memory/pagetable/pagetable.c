#include "pagetable.h"
#include "kernel_heap.h"
#include "pte.h"
#include "string.h"
#include "address.h"
#include "debug.h"

// 创建新的页表结构体并初始化
PageTable* PageTable_new(void) 
{
    // 申请PageTable结构体的内存空间
    PageTable *pt = (PageTable*)malloc(sizeof(PageTable));
    // 检查内存是否申请成功
    if (pt == NULL) 
    {
        return NULL;
    }
    // 为页表分配一个物理页作为根页表
    PhysPageNum root_ppn = StackFrameAllocator_alloc(&fram_allocator);
    // 检查物理页是否分配成功
    if (root_ppn.num == 0) 
    {
        // 分配失败，释放PageTable结构体内存并返回NULL
        free(pt);
        return NULL;
    }
    // 设置根页表的物理页号
    pt->root_ppn = root_ppn;
    // 初始化页表项向量
    vector_init(&pt->frames);
    vector_resize(&pt->frames, sizeof(PhysPageNum));
    return pt;
}

// 释放页表结构体及其资源
void PageTable_free(PageTable* pt) 
{
    // 释放页表项向量占用的内存
    vector_free(&pt->frames);
    // 释放页表结构体占用的内存
    free(pt);
}

// 根据物理页号和索引获取页表项地址
PageTableEntry* get_pte_address(PhysPageNum current_ppn, uint64_t index) 
{
    // 检查索引是否超出每页的页表项上限
    if (index >= ENTRIES_PER_PAGE)
    {
        return NULL;
    }
    // 获取当前物理页的基地址
    PhysAddr base_address = phys_page_num_to_addr(current_ppn);
    // 返回页表项地址
    return (PageTableEntry*)((uintptr_t)base_address.addr + index * sizeof(PageTableEntry));
}

// 在页表中映射物理页号到虚拟页号
void PageTable_map_ppn_2_vpn(PageTable* pt, VirtPageNum vpn, PhysPageNum ppn, PTEFlags flags) 
{
    PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    if (pte_is_valid(*pte)) 
    {
        ASSERT(0);
        //panic("VPN 0x%llx is mapped before mapping.\n", vpn);
    }
    *pte = pte_new(ppn.num, flags | PTE_V);
}

// 在页表中取消物理页号到虚拟页号的映射
void PageTable_unmap_ppn_2_vpn(PageTable* pt, VirtPageNum vpn) 
{
    PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
  if (!pte_is_valid(*pte)) {
    ASSERT(0);
    //panic("VPN 0x%llx is invalid before unmapping.\n", vpn);
  }
  *pte = pte_empty();
}

// 从页表项中获取物理页号
PhysPageNum pte_get_ppn(PageTableEntry pte)
{
    PhysPageNum tmp;
    tmp.num = pte.bits >> 10; // 页表项中物理页号的位置
    return tmp;
}

// 获取页表的SATP值
uint64_t page_table_token(PageTable *pt) 
{ 
    // 根据RISC-V的页表格式设置SATP寄存器的值
    return ((8L << 60) | pt->root_ppn.num); 
}

// 查找页表中给定虚拟页号对应的页表项，如果不存在则返回NULL
PageTableEntry* page_table_find_pte(PageTable *pt, VirtPageNum vpn) 
{
    // 解析虚拟页号获取三级页表的索引数组
    uint64_t* indexes = decompose_vpn(vpn.num);
    // 从根页表开始
    PhysPageNum current_ppn = pt->root_ppn;
    PageTableEntry* current_pte;
    // 遍历三级页表
    for (int level = 0; level < 3; level++) 
    {
        // 获取当前级别的页表项地址
        current_pte = get_pte_address(current_ppn, indexes[level]);
        // 检查页表项是否有效
        if (!pte_is_valid(*current_pte)) 
        {
            // 无效则返回NULL
            return NULL;
        }
        // 若不是最后一级，更新当前物理页号为下一级的物理页号
        if (level < 2) 
        {
            current_ppn = pte_get_ppn(*current_pte);
        }
    }
    // 返回找到的页表项
    return current_pte;
}

// 查找或创建页表中给定虚拟页号对应的页表项
PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn) 
{
  // 解析虚拟页号获取三级索引
  uint64_t* idxs;
  vpn_indexes(vpn,idxs);
  // 从根页表的物理页号开始
  PhysPageNum ppn = pt->root_ppn;
  PageTableEntry *result = NULL;
  for (unsigned i = 0; i < 3; i++) 
  {
    // 根据当前物理页号和索引获取页表项地址
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    // 如果是最后一级页表项，则直接返回该页表项
    if (i == 2) 
    {
      result = pte;
      break;
    }

    printk("pte: addr : %d \n",pte);
    if (!pte_is_valid(*pte)) 
    {
      // 分配新的物理页
      PhysPageNum frame = StackFrameAllocator_alloc(&fram_allocator);
      //trace("frame alloc 0x%llx\n", frame);
      // 检查物理页分配是否成功 
      if (frame.num == 0x80000000 ) 
      {
        return NULL;
      }
      // 将新分配的物理页设置为当前页表项指向的物理页，并标记为有效
      *pte = pte_new(frame.num, PTE_V);
      // 将新分配的物理页加入到页表项向量中
      vector_add(&pt->frames, &frame);
    }
    // 更新当前物理页号为当前页表项指向的下一级物理页号，以便继续遍历
        ppn.num = pte_ppn(*pte);
  }
  // 返回找到或创建的页表项
  return result;
}

void vpn_indexes(VirtPageNum vpn, uint64_t *idx) 
{
  for (int i = 2; i >= 0; i--) 
  {
    idx[i] = vpn.num & 0x1ff;
    vpn.num >>= 9;
  }
}