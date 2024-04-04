#include "task.h"
#include "stdint.h"
#include "stack.h"
#include "context.h"
#include "batch.h"
#include "debug.h"
#include "string.h"
struct TaskManager task_manager;
extern void __switch(struct TaskContext*,struct TaskContext*);
extern uint64_t _num_app[];

void task_manager_init( void )
{

    extern void __restore(uint64_t);
    print_str("[Test] __restore: ");
    print_uint64((uint64_t)__restore);
    print_str("\n");
    task_manager.num_task = MAX_APP_NUM;
    task_manager.current_task = 0;

    // 初始化TCB
    for(uint64_t i = 0; i < app_manager.app_num; i ++)
    {

        // 获取kernel_stack压入TrapContext后的地址
        uint64_t target_sp = get_kernel_stack_top(i) - sizeof(struct TrapContext);
        task_manager.tasks[i].task_status = Ready; // 设置app状态
        task_manager.tasks[i].task_cx.ra = (uint64_t)__restore; // 设置switch函数返回地址
        task_manager.tasks[i].task_cx.sp = target_sp; // 设置各自kernel_stack位置

        /* 初始化kernel_stack */
        struct TrapContext tc = {
            {0},
            0,
            0
        };
        tc.sepc = APP_BASE_ADDRESS + (APP_SIZE_LIMIT * i); // 设置app首次进入的地址
        tc.sstatus = READ_CSR(sstatus) & (~SSTATUS_SPP); // 设置sstatus寄存器为内核状态
        tc.x[2] = (uint64_t)get_user_stack_top(i); // 保证sscratch指向user_stack
        // 将TrapContext压入kernel_stack
        *(struct TrapContext *)target_sp = tc;
    }
}


void run_next_task(uint64_t status) 
{
    /* 寻找ready的task */
    uint64_t target_task_num;
    for (target_task_num = (task_manager.current_task + 1) % MAX_APP_NUM; target_task_num != task_manager.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
        if (task_manager.tasks[target_task_num].task_status == Ready) {
            break;
        }
    }
    // 没有ready的任务
    if ((target_task_num == task_manager.current_task) && (task_manager.tasks[target_task_num].task_status != Ready)) {
        ASSERT(0);
    }

    struct TaskControlBlock* target_task_tcb = &task_manager.tasks[target_task_num];
    struct TaskControlBlock* current_task_tcb = &task_manager.tasks[task_manager.current_task];

    /* 改变状态 */
    current_task_tcb->task_status = status;
    target_task_tcb->task_status = Running;
    task_manager.current_task = target_task_num;

    /* 交换TaskContext */
    __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
}


void run_first_task(void) 
{
    static struct TaskContext temp;
    task_manager.tasks[task_manager.current_task].task_status = Running;
    print_str("[kernel] ready to run first app\n");
    __switch(&temp, &task_manager.tasks[task_manager.current_task].task_cx);
    ASSERT(0);
}