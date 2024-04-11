#ifndef QUEUE_H
#define QUEUE_H

// 队列节点结构体
typedef struct Node {
    void* data;
    struct Node* next;
} Node;

// 队列结构体
typedef struct {
    Node* head;
    Node* tail;
    int size;
} Queue;

Queue* createQueue();
int queue_empty(Queue* q);
int queue_size(Queue* q);
void queue_push(Queue* q, void* element);
void* queue_pop(Queue* q);
void* queue_front(Queue* q);
void* queue_back(Queue* q);

#endif // QUEUE_H
