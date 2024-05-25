#ifndef VECTOR_H
#define VECTOR_H
#include "buddy.h" // 提供 malloc 和 free
#include "string.h"
#include "stdint.h"
// 泛型 Vector 结构定
struct vector
{
  uint64_t size, capacity, dsize;
  char *buffer;
};

void vector_new(struct vector *, uint64_t);
uint64_t vector_push(struct vector *, void *);
void vector_pop(struct vector *);
void *vector_back(struct vector *);
int vector_empty(struct vector *);
void vector_free(struct vector *);
void vector_remove(struct vector *, uint64_t);
void *vector_get(struct vector *v, uint64_t index);
uint64_t vector_size(struct vector *v);
void vector_zero_at_index(struct vector *v, uint64_t index);
void vector_ensure_capacity(struct vector *v, uint64_t index);
void vector_set_at_index(struct vector *v, uint64_t index, void *data);
#endif /* VECTOR_H */
