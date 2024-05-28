#include "batch.h"
#include "console.h"
#include "string.h"
#include "debug.h"
#include "context.h"
#include "stack.h"
#include "loader.h"
#include "mem.h"
#include "task.h"
#include "processor.h"
extern struct TaskControlBlock FIRST_TASK;
struct AppManager app_manager;
extern struct TaskManager TASK_MANAGER;
extern struct TaskControlBlock INITPROC;
extern void trap_handler();
void init_appmanager()
{
  app_manager.app_num = _num_app[0];
  for (uint64_t i = 0; i < app_manager.app_num; i++)
  {
    app_manager.app_start[i] = _num_app[1 + i * 2];
    app_manager.app_end[i] = _num_app[2 + i * 2];
  }
  app_manager.current_app = 0;
  print_app_info(&app_manager);
}

void print_app_info(struct AppManager *manager)
{
  print_str("Total applications: ");
  print_uint64(manager->app_num);
  print_str("\n");

  for (uint64_t i = 0; i < manager->app_num; ++i)
  {
    print_str("App ");
    print_uint64(i);
    print_str(":\n  Start Address: ");
    print_uint64(manager->app_start[i]);
    print_str("\n  End Address:   ");
    print_uint64(manager->app_end[i]);
    print_str("\n");
  }
}

struct TrapContext *get_trap_cx(struct TaskControlBlock *s)
{
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
}

// void run_next_app()
// {
//     //print_str("run_next_app");
//     print_str("run_next_app : ");
//     print_uint64(app_manager.current_app);
//     print_str("\n");
//     app_manager.current_app++;
//     if(app_manager.current_app>=app_manager.app_num)
//     {
//         print_str("app execute over\n");
//         ASSERT(0);
//     }
//     uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
//     asm volatile ("fence.i");
//     struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
//     uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
//     //__restore(trapcontext);
//     __restore((uint64_t)cx);
// }

void run_first_app()
{
  extern void __switch(struct TaskContext * *current_task_cx_ptr2,
                       struct TaskContext * *next_task_cx_ptr2);
  TASK_MANAGER.tasks[0].task_status = Running;
  struct TaskContext **next_task_cx_ptr2 =
      get_task_cx_ptr2(&(TASK_MANAGER.tasks[0]));
  uint64_t _unused = 0;
  // printk("run_fisrt_app_end\n");
  __switch((struct TaskContext **)&_unused, next_task_cx_ptr2);
}

// void load_app_test()
// {
//       // Assume _num_app and related variables are defined elsewhere in your project
//     extern uint64_t _num_app[]; // Assuming this is an array holding app info
//     uint64_t num_app = _num_app[0]; // First element holds the number of apps
//     asm volatile("fence.i");
//     for (uint64_t i = 0; i < num_app; i++) {
//         // Calculate the start and end addresses of the app in memory
//         uint64_t app_start = _num_app[1 + i * 2];
//         uint64_t app_end = _num_app[2 + i * 2];
//         uint64_t app_size = app_end - app_start;
//         const void* src = (const void*)app_start;
//         void* dst = (void*)(APP_BASE_ADDRESS + 0x20000 * i);

//         print_str("[Test] Loading app from ");
//         print_uint64(app_start);
//         print_str(" to ");
//         print_uint64(app_end);
//         print_str("\n");

//         // Clear the application area and copy the new app into place
//         memset_t(dst, 0, 0x20000); // Ensure APP_MAX_SIZE covers the max possible app size
//         memcpy_t(dst, src, app_size);
//         // Instruction synchronization barrier to ensure all instructions are executed correctly
//         __asm__ volatile ("fence.i");
//     }
// }

struct TrapContext *task_manager_get_current_trap_cx()
{
  uint64_t current = TASK_MANAGER.current_task;
  return get_trap_cx(&TASK_MANAGER.tasks[current]);
}

void task_control_block_free(struct TaskControlBlock *s)
{
  memory_set_free(&s->memory_set);
}

void task_manager_mark_current_exited()
{
  uint64_t current = TASK_MANAGER.current_task;
  task_control_block_free(&TASK_MANAGER.tasks[current]);
  TASK_MANAGER.tasks[current].task_status = Exited;
}

