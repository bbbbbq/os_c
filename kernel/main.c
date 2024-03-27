// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
int main_os()
{
    console_putchar('1');
    print_str("123123\n");
    //asm volatile ("ebreak");
    init_interrupt();
    //asm volatile("ebreak");
    //asm volatile("ecall");
    init_appmanager();
    run_first_app();
    __asm__ volatile ("ebreak");
    ASSERT(0);
    while(1);
}
