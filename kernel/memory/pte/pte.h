#ifndef PTE_H
#define PTE_h
#include "stdint.h"
#include "addr.h"
typedef uintptr_t PageTableEntry;

PageTableEntry pte_new(PhysPageNum ppn);

#endif