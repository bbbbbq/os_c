#ifndef TASK_H
#define TASK_H
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
struct TaskContext;
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
    struct TaskContext *task_cx_ptr;   // 指出了应用地址空间中的 Trap 上下文（详见第四章）被放在的物理页帧的物理页号
    enum TaskStatus task_status;       // 任务状态
    MemorySet memory_set;              // 应用地址空间
    PhysPageNum trap_cx_ppn;           // 陷阱上下文物理页号
    uint64_t base_size;                // 应用数据仅有可能出现在应用地址空间低于 base_size 字节的区域中。借助它我们可以清楚的知道应用有多少数据驻留在内存中。
    uint64_t priority;                 // 任务优先级
    uint64_t stride;                   // 任务步幅
    PidHandle pid;                     // 进程标识符句柄
    int32_t exit_code;                 // 退出码
    struct TaskControlBlock* parent;   // 指向父任务控制块的指针
    struct vector children;            // 存储子任务控制块的动态数组
};

struct TaskManager
{
    struct TaskControlBlock tasks[MAX_APP_NUM];
    uint64_t current_task;
    uint64_t num_app;
};


extern struct TaskManager TASK_MANAGER;


void task_manager_init(void);
void run_next_task(uint64_t status);
uint64_t task_manager_get_current_token();
uint64_t get_user_token(struct TaskControlBlock *s);

void task_control_block_new(uint8_t *elf_data, size_t elf_size, uint64_t app_id,
                            struct TaskControlBlock *s);

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s);
enum TaskStatus get_status(struct TaskControlBlock* self);
void task_exit_current_and_run_next();
struct TrapContext *task_current_trap_cx();
int is_zombie(struct TaskControlBlock* self);
uint64_t getpid(struct TaskControlBlock* self);

void task_context_zero_init(struct TaskContext *cx);
uint64_t task_control_block_get_user_token(struct TaskControlBlock *s);
#endif
