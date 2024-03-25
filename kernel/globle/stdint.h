#ifndef _STDINT_H
#define _STDINT_H

// 定义有符号整数
typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;
typedef long int int64_t;

#define SSTATUS_SPP (1UL << 8)  // Supervisor Previous Privilege, 第8位
#define SSTATUS_SPIE (1UL << 5) // Supervisor Previous Interrupt Enable, 第5位

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


// uint64_t read_scause() 
// {
//     uint64_t scause;
//     asm volatile("csrr %0, scause" : "=r"(scause));
//     return scause;
// }
#endif // _STDINT_H
