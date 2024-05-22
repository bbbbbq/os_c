// queue.h
#ifndef QUEUE_H
#define QUEUE_H

#include "mem.h"

// Node structure
typedef struct Node
{
    void *data;
    struct Node *next;
} Node;

// Queue structure
typedef struct
{
    Node *head;
    Node *tail;
    int size;
} Queue;

// Function declarations
void queue_init(Queue *q);
int queue_enqueue(Queue *q, void *data);
void *queue_dequeue(Queue *q);
void queue_clear(Queue *q);
int queue_is_empty(const Queue *q);
void *queue_get_at(const Queue *q, int index);
#endif // QUEUE_H
