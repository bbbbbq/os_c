#include "trap.h"
#include "stdint.h"
#include "debug.h"
#include "console.h"
#include "timer.h"
#include "stdint.h"
#include "batch.h"
#include "syscall.h"
extern void __alltraps(void);
uintptr_t alltraps = (uintptr_t)__alltraps;

void enable_global_interrupts() 
{
    unsigned long sstatus;
    __asm__ volatile ("csrr %0, sstatus" : "=r"(sstatus));
    sstatus |= (1 << 1);
    __asm__ volatile ("csrw sstatus, %0" : : "r"(sstatus));
}
void disable_global_interrupts() 
{
    unsigned long sstatus;
    __asm__ volatile ("csrr %0, sstatus" : "=r"(sstatus));
    sstatus &= ~(1UL << 1);
    __asm__ volatile ("csrw sstatus, %0" : : "r"(sstatus));
}



void init_trap(void)
{
    timer_init();
    unsigned long sstatus;
    asm volatile("csrw sscratch, zero");
    //uint64_t trap_handler_addr = (uint64_t)trap_handler;
    asm volatile("csrw stvec, %0" : : "r"(alltraps));
    //使能中断
    __asm__ volatile ("csrr %0, sstatus" : "=r"(sstatus));
    sstatus |= (1 << 1);
    __asm__ volatile ("csrw sstatus, %0" : : "r"(sstatus));

    print_str("++++ setup interrupt! ++++\n");
}

 void intr_break_handle(uint64_t *sepc)
 {
    uint64_t scause;
    __asm__ volatile ("csrr %0, scause" : "=r"(scause));
    switch (scause) 
    {
        case 0:
            print_str("Instruction address misaligned\n");
            break;
        case 1:
            print_str("Instruction access fault\n");
            break;
        case 2:
            print_str("Illegal instruction\n");
            break;
        case 3:
            print_str("Breakpoint\n");
            *sepc += 2;
            break;
        case 4:
            print_str("Load address misaligned\n");
            break;
        case 5:
            print_str("Load access fault\n");
            break;
        case 6:
            print_str("Store/AMO address misaligned\n");
            break;
        case 7:
            print_str("Store/AMO access fault\n");
            break;
        case 8:
            print_str("Environment call from U-mode\n");
            break;
        case 9:
            print_str("Environment call from S-mode\n");
            break;
        case 11:
            print_str("Environment call from M-mode\n");
            break;
        case 12:
            print_str("Instruction page fault\n");
            break;
        case 13:
            print_str("Load page fault\n");
            break;
        case 15:
            print_str("Store/AMO page fault\n");
            break;
        default:
            print_str("Unknown exception\n");
            break;
    }
}

TrapContext *trap_handler(TrapContext *cx) 
{
    print_str("trap_handler\n");
    uint64_t scause = r_scause();
    uint64_t stval = r_stval();
    uint64_t trap = scause & 0x0fff;
    if (scause & 0x8000 == 1) {
        print_str("can't identify interrupt trap");
        ASSERT(0);
    } else {
        switch (trap) {
            case UserEnvCall:
                cx->sepc += 4;
                cx->x_regs[10] = syscall(cx->x_regs[17], cx->x_regs[10], cx->x_regs[11], cx->x_regs[12]);
                break;
            case StoreFault:
                print_str("[kernel] app err: store fault. run next\n");
                run_next_app();
                break;
            default:
                print_str("trap scause undefined.");
                ASSERT(0);
                break;
        }
    }

    return cx;
}
