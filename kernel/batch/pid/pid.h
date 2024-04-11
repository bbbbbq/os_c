#ifndef PID_H
#define PID_H

#include "vector.h"
#include "stdint.h"


typedef struct
{
    uint64_t pid;
}PidHandle;

typedef struct
{
    PidHandle current;
    struct vector recycled;
} PidAllocator;

PidAllocator PID_ALLOCATOR;

void PidAllocator_init();
void PidAllocator_alloc();
void PidAllocator_dealloc();
#endif