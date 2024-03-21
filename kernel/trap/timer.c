#include "timer.h"
#include "sbi.h"
void timer_init()
{
    uint64_t sie_val;
    __asm__ volatile ("csrr %0, sie" : "=r"(sie_val));
    sie_val |= (1 << 5);
    __asm__ volatile ("csrw sie, %0" : : "r"(sie_val));
    ticks = 0;
    clock_set_next_event();
    print_str("----timer_init----\n");
}

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

void intr_timer_handle()
{
    ticks++;
    clock_set_next_event();
    if(ticks==100)
    {
        print_str("timer interrupt: ");
        print_uint32(ticks);
        print_str("\n");
    }
    if(ticks==100000) ticks=0;
}