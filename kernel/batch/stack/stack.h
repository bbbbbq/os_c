#ifndef STACK_H
#define STAKC_H
#include "stdint.h"
#include "batch.h"
#include "mem.h"

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top);

#endif