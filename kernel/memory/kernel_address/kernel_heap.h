#ifndef HEAP_H
#define HEAP_H

#include "stdint.h"

void init_heap();
void *malloc(uint64_t size);
void free(void *ptr);
void print_heap();
void *realloc(void *ptr, uint64_t new_size);
#endif // HEAP_H