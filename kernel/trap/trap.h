#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"
#define INTERRUPT_SUPERVISOR_TIMER 0x8000000000000005UL
#define EXCEPTION_BREAKPOINT 0x3
#define EXCEPTION_ILLEGAL_INSTRUCTION 0x2
#define EXCEPTION_STORE_FAULT 0x7
#define EXCEPTION_STORE_PAGE_FAULT 0xf

struct TrapContext 
{
    uintptr_t x[32];
    uintptr_t sstatus;
    uintptr_t sepc;
};
extern void __restore(struct TrapContext* ctx);
void init_trap(void);

void trap_handler(struct TrapContext *fp);

void enable_global_interrupts();

void disable_global_interrupts();
#endif
