    .section .text.entry
    .globl _start
_start:
    la sp, bootstacktop
    call main_os
    .section .bss.stack
    .align 12
    .global bootstack
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:
