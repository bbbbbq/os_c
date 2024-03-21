#ifndef SBI_H
#define SBI_H

void console_putchar(uint64_t ch);
uint64_t console_getchar(void);
uint64_t sbi_shutdown(void);
#endif