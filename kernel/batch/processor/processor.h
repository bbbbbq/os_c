#ifndef PROCESSOR_H
#define PROCESSOR_H
#include "task.h"
#include "taskmanager.h"
typedef struct {
  struct TaskControlBlock *current;
  struct TaskContext idle_task_cx;
} Processor;
extern Processor PROCESSOR;
uint64_t processor_current_user_token();
void processor_init(Processor *processor);
struct TaskControlBlock *processor_take_current(Processor *processor);
struct TaskContext *processor_get_idle_task_cx_ptr(Processor *processor);
struct TaskControlBlock *processor_current_task();
void processor_run_tasks();
#endif