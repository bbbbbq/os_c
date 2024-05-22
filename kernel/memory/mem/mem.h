#ifndef _MM_H_
#define _MM_H_

#include "stdint.h"
#include "debug.h"
#include "config.h"
#include "vector.h"

#define MMAP_MAX_SIZE (1 << 30) // 1GB 最大内存映射大小

// 页码和地址计算的实用宏
#define page_floor(x) ((x) / PAGE_SIZE)                // 计算地址x的页底部编号
#define page_ceil(x) (((x)-1 + PAGE_SIZE) / PAGE_SIZE) // 计算地址x的页顶部编号
#define page_offset(x) ((x) & (PAGE_SIZE - 1))         // 计算地址x在页内的偏移量
#define page_aligned(x) (page_offset(x) == 0)          // 检查地址x是否为页对齐
#define addr2pn(x) page_floor(x)                       // 将地址转换为页码
#define pn2addr(x) ((x) << PAGE_SIZE_BITS)             // 将页码转换为地址

// 页表项（PTE）操作宏
#define pte_new(ppn, flags) ((ppn) << 10 | (PageTableEntry)flags) // 创建一个新的PTE，给定PPN和flags
#define pte_empty() 0                                             // 表示一个空的PTE
#define pte_ppn(pte) (((pte) >> 10) & ((1L << 44) - 1))           // 从PTE中提取PPN
#define pte_flags(pte) ((PTEFlags)((pte) & 0xff))                 // 从PTE中提取flags
#define pte_is_valid(pte) (((pte) & PTE_V) != pte_empty())        // 检查PTE是否有效
#define pte_readable(pte) (((pte) & PTE_R) != pte_empty())        // 检查PTE是否允许读权限
#define pte_writable(pte) (((pte) & PTE_W) != pte_empty())        // 检查PTE是否允许写权限
#define pte_executable(pte) (((pte) & PTE_X) != pte_empty())      // 检查PTE是否允许执行权限

// 页表项flags
#define PTE_V (1L << 0) // 有效
#define PTE_R (1L << 1) // 可读
#define PTE_W (1L << 2) // 可写
#define PTE_X (1L << 3) // 可执行
#define PTE_U (1L << 4) // 用户模式
#define PTE_G (1L << 5) // 全局
#define PTE_A (1L << 6) // 已访问
#define PTE_D (1L << 7) // 脏页

// 映射类型和权限
#define MAP_IDENTICAL 0 // 虚拟地址到物理地址的直接映射
#define MAP_FRAMED 1    // 需要帧分配的映射

#define MAP_PERM_R PTE_R // 读权限
#define MAP_PERM_W PTE_W // 写权限
#define MAP_PERM_X PTE_X // 执行权限
#define MAP_PERM_U PTE_U // 用户模式权限

#define FROM_USER 0 // 复制方向：从用户空间
#define TO_USER 1   // 复制方向：到用户空间

// 虚拟和物理地址、页码等的类型定义
typedef uint64_t PhysAddr;
typedef uint64_t VirtAddr;
typedef uint64_t PhysPageNum;
typedef uint64_t VirtPageNum;

typedef uint8_t PTEFlags;
typedef uint64_t PageTableEntry;

typedef struct
{
  PhysPageNum root_ppn; // 根页表页码
  struct vector frames; // 为此页表分配的帧的向量
} PageTable;

typedef struct
{
  VirtPageNum l; // 虚拟页码范围的下界
  VirtPageNum r; // 虚拟页码范围的上界
} VPNRange;

typedef uint8_t MapType;
typedef uint8_t MapPermission;

typedef struct
{
  VPNRange vpn_range;     // 虚拟页码范围
  MapType map_type;       // 映射类型（如，相同、帧映射）
  MapPermission map_perm; // 此映射区域的权限
} MapArea;

typedef struct
{
  PageTable page_table; // 页表
  struct vector areas;  // 映射区域的向量
} MemorySet;

