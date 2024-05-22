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
  init_root_entry();
  sys_inode_table = Sys_Inode_Table_new();
  // Block block = read_block(CLUSTER_TO_LBA(2));
  // print_hex(block.data, 512);
  loader_init_and_list_apps();
  taks_init();
  task_manager_add_2_initproc();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}