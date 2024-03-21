// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
extern char sbss;
extern char ebss; 
void clear_bss(void) 
{
    print_str("clear_bss\n");
    char* start = &sbss;
    char* end = &ebss;
    while (start < end)
    {
        *start = 0;
        start++;
    }
}

static inline uint64_t read_sie(void) {
    uint64_t value;
    asm volatile("csrr %0, sie" : "=r" (value) :: "memory");
    return value;
}



void main_os()
{
    clear_bss();
    console_putchar('1');
    init_trap();
    //__asm__ volatile ("ebreak");
    //ASSERT(1==2);
    print_str("123");
    print_str("\n");
    // uint64_t sie_value = read_sie();
    // int timer_interrupt_enabled = (sie_value >> 5) & 1;
    // if (timer_interrupt_enabled) {
    //     print_str("start\n");
    // } else {
    //     print_str("close\n");
    // }
    while(1);
}
