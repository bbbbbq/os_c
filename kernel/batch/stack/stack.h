#ifndef STACK_H
#define STAKC_H
#define KERNEL_STACK_SIZE 4096 * 2
#include "stdint.h"
#include "batch.h"
#include "mem.h"
extern uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
extern uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];
extern uint8_t Trap_Stack[1024];

uint64_t get_kernel_stack_top(uint64_t app_id); 
uint64_t get_user_stack_top(uint64_t app_id);
void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top);
uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapcontext,uint64_t app_id);

#endif