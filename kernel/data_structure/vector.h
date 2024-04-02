#ifndef VECTOR_H
#define VECTOR_H
#ifdef __cplusplus
extern "C" {
#endif
#include "stdint.h"
// Vector结构定义
typedef struct {
    uint64_t *items;       // 动态数组的项
    uint64_t capacity; // 动态数组的容量
    uint64_t total;    // 当前动态数组中项的总数
} Vector;

void vector_init(Vector *v);
uint64_t vector_total(Vector *v);
void vector_resize(Vector *v, uint64_t capacity);
void vector_add(Vector *v, uint64_t item);
void vector_set(Vector *v, uint64_t index, uint64_t item);
uint64_t vector_get(Vector *v, uint64_t index);
void vector_delete(Vector *v, uint64_t index);
void vector_free(Vector *v);
uint64_t vector_find_elem(Vector *v, uint64_t item);
uint64_t vector_pop(Vector *v);

#ifdef __cplusplus
}
#endif

#endif /* VECTOR_H */
