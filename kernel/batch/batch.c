#include "batch.h"
#include "trap.h"
#include "debug.h"
#include "console.h"
#include "string.h"
#include "stdint.h"
static appmanager app_manager;
extern uint64_t app_0_start, app_1_start, app_2_start;
extern uint64_t app_0_end, app_1_end, app_2_end;
uint64_t* app_starts[MAX_APP_NUM] = {&app_0_start, &app_1_start, &app_2_start};
uint64_t* app_ends[MAX_APP_NUM] = {&app_0_end, &app_1_end, &app_2_end};

void init_app_manager()
{
    
}

static inline uint64_t r_sstatus(void) 
{
    uint64_t value;
    asm volatile ("csrr %0, sstatus" : "=r"(value));
    return value;
}

uint64_t get_kernel_stack_top(void) 
{
    return (uint64_t)(kernel_stack) + KERNEL_STACK_SIZE;
}

uint64_t get_user_stack_top(void) 
{
    return (uint64_t)(user_stack) + KERNEL_STACK_SIZE;
}

void load_app(void) 
{
    uint64_t *num_app_ptr = (uint64_t *)_num_app;
    // app数量
    uint64_t num_app = *_num_app;
    _num_app ++; // 现在num_app_ptr是app文件起始位置

    // 刷新缓冲区
    asm volatile("fence.i");

    for(uint64_t i = 0; i < num_app; i ++)
    {
        uint8_t *app_addr;
        app_addr = (uint8_t *)(APP_BASE_ADDRESS + APP_MAX_SIZE * i);
        print_str("[Test] loader: app 0x");
        print_uint32(num_app_ptr[i]);
        print_str(" - 0x");
        print_uint32(num_app_ptr[i + 1]);
        print_str("\n");
        for(uint8_t *target = (uint8_t *)num_app_ptr[i]; (uint64_t)target <= (uint64_t)num_app_ptr[i + 1]; target ++, app_addr ++){
            *app_addr = *target;
        }
    }
}


void run_app() {

    if(current_app >= *(uint64_t *)_num_app){
        print_str("all app execed");
        ASSERT(0);
    }

    /* 设置tc，准备传给app */
    const uint64_t sstatus = r_sstatus();
    static TrapContext tc = {
        {0},
        0,
        0
    };
    tc.sepc = APP_BASE_ADDRESS + (APP_MAX_SIZE * current_app);
    current_app ++;
    tc.sstatus = sstatus & (~SSTATUS_SPP);
    tc.x_regs[2] = get_user_stack_top(); // 保证sscratch指向user_stack
    uint64_t store_posi = get_kernel_stack_top() - sizeof(TrapContext);
    *(TrapContext *)store_posi = tc;
    extern void __restore(TrapContext *cx);
    __restore(&tc);
}