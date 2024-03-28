#include "task.h"
#include "stdint.h"
#include "stack.h"
#include "context.h"
#include "batch.h"
#include "debug.h"
struct TaskManager task_manager;
extern void __restore(uint64_t);
extern void __switch(struct TaskContext*,struct TaskContext*);
extern uint64_t _num_app[];

struct TaskContext init_TaskContext(uint64_t task_id)
{
    struct TaskContext task_context;
    task_context.ra = (uint64_t) __restore;
    struct TrapContext trap_context = app_init_context(app_manager.app_start[task_id],(uint64_t)get_kernel_sp(Kernelstack[task_id]));
    task_context.sp = (uint64_t)Kernelstack_push_TrapContext(trap_context,task_id);
    for(int i=0;i<12;i++)
    {
        task_context.x[i]=0;
    }
    return task_context;
}

struct TaskControlBlock init_TaskControlBlock(uint64_t task_id)
{
    struct TaskControlBlock task_block;
    task_block.task_status = Ready;
    task_block.task_cx = init_TaskContext(task_id);
    return task_block;
}
void init_TaskManager() 
{
    task_manager.num_task = _num_app[0];
    task_manager.current_task = 0;
    
    print_str("Initializing Task Manager with ");
    print_uint64(task_manager.num_task);
    print_str(" tasks.\n");
    
    for(int i = 0; i < task_manager.num_task; i++) {
        task_manager.tasks[i] = init_TaskControlBlock(i);
        print_str("Task ");
        print_uint64(i);
        print_str(" initialized with status: ");
        print_uint64(task_manager.tasks[i].task_status); // 假设status是一个可以直接打印的uint64_t类型
        print_str("\n");
    }
}

void mark_current_suspended() 
{
    task_manager.tasks[task_manager.current_task].task_status = Ready;
}


void mark_current_exited()
{
    task_manager.tasks[task_manager.current_task].task_status = Exited;
}

int64_t find_next_task() 
{
    uint64_t start = task_manager.current_task + 1;
    for (uint64_t i = 0; i < task_manager.num_task; ++i) 
    {
        uint64_t index = (start + i) % task_manager.num_task;
        if (task_manager.tasks[index].task_status == Ready) 
        {
            task_manager.current_task = index;
            return index;
        }
    }
    return -1; // 没有找到Ready任务，返回一个无效值
}
//一直在用户态
void suspend_current_and_run_next()
{
    mark_current_suspended();
    task_manager.current_task++;
    uint64_t pre_id = task_manager.current_task;
    uint64_t next_task = find_next_task();
    if (next_task < task_manager.num_task)
    {
        task_manager.current_task = next_task;
        // sTrapContext* cx = 
        __switch(&task_manager.tasks[pre_id].task_cx,&task_manager.tasks[next_task].task_cx);
    }else
    {
        print_str("task completed\n");
    }
}

struct TaskContext init_zero_TaskContext()
{
    struct TaskContext cx;
    for(int i=0;i<12;i++) cx.x[i]=0;
    cx.ra=0;
    cx.sp=0;
    return cx;
}

void run_next_task_u2u()
{
    mark_current_exited();
    uint64_t current_idx = task_manager.current_task;
    if(current_idx>=task_manager.num_task)
    {
        print_str("app execure voer\n");
        ASSERT(0);
    }
    int64_t next_app_idx = find_next_task();
    if(next_app_idx == -1)
    {
        print_str("all task is not ready\n");
        ASSERT(0);
    }
    task_manager.tasks[current_idx].task_status = Exited;
    task_manager.tasks[next_app_idx].task_status = Running;
    //__restore();
    __switch(&task_manager.tasks[current_idx].task_cx,&task_manager.tasks[next_app_idx].task_cx);
}


void run_first_task()
{
    task_manager.tasks[0].task_status = Running;
    struct TaskContext cx_zero = init_zero_TaskContext();
    __switch(&cx_zero,&task_manager.tasks[0].task_cx);
    //run_first_app();    
}


// void run_next_task_s2u()
// {
//     task_manager.tasks[task_manager.current_task].task_status = Ready;
//     int64_t next_app_idx = find_next_task();
//     if(next_app_idx == -1)
//     {
//         print_str("all task is not ready\n");
//         ASSERT(0);
//     }
//     task_manager.tasks[current_idx].task_status = Exited;
//     task_manager.tasks[next_app_idx].task_status = Running;
//     //__restore();
//     __switch(&task_manager.tasks[current_idx].task_cx,&task_manager.tasks[next_app_idx].task_cx);
// }

// void mark_current_ready()
// {
//     task_manager.tasks[task_manager.current_task].task_status = Ready;
// }

// void suspend_current_and_run_next_s2u()
// {
//     mark_current_ready();
//     uint64_t next_idx = find_next_task();
//     struct TaskContext cur_cx = task_manager.tasks[task_manager.current_task].task_cx;
//     struct TaskContext next_cx = task_manager.tasks[next_idx].task_cx;

// }