#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    while (*str) {
        console_putchar((uint64_t)(*str));
        str++;
    }
}

void reverse_str(char* str, int length) {
    int start = 0;
    int end = length - 1;
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        start++;
        end--;
    }
}

void print_uint32(uint32_t value) {
    char buffer[12];
    int i = 0;
    if (value == 0) {
        buffer[i++] = '0';
    }
    while (value != 0) {
        int digit = value % 10;
        buffer[i++] = digit + '0';
        value /= 10;
    }
    buffer[i] = '\0';
    reverse_str(buffer, i);
    print_str(buffer);
}

void print_uint64(uint64_t value) {
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    if (value == 0) {
        buffer[i++] = '0';
    }
    while (value != 0) {
        int digit = value % 10;
        buffer[i++] = digit + '0';
        value /= 10;
    }
    buffer[i] = '\0';
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
}