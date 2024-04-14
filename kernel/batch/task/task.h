#ifndef TASK_H
#define TASK_H
#include "stack.h"
#include "batch.h"
#include "stdint.h"
#include "mem.h"
#include "batch.h"
#include "config.h"
#include "pid.h"
#define MAX_APP_NUM 20
#define BIG_STRIDE 100000
#define MAX_APP_NAME_LENGTH 64
#define DEFAULT_PRIORITY 16



enum TaskStatus 
{
    UnInit, // 未初始化
    Ready, // 准备运行
    Running, // 正在运行
    Exited, // 已退出
    Zombie  //僵尸进程
};
struct TaskContext
{   
    uint64_t ra;
    uint64_t sp;
    uint64_t x[12];
};

struct TaskControlBlock
{
    PidHandle pid;
    struct KernelStack kernel_stack;
    PhysPageNum trap_cx_ppn;
    uint64_t base_size;
    struct TaskContext task_cx;
    enum TaskStatus task_status;
    MemorySet memory_set;
    struct TaskControlBlock *parent;
    struct vector children;
    int exit_code;

    // stride scheduling
    uint64_t priority;
    uint64_t stride;
};

struct TaskManager
{
    struct TaskControlBlock tasks[MAX_APP_NUM];
    uint64_t current_task;
    uint64_t num_app;
};

extern struct TaskManager TASK_MANAGER;
void taks_init();
void task_manager_add_2_initproc();
// void task_manager_init(void);
void run_next_task(uint64_t status);
uint64_t task_manager_get_current_token();
uint64_t get_user_token(struct TaskControlBlock *s);

void task_control_block_new(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size);

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s);
enum TaskStatus get_status(struct TaskControlBlock* self);
void task_exit_current_and_run_next();
struct TrapContext *task_current_trap_cx();
int is_zombie(struct TaskControlBlock* self);
uint64_t getpid(struct TaskControlBlock* self);

void task_context_zero_init(struct TaskContext *cx);
uint64_t task_control_block_get_user_token(struct TaskControlBlock *s);

struct TrapContext *task_control_block_get_trap_cx(struct TaskControlBlock *s);
#endif
