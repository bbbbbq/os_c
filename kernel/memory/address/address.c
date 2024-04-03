#include "address.h"

PhysPageNum phys_addr_to_page_num(PhysAddr addr, AlignDirection direction) {
    size_t num;
    if (direction == ALIGN_DOWN) {
        num = addr.addr >> PAGE_SIZE_BITS;
    } else {
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    }
    return (PhysPageNum){.num = num};
}

VirtPageNum virt_addr_to_page_num(VirtAddr addr, AlignDirection direction) {
    size_t num;
    if (direction == ALIGN_DOWN) 
    {
        num = addr.addr >> PAGE_SIZE_BITS;
    } else { // ALIGN_UP
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    }
    return (VirtPageNum){.num = num};
}

VirtAddr virt_page_num_to_addr(VirtPageNum vpn) {
    return (VirtAddr){.addr = vpn.num << PAGE_SIZE_BITS};
}

PhysAddr phys_page_num_to_addr(PhysPageNum ppn) {
    return (PhysAddr){.addr = ppn.num << PAGE_SIZE_BITS};
}


uint64_t* decompose_vpn(uint64_t vpn)
{
    uint64_t result[4];
    uint64_t page_offset = vpn & OFFSET_MASK;
    vpn >>= PAGE_SIZE_BITS;
    uint64_t l3 = vpn & INDEX_MASK;
    vpn >>= INDEX_BITS;
    uint64_t l2 = vpn & INDEX_MASK;
    vpn >>= INDEX_BITS;
    uint64_t l1 = vpn & INDEX_MASK;
    result[0] = l1;
    result[1] = l2;
    result[2] = l3;
    result[3] = page_offset;
    return result;
}