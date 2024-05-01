#include "mem.h"

void mm_init()
{
  heap_allocator_init();
  frame_allocator_init();
  memory_set_kernel_init();
  memory_set_remap_test();
}

void mm_free()
{
  frame_allocator_free();
}
