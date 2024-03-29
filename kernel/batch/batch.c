#include "batch.h"
#include "console.h"
#include "string.h"
#include "debug.h"
#include "context.h"
#include "stack.h"


struct AppManager app_manager;


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

void load_app(uint64_t app_id)
{
    if (app_id >= app_manager.app_num) 
    {
        ASSERT(0);
        return;
    }
    print_str("[kernel] Loading app_");
    print_uint64(app_id);
    print_str("\n");
    // 清空应用程序区域
    memset_t((void*)APP_BASE_ADDRESS, 0, APP_SIZE_LIMIT);

    // 计算应用程序的大小
    uintptr_t app_size;
    if (app_id < app_manager.app_num - 1) 
    {
        app_size = app_manager.app_start[app_id] - app_manager.app_end[app_id];
    } else 
    {
        app_size = APP_SIZE_LIMIT;
    }
    // 获取应用程序源地址和目标地址
    const void* src = (const void*)app_manager.app_start[app_id];
    void* dst = (void*)APP_BASE_ADDRESS;
    
    memcpy_t(dst, src, app_size);
    __asm__ volatile ("fence.i");
}



void print_app_info(struct AppManager *manager) {
    print_str("Total applications: ");
    print_uint64(manager->app_num);
    print_str("\n");

    for (uint64_t i = 0; i < manager->app_num; ++i) {
        print_str("App ");
        print_uint64(i);
        print_str(":\n  Start Address: ");
        print_uint64(manager->app_start[i]);
        print_str("\n  End Address:   ");
        print_uint64(manager->app_end[i]);
        print_str("\n");
    }
}

void run_next_app()
{
    //print_str("run_next_app");
    print_str("run_next_app : ");
    print_uint64(app_manager.current_app);
    print_str("\n");
    app_manager.current_app++;
    if(app_manager.current_app>=app_manager.app_num)
    {
        print_str("app execute over\n");
        ASSERT(0);
    }
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    asm volatile ("fence.i");
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    //__restore(trapcontext);
    __restore((uint64_t)cx);
}

void run_first_app()
{
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    __restore((uint64_t)cx);
}


void load_app_test()
{
      // Assume _num_app and related variables are defined elsewhere in your project
    extern uint64_t _num_app[]; // Assuming this is an array holding app info
    uint64_t num_app = _num_app[0]; // First element holds the number of apps
    asm volatile("fence.i");
    for (uint64_t i = 0; i < num_app; i++) {
        // Calculate the start and end addresses of the app in memory
        uint64_t app_start = _num_app[1 + i * 2];
        uint64_t app_end = _num_app[2 + i * 2];
        uint64_t app_size = app_end - app_start;
        const void* src = (const void*)app_start;
        void* dst = (void*)(APP_BASE_ADDRESS + 0x20000 * i);

        print_str("[Test] Loading app from ");
        print_uint64(app_start);
        print_str(" to ");
        print_uint64(app_end);
        print_str("\n");

        // Clear the application area and copy the new app into place
        memset_t(dst, 0, 0x20000); // Ensure APP_MAX_SIZE covers the max possible app size
        memcpy_t(dst, src, app_size);
        // Instruction synchronization barrier to ensure all instructions are executed correctly
        __asm__ volatile ("fence.i");
    }
}