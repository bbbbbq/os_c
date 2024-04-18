#ifndef MY_STRING_H
#define MY_STRING_H

#include "stdint.h"

// 类型定义
typedef uint8_t u8;   // 保证u8是无符号8位整数
typedef uint32_t u32; // 保证u32是无符号32位整数
typedef int32_t i32;  // 保证i32是有符号32位整数

int strlen_t(const char *src);
void memcpy_t(u8 *dest, const u8 *src, u32 len);
int memcmp_t(const void *ptr1, const void *ptr2, u32 num);
void memmove_t(u8 *dest, const u8 *src, u32 len);
void memset_t(void *dest, u8 val, u32 len);
void bzero_t(void *dest, u32 len);
int strcmp_t(const char *str1, const char *str2);
char *strcpy_t(char *dest, const char *src);
char *strcat_t(char *dest, const char *src);
void memcpy(u8 *dest, const u8 *src, u32 len);
void memset(void *dest, u8 val, u32 len);
int memcmp(const void *ptr1, const void *ptr2, size_t num);
void *memmove(void *dest, const void *src, size_t n);
#endif // MY_STRING_H