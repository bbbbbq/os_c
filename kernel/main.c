// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
#include "memory.h"
extern char sbss;
extern char ebss; 
void clear_bss(void) 
{
    //print_str("clear_bss\n");
    char* start = &sbss;
    char* end = &ebss;
    while (start < end)
    {
        *start = 0;
        start++;
    }
}

static inline uint64_t read_sie(void) 
{
    uint64_t value;
    asm volatile("csrr %0, sie" : "=r" (value) :: "memory");
    return value;
}
extern char end;
void main_os()
{
    clear_bss();
    console_putchar('1');
    init_trap();
    //print_uint32(&end);
    print_str("\n");
    //init_memory(&sta,&end,PHYSICAL_MEMORY_END);
    //__asm__ volatile ("ebreak");
    //ASSERT(1==2);
    // print_str("123");
    // print_str("\n");
    // uint64_t sie_value = read_sie();
    // int timer_interrupt_enabled = (sie_value >> 5) & 1;
    // if (timer_interrupt_enabled) {
    //     print_str("start\n");
    // } else {
    //     print_str("close\n");
    // }
    //unsigned long free_memory_start = (unsigned long)&end;
    // print_str("free physical memory paddr = [");
    // print_uint32(free_memory_start);
    // print_str(", ");
    // print_uint32(PHYSICAL_MEMORY_END);
    // print_str("]\n");
    load_app();
    run_app();
    print_str("123123");
    __asm__ volatile ("ebreak");
    ASSERT(0);
    while(1);
}
