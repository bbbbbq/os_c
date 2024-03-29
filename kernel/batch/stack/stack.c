#include "stack.h"
#include "string.h"
#include "stdint.h"
#include "batch.h"
#include "context.h"
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
    memset_t(stack - KERNEL_STACK_SIZE, 0,(uint32_t)KERNEL_STACK_SIZE);
}


uint64_t get_kernel_stack_top( uint64_t app_id ) {
    return (uint64_t)(Kernelstack[app_id]) + KERNEL_STACK_SIZE;
}


uint64_t get_user_stack_top( uint64_t app_id ) {
    return (uint64_t)(UserStack[app_id]) + USER_STACK_SIZE;
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

//初始化trapcontext以及压栈
uint64_t init_app_cx(uint64_t id)
{
    // struct TrapContext tmp_cx = app_init_context(app_manager.app_start[id],(uint64_t)get_user_stack_top(id));
    // uint64_t sp = (uint64_t)get_kernel_stack_top(id);
    // return sp;  
}   