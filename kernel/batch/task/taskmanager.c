#include "taskmanager.h"
TaskManager_2 TASK_MANAGER_2;

void task_manager_init_2()
{
    TASK_MANAGER_2.ready_queue = createQueue();
}

void task_manager_add_2(TaskManager_2* manager, void* task) 
{
    queue_push(manager->ready_queue, task);
}

void* task_manager_fetch_2(TaskManager_2* manager) 
{
    return queue_pop(manager->ready_queue);
}


struct TaskControlBlock *task_manager_fetch_task() {
  return task_manager_fetch_2(&TASK_MANAGER_2);
}
