#include "stdint.h"
#include "debug.h"

#ifndef RINGBUFFER_H
#define RINGBUFFER_H
// 断言宏，确保表达式x为真
#define RING_BUFFER_ASSERT(x) ASSERT(x)

// 检查buffer_size是否是2的幂
#define RING_BUFFER_IS_POWER_OF_TWO(buffer_size) ((buffer_size & (buffer_size - 1)) == 0)

// 定义用于存储大小和索引的类型
typedef size_t ring_buffer_size_t;

// 用作模运算的宏
#define RING_BUFFER_MASK(rb) (rb->buffer_mask)

// 简化结构体类型的使用
typedef struct ring_buffer_t ring_buffer_t;

// 环形缓冲区的结构体定义
struct ring_buffer_t
{
    char *buffer;                   // 缓冲区内存
    ring_buffer_size_t buffer_mask; // 缓冲区掩码，用于索引运算
    ring_buffer_size_t tail_index;  // 尾索引
    ring_buffer_size_t head_index;  // 头索引
};

// 初始化环形缓冲区
void ring_buffer_init(ring_buffer_t *buffer, char *buf, size_t buf_size);

// 向环形缓冲区中添加一个字节
void ring_buffer_queue(ring_buffer_t *buffer, char data);

// 向环形缓冲区中添加一个字节数组
void ring_buffer_queue_arr(ring_buffer_t *buffer, const char *data, ring_buffer_size_t size);

// 从环形缓冲区中移除一个字节
uint8_t ring_buffer_dequeue(ring_buffer_t *buffer, char *data);

// 从环形缓冲区中移除多个字节
ring_buffer_size_t ring_buffer_dequeue_arr(ring_buffer_t *buffer, char *data, ring_buffer_size_t len);

// 查看环形缓冲区的一个元素，不移除
uint8_t ring_buffer_peek(ring_buffer_t *buffer, char *data, ring_buffer_size_t index);

// 检查环形缓冲区是否为空
inline uint8_t ring_buffer_is_empty(ring_buffer_t *buffer)
{
    return (buffer->head_index == buffer->tail_index);
}

// 检查环形缓冲区是否已满
inline uint8_t ring_buffer_is_full(ring_buffer_t *buffer)
{
    return ((buffer->head_index - buffer->tail_index) & RING_BUFFER_MASK(buffer)) == RING_BUFFER_MASK(buffer);
}

// 返回环形缓冲区中的元素数量
inline ring_buffer_size_t ring_buffer_num_items(ring_buffer_t *buffer)
{
    return ((buffer->head_index - buffer->tail_index) & RING_BUFFER_MASK(buffer));
}
#endif