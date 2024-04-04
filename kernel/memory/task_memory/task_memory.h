#ifndef TASK_MEMORY_H
#define TASK_MEMORY_H
#include "vector.h"
#include "pagetable.h"
#include "stdint.h"
#include "address.h"
#define MAP_PREMISSION_R  (1 << 1)
#define MAP_PREMISSION_W  (1 << 2)
#define MAP_PREMISSION_X  (1 << 3)
#define MAP_PREMISSION_U  (1 << 4)
#define TRAMPOLINE         (((uint64_t)0x7fFFFFFfff - PAGE_SIZE + 1))
#define TRAMPOLINE_FULL    (0xffffff8000000000 | TRAMPOLINE)
#define TRAP_CONTEXT       (TRAMPOLINE - PAGE_SIZE)
#define TRAP_CONTEXT_FULL  (0xffffff8000000000 | TRAP_CONTEXT)

#define MAP_PERM_R PTE_R
#define MAP_PERM_W PTE_W
#define MAP_PERM_X PTE_X
#define MAP_PERM_U PTE_U


#define MAP_IDENTICAL 0
#define MAP_FRAMED 1
typedef struct MemorySet
{
    PageTable page_table;
    Vector areas;
}MemorySet;

enum MapType
{
    Identical,
    Framed
};

// 逻辑段的权限
typedef uint32_t MapPermission;

// 连续虚拟地址的范围
typedef struct VpnRange
{
    VirtPageNum start_vpn;
    uint64_t size;
}VpnRange;


// 逻辑段（具有相同权限的段，虚拟地址连续
typedef struct MapArea
{
    VpnRange vpn_range;
    enum MapType map_type;
    MapPermission map_premission;
}MapArea;


extern MemorySet KERNEL_SPACE;
void memory_set_new_bare(MemorySet *memory_set);
void map_area_init(MapArea* ma, VirtAddr start_va, VirtAddr end_va, enum MapType mt, MapPermission mp);
void map_area_map(MapArea* ma, PageTable* pt);
void memory_set_init(MemorySet* ms);
void memory_set_push(MemorySet* ms, MapArea* ma);
void memory_set_kernel_new(MemorySet* ms);
void memory_set_map_user_stack(MemorySet *ms, VirtAddr user_stack_low_va);
void memory_set_activate(MemorySet *memory_set);
void memory_set_remap_test();
void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data, \
                         size_t elf_size, uint64_t *user_sp, \
                         uint64_t *entry_point);
void memory_set_push_pro(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len);

static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len);

uint8_t* ppn_get_bytes_array(PhysPageNum ppn);

#endif
