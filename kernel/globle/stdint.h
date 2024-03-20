#ifndef MY_STDINT_H
#define MY_STDINT_H

/* 确定各种整数类型 */
typedef signed char int8_t;
typedef unsigned char uint8_t;

typedef short int int16_t;
typedef unsigned short int uint16_t;

typedef int int32_t;
typedef unsigned int uint32_t;

/* 在64位平台上，long long通常被定义为64位 */
typedef long long int int64_t;
typedef unsigned long long int uint64_t;

/* 最小和最大指针宽度的整数类型 */
typedef long long int intptr_t;
typedef unsigned long long int uintptr_t;

/* 最大宽度的整数类型 */
typedef long long int intmax_t;
typedef unsigned long long int uintmax_t;

/* 定义布尔类型 */
typedef enum {
    false = 0,
    true = 1
} bool;

#endif /* MY_STDINT_H */