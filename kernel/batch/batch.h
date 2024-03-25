#ifndef BATCH_H
#define BATCH_H
#include "stdint.h"
#include "trap.h"
#define APP_ADDR_BASE 0x80400000
#define APP_MEMORY_LIMII 0x2000
#define MAX_APPS_NUM 20

#define KERNEL_STACK_SIZE 4096*2
#define USER_STACK_SIZE 4096*2


// 栈声明



//初始化app信息  清空内存  清空缓存   拷贝第一个程序到执行地址 
void init_app();

// void clear_memory(uint64_t app_idx);

// void load_app(uint64_t app_idx);

void run_next_app();

// void set_sepc_to_app_start();

void app_init_context(struct TrapContext *ctx, uint64_t entry, uint64_t sp);

uintptr_t get_kernel_stack_top();

uintptr_t get_user_stack_top(); 
#endif