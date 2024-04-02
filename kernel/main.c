// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
#include "task.h"
#include "timer.h"
#include "kernel_heap.h"
int main_os()
{
    console_putchar('1');
    print_str("123123\n");
    init_interrupt();
    load_app_test();
    timer_init(); 
    // init_appmanager();
    // run_first_app();
    init_appmanager();
    // init_appmanager();
    task_manager_init();
    ASSERT(0);
    while(1){}
    ASSERT(0);
}
