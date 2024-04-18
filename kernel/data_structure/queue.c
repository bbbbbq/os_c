// queue.c
#include "queue.h"
#include "mem.h"
#include "kernel_heap.h"
void queue_init(Queue *q)
{
    q->head = NULL;
    q->tail = NULL;
    q->size = 0;
}

void queue_enqueue(Queue *q, void *data)
{
    Node *newNode = (Node *)bd_malloc(sizeof(Node));
    if (newNode == NULL)
    {
        ASSERT(0);
    }
    newNode->data = data;
    newNode->next = NULL;

    if (q->tail == NULL)
    { // Empty queue
        q->head = q->tail = newNode;
    }
    else
    {
        q->tail->next = newNode;
        q->tail = newNode;
    }
    q->size++;
}

void *queue_dequeue(Queue *q)
{
    if (q->head == NULL)
    {
        return NULL; // Empty queue
    }

    Node *temp = q->head;
    void *data = temp->data;
    q->head = q->head->next;

    if (q->head == NULL)
    {
        q->tail = NULL; // Queue is now empty
    }

    free(temp);
    q->size--;
    return data;
}

void queue_clear(Queue *q)
{
    Node *current = q->head;
    Node *next;

    while (current != NULL)
    {
        next = current->next;
        free(current);
        current = next;
    }

    q->head = NULL;
    q->tail = NULL;
    q->size = 0;
}

int queue_is_empty(const Queue *q)
{
    return q->size == 0;
}
