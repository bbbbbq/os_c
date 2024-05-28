#include "uart.h"
#include "config.h"

static int cpuid()
{
    return 0;
}

void plic_init()
{
  // set desired IRQ priorities non-zero (otherwise disabled).
  int hart = cpuid();
  *(uint32_t *)(PLIC + VIRTIO0_IRQ * 4) = 1;
  // set uart's enable bit for this hart's S-mode.
  *(uint32_t *)PLIC_SENABLE(hart) = (1 << VIRTIO0_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32_t *)PLIC_SPRIORITY(hart) = 0;
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