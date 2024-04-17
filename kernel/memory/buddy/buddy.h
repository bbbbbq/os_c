#ifndef BUDDY_H
#define BUDDY_H
#include "stdint.h"
void bd_init(void *, void *);
void bd_free(void *);
void *bd_malloc(uint64_t nbytes);

#endif