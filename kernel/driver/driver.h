#pragma once

#ifndef DRIVER_H
#define DRIVER_H

#include "stdint.h"
#define REG(r) ((volatile uint32_t *)(VIRTIO0 + (r)))
// UART definitions and functions
#define UART_BASE 0x10000000 // UART设备的基地址
#define UART_CLOCK 50000000  // UART时钟频率
#define DESIRED_BAUD 115200  // 期望的波特率

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

// PLIC definitions and functions
#define PLIC_BASE 0x0C000000
#define PLIC_PRIORITY_OFFSET 0x0000                               // 中断优先级基址
#define PLIC_PENDING_OFFSET 0x1000                                // 挂起位数组基址
#define PLIC_MENABLE_OFFSET(hart) (0x2000 + (hart) * 0x100)       // 每个hart的中断使能数组基址
#define PLIC_SENABLE_OFFSET(hart) (0x2080 + (hart) * 0x100)       // 每个hart的中断使能数组基址（监督模式）
#define PLIC_MCLAIM_OFFSET(hart) (0x200004 + (hart) * 0x2000)     // 每个hart的中断认领/完成寄存器基址
#define PLIC_SCLAIM_OFFSET(hart) (0x201004 + (hart) * 0x2000)     // 每个hart的中断认领/完成寄存器基址（监督模式）
#define PLIC_MTHRESHOLD_OFFSET(hart) (0x200000 + (hart) * 0x2000) // 每个hart的中断门限寄存器基址
#define PLIC_STHRESHOLD_OFFSET(hart) (0x201000 + (hart) * 0x2000) // 每个hart的中断门限寄存器基址（监督模式）
#define PLIC_REG32(address) (*(volatile uint32_t *)(address))
#define PLIC_PRIORITY(irq) (PLIC_BASE + PLIC_PRIORITY_OFFSET + (irq) * 4)

void plic_init();
int plic_claim();
void plic_complete(int irq);

#define VIRTIO_MMIO_MAGIC_VALUE 0x000 // 0x74726976
#define VIRTIO_MMIO_VERSION 0x004     // version; 1 is legacy
#define VIRTIO_MMIO_DEVICE_ID 0x008   // device type; 1 is net, 2 is disk
#define VIRTIO_MMIO_VENDOR_ID 0x00c   // 0x554d4551
#define VIRTIO_MMIO_DEVICE_FEATURES 0x010
#define VIRTIO_MMIO_DRIVER_FEATURES 0x020
#define VIRTIO_MMIO_GUEST_PAGE_SIZE 0x028  // page size for PFN, write-only
#define VIRTIO_MMIO_QUEUE_SEL 0x030        // select queue, write-only
#define VIRTIO_MMIO_QUEUE_NUM_MAX 0x034    // max size of current queue, read-only
#define VIRTIO_MMIO_QUEUE_NUM 0x038        // size of current queue, write-only
#define VIRTIO_MMIO_QUEUE_ALIGN 0x03c      // used ring alignment, write-only
#define VIRTIO_MMIO_QUEUE_PFN 0x040        // physical page number for queue, r/w
#define VIRTIO_MMIO_QUEUE_READY 0x044      // ready bit
#define VIRTIO_MMIO_QUEUE_NOTIFY 0x050     // write-only
#define VIRTIO_MMIO_INTERRUPT_STATUS 0x060 // read-only
#define VIRTIO_MMIO_INTERRUPT_ACK 0x064    // write-only
#define VIRTIO_MMIO_STATUS 0x070           // read/write

// status register bits, from qemu virtio_config.h
#define VIRTIO_CONFIG_S_ACKNOWLEDGE 1
#define VIRTIO_CONFIG_S_DRIVER 2
#define VIRTIO_CONFIG_S_DRIVER_OK 4
#define VIRTIO_CONFIG_S_FEATURES_OK 8

// device feature bits
#define VIRTIO_BLK_F_RO 5          /* Disk is read-only */
#define VIRTIO_BLK_F_SCSI 7        /* Supports scsi command passthru */
#define VIRTIO_BLK_F_CONFIG_WCE 11 /* Writeback mode available in config */
#define VIRTIO_BLK_F_MQ 12         /* support more than one vq */
#define VIRTIO_F_ANY_LAYOUT 27
#define VIRTIO_RING_F_INDIRECT_DESC 28
#define VIRTIO_RING_F_EVENT_IDX 29

// this many virtio descriptors.
// must be a power of two.
#define NUM 8

// a single descriptor, from the spec.
struct virtq_desc
{
    uint64_t addr;
    uint32_t len;
    uint16_t flags;
    uint16_t next;
};
#define VRING_DESC_F_NEXT 1  // chained with another descriptor
#define VRING_DESC_F_WRITE 2 // device writes (vs read)

// the (entire) avail ring, from the spec.
struct virtq_avail
{
    uint16_t flags;     // always zero
    uint16_t idx;       // driver will write ring[idx] next
    uint16_t ring[NUM]; // descriptor numbers of chain heads
    uint16_t unused;
};

// one entry in the "used" ring, with which the
// device tells the driver about completed requests.
struct virtq_used_elem
{
    uint32_t id; // index of start of completed descriptor chain
    uint32_t len;
};

struct virtq_used
{
    uint16_t flags; // always zero
    uint16_t idx;   // device increments when it adds a ring[] entry
    struct virtq_used_elem ring[NUM];
};

// these are specific to virtio block devices, e.g. disks,
// described in Section 5.2 of the spec.

#define VIRTIO_BLK_T_IN 0  // read the disk
#define VIRTIO_BLK_T_OUT 1 // write the disk

// the format of the first descriptor in a disk request.
// to be followed by two more descriptors containing
// the block, and a one-byte status.
struct virtio_blk_req
{
    uint32_t type; // VIRTIO_BLK_T_IN or ..._OUT
    uint32_t reserved;
    uint64_t sector;
};

#endif // DRIVER_H
