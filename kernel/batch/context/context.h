#ifndef CONTEXT_H
#define CONTEXT_H

struct TrapContext
{
    uint64_t x[32];
    uint64_t sstatus;
    uint64_t sepc;
    uint64_t kernel_satp; //内核页表的起始物理地址
    uint64_t kernel_sp;   //前应用在内核地址空间中的内核栈栈顶的虚拟地址
    uint64_t trap_handler;//表示内核中 trap handler 入口点的虚拟地址。
};

struct TrapContext app_init_context(uint64_t entry, uint64_t sp);
#endif