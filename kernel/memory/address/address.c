#include "address.h"

// 将物理地址转换为物理页号
PhysPageNum phys_addr_to_page_num(PhysAddr addr, AlignDirection direction) {
    size_t num;
    if (direction == ALIGN_DOWN) {
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    } else {
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    }
    return (PhysPageNum){.num = num};
}

// 将虚拟地址转换为虚拟页号
VirtPageNum virt_addr_to_page_num(VirtAddr addr, AlignDirection direction) {
    size_t num;
    if (direction == ALIGN_DOWN) {
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    } else { // ALIGN_UP
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    }
    return (VirtPageNum){.num = num};
}

// 将虚拟页号转换为虚拟地址
VirtAddr virt_page_num_to_addr(VirtPageNum vpn) {
    // 计算页号对应的虚拟地址起始位置
    return (VirtAddr){.addr = vpn.num << PAGE_SIZE_BITS};
}

// 将物理页号转换为物理地址
PhysAddr phys_page_num_to_addr(PhysPageNum ppn) {
    // 计算页号对应的物理地址起始位置
    return (PhysAddr){.addr = ppn.num << PAGE_SIZE_BITS};
}

// 解析虚拟页号，获取页内偏移及三级页表中各级的索引
uint64_t* decompose_vpn(uint64_t vpn) {
    static uint64_t result[4];
    // 获取页内偏移
    uint64_t page_offset = vpn & OFFSET_MASK;
    // 移除偏移位，准备解析索引
    vpn >>= PAGE_SIZE_BITS;
    // 解析L3索引
    uint64_t l3 = vpn & INDEX_MASK;
    vpn >>= INDEX_BITS;
    // 解析L2索引
    uint64_t l2 = vpn & INDEX_MASK;
    vpn >>= INDEX_BITS;
    // 解析L1索引
    uint64_t l1 = vpn & INDEX_MASK;
    result[0] = l1;
    result[1] = l2;
    result[2] = l3;
    result[3] = page_offset;
    return result;
}
