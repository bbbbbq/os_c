#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
#include "task.h"
#include "timer.h"
#include "buddy.h"
#include "mem.h"
#include "loader.h"
extern uint8_t sbss, ebss;

void clear_bss() {
  for (uint8_t *i = &sbss; i < &ebss; i++) {
    *i = 0;
  }
}
int main_os()
{
    mm_init();
    printk("123%d\n",123);
    //init_interrupt();
    init_trap();
    timer_init(); 
    task_manager_init();
    //asm("ebreak");
    // while(1){}
    loader_init_and_list_apps();
    list_apps();
    run_first_app();
    ASSERT(0);
}