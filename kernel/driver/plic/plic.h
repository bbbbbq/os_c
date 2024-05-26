#ifndef PLIC_H
#define PLIC_H

#include "config.h"
#include "uart.h"

// // PLIC base address
// #define PLIC_BASE 0x0C000000

// // PLIC IRQ offsets for UART0 and VIRTIO0
// #define UART0_IRQ 1
// #define VIRTIO0_IRQ 2

// PLIC priority and claim offsets
// #define PLIC_PRIORITY_OFFSET(hart) (PLIC_BASE + 0x0000)
// #define PLIC_PENDING_OFFSET(hart) (PLIC_BASE + 0x1000)
// #define PLIC_MENABLE_OFFSET(hart) (PLIC_BASE + 0x2000 + (hart) * 0x100)
// #define PLIC_SENABLE_OFFSET(hart) (PLIC_BASE + 0x2080 + (hart) * 0x100)
// #define PLIC_MCLAIM_OFFSET(hart) (PLIC_BASE + 0x200004 + (hart) * 0x2000)
// #define PLIC_SCLAIM_OFFSET(hart) (PLIC_BASE + 0x201004 + (hart) * 0x2000)

// Function declarations
void plic_init();
int plic_claim();
void plic_complete(int irq);

#endif
