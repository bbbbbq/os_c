#ifndef STACK_H
#define STAKC_H
#define USER_STACK_SIZE 4096 * 2
#define KERNEL_STACK_SIZE 4096 * 2
#include "stdint.h"
#include "batch.h"
extern uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
extern uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];
extern uint8_t Trap_Stack[1024];
void init_user_stack(uint8_t* stack);
void init_kernel_stack(uint8_t* stack);

uint64_t get_kernel_stack_top(uint64_t app_id); 
uint64_t get_user_stack_top(uint64_t app_id);

uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapcontext,uint64_t app_id);
uint8_t* UserStack_push_TrapContext(struct TrapContext trapcontext,uint64_t app_id);

//初始化trapcontext以及压栈
uint64_t init_app_cx(uint64_t id);
#endif