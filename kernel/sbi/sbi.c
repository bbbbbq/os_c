#include "sbi.h"
#include "stdint.h"
void clear_bss(void) {
    char* start = &sbss;
    char* end = &ebss;
    while (start < end) {
        *start++ = 0;
    }
}

static inline uint64_t sbi_call(uint64_t which, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret;
    __asm__ volatile ("ecall"
                      : "=r"(ret)
                      : "r"(arg0), "r"(arg1), "r"(arg2), "r"(which)
                      : "memory");
    return ret;
}

void console_putchar(uint64_t ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}

uint64_t console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}

void shutdown(void) {
    sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    while(1) {} // Loop forever as `unreachable` equivalent
}

void set_timer(uint64_t stime_value) {
    // Assuming a 64-bit environment for simplicity
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}

void clear_ipi(void) {
    sbi_call(SBI_CLEAR_IPI, 0, 0, 0);
}

void send_ipi(const uint64_t hart_mask) {
    sbi_call(SBI_SEND_IPI, (uint64_t)&hart_mask, 0, 0);
}

void remote_fence_i(const uint64_t hart_mask) {
    sbi_call(SBI_REMOTE_FENCE_I, (uint64_t)&hart_mask, 0, 0);
}

void remote_sfence_vma(const uint64_t hart_mask, uint64_t start, uint64_t size) {
    sbi_call(SBI_REMOTE_SFENCE_VMA, (uint64_t)&hart_mask, start, size);
}

// void remote_sfence_vma_asid(const uint64_t hart_mask, uint64_t start, uint64_t size, uint64_t asid) {
//     sbi_call(SBI_REMOTE_SFENCE_VMA_ASID, (uint64_t)&hart_mask, start, size, asid);
// }