/*
 *
 *  MemorySet 结构解析：
 *    ├── PageTable
 *    │     ├── Root PPN（根页表页码）
 *    │     └── Vector of PPN frames（PPN帧的向量）
 *    └── Vector of MapArea（映射区域的向量）
 *                    ├── VPN Range（虚拟页码范围）
 *                    │     ├── VPN l（左虚拟页码）
 *                    │     └── VPN r（右虚拟页码）
 *                    ├── MapType（映射类型：相同/帧映射）
 *                    └── MapPermission（映射权限：R/W/X/U）
 */

// mm.c
void mm_init(); // 初始化内存管理系统
void mm_free(); // 释放内存管理系统资源

// address.c
void vpn_indexes(VirtPageNum vpn, uint64_t *idx);   // 计算VPN的索引
PageTableEntry *ppn_get_pte_array(PhysPageNum ppn); // 获取PPN对应的PTE数组
uint8_t *ppn_get_bytes_array(PhysPageNum ppn);      // 获取PPN对应的字节数组

// heap_allocator.c
void heap_allocator_init(); // 初始化堆分配器

// frame_allocator.c
void frame_allocator_init();         // 初始化帧分配器
void frame_allocator_free();         // 释放帧分配器资源
PhysPageNum frame_alloc();           // 分配一个物理页帧
void frame_dealloc(PhysPageNum ppn); // 释放一个物理页帧
uint64_t frame_remaining_pages();    // 获取剩余的物理页帧数
void frame_allocator_print();        // 打印帧分配器的状态信息

// page_table.c
void page_table_new(PageTable *pt);                                         // 创建新的页表
void page_table_free(PageTable *pt);                                        // 释放页表资源
void page_table_from_token(PageTable *pt, uint64_t satp);                   // 从SATP令牌创建页表
PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn); // 查找或创建PTE
PageTableEntry *page_table_find_pte(PageTable *pt, VirtPageNum vpn);        // 查找PTE
void page_table_map(PageTable *pt, VirtPageNum vpn, PhysPageNum ppn,
                    PTEFlags flags);                                  // 将VPN映射到PPN
void page_table_unmap(PageTable *pt, VirtPageNum vpn);                // 取消VPN的映射
PageTableEntry *page_table_translate(PageTable *pt, VirtPageNum vpn); // 翻译VPN到PTE
uint64_t page_table_token(PageTable *pt);                             // 获取页表的SATP令牌
int64_t copy_byte_buffer(uint64_t token, uint8_t *kernel, uint8_t *user,
                         uint64_t len, uint64_t direction); // 在内核和用户空间之间复制字节缓冲区

// memory_set.c
uint64_t memory_set_token(MemorySet *memory_set); // 获取内存集的SATP令牌
void memory_set_free(MemorySet *memory_set);      // 释放内存集资源
void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point);                                 // 从ELF文件创建内存集
void memory_set_from_existed_user(MemorySet *memory_set, MemorySet *user_space); // 从现有用户空间创建内存集
void memory_set_kernel_init();                                                   // 初始化内核空间
PageTableEntry *memory_set_translate(MemorySet *memory_set, VirtPageNum vpn);    // 翻译VPN到PTE
void memory_set_recycle_data_pages(MemorySet *memory_set);                       // 回收数据页
void kernel_space_insert_framed_area(VirtAddr start_va, VirtAddr end_va,
                                     MapPermission permission);      // 在内核空间插入帧映射区域
void kernel_space_remove_area_with_start_vpn(VirtPageNum start_vpn); // 根据起始VPN移除内核空间区域
uint64_t kernel_space_token();                                       // 获取内核空间的SATP令牌
int64_t memory_set_mmap(MemorySet *memory_set, uint64_t start, uint64_t len,
                        uint64_t prot);                                         // 内存映射
int64_t memory_set_munmap(MemorySet *memory_set, uint64_t start, uint64_t len); // 取消内存映射
void memory_set_remap_test();                                                   // 内存重映射测试
void memory_set_insert_framed_area(MemorySet *memory_set,
                                   VirtAddr start_va, VirtAddr end_va,
                                   MapPermission permission);
void memory_set_push(MemorySet *memory_set, MapArea *map_area,
                     uint8_t *data, uint64_t len);
#endif // _MM_H_
