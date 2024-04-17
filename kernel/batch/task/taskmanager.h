#ifndef TASKMANAGER_H
#define TASKMANAGER_H
#include "queue.h"
typedef struct {
    Queue* ready_queue;
} TaskManager_2;

extern TaskManager_2 TASK_MANAGER_2;
void task_manager_init_2();
void task_manager_add_2(TaskManager_2* manager, void* task);
void *task_manager_fetch_2(TaskManager_2 *manager);
struct TaskControlBlock *task_manager_fetch_task();

#endif