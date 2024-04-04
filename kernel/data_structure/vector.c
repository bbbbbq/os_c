#include "vector.h"
#include "stdint.h"
#include "buddy.h"

void vector_init(Vector *v) 
{
    v->capacity = 4;
    v->total = 0;
    // 这里假设 sizeof(void*) * v->capacity 是以字节为单位的合适大小，需要根据实际情况调整
    int offset = buddy_alloc(global_buddy, sizeof(void*) * v->capacity); // 这可能需要调整，因为buddy_alloc的参数和返回值可能与你的需求不匹配
    v->items = (void**)(offset); // 这里需要根据伙伴系统分配器的具体实现来转换offset到指针
}
size_t vector_total(Vector *v) {
    return v->total;
}
void vector_resize(Vector *v, size_t capacity) {
    int new_offset = buddy_alloc(global_buddy, sizeof(void*) * capacity);
    void **new_items = (void**)(new_offset); // 根据实际情况转换
    if (new_items) {
        // 复制旧数据到新位置
        for (size_t i = 0; i < v->total; i++) {
            new_items[i] = v->items[i];
        }
        // 释放旧内存
        buddy_free(global_buddy, (int)v->items); // 这里的转换需要根据buddy_free的实现来调整
        // 更新结构体
        v->items = new_items;
        v->capacity = capacity;
    }
}

void vector_add(Vector *v, void *item) {
    if (v->capacity == v->total) {
        vector_resize(v, v->capacity * 2);
    }
    v->items[v->total++] = item;
}

void *vector_get(Vector *v, size_t index) {
    if (index < v->total) {
        return v->items[index];
    }
    return NULL;
}

void vector_delete(Vector *v, size_t index) {
    if (index < v->total) {
        v->items[index] = NULL;
        for (size_t i = index; i < v->total - 1; ++i) {
            v->items[i] = v->items[i + 1];
            v->items[i + 1] = NULL;
        }
        v->total--;
        if (v->total > 0 && v->total == v->capacity / 4) {
            vector_resize(v, v->capacity / 2);
        }
    }
}
void vector_free(Vector *v) 
{
    buddy_free(global_buddy, (int)v->items); // 这里的转换需要根据buddy_free的实现来调整
    v->items = NULL;
    v->capacity = 0;
    v->total = 0;
}


void vector_new(Vector *v, size_t initial_capacity) 
{
    if (!v) return;
    v->items = (void**)malloc(initial_capacity * sizeof(void*));
    if (v->items == NULL) {
        // 如果内存分配失败，则容量和总数设置为 0
        v->capacity = 0;
        v->total = 0;
        return; // 可以在这里处理错误或者返回
    }

    // 初始化 Vector 结构体的其他成员
    v->capacity = initial_capacity;
    v->total = 0; // 初始时，Vector 为空
}