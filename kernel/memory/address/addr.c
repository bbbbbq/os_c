#include "addr.h"
PhysPageNum phys_addr_to_page_num(PhysAddr addr, bool roundUp) 
{
    PhysPageNum ppn;
    if (roundUp) 
    {
        // 向上取整
        ppn.num = (addr.addr + (1ULL << PAGE_SIZE_BITS) - 1) >> PAGE_SIZE_BITS;
    } else 
    {
        // 向下取整
        ppn.num = addr.addr >> PAGE_SIZE_BITS;
    }
    return ppn;
}
PhysAddr phys_page_num_to_addr(PhysPageNum ppn) 
{
    PhysAddr addr;
    addr.addr = ppn.num << PAGE_SIZE_BITS;
    return addr;
}

VirtPageNum virt_addr_to_page_num(VirtAddr addr, bool roundUp) 
{
    VirtPageNum vpn;
    if (roundUp) 
    {
        // 向上取整
        vpn.num = (addr.addr + (1ULL << PAGE_SIZE_BITS) - 1) >> PAGE_SIZE_BITS;
    } else 
    {
        // 向下取整
        vpn.num = addr.addr >> PAGE_SIZE_BITS;
    }
    return vpn;
}

VirtAddr virt_page_num_to_addr(VirtPageNum vpn) 
{
    VirtAddr addr;
    addr.addr = vpn.num << PAGE_SIZE_BITS;
    return addr;
}