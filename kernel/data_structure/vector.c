#include "vector.h"
#include "string.h"
#include "buddy.h"
#include "debug.h"
#define VECTOR_INIT_CAPACITY 8

void vector_new(struct vector *v, uint64_t dsize)
{
  v->size = 0;
  v->capacity = VECTOR_INIT_CAPACITY;
  v->dsize = dsize;
  v->buffer = bd_malloc(v->capacity * v->dsize);
}

uint64_t vector_push(struct vector *v, void *d)
{
  if (v->size == v->capacity)
  {
    v->capacity <<= 1;
    char *t = bd_malloc(v->capacity * v->dsize);
    memcpy((uint8_t *)t, (uint8_t *)v->buffer, v->size * v->dsize);
    bd_free(v->buffer);
    v->buffer = t;
  }
  memcpy((uint8_t *)(v->buffer + (v->size++) * v->dsize), d, v->dsize);
  return v->size - 1;
}

void vector_pop(struct vector *v)
{
  if (v->size == 0)
    panic("empty vector pop\n");
  v->size--;
}

void *vector_back(struct vector *v)
{
  if (!v->size)
    panic("empty vector back\n");
  return v->buffer + (v->size - 1) * v->dsize;
}

int vector_empty(struct vector *v) { return !v->size; }

void vector_free(struct vector *v) { bd_free(v->buffer); }

void vector_remove(struct vector *v, uint64_t idx)
{
  if (idx >= v->size)
  {
    panic("invalid idx in vector remove\n");
  }
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
          (v->size - idx - 1) * v->dsize);
  v->size--;
}

void *vector_get(struct vector *v, uint64_t index)
{
  if (index >= v->size)
  {
    return NULL;
  }
  return (void *)(v->buffer + (index * v->dsize));
}

uint64_t vector_size(struct vector *v)
{
  return v->size;
}

void vector_zero_at_index(struct vector *v, uint64_t index)
{
  if (index >= v->size)
  {
    panic("index out of range in vector_zero_at_index\n");
  }
  memset(v->buffer + index * v->dsize, 0, v->dsize);
}

void vector_ensure_capacity(struct vector *v, uint64_t index)
{
  // If index is within current size, return
  if (index < v->size)
    return;

  // Ensure there is enough capacity
  while (index >= v->capacity)
  {
    v->capacity <<= 1; // Double the capacity
    char *new_buffer = bd_malloc(v->capacity * v->dsize);
    if (!new_buffer)
    {
      panic("Out of memory when expanding vector.");
    }
    memcpy(new_buffer, v->buffer, v->size * v->dsize);
    memset(new_buffer + v->size * v->dsize, 0, (v->capacity - v->size) * v->dsize);
    bd_free(v->buffer);
    v->buffer = new_buffer;
  }

  // Initialize new elements to zero up to the required index
  if (index >= v->size)
  {
    memset(v->buffer + v->size * v->dsize, 0, (index - v->size + 1) * v->dsize);
    v->size = index + 1; // Adjust size to include the new index
  }
}

// Set the value at a specific index in the vector
void vector_set_at_index(struct vector *v, uint64_t index, void *data)
{
  vector_ensure_capacity(v, index);                     // Ensure the vector is big enough
  memcpy(v->buffer + index * v->dsize, data, v->dsize); // Copy data into the specified index
}