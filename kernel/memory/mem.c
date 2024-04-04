#include "address.h"
#include "kernel_heap.h"
#include "pagetable.h"
#include "task_memory.h"
#include "kernel_heap.h"
void memory_set_kernel_init() 
{
  memory_set_kernel_new(&KERNEL_SPACE);
  memory_set_activate(&KERNEL_SPACE);
}

void mm_init()
{
    init_heap();
    frame_allocator_init();
    memory_set_kernel_init();
    memory_set_remap_test();
}

