#include "batch.h"
#include "console.h"
#include "string.h"
#include "debug.h"
#include "context.h"
#include "stack.h"
#include "loader.h"
#include "mem.h"
#include "task.h"
struct AppManager app_manager;
extern struct TaskManager TASK_MANAGER;
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
    TASK_MANAGER.tasks[0].task_status = Running;
  const struct TaskContext **next_task_cx_ptr2 =
      get_task_cx_ptr2(&(TASK_MANAGER.tasks[0]));
  uint64_t _unused = 0;
  __switch((const struct TaskContext **)&_unused, next_task_cx_ptr2);
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