#include "taskmanager.h"
#include "mem.h"
#include "processor.h"
TaskManager_2 TASK_MANAGER_2;

void task_manager_init_2()
{
    TASK_MANAGER_2.ready_queue = bd_malloc(sizeof(Queue *));
    if(TASK_MANAGER_2.ready_queue == NULL) ASSERT(0);
    queue_init(TASK_MANAGER_2.ready_queue);
}

void task_manager_add_2(TaskManager_2* manager, void* task) 
{
    queue_enqueue(manager->ready_queue, task);
}

void* task_manager_fetch_2(TaskManager_2* manager) 
{
    return queue_dequeue(manager->ready_queue);
}


struct TaskControlBlock *task_manager_fetch_task() {
  return task_manager_fetch_2(&TASK_MANAGER_2);
}
struct TrapContext *processor_current_trap_cx() 
{
  struct TaskControlBlock *task = processor_current_task();
  return task_control_block_get_trap_cx(task);
}