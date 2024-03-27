#include "task.h"
struct TaskManager task_manager;

void init_TaskManager() 
{
    task_manager.num_task = MAX_APP_NUM;
    task_manager.current_task = 0;
    for (int i = 0; i < MAX_APP_NUM; i++)
    {
        task_manager.tasks[i].task_cx.ra = (uint64_t)__restore;
        //task_manager.tasks[i].task_cx.sp = init_app_cx(i);
        for (int j = 0; j < 12; j++)
        {
            task_manager.tasks[i].task_cx.x[j] = 0;
        }
        task_manager.tasks[i].task_status = Ready;
    }
}