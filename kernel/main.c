// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
#include "trap.h"
#include "batch.h"
//#include "memory.h"
extern char sbss;
extern char ebss; 
void clear_bss(void) 
{
    //print_str("clear_bss\n");
    char* start = &sbss;
    char* end = &ebss;
    while (start < end)
    {
        *start = 0;
        start++;
    }
}

static inline uint64_t read_sie(void) 
{
    uint64_t value;
    asm volatile("csrr %0, sie" : "=r" (value) :: "memory");
    return value;
}
extern char end;
void main_os()
{
    clear_bss();
    // console_putchar('1');
    init_trap();
    // print_uint64((uint64_t)&end);
    // print_str("\n");
    //init_app();
    uint64_t sstatus;
    asm volatile("csrr %0, sstatus" : "=r"(sstatus)); // 读取当前sstatus值
    sstatus &= ~(1UL << 8); // 清除SPP位，设置为0以返回U-mode
    sstatus |= (1UL << 5); // 设置SPIE位，恢复中断使能
    asm volatile("csrw sstatus, %0" : : "r"(sstatus)); // 写回修改后的sstatus值
    
    // __asm__ volatile ("ebreak");
    ASSERT(0);
    while(1);
}
