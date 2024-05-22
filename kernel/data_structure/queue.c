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

int queue_enqueue(Queue *q, void *data)
{
    Node *newNode = (Node *)bd_malloc(sizeof(Node));
    if (newNode == NULL)
    {
        ASSERT(0);
    }
    newNode->data = data;
    newNode->next = NULL;

    if (q->tail == NULL)
    {
        q->head = q->tail = newNode;
    }
    else
    {
        q->tail->next = newNode;
        q->tail = newNode;
    }
    q->size++;
    return q->size - 1;
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

void *queue_get_at(const Queue *q, int index)
{
    if (q == NULL || index < 0 || index >= q->size)
    {
        return NULL; // 检查索引有效性和队列非空
    }

    Node *current = q->head;
    int count = 0;

    // 遍历链表直到所需的索引
    while (current != NULL && count < index)
    {
        current = current->next;
        count++;
    }

    // 如果当前节点非空，返回节点数据
    if (current != NULL)
    {
        return current->data;
    }

    return NULL;
}

bool queue_set_at(Queue *q, int index, void *new_data)
{
    if (q == NULL || index < 0 || index >= q->size)
    {
        return 0;
    }

    Node *current = q->head;
    int count = 0;

    while (current != NULL && count < index)
    {
        current = current->next;
        count++;
    }

    if (current != NULL)
    {
        current->data = new_data;
        return 1;
    }

    return 0;
}