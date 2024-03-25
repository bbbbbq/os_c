#include "console.h"
#include "stdint.h"
#include "batch.h"
#include "debug.h"
extern uint64_t* _num_app;


uint8_t kernel_stack[KERNEL_STACK_SIZE];
uint8_t user_stack[USER_STACK_SIZE];


struct AppManager
{
    uint64_t app_num;
    uint64_t current_idx;
    uint8_t* APPS_START[MAX_APPS_NUM];
    uint8_t* APPS_END[MAX_APPS_NUM];
};
struct AppManager appmanager;

// void set_sepc_to_app_start(uint64_t app_idx) 
// {
//     uint64_t start_address = (uint64_t)appmanager.APPS_START[app_idx];
//     asm volatile ("csrw sepc, %0" :: "r"(start_address));
// }
// void set_sepc_to_app_start(uint64_t app_idx);

void init_app()
{
    print_str("init_app\n");
    print_str("Number of apps: ");
    print_uint64((uint64_t)*(&(_num_app)));  // 解引用 _num_app 来获取它指向的值
    print_str("\n");
    // 打印 _num_app 变量本身的地址
    // print_str("_num_app address: 0x");
    // print_str("\n");
    appmanager.current_idx = 0;
    appmanager.app_num = (uint64_t)*(&_num_app);
    // print_str("\n\n appmanager : ");
    // print_uint64(appmanager.app_num);
    // print_str("\n\n");
    uint64_t* app_information = &_num_app + 1;
    for (uint32_t i = 0; i < appmanager.app_num; i++) 
    {
        appmanager.APPS_START[i] = (void*)(uintptr_t)*app_information++;
        appmanager.APPS_END[i] = (void*)(uintptr_t)*app_information++;
        print_str("App ");
        print_uint32(i);
        print_str(" Start: 0x");
        print_uint64((uintptr_t)appmanager.APPS_START[i]);
        print_str(", End: 0x");
        print_uint64((uintptr_t)appmanager.APPS_END[i]);
        print_str("\n");
    }
    asm volatile ("fence.i");
    print_str("init_app end\n");
    
    set_sepc_to_app_start();
    asm volatile("sret");
}

void run_next_app() 
{
    if (appmanager.current_idx + 1 < appmanager.app_num) 
    {
        appmanager.current_idx++;
    } else 
    {
        print_str("No more apps to run. Resetting to first app.\n");
        appmanager.current_idx = 0;
        ASSERT(0);
    }
    uintptr_t start_addr = (uintptr_t)appmanager.APPS_START[appmanager.current_idx];
    asm volatile ("csrw sepc, %0" : : "r"(start_addr));
    asm volatile("sret");
}
// void clear_memory(uint64_t app_idx)
// {
//     if(app_idx >= MAX_APPS_NUM) 
//     {
//         print_str("exceed app nums :");
//         print_uint64(app_idx);
//         print_str("\n");
//         ASSERT(0);
//     }
//     uint8_t* start = appmanager.APPS_START[app_idx];
//     uint8_t* end   = appmanager.APPS_END[app_idx];
//     uint64_t app_memory = start - end;
//     if(app_memory>APP_MEMORY_LIMII)
//     {
//         print_str("app_idx:");
//         print_uint64(app_idx);
//         print_str("exceen memory limit \n");
//         ASSERT(0);
//     }
//     for(int i=0;i<=app_memory;i++)
//     {
//         uint8_t* current_memory = start + i;
//         *current_memory = 0;
//     }
// }

// void load_app(uint64_t app_idx)
// {
//     print_str("load_app\n");
//     if(app_idx >= MAX_APPS_NUM)
//     {
//         ASSERT(0);
//     }
//     uint8_t* start = appmanager.APPS_START[app_idx];
//     uint8_t* end   = appmanager.APPS_END[app_idx];
//     uint64_t app_mem = end - start;
//     for(int i = 0; i <= app_mem; i++)
//     {
//         // 强制类型转换
//         uint8_t* current_mem = (uint8_t *)(uintptr_t)(APP_ADDR_BASE + i);
//         *(current_mem) = *(start + i);
//     }
// }

void set_sepc_to_app_start() 
{
    print_str("set_sepc_to_app_start\n");
    uintptr_t sstatus;
    asm volatile("csrr %0, sstatus" : "=r"(sstatus)); // 读取当前sstatus寄存器的值
    sstatus &= ~SSTATUS_SPP; 
    sstatus |= SSTATUS_SPIE; 
    asm volatile("csrw sstatus, %0" : : "r"(sstatus)); // 更新sstatus寄存器的值
    uint64_t start_address = (uint64_t)appmanager.APPS_START[appmanager.current_idx];
    asm volatile (
    "csrw sepc, %0" 
    : 
    : "rK"(start_address)
    );
    print_str("set_sepc_to_app_start  end \n");
}

uintptr_t get_kernel_stack_top() 
{
    return (uintptr_t)&kernel_stack + KERNEL_STACK_SIZE;
}

uintptr_t get_user_stack_top() 
{
    return (uintptr_t)&user_stack + USER_STACK_SIZE;
}