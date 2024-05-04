#ifndef UART_H
#define UART_H
#include "config.h"
#include "riscv.h"
#include "uart.h"
#include "ring_buffer.h"

#define UART_BASE 0x10000000 // UART设备的基地址
#define UART_CLOCK 50000000  // UART时钟频率
#define DESIRED_BAUD 115200  // 期望的波特率

// 寄存器偏移量
#define UART_RBR 0x00      // Receiver Buffer Register (read only)
#define UART_THR 0x00      // Transmitter Holding Register (write only)
#define UART_IER 0x01      // Interrupt Enable Register
#define UART_DLL 0x00      // Divisor Latch Low Byte (LCR[7] = 1)
#define UART_DLM 0x01      // Divisor Latch High Byte (LCR[7] = 1)
#define UART_LCR 0x03      // Line Control Register
#define UART_MCR 0x04      // Modem Control Register
#define UART_LSR 0x05      // Line Status Register
#define UART_MSR 0x06      // Modem Status Register
#define UART_SCR 0x07      // Scratch Register
#define UART_LSR_THRE 0x20 // 发送保持寄存器空
#define UART_REG(offset) (*(volatile uint8_t *)(UART_BASE + (offset)))
#define UART_write(reg, val) (*(volatile uint32_t *)(reg) = (val))

void uart_irq_handler();
void uart_init();
void uart_send_one_byte(char byte);
void uart_write_byte_to_buffer(char *byte, size_t cnt);
void uart_clear_buffer();
void uart_send_all_byte();
void uart_irq_handler();
#endif