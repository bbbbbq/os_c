#ifndef TIMER_H
#define TIMER_H
#include "stdint.h"
#include "console.h"
static uint64_t ticks=1000;
#define TIMEBASE 100000
void timer_init(); 
void intr_timer_handle();
#endif