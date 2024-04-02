#include "pte.h"
#include "addr.h"

PageTableEntry pte_new(PhysPageNum ppn) 
{
    uint64_t num = ppn.num;
    return (uintptr_t)(num << 10);
}