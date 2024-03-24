.align 3
.section .data
.global app_infomation
app_infomation:
    .quad 3
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_0_end
    .quad app_1_end
    .quad app_2_end
.global _app_names
_app_names:
    .string "hello_word"
.section .data
.global app_0_start
.global app_0_end
.align 3
app_0_start:
    .incbin "/home/caigoubencai/Desktop/os_c/user/build/00.bin"
app_0_end:
    .string "sret.elf"
.section .data
.global app_1_start
.global app_1_end
.align 3
app_1_start:
    .incbin "/home/caigoubencai/Desktop/os_c/user/build/01.bin"
app_1_end:
    .string "test.elf"
.section .data
.global app_2_start
.global app_2_end
.align 3
app_2_start:
    .incbin "/home/caigoubencai/Desktop/os_c/user/build/02.bin"
app_2_end:
