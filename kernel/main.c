// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
//#include "memory.h"
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
    // console_putchar('1');
    init_trap();
    // print_uint64((uint64_t)&end);
    // print_str("\n");
    init_app();
    __asm__ volatile ("ecall");
    // __asm__ volatile ("ebreak");
    ASSERT(0);
    while(1);
}
