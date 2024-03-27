#ifndef TASK_H
#define TACK_H
#include "batch.h"
#include "stdint.h"
extern void __restore();
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

void init_TaskManager();
#endif