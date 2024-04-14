#ifndef CONTEXT_H
#define CONTEXT_H
#include "task.h"
struct TaskContext;

struct TrapContext
{
    uint64_t x[32];
    uint64_t sstatus;
    uint64_t sepc;
    uint64_t kernel_satp; //内核页表的起始物理地址
    uint64_t kernel_sp;   //前应用在内核地址空间中的内核栈栈顶的虚拟地址
    uint64_t trap_handler;//表示内核中 trap handler 入口点的虚拟地址。
};

void app_init_context(uint64_t entry, uint64_t sp, uint64_t kernel_satp,
                      uint64_t kernel_sp, uint64_t trap_handler,
                      struct TrapContext *c);

void task_context_goto_trap_return(struct TaskContext *cx, uint64_t kstack_ptr);

#endif