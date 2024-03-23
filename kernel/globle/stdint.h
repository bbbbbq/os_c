#ifndef _STDINT_H
#define _STDINT_H

// 定义有符号整数
typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;
typedef long int int64_t;

// 定义无符号整数
typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long int uint64_t;

// 定义指针大小的整数
typedef long int intptr_t;
typedef unsigned long int uintptr_t;

// 最小和最大值
#define INT8_MIN (-128)
#define INT16_MIN (-32767-1)
#define INT32_MIN (-2147483647-1)
#define INT64_MIN (-9223372036854775807L-1)

#define INT8_MAX (127)
#define INT16_MAX (32767)
#define INT32_MAX (2147483647)
#define INT64_MAX (9223372036854775807L)

#define UINT8_MAX (255U)
#define UINT16_MAX (65535U)
#define UINT32_MAX (4294967295U)
#define UINT64_MAX (18446744073709551615UL)


static inline uint64_t r_scause(void) {
    uint64_t value;
    asm volatile("csrr %0, scause" : "=r" (value) :: "memory");
    return value;
}

static inline uint64_t r_stval(void) {
    uint64_t value;
    asm volatile("csrr %0, stval" : "=r" (value) :: "memory");
    return value;
}

#endif // _STDINT_H
