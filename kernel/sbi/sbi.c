#include "stdint.h"



#define SBI_SET_TIMER 0
#define SBI_CONSOLE_PUTCHAR 1
#define SBI_CONSOLE_GETCHAR 2
#define SBI_CLEAR_IPI 3
#define SBI_SEND_IPI 4
#define SBI_REMOTE_FENCE_I 5
#define SBI_REMOTE_SFENCE_VMA 6
#define SBI_REMOTE_SFENCE_VMA_ASID 7
#define SBI_SHUTDOWN 8


static inline uint64_t sbi_call(long which, long arg0, long arg1, long arg2) {
    register long a0 asm("a0") = arg0;
    register long a1 asm("a1") = arg1;
    register long a2 asm("a2") = arg2;
    register long a7 asm("a7") = which;

    asm volatile("ecall"
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");

    return a0;
}

void console_putchar(uint64_t ch) {
    sbi_call(0x01, ch, 0, 0);
}

uint64_t console_getchar(void) {
    return sbi_call(0x02, 0, 0, 0);
}

uint64_t sbi_shutdown(void) {
    return sbi_call(0x08, 0, 0, 0);
}

uint64_t sbi_set_timer(uint64_t stime_value)
{
    return sbi_call(0x00,stime_value,0,0);
}