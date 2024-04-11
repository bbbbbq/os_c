#include "pid.h"
#include "stdint.h"
#include "debug.h"

void PidAllocator_init(PidAllocator* allocator) 
{
    allocator->current.pid = 0;
    vector_new(&allocator->recycled,10);
}

PidHandle PidAllocator_alloc()
{
    PidHandle handle;
    if (vector_size(&PID_ALLOCATOR.recycled) > 0) {
        handle.pid = *(uint64_t*)vector_back(&PID_ALLOCATOR.recycled);
        vector_pop(&PID_ALLOCATOR.recycled);
    } else {
        handle.pid = PID_ALLOCATOR.current.pid;
        PID_ALLOCATOR.current.pid++;
    }
    return handle;
}

void PidAllocator_dealloc(PidHandle pid) 
{
    ASSERT(pid.pid < PID_ALLOCATOR.current.pid);
    for (size_t i = 0; i < vector_size(&PID_ALLOCATOR.recycled); ++i) {
        ASSERT(pid.pid != *(uint64_t*)vector_get(&PID_ALLOCATOR.recycled, i));
    }
    vector_push(&PID_ALLOCATOR.recycled, &pid);
}