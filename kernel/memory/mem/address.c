#include "config.h"
#include "mem.h"

void vpn_indexes(VirtPageNum vpn, uint64_t *idx) {
  printk("vpn_indexes start \n");
  for (int i = 2; i >= 0; i--) {
    idx[i] = vpn & 0x1ff;
    vpn >>= 9;
  }
  printk("vpn_indexes end \n");
}

PageTableEntry *ppn_get_pte_array(PhysPageNum ppn) {
  PhysAddr pa = pn2addr(ppn);
  return (PageTableEntry *)pa; // len = 512 * 8
}

uint8_t *ppn_get_bytes_array(PhysPageNum ppn) {
  PhysAddr pa = pn2addr(ppn);
  return (uint8_t *)pa; // len = PAGE_SIZE (4096)
}
