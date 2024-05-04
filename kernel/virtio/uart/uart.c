#include "riscv.h"
#include "config.h"
#include "uart.h"
#include "buddy.h"
#include "ring_buffer.h"

ring_buffer_t uart_ring_buffer;

void uart_init()
{
    printk("uart_init_start\n");
    // 禁用所有中断
    UART_REG(UART_IER) = 0x00;

    // 启用 DLAB (Divisor Latch Access Bit)
    UART_REG(UART_LCR) = 0x80;

    // 设置波特率
    uint16_t divisor = UART_CLOCK / (16 * DESIRED_BAUD);
    UART_REG(UART_DLL) = (uint8_t)(divisor & 0xFF);
    UART_REG(UART_DLM) = (uint8_t)((divisor >> 8) & 0xFF);

    // 设置数据帧格式: 8 bits, no parity, 1 stop bit
    UART_REG(UART_LCR) = 0x03;

    // 配置 Modem Control Register
    // RTS and DTR are high
    UART_REG(UART_MCR) = 0x03;

    // 启用接收数据可用中断
    UART_REG(UART_IER) = 0x01;

    // 清除任何未处理的垃圾数据
    while (UART_REG(UART_LSR) & 0x01)
    {
        volatile uint8_t temp = UART_REG(UART_RBR); // 读 Receiver Buffer Register
        (void)temp;
    }
    // uart缓冲区初始化
    char *buffer = bd_malloc(sizeof(char) * 64);
    ring_buffer_init(&uart_ring_buffer, buffer, 64);
    printk("UART initialized at baud rate %d\n", DESIRED_BAUD);
}

void uart_send_one_byte(char byte)
{
    // 等待发送保持寄存器为空
    while ((UART_REG(UART_LSR) & UART_LSR_THRE) == 0)
    {
    };
    // 写数据到发送保持寄存器
    UART_write(UART_THR, byte);
}

void uart_write_byte_to_buffer(char *byte, size_t cnt)
{
    for (size_t i = 0; i < cnt; i++)
    {
        if (ring_buffer_is_full(&uart_ring_buffer))
        {
            panic("uart_ring_buffer_is_full");
        }
        ring_buffer_queue(&uart_ring_buffer, byte[i]);
    }
}

void uart_clear_buffer()
{
    // ring_buffer_clear(&uart_ring_buffer);
}

void uart_send_all_byte()
{
    char data;
    // 当缓冲区不为空时，继续发送数据
    while (!ring_buffer_is_empty(&uart_ring_buffer))
    {
        // 从缓冲区中取出一个字节
        if (ring_buffer_dequeue(&uart_ring_buffer, &data))
        {
            uart_send_one_byte(data);
        }
    }
}