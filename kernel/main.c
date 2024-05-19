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
#include "driver.h"
#include "fs.h"
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
  virtio_block_device_init();
  BlockCache_manager_init();
  uart_init();
  // BlockCache *test1;
  // BlockCache *test2;
  // block_cache_new(test1, 1, &BLOCK_DEVICE);
  // block_cache_new(test2, 1, &BLOCK_DEVICE);
  loader_init_and_list_apps();
  taks_init();
  task_manager_add_2_initproc();
  processor_run_tasks();
  ASSERT(0);
  return 0;
}