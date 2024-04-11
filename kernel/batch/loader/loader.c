#include "config.h"
#include "debug.h"
#include "task.h"
#include "string.h"
#include "loader.h"
char APP_NAMES[MAX_APP_NUM][MAX_APP_NAME_LENGTH];
uint64_t loader_get_num_app() 
{
  extern uint64_t _num_app[];
  return _num_app[0];
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
    //printk("App ID: %d Size: %d\n", app_id, app_size);
    return app_size;
}


void loader_init_and_list_apps() 
{
  extern uint64_t _app_names;
  uint64_t num_app = loader_get_num_app();
  uint8_t *ptr = (uint8_t *)&_app_names;
  for (uint64_t i = 0; i < num_app; i++) 
  {
    strcpy_t(APP_NAMES[i], (char *)ptr);
    ptr += (strlen_t((char *)ptr) + 1);
  }
}

void list_apps() 
{
    printk("/**** APPS ****\n");
    int num_app = loader_get_num_app();
    for (int i = 0; i < num_app; i++) {
        printk("%s\n", APP_NAMES[i]);
    }
    printk("**************/\n");
}

uint8_t* get_app_data_by_name(char* name) 
{
    int num_app = loader_get_num_app();
    for (int i = 0; i < num_app; i++) 
    {
        if (strcmp_t(APP_NAMES[i], name) == 0) 
        {
            return loader_get_app_data(i);
        }
    }
    return NULL; // Return NULL if no match is found
}