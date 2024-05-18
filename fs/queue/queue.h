#ifndef QUEUE_H
#define QUEUE_H
#include <stdint.h>
struct queue_root {
	struct queue_node *head;
	struct queue_node *tail;
	volatile unsigned int size;
};

struct queue_node {
	void *n;
	struct queue_node *next;
};

void init_queue(struct queue_root **root);
int queue_add(struct queue_root *root, void *val);
void *queue_get(struct queue_root *root);
uint32_t queue_is_empty(struct queue_root *root);
#endif