#ifndef TASK_H
#define TASK_H
#include "batch.h"
#include "stdint.h"
#include "mem.h"
#include "batch.h"
#include "config.h"
#define MAX_APP_NUM 20
struct TaskContext;
enum TaskStatus 
{
    UnInit, // 未初始化
    Ready, // 准备运行
    Running, // 正在运行
    Exited, // 已退出
};

struct TaskContext
{
    uint64_t ra;
    uint64_t sp;
    uint64_t x[12];
};

struct TaskControlBlock
{
    struct TaskContext task_cx;
    enum TaskStatus task_status;
    MemorySet memory_set;
    PhysPageNum trap_cx_ppn;
    size_t base_size;
};

struct TaskManager
{
    TaskControlBlock tasks[MAX_APP_NUM];
    uint64_t current_task;
    uint64_t num_app;
};


extern struct TaskManager TASK_MANAGER;


void task_manager_init(void);
void run_next_task(uint64_t status);
void run_first_task(void);
void init_taskcontrolblock(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size,uint64_t app_id);
uint64_t task_manager_get_current_token();
uint64_t get_user_token(struct TaskControlBlock *s);

void task_control_block_new(uint8_t *elf_data, size_t elf_size, uint64_t app_id,
                            struct TaskControlBlock *s);

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s);
#endif
