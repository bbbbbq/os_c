#include "task.h"
#include "stdint.h"
#include "stack.h"
#include "context.h"
#include "batch.h"
#include "debug.h"
#include "string.h"
#include "mem.h"
#include "trap.h"
#include "loader.h"
#include "taskmanager.h"
struct TaskManager TASK_MANAGER;
struct TaskControlBlock INITPROC;
extern void __switch(struct TaskContext **, struct TaskContext **);
extern uint64_t _num_app[];

struct TrapContext *task_control_block_get_trap_cx(struct TaskControlBlock *s)
{
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
}

// void task_manager_init()
// {
//    TASK_MANAGER.num_app = loader_get_num_app();
//   for (unsigned i = 0; i < TASK_MANAGER.num_app; i++)
//   {
//     task_control_block_new(loader_get_app_data(i), loader_get_app_size(i), i,
//                            &TASK_MANAGER.tasks[i]);
//   }
//   //printk("task_manager_init_end\n");
//   TASK_MANAGER.current_task = 0;
// }

void run_next_task(uint64_t status)
{
  ASSERT(0);
  // // 寻找ready的task
  // uint64_t target_task_num;
  // for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
  //     if (TASK_MANAGER.tasks[target_task_num].task_status == Ready) {
  //         break;
  //     }
  // }
  // // 没有ready的任务
  // if ((target_task_num == TASK_MANAGER.current_task) && (TASK_MANAGER.tasks[target_task_num].task_status != Ready)) {
  //     ASSERT(0);
  // }

  // struct TaskControlBlock* target_task_tcb = &TASK_MANAGER.tasks[target_task_num];
  // struct TaskControlBlock* current_task_tcb = &TASK_MANAGER.tasks[TASK_MANAGER.current_task];

  // // 改变状态
  // current_task_tcb->task_status = status;
  // target_task_tcb->task_status = Running;
  // TASK_MANAGER.current_task = target_task_num;
  // __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
}

// void run_first_task(void)
// {
//     static struct TaskContext temp;
//     TASK_MANAGER.tasks[TASK_MANAGER.current_task].task_status = Running;
//     print_str("[kernel] ready to run first app\n");
//     __switch(&temp, &TASK_MANAGER.tasks[TASK_MANAGER.current_task].task_cx_ptr);
//     ASSERT(0);
// }

uint64_t task_manager_get_current_token()
{
  uint64_t current = TASK_MANAGER.current_task;
  return get_user_token(&TASK_MANAGER.tasks[current]);
}

uint64_t get_user_token(struct TaskControlBlock *s)
{
  return memory_set_token(&s->memory_set);
}

void task_control_block_new(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size)
{
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
                      &entry_point);
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  s->pid = PidAllocator_alloc();
  kernel_stack_new(&s->kernel_stack, s->pid);
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);

  // push a task context which goes to trap_return to the top of kernel stack
  s->base_size = user_sp;
  task_context_goto_trap_return(&s->task_cx, kernel_stack_top);
  s->task_status = Ready;
  s->parent = NULL;
  vector_new(&s->children, sizeof(struct TaskControlBlock *));
  s->exit_code = 0;

  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
                   (uint64_t)trap_handler, trap_cx);
  s->user_pace_size = s->base_size;
  s->priority = DEFAULT_PRIORITY;
  s->stride = 0;
  queue_init(&s->inode_table_index);
  Inode inode;
  queue_enqueue(&s->inode_table_index, &inode);
  queue_enqueue(&s->inode_table_index, &inode);
  queue_enqueue(&s->inode_table_index, &inode);
  memset(s->pwd, 0, sizeof(s->pwd));
  s->sys_times = 0;
  s->user_times = 0;
}

struct TrapContext *task_current_trap_cx()
{
  return task_manager_get_current_trap_cx();
}

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s)
{
  return (struct TaskContext **)(&(s->task_cx));
}

enum TaskStatus get_status(struct TaskControlBlock *self)
{
  return self->task_status;
}

int is_zombie(struct TaskControlBlock *self)
{
  return get_status(self) == Zombie;
}

uint64_t getpid(struct TaskControlBlock *self)
{
  return self->pid.pid;
}

void task_context_zero_init(struct TaskContext *cx)
{
  cx->ra = 0;
  cx->sp = 0;
  for (int i = 0; i < 12; i++)
  {
    cx->x[i] = 0;
  }
}

uint64_t task_control_block_get_user_token(struct TaskControlBlock *s)
{
  return memory_set_token(&s->memory_set);
}

void taks_init()
{
  PidAllocator_init(&PID_ALLOCATOR);
  task_manager_init_2();
  task_control_block_new(&INITPROC, loader_get_app_data_by_name("initproc"),
                         loader_get_app_size_by_name("initproc"));
}

void task_manager_add_2_initproc()
{
  task_manager_add_2(&TASK_MANAGER_2, &INITPROC);
}