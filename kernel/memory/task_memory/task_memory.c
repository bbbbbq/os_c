#include "task_memory.h"
#include "stdint.h"
#include "address.h"
#include "fram_allocator.h"
#include "pagetable.h"
extern void text_start();
extern void text_end();
extern void rodata_start();
extern void rodata_end();
extern void data_start();
extern void data_end();
extern void bss_start();
extern void bss_end();
extern void ekernel();
extern void strampoline(); // trap跳板位置
void map_area_init(MapArea* ma, VirtAddr start_va, VirtAddr end_va, enum MapType mt, MapPermission mp)
{
    ma->vpn_range.start_vpn = virt_addr_to_page_num(start_va, 0);
    ma->vpn_range.size = virt_addr_to_page_num(end_va, 1).num - ma->vpn_range.start_vpn.num;
    ma->map_type = mt;
    ma->map_premission = mp;
}

void map_area_map(MapArea* ma, PageTable* pt)
{
    PhysPageNum target;
    for(int64_t i = 0; i < ma->vpn_range.size; i ++)
    {
        if (ma->map_type == Identical)
        {
            target.num = ma->vpn_range.start_vpn.num + i;
        } else 
        {
            target = StackFrameAllocator_alloc(&fram_allocator);
        }
        VirtPageNum vpn;
        vpn.num = ma->vpn_range.start_vpn.num+i;
        PageTable_map_ppn_2_vpn(pt, vpn, target, ma->map_premission);
    }
}

void memory_set_init(MemorySet* ms)
{
    ms->page_table = *PageTable_new();
    vector_init(&ms->areas);
    vector_resize(&ms->areas,sizeof(MapArea));
}

void memory_set_push(MemorySet* ms, MapArea* ma)
{
    vector_add(&ms->areas, ma);
    map_area_map(ma, &ms->page_table);
}

void memory_set_map_user_stack(MemorySet *ms, VirtAddr user_stack_low_va)
{
    PhysPageNum user_stack_ppn = StackFrameAllocator_alloc(&fram_allocator);
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(user_stack_low_va,1),user_stack_ppn,PTE_R|PTE_W|PTE_U);
}

void memory_set_map_kernel_stack_kernel(MemorySet *ms)
{
    PhysPageNum kernel_stack = StackFrameAllocator_alloc(&fram_allocator);
    VirtAddr va;
    va.addr = TRAP_CONTEXT_FULL;
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,1),kernel_stack,(PTE_R|PTE_W));
}

void memory_set_map_trampoline(MemorySet *ms)
{
    VirtAddr va;
    va.addr = TRAMPOLINE_FULL;
    PhysAddr pha;
    pha.addr = (size_t)&strampoline;
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,0),phys_addr_to_page_num(pha,1),PTE_R|PTE_X);
}


void memory_set_kernel_new(MemorySet* ms)
{
    MapArea ma_tmp;
    printk("[mm/memory_set.c] text: 0x%x - 0x%x\n", (uint64_t)text_start, (uint64_t)text_end);
    printk("[mm/memory_set.c] rodata: 0x%x - 0x%x\n", (uint64_t)rodata_start, (uint64_t)rodata_end);
    printk("[mm/memory_set.c] data: 0x%x - 0x%x\n", (uint64_t)data_start, (uint64_t)data_end);
    printk("[mm/memory_set.c] bss: 0x%x - 0x%x\n", (uint64_t)bss_start, (uint64_t)bss_end);
    memory_set_map_trampoline(ms);
    memory_set_map_kernel_stack_kernel(ms);

    VirtAddr vad1,vad2;
    vad1.addr = (uint64_t)&text_start;
    vad2.addr = (uint64_t)&text_end;
    map_area_init(&ma_tmp, vad1,  vad2,   Identical, MAP_PREMISSION_R | MAP_PREMISSION_X);
    memory_set_push(ms, &ma_tmp);

    vad1.addr = (uint64_t)&rodata_start;
    vad2.addr = (uint64_t)&rodata_end;
    map_area_init(&ma_tmp, vad1, vad2, Identical, MAP_PREMISSION_R                   );
    memory_set_push(ms, &ma_tmp);

    vad1.addr = (uint64_t)&data_start;
    vad2.addr = (uint64_t)&data_end;
    map_area_init(&ma_tmp, vad1,  vad2,   Identical, MAP_PREMISSION_R | MAP_PREMISSION_W);
    memory_set_push(ms, &ma_tmp);

    vad1.addr = (uint64_t)&bss_start;
    vad2.addr = (uint64_t)&bss_end;
    map_area_init(&ma_tmp, vad1,   vad2,    Identical, MAP_PREMISSION_R | MAP_PREMISSION_W);
    memory_set_push(ms, &ma_tmp);

    vad1.addr = (uint64_t)&ekernel;
    vad2.addr = MEMORY_END;
    map_area_init(&ma_tmp, vad1, vad2, Identical, MAP_PREMISSION_R | MAP_PREMISSION_W);
    memory_set_push(ms, &ma_tmp);
}

void memory_init()
{
    memory_set_kernel_new
}