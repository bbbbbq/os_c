// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"

extern char sbss;
extern char ebss; 
void clear_bss(void) {
    char* start = &sbss;
    char* end = &ebss;
    while (start < end) {
        *start = 0;
        start++;
    }
}



int main_os()
{
    clear_bss();
    console_putchar('1');
    init_trap();
    __asm__ volatile ("ebreak");
    ASSERT(1==2);
    print_str("123");
    while(1);
}
