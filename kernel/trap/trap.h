#ifndef TRAP_H
#define TRAP_H

#include "stdint.h"
typedef uintptr_t Sstatus;

typedef uintptr_t Scause;

// 用于保存中断或异常时的上下文
typedef struct TrapFrame {
    uintptr_t x[32]; // 通用寄存器
    Sstatus sstatus; // 监管态状态寄存器
    uintptr_t sepc; // 监管态异常程序计数器
    uintptr_t stval; // 监管态陷阱值
    Scause scause; // 监管态陷阱原因寄存器
} TrapFrame;

#endif // TRAP_H
