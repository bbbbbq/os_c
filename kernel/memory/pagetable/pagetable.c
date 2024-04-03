#include "pagetable.h"
#include "kernel_heap.h"
#include "pte.h"
#include "string.h"
#include "address.h"
#include "debug.h"
PageTable* PageTable_new(void) 
{
    PageTable *pt = (PageTable*)malloc(sizeof(PageTable));
    if (pt == NULL) 
    {
        return NULL;
    }
    PhysPageNum root_ppn = StackFrameAllocator_alloc(&fram_allocator);
    if (root_ppn.num == 0) 
    {
        free(pt);
        return NULL;
    }
    pt->root_ppn = root_ppn;
    vector_init(&pt->frames);
    vector_resize(&pt->frames,sizeof(PhysPageNum));
    return pt;
}

void PageTable_free(PageTable* pt) 
{
    vector_free(&pt->frames);
    free(pt);
}

// 获取当前级别的页表项地址
PageTableEntry* get_pte_address(PhysPageNum current_ppn, uint64_t index) 
{
    if (index >= ENTRIES_PER_PAGE)
    {
        return NULL;
    }
    PhysAddr base_address = phys_page_num_to_addr(current_ppn);
    return (PageTableEntry*)((uintptr_t)base_address.addr + index * sizeof(PageTableEntry));
}


PageTableEntry* navigate_to_pte(PageTable* pt, uint64_t* indexes) 
{
    PhysPageNum current_ppn = pt->root_ppn;
    PhysAddr current_pa;
    PageTableEntry* pte = NULL;

    for (int i = 0; i < 3; ++i) 
    {
        current_pa = phys_page_num_to_addr(current_ppn); // Convert current PPN to physical address
        pte = (PageTableEntry*)(current_pa.addr + (indexes[i] * sizeof(PageTableEntry))); // Calculate address of the PTE

        // Check if the PTE is valid
        if (!pte_is_valid(*pte)) {
            if (i < 2) { // For levels other than the last, allocate a new page and update the PTE
                PhysPageNum new_ppn = StackFrameAllocator_alloc(&fram_allocator); // Allocate a new page
                memset((void*)phys_page_num_to_addr(new_ppn).addr, 0, PAGE_SIZE); // Clear the new page

                // Set the current PTE to point to the new page
                set_pte(pte, new_ppn.num, PTE_V); // Assuming PTE_V is the flag for a valid entry
            } else {
                // For the last level, you might want to handle differently or just ensure the PTE is set up correctly.
                // Depending on the use case, you might not need to allocate a new page, but instead set flags or return NULL.
            }
        }
        // For the first two levels, update current_ppn to the next level's PPN
        if (i < 2) {
            current_ppn.num = pte_ppn(*pte); // Update the current PPN for the next iteration
        }
    }
    return pte; // Return the address of the final level PTE
}


void PageTable_map_ppn_2_vpn(PageTable* pt, VirtPageNum vpn, PhysPageNum ppn, PTEFlags flags) 
{
    uint64_t* indexs = decompose_vpn(vpn.num);
    PageTableEntry* entry = navigate_to_pte(pt,indexs);
    if(entry)
    {
        *entry = pte_new(ppn.num,flags);
    }else 
    {
        ASSERT(0);
    }
}

void PageTable_unmap_ppn_2_vpn(PageTable* pt, VirtPageNum vpn) 
{
    uint64_t* indexs = decompose_vpn(vpn.num);
    PageTableEntry* entry = navigate_to_pte(pt,indexs);
    if(entry)
    {
        *entry = pte_new(0, 0); // 拆除映射
    }
}

PhysPageNum pte_get_ppn(PageTableEntry pte)
{
    PhysPageNum tmp;
    tmp.num = pte.bits >> 10;
    return tmp;
}
