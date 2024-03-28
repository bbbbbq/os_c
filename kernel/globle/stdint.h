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

#define READ_CSR(reg) ({ \
    unsigned long __val; \
    asm volatile ("csrr %0, " #reg : "=r"(__val)); \
    __val; \
})

#define WRITE_CSR(reg, val) ({ \
    asm volatile ("csrw " #reg ", %0" :: "rK"(val)); \
})

#define SSTATUS_SIE_BIT (1UL << 1) // Supervisor Interrupt Enable bit in sstatus
#define SIE_SSIE_BIT (1UL << 1)    // Software Interrupt Enable for S-mode
#define SIE_STIE_BIT (1UL << 5)    // Timer Interrupt Enable for S-mode
#define SIE_SEIE_BIT (1UL << 9)    // External Interrupt Enable for S-mode

#endif // _STDINT_H
