// Guard to prevent multiple inclusion of this header file
#ifndef QUEUE_H
#define QUEUE_H

#include "mem.h"  // Include the memory management header if needed for dynamic allocation

// Node structure definition
typedef struct Node {
    void* data;           // Pointer to the data held by the node
    struct Node* next;    // Pointer to the next node in the queue
} Node;

// Queue structure definition
typedef struct {
    Node* head;   // Pointer to the front of the queue
    Node* tail;   // Pointer to the end of the queue
    int size;     // Integer to track the number of elements in the queue
} Queue;

// Function declarations:

// Initializes the queue structure
// @param q Pointer to the queue to be initialized
void queue_init(Queue* q);

// Enqueues a new element into the queue
// @param q Pointer to the queue where data will be added
// @param data Pointer to the data to be added to the queue
void queue_enqueue(Queue* q, void* data);

// Dequeues an element from the queue and returns the data from the front
// @param q Pointer to the queue from which data will be removed
// @return Pointer to the data dequeued, or NULL if the queue is empty
void* queue_dequeue(Queue* q);

// Clears all elements from the queue, freeing memory if necessary
// @param q Pointer to the queue to be cleared
void queue_clear(Queue* q);

// Checks if the queue is empty
// @param q Pointer to the queue to be checked
// @return Integer 1 if the queue is empty, 0 otherwise
int queue_is_empty(const Queue* q);

#endif // QUEUE_H
