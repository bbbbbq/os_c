#include "interrupt.h"
#include "stdint.h"
#include "console.h"
// 假设 printf 作为简化版的 println! 宏的替代
extern uintptr_t __alltraps;
// 声明 trap_handler 为静态函数，仅在本文件内使用

void init_interrupt(void) 
{
    //uintptr_t regValue; // 用于存储寄存器的值
    //asm volatile("mv %0, a0" : "=r"(regValue));
    asm volatile ("csrw sscratch,%0" :: "r"((uintptr_t)0));
    //print("\n");
    asm volatile ("csrw stvec, %0" :: "r"((uintptr_t)__alltraps));
    //print("\n");
    //print("++++ setup interrupt! ++++\n");

}

void c_trap(TrapFrame tf)
{
    puts_str("rust_trap\n");
    tf.sepc +=16;
}
