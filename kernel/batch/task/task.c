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
struct TaskManager TASK_MANAGER;
extern void __switch(struct TaskContext**,struct TaskContext**);
extern uint64_t _num_app[];

void task_manager_init()
{
   TASK_MANAGER.num_app = loader_get_num_app();
  for (unsigned i = 0; i < TASK_MANAGER.num_app; i++) 
  {
    task_control_block_new(loader_get_app_data(i), loader_get_app_size(i), i,
                           &TASK_MANAGER.tasks[i]);
  }
  //printk("task_manager_init_end\n");
  TASK_MANAGER.current_task = 0;
}


void run_next_task(uint64_t status) 
{
    // 寻找ready的task
    uint64_t target_task_num;
    for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
        if (TASK_MANAGER.tasks[target_task_num].task_status == Ready) {
            break;
        }
    }
    // 没有ready的任务
    if ((target_task_num == TASK_MANAGER.current_task) && (TASK_MANAGER.tasks[target_task_num].task_status != Ready)) {
        ASSERT(0);
    }

    struct TaskControlBlock* target_task_tcb = &TASK_MANAGER.tasks[target_task_num];
    struct TaskControlBlock* current_task_tcb = &TASK_MANAGER.tasks[TASK_MANAGER.current_task];

    // 改变状态
    current_task_tcb->task_status = status;
    target_task_tcb->task_status = Running;
    TASK_MANAGER.current_task = target_task_num;
    __switch(&(current_task_tcb->task_cx_ptr), &(target_task_tcb->task_cx_ptr));
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



void task_control_block_new(uint8_t *elf_data, size_t elf_size, uint64_t app_id,
                            struct TaskControlBlock *s) 
{
  // memory_set with elf program headers/trampoline/trap context/user stack
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
                      &entry_point);
  PhysPageNum trap_cx_ppn = pte_ppn(*memory_set_translate(
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // map a kernel-stack in kernel space
  uint64_t kernel_stack_bottom = kernel_stack_position_bottom(app_id);
  uint64_t kernel_stack_top = kernel_stack_position_top(app_id);
  kernel_space_insert_framed_area((VirtAddr)kernel_stack_bottom,
                                  (VirtAddr)kernel_stack_top,
                                  MAP_PERM_R | MAP_PERM_W);

  struct TaskContext *task_cx_ptr =
      (struct TaskContext *)(kernel_stack_top - sizeof(struct TaskContext));
  task_context_goto_trap_return(task_cx_ptr);

  s->task_cx_ptr = task_cx_ptr;
  s->task_status = Ready;
  s->trap_cx_ppn = trap_cx_ppn;
  s->base_size = user_sp;

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = get_trap_cx(s);
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
                   (uint64_t)trap_handler, trap_cx);
  s->priority = DEFAULT_PRIORITY;
  s->stride = 0;

//   if(app_id==0)
//   {
//   printk("TrapContext values:\n");
// for (int i = 0; i < 32; i++) {
//     printk("x[%d] = 0x%lx%08lx\n", i,
//            (unsigned long)(trap_cx->x[i] >> 32),
//            (unsigned long)(trap_cx->x[i] & 0xFFFFFFFF));
// }
// printk("sstatus = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->sstatus >> 32),
//        (unsigned long)(trap_cx->sstatus & 0xFFFFFFFF));
// printk("sepc = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->sepc >> 32),
//        (unsigned long)(trap_cx->sepc & 0xFFFFFFFF));
// printk("kernel_satp = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->kernel_satp >> 32),
//        (unsigned long)(trap_cx->kernel_satp & 0xFFFFFFFF));
// printk("kernel_sp = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->kernel_sp >> 32),
//        (unsigned long)(trap_cx->kernel_sp & 0xFFFFFFFF));
// printk("trap_handler = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->trap_handler >> 32),
//        (unsigned long)(trap_cx->trap_handler & 0xFFFFFFFF));
//   }
}

struct TrapContext *task_current_trap_cx()
{
  return task_manager_get_current_trap_cx();
}

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s) 
{
  return (struct TaskContext **)(&(s->task_cx_ptr));
}