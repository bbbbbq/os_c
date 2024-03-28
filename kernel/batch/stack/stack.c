#include "stack.h"
#include "string.h"
#include "stdint.h"
#include "batch.h"

// uint8_t UserStack[USER_STACK_SIZE];
// uint8_t Kernelstack[KERNEL_STACK_SIZE];
uint8_t Trap_Stack[1024];
uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];

void init_user_stack(uint8_t* stack) 
{
    memset_t(stack - USER_STACK_SIZE, 0, (uint32_t)USER_STACK_SIZE);
}

void init_kernel_stack(uint8_t* stack) 
{
    memset_t(stack - KERNEL_STACK_SIZE, 0,(uint32_t) KERNEL_STACK_SIZE);
}

uint8_t* get_kernel_sp(uint8_t *stack) 
{
    return stack + KERNEL_STACK_SIZE;
}

uint8_t* get_user_sp(uint8_t *stack)
{
    return stack + USER_STACK_SIZE;
}

uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
{
    uint8_t* stackTop = Kernelstack[task_id] + KERNEL_STACK_SIZE; // 指向栈顶
    stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
    *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
    return stackTop; // 返回新的栈顶地址
}

uint8_t* UserStack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
{
    uint8_t* stackTop = UserStack[task_id] + USER_STACK_SIZE; // 指向栈顶
    stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
    *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
    return stackTop; // 返回新的栈顶地址
}
