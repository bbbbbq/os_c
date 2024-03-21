#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"
// 初始化中断系统
void init_trap(void);

void trap_handler(void);

#include <stdint.h>

typedef struct {
    uint64_t x[32];    // 通用寄存器
    uint64_t sstatus;  // Supervisor Status 寄存器
    uint64_t sepc;     // Supervisor 异常程序计数器
    uint64_t stval;    // Supervisor 陷阱值
    uint64_t scause;   // Scause 寄存器: 记录异常/中断/陷阱的原因
} TrapFrame;

#endif
