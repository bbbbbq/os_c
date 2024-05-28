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
#include "dir.h"
#include "fs_globle.h"
#include "sys_inode_table.h"
#include "sys_info.h"
#include "fat_table.h"
#include "drivers.h"
extern uint8_t sbss, ebss;
void clear_bss()
{
  for (uint8_t *i = &sbss; i < &ebss; i++)
  {
    *i = 0;
  }
}

void print_byte_as_binary(uint8_t byte)
{
  for (int i = 7; i >= 0; i--)
  {
    printk("%c", (byte & (1 << i)) ? '1' : '0');
  }
}

void print_file_data_as_binary(char *file_data, uint32_t file_size)
{
  printk("Binary representation of file data:\n");
  for (uint32_t i = 0; i < file_size; i++)
  {
    print_byte_as_binary(file_data[i]);
    printk(" "); // Add space between bytes for readability
    if ((i + 1) % 8 == 0)
    { // Break line every 8 bytes
    }
  }
}
int main_os()
{
  clear_bss();
  mm_init();
  init_trap();
  plic_init();
  // uart_init();
  virtio_block_device_init();
  virtio_disk_init();
  block_cache_manager_init();
  parse_root_dir();
  init_fat_table();
  init_sys_info();
  Sys_Inode_Table_init();
  char *test_buffer = bd_malloc(512);
  memset(test_buffer, 1, 512);
  read_block_fs(0, test_buffer);
  ls_dir(&root_dir_entry);
  loader_init_and_list_apps();
  taks_init();
  task_manager_add_2_initproc();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}