.align 3
.section .data
.global _num_app
_num_app:
    .quad 3
    .quad app_0_start
    .quad app_0_end
    .quad app_1_start
    .quad app_1_end
    .quad app_2_start
    .quad app_2_end
.global _app_names
_app_names:
    .string "02t"
.section .data
.global app_0_start
.global app_0_end
.align 3
app_0_start:
    .incbin "../../user/target/00t.bin"
app_0_end:
    .string "00t"
.section .data
.global app_1_start
.global app_1_end
.align 3
app_1_start:
    .incbin "../../user/target/01t.bin"
app_1_end:
    .string "01t"
.section .data
.global app_2_start
.global app_2_end
.align 3
app_2_start:
    .incbin "../../user/target/02t.bin"
app_2_end:
