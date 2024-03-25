#include "trap.h"
#include "stdint.h"
#include "debug.h"
#include "console.h"
#include "timer.h"
#include "stdint.h"
#include "batch.h"
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
            ASSERT(0);
            break;
        case 1:
            print_str("Instruction access fault\n");
            ASSERT(0);
            break;
        case 2:
            print_str("Illegal instruction\n");
            ASSERT(0);
            break;
        case 3:
            print_str("Breakpoint\n");
            *sepc += 2;
            break;
        case 4:
            print_str("Load address misaligned\n");
            ASSERT(0);
            break;
        case 5:
            print_str("Load access fault\n");
            ASSERT(0);
            break;
        case 6:
            print_str("Store/AMO address misaligned\n");
            ASSERT(0);
            break;
        case 7:
            print_str("Store/AMO access fault\n");
            ASSERT(0);
            break;
        case 8:
            print_str("Environment call from U-mode\n");
            ASSERT(0);
            break;
        case 9:
            print_str("Environment call from S-mode\n");
            ASSERT(0);
            break;
        case 11:
            print_str("Environment call from M-mode\n");
            ASSERT(0);
            break;
        case 12:
            print_str("Instruction page fault\n");
            ASSERT(0);
            break;
        case 13:
            print_str("Load page fault\n");
            ASSERT(0);
            break;
        case 15:
            print_str("Store/AMO page fault\n");
            ASSERT(0);
            break;
        default:
            print_str("Unknown exception\n");
            ASSERT(0);
            break;
    }
}
void trap_handler(struct TrapContext *cx) 
{
    uint64_t scause;
    asm volatile("csrr %0, scause" : "=r"(scause));
    switch (scause) {
        case INTERRUPT_SUPERVISOR_TIMER:
            intr_timer_handle();
            break;
        case EXCEPTION_BREAKPOINT:
            intr_break_handle(&cx->sepc);
            break;
        case EXCEPTION_ILLEGAL_INSTRUCTION:
            print_str("[kernel] Illegal instruction in application, kernel killed it.\n");
            break;
        case EXCEPTION_STORE_FAULT:
        case EXCEPTION_STORE_PAGE_FAULT:
            print_str("[kernel] Page fault in application, kernel killed it.\n");
            break;
        default:
            print_str("[kernel] Unknown interrupt or exception\n");
            break;
    }
    run_next_app();  // 假设每次处理完中断或异常都运行下一个应用程序
}