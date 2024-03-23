#ifndef BATCH_H
#define BATCH_H
#include "stdint.h"
extern uint64_t* _num_app;

#define MAX_APP_NUM 20
#define APP_SIZE_LIMIT 0x20000
#define APP_BASE_ADDRESS  0x80400000
#define KERNEL_STACK_SIZE 4096*2
#define USER_STACK_SIZE   4096*2
#define FD_STDOUT 1
#define APP_SIZE_LIMIT    0x20000
#define APP_MAX_SIZE      0x20000  
extern uint32_t USER_STACK_SP;
static uint32_t current_app = 0; 
static uint8_t kernel_stack[KERNEL_STACK_SIZE] = {0};
static uint8_t user_stack[USER_STACK_SIZE] = {0};
#define SSTATUS_SPP (1UL << 8)

typedef struct AppManager 
{
    uint32_t num_app;
    uint32_t current_app;
    uint32_t app_start[MAX_APP_NUM + 1];
} appmanager;


void initAppManager(uint64_t* num_app_ptr);
uint64_t get_kernel_stack_top(void);
uint64_t get_user_stack_top(void);
void load_app();
void run_app();
#endif