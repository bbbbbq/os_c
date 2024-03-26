.align 3
.section .data
.global _num_app
_num_app:
    .quad 1
    .quad app_0_start
    .quad app_0_end
.global _app_names
_app_names:
    .string "02t.elf"
.section .data
.global app_0_start
.global app_0_end
.align 3
app_0_start:
    .incbin "../../user/target/02t.elf"
app_0_end: