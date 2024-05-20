#ifndef QUEUE_H
#define QUEUE_H
#include <stdint.h>

struct queue_node
{
    void *n;
    struct queue_node *next;
};

struct queue_root
{
    struct queue_node *head;
    struct queue_node *tail;
    volatile unsigned int size;
};

void fs_init_queue(struct queue_root **root);
int fs_queue_add(struct queue_root *root, void *val);
void *fs_queue_get(struct queue_root *root);
uint32_t fs_queue_is_empty(struct queue_root *root);

#endif