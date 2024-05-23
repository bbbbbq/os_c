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
  init_sys_info();
  char file_names[MAX_FILES_PER_DIR][FILE_NAME_LENGTH];
  printk("\n\n\n\n\n");
  // 调用函数
  int file_count = load_file_names(&root_dir_entry, file_names);

  if (file_count == -1)
  {
    printk("Failed to load file names.\n");
  }
  else
  {
    printk("Total files loaded: %d\n", file_count);
    for (int i = 0; i < file_count; i++)
    {
      printk("File %d: %s\n", i + 1, file_names[i]);
    }
  }

  loader_init_and_list_apps();
  taks_init();
  task_manager_add_2_initproc();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}