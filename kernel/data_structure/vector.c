#include "vector.h"
#include "kernel_heap.h"
#include "stdint.h"
// 初始化Vector
void vector_init(Vector *v) 
{
    v->capacity = 4; // 初始容量设为4
    v->total = 0;
    v->items = (uint64_t*)0; // 用0代替NULL
}

// 获取Vector中的元素总数
uint64_t vector_total(Vector *v) 
{
    return v->total;
}

// 内部函数，用于调整Vector的容量
void vector_resize(Vector *v, uint64_t capacity) 
{
    uint64_t *items = (uint64_t*)0;
    if (v->items == 0) 
    {
        items = (uint64_t*)malloc(capacity * sizeof(uint64_t));
    } else 
    {
        items = (uint64_t*)realloc(v->items, capacity * sizeof(uint64_t));
    }

    if (items) 
    {
        v->items = items;
        v->capacity = capacity;
    }
}

// 向Vector添加元素
void vector_add(Vector *v, uint64_t item) 
{
    if (v->capacity == v->total) 
    {
        vector_resize(v, v->capacity * 2);
    }

    v->items[v->total++] = item;
}

// 设置Vector指定位置的元素
void vector_set(Vector *v, uint64_t index, uint64_t item) 
{
    if (index >= 0 && index < v->total) 
    {
        v->items[index] = item;
    }
}

// 获取Vector指定位置的元素
uint64_t vector_get(Vector *v, uint64_t index) 
{
    if (index >= 0 && index < v->total) 
    {
        return v->items[index];
    }
    return 0; // 用0代替NULL
}

// 删除Vector指定位置的元素
void vector_delete(Vector *v, uint64_t index) 
{
    if (index < 0 || index >= v->total) 
    {
        return;
    }

    v->items[index] = 0; // 清空元素
    for (uint64_t i = index; i < v->total - 1; i++) 
    {
        v->items[i] = v->items[i + 1];
    }
    v->total--;

    if (v->total > 0 && v->total == v->capacity / 4) 
    {
        vector_resize(v, v->capacity / 2);
    }
}

// 释放Vector
void vector_free(Vector *v) 
{
    if (v->items) 
    {
        free(v->items);
    }
    v->capacity = 0;
    v->total = 0;
    v->items = (uint64_t*)0;
}

uint64_t vector_find_elem(Vector *v, uint64_t item) 
{
    for (uint64_t i = 0; i < v->total; i++) 
    {
        if (v->items[i] == item) 
        {
            return i;
        }
    }
    return -1;
}

uint64_t vector_pop(Vector *v) 
{
    if (v->total == 0) 
    {
        return 0;
    }
    uint64_t item = v->items[v->total - 1];
    v->total--;
    return item;
}
