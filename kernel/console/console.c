#include "console.h"
#include "sbi.h"
void put_char(char ch) {
    console_putchar((unsigned long)ch);
}

// 输出一个字符串
void puts_str(const char *s) {
    while (*s) { // 循环直到字符串终止符 '\0'
        put_char(*s++); // 输出当前字符并将指针移动到下一个字符
    }
}