int64_t task_manager_find_next_task()
{
  uint64_t num_app = TASK_MANAGER.num_app;
  uint64_t min_stride = __UINT64_MAX__;
  int64_t min_id = -1;
  uint64_t start_id = (TASK_MANAGER.current_task + 1) % num_app; // Start from the next task of the current task.
  uint64_t checked = 0;                                          // Number of tasks checked.

  for (uint64_t i = start_id; checked < num_app; i = (i + 1) % num_app)
  {
    if (TASK_MANAGER.tasks[i].task_status == Ready)
    {
      uint64_t current_stride = TASK_MANAGER.tasks[i].stride;
      if (current_stride < min_stride)
      {
        min_stride = current_stride;
        min_id = i;
        break; // Stop the loop once the first ready task is found.
      }
    }
    checked++;
  }

  return min_id;
}

void task_manager_run_next_task()
{
  extern void __switch(struct TaskContext * *current_task_cx_ptr2,
                       struct TaskContext * *next_task_cx_ptr2);
  int64_t next = task_manager_find_next_task();
  if (next >= 0)
  {
    uint64_t current = TASK_MANAGER.current_task;
    TASK_MANAGER.tasks[next].task_status = Running;
    uint64_t pass = BIG_STRIDE / TASK_MANAGER.tasks[next].priority;
    TASK_MANAGER.tasks[next].stride += pass;
    TASK_MANAGER.current_task = next;
    struct TaskContext **current_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[current]));
    struct TaskContext **next_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[next]));
    __switch(current_task_cx_ptr2, next_task_cx_ptr2);
  }
  else
  {
    mm_free();
    panic("All applications completed!\n");
  }
}

void task_exit_current_and_run_next(int exit_code)
{
  // take from Processor
  struct TaskControlBlock *task = processor_take_current_task();

  // Change status to Zombie
  task->task_status = Zombie;

  // Record exit code
  task->exit_code = exit_code;
  // do not move to its parent but under initproc

  struct TaskControlBlock **x = (struct TaskControlBlock **)(task->children.buffer);
  for (uint64_t i = 0; i < task->children.size; i++)
  {
    x[i]->parent = &FIRST_TASK;
    vector_push(&FIRST_TASK.children, x[i]);
  }
  vector_free(&task->children);

  // deallocate user space
  memory_set_recycle_data_pages(&task->memory_set);

  // deallocate kernel stack
  kernel_stack_free(&task->kernel_stack);

  // we do not have to save task context
  struct TaskContext _unused;
  task_context_zero_init(&_unused);
  processor_schedule(&_unused);
}

void task_manager_mark_current_suspended()
{
  uint64_t current = TASK_MANAGER.current_task;
  TASK_MANAGER.tasks[current].task_status = Ready;
}

void task_suspend_current_and_run_next()
{
  struct TaskControlBlock *task = processor_current_task();
  struct TaskContext *task_cx_ptr = &task->task_cx;
  task->task_status = Ready;
  task_manager_add_2(&TASK_MANAGER_2, task);
  processor_schedule(task_cx_ptr);
}

struct TaskControlBlock *task_control_block_fork(struct TaskControlBlock *parent)
{
  struct TaskControlBlock *s = (struct TaskControlBlock *)bd_malloc(sizeof(struct TaskControlBlock));

  // copy user space (include trap context)
  memory_set_from_existed_user(&s->memory_set, &parent->memory_set);
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // alloc a pid and a kernel stack in kernel space
  s->pid = PidAllocator_alloc();
  kernel_stack_new(&s->kernel_stack, s->pid);
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);

  s->base_size = parent->base_size;
  task_context_goto_trap_return(&s->task_cx, kernel_stack_top);
  s->task_status = Ready;
  s->parent = parent;
  vector_new(&s->children, sizeof(struct TaskControlBlock *));
  s->exit_code = 0;

  s->priority = parent->priority;
  s->stride = parent->stride;

  // add child
  vector_push(&parent->children, &s);

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
  trap_cx->kernel_sp = kernel_stack_top;

  return s;
}

void task_control_block_exec(struct TaskControlBlock *s, uint8_t *elf_data,
                             size_t elf_size, char **args, uint64_t argc)
{
  // memory_set with elf program headers/trampoline/trap context/user stack
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_free(&s->memory_set);

  // substitute memory_set
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
                      &entry_point);
  // 压入argv
  user_sp -= (argc + 1) * sizeof(char *);

  // update trap_cx ppn
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // initialize trap_cx
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
                   (uint64_t)trap_handler, trap_cx);
}
