#include "trap.h"
#include "stdint.h"
#include "debug.h"
#include "console.h"
#include "timer.h"
#include "stdint.h"
extern void __alltraps(void);
uintptr_t alltraps = (uintptr_t)__alltraps;
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
    print_str("break interrupt \n");
    *sepc+=2;
 }

void trap_handler(TrapFrame *fp) 
{
    print_str("trap handled!");
    uint64_t scause = fp->scause;
    switch (scause)
    {
        case INTERRUPT_SUPERVISOR_TIMER:
            intr_timer_handle();
            break;
        case EXCEPTION_BREAKPOINT:
            intr_break_handle(&(fp->sepc));
            break;
        default:
            print_str("unknow interrupt\n");
            ASSERT(0);
            break;
    }   
}
