
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
stext():
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:4
    .section .text.entry
    .globl _start
_start:
    la sp, bootstacktop
    80200000:	00005117          	auipc	sp,0x5
    80200004:	00010113          	mv	sp,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:5
    call main_os
    80200008:	024000ef          	jal	ra,8020002c <main_os>

000000008020000c <sbi_console_putchar>:
sbi_console_putchar():
/home/caigoubencai/Desktop/os_c/kernel/main.c:5
// #include "console.h"
// #include "stdint.h"
// #include "interrupt.h"

void sbi_console_putchar(int ch) {
    8020000c:	1101                	addi	sp,sp,-32
    8020000e:	ec22                	sd	s0,24(sp)
    80200010:	1000                	addi	s0,sp,32
    80200012:	87aa                	mv	a5,a0
    80200014:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/main.c:6
    register long a0 asm("a0") = ch; // 将字符存储在 a0 寄存器
    80200018:	fec42783          	lw	a5,-20(s0)
    8020001c:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c/kernel/main.c:7
    register long a7 asm("a7") = 0x01; // SBI 控制台输出的服务编号存储在 a7 寄存器
    8020001e:	4885                	li	a7,1
/home/caigoubencai/Desktop/os_c/kernel/main.c:8
    asm volatile (
    80200020:	00000073          	ecall
/home/caigoubencai/Desktop/os_c/kernel/main.c:14
        "ecall" // 执行环境调用，调用 SBI 服务
        : "+r" (a0) // 输入+输出操作数：字符数据
        : "r" (a7) // 输入操作数：SBI 服务编号
        : "memory" // 告诉编译器内存可能被更改，防止优化
    );
}
    80200024:	0001                	nop
    80200026:	6462                	ld	s0,24(sp)
    80200028:	6105                	addi	sp,sp,32
    8020002a:	8082                	ret

000000008020002c <main_os>:
main_os():
/home/caigoubencai/Desktop/os_c/kernel/main.c:18

int cnt=0;
int main_os()
{
    8020002c:	1141                	addi	sp,sp,-16
    8020002e:	e406                	sd	ra,8(sp)
    80200030:	e022                	sd	s0,0(sp)
    80200032:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/main.c:19
    cnt++;
    80200034:	00005797          	auipc	a5,0x5
    80200038:	fcc78793          	addi	a5,a5,-52 # 80205000 <cnt>
    8020003c:	439c                	lw	a5,0(a5)
    8020003e:	2785                	addiw	a5,a5,1
    80200040:	0007871b          	sext.w	a4,a5
    80200044:	00005797          	auipc	a5,0x5
    80200048:	fbc78793          	addi	a5,a5,-68 # 80205000 <cnt>
    8020004c:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/main.c:20
    sbi_console_putchar('0'+cnt);
    8020004e:	00005797          	auipc	a5,0x5
    80200052:	fb278793          	addi	a5,a5,-78 # 80205000 <cnt>
    80200056:	439c                	lw	a5,0(a5)
    80200058:	0307879b          	addiw	a5,a5,48
    8020005c:	2781                	sext.w	a5,a5
    8020005e:	853e                	mv	a0,a5
    80200060:	fadff0ef          	jal	ra,8020000c <sbi_console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/main.c:21
    sbi_console_putchar('\n');
    80200064:	4529                	li	a0,10
    80200066:	fa7ff0ef          	jal	ra,8020000c <sbi_console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/main.c:23
    //while(1);
}
    8020006a:	0001                	nop
    8020006c:	853e                	mv	a0,a5
    8020006e:	60a2                	ld	ra,8(sp)
    80200070:	6402                	ld	s0,0(sp)
    80200072:	0141                	addi	sp,sp,16
    80200074:	8082                	ret
	...
