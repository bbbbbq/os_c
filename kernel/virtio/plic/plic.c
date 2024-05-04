#include "plic.h"
#include "config.h"

static int cpuid()
{
    return 0;
}

void plic_init()
{
    printk("plic_init_start\n");
    *(uint32_t *)(PLIC + UART0_IRQ * 4) = 1;
    *(uint32_t *)(PLIC + VIRTIO0_IRQ * 4) = 1;
    int hart = cpuid();
    *(uint32_t *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    *(uint32_t *)PLIC_SPRIORITY(hart) = 0;
    printk("plic_init_end\n");
}

int plic_claim()
{
    int hart = cpuid();
    int irq = *(uint32_t *)PLIC_SCLAIM(hart);
    return irq;
}

void plic_complete(int irq)
{
    int hart = cpuid();
    *(uint32_t *)PLIC_SCLAIM(hart) = irq;
}
