#include "config.h"
#include "debug.h"
uint64_t loader_get_num_app() 
{
  extern uint64_t _num_app;
  return _num_app;
}

uint8_t *loader_get_app_data(uint64_t app_id) 
{
    ASSERT(app_id < loader_get_num_app());
    extern uint8_t app_0_start, app_1_start, app_2_start;
    static uint8_t* app_starts[] = 
    {
    &app_0_start,
    &app_1_start,
    &app_2_start
    };
    return app_starts[app_id];
}


size_t loader_get_app_size(uint64_t app_id) 
{
    //printk("loader_get_app_size start\n");
    
    // 确保提供的 app_id 是有效的
    uint64_t num_app = loader_get_num_app();
    ASSERT(app_id < num_app);

    // 使用外部定义的应用程序起始地址和结束地址符号
    extern uint8_t app_0_start, app_1_start, app_2_start, app_2_end;
    // 根据 app_id，创建一个包含应用程序起始地址和最后一个应用的结束地址的数组
    static uint8_t* app_starts_ends[] = {
        &app_0_start,
        &app_1_start,
        &app_2_start,
        &app_2_end, // 用于计算最后一个应用程序的大小
    };

    // 计算并返回应用程序的大小
    size_t app_size = app_starts_ends[app_id + 1] - app_starts_ends[app_id];
    
    // for (uint64_t i = 0; i < num_app; i++) {
    //     printk("App %d Start/End Address: %d\n", i, (uint64_t)app_starts_ends[i]);
    // }
    
    // printk("App ID: %d Size: %d\n", app_id, app_size);
    //ASSERT(0);
    printk("App ID: %d Size: %d\n", app_id, app_size);
    return app_size;
}
