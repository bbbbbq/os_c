#include "trap.h"
#include "stdint.h"
#include "debug.h"
#include "console.h"
extern uint64_t __alltraps;
void init_trap(void) 
{
    asm volatile("csrw sscratch, zero");
    //uint64_t trap_handler_addr = (uint64_t)trap_handler;
    uintptr_t alltraps = (uintptr_t)__alltraps;
    __asm__ volatile ("csrw stvec, %0" : : "r"(alltraps));
    print_str("++++ setup interrupt! ++++\n");
}

__attribute__((noreturn)) void trap_handler(void) {
    // uint64_t cause, epc;
    // asm volatile("csrr %0, scause" : "=r"(cause));
    // asm volatile("csrr %0, sepc" : "=r"(epc));
    // print_str("cause : ");
    // print_uint32(cause);
    // print_str("\n");

    // print_str("sepc : ");
    // print_uint32(epc);
    // print_str("\n");
    print_str("trap handled!");
    while(1); // 防止返回
}
