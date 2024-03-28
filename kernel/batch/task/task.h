#ifndef TASK_H
#define TACK_H
#include "batch.h"
#include "stdint.h"

enum TaskStatus 
{
    UnInit, // 未初始化
    Ready, // 准备运行
    Running, // 正在运行
    Exited, // 已退出
};

struct TaskContext
{
    uint64_t x[12];
    uint64_t ra;
    uint64_t sp;
};

struct TaskControlBlock
{
    struct TaskContext task_cx;
    enum TaskStatus task_status;
};

struct TaskManager
{
    uint64_t num_task;
    uint64_t current_task;
    struct TaskControlBlock tasks[MAX_APP_NUM];
};

extern struct TaskManager task_manager; 

struct TaskContext init_TaskContext(uint64_t task_id);

struct TaskControlBlock init_TaskControlBlock(uint64_t task_id);

void init_TaskManager();

void run_first_task();

struct TaskContext init_zero_TaskContext();

// void suspend_current_and_run_next();

// void mark_current_suspended();

void mark_current_exited();

// int64_t find_next_task();

// void run_next_task_u2u();

// void run_next_task_s2u();

void mark_current_ready();
#endif