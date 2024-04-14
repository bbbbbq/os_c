#ifndef STACK_H
#define STACK_H
#include "stdint.h"
#include "mem.h"
#include "pid.h"


struct KernelStack 
{
    PidHandle pid;
};

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top);
void kernel_stack_new(struct KernelStack *ks, PidHandle pid);
void* kernel_stack_push_on_top(struct KernelStack stack,void* value);
uint64_t kernel_stack_get_top(struct KernelStack stack);


#endif