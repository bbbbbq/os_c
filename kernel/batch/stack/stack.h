#ifndef STACK_H
#define STAKC_H
#define USER_STACK_SIZE 4096 * 2
#define KERNEL_STACK_SIZE 4096 * 2
#include "stdint.h"
extern uint8_t UserStack[USER_STACK_SIZE];
extern uint8_t Kernelstack[KERNEL_STACK_SIZE];

void init_user_stack(uint8_t* stack);
void init_kernel_stack(uint8_t* stack);

uint8_t* get_kernel_sp(uint8_t *stack);
uint8_t* get_user_sp(uint8_t *stack);
#endif