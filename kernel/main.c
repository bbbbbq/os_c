#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
#include "task.h"
#include "timer.h"
#include "buddy.h"
#include "mem.h"
#include "loader.h"
#include "processor.h"
#include "taskmanager.h"
#include "string.h"
#include "riscv.h"
#include "virtio_disk.h"
#include "dir.h"
#include "fs_globle.h"
#include "sys_inode_table.h"
#include "sys_info.h"
#include "fat_table.h"
extern uint8_t sbss, ebss;
void clear_bss()
{
  for (uint8_t *i = &sbss; i < &ebss; i++)
  {
    *i = 0;
  }
}

int main_os()
{
  mm_init();
  init_trap();
  plic_init();
  uart_init();
  virtio_disk_init();
  parse_root_dir();
  init_fat_table();
  ls_dir(&root_dir_entry);
  // Dirent *dir = find_directory_bfs("clone", root_dir_entry);
  // char *buffer = bd_malloc(get_file_or_dir_size(dir));
  // read_file("clone", buffer);
  // print_hex(buffer, get_file_or_dir_size(dir));
  // printk("init_sys_info\n");
  init_sys_info();
  // printk("loader_init_and_list_apps();\n");
  loader_init_and_list_apps();
  // printk("taks_init();\n");
  taks_init();
  // printk("task_manager_add_2_initproc();\n");
  task_manager_add_2_initproc();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}