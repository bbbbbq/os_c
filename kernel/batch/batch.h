#ifndef BATCH_H
#define BATCH_H
#include "stdint.h"
#include "console.h"
#include "context.h"
#define MAX_APP_NUM 20
#define APP_BASE_ADDRESS 0x80400000
#define APP_SIZE_LIMIT 0x20000
struct TaskControlBlock;
struct AppManager
{
    uint64_t app_num;
    uint64_t current_app;
    uintptr_t app_start[MAX_APP_NUM];
    uintptr_t app_end[MAX_APP_NUM];
};


typedef struct
{
    
}TaskManager;
extern struct AppManager app_manager;
extern uint64_t _num_app[];
extern void __restore(uint64_t);
void init_appmanager();
// void run_next_app();
void print_app_info(struct AppManager *manager);
void run_first_app();
// void load_app_test();
struct TrapContext *get_trap_cx(struct TaskControlBlock *s);
void task_manager_run_next_task();
void task_control_block_free(struct TaskControlBlock *s);
struct TrapContext *task_manager_get_current_trap_cx(); 
void task_exit_current_and_run_next();
void task_manager_mark_current_exited();
int64_t task_manager_find_next_task();
void task_suspend_current_and_run_next();
#endif