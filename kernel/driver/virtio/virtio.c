#include "virtio.h"

uint32_t read_reg(uint32_t *addr)
{
    return *(volatile uint32_t *)addr;
}

// Helper function to write MMIO register
void write_reg(uint32_t *addr, uint32_t val)
{
    *(volatile uint32_t *)addr = val;
}