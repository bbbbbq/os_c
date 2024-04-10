#include "timer.h"
#include "sbi.h"
#include "task.h"
static inline uint64_t read_time(void) 
{
    uint64_t time;
    __asm__ volatile ("csrr %0, time" : "=r"(time));
    return time;
}

void clock_set_next_event() 
{
    sbi_set_timer(read_time() + TIMEBASE);
}


void timer_init()
{
    clock_set_next_event();
    print_str("----timer_init----\n");
}


void intr_timer_handle()
{
    printk("intr_timer_handle\n");
    //run_next_task(1);
    ticks++;
    clock_set_next_event();
    if(ticks % 10 == 0)
    {
        print_str("timer_interrupt\n");
    }
    // task_manager_run_next_task();
    // if(ticks==100)
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
}