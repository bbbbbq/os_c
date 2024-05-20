#include "fs_queue.h"

// #include <memory.h>
// // #include <stdio.h>
// #include <stdlib.h>

void fs_init_queue(struct queue_root **root)
{
    *root = (struct queue_root *)bd_malloc(sizeof(struct queue_root));
    if (root == NULL)
    {
        printk("bd_malloc failed");
        return;
    }
    (*root)->head = (struct queue_node *)bd_malloc(sizeof(struct queue_node)); /* Sentinel node */
    (*root)->tail = (*root)->head;
    (*root)->head->n = NULL;
    (*root)->head->next = NULL;
}

int fs_queue_add(struct queue_root *root, void *val)
{
    struct queue_node *n;
    struct queue_node *node = (struct queue_node *)bd_malloc(sizeof(struct queue_node));
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

void *fs_queue_get(struct queue_root *root)
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
    bd_free(n);
    return val;
}

uint32_t fs_queue_is_empty(struct queue_root *root)
{
    return (root->head->next == NULL);
}