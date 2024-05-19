#include "queue.h"

#include <memory.h>
#include <stdio.h>
#include <stdlib.h>

void init_queue(struct queue_root **root)
{
    *root = (struct queue_root *)malloc(sizeof(struct queue_root));
    if (root == NULL)
    {
        printf("malloc failed");
        exit(1);
    }
    (*root)->head = (struct queue_node *)malloc(sizeof(struct queue_node)); /* Sentinel node */
    (*root)->tail = (*root)->head;
    (*root)->head->n = NULL;
    (*root)->head->next = NULL;
}

int queue_add(struct queue_root *root, void *val)
{
    struct queue_node *n;
    struct queue_node *node = (struct queue_node *)malloc(sizeof(struct queue_node));
    node->n = val;
    node->next = NULL;
    while (1)
    {
        n = root->tail;
        if (__sync_bool_compare_and_swap(&(n->next), NULL, node))
        {
            break;
        }
        else
        {
            __sync_bool_compare_and_swap(&(root->tail), n, n->next);
        }
    }
    __sync_bool_compare_and_swap(&(root->tail), n, node);

    return 1;
}

void *queue_get(struct queue_root *root)
{
    struct queue_node *n;
    void *val;
    while (1)
    {
        n = root->head;
        if (n->next == NULL)
        {
            return NULL;
        }

        if (__sync_bool_compare_and_swap(&(root->head), n, n->next))
        {
            break;
        }
    }
    val = (void *)n->next->n;
    free(n);
    return val;
}

uint32_t queue_is_empty(struct queue_root *root)
{
    return (root->head->next == NULL);
}