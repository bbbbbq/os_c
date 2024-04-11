#ifndef STACK_H
#define STAKC_H
#include "stdint.h"
#include "batch.h"
#include "mem.h"
#include "pid.h"

typedef struct
{
    PidHandle pid;
}KernelStack;

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top);
KernelStack kernel_stack_new(PidHandle pid);
void* kernel_stack_push_on_top(KernelStack stack,void* value);
uint64_t kernel_stack_get_top(KernelStack stack);
#endif