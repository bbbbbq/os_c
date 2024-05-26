#include "ring_buffer.h"

/**
 * @file
 * 环形缓冲区函数的实现。
 */

void ring_buffer_init(ring_buffer_t *buffer, char *buf, size_t buf_size)
{
    RING_BUFFER_ASSERT(RING_BUFFER_IS_POWER_OF_TWO(buf_size) == 1);
    buffer->buffer = buf;
    buffer->buffer_mask = buf_size - 1; // 计算掩码
    buffer->tail_index = 0;             // 初始化尾索引
    buffer->head_index = 0;             // 初始化头索引
}

void ring_buffer_queue(ring_buffer_t *buffer, char data)
{
    /* 检查缓冲区是否已满 */
    if (ring_buffer_is_full(buffer))
    {
        /* 将覆盖最旧的字节 */
        /* 增加尾索引 */
        buffer->tail_index = ((buffer->tail_index + 1) & RING_BUFFER_MASK(buffer));
    }

    /* 在缓冲区中放置数据 */
    buffer->buffer[buffer->head_index] = data;
    buffer->head_index = ((buffer->head_index + 1) & RING_BUFFER_MASK(buffer));
}

void ring_buffer_queue_arr(ring_buffer_t *buffer, const char *data, ring_buffer_size_t size)
{
    /* 逐个添加字节 */
    ring_buffer_size_t i;
    for (i = 0; i < size; i++)
    {
        ring_buffer_queue(buffer, data[i]);
    }
}

uint8_t ring_buffer_dequeue(ring_buffer_t *buffer, char *data)
{
    if (ring_buffer_is_empty(buffer))
    {
        return 0;
    }

    *data = buffer->buffer[buffer->tail_index];
    buffer->tail_index = ((buffer->tail_index + 1) & RING_BUFFER_MASK(buffer));
    return 1;
}

ring_buffer_size_t ring_buffer_dequeue_arr(ring_buffer_t *buffer, char *data, ring_buffer_size_t len)
{
    if (ring_buffer_is_empty(buffer))
    {
        /* 没有项目 */
        return 0;
    }

    char *data_ptr = data;
    ring_buffer_size_t cnt = 0;
    while ((cnt < len) && ring_buffer_dequeue(buffer, data_ptr))
    {
        cnt++;
        data_ptr++;
    }
    return cnt;
}

uint8_t ring_buffer_peek(ring_buffer_t *buffer, char *data, ring_buffer_size_t index)
{
    if (index >= ring_buffer_num_items(buffer))
    {
        /* 索引位置无项目 */
        return 0;
    }

    /* 计算数据索引 */
    ring_buffer_size_t data_index = ((buffer->tail_index + index) & RING_BUFFER_MASK(buffer));
    *data = buffer->buffer[data_index];
    return 1;
}

extern inline uint8_t ring_buffer_is_empty(ring_buffer_t *buffer);
extern inline uint8_t ring_buffer_is_full(ring_buffer_t *buffer);
extern inline ring_buffer_size_t ring_buffer_num_items(ring_buffer_t *buffer);
