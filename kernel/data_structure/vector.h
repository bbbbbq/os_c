#ifndef VECTOR_H
#define VECTOR_H

#ifdef __cplusplus
extern "C" {
#endif

#include "kernel_heap.h" // 提供 malloc 和 free
#include "string.h"
// 泛型 Vector 结构定义
typedef struct {
    void **items;      // 动态数组的项，使用 void* 来存储任意类型的指针
    size_t capacity;   // 动态数组的容量
    size_t total;      // 当前动态数组中项的总数
} Vector;

// Vector 相关函数声明
void vector_init(Vector *v);
size_t vector_total(Vector *v);
void vector_resize(Vector *v, size_t capacity);
void vector_add(Vector *v, void *item);
void *vector_get(Vector *v, size_t index);  


void vector_delete(Vector *v, size_t index);
void vector_free(Vector *v);

#ifdef __cplusplus
}
#endif

#endif /* VECTOR_H */
