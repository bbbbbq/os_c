#include "processor.h"

#include "task.h"

Processor PROCESSOR;

extern void __switch(struct TaskContext *current_task_cx_ptr,
                     struct TaskContext *next_task_cx_ptr);


void processor_init(Processor *processor) 
{
  processor->current = NULL;
  task_context_zero_init(&processor->idle_task_cx);
}

struct TaskControlBlock *processor_take_current(Processor *processor) {
  return processor->current;
}


struct TaskContext *processor_get_idle_task_cx_ptr(Processor *processor) {
  return &processor->idle_task_cx;
}


uint64_t processor_current_user_token() {
  struct TaskControlBlock *task = processor_current_task();
  return task_control_block_get_user_token(task);
}



struct TaskControlBlock *processor_current_task() {
  return processor_current_task(&PROCESSOR);
}


void processor_run_tasks() 
{
  processor_init(&PROCESSOR);
  struct TaskControlBlock *task;
  struct TaskContext *idle_task_cx_ptr;
  struct TaskContext *next_task_cx_ptr;
  while (1) {
    task = task_manager_fetch_task();
    if (task) {
      idle_task_cx_ptr = processor_get_idle_task_cx_ptr(&PROCESSOR);
      next_task_cx_ptr = &task->task_cx;
      task->task_status = Running;
      PROCESSOR.current = task;
      __switch(idle_task_cx_ptr, next_task_cx_ptr);
    }
  }
}