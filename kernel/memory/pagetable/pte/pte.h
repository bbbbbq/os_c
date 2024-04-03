#ifndef PTE_H
#define PTE_H
#include "stdint.h"
// 定义 PTEFlags 作为位掩码的集合
typedef uint8_t PTEFlags;
#define ENTRIES_PER_PAGE 4096
#define PTE_V  (1 << 0) // Valid
#define PTE_R  (1 << 1) // Read
#define PTE_W  (1 << 2) // Write
#define PTE_X  (1 << 3) // Execute
#define PTE_U  (1 << 4) // User
#define PTE_G  (1 << 5) // G, 忽略
#define PTE_A  (1 << 6) // Accessed
#define PTE_D  (1 << 7) // Dirty
#define PTE_PPN_SHIFT 10
typedef struct 
{
    uint64_t bits;
} PageTableEntry;

PageTableEntry pte_new(uint64_t ppn, PTEFlags flags);
PageTableEntry pte_empty(void);
uint64_t pte_ppn(PageTableEntry pte);
PTEFlags pte_flags(PageTableEntry pte);
int pte_is_valid(PageTableEntry pte);
void set_pte(PageTableEntry* entry, uint64_t ppn, uint64_t flags);

#endif