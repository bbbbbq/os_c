#include "config.h"
#include "debug.h"
#include "task.h"
#include "string.h"
#include "loader.h"
char APP_NAMES[MAX_APP_NUM][256];
uint64_t APP_NUM_GLOBLE = 0;
uint64_t CURRENT_TASK_ID = 3;
uint64_t loader_get_num_app()
{
  return APP_NUM_GLOBLE;
}

// uint8_t *loader_get_app_data(uint64_t app_id)
// {
//     ASSERT(app_id < loader_get_num_app());
//     extern uint8_t app_0_start, app_1_start, app_2_start;
//     static uint8_t* app_starts[] =
//     {
//     &app_0_start,
//     &app_1_start,
//     &app_2_start
//     };
//     return app_starts[app_id];
// }

// size_t loader_get_app_size(uint64_t app_id)
// {
//     //printk("loader_get_app_size start\n");

//     // 确保提供的 app_id 是有效的
//     uint64_t num_app = loader_get_num_app();
//     ASSERT(app_id < num_app);

//     // 使用外部定义的应用程序起始地址和结束地址符号
//     extern uint8_t app_0_start, app_1_start, app_2_start, app_2_end;
//     // 根据 app_id，创建一个包含应用程序起始地址和最后一个应用的结束地址的数组
//     static uint8_t* app_starts_ends[] = {
//         &app_0_start,
//         &app_1_start,
//         &app_2_start,
//         &app_2_end, // 用于计算最后一个应用程序的大小
//     };

//     // 计算并返回应用程序的大小
//     size_t app_size = app_starts_ends[app_id + 1] - app_starts_ends[app_id];
//     return app_size;
// }

void loader_init_and_list_apps()
{
  APP_NUM_GLOBLE = load_file_names(&root_dir_entry, APP_NAMES);
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

uint8_t *loader_get_app_data_by_name(char *name)
{
  Dirent *dir = find_directory_bfs(name, root_dir_entry);
  if (dir == NULL)
    return NULL;
  uint32_t file_size = get_file_or_dir_size(dir);
  // 8字节对齐
  file_size = file_size + (8 - file_size % 8) % 8;
  if (file_size == 0)
  {
    printk("file_size = 0\n");
    return NULL;
  }
  char *buffer = bd_malloc(file_size);
  if (buffer == NULL)
  {
    panic("buffer alloc error \n");
  }
  read_file(name, buffer);
  return buffer;
}

size_t loader_get_app_size_by_name(char *name)
{
  Dirent *dir = find_directory_bfs(name, root_dir_entry);
  if (dir == NULL)
  {
    panic("dir not found\n");
  }
  uint32_t file_size = get_file_or_dir_size(dir);
  if (file_size == 0)
  {
    panic("file_size == 0\n");
  }
  return file_size;
}

char *loader_get_app_name_by_index(uint32_t id)
{
  char *app_name = APP_NAMES[id];
  return app_name;
}