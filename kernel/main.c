// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
#include "task.h"
#include "timer.h"
int main_os()
{
    console_putchar('1');
    print_str("123123\n");
    init_interrupt();
    // init_appmanager();
    // run_first_app();
    init_appmanager();
    //init_appmanager();
    init_TaskManager();
    //run_first_task();
    run_first_app();
    __asm__ volatile ("ebreak");
    //ASSERT(0);
    //__asm__ volatile ("ecall");
   // uint64_t cnt = 0;
    while(1)
    {
        // cnt++;
        // if(cnt%100000==0)
        // {
        //     print_str("ticks : ");
        //     print_uint64(ticks);
        //     print_str("\n");
        // }
    }
    ASSERT(0);
}
