#include "stack.h"
#include "string.h"
#include "stdint.h"
#include "batch.h"
#include "context.h"
#include "mem.h"
#include "pid.h"
// uint8_t UserStack[USER_STACK_SIZE];
// uint8_t Kernelstack[KERNEL_STACK_SIZE];
// uint8_t Trap_Stack[1024];
// uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
// uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];


// uint64_t get_kernel_stack_top( uint64_t app_id ) {
//     return (uint64_t)(Kernelstack[app_id]) + KERNEL_STACK_SIZE;
// }


// uint64_t get_user_stack_top( uint64_t app_id ) {
//     return (uint64_t)(UserStack[app_id]) + USER_STACK_SIZE;
// }


// uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
// {
//     uint8_t* stackTop = Kernelstack[task_id] + KERNEL_STACK_SIZE; // 指向栈顶
//     stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
//     *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
//     return stackTop; // 返回新的栈顶地址
// }

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top) 
{
    *top = TRAMPOLINE - app_id * (KERNEL_STACK_SIZE + PAGE_SIZE);
    *bottom = *top - KERNEL_STACK_SIZE;
}

void* kernel_stack_push_on_top(struct KernelStack stack, void* value)
{
    uint64_t kernel_stack_top = kernel_stack_get_top(stack);
    void* ptr = (void*)(kernel_stack_top - sizeof(void*));
    *(void**)ptr = value;
    return ptr;
}

uint64_t kernel_stack_get_top(struct KernelStack stack)
{
    uint64_t bottom, top;
    kernel_stack_position(stack.pid.pid, &bottom, &top);
    return top;
}

void kernel_stack_new(struct KernelStack *ks, PidHandle pid) {
  uint64_t kernel_stack_bottom = kernel_stack_position_bottom(pid.pid);
  uint64_t kernel_stack_top = kernel_stack_position_top(pid.pid);
  kernel_space_insert_framed_area(kernel_stack_bottom, kernel_stack_top,
                                  MAP_PERM_R | MAP_PERM_W);
  ks->pid = pid;
}


void kernel_stack_free(struct KernelStack* ks)
{
    VirtAddr kernel_stack_bottom_va =
      (VirtAddr)kernel_stack_position_bottom(ks->pid.pid);
    VirtPageNum kernel_stack_bottom_vpn = addr2pn(kernel_stack_bottom_va);
    kernel_space_remove_area_with_start_vpn(kernel_stack_bottom_vpn);
}
