#include "task_memory.h"
#include "stdint.h"
#include "address.h"
#include "fram_allocator.h"
#include "pagetable.h"
#include "debug.h"
#include "elfparse.h"
#include "string.h"
#include "stack.h"
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
MemorySet KERNEL_SPACE;
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
    va.addr = TRAMPOLINE;
    PhysAddr pha;
    pha.addr = (size_t)&strampoline;
    VirtPageNum tmp = virt_addr_to_page_num(va,1);
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,0),phys_addr_to_page_num(pha,1),PTE_R|PTE_X);
}

void memory_set_kernel_new(MemorySet* ms) 
{
    MapArea ma_tmp;
    printk("[mm/memory_set.c] text: 0x%x - 0x%x\n", (uint64_t)text_start, (uint64_t)text_end);
    printk("[mm/memory_set.c] rodata: 0x%x - 0x%x\n", (uint64_t)rodata_start, (uint64_t)rodata_end);
    printk("[mm/memory_set.c] data: 0x%x - 0x%x\n", (uint64_t)data_start, (uint64_t)data_end);
    printk("[mm/memory_set.c] bss: 0x%x - 0x%x\n", (uint64_t)bss_start, (uint64_t)bss_end);
    memory_set_new_bare(ms);
    memory_set_map_trampoline(ms);
    memory_set_map_kernel_stack_kernel(ms);
    VirtAddr vads, vade;
    vads.addr = (uint64_t)text_start;
    vade.addr = (uint64_t)text_end;
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_X);
    memory_set_push(ms, &ma_tmp);

    // .rodata segment
    vads.addr = (uint64_t)rodata_start;
    vade.addr = (uint64_t)rodata_end;
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R);
    memory_set_push(ms, &ma_tmp);

    // .data segment
    vads.addr = (uint64_t)data_start;
    vade.addr = (uint64_t)data_end;
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    memory_set_push(ms, &ma_tmp);

    // .bss segment
    vads.addr = (uint64_t)bss_start;
    vade.addr = (uint64_t)bss_end;
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    memory_set_push(ms, &ma_tmp);
}

void memory_set_activate(MemorySet *memory_set)
{
    uint64_t satp = page_table_token(&memory_set->page_table);
    WRITE_CSR(satp,satp);
    asm volatile("sfence.vma zero, zero");
}

void memory_set_remap_test()
{
    VirtAddr mid_text;
    mid_text.addr = (((uint64_t)&text_start + (uint64_t)&text_end) / 2);
    VirtAddr mid_rodata;
    mid_rodata.addr = (((uint64_t)&rodata_start + (uint64_t)&rodata_end) / 2);
    VirtAddr mid_data;
    mid_data.addr = (((uint64_t)&data_start + (uint64_t)&data_end) / 2);

    VirtPageNum text = virt_addr_to_page_num(mid_text,1);
    VirtPageNum rodata = virt_addr_to_page_num(mid_rodata,1);
    VirtPageNum data = virt_addr_to_page_num(mid_data,1);
    PageTableEntry* p1 = page_table_find_pte(&(KERNEL_SPACE.page_table),text);
    PageTableEntry* p2 = page_table_find_pte(&(KERNEL_SPACE.page_table),rodata);
    PageTableEntry* p3 = page_table_find_pte(&(KERNEL_SPACE.page_table),data);

    // 检查text区域是否可执行且不可写
    ASSERT(pte_is_executable(*p1) && !pte_is_writable(*p1));

    // 检查rodata区域是否可读且不可写
    ASSERT(pte_is_readable(*p2) && !pte_is_writable(*p2));

    // 检查data区域是否可读写
    ASSERT(pte_is_readable(*p3) && pte_is_writable(*p3));
}

void memory_set_new_bare(MemorySet *memory_set) 
{
    memory_set->page_table = *PageTable_new();
    vector_new(&memory_set->areas, sizeof(MapArea));
}



uint8_t* ppn_get_bytes_array(PhysPageNum ppn) 
{
  PhysAddr pa = phys_page_num_to_addr(ppn);
  return (uint8_t *)pa.addr;
}



static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len) 
{
  uint64_t start = 0;
  VirtPageNum current_vpn = map_area->vpn_range.start_vpn;
  for (;;) {
    PhysPageNum tmp;
    tmp.num = pte_ppn(*page_table_find_pte(pt, current_vpn));
    uint8_t *src = &data[start];
    uint8_t *dst = ppn_get_bytes_array(tmp);
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    memcpy(dst, src, cpy_len);
    start += PAGE_SIZE;
    if (start >= len) {
      break;
    }
    current_vpn.num += 1;
  }
}


void memory_set_push_pro(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len)
{
    map_area_map(map_area, &memory_set->page_table);
    if (data && len >= 0) 
    {
        map_area_copy_data(map_area, &memory_set->page_table, data, len);
    }
    vector_add(&memory_set->areas, map_area);
}


void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point) {
  memory_set_new_bare(memory_set);

  // map trampoline
  memory_set_map_trampoline(memory_set);

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
  if (elf_load_ret != 0) {
    printk("Elf load error.\n");
    ASSERT(0);
  }

  size_t ph_count = elf_header_get_phnum(&elf);
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn;
  max_end_vpn.num=0;
  for (size_t i = 0; i < ph_count; i++) {
    t_elf_program *ph = &elf.programs[i];
    if (elf_program_get_type(&elf, ph) == PT_LOAD) {
      start_va.addr = elf_program_get_vaddr(&elf, ph);
      end_va.addr = (start_va.addr + (uint64_t)elf_program_get_memsz(&elf, ph));
      map_perm = MAP_PERM_U;
      ph_flags = elf_program_get_flags(&elf, ph);
      if (ph_flags | PF_R) {
        map_perm |= MAP_PERM_R;
      }
      if (ph_flags | PF_W) {
        map_perm |= MAP_PERM_W;
      }
      if (ph_flags | PF_X) {
        map_perm |= MAP_PERM_X;
      }
      map_area.vpn_range.start_vpn = virt_addr_to_page_num(start_va,0);
      map_area.vpn_range.size = virt_addr_to_page_num(start_va,0).num-virt_addr_to_page_num(end_va,1).num+1;
      map_area.map_type = MAP_FRAMED;
      map_area.map_premission = map_perm;
      max_end_vpn.num = map_area.vpn_range.start_vpn.num + map_area.vpn_range.size-1;
      memory_set_push_pro(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = virt_page_num_to_addr(max_end_vpn);
  VirtAddr user_stack_bottom = max_end_va;
  // guard page
  user_stack_bottom.addr += PAGE_SIZE;
  VirtAddr user_stack_top;
  user_stack_top.addr = user_stack_bottom.addr + USER_STACK_SIZE;
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(user_stack_bottom,0);
  map_area.vpn_range.size = virt_addr_to_page_num(user_stack_top,1).num - map_area.vpn_range.start_vpn.num+1;
  map_area.map_type = MAP_FRAMED;
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
  memory_set_push(memory_set, &map_area);
    VirtAddr t2;
    t2.addr = TRAP_CONTEXT;
  // map TrapContext
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(t2,0);
  VirtAddr t1;
  t1.addr = TRAMPOLINE;
  map_area.vpn_range.size = virt_addr_to_page_num(t1,1).num - map_area.vpn_range.start_vpn.num + 1;
  map_area.map_type = MAP_FRAMED;
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W;
  memory_set_push(memory_set, &map_area);

  // return
  *user_sp = (uint64_t)user_stack_top.addr;
  *entry_point = elf_header_get_entry(&elf);
}
