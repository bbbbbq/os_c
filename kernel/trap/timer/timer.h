#ifndef TIMER_H
#define TIMER_H
#include "stdint.h"
#include "console.h"
static uint64_t ticks=0;
#define TIMEBASE 1000

#define TICKS_PER_SEC 100
#define USEC_PER_SEC 1000000
typedef struct
{
    uint64_t sec;
    uint64_t usec;
} TimeVal;

void timer_init(); 
void intr_timer_handle();
uint64_t timer_get_time();
uint64_t timer_get_time_us();
void timer_set_next_trigger();
#endif