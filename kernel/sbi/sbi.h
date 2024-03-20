#ifndef SBI_H
#define SBI_H
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


extern char sbss; // BSS 段开始
extern char ebss; // BSS 段结束

// void print_char(char ch);
// void print(const char* str);
void clear_bss(void);
// void print_uint64(uint64_t value);

void console_putchar(uint64_t ch);
uint64_t console_getchar(void);
void shutdown(void) __attribute__((noreturn));
void set_timer(uint64_t stime_value);
void clear_ipi(void);
void send_ipi(const uint64_t hart_mask);
void remote_fence_i(const uint64_t hart_mask);
void remote_sfence_vma(const uint64_t hart_mask, uint64_t start, uint64_t size);
//void remote_sfence_vma_asid(const uint64_t hart_mask, uint64_t start, uint64_t size, uint64_t asid);

#endif