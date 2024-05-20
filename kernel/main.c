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
#include "fs_globle.h"
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
  loader_init_and_list_apps();
  taks_init();
  Block block1;
  uint32_t test = 0;
  block1 = read_block(0);
  print_hex(block1.data, 512);
  task_manager_add_2_initproc();
  // init_fat_32();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}