#ifndef PLIC_H
#define PLIC_H


#define PLIC_BASE 0x0C000000
#define PLIC_PRIORITY_OFFSET   0x0000      // 中断优先级基址
#define PLIC_PENDING_OFFSET    0x1000      // 挂起位数组基址
#define PLIC_MENABLE_OFFSET(hart) (0x2000 + (hart) * 0x100) // 每个hart的中断使能数组基址
#define PLIC_SENABLE_OFFSET(hart) (0x2080 + (hart) * 0x100) // 每个hart的中断使能数组基址（监督模式）
#define PLIC_MCLAIM_OFFSET(hart)  (0x200004 + (hart) * 0x2000) // 每个hart的中断认领/完成寄存器基址
#define PLIC_SCLAIM_OFFSET(hart)  (0x201004 + (hart) * 0x2000) // 每个hart的中断认领/完成寄存器基址（监督模式）
#define PLIC_MTHRESHOLD_OFFSET(hart) (0x200000 + (hart) * 0x2000) // 每个hart的中断门限寄存器基址
#define PLIC_STHRESHOLD_OFFSET(hart) (0x201000 + (hart) * 0x2000) // 每个hart的中断门限寄存器基址（监督模式）
#define PLIC_REG32(address) (*(volatile uint32_t *)(address))
#define PLIC_PRIORITY(irq) (PLIC_BASE + PLIC_PRIORITY_OFFSET + (irq) * 4)

void plic_init();
int plic_claim();
void plic_complete(int irq);

#endif