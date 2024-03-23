#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"
#define INTERRUPT_SUPERVISOR_TIMER 0x8000000000000005
#define EXCEPTION_BREAKPOINT 0x3

typedef struct trap_value{
    uint64_t x[32];    // 通用寄存器
    uint64_t sstatus;  // Supervisor Status 寄存器
    uint64_t sepc;     // Supervisor 异常程序计数器
    uint64_t stval;    // Supervisor 陷阱值
    uint64_t scause;   // Scause 寄存器: 记录异常/中断/陷阱的原因
} TrapFrame;


void init_trap(void);

void trap_handler(TrapFrame *fp);

void enable_global_interrupts();

void disable_global_interrupts();
#endif
