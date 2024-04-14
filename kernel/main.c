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
#include "processor.h"
#include "taskmanager.h"
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
    init_trap();
    timer_init();
    loader_init_and_list_apps();
    taks_init();
    task_manager_add_2_initproc();
    processor_run_tasks();
    //task_manager_init();
    // loader_init_and_list_apps();
    // list_apps();
    // processor_init(&PROCESSOR);
    // task_manager_init_2();
    // task_manager_add_2_initproc();
    // //run_first_app();
    // processor_run_tasks();
    ASSERT(0);
}