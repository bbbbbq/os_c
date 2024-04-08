#ifndef TASK_H
#define TACK_H
#include "batch.h"
#include "stdint.h"
#include "mem.h"
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
    uint64_t num_task;
    uint64_t current_task;
    struct TaskControlBlock tasks[MAX_APP_NUM];
};

extern struct TaskManager task_manager; 

void task_manager_init(void);
void run_next_task(uint64_t status);
void run_first_task(void);
void init_taskcontrolblock(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size,uint64_t app_id);
uint64_t task_manager_get_current_token();
uint64_t get_user_token(struct TaskControlBlock *s);
#endif
