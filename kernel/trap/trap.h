#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"
#define INTERRUPT_SUPERVISOR_TIMER 0x8000000000000005
#define EXCEPTION_BREAKPOINT 0x3
#define StoreFault  7


#define InstructionMisaligned       0
#define InstructionFault            1
#define IllegalInstruction          2
#define Breakpoint                  3
#define LoadFault                   5
#define StoreMisaligned             6
#define StoreFault                  7
#define UserEnvCall                 8
#define VirtualSupervisorEnvCall    10
#define InstructionPageFault        12
#define LoadPageFault               13
#define StorePageFault              15


typedef struct TrapContext{
    uint64_t x_regs[32];
    uint64_t sstatus;
    uint64_t sepc;
}TrapContext;

void init_trap(void);

TrapContext * trap_handler(TrapContext *fp);

void enable_global_interrupts();

void disable_global_interrupts();
#endif
