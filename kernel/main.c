// #include "console.h"
// #include "stdint.h"
// #include "interrupt.h"
// void sbi_console_putchar(int ch) {
//     register long a0 asm("a0") = ch; // 将字符存储在 a0 寄存器
//     register long a7 asm("a7") = 0x01; // SBI 控制台输出的服务编号存储在 a7 寄存器
//     asm volatile (
//         "ecall" // 执行环境调用，调用 SBI 服务
//         : "+r" (a0) // 输入+输出操作数：字符数据
//         : "r" (a7) // 输入操作数：SBI 服务编号
//         : "memory" // 告诉编译器内存可能被更改，防止优化
//     );
// }

#include "console.h"
int main_os()
{
    //clear_bss();
    // print_char(98);
    // print_char(99);
    //init_interrupt();
    // __asm__ volatile ("ebreak");    
    put_char('a');
}
