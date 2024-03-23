.align 3
.section .data
.global _num_app
_num_app:
    .quad 3
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_2_end
.global _app_names
_app_names:
    .string "hello_word.elf"
.section .data
.global app_0_start
.global app_0_end
.align 3
app_0_start:
    .incbin "../user/build/hello_word.elf"
app_0_end:
    .string "sret.elf"
.section .data
.global app_1_start
.global app_1_end
.align 3
app_1_start:
    .incbin "../user/build/sret.elf"
app_1_end:
    .string "test.elf"
.section .data
.global app_2_start
.global app_2_end
.align 3
app_2_start:
    .incbin "../user/build/test.elf"
app_2_end: