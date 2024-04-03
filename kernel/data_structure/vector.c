#include "vector.h"
#include "stdint.h"
void vector_init(Vector *v) {
    v->capacity = 4;
    v->total = 0;
    v->items = malloc(sizeof(void*) * v->capacity);
}

size_t vector_total(Vector *v) {
    return v->total;
}

void vector_resize(Vector *v, size_t capacity) {
    void **items = realloc(v->items, sizeof(void*) * capacity);
    if (items) {
        v->items = items;
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

void vector_free(Vector *v) {
    free(v->items);
    v->items = NULL;
    v->capacity = 0;
    v->total = 0;
}
