// queue.c
#include "queue.h"
#include "stdint.h"
#include "mem.h"
#include "kernel_heap.h"
Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->head = q->tail = NULL;
    q->size = 0;
    return q;
}

int queue_empty(Queue* q) {
    return q->size == 0;
}

int queue_size(Queue* q) {
    return q->size;
}

void queue_push(Queue* q, void* element) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = element;
    newNode->next = NULL;
    
    if (q->tail == NULL) {
        q->head = q->tail = newNode;
    } else {
        q->tail->next = newNode;
        q->tail = newNode;
    }
    q->size++;
}

void* queue_pop(Queue* q) {
    if (queue_empty(q)) {
        return NULL;
    }
    
    Node* temp = q->head;
    void* data = temp->data;
    q->head = q->head->next;
    
    if (q->head == NULL) {
        q->tail = NULL;
    }
    
    free(temp);
    q->size--;
    return data;
}

void* queue_front(Queue* q) {
    if (queue_empty(q)) {
        return NULL;
    }
    return q->head->data;
}

void* queue_back(Queue* q) 
{
    if (queue_empty(q)) {
        return NULL;
    }
    return q->tail->data;
}
