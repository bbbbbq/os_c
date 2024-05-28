#ifndef PROCESSOR_H
#define PROCESSOR_H
#include "task.h"
#include "taskmanager.h"
typedef struct
{
  struct TaskControlBlock *current;
  struct TaskContext idle_task_cx;
} Processor;
extern Processor PROCESSOR;
struct TaskControlBlock *processor_current_task();
uint64_t processor_current_user_token();
void processor_init(Processor *processor);
struct TaskControlBlock *processor_take_current(Processor *processor);
struct TaskContext *processor_get_idle_task_cx_ptr(Processor *processor);
struct TaskControlBlock *processor_current_task();
void processor_run_tasks();
struct TrapContext *processor_current_trap_cx();
void processor_schedule(struct TaskContext *switched_task_cx_ptr);
struct TaskControlBlock *processor_take_current_task();
#endif