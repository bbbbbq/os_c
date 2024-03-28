#ifndef BATCH_H
#define BATCH_H
#include "stdint.h"
#include "console.h"
#include "context.h"
#define MAX_APP_NUM 20
#define APP_BASE_ADDRESS 0x80400000
#define APP_SIZE_LIMIT 0x200000
struct AppManager
{
    uint64_t app_num;
    uint64_t current_app;
    uintptr_t app_start[MAX_APP_NUM];
    uintptr_t app_end[MAX_APP_NUM];
};
extern struct AppManager app_manager;
extern uint64_t _num_app[];
extern void __restore(uint64_t);
void init_appmanager();
void run_next_app();
void load_app(uint64_t app_id);
void print_app_info(struct AppManager *manager);
void run_first_app();
#endif