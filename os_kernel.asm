
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
stext():
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:4
    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    80200000:	00022117          	auipc	sp,0x22
    80200004:	00010113          	mv	sp,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:5
    call main_os
    80200008:	159020ef          	jal	ra,80202960 <main_os>
	...

0000000080201000 <__alltraps>:
__alltraps():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:13
  .section .text.trampoline
  .globl __alltraps
  .globl __restore
  .align 2
__alltraps:
  csrrw sp, sscratch, sp
    80201000:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:16
  # now sp->*TrapContext in user space, sscratch->user stack
  # save other general purpose registers
  sd x1, 1*8(sp)
    80201004:	e406                	sd	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:18
  # skip sp(x2), we will save it later
  sd x3, 3*8(sp)
    80201006:	ec0e                	sd	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:25
  # save x5~x31
  .set n, 5
  .rept 27
    SAVE_GP %n
    .set n, n+1
  .endr
    80201008:	f416                	sd	t0,40(sp)
    8020100a:	f81a                	sd	t1,48(sp)
    8020100c:	fc1e                	sd	t2,56(sp)
    8020100e:	e0a2                	sd	s0,64(sp)
    80201010:	e4a6                	sd	s1,72(sp)
    80201012:	e8aa                	sd	a0,80(sp)
    80201014:	ecae                	sd	a1,88(sp)
    80201016:	f0b2                	sd	a2,96(sp)
    80201018:	f4b6                	sd	a3,104(sp)
    8020101a:	f8ba                	sd	a4,112(sp)
    8020101c:	fcbe                	sd	a5,120(sp)
    8020101e:	e142                	sd	a6,128(sp)
    80201020:	e546                	sd	a7,136(sp)
    80201022:	e94a                	sd	s2,144(sp)
    80201024:	ed4e                	sd	s3,152(sp)
    80201026:	f152                	sd	s4,160(sp)
    80201028:	f556                	sd	s5,168(sp)
    8020102a:	f95a                	sd	s6,176(sp)
    8020102c:	fd5e                	sd	s7,184(sp)
    8020102e:	e1e2                	sd	s8,192(sp)
    80201030:	e5e6                	sd	s9,200(sp)
    80201032:	e9ea                	sd	s10,208(sp)
    80201034:	edee                	sd	s11,216(sp)
    80201036:	f1f2                	sd	t3,224(sp)
    80201038:	f5f6                	sd	t4,232(sp)
    8020103a:	f9fa                	sd	t5,240(sp)
    8020103c:	fdfe                	sd	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:27
  # we can use t0/t1/t2 freely, because they have been saved in TrapContext
  csrr t0, sstatus
    8020103e:	100022f3          	csrr	t0,sstatus
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:28
  csrr t1, sepc
    80201042:	14102373          	csrr	t1,sepc
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:29
  sd t0, 32*8(sp)
    80201046:	e216                	sd	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:30
  sd t1, 33*8(sp)
    80201048:	e61a                	sd	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:32
  # read user stack from sscratch and save it in TrapContext
  csrr t2, sscratch
    8020104a:	140023f3          	csrr	t2,sscratch
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:33
  sd t2, 2*8(sp)
    8020104e:	e81e                	sd	t2,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:35
  # load kernel_satp into t0
  ld t0, 34*8(sp)
    80201050:	62d2                	ld	t0,272(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:37
  # load trap_handler into t1
  ld t1, 36*8(sp)
    80201052:	7312                	ld	t1,288(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:39
  # move to kernel_sp
  ld sp, 35*8(sp)
    80201054:	6172                	ld	sp,280(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:41
  # switch to kernel space
  csrw satp, t0
    80201056:	18029073          	csrw	satp,t0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:42
  sfence.vma
    8020105a:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:44
  # jump to trap_handler
  jr t1
    8020105e:	8302                	jr	t1

0000000080201060 <__restore>:
__restore():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:49

__restore:
  # a0: *TrapContext in user space(Constant); a1: user space token
  # switch to user space
  csrw satp, a1
    80201060:	18059073          	csrw	satp,a1
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:50
  sfence.vma
    80201064:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:51
  csrw sscratch, a0
    80201068:	14051073          	csrw	sscratch,a0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:52
  mv sp, a0
    8020106c:	812a                	mv	sp,a0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:55
  # now sp points to TrapContext in user space, start restoring based on it
  # restore sstatus/sepc
  ld t0, 32*8(sp)
    8020106e:	6292                	ld	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:56
  ld t1, 33*8(sp)
    80201070:	6332                	ld	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:57
  csrw sstatus, t0
    80201072:	10029073          	csrw	sstatus,t0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:58
  csrw sepc, t1
    80201076:	14131073          	csrw	sepc,t1
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:60
  # restore general purpose registers except x0/sp/tp
  ld x1, 1*8(sp)
    8020107a:	60a2                	ld	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:61
  ld x3, 3*8(sp)
    8020107c:	61e2                	ld	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:66
  .set n, 5
  .rept 27
    LOAD_GP %n
    .set n, n+1
  .endr
    8020107e:	72a2                	ld	t0,40(sp)
    80201080:	7342                	ld	t1,48(sp)
    80201082:	73e2                	ld	t2,56(sp)
    80201084:	6406                	ld	s0,64(sp)
    80201086:	64a6                	ld	s1,72(sp)
    80201088:	6546                	ld	a0,80(sp)
    8020108a:	65e6                	ld	a1,88(sp)
    8020108c:	7606                	ld	a2,96(sp)
    8020108e:	76a6                	ld	a3,104(sp)
    80201090:	7746                	ld	a4,112(sp)
    80201092:	77e6                	ld	a5,120(sp)
    80201094:	680a                	ld	a6,128(sp)
    80201096:	68aa                	ld	a7,136(sp)
    80201098:	694a                	ld	s2,144(sp)
    8020109a:	69ea                	ld	s3,152(sp)
    8020109c:	7a0a                	ld	s4,160(sp)
    8020109e:	7aaa                	ld	s5,168(sp)
    802010a0:	7b4a                	ld	s6,176(sp)
    802010a2:	7bea                	ld	s7,184(sp)
    802010a4:	6c0e                	ld	s8,192(sp)
    802010a6:	6cae                	ld	s9,200(sp)
    802010a8:	6d4e                	ld	s10,208(sp)
    802010aa:	6dee                	ld	s11,216(sp)
    802010ac:	7e0e                	ld	t3,224(sp)
    802010ae:	7eae                	ld	t4,232(sp)
    802010b0:	7f4e                	ld	t5,240(sp)
    802010b2:	7fee                	ld	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:68
  # back to user stack
  ld sp, 2*8(sp)
    802010b4:	6142                	ld	sp,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:69
  sret
    802010b6:	10200073          	sret
	...

0000000080202000 <port_write>:
port_write():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:9
#include "stdarg.h"

/**
 *  @brief: 调用sbi输出函数，参数为固定要求，由_vprintk & _vprints调用
 */
void port_write(char *buf) {
    80202000:	1101                	addi	sp,sp,-32
    80202002:	ec06                	sd	ra,24(sp)
    80202004:	e822                	sd	s0,16(sp)
    80202006:	1000                	addi	s0,sp,32
    80202008:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:10
    while(*buf != 0){
    8020200c:	a821                	j	80202024 <port_write+0x24>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:11
        console_putchar(*buf++);
    8020200e:	fe843783          	ld	a5,-24(s0)
    80202012:	00178713          	addi	a4,a5,1
    80202016:	fee43423          	sd	a4,-24(s0)
    8020201a:	0007c783          	lbu	a5,0(a5)
    8020201e:	853e                	mv	a0,a5
    80202020:	2cc010ef          	jal	ra,802032ec <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:10
    while(*buf != 0){
    80202024:	fe843783          	ld	a5,-24(s0)
    80202028:	0007c783          	lbu	a5,0(a5)
    8020202c:	f3ed                	bnez	a5,8020200e <port_write+0xe>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:13
    }
}
    8020202e:	0001                	nop
    80202030:	0001                	nop
    80202032:	60e2                	ld	ra,24(sp)
    80202034:	6442                	ld	s0,16(sp)
    80202036:	6105                	addi	sp,sp,32
    80202038:	8082                	ret

000000008020203a <mini_strlen>:
mini_strlen():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:17


static unsigned int mini_strlen(const char *s)
{
    8020203a:	7179                	addi	sp,sp,-48
    8020203c:	f422                	sd	s0,40(sp)
    8020203e:	1800                	addi	s0,sp,48
    80202040:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:18
    unsigned int len = 0;
    80202044:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19
    while (s[len] != '\0') len++;
    80202048:	a031                	j	80202054 <mini_strlen+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19 (discriminator 2)
    8020204a:	fec42783          	lw	a5,-20(s0)
    8020204e:	2785                	addiw	a5,a5,1
    80202050:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19 (discriminator 1)
    80202054:	fec46783          	lwu	a5,-20(s0)
    80202058:	fd843703          	ld	a4,-40(s0)
    8020205c:	97ba                	add	a5,a5,a4
    8020205e:	0007c783          	lbu	a5,0(a5)
    80202062:	f7e5                	bnez	a5,8020204a <mini_strlen+0x10>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:20
    return len;
    80202064:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:21
}
    80202068:	853e                	mv	a0,a5
    8020206a:	7422                	ld	s0,40(sp)
    8020206c:	6145                	addi	sp,sp,48
    8020206e:	8082                	ret

0000000080202070 <mini_itoa>:
mini_itoa():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:26

static unsigned int mini_itoa(
    long value, unsigned int radix, unsigned int uppercase,
    unsigned int unsig, char *buffer, unsigned int zero_pad)
{
    80202070:	715d                	addi	sp,sp,-80
    80202072:	e4a2                	sd	s0,72(sp)
    80202074:	0880                	addi	s0,sp,80
    80202076:	fca43423          	sd	a0,-56(s0)
    8020207a:	fae43823          	sd	a4,-80(s0)
    8020207e:	873e                	mv	a4,a5
    80202080:	87ae                	mv	a5,a1
    80202082:	fcf42223          	sw	a5,-60(s0)
    80202086:	87b2                	mv	a5,a2
    80202088:	fcf42023          	sw	a5,-64(s0)
    8020208c:	87b6                	mv	a5,a3
    8020208e:	faf42e23          	sw	a5,-68(s0)
    80202092:	87ba                	mv	a5,a4
    80202094:	faf42c23          	sw	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:27
    char *pbuffer = buffer;
    80202098:	fb043783          	ld	a5,-80(s0)
    8020209c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:28
    int negative  = 0;
    802020a0:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:32
    unsigned int i, len;

    /* No support for unusual radixes. */
    if (radix > 16) return 0;
    802020a4:	fc442783          	lw	a5,-60(s0)
    802020a8:	0007871b          	sext.w	a4,a5
    802020ac:	47c1                	li	a5,16
    802020ae:	00e7f463          	bgeu	a5,a4,802020b6 <mini_itoa+0x46>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:32 (discriminator 1)
    802020b2:	4781                	li	a5,0
    802020b4:	aae9                	j	8020228e <mini_itoa+0x21e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:34

    if (value < 0 && !unsig) {
    802020b6:	fc843783          	ld	a5,-56(s0)
    802020ba:	0007df63          	bgez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:34 (discriminator 1)
    802020be:	fbc42783          	lw	a5,-68(s0)
    802020c2:	2781                	sext.w	a5,a5
    802020c4:	eb91                	bnez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:35
        negative = 1;
    802020c6:	4785                	li	a5,1
    802020c8:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:36
        value    = -value;
    802020cc:	fc843783          	ld	a5,-56(s0)
    802020d0:	40f007b3          	neg	a5,a5
    802020d4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:41
    }

    /* This builds the string back to front ... */
    do {
        int digit = 0;
    802020d8:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:42
        if (unsig) {
    802020dc:	fbc42783          	lw	a5,-68(s0)
    802020e0:	2781                	sext.w	a5,a5
    802020e2:	cb91                	beqz	a5,802020f6 <mini_itoa+0x86>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:43
            digit = (unsigned long)value % (unsigned)radix;
    802020e4:	fc843703          	ld	a4,-56(s0)
    802020e8:	fc446783          	lwu	a5,-60(s0)
    802020ec:	02f777b3          	remu	a5,a4,a5
    802020f0:	fcf42e23          	sw	a5,-36(s0)
    802020f4:	a809                	j	80202106 <mini_itoa+0x96>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:45
        } else {
            digit = value % radix;
    802020f6:	fc446783          	lwu	a5,-60(s0)
    802020fa:	fc843703          	ld	a4,-56(s0)
    802020fe:	02f767b3          	rem	a5,a4,a5
    80202102:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47
        }
        *(pbuffer++) =
    80202106:	fdc42783          	lw	a5,-36(s0)
    8020210a:	0007871b          	sext.w	a4,a5
    8020210e:	47a5                	li	a5,9
    80202110:	00e7cb63          	blt	a5,a4,80202126 <mini_itoa+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:48 (discriminator 1)
            (digit < 10 ? '0' + digit :
    80202114:	fdc42783          	lw	a5,-36(s0)
    80202118:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 1)
        *(pbuffer++) =
    8020211c:	0307879b          	addiw	a5,a5,48
    80202120:	0ff7f713          	andi	a4,a5,255
    80202124:	a025                	j	8020214c <mini_itoa+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49
             (uppercase ? 'A' : 'a') + digit - 10);
    80202126:	fc042783          	lw	a5,-64(s0)
    8020212a:	2781                	sext.w	a5,a5
    8020212c:	c781                	beqz	a5,80202134 <mini_itoa+0xc4>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 1)
    8020212e:	04100793          	li	a5,65
    80202132:	a019                	j	80202138 <mini_itoa+0xc8>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 2)
    80202134:	06100793          	li	a5,97
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 4)
    80202138:	fdc42703          	lw	a4,-36(s0)
    8020213c:	0ff77713          	andi	a4,a4,255
    80202140:	9fb9                	addw	a5,a5,a4
    80202142:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 4)
        *(pbuffer++) =
    80202146:	37d9                	addiw	a5,a5,-10
    80202148:	0ff7f713          	andi	a4,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 3)
    8020214c:	fe843783          	ld	a5,-24(s0)
    80202150:	00178693          	addi	a3,a5,1
    80202154:	fed43423          	sd	a3,-24(s0)
    80202158:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:50 (discriminator 3)
        if (unsig) {
    8020215c:	fbc42783          	lw	a5,-68(s0)
    80202160:	2781                	sext.w	a5,a5
    80202162:	cb91                	beqz	a5,80202176 <mini_itoa+0x106>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:51
            value = (unsigned long) value / (unsigned) radix;
    80202164:	fc843703          	ld	a4,-56(s0)
    80202168:	fc446783          	lwu	a5,-60(s0)
    8020216c:	02f757b3          	divu	a5,a4,a5
    80202170:	fcf43423          	sd	a5,-56(s0)
    80202174:	a809                	j	80202186 <mini_itoa+0x116>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:53
        } else {
            value /= radix;
    80202176:	fc446783          	lwu	a5,-60(s0)
    8020217a:	fc843703          	ld	a4,-56(s0)
    8020217e:	02f747b3          	div	a5,a4,a5
    80202182:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:55
        }
    } while (value != 0);
    80202186:	fc843783          	ld	a5,-56(s0)
    8020218a:	f7b9                	bnez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57

    for (i = (pbuffer - buffer); i < zero_pad; i++)
    8020218c:	fe843703          	ld	a4,-24(s0)
    80202190:	fb043783          	ld	a5,-80(s0)
    80202194:	40f707b3          	sub	a5,a4,a5
    80202198:	fef42023          	sw	a5,-32(s0)
    8020219c:	a005                	j	802021bc <mini_itoa+0x14c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:58 (discriminator 3)
        *(pbuffer++) = '0';
    8020219e:	fe843783          	ld	a5,-24(s0)
    802021a2:	00178713          	addi	a4,a5,1
    802021a6:	fee43423          	sd	a4,-24(s0)
    802021aa:	03000713          	li	a4,48
    802021ae:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57 (discriminator 3)
    for (i = (pbuffer - buffer); i < zero_pad; i++)
    802021b2:	fe042783          	lw	a5,-32(s0)
    802021b6:	2785                	addiw	a5,a5,1
    802021b8:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57 (discriminator 1)
    802021bc:	fe042703          	lw	a4,-32(s0)
    802021c0:	fb842783          	lw	a5,-72(s0)
    802021c4:	2701                	sext.w	a4,a4
    802021c6:	2781                	sext.w	a5,a5
    802021c8:	fcf76be3          	bltu	a4,a5,8020219e <mini_itoa+0x12e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:60

    if (negative) *(pbuffer++) = '-';
    802021cc:	fe442783          	lw	a5,-28(s0)
    802021d0:	2781                	sext.w	a5,a5
    802021d2:	cb99                	beqz	a5,802021e8 <mini_itoa+0x178>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:60 (discriminator 1)
    802021d4:	fe843783          	ld	a5,-24(s0)
    802021d8:	00178713          	addi	a4,a5,1
    802021dc:	fee43423          	sd	a4,-24(s0)
    802021e0:	02d00713          	li	a4,45
    802021e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:62

    *(pbuffer) = '\0';
    802021e8:	fe843783          	ld	a5,-24(s0)
    802021ec:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:64

    len = (pbuffer - buffer);
    802021f0:	fe843703          	ld	a4,-24(s0)
    802021f4:	fb043783          	ld	a5,-80(s0)
    802021f8:	40f707b3          	sub	a5,a4,a5
    802021fc:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65
    for (i = 0; i < len / 2; i++) {
    80202200:	fe042023          	sw	zero,-32(s0)
    80202204:	a885                	j	80202274 <mini_itoa+0x204>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:66 (discriminator 3)
        char j              = buffer[i];
    80202206:	fe046783          	lwu	a5,-32(s0)
    8020220a:	fb043703          	ld	a4,-80(s0)
    8020220e:	97ba                	add	a5,a5,a4
    80202210:	0007c783          	lbu	a5,0(a5)
    80202214:	fcf40ba3          	sb	a5,-41(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:67 (discriminator 3)
        buffer[i]           = buffer[len - i - 1];
    80202218:	fd842703          	lw	a4,-40(s0)
    8020221c:	fe042783          	lw	a5,-32(s0)
    80202220:	40f707bb          	subw	a5,a4,a5
    80202224:	2781                	sext.w	a5,a5
    80202226:	37fd                	addiw	a5,a5,-1
    80202228:	2781                	sext.w	a5,a5
    8020222a:	1782                	slli	a5,a5,0x20
    8020222c:	9381                	srli	a5,a5,0x20
    8020222e:	fb043703          	ld	a4,-80(s0)
    80202232:	973e                	add	a4,a4,a5
    80202234:	fe046783          	lwu	a5,-32(s0)
    80202238:	fb043683          	ld	a3,-80(s0)
    8020223c:	97b6                	add	a5,a5,a3
    8020223e:	00074703          	lbu	a4,0(a4)
    80202242:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:68 (discriminator 3)
        buffer[len - i - 1] = j;
    80202246:	fd842703          	lw	a4,-40(s0)
    8020224a:	fe042783          	lw	a5,-32(s0)
    8020224e:	40f707bb          	subw	a5,a4,a5
    80202252:	2781                	sext.w	a5,a5
    80202254:	37fd                	addiw	a5,a5,-1
    80202256:	2781                	sext.w	a5,a5
    80202258:	1782                	slli	a5,a5,0x20
    8020225a:	9381                	srli	a5,a5,0x20
    8020225c:	fb043703          	ld	a4,-80(s0)
    80202260:	97ba                	add	a5,a5,a4
    80202262:	fd744703          	lbu	a4,-41(s0)
    80202266:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65 (discriminator 3)
    for (i = 0; i < len / 2; i++) {
    8020226a:	fe042783          	lw	a5,-32(s0)
    8020226e:	2785                	addiw	a5,a5,1
    80202270:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65 (discriminator 1)
    80202274:	fd842783          	lw	a5,-40(s0)
    80202278:	0017d79b          	srliw	a5,a5,0x1
    8020227c:	0007871b          	sext.w	a4,a5
    80202280:	fe042783          	lw	a5,-32(s0)
    80202284:	2781                	sext.w	a5,a5
    80202286:	f8e7e0e3          	bltu	a5,a4,80202206 <mini_itoa+0x196>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:71
    }

    return len;
    8020228a:	fd842783          	lw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:72
}
    8020228e:	853e                	mv	a0,a5
    80202290:	6426                	ld	s0,72(sp)
    80202292:	6161                	addi	sp,sp,80
    80202294:	8082                	ret

0000000080202296 <_putc>:
_putc():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:81
    char *buffer, *pbuffer;
    unsigned int buffer_len;
};

static int _putc(int ch, struct mini_buff *b)
{
    80202296:	1101                	addi	sp,sp,-32
    80202298:	ec22                	sd	s0,24(sp)
    8020229a:	1000                	addi	s0,sp,32
    8020229c:	87aa                	mv	a5,a0
    8020229e:	feb43023          	sd	a1,-32(s0)
    802022a2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:82
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802022a6:	fe043783          	ld	a5,-32(s0)
    802022aa:	6798                	ld	a4,8(a5)
    802022ac:	fe043783          	ld	a5,-32(s0)
    802022b0:	639c                	ld	a5,0(a5)
    802022b2:	40f707b3          	sub	a5,a4,a5
    802022b6:	2781                	sext.w	a5,a5
    802022b8:	2785                	addiw	a5,a5,1
    802022ba:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:83
        b->buffer_len)
    802022be:	fe043783          	ld	a5,-32(s0)
    802022c2:	4b9c                	lw	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:82
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802022c4:	00f76463          	bltu	a4,a5,802022cc <_putc+0x36>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:84
        return 0;
    802022c8:	4781                	li	a5,0
    802022ca:	a02d                	j	802022f4 <_putc+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:85
    *(b->pbuffer++) = ch;
    802022cc:	fe043783          	ld	a5,-32(s0)
    802022d0:	679c                	ld	a5,8(a5)
    802022d2:	00178693          	addi	a3,a5,1
    802022d6:	fe043703          	ld	a4,-32(s0)
    802022da:	e714                	sd	a3,8(a4)
    802022dc:	fec42703          	lw	a4,-20(s0)
    802022e0:	0ff77713          	andi	a4,a4,255
    802022e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:86
    *(b->pbuffer)   = '\0';
    802022e8:	fe043783          	ld	a5,-32(s0)
    802022ec:	679c                	ld	a5,8(a5)
    802022ee:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:87
    return 1;
    802022f2:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:88
}
    802022f4:	853e                	mv	a0,a5
    802022f6:	6462                	ld	s0,24(sp)
    802022f8:	6105                	addi	sp,sp,32
    802022fa:	8082                	ret

00000000802022fc <_puts>:
_puts():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:91

static int _puts(char *s, unsigned int len, struct mini_buff *b)
{
    802022fc:	7139                	addi	sp,sp,-64
    802022fe:	fc22                	sd	s0,56(sp)
    80202300:	0080                	addi	s0,sp,64
    80202302:	fca43c23          	sd	a0,-40(s0)
    80202306:	87ae                	mv	a5,a1
    80202308:	fcc43423          	sd	a2,-56(s0)
    8020230c:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:94
    unsigned int i;

    if (b->buffer_len - (b->pbuffer - b->buffer) - 1 < len)
    80202310:	fc843783          	ld	a5,-56(s0)
    80202314:	4b9c                	lw	a5,16(a5)
    80202316:	02079713          	slli	a4,a5,0x20
    8020231a:	9301                	srli	a4,a4,0x20
    8020231c:	fc843783          	ld	a5,-56(s0)
    80202320:	6794                	ld	a3,8(a5)
    80202322:	fc843783          	ld	a5,-56(s0)
    80202326:	639c                	ld	a5,0(a5)
    80202328:	40f687b3          	sub	a5,a3,a5
    8020232c:	8f1d                	sub	a4,a4,a5
    8020232e:	fd446783          	lwu	a5,-44(s0)
    80202332:	02e7c463          	blt	a5,a4,8020235a <_puts+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:95
        len = b->buffer_len - (b->pbuffer - b->buffer) - 1;
    80202336:	fc843783          	ld	a5,-56(s0)
    8020233a:	4b98                	lw	a4,16(a5)
    8020233c:	fc843783          	ld	a5,-56(s0)
    80202340:	6794                	ld	a3,8(a5)
    80202342:	fc843783          	ld	a5,-56(s0)
    80202346:	639c                	ld	a5,0(a5)
    80202348:	40f687b3          	sub	a5,a3,a5
    8020234c:	2781                	sext.w	a5,a5
    8020234e:	40f707bb          	subw	a5,a4,a5
    80202352:	2781                	sext.w	a5,a5
    80202354:	37fd                	addiw	a5,a5,-1
    80202356:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98

    /* Copy to buffer */
    for (i = 0; i < len; i++) *(b->pbuffer++) = s[i];
    8020235a:	fe042623          	sw	zero,-20(s0)
    8020235e:	a03d                	j	8020238c <_puts+0x90>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98 (discriminator 3)
    80202360:	fec46783          	lwu	a5,-20(s0)
    80202364:	fd843703          	ld	a4,-40(s0)
    80202368:	973e                	add	a4,a4,a5
    8020236a:	fc843783          	ld	a5,-56(s0)
    8020236e:	679c                	ld	a5,8(a5)
    80202370:	00178613          	addi	a2,a5,1
    80202374:	fc843683          	ld	a3,-56(s0)
    80202378:	e690                	sd	a2,8(a3)
    8020237a:	00074703          	lbu	a4,0(a4)
    8020237e:	00e78023          	sb	a4,0(a5)
    80202382:	fec42783          	lw	a5,-20(s0)
    80202386:	2785                	addiw	a5,a5,1
    80202388:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98 (discriminator 1)
    8020238c:	fec42703          	lw	a4,-20(s0)
    80202390:	fd442783          	lw	a5,-44(s0)
    80202394:	2701                	sext.w	a4,a4
    80202396:	2781                	sext.w	a5,a5
    80202398:	fcf764e3          	bltu	a4,a5,80202360 <_puts+0x64>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:99
    *(b->pbuffer) = '\0';
    8020239c:	fc843783          	ld	a5,-56(s0)
    802023a0:	679c                	ld	a5,8(a5)
    802023a2:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:101

    return len;
    802023a6:	fd442783          	lw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:102
}
    802023aa:	853e                	mv	a0,a5
    802023ac:	7462                	ld	s0,56(sp)
    802023ae:	6121                	addi	sp,sp,64
    802023b0:	8082                	ret

00000000802023b2 <mini_vsnprintf>:
mini_vsnprintf():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:107

static int mini_vsnprintf(
    char *buffer, unsigned int buffer_len, const char *fmt,
    va_list va)
{
    802023b2:	7119                	addi	sp,sp,-128
    802023b4:	fc86                	sd	ra,120(sp)
    802023b6:	f8a2                	sd	s0,112(sp)
    802023b8:	0100                	addi	s0,sp,128
    802023ba:	f8a43c23          	sd	a0,-104(s0)
    802023be:	87ae                	mv	a5,a1
    802023c0:	f8c43423          	sd	a2,-120(s0)
    802023c4:	f8d43023          	sd	a3,-128(s0)
    802023c8:	f8f42a23          	sw	a5,-108(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:112
    struct mini_buff b;
    char bf[24];
    char ch;

    b.buffer     = buffer;
    802023cc:	f9843783          	ld	a5,-104(s0)
    802023d0:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:113
    b.pbuffer    = buffer;
    802023d4:	f9843783          	ld	a5,-104(s0)
    802023d8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:114
    b.buffer_len = buffer_len;
    802023dc:	f9442783          	lw	a5,-108(s0)
    802023e0:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:116

    while ((ch = *(fmt++))) {
    802023e4:	a4f9                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:117
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802023e6:	fc843703          	ld	a4,-56(s0)
    802023ea:	fc043783          	ld	a5,-64(s0)
    802023ee:	40f707b3          	sub	a5,a4,a5
    802023f2:	2781                	sext.w	a5,a5
    802023f4:	2785                	addiw	a5,a5,1
    802023f6:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:118
            b.buffer_len)
    802023fa:	fd042783          	lw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:117
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802023fe:	2cf77b63          	bgeu	a4,a5,802026d4 <mini_vsnprintf+0x322>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:120
            break;
        if (ch != '%')
    80202402:	fef44783          	lbu	a5,-17(s0)
    80202406:	0ff7f713          	andi	a4,a5,255
    8020240a:	02500793          	li	a5,37
    8020240e:	00f70c63          	beq	a4,a5,80202426 <mini_vsnprintf+0x74>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:121
            _putc(ch, &b);
    80202412:	fef44783          	lbu	a5,-17(s0)
    80202416:	2781                	sext.w	a5,a5
    80202418:	fc040713          	addi	a4,s0,-64
    8020241c:	85ba                	mv	a1,a4
    8020241e:	853e                	mv	a0,a5
    80202420:	e77ff0ef          	jal	ra,80202296 <_putc>
    80202424:	a479                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:123
        else {
            char zero_pad = 0;
    80202426:	fe040723          	sb	zero,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:124
            int longflag = 0;
    8020242a:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:128
            char *ptr;
            unsigned int len;

            ch = *(fmt++);
    8020242e:	f8843783          	ld	a5,-120(s0)
    80202432:	00178713          	addi	a4,a5,1
    80202436:	f8e43423          	sd	a4,-120(s0)
    8020243a:	0007c783          	lbu	a5,0(a5)
    8020243e:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:131

            /* Zero padding requested */
            if (ch == '0') {
    80202442:	fef44783          	lbu	a5,-17(s0)
    80202446:	0ff7f713          	andi	a4,a5,255
    8020244a:	03000793          	li	a5,48
    8020244e:	06f71b63          	bne	a4,a5,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:132
                while ((ch = *(fmt++))) {
    80202452:	a891                	j	802024a6 <mini_vsnprintf+0xf4>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:133
                    if (ch == '\0') goto end;
    80202454:	fef44783          	lbu	a5,-17(s0)
    80202458:	0ff7f793          	andi	a5,a5,255
    8020245c:	26078e63          	beqz	a5,802026d8 <mini_vsnprintf+0x326>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:134
                    if (ch >= '0' && ch <= '9') {
    80202460:	fef44783          	lbu	a5,-17(s0)
    80202464:	0ff7f713          	andi	a4,a5,255
    80202468:	02f00793          	li	a5,47
    8020246c:	04e7fc63          	bgeu	a5,a4,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:134 (discriminator 1)
    80202470:	fef44783          	lbu	a5,-17(s0)
    80202474:	0ff7f713          	andi	a4,a5,255
    80202478:	03900793          	li	a5,57
    8020247c:	04e7e463          	bltu	a5,a4,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:135
                        zero_pad = zero_pad * 10 + ch - '0';
    80202480:	fee44703          	lbu	a4,-18(s0)
    80202484:	87ba                	mv	a5,a4
    80202486:	0027979b          	slliw	a5,a5,0x2
    8020248a:	9fb9                	addw	a5,a5,a4
    8020248c:	0017979b          	slliw	a5,a5,0x1
    80202490:	0ff7f793          	andi	a5,a5,255
    80202494:	fef44703          	lbu	a4,-17(s0)
    80202498:	9fb9                	addw	a5,a5,a4
    8020249a:	0ff7f793          	andi	a5,a5,255
    8020249e:	fd07879b          	addiw	a5,a5,-48
    802024a2:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:132
                while ((ch = *(fmt++))) {
    802024a6:	f8843783          	ld	a5,-120(s0)
    802024aa:	00178713          	addi	a4,a5,1
    802024ae:	f8e43423          	sd	a4,-120(s0)
    802024b2:	0007c783          	lbu	a5,0(a5)
    802024b6:	fef407a3          	sb	a5,-17(s0)
    802024ba:	fef44783          	lbu	a5,-17(s0)
    802024be:	0ff7f793          	andi	a5,a5,255
    802024c2:	fbc9                	bnez	a5,80202454 <mini_vsnprintf+0xa2>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:141
                    } else {
                        break;
                    }
                }
            }
            if (ch == 'l') {
    802024c4:	fef44783          	lbu	a5,-17(s0)
    802024c8:	0ff7f713          	andi	a4,a5,255
    802024cc:	06c00793          	li	a5,108
    802024d0:	00f71f63          	bne	a4,a5,802024ee <mini_vsnprintf+0x13c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:142
                longflag = 1;
    802024d4:	4785                	li	a5,1
    802024d6:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:143
                ch = *(fmt++);
    802024da:	f8843783          	ld	a5,-120(s0)
    802024de:	00178713          	addi	a4,a5,1
    802024e2:	f8e43423          	sd	a4,-120(s0)
    802024e6:	0007c783          	lbu	a5,0(a5)
    802024ea:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:146
            }

            switch (ch) {
    802024ee:	fef44783          	lbu	a5,-17(s0)
    802024f2:	2781                	sext.w	a5,a5
    802024f4:	1e078463          	beqz	a5,802026dc <mini_vsnprintf+0x32a>
    802024f8:	873e                	mv	a4,a5
    802024fa:	1a074263          	bltz	a4,8020269e <mini_vsnprintf+0x2ec>
    802024fe:	86be                	mv	a3,a5
    80202500:	07800713          	li	a4,120
    80202504:	18d74d63          	blt	a4,a3,8020269e <mini_vsnprintf+0x2ec>
    80202508:	86be                	mv	a3,a5
    8020250a:	05800713          	li	a4,88
    8020250e:	18e6c863          	blt	a3,a4,8020269e <mini_vsnprintf+0x2ec>
    80202512:	fa87869b          	addiw	a3,a5,-88
    80202516:	0006871b          	sext.w	a4,a3
    8020251a:	02000793          	li	a5,32
    8020251e:	18e7e063          	bltu	a5,a4,8020269e <mini_vsnprintf+0x2ec>
    80202522:	02069793          	slli	a5,a3,0x20
    80202526:	9381                	srli	a5,a5,0x20
    80202528:	00279713          	slli	a4,a5,0x2
    8020252c:	00007797          	auipc	a5,0x7
    80202530:	ad478793          	addi	a5,a5,-1324 # 80209000 <etext>
    80202534:	97ba                	add	a5,a5,a4
    80202536:	439c                	lw	a5,0(a5)
    80202538:	0007871b          	sext.w	a4,a5
    8020253c:	00007797          	auipc	a5,0x7
    80202540:	ac478793          	addi	a5,a5,-1340 # 80209000 <etext>
    80202544:	97ba                	add	a5,a5,a4
    80202546:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:151
                case 0:
                    goto end;

                case 'l':
                    longflag = 1;
    80202548:	4785                	li	a5,1
    8020254a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:152
                    break;
    8020254e:	a295                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156

                case 'u':
                case 'd':
                    len = mini_itoa(
    80202550:	fe842783          	lw	a5,-24(s0)
    80202554:	2781                	sext.w	a5,a5
    80202556:	ef81                	bnez	a5,8020256e <mini_vsnprintf+0x1bc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:157
                        longflag == 0 ? (unsigned long)va_arg(
    80202558:	f8043783          	ld	a5,-128(s0)
    8020255c:	00878713          	addi	a4,a5,8
    80202560:	f8e43023          	sd	a4,-128(s0)
    80202564:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156
                    len = mini_itoa(
    80202566:	02079513          	slli	a0,a5,0x20
    8020256a:	9101                	srli	a0,a0,0x20
    8020256c:	a809                	j	8020257e <mini_vsnprintf+0x1cc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:159
                                            va, unsigned int) :
                                        va_arg(va, unsigned long),
    8020256e:	f8043783          	ld	a5,-128(s0)
    80202572:	00878713          	addi	a4,a5,8
    80202576:	f8e43023          	sd	a4,-128(s0)
    8020257a:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156
                    len = mini_itoa(
    8020257c:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156 (discriminator 4)
    8020257e:	fef44783          	lbu	a5,-17(s0)
    80202582:	0007871b          	sext.w	a4,a5
    80202586:	07500793          	li	a5,117
    8020258a:	40f707b3          	sub	a5,a4,a5
    8020258e:	0017b793          	seqz	a5,a5
    80202592:	0ff7f793          	andi	a5,a5,255
    80202596:	0007869b          	sext.w	a3,a5
    8020259a:	fee44783          	lbu	a5,-18(s0)
    8020259e:	2781                	sext.w	a5,a5
    802025a0:	fa840713          	addi	a4,s0,-88
    802025a4:	4601                	li	a2,0
    802025a6:	45a9                	li	a1,10
    802025a8:	ac9ff0ef          	jal	ra,80202070 <mini_itoa>
    802025ac:	87aa                	mv	a5,a0
    802025ae:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:161 (discriminator 4)
                        10, 0, (ch == 'u'), bf, zero_pad);
                    _puts(bf, len, &b);
    802025b2:	fc040693          	addi	a3,s0,-64
    802025b6:	fdc42703          	lw	a4,-36(s0)
    802025ba:	fa840793          	addi	a5,s0,-88
    802025be:	8636                	mv	a2,a3
    802025c0:	85ba                	mv	a1,a4
    802025c2:	853e                	mv	a0,a5
    802025c4:	d39ff0ef          	jal	ra,802022fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:162 (discriminator 4)
                    longflag = 0;
    802025c8:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:163 (discriminator 4)
                    break;
    802025cc:	a0dd                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                case 'x':
                case 'X':
                    len = mini_itoa(
    802025ce:	fe842783          	lw	a5,-24(s0)
    802025d2:	2781                	sext.w	a5,a5
    802025d4:	ef81                	bnez	a5,802025ec <mini_vsnprintf+0x23a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:167
                        longflag == 0 ? (unsigned long)va_arg(
    802025d6:	f8043783          	ld	a5,-128(s0)
    802025da:	00878713          	addi	a4,a5,8
    802025de:	f8e43023          	sd	a4,-128(s0)
    802025e2:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                    len = mini_itoa(
    802025e4:	02079513          	slli	a0,a5,0x20
    802025e8:	9101                	srli	a0,a0,0x20
    802025ea:	a809                	j	802025fc <mini_vsnprintf+0x24a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:169
                                            va, unsigned int) :
                                        va_arg(va, unsigned long),
    802025ec:	f8043783          	ld	a5,-128(s0)
    802025f0:	00878713          	addi	a4,a5,8
    802025f4:	f8e43023          	sd	a4,-128(s0)
    802025f8:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                    len = mini_itoa(
    802025fa:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166 (discriminator 4)
    802025fc:	fef44783          	lbu	a5,-17(s0)
    80202600:	0007871b          	sext.w	a4,a5
    80202604:	05800793          	li	a5,88
    80202608:	40f707b3          	sub	a5,a4,a5
    8020260c:	0017b793          	seqz	a5,a5
    80202610:	0ff7f793          	andi	a5,a5,255
    80202614:	0007861b          	sext.w	a2,a5
    80202618:	fee44783          	lbu	a5,-18(s0)
    8020261c:	2781                	sext.w	a5,a5
    8020261e:	fa840713          	addi	a4,s0,-88
    80202622:	4685                	li	a3,1
    80202624:	45c1                	li	a1,16
    80202626:	a4bff0ef          	jal	ra,80202070 <mini_itoa>
    8020262a:	87aa                	mv	a5,a0
    8020262c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:171 (discriminator 4)
                        16, (ch == 'X'), 1, bf, zero_pad);
                    _puts(bf, len, &b);
    80202630:	fc040693          	addi	a3,s0,-64
    80202634:	fdc42703          	lw	a4,-36(s0)
    80202638:	fa840793          	addi	a5,s0,-88
    8020263c:	8636                	mv	a2,a3
    8020263e:	85ba                	mv	a1,a4
    80202640:	853e                	mv	a0,a5
    80202642:	cbbff0ef          	jal	ra,802022fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:172 (discriminator 4)
                    longflag = 0;
    80202646:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:173 (discriminator 4)
                    break;
    8020264a:	a0a5                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:176

                case 'c':
                    _putc((char)(va_arg(va, int)), &b);
    8020264c:	f8043783          	ld	a5,-128(s0)
    80202650:	00878713          	addi	a4,a5,8
    80202654:	f8e43023          	sd	a4,-128(s0)
    80202658:	439c                	lw	a5,0(a5)
    8020265a:	0ff7f793          	andi	a5,a5,255
    8020265e:	2781                	sext.w	a5,a5
    80202660:	fc040713          	addi	a4,s0,-64
    80202664:	85ba                	mv	a1,a4
    80202666:	853e                	mv	a0,a5
    80202668:	c2fff0ef          	jal	ra,80202296 <_putc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:177
                    break;
    8020266c:	a099                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:180

                case 's':
                    ptr = va_arg(va, char *);
    8020266e:	f8043783          	ld	a5,-128(s0)
    80202672:	00878713          	addi	a4,a5,8
    80202676:	f8e43023          	sd	a4,-128(s0)
    8020267a:	639c                	ld	a5,0(a5)
    8020267c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:181
                    _puts(ptr, mini_strlen(ptr), &b);
    80202680:	fe043503          	ld	a0,-32(s0)
    80202684:	9b7ff0ef          	jal	ra,8020203a <mini_strlen>
    80202688:	87aa                	mv	a5,a0
    8020268a:	2781                	sext.w	a5,a5
    8020268c:	fc040713          	addi	a4,s0,-64
    80202690:	863a                	mv	a2,a4
    80202692:	85be                	mv	a1,a5
    80202694:	fe043503          	ld	a0,-32(s0)
    80202698:	c65ff0ef          	jal	ra,802022fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:182
                    break;
    8020269c:	a819                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:185

                default:
                    _putc(ch, &b);
    8020269e:	fef44783          	lbu	a5,-17(s0)
    802026a2:	2781                	sext.w	a5,a5
    802026a4:	fc040713          	addi	a4,s0,-64
    802026a8:	85ba                	mv	a1,a4
    802026aa:	853e                	mv	a0,a5
    802026ac:	bebff0ef          	jal	ra,80202296 <_putc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:186
                    break;
    802026b0:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:116
    while ((ch = *(fmt++))) {
    802026b2:	f8843783          	ld	a5,-120(s0)
    802026b6:	00178713          	addi	a4,a5,1
    802026ba:	f8e43423          	sd	a4,-120(s0)
    802026be:	0007c783          	lbu	a5,0(a5)
    802026c2:	fef407a3          	sb	a5,-17(s0)
    802026c6:	fef44783          	lbu	a5,-17(s0)
    802026ca:	0ff7f793          	andi	a5,a5,255
    802026ce:	d0079ce3          	bnez	a5,802023e6 <mini_vsnprintf+0x34>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:190
            }
        }
    }
end:
    802026d2:	a031                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:119
            break;
    802026d4:	0001                	nop
    802026d6:	a021                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:133
                    if (ch == '\0') goto end;
    802026d8:	0001                	nop
    802026da:	a011                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:148
                    goto end;
    802026dc:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:191
    return b.pbuffer - b.buffer;
    802026de:	fc843703          	ld	a4,-56(s0)
    802026e2:	fc043783          	ld	a5,-64(s0)
    802026e6:	40f707b3          	sub	a5,a4,a5
    802026ea:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:192
}
    802026ec:	853e                	mv	a0,a5
    802026ee:	70e6                	ld	ra,120(sp)
    802026f0:	7446                	ld	s0,112(sp)
    802026f2:	6109                	addi	sp,sp,128
    802026f4:	8082                	ret

00000000802026f6 <_vprintk>:
_vprintk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:196

static int _vprintk(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    802026f6:	7129                	addi	sp,sp,-320
    802026f8:	fe06                	sd	ra,312(sp)
    802026fa:	fa22                	sd	s0,304(sp)
    802026fc:	0280                	addi	s0,sp,320
    802026fe:	eca43c23          	sd	a0,-296(s0)
    80202702:	ecb43823          	sd	a1,-304(s0)
    80202706:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:198
    va_list va;
    va_copy(va, _va);
    8020270a:	ed043783          	ld	a5,-304(s0)
    8020270e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:203

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    80202712:	fe043703          	ld	a4,-32(s0)
    80202716:	ee040793          	addi	a5,s0,-288
    8020271a:	86ba                	mv	a3,a4
    8020271c:	ed843603          	ld	a2,-296(s0)
    80202720:	10000593          	li	a1,256
    80202724:	853e                	mv	a0,a5
    80202726:	c8dff0ef          	jal	ra,802023b2 <mini_vsnprintf>
    8020272a:	87aa                	mv	a5,a0
    8020272c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:205

    buff[ret] = '\0';
    80202730:	fec42783          	lw	a5,-20(s0)
    80202734:	ff040713          	addi	a4,s0,-16
    80202738:	97ba                	add	a5,a5,a4
    8020273a:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:210

    // disable_preempt();
    
    // 在此处调用sbi，output
    output(buff);
    8020273e:	ee040793          	addi	a5,s0,-288
    80202742:	ec843703          	ld	a4,-312(s0)
    80202746:	853e                	mv	a0,a5
    80202748:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:225
    //     }
    // }

    // enable_preempt();

    return ret;
    8020274a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:226
}
    8020274e:	853e                	mv	a0,a5
    80202750:	70f2                	ld	ra,312(sp)
    80202752:	7452                	ld	s0,304(sp)
    80202754:	6131                	addi	sp,sp,320
    80202756:	8082                	ret

0000000080202758 <_vprints>:
_vprints():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:230

static int _vprints(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    80202758:	7129                	addi	sp,sp,-320
    8020275a:	fe06                	sd	ra,312(sp)
    8020275c:	fa22                	sd	s0,304(sp)
    8020275e:	0280                	addi	s0,sp,320
    80202760:	eca43c23          	sd	a0,-296(s0)
    80202764:	ecb43823          	sd	a1,-304(s0)
    80202768:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:232
    va_list va;
    va_copy(va, _va);
    8020276c:	ed043783          	ld	a5,-304(s0)
    80202770:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:237

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    80202774:	fe043703          	ld	a4,-32(s0)
    80202778:	ee040793          	addi	a5,s0,-288
    8020277c:	86ba                	mv	a3,a4
    8020277e:	ed843603          	ld	a2,-296(s0)
    80202782:	10000593          	li	a1,256
    80202786:	853e                	mv	a0,a5
    80202788:	c2bff0ef          	jal	ra,802023b2 <mini_vsnprintf>
    8020278c:	87aa                	mv	a5,a0
    8020278e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:239

    buff[ret] = '\0';
    80202792:	fec42783          	lw	a5,-20(s0)
    80202796:	ff040713          	addi	a4,s0,-16
    8020279a:	97ba                	add	a5,a5,a4
    8020279c:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:245


    // disable_preempt();

    // 在此处调用sbi，output
    output(buff);
    802027a0:	ee040793          	addi	a5,s0,-288
    802027a4:	ec843703          	ld	a4,-312(s0)
    802027a8:	853e                	mv	a0,a5
    802027aa:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:249

    // enable_preempt();

    return ret;
    802027ac:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:250
}
    802027b0:	853e                	mv	a0,a5
    802027b2:	70f2                	ld	ra,312(sp)
    802027b4:	7452                	ld	s0,304(sp)
    802027b6:	6131                	addi	sp,sp,320
    802027b8:	8082                	ret

00000000802027ba <vprintk>:
vprintk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:254


int vprintk(const char *fmt, va_list _va)
{
    802027ba:	1101                	addi	sp,sp,-32
    802027bc:	ec06                	sd	ra,24(sp)
    802027be:	e822                	sd	s0,16(sp)
    802027c0:	1000                	addi	s0,sp,32
    802027c2:	fea43423          	sd	a0,-24(s0)
    802027c6:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:255
    return _vprintk(fmt, _va, port_write);
    802027ca:	00000617          	auipc	a2,0x0
    802027ce:	83660613          	addi	a2,a2,-1994 # 80202000 <port_write>
    802027d2:	fe043583          	ld	a1,-32(s0)
    802027d6:	fe843503          	ld	a0,-24(s0)
    802027da:	f1dff0ef          	jal	ra,802026f6 <_vprintk>
    802027de:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:256
}
    802027e0:	853e                	mv	a0,a5
    802027e2:	60e2                	ld	ra,24(sp)
    802027e4:	6442                	ld	s0,16(sp)
    802027e6:	6105                	addi	sp,sp,32
    802027e8:	8082                	ret

00000000802027ea <printk>:
printk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:259

int printk(const char *fmt, ...)
{
    802027ea:	7159                	addi	sp,sp,-112
    802027ec:	f406                	sd	ra,40(sp)
    802027ee:	f022                	sd	s0,32(sp)
    802027f0:	1800                	addi	s0,sp,48
    802027f2:	fca43c23          	sd	a0,-40(s0)
    802027f6:	e40c                	sd	a1,8(s0)
    802027f8:	e810                	sd	a2,16(s0)
    802027fa:	ec14                	sd	a3,24(s0)
    802027fc:	f018                	sd	a4,32(s0)
    802027fe:	f41c                	sd	a5,40(s0)
    80202800:	03043823          	sd	a6,48(s0)
    80202804:	03143c23          	sd	a7,56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:260
    int ret = 0;
    80202808:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:263
    va_list va;

    va_start(va, fmt);
    8020280c:	04040793          	addi	a5,s0,64
    80202810:	fcf43823          	sd	a5,-48(s0)
    80202814:	fd043783          	ld	a5,-48(s0)
    80202818:	fc878793          	addi	a5,a5,-56
    8020281c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:264
    ret = vprintk(fmt, va);
    80202820:	fe043783          	ld	a5,-32(s0)
    80202824:	85be                	mv	a1,a5
    80202826:	fd843503          	ld	a0,-40(s0)
    8020282a:	f91ff0ef          	jal	ra,802027ba <vprintk>
    8020282e:	87aa                	mv	a5,a0
    80202830:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:267
    va_end(va);

    return ret;
    80202834:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:268
}
    80202838:	853e                	mv	a0,a5
    8020283a:	70a2                	ld	ra,40(sp)
    8020283c:	7402                	ld	s0,32(sp)
    8020283e:	6165                	addi	sp,sp,112
    80202840:	8082                	ret

0000000080202842 <_vprintk_port>:
_vprintk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:274

/* for port output, direct output */

static int _vprintk_port(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    80202842:	7129                	addi	sp,sp,-320
    80202844:	fe06                	sd	ra,312(sp)
    80202846:	fa22                	sd	s0,304(sp)
    80202848:	0280                	addi	s0,sp,320
    8020284a:	eca43c23          	sd	a0,-296(s0)
    8020284e:	ecb43823          	sd	a1,-304(s0)
    80202852:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:276
    va_list va;
    va_copy(va, _va);
    80202856:	ed043783          	ld	a5,-304(s0)
    8020285a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:281

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    8020285e:	fe043703          	ld	a4,-32(s0)
    80202862:	ee040793          	addi	a5,s0,-288
    80202866:	86ba                	mv	a3,a4
    80202868:	ed843603          	ld	a2,-296(s0)
    8020286c:	10000593          	li	a1,256
    80202870:	853e                	mv	a0,a5
    80202872:	b41ff0ef          	jal	ra,802023b2 <mini_vsnprintf>
    80202876:	87aa                	mv	a5,a0
    80202878:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:283

    buff[ret] = '\0';
    8020287c:	fec42783          	lw	a5,-20(s0)
    80202880:	ff040713          	addi	a4,s0,-16
    80202884:	97ba                	add	a5,a5,a4
    80202886:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:292
    // 在此处调用sbi，output
    // port_write(buff);

    // enable_preempt();

    return ret;
    8020288a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:293
}
    8020288e:	853e                	mv	a0,a5
    80202890:	70f2                	ld	ra,312(sp)
    80202892:	7452                	ld	s0,304(sp)
    80202894:	6131                	addi	sp,sp,320
    80202896:	8082                	ret

0000000080202898 <vprintk_port>:
vprintk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:297


int vprintk_port(const char *fmt, va_list _va)
{
    80202898:	1101                	addi	sp,sp,-32
    8020289a:	ec06                	sd	ra,24(sp)
    8020289c:	e822                	sd	s0,16(sp)
    8020289e:	1000                	addi	s0,sp,32
    802028a0:	fea43423          	sd	a0,-24(s0)
    802028a4:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:298
    return _vprintk_port(fmt, _va, port_write);
    802028a8:	fffff617          	auipc	a2,0xfffff
    802028ac:	75860613          	addi	a2,a2,1880 # 80202000 <port_write>
    802028b0:	fe043583          	ld	a1,-32(s0)
    802028b4:	fe843503          	ld	a0,-24(s0)
    802028b8:	f8bff0ef          	jal	ra,80202842 <_vprintk_port>
    802028bc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:299
}
    802028be:	853e                	mv	a0,a5
    802028c0:	60e2                	ld	ra,24(sp)
    802028c2:	6442                	ld	s0,16(sp)
    802028c4:	6105                	addi	sp,sp,32
    802028c6:	8082                	ret

00000000802028c8 <printk_port>:
printk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:302

uint32_t printk_port(const char *fmt, ...)
{
    802028c8:	7159                	addi	sp,sp,-112
    802028ca:	f406                	sd	ra,40(sp)
    802028cc:	f022                	sd	s0,32(sp)
    802028ce:	1800                	addi	s0,sp,48
    802028d0:	fca43c23          	sd	a0,-40(s0)
    802028d4:	e40c                	sd	a1,8(s0)
    802028d6:	e810                	sd	a2,16(s0)
    802028d8:	ec14                	sd	a3,24(s0)
    802028da:	f018                	sd	a4,32(s0)
    802028dc:	f41c                	sd	a5,40(s0)
    802028de:	03043823          	sd	a6,48(s0)
    802028e2:	03143c23          	sd	a7,56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:303
    uint32_t ret = 0;
    802028e6:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:306
    va_list va;

    va_start(va, fmt);
    802028ea:	04040793          	addi	a5,s0,64
    802028ee:	fcf43823          	sd	a5,-48(s0)
    802028f2:	fd043783          	ld	a5,-48(s0)
    802028f6:	fc878793          	addi	a5,a5,-56
    802028fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:307
    ret = vprintk_port(fmt, va);
    802028fe:	fe043783          	ld	a5,-32(s0)
    80202902:	85be                	mv	a1,a5
    80202904:	fd843503          	ld	a0,-40(s0)
    80202908:	f91ff0ef          	jal	ra,80202898 <vprintk_port>
    8020290c:	87aa                	mv	a5,a0
    8020290e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:310
    va_end(va);

    return ret;
    80202912:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:311
    80202916:	853e                	mv	a0,a5
    80202918:	70a2                	ld	ra,40(sp)
    8020291a:	7402                	ld	s0,32(sp)
    8020291c:	6165                	addi	sp,sp,112
    8020291e:	8082                	ret

0000000080202920 <clear_bss>:
clear_bss():
/home/caigoubencai/Desktop/os_c/kernel/main.c:15
#include "loader.h"
#include "processor.h"
#include "taskmanager.h"
extern uint8_t sbss, ebss;

void clear_bss() {
    80202920:	1101                	addi	sp,sp,-32
    80202922:	ec22                	sd	s0,24(sp)
    80202924:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/main.c:16
  for (uint8_t *i = &sbss; i < &ebss; i++) {
    80202926:	0001f797          	auipc	a5,0x1f
    8020292a:	6da78793          	addi	a5,a5,1754 # 80222000 <ticks>
    8020292e:	fef43423          	sd	a5,-24(s0)
    80202932:	a811                	j	80202946 <clear_bss+0x26>
/home/caigoubencai/Desktop/os_c/kernel/main.c:17 (discriminator 3)
    *i = 0;
    80202934:	fe843783          	ld	a5,-24(s0)
    80202938:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/main.c:16 (discriminator 3)
  for (uint8_t *i = &sbss; i < &ebss; i++) {
    8020293c:	fe843783          	ld	a5,-24(s0)
    80202940:	0785                	addi	a5,a5,1
    80202942:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/main.c:16 (discriminator 1)
    80202946:	fe843703          	ld	a4,-24(s0)
    8020294a:	00b23797          	auipc	a5,0xb23
    8020294e:	6b678793          	addi	a5,a5,1718 # 80d26000 <ebss>
    80202952:	fef761e3          	bltu	a4,a5,80202934 <clear_bss+0x14>
/home/caigoubencai/Desktop/os_c/kernel/main.c:19
  }
}
    80202956:	0001                	nop
    80202958:	0001                	nop
    8020295a:	6462                	ld	s0,24(sp)
    8020295c:	6105                	addi	sp,sp,32
    8020295e:	8082                	ret

0000000080202960 <main_os>:
main_os():
/home/caigoubencai/Desktop/os_c/kernel/main.c:21
int main_os()
{
    80202960:	1141                	addi	sp,sp,-16
    80202962:	e406                	sd	ra,8(sp)
    80202964:	e022                	sd	s0,0(sp)
    80202966:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/main.c:22
    mm_init();
    80202968:	321020ef          	jal	ra,80205488 <mm_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:23
    printk("123%d\n",123);
    8020296c:	07b00593          	li	a1,123
    80202970:	00006517          	auipc	a0,0x6
    80202974:	72850513          	addi	a0,a0,1832 # 80209098 <MMIO+0x10>
    80202978:	e73ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/main.c:24
    init_trap();
    8020297c:	152050ef          	jal	ra,80207ace <init_trap>
/home/caigoubencai/Desktop/os_c/kernel/main.c:25
    timer_init();
    80202980:	4c0050ef          	jal	ra,80207e40 <timer_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:26
    loader_init_and_list_apps();
    80202984:	2b1040ef          	jal	ra,80207434 <loader_init_and_list_apps>
/home/caigoubencai/Desktop/os_c/kernel/main.c:27
    taks_init();
    80202988:	164040ef          	jal	ra,80206aec <taks_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:28
    task_manager_add_2_initproc();
    8020298c:	1b2040ef          	jal	ra,80206b3e <task_manager_add_2_initproc>
/home/caigoubencai/Desktop/os_c/kernel/main.c:29
    processor_run_tasks();
    80202990:	059040ef          	jal	ra,802071e8 <processor_run_tasks>
/home/caigoubencai/Desktop/os_c/kernel/main.c:38
    // processor_init(&PROCESSOR);
    // task_manager_init_2();
    // task_manager_add_2_initproc();
    // //run_first_app();
    // processor_run_tasks();
    ASSERT(0);
    80202994:	00006617          	auipc	a2,0x6
    80202998:	70c60613          	addi	a2,a2,1804 # 802090a0 <MMIO+0x18>
    8020299c:	02600593          	li	a1,38
    802029a0:	00006517          	auipc	a0,0x6
    802029a4:	71850513          	addi	a0,a0,1816 # 802090b8 <MMIO+0x30>
    802029a8:	4f1030ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/main.c:39
    802029ac:	0001                	nop
    802029ae:	853e                	mv	a0,a5
    802029b0:	60a2                	ld	ra,8(sp)
    802029b2:	6402                	ld	s0,0(sp)
    802029b4:	0141                	addi	sp,sp,16
    802029b6:	8082                	ret

00000000802029b8 <elf_load_sections_loop>:
elf_load_sections_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:18

/*
** traverse the section header table and load each section
*/
static int elf_load_sections_loop(t_elf *elf, size_t shoff, size_t shnum,
                                  size_t shentsize) {
    802029b8:	715d                	addi	sp,sp,-80
    802029ba:	e486                	sd	ra,72(sp)
    802029bc:	e0a2                	sd	s0,64(sp)
    802029be:	0880                	addi	s0,sp,80
    802029c0:	fca43423          	sd	a0,-56(s0)
    802029c4:	fcb43023          	sd	a1,-64(s0)
    802029c8:	fac43c23          	sd	a2,-72(s0)
    802029cc:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:23
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    802029d0:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    802029d4:	a0dd                	j	80202aba <elf_load_sections_loop+0x102>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:25
    if (i >= MAX_SECTION_NUM) {
    802029d6:	fe843703          	ld	a4,-24(s0)
    802029da:	03f00793          	li	a5,63
    802029de:	00e7f463          	bgeu	a5,a4,802029e6 <elf_load_sections_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:26
      return (-1);
    802029e2:	57fd                	li	a5,-1
    802029e4:	a0d5                	j	80202ac8 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:29
    }
    elf->sections[i].header =
        (union u_elf_sh *)(elf->raw_data + shoff + i * shentsize);
    802029e6:	fc843783          	ld	a5,-56(s0)
    802029ea:	6798                	ld	a4,8(a5)
    802029ec:	fe843683          	ld	a3,-24(s0)
    802029f0:	fb043783          	ld	a5,-80(s0)
    802029f4:	02f686b3          	mul	a3,a3,a5
    802029f8:	fc043783          	ld	a5,-64(s0)
    802029fc:	97b6                	add	a5,a5,a3
    802029fe:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:28
    elf->sections[i].header =
    80202a00:	fc843683          	ld	a3,-56(s0)
    80202a04:	fe843783          	ld	a5,-24(s0)
    80202a08:	0789                	addi	a5,a5,2
    80202a0a:	0792                	slli	a5,a5,0x4
    80202a0c:	97b6                	add	a5,a5,a3
    80202a0e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:30
    type = elf_section_get_type(elf, &elf->sections[i]);
    80202a10:	fe843783          	ld	a5,-24(s0)
    80202a14:	0789                	addi	a5,a5,2
    80202a16:	0792                	slli	a5,a5,0x4
    80202a18:	fc843703          	ld	a4,-56(s0)
    80202a1c:	97ba                	add	a5,a5,a4
    80202a1e:	07a1                	addi	a5,a5,8
    80202a20:	85be                	mv	a1,a5
    80202a22:	fc843503          	ld	a0,-56(s0)
    80202a26:	576000ef          	jal	ra,80202f9c <elf_section_get_type>
    80202a2a:	87aa                	mv	a5,a0
    80202a2c:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31
    if (type != SHT_NULL && type != SHT_NOBITS) {
    80202a30:	fe442783          	lw	a5,-28(s0)
    80202a34:	2781                	sext.w	a5,a5
    80202a36:	cfad                	beqz	a5,80202ab0 <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31 (discriminator 1)
    80202a38:	fe442783          	lw	a5,-28(s0)
    80202a3c:	0007871b          	sext.w	a4,a5
    80202a40:	47a1                	li	a5,8
    80202a42:	06f70763          	beq	a4,a5,80202ab0 <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:32
      content_offset = elf_section_get_offset(elf, &elf->sections[i]);
    80202a46:	fe843783          	ld	a5,-24(s0)
    80202a4a:	0789                	addi	a5,a5,2
    80202a4c:	0792                	slli	a5,a5,0x4
    80202a4e:	fc843703          	ld	a4,-56(s0)
    80202a52:	97ba                	add	a5,a5,a4
    80202a54:	07a1                	addi	a5,a5,8
    80202a56:	85be                	mv	a1,a5
    80202a58:	fc843503          	ld	a0,-56(s0)
    80202a5c:	584000ef          	jal	ra,80202fe0 <elf_section_get_offset>
    80202a60:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80202a64:	fe843783          	ld	a5,-24(s0)
    80202a68:	0789                	addi	a5,a5,2
    80202a6a:	0792                	slli	a5,a5,0x4
    80202a6c:	fc843703          	ld	a4,-56(s0)
    80202a70:	97ba                	add	a5,a5,a4
    80202a72:	07a1                	addi	a5,a5,8
    80202a74:	85be                	mv	a1,a5
    80202a76:	fc843503          	ld	a0,-56(s0)
    80202a7a:	5ae000ef          	jal	ra,80203028 <elf_section_get_size>
    80202a7e:	872a                	mv	a4,a0
    80202a80:	fd843783          	ld	a5,-40(s0)
    80202a84:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:34
          elf->size) {
    80202a86:	fc843783          	ld	a5,-56(s0)
    80202a8a:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80202a8c:	00e7f463          	bgeu	a5,a4,80202a94 <elf_load_sections_loop+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:35
        return (-1);
    80202a90:	57fd                	li	a5,-1
    80202a92:	a81d                	j	80202ac8 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:37
      }
      elf->sections[i].content = elf->raw_data + content_offset;
    80202a94:	fc843783          	ld	a5,-56(s0)
    80202a98:	6798                	ld	a4,8(a5)
    80202a9a:	fd843783          	ld	a5,-40(s0)
    80202a9e:	973e                	add	a4,a4,a5
    80202aa0:	fc843683          	ld	a3,-56(s0)
    80202aa4:	fe843783          	ld	a5,-24(s0)
    80202aa8:	0789                	addi	a5,a5,2
    80202aaa:	0792                	slli	a5,a5,0x4
    80202aac:	97b6                	add	a5,a5,a3
    80202aae:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:39
    }
    i++;
    80202ab0:	fe843783          	ld	a5,-24(s0)
    80202ab4:	0785                	addi	a5,a5,1
    80202ab6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    80202aba:	fe843703          	ld	a4,-24(s0)
    80202abe:	fb843783          	ld	a5,-72(s0)
    80202ac2:	f0f76ae3          	bltu	a4,a5,802029d6 <elf_load_sections_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:41
  }
  return (0);
    80202ac6:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:42
}
    80202ac8:	853e                	mv	a0,a5
    80202aca:	60a6                	ld	ra,72(sp)
    80202acc:	6406                	ld	s0,64(sp)
    80202ace:	6161                	addi	sp,sp,80
    80202ad0:	8082                	ret

0000000080202ad2 <elf_load_sections>:
elf_load_sections():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:48

/*
** Load sections. Create a table of t_elf_section in elf->sections.
** This table is null if there is no section header table.
*/
int elf_load_sections(t_elf *elf) {
    80202ad2:	7139                	addi	sp,sp,-64
    80202ad4:	fc06                	sd	ra,56(sp)
    80202ad6:	f822                	sd	s0,48(sp)
    80202ad8:	0080                	addi	s0,sp,64
    80202ada:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:53
  size_t shoff;
  size_t shnum;
  size_t shentsize;

  if ((shoff = elf_header_get_shoff(elf)) > 0) {
    80202ade:	fc843503          	ld	a0,-56(s0)
    80202ae2:	0cc000ef          	jal	ra,80202bae <elf_header_get_shoff>
    80202ae6:	fea43423          	sd	a0,-24(s0)
    80202aea:	fe843783          	ld	a5,-24(s0)
    80202aee:	cfb1                	beqz	a5,80202b4a <elf_load_sections+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:54
    shnum = elf_header_get_shnum(elf);
    80202af0:	fc843503          	ld	a0,-56(s0)
    80202af4:	142000ef          	jal	ra,80202c36 <elf_header_get_shnum>
    80202af8:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:55
    shentsize = elf_header_get_shentsize(elf);
    80202afc:	fc843503          	ld	a0,-56(s0)
    80202b00:	0f2000ef          	jal	ra,80202bf2 <elf_header_get_shentsize>
    80202b04:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:56
    if (shoff + shnum * shentsize > elf->size) {
    80202b08:	fe043703          	ld	a4,-32(s0)
    80202b0c:	fd843783          	ld	a5,-40(s0)
    80202b10:	02f70733          	mul	a4,a4,a5
    80202b14:	fe843783          	ld	a5,-24(s0)
    80202b18:	973e                	add	a4,a4,a5
    80202b1a:	fc843783          	ld	a5,-56(s0)
    80202b1e:	639c                	ld	a5,0(a5)
    80202b20:	00e7f463          	bgeu	a5,a4,80202b28 <elf_load_sections+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:57
      return (-1);
    80202b24:	57fd                	li	a5,-1
    80202b26:	a82d                	j	80202b60 <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:59
    }
    if (elf_load_sections_loop(elf, shoff, shnum, shentsize) == -1) {
    80202b28:	fd843683          	ld	a3,-40(s0)
    80202b2c:	fe043603          	ld	a2,-32(s0)
    80202b30:	fe843583          	ld	a1,-24(s0)
    80202b34:	fc843503          	ld	a0,-56(s0)
    80202b38:	e81ff0ef          	jal	ra,802029b8 <elf_load_sections_loop>
    80202b3c:	87aa                	mv	a5,a0
    80202b3e:	873e                	mv	a4,a5
    80202b40:	57fd                	li	a5,-1
    80202b42:	00f71e63          	bne	a4,a5,80202b5e <elf_load_sections+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:60
      return (-1);
    80202b46:	57fd                	li	a5,-1
    80202b48:	a821                	j	80202b60 <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:63
    }
  } else
    memset(elf->sections, 0, MAX_SECTION_NUM * sizeof(t_elf_section));
    80202b4a:	fc843783          	ld	a5,-56(s0)
    80202b4e:	02878793          	addi	a5,a5,40
    80202b52:	40000613          	li	a2,1024
    80202b56:	4581                	li	a1,0
    80202b58:	853e                	mv	a0,a5
    80202b5a:	437000ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:64
  return (0);
    80202b5e:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:65
}
    80202b60:	853e                	mv	a0,a5
    80202b62:	70e2                	ld	ra,56(sp)
    80202b64:	7442                	ld	s0,48(sp)
    80202b66:	6121                	addi	sp,sp,64
    80202b68:	8082                	ret

0000000080202b6a <elf_header_get_entry>:
elf_header_get_entry():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:14
** Last update Mon Mar 10 20:51:03 2014 Barthelemy Delemotte
*/

#include "elfparse.h"

size_t elf_header_get_entry(t_elf *elf) {
    80202b6a:	7179                	addi	sp,sp,-48
    80202b6c:	f422                	sd	s0,40(sp)
    80202b6e:	1800                	addi	s0,sp,48
    80202b70:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:17
  size_t entry;

  if (ELF_IS_32(elf))
    80202b74:	fd843783          	ld	a5,-40(s0)
    80202b78:	0187c783          	lbu	a5,24(a5)
    80202b7c:	873e                	mv	a4,a5
    80202b7e:	4785                	li	a5,1
    80202b80:	00f71b63          	bne	a4,a5,80202b96 <elf_header_get_entry+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:18
    entry = (size_t)elf->header->_32.e_entry;
    80202b84:	fd843783          	ld	a5,-40(s0)
    80202b88:	739c                	ld	a5,32(a5)
    80202b8a:	4f9c                	lw	a5,24(a5)
    80202b8c:	1782                	slli	a5,a5,0x20
    80202b8e:	9381                	srli	a5,a5,0x20
    80202b90:	fef43423          	sd	a5,-24(s0)
    80202b94:	a039                	j	80202ba2 <elf_header_get_entry+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:20
  else
    entry = (size_t)elf->header->_64.e_entry;
    80202b96:	fd843783          	ld	a5,-40(s0)
    80202b9a:	739c                	ld	a5,32(a5)
    80202b9c:	6f9c                	ld	a5,24(a5)
    80202b9e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:21
  return (entry);
    80202ba2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:22
}
    80202ba6:	853e                	mv	a0,a5
    80202ba8:	7422                	ld	s0,40(sp)
    80202baa:	6145                	addi	sp,sp,48
    80202bac:	8082                	ret

0000000080202bae <elf_header_get_shoff>:
elf_header_get_shoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:17
#include "elfparse.h"

/*
** Get the section header table offset
*/
size_t elf_header_get_shoff(t_elf *elf) {
    80202bae:	7179                	addi	sp,sp,-48
    80202bb0:	f422                	sd	s0,40(sp)
    80202bb2:	1800                	addi	s0,sp,48
    80202bb4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:20
  size_t shoff;

  if (ELF_IS_32(elf))
    80202bb8:	fd843783          	ld	a5,-40(s0)
    80202bbc:	0187c783          	lbu	a5,24(a5)
    80202bc0:	873e                	mv	a4,a5
    80202bc2:	4785                	li	a5,1
    80202bc4:	00f71b63          	bne	a4,a5,80202bda <elf_header_get_shoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:21
    shoff = (size_t)elf->header->_32.e_shoff;
    80202bc8:	fd843783          	ld	a5,-40(s0)
    80202bcc:	739c                	ld	a5,32(a5)
    80202bce:	539c                	lw	a5,32(a5)
    80202bd0:	1782                	slli	a5,a5,0x20
    80202bd2:	9381                	srli	a5,a5,0x20
    80202bd4:	fef43423          	sd	a5,-24(s0)
    80202bd8:	a039                	j	80202be6 <elf_header_get_shoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:23
  else
    shoff = (size_t)elf->header->_64.e_shoff;
    80202bda:	fd843783          	ld	a5,-40(s0)
    80202bde:	739c                	ld	a5,32(a5)
    80202be0:	779c                	ld	a5,40(a5)
    80202be2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:24
  return (shoff);
    80202be6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:25
}
    80202bea:	853e                	mv	a0,a5
    80202bec:	7422                	ld	s0,40(sp)
    80202bee:	6145                	addi	sp,sp,48
    80202bf0:	8082                	ret

0000000080202bf2 <elf_header_get_shentsize>:
elf_header_get_shentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:30

/*
** Get the size of one section header
*/
size_t elf_header_get_shentsize(t_elf *elf) {
    80202bf2:	7179                	addi	sp,sp,-48
    80202bf4:	f422                	sd	s0,40(sp)
    80202bf6:	1800                	addi	s0,sp,48
    80202bf8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:33
  size_t shentsize;

  if (ELF_IS_32(elf))
    80202bfc:	fd843783          	ld	a5,-40(s0)
    80202c00:	0187c783          	lbu	a5,24(a5)
    80202c04:	873e                	mv	a4,a5
    80202c06:	4785                	li	a5,1
    80202c08:	00f71a63          	bne	a4,a5,80202c1c <elf_header_get_shentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:34
    shentsize = (size_t)elf->header->_32.e_shentsize;
    80202c0c:	fd843783          	ld	a5,-40(s0)
    80202c10:	739c                	ld	a5,32(a5)
    80202c12:	02e7d783          	lhu	a5,46(a5)
    80202c16:	fef43423          	sd	a5,-24(s0)
    80202c1a:	a801                	j	80202c2a <elf_header_get_shentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:36
  else
    shentsize = (size_t)elf->header->_64.e_shentsize;
    80202c1c:	fd843783          	ld	a5,-40(s0)
    80202c20:	739c                	ld	a5,32(a5)
    80202c22:	03a7d783          	lhu	a5,58(a5)
    80202c26:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:37
  return (shentsize);
    80202c2a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:38
}
    80202c2e:	853e                	mv	a0,a5
    80202c30:	7422                	ld	s0,40(sp)
    80202c32:	6145                	addi	sp,sp,48
    80202c34:	8082                	ret

0000000080202c36 <elf_header_get_shnum>:
elf_header_get_shnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:43

/*
** Get the number of entry in the section header table
*/
size_t elf_header_get_shnum(t_elf *elf) {
    80202c36:	7179                	addi	sp,sp,-48
    80202c38:	f422                	sd	s0,40(sp)
    80202c3a:	1800                	addi	s0,sp,48
    80202c3c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:46
  size_t shum;

  if (ELF_IS_32(elf))
    80202c40:	fd843783          	ld	a5,-40(s0)
    80202c44:	0187c783          	lbu	a5,24(a5)
    80202c48:	873e                	mv	a4,a5
    80202c4a:	4785                	li	a5,1
    80202c4c:	00f71a63          	bne	a4,a5,80202c60 <elf_header_get_shnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:47
    shum = (size_t)elf->header->_32.e_shnum;
    80202c50:	fd843783          	ld	a5,-40(s0)
    80202c54:	739c                	ld	a5,32(a5)
    80202c56:	0307d783          	lhu	a5,48(a5)
    80202c5a:	fef43423          	sd	a5,-24(s0)
    80202c5e:	a801                	j	80202c6e <elf_header_get_shnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:49
  else
    shum = (size_t)elf->header->_64.e_shnum;
    80202c60:	fd843783          	ld	a5,-40(s0)
    80202c64:	739c                	ld	a5,32(a5)
    80202c66:	03c7d783          	lhu	a5,60(a5)
    80202c6a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:50
  return (shum);
    80202c6e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:51
}
    80202c72:	853e                	mv	a0,a5
    80202c74:	7422                	ld	s0,40(sp)
    80202c76:	6145                	addi	sp,sp,48
    80202c78:	8082                	ret

0000000080202c7a <elf_program_get_type>:
elf_program_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:8
#include "elfparse.h"

/*
** Get the program type.
*/
uint32_t elf_program_get_type(t_elf *elf, t_elf_program *program) {
    80202c7a:	7179                	addi	sp,sp,-48
    80202c7c:	f422                	sd	s0,40(sp)
    80202c7e:	1800                	addi	s0,sp,48
    80202c80:	fca43c23          	sd	a0,-40(s0)
    80202c84:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:11
  uint32_t type;

  if (ELF_IS_32(elf))
    80202c88:	fd843783          	ld	a5,-40(s0)
    80202c8c:	0187c783          	lbu	a5,24(a5)
    80202c90:	873e                	mv	a4,a5
    80202c92:	4785                	li	a5,1
    80202c94:	00f71963          	bne	a4,a5,80202ca6 <elf_program_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:12
    type = (uint32_t)program->header->_32.p_type;
    80202c98:	fd043783          	ld	a5,-48(s0)
    80202c9c:	639c                	ld	a5,0(a5)
    80202c9e:	439c                	lw	a5,0(a5)
    80202ca0:	fef42623          	sw	a5,-20(s0)
    80202ca4:	a039                	j	80202cb2 <elf_program_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:14
  else
    type = (uint32_t)program->header->_64.p_type;
    80202ca6:	fd043783          	ld	a5,-48(s0)
    80202caa:	639c                	ld	a5,0(a5)
    80202cac:	439c                	lw	a5,0(a5)
    80202cae:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:15
  return (type);
    80202cb2:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:16
}
    80202cb6:	853e                	mv	a0,a5
    80202cb8:	7422                	ld	s0,40(sp)
    80202cba:	6145                	addi	sp,sp,48
    80202cbc:	8082                	ret

0000000080202cbe <elf_program_get_offset>:
elf_program_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:21

/*
** Get the program offset (from the begin of the file)
*/
size_t elf_program_get_offset(t_elf *elf, t_elf_program *program) {
    80202cbe:	7179                	addi	sp,sp,-48
    80202cc0:	f422                	sd	s0,40(sp)
    80202cc2:	1800                	addi	s0,sp,48
    80202cc4:	fca43c23          	sd	a0,-40(s0)
    80202cc8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:24
  size_t offset;

  if (ELF_IS_32(elf))
    80202ccc:	fd843783          	ld	a5,-40(s0)
    80202cd0:	0187c783          	lbu	a5,24(a5)
    80202cd4:	873e                	mv	a4,a5
    80202cd6:	4785                	li	a5,1
    80202cd8:	00f71b63          	bne	a4,a5,80202cee <elf_program_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:25
    offset = (size_t)program->header->_32.p_offset;
    80202cdc:	fd043783          	ld	a5,-48(s0)
    80202ce0:	639c                	ld	a5,0(a5)
    80202ce2:	43dc                	lw	a5,4(a5)
    80202ce4:	1782                	slli	a5,a5,0x20
    80202ce6:	9381                	srli	a5,a5,0x20
    80202ce8:	fef43423          	sd	a5,-24(s0)
    80202cec:	a039                	j	80202cfa <elf_program_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:27
  else
    offset = (size_t)program->header->_64.p_offset;
    80202cee:	fd043783          	ld	a5,-48(s0)
    80202cf2:	639c                	ld	a5,0(a5)
    80202cf4:	679c                	ld	a5,8(a5)
    80202cf6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:28
  return (offset);
    80202cfa:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:29
}
    80202cfe:	853e                	mv	a0,a5
    80202d00:	7422                	ld	s0,40(sp)
    80202d02:	6145                	addi	sp,sp,48
    80202d04:	8082                	ret

0000000080202d06 <elf_program_get_flags>:
elf_program_get_flags():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:34

/*
** Get the flags of the program
*/
uint64_t elf_program_get_flags(t_elf *elf, t_elf_program *program) {
    80202d06:	7179                	addi	sp,sp,-48
    80202d08:	f422                	sd	s0,40(sp)
    80202d0a:	1800                	addi	s0,sp,48
    80202d0c:	fca43c23          	sd	a0,-40(s0)
    80202d10:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:37
  uint64_t flags;

  if (ELF_IS_32(elf))
    80202d14:	fd843783          	ld	a5,-40(s0)
    80202d18:	0187c783          	lbu	a5,24(a5)
    80202d1c:	873e                	mv	a4,a5
    80202d1e:	4785                	li	a5,1
    80202d20:	00f71b63          	bne	a4,a5,80202d36 <elf_program_get_flags+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:38
    flags = (uint64_t)program->header->_32.p_flags;
    80202d24:	fd043783          	ld	a5,-48(s0)
    80202d28:	639c                	ld	a5,0(a5)
    80202d2a:	4f9c                	lw	a5,24(a5)
    80202d2c:	1782                	slli	a5,a5,0x20
    80202d2e:	9381                	srli	a5,a5,0x20
    80202d30:	fef43423          	sd	a5,-24(s0)
    80202d34:	a809                	j	80202d46 <elf_program_get_flags+0x40>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:40
  else
    flags = (uint64_t)program->header->_64.p_flags;
    80202d36:	fd043783          	ld	a5,-48(s0)
    80202d3a:	639c                	ld	a5,0(a5)
    80202d3c:	43dc                	lw	a5,4(a5)
    80202d3e:	1782                	slli	a5,a5,0x20
    80202d40:	9381                	srli	a5,a5,0x20
    80202d42:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:41
  return (flags);
    80202d46:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:42
}
    80202d4a:	853e                	mv	a0,a5
    80202d4c:	7422                	ld	s0,40(sp)
    80202d4e:	6145                	addi	sp,sp,48
    80202d50:	8082                	ret

0000000080202d52 <elf_program_get_vaddr>:
elf_program_get_vaddr():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:47

/*
** Get the virtual address of the program
*/
uint64_t elf_program_get_vaddr(t_elf *elf, t_elf_program *program) {
    80202d52:	7179                	addi	sp,sp,-48
    80202d54:	f422                	sd	s0,40(sp)
    80202d56:	1800                	addi	s0,sp,48
    80202d58:	fca43c23          	sd	a0,-40(s0)
    80202d5c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:50
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202d60:	fd843783          	ld	a5,-40(s0)
    80202d64:	0187c783          	lbu	a5,24(a5)
    80202d68:	873e                	mv	a4,a5
    80202d6a:	4785                	li	a5,1
    80202d6c:	00f71b63          	bne	a4,a5,80202d82 <elf_program_get_vaddr+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:51
    addr = (uint64_t)program->header->_32.p_vaddr;
    80202d70:	fd043783          	ld	a5,-48(s0)
    80202d74:	639c                	ld	a5,0(a5)
    80202d76:	479c                	lw	a5,8(a5)
    80202d78:	1782                	slli	a5,a5,0x20
    80202d7a:	9381                	srli	a5,a5,0x20
    80202d7c:	fef43423          	sd	a5,-24(s0)
    80202d80:	a039                	j	80202d8e <elf_program_get_vaddr+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:53
  else
    addr = (uint64_t)program->header->_64.p_vaddr;
    80202d82:	fd043783          	ld	a5,-48(s0)
    80202d86:	639c                	ld	a5,0(a5)
    80202d88:	6b9c                	ld	a5,16(a5)
    80202d8a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:54
  return (addr);
    80202d8e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:55
}
    80202d92:	853e                	mv	a0,a5
    80202d94:	7422                	ld	s0,40(sp)
    80202d96:	6145                	addi	sp,sp,48
    80202d98:	8082                	ret

0000000080202d9a <elf_program_get_memsz>:
elf_program_get_memsz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:60

/*
** Get the memory size of the program
*/
uint64_t elf_program_get_memsz(t_elf *elf, t_elf_program *program) {
    80202d9a:	7179                	addi	sp,sp,-48
    80202d9c:	f422                	sd	s0,40(sp)
    80202d9e:	1800                	addi	s0,sp,48
    80202da0:	fca43c23          	sd	a0,-40(s0)
    80202da4:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:63
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202da8:	fd843783          	ld	a5,-40(s0)
    80202dac:	0187c783          	lbu	a5,24(a5)
    80202db0:	873e                	mv	a4,a5
    80202db2:	4785                	li	a5,1
    80202db4:	00f71b63          	bne	a4,a5,80202dca <elf_program_get_memsz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:64
    addr = (uint64_t)program->header->_32.p_memsz;
    80202db8:	fd043783          	ld	a5,-48(s0)
    80202dbc:	639c                	ld	a5,0(a5)
    80202dbe:	4bdc                	lw	a5,20(a5)
    80202dc0:	1782                	slli	a5,a5,0x20
    80202dc2:	9381                	srli	a5,a5,0x20
    80202dc4:	fef43423          	sd	a5,-24(s0)
    80202dc8:	a039                	j	80202dd6 <elf_program_get_memsz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:66
  else
    addr = (uint64_t)program->header->_64.p_memsz;
    80202dca:	fd043783          	ld	a5,-48(s0)
    80202dce:	639c                	ld	a5,0(a5)
    80202dd0:	779c                	ld	a5,40(a5)
    80202dd2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:67
  return (addr);
    80202dd6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:68
}
    80202dda:	853e                	mv	a0,a5
    80202ddc:	7422                	ld	s0,40(sp)
    80202dde:	6145                	addi	sp,sp,48
    80202de0:	8082                	ret

0000000080202de2 <elf_program_get_filesz>:
elf_program_get_filesz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:73

/*
** Get the file size of the program
*/
uint64_t elf_program_get_filesz(t_elf *elf, t_elf_program *program) {
    80202de2:	7179                	addi	sp,sp,-48
    80202de4:	f422                	sd	s0,40(sp)
    80202de6:	1800                	addi	s0,sp,48
    80202de8:	fca43c23          	sd	a0,-40(s0)
    80202dec:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:76
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202df0:	fd843783          	ld	a5,-40(s0)
    80202df4:	0187c783          	lbu	a5,24(a5)
    80202df8:	873e                	mv	a4,a5
    80202dfa:	4785                	li	a5,1
    80202dfc:	00f71b63          	bne	a4,a5,80202e12 <elf_program_get_filesz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:77
    addr = (uint64_t)program->header->_32.p_filesz;
    80202e00:	fd043783          	ld	a5,-48(s0)
    80202e04:	639c                	ld	a5,0(a5)
    80202e06:	4b9c                	lw	a5,16(a5)
    80202e08:	1782                	slli	a5,a5,0x20
    80202e0a:	9381                	srli	a5,a5,0x20
    80202e0c:	fef43423          	sd	a5,-24(s0)
    80202e10:	a039                	j	80202e1e <elf_program_get_filesz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:79
  else
    addr = (uint64_t)program->header->_64.p_filesz;
    80202e12:	fd043783          	ld	a5,-48(s0)
    80202e16:	639c                	ld	a5,0(a5)
    80202e18:	739c                	ld	a5,32(a5)
    80202e1a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:80
  return (addr);
    80202e1e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:81
}
    80202e22:	853e                	mv	a0,a5
    80202e24:	7422                	ld	s0,40(sp)
    80202e26:	6145                	addi	sp,sp,48
    80202e28:	8082                	ret

0000000080202e2a <elf_load_ident>:
elf_load_ident():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:18
#include "string.h"
/*
** Load the identity of the file.
*/
static int elf_load_ident(t_elf *elf) 
{
    80202e2a:	1101                	addi	sp,sp,-32
    80202e2c:	ec06                	sd	ra,24(sp)
    80202e2e:	e822                	sd	s0,16(sp)
    80202e30:	1000                	addi	s0,sp,32
    80202e32:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:19
  if (elf->size < EI_NIDENT || memcmp(elf->raw_data, ELFMAG, 4)) {
    80202e36:	fe843783          	ld	a5,-24(s0)
    80202e3a:	6398                	ld	a4,0(a5)
    80202e3c:	47bd                	li	a5,15
    80202e3e:	00e7ff63          	bgeu	a5,a4,80202e5c <elf_load_ident+0x32>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:19 (discriminator 1)
    80202e42:	fe843783          	ld	a5,-24(s0)
    80202e46:	679c                	ld	a5,8(a5)
    80202e48:	4611                	li	a2,4
    80202e4a:	00006597          	auipc	a1,0x6
    80202e4e:	27e58593          	addi	a1,a1,638 # 802090c8 <MMIO+0x40>
    80202e52:	853e                	mv	a0,a5
    80202e54:	175000ef          	jal	ra,802037c8 <memcmp>
    80202e58:	87aa                	mv	a5,a0
    80202e5a:	c399                	beqz	a5,80202e60 <elf_load_ident+0x36>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:20
    return (-1);
    80202e5c:	57fd                	li	a5,-1
    80202e5e:	a801                	j	80202e6e <elf_load_ident+0x44>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:22
  }
  elf->ident = elf->raw_data;
    80202e60:	fe843783          	ld	a5,-24(s0)
    80202e64:	6798                	ld	a4,8(a5)
    80202e66:	fe843783          	ld	a5,-24(s0)
    80202e6a:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:23
  return (0);
    80202e6c:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:24
}
    80202e6e:	853e                	mv	a0,a5
    80202e70:	60e2                	ld	ra,24(sp)
    80202e72:	6442                	ld	s0,16(sp)
    80202e74:	6105                	addi	sp,sp,32
    80202e76:	8082                	ret

0000000080202e78 <elf_load_header>:
elf_load_header():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:31
/*
** Load the elf header in the elf structure.
** The identity is loaded first. Then, when the file class has been
** reconized, the entire header is loaded in the field 'elf->header'
*/
int elf_load_header(t_elf *elf) {
    80202e78:	1101                	addi	sp,sp,-32
    80202e7a:	ec06                	sd	ra,24(sp)
    80202e7c:	e822                	sd	s0,16(sp)
    80202e7e:	1000                	addi	s0,sp,32
    80202e80:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:33
  //printk("eld load_header\n");
  if (elf_load_ident(elf) == -1)
    80202e84:	fe843503          	ld	a0,-24(s0)
    80202e88:	fa3ff0ef          	jal	ra,80202e2a <elf_load_ident>
    80202e8c:	87aa                	mv	a5,a0
    80202e8e:	873e                	mv	a4,a5
    80202e90:	57fd                	li	a5,-1
    80202e92:	00f71463          	bne	a4,a5,80202e9a <elf_load_header+0x22>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:34
    return (-1);
    80202e96:	57fd                	li	a5,-1
    80202e98:	a059                	j	80202f1e <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:35
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80202e9a:	fe843783          	ld	a5,-24(s0)
    80202e9e:	6b9c                	ld	a5,16(a5)
    80202ea0:	0047c703          	lbu	a4,4(a5)
    80202ea4:	fe843783          	ld	a5,-24(s0)
    80202ea8:	00e78c23          	sb	a4,24(a5)
    80202eac:	fe843783          	ld	a5,-24(s0)
    80202eb0:	0187c783          	lbu	a5,24(a5)
    80202eb4:	873e                	mv	a4,a5
    80202eb6:	4785                	li	a5,1
    80202eb8:	00f70c63          	beq	a4,a5,80202ed0 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:36 (discriminator 1)
      elf->class != ELFCLASS64) {
    80202ebc:	fe843783          	ld	a5,-24(s0)
    80202ec0:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:35 (discriminator 1)
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80202ec4:	873e                	mv	a4,a5
    80202ec6:	4789                	li	a5,2
    80202ec8:	00f70463          	beq	a4,a5,80202ed0 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:37
    return (-1);
    80202ecc:	57fd                	li	a5,-1
    80202ece:	a881                	j	80202f1e <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:39
  }
  elf->header = (t_elf_header *)elf->raw_data;
    80202ed0:	fe843783          	ld	a5,-24(s0)
    80202ed4:	6798                	ld	a4,8(a5)
    80202ed6:	fe843783          	ld	a5,-24(s0)
    80202eda:	f398                	sd	a4,32(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:40
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80202edc:	fe843783          	ld	a5,-24(s0)
    80202ee0:	0187c783          	lbu	a5,24(a5)
    80202ee4:	873e                	mv	a4,a5
    80202ee6:	4785                	li	a5,1
    80202ee8:	00f71963          	bne	a4,a5,80202efa <elf_load_header+0x82>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:40 (discriminator 1)
    80202eec:	fe843783          	ld	a5,-24(s0)
    80202ef0:	6398                	ld	a4,0(a5)
    80202ef2:	03300793          	li	a5,51
    80202ef6:	02e7f163          	bgeu	a5,a4,80202f18 <elf_load_header+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:41 (discriminator 3)
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80202efa:	fe843783          	ld	a5,-24(s0)
    80202efe:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:40 (discriminator 3)
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80202f02:	873e                	mv	a4,a5
    80202f04:	4789                	li	a5,2
    80202f06:	00f71b63          	bne	a4,a5,80202f1c <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:41
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80202f0a:	fe843783          	ld	a5,-24(s0)
    80202f0e:	6398                	ld	a4,0(a5)
    80202f10:	03f00793          	li	a5,63
    80202f14:	00e7e463          	bltu	a5,a4,80202f1c <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:42
    return (-1);
    80202f18:	57fd                	li	a5,-1
    80202f1a:	a011                	j	80202f1e <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:45
  }
  //printk("eld load end\n");
  return (0);
    80202f1c:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:46
}
    80202f1e:	853e                	mv	a0,a5
    80202f20:	60e2                	ld	ra,24(sp)
    80202f22:	6442                	ld	s0,16(sp)
    80202f24:	6105                	addi	sp,sp,32
    80202f26:	8082                	ret

0000000080202f28 <elf_load>:
elf_load():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:10
/*
** Load the elf file present in the buffer.
** This function is used to parse elf file contained in a static library
** archive.
*/
int elf_load(uint8_t *elf_data, size_t elf_size, t_elf *elf) {
    80202f28:	7179                	addi	sp,sp,-48
    80202f2a:	f406                	sd	ra,40(sp)
    80202f2c:	f022                	sd	s0,32(sp)
    80202f2e:	1800                	addi	s0,sp,48
    80202f30:	fea43423          	sd	a0,-24(s0)
    80202f34:	feb43023          	sd	a1,-32(s0)
    80202f38:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:12
  //printk("elf load\n");
  memset(elf, 0, sizeof(t_elf));
    80202f3c:	6785                	lui	a5,0x1
    80202f3e:	82878613          	addi	a2,a5,-2008 # 828 <n+0x808>
    80202f42:	4581                	li	a1,0
    80202f44:	fd843503          	ld	a0,-40(s0)
    80202f48:	049000ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:13
  elf->size = elf_size;
    80202f4c:	fd843783          	ld	a5,-40(s0)
    80202f50:	fe043703          	ld	a4,-32(s0)
    80202f54:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:14
  elf->raw_data = elf_data;
    80202f56:	fd843783          	ld	a5,-40(s0)
    80202f5a:	fe843703          	ld	a4,-24(s0)
    80202f5e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:16

  if (elf_load_header(elf) != 0) {
    80202f60:	fd843503          	ld	a0,-40(s0)
    80202f64:	f15ff0ef          	jal	ra,80202e78 <elf_load_header>
    80202f68:	87aa                	mv	a5,a0
    80202f6a:	c399                	beqz	a5,80202f70 <elf_load+0x48>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:17
    return -1;
    80202f6c:	57fd                	li	a5,-1
    80202f6e:	a015                	j	80202f92 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:20
  }

  if (elf_load_sections(elf) != 0) {
    80202f70:	fd843503          	ld	a0,-40(s0)
    80202f74:	b5fff0ef          	jal	ra,80202ad2 <elf_load_sections>
    80202f78:	87aa                	mv	a5,a0
    80202f7a:	c399                	beqz	a5,80202f80 <elf_load+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:21
    return -1;
    80202f7c:	57fd                	li	a5,-1
    80202f7e:	a811                	j	80202f92 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:24
  }

  if (elf_load_programs(elf) != 0) {
    80202f80:	fd843503          	ld	a0,-40(s0)
    80202f84:	29c000ef          	jal	ra,80203220 <elf_load_programs>
    80202f88:	87aa                	mv	a5,a0
    80202f8a:	c399                	beqz	a5,80202f90 <elf_load+0x68>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:25
    return -1;
    80202f8c:	57fd                	li	a5,-1
    80202f8e:	a011                	j	80202f92 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:28
  }
  //printk("elf load end\n");
  return 0;
    80202f90:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:29
}
    80202f92:	853e                	mv	a0,a5
    80202f94:	70a2                	ld	ra,40(sp)
    80202f96:	7402                	ld	s0,32(sp)
    80202f98:	6145                	addi	sp,sp,48
    80202f9a:	8082                	ret

0000000080202f9c <elf_section_get_type>:
elf_section_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:17
#include "elfparse.h"

/*
** Get the section type.
*/
uint32_t elf_section_get_type(t_elf *elf, t_elf_section *section) {
    80202f9c:	7179                	addi	sp,sp,-48
    80202f9e:	f422                	sd	s0,40(sp)
    80202fa0:	1800                	addi	s0,sp,48
    80202fa2:	fca43c23          	sd	a0,-40(s0)
    80202fa6:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:20
  uint32_t type;

  if (ELF_IS_32(elf))
    80202faa:	fd843783          	ld	a5,-40(s0)
    80202fae:	0187c783          	lbu	a5,24(a5)
    80202fb2:	873e                	mv	a4,a5
    80202fb4:	4785                	li	a5,1
    80202fb6:	00f71963          	bne	a4,a5,80202fc8 <elf_section_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:21
    type = (uint32_t)section->header->_32.sh_type;
    80202fba:	fd043783          	ld	a5,-48(s0)
    80202fbe:	639c                	ld	a5,0(a5)
    80202fc0:	43dc                	lw	a5,4(a5)
    80202fc2:	fef42623          	sw	a5,-20(s0)
    80202fc6:	a039                	j	80202fd4 <elf_section_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:23
  else
    type = (uint32_t)section->header->_64.sh_type;
    80202fc8:	fd043783          	ld	a5,-48(s0)
    80202fcc:	639c                	ld	a5,0(a5)
    80202fce:	43dc                	lw	a5,4(a5)
    80202fd0:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:24
  return (type);
    80202fd4:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:25
}
    80202fd8:	853e                	mv	a0,a5
    80202fda:	7422                	ld	s0,40(sp)
    80202fdc:	6145                	addi	sp,sp,48
    80202fde:	8082                	ret

0000000080202fe0 <elf_section_get_offset>:
elf_section_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:30

/*
** Get the section offset (from the begin of the file)
*/
size_t elf_section_get_offset(t_elf *elf, t_elf_section *section) {
    80202fe0:	7179                	addi	sp,sp,-48
    80202fe2:	f422                	sd	s0,40(sp)
    80202fe4:	1800                	addi	s0,sp,48
    80202fe6:	fca43c23          	sd	a0,-40(s0)
    80202fea:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:33
  size_t offset;

  if (ELF_IS_32(elf))
    80202fee:	fd843783          	ld	a5,-40(s0)
    80202ff2:	0187c783          	lbu	a5,24(a5)
    80202ff6:	873e                	mv	a4,a5
    80202ff8:	4785                	li	a5,1
    80202ffa:	00f71b63          	bne	a4,a5,80203010 <elf_section_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:34
    offset = (size_t)section->header->_32.sh_offset;
    80202ffe:	fd043783          	ld	a5,-48(s0)
    80203002:	639c                	ld	a5,0(a5)
    80203004:	4b9c                	lw	a5,16(a5)
    80203006:	1782                	slli	a5,a5,0x20
    80203008:	9381                	srli	a5,a5,0x20
    8020300a:	fef43423          	sd	a5,-24(s0)
    8020300e:	a039                	j	8020301c <elf_section_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:36
  else
    offset = (size_t)section->header->_64.sh_offset;
    80203010:	fd043783          	ld	a5,-48(s0)
    80203014:	639c                	ld	a5,0(a5)
    80203016:	6f9c                	ld	a5,24(a5)
    80203018:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:37
  return (offset);
    8020301c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:38
}
    80203020:	853e                	mv	a0,a5
    80203022:	7422                	ld	s0,40(sp)
    80203024:	6145                	addi	sp,sp,48
    80203026:	8082                	ret

0000000080203028 <elf_section_get_size>:
elf_section_get_size():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:43

/*
** Get the size of the section
*/
size_t elf_section_get_size(t_elf *elf, t_elf_section *section) {
    80203028:	7179                	addi	sp,sp,-48
    8020302a:	f422                	sd	s0,40(sp)
    8020302c:	1800                	addi	s0,sp,48
    8020302e:	fca43c23          	sd	a0,-40(s0)
    80203032:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:46
  size_t size;

  if (ELF_IS_32(elf))
    80203036:	fd843783          	ld	a5,-40(s0)
    8020303a:	0187c783          	lbu	a5,24(a5)
    8020303e:	873e                	mv	a4,a5
    80203040:	4785                	li	a5,1
    80203042:	00f71b63          	bne	a4,a5,80203058 <elf_section_get_size+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:47
    size = (size_t)section->header->_32.sh_size;
    80203046:	fd043783          	ld	a5,-48(s0)
    8020304a:	639c                	ld	a5,0(a5)
    8020304c:	4bdc                	lw	a5,20(a5)
    8020304e:	1782                	slli	a5,a5,0x20
    80203050:	9381                	srli	a5,a5,0x20
    80203052:	fef43423          	sd	a5,-24(s0)
    80203056:	a039                	j	80203064 <elf_section_get_size+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:49
  else
    size = (size_t)section->header->_64.sh_size;
    80203058:	fd043783          	ld	a5,-48(s0)
    8020305c:	639c                	ld	a5,0(a5)
    8020305e:	739c                	ld	a5,32(a5)
    80203060:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:50
  return (size);
    80203064:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:51
}
    80203068:	853e                	mv	a0,a5
    8020306a:	7422                	ld	s0,40(sp)
    8020306c:	6145                	addi	sp,sp,48
    8020306e:	8082                	ret

0000000080203070 <elf_header_get_phoff>:
elf_header_get_phoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:17
#include "elfparse.h"

/*
** Get the program header table offset
*/
size_t elf_header_get_phoff(t_elf *elf) {
    80203070:	7179                	addi	sp,sp,-48
    80203072:	f422                	sd	s0,40(sp)
    80203074:	1800                	addi	s0,sp,48
    80203076:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:20
  size_t phoff;

  if (ELF_IS_32(elf))
    8020307a:	fd843783          	ld	a5,-40(s0)
    8020307e:	0187c783          	lbu	a5,24(a5)
    80203082:	873e                	mv	a4,a5
    80203084:	4785                	li	a5,1
    80203086:	00f71b63          	bne	a4,a5,8020309c <elf_header_get_phoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:21
    phoff = (size_t)elf->header->_32.e_phoff;
    8020308a:	fd843783          	ld	a5,-40(s0)
    8020308e:	739c                	ld	a5,32(a5)
    80203090:	4fdc                	lw	a5,28(a5)
    80203092:	1782                	slli	a5,a5,0x20
    80203094:	9381                	srli	a5,a5,0x20
    80203096:	fef43423          	sd	a5,-24(s0)
    8020309a:	a039                	j	802030a8 <elf_header_get_phoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:23
  else
    phoff = (size_t)elf->header->_64.e_phoff;
    8020309c:	fd843783          	ld	a5,-40(s0)
    802030a0:	739c                	ld	a5,32(a5)
    802030a2:	739c                	ld	a5,32(a5)
    802030a4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:24
  return (phoff);
    802030a8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:25
}
    802030ac:	853e                	mv	a0,a5
    802030ae:	7422                	ld	s0,40(sp)
    802030b0:	6145                	addi	sp,sp,48
    802030b2:	8082                	ret

00000000802030b4 <elf_header_get_phentsize>:
elf_header_get_phentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:30

/*
** Get the size of one program header
*/
size_t elf_header_get_phentsize(t_elf *elf) {
    802030b4:	7179                	addi	sp,sp,-48
    802030b6:	f422                	sd	s0,40(sp)
    802030b8:	1800                	addi	s0,sp,48
    802030ba:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:33
  size_t phentsize;

  if (ELF_IS_32(elf))
    802030be:	fd843783          	ld	a5,-40(s0)
    802030c2:	0187c783          	lbu	a5,24(a5)
    802030c6:	873e                	mv	a4,a5
    802030c8:	4785                	li	a5,1
    802030ca:	00f71a63          	bne	a4,a5,802030de <elf_header_get_phentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:34
    phentsize = (size_t)elf->header->_32.e_phentsize;
    802030ce:	fd843783          	ld	a5,-40(s0)
    802030d2:	739c                	ld	a5,32(a5)
    802030d4:	02a7d783          	lhu	a5,42(a5)
    802030d8:	fef43423          	sd	a5,-24(s0)
    802030dc:	a801                	j	802030ec <elf_header_get_phentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:36
  else
    phentsize = (size_t)elf->header->_64.e_phentsize;
    802030de:	fd843783          	ld	a5,-40(s0)
    802030e2:	739c                	ld	a5,32(a5)
    802030e4:	0367d783          	lhu	a5,54(a5)
    802030e8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:37
  return (phentsize);
    802030ec:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:38
}
    802030f0:	853e                	mv	a0,a5
    802030f2:	7422                	ld	s0,40(sp)
    802030f4:	6145                	addi	sp,sp,48
    802030f6:	8082                	ret

00000000802030f8 <elf_header_get_phnum>:
elf_header_get_phnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:43

/*
** Get the number of entry in the program header table
*/
size_t elf_header_get_phnum(t_elf *elf) {
    802030f8:	7179                	addi	sp,sp,-48
    802030fa:	f422                	sd	s0,40(sp)
    802030fc:	1800                	addi	s0,sp,48
    802030fe:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:46
  size_t phnum;

  if (ELF_IS_32(elf))
    80203102:	fd843783          	ld	a5,-40(s0)
    80203106:	0187c783          	lbu	a5,24(a5)
    8020310a:	873e                	mv	a4,a5
    8020310c:	4785                	li	a5,1
    8020310e:	00f71a63          	bne	a4,a5,80203122 <elf_header_get_phnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:47
    phnum = (size_t)elf->header->_32.e_phnum;
    80203112:	fd843783          	ld	a5,-40(s0)
    80203116:	739c                	ld	a5,32(a5)
    80203118:	02c7d783          	lhu	a5,44(a5)
    8020311c:	fef43423          	sd	a5,-24(s0)
    80203120:	a801                	j	80203130 <elf_header_get_phnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:49
  else
    phnum = (size_t)elf->header->_64.e_phnum;
    80203122:	fd843783          	ld	a5,-40(s0)
    80203126:	739c                	ld	a5,32(a5)
    80203128:	0387d783          	lhu	a5,56(a5)
    8020312c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:50
  return (phnum);
    80203130:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:51
}
    80203134:	853e                	mv	a0,a5
    80203136:	7422                	ld	s0,40(sp)
    80203138:	6145                	addi	sp,sp,48
    8020313a:	8082                	ret

000000008020313c <elf_load_programs_loop>:
elf_load_programs_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:9

/*
** traverse the program header table and load each segment
*/
static int elf_load_programs_loop(t_elf *elf, size_t phoff, size_t phnum,
                                  size_t phentsize) {
    8020313c:	715d                	addi	sp,sp,-80
    8020313e:	e486                	sd	ra,72(sp)
    80203140:	e0a2                	sd	s0,64(sp)
    80203142:	0880                	addi	s0,sp,80
    80203144:	fca43423          	sd	a0,-56(s0)
    80203148:	fcb43023          	sd	a1,-64(s0)
    8020314c:	fac43c23          	sd	a2,-72(s0)
    80203150:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:14
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    80203154:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    80203158:	a845                	j	80203208 <elf_load_programs_loop+0xcc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:16
    if (i >= MAX_PROGRAM_NUM) {
    8020315a:	fe843703          	ld	a4,-24(s0)
    8020315e:	03f00793          	li	a5,63
    80203162:	00e7f463          	bgeu	a5,a4,8020316a <elf_load_programs_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:17
      return (-1);
    80203166:	57fd                	li	a5,-1
    80203168:	a07d                	j	80203216 <elf_load_programs_loop+0xda>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:20
    }
    elf->programs[i].header =
        (union u_elf_ph *)(elf->raw_data + phoff + i * phentsize);
    8020316a:	fc843783          	ld	a5,-56(s0)
    8020316e:	6798                	ld	a4,8(a5)
    80203170:	fe843683          	ld	a3,-24(s0)
    80203174:	fb043783          	ld	a5,-80(s0)
    80203178:	02f686b3          	mul	a3,a3,a5
    8020317c:	fc043783          	ld	a5,-64(s0)
    80203180:	97b6                	add	a5,a5,a3
    80203182:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:19
    elf->programs[i].header =
    80203184:	fc843683          	ld	a3,-56(s0)
    80203188:	fe843783          	ld	a5,-24(s0)
    8020318c:	04278793          	addi	a5,a5,66
    80203190:	0792                	slli	a5,a5,0x4
    80203192:	97b6                	add	a5,a5,a3
    80203194:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:21
    type = elf_program_get_type(elf, &elf->programs[i]);
    80203196:	fe843783          	ld	a5,-24(s0)
    8020319a:	04278793          	addi	a5,a5,66
    8020319e:	0792                	slli	a5,a5,0x4
    802031a0:	fc843703          	ld	a4,-56(s0)
    802031a4:	97ba                	add	a5,a5,a4
    802031a6:	07a1                	addi	a5,a5,8
    802031a8:	85be                	mv	a1,a5
    802031aa:	fc843503          	ld	a0,-56(s0)
    802031ae:	acdff0ef          	jal	ra,80202c7a <elf_program_get_type>
    802031b2:	87aa                	mv	a5,a0
    802031b4:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:22
    if (type != PT_NULL) {
    802031b8:	fe442783          	lw	a5,-28(s0)
    802031bc:	2781                	sext.w	a5,a5
    802031be:	c3a1                	beqz	a5,802031fe <elf_load_programs_loop+0xc2>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:23
      content_offset = elf_program_get_offset(elf, &elf->programs[i]);
    802031c0:	fe843783          	ld	a5,-24(s0)
    802031c4:	04278793          	addi	a5,a5,66
    802031c8:	0792                	slli	a5,a5,0x4
    802031ca:	fc843703          	ld	a4,-56(s0)
    802031ce:	97ba                	add	a5,a5,a4
    802031d0:	07a1                	addi	a5,a5,8
    802031d2:	85be                	mv	a1,a5
    802031d4:	fc843503          	ld	a0,-56(s0)
    802031d8:	ae7ff0ef          	jal	ra,80202cbe <elf_program_get_offset>
    802031dc:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:24
      elf->programs[i].content = elf->raw_data + content_offset;
    802031e0:	fc843783          	ld	a5,-56(s0)
    802031e4:	6798                	ld	a4,8(a5)
    802031e6:	fd843783          	ld	a5,-40(s0)
    802031ea:	973e                	add	a4,a4,a5
    802031ec:	fc843683          	ld	a3,-56(s0)
    802031f0:	fe843783          	ld	a5,-24(s0)
    802031f4:	04278793          	addi	a5,a5,66
    802031f8:	0792                	slli	a5,a5,0x4
    802031fa:	97b6                	add	a5,a5,a3
    802031fc:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:26
    }
    i++;
    802031fe:	fe843783          	ld	a5,-24(s0)
    80203202:	0785                	addi	a5,a5,1
    80203204:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    80203208:	fe843703          	ld	a4,-24(s0)
    8020320c:	fb843783          	ld	a5,-72(s0)
    80203210:	f4f765e3          	bltu	a4,a5,8020315a <elf_load_programs_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:28
  }
  return (0);
    80203214:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:29
}
    80203216:	853e                	mv	a0,a5
    80203218:	60a6                	ld	ra,72(sp)
    8020321a:	6406                	ld	s0,64(sp)
    8020321c:	6161                	addi	sp,sp,80
    8020321e:	8082                	ret

0000000080203220 <elf_load_programs>:
elf_load_programs():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:35

/*
** Load programs. Create a table of t_elf_program in elf->programs.
** This table is null if there is no program header table.
*/
int elf_load_programs(t_elf *elf) {
    80203220:	7139                	addi	sp,sp,-64
    80203222:	fc06                	sd	ra,56(sp)
    80203224:	f822                	sd	s0,48(sp)
    80203226:	0080                	addi	s0,sp,64
    80203228:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:40
  size_t phoff;
  size_t phnum;
  size_t phentsize;

  if ((phoff = elf_header_get_phoff(elf)) > 0) {
    8020322c:	fc843503          	ld	a0,-56(s0)
    80203230:	e41ff0ef          	jal	ra,80203070 <elf_header_get_phoff>
    80203234:	fea43423          	sd	a0,-24(s0)
    80203238:	fe843783          	ld	a5,-24(s0)
    8020323c:	cfb1                	beqz	a5,80203298 <elf_load_programs+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:41
    phnum = elf_header_get_phnum(elf);
    8020323e:	fc843503          	ld	a0,-56(s0)
    80203242:	eb7ff0ef          	jal	ra,802030f8 <elf_header_get_phnum>
    80203246:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:42
    phentsize = elf_header_get_phentsize(elf);
    8020324a:	fc843503          	ld	a0,-56(s0)
    8020324e:	e67ff0ef          	jal	ra,802030b4 <elf_header_get_phentsize>
    80203252:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:43
    if (phoff + phnum * phentsize > elf->size) {
    80203256:	fe043703          	ld	a4,-32(s0)
    8020325a:	fd843783          	ld	a5,-40(s0)
    8020325e:	02f70733          	mul	a4,a4,a5
    80203262:	fe843783          	ld	a5,-24(s0)
    80203266:	973e                	add	a4,a4,a5
    80203268:	fc843783          	ld	a5,-56(s0)
    8020326c:	639c                	ld	a5,0(a5)
    8020326e:	00e7f463          	bgeu	a5,a4,80203276 <elf_load_programs+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:44
      return (-1);
    80203272:	57fd                	li	a5,-1
    80203274:	a82d                	j	802032ae <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:46
    }
    if (elf_load_programs_loop(elf, phoff, phnum, phentsize) == -1) {
    80203276:	fd843683          	ld	a3,-40(s0)
    8020327a:	fe043603          	ld	a2,-32(s0)
    8020327e:	fe843583          	ld	a1,-24(s0)
    80203282:	fc843503          	ld	a0,-56(s0)
    80203286:	eb7ff0ef          	jal	ra,8020313c <elf_load_programs_loop>
    8020328a:	87aa                	mv	a5,a0
    8020328c:	873e                	mv	a4,a5
    8020328e:	57fd                	li	a5,-1
    80203290:	00f71e63          	bne	a4,a5,802032ac <elf_load_programs+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:47
      return (-1);
    80203294:	57fd                	li	a5,-1
    80203296:	a821                	j	802032ae <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:50
    }
  } else
    memset(elf->programs, 0, MAX_PROGRAM_NUM * sizeof(t_elf_program));
    80203298:	fc843783          	ld	a5,-56(s0)
    8020329c:	42878793          	addi	a5,a5,1064
    802032a0:	40000613          	li	a2,1024
    802032a4:	4581                	li	a1,0
    802032a6:	853e                	mv	a0,a5
    802032a8:	4e8000ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:51
  return (0);
    802032ac:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:52
}
    802032ae:	853e                	mv	a0,a5
    802032b0:	70e2                	ld	ra,56(sp)
    802032b2:	7442                	ld	s0,48(sp)
    802032b4:	6121                	addi	sp,sp,64
    802032b6:	8082                	ret

00000000802032b8 <sbi_call>:
sbi_call():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:16
#define SBI_REMOTE_SFENCE_VMA 6
#define SBI_REMOTE_SFENCE_VMA_ASID 7
#define SBI_SHUTDOWN 8


static inline uint64_t sbi_call(long which, long arg0, long arg1, long arg2) {
    802032b8:	7179                	addi	sp,sp,-48
    802032ba:	f422                	sd	s0,40(sp)
    802032bc:	1800                	addi	s0,sp,48
    802032be:	fea43423          	sd	a0,-24(s0)
    802032c2:	feb43023          	sd	a1,-32(s0)
    802032c6:	fcc43c23          	sd	a2,-40(s0)
    802032ca:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:17
    register long a0 asm("a0") = arg0;
    802032ce:	fe043503          	ld	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:18
    register long a1 asm("a1") = arg1;
    802032d2:	fd843583          	ld	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:19
    register long a2 asm("a2") = arg2;
    802032d6:	fd043603          	ld	a2,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:20
    register long a7 asm("a7") = which;
    802032da:	fe843883          	ld	a7,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:22

    asm volatile("ecall"
    802032de:	00000073          	ecall
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:27
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");

    return a0;
    802032e2:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:28
}
    802032e4:	853e                	mv	a0,a5
    802032e6:	7422                	ld	s0,40(sp)
    802032e8:	6145                	addi	sp,sp,48
    802032ea:	8082                	ret

00000000802032ec <console_putchar>:
console_putchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:30

void console_putchar(uint64_t ch) {
    802032ec:	1101                	addi	sp,sp,-32
    802032ee:	ec06                	sd	ra,24(sp)
    802032f0:	e822                	sd	s0,16(sp)
    802032f2:	1000                	addi	s0,sp,32
    802032f4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:31
    sbi_call(0x01, ch, 0, 0);
    802032f8:	fe843783          	ld	a5,-24(s0)
    802032fc:	4681                	li	a3,0
    802032fe:	4601                	li	a2,0
    80203300:	85be                	mv	a1,a5
    80203302:	4505                	li	a0,1
    80203304:	fb5ff0ef          	jal	ra,802032b8 <sbi_call>
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:32
}
    80203308:	0001                	nop
    8020330a:	60e2                	ld	ra,24(sp)
    8020330c:	6442                	ld	s0,16(sp)
    8020330e:	6105                	addi	sp,sp,32
    80203310:	8082                	ret

0000000080203312 <console_getchar>:
console_getchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:34

uint64_t console_getchar(void) {
    80203312:	1141                	addi	sp,sp,-16
    80203314:	e406                	sd	ra,8(sp)
    80203316:	e022                	sd	s0,0(sp)
    80203318:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:35
    return sbi_call(0x02, 0, 0, 0);
    8020331a:	4681                	li	a3,0
    8020331c:	4601                	li	a2,0
    8020331e:	4581                	li	a1,0
    80203320:	4509                	li	a0,2
    80203322:	f97ff0ef          	jal	ra,802032b8 <sbi_call>
    80203326:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:36
}
    80203328:	853e                	mv	a0,a5
    8020332a:	60a2                	ld	ra,8(sp)
    8020332c:	6402                	ld	s0,0(sp)
    8020332e:	0141                	addi	sp,sp,16
    80203330:	8082                	ret

0000000080203332 <sbi_shutdown>:
sbi_shutdown():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:38

uint64_t sbi_shutdown(void) {
    80203332:	1141                	addi	sp,sp,-16
    80203334:	e406                	sd	ra,8(sp)
    80203336:	e022                	sd	s0,0(sp)
    80203338:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:39
    return sbi_call(0x08, 0, 0, 0);
    8020333a:	4681                	li	a3,0
    8020333c:	4601                	li	a2,0
    8020333e:	4581                	li	a1,0
    80203340:	4521                	li	a0,8
    80203342:	f77ff0ef          	jal	ra,802032b8 <sbi_call>
    80203346:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:40
}
    80203348:	853e                	mv	a0,a5
    8020334a:	60a2                	ld	ra,8(sp)
    8020334c:	6402                	ld	s0,0(sp)
    8020334e:	0141                	addi	sp,sp,16
    80203350:	8082                	ret

0000000080203352 <sbi_set_timer>:
sbi_set_timer():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:43

uint64_t sbi_set_timer(uint64_t stime_value)
{
    80203352:	1101                	addi	sp,sp,-32
    80203354:	ec06                	sd	ra,24(sp)
    80203356:	e822                	sd	s0,16(sp)
    80203358:	1000                	addi	s0,sp,32
    8020335a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:44
    return sbi_call(0x00,stime_value,0,0);
    8020335e:	fe843783          	ld	a5,-24(s0)
    80203362:	4681                	li	a3,0
    80203364:	4601                	li	a2,0
    80203366:	85be                	mv	a1,a5
    80203368:	4501                	li	a0,0
    8020336a:	f4fff0ef          	jal	ra,802032b8 <sbi_call>
    8020336e:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:45
    80203370:	853e                	mv	a0,a5
    80203372:	60e2                	ld	ra,24(sp)
    80203374:	6442                	ld	s0,16(sp)
    80203376:	6105                	addi	sp,sp,32
    80203378:	8082                	ret

000000008020337a <strlen_t>:
strlen_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:6

#include "string.h"


int strlen_t(const char *src)
{
    8020337a:	7179                	addi	sp,sp,-48
    8020337c:	f422                	sd	s0,40(sp)
    8020337e:	1800                	addi	s0,sp,48
    80203380:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8
    int i;
    for (i = 0; src[i] != '\0'; i++) {
    80203384:	fe042623          	sw	zero,-20(s0)
    80203388:	a031                	j	80203394 <strlen_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 3)
    8020338a:	fec42783          	lw	a5,-20(s0)
    8020338e:	2785                	addiw	a5,a5,1
    80203390:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 1)
    80203394:	fec42783          	lw	a5,-20(s0)
    80203398:	fd843703          	ld	a4,-40(s0)
    8020339c:	97ba                	add	a5,a5,a4
    8020339e:	0007c783          	lbu	a5,0(a5)
    802033a2:	f7e5                	bnez	a5,8020338a <strlen_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:10
    }
    return i;
    802033a4:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:11
}
    802033a8:	853e                	mv	a0,a5
    802033aa:	7422                	ld	s0,40(sp)
    802033ac:	6145                	addi	sp,sp,48
    802033ae:	8082                	ret

00000000802033b0 <memcpy_t>:
memcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:14

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    802033b0:	7179                	addi	sp,sp,-48
    802033b2:	f422                	sd	s0,40(sp)
    802033b4:	1800                	addi	s0,sp,48
    802033b6:	fea43423          	sd	a0,-24(s0)
    802033ba:	feb43023          	sd	a1,-32(s0)
    802033be:	87b2                	mv	a5,a2
    802033c0:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15
    for (; len != 0; len--) {
    802033c4:	a035                	j	802033f0 <memcpy_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:16 (discriminator 2)
        *dest++ = *src++;
    802033c6:	fe043703          	ld	a4,-32(s0)
    802033ca:	00170793          	addi	a5,a4,1
    802033ce:	fef43023          	sd	a5,-32(s0)
    802033d2:	fe843783          	ld	a5,-24(s0)
    802033d6:	00178693          	addi	a3,a5,1
    802033da:	fed43423          	sd	a3,-24(s0)
    802033de:	00074703          	lbu	a4,0(a4)
    802033e2:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 2)
    for (; len != 0; len--) {
    802033e6:	fdc42783          	lw	a5,-36(s0)
    802033ea:	37fd                	addiw	a5,a5,-1
    802033ec:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 1)
    802033f0:	fdc42783          	lw	a5,-36(s0)
    802033f4:	2781                	sext.w	a5,a5
    802033f6:	fbe1                	bnez	a5,802033c6 <memcpy_t+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:18
    }
}
    802033f8:	0001                	nop
    802033fa:	0001                	nop
    802033fc:	7422                	ld	s0,40(sp)
    802033fe:	6145                	addi	sp,sp,48
    80203400:	8082                	ret

0000000080203402 <memcmp_t>:
memcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:21

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    80203402:	7139                	addi	sp,sp,-64
    80203404:	fc22                	sd	s0,56(sp)
    80203406:	0080                	addi	s0,sp,64
    80203408:	fca43c23          	sd	a0,-40(s0)
    8020340c:	fcb43823          	sd	a1,-48(s0)
    80203410:	87b2                	mv	a5,a2
    80203412:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22
    for (int i = 0; i < num; ++i) {
    80203416:	fe042623          	sw	zero,-20(s0)
    8020341a:	a8a1                	j	80203472 <memcmp_t+0x70>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:23
        if (((char*)ptr1)[i] != ((char*)ptr2)[i]) {
    8020341c:	fec42783          	lw	a5,-20(s0)
    80203420:	fd843703          	ld	a4,-40(s0)
    80203424:	97ba                	add	a5,a5,a4
    80203426:	0007c683          	lbu	a3,0(a5)
    8020342a:	fec42783          	lw	a5,-20(s0)
    8020342e:	fd043703          	ld	a4,-48(s0)
    80203432:	97ba                	add	a5,a5,a4
    80203434:	0007c783          	lbu	a5,0(a5)
    80203438:	8736                	mv	a4,a3
    8020343a:	02f70763          	beq	a4,a5,80203468 <memcmp_t+0x66>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:24
            return ((char*)ptr1)[i] - ((char*)ptr2)[i];
    8020343e:	fec42783          	lw	a5,-20(s0)
    80203442:	fd843703          	ld	a4,-40(s0)
    80203446:	97ba                	add	a5,a5,a4
    80203448:	0007c783          	lbu	a5,0(a5)
    8020344c:	0007871b          	sext.w	a4,a5
    80203450:	fec42783          	lw	a5,-20(s0)
    80203454:	fd043683          	ld	a3,-48(s0)
    80203458:	97b6                	add	a5,a5,a3
    8020345a:	0007c783          	lbu	a5,0(a5)
    8020345e:	2781                	sext.w	a5,a5
    80203460:	40f707bb          	subw	a5,a4,a5
    80203464:	2781                	sext.w	a5,a5
    80203466:	a831                	j	80203482 <memcmp_t+0x80>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 2)
    for (int i = 0; i < num; ++i) {
    80203468:	fec42783          	lw	a5,-20(s0)
    8020346c:	2785                	addiw	a5,a5,1
    8020346e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 1)
    80203472:	fec42703          	lw	a4,-20(s0)
    80203476:	fcc42783          	lw	a5,-52(s0)
    8020347a:	2781                	sext.w	a5,a5
    8020347c:	faf760e3          	bltu	a4,a5,8020341c <memcmp_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:27
        }
    }
    return 0;
    80203480:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:28
}
    80203482:	853e                	mv	a0,a5
    80203484:	7462                	ld	s0,56(sp)
    80203486:	6121                	addi	sp,sp,64
    80203488:	8082                	ret

000000008020348a <memmove_t>:
memmove_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:31

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    8020348a:	715d                	addi	sp,sp,-80
    8020348c:	e4a2                	sd	s0,72(sp)
    8020348e:	0880                	addi	s0,sp,80
    80203490:	fca43423          	sd	a0,-56(s0)
    80203494:	fcb43023          	sd	a1,-64(s0)
    80203498:	86b2                	mv	a3,a2
    8020349a:	fad42e23          	sw	a3,-68(s0)
    8020349e:	868a                	mv	a3,sp
    802034a0:	85b6                	mv	a1,a3
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:32
    u8 temp[len];
    802034a2:	fbc42683          	lw	a3,-68(s0)
    802034a6:	02069613          	slli	a2,a3,0x20
    802034aa:	9201                	srli	a2,a2,0x20
    802034ac:	167d                	addi	a2,a2,-1
    802034ae:	fec43423          	sd	a2,-24(s0)
    802034b2:	02069613          	slli	a2,a3,0x20
    802034b6:	9201                	srli	a2,a2,0x20
    802034b8:	8e32                	mv	t3,a2
    802034ba:	4e81                	li	t4,0
    802034bc:	03de5613          	srli	a2,t3,0x3d
    802034c0:	003e9893          	slli	a7,t4,0x3
    802034c4:	011668b3          	or	a7,a2,a7
    802034c8:	003e1813          	slli	a6,t3,0x3
    802034cc:	02069613          	slli	a2,a3,0x20
    802034d0:	9201                	srli	a2,a2,0x20
    802034d2:	8332                	mv	t1,a2
    802034d4:	4381                	li	t2,0
    802034d6:	03d35613          	srli	a2,t1,0x3d
    802034da:	00339793          	slli	a5,t2,0x3
    802034de:	8fd1                	or	a5,a5,a2
    802034e0:	00331713          	slli	a4,t1,0x3
    802034e4:	02069793          	slli	a5,a3,0x20
    802034e8:	9381                	srli	a5,a5,0x20
    802034ea:	07bd                	addi	a5,a5,15
    802034ec:	8391                	srli	a5,a5,0x4
    802034ee:	0792                	slli	a5,a5,0x4
    802034f0:	40f10133          	sub	sp,sp,a5
    802034f4:	878a                	mv	a5,sp
    802034f6:	00078793          	mv	a5,a5
    802034fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34
    i32 i;
    for (i = 0; len != 0; len--) {
    802034fe:	fc042e23          	sw	zero,-36(s0)
    80203502:	a02d                	j	8020352c <memmove_t+0xa2>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:35 (discriminator 3)
        temp[i] = *src++;
    80203504:	fc043783          	ld	a5,-64(s0)
    80203508:	00178713          	addi	a4,a5,1
    8020350c:	fce43023          	sd	a4,-64(s0)
    80203510:	0007c703          	lbu	a4,0(a5)
    80203514:	fe043683          	ld	a3,-32(s0)
    80203518:	fdc42783          	lw	a5,-36(s0)
    8020351c:	97b6                	add	a5,a5,a3
    8020351e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 3)
    for (i = 0; len != 0; len--) {
    80203522:	fbc42783          	lw	a5,-68(s0)
    80203526:	37fd                	addiw	a5,a5,-1
    80203528:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 1)
    8020352c:	fbc42783          	lw	a5,-68(s0)
    80203530:	2781                	sext.w	a5,a5
    80203532:	fbe9                	bnez	a5,80203504 <memmove_t+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37
    }
    for (; len != 0; len--) {
    80203534:	a02d                	j	8020355e <memmove_t+0xd4>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:38 (discriminator 2)
        *dest++ = temp[i];
    80203536:	fc843783          	ld	a5,-56(s0)
    8020353a:	00178713          	addi	a4,a5,1
    8020353e:	fce43423          	sd	a4,-56(s0)
    80203542:	fe043683          	ld	a3,-32(s0)
    80203546:	fdc42703          	lw	a4,-36(s0)
    8020354a:	9736                	add	a4,a4,a3
    8020354c:	00074703          	lbu	a4,0(a4)
    80203550:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 2)
    for (; len != 0; len--) {
    80203554:	fbc42783          	lw	a5,-68(s0)
    80203558:	37fd                	addiw	a5,a5,-1
    8020355a:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 1)
    8020355e:	fbc42783          	lw	a5,-68(s0)
    80203562:	2781                	sext.w	a5,a5
    80203564:	fbe9                	bnez	a5,80203536 <memmove_t+0xac>
    80203566:	812e                	mv	sp,a1
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:40
    }
}
    80203568:	0001                	nop
    8020356a:	fb040113          	addi	sp,s0,-80
    8020356e:	6426                	ld	s0,72(sp)
    80203570:	6161                	addi	sp,sp,80
    80203572:	8082                	ret

0000000080203574 <memset_t>:
memset_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:43

void memset_t(void *dest, u8 val, u32 len)
{
    80203574:	7179                	addi	sp,sp,-48
    80203576:	f422                	sd	s0,40(sp)
    80203578:	1800                	addi	s0,sp,48
    8020357a:	fca43c23          	sd	a0,-40(s0)
    8020357e:	87ae                	mv	a5,a1
    80203580:	8732                	mv	a4,a2
    80203582:	fcf40ba3          	sb	a5,-41(s0)
    80203586:	87ba                	mv	a5,a4
    80203588:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:44
    u8 *dst = (u8 *)dest;
    8020358c:	fd843783          	ld	a5,-40(s0)
    80203590:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46

    for (; len != 0; len--) 
    80203594:	a005                	j	802035b4 <memset_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:48 (discriminator 2)
    {
        *dst++ = val;
    80203596:	fe843783          	ld	a5,-24(s0)
    8020359a:	00178713          	addi	a4,a5,1
    8020359e:	fee43423          	sd	a4,-24(s0)
    802035a2:	fd744703          	lbu	a4,-41(s0)
    802035a6:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 2)
    for (; len != 0; len--) 
    802035aa:	fd042783          	lw	a5,-48(s0)
    802035ae:	37fd                	addiw	a5,a5,-1
    802035b0:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 1)
    802035b4:	fd042783          	lw	a5,-48(s0)
    802035b8:	2781                	sext.w	a5,a5
    802035ba:	fff1                	bnez	a5,80203596 <memset_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:50
    }
}
    802035bc:	0001                	nop
    802035be:	0001                	nop
    802035c0:	7422                	ld	s0,40(sp)
    802035c2:	6145                	addi	sp,sp,48
    802035c4:	8082                	ret

00000000802035c6 <bzero_t>:
bzero_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:52

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }
    802035c6:	1101                	addi	sp,sp,-32
    802035c8:	ec06                	sd	ra,24(sp)
    802035ca:	e822                	sd	s0,16(sp)
    802035cc:	1000                	addi	s0,sp,32
    802035ce:	fea43423          	sd	a0,-24(s0)
    802035d2:	87ae                	mv	a5,a1
    802035d4:	fef42223          	sw	a5,-28(s0)
    802035d8:	fe442783          	lw	a5,-28(s0)
    802035dc:	863e                	mv	a2,a5
    802035de:	4581                	li	a1,0
    802035e0:	fe843503          	ld	a0,-24(s0)
    802035e4:	f91ff0ef          	jal	ra,80203574 <memset_t>
    802035e8:	0001                	nop
    802035ea:	60e2                	ld	ra,24(sp)
    802035ec:	6442                	ld	s0,16(sp)
    802035ee:	6105                	addi	sp,sp,32
    802035f0:	8082                	ret

00000000802035f2 <strcmp_t>:
strcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:55

int strcmp_t(const char *str1, const char *str2)
{
    802035f2:	1101                	addi	sp,sp,-32
    802035f4:	ec22                	sd	s0,24(sp)
    802035f6:	1000                	addi	s0,sp,32
    802035f8:	fea43423          	sd	a0,-24(s0)
    802035fc:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56
    while (*str1 && *str2) {
    80203600:	a0a1                	j	80203648 <strcmp_t+0x56>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:57
        if (*str1 != *str2) {
    80203602:	fe843783          	ld	a5,-24(s0)
    80203606:	0007c703          	lbu	a4,0(a5)
    8020360a:	fe043783          	ld	a5,-32(s0)
    8020360e:	0007c783          	lbu	a5,0(a5)
    80203612:	02f70163          	beq	a4,a5,80203634 <strcmp_t+0x42>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:58
            return (*str1) - (*str2);
    80203616:	fe843783          	ld	a5,-24(s0)
    8020361a:	0007c783          	lbu	a5,0(a5)
    8020361e:	0007871b          	sext.w	a4,a5
    80203622:	fe043783          	ld	a5,-32(s0)
    80203626:	0007c783          	lbu	a5,0(a5)
    8020362a:	2781                	sext.w	a5,a5
    8020362c:	40f707bb          	subw	a5,a4,a5
    80203630:	2781                	sext.w	a5,a5
    80203632:	a099                	j	80203678 <strcmp_t+0x86>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:60
        }
        ++str1;
    80203634:	fe843783          	ld	a5,-24(s0)
    80203638:	0785                	addi	a5,a5,1
    8020363a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:61
        ++str2;
    8020363e:	fe043783          	ld	a5,-32(s0)
    80203642:	0785                	addi	a5,a5,1
    80203644:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56
    while (*str1 && *str2) {
    80203648:	fe843783          	ld	a5,-24(s0)
    8020364c:	0007c783          	lbu	a5,0(a5)
    80203650:	c791                	beqz	a5,8020365c <strcmp_t+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56 (discriminator 1)
    80203652:	fe043783          	ld	a5,-32(s0)
    80203656:	0007c783          	lbu	a5,0(a5)
    8020365a:	f7c5                	bnez	a5,80203602 <strcmp_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:63
    }
    return (*str1) - (*str2);
    8020365c:	fe843783          	ld	a5,-24(s0)
    80203660:	0007c783          	lbu	a5,0(a5)
    80203664:	0007871b          	sext.w	a4,a5
    80203668:	fe043783          	ld	a5,-32(s0)
    8020366c:	0007c783          	lbu	a5,0(a5)
    80203670:	2781                	sext.w	a5,a5
    80203672:	40f707bb          	subw	a5,a4,a5
    80203676:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:64
}
    80203678:	853e                	mv	a0,a5
    8020367a:	6462                	ld	s0,24(sp)
    8020367c:	6105                	addi	sp,sp,32
    8020367e:	8082                	ret

0000000080203680 <strcpy_t>:
strcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:67

char *strcpy_t(char *dest, const char *src)
{
    80203680:	7179                	addi	sp,sp,-48
    80203682:	f422                	sd	s0,40(sp)
    80203684:	1800                	addi	s0,sp,48
    80203686:	fca43c23          	sd	a0,-40(s0)
    8020368a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:68
    char *tmp = dest;
    8020368e:	fd843783          	ld	a5,-40(s0)
    80203692:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:70

    while (*src) {
    80203696:	a00d                	j	802036b8 <strcpy_t+0x38>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:71
        *dest++ = *src++;
    80203698:	fd043703          	ld	a4,-48(s0)
    8020369c:	00170793          	addi	a5,a4,1
    802036a0:	fcf43823          	sd	a5,-48(s0)
    802036a4:	fd843783          	ld	a5,-40(s0)
    802036a8:	00178693          	addi	a3,a5,1
    802036ac:	fcd43c23          	sd	a3,-40(s0)
    802036b0:	00074703          	lbu	a4,0(a4)
    802036b4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:70
    while (*src) {
    802036b8:	fd043783          	ld	a5,-48(s0)
    802036bc:	0007c783          	lbu	a5,0(a5)
    802036c0:	ffe1                	bnez	a5,80203698 <strcpy_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:74
    }

    *dest = '\0';
    802036c2:	fd843783          	ld	a5,-40(s0)
    802036c6:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:76

    return tmp;
    802036ca:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:77
}
    802036ce:	853e                	mv	a0,a5
    802036d0:	7422                	ld	s0,40(sp)
    802036d2:	6145                	addi	sp,sp,48
    802036d4:	8082                	ret

00000000802036d6 <strcat_t>:
strcat_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:80

char *strcat_t(char *dest, const char *src)
{
    802036d6:	7179                	addi	sp,sp,-48
    802036d8:	f422                	sd	s0,40(sp)
    802036da:	1800                	addi	s0,sp,48
    802036dc:	fca43c23          	sd	a0,-40(s0)
    802036e0:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:81
    char *tmp = dest;
    802036e4:	fd843783          	ld	a5,-40(s0)
    802036e8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83

    while (*dest != '\0') { dest++; }
    802036ec:	a031                	j	802036f8 <strcat_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83 (discriminator 2)
    802036ee:	fd843783          	ld	a5,-40(s0)
    802036f2:	0785                	addi	a5,a5,1
    802036f4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83 (discriminator 1)
    802036f8:	fd843783          	ld	a5,-40(s0)
    802036fc:	0007c783          	lbu	a5,0(a5)
    80203700:	f7fd                	bnez	a5,802036ee <strcat_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:84
    while (*src) {
    80203702:	a00d                	j	80203724 <strcat_t+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:85
        *dest++ = *src++;
    80203704:	fd043703          	ld	a4,-48(s0)
    80203708:	00170793          	addi	a5,a4,1
    8020370c:	fcf43823          	sd	a5,-48(s0)
    80203710:	fd843783          	ld	a5,-40(s0)
    80203714:	00178693          	addi	a3,a5,1
    80203718:	fcd43c23          	sd	a3,-40(s0)
    8020371c:	00074703          	lbu	a4,0(a4)
    80203720:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:84
    while (*src) {
    80203724:	fd043783          	ld	a5,-48(s0)
    80203728:	0007c783          	lbu	a5,0(a5)
    8020372c:	ffe1                	bnez	a5,80203704 <strcat_t+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:88
    }

    *dest = '\0';
    8020372e:	fd843783          	ld	a5,-40(s0)
    80203732:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:90

    return tmp;
    80203736:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:91
}
    8020373a:	853e                	mv	a0,a5
    8020373c:	7422                	ld	s0,40(sp)
    8020373e:	6145                	addi	sp,sp,48
    80203740:	8082                	ret

0000000080203742 <memcpy>:
memcpy():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:94

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    80203742:	7179                	addi	sp,sp,-48
    80203744:	f422                	sd	s0,40(sp)
    80203746:	1800                	addi	s0,sp,48
    80203748:	fea43423          	sd	a0,-24(s0)
    8020374c:	feb43023          	sd	a1,-32(s0)
    80203750:	87b2                	mv	a5,a2
    80203752:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:95
    while (len--) {
    80203756:	a00d                	j	80203778 <memcpy+0x36>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:96
        *dest++ = *src++;
    80203758:	fe043703          	ld	a4,-32(s0)
    8020375c:	00170793          	addi	a5,a4,1
    80203760:	fef43023          	sd	a5,-32(s0)
    80203764:	fe843783          	ld	a5,-24(s0)
    80203768:	00178693          	addi	a3,a5,1
    8020376c:	fed43423          	sd	a3,-24(s0)
    80203770:	00074703          	lbu	a4,0(a4)
    80203774:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:95
    while (len--) {
    80203778:	fdc42783          	lw	a5,-36(s0)
    8020377c:	fff7871b          	addiw	a4,a5,-1
    80203780:	fce42e23          	sw	a4,-36(s0)
    80203784:	fbf1                	bnez	a5,80203758 <memcpy+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:98
    }
}
    80203786:	0001                	nop
    80203788:	0001                	nop
    8020378a:	7422                	ld	s0,40(sp)
    8020378c:	6145                	addi	sp,sp,48
    8020378e:	8082                	ret

0000000080203790 <memset>:
memset():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:101

void memset(void *dest, u8 val, u32 len)
{
    80203790:	1101                	addi	sp,sp,-32
    80203792:	ec06                	sd	ra,24(sp)
    80203794:	e822                	sd	s0,16(sp)
    80203796:	1000                	addi	s0,sp,32
    80203798:	fea43423          	sd	a0,-24(s0)
    8020379c:	87ae                	mv	a5,a1
    8020379e:	8732                	mv	a4,a2
    802037a0:	fef403a3          	sb	a5,-25(s0)
    802037a4:	87ba                	mv	a5,a4
    802037a6:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:102
    memset_t(dest,val,len);
    802037aa:	fe042703          	lw	a4,-32(s0)
    802037ae:	fe744783          	lbu	a5,-25(s0)
    802037b2:	863a                	mv	a2,a4
    802037b4:	85be                	mv	a1,a5
    802037b6:	fe843503          	ld	a0,-24(s0)
    802037ba:	dbbff0ef          	jal	ra,80203574 <memset_t>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:103
}
    802037be:	0001                	nop
    802037c0:	60e2                	ld	ra,24(sp)
    802037c2:	6442                	ld	s0,16(sp)
    802037c4:	6105                	addi	sp,sp,32
    802037c6:	8082                	ret

00000000802037c8 <memcmp>:
memcmp():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:105
int memcmp(const void *ptr1, const void *ptr2, size_t num) 
{
    802037c8:	715d                	addi	sp,sp,-80
    802037ca:	e4a2                	sd	s0,72(sp)
    802037cc:	0880                	addi	s0,sp,80
    802037ce:	fca43423          	sd	a0,-56(s0)
    802037d2:	fcb43023          	sd	a1,-64(s0)
    802037d6:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:106
    const unsigned char *p1 = ptr1, *p2 = ptr2;
    802037da:	fc843783          	ld	a5,-56(s0)
    802037de:	fef43023          	sd	a5,-32(s0)
    802037e2:	fc043783          	ld	a5,-64(s0)
    802037e6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107
    for (size_t i = 0; i < num; i++) 
    802037ea:	fe043423          	sd	zero,-24(s0)
    802037ee:	a8a1                	j	80203846 <memcmp+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:109
    {
        if (p1[i] != p2[i]) 
    802037f0:	fe043703          	ld	a4,-32(s0)
    802037f4:	fe843783          	ld	a5,-24(s0)
    802037f8:	97ba                	add	a5,a5,a4
    802037fa:	0007c683          	lbu	a3,0(a5)
    802037fe:	fd843703          	ld	a4,-40(s0)
    80203802:	fe843783          	ld	a5,-24(s0)
    80203806:	97ba                	add	a5,a5,a4
    80203808:	0007c783          	lbu	a5,0(a5)
    8020380c:	8736                	mv	a4,a3
    8020380e:	02f70763          	beq	a4,a5,8020383c <memcmp+0x74>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:111
        {
            return (int)p1[i] - (int)p2[i];
    80203812:	fe043703          	ld	a4,-32(s0)
    80203816:	fe843783          	ld	a5,-24(s0)
    8020381a:	97ba                	add	a5,a5,a4
    8020381c:	0007c783          	lbu	a5,0(a5)
    80203820:	0007871b          	sext.w	a4,a5
    80203824:	fd843683          	ld	a3,-40(s0)
    80203828:	fe843783          	ld	a5,-24(s0)
    8020382c:	97b6                	add	a5,a5,a3
    8020382e:	0007c783          	lbu	a5,0(a5)
    80203832:	2781                	sext.w	a5,a5
    80203834:	40f707bb          	subw	a5,a4,a5
    80203838:	2781                	sext.w	a5,a5
    8020383a:	a829                	j	80203854 <memcmp+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 2)
    for (size_t i = 0; i < num; i++) 
    8020383c:	fe843783          	ld	a5,-24(s0)
    80203840:	0785                	addi	a5,a5,1
    80203842:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 1)
    80203846:	fe843703          	ld	a4,-24(s0)
    8020384a:	fb843783          	ld	a5,-72(s0)
    8020384e:	faf761e3          	bltu	a4,a5,802037f0 <memcmp+0x28>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:114
        }
    }
    return 0;
    80203852:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:115
}
    80203854:	853e                	mv	a0,a5
    80203856:	6426                	ld	s0,72(sp)
    80203858:	6161                	addi	sp,sp,80
    8020385a:	8082                	ret

000000008020385c <memmove>:
memmove():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:118


void *memmove(void *dest, const void *src, size_t n) {
    8020385c:	715d                	addi	sp,sp,-80
    8020385e:	e4a2                	sd	s0,72(sp)
    80203860:	0880                	addi	s0,sp,80
    80203862:	fca43423          	sd	a0,-56(s0)
    80203866:	fcb43023          	sd	a1,-64(s0)
    8020386a:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:119
    u8 *d = (u8 *)dest;
    8020386e:	fc843783          	ld	a5,-56(s0)
    80203872:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:120
    const u8 *s = (const u8 *)src;
    80203876:	fc043783          	ld	a5,-64(s0)
    8020387a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:123

    // 如果源和目标相同，就没有复制的必要
    if (d == s) {
    8020387e:	fd843703          	ld	a4,-40(s0)
    80203882:	fd043783          	ld	a5,-48(s0)
    80203886:	00f71563          	bne	a4,a5,80203890 <memmove+0x34>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:124
        return dest;
    8020388a:	fc843783          	ld	a5,-56(s0)
    8020388e:	a861                	j	80203926 <memmove+0xca>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:128
    }

    // 如果源地址小于目标地址，并且两者重叠，则从后向前复制
    if (s < d && d < s + n) {
    80203890:	fd043703          	ld	a4,-48(s0)
    80203894:	fd843783          	ld	a5,-40(s0)
    80203898:	04f77963          	bgeu	a4,a5,802038ea <memmove+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:128 (discriminator 1)
    8020389c:	fd043703          	ld	a4,-48(s0)
    802038a0:	fb843783          	ld	a5,-72(s0)
    802038a4:	97ba                	add	a5,a5,a4
    802038a6:	fd843703          	ld	a4,-40(s0)
    802038aa:	04f77063          	bgeu	a4,a5,802038ea <memmove+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129
        for (size_t i = n; i != 0; i--) {
    802038ae:	fb843783          	ld	a5,-72(s0)
    802038b2:	fef43423          	sd	a5,-24(s0)
    802038b6:	a035                	j	802038e2 <memmove+0x86>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:130 (discriminator 3)
            d[i - 1] = s[i - 1];
    802038b8:	fe843783          	ld	a5,-24(s0)
    802038bc:	17fd                	addi	a5,a5,-1
    802038be:	fd043703          	ld	a4,-48(s0)
    802038c2:	973e                	add	a4,a4,a5
    802038c4:	fe843783          	ld	a5,-24(s0)
    802038c8:	17fd                	addi	a5,a5,-1
    802038ca:	fd843683          	ld	a3,-40(s0)
    802038ce:	97b6                	add	a5,a5,a3
    802038d0:	00074703          	lbu	a4,0(a4)
    802038d4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129 (discriminator 3)
        for (size_t i = n; i != 0; i--) {
    802038d8:	fe843783          	ld	a5,-24(s0)
    802038dc:	17fd                	addi	a5,a5,-1
    802038de:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129 (discriminator 1)
    802038e2:	fe843783          	ld	a5,-24(s0)
    802038e6:	fbe9                	bnez	a5,802038b8 <memmove+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129
    802038e8:	a82d                	j	80203922 <memmove+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134
        }
    } else {
        // 否则，从前向后复制
        for (size_t i = 0; i < n; i++) {
    802038ea:	fe043023          	sd	zero,-32(s0)
    802038ee:	a025                	j	80203916 <memmove+0xba>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:135 (discriminator 3)
            d[i] = s[i];
    802038f0:	fd043703          	ld	a4,-48(s0)
    802038f4:	fe043783          	ld	a5,-32(s0)
    802038f8:	973e                	add	a4,a4,a5
    802038fa:	fd843683          	ld	a3,-40(s0)
    802038fe:	fe043783          	ld	a5,-32(s0)
    80203902:	97b6                	add	a5,a5,a3
    80203904:	00074703          	lbu	a4,0(a4)
    80203908:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134 (discriminator 3)
        for (size_t i = 0; i < n; i++) {
    8020390c:	fe043783          	ld	a5,-32(s0)
    80203910:	0785                	addi	a5,a5,1
    80203912:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134 (discriminator 1)
    80203916:	fe043703          	ld	a4,-32(s0)
    8020391a:	fb843783          	ld	a5,-72(s0)
    8020391e:	fcf769e3          	bltu	a4,a5,802038f0 <memmove+0x94>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:139
        }
    }

    return dest;
    80203922:	fc843783          	ld	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:140
    80203926:	853e                	mv	a0,a5
    80203928:	6426                	ld	s0,72(sp)
    8020392a:	6161                	addi	sp,sp,80
    8020392c:	8082                	ret

000000008020392e <init_heap>:
init_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:16

static char heap[HEAP_SIZE];  // 堆空间

// 初始化堆
void init_heap() 
{
    8020392e:	1101                	addi	sp,sp,-32
    80203930:	ec22                	sd	s0,24(sp)
    80203932:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:18
    // 初始化堆的第一个块
    BlockHeader* header = (BlockHeader*)heap;
    80203934:	0001e797          	auipc	a5,0x1e
    80203938:	6d478793          	addi	a5,a5,1748 # 80222008 <heap>
    8020393c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:19
    header->size = HEAP_SIZE - sizeof(BlockHeader); // 设置第一个块的大小
    80203940:	fe843783          	ld	a5,-24(s0)
    80203944:	00800737          	lui	a4,0x800
    80203948:	1741                	addi	a4,a4,-16
    8020394a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:20
    header->free = 1; // 设置第一个块为空闲
    8020394c:	fe843783          	ld	a5,-24(s0)
    80203950:	4705                	li	a4,1
    80203952:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:21
}
    80203954:	0001                	nop
    80203956:	6462                	ld	s0,24(sp)
    80203958:	6105                	addi	sp,sp,32
    8020395a:	8082                	ret

000000008020395c <malloc>:
malloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:24

// 分配内存
void* malloc(uint64_t size) {
    8020395c:	7179                	addi	sp,sp,-48
    8020395e:	f422                	sd	s0,40(sp)
    80203960:	1800                	addi	s0,sp,48
    80203962:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:26
    // 从堆的开始处搜索合适的内存块
    BlockHeader* header = (BlockHeader*)heap;
    80203966:	0001e797          	auipc	a5,0x1e
    8020396a:	6a278793          	addi	a5,a5,1698 # 80222008 <heap>
    8020396e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29

    // 搜索未分配且大小合适的内存块
    while (header->size < size || !header->free) {
    80203972:	a025                	j	8020399a <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:30
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    80203974:	fe843783          	ld	a5,-24(s0)
    80203978:	639c                	ld	a5,0(a5)
    8020397a:	07c1                	addi	a5,a5,16
    8020397c:	fe843703          	ld	a4,-24(s0)
    80203980:	97ba                	add	a5,a5,a4
    80203982:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:31
        if ((char*)header >= (char*)heap + HEAP_SIZE) {
    80203986:	0081e797          	auipc	a5,0x81e
    8020398a:	68278793          	addi	a5,a5,1666 # 80a22008 <KERNEL_SPACE>
    8020398e:	fe843703          	ld	a4,-24(s0)
    80203992:	00f76463          	bltu	a4,a5,8020399a <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:33
            // 搜索到堆的末尾还未找到合适的内存块
            return NULL;
    80203996:	4781                	li	a5,0
    80203998:	a885                	j	80203a08 <malloc+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29
    while (header->size < size || !header->free) {
    8020399a:	fe843783          	ld	a5,-24(s0)
    8020399e:	639c                	ld	a5,0(a5)
    802039a0:	fd843703          	ld	a4,-40(s0)
    802039a4:	fce7e8e3          	bltu	a5,a4,80203974 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29 (discriminator 1)
    802039a8:	fe843783          	ld	a5,-24(s0)
    802039ac:	479c                	lw	a5,8(a5)
    802039ae:	d3f9                	beqz	a5,80203974 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:38
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4) {
    802039b0:	fe843783          	ld	a5,-24(s0)
    802039b4:	6398                	ld	a4,0(a5)
    802039b6:	fd843783          	ld	a5,-40(s0)
    802039ba:	07d1                	addi	a5,a5,20
    802039bc:	02f76f63          	bltu	a4,a5,802039fa <malloc+0x9e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:40
        // 分割内存块以减少浪费
        BlockHeader* new_header = (BlockHeader*)((char*)header + size + sizeof(BlockHeader));
    802039c0:	fd843783          	ld	a5,-40(s0)
    802039c4:	07c1                	addi	a5,a5,16
    802039c6:	fe843703          	ld	a4,-24(s0)
    802039ca:	97ba                	add	a5,a5,a4
    802039cc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:41
        new_header->size = header->size - size - sizeof(BlockHeader); // 计算新内存块的大小
    802039d0:	fe843783          	ld	a5,-24(s0)
    802039d4:	6398                	ld	a4,0(a5)
    802039d6:	fd843783          	ld	a5,-40(s0)
    802039da:	40f707b3          	sub	a5,a4,a5
    802039de:	ff078713          	addi	a4,a5,-16
    802039e2:	fe043783          	ld	a5,-32(s0)
    802039e6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:42
        new_header->free = 1; // 设置新内存块为空闲
    802039e8:	fe043783          	ld	a5,-32(s0)
    802039ec:	4705                	li	a4,1
    802039ee:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:43
        header->size = size; // 更新当前内存块的大小
    802039f0:	fe843783          	ld	a5,-24(s0)
    802039f4:	fd843703          	ld	a4,-40(s0)
    802039f8:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:46
    }

    header->free = 0; // 标记当前内存块为已分配
    802039fa:	fe843783          	ld	a5,-24(s0)
    802039fe:	0007a423          	sw	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:47
    return (void*)(header + 1); // 返回内存块数据区的地址
    80203a02:	fe843783          	ld	a5,-24(s0)
    80203a06:	07c1                	addi	a5,a5,16
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:48
}
    80203a08:	853e                	mv	a0,a5
    80203a0a:	7422                	ld	s0,40(sp)
    80203a0c:	6145                	addi	sp,sp,48
    80203a0e:	8082                	ret

0000000080203a10 <free>:
free():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:51

// 释放内存
void free(void* ptr) {
    80203a10:	7179                	addi	sp,sp,-48
    80203a12:	f422                	sd	s0,40(sp)
    80203a14:	1800                	addi	s0,sp,48
    80203a16:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:53
    // 如果指针为空，则不进行操作
    if (ptr == NULL) {
    80203a1a:	fd843783          	ld	a5,-40(s0)
    80203a1e:	cb99                	beqz	a5,80203a34 <free+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:58
        return;
    }

    // 获取内存块头部
    BlockHeader* header = (BlockHeader*)ptr - 1;
    80203a20:	fd843783          	ld	a5,-40(s0)
    80203a24:	17c1                	addi	a5,a5,-16
    80203a26:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:59
    header->free = 1; // 标记内存块为空闲
    80203a2a:	fe843783          	ld	a5,-24(s0)
    80203a2e:	4705                	li	a4,1
    80203a30:	c798                	sw	a4,8(a5)
    80203a32:	a011                	j	80203a36 <free+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:54
        return;
    80203a34:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:60
}
    80203a36:	7422                	ld	s0,40(sp)
    80203a38:	6145                	addi	sp,sp,48
    80203a3a:	8082                	ret

0000000080203a3c <print_heap>:
print_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:63

// 打印堆的状态
void print_heap() {
    80203a3c:	1101                	addi	sp,sp,-32
    80203a3e:	ec06                	sd	ra,24(sp)
    80203a40:	e822                	sd	s0,16(sp)
    80203a42:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:64
    BlockHeader* header = (BlockHeader*)heap;
    80203a44:	0001e797          	auipc	a5,0x1e
    80203a48:	5c478793          	addi	a5,a5,1476 # 80222008 <heap>
    80203a4c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:67

    // 遍历堆中的所有内存块
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    80203a50:	a095                	j	80203ab4 <print_heap+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:68
        print_str("Block size: ");
    80203a52:	00005517          	auipc	a0,0x5
    80203a56:	67e50513          	addi	a0,a0,1662 # 802090d0 <MMIO+0x48>
    80203a5a:	17b020ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:69
        print_uint64(header->size); // 打印内存块大小
    80203a5e:	fe843783          	ld	a5,-24(s0)
    80203a62:	639c                	ld	a5,0(a5)
    80203a64:	853e                	mv	a0,a5
    80203a66:	2ed020ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:70
        print_str(", Free: ");
    80203a6a:	00005517          	auipc	a0,0x5
    80203a6e:	67650513          	addi	a0,a0,1654 # 802090e0 <MMIO+0x58>
    80203a72:	163020ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71
        print_str(header->free ? "Yes" : "No"); // 打印内存块是否空闲
    80203a76:	fe843783          	ld	a5,-24(s0)
    80203a7a:	479c                	lw	a5,8(a5)
    80203a7c:	c791                	beqz	a5,80203a88 <print_heap+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 1)
    80203a7e:	00005797          	auipc	a5,0x5
    80203a82:	67278793          	addi	a5,a5,1650 # 802090f0 <MMIO+0x68>
    80203a86:	a029                	j	80203a90 <print_heap+0x54>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 2)
    80203a88:	00005797          	auipc	a5,0x5
    80203a8c:	67078793          	addi	a5,a5,1648 # 802090f8 <MMIO+0x70>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 4)
    80203a90:	853e                	mv	a0,a5
    80203a92:	143020ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:72 (discriminator 4)
        print_str("\n");
    80203a96:	00005517          	auipc	a0,0x5
    80203a9a:	66a50513          	addi	a0,a0,1642 # 80209100 <MMIO+0x78>
    80203a9e:	137020ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:75 (discriminator 4)

        // 移动到下一个内存块
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    80203aa2:	fe843783          	ld	a5,-24(s0)
    80203aa6:	639c                	ld	a5,0(a5)
    80203aa8:	07c1                	addi	a5,a5,16
    80203aaa:	fe843703          	ld	a4,-24(s0)
    80203aae:	97ba                	add	a5,a5,a4
    80203ab0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:67
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    80203ab4:	0081e797          	auipc	a5,0x81e
    80203ab8:	55478793          	addi	a5,a5,1364 # 80a22008 <KERNEL_SPACE>
    80203abc:	fe843703          	ld	a4,-24(s0)
    80203ac0:	f8f769e3          	bltu	a4,a5,80203a52 <print_heap+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:77
    }
}
    80203ac4:	0001                	nop
    80203ac6:	0001                	nop
    80203ac8:	60e2                	ld	ra,24(sp)
    80203aca:	6442                	ld	s0,16(sp)
    80203acc:	6105                	addi	sp,sp,32
    80203ace:	8082                	ret

0000000080203ad0 <realloc>:
realloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:81

// 重新分配内存
void* realloc(void* ptr, uint64_t new_size) 
{
    80203ad0:	7139                	addi	sp,sp,-64
    80203ad2:	fc06                	sd	ra,56(sp)
    80203ad4:	f822                	sd	s0,48(sp)
    80203ad6:	0080                	addi	s0,sp,64
    80203ad8:	fca43423          	sd	a0,-56(s0)
    80203adc:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:82
    if (new_size == 0) {
    80203ae0:	fc043783          	ld	a5,-64(s0)
    80203ae4:	e799                	bnez	a5,80203af2 <realloc+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:84
        // 如果新大小为0，则释放原有内存并返回NULL
        free(ptr);
    80203ae6:	fc843503          	ld	a0,-56(s0)
    80203aea:	f27ff0ef          	jal	ra,80203a10 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:85
        return NULL;
    80203aee:	4781                	li	a5,0
    80203af0:	a045                	j	80203b90 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:88
    }

    if (ptr == NULL) {
    80203af2:	fc843783          	ld	a5,-56(s0)
    80203af6:	e799                	bnez	a5,80203b04 <realloc+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:90
        // 如果原始指针为NULL，则行为等同于malloc
        return malloc(new_size);
    80203af8:	fc043503          	ld	a0,-64(s0)
    80203afc:	e61ff0ef          	jal	ra,8020395c <malloc>
    80203b00:	87aa                	mv	a5,a0
    80203b02:	a079                	j	80203b90 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:93
    }

    BlockHeader* header = (BlockHeader*)ptr - 1;
    80203b04:	fc843783          	ld	a5,-56(s0)
    80203b08:	17c1                	addi	a5,a5,-16
    80203b0a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:94
    if (header->size >= new_size) {
    80203b0e:	fe043783          	ld	a5,-32(s0)
    80203b12:	639c                	ld	a5,0(a5)
    80203b14:	fc043703          	ld	a4,-64(s0)
    80203b18:	00e7e563          	bltu	a5,a4,80203b22 <realloc+0x52>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:96
        // 如果原始内存块大小已满足需求，则直接返回原始指针
        return ptr;
    80203b1c:	fc843783          	ld	a5,-56(s0)
    80203b20:	a885                	j	80203b90 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:99
    } else {
        // 如果新大小超出原始大小，则分配一个新的内存块并复制原始数据
        void* new_ptr = malloc(new_size);
    80203b22:	fc043503          	ld	a0,-64(s0)
    80203b26:	e37ff0ef          	jal	ra,8020395c <malloc>
    80203b2a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:100
        if (new_ptr == NULL) {
    80203b2e:	fd843783          	ld	a5,-40(s0)
    80203b32:	e399                	bnez	a5,80203b38 <realloc+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:102
            // 分配失败
            return NULL;
    80203b34:	4781                	li	a5,0
    80203b36:	a8a9                	j	80203b90 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:106
        }

        // 复制原始内存数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
    80203b38:	fe043783          	ld	a5,-32(s0)
    80203b3c:	6398                	ld	a4,0(a5)
    80203b3e:	fc043783          	ld	a5,-64(s0)
    80203b42:	00f77363          	bgeu	a4,a5,80203b48 <realloc+0x78>
    80203b46:	87ba                	mv	a5,a4
    80203b48:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107
        for (uint64_t i = 0; i < copy_size; ++i) {
    80203b4c:	fe043423          	sd	zero,-24(s0)
    80203b50:	a025                	j	80203b78 <realloc+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:108 (discriminator 3)
            *((char*)new_ptr + i) = *((char*)ptr + i);
    80203b52:	fc843703          	ld	a4,-56(s0)
    80203b56:	fe843783          	ld	a5,-24(s0)
    80203b5a:	973e                	add	a4,a4,a5
    80203b5c:	fd843683          	ld	a3,-40(s0)
    80203b60:	fe843783          	ld	a5,-24(s0)
    80203b64:	97b6                	add	a5,a5,a3
    80203b66:	00074703          	lbu	a4,0(a4) # 800000 <n+0x7fffe0>
    80203b6a:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107 (discriminator 3)
        for (uint64_t i = 0; i < copy_size; ++i) {
    80203b6e:	fe843783          	ld	a5,-24(s0)
    80203b72:	0785                	addi	a5,a5,1
    80203b74:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107 (discriminator 1)
    80203b78:	fe843703          	ld	a4,-24(s0)
    80203b7c:	fd043783          	ld	a5,-48(s0)
    80203b80:	fcf769e3          	bltu	a4,a5,80203b52 <realloc+0x82>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:112
        }

        // 释放原始内存块
        free(ptr);
    80203b84:	fc843503          	ld	a0,-56(s0)
    80203b88:	e89ff0ef          	jal	ra,80203a10 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:113
        return new_ptr;
    80203b8c:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:115
    }
}
    80203b90:	853e                	mv	a0,a5
    80203b92:	70e2                	ld	ra,56(sp)
    80203b94:	7442                	ld	s0,48(sp)
    80203b96:	6121                	addi	sp,sp,64
    80203b98:	8082                	ret

0000000080203b9a <w_satp>:
w_satp():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:154

#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64_t)pagetable) >> 12))

// supervisor address translation and protection;
// holds the address of the page table.
static inline void w_satp(uint64_t x) {
    80203b9a:	1101                	addi	sp,sp,-32
    80203b9c:	ec22                	sd	s0,24(sp)
    80203b9e:	1000                	addi	s0,sp,32
    80203ba0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:155
  asm volatile("csrw satp, %0" : : "r"(x));
    80203ba4:	fe843783          	ld	a5,-24(s0)
    80203ba8:	18079073          	csrw	satp,a5
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:156
}
    80203bac:	0001                	nop
    80203bae:	6462                	ld	s0,24(sp)
    80203bb0:	6105                	addi	sp,sp,32
    80203bb2:	8082                	ret

0000000080203bb4 <sfence_vma>:
sfence_vma():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:240
  asm volatile("mv %0, ra" : "=r"(x));
  return x;
}

// flush the TLB.
static inline void sfence_vma() {
    80203bb4:	1141                	addi	sp,sp,-16
    80203bb6:	e422                	sd	s0,8(sp)
    80203bb8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:242
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80203bba:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:243
}
    80203bbe:	0001                	nop
    80203bc0:	6422                	ld	s0,8(sp)
    80203bc2:	0141                	addi	sp,sp,16
    80203bc4:	8082                	ret

0000000080203bc6 <map_area_from_another>:
map_area_from_another():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:6
#include "elfparse.h"
#include "mem.h"
#include "riscv.h"
#include "string.h"
#include "debug.h"
static void map_area_from_another(MapArea *map_area, MapArea *another) {
    80203bc6:	1101                	addi	sp,sp,-32
    80203bc8:	ec22                	sd	s0,24(sp)
    80203bca:	1000                	addi	s0,sp,32
    80203bcc:	fea43423          	sd	a0,-24(s0)
    80203bd0:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:7
  map_area->vpn_range.l = another->vpn_range.l;
    80203bd4:	fe043783          	ld	a5,-32(s0)
    80203bd8:	6398                	ld	a4,0(a5)
    80203bda:	fe843783          	ld	a5,-24(s0)
    80203bde:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:8
  map_area->vpn_range.r = another->vpn_range.r;
    80203be0:	fe043783          	ld	a5,-32(s0)
    80203be4:	6798                	ld	a4,8(a5)
    80203be6:	fe843783          	ld	a5,-24(s0)
    80203bea:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:9
  map_area->map_type = another->map_type;
    80203bec:	fe043783          	ld	a5,-32(s0)
    80203bf0:	0107c703          	lbu	a4,16(a5)
    80203bf4:	fe843783          	ld	a5,-24(s0)
    80203bf8:	00e78823          	sb	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:10
  map_area->map_perm = another->map_perm;
    80203bfc:	fe043783          	ld	a5,-32(s0)
    80203c00:	0117c703          	lbu	a4,17(a5)
    80203c04:	fe843783          	ld	a5,-24(s0)
    80203c08:	00e788a3          	sb	a4,17(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:11
}
    80203c0c:	0001                	nop
    80203c0e:	6462                	ld	s0,24(sp)
    80203c10:	6105                	addi	sp,sp,32
    80203c12:	8082                	ret

0000000080203c14 <map_area_map_one>:
map_area_map_one():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:14

static void map_area_map_one(MapArea *map_area, PageTable *pt,
                             VirtPageNum vpn) {
    80203c14:	7139                	addi	sp,sp,-64
    80203c16:	fc06                	sd	ra,56(sp)
    80203c18:	f822                	sd	s0,48(sp)
    80203c1a:	0080                	addi	s0,sp,64
    80203c1c:	fca43c23          	sd	a0,-40(s0)
    80203c20:	fcb43823          	sd	a1,-48(s0)
    80203c24:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:16
  PhysPageNum ppn;
  if (map_area->map_type == MAP_IDENTICAL) {
    80203c28:	fd843783          	ld	a5,-40(s0)
    80203c2c:	0107c783          	lbu	a5,16(a5)
    80203c30:	e791                	bnez	a5,80203c3c <map_area_map_one+0x28>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:17
    ppn = (PhysPageNum)vpn;
    80203c32:	fc843783          	ld	a5,-56(s0)
    80203c36:	fef43023          	sd	a5,-32(s0)
    80203c3a:	a031                	j	80203c46 <map_area_map_one+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:19
  } else {
    ppn = frame_alloc();
    80203c3c:	032010ef          	jal	ra,80204c6e <frame_alloc>
    80203c40:	87aa                	mv	a5,a0
    80203c42:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:21
  }
  PTEFlags pte_flags = (PTEFlags)(map_area->map_perm);
    80203c46:	fd843783          	ld	a5,-40(s0)
    80203c4a:	0117c783          	lbu	a5,17(a5)
    80203c4e:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:22
  page_table_map(pt, vpn, ppn, pte_flags);
    80203c52:	fe043783          	ld	a5,-32(s0)
    80203c56:	fef44703          	lbu	a4,-17(s0)
    80203c5a:	86ba                	mv	a3,a4
    80203c5c:	863e                	mv	a2,a5
    80203c5e:	fc843583          	ld	a1,-56(s0)
    80203c62:	fd043503          	ld	a0,-48(s0)
    80203c66:	492010ef          	jal	ra,802050f8 <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:23
  vector_push(&pt->frames, &ppn);
    80203c6a:	fd043783          	ld	a5,-48(s0)
    80203c6e:	07a1                	addi	a5,a5,8
    80203c70:	fe040713          	addi	a4,s0,-32
    80203c74:	85ba                	mv	a1,a4
    80203c76:	853e                	mv	a0,a5
    80203c78:	3f4040ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:24
}
    80203c7c:	0001                	nop
    80203c7e:	70e2                	ld	ra,56(sp)
    80203c80:	7442                	ld	s0,48(sp)
    80203c82:	6121                	addi	sp,sp,64
    80203c84:	8082                	ret

0000000080203c86 <map_area_unmap_one>:
map_area_unmap_one():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:27

static void map_area_unmap_one(MapArea *map_area, PageTable *pt,
                               VirtPageNum vpn, bool dealloc) {
    80203c86:	7139                	addi	sp,sp,-64
    80203c88:	fc06                	sd	ra,56(sp)
    80203c8a:	f822                	sd	s0,48(sp)
    80203c8c:	0080                	addi	s0,sp,64
    80203c8e:	fca43c23          	sd	a0,-40(s0)
    80203c92:	fcb43823          	sd	a1,-48(s0)
    80203c96:	fcc43423          	sd	a2,-56(s0)
    80203c9a:	87b6                	mv	a5,a3
    80203c9c:	fcf42223          	sw	a5,-60(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:28
  PhysPageNum ppn = pte_ppn(*page_table_translate(pt, vpn));
    80203ca0:	fc843583          	ld	a1,-56(s0)
    80203ca4:	fd043503          	ld	a0,-48(s0)
    80203ca8:	512010ef          	jal	ra,802051ba <page_table_translate>
    80203cac:	87aa                	mv	a5,a0
    80203cae:	639c                	ld	a5,0(a5)
    80203cb0:	00a7d713          	srli	a4,a5,0xa
    80203cb4:	57fd                	li	a5,-1
    80203cb6:	83d1                	srli	a5,a5,0x14
    80203cb8:	8ff9                	and	a5,a5,a4
    80203cba:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:29
  page_table_unmap(pt, vpn);
    80203cbe:	fc843583          	ld	a1,-56(s0)
    80203cc2:	fd043503          	ld	a0,-48(s0)
    80203cc6:	4a0010ef          	jal	ra,80205166 <page_table_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:30
  if (dealloc) {
    80203cca:	fc442783          	lw	a5,-60(s0)
    80203cce:	2781                	sext.w	a5,a5
    80203cd0:	c789                	beqz	a5,80203cda <map_area_unmap_one+0x54>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:31
    frame_dealloc(ppn);
    80203cd2:	fe843503          	ld	a0,-24(s0)
    80203cd6:	04c010ef          	jal	ra,80204d22 <frame_dealloc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:33
  }
}
    80203cda:	0001                	nop
    80203cdc:	70e2                	ld	ra,56(sp)
    80203cde:	7442                	ld	s0,48(sp)
    80203ce0:	6121                	addi	sp,sp,64
    80203ce2:	8082                	ret

0000000080203ce4 <map_area_map>:
map_area_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:35

static void map_area_map(MapArea *map_area, PageTable *pt) {
    80203ce4:	7179                	addi	sp,sp,-48
    80203ce6:	f406                	sd	ra,40(sp)
    80203ce8:	f022                	sd	s0,32(sp)
    80203cea:	1800                	addi	s0,sp,48
    80203cec:	fca43c23          	sd	a0,-40(s0)
    80203cf0:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:36
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203cf4:	fd843783          	ld	a5,-40(s0)
    80203cf8:	639c                	ld	a5,0(a5)
    80203cfa:	fef43423          	sd	a5,-24(s0)
    80203cfe:	a831                	j	80203d1a <map_area_map+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:38
       vpn++) {
    map_area_map_one(map_area, pt, vpn);
    80203d00:	fe843603          	ld	a2,-24(s0)
    80203d04:	fd043583          	ld	a1,-48(s0)
    80203d08:	fd843503          	ld	a0,-40(s0)
    80203d0c:	f09ff0ef          	jal	ra,80203c14 <map_area_map_one>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:37
       vpn++) {
    80203d10:	fe843783          	ld	a5,-24(s0)
    80203d14:	0785                	addi	a5,a5,1
    80203d16:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:36 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d1a:	fd843783          	ld	a5,-40(s0)
    80203d1e:	679c                	ld	a5,8(a5)
    80203d20:	fe843703          	ld	a4,-24(s0)
    80203d24:	fcf76ee3          	bltu	a4,a5,80203d00 <map_area_map+0x1c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:40
  }
}
    80203d28:	0001                	nop
    80203d2a:	0001                	nop
    80203d2c:	70a2                	ld	ra,40(sp)
    80203d2e:	7402                	ld	s0,32(sp)
    80203d30:	6145                	addi	sp,sp,48
    80203d32:	8082                	ret

0000000080203d34 <map_area_unmap>:
map_area_unmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:42

static void map_area_unmap(MapArea *map_area, PageTable *pt, bool dealloc) {
    80203d34:	7139                	addi	sp,sp,-64
    80203d36:	fc06                	sd	ra,56(sp)
    80203d38:	f822                	sd	s0,48(sp)
    80203d3a:	0080                	addi	s0,sp,64
    80203d3c:	fca43c23          	sd	a0,-40(s0)
    80203d40:	fcb43823          	sd	a1,-48(s0)
    80203d44:	87b2                	mv	a5,a2
    80203d46:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:43
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d4a:	fd843783          	ld	a5,-40(s0)
    80203d4e:	639c                	ld	a5,0(a5)
    80203d50:	fef43423          	sd	a5,-24(s0)
    80203d54:	a00d                	j	80203d76 <map_area_unmap+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:45
       vpn++) {
    map_area_unmap_one(map_area, pt, vpn, dealloc);
    80203d56:	fcc42783          	lw	a5,-52(s0)
    80203d5a:	86be                	mv	a3,a5
    80203d5c:	fe843603          	ld	a2,-24(s0)
    80203d60:	fd043583          	ld	a1,-48(s0)
    80203d64:	fd843503          	ld	a0,-40(s0)
    80203d68:	f1fff0ef          	jal	ra,80203c86 <map_area_unmap_one>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:44
       vpn++) {
    80203d6c:	fe843783          	ld	a5,-24(s0)
    80203d70:	0785                	addi	a5,a5,1
    80203d72:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:43 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d76:	fd843783          	ld	a5,-40(s0)
    80203d7a:	679c                	ld	a5,8(a5)
    80203d7c:	fe843703          	ld	a4,-24(s0)
    80203d80:	fcf76be3          	bltu	a4,a5,80203d56 <map_area_unmap+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:47
  }
}
    80203d84:	0001                	nop
    80203d86:	0001                	nop
    80203d88:	70e2                	ld	ra,56(sp)
    80203d8a:	7442                	ld	s0,48(sp)
    80203d8c:	6121                	addi	sp,sp,64
    80203d8e:	8082                	ret

0000000080203d90 <map_area_copy_data>:
map_area_copy_data():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:50

static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len) {
    80203d90:	711d                	addi	sp,sp,-96
    80203d92:	ec86                	sd	ra,88(sp)
    80203d94:	e8a2                	sd	s0,80(sp)
    80203d96:	1080                	addi	s0,sp,96
    80203d98:	faa43c23          	sd	a0,-72(s0)
    80203d9c:	fab43823          	sd	a1,-80(s0)
    80203da0:	fac43423          	sd	a2,-88(s0)
    80203da4:	fad43023          	sd	a3,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:51
  uint64_t start = 0;
    80203da8:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:52
  VirtPageNum current_vpn = map_area->vpn_range.l;
    80203dac:	fb843783          	ld	a5,-72(s0)
    80203db0:	639c                	ld	a5,0(a5)
    80203db2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:54
  for (;;) {
    uint8_t *src = &data[start];
    80203db6:	fa843703          	ld	a4,-88(s0)
    80203dba:	fe843783          	ld	a5,-24(s0)
    80203dbe:	97ba                	add	a5,a5,a4
    80203dc0:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:56
    uint8_t *dst =
        ppn_get_bytes_array(pte_ppn(*page_table_translate(pt, current_vpn)));
    80203dc4:	fe043583          	ld	a1,-32(s0)
    80203dc8:	fb043503          	ld	a0,-80(s0)
    80203dcc:	3ee010ef          	jal	ra,802051ba <page_table_translate>
    80203dd0:	87aa                	mv	a5,a0
    80203dd2:	639c                	ld	a5,0(a5)
    80203dd4:	00a7d713          	srli	a4,a5,0xa
    80203dd8:	57fd                	li	a5,-1
    80203dda:	83d1                	srli	a5,a5,0x14
    80203ddc:	8ff9                	and	a5,a5,a4
    80203dde:	853e                	mv	a0,a5
    80203de0:	607000ef          	jal	ra,80204be6 <ppn_get_bytes_array>
    80203de4:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:57
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    80203de8:	fa043703          	ld	a4,-96(s0)
    80203dec:	fe843783          	ld	a5,-24(s0)
    80203df0:	40f707b3          	sub	a5,a4,a5
    80203df4:	6705                	lui	a4,0x1
    80203df6:	00f77363          	bgeu	a4,a5,80203dfc <map_area_copy_data+0x6c>
    80203dfa:	6785                	lui	a5,0x1
    80203dfc:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:58
    memcpy(dst, src, cpy_len);
    80203e00:	fc843783          	ld	a5,-56(s0)
    80203e04:	2781                	sext.w	a5,a5
    80203e06:	863e                	mv	a2,a5
    80203e08:	fd843583          	ld	a1,-40(s0)
    80203e0c:	fd043503          	ld	a0,-48(s0)
    80203e10:	933ff0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:59
    start += PAGE_SIZE;
    80203e14:	fe843703          	ld	a4,-24(s0)
    80203e18:	6785                	lui	a5,0x1
    80203e1a:	97ba                	add	a5,a5,a4
    80203e1c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:60
    if (start >= len) {
    80203e20:	fe843703          	ld	a4,-24(s0)
    80203e24:	fa043783          	ld	a5,-96(s0)
    80203e28:	00f77863          	bgeu	a4,a5,80203e38 <map_area_copy_data+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:63
      break;
    }
    current_vpn += 1;
    80203e2c:	fe043783          	ld	a5,-32(s0)
    80203e30:	0785                	addi	a5,a5,1
    80203e32:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:53
  for (;;) {
    80203e36:	b741                	j	80203db6 <map_area_copy_data+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:61
      break;
    80203e38:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:65
  }
}
    80203e3a:	0001                	nop
    80203e3c:	60e6                	ld	ra,88(sp)
    80203e3e:	6446                	ld	s0,80(sp)
    80203e40:	6125                	addi	sp,sp,96
    80203e42:	8082                	ret

0000000080203e44 <memory_set_new_bare>:
memory_set_new_bare():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:67

static void memory_set_new_bare(MemorySet *memory_set) {
    80203e44:	1101                	addi	sp,sp,-32
    80203e46:	ec06                	sd	ra,24(sp)
    80203e48:	e822                	sd	s0,16(sp)
    80203e4a:	1000                	addi	s0,sp,32
    80203e4c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:68
  page_table_new(&memory_set->page_table);
    80203e50:	fe843783          	ld	a5,-24(s0)
    80203e54:	853e                	mv	a0,a5
    80203e56:	03c010ef          	jal	ra,80204e92 <page_table_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:69
  vector_new(&memory_set->areas, sizeof(MapArea));
    80203e5a:	fe843783          	ld	a5,-24(s0)
    80203e5e:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80203e62:	45e1                	li	a1,24
    80203e64:	853e                	mv	a0,a5
    80203e66:	1b4040ef          	jal	ra,8020801a <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:70
}
    80203e6a:	0001                	nop
    80203e6c:	60e2                	ld	ra,24(sp)
    80203e6e:	6442                	ld	s0,16(sp)
    80203e70:	6105                	addi	sp,sp,32
    80203e72:	8082                	ret

0000000080203e74 <memory_set_token>:
memory_set_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:72

uint64_t memory_set_token(MemorySet *memory_set) {
    80203e74:	1101                	addi	sp,sp,-32
    80203e76:	ec06                	sd	ra,24(sp)
    80203e78:	e822                	sd	s0,16(sp)
    80203e7a:	1000                	addi	s0,sp,32
    80203e7c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:73
  return page_table_token(&memory_set->page_table);
    80203e80:	fe843783          	ld	a5,-24(s0)
    80203e84:	853e                	mv	a0,a5
    80203e86:	380010ef          	jal	ra,80205206 <page_table_token>
    80203e8a:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:74
}
    80203e8c:	853e                	mv	a0,a5
    80203e8e:	60e2                	ld	ra,24(sp)
    80203e90:	6442                	ld	s0,16(sp)
    80203e92:	6105                	addi	sp,sp,32
    80203e94:	8082                	ret

0000000080203e96 <memory_set_push>:
memory_set_push():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:77

static void memory_set_push(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len) {
    80203e96:	7179                	addi	sp,sp,-48
    80203e98:	f406                	sd	ra,40(sp)
    80203e9a:	f022                	sd	s0,32(sp)
    80203e9c:	1800                	addi	s0,sp,48
    80203e9e:	fea43423          	sd	a0,-24(s0)
    80203ea2:	feb43023          	sd	a1,-32(s0)
    80203ea6:	fcc43c23          	sd	a2,-40(s0)
    80203eaa:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:78
  map_area_map(map_area, &memory_set->page_table);
    80203eae:	fe843783          	ld	a5,-24(s0)
    80203eb2:	85be                	mv	a1,a5
    80203eb4:	fe043503          	ld	a0,-32(s0)
    80203eb8:	e2dff0ef          	jal	ra,80203ce4 <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:79
  if (data && len >= 0) {
    80203ebc:	fd843783          	ld	a5,-40(s0)
    80203ec0:	cf81                	beqz	a5,80203ed8 <memory_set_push+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:80
    map_area_copy_data(map_area, &memory_set->page_table, data, len);
    80203ec2:	fe843783          	ld	a5,-24(s0)
    80203ec6:	fd043683          	ld	a3,-48(s0)
    80203eca:	fd843603          	ld	a2,-40(s0)
    80203ece:	85be                	mv	a1,a5
    80203ed0:	fe043503          	ld	a0,-32(s0)
    80203ed4:	ebdff0ef          	jal	ra,80203d90 <map_area_copy_data>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:82
  }
  vector_push(&memory_set->areas, map_area);
    80203ed8:	fe843783          	ld	a5,-24(s0)
    80203edc:	02878793          	addi	a5,a5,40
    80203ee0:	fe043583          	ld	a1,-32(s0)
    80203ee4:	853e                	mv	a0,a5
    80203ee6:	186040ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:83
}
    80203eea:	0001                	nop
    80203eec:	70a2                	ld	ra,40(sp)
    80203eee:	7402                	ld	s0,32(sp)
    80203ef0:	6145                	addi	sp,sp,48
    80203ef2:	8082                	ret

0000000080203ef4 <memory_set_insert_framed_area>:
memory_set_insert_framed_area():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:88

// Assume that no conflicts.
static void memory_set_insert_framed_area(MemorySet *memory_set,
                                          VirtAddr start_va, VirtAddr end_va,
                                          MapPermission permission) {
    80203ef4:	715d                	addi	sp,sp,-80
    80203ef6:	e486                	sd	ra,72(sp)
    80203ef8:	e0a2                	sd	s0,64(sp)
    80203efa:	0880                	addi	s0,sp,80
    80203efc:	fca43423          	sd	a0,-56(s0)
    80203f00:	fcb43023          	sd	a1,-64(s0)
    80203f04:	fac43c23          	sd	a2,-72(s0)
    80203f08:	87b6                	mv	a5,a3
    80203f0a:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:90
  MapArea map_area;
  map_area.vpn_range.l = page_floor(start_va);
    80203f0e:	fc043783          	ld	a5,-64(s0)
    80203f12:	83b1                	srli	a5,a5,0xc
    80203f14:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:91
  map_area.vpn_range.r = page_ceil(end_va);
    80203f18:	fb843703          	ld	a4,-72(s0)
    80203f1c:	6785                	lui	a5,0x1
    80203f1e:	17fd                	addi	a5,a5,-1
    80203f20:	97ba                	add	a5,a5,a4
    80203f22:	83b1                	srli	a5,a5,0xc
    80203f24:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:92
  map_area.map_type = MAP_FRAMED;
    80203f28:	4785                	li	a5,1
    80203f2a:	fef40423          	sb	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:93
  map_area.map_perm = permission;
    80203f2e:	fb744783          	lbu	a5,-73(s0)
    80203f32:	fef404a3          	sb	a5,-23(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:94
  memory_set_push(memory_set, &map_area, NULL, 0);
    80203f36:	fd840793          	addi	a5,s0,-40
    80203f3a:	4681                	li	a3,0
    80203f3c:	4601                	li	a2,0
    80203f3e:	85be                	mv	a1,a5
    80203f40:	fc843503          	ld	a0,-56(s0)
    80203f44:	f53ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:95
}
    80203f48:	0001                	nop
    80203f4a:	60a6                	ld	ra,72(sp)
    80203f4c:	6406                	ld	s0,64(sp)
    80203f4e:	6161                	addi	sp,sp,80
    80203f50:	8082                	ret

0000000080203f52 <memory_set_remove_area_with_start_vpn>:
memory_set_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:98

static void memory_set_remove_area_with_start_vpn(MemorySet *memory_set,
                                                  VirtPageNum start_vpn) {
    80203f52:	7179                	addi	sp,sp,-48
    80203f54:	f406                	sd	ra,40(sp)
    80203f56:	f022                	sd	s0,32(sp)
    80203f58:	1800                	addi	s0,sp,48
    80203f5a:	fca43c23          	sd	a0,-40(s0)
    80203f5e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:99
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    80203f62:	fd843783          	ld	a5,-40(s0)
    80203f66:	63bc                	ld	a5,64(a5)
    80203f68:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:100
  uint64_t i = 0;
    80203f6c:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:101
  while (i < memory_set->areas.size) {
    80203f70:	a085                	j	80203fd0 <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:102
    if (x[i].vpn_range.l == start_vpn) {
    80203f72:	fe843703          	ld	a4,-24(s0)
    80203f76:	87ba                	mv	a5,a4
    80203f78:	0786                	slli	a5,a5,0x1
    80203f7a:	97ba                	add	a5,a5,a4
    80203f7c:	078e                	slli	a5,a5,0x3
    80203f7e:	873e                	mv	a4,a5
    80203f80:	fe043783          	ld	a5,-32(s0)
    80203f84:	97ba                	add	a5,a5,a4
    80203f86:	639c                	ld	a5,0(a5)
    80203f88:	fd043703          	ld	a4,-48(s0)
    80203f8c:	02f71d63          	bne	a4,a5,80203fc6 <memory_set_remove_area_with_start_vpn+0x74>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:103
      map_area_unmap(&x[i], &memory_set->page_table, true);
    80203f90:	fe843703          	ld	a4,-24(s0)
    80203f94:	87ba                	mv	a5,a4
    80203f96:	0786                	slli	a5,a5,0x1
    80203f98:	97ba                	add	a5,a5,a4
    80203f9a:	078e                	slli	a5,a5,0x3
    80203f9c:	873e                	mv	a4,a5
    80203f9e:	fe043783          	ld	a5,-32(s0)
    80203fa2:	97ba                	add	a5,a5,a4
    80203fa4:	fd843703          	ld	a4,-40(s0)
    80203fa8:	4605                	li	a2,1
    80203faa:	85ba                	mv	a1,a4
    80203fac:	853e                	mv	a0,a5
    80203fae:	d87ff0ef          	jal	ra,80203d34 <map_area_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:104
      vector_remove(&memory_set->areas, i);
    80203fb2:	fd843783          	ld	a5,-40(s0)
    80203fb6:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80203fba:	fe843583          	ld	a1,-24(s0)
    80203fbe:	853e                	mv	a0,a5
    80203fc0:	250040ef          	jal	ra,80208210 <vector_remove>
    80203fc4:	a031                	j	80203fd0 <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:106
    } else {
      i++;
    80203fc6:	fe843783          	ld	a5,-24(s0)
    80203fca:	0785                	addi	a5,a5,1
    80203fcc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:101
  while (i < memory_set->areas.size) {
    80203fd0:	fd843783          	ld	a5,-40(s0)
    80203fd4:	779c                	ld	a5,40(a5)
    80203fd6:	fe843703          	ld	a4,-24(s0)
    80203fda:	f8f76ce3          	bltu	a4,a5,80203f72 <memory_set_remove_area_with_start_vpn+0x20>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:109
    }
  }
}
    80203fde:	0001                	nop
    80203fe0:	0001                	nop
    80203fe2:	70a2                	ld	ra,40(sp)
    80203fe4:	7402                	ld	s0,32(sp)
    80203fe6:	6145                	addi	sp,sp,48
    80203fe8:	8082                	ret

0000000080203fea <memory_set_free>:
memory_set_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:111

void memory_set_free(MemorySet *memory_set) {
    80203fea:	7179                	addi	sp,sp,-48
    80203fec:	f406                	sd	ra,40(sp)
    80203fee:	f022                	sd	s0,32(sp)
    80203ff0:	1800                	addi	s0,sp,48
    80203ff2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:112
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    80203ff6:	fd843783          	ld	a5,-40(s0)
    80203ffa:	63bc                	ld	a5,64(a5)
    80203ffc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113
  for (uint64_t i = 0; i < memory_set->areas.size; i++) {
    80204000:	fe043423          	sd	zero,-24(s0)
    80204004:	a03d                	j	80204032 <memory_set_free+0x48>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:114 (discriminator 3)
    map_area_unmap(&x[i], &memory_set->page_table, false);
    80204006:	fe843703          	ld	a4,-24(s0)
    8020400a:	87ba                	mv	a5,a4
    8020400c:	0786                	slli	a5,a5,0x1
    8020400e:	97ba                	add	a5,a5,a4
    80204010:	078e                	slli	a5,a5,0x3
    80204012:	873e                	mv	a4,a5
    80204014:	fe043783          	ld	a5,-32(s0)
    80204018:	97ba                	add	a5,a5,a4
    8020401a:	fd843703          	ld	a4,-40(s0)
    8020401e:	4601                	li	a2,0
    80204020:	85ba                	mv	a1,a4
    80204022:	853e                	mv	a0,a5
    80204024:	d11ff0ef          	jal	ra,80203d34 <map_area_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113 (discriminator 3)
  for (uint64_t i = 0; i < memory_set->areas.size; i++) {
    80204028:	fe843783          	ld	a5,-24(s0)
    8020402c:	0785                	addi	a5,a5,1
    8020402e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113 (discriminator 1)
    80204032:	fd843783          	ld	a5,-40(s0)
    80204036:	779c                	ld	a5,40(a5)
    80204038:	fe843703          	ld	a4,-24(s0)
    8020403c:	fcf765e3          	bltu	a4,a5,80204006 <memory_set_free+0x1c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:116
  }
  vector_free(&memory_set->areas);
    80204040:	fd843783          	ld	a5,-40(s0)
    80204044:	02878793          	addi	a5,a5,40
    80204048:	853e                	mv	a0,a5
    8020404a:	1a4040ef          	jal	ra,802081ee <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:117
  page_table_free(&memory_set->page_table);
    8020404e:	fd843783          	ld	a5,-40(s0)
    80204052:	853e                	mv	a0,a5
    80204054:	689000ef          	jal	ra,80204edc <page_table_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:118
}
    80204058:	0001                	nop
    8020405a:	70a2                	ld	ra,40(sp)
    8020405c:	7402                	ld	s0,32(sp)
    8020405e:	6145                	addi	sp,sp,48
    80204060:	8082                	ret

0000000080204062 <memory_set_map_trampoline>:
memory_set_map_trampoline():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:132
extern uint8_t ebss;
extern uint8_t ekernel;
extern uint8_t strampoline;

// Mention that trampoline is not collected by areas.
static inline void memory_set_map_trampoline(MemorySet *memory_set) {
    80204062:	1101                	addi	sp,sp,-32
    80204064:	ec06                	sd	ra,24(sp)
    80204066:	e822                	sd	s0,16(sp)
    80204068:	1000                	addi	s0,sp,32
    8020406a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:133
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    8020406e:	fe843703          	ld	a4,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:134
                 addr2pn((PhysAddr)&strampoline), PTE_R | PTE_X);
    80204072:	ffffd797          	auipc	a5,0xffffd
    80204076:	f8e78793          	addi	a5,a5,-114 # 80201000 <__alltraps>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:133
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    8020407a:	83b1                	srli	a5,a5,0xc
    8020407c:	46a9                	li	a3,10
    8020407e:	863e                	mv	a2,a5
    80204080:	57fd                	li	a5,-1
    80204082:	00c7d593          	srli	a1,a5,0xc
    80204086:	853a                	mv	a0,a4
    80204088:	070010ef          	jal	ra,802050f8 <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:135
}
    8020408c:	0001                	nop
    8020408e:	60e2                	ld	ra,24(sp)
    80204090:	6442                	ld	s0,16(sp)
    80204092:	6105                	addi	sp,sp,32
    80204094:	8082                	ret

0000000080204096 <memory_set_new_kernel>:
memory_set_new_kernel():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:138

static MemorySet KERNEL_SPACE;
static void memory_set_new_kernel() {
    80204096:	7179                	addi	sp,sp,-48
    80204098:	f406                	sd	ra,40(sp)
    8020409a:	f022                	sd	s0,32(sp)
    8020409c:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:139
  MemorySet *memory_set = &KERNEL_SPACE;
    8020409e:	0081e797          	auipc	a5,0x81e
    802040a2:	f6a78793          	addi	a5,a5,-150 # 80a22008 <KERNEL_SPACE>
    802040a6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:140
  memory_set_new_bare(memory_set);
    802040aa:	fe843503          	ld	a0,-24(s0)
    802040ae:	d97ff0ef          	jal	ra,80203e44 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:143

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802040b2:	fe843503          	ld	a0,-24(s0)
    802040b6:	fadff0ef          	jal	ra,80204062 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:154
  // info("boot_stack [0x%llx, 0x%llx)\n", &sbss_with_stack, &ebss);

  MapArea map_area;

  // info("mapping .text section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&stext);
    802040ba:	ffffc797          	auipc	a5,0xffffc
    802040be:	f4678793          	addi	a5,a5,-186 # 80200000 <_start>
    802040c2:	83b1                	srli	a5,a5,0xc
    802040c4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:155
  map_area.vpn_range.r = page_ceil((PhysAddr)&etext);
    802040c8:	00005717          	auipc	a4,0x5
    802040cc:	f3870713          	addi	a4,a4,-200 # 80209000 <etext>
    802040d0:	6785                	lui	a5,0x1
    802040d2:	17fd                	addi	a5,a5,-1
    802040d4:	97ba                	add	a5,a5,a4
    802040d6:	83b1                	srli	a5,a5,0xc
    802040d8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:156
  map_area.map_type = MAP_IDENTICAL;
    802040dc:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:157
  map_area.map_perm = MAP_PERM_R | MAP_PERM_X;
    802040e0:	47a9                	li	a5,10
    802040e2:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:158
  memory_set_push(memory_set, &map_area, NULL, 0);
    802040e6:	fd040793          	addi	a5,s0,-48
    802040ea:	4681                	li	a3,0
    802040ec:	4601                	li	a2,0
    802040ee:	85be                	mv	a1,a5
    802040f0:	fe843503          	ld	a0,-24(s0)
    802040f4:	da3ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:161

  // info("mapping .rodata section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&srodata);
    802040f8:	00005797          	auipc	a5,0x5
    802040fc:	f0878793          	addi	a5,a5,-248 # 80209000 <etext>
    80204100:	83b1                	srli	a5,a5,0xc
    80204102:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:162
  map_area.vpn_range.r = page_ceil((PhysAddr)&erodata);
    80204106:	00006717          	auipc	a4,0x6
    8020410a:	efa70713          	addi	a4,a4,-262 # 8020a000 <app_starts.1>
    8020410e:	6785                	lui	a5,0x1
    80204110:	17fd                	addi	a5,a5,-1
    80204112:	97ba                	add	a5,a5,a4
    80204114:	83b1                	srli	a5,a5,0xc
    80204116:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:163
  map_area.map_type = MAP_IDENTICAL;
    8020411a:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:164
  map_area.map_perm = MAP_PERM_R;
    8020411e:	4789                	li	a5,2
    80204120:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:165
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204124:	fd040793          	addi	a5,s0,-48
    80204128:	4681                	li	a3,0
    8020412a:	4601                	li	a2,0
    8020412c:	85be                	mv	a1,a5
    8020412e:	fe843503          	ld	a0,-24(s0)
    80204132:	d65ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:168

  // info("mapping .data section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sdata);
    80204136:	00006797          	auipc	a5,0x6
    8020413a:	eca78793          	addi	a5,a5,-310 # 8020a000 <app_starts.1>
    8020413e:	83b1                	srli	a5,a5,0xc
    80204140:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:169
  map_area.vpn_range.r = page_ceil((PhysAddr)&edata);
    80204144:	0000e717          	auipc	a4,0xe
    80204148:	ebc70713          	addi	a4,a4,-324 # 80212000 <boot_stack_lower_bound>
    8020414c:	6785                	lui	a5,0x1
    8020414e:	17fd                	addi	a5,a5,-1
    80204150:	97ba                	add	a5,a5,a4
    80204152:	83b1                	srli	a5,a5,0xc
    80204154:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:170
  map_area.map_type = MAP_IDENTICAL;
    80204158:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:171
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    8020415c:	4799                	li	a5,6
    8020415e:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:172
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204162:	fd040793          	addi	a5,s0,-48
    80204166:	4681                	li	a3,0
    80204168:	4601                	li	a2,0
    8020416a:	85be                	mv	a1,a5
    8020416c:	fe843503          	ld	a0,-24(s0)
    80204170:	d27ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:175

  // info("mapping .bss section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sbss_with_stack);
    80204174:	0000e797          	auipc	a5,0xe
    80204178:	e8c78793          	addi	a5,a5,-372 # 80212000 <boot_stack_lower_bound>
    8020417c:	83b1                	srli	a5,a5,0xc
    8020417e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:176
  map_area.vpn_range.r = page_ceil((PhysAddr)&ebss);
    80204182:	00b22717          	auipc	a4,0xb22
    80204186:	e7e70713          	addi	a4,a4,-386 # 80d26000 <ebss>
    8020418a:	6785                	lui	a5,0x1
    8020418c:	17fd                	addi	a5,a5,-1
    8020418e:	97ba                	add	a5,a5,a4
    80204190:	83b1                	srli	a5,a5,0xc
    80204192:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:177
  map_area.map_type = MAP_IDENTICAL;
    80204196:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:178
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    8020419a:	4799                	li	a5,6
    8020419c:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:179
  memory_set_push(memory_set, &map_area, NULL, 0);
    802041a0:	fd040793          	addi	a5,s0,-48
    802041a4:	4681                	li	a3,0
    802041a6:	4601                	li	a2,0
    802041a8:	85be                	mv	a1,a5
    802041aa:	fe843503          	ld	a0,-24(s0)
    802041ae:	ce9ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:182

  // info("mapping physical memory\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&ekernel);
    802041b2:	00b22797          	auipc	a5,0xb22
    802041b6:	e4e78793          	addi	a5,a5,-434 # 80d26000 <ebss>
    802041ba:	83b1                	srli	a5,a5,0xc
    802041bc:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:183
  map_area.vpn_range.r = page_ceil((PhysAddr)MEMORY_END);
    802041c0:	000817b7          	lui	a5,0x81
    802041c4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:184
  map_area.map_type = MAP_IDENTICAL;
    802041c8:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:185
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    802041cc:	4799                	li	a5,6
    802041ce:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:186
  memory_set_push(memory_set, &map_area, NULL, 0);
    802041d2:	fd040793          	addi	a5,s0,-48
    802041d6:	4681                	li	a3,0
    802041d8:	4601                	li	a2,0
    802041da:	85be                	mv	a1,a5
    802041dc:	fe843503          	ld	a0,-24(s0)
    802041e0:	cb7ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:187
}
    802041e4:	0001                	nop
    802041e6:	70a2                	ld	ra,40(sp)
    802041e8:	7402                	ld	s0,32(sp)
    802041ea:	6145                	addi	sp,sp,48
    802041ec:	8082                	ret

00000000802041ee <memory_set_from_elf>:
memory_set_from_elf():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:192

void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point) 
{
    802041ee:	7111                	addi	sp,sp,-256
    802041f0:	fd86                	sd	ra,248(sp)
    802041f2:	f9a2                	sd	s0,240(sp)
    802041f4:	f5a6                	sd	s1,232(sp)
    802041f6:	0200                	addi	s0,sp,256
    802041f8:	81010113          	addi	sp,sp,-2032 # 80221810 <boot_stack_lower_bound+0xf810>
    802041fc:	77fd                	lui	a5,0xfffff
    802041fe:	fe040493          	addi	s1,s0,-32
    80204202:	97a6                	add	a5,a5,s1
    80204204:	74a7bc23          	sd	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    80204208:	77fd                	lui	a5,0xfffff
    8020420a:	fe040513          	addi	a0,s0,-32
    8020420e:	97aa                	add	a5,a5,a0
    80204210:	74b7b823          	sd	a1,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d9750>
    80204214:	77fd                	lui	a5,0xfffff
    80204216:	fe040593          	addi	a1,s0,-32
    8020421a:	97ae                	add	a5,a5,a1
    8020421c:	74c7b423          	sd	a2,1864(a5) # fffffffffffff748 <ebss+0xffffffff7f2d9748>
    80204220:	77fd                	lui	a5,0xfffff
    80204222:	fe040613          	addi	a2,s0,-32
    80204226:	97b2                	add	a5,a5,a2
    80204228:	74d7b023          	sd	a3,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f2d9740>
    8020422c:	77fd                	lui	a5,0xfffff
    8020422e:	fe040693          	addi	a3,s0,-32
    80204232:	97b6                	add	a5,a5,a3
    80204234:	72e7bc23          	sd	a4,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f2d9738>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:193
  memory_set_new_bare(memory_set);
    80204238:	77fd                	lui	a5,0xfffff
    8020423a:	fe040713          	addi	a4,s0,-32
    8020423e:	97ba                	add	a5,a5,a4
    80204240:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    80204244:	c01ff0ef          	jal	ra,80203e44 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:196

  // map trampoline
  memory_set_map_trampoline(memory_set);
    80204248:	77fd                	lui	a5,0xfffff
    8020424a:	fe040713          	addi	a4,s0,-32
    8020424e:	97ba                	add	a5,a5,a4
    80204250:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    80204254:	e0fff0ef          	jal	ra,80204062 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:200

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
    80204258:	77fd                	lui	a5,0xfffff
    8020425a:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    8020425e:	fe040713          	addi	a4,s0,-32
    80204262:	00f706b3          	add	a3,a4,a5
    80204266:	77fd                	lui	a5,0xfffff
    80204268:	fe040713          	addi	a4,s0,-32
    8020426c:	973e                	add	a4,a4,a5
    8020426e:	77fd                	lui	a5,0xfffff
    80204270:	fe040613          	addi	a2,s0,-32
    80204274:	97b2                	add	a5,a5,a2
    80204276:	8636                	mv	a2,a3
    80204278:	74873583          	ld	a1,1864(a4)
    8020427c:	7507b503          	ld	a0,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d9750>
    80204280:	ca9fe0ef          	jal	ra,80202f28 <elf_load>
    80204284:	87aa                	mv	a5,a0
    80204286:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:201
  if (elf_load_ret != 0)
    8020428a:	fcc42783          	lw	a5,-52(s0)
    8020428e:	2781                	sext.w	a5,a5
    80204290:	cf89                	beqz	a5,802042aa <memory_set_from_elf+0xbc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:203
  {
    panic("Elf load error.\n");
    80204292:	00005617          	auipc	a2,0x5
    80204296:	e8660613          	addi	a2,a2,-378 # 80209118 <MMIO+0x10>
    8020429a:	0cb00593          	li	a1,203
    8020429e:	00005517          	auipc	a0,0x5
    802042a2:	e9250513          	addi	a0,a0,-366 # 80209130 <MMIO+0x28>
    802042a6:	3f2020ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:206
  }

  size_t ph_count = elf_header_get_phnum(&elf);
    802042aa:	77fd                	lui	a5,0xfffff
    802042ac:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    802042b0:	fe040713          	addi	a4,s0,-32
    802042b4:	97ba                	add	a5,a5,a4
    802042b6:	853e                	mv	a0,a5
    802042b8:	e41fe0ef          	jal	ra,802030f8 <elf_header_get_phnum>
    802042bc:	fca43023          	sd	a0,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:211
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn = 0;
    802042c0:	fc043c23          	sd	zero,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212
  for (size_t i = 0; i < ph_count; i++) {
    802042c4:	fc043823          	sd	zero,-48(s0)
    802042c8:	a261                	j	80204450 <memory_set_from_elf+0x262>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:213
    t_elf_program *ph = &elf.programs[i];
    802042ca:	77fd                	lui	a5,0xfffff
    802042cc:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    802042d0:	fe040713          	addi	a4,s0,-32
    802042d4:	973e                	add	a4,a4,a5
    802042d6:	fd043783          	ld	a5,-48(s0)
    802042da:	04278793          	addi	a5,a5,66
    802042de:	0792                	slli	a5,a5,0x4
    802042e0:	97ba                	add	a5,a5,a4
    802042e2:	07a1                	addi	a5,a5,8
    802042e4:	faf43023          	sd	a5,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:214
    if (elf_program_get_type(&elf, ph) == PT_LOAD) {
    802042e8:	77fd                	lui	a5,0xfffff
    802042ea:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    802042ee:	fe040713          	addi	a4,s0,-32
    802042f2:	97ba                	add	a5,a5,a4
    802042f4:	fa043583          	ld	a1,-96(s0)
    802042f8:	853e                	mv	a0,a5
    802042fa:	981fe0ef          	jal	ra,80202c7a <elf_program_get_type>
    802042fe:	87aa                	mv	a5,a0
    80204300:	2781                	sext.w	a5,a5
    80204302:	873e                	mv	a4,a5
    80204304:	4785                	li	a5,1
    80204306:	14f71063          	bne	a4,a5,80204446 <memory_set_from_elf+0x258>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:215
      start_va = (VirtAddr)elf_program_get_vaddr(&elf, ph);
    8020430a:	77fd                	lui	a5,0xfffff
    8020430c:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    80204310:	fe040713          	addi	a4,s0,-32
    80204314:	97ba                	add	a5,a5,a4
    80204316:	fa043583          	ld	a1,-96(s0)
    8020431a:	853e                	mv	a0,a5
    8020431c:	a37fe0ef          	jal	ra,80202d52 <elf_program_get_vaddr>
    80204320:	f8a43c23          	sd	a0,-104(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:216
      end_va = (VirtAddr)(start_va + elf_program_get_memsz(&elf, ph));
    80204324:	77fd                	lui	a5,0xfffff
    80204326:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    8020432a:	fe040713          	addi	a4,s0,-32
    8020432e:	97ba                	add	a5,a5,a4
    80204330:	fa043583          	ld	a1,-96(s0)
    80204334:	853e                	mv	a0,a5
    80204336:	a65fe0ef          	jal	ra,80202d9a <elf_program_get_memsz>
    8020433a:	872a                	mv	a4,a0
    8020433c:	f9843783          	ld	a5,-104(s0)
    80204340:	97ba                	add	a5,a5,a4
    80204342:	f8f43823          	sd	a5,-112(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:217
      map_perm = MAP_PERM_U;
    80204346:	47c1                	li	a5,16
    80204348:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:218
      ph_flags = elf_program_get_flags(&elf, ph);
    8020434c:	77fd                	lui	a5,0xfffff
    8020434e:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    80204352:	fe040713          	addi	a4,s0,-32
    80204356:	97ba                	add	a5,a5,a4
    80204358:	fa043583          	ld	a1,-96(s0)
    8020435c:	853e                	mv	a0,a5
    8020435e:	9a9fe0ef          	jal	ra,80202d06 <elf_program_get_flags>
    80204362:	f8a43023          	sd	a0,-128(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:220
      if (ph_flags | PF_R) {
        map_perm |= MAP_PERM_R;
    80204366:	f8f44783          	lbu	a5,-113(s0)
    8020436a:	0027e793          	ori	a5,a5,2
    8020436e:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:223
      }
      if (ph_flags | PF_W) {
        map_perm |= MAP_PERM_W;
    80204372:	f8f44783          	lbu	a5,-113(s0)
    80204376:	0047e793          	ori	a5,a5,4
    8020437a:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:226
      }
      if (ph_flags | PF_X) {
        map_perm |= MAP_PERM_X;
    8020437e:	f8f44783          	lbu	a5,-113(s0)
    80204382:	0087e793          	ori	a5,a5,8
    80204386:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:228
      }
      map_area.vpn_range.l = page_floor(start_va);
    8020438a:	f9843783          	ld	a5,-104(s0)
    8020438e:	00c7d713          	srli	a4,a5,0xc
    80204392:	77fd                	lui	a5,0xfffff
    80204394:	fe040693          	addi	a3,s0,-32
    80204398:	97b6                	add	a5,a5,a3
    8020439a:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d9760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:229
      map_area.vpn_range.r = page_ceil(end_va);
    8020439e:	f9043703          	ld	a4,-112(s0)
    802043a2:	6785                	lui	a5,0x1
    802043a4:	17fd                	addi	a5,a5,-1
    802043a6:	97ba                	add	a5,a5,a4
    802043a8:	00c7d713          	srli	a4,a5,0xc
    802043ac:	77fd                	lui	a5,0xfffff
    802043ae:	fe040693          	addi	a3,s0,-32
    802043b2:	97b6                	add	a5,a5,a3
    802043b4:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d9768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:230
      map_area.map_type = MAP_FRAMED;
    802043b8:	77fd                	lui	a5,0xfffff
    802043ba:	fe040713          	addi	a4,s0,-32
    802043be:	97ba                	add	a5,a5,a4
    802043c0:	4705                	li	a4,1
    802043c2:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d9770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:231
      map_area.map_perm = map_perm;
    802043c6:	77fd                	lui	a5,0xfffff
    802043c8:	fe040713          	addi	a4,s0,-32
    802043cc:	97ba                	add	a5,a5,a4
    802043ce:	f8f44703          	lbu	a4,-113(s0)
    802043d2:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d9771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:232
      max_end_vpn = map_area.vpn_range.r;
    802043d6:	77fd                	lui	a5,0xfffff
    802043d8:	fe040713          	addi	a4,s0,-32
    802043dc:	97ba                	add	a5,a5,a4
    802043de:	7687b783          	ld	a5,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d9768>
    802043e2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:234
      memory_set_push(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
    802043e6:	77fd                	lui	a5,0xfffff
    802043e8:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    802043ec:	fe040713          	addi	a4,s0,-32
    802043f0:	97ba                	add	a5,a5,a4
    802043f2:	fa043583          	ld	a1,-96(s0)
    802043f6:	853e                	mv	a0,a5
    802043f8:	8c7fe0ef          	jal	ra,80202cbe <elf_program_get_offset>
    802043fc:	872a                	mv	a4,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:233
      memory_set_push(memory_set, &map_area,
    802043fe:	77fd                	lui	a5,0xfffff
    80204400:	fe040693          	addi	a3,s0,-32
    80204404:	97b6                	add	a5,a5,a3
    80204406:	7507b783          	ld	a5,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d9750>
    8020440a:	00e784b3          	add	s1,a5,a4
    8020440e:	77fd                	lui	a5,0xfffff
    80204410:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    80204414:	fe040713          	addi	a4,s0,-32
    80204418:	97ba                	add	a5,a5,a4
    8020441a:	fa043583          	ld	a1,-96(s0)
    8020441e:	853e                	mv	a0,a5
    80204420:	9c3fe0ef          	jal	ra,80202de2 <elf_program_get_filesz>
    80204424:	86aa                	mv	a3,a0
    80204426:	77fd                	lui	a5,0xfffff
    80204428:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d9760>
    8020442c:	fe040713          	addi	a4,s0,-32
    80204430:	973e                	add	a4,a4,a5
    80204432:	77fd                	lui	a5,0xfffff
    80204434:	fe040613          	addi	a2,s0,-32
    80204438:	97b2                	add	a5,a5,a2
    8020443a:	8626                	mv	a2,s1
    8020443c:	85ba                	mv	a1,a4
    8020443e:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    80204442:	a55ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212 (discriminator 2)
  for (size_t i = 0; i < ph_count; i++) {
    80204446:	fd043783          	ld	a5,-48(s0)
    8020444a:	0785                	addi	a5,a5,1
    8020444c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212 (discriminator 1)
    80204450:	fd043703          	ld	a4,-48(s0)
    80204454:	fc043783          	ld	a5,-64(s0)
    80204458:	e6f769e3          	bltu	a4,a5,802042ca <memory_set_from_elf+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:240
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = pn2addr(max_end_vpn);
    8020445c:	fd843783          	ld	a5,-40(s0)
    80204460:	07b2                	slli	a5,a5,0xc
    80204462:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:241
  VirtAddr user_stack_bottom = max_end_va;
    80204466:	fb843783          	ld	a5,-72(s0)
    8020446a:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:243
  // guard page
  user_stack_bottom += PAGE_SIZE;
    8020446e:	fb043703          	ld	a4,-80(s0)
    80204472:	6785                	lui	a5,0x1
    80204474:	97ba                	add	a5,a5,a4
    80204476:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:244
  VirtAddr user_stack_top = user_stack_bottom + USER_STACK_SIZE;
    8020447a:	fb043703          	ld	a4,-80(s0)
    8020447e:	6789                	lui	a5,0x2
    80204480:	97ba                	add	a5,a5,a4
    80204482:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:245
  map_area.vpn_range.l = page_floor(user_stack_bottom);
    80204486:	fb043783          	ld	a5,-80(s0)
    8020448a:	00c7d713          	srli	a4,a5,0xc
    8020448e:	77fd                	lui	a5,0xfffff
    80204490:	fe040693          	addi	a3,s0,-32
    80204494:	97b6                	add	a5,a5,a3
    80204496:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d9760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:246
  map_area.vpn_range.r = page_ceil(user_stack_top);
    8020449a:	fa843703          	ld	a4,-88(s0)
    8020449e:	6785                	lui	a5,0x1
    802044a0:	17fd                	addi	a5,a5,-1
    802044a2:	97ba                	add	a5,a5,a4
    802044a4:	00c7d713          	srli	a4,a5,0xc
    802044a8:	77fd                	lui	a5,0xfffff
    802044aa:	fe040693          	addi	a3,s0,-32
    802044ae:	97b6                	add	a5,a5,a3
    802044b0:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d9768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:247
  map_area.map_type = MAP_FRAMED;
    802044b4:	77fd                	lui	a5,0xfffff
    802044b6:	fe040713          	addi	a4,s0,-32
    802044ba:	97ba                	add	a5,a5,a4
    802044bc:	4705                	li	a4,1
    802044be:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d9770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:248
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
    802044c2:	77fd                	lui	a5,0xfffff
    802044c4:	fe040713          	addi	a4,s0,-32
    802044c8:	97ba                	add	a5,a5,a4
    802044ca:	4759                	li	a4,22
    802044cc:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d9771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:249
  memory_set_push(memory_set, &map_area, NULL, 0);
    802044d0:	77fd                	lui	a5,0xfffff
    802044d2:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d9760>
    802044d6:	fe040713          	addi	a4,s0,-32
    802044da:	973e                	add	a4,a4,a5
    802044dc:	77fd                	lui	a5,0xfffff
    802044de:	fe040693          	addi	a3,s0,-32
    802044e2:	97b6                	add	a5,a5,a3
    802044e4:	4681                	li	a3,0
    802044e6:	4601                	li	a2,0
    802044e8:	85ba                	mv	a1,a4
    802044ea:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    802044ee:	9a9ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:252

  // map TrapContext
  map_area.vpn_range.l = page_floor(TRAP_CONTEXT);
    802044f2:	77fd                	lui	a5,0xfffff
    802044f4:	fe040713          	addi	a4,s0,-32
    802044f8:	97ba                	add	a5,a5,a4
    802044fa:	7779                	lui	a4,0xffffe
    802044fc:	8331                	srli	a4,a4,0xc
    802044fe:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d9760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:253
  map_area.vpn_range.r = page_ceil(TRAMPOLINE);
    80204502:	77fd                	lui	a5,0xfffff
    80204504:	fe040713          	addi	a4,s0,-32
    80204508:	97ba                	add	a5,a5,a4
    8020450a:	577d                	li	a4,-1
    8020450c:	8331                	srli	a4,a4,0xc
    8020450e:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d9768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:254
  map_area.map_type = MAP_FRAMED;
    80204512:	77fd                	lui	a5,0xfffff
    80204514:	fe040713          	addi	a4,s0,-32
    80204518:	97ba                	add	a5,a5,a4
    8020451a:	4705                	li	a4,1
    8020451c:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d9770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:255
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80204520:	77fd                	lui	a5,0xfffff
    80204522:	fe040713          	addi	a4,s0,-32
    80204526:	97ba                	add	a5,a5,a4
    80204528:	4719                	li	a4,6
    8020452a:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d9771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:256
  memory_set_push(memory_set, &map_area, NULL, 0);
    8020452e:	77fd                	lui	a5,0xfffff
    80204530:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d9760>
    80204534:	fe040713          	addi	a4,s0,-32
    80204538:	973e                	add	a4,a4,a5
    8020453a:	77fd                	lui	a5,0xfffff
    8020453c:	fe040693          	addi	a3,s0,-32
    80204540:	97b6                	add	a5,a5,a3
    80204542:	4681                	li	a3,0
    80204544:	4601                	li	a2,0
    80204546:	85ba                	mv	a1,a4
    80204548:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d9758>
    8020454c:	94bff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:259

  // return
  *user_sp = (uint64_t)user_stack_top;
    80204550:	77fd                	lui	a5,0xfffff
    80204552:	fe040713          	addi	a4,s0,-32
    80204556:	97ba                	add	a5,a5,a4
    80204558:	7407b783          	ld	a5,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f2d9740>
    8020455c:	fa843703          	ld	a4,-88(s0)
    80204560:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:260
  *entry_point = elf_header_get_entry(&elf);
    80204562:	77fd                	lui	a5,0xfffff
    80204564:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d9778>
    80204568:	fe040713          	addi	a4,s0,-32
    8020456c:	97ba                	add	a5,a5,a4
    8020456e:	853e                	mv	a0,a5
    80204570:	dfafe0ef          	jal	ra,80202b6a <elf_header_get_entry>
    80204574:	872a                	mv	a4,a0
    80204576:	77fd                	lui	a5,0xfffff
    80204578:	fe040693          	addi	a3,s0,-32
    8020457c:	97b6                	add	a5,a5,a3
    8020457e:	7387b783          	ld	a5,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f2d9738>
    80204582:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:261
}
    80204584:	0001                	nop
    80204586:	7f010113          	addi	sp,sp,2032
    8020458a:	70ee                	ld	ra,248(sp)
    8020458c:	744e                	ld	s0,240(sp)
    8020458e:	74ae                	ld	s1,232(sp)
    80204590:	6111                	addi	sp,sp,256
    80204592:	8082                	ret

0000000080204594 <memory_set_from_existed_user>:
memory_set_from_existed_user():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:264

void memory_set_from_existed_user(MemorySet *memory_set,
                                  MemorySet *user_space) {
    80204594:	7159                	addi	sp,sp,-112
    80204596:	f486                	sd	ra,104(sp)
    80204598:	f0a2                	sd	s0,96(sp)
    8020459a:	eca6                	sd	s1,88(sp)
    8020459c:	1880                	addi	s0,sp,112
    8020459e:	f8a43c23          	sd	a0,-104(s0)
    802045a2:	f8b43823          	sd	a1,-112(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:266

  memory_set_new_bare(memory_set);
    802045a6:	f9843503          	ld	a0,-104(s0)
    802045aa:	89bff0ef          	jal	ra,80203e44 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:269

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802045ae:	f9843503          	ld	a0,-104(s0)
    802045b2:	ab1ff0ef          	jal	ra,80204062 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:273

  // copy data sections / trap_context / user_stack
  MapArea new_area;
  MapArea *x = (MapArea *)(user_space->areas.buffer);
    802045b6:	f9043783          	ld	a5,-112(s0)
    802045ba:	63bc                	ld	a5,64(a5)
    802045bc:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275
  PhysPageNum src_ppn, dst_ppn;
  for (uint64_t i = 0; i < user_space->areas.size; i++) {
    802045c0:	fc043c23          	sd	zero,-40(s0)
    802045c4:	a8f1                	j	802046a0 <memory_set_from_existed_user+0x10c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:276
    map_area_from_another(&new_area, &x[i]);
    802045c6:	fd843703          	ld	a4,-40(s0)
    802045ca:	87ba                	mv	a5,a4
    802045cc:	0786                	slli	a5,a5,0x1
    802045ce:	97ba                	add	a5,a5,a4
    802045d0:	078e                	slli	a5,a5,0x3
    802045d2:	873e                	mv	a4,a5
    802045d4:	fc843783          	ld	a5,-56(s0)
    802045d8:	973e                	add	a4,a4,a5
    802045da:	fa040793          	addi	a5,s0,-96
    802045de:	85ba                	mv	a1,a4
    802045e0:	853e                	mv	a0,a5
    802045e2:	de4ff0ef          	jal	ra,80203bc6 <map_area_from_another>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:277
    memory_set_push(memory_set, &new_area, NULL, 0);
    802045e6:	fa040793          	addi	a5,s0,-96
    802045ea:	4681                	li	a3,0
    802045ec:	4601                	li	a2,0
    802045ee:	85be                	mv	a1,a5
    802045f0:	f9843503          	ld	a0,-104(s0)
    802045f4:	8a3ff0ef          	jal	ra,80203e96 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279
    // copy data from another space
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++) {
    802045f8:	fd843703          	ld	a4,-40(s0)
    802045fc:	87ba                	mv	a5,a4
    802045fe:	0786                	slli	a5,a5,0x1
    80204600:	97ba                	add	a5,a5,a4
    80204602:	078e                	slli	a5,a5,0x3
    80204604:	873e                	mv	a4,a5
    80204606:	fc843783          	ld	a5,-56(s0)
    8020460a:	97ba                	add	a5,a5,a4
    8020460c:	639c                	ld	a5,0(a5)
    8020460e:	fcf43823          	sd	a5,-48(s0)
    80204612:	a09d                	j	80204678 <memory_set_from_existed_user+0xe4>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:280 (discriminator 3)
      src_ppn = pte_ppn(*memory_set_translate(user_space, vpn));
    80204614:	fd043583          	ld	a1,-48(s0)
    80204618:	f9043503          	ld	a0,-112(s0)
    8020461c:	0f2000ef          	jal	ra,8020470e <memory_set_translate>
    80204620:	87aa                	mv	a5,a0
    80204622:	639c                	ld	a5,0(a5)
    80204624:	00a7d713          	srli	a4,a5,0xa
    80204628:	57fd                	li	a5,-1
    8020462a:	83d1                	srli	a5,a5,0x14
    8020462c:	8ff9                	and	a5,a5,a4
    8020462e:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:281 (discriminator 3)
      dst_ppn = pte_ppn(*memory_set_translate(memory_set, vpn));
    80204632:	fd043583          	ld	a1,-48(s0)
    80204636:	f9843503          	ld	a0,-104(s0)
    8020463a:	0d4000ef          	jal	ra,8020470e <memory_set_translate>
    8020463e:	87aa                	mv	a5,a0
    80204640:	639c                	ld	a5,0(a5)
    80204642:	00a7d713          	srli	a4,a5,0xa
    80204646:	57fd                	li	a5,-1
    80204648:	83d1                	srli	a5,a5,0x14
    8020464a:	8ff9                	and	a5,a5,a4
    8020464c:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:282 (discriminator 3)
      memcpy(ppn_get_bytes_array(dst_ppn), ppn_get_bytes_array(src_ppn),
    80204650:	fb843503          	ld	a0,-72(s0)
    80204654:	592000ef          	jal	ra,80204be6 <ppn_get_bytes_array>
    80204658:	84aa                	mv	s1,a0
    8020465a:	fc043503          	ld	a0,-64(s0)
    8020465e:	588000ef          	jal	ra,80204be6 <ppn_get_bytes_array>
    80204662:	87aa                	mv	a5,a0
    80204664:	6605                	lui	a2,0x1
    80204666:	85be                	mv	a1,a5
    80204668:	8526                	mv	a0,s1
    8020466a:	8d8ff0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279 (discriminator 3)
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++) {
    8020466e:	fd043783          	ld	a5,-48(s0)
    80204672:	0785                	addi	a5,a5,1
    80204674:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279 (discriminator 1)
    80204678:	fd843703          	ld	a4,-40(s0)
    8020467c:	87ba                	mv	a5,a4
    8020467e:	0786                	slli	a5,a5,0x1
    80204680:	97ba                	add	a5,a5,a4
    80204682:	078e                	slli	a5,a5,0x3
    80204684:	873e                	mv	a4,a5
    80204686:	fc843783          	ld	a5,-56(s0)
    8020468a:	97ba                	add	a5,a5,a4
    8020468c:	679c                	ld	a5,8(a5)
    8020468e:	fd043703          	ld	a4,-48(s0)
    80204692:	f8f761e3          	bltu	a4,a5,80204614 <memory_set_from_existed_user+0x80>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275 (discriminator 2)
  for (uint64_t i = 0; i < user_space->areas.size; i++) {
    80204696:	fd843783          	ld	a5,-40(s0)
    8020469a:	0785                	addi	a5,a5,1
    8020469c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275 (discriminator 1)
    802046a0:	f9043783          	ld	a5,-112(s0)
    802046a4:	779c                	ld	a5,40(a5)
    802046a6:	fd843703          	ld	a4,-40(s0)
    802046aa:	f0f76ee3          	bltu	a4,a5,802045c6 <memory_set_from_existed_user+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:286
             PAGE_SIZE);
    }
  }
}
    802046ae:	0001                	nop
    802046b0:	0001                	nop
    802046b2:	70a6                	ld	ra,104(sp)
    802046b4:	7406                	ld	s0,96(sp)
    802046b6:	64e6                	ld	s1,88(sp)
    802046b8:	6165                	addi	sp,sp,112
    802046ba:	8082                	ret

00000000802046bc <memory_set_activate>:
memory_set_activate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:288

static void memory_set_activate(MemorySet *memory_set) {
    802046bc:	7179                	addi	sp,sp,-48
    802046be:	f406                	sd	ra,40(sp)
    802046c0:	f022                	sd	s0,32(sp)
    802046c2:	1800                	addi	s0,sp,48
    802046c4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:289
  uint64_t satp = page_table_token(&memory_set->page_table);
    802046c8:	fd843783          	ld	a5,-40(s0)
    802046cc:	853e                	mv	a0,a5
    802046ce:	339000ef          	jal	ra,80205206 <page_table_token>
    802046d2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:290
  w_satp(satp);
    802046d6:	fe843503          	ld	a0,-24(s0)
    802046da:	cc0ff0ef          	jal	ra,80203b9a <w_satp>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:291
  sfence_vma();
    802046de:	cd6ff0ef          	jal	ra,80203bb4 <sfence_vma>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:292
}
    802046e2:	0001                	nop
    802046e4:	70a2                	ld	ra,40(sp)
    802046e6:	7402                	ld	s0,32(sp)
    802046e8:	6145                	addi	sp,sp,48
    802046ea:	8082                	ret

00000000802046ec <memory_set_kernel_init>:
memory_set_kernel_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:294

void memory_set_kernel_init() {
    802046ec:	1141                	addi	sp,sp,-16
    802046ee:	e406                	sd	ra,8(sp)
    802046f0:	e022                	sd	s0,0(sp)
    802046f2:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:295
  memory_set_new_kernel();
    802046f4:	9a3ff0ef          	jal	ra,80204096 <memory_set_new_kernel>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:296
  memory_set_activate(&KERNEL_SPACE);
    802046f8:	0081e517          	auipc	a0,0x81e
    802046fc:	91050513          	addi	a0,a0,-1776 # 80a22008 <KERNEL_SPACE>
    80204700:	fbdff0ef          	jal	ra,802046bc <memory_set_activate>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:297
}
    80204704:	0001                	nop
    80204706:	60a2                	ld	ra,8(sp)
    80204708:	6402                	ld	s0,0(sp)
    8020470a:	0141                	addi	sp,sp,16
    8020470c:	8082                	ret

000000008020470e <memory_set_translate>:
memory_set_translate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:299

PageTableEntry *memory_set_translate(MemorySet *memory_set, VirtPageNum vpn) {
    8020470e:	1101                	addi	sp,sp,-32
    80204710:	ec06                	sd	ra,24(sp)
    80204712:	e822                	sd	s0,16(sp)
    80204714:	1000                	addi	s0,sp,32
    80204716:	fea43423          	sd	a0,-24(s0)
    8020471a:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:300
  return page_table_translate(&memory_set->page_table, vpn);
    8020471e:	fe843783          	ld	a5,-24(s0)
    80204722:	fe043583          	ld	a1,-32(s0)
    80204726:	853e                	mv	a0,a5
    80204728:	293000ef          	jal	ra,802051ba <page_table_translate>
    8020472c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:301
}
    8020472e:	853e                	mv	a0,a5
    80204730:	60e2                	ld	ra,24(sp)
    80204732:	6442                	ld	s0,16(sp)
    80204734:	6105                	addi	sp,sp,32
    80204736:	8082                	ret

0000000080204738 <memory_set_recycle_data_pages>:
memory_set_recycle_data_pages():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:303

void memory_set_recycle_data_pages(MemorySet *memory_set) {
    80204738:	1101                	addi	sp,sp,-32
    8020473a:	ec06                	sd	ra,24(sp)
    8020473c:	e822                	sd	s0,16(sp)
    8020473e:	1000                	addi	s0,sp,32
    80204740:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:304
  memory_set_free(memory_set);
    80204744:	fe843503          	ld	a0,-24(s0)
    80204748:	8a3ff0ef          	jal	ra,80203fea <memory_set_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:305
}
    8020474c:	0001                	nop
    8020474e:	60e2                	ld	ra,24(sp)
    80204750:	6442                	ld	s0,16(sp)
    80204752:	6105                	addi	sp,sp,32
    80204754:	8082                	ret

0000000080204756 <kernel_space_insert_framed_area>:
kernel_space_insert_framed_area():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:308

void kernel_space_insert_framed_area(VirtAddr start_va, VirtAddr end_va,
                                     MapPermission permission) {
    80204756:	7179                	addi	sp,sp,-48
    80204758:	f406                	sd	ra,40(sp)
    8020475a:	f022                	sd	s0,32(sp)
    8020475c:	1800                	addi	s0,sp,48
    8020475e:	fea43423          	sd	a0,-24(s0)
    80204762:	feb43023          	sd	a1,-32(s0)
    80204766:	87b2                	mv	a5,a2
    80204768:	fcf40fa3          	sb	a5,-33(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:309
  memory_set_insert_framed_area(&KERNEL_SPACE, start_va, end_va, permission);
    8020476c:	fdf44783          	lbu	a5,-33(s0)
    80204770:	86be                	mv	a3,a5
    80204772:	fe043603          	ld	a2,-32(s0)
    80204776:	fe843583          	ld	a1,-24(s0)
    8020477a:	0081e517          	auipc	a0,0x81e
    8020477e:	88e50513          	addi	a0,a0,-1906 # 80a22008 <KERNEL_SPACE>
    80204782:	f72ff0ef          	jal	ra,80203ef4 <memory_set_insert_framed_area>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:310
}
    80204786:	0001                	nop
    80204788:	70a2                	ld	ra,40(sp)
    8020478a:	7402                	ld	s0,32(sp)
    8020478c:	6145                	addi	sp,sp,48
    8020478e:	8082                	ret

0000000080204790 <kernel_space_remove_area_with_start_vpn>:
kernel_space_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:312

void kernel_space_remove_area_with_start_vpn(VirtPageNum start_vpn) {
    80204790:	1101                	addi	sp,sp,-32
    80204792:	ec06                	sd	ra,24(sp)
    80204794:	e822                	sd	s0,16(sp)
    80204796:	1000                	addi	s0,sp,32
    80204798:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:313
  memory_set_remove_area_with_start_vpn(&KERNEL_SPACE, start_vpn);
    8020479c:	fe843583          	ld	a1,-24(s0)
    802047a0:	0081e517          	auipc	a0,0x81e
    802047a4:	86850513          	addi	a0,a0,-1944 # 80a22008 <KERNEL_SPACE>
    802047a8:	faaff0ef          	jal	ra,80203f52 <memory_set_remove_area_with_start_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:314
}
    802047ac:	0001                	nop
    802047ae:	60e2                	ld	ra,24(sp)
    802047b0:	6442                	ld	s0,16(sp)
    802047b2:	6105                	addi	sp,sp,32
    802047b4:	8082                	ret

00000000802047b6 <kernel_space_token>:
kernel_space_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:316

uint64_t kernel_space_token() { return memory_set_token(&KERNEL_SPACE); }
    802047b6:	1141                	addi	sp,sp,-16
    802047b8:	e406                	sd	ra,8(sp)
    802047ba:	e022                	sd	s0,0(sp)
    802047bc:	0800                	addi	s0,sp,16
    802047be:	0081e517          	auipc	a0,0x81e
    802047c2:	84a50513          	addi	a0,a0,-1974 # 80a22008 <KERNEL_SPACE>
    802047c6:	eaeff0ef          	jal	ra,80203e74 <memory_set_token>
    802047ca:	87aa                	mv	a5,a0
    802047cc:	853e                	mv	a0,a5
    802047ce:	60a2                	ld	ra,8(sp)
    802047d0:	6402                	ld	s0,0(sp)
    802047d2:	0141                	addi	sp,sp,16
    802047d4:	8082                	ret

00000000802047d6 <memory_set_mmap>:
memory_set_mmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:319

int64_t memory_set_mmap(MemorySet *memory_set, uint64_t start, uint64_t len,
                        uint64_t prot) {
    802047d6:	7119                	addi	sp,sp,-128
    802047d8:	fc86                	sd	ra,120(sp)
    802047da:	f8a2                	sd	s0,112(sp)
    802047dc:	0100                	addi	s0,sp,128
    802047de:	f8a43c23          	sd	a0,-104(s0)
    802047e2:	f8b43823          	sd	a1,-112(s0)
    802047e6:	f8c43423          	sd	a2,-120(s0)
    802047ea:	f8d43023          	sd	a3,-128(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:320
  if (len == 0) {
    802047ee:	f8843783          	ld	a5,-120(s0)
    802047f2:	e399                	bnez	a5,802047f8 <memory_set_mmap+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:321
    return 0;
    802047f4:	4781                	li	a5,0
    802047f6:	a2b5                	j	80204962 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    802047f8:	f9043703          	ld	a4,-112(s0)
    802047fc:	6785                	lui	a5,0x1
    802047fe:	17fd                	addi	a5,a5,-1
    80204800:	8ff9                	and	a5,a5,a4
    80204802:	ef99                	bnez	a5,80204820 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 1)
    80204804:	f8843703          	ld	a4,-120(s0)
    80204808:	400007b7          	lui	a5,0x40000
    8020480c:	00e7ea63          	bltu	a5,a4,80204820 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 2)
    80204810:	f8043783          	ld	a5,-128(s0)
    80204814:	9be1                	andi	a5,a5,-8
    80204816:	e789                	bnez	a5,80204820 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:325 (discriminator 3)
      ((prot & 0x7) == 0)) {
    80204818:	f8043783          	ld	a5,-128(s0)
    8020481c:	8b9d                	andi	a5,a5,7
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 3)
  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    8020481e:	e399                	bnez	a5,80204824 <memory_set_mmap+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:326
    return -1;
    80204820:	57fd                	li	a5,-1
    80204822:	a281                	j	80204962 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:329
  }

  len = page_ceil(len) * PAGE_SIZE;
    80204824:	f8843703          	ld	a4,-120(s0)
    80204828:	6785                	lui	a5,0x1
    8020482a:	17fd                	addi	a5,a5,-1
    8020482c:	973e                	add	a4,a4,a5
    8020482e:	77fd                	lui	a5,0xfffff
    80204830:	8ff9                	and	a5,a5,a4
    80204832:	f8f43423          	sd	a5,-120(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:330
  VirtPageNum vpn_start = addr2pn(start);
    80204836:	f9043783          	ld	a5,-112(s0)
    8020483a:	83b1                	srli	a5,a5,0xc
    8020483c:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:331
  VirtPageNum vpn_end = addr2pn(start + len);
    80204840:	f9043703          	ld	a4,-112(s0)
    80204844:	f8843783          	ld	a5,-120(s0)
    80204848:	97ba                	add	a5,a5,a4
    8020484a:	83b1                	srli	a5,a5,0xc
    8020484c:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:332
  PageTable *pt = &memory_set->page_table;
    80204850:	f9843783          	ld	a5,-104(s0)
    80204854:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204858:	fc843783          	ld	a5,-56(s0)
    8020485c:	fef43423          	sd	a5,-24(s0)
    80204860:	a005                	j	80204880 <memory_set_mmap+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:336
    if (page_table_find_pte(pt, vpn)) {
    80204862:	fe843583          	ld	a1,-24(s0)
    80204866:	fb843503          	ld	a0,-72(s0)
    8020486a:	7da000ef          	jal	ra,80205044 <page_table_find_pte>
    8020486e:	87aa                	mv	a5,a0
    80204870:	c399                	beqz	a5,80204876 <memory_set_mmap+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:337
      return -1;
    80204872:	57fd                	li	a5,-1
    80204874:	a0fd                	j	80204962 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204876:	fe843783          	ld	a5,-24(s0)
    8020487a:	0785                	addi	a5,a5,1
    8020487c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335 (discriminator 1)
    80204880:	fe843703          	ld	a4,-24(s0)
    80204884:	fc043783          	ld	a5,-64(s0)
    80204888:	fcf76de3          	bltu	a4,a5,80204862 <memory_set_mmap+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:341
    }
  }

  MapPermission map_perm = MAP_PERM_U;
    8020488c:	47c1                	li	a5,16
    8020488e:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:342
  if ((prot & 0x1) != 0)
    80204892:	f8043783          	ld	a5,-128(s0)
    80204896:	8b85                	andi	a5,a5,1
    80204898:	c799                	beqz	a5,802048a6 <memory_set_mmap+0xd0>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:343
    map_perm |= MAP_PERM_R;
    8020489a:	fe744783          	lbu	a5,-25(s0)
    8020489e:	0027e793          	ori	a5,a5,2
    802048a2:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:344
  if ((prot & 0x2) != 0)
    802048a6:	f8043783          	ld	a5,-128(s0)
    802048aa:	8b89                	andi	a5,a5,2
    802048ac:	c799                	beqz	a5,802048ba <memory_set_mmap+0xe4>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:345
    map_perm |= MAP_PERM_W;
    802048ae:	fe744783          	lbu	a5,-25(s0)
    802048b2:	0047e793          	ori	a5,a5,4
    802048b6:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:346
  if ((prot & 0x4) != 0)
    802048ba:	f8043783          	ld	a5,-128(s0)
    802048be:	8b91                	andi	a5,a5,4
    802048c0:	c799                	beqz	a5,802048ce <memory_set_mmap+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:347
    map_perm |= MAP_PERM_X;
    802048c2:	fe744783          	lbu	a5,-25(s0)
    802048c6:	0087e793          	ori	a5,a5,8
    802048ca:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352

  // map
  PhysPageNum ppn;
  PTEFlags pte_flags;
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    802048ce:	fc843783          	ld	a5,-56(s0)
    802048d2:	fcf43c23          	sd	a5,-40(s0)
    802048d6:	a0a1                	j	8020491e <memory_set_mmap+0x148>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:353 (discriminator 3)
    ppn = frame_alloc();
    802048d8:	396000ef          	jal	ra,80204c6e <frame_alloc>
    802048dc:	87aa                	mv	a5,a0
    802048de:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:354 (discriminator 3)
    pte_flags = (PTEFlags)(map_perm);
    802048e2:	fe744783          	lbu	a5,-25(s0)
    802048e6:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:355 (discriminator 3)
    page_table_map(pt, vpn, ppn, pte_flags);
    802048ea:	fa843783          	ld	a5,-88(s0)
    802048ee:	fb744703          	lbu	a4,-73(s0)
    802048f2:	86ba                	mv	a3,a4
    802048f4:	863e                	mv	a2,a5
    802048f6:	fd843583          	ld	a1,-40(s0)
    802048fa:	fb843503          	ld	a0,-72(s0)
    802048fe:	7fa000ef          	jal	ra,802050f8 <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:356 (discriminator 3)
    vector_push(&pt->frames, &ppn);
    80204902:	fb843783          	ld	a5,-72(s0)
    80204906:	07a1                	addi	a5,a5,8
    80204908:	fa840713          	addi	a4,s0,-88
    8020490c:	85ba                	mv	a1,a4
    8020490e:	853e                	mv	a0,a5
    80204910:	75c030ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204914:	fd843783          	ld	a5,-40(s0)
    80204918:	0785                	addi	a5,a5,1
    8020491a:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352 (discriminator 1)
    8020491e:	fd843703          	ld	a4,-40(s0)
    80204922:	fc043783          	ld	a5,-64(s0)
    80204926:	faf769e3          	bltu	a4,a5,802048d8 <memory_set_mmap+0x102>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360
  }

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    8020492a:	fc843783          	ld	a5,-56(s0)
    8020492e:	fcf43823          	sd	a5,-48(s0)
    80204932:	a005                	j	80204952 <memory_set_mmap+0x17c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:361
    if (!page_table_find_pte(pt, vpn)) {
    80204934:	fd043583          	ld	a1,-48(s0)
    80204938:	fb843503          	ld	a0,-72(s0)
    8020493c:	708000ef          	jal	ra,80205044 <page_table_find_pte>
    80204940:	87aa                	mv	a5,a0
    80204942:	e399                	bnez	a5,80204948 <memory_set_mmap+0x172>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:362
      return -1;
    80204944:	57fd                	li	a5,-1
    80204946:	a831                	j	80204962 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204948:	fd043783          	ld	a5,-48(s0)
    8020494c:	0785                	addi	a5,a5,1
    8020494e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360 (discriminator 1)
    80204952:	fd043703          	ld	a4,-48(s0)
    80204956:	fc043783          	ld	a5,-64(s0)
    8020495a:	fcf76de3          	bltu	a4,a5,80204934 <memory_set_mmap+0x15e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:366
    }
  }

  return len;
    8020495e:	f8843783          	ld	a5,-120(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:367 (discriminator 1)
}
    80204962:	853e                	mv	a0,a5
    80204964:	70e6                	ld	ra,120(sp)
    80204966:	7446                	ld	s0,112(sp)
    80204968:	6109                	addi	sp,sp,128
    8020496a:	8082                	ret

000000008020496c <memory_set_munmap>:
memory_set_munmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:369

int64_t memory_set_munmap(MemorySet *memory_set, uint64_t start, uint64_t len) {
    8020496c:	711d                	addi	sp,sp,-96
    8020496e:	ec86                	sd	ra,88(sp)
    80204970:	e8a2                	sd	s0,80(sp)
    80204972:	1080                	addi	s0,sp,96
    80204974:	faa43c23          	sd	a0,-72(s0)
    80204978:	fab43823          	sd	a1,-80(s0)
    8020497c:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:370
  if (len == 0) {
    80204980:	fa843783          	ld	a5,-88(s0)
    80204984:	e399                	bnez	a5,8020498a <memory_set_munmap+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:371
    return 0;
    80204986:	4781                	li	a5,0
    80204988:	a0ed                	j	80204a72 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:374
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE)) {
    8020498a:	fb043703          	ld	a4,-80(s0)
    8020498e:	6785                	lui	a5,0x1
    80204990:	17fd                	addi	a5,a5,-1
    80204992:	8ff9                	and	a5,a5,a4
    80204994:	e799                	bnez	a5,802049a2 <memory_set_munmap+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:374 (discriminator 1)
    80204996:	fa843703          	ld	a4,-88(s0)
    8020499a:	400007b7          	lui	a5,0x40000
    8020499e:	00e7f463          	bgeu	a5,a4,802049a6 <memory_set_munmap+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:375
    return -1;
    802049a2:	57fd                	li	a5,-1
    802049a4:	a0f9                	j	80204a72 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:378
  }

  len = page_ceil(len) * PAGE_SIZE;
    802049a6:	fa843703          	ld	a4,-88(s0)
    802049aa:	6785                	lui	a5,0x1
    802049ac:	17fd                	addi	a5,a5,-1
    802049ae:	973e                	add	a4,a4,a5
    802049b0:	77fd                	lui	a5,0xfffff
    802049b2:	8ff9                	and	a5,a5,a4
    802049b4:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:379
  VirtPageNum vpn_start = addr2pn(start);
    802049b8:	fb043783          	ld	a5,-80(s0)
    802049bc:	83b1                	srli	a5,a5,0xc
    802049be:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:380
  VirtPageNum vpn_end = addr2pn(start + len);
    802049c2:	fb043703          	ld	a4,-80(s0)
    802049c6:	fa843783          	ld	a5,-88(s0)
    802049ca:	97ba                	add	a5,a5,a4
    802049cc:	83b1                	srli	a5,a5,0xc
    802049ce:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:381
  PageTable *pt = &memory_set->page_table;
    802049d2:	fb843783          	ld	a5,-72(s0)
    802049d6:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    802049da:	fd043783          	ld	a5,-48(s0)
    802049de:	fef43423          	sd	a5,-24(s0)
    802049e2:	a005                	j	80204a02 <memory_set_munmap+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:385
    if (!page_table_find_pte(pt, vpn)) {
    802049e4:	fe843583          	ld	a1,-24(s0)
    802049e8:	fc043503          	ld	a0,-64(s0)
    802049ec:	658000ef          	jal	ra,80205044 <page_table_find_pte>
    802049f0:	87aa                	mv	a5,a0
    802049f2:	e399                	bnez	a5,802049f8 <memory_set_munmap+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:386
      return -1;
    802049f4:	57fd                	li	a5,-1
    802049f6:	a8b5                	j	80204a72 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    802049f8:	fe843783          	ld	a5,-24(s0)
    802049fc:	0785                	addi	a5,a5,1
    802049fe:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384 (discriminator 1)
    80204a02:	fe843703          	ld	a4,-24(s0)
    80204a06:	fc843783          	ld	a5,-56(s0)
    80204a0a:	fcf76de3          	bltu	a4,a5,802049e4 <memory_set_munmap+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391
    }
  }

  // unmap
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a0e:	fd043783          	ld	a5,-48(s0)
    80204a12:	fef43023          	sd	a5,-32(s0)
    80204a16:	a821                	j	80204a2e <memory_set_munmap+0xc2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:392 (discriminator 3)
    page_table_unmap(pt, vpn);
    80204a18:	fe043583          	ld	a1,-32(s0)
    80204a1c:	fc043503          	ld	a0,-64(s0)
    80204a20:	746000ef          	jal	ra,80205166 <page_table_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a24:	fe043783          	ld	a5,-32(s0)
    80204a28:	0785                	addi	a5,a5,1
    80204a2a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391 (discriminator 1)
    80204a2e:	fe043703          	ld	a4,-32(s0)
    80204a32:	fc843783          	ld	a5,-56(s0)
    80204a36:	fef761e3          	bltu	a4,a5,80204a18 <memory_set_munmap+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396
  }

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a3a:	fd043783          	ld	a5,-48(s0)
    80204a3e:	fcf43c23          	sd	a5,-40(s0)
    80204a42:	a005                	j	80204a62 <memory_set_munmap+0xf6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:397
    if (page_table_find_pte(pt, vpn)) {
    80204a44:	fd843583          	ld	a1,-40(s0)
    80204a48:	fc043503          	ld	a0,-64(s0)
    80204a4c:	5f8000ef          	jal	ra,80205044 <page_table_find_pte>
    80204a50:	87aa                	mv	a5,a0
    80204a52:	c399                	beqz	a5,80204a58 <memory_set_munmap+0xec>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:398
      return -1;
    80204a54:	57fd                	li	a5,-1
    80204a56:	a831                	j	80204a72 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a58:	fd843783          	ld	a5,-40(s0)
    80204a5c:	0785                	addi	a5,a5,1
    80204a5e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396 (discriminator 1)
    80204a62:	fd843703          	ld	a4,-40(s0)
    80204a66:	fc843783          	ld	a5,-56(s0)
    80204a6a:	fcf76de3          	bltu	a4,a5,80204a44 <memory_set_munmap+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:402
    }
  }

  return len;
    80204a6e:	fa843783          	ld	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:403
}
    80204a72:	853e                	mv	a0,a5
    80204a74:	60e6                	ld	ra,88(sp)
    80204a76:	6446                	ld	s0,80(sp)
    80204a78:	6125                	addi	sp,sp,96
    80204a7a:	8082                	ret

0000000080204a7c <memory_set_remap_test>:
memory_set_remap_test():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:406

void memory_set_remap_test() 
{
    80204a7c:	7179                	addi	sp,sp,-48
    80204a7e:	f406                	sd	ra,40(sp)
    80204a80:	f022                	sd	s0,32(sp)
    80204a82:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:407
  VirtAddr mid_text = (VirtAddr)(((uint64_t)&stext + (uint64_t)&etext) / 2);
    80204a84:	ffffb717          	auipc	a4,0xffffb
    80204a88:	57c70713          	addi	a4,a4,1404 # 80200000 <_start>
    80204a8c:	00004797          	auipc	a5,0x4
    80204a90:	57478793          	addi	a5,a5,1396 # 80209000 <etext>
    80204a94:	97ba                	add	a5,a5,a4
    80204a96:	8385                	srli	a5,a5,0x1
    80204a98:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:409
  VirtAddr mid_rodata =
      (VirtAddr)(((uint64_t)&srodata + (uint64_t)&erodata) / 2);
    80204a9c:	00004717          	auipc	a4,0x4
    80204aa0:	56470713          	addi	a4,a4,1380 # 80209000 <etext>
    80204aa4:	00005797          	auipc	a5,0x5
    80204aa8:	55c78793          	addi	a5,a5,1372 # 8020a000 <app_starts.1>
    80204aac:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:408
  VirtAddr mid_rodata =
    80204aae:	8385                	srli	a5,a5,0x1
    80204ab0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:410
  VirtAddr mid_data = (VirtAddr)(((uint64_t)&sdata + (uint64_t)&edata) / 2);
    80204ab4:	00005717          	auipc	a4,0x5
    80204ab8:	54c70713          	addi	a4,a4,1356 # 8020a000 <app_starts.1>
    80204abc:	0000d797          	auipc	a5,0xd
    80204ac0:	54478793          	addi	a5,a5,1348 # 80212000 <boot_stack_lower_bound>
    80204ac4:	97ba                	add	a5,a5,a4
    80204ac6:	8385                	srli	a5,a5,0x1
    80204ac8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:412

  ASSERT(!pte_writable(*page_table_translate(
    80204acc:	fe843783          	ld	a5,-24(s0)
    80204ad0:	83b1                	srli	a5,a5,0xc
    80204ad2:	85be                	mv	a1,a5
    80204ad4:	0081d517          	auipc	a0,0x81d
    80204ad8:	53450513          	addi	a0,a0,1332 # 80a22008 <KERNEL_SPACE>
    80204adc:	6de000ef          	jal	ra,802051ba <page_table_translate>
    80204ae0:	87aa                	mv	a5,a0
    80204ae2:	639c                	ld	a5,0(a5)
    80204ae4:	8b91                	andi	a5,a5,4
    80204ae6:	cf89                	beqz	a5,80204b00 <memory_set_remap_test+0x84>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:412 (discriminator 1)
    80204ae8:	00004617          	auipc	a2,0x4
    80204aec:	66860613          	addi	a2,a2,1640 # 80209150 <MMIO+0x48>
    80204af0:	19c00593          	li	a1,412
    80204af4:	00004517          	auipc	a0,0x4
    80204af8:	63c50513          	addi	a0,a0,1596 # 80209130 <MMIO+0x28>
    80204afc:	39d010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:414
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_text))));
  ASSERT(!pte_writable(*page_table_translate(
    80204b00:	fe043783          	ld	a5,-32(s0)
    80204b04:	83b1                	srli	a5,a5,0xc
    80204b06:	85be                	mv	a1,a5
    80204b08:	0081d517          	auipc	a0,0x81d
    80204b0c:	50050513          	addi	a0,a0,1280 # 80a22008 <KERNEL_SPACE>
    80204b10:	6aa000ef          	jal	ra,802051ba <page_table_translate>
    80204b14:	87aa                	mv	a5,a0
    80204b16:	639c                	ld	a5,0(a5)
    80204b18:	8b91                	andi	a5,a5,4
    80204b1a:	cf89                	beqz	a5,80204b34 <memory_set_remap_test+0xb8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:414 (discriminator 1)
    80204b1c:	00004617          	auipc	a2,0x4
    80204b20:	6ac60613          	addi	a2,a2,1708 # 802091c8 <MMIO+0xc0>
    80204b24:	19e00593          	li	a1,414
    80204b28:	00004517          	auipc	a0,0x4
    80204b2c:	60850513          	addi	a0,a0,1544 # 80209130 <MMIO+0x28>
    80204b30:	369010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:416
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_rodata))));
  ASSERT(!pte_executable(*page_table_translate(
    80204b34:	fd843783          	ld	a5,-40(s0)
    80204b38:	83b1                	srli	a5,a5,0xc
    80204b3a:	85be                	mv	a1,a5
    80204b3c:	0081d517          	auipc	a0,0x81d
    80204b40:	4cc50513          	addi	a0,a0,1228 # 80a22008 <KERNEL_SPACE>
    80204b44:	676000ef          	jal	ra,802051ba <page_table_translate>
    80204b48:	87aa                	mv	a5,a0
    80204b4a:	639c                	ld	a5,0(a5)
    80204b4c:	8ba1                	andi	a5,a5,8
    80204b4e:	cf89                	beqz	a5,80204b68 <memory_set_remap_test+0xec>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:416 (discriminator 1)
    80204b50:	00004617          	auipc	a2,0x4
    80204b54:	6f060613          	addi	a2,a2,1776 # 80209240 <MMIO+0x138>
    80204b58:	1a000593          	li	a1,416
    80204b5c:	00004517          	auipc	a0,0x4
    80204b60:	5d450513          	addi	a0,a0,1492 # 80209130 <MMIO+0x28>
    80204b64:	335010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:418
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_data))));
}
    80204b68:	0001                	nop
    80204b6a:	70a2                	ld	ra,40(sp)
    80204b6c:	7402                	ld	s0,32(sp)
    80204b6e:	6145                	addi	sp,sp,48
    80204b70:	8082                	ret

0000000080204b72 <vpn_indexes>:
vpn_indexes():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:4
#include "config.h"
#include "mem.h"

void vpn_indexes(VirtPageNum vpn, uint64_t *idx) {
    80204b72:	7179                	addi	sp,sp,-48
    80204b74:	f422                	sd	s0,40(sp)
    80204b76:	1800                	addi	s0,sp,48
    80204b78:	fca43c23          	sd	a0,-40(s0)
    80204b7c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5
  for (int i = 2; i >= 0; i--) {
    80204b80:	4789                	li	a5,2
    80204b82:	fef42623          	sw	a5,-20(s0)
    80204b86:	a035                	j	80204bb2 <vpn_indexes+0x40>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:6 (discriminator 3)
    idx[i] = vpn & 0x1ff;
    80204b88:	fec42783          	lw	a5,-20(s0)
    80204b8c:	078e                	slli	a5,a5,0x3
    80204b8e:	fd043703          	ld	a4,-48(s0)
    80204b92:	97ba                	add	a5,a5,a4
    80204b94:	fd843703          	ld	a4,-40(s0)
    80204b98:	1ff77713          	andi	a4,a4,511
    80204b9c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:7 (discriminator 3)
    vpn >>= 9;
    80204b9e:	fd843783          	ld	a5,-40(s0)
    80204ba2:	83a5                	srli	a5,a5,0x9
    80204ba4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5 (discriminator 3)
  for (int i = 2; i >= 0; i--) {
    80204ba8:	fec42783          	lw	a5,-20(s0)
    80204bac:	37fd                	addiw	a5,a5,-1
    80204bae:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5 (discriminator 1)
    80204bb2:	fec42783          	lw	a5,-20(s0)
    80204bb6:	2781                	sext.w	a5,a5
    80204bb8:	fc07d8e3          	bgez	a5,80204b88 <vpn_indexes+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:9
  }
}
    80204bbc:	0001                	nop
    80204bbe:	0001                	nop
    80204bc0:	7422                	ld	s0,40(sp)
    80204bc2:	6145                	addi	sp,sp,48
    80204bc4:	8082                	ret

0000000080204bc6 <ppn_get_pte_array>:
ppn_get_pte_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:11

PageTableEntry *ppn_get_pte_array(PhysPageNum ppn) {
    80204bc6:	7179                	addi	sp,sp,-48
    80204bc8:	f422                	sd	s0,40(sp)
    80204bca:	1800                	addi	s0,sp,48
    80204bcc:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:12
  PhysAddr pa = pn2addr(ppn);
    80204bd0:	fd843783          	ld	a5,-40(s0)
    80204bd4:	07b2                	slli	a5,a5,0xc
    80204bd6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:13
  return (PageTableEntry *)pa; // len = 512 * 8
    80204bda:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:14
}
    80204bde:	853e                	mv	a0,a5
    80204be0:	7422                	ld	s0,40(sp)
    80204be2:	6145                	addi	sp,sp,48
    80204be4:	8082                	ret

0000000080204be6 <ppn_get_bytes_array>:
ppn_get_bytes_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:16

uint8_t *ppn_get_bytes_array(PhysPageNum ppn) {
    80204be6:	7179                	addi	sp,sp,-48
    80204be8:	f422                	sd	s0,40(sp)
    80204bea:	1800                	addi	s0,sp,48
    80204bec:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:17
  PhysAddr pa = pn2addr(ppn);
    80204bf0:	fd843783          	ld	a5,-40(s0)
    80204bf4:	07b2                	slli	a5,a5,0xc
    80204bf6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:18
  return (uint8_t *)pa; // len = PAGE_SIZE (4096)
    80204bfa:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:19
}
    80204bfe:	853e                	mv	a0,a5
    80204c00:	7422                	ld	s0,40(sp)
    80204c02:	6145                	addi	sp,sp,48
    80204c04:	8082                	ret

0000000080204c06 <frame_allocator_init>:
frame_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:14
  struct vector recycled;
} StackFrameAllocator;

static StackFrameAllocator FRAME_ALLOCATOR;

void frame_allocator_init() {
    80204c06:	1141                	addi	sp,sp,-16
    80204c08:	e406                	sd	ra,8(sp)
    80204c0a:	e022                	sd	s0,0(sp)
    80204c0c:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:16
  extern uint8_t ekernel;
  FRAME_ALLOCATOR.current = page_ceil((PhysAddr)&ekernel);
    80204c0e:	00b21717          	auipc	a4,0xb21
    80204c12:	3f270713          	addi	a4,a4,1010 # 80d26000 <ebss>
    80204c16:	6785                	lui	a5,0x1
    80204c18:	17fd                	addi	a5,a5,-1
    80204c1a:	97ba                	add	a5,a5,a4
    80204c1c:	00c7d713          	srli	a4,a5,0xc
    80204c20:	0081d797          	auipc	a5,0x81d
    80204c24:	43078793          	addi	a5,a5,1072 # 80a22050 <FRAME_ALLOCATOR>
    80204c28:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:17
  FRAME_ALLOCATOR.end = page_floor(MEMORY_END);
    80204c2a:	0081d797          	auipc	a5,0x81d
    80204c2e:	42678793          	addi	a5,a5,1062 # 80a22050 <FRAME_ALLOCATOR>
    80204c32:	00081737          	lui	a4,0x81
    80204c36:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:18
  vector_new(&FRAME_ALLOCATOR.recycled, sizeof(PhysPageNum));
    80204c38:	45a1                	li	a1,8
    80204c3a:	0081d517          	auipc	a0,0x81d
    80204c3e:	42650513          	addi	a0,a0,1062 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204c42:	3d8030ef          	jal	ra,8020801a <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:19
}
    80204c46:	0001                	nop
    80204c48:	60a2                	ld	ra,8(sp)
    80204c4a:	6402                	ld	s0,0(sp)
    80204c4c:	0141                	addi	sp,sp,16
    80204c4e:	8082                	ret

0000000080204c50 <frame_allocator_free>:
frame_allocator_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:21

void frame_allocator_free() { vector_free(&FRAME_ALLOCATOR.recycled); }
    80204c50:	1141                	addi	sp,sp,-16
    80204c52:	e406                	sd	ra,8(sp)
    80204c54:	e022                	sd	s0,0(sp)
    80204c56:	0800                	addi	s0,sp,16
    80204c58:	0081d517          	auipc	a0,0x81d
    80204c5c:	40850513          	addi	a0,a0,1032 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204c60:	58e030ef          	jal	ra,802081ee <vector_free>
    80204c64:	0001                	nop
    80204c66:	60a2                	ld	ra,8(sp)
    80204c68:	6402                	ld	s0,0(sp)
    80204c6a:	0141                	addi	sp,sp,16
    80204c6c:	8082                	ret

0000000080204c6e <frame_alloc>:
frame_alloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:24

PhysPageNum frame_alloc() 
{
    80204c6e:	1101                	addi	sp,sp,-32
    80204c70:	ec06                	sd	ra,24(sp)
    80204c72:	e822                	sd	s0,16(sp)
    80204c74:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:25
  PhysPageNum ppn = 0;
    80204c76:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:26
  if (!vector_empty(&FRAME_ALLOCATOR.recycled)) 
    80204c7a:	0081d517          	auipc	a0,0x81d
    80204c7e:	3e650513          	addi	a0,a0,998 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204c82:	54a030ef          	jal	ra,802081cc <vector_empty>
    80204c86:	87aa                	mv	a5,a0
    80204c88:	e395                	bnez	a5,80204cac <frame_alloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:28
  {
    ppn = *(PhysPageNum *)vector_back(&FRAME_ALLOCATOR.recycled);
    80204c8a:	0081d517          	auipc	a0,0x81d
    80204c8e:	3d650513          	addi	a0,a0,982 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204c92:	4e8030ef          	jal	ra,8020817a <vector_back>
    80204c96:	87aa                	mv	a5,a0
    80204c98:	639c                	ld	a5,0(a5)
    80204c9a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:29
    vector_pop(&FRAME_ALLOCATOR.recycled);
    80204c9e:	0081d517          	auipc	a0,0x81d
    80204ca2:	3c250513          	addi	a0,a0,962 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204ca6:	490030ef          	jal	ra,80208136 <vector_pop>
    80204caa:	a8a9                	j	80204d04 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:31
  } else {
    if (FRAME_ALLOCATOR.current == FRAME_ALLOCATOR.end) {
    80204cac:	0081d797          	auipc	a5,0x81d
    80204cb0:	3a478793          	addi	a5,a5,932 # 80a22050 <FRAME_ALLOCATOR>
    80204cb4:	6398                	ld	a4,0(a5)
    80204cb6:	0081d797          	auipc	a5,0x81d
    80204cba:	39a78793          	addi	a5,a5,922 # 80a22050 <FRAME_ALLOCATOR>
    80204cbe:	679c                	ld	a5,8(a5)
    80204cc0:	00f71f63          	bne	a4,a5,80204cde <frame_alloc+0x70>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:32
      panic("No empty physical page.\n");
    80204cc4:	00004617          	auipc	a2,0x4
    80204cc8:	61460613          	addi	a2,a2,1556 # 802092d8 <MMIO+0x10>
    80204ccc:	02000593          	li	a1,32
    80204cd0:	00004517          	auipc	a0,0x4
    80204cd4:	62850513          	addi	a0,a0,1576 # 802092f8 <MMIO+0x30>
    80204cd8:	1c1010ef          	jal	ra,80206698 <_panic>
    80204cdc:	a025                	j	80204d04 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:34
    } else {
      ppn = FRAME_ALLOCATOR.current;
    80204cde:	0081d797          	auipc	a5,0x81d
    80204ce2:	37278793          	addi	a5,a5,882 # 80a22050 <FRAME_ALLOCATOR>
    80204ce6:	639c                	ld	a5,0(a5)
    80204ce8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:35
      FRAME_ALLOCATOR.current++;
    80204cec:	0081d797          	auipc	a5,0x81d
    80204cf0:	36478793          	addi	a5,a5,868 # 80a22050 <FRAME_ALLOCATOR>
    80204cf4:	639c                	ld	a5,0(a5)
    80204cf6:	00178713          	addi	a4,a5,1
    80204cfa:	0081d797          	auipc	a5,0x81d
    80204cfe:	35678793          	addi	a5,a5,854 # 80a22050 <FRAME_ALLOCATOR>
    80204d02:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:38
    }
  }
  memset((uint8_t *)pn2addr(ppn), 0, PAGE_SIZE);
    80204d04:	fe843783          	ld	a5,-24(s0)
    80204d08:	07b2                	slli	a5,a5,0xc
    80204d0a:	6605                	lui	a2,0x1
    80204d0c:	4581                	li	a1,0
    80204d0e:	853e                	mv	a0,a5
    80204d10:	a81fe0ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:39
  return ppn;
    80204d14:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:40
}
    80204d18:	853e                	mv	a0,a5
    80204d1a:	60e2                	ld	ra,24(sp)
    80204d1c:	6442                	ld	s0,16(sp)
    80204d1e:	6105                	addi	sp,sp,32
    80204d20:	8082                	ret

0000000080204d22 <frame_dealloc>:
frame_dealloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:42

void frame_dealloc(PhysPageNum ppn) {
    80204d22:	7139                	addi	sp,sp,-64
    80204d24:	fc06                	sd	ra,56(sp)
    80204d26:	f822                	sd	s0,48(sp)
    80204d28:	0080                	addi	s0,sp,64
    80204d2a:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:43
  bool in_recycled = false;
    80204d2e:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:44
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80204d32:	0081d797          	auipc	a5,0x81d
    80204d36:	31e78793          	addi	a5,a5,798 # 80a22050 <FRAME_ALLOCATOR>
    80204d3a:	779c                	ld	a5,40(a5)
    80204d3c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204d40:	fe043023          	sd	zero,-32(s0)
    80204d44:	a02d                	j	80204d6e <frame_dealloc+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:46
    if (x[i] == ppn) {
    80204d46:	fe043783          	ld	a5,-32(s0)
    80204d4a:	078e                	slli	a5,a5,0x3
    80204d4c:	fd843703          	ld	a4,-40(s0)
    80204d50:	97ba                	add	a5,a5,a4
    80204d52:	6398                	ld	a4,0(a5)
    80204d54:	fc843783          	ld	a5,-56(s0)
    80204d58:	00f71663          	bne	a4,a5,80204d64 <frame_dealloc+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:47
      in_recycled = true;
    80204d5c:	4785                	li	a5,1
    80204d5e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:48
      break;
    80204d62:	a839                	j	80204d80 <frame_dealloc+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45 (discriminator 2)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204d64:	fe043783          	ld	a5,-32(s0)
    80204d68:	0785                	addi	a5,a5,1
    80204d6a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45 (discriminator 1)
    80204d6e:	0081d797          	auipc	a5,0x81d
    80204d72:	2e278793          	addi	a5,a5,738 # 80a22050 <FRAME_ALLOCATOR>
    80204d76:	6b9c                	ld	a5,16(a5)
    80204d78:	fe043703          	ld	a4,-32(s0)
    80204d7c:	fcf765e3          	bltu	a4,a5,80204d46 <frame_dealloc+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:51
    }
  }
  if (ppn >= FRAME_ALLOCATOR.current || in_recycled) {
    80204d80:	0081d797          	auipc	a5,0x81d
    80204d84:	2d078793          	addi	a5,a5,720 # 80a22050 <FRAME_ALLOCATOR>
    80204d88:	6398                	ld	a4,0(a5)
    80204d8a:	fc843783          	ld	a5,-56(s0)
    80204d8e:	00e7f663          	bgeu	a5,a4,80204d9a <frame_dealloc+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:51 (discriminator 1)
    80204d92:	fec42783          	lw	a5,-20(s0)
    80204d96:	2781                	sext.w	a5,a5
    80204d98:	cf89                	beqz	a5,80204db2 <frame_dealloc+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:52
    panic("Frame ppn= has not been allocated!\n");
    80204d9a:	00004617          	auipc	a2,0x4
    80204d9e:	58660613          	addi	a2,a2,1414 # 80209320 <MMIO+0x58>
    80204da2:	03400593          	li	a1,52
    80204da6:	00004517          	auipc	a0,0x4
    80204daa:	55250513          	addi	a0,a0,1362 # 802092f8 <MMIO+0x30>
    80204dae:	0eb010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:54
  }
  vector_push(&FRAME_ALLOCATOR.recycled, &ppn);
    80204db2:	fc840793          	addi	a5,s0,-56
    80204db6:	85be                	mv	a1,a5
    80204db8:	0081d517          	auipc	a0,0x81d
    80204dbc:	2a850513          	addi	a0,a0,680 # 80a22060 <FRAME_ALLOCATOR+0x10>
    80204dc0:	2ac030ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:55
}
    80204dc4:	0001                	nop
    80204dc6:	70e2                	ld	ra,56(sp)
    80204dc8:	7442                	ld	s0,48(sp)
    80204dca:	6121                	addi	sp,sp,64
    80204dcc:	8082                	ret

0000000080204dce <frame_remaining_pages>:
frame_remaining_pages():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:57

uint64_t frame_remaining_pages() {
    80204dce:	1101                	addi	sp,sp,-32
    80204dd0:	ec22                	sd	s0,24(sp)
    80204dd2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:58
  uint64_t x = (uint64_t)(FRAME_ALLOCATOR.end - FRAME_ALLOCATOR.current);
    80204dd4:	0081d797          	auipc	a5,0x81d
    80204dd8:	27c78793          	addi	a5,a5,636 # 80a22050 <FRAME_ALLOCATOR>
    80204ddc:	6798                	ld	a4,8(a5)
    80204dde:	0081d797          	auipc	a5,0x81d
    80204de2:	27278793          	addi	a5,a5,626 # 80a22050 <FRAME_ALLOCATOR>
    80204de6:	639c                	ld	a5,0(a5)
    80204de8:	40f707b3          	sub	a5,a4,a5
    80204dec:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:59
  uint64_t y = (uint64_t)FRAME_ALLOCATOR.recycled.size;
    80204df0:	0081d797          	auipc	a5,0x81d
    80204df4:	26078793          	addi	a5,a5,608 # 80a22050 <FRAME_ALLOCATOR>
    80204df8:	6b9c                	ld	a5,16(a5)
    80204dfa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:60
  return x + y;
    80204dfe:	fe843703          	ld	a4,-24(s0)
    80204e02:	fe043783          	ld	a5,-32(s0)
    80204e06:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:61
}
    80204e08:	853e                	mv	a0,a5
    80204e0a:	6462                	ld	s0,24(sp)
    80204e0c:	6105                	addi	sp,sp,32
    80204e0e:	8082                	ret

0000000080204e10 <frame_allocator_print>:
frame_allocator_print():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:63

void frame_allocator_print() {
    80204e10:	1101                	addi	sp,sp,-32
    80204e12:	ec06                	sd	ra,24(sp)
    80204e14:	e822                	sd	s0,16(sp)
    80204e16:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:64
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80204e18:	0081d797          	auipc	a5,0x81d
    80204e1c:	23878793          	addi	a5,a5,568 # 80a22050 <FRAME_ALLOCATOR>
    80204e20:	779c                	ld	a5,40(a5)
    80204e22:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:65
  printk("FRAME_ALLOCATOR current = %llx, recycled = [ ",
    80204e26:	0081d797          	auipc	a5,0x81d
    80204e2a:	22a78793          	addi	a5,a5,554 # 80a22050 <FRAME_ALLOCATOR>
    80204e2e:	639c                	ld	a5,0(a5)
    80204e30:	85be                	mv	a1,a5
    80204e32:	00004517          	auipc	a0,0x4
    80204e36:	51650513          	addi	a0,a0,1302 # 80209348 <MMIO+0x80>
    80204e3a:	9b1fd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67
         FRAME_ALLOCATOR.current);
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204e3e:	fe043423          	sd	zero,-24(s0)
    80204e42:	a025                	j	80204e6a <frame_allocator_print+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:68 (discriminator 3)
    printk("%llx ", x[i]);
    80204e44:	fe843783          	ld	a5,-24(s0)
    80204e48:	078e                	slli	a5,a5,0x3
    80204e4a:	fe043703          	ld	a4,-32(s0)
    80204e4e:	97ba                	add	a5,a5,a4
    80204e50:	639c                	ld	a5,0(a5)
    80204e52:	85be                	mv	a1,a5
    80204e54:	00004517          	auipc	a0,0x4
    80204e58:	52450513          	addi	a0,a0,1316 # 80209378 <MMIO+0xb0>
    80204e5c:	98ffd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67 (discriminator 3)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204e60:	fe843783          	ld	a5,-24(s0)
    80204e64:	0785                	addi	a5,a5,1
    80204e66:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67 (discriminator 1)
    80204e6a:	0081d797          	auipc	a5,0x81d
    80204e6e:	1e678793          	addi	a5,a5,486 # 80a22050 <FRAME_ALLOCATOR>
    80204e72:	6b9c                	ld	a5,16(a5)
    80204e74:	fe843703          	ld	a4,-24(s0)
    80204e78:	fcf766e3          	bltu	a4,a5,80204e44 <frame_allocator_print+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:70
  }
  printk("]\n");
    80204e7c:	00004517          	auipc	a0,0x4
    80204e80:	50450513          	addi	a0,a0,1284 # 80209380 <MMIO+0xb8>
    80204e84:	967fd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:71
}
    80204e88:	0001                	nop
    80204e8a:	60e2                	ld	ra,24(sp)
    80204e8c:	6442                	ld	s0,16(sp)
    80204e8e:	6105                	addi	sp,sp,32
    80204e90:	8082                	ret

0000000080204e92 <page_table_new>:
page_table_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:4
#include "mem.h"
#include "string.h"
#include "debug.h"
void page_table_new(PageTable *pt) {
    80204e92:	7179                	addi	sp,sp,-48
    80204e94:	f406                	sd	ra,40(sp)
    80204e96:	f022                	sd	s0,32(sp)
    80204e98:	1800                	addi	s0,sp,48
    80204e9a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:5
  PhysPageNum frame = frame_alloc();
    80204e9e:	dd1ff0ef          	jal	ra,80204c6e <frame_alloc>
    80204ea2:	87aa                	mv	a5,a0
    80204ea4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:6
  pt->root_ppn = frame;
    80204ea8:	fe843703          	ld	a4,-24(s0)
    80204eac:	fd843783          	ld	a5,-40(s0)
    80204eb0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:7
  vector_new(&pt->frames, sizeof(PhysPageNum));
    80204eb2:	fd843783          	ld	a5,-40(s0)
    80204eb6:	07a1                	addi	a5,a5,8
    80204eb8:	45a1                	li	a1,8
    80204eba:	853e                	mv	a0,a5
    80204ebc:	15e030ef          	jal	ra,8020801a <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:8
  vector_push(&pt->frames, &frame);
    80204ec0:	fd843783          	ld	a5,-40(s0)
    80204ec4:	07a1                	addi	a5,a5,8
    80204ec6:	fe840713          	addi	a4,s0,-24
    80204eca:	85ba                	mv	a1,a4
    80204ecc:	853e                	mv	a0,a5
    80204ece:	19e030ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:9
}
    80204ed2:	0001                	nop
    80204ed4:	70a2                	ld	ra,40(sp)
    80204ed6:	7402                	ld	s0,32(sp)
    80204ed8:	6145                	addi	sp,sp,48
    80204eda:	8082                	ret

0000000080204edc <page_table_free>:
page_table_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:11

void page_table_free(PageTable *pt) {
    80204edc:	7179                	addi	sp,sp,-48
    80204ede:	f406                	sd	ra,40(sp)
    80204ee0:	f022                	sd	s0,32(sp)
    80204ee2:	1800                	addi	s0,sp,48
    80204ee4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:13
  PhysPageNum frame;
  while (!vector_empty(&pt->frames)) {
    80204ee8:	a02d                	j	80204f12 <page_table_free+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:14
    frame = *(PhysPageNum *)vector_back(&pt->frames);
    80204eea:	fd843783          	ld	a5,-40(s0)
    80204eee:	07a1                	addi	a5,a5,8
    80204ef0:	853e                	mv	a0,a5
    80204ef2:	288030ef          	jal	ra,8020817a <vector_back>
    80204ef6:	87aa                	mv	a5,a0
    80204ef8:	639c                	ld	a5,0(a5)
    80204efa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:15
    vector_pop(&pt->frames);
    80204efe:	fd843783          	ld	a5,-40(s0)
    80204f02:	07a1                	addi	a5,a5,8
    80204f04:	853e                	mv	a0,a5
    80204f06:	230030ef          	jal	ra,80208136 <vector_pop>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:16
    frame_dealloc(frame);
    80204f0a:	fe843503          	ld	a0,-24(s0)
    80204f0e:	e15ff0ef          	jal	ra,80204d22 <frame_dealloc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:13
  while (!vector_empty(&pt->frames)) {
    80204f12:	fd843783          	ld	a5,-40(s0)
    80204f16:	07a1                	addi	a5,a5,8
    80204f18:	853e                	mv	a0,a5
    80204f1a:	2b2030ef          	jal	ra,802081cc <vector_empty>
    80204f1e:	87aa                	mv	a5,a0
    80204f20:	d7e9                	beqz	a5,80204eea <page_table_free+0xe>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:18
  }
  vector_free(&pt->frames);
    80204f22:	fd843783          	ld	a5,-40(s0)
    80204f26:	07a1                	addi	a5,a5,8
    80204f28:	853e                	mv	a0,a5
    80204f2a:	2c4030ef          	jal	ra,802081ee <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:19
}
    80204f2e:	0001                	nop
    80204f30:	70a2                	ld	ra,40(sp)
    80204f32:	7402                	ld	s0,32(sp)
    80204f34:	6145                	addi	sp,sp,48
    80204f36:	8082                	ret

0000000080204f38 <page_table_from_token>:
page_table_from_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:21

void page_table_from_token(PageTable *pt, uint64_t satp) {
    80204f38:	1101                	addi	sp,sp,-32
    80204f3a:	ec22                	sd	s0,24(sp)
    80204f3c:	1000                	addi	s0,sp,32
    80204f3e:	fea43423          	sd	a0,-24(s0)
    80204f42:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:22
  pt->root_ppn = (PhysPageNum)(satp & ((1L << 44) - 1));
    80204f46:	fe043703          	ld	a4,-32(s0)
    80204f4a:	57fd                	li	a5,-1
    80204f4c:	83d1                	srli	a5,a5,0x14
    80204f4e:	8f7d                	and	a4,a4,a5
    80204f50:	fe843783          	ld	a5,-24(s0)
    80204f54:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:23
}
    80204f56:	0001                	nop
    80204f58:	6462                	ld	s0,24(sp)
    80204f5a:	6105                	addi	sp,sp,32
    80204f5c:	8082                	ret

0000000080204f5e <page_table_find_pte_create>:
page_table_find_pte_create():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:25

PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn) {
    80204f5e:	711d                	addi	sp,sp,-96
    80204f60:	ec86                	sd	ra,88(sp)
    80204f62:	e8a2                	sd	s0,80(sp)
    80204f64:	1080                	addi	s0,sp,96
    80204f66:	faa43423          	sd	a0,-88(s0)
    80204f6a:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:27
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    80204f6e:	fb840793          	addi	a5,s0,-72
    80204f72:	85be                	mv	a1,a5
    80204f74:	fa043503          	ld	a0,-96(s0)
    80204f78:	bfbff0ef          	jal	ra,80204b72 <vpn_indexes>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:28
  PhysPageNum ppn = pt->root_ppn;
    80204f7c:	fa843783          	ld	a5,-88(s0)
    80204f80:	639c                	ld	a5,0(a5)
    80204f82:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:29
  PageTableEntry *result = NULL;
    80204f86:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30
  for (unsigned i = 0; i < 3; i++) {
    80204f8a:	fc042e23          	sw	zero,-36(s0)
    80204f8e:	a869                	j	80205028 <page_table_find_pte_create+0xca>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:31
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    80204f90:	fe843503          	ld	a0,-24(s0)
    80204f94:	c33ff0ef          	jal	ra,80204bc6 <ppn_get_pte_array>
    80204f98:	872a                	mv	a4,a0
    80204f9a:	fdc46783          	lwu	a5,-36(s0)
    80204f9e:	078e                	slli	a5,a5,0x3
    80204fa0:	ff040693          	addi	a3,s0,-16
    80204fa4:	97b6                	add	a5,a5,a3
    80204fa6:	fc87b783          	ld	a5,-56(a5)
    80204faa:	078e                	slli	a5,a5,0x3
    80204fac:	97ba                	add	a5,a5,a4
    80204fae:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:32
    if (i == 2) {
    80204fb2:	fdc42783          	lw	a5,-36(s0)
    80204fb6:	0007871b          	sext.w	a4,a5
    80204fba:	4789                	li	a5,2
    80204fbc:	00f71763          	bne	a4,a5,80204fca <page_table_find_pte_create+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:33
      result = pte;
    80204fc0:	fd043783          	ld	a5,-48(s0)
    80204fc4:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:34
      break;
    80204fc8:	a0bd                	j	80205036 <page_table_find_pte_create+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:36
    }
    if (!pte_is_valid(*pte)) {
    80204fca:	fd043783          	ld	a5,-48(s0)
    80204fce:	639c                	ld	a5,0(a5)
    80204fd0:	8b85                	andi	a5,a5,1
    80204fd2:	ef85                	bnez	a5,8020500a <page_table_find_pte_create+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:37
      PhysPageNum frame = frame_alloc();
    80204fd4:	c9bff0ef          	jal	ra,80204c6e <frame_alloc>
    80204fd8:	87aa                	mv	a5,a0
    80204fda:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:38
      if (!frame) {
    80204fde:	fb043783          	ld	a5,-80(s0)
    80204fe2:	e399                	bnez	a5,80204fe8 <page_table_find_pte_create+0x8a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:39
        return NULL;
    80204fe4:	4781                	li	a5,0
    80204fe6:	a891                	j	8020503a <page_table_find_pte_create+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:41
      }
      *pte = pte_new(frame, PTE_V);
    80204fe8:	fb043783          	ld	a5,-80(s0)
    80204fec:	07aa                	slli	a5,a5,0xa
    80204fee:	0017e713          	ori	a4,a5,1
    80204ff2:	fd043783          	ld	a5,-48(s0)
    80204ff6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:42
      vector_push(&pt->frames, &frame);
    80204ff8:	fa843783          	ld	a5,-88(s0)
    80204ffc:	07a1                	addi	a5,a5,8
    80204ffe:	fb040713          	addi	a4,s0,-80
    80205002:	85ba                	mv	a1,a4
    80205004:	853e                	mv	a0,a5
    80205006:	066030ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:44 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    8020500a:	fd043783          	ld	a5,-48(s0)
    8020500e:	639c                	ld	a5,0(a5)
    80205010:	00a7d713          	srli	a4,a5,0xa
    80205014:	57fd                	li	a5,-1
    80205016:	83d1                	srli	a5,a5,0x14
    80205018:	8ff9                	and	a5,a5,a4
    8020501a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) {
    8020501e:	fdc42783          	lw	a5,-36(s0)
    80205022:	2785                	addiw	a5,a5,1
    80205024:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30 (discriminator 1)
    80205028:	fdc42783          	lw	a5,-36(s0)
    8020502c:	0007871b          	sext.w	a4,a5
    80205030:	4789                	li	a5,2
    80205032:	f4e7ffe3          	bgeu	a5,a4,80204f90 <page_table_find_pte_create+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:46
  }
  return result;
    80205036:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:47 (discriminator 1)
}
    8020503a:	853e                	mv	a0,a5
    8020503c:	60e6                	ld	ra,88(sp)
    8020503e:	6446                	ld	s0,80(sp)
    80205040:	6125                	addi	sp,sp,96
    80205042:	8082                	ret

0000000080205044 <page_table_find_pte>:
page_table_find_pte():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:49

PageTableEntry *page_table_find_pte(PageTable *pt, VirtPageNum vpn) {
    80205044:	711d                	addi	sp,sp,-96
    80205046:	ec86                	sd	ra,88(sp)
    80205048:	e8a2                	sd	s0,80(sp)
    8020504a:	1080                	addi	s0,sp,96
    8020504c:	faa43423          	sd	a0,-88(s0)
    80205050:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:51
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    80205054:	fb840793          	addi	a5,s0,-72
    80205058:	85be                	mv	a1,a5
    8020505a:	fa043503          	ld	a0,-96(s0)
    8020505e:	b15ff0ef          	jal	ra,80204b72 <vpn_indexes>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:52
  PhysPageNum ppn = pt->root_ppn;
    80205062:	fa843783          	ld	a5,-88(s0)
    80205066:	639c                	ld	a5,0(a5)
    80205068:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:53
  PageTableEntry *result = NULL;
    8020506c:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55
  PageTableEntry *pte;
  for (unsigned i = 0; i < 3; i++) {
    80205070:	fc042e23          	sw	zero,-36(s0)
    80205074:	a0a5                	j	802050dc <page_table_find_pte+0x98>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:56
    pte = ppn_get_pte_array(ppn) + idxs[i];
    80205076:	fe843503          	ld	a0,-24(s0)
    8020507a:	b4dff0ef          	jal	ra,80204bc6 <ppn_get_pte_array>
    8020507e:	872a                	mv	a4,a0
    80205080:	fdc46783          	lwu	a5,-36(s0)
    80205084:	078e                	slli	a5,a5,0x3
    80205086:	ff040693          	addi	a3,s0,-16
    8020508a:	97b6                	add	a5,a5,a3
    8020508c:	fc87b783          	ld	a5,-56(a5)
    80205090:	078e                	slli	a5,a5,0x3
    80205092:	97ba                	add	a5,a5,a4
    80205094:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:57
    if (!pte_is_valid(*pte)) {
    80205098:	fd043783          	ld	a5,-48(s0)
    8020509c:	639c                	ld	a5,0(a5)
    8020509e:	8b85                	andi	a5,a5,1
    802050a0:	e399                	bnez	a5,802050a6 <page_table_find_pte+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:58
      return NULL;
    802050a2:	4781                	li	a5,0
    802050a4:	a0a9                	j	802050ee <page_table_find_pte+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:60
    }
    if (i == 2) {
    802050a6:	fdc42783          	lw	a5,-36(s0)
    802050aa:	0007871b          	sext.w	a4,a5
    802050ae:	4789                	li	a5,2
    802050b0:	00f71763          	bne	a4,a5,802050be <page_table_find_pte+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:61
      result = pte;
    802050b4:	fd043783          	ld	a5,-48(s0)
    802050b8:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:62
      break;
    802050bc:	a03d                	j	802050ea <page_table_find_pte+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:64 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    802050be:	fd043783          	ld	a5,-48(s0)
    802050c2:	639c                	ld	a5,0(a5)
    802050c4:	00a7d713          	srli	a4,a5,0xa
    802050c8:	57fd                	li	a5,-1
    802050ca:	83d1                	srli	a5,a5,0x14
    802050cc:	8ff9                	and	a5,a5,a4
    802050ce:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) {
    802050d2:	fdc42783          	lw	a5,-36(s0)
    802050d6:	2785                	addiw	a5,a5,1
    802050d8:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55 (discriminator 1)
    802050dc:	fdc42783          	lw	a5,-36(s0)
    802050e0:	0007871b          	sext.w	a4,a5
    802050e4:	4789                	li	a5,2
    802050e6:	f8e7f8e3          	bgeu	a5,a4,80205076 <page_table_find_pte+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:66
  }
  return result;
    802050ea:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:67 (discriminator 1)
}
    802050ee:	853e                	mv	a0,a5
    802050f0:	60e6                	ld	ra,88(sp)
    802050f2:	6446                	ld	s0,80(sp)
    802050f4:	6125                	addi	sp,sp,96
    802050f6:	8082                	ret

00000000802050f8 <page_table_map>:
page_table_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:70

void page_table_map(PageTable *pt, VirtPageNum vpn, PhysPageNum ppn,
                    PTEFlags flags) {
    802050f8:	7139                	addi	sp,sp,-64
    802050fa:	fc06                	sd	ra,56(sp)
    802050fc:	f822                	sd	s0,48(sp)
    802050fe:	0080                	addi	s0,sp,64
    80205100:	fca43c23          	sd	a0,-40(s0)
    80205104:	fcb43823          	sd	a1,-48(s0)
    80205108:	fcc43423          	sd	a2,-56(s0)
    8020510c:	87b6                	mv	a5,a3
    8020510e:	fcf403a3          	sb	a5,-57(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:71
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80205112:	fd043583          	ld	a1,-48(s0)
    80205116:	fd843503          	ld	a0,-40(s0)
    8020511a:	e45ff0ef          	jal	ra,80204f5e <page_table_find_pte_create>
    8020511e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:72
  if (pte_is_valid(*pte)) {
    80205122:	fe843783          	ld	a5,-24(s0)
    80205126:	639c                	ld	a5,0(a5)
    80205128:	8b85                	andi	a5,a5,1
    8020512a:	cf89                	beqz	a5,80205144 <page_table_map+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:73
    panic("VPN 0x is mapped before mapping.\n");
    8020512c:	00004617          	auipc	a2,0x4
    80205130:	26c60613          	addi	a2,a2,620 # 80209398 <MMIO+0x10>
    80205134:	04900593          	li	a1,73
    80205138:	00004517          	auipc	a0,0x4
    8020513c:	28850513          	addi	a0,a0,648 # 802093c0 <MMIO+0x38>
    80205140:	558010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:75
  }
  *pte = pte_new(ppn, flags | PTE_V);
    80205144:	fc843783          	ld	a5,-56(s0)
    80205148:	00a79713          	slli	a4,a5,0xa
    8020514c:	fc744783          	lbu	a5,-57(s0)
    80205150:	8fd9                	or	a5,a5,a4
    80205152:	0017e713          	ori	a4,a5,1
    80205156:	fe843783          	ld	a5,-24(s0)
    8020515a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:76
}
    8020515c:	0001                	nop
    8020515e:	70e2                	ld	ra,56(sp)
    80205160:	7442                	ld	s0,48(sp)
    80205162:	6121                	addi	sp,sp,64
    80205164:	8082                	ret

0000000080205166 <page_table_unmap>:
page_table_unmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:78

void page_table_unmap(PageTable *pt, VirtPageNum vpn) {
    80205166:	7179                	addi	sp,sp,-48
    80205168:	f406                	sd	ra,40(sp)
    8020516a:	f022                	sd	s0,32(sp)
    8020516c:	1800                	addi	s0,sp,48
    8020516e:	fca43c23          	sd	a0,-40(s0)
    80205172:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:79
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80205176:	fd043583          	ld	a1,-48(s0)
    8020517a:	fd843503          	ld	a0,-40(s0)
    8020517e:	de1ff0ef          	jal	ra,80204f5e <page_table_find_pte_create>
    80205182:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:80
  if (!pte_is_valid(*pte)) {
    80205186:	fe843783          	ld	a5,-24(s0)
    8020518a:	639c                	ld	a5,0(a5)
    8020518c:	8b85                	andi	a5,a5,1
    8020518e:	ef89                	bnez	a5,802051a8 <page_table_unmap+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:81 (discriminator 1)
    ASSERT(0);
    80205190:	00004617          	auipc	a2,0x4
    80205194:	25060613          	addi	a2,a2,592 # 802093e0 <MMIO+0x58>
    80205198:	05100593          	li	a1,81
    8020519c:	00004517          	auipc	a0,0x4
    802051a0:	22450513          	addi	a0,a0,548 # 802093c0 <MMIO+0x38>
    802051a4:	4f4010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:83
  }
  *pte = pte_empty();
    802051a8:	fe843783          	ld	a5,-24(s0)
    802051ac:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:84
}
    802051b0:	0001                	nop
    802051b2:	70a2                	ld	ra,40(sp)
    802051b4:	7402                	ld	s0,32(sp)
    802051b6:	6145                	addi	sp,sp,48
    802051b8:	8082                	ret

00000000802051ba <page_table_translate>:
page_table_translate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:86

PageTableEntry *page_table_translate(PageTable *pt, VirtPageNum vpn) {
    802051ba:	7179                	addi	sp,sp,-48
    802051bc:	f406                	sd	ra,40(sp)
    802051be:	f022                	sd	s0,32(sp)
    802051c0:	1800                	addi	s0,sp,48
    802051c2:	fca43c23          	sd	a0,-40(s0)
    802051c6:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:87
  PageTableEntry *pte = page_table_find_pte(pt, vpn);
    802051ca:	fd043583          	ld	a1,-48(s0)
    802051ce:	fd843503          	ld	a0,-40(s0)
    802051d2:	e73ff0ef          	jal	ra,80205044 <page_table_find_pte>
    802051d6:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:88
  if (pte == NULL) {
    802051da:	fe843783          	ld	a5,-24(s0)
    802051de:	ef89                	bnez	a5,802051f8 <page_table_translate+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:89 (discriminator 1)
    ASSERT(0);
    802051e0:	00004617          	auipc	a2,0x4
    802051e4:	20060613          	addi	a2,a2,512 # 802093e0 <MMIO+0x58>
    802051e8:	05900593          	li	a1,89
    802051ec:	00004517          	auipc	a0,0x4
    802051f0:	1d450513          	addi	a0,a0,468 # 802093c0 <MMIO+0x38>
    802051f4:	4a4010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:91
  }
  return pte;
    802051f8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:92
}
    802051fc:	853e                	mv	a0,a5
    802051fe:	70a2                	ld	ra,40(sp)
    80205200:	7402                	ld	s0,32(sp)
    80205202:	6145                	addi	sp,sp,48
    80205204:	8082                	ret

0000000080205206 <page_table_token>:
page_table_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:94

uint64_t page_table_token(PageTable *pt) { return ((8L << 60) | pt->root_ppn); }
    80205206:	1101                	addi	sp,sp,-32
    80205208:	ec22                	sd	s0,24(sp)
    8020520a:	1000                	addi	s0,sp,32
    8020520c:	fea43423          	sd	a0,-24(s0)
    80205210:	fe843783          	ld	a5,-24(s0)
    80205214:	6398                	ld	a4,0(a5)
    80205216:	57fd                	li	a5,-1
    80205218:	17fe                	slli	a5,a5,0x3f
    8020521a:	8fd9                	or	a5,a5,a4
    8020521c:	853e                	mv	a0,a5
    8020521e:	6462                	ld	s0,24(sp)
    80205220:	6105                	addi	sp,sp,32
    80205222:	8082                	ret

0000000080205224 <copy_byte_buffer>:
copy_byte_buffer():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:97

int64_t copy_byte_buffer(uint64_t token, uint8_t *kernel, uint8_t *user,
                         uint64_t len, uint64_t direction) {
    80205224:	7171                	addi	sp,sp,-176
    80205226:	f506                	sd	ra,168(sp)
    80205228:	f122                	sd	s0,160(sp)
    8020522a:	1900                	addi	s0,sp,176
    8020522c:	f6a43c23          	sd	a0,-136(s0)
    80205230:	f6b43823          	sd	a1,-144(s0)
    80205234:	f6c43423          	sd	a2,-152(s0)
    80205238:	f6d43023          	sd	a3,-160(s0)
    8020523c:	f4e43c23          	sd	a4,-168(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:98
  if (direction != FROM_USER && direction != TO_USER) {
    80205240:	f5843783          	ld	a5,-168(s0)
    80205244:	c395                	beqz	a5,80205268 <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:98 (discriminator 1)
    80205246:	f5843703          	ld	a4,-168(s0)
    8020524a:	4785                	li	a5,1
    8020524c:	00f70e63          	beq	a4,a5,80205268 <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:99
    panic("Unknown direction in copy_byte_buffer.\n");
    80205250:	00004617          	auipc	a2,0x4
    80205254:	1a860613          	addi	a2,a2,424 # 802093f8 <MMIO+0x70>
    80205258:	06300593          	li	a1,99
    8020525c:	00004517          	auipc	a0,0x4
    80205260:	16450513          	addi	a0,a0,356 # 802093c0 <MMIO+0x38>
    80205264:	434010ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:101
  }
  if (len == 0) {
    80205268:	f6043783          	ld	a5,-160(s0)
    8020526c:	e399                	bnez	a5,80205272 <copy_byte_buffer+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:102
    return 0;
    8020526e:	4781                	li	a5,0
    80205270:	a439                	j	8020547e <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:106
  }

  PageTable page_table;
  page_table_from_token(&page_table, token);
    80205272:	f8040793          	addi	a5,s0,-128
    80205276:	f7843583          	ld	a1,-136(s0)
    8020527a:	853e                	mv	a0,a5
    8020527c:	cbdff0ef          	jal	ra,80204f38 <page_table_from_token>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:107
  uint64_t start = (uint64_t)user;
    80205280:	f6843783          	ld	a5,-152(s0)
    80205284:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:108
  uint64_t end = start + len;
    80205288:	fe843703          	ld	a4,-24(s0)
    8020528c:	f6043783          	ld	a5,-160(s0)
    80205290:	97ba                	add	a5,a5,a4
    80205292:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:109
  uint64_t kernel_i = 0;
    80205296:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:117
  VirtPageNum vpn;
  PhysPageNum ppn;
  PageTableEntry *pte_ptr;
  uint8_t *bytes_array;

  while (start < end) {
    8020529a:	aad1                	j	8020546e <copy_byte_buffer+0x24a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:118
    start_va = (VirtAddr)start;
    8020529c:	fe843783          	ld	a5,-24(s0)
    802052a0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:119
    vpn = page_floor(start_va);
    802052a4:	fc843783          	ld	a5,-56(s0)
    802052a8:	83b1                	srli	a5,a5,0xc
    802052aa:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:120
    pte_ptr = page_table_translate(&page_table, vpn);
    802052ae:	f8040793          	addi	a5,s0,-128
    802052b2:	fc043583          	ld	a1,-64(s0)
    802052b6:	853e                	mv	a0,a5
    802052b8:	f03ff0ef          	jal	ra,802051ba <page_table_translate>
    802052bc:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:121
    if (pte_ptr == NULL) {
    802052c0:	fb843783          	ld	a5,-72(s0)
    802052c4:	e399                	bnez	a5,802052ca <copy_byte_buffer+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:122
      return -1;
    802052c6:	57fd                	li	a5,-1
    802052c8:	aa5d                	j	8020547e <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:124
    }
    ppn = pte_ppn(*pte_ptr);
    802052ca:	fb843783          	ld	a5,-72(s0)
    802052ce:	639c                	ld	a5,0(a5)
    802052d0:	00a7d713          	srli	a4,a5,0xa
    802052d4:	57fd                	li	a5,-1
    802052d6:	83d1                	srli	a5,a5,0x14
    802052d8:	8ff9                	and	a5,a5,a4
    802052da:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:125
    vpn++;
    802052de:	fc043783          	ld	a5,-64(s0)
    802052e2:	0785                	addi	a5,a5,1
    802052e4:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:126
    end_va = (VirtAddr)pn2addr(vpn);
    802052e8:	fc043783          	ld	a5,-64(s0)
    802052ec:	07b2                	slli	a5,a5,0xc
    802052ee:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:127
    if ((VirtAddr)end < end_va) {
    802052f2:	fd043703          	ld	a4,-48(s0)
    802052f6:	fd843783          	ld	a5,-40(s0)
    802052fa:	00f77663          	bgeu	a4,a5,80205306 <copy_byte_buffer+0xe2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:128
      end_va = (VirtAddr)end;
    802052fe:	fd043783          	ld	a5,-48(s0)
    80205302:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:130
    }
    bytes_array = ppn_get_bytes_array(ppn);
    80205306:	fb043503          	ld	a0,-80(s0)
    8020530a:	8ddff0ef          	jal	ra,80204be6 <ppn_get_bytes_array>
    8020530e:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:131
    if (page_aligned(end_va)) {
    80205312:	fd843703          	ld	a4,-40(s0)
    80205316:	6785                	lui	a5,0x1
    80205318:	17fd                	addi	a5,a5,-1
    8020531a:	8ff9                	and	a5,a5,a4
    8020531c:	e3d1                	bnez	a5,802053a0 <copy_byte_buffer+0x17c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:132
      if (direction == FROM_USER)
    8020531e:	f5843783          	ld	a5,-168(s0)
    80205322:	eb95                	bnez	a5,80205356 <copy_byte_buffer+0x132>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:133
        memcpy(kernel + kernel_i, bytes_array,
    80205324:	f7043703          	ld	a4,-144(s0)
    80205328:	fe043783          	ld	a5,-32(s0)
    8020532c:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:134
               PAGE_SIZE - page_offset(start_va));
    80205330:	fc843783          	ld	a5,-56(s0)
    80205334:	2781                	sext.w	a5,a5
    80205336:	873e                	mv	a4,a5
    80205338:	6785                	lui	a5,0x1
    8020533a:	17fd                	addi	a5,a5,-1
    8020533c:	8ff9                	and	a5,a5,a4
    8020533e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:133
        memcpy(kernel + kernel_i, bytes_array,
    80205340:	6705                	lui	a4,0x1
    80205342:	40f707bb          	subw	a5,a4,a5
    80205346:	2781                	sext.w	a5,a5
    80205348:	863e                	mv	a2,a5
    8020534a:	fa843583          	ld	a1,-88(s0)
    8020534e:	8536                	mv	a0,a3
    80205350:	bf2fe0ef          	jal	ra,80203742 <memcpy>
    80205354:	a80d                	j	80205386 <copy_byte_buffer+0x162>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:136
      else
        memcpy(bytes_array, kernel + kernel_i,
    80205356:	f7043703          	ld	a4,-144(s0)
    8020535a:	fe043783          	ld	a5,-32(s0)
    8020535e:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:137
               PAGE_SIZE - page_offset(start_va));
    80205362:	fc843783          	ld	a5,-56(s0)
    80205366:	2781                	sext.w	a5,a5
    80205368:	873e                	mv	a4,a5
    8020536a:	6785                	lui	a5,0x1
    8020536c:	17fd                	addi	a5,a5,-1
    8020536e:	8ff9                	and	a5,a5,a4
    80205370:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:136
        memcpy(bytes_array, kernel + kernel_i,
    80205372:	6705                	lui	a4,0x1
    80205374:	40f707bb          	subw	a5,a4,a5
    80205378:	2781                	sext.w	a5,a5
    8020537a:	863e                	mv	a2,a5
    8020537c:	85b6                	mv	a1,a3
    8020537e:	fa843503          	ld	a0,-88(s0)
    80205382:	bc0fe0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:138
      kernel_i += PAGE_SIZE - page_offset(start_va);
    80205386:	fc843703          	ld	a4,-56(s0)
    8020538a:	6785                	lui	a5,0x1
    8020538c:	17fd                	addi	a5,a5,-1
    8020538e:	8ff9                	and	a5,a5,a4
    80205390:	fe043703          	ld	a4,-32(s0)
    80205394:	8f1d                	sub	a4,a4,a5
    80205396:	6785                	lui	a5,0x1
    80205398:	97ba                	add	a5,a5,a4
    8020539a:	fef43023          	sd	a5,-32(s0)
    8020539e:	a0e1                	j	80205466 <copy_byte_buffer+0x242>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:140
    } else {
      if (direction == FROM_USER)
    802053a0:	f5843783          	ld	a5,-168(s0)
    802053a4:	eba9                	bnez	a5,802053f6 <copy_byte_buffer+0x1d2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:141
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    802053a6:	f7043703          	ld	a4,-144(s0)
    802053aa:	fe043783          	ld	a5,-32(s0)
    802053ae:	00f706b3          	add	a3,a4,a5
    802053b2:	fc843703          	ld	a4,-56(s0)
    802053b6:	6785                	lui	a5,0x1
    802053b8:	17fd                	addi	a5,a5,-1
    802053ba:	8ff9                	and	a5,a5,a4
    802053bc:	fa843703          	ld	a4,-88(s0)
    802053c0:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:142
               page_offset(end_va) - page_offset(start_va));
    802053c4:	fd843783          	ld	a5,-40(s0)
    802053c8:	2781                	sext.w	a5,a5
    802053ca:	873e                	mv	a4,a5
    802053cc:	6785                	lui	a5,0x1
    802053ce:	17fd                	addi	a5,a5,-1
    802053d0:	8ff9                	and	a5,a5,a4
    802053d2:	0007871b          	sext.w	a4,a5
    802053d6:	fc843783          	ld	a5,-56(s0)
    802053da:	2781                	sext.w	a5,a5
    802053dc:	863e                	mv	a2,a5
    802053de:	6785                	lui	a5,0x1
    802053e0:	17fd                	addi	a5,a5,-1
    802053e2:	8ff1                	and	a5,a5,a2
    802053e4:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:141
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    802053e6:	40f707bb          	subw	a5,a4,a5
    802053ea:	2781                	sext.w	a5,a5
    802053ec:	863e                	mv	a2,a5
    802053ee:	8536                	mv	a0,a3
    802053f0:	b52fe0ef          	jal	ra,80203742 <memcpy>
    802053f4:	a881                	j	80205444 <copy_byte_buffer+0x220>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:144
      else
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    802053f6:	fc843703          	ld	a4,-56(s0)
    802053fa:	6785                	lui	a5,0x1
    802053fc:	17fd                	addi	a5,a5,-1
    802053fe:	8ff9                	and	a5,a5,a4
    80205400:	fa843703          	ld	a4,-88(s0)
    80205404:	00f706b3          	add	a3,a4,a5
    80205408:	f7043703          	ld	a4,-144(s0)
    8020540c:	fe043783          	ld	a5,-32(s0)
    80205410:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:145
               page_offset(end_va) - page_offset(start_va));
    80205414:	fd843783          	ld	a5,-40(s0)
    80205418:	2781                	sext.w	a5,a5
    8020541a:	873e                	mv	a4,a5
    8020541c:	6785                	lui	a5,0x1
    8020541e:	17fd                	addi	a5,a5,-1
    80205420:	8ff9                	and	a5,a5,a4
    80205422:	0007871b          	sext.w	a4,a5
    80205426:	fc843783          	ld	a5,-56(s0)
    8020542a:	2781                	sext.w	a5,a5
    8020542c:	863e                	mv	a2,a5
    8020542e:	6785                	lui	a5,0x1
    80205430:	17fd                	addi	a5,a5,-1
    80205432:	8ff1                	and	a5,a5,a2
    80205434:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:144
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    80205436:	40f707bb          	subw	a5,a4,a5
    8020543a:	2781                	sext.w	a5,a5
    8020543c:	863e                	mv	a2,a5
    8020543e:	8536                	mv	a0,a3
    80205440:	b02fe0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:146
      kernel_i += page_offset(end_va) - page_offset(start_va);
    80205444:	fd843703          	ld	a4,-40(s0)
    80205448:	6785                	lui	a5,0x1
    8020544a:	17fd                	addi	a5,a5,-1
    8020544c:	8f7d                	and	a4,a4,a5
    8020544e:	fc843683          	ld	a3,-56(s0)
    80205452:	6785                	lui	a5,0x1
    80205454:	17fd                	addi	a5,a5,-1
    80205456:	8ff5                	and	a5,a5,a3
    80205458:	40f707b3          	sub	a5,a4,a5
    8020545c:	fe043703          	ld	a4,-32(s0)
    80205460:	97ba                	add	a5,a5,a4
    80205462:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:148
    }
    start = (uint64_t)end_va;
    80205466:	fd843783          	ld	a5,-40(s0)
    8020546a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:117
  while (start < end) {
    8020546e:	fe843703          	ld	a4,-24(s0)
    80205472:	fd043783          	ld	a5,-48(s0)
    80205476:	e2f763e3          	bltu	a4,a5,8020529c <copy_byte_buffer+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:150
  }
  return len;
    8020547a:	f6043783          	ld	a5,-160(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:151 (discriminator 1)
}
    8020547e:	853e                	mv	a0,a5
    80205480:	70aa                	ld	ra,168(sp)
    80205482:	740a                	ld	s0,160(sp)
    80205484:	614d                	addi	sp,sp,176
    80205486:	8082                	ret

0000000080205488 <mm_init>:
mm_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:4
#include "mem.h"

void mm_init() 
{
    80205488:	1141                	addi	sp,sp,-16
    8020548a:	e406                	sd	ra,8(sp)
    8020548c:	e022                	sd	s0,0(sp)
    8020548e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:5
  heap_allocator_init();
    80205490:	030000ef          	jal	ra,802054c0 <heap_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:6
  frame_allocator_init();
    80205494:	f72ff0ef          	jal	ra,80204c06 <frame_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:7
  memory_set_kernel_init();
    80205498:	a54ff0ef          	jal	ra,802046ec <memory_set_kernel_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:8
  memory_set_remap_test();
    8020549c:	de0ff0ef          	jal	ra,80204a7c <memory_set_remap_test>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:9
}
    802054a0:	0001                	nop
    802054a2:	60a2                	ld	ra,8(sp)
    802054a4:	6402                	ld	s0,0(sp)
    802054a6:	0141                	addi	sp,sp,16
    802054a8:	8082                	ret

00000000802054aa <mm_free>:
mm_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:11

void mm_free() {
    802054aa:	1141                	addi	sp,sp,-16
    802054ac:	e406                	sd	ra,8(sp)
    802054ae:	e022                	sd	s0,0(sp)
    802054b0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:12
  frame_allocator_free();
    802054b2:	f9eff0ef          	jal	ra,80204c50 <frame_allocator_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:13
}
    802054b6:	0001                	nop
    802054b8:	60a2                	ld	ra,8(sp)
    802054ba:	6402                	ld	s0,0(sp)
    802054bc:	0141                	addi	sp,sp,16
    802054be:	8082                	ret

00000000802054c0 <heap_allocator_init>:
heap_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:9
#include "mem.h"
#include "string.h"

static uint8_t HEAP_SPACE[KERNEL_HEAP_SIZE] __attribute__((aligned(4096)));

void heap_allocator_init() {
    802054c0:	1141                	addi	sp,sp,-16
    802054c2:	e406                	sd	ra,8(sp)
    802054c4:	e022                	sd	s0,0(sp)
    802054c6:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:10
  memset(HEAP_SPACE, 0, KERNEL_HEAP_SIZE);
    802054c8:	00300637          	lui	a2,0x300
    802054cc:	4581                	li	a1,0
    802054ce:	0081e517          	auipc	a0,0x81e
    802054d2:	b3250513          	addi	a0,a0,-1230 # 80a23000 <HEAP_SPACE>
    802054d6:	abafe0ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:11
  bd_init(HEAP_SPACE, HEAP_SPACE + KERNEL_HEAP_SIZE);
    802054da:	00b1e797          	auipc	a5,0xb1e
    802054de:	b2678793          	addi	a5,a5,-1242 # 80d23000 <nsizes>
    802054e2:	85be                	mv	a1,a5
    802054e4:	0081e517          	auipc	a0,0x81e
    802054e8:	b1c50513          	addi	a0,a0,-1252 # 80a23000 <HEAP_SPACE>
    802054ec:	3cd000ef          	jal	ra,802060b8 <bd_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:12
}
    802054f0:	0001                	nop
    802054f2:	60a2                	ld	ra,8(sp)
    802054f4:	6402                	ld	s0,0(sp)
    802054f6:	0141                	addi	sp,sp,16
    802054f8:	8082                	ret

00000000802054fa <bit_isset>:
bit_isset():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:38
static Sz_info *bd_sizes;
static void *bd_base; // start address of memory managed by the buddy allocator
// static struct spinlock lock;

// Return 1 if bit at position index in array is set to 1
int bit_isset(char *array, int index) {
    802054fa:	7179                	addi	sp,sp,-48
    802054fc:	f422                	sd	s0,40(sp)
    802054fe:	1800                	addi	s0,sp,48
    80205500:	fca43c23          	sd	a0,-40(s0)
    80205504:	87ae                	mv	a5,a1
    80205506:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:39
  char b = array[index / 8];
    8020550a:	fd442783          	lw	a5,-44(s0)
    8020550e:	41f7d71b          	sraiw	a4,a5,0x1f
    80205512:	01d7571b          	srliw	a4,a4,0x1d
    80205516:	9fb9                	addw	a5,a5,a4
    80205518:	4037d79b          	sraiw	a5,a5,0x3
    8020551c:	2781                	sext.w	a5,a5
    8020551e:	873e                	mv	a4,a5
    80205520:	fd843783          	ld	a5,-40(s0)
    80205524:	97ba                	add	a5,a5,a4
    80205526:	0007c783          	lbu	a5,0(a5)
    8020552a:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:40
  char m = (1 << (index % 8));
    8020552e:	fd442703          	lw	a4,-44(s0)
    80205532:	41f7579b          	sraiw	a5,a4,0x1f
    80205536:	01d7d79b          	srliw	a5,a5,0x1d
    8020553a:	9f3d                	addw	a4,a4,a5
    8020553c:	8b1d                	andi	a4,a4,7
    8020553e:	40f707bb          	subw	a5,a4,a5
    80205542:	2781                	sext.w	a5,a5
    80205544:	4705                	li	a4,1
    80205546:	00f717bb          	sllw	a5,a4,a5
    8020554a:	2781                	sext.w	a5,a5
    8020554c:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:41
  return (b & m) == m;
    80205550:	fef44703          	lbu	a4,-17(s0)
    80205554:	fee44783          	lbu	a5,-18(s0)
    80205558:	8ff9                	and	a5,a5,a4
    8020555a:	0ff7f793          	andi	a5,a5,255
    8020555e:	fee44703          	lbu	a4,-18(s0)
    80205562:	2701                	sext.w	a4,a4
    80205564:	2781                	sext.w	a5,a5
    80205566:	40f707b3          	sub	a5,a4,a5
    8020556a:	0017b793          	seqz	a5,a5
    8020556e:	0ff7f793          	andi	a5,a5,255
    80205572:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:42
}
    80205574:	853e                	mv	a0,a5
    80205576:	7422                	ld	s0,40(sp)
    80205578:	6145                	addi	sp,sp,48
    8020557a:	8082                	ret

000000008020557c <bit_set>:
bit_set():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:45

// Set bit at position index in array to 1
void bit_set(char *array, int index) {
    8020557c:	7179                	addi	sp,sp,-48
    8020557e:	f422                	sd	s0,40(sp)
    80205580:	1800                	addi	s0,sp,48
    80205582:	fca43c23          	sd	a0,-40(s0)
    80205586:	87ae                	mv	a5,a1
    80205588:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:46
  char b = array[index / 8];
    8020558c:	fd442783          	lw	a5,-44(s0)
    80205590:	41f7d71b          	sraiw	a4,a5,0x1f
    80205594:	01d7571b          	srliw	a4,a4,0x1d
    80205598:	9fb9                	addw	a5,a5,a4
    8020559a:	4037d79b          	sraiw	a5,a5,0x3
    8020559e:	2781                	sext.w	a5,a5
    802055a0:	873e                	mv	a4,a5
    802055a2:	fd843783          	ld	a5,-40(s0)
    802055a6:	97ba                	add	a5,a5,a4
    802055a8:	0007c783          	lbu	a5,0(a5)
    802055ac:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:47
  char m = (1 << (index % 8));
    802055b0:	fd442703          	lw	a4,-44(s0)
    802055b4:	41f7579b          	sraiw	a5,a4,0x1f
    802055b8:	01d7d79b          	srliw	a5,a5,0x1d
    802055bc:	9f3d                	addw	a4,a4,a5
    802055be:	8b1d                	andi	a4,a4,7
    802055c0:	40f707bb          	subw	a5,a4,a5
    802055c4:	2781                	sext.w	a5,a5
    802055c6:	4705                	li	a4,1
    802055c8:	00f717bb          	sllw	a5,a4,a5
    802055cc:	2781                	sext.w	a5,a5
    802055ce:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:48
  array[index / 8] = (b | m);
    802055d2:	fd442783          	lw	a5,-44(s0)
    802055d6:	41f7d71b          	sraiw	a4,a5,0x1f
    802055da:	01d7571b          	srliw	a4,a4,0x1d
    802055de:	9fb9                	addw	a5,a5,a4
    802055e0:	4037d79b          	sraiw	a5,a5,0x3
    802055e4:	2781                	sext.w	a5,a5
    802055e6:	873e                	mv	a4,a5
    802055e8:	fd843783          	ld	a5,-40(s0)
    802055ec:	97ba                	add	a5,a5,a4
    802055ee:	fef44683          	lbu	a3,-17(s0)
    802055f2:	fee44703          	lbu	a4,-18(s0)
    802055f6:	8f55                	or	a4,a4,a3
    802055f8:	0ff77713          	andi	a4,a4,255
    802055fc:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:49
}
    80205600:	0001                	nop
    80205602:	7422                	ld	s0,40(sp)
    80205604:	6145                	addi	sp,sp,48
    80205606:	8082                	ret

0000000080205608 <bit_clear>:
bit_clear():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:52

// Clear bit at position index in array
void bit_clear(char *array, int index) {
    80205608:	7179                	addi	sp,sp,-48
    8020560a:	f422                	sd	s0,40(sp)
    8020560c:	1800                	addi	s0,sp,48
    8020560e:	fca43c23          	sd	a0,-40(s0)
    80205612:	87ae                	mv	a5,a1
    80205614:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:53
  char b = array[index / 8];
    80205618:	fd442783          	lw	a5,-44(s0)
    8020561c:	41f7d71b          	sraiw	a4,a5,0x1f
    80205620:	01d7571b          	srliw	a4,a4,0x1d
    80205624:	9fb9                	addw	a5,a5,a4
    80205626:	4037d79b          	sraiw	a5,a5,0x3
    8020562a:	2781                	sext.w	a5,a5
    8020562c:	873e                	mv	a4,a5
    8020562e:	fd843783          	ld	a5,-40(s0)
    80205632:	97ba                	add	a5,a5,a4
    80205634:	0007c783          	lbu	a5,0(a5)
    80205638:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:54
  char m = (1 << (index % 8));
    8020563c:	fd442703          	lw	a4,-44(s0)
    80205640:	41f7579b          	sraiw	a5,a4,0x1f
    80205644:	01d7d79b          	srliw	a5,a5,0x1d
    80205648:	9f3d                	addw	a4,a4,a5
    8020564a:	8b1d                	andi	a4,a4,7
    8020564c:	40f707bb          	subw	a5,a4,a5
    80205650:	2781                	sext.w	a5,a5
    80205652:	4705                	li	a4,1
    80205654:	00f717bb          	sllw	a5,a4,a5
    80205658:	2781                	sext.w	a5,a5
    8020565a:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:55
  array[index / 8] = (b & ~m);
    8020565e:	fee40783          	lb	a5,-18(s0)
    80205662:	fff7c793          	not	a5,a5
    80205666:	0187971b          	slliw	a4,a5,0x18
    8020566a:	4187571b          	sraiw	a4,a4,0x18
    8020566e:	fef40783          	lb	a5,-17(s0)
    80205672:	8ff9                	and	a5,a5,a4
    80205674:	0187969b          	slliw	a3,a5,0x18
    80205678:	4186d69b          	sraiw	a3,a3,0x18
    8020567c:	fd442783          	lw	a5,-44(s0)
    80205680:	41f7d71b          	sraiw	a4,a5,0x1f
    80205684:	01d7571b          	srliw	a4,a4,0x1d
    80205688:	9fb9                	addw	a5,a5,a4
    8020568a:	4037d79b          	sraiw	a5,a5,0x3
    8020568e:	2781                	sext.w	a5,a5
    80205690:	873e                	mv	a4,a5
    80205692:	fd843783          	ld	a5,-40(s0)
    80205696:	97ba                	add	a5,a5,a4
    80205698:	0ff6f713          	andi	a4,a3,255
    8020569c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:56
}
    802056a0:	0001                	nop
    802056a2:	7422                	ld	s0,40(sp)
    802056a4:	6145                	addi	sp,sp,48
    802056a6:	8082                	ret

00000000802056a8 <bd_print_vector>:
bd_print_vector():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:59

// Print a bit vector as a list of ranges of 1 bits
void bd_print_vector(char *vector, int len) {
    802056a8:	7179                	addi	sp,sp,-48
    802056aa:	f406                	sd	ra,40(sp)
    802056ac:	f022                	sd	s0,32(sp)
    802056ae:	1800                	addi	s0,sp,48
    802056b0:	fca43c23          	sd	a0,-40(s0)
    802056b4:	87ae                	mv	a5,a1
    802056b6:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:62
  int last, lb;

  last = 1;
    802056ba:	4785                	li	a5,1
    802056bc:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:63
  lb = 0;
    802056c0:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64
  for (int b = 0; b < len; b++) {
    802056c4:	fe042423          	sw	zero,-24(s0)
    802056c8:	a0a1                	j	80205710 <bd_print_vector+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:65
    if (last == bit_isset(vector, b))
    802056ca:	fe842783          	lw	a5,-24(s0)
    802056ce:	85be                	mv	a1,a5
    802056d0:	fd843503          	ld	a0,-40(s0)
    802056d4:	e27ff0ef          	jal	ra,802054fa <bit_isset>
    802056d8:	87aa                	mv	a5,a0
    802056da:	873e                	mv	a4,a5
    802056dc:	fec42783          	lw	a5,-20(s0)
    802056e0:	2781                	sext.w	a5,a5
    802056e2:	02e78163          	beq	a5,a4,80205704 <bd_print_vector+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:67
      continue;
    lb = b;
    802056e6:	fe842783          	lw	a5,-24(s0)
    802056ea:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:68
    last = bit_isset(vector, b);
    802056ee:	fe842783          	lw	a5,-24(s0)
    802056f2:	85be                	mv	a1,a5
    802056f4:	fd843503          	ld	a0,-40(s0)
    802056f8:	e03ff0ef          	jal	ra,802054fa <bit_isset>
    802056fc:	87aa                	mv	a5,a0
    802056fe:	fef42623          	sw	a5,-20(s0)
    80205702:	a011                	j	80205706 <bd_print_vector+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:66
      continue;
    80205704:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64 (discriminator 2)
  for (int b = 0; b < len; b++) {
    80205706:	fe842783          	lw	a5,-24(s0)
    8020570a:	2785                	addiw	a5,a5,1
    8020570c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64 (discriminator 1)
    80205710:	fe842703          	lw	a4,-24(s0)
    80205714:	fd442783          	lw	a5,-44(s0)
    80205718:	2701                	sext.w	a4,a4
    8020571a:	2781                	sext.w	a5,a5
    8020571c:	faf747e3          	blt	a4,a5,802056ca <bd_print_vector+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:72
  }
  if (lb == 0 || last == 1) {
  }
}
    80205720:	0001                	nop
    80205722:	0001                	nop
    80205724:	70a2                	ld	ra,40(sp)
    80205726:	7402                	ld	s0,32(sp)
    80205728:	6145                	addi	sp,sp,48
    8020572a:	8082                	ret

000000008020572c <bd_print>:
bd_print():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:75

// Print buddy's data structures
void bd_print() {
    8020572c:	1101                	addi	sp,sp,-32
    8020572e:	ec06                	sd	ra,24(sp)
    80205730:	e822                	sd	s0,16(sp)
    80205732:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76
  for (int k = 0; k < nsizes; k++) {
    80205734:	fe042623          	sw	zero,-20(s0)
    80205738:	a06d                	j	802057e2 <bd_print+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:77
    lst_print(&bd_sizes[k].free);
    8020573a:	00b1e797          	auipc	a5,0xb1e
    8020573e:	8ce78793          	addi	a5,a5,-1842 # 80d23008 <bd_sizes>
    80205742:	6398                	ld	a4,0(a5)
    80205744:	fec42783          	lw	a5,-20(s0)
    80205748:	0796                	slli	a5,a5,0x5
    8020574a:	97ba                	add	a5,a5,a4
    8020574c:	853e                	mv	a0,a5
    8020574e:	079020ef          	jal	ra,80207fc6 <lst_print>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:78
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80205752:	00b1e797          	auipc	a5,0xb1e
    80205756:	8b678793          	addi	a5,a5,-1866 # 80d23008 <bd_sizes>
    8020575a:	6398                	ld	a4,0(a5)
    8020575c:	fec42783          	lw	a5,-20(s0)
    80205760:	0796                	slli	a5,a5,0x5
    80205762:	97ba                	add	a5,a5,a4
    80205764:	6b94                	ld	a3,16(a5)
    80205766:	00b1e797          	auipc	a5,0xb1e
    8020576a:	89a78793          	addi	a5,a5,-1894 # 80d23000 <nsizes>
    8020576e:	439c                	lw	a5,0(a5)
    80205770:	37fd                	addiw	a5,a5,-1
    80205772:	0007871b          	sext.w	a4,a5
    80205776:	fec42783          	lw	a5,-20(s0)
    8020577a:	40f707bb          	subw	a5,a4,a5
    8020577e:	2781                	sext.w	a5,a5
    80205780:	4705                	li	a4,1
    80205782:	00f717bb          	sllw	a5,a4,a5
    80205786:	2781                	sext.w	a5,a5
    80205788:	85be                	mv	a1,a5
    8020578a:	8536                	mv	a0,a3
    8020578c:	f1dff0ef          	jal	ra,802056a8 <bd_print_vector>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:79
    if (k > 0) {
    80205790:	fec42783          	lw	a5,-20(s0)
    80205794:	2781                	sext.w	a5,a5
    80205796:	04f05163          	blez	a5,802057d8 <bd_print+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:80
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    8020579a:	00b1e797          	auipc	a5,0xb1e
    8020579e:	86e78793          	addi	a5,a5,-1938 # 80d23008 <bd_sizes>
    802057a2:	6398                	ld	a4,0(a5)
    802057a4:	fec42783          	lw	a5,-20(s0)
    802057a8:	0796                	slli	a5,a5,0x5
    802057aa:	97ba                	add	a5,a5,a4
    802057ac:	6f94                	ld	a3,24(a5)
    802057ae:	00b1e797          	auipc	a5,0xb1e
    802057b2:	85278793          	addi	a5,a5,-1966 # 80d23000 <nsizes>
    802057b6:	439c                	lw	a5,0(a5)
    802057b8:	37fd                	addiw	a5,a5,-1
    802057ba:	0007871b          	sext.w	a4,a5
    802057be:	fec42783          	lw	a5,-20(s0)
    802057c2:	40f707bb          	subw	a5,a4,a5
    802057c6:	2781                	sext.w	a5,a5
    802057c8:	4705                	li	a4,1
    802057ca:	00f717bb          	sllw	a5,a4,a5
    802057ce:	2781                	sext.w	a5,a5
    802057d0:	85be                	mv	a1,a5
    802057d2:	8536                	mv	a0,a3
    802057d4:	ed5ff0ef          	jal	ra,802056a8 <bd_print_vector>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    802057d8:	fec42783          	lw	a5,-20(s0)
    802057dc:	2785                	addiw	a5,a5,1
    802057de:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76 (discriminator 1)
    802057e2:	00b1e797          	auipc	a5,0xb1e
    802057e6:	81e78793          	addi	a5,a5,-2018 # 80d23000 <nsizes>
    802057ea:	4398                	lw	a4,0(a5)
    802057ec:	fec42783          	lw	a5,-20(s0)
    802057f0:	2781                	sext.w	a5,a5
    802057f2:	f4e7c4e3          	blt	a5,a4,8020573a <bd_print+0xe>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:83
    }
  }
}
    802057f6:	0001                	nop
    802057f8:	0001                	nop
    802057fa:	60e2                	ld	ra,24(sp)
    802057fc:	6442                	ld	s0,16(sp)
    802057fe:	6105                	addi	sp,sp,32
    80205800:	8082                	ret

0000000080205802 <firstk>:
firstk():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:86

// What is the first k such that 2^k >= n?
int firstk(uint64_t n) {
    80205802:	7179                	addi	sp,sp,-48
    80205804:	f422                	sd	s0,40(sp)
    80205806:	1800                	addi	s0,sp,48
    80205808:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:87
  int k = 0;
    8020580c:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:88
  uint64_t size = LEAF_SIZE;
    80205810:	47c1                	li	a5,16
    80205812:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:90

  while (size < n) {
    80205816:	a819                	j	8020582c <firstk+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:91
    k++;
    80205818:	fec42783          	lw	a5,-20(s0)
    8020581c:	2785                	addiw	a5,a5,1
    8020581e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:92
    size *= 2;
    80205822:	fe043783          	ld	a5,-32(s0)
    80205826:	0786                	slli	a5,a5,0x1
    80205828:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:90
  while (size < n) {
    8020582c:	fe043703          	ld	a4,-32(s0)
    80205830:	fd843783          	ld	a5,-40(s0)
    80205834:	fef762e3          	bltu	a4,a5,80205818 <firstk+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:94
  }
  return k;
    80205838:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:95
}
    8020583c:	853e                	mv	a0,a5
    8020583e:	7422                	ld	s0,40(sp)
    80205840:	6145                	addi	sp,sp,48
    80205842:	8082                	ret

0000000080205844 <blk_index>:
blk_index():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:98

// Compute the block index for address p at size k
int blk_index(int k, char *p) {
    80205844:	7179                	addi	sp,sp,-48
    80205846:	f422                	sd	s0,40(sp)
    80205848:	1800                	addi	s0,sp,48
    8020584a:	87aa                	mv	a5,a0
    8020584c:	fcb43823          	sd	a1,-48(s0)
    80205850:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:99
  int n = p - (char *)bd_base;
    80205854:	00b1d797          	auipc	a5,0xb1d
    80205858:	7bc78793          	addi	a5,a5,1980 # 80d23010 <bd_base>
    8020585c:	639c                	ld	a5,0(a5)
    8020585e:	fd043703          	ld	a4,-48(s0)
    80205862:	40f707b3          	sub	a5,a4,a5
    80205866:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:100
  return n / BLK_SIZE(k);
    8020586a:	fec42703          	lw	a4,-20(s0)
    8020586e:	fdc42783          	lw	a5,-36(s0)
    80205872:	46c1                	li	a3,16
    80205874:	00f697b3          	sll	a5,a3,a5
    80205878:	02f747b3          	div	a5,a4,a5
    8020587c:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:101
}
    8020587e:	853e                	mv	a0,a5
    80205880:	7422                	ld	s0,40(sp)
    80205882:	6145                	addi	sp,sp,48
    80205884:	8082                	ret

0000000080205886 <addr>:
addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:104

// Convert a block index at size k back into an address
void *addr(int k, int bi) {
    80205886:	7179                	addi	sp,sp,-48
    80205888:	f422                	sd	s0,40(sp)
    8020588a:	1800                	addi	s0,sp,48
    8020588c:	87aa                	mv	a5,a0
    8020588e:	872e                	mv	a4,a1
    80205890:	fcf42e23          	sw	a5,-36(s0)
    80205894:	87ba                	mv	a5,a4
    80205896:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:105
  int n = bi * BLK_SIZE(k);
    8020589a:	fdc42783          	lw	a5,-36(s0)
    8020589e:	4741                	li	a4,16
    802058a0:	00f717b3          	sll	a5,a4,a5
    802058a4:	0007871b          	sext.w	a4,a5
    802058a8:	fd842783          	lw	a5,-40(s0)
    802058ac:	02f707bb          	mulw	a5,a4,a5
    802058b0:	2781                	sext.w	a5,a5
    802058b2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:106
  return (char *)bd_base + n;
    802058b6:	00b1d797          	auipc	a5,0xb1d
    802058ba:	75a78793          	addi	a5,a5,1882 # 80d23010 <bd_base>
    802058be:	6398                	ld	a4,0(a5)
    802058c0:	fec42783          	lw	a5,-20(s0)
    802058c4:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:107
}
    802058c6:	853e                	mv	a0,a5
    802058c8:	7422                	ld	s0,40(sp)
    802058ca:	6145                	addi	sp,sp,48
    802058cc:	8082                	ret

00000000802058ce <bd_malloc>:
bd_malloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:110

// allocate nbytes, but malloc won't return anything smaller than LEAF_SIZE
void *bd_malloc(uint64_t nbytes) {
    802058ce:	715d                	addi	sp,sp,-80
    802058d0:	e486                	sd	ra,72(sp)
    802058d2:	e0a2                	sd	s0,64(sp)
    802058d4:	fc26                	sd	s1,56(sp)
    802058d6:	0880                	addi	s0,sp,80
    802058d8:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:116
  int fk, k;

  // acquire(&lock);

  // Find a free block >= nbytes, starting with smallest k possible
  fk = firstk(nbytes);
    802058dc:	fb843503          	ld	a0,-72(s0)
    802058e0:	f23ff0ef          	jal	ra,80205802 <firstk>
    802058e4:	87aa                	mv	a5,a0
    802058e6:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117
  for (k = fk; k < nsizes; k++) {
    802058ea:	fd842783          	lw	a5,-40(s0)
    802058ee:	fcf42e23          	sw	a5,-36(s0)
    802058f2:	a025                	j	8020591a <bd_malloc+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:118
    if (!lst_empty(&bd_sizes[k].free))
    802058f4:	00b1d797          	auipc	a5,0xb1d
    802058f8:	71478793          	addi	a5,a5,1812 # 80d23008 <bd_sizes>
    802058fc:	6398                	ld	a4,0(a5)
    802058fe:	fdc42783          	lw	a5,-36(s0)
    80205902:	0796                	slli	a5,a5,0x5
    80205904:	97ba                	add	a5,a5,a4
    80205906:	853e                	mv	a0,a5
    80205908:	5cc020ef          	jal	ra,80207ed4 <lst_empty>
    8020590c:	87aa                	mv	a5,a0
    8020590e:	c38d                	beqz	a5,80205930 <bd_malloc+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117 (discriminator 2)
  for (k = fk; k < nsizes; k++) {
    80205910:	fdc42783          	lw	a5,-36(s0)
    80205914:	2785                	addiw	a5,a5,1
    80205916:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117 (discriminator 1)
    8020591a:	00b1d797          	auipc	a5,0xb1d
    8020591e:	6e678793          	addi	a5,a5,1766 # 80d23000 <nsizes>
    80205922:	4398                	lw	a4,0(a5)
    80205924:	fdc42783          	lw	a5,-36(s0)
    80205928:	2781                	sext.w	a5,a5
    8020592a:	fce7c5e3          	blt	a5,a4,802058f4 <bd_malloc+0x26>
    8020592e:	a011                	j	80205932 <bd_malloc+0x64>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:119
      break;
    80205930:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:121
  }
  if (k >= nsizes) { // No free blocks?
    80205932:	00b1d797          	auipc	a5,0xb1d
    80205936:	6ce78793          	addi	a5,a5,1742 # 80d23000 <nsizes>
    8020593a:	4398                	lw	a4,0(a5)
    8020593c:	fdc42783          	lw	a5,-36(s0)
    80205940:	2781                	sext.w	a5,a5
    80205942:	00e7c463          	blt	a5,a4,8020594a <bd_malloc+0x7c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:123
    // release(&lock);
    return 0;
    80205946:	4781                	li	a5,0
    80205948:	a201                	j	80205a48 <bd_malloc+0x17a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:127
  }

  // Found a block; pop it and potentially split it.
  char *p = lst_pop(&bd_sizes[k].free);
    8020594a:	00b1d797          	auipc	a5,0xb1d
    8020594e:	6be78793          	addi	a5,a5,1726 # 80d23008 <bd_sizes>
    80205952:	6398                	ld	a4,0(a5)
    80205954:	fdc42783          	lw	a5,-36(s0)
    80205958:	0796                	slli	a5,a5,0x5
    8020595a:	97ba                	add	a5,a5,a4
    8020595c:	853e                	mv	a0,a5
    8020595e:	5ce020ef          	jal	ra,80207f2c <lst_pop>
    80205962:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:128
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
    80205966:	00b1d797          	auipc	a5,0xb1d
    8020596a:	6a278793          	addi	a5,a5,1698 # 80d23008 <bd_sizes>
    8020596e:	6398                	ld	a4,0(a5)
    80205970:	fdc42783          	lw	a5,-36(s0)
    80205974:	0796                	slli	a5,a5,0x5
    80205976:	97ba                	add	a5,a5,a4
    80205978:	6b84                	ld	s1,16(a5)
    8020597a:	fdc42783          	lw	a5,-36(s0)
    8020597e:	fd043583          	ld	a1,-48(s0)
    80205982:	853e                	mv	a0,a5
    80205984:	ec1ff0ef          	jal	ra,80205844 <blk_index>
    80205988:	87aa                	mv	a5,a0
    8020598a:	85be                	mv	a1,a5
    8020598c:	8526                	mv	a0,s1
    8020598e:	befff0ef          	jal	ra,8020557c <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129
  for (; k > fk; k--) {
    80205992:	a04d                	j	80205a34 <bd_malloc+0x166>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:132 (discriminator 2)
    // split a block at size k and mark one half allocated at size k-1
    // and put the buddy on the free list at size k-1
    char *q = p + BLK_SIZE(k - 1); // p's buddy
    80205994:	fdc42783          	lw	a5,-36(s0)
    80205998:	37fd                	addiw	a5,a5,-1
    8020599a:	2781                	sext.w	a5,a5
    8020599c:	4741                	li	a4,16
    8020599e:	00f717b3          	sll	a5,a4,a5
    802059a2:	873e                	mv	a4,a5
    802059a4:	fd043783          	ld	a5,-48(s0)
    802059a8:	97ba                	add	a5,a5,a4
    802059aa:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:133 (discriminator 2)
    bit_set(bd_sizes[k].split, blk_index(k, p));
    802059ae:	00b1d797          	auipc	a5,0xb1d
    802059b2:	65a78793          	addi	a5,a5,1626 # 80d23008 <bd_sizes>
    802059b6:	6398                	ld	a4,0(a5)
    802059b8:	fdc42783          	lw	a5,-36(s0)
    802059bc:	0796                	slli	a5,a5,0x5
    802059be:	97ba                	add	a5,a5,a4
    802059c0:	6f84                	ld	s1,24(a5)
    802059c2:	fdc42783          	lw	a5,-36(s0)
    802059c6:	fd043583          	ld	a1,-48(s0)
    802059ca:	853e                	mv	a0,a5
    802059cc:	e79ff0ef          	jal	ra,80205844 <blk_index>
    802059d0:	87aa                	mv	a5,a0
    802059d2:	85be                	mv	a1,a5
    802059d4:	8526                	mv	a0,s1
    802059d6:	ba7ff0ef          	jal	ra,8020557c <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:134 (discriminator 2)
    bit_set(bd_sizes[k - 1].alloc, blk_index(k - 1, p));
    802059da:	00b1d797          	auipc	a5,0xb1d
    802059de:	62e78793          	addi	a5,a5,1582 # 80d23008 <bd_sizes>
    802059e2:	6398                	ld	a4,0(a5)
    802059e4:	fdc42783          	lw	a5,-36(s0)
    802059e8:	0796                	slli	a5,a5,0x5
    802059ea:	1781                	addi	a5,a5,-32
    802059ec:	97ba                	add	a5,a5,a4
    802059ee:	6b84                	ld	s1,16(a5)
    802059f0:	fdc42783          	lw	a5,-36(s0)
    802059f4:	37fd                	addiw	a5,a5,-1
    802059f6:	2781                	sext.w	a5,a5
    802059f8:	fd043583          	ld	a1,-48(s0)
    802059fc:	853e                	mv	a0,a5
    802059fe:	e47ff0ef          	jal	ra,80205844 <blk_index>
    80205a02:	87aa                	mv	a5,a0
    80205a04:	85be                	mv	a1,a5
    80205a06:	8526                	mv	a0,s1
    80205a08:	b75ff0ef          	jal	ra,8020557c <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:135 (discriminator 2)
    lst_push(&bd_sizes[k - 1].free, q);
    80205a0c:	00b1d797          	auipc	a5,0xb1d
    80205a10:	5fc78793          	addi	a5,a5,1532 # 80d23008 <bd_sizes>
    80205a14:	6398                	ld	a4,0(a5)
    80205a16:	fdc42783          	lw	a5,-36(s0)
    80205a1a:	0796                	slli	a5,a5,0x5
    80205a1c:	1781                	addi	a5,a5,-32
    80205a1e:	97ba                	add	a5,a5,a4
    80205a20:	fc843583          	ld	a1,-56(s0)
    80205a24:	853e                	mv	a0,a5
    80205a26:	556020ef          	jal	ra,80207f7c <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129 (discriminator 2)
  for (; k > fk; k--) {
    80205a2a:	fdc42783          	lw	a5,-36(s0)
    80205a2e:	37fd                	addiw	a5,a5,-1
    80205a30:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129 (discriminator 1)
    80205a34:	fdc42703          	lw	a4,-36(s0)
    80205a38:	fd842783          	lw	a5,-40(s0)
    80205a3c:	2701                	sext.w	a4,a4
    80205a3e:	2781                	sext.w	a5,a5
    80205a40:	f4e7cae3          	blt	a5,a4,80205994 <bd_malloc+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:139
  }
  // release(&lock);

  return p;
    80205a44:	fd043783          	ld	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:140
}
    80205a48:	853e                	mv	a0,a5
    80205a4a:	60a6                	ld	ra,72(sp)
    80205a4c:	6406                	ld	s0,64(sp)
    80205a4e:	74e2                	ld	s1,56(sp)
    80205a50:	6161                	addi	sp,sp,80
    80205a52:	8082                	ret

0000000080205a54 <size>:
size():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:143

// Find the size of the block that p points to.
int size(char *p) {
    80205a54:	7139                	addi	sp,sp,-64
    80205a56:	fc06                	sd	ra,56(sp)
    80205a58:	f822                	sd	s0,48(sp)
    80205a5a:	f426                	sd	s1,40(sp)
    80205a5c:	0080                	addi	s0,sp,64
    80205a5e:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144
  for (int k = 0; k < nsizes; k++) {
    80205a62:	fc042e23          	sw	zero,-36(s0)
    80205a66:	a0a1                	j	80205aae <size+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:145
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p))) {
    80205a68:	00b1d797          	auipc	a5,0xb1d
    80205a6c:	5a078793          	addi	a5,a5,1440 # 80d23008 <bd_sizes>
    80205a70:	6398                	ld	a4,0(a5)
    80205a72:	fdc42783          	lw	a5,-36(s0)
    80205a76:	0785                	addi	a5,a5,1
    80205a78:	0796                	slli	a5,a5,0x5
    80205a7a:	97ba                	add	a5,a5,a4
    80205a7c:	6f84                	ld	s1,24(a5)
    80205a7e:	fdc42783          	lw	a5,-36(s0)
    80205a82:	2785                	addiw	a5,a5,1
    80205a84:	2781                	sext.w	a5,a5
    80205a86:	fc843583          	ld	a1,-56(s0)
    80205a8a:	853e                	mv	a0,a5
    80205a8c:	db9ff0ef          	jal	ra,80205844 <blk_index>
    80205a90:	87aa                	mv	a5,a0
    80205a92:	85be                	mv	a1,a5
    80205a94:	8526                	mv	a0,s1
    80205a96:	a65ff0ef          	jal	ra,802054fa <bit_isset>
    80205a9a:	87aa                	mv	a5,a0
    80205a9c:	c781                	beqz	a5,80205aa4 <size+0x50>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:146
      return k;
    80205a9e:	fdc42783          	lw	a5,-36(s0)
    80205aa2:	a00d                	j	80205ac4 <size+0x70>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    80205aa4:	fdc42783          	lw	a5,-36(s0)
    80205aa8:	2785                	addiw	a5,a5,1
    80205aaa:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144 (discriminator 1)
    80205aae:	00b1d797          	auipc	a5,0xb1d
    80205ab2:	55278793          	addi	a5,a5,1362 # 80d23000 <nsizes>
    80205ab6:	4398                	lw	a4,0(a5)
    80205ab8:	fdc42783          	lw	a5,-36(s0)
    80205abc:	2781                	sext.w	a5,a5
    80205abe:	fae7c5e3          	blt	a5,a4,80205a68 <size+0x14>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:149
    }
  }
  return 0;
    80205ac2:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:150
}
    80205ac4:	853e                	mv	a0,a5
    80205ac6:	70e2                	ld	ra,56(sp)
    80205ac8:	7442                	ld	s0,48(sp)
    80205aca:	74a2                	ld	s1,40(sp)
    80205acc:	6121                	addi	sp,sp,64
    80205ace:	8082                	ret

0000000080205ad0 <bd_free>:
bd_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:154

// Free memory pointed to by p, which was earlier allocated using
// bd_malloc.
void bd_free(void *p) {
    80205ad0:	715d                	addi	sp,sp,-80
    80205ad2:	e486                	sd	ra,72(sp)
    80205ad4:	e0a2                	sd	s0,64(sp)
    80205ad6:	fc26                	sd	s1,56(sp)
    80205ad8:	0880                	addi	s0,sp,80
    80205ada:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159
  void *q;
  int k;

  // acquire(&lock);
  for (k = size(p); k < MAXSIZE; k++) {
    80205ade:	fb843503          	ld	a0,-72(s0)
    80205ae2:	f73ff0ef          	jal	ra,80205a54 <size>
    80205ae6:	87aa                	mv	a5,a0
    80205ae8:	fcf42e23          	sw	a5,-36(s0)
    80205aec:	a0d5                	j	80205bd0 <bd_free+0x100>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:160
    int bi = blk_index(k, p);
    80205aee:	fdc42783          	lw	a5,-36(s0)
    80205af2:	fb843583          	ld	a1,-72(s0)
    80205af6:	853e                	mv	a0,a5
    80205af8:	d4dff0ef          	jal	ra,80205844 <blk_index>
    80205afc:	87aa                	mv	a5,a0
    80205afe:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80205b02:	fd842783          	lw	a5,-40(s0)
    80205b06:	8b85                	andi	a5,a5,1
    80205b08:	2781                	sext.w	a5,a5
    80205b0a:	e791                	bnez	a5,80205b16 <bd_free+0x46>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 1)
    80205b0c:	fd842783          	lw	a5,-40(s0)
    80205b10:	2785                	addiw	a5,a5,1
    80205b12:	2781                	sext.w	a5,a5
    80205b14:	a029                	j	80205b1e <bd_free+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 2)
    80205b16:	fd842783          	lw	a5,-40(s0)
    80205b1a:	37fd                	addiw	a5,a5,-1
    80205b1c:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 4)
    80205b1e:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:162 (discriminator 4)
    bit_clear(bd_sizes[k].alloc, bi);          // free p at size k
    80205b22:	00b1d797          	auipc	a5,0xb1d
    80205b26:	4e678793          	addi	a5,a5,1254 # 80d23008 <bd_sizes>
    80205b2a:	6398                	ld	a4,0(a5)
    80205b2c:	fdc42783          	lw	a5,-36(s0)
    80205b30:	0796                	slli	a5,a5,0x5
    80205b32:	97ba                	add	a5,a5,a4
    80205b34:	6b9c                	ld	a5,16(a5)
    80205b36:	fd842703          	lw	a4,-40(s0)
    80205b3a:	85ba                	mv	a1,a4
    80205b3c:	853e                	mv	a0,a5
    80205b3e:	acbff0ef          	jal	ra,80205608 <bit_clear>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:163 (discriminator 4)
    if (bit_isset(bd_sizes[k].alloc, buddy)) { // is buddy allocated?
    80205b42:	00b1d797          	auipc	a5,0xb1d
    80205b46:	4c678793          	addi	a5,a5,1222 # 80d23008 <bd_sizes>
    80205b4a:	6398                	ld	a4,0(a5)
    80205b4c:	fdc42783          	lw	a5,-36(s0)
    80205b50:	0796                	slli	a5,a5,0x5
    80205b52:	97ba                	add	a5,a5,a4
    80205b54:	6b9c                	ld	a5,16(a5)
    80205b56:	fd442703          	lw	a4,-44(s0)
    80205b5a:	85ba                	mv	a1,a4
    80205b5c:	853e                	mv	a0,a5
    80205b5e:	99dff0ef          	jal	ra,802054fa <bit_isset>
    80205b62:	87aa                	mv	a5,a0
    80205b64:	e7c1                	bnez	a5,80205bec <bd_free+0x11c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:167
      break;                                   // break out of loop
    }
    // budy is free; merge with buddy
    q = addr(k, buddy);
    80205b66:	fd442703          	lw	a4,-44(s0)
    80205b6a:	fdc42783          	lw	a5,-36(s0)
    80205b6e:	85ba                	mv	a1,a4
    80205b70:	853e                	mv	a0,a5
    80205b72:	d15ff0ef          	jal	ra,80205886 <addr>
    80205b76:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:168
    lst_remove(q); // remove buddy from free list
    80205b7a:	fc843503          	ld	a0,-56(s0)
    80205b7e:	380020ef          	jal	ra,80207efe <lst_remove>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:169
    if (buddy % 2 == 0) {
    80205b82:	fd442783          	lw	a5,-44(s0)
    80205b86:	8b85                	andi	a5,a5,1
    80205b88:	2781                	sext.w	a5,a5
    80205b8a:	e789                	bnez	a5,80205b94 <bd_free+0xc4>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:170
      p = q;
    80205b8c:	fc843783          	ld	a5,-56(s0)
    80205b90:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:174 (discriminator 2)
    }
    // at size k+1, mark that the merged buddy pair isn't split
    // anymore
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
    80205b94:	00b1d797          	auipc	a5,0xb1d
    80205b98:	47478793          	addi	a5,a5,1140 # 80d23008 <bd_sizes>
    80205b9c:	6398                	ld	a4,0(a5)
    80205b9e:	fdc42783          	lw	a5,-36(s0)
    80205ba2:	0785                	addi	a5,a5,1
    80205ba4:	0796                	slli	a5,a5,0x5
    80205ba6:	97ba                	add	a5,a5,a4
    80205ba8:	6f84                	ld	s1,24(a5)
    80205baa:	fdc42783          	lw	a5,-36(s0)
    80205bae:	2785                	addiw	a5,a5,1
    80205bb0:	2781                	sext.w	a5,a5
    80205bb2:	fb843583          	ld	a1,-72(s0)
    80205bb6:	853e                	mv	a0,a5
    80205bb8:	c8dff0ef          	jal	ra,80205844 <blk_index>
    80205bbc:	87aa                	mv	a5,a0
    80205bbe:	85be                	mv	a1,a5
    80205bc0:	8526                	mv	a0,s1
    80205bc2:	a47ff0ef          	jal	ra,80205608 <bit_clear>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159 (discriminator 2)
  for (k = size(p); k < MAXSIZE; k++) {
    80205bc6:	fdc42783          	lw	a5,-36(s0)
    80205bca:	2785                	addiw	a5,a5,1
    80205bcc:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159 (discriminator 1)
    80205bd0:	00b1d797          	auipc	a5,0xb1d
    80205bd4:	43078793          	addi	a5,a5,1072 # 80d23000 <nsizes>
    80205bd8:	439c                	lw	a5,0(a5)
    80205bda:	37fd                	addiw	a5,a5,-1
    80205bdc:	0007871b          	sext.w	a4,a5
    80205be0:	fdc42783          	lw	a5,-36(s0)
    80205be4:	2781                	sext.w	a5,a5
    80205be6:	f0e7c4e3          	blt	a5,a4,80205aee <bd_free+0x1e>
    80205bea:	a011                	j	80205bee <bd_free+0x11e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:164
      break;                                   // break out of loop
    80205bec:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:176
  }
  lst_push(&bd_sizes[k].free, p);
    80205bee:	00b1d797          	auipc	a5,0xb1d
    80205bf2:	41a78793          	addi	a5,a5,1050 # 80d23008 <bd_sizes>
    80205bf6:	6398                	ld	a4,0(a5)
    80205bf8:	fdc42783          	lw	a5,-36(s0)
    80205bfc:	0796                	slli	a5,a5,0x5
    80205bfe:	97ba                	add	a5,a5,a4
    80205c00:	fb843583          	ld	a1,-72(s0)
    80205c04:	853e                	mv	a0,a5
    80205c06:	376020ef          	jal	ra,80207f7c <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:178
  // release(&lock);
}
    80205c0a:	0001                	nop
    80205c0c:	60a6                	ld	ra,72(sp)
    80205c0e:	6406                	ld	s0,64(sp)
    80205c10:	74e2                	ld	s1,56(sp)
    80205c12:	6161                	addi	sp,sp,80
    80205c14:	8082                	ret

0000000080205c16 <blk_index_next>:
blk_index_next():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:181

// Compute the first block at size k that doesn't contain p
int blk_index_next(int k, char *p) {
    80205c16:	7179                	addi	sp,sp,-48
    80205c18:	f422                	sd	s0,40(sp)
    80205c1a:	1800                	addi	s0,sp,48
    80205c1c:	87aa                	mv	a5,a0
    80205c1e:	fcb43823          	sd	a1,-48(s0)
    80205c22:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:182
  int n = (p - (char *)bd_base) / BLK_SIZE(k);
    80205c26:	00b1d797          	auipc	a5,0xb1d
    80205c2a:	3ea78793          	addi	a5,a5,1002 # 80d23010 <bd_base>
    80205c2e:	639c                	ld	a5,0(a5)
    80205c30:	fd043703          	ld	a4,-48(s0)
    80205c34:	8f1d                	sub	a4,a4,a5
    80205c36:	fdc42783          	lw	a5,-36(s0)
    80205c3a:	46c1                	li	a3,16
    80205c3c:	00f697b3          	sll	a5,a3,a5
    80205c40:	02f747b3          	div	a5,a4,a5
    80205c44:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:183
  if ((p - (char *)bd_base) % BLK_SIZE(k) != 0)
    80205c48:	00b1d797          	auipc	a5,0xb1d
    80205c4c:	3c878793          	addi	a5,a5,968 # 80d23010 <bd_base>
    80205c50:	639c                	ld	a5,0(a5)
    80205c52:	fd043703          	ld	a4,-48(s0)
    80205c56:	8f1d                	sub	a4,a4,a5
    80205c58:	fdc42783          	lw	a5,-36(s0)
    80205c5c:	46c1                	li	a3,16
    80205c5e:	00f697b3          	sll	a5,a3,a5
    80205c62:	02f767b3          	rem	a5,a4,a5
    80205c66:	c791                	beqz	a5,80205c72 <blk_index_next+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:184
    n++;
    80205c68:	fec42783          	lw	a5,-20(s0)
    80205c6c:	2785                	addiw	a5,a5,1
    80205c6e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:185
  return n;
    80205c72:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:186
}
    80205c76:	853e                	mv	a0,a5
    80205c78:	7422                	ld	s0,40(sp)
    80205c7a:	6145                	addi	sp,sp,48
    80205c7c:	8082                	ret

0000000080205c7e <_log2>:
_log2():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:188

static int _log2(uint64_t n) {
    80205c7e:	7179                	addi	sp,sp,-48
    80205c80:	f422                	sd	s0,40(sp)
    80205c82:	1800                	addi	s0,sp,48
    80205c84:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:189
  int k = 0;
    80205c88:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:190
  while (n > 1) {
    80205c8c:	a819                	j	80205ca2 <_log2+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:191
    k++;
    80205c8e:	fec42783          	lw	a5,-20(s0)
    80205c92:	2785                	addiw	a5,a5,1
    80205c94:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:192
    n = n >> 1;
    80205c98:	fd843783          	ld	a5,-40(s0)
    80205c9c:	8385                	srli	a5,a5,0x1
    80205c9e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:190
  while (n > 1) {
    80205ca2:	fd843703          	ld	a4,-40(s0)
    80205ca6:	4785                	li	a5,1
    80205ca8:	fee7e3e3          	bltu	a5,a4,80205c8e <_log2+0x10>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:194
  }
  return k;
    80205cac:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:195
}
    80205cb0:	853e                	mv	a0,a5
    80205cb2:	7422                	ld	s0,40(sp)
    80205cb4:	6145                	addi	sp,sp,48
    80205cb6:	8082                	ret

0000000080205cb8 <bd_mark>:
bd_mark():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:198

// Mark memory from [start, stop), starting at size 0, as allocated.
void bd_mark(void *start, void *stop) {
    80205cb8:	7179                	addi	sp,sp,-48
    80205cba:	f406                	sd	ra,40(sp)
    80205cbc:	f022                	sd	s0,32(sp)
    80205cbe:	1800                	addi	s0,sp,48
    80205cc0:	fca43c23          	sd	a0,-40(s0)
    80205cc4:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:201
  int bi, bj;

  if (((uint64_t)start % LEAF_SIZE != 0) || ((uint64_t)stop % LEAF_SIZE != 0))
    80205cc8:	fd843783          	ld	a5,-40(s0)
    80205ccc:	8bbd                	andi	a5,a5,15
    80205cce:	e789                	bnez	a5,80205cd8 <bd_mark+0x20>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:201 (discriminator 1)
    80205cd0:	fd043783          	ld	a5,-48(s0)
    80205cd4:	8bbd                	andi	a5,a5,15
    80205cd6:	cf89                	beqz	a5,80205cf0 <bd_mark+0x38>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:202
    panic("bd_mark\n");
    80205cd8:	00003617          	auipc	a2,0x3
    80205cdc:	76860613          	addi	a2,a2,1896 # 80209440 <MMIO+0x10>
    80205ce0:	0ca00593          	li	a1,202
    80205ce4:	00003517          	auipc	a0,0x3
    80205ce8:	76c50513          	addi	a0,a0,1900 # 80209450 <MMIO+0x20>
    80205cec:	1ad000ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204

  for (int k = 0; k < nsizes; k++) {
    80205cf0:	fe042423          	sw	zero,-24(s0)
    80205cf4:	a869                	j	80205d8e <bd_mark+0xd6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:205
    bi = blk_index(k, start);
    80205cf6:	fe842783          	lw	a5,-24(s0)
    80205cfa:	fd843583          	ld	a1,-40(s0)
    80205cfe:	853e                	mv	a0,a5
    80205d00:	b45ff0ef          	jal	ra,80205844 <blk_index>
    80205d04:	87aa                	mv	a5,a0
    80205d06:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:206
    bj = blk_index_next(k, stop);
    80205d0a:	fe842783          	lw	a5,-24(s0)
    80205d0e:	fd043583          	ld	a1,-48(s0)
    80205d12:	853e                	mv	a0,a5
    80205d14:	f03ff0ef          	jal	ra,80205c16 <blk_index_next>
    80205d18:	87aa                	mv	a5,a0
    80205d1a:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207
    for (; bi < bj; bi++) {
    80205d1e:	a899                	j	80205d74 <bd_mark+0xbc>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:208
      if (k > 0) {
    80205d20:	fe842783          	lw	a5,-24(s0)
    80205d24:	2781                	sext.w	a5,a5
    80205d26:	02f05263          	blez	a5,80205d4a <bd_mark+0x92>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:210
        // if a block is allocated at size k, mark it as split too.
        bit_set(bd_sizes[k].split, bi);
    80205d2a:	00b1d797          	auipc	a5,0xb1d
    80205d2e:	2de78793          	addi	a5,a5,734 # 80d23008 <bd_sizes>
    80205d32:	6398                	ld	a4,0(a5)
    80205d34:	fe842783          	lw	a5,-24(s0)
    80205d38:	0796                	slli	a5,a5,0x5
    80205d3a:	97ba                	add	a5,a5,a4
    80205d3c:	6f9c                	ld	a5,24(a5)
    80205d3e:	fec42703          	lw	a4,-20(s0)
    80205d42:	85ba                	mv	a1,a4
    80205d44:	853e                	mv	a0,a5
    80205d46:	837ff0ef          	jal	ra,8020557c <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:212
      }
      bit_set(bd_sizes[k].alloc, bi);
    80205d4a:	00b1d797          	auipc	a5,0xb1d
    80205d4e:	2be78793          	addi	a5,a5,702 # 80d23008 <bd_sizes>
    80205d52:	6398                	ld	a4,0(a5)
    80205d54:	fe842783          	lw	a5,-24(s0)
    80205d58:	0796                	slli	a5,a5,0x5
    80205d5a:	97ba                	add	a5,a5,a4
    80205d5c:	6b9c                	ld	a5,16(a5)
    80205d5e:	fec42703          	lw	a4,-20(s0)
    80205d62:	85ba                	mv	a1,a4
    80205d64:	853e                	mv	a0,a5
    80205d66:	817ff0ef          	jal	ra,8020557c <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207
    for (; bi < bj; bi++) {
    80205d6a:	fec42783          	lw	a5,-20(s0)
    80205d6e:	2785                	addiw	a5,a5,1
    80205d70:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207 (discriminator 1)
    80205d74:	fec42703          	lw	a4,-20(s0)
    80205d78:	fe442783          	lw	a5,-28(s0)
    80205d7c:	2701                	sext.w	a4,a4
    80205d7e:	2781                	sext.w	a5,a5
    80205d80:	faf740e3          	blt	a4,a5,80205d20 <bd_mark+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    80205d84:	fe842783          	lw	a5,-24(s0)
    80205d88:	2785                	addiw	a5,a5,1
    80205d8a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204 (discriminator 1)
    80205d8e:	00b1d797          	auipc	a5,0xb1d
    80205d92:	27278793          	addi	a5,a5,626 # 80d23000 <nsizes>
    80205d96:	4398                	lw	a4,0(a5)
    80205d98:	fe842783          	lw	a5,-24(s0)
    80205d9c:	2781                	sext.w	a5,a5
    80205d9e:	f4e7cce3          	blt	a5,a4,80205cf6 <bd_mark+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:215
    }
  }
}
    80205da2:	0001                	nop
    80205da4:	0001                	nop
    80205da6:	70a2                	ld	ra,40(sp)
    80205da8:	7402                	ld	s0,32(sp)
    80205daa:	6145                	addi	sp,sp,48
    80205dac:	8082                	ret

0000000080205dae <bd_initfree_pair>:
bd_initfree_pair():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:219

// If a block is marked as allocated and the buddy is free, put the
// buddy on the free list at size k.
int bd_initfree_pair(int k, int bi) {
    80205dae:	7139                	addi	sp,sp,-64
    80205db0:	fc06                	sd	ra,56(sp)
    80205db2:	f822                	sd	s0,48(sp)
    80205db4:	f426                	sd	s1,40(sp)
    80205db6:	0080                	addi	s0,sp,64
    80205db8:	87aa                	mv	a5,a0
    80205dba:	872e                	mv	a4,a1
    80205dbc:	fcf42623          	sw	a5,-52(s0)
    80205dc0:	87ba                	mv	a5,a4
    80205dc2:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80205dc6:	fc842783          	lw	a5,-56(s0)
    80205dca:	8b85                	andi	a5,a5,1
    80205dcc:	2781                	sext.w	a5,a5
    80205dce:	e791                	bnez	a5,80205dda <bd_initfree_pair+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 1)
    80205dd0:	fc842783          	lw	a5,-56(s0)
    80205dd4:	2785                	addiw	a5,a5,1
    80205dd6:	2781                	sext.w	a5,a5
    80205dd8:	a029                	j	80205de2 <bd_initfree_pair+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 2)
    80205dda:	fc842783          	lw	a5,-56(s0)
    80205dde:	37fd                	addiw	a5,a5,-1
    80205de0:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 4)
    80205de2:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:221 (discriminator 4)
  int free = 0;
    80205de6:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:222 (discriminator 4)
  if (bit_isset(bd_sizes[k].alloc, bi) != bit_isset(bd_sizes[k].alloc, buddy)) {
    80205dea:	00b1d797          	auipc	a5,0xb1d
    80205dee:	21e78793          	addi	a5,a5,542 # 80d23008 <bd_sizes>
    80205df2:	6398                	ld	a4,0(a5)
    80205df4:	fcc42783          	lw	a5,-52(s0)
    80205df8:	0796                	slli	a5,a5,0x5
    80205dfa:	97ba                	add	a5,a5,a4
    80205dfc:	6b9c                	ld	a5,16(a5)
    80205dfe:	fc842703          	lw	a4,-56(s0)
    80205e02:	85ba                	mv	a1,a4
    80205e04:	853e                	mv	a0,a5
    80205e06:	ef4ff0ef          	jal	ra,802054fa <bit_isset>
    80205e0a:	87aa                	mv	a5,a0
    80205e0c:	84be                	mv	s1,a5
    80205e0e:	00b1d797          	auipc	a5,0xb1d
    80205e12:	1fa78793          	addi	a5,a5,506 # 80d23008 <bd_sizes>
    80205e16:	6398                	ld	a4,0(a5)
    80205e18:	fcc42783          	lw	a5,-52(s0)
    80205e1c:	0796                	slli	a5,a5,0x5
    80205e1e:	97ba                	add	a5,a5,a4
    80205e20:	6b9c                	ld	a5,16(a5)
    80205e22:	fd842703          	lw	a4,-40(s0)
    80205e26:	85ba                	mv	a1,a4
    80205e28:	853e                	mv	a0,a5
    80205e2a:	ed0ff0ef          	jal	ra,802054fa <bit_isset>
    80205e2e:	87aa                	mv	a5,a0
    80205e30:	8726                	mv	a4,s1
    80205e32:	08f70a63          	beq	a4,a5,80205ec6 <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:224
    // one of the pair is free
    free = BLK_SIZE(k);
    80205e36:	fcc42783          	lw	a5,-52(s0)
    80205e3a:	4741                	li	a4,16
    80205e3c:	00f717b3          	sll	a5,a4,a5
    80205e40:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:225
    if (bit_isset(bd_sizes[k].alloc, bi))
    80205e44:	00b1d797          	auipc	a5,0xb1d
    80205e48:	1c478793          	addi	a5,a5,452 # 80d23008 <bd_sizes>
    80205e4c:	6398                	ld	a4,0(a5)
    80205e4e:	fcc42783          	lw	a5,-52(s0)
    80205e52:	0796                	slli	a5,a5,0x5
    80205e54:	97ba                	add	a5,a5,a4
    80205e56:	6b9c                	ld	a5,16(a5)
    80205e58:	fc842703          	lw	a4,-56(s0)
    80205e5c:	85ba                	mv	a1,a4
    80205e5e:	853e                	mv	a0,a5
    80205e60:	e9aff0ef          	jal	ra,802054fa <bit_isset>
    80205e64:	87aa                	mv	a5,a0
    80205e66:	cb8d                	beqz	a5,80205e98 <bd_initfree_pair+0xea>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:226
      lst_push(&bd_sizes[k].free, addr(k, buddy)); // put buddy on free list
    80205e68:	00b1d797          	auipc	a5,0xb1d
    80205e6c:	1a078793          	addi	a5,a5,416 # 80d23008 <bd_sizes>
    80205e70:	6398                	ld	a4,0(a5)
    80205e72:	fcc42783          	lw	a5,-52(s0)
    80205e76:	0796                	slli	a5,a5,0x5
    80205e78:	97ba                	add	a5,a5,a4
    80205e7a:	84be                	mv	s1,a5
    80205e7c:	fd842703          	lw	a4,-40(s0)
    80205e80:	fcc42783          	lw	a5,-52(s0)
    80205e84:	85ba                	mv	a1,a4
    80205e86:	853e                	mv	a0,a5
    80205e88:	9ffff0ef          	jal	ra,80205886 <addr>
    80205e8c:	87aa                	mv	a5,a0
    80205e8e:	85be                	mv	a1,a5
    80205e90:	8526                	mv	a0,s1
    80205e92:	0ea020ef          	jal	ra,80207f7c <lst_push>
    80205e96:	a805                	j	80205ec6 <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:228
    else
      lst_push(&bd_sizes[k].free, addr(k, bi)); // put bi on free list
    80205e98:	00b1d797          	auipc	a5,0xb1d
    80205e9c:	17078793          	addi	a5,a5,368 # 80d23008 <bd_sizes>
    80205ea0:	6398                	ld	a4,0(a5)
    80205ea2:	fcc42783          	lw	a5,-52(s0)
    80205ea6:	0796                	slli	a5,a5,0x5
    80205ea8:	97ba                	add	a5,a5,a4
    80205eaa:	84be                	mv	s1,a5
    80205eac:	fc842703          	lw	a4,-56(s0)
    80205eb0:	fcc42783          	lw	a5,-52(s0)
    80205eb4:	85ba                	mv	a1,a4
    80205eb6:	853e                	mv	a0,a5
    80205eb8:	9cfff0ef          	jal	ra,80205886 <addr>
    80205ebc:	87aa                	mv	a5,a0
    80205ebe:	85be                	mv	a1,a5
    80205ec0:	8526                	mv	a0,s1
    80205ec2:	0ba020ef          	jal	ra,80207f7c <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:230
  }
  return free;
    80205ec6:	fdc42783          	lw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:231
}
    80205eca:	853e                	mv	a0,a5
    80205ecc:	70e2                	ld	ra,56(sp)
    80205ece:	7442                	ld	s0,48(sp)
    80205ed0:	74a2                	ld	s1,40(sp)
    80205ed2:	6121                	addi	sp,sp,64
    80205ed4:	8082                	ret

0000000080205ed6 <bd_initfree>:
bd_initfree():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:236

// Initialize the free lists for each size k.  For each size k, there
// are only two pairs that may have a buddy that should be on free list:
// bd_left and bd_right.
int bd_initfree(void *bd_left, void *bd_right) {
    80205ed6:	7179                	addi	sp,sp,-48
    80205ed8:	f406                	sd	ra,40(sp)
    80205eda:	f022                	sd	s0,32(sp)
    80205edc:	1800                	addi	s0,sp,48
    80205ede:	fca43c23          	sd	a0,-40(s0)
    80205ee2:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:237
  int free = 0;
    80205ee6:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239

  for (int k = 0; k < MAXSIZE; k++) { // skip max size
    80205eea:	fe042423          	sw	zero,-24(s0)
    80205eee:	a051                	j	80205f72 <bd_initfree+0x9c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:240
    int left = blk_index_next(k, bd_left);
    80205ef0:	fe842783          	lw	a5,-24(s0)
    80205ef4:	fd843583          	ld	a1,-40(s0)
    80205ef8:	853e                	mv	a0,a5
    80205efa:	d1dff0ef          	jal	ra,80205c16 <blk_index_next>
    80205efe:	87aa                	mv	a5,a0
    80205f00:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:241
    int right = blk_index(k, bd_right);
    80205f04:	fe842783          	lw	a5,-24(s0)
    80205f08:	fd043583          	ld	a1,-48(s0)
    80205f0c:	853e                	mv	a0,a5
    80205f0e:	937ff0ef          	jal	ra,80205844 <blk_index>
    80205f12:	87aa                	mv	a5,a0
    80205f14:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:242
    free += bd_initfree_pair(k, left);
    80205f18:	fe442703          	lw	a4,-28(s0)
    80205f1c:	fe842783          	lw	a5,-24(s0)
    80205f20:	85ba                	mv	a1,a4
    80205f22:	853e                	mv	a0,a5
    80205f24:	e8bff0ef          	jal	ra,80205dae <bd_initfree_pair>
    80205f28:	87aa                	mv	a5,a0
    80205f2a:	873e                	mv	a4,a5
    80205f2c:	fec42783          	lw	a5,-20(s0)
    80205f30:	9fb9                	addw	a5,a5,a4
    80205f32:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:243
    if (right <= left)
    80205f36:	fe042703          	lw	a4,-32(s0)
    80205f3a:	fe442783          	lw	a5,-28(s0)
    80205f3e:	2701                	sext.w	a4,a4
    80205f40:	2781                	sext.w	a5,a5
    80205f42:	02e7d263          	bge	a5,a4,80205f66 <bd_initfree+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:245
      continue;
    free += bd_initfree_pair(k, right);
    80205f46:	fe042703          	lw	a4,-32(s0)
    80205f4a:	fe842783          	lw	a5,-24(s0)
    80205f4e:	85ba                	mv	a1,a4
    80205f50:	853e                	mv	a0,a5
    80205f52:	e5dff0ef          	jal	ra,80205dae <bd_initfree_pair>
    80205f56:	87aa                	mv	a5,a0
    80205f58:	873e                	mv	a4,a5
    80205f5a:	fec42783          	lw	a5,-20(s0)
    80205f5e:	9fb9                	addw	a5,a5,a4
    80205f60:	fef42623          	sw	a5,-20(s0)
    80205f64:	a011                	j	80205f68 <bd_initfree+0x92>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:244
      continue;
    80205f66:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239 (discriminator 2)
  for (int k = 0; k < MAXSIZE; k++) { // skip max size
    80205f68:	fe842783          	lw	a5,-24(s0)
    80205f6c:	2785                	addiw	a5,a5,1
    80205f6e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239 (discriminator 1)
    80205f72:	00b1d797          	auipc	a5,0xb1d
    80205f76:	08e78793          	addi	a5,a5,142 # 80d23000 <nsizes>
    80205f7a:	439c                	lw	a5,0(a5)
    80205f7c:	37fd                	addiw	a5,a5,-1
    80205f7e:	0007871b          	sext.w	a4,a5
    80205f82:	fe842783          	lw	a5,-24(s0)
    80205f86:	2781                	sext.w	a5,a5
    80205f88:	f6e7c4e3          	blt	a5,a4,80205ef0 <bd_initfree+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:247
  }
  return free;
    80205f8c:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:248
}
    80205f90:	853e                	mv	a0,a5
    80205f92:	70a2                	ld	ra,40(sp)
    80205f94:	7402                	ld	s0,32(sp)
    80205f96:	6145                	addi	sp,sp,48
    80205f98:	8082                	ret

0000000080205f9a <bd_mark_data_structures>:
bd_mark_data_structures():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:251

// Mark the range [bd_base,p) as allocated
int bd_mark_data_structures(char *p) {
    80205f9a:	7179                	addi	sp,sp,-48
    80205f9c:	f406                	sd	ra,40(sp)
    80205f9e:	f022                	sd	s0,32(sp)
    80205fa0:	1800                	addi	s0,sp,48
    80205fa2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:252
  int meta = p - (char *)bd_base;
    80205fa6:	00b1d797          	auipc	a5,0xb1d
    80205faa:	06a78793          	addi	a5,a5,106 # 80d23010 <bd_base>
    80205fae:	639c                	ld	a5,0(a5)
    80205fb0:	fd843703          	ld	a4,-40(s0)
    80205fb4:	40f707b3          	sub	a5,a4,a5
    80205fb8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:253
  bd_mark(bd_base, p);
    80205fbc:	00b1d797          	auipc	a5,0xb1d
    80205fc0:	05478793          	addi	a5,a5,84 # 80d23010 <bd_base>
    80205fc4:	639c                	ld	a5,0(a5)
    80205fc6:	fd843583          	ld	a1,-40(s0)
    80205fca:	853e                	mv	a0,a5
    80205fcc:	cedff0ef          	jal	ra,80205cb8 <bd_mark>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:254
  return meta;
    80205fd0:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:255
}
    80205fd4:	853e                	mv	a0,a5
    80205fd6:	70a2                	ld	ra,40(sp)
    80205fd8:	7402                	ld	s0,32(sp)
    80205fda:	6145                	addi	sp,sp,48
    80205fdc:	8082                	ret

0000000080205fde <bd_mark_unavailable>:
bd_mark_unavailable():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:258

// Mark the range [end, HEAPSIZE) as allocated
int bd_mark_unavailable(void *end, void *left) {
    80205fde:	7179                	addi	sp,sp,-48
    80205fe0:	f406                	sd	ra,40(sp)
    80205fe2:	f022                	sd	s0,32(sp)
    80205fe4:	1800                	addi	s0,sp,48
    80205fe6:	fca43c23          	sd	a0,-40(s0)
    80205fea:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:259
  int unavailable = BLK_SIZE(MAXSIZE) - (end - bd_base);
    80205fee:	00b1d797          	auipc	a5,0xb1d
    80205ff2:	01278793          	addi	a5,a5,18 # 80d23000 <nsizes>
    80205ff6:	439c                	lw	a5,0(a5)
    80205ff8:	37fd                	addiw	a5,a5,-1
    80205ffa:	2781                	sext.w	a5,a5
    80205ffc:	4741                	li	a4,16
    80205ffe:	00f717b3          	sll	a5,a4,a5
    80206002:	0007871b          	sext.w	a4,a5
    80206006:	00b1d797          	auipc	a5,0xb1d
    8020600a:	00a78793          	addi	a5,a5,10 # 80d23010 <bd_base>
    8020600e:	639c                	ld	a5,0(a5)
    80206010:	fd843683          	ld	a3,-40(s0)
    80206014:	40f687b3          	sub	a5,a3,a5
    80206018:	2781                	sext.w	a5,a5
    8020601a:	40f707bb          	subw	a5,a4,a5
    8020601e:	2781                	sext.w	a5,a5
    80206020:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:260
  if (unavailable > 0)
    80206024:	fec42783          	lw	a5,-20(s0)
    80206028:	2781                	sext.w	a5,a5
    8020602a:	02f05463          	blez	a5,80206052 <bd_mark_unavailable+0x74>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:261
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    8020602e:	fec42783          	lw	a5,-20(s0)
    80206032:	37fd                	addiw	a5,a5,-1
    80206034:	2781                	sext.w	a5,a5
    80206036:	41f7d71b          	sraiw	a4,a5,0x1f
    8020603a:	01c7571b          	srliw	a4,a4,0x1c
    8020603e:	9fb9                	addw	a5,a5,a4
    80206040:	4047d79b          	sraiw	a5,a5,0x4
    80206044:	2781                	sext.w	a5,a5
    80206046:	2785                	addiw	a5,a5,1
    80206048:	2781                	sext.w	a5,a5
    8020604a:	0047979b          	slliw	a5,a5,0x4
    8020604e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:263

  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    80206052:	00b1d797          	auipc	a5,0xb1d
    80206056:	fbe78793          	addi	a5,a5,-66 # 80d23010 <bd_base>
    8020605a:	6398                	ld	a4,0(a5)
    8020605c:	00b1d797          	auipc	a5,0xb1d
    80206060:	fa478793          	addi	a5,a5,-92 # 80d23000 <nsizes>
    80206064:	439c                	lw	a5,0(a5)
    80206066:	37fd                	addiw	a5,a5,-1
    80206068:	2781                	sext.w	a5,a5
    8020606a:	46c1                	li	a3,16
    8020606c:	00f697b3          	sll	a5,a3,a5
    80206070:	86be                	mv	a3,a5
    80206072:	fec42783          	lw	a5,-20(s0)
    80206076:	40f687b3          	sub	a5,a3,a5
    8020607a:	97ba                	add	a5,a5,a4
    8020607c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:264
  bd_mark(bd_end, bd_base + BLK_SIZE(MAXSIZE));
    80206080:	00b1d797          	auipc	a5,0xb1d
    80206084:	f9078793          	addi	a5,a5,-112 # 80d23010 <bd_base>
    80206088:	639c                	ld	a5,0(a5)
    8020608a:	00b1d717          	auipc	a4,0xb1d
    8020608e:	f7670713          	addi	a4,a4,-138 # 80d23000 <nsizes>
    80206092:	4318                	lw	a4,0(a4)
    80206094:	377d                	addiw	a4,a4,-1
    80206096:	2701                	sext.w	a4,a4
    80206098:	46c1                	li	a3,16
    8020609a:	00e69733          	sll	a4,a3,a4
    8020609e:	97ba                	add	a5,a5,a4
    802060a0:	85be                	mv	a1,a5
    802060a2:	fe043503          	ld	a0,-32(s0)
    802060a6:	c13ff0ef          	jal	ra,80205cb8 <bd_mark>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:265
  return unavailable;
    802060aa:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:266
}
    802060ae:	853e                	mv	a0,a5
    802060b0:	70a2                	ld	ra,40(sp)
    802060b2:	7402                	ld	s0,32(sp)
    802060b4:	6145                	addi	sp,sp,48
    802060b6:	8082                	ret

00000000802060b8 <bd_init>:
bd_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:269

// Initialize the buddy allocator: it manages memory from [base, end).
void bd_init(void *base, void *end) {
    802060b8:	715d                	addi	sp,sp,-80
    802060ba:	e486                	sd	ra,72(sp)
    802060bc:	e0a2                	sd	s0,64(sp)
    802060be:	0880                	addi	s0,sp,80
    802060c0:	faa43c23          	sd	a0,-72(s0)
    802060c4:	fab43823          	sd	a1,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:270
  char *p = (char *)ROUNDUP((uint64_t)base, LEAF_SIZE);
    802060c8:	fb843783          	ld	a5,-72(s0)
    802060cc:	17fd                	addi	a5,a5,-1
    802060ce:	8391                	srli	a5,a5,0x4
    802060d0:	0785                	addi	a5,a5,1
    802060d2:	0792                	slli	a5,a5,0x4
    802060d4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:274
  int sz;

  // initlock(&lock, "buddy");
  bd_base = (void *)p;
    802060d8:	00b1d797          	auipc	a5,0xb1d
    802060dc:	f3878793          	addi	a5,a5,-200 # 80d23010 <bd_base>
    802060e0:	fe843703          	ld	a4,-24(s0)
    802060e4:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:277

  // compute the number of sizes we need to manage [base, end)
  nsizes = _log2(((char *)end - p) / LEAF_SIZE) + 1;
    802060e6:	fb043703          	ld	a4,-80(s0)
    802060ea:	fe843783          	ld	a5,-24(s0)
    802060ee:	40f707b3          	sub	a5,a4,a5
    802060f2:	43f7d713          	srai	a4,a5,0x3f
    802060f6:	8b3d                	andi	a4,a4,15
    802060f8:	97ba                	add	a5,a5,a4
    802060fa:	8791                	srai	a5,a5,0x4
    802060fc:	853e                	mv	a0,a5
    802060fe:	b81ff0ef          	jal	ra,80205c7e <_log2>
    80206102:	87aa                	mv	a5,a0
    80206104:	2785                	addiw	a5,a5,1
    80206106:	0007871b          	sext.w	a4,a5
    8020610a:	00b1d797          	auipc	a5,0xb1d
    8020610e:	ef678793          	addi	a5,a5,-266 # 80d23000 <nsizes>
    80206112:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:278
  if ((char *)end - p > BLK_SIZE(MAXSIZE)) {
    80206114:	fb043703          	ld	a4,-80(s0)
    80206118:	fe843783          	ld	a5,-24(s0)
    8020611c:	8f1d                	sub	a4,a4,a5
    8020611e:	00b1d797          	auipc	a5,0xb1d
    80206122:	ee278793          	addi	a5,a5,-286 # 80d23000 <nsizes>
    80206126:	439c                	lw	a5,0(a5)
    80206128:	37fd                	addiw	a5,a5,-1
    8020612a:	2781                	sext.w	a5,a5
    8020612c:	46c1                	li	a3,16
    8020612e:	00f697b3          	sll	a5,a3,a5
    80206132:	00e7df63          	bge	a5,a4,80206150 <bd_init+0x98>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:279
    nsizes++; // round up to the next power of 2
    80206136:	00b1d797          	auipc	a5,0xb1d
    8020613a:	eca78793          	addi	a5,a5,-310 # 80d23000 <nsizes>
    8020613e:	439c                	lw	a5,0(a5)
    80206140:	2785                	addiw	a5,a5,1
    80206142:	0007871b          	sext.w	a4,a5
    80206146:	00b1d797          	auipc	a5,0xb1d
    8020614a:	eba78793          	addi	a5,a5,-326 # 80d23000 <nsizes>
    8020614e:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:283
  }

  // allocate bd_sizes array
  bd_sizes = (Sz_info *)p;
    80206150:	00b1d797          	auipc	a5,0xb1d
    80206154:	eb878793          	addi	a5,a5,-328 # 80d23008 <bd_sizes>
    80206158:	fe843703          	ld	a4,-24(s0)
    8020615c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:284
  p += sizeof(Sz_info) * nsizes;
    8020615e:	00b1d797          	auipc	a5,0xb1d
    80206162:	ea278793          	addi	a5,a5,-350 # 80d23000 <nsizes>
    80206166:	439c                	lw	a5,0(a5)
    80206168:	0796                	slli	a5,a5,0x5
    8020616a:	fe843703          	ld	a4,-24(s0)
    8020616e:	97ba                	add	a5,a5,a4
    80206170:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:285
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    80206174:	00b1d797          	auipc	a5,0xb1d
    80206178:	e9478793          	addi	a5,a5,-364 # 80d23008 <bd_sizes>
    8020617c:	6398                	ld	a4,0(a5)
    8020617e:	00b1d797          	auipc	a5,0xb1d
    80206182:	e8278793          	addi	a5,a5,-382 # 80d23000 <nsizes>
    80206186:	439c                	lw	a5,0(a5)
    80206188:	2781                	sext.w	a5,a5
    8020618a:	0057979b          	slliw	a5,a5,0x5
    8020618e:	2781                	sext.w	a5,a5
    80206190:	863e                	mv	a2,a5
    80206192:	4581                	li	a1,0
    80206194:	853a                	mv	a0,a4
    80206196:	dfafd0ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288

  // initialize free list and allocate the alloc array for each size k
  for (int k = 0; k < nsizes; k++) {
    8020619a:	fe042223          	sw	zero,-28(s0)
    8020619e:	a84d                	j	80206250 <bd_init+0x198>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:289 (discriminator 3)
    lst_init(&bd_sizes[k].free);
    802061a0:	00b1d797          	auipc	a5,0xb1d
    802061a4:	e6878793          	addi	a5,a5,-408 # 80d23008 <bd_sizes>
    802061a8:	6398                	ld	a4,0(a5)
    802061aa:	fe442783          	lw	a5,-28(s0)
    802061ae:	0796                	slli	a5,a5,0x5
    802061b0:	97ba                	add	a5,a5,a4
    802061b2:	853e                	mv	a0,a5
    802061b4:	4fb010ef          	jal	ra,80207eae <lst_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:290 (discriminator 3)
    sz = sizeof(char) * ROUNDUP(NBLK(k), 8) / 8;
    802061b8:	00b1d797          	auipc	a5,0xb1d
    802061bc:	e4878793          	addi	a5,a5,-440 # 80d23000 <nsizes>
    802061c0:	439c                	lw	a5,0(a5)
    802061c2:	37fd                	addiw	a5,a5,-1
    802061c4:	0007871b          	sext.w	a4,a5
    802061c8:	fe442783          	lw	a5,-28(s0)
    802061cc:	40f707bb          	subw	a5,a4,a5
    802061d0:	2781                	sext.w	a5,a5
    802061d2:	4705                	li	a4,1
    802061d4:	00f717bb          	sllw	a5,a4,a5
    802061d8:	2781                	sext.w	a5,a5
    802061da:	37fd                	addiw	a5,a5,-1
    802061dc:	2781                	sext.w	a5,a5
    802061de:	41f7d71b          	sraiw	a4,a5,0x1f
    802061e2:	01d7571b          	srliw	a4,a4,0x1d
    802061e6:	9fb9                	addw	a5,a5,a4
    802061e8:	4037d79b          	sraiw	a5,a5,0x3
    802061ec:	2781                	sext.w	a5,a5
    802061ee:	2785                	addiw	a5,a5,1
    802061f0:	2781                	sext.w	a5,a5
    802061f2:	0037979b          	slliw	a5,a5,0x3
    802061f6:	2781                	sext.w	a5,a5
    802061f8:	838d                	srli	a5,a5,0x3
    802061fa:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:291 (discriminator 3)
    bd_sizes[k].alloc = p;
    802061fe:	00b1d797          	auipc	a5,0xb1d
    80206202:	e0a78793          	addi	a5,a5,-502 # 80d23008 <bd_sizes>
    80206206:	6398                	ld	a4,0(a5)
    80206208:	fe442783          	lw	a5,-28(s0)
    8020620c:	0796                	slli	a5,a5,0x5
    8020620e:	97ba                	add	a5,a5,a4
    80206210:	fe843703          	ld	a4,-24(s0)
    80206214:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:292 (discriminator 3)
    memset(bd_sizes[k].alloc, 0, sz);
    80206216:	00b1d797          	auipc	a5,0xb1d
    8020621a:	df278793          	addi	a5,a5,-526 # 80d23008 <bd_sizes>
    8020621e:	6398                	ld	a4,0(a5)
    80206220:	fe442783          	lw	a5,-28(s0)
    80206224:	0796                	slli	a5,a5,0x5
    80206226:	97ba                	add	a5,a5,a4
    80206228:	6b9c                	ld	a5,16(a5)
    8020622a:	fc842703          	lw	a4,-56(s0)
    8020622e:	863a                	mv	a2,a4
    80206230:	4581                	li	a1,0
    80206232:	853e                	mv	a0,a5
    80206234:	d5cfd0ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:293 (discriminator 3)
    p += sz;
    80206238:	fc842783          	lw	a5,-56(s0)
    8020623c:	fe843703          	ld	a4,-24(s0)
    80206240:	97ba                	add	a5,a5,a4
    80206242:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288 (discriminator 3)
  for (int k = 0; k < nsizes; k++) {
    80206246:	fe442783          	lw	a5,-28(s0)
    8020624a:	2785                	addiw	a5,a5,1
    8020624c:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288 (discriminator 1)
    80206250:	00b1d797          	auipc	a5,0xb1d
    80206254:	db078793          	addi	a5,a5,-592 # 80d23000 <nsizes>
    80206258:	4398                	lw	a4,0(a5)
    8020625a:	fe442783          	lw	a5,-28(s0)
    8020625e:	2781                	sext.w	a5,a5
    80206260:	f4e7c0e3          	blt	a5,a4,802061a0 <bd_init+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298
  }

  // allocate the split array for each size k, except for k = 0, since
  // we will not split blocks of size k = 0, the smallest size.
  for (int k = 1; k < nsizes; k++) {
    80206264:	4785                	li	a5,1
    80206266:	fef42023          	sw	a5,-32(s0)
    8020626a:	a869                	j	80206304 <bd_init+0x24c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:299 (discriminator 3)
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    8020626c:	00b1d797          	auipc	a5,0xb1d
    80206270:	d9478793          	addi	a5,a5,-620 # 80d23000 <nsizes>
    80206274:	439c                	lw	a5,0(a5)
    80206276:	37fd                	addiw	a5,a5,-1
    80206278:	0007871b          	sext.w	a4,a5
    8020627c:	fe042783          	lw	a5,-32(s0)
    80206280:	40f707bb          	subw	a5,a4,a5
    80206284:	2781                	sext.w	a5,a5
    80206286:	4705                	li	a4,1
    80206288:	00f717bb          	sllw	a5,a4,a5
    8020628c:	2781                	sext.w	a5,a5
    8020628e:	37fd                	addiw	a5,a5,-1
    80206290:	2781                	sext.w	a5,a5
    80206292:	41f7d71b          	sraiw	a4,a5,0x1f
    80206296:	01d7571b          	srliw	a4,a4,0x1d
    8020629a:	9fb9                	addw	a5,a5,a4
    8020629c:	4037d79b          	sraiw	a5,a5,0x3
    802062a0:	2781                	sext.w	a5,a5
    802062a2:	2785                	addiw	a5,a5,1
    802062a4:	2781                	sext.w	a5,a5
    802062a6:	0037979b          	slliw	a5,a5,0x3
    802062aa:	2781                	sext.w	a5,a5
    802062ac:	838d                	srli	a5,a5,0x3
    802062ae:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:300 (discriminator 3)
    bd_sizes[k].split = p;
    802062b2:	00b1d797          	auipc	a5,0xb1d
    802062b6:	d5678793          	addi	a5,a5,-682 # 80d23008 <bd_sizes>
    802062ba:	6398                	ld	a4,0(a5)
    802062bc:	fe042783          	lw	a5,-32(s0)
    802062c0:	0796                	slli	a5,a5,0x5
    802062c2:	97ba                	add	a5,a5,a4
    802062c4:	fe843703          	ld	a4,-24(s0)
    802062c8:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:301 (discriminator 3)
    memset(bd_sizes[k].split, 0, sz);
    802062ca:	00b1d797          	auipc	a5,0xb1d
    802062ce:	d3e78793          	addi	a5,a5,-706 # 80d23008 <bd_sizes>
    802062d2:	6398                	ld	a4,0(a5)
    802062d4:	fe042783          	lw	a5,-32(s0)
    802062d8:	0796                	slli	a5,a5,0x5
    802062da:	97ba                	add	a5,a5,a4
    802062dc:	6f9c                	ld	a5,24(a5)
    802062de:	fc842703          	lw	a4,-56(s0)
    802062e2:	863a                	mv	a2,a4
    802062e4:	4581                	li	a1,0
    802062e6:	853e                	mv	a0,a5
    802062e8:	ca8fd0ef          	jal	ra,80203790 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:302 (discriminator 3)
    p += sz;
    802062ec:	fc842783          	lw	a5,-56(s0)
    802062f0:	fe843703          	ld	a4,-24(s0)
    802062f4:	97ba                	add	a5,a5,a4
    802062f6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298 (discriminator 3)
  for (int k = 1; k < nsizes; k++) {
    802062fa:	fe042783          	lw	a5,-32(s0)
    802062fe:	2785                	addiw	a5,a5,1
    80206300:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298 (discriminator 1)
    80206304:	00b1d797          	auipc	a5,0xb1d
    80206308:	cfc78793          	addi	a5,a5,-772 # 80d23000 <nsizes>
    8020630c:	4398                	lw	a4,0(a5)
    8020630e:	fe042783          	lw	a5,-32(s0)
    80206312:	2781                	sext.w	a5,a5
    80206314:	f4e7cce3          	blt	a5,a4,8020626c <bd_init+0x1b4>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:304
  }
  p = (char *)ROUNDUP((uint64_t)p, LEAF_SIZE);
    80206318:	fe843783          	ld	a5,-24(s0)
    8020631c:	17fd                	addi	a5,a5,-1
    8020631e:	8391                	srli	a5,a5,0x4
    80206320:	0785                	addi	a5,a5,1
    80206322:	0792                	slli	a5,a5,0x4
    80206324:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:308

  // done allocating; mark the memory range [base, p) as allocated, so
  // that buddy will not hand out that memory.
  int meta = bd_mark_data_structures(p);
    80206328:	fe843503          	ld	a0,-24(s0)
    8020632c:	c6fff0ef          	jal	ra,80205f9a <bd_mark_data_structures>
    80206330:	87aa                	mv	a5,a0
    80206332:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:312

  // mark the unavailable memory range [end, HEAP_SIZE) as allocated,
  // so that buddy will not hand out that memory.
  int unavailable = bd_mark_unavailable(end, p);
    80206336:	fe843583          	ld	a1,-24(s0)
    8020633a:	fb043503          	ld	a0,-80(s0)
    8020633e:	ca1ff0ef          	jal	ra,80205fde <bd_mark_unavailable>
    80206342:	87aa                	mv	a5,a0
    80206344:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:313
  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    80206348:	00b1d797          	auipc	a5,0xb1d
    8020634c:	cc878793          	addi	a5,a5,-824 # 80d23010 <bd_base>
    80206350:	6398                	ld	a4,0(a5)
    80206352:	00b1d797          	auipc	a5,0xb1d
    80206356:	cae78793          	addi	a5,a5,-850 # 80d23000 <nsizes>
    8020635a:	439c                	lw	a5,0(a5)
    8020635c:	37fd                	addiw	a5,a5,-1
    8020635e:	2781                	sext.w	a5,a5
    80206360:	46c1                	li	a3,16
    80206362:	00f697b3          	sll	a5,a3,a5
    80206366:	86be                	mv	a3,a5
    80206368:	fd842783          	lw	a5,-40(s0)
    8020636c:	40f687b3          	sub	a5,a3,a5
    80206370:	97ba                	add	a5,a5,a4
    80206372:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:316

  // initialize free lists for each size k
  int free = bd_initfree(p, bd_end);
    80206376:	fd043583          	ld	a1,-48(s0)
    8020637a:	fe843503          	ld	a0,-24(s0)
    8020637e:	b59ff0ef          	jal	ra,80205ed6 <bd_initfree>
    80206382:	87aa                	mv	a5,a0
    80206384:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:319

  // check if the amount that is free is what we expect
  if (free != BLK_SIZE(MAXSIZE) - meta - unavailable) {
    80206388:	fcc42703          	lw	a4,-52(s0)
    8020638c:	00b1d797          	auipc	a5,0xb1d
    80206390:	c7478793          	addi	a5,a5,-908 # 80d23000 <nsizes>
    80206394:	439c                	lw	a5,0(a5)
    80206396:	37fd                	addiw	a5,a5,-1
    80206398:	2781                	sext.w	a5,a5
    8020639a:	46c1                	li	a3,16
    8020639c:	00f696b3          	sll	a3,a3,a5
    802063a0:	fdc42783          	lw	a5,-36(s0)
    802063a4:	8e9d                	sub	a3,a3,a5
    802063a6:	fd842783          	lw	a5,-40(s0)
    802063aa:	40f687b3          	sub	a5,a3,a5
    802063ae:	00f70e63          	beq	a4,a5,802063ca <bd_init+0x312>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:320
    panic("bd_init: free mem\n");
    802063b2:	00003617          	auipc	a2,0x3
    802063b6:	0be60613          	addi	a2,a2,190 # 80209470 <MMIO+0x40>
    802063ba:	14000593          	li	a1,320
    802063be:	00003517          	auipc	a0,0x3
    802063c2:	09250513          	addi	a0,a0,146 # 80209450 <MMIO+0x20>
    802063c6:	2d2000ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:322
  }
}
    802063ca:	0001                	nop
    802063cc:	60a6                	ld	ra,72(sp)
    802063ce:	6406                	ld	s0,64(sp)
    802063d0:	6161                	addi	sp,sp,80
    802063d2:	8082                	ret

00000000802063d4 <print_str>:
print_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:3
#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    802063d4:	1101                	addi	sp,sp,-32
    802063d6:	ec06                	sd	ra,24(sp)
    802063d8:	e822                	sd	s0,16(sp)
    802063da:	1000                	addi	s0,sp,32
    802063dc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) 
    802063e0:	a829                	j	802063fa <print_str+0x26>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:6
    {
        console_putchar((uint64_t)(*str));
    802063e2:	fe843783          	ld	a5,-24(s0)
    802063e6:	0007c783          	lbu	a5,0(a5)
    802063ea:	853e                	mv	a0,a5
    802063ec:	f01fc0ef          	jal	ra,802032ec <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:7
        str++;
    802063f0:	fe843783          	ld	a5,-24(s0)
    802063f4:	0785                	addi	a5,a5,1
    802063f6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) 
    802063fa:	fe843783          	ld	a5,-24(s0)
    802063fe:	0007c783          	lbu	a5,0(a5)
    80206402:	f3e5                	bnez	a5,802063e2 <print_str+0xe>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:9
    }
}
    80206404:	0001                	nop
    80206406:	0001                	nop
    80206408:	60e2                	ld	ra,24(sp)
    8020640a:	6442                	ld	s0,16(sp)
    8020640c:	6105                	addi	sp,sp,32
    8020640e:	8082                	ret

0000000080206410 <reverse_str>:
reverse_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:11

void reverse_str(char* str, int length) {
    80206410:	7179                	addi	sp,sp,-48
    80206412:	f422                	sd	s0,40(sp)
    80206414:	1800                	addi	s0,sp,48
    80206416:	fca43c23          	sd	a0,-40(s0)
    8020641a:	87ae                	mv	a5,a1
    8020641c:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:12
    int start = 0;
    80206420:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    int end = length - 1;
    80206424:	fd442783          	lw	a5,-44(s0)
    80206428:	37fd                	addiw	a5,a5,-1
    8020642a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
    while (start < end) {
    8020642e:	a899                	j	80206484 <reverse_str+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:15
        char temp = str[start];
    80206430:	fec42783          	lw	a5,-20(s0)
    80206434:	fd843703          	ld	a4,-40(s0)
    80206438:	97ba                	add	a5,a5,a4
    8020643a:	0007c783          	lbu	a5,0(a5)
    8020643e:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:16
        str[start] = str[end];
    80206442:	fe842783          	lw	a5,-24(s0)
    80206446:	fd843703          	ld	a4,-40(s0)
    8020644a:	973e                	add	a4,a4,a5
    8020644c:	fec42783          	lw	a5,-20(s0)
    80206450:	fd843683          	ld	a3,-40(s0)
    80206454:	97b6                	add	a5,a5,a3
    80206456:	00074703          	lbu	a4,0(a4)
    8020645a:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:17
        str[end] = temp;
    8020645e:	fe842783          	lw	a5,-24(s0)
    80206462:	fd843703          	ld	a4,-40(s0)
    80206466:	97ba                	add	a5,a5,a4
    80206468:	fe744703          	lbu	a4,-25(s0)
    8020646c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:18
        start++;
    80206470:	fec42783          	lw	a5,-20(s0)
    80206474:	2785                	addiw	a5,a5,1
    80206476:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:19
        end--;
    8020647a:	fe842783          	lw	a5,-24(s0)
    8020647e:	37fd                	addiw	a5,a5,-1
    80206480:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
    while (start < end) {
    80206484:	fec42703          	lw	a4,-20(s0)
    80206488:	fe842783          	lw	a5,-24(s0)
    8020648c:	2701                	sext.w	a4,a4
    8020648e:	2781                	sext.w	a5,a5
    80206490:	faf740e3          	blt	a4,a5,80206430 <reverse_str+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:21
    }
}
    80206494:	0001                	nop
    80206496:	0001                	nop
    80206498:	7422                	ld	s0,40(sp)
    8020649a:	6145                	addi	sp,sp,48
    8020649c:	8082                	ret

000000008020649e <print_uint32>:
print_uint32():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:23

void print_uint32(uint32_t value) {
    8020649e:	7139                	addi	sp,sp,-64
    802064a0:	fc06                	sd	ra,56(sp)
    802064a2:	f822                	sd	s0,48(sp)
    802064a4:	0080                	addi	s0,sp,64
    802064a6:	87aa                	mv	a5,a0
    802064a8:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:25
    char buffer[12];
    int i = 0;
    802064ac:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:26
    if (value == 0) {
    802064b0:	fcc42783          	lw	a5,-52(s0)
    802064b4:	2781                	sext.w	a5,a5
    802064b6:	e3ad                	bnez	a5,80206518 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:27
        buffer[i++] = '0';
    802064b8:	fec42783          	lw	a5,-20(s0)
    802064bc:	0017871b          	addiw	a4,a5,1
    802064c0:	fee42623          	sw	a4,-20(s0)
    802064c4:	ff040713          	addi	a4,s0,-16
    802064c8:	97ba                	add	a5,a5,a4
    802064ca:	03000713          	li	a4,48
    802064ce:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
    }
    while (value != 0) {
    802064d2:	a099                	j	80206518 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:30
        int digit = value % 10;
    802064d4:	fcc42703          	lw	a4,-52(s0)
    802064d8:	47a9                	li	a5,10
    802064da:	02f777bb          	remuw	a5,a4,a5
    802064de:	2781                	sext.w	a5,a5
    802064e0:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:31
        buffer[i++] = digit + '0';
    802064e4:	fe842783          	lw	a5,-24(s0)
    802064e8:	0ff7f713          	andi	a4,a5,255
    802064ec:	fec42783          	lw	a5,-20(s0)
    802064f0:	0017869b          	addiw	a3,a5,1
    802064f4:	fed42623          	sw	a3,-20(s0)
    802064f8:	0307071b          	addiw	a4,a4,48
    802064fc:	0ff77713          	andi	a4,a4,255
    80206500:	ff040693          	addi	a3,s0,-16
    80206504:	97b6                	add	a5,a5,a3
    80206506:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:32
        value /= 10;
    8020650a:	fcc42703          	lw	a4,-52(s0)
    8020650e:	47a9                	li	a5,10
    80206510:	02f757bb          	divuw	a5,a4,a5
    80206514:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
    while (value != 0) {
    80206518:	fcc42783          	lw	a5,-52(s0)
    8020651c:	2781                	sext.w	a5,a5
    8020651e:	fbdd                	bnez	a5,802064d4 <print_uint32+0x36>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:34
    }
    buffer[i] = '\0';
    80206520:	fec42783          	lw	a5,-20(s0)
    80206524:	ff040713          	addi	a4,s0,-16
    80206528:	97ba                	add	a5,a5,a4
    8020652a:	fe078423          	sb	zero,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:35
    reverse_str(buffer, i);
    8020652e:	fec42703          	lw	a4,-20(s0)
    80206532:	fd840793          	addi	a5,s0,-40
    80206536:	85ba                	mv	a1,a4
    80206538:	853e                	mv	a0,a5
    8020653a:	ed7ff0ef          	jal	ra,80206410 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:36
    print_str(buffer);
    8020653e:	fd840793          	addi	a5,s0,-40
    80206542:	853e                	mv	a0,a5
    80206544:	e91ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:37
}
    80206548:	0001                	nop
    8020654a:	70e2                	ld	ra,56(sp)
    8020654c:	7442                	ld	s0,48(sp)
    8020654e:	6121                	addi	sp,sp,64
    80206550:	8082                	ret

0000000080206552 <print_uint64>:
print_uint64():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:40

void print_uint64(uint64_t value) 
{
    80206552:	7139                	addi	sp,sp,-64
    80206554:	fc06                	sd	ra,56(sp)
    80206556:	f822                	sd	s0,48(sp)
    80206558:	0080                	addi	s0,sp,64
    8020655a:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:42
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    8020655e:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:43
    if (value == 0) 
    80206562:	fc843783          	ld	a5,-56(s0)
    80206566:	e3a5                	bnez	a5,802065c6 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:45
    {
        buffer[i++] = '0';
    80206568:	fec42783          	lw	a5,-20(s0)
    8020656c:	0017871b          	addiw	a4,a5,1
    80206570:	fee42623          	sw	a4,-20(s0)
    80206574:	ff040713          	addi	a4,s0,-16
    80206578:	97ba                	add	a5,a5,a4
    8020657a:	03000713          	li	a4,48
    8020657e:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
    }
    while (value != 0) 
    80206582:	a091                	j	802065c6 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:49
    {
        int digit = value % 10;
    80206584:	fc843703          	ld	a4,-56(s0)
    80206588:	47a9                	li	a5,10
    8020658a:	02f777b3          	remu	a5,a4,a5
    8020658e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:50
        buffer[i++] = digit + '0';
    80206592:	fe842783          	lw	a5,-24(s0)
    80206596:	0ff7f713          	andi	a4,a5,255
    8020659a:	fec42783          	lw	a5,-20(s0)
    8020659e:	0017869b          	addiw	a3,a5,1
    802065a2:	fed42623          	sw	a3,-20(s0)
    802065a6:	0307071b          	addiw	a4,a4,48
    802065aa:	0ff77713          	andi	a4,a4,255
    802065ae:	ff040693          	addi	a3,s0,-16
    802065b2:	97b6                	add	a5,a5,a3
    802065b4:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:51
        value /= 10;
    802065b8:	fc843703          	ld	a4,-56(s0)
    802065bc:	47a9                	li	a5,10
    802065be:	02f757b3          	divu	a5,a4,a5
    802065c2:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
    while (value != 0) 
    802065c6:	fc843783          	ld	a5,-56(s0)
    802065ca:	ffcd                	bnez	a5,80206584 <print_uint64+0x32>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:53
    }
    buffer[i] = '\0';
    802065cc:	fec42783          	lw	a5,-20(s0)
    802065d0:	ff040713          	addi	a4,s0,-16
    802065d4:	97ba                	add	a5,a5,a4
    802065d6:	fe078023          	sb	zero,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:54
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    802065da:	fec42703          	lw	a4,-20(s0)
    802065de:	fd040793          	addi	a5,s0,-48
    802065e2:	85ba                	mv	a1,a4
    802065e4:	853e                	mv	a0,a5
    802065e6:	e2bff0ef          	jal	ra,80206410 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:55
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
    802065ea:	fd040793          	addi	a5,s0,-48
    802065ee:	853e                	mv	a0,a5
    802065f0:	de5ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:56
}
    802065f4:	0001                	nop
    802065f6:	70e2                	ld	ra,56(sp)
    802065f8:	7442                	ld	s0,48(sp)
    802065fa:	6121                	addi	sp,sp,64
    802065fc:	8082                	ret

00000000802065fe <print_uint64_hex>:
print_uint64_hex():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:59

void print_uint64_hex(uint64_t value) 
{
    802065fe:	7179                	addi	sp,sp,-48
    80206600:	f406                	sd	ra,40(sp)
    80206602:	f022                	sd	s0,32(sp)
    80206604:	1800                	addi	s0,sp,48
    80206606:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60
    print_str("0x"); // 打印十六进制前缀
    8020660a:	00003517          	auipc	a0,0x3
    8020660e:	e7e50513          	addi	a0,a0,-386 # 80209488 <MMIO+0x58>
    80206612:	dc3ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61
    for (int i = 15; i >= 0; i--) 
    80206616:	47bd                	li	a5,15
    80206618:	fef42623          	sw	a5,-20(s0)
    8020661c:	a09d                	j	80206682 <print_uint64_hex+0x84>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:63
    {
        int digit = (value >> (i * 4)) & 0xF; // 获取每个十六进制位
    8020661e:	fec42783          	lw	a5,-20(s0)
    80206622:	0027979b          	slliw	a5,a5,0x2
    80206626:	2781                	sext.w	a5,a5
    80206628:	873e                	mv	a4,a5
    8020662a:	fd843783          	ld	a5,-40(s0)
    8020662e:	00e7d7b3          	srl	a5,a5,a4
    80206632:	2781                	sext.w	a5,a5
    80206634:	8bbd                	andi	a5,a5,15
    80206636:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64
        char hex = digit < 10 ? '0' + digit : 'A' + digit - 10; // 转换为字符
    8020663a:	fe842783          	lw	a5,-24(s0)
    8020663e:	0007871b          	sext.w	a4,a5
    80206642:	47a5                	li	a5,9
    80206644:	00e7cb63          	blt	a5,a4,8020665a <print_uint64_hex+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 1)
    80206648:	fe842783          	lw	a5,-24(s0)
    8020664c:	0ff7f793          	andi	a5,a5,255
    80206650:	0307879b          	addiw	a5,a5,48
    80206654:	0ff7f793          	andi	a5,a5,255
    80206658:	a809                	j	8020666a <print_uint64_hex+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 2)
    8020665a:	fe842783          	lw	a5,-24(s0)
    8020665e:	0ff7f793          	andi	a5,a5,255
    80206662:	0377879b          	addiw	a5,a5,55
    80206666:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 4)
    8020666a:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:65 (discriminator 4)
        console_putchar((uint64_t)hex); // 输出字符
    8020666e:	fe744783          	lbu	a5,-25(s0)
    80206672:	853e                	mv	a0,a5
    80206674:	c79fc0ef          	jal	ra,802032ec <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 4)
    for (int i = 15; i >= 0; i--) 
    80206678:	fec42783          	lw	a5,-20(s0)
    8020667c:	37fd                	addiw	a5,a5,-1
    8020667e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 2)
    80206682:	fec42783          	lw	a5,-20(s0)
    80206686:	2781                	sext.w	a5,a5
    80206688:	f807dbe3          	bgez	a5,8020661e <print_uint64_hex+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:67
    }
    8020668c:	0001                	nop
    8020668e:	0001                	nop
    80206690:	70a2                	ld	ra,40(sp)
    80206692:	7402                	ld	s0,32(sp)
    80206694:	6145                	addi	sp,sp,48
    80206696:	8082                	ret

0000000080206698 <_panic>:
_panic():
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:4
#include "console.h"
#include "sbi.h"
// panic函数现在接收文件名和行号作为参数
void _panic(const char* file, int line, const char* msg) {
    80206698:	7179                	addi	sp,sp,-48
    8020669a:	f406                	sd	ra,40(sp)
    8020669c:	f022                	sd	s0,32(sp)
    8020669e:	1800                	addi	s0,sp,48
    802066a0:	fea43423          	sd	a0,-24(s0)
    802066a4:	87ae                	mv	a5,a1
    802066a6:	fcc43c23          	sd	a2,-40(s0)
    802066aa:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:5
    printk("PANIC in %s at line %d: %s\n", file, line, msg);
    802066ae:	fe442783          	lw	a5,-28(s0)
    802066b2:	fd843683          	ld	a3,-40(s0)
    802066b6:	863e                	mv	a2,a5
    802066b8:	fe843583          	ld	a1,-24(s0)
    802066bc:	00003517          	auipc	a0,0x3
    802066c0:	dd450513          	addi	a0,a0,-556 # 80209490 <MMIO+0x60>
    802066c4:	926fc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:6
    sbi_shutdown();
    802066c8:	c6bfc0ef          	jal	ra,80203332 <sbi_shutdown>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:7
}
    802066cc:	0001                	nop
    802066ce:	70a2                	ld	ra,40(sp)
    802066d0:	7402                	ld	s0,32(sp)
    802066d2:	6145                	addi	sp,sp,48
    802066d4:	8082                	ret

00000000802066d6 <task_control_block_get_trap_cx>:
task_control_block_get_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:19
extern void __switch(struct TaskContext**,struct TaskContext**);
extern uint64_t _num_app[];



struct TrapContext *task_control_block_get_trap_cx(struct TaskControlBlock *s) {
    802066d6:	1101                	addi	sp,sp,-32
    802066d8:	ec22                	sd	s0,24(sp)
    802066da:	1000                	addi	s0,sp,32
    802066dc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:20
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
    802066e0:	fe843783          	ld	a5,-24(s0)
    802066e4:	6b9c                	ld	a5,16(a5)
    802066e6:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:21
}
    802066e8:	853e                	mv	a0,a5
    802066ea:	6462                	ld	s0,24(sp)
    802066ec:	6105                	addi	sp,sp,32
    802066ee:	8082                	ret

00000000802066f0 <run_next_task>:
run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:39
//   TASK_MANAGER.current_task = 0;
// }


void run_next_task(uint64_t status) 
{
    802066f0:	7139                	addi	sp,sp,-64
    802066f2:	fc06                	sd	ra,56(sp)
    802066f4:	f822                	sd	s0,48(sp)
    802066f6:	0080                	addi	s0,sp,64
    802066f8:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42
    // 寻找ready的task
    uint64_t target_task_num;
    for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    802066fc:	00b1d717          	auipc	a4,0xb1d
    80206700:	91c70713          	addi	a4,a4,-1764 # 80d23018 <TASK_MANAGER>
    80206704:	6785                	lui	a5,0x1
    80206706:	97ba                	add	a5,a5,a4
    80206708:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    8020670c:	00178713          	addi	a4,a5,1
    80206710:	47d1                	li	a5,20
    80206712:	02f777b3          	remu	a5,a4,a5
    80206716:	fef43423          	sd	a5,-24(s0)
    8020671a:	a81d                	j	80206750 <run_next_task+0x60>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:43
        if (TASK_MANAGER.tasks[target_task_num].task_status == Ready) {
    8020671c:	00b1d697          	auipc	a3,0xb1d
    80206720:	8fc68693          	addi	a3,a3,-1796 # 80d23018 <TASK_MANAGER>
    80206724:	fe843703          	ld	a4,-24(s0)
    80206728:	87ba                	mv	a5,a4
    8020672a:	078e                	slli	a5,a5,0x3
    8020672c:	97ba                	add	a5,a5,a4
    8020672e:	0796                	slli	a5,a5,0x5
    80206730:	97b6                	add	a5,a5,a3
    80206732:	0907a783          	lw	a5,144(a5)
    80206736:	873e                	mv	a4,a5
    80206738:	4785                	li	a5,1
    8020673a:	02f70863          	beq	a4,a5,8020676a <run_next_task+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42 (discriminator 2)
    for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    8020673e:	fe843783          	ld	a5,-24(s0)
    80206742:	00178713          	addi	a4,a5,1
    80206746:	47d1                	li	a5,20
    80206748:	02f777b3          	remu	a5,a4,a5
    8020674c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42 (discriminator 1)
    80206750:	00b1d717          	auipc	a4,0xb1d
    80206754:	8c870713          	addi	a4,a4,-1848 # 80d23018 <TASK_MANAGER>
    80206758:	6785                	lui	a5,0x1
    8020675a:	97ba                	add	a5,a5,a4
    8020675c:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206760:	fe843703          	ld	a4,-24(s0)
    80206764:	faf71ce3          	bne	a4,a5,8020671c <run_next_task+0x2c>
    80206768:	a011                	j	8020676c <run_next_task+0x7c>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:44
            break;
    8020676a:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:48
        }
    }
    // 没有ready的任务
    if ((target_task_num == TASK_MANAGER.current_task) && (TASK_MANAGER.tasks[target_task_num].task_status != Ready)) {
    8020676c:	00b1d717          	auipc	a4,0xb1d
    80206770:	8ac70713          	addi	a4,a4,-1876 # 80d23018 <TASK_MANAGER>
    80206774:	6785                	lui	a5,0x1
    80206776:	97ba                	add	a5,a5,a4
    80206778:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    8020677c:	fe843703          	ld	a4,-24(s0)
    80206780:	02f71f63          	bne	a4,a5,802067be <run_next_task+0xce>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:48 (discriminator 1)
    80206784:	00b1d697          	auipc	a3,0xb1d
    80206788:	89468693          	addi	a3,a3,-1900 # 80d23018 <TASK_MANAGER>
    8020678c:	fe843703          	ld	a4,-24(s0)
    80206790:	87ba                	mv	a5,a4
    80206792:	078e                	slli	a5,a5,0x3
    80206794:	97ba                	add	a5,a5,a4
    80206796:	0796                	slli	a5,a5,0x5
    80206798:	97b6                	add	a5,a5,a3
    8020679a:	0907a783          	lw	a5,144(a5)
    8020679e:	873e                	mv	a4,a5
    802067a0:	4785                	li	a5,1
    802067a2:	00f70e63          	beq	a4,a5,802067be <run_next_task+0xce>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:49 (discriminator 1)
        ASSERT(0);
    802067a6:	00003617          	auipc	a2,0x3
    802067aa:	d1a60613          	addi	a2,a2,-742 # 802094c0 <MMIO+0x10>
    802067ae:	03100593          	li	a1,49
    802067b2:	00003517          	auipc	a0,0x3
    802067b6:	d2650513          	addi	a0,a0,-730 # 802094d8 <MMIO+0x28>
    802067ba:	edfff0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:52
    }

    struct TaskControlBlock* target_task_tcb = &TASK_MANAGER.tasks[target_task_num];
    802067be:	fe843703          	ld	a4,-24(s0)
    802067c2:	87ba                	mv	a5,a4
    802067c4:	078e                	slli	a5,a5,0x3
    802067c6:	97ba                	add	a5,a5,a4
    802067c8:	0796                	slli	a5,a5,0x5
    802067ca:	00b1d717          	auipc	a4,0xb1d
    802067ce:	84e70713          	addi	a4,a4,-1970 # 80d23018 <TASK_MANAGER>
    802067d2:	97ba                	add	a5,a5,a4
    802067d4:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:53
    struct TaskControlBlock* current_task_tcb = &TASK_MANAGER.tasks[TASK_MANAGER.current_task];
    802067d8:	00b1d717          	auipc	a4,0xb1d
    802067dc:	84070713          	addi	a4,a4,-1984 # 80d23018 <TASK_MANAGER>
    802067e0:	6785                	lui	a5,0x1
    802067e2:	97ba                	add	a5,a5,a4
    802067e4:	6807b703          	ld	a4,1664(a5) # 1680 <n+0x1660>
    802067e8:	87ba                	mv	a5,a4
    802067ea:	078e                	slli	a5,a5,0x3
    802067ec:	97ba                	add	a5,a5,a4
    802067ee:	0796                	slli	a5,a5,0x5
    802067f0:	00b1d717          	auipc	a4,0xb1d
    802067f4:	82870713          	addi	a4,a4,-2008 # 80d23018 <TASK_MANAGER>
    802067f8:	97ba                	add	a5,a5,a4
    802067fa:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:56

    // 改变状态
    current_task_tcb->task_status = status;
    802067fe:	fc843783          	ld	a5,-56(s0)
    80206802:	0007871b          	sext.w	a4,a5
    80206806:	fd843783          	ld	a5,-40(s0)
    8020680a:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:57
    target_task_tcb->task_status = Running;
    8020680e:	fe043783          	ld	a5,-32(s0)
    80206812:	4709                	li	a4,2
    80206814:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:58
    TASK_MANAGER.current_task = target_task_num;
    80206818:	00b1d717          	auipc	a4,0xb1d
    8020681c:	80070713          	addi	a4,a4,-2048 # 80d23018 <TASK_MANAGER>
    80206820:	6785                	lui	a5,0x1
    80206822:	97ba                	add	a5,a5,a4
    80206824:	fe843703          	ld	a4,-24(s0)
    80206828:	68e7b023          	sd	a4,1664(a5) # 1680 <n+0x1660>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:59
    __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
    8020682c:	fd843783          	ld	a5,-40(s0)
    80206830:	02078713          	addi	a4,a5,32
    80206834:	fe043783          	ld	a5,-32(s0)
    80206838:	02078793          	addi	a5,a5,32
    8020683c:	85be                	mv	a1,a5
    8020683e:	853a                	mv	a0,a4
    80206840:	483010ef          	jal	ra,802084c2 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:60
}
    80206844:	0001                	nop
    80206846:	70e2                	ld	ra,56(sp)
    80206848:	7442                	ld	s0,48(sp)
    8020684a:	6121                	addi	sp,sp,64
    8020684c:	8082                	ret

000000008020684e <task_manager_get_current_token>:
task_manager_get_current_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:74
//     ASSERT(0);
// }


uint64_t task_manager_get_current_token() 
{
    8020684e:	1101                	addi	sp,sp,-32
    80206850:	ec06                	sd	ra,24(sp)
    80206852:	e822                	sd	s0,16(sp)
    80206854:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:75
  uint64_t current = TASK_MANAGER.current_task;
    80206856:	00b1c717          	auipc	a4,0xb1c
    8020685a:	7c270713          	addi	a4,a4,1986 # 80d23018 <TASK_MANAGER>
    8020685e:	6785                	lui	a5,0x1
    80206860:	97ba                	add	a5,a5,a4
    80206862:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206866:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:76
  return get_user_token(&TASK_MANAGER.tasks[current]);
    8020686a:	fe843703          	ld	a4,-24(s0)
    8020686e:	87ba                	mv	a5,a4
    80206870:	078e                	slli	a5,a5,0x3
    80206872:	97ba                	add	a5,a5,a4
    80206874:	0796                	slli	a5,a5,0x5
    80206876:	00b1c717          	auipc	a4,0xb1c
    8020687a:	7a270713          	addi	a4,a4,1954 # 80d23018 <TASK_MANAGER>
    8020687e:	97ba                	add	a5,a5,a4
    80206880:	853e                	mv	a0,a5
    80206882:	010000ef          	jal	ra,80206892 <get_user_token>
    80206886:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:77
}
    80206888:	853e                	mv	a0,a5
    8020688a:	60e2                	ld	ra,24(sp)
    8020688c:	6442                	ld	s0,16(sp)
    8020688e:	6105                	addi	sp,sp,32
    80206890:	8082                	ret

0000000080206892 <get_user_token>:
get_user_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:81


uint64_t get_user_token(struct TaskControlBlock *s) 
{
    80206892:	1101                	addi	sp,sp,-32
    80206894:	ec06                	sd	ra,24(sp)
    80206896:	e822                	sd	s0,16(sp)
    80206898:	1000                	addi	s0,sp,32
    8020689a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:82
  return memory_set_token(&s->memory_set);
    8020689e:	fe843783          	ld	a5,-24(s0)
    802068a2:	09878793          	addi	a5,a5,152
    802068a6:	853e                	mv	a0,a5
    802068a8:	dccfd0ef          	jal	ra,80203e74 <memory_set_token>
    802068ac:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:83
}
    802068ae:	853e                	mv	a0,a5
    802068b0:	60e2                	ld	ra,24(sp)
    802068b2:	6442                	ld	s0,16(sp)
    802068b4:	6105                	addi	sp,sp,32
    802068b6:	8082                	ret

00000000802068b8 <task_control_block_new>:
task_control_block_new():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:88



void task_control_block_new(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size) {
    802068b8:	711d                	addi	sp,sp,-96
    802068ba:	ec86                	sd	ra,88(sp)
    802068bc:	e8a2                	sd	s0,80(sp)
    802068be:	e4a6                	sd	s1,72(sp)
    802068c0:	e0ca                	sd	s2,64(sp)
    802068c2:	1080                	addi	s0,sp,96
    802068c4:	faa43c23          	sd	a0,-72(s0)
    802068c8:	fab43823          	sd	a1,-80(s0)
    802068cc:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:91
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
    802068d0:	fb843783          	ld	a5,-72(s0)
    802068d4:	09878793          	addi	a5,a5,152
    802068d8:	fc040713          	addi	a4,s0,-64
    802068dc:	fc840693          	addi	a3,s0,-56
    802068e0:	fa843603          	ld	a2,-88(s0)
    802068e4:	fb043583          	ld	a1,-80(s0)
    802068e8:	853e                	mv	a0,a5
    802068ea:	905fd0ef          	jal	ra,802041ee <memory_set_from_elf>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:93
                      &entry_point);
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
    802068ee:	fb843783          	ld	a5,-72(s0)
    802068f2:	09878713          	addi	a4,a5,152
    802068f6:	77f9                	lui	a5,0xffffe
    802068f8:	00c7d593          	srli	a1,a5,0xc
    802068fc:	853a                	mv	a0,a4
    802068fe:	e11fd0ef          	jal	ra,8020470e <memory_set_translate>
    80206902:	87aa                	mv	a5,a0
    80206904:	639c                	ld	a5,0(a5)
    80206906:	00a7d713          	srli	a4,a5,0xa
    8020690a:	57fd                	li	a5,-1
    8020690c:	83d1                	srli	a5,a5,0x14
    8020690e:	8f7d                	and	a4,a4,a5
    80206910:	fb843783          	ld	a5,-72(s0)
    80206914:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:97
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // alloc a pid and a kernel stack in kernel space
  s->pid = PidAllocator_alloc();
    80206916:	fb843483          	ld	s1,-72(s0)
    8020691a:	6a3000ef          	jal	ra,802077bc <PidAllocator_alloc>
    8020691e:	e088                	sd	a0,0(s1)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:98
  kernel_stack_new(&s->kernel_stack, s->pid);
    80206920:	fb843783          	ld	a5,-72(s0)
    80206924:	00878713          	addi	a4,a5,8 # ffffffffffffe008 <ebss+0xffffffff7f2d8008>
    80206928:	fb843783          	ld	a5,-72(s0)
    8020692c:	638c                	ld	a1,0(a5)
    8020692e:	853a                	mv	a0,a4
    80206930:	1cf000ef          	jal	ra,802072fe <kernel_stack_new>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:99
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);
    80206934:	fb843783          	ld	a5,-72(s0)
    80206938:	6788                	ld	a0,8(a5)
    8020693a:	195000ef          	jal	ra,802072ce <kernel_stack_get_top>
    8020693e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:102

  // push a task context which goes to trap_return to the top of kernel stack
  s->base_size = user_sp;
    80206942:	fc843703          	ld	a4,-56(s0)
    80206946:	fb843783          	ld	a5,-72(s0)
    8020694a:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:103
  task_context_goto_trap_return(&s->task_cx, kernel_stack_top);
    8020694c:	fb843783          	ld	a5,-72(s0)
    80206950:	02078793          	addi	a5,a5,32
    80206954:	fd843583          	ld	a1,-40(s0)
    80206958:	853e                	mv	a0,a5
    8020695a:	5d7000ef          	jal	ra,80207730 <task_context_goto_trap_return>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:104
  s->task_status = Ready;
    8020695e:	fb843783          	ld	a5,-72(s0)
    80206962:	4705                	li	a4,1
    80206964:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:105
  s->parent = NULL;
    80206968:	fb843783          	ld	a5,-72(s0)
    8020696c:	0e07b023          	sd	zero,224(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:106
  vector_new(&s->children, sizeof(struct TaskControlBlock *));
    80206970:	fb843783          	ld	a5,-72(s0)
    80206974:	0e878793          	addi	a5,a5,232
    80206978:	45a1                	li	a1,8
    8020697a:	853e                	mv	a0,a5
    8020697c:	69e010ef          	jal	ra,8020801a <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:107
  s->exit_code = 0;
    80206980:	fb843783          	ld	a5,-72(s0)
    80206984:	1007a423          	sw	zero,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:110

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
    80206988:	fb843503          	ld	a0,-72(s0)
    8020698c:	d4bff0ef          	jal	ra,802066d6 <task_control_block_get_trap_cx>
    80206990:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:111
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
    80206994:	fc043483          	ld	s1,-64(s0)
    80206998:	fc843903          	ld	s2,-56(s0)
    8020699c:	e1bfd0ef          	jal	ra,802047b6 <kernel_space_token>
    802069a0:	862a                	mv	a2,a0
    802069a2:	00001717          	auipc	a4,0x1
    802069a6:	fa470713          	addi	a4,a4,-92 # 80207946 <trap_handler>
    802069aa:	fd043783          	ld	a5,-48(s0)
    802069ae:	fd843683          	ld	a3,-40(s0)
    802069b2:	85ca                	mv	a1,s2
    802069b4:	8526                	mv	a0,s1
    802069b6:	4c9000ef          	jal	ra,8020767e <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:114
                   (uint64_t)trap_handler, trap_cx);

  s->priority = DEFAULT_PRIORITY;
    802069ba:	fb843783          	ld	a5,-72(s0)
    802069be:	4741                	li	a4,16
    802069c0:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:115
  s->stride = 0;
    802069c4:	fb843783          	ld	a5,-72(s0)
    802069c8:	1007bc23          	sd	zero,280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:116
}
    802069cc:	0001                	nop
    802069ce:	60e6                	ld	ra,88(sp)
    802069d0:	6446                	ld	s0,80(sp)
    802069d2:	64a6                	ld	s1,72(sp)
    802069d4:	6906                	ld	s2,64(sp)
    802069d6:	6125                	addi	sp,sp,96
    802069d8:	8082                	ret

00000000802069da <task_current_trap_cx>:
task_current_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:120


struct TrapContext *task_current_trap_cx()
{
    802069da:	1141                	addi	sp,sp,-16
    802069dc:	e406                	sd	ra,8(sp)
    802069de:	e022                	sd	s0,0(sp)
    802069e0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:121
  return task_manager_get_current_trap_cx();
    802069e2:	414000ef          	jal	ra,80206df6 <task_manager_get_current_trap_cx>
    802069e6:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:122
}
    802069e8:	853e                	mv	a0,a5
    802069ea:	60a2                	ld	ra,8(sp)
    802069ec:	6402                	ld	s0,0(sp)
    802069ee:	0141                	addi	sp,sp,16
    802069f0:	8082                	ret

00000000802069f2 <get_task_cx_ptr2>:
get_task_cx_ptr2():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:125

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s) 
{
    802069f2:	1101                	addi	sp,sp,-32
    802069f4:	ec22                	sd	s0,24(sp)
    802069f6:	1000                	addi	s0,sp,32
    802069f8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:126
  return (struct TaskContext **)(&(s->task_cx));
    802069fc:	fe843783          	ld	a5,-24(s0)
    80206a00:	02078793          	addi	a5,a5,32
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:127
}
    80206a04:	853e                	mv	a0,a5
    80206a06:	6462                	ld	s0,24(sp)
    80206a08:	6105                	addi	sp,sp,32
    80206a0a:	8082                	ret

0000000080206a0c <get_status>:
get_status():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:129

enum TaskStatus get_status(struct TaskControlBlock* self) {
    80206a0c:	1101                	addi	sp,sp,-32
    80206a0e:	ec22                	sd	s0,24(sp)
    80206a10:	1000                	addi	s0,sp,32
    80206a12:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:130
    return self->task_status;
    80206a16:	fe843783          	ld	a5,-24(s0)
    80206a1a:	0907a783          	lw	a5,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:131
}
    80206a1e:	853e                	mv	a0,a5
    80206a20:	6462                	ld	s0,24(sp)
    80206a22:	6105                	addi	sp,sp,32
    80206a24:	8082                	ret

0000000080206a26 <is_zombie>:
is_zombie():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:134

int is_zombie(struct TaskControlBlock* self) 
{
    80206a26:	1101                	addi	sp,sp,-32
    80206a28:	ec06                	sd	ra,24(sp)
    80206a2a:	e822                	sd	s0,16(sp)
    80206a2c:	1000                	addi	s0,sp,32
    80206a2e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:135
    return get_status(self) == Zombie;
    80206a32:	fe843503          	ld	a0,-24(s0)
    80206a36:	fd7ff0ef          	jal	ra,80206a0c <get_status>
    80206a3a:	87aa                	mv	a5,a0
    80206a3c:	2781                	sext.w	a5,a5
    80206a3e:	873e                	mv	a4,a5
    80206a40:	4791                	li	a5,4
    80206a42:	40f707b3          	sub	a5,a4,a5
    80206a46:	0017b793          	seqz	a5,a5
    80206a4a:	0ff7f793          	andi	a5,a5,255
    80206a4e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:136
}
    80206a50:	853e                	mv	a0,a5
    80206a52:	60e2                	ld	ra,24(sp)
    80206a54:	6442                	ld	s0,16(sp)
    80206a56:	6105                	addi	sp,sp,32
    80206a58:	8082                	ret

0000000080206a5a <getpid>:
getpid():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:140


uint64_t getpid(struct TaskControlBlock* self) 
{
    80206a5a:	1101                	addi	sp,sp,-32
    80206a5c:	ec22                	sd	s0,24(sp)
    80206a5e:	1000                	addi	s0,sp,32
    80206a60:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:141
    return self->pid.pid;
    80206a64:	fe843783          	ld	a5,-24(s0)
    80206a68:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:142
}
    80206a6a:	853e                	mv	a0,a5
    80206a6c:	6462                	ld	s0,24(sp)
    80206a6e:	6105                	addi	sp,sp,32
    80206a70:	8082                	ret

0000000080206a72 <task_context_zero_init>:
task_context_zero_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:147



void task_context_zero_init(struct TaskContext *cx) 
{
    80206a72:	7179                	addi	sp,sp,-48
    80206a74:	f422                	sd	s0,40(sp)
    80206a76:	1800                	addi	s0,sp,48
    80206a78:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:148
  cx->ra = 0;
    80206a7c:	fd843783          	ld	a5,-40(s0)
    80206a80:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:149
  cx->sp = 0;
    80206a84:	fd843783          	ld	a5,-40(s0)
    80206a88:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:150
  for (int i = 0; i < 12; i++) {
    80206a8c:	fe042623          	sw	zero,-20(s0)
    80206a90:	a839                	j	80206aae <task_context_zero_init+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:151 (discriminator 3)
    cx->x[i] = 0;
    80206a92:	fd843703          	ld	a4,-40(s0)
    80206a96:	fec42783          	lw	a5,-20(s0)
    80206a9a:	0789                	addi	a5,a5,2
    80206a9c:	078e                	slli	a5,a5,0x3
    80206a9e:	97ba                	add	a5,a5,a4
    80206aa0:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:150 (discriminator 3)
  for (int i = 0; i < 12; i++) {
    80206aa4:	fec42783          	lw	a5,-20(s0)
    80206aa8:	2785                	addiw	a5,a5,1
    80206aaa:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:150 (discriminator 1)
    80206aae:	fec42783          	lw	a5,-20(s0)
    80206ab2:	0007871b          	sext.w	a4,a5
    80206ab6:	47ad                	li	a5,11
    80206ab8:	fce7dde3          	bge	a5,a4,80206a92 <task_context_zero_init+0x20>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:153
  }
}
    80206abc:	0001                	nop
    80206abe:	0001                	nop
    80206ac0:	7422                	ld	s0,40(sp)
    80206ac2:	6145                	addi	sp,sp,48
    80206ac4:	8082                	ret

0000000080206ac6 <task_control_block_get_user_token>:
task_control_block_get_user_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:156


uint64_t task_control_block_get_user_token(struct TaskControlBlock *s) {
    80206ac6:	1101                	addi	sp,sp,-32
    80206ac8:	ec06                	sd	ra,24(sp)
    80206aca:	e822                	sd	s0,16(sp)
    80206acc:	1000                	addi	s0,sp,32
    80206ace:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:157
  return memory_set_token(&s->memory_set);
    80206ad2:	fe843783          	ld	a5,-24(s0)
    80206ad6:	09878793          	addi	a5,a5,152
    80206ada:	853e                	mv	a0,a5
    80206adc:	b98fd0ef          	jal	ra,80203e74 <memory_set_token>
    80206ae0:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:158
}
    80206ae2:	853e                	mv	a0,a5
    80206ae4:	60e2                	ld	ra,24(sp)
    80206ae6:	6442                	ld	s0,16(sp)
    80206ae8:	6105                	addi	sp,sp,32
    80206aea:	8082                	ret

0000000080206aec <taks_init>:
taks_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:162


void taks_init()
{
    80206aec:	1101                	addi	sp,sp,-32
    80206aee:	ec06                	sd	ra,24(sp)
    80206af0:	e822                	sd	s0,16(sp)
    80206af2:	e426                	sd	s1,8(sp)
    80206af4:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:163
    PidAllocator_init(&PID_ALLOCATOR);
    80206af6:	00b1e517          	auipc	a0,0xb1e
    80206afa:	39a50513          	addi	a0,a0,922 # 80d24e90 <PID_ALLOCATOR>
    80206afe:	493000ef          	jal	ra,80207790 <PidAllocator_init>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:164
    task_manager_init_2();
    80206b02:	062000ef          	jal	ra,80206b64 <task_manager_init_2>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:165
    task_control_block_new(&INITPROC, loader_get_app_data_by_name("initproc"),
    80206b06:	00003517          	auipc	a0,0x3
    80206b0a:	9f250513          	addi	a0,a0,-1550 # 802094f8 <MMIO+0x48>
    80206b0e:	215000ef          	jal	ra,80207522 <loader_get_app_data_by_name>
    80206b12:	84aa                	mv	s1,a0
    80206b14:	00003517          	auipc	a0,0x3
    80206b18:	9e450513          	addi	a0,a0,-1564 # 802094f8 <MMIO+0x48>
    80206b1c:	277000ef          	jal	ra,80207592 <loader_get_app_size_by_name>
    80206b20:	87aa                	mv	a5,a0
    80206b22:	863e                	mv	a2,a5
    80206b24:	85a6                	mv	a1,s1
    80206b26:	00b1e517          	auipc	a0,0xb1e
    80206b2a:	b8250513          	addi	a0,a0,-1150 # 80d246a8 <INITPROC>
    80206b2e:	d8bff0ef          	jal	ra,802068b8 <task_control_block_new>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:167
                         loader_get_app_size_by_name("initproc"));
}
    80206b32:	0001                	nop
    80206b34:	60e2                	ld	ra,24(sp)
    80206b36:	6442                	ld	s0,16(sp)
    80206b38:	64a2                	ld	s1,8(sp)
    80206b3a:	6105                	addi	sp,sp,32
    80206b3c:	8082                	ret

0000000080206b3e <task_manager_add_2_initproc>:
task_manager_add_2_initproc():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:172



void task_manager_add_2_initproc()
{
    80206b3e:	1141                	addi	sp,sp,-16
    80206b40:	e406                	sd	ra,8(sp)
    80206b42:	e022                	sd	s0,0(sp)
    80206b44:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:173
  task_manager_add_2(&TASK_MANAGER_2,&INITPROC);
    80206b46:	00b1e597          	auipc	a1,0xb1e
    80206b4a:	b6258593          	addi	a1,a1,-1182 # 80d246a8 <INITPROC>
    80206b4e:	00b1e517          	auipc	a0,0xb1e
    80206b52:	77a50513          	addi	a0,a0,1914 # 80d252c8 <TASK_MANAGER_2>
    80206b56:	064000ef          	jal	ra,80206bba <task_manager_add_2>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:174
    80206b5a:	0001                	nop
    80206b5c:	60a2                	ld	ra,8(sp)
    80206b5e:	6402                	ld	s0,0(sp)
    80206b60:	0141                	addi	sp,sp,16
    80206b62:	8082                	ret

0000000080206b64 <task_manager_init_2>:
task_manager_init_2():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:6
#include "taskmanager.h"
#include "mem.h"
TaskManager_2 TASK_MANAGER_2;

void task_manager_init_2()
{
    80206b64:	1141                	addi	sp,sp,-16
    80206b66:	e406                	sd	ra,8(sp)
    80206b68:	e022                	sd	s0,0(sp)
    80206b6a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:7
    TASK_MANAGER_2.ready_queue = bd_malloc(sizeof(Queue *));
    80206b6c:	4521                	li	a0,8
    80206b6e:	d61fe0ef          	jal	ra,802058ce <bd_malloc>
    80206b72:	872a                	mv	a4,a0
    80206b74:	00b1e797          	auipc	a5,0xb1e
    80206b78:	75478793          	addi	a5,a5,1876 # 80d252c8 <TASK_MANAGER_2>
    80206b7c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:8
    if(TASK_MANAGER_2.ready_queue == NULL) ASSERT(0);
    80206b7e:	00b1e797          	auipc	a5,0xb1e
    80206b82:	74a78793          	addi	a5,a5,1866 # 80d252c8 <TASK_MANAGER_2>
    80206b86:	639c                	ld	a5,0(a5)
    80206b88:	ef81                	bnez	a5,80206ba0 <task_manager_init_2+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:8 (discriminator 2)
    80206b8a:	00003617          	auipc	a2,0x3
    80206b8e:	98e60613          	addi	a2,a2,-1650 # 80209518 <MMIO+0x10>
    80206b92:	45a1                	li	a1,8
    80206b94:	00003517          	auipc	a0,0x3
    80206b98:	99c50513          	addi	a0,a0,-1636 # 80209530 <MMIO+0x28>
    80206b9c:	afdff0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:9
    queue_init(TASK_MANAGER_2.ready_queue);
    80206ba0:	00b1e797          	auipc	a5,0xb1e
    80206ba4:	72878793          	addi	a5,a5,1832 # 80d252c8 <TASK_MANAGER_2>
    80206ba8:	639c                	ld	a5,0(a5)
    80206baa:	853e                	mv	a0,a5
    80206bac:	762010ef          	jal	ra,8020830e <queue_init>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:10
}
    80206bb0:	0001                	nop
    80206bb2:	60a2                	ld	ra,8(sp)
    80206bb4:	6402                	ld	s0,0(sp)
    80206bb6:	0141                	addi	sp,sp,16
    80206bb8:	8082                	ret

0000000080206bba <task_manager_add_2>:
task_manager_add_2():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:13

void task_manager_add_2(TaskManager_2* manager, void* task) 
{
    80206bba:	1101                	addi	sp,sp,-32
    80206bbc:	ec06                	sd	ra,24(sp)
    80206bbe:	e822                	sd	s0,16(sp)
    80206bc0:	1000                	addi	s0,sp,32
    80206bc2:	fea43423          	sd	a0,-24(s0)
    80206bc6:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:14
    queue_enqueue(manager->ready_queue, task);
    80206bca:	fe843783          	ld	a5,-24(s0)
    80206bce:	639c                	ld	a5,0(a5)
    80206bd0:	fe043583          	ld	a1,-32(s0)
    80206bd4:	853e                	mv	a0,a5
    80206bd6:	762010ef          	jal	ra,80208338 <queue_enqueue>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:15
}
    80206bda:	0001                	nop
    80206bdc:	60e2                	ld	ra,24(sp)
    80206bde:	6442                	ld	s0,16(sp)
    80206be0:	6105                	addi	sp,sp,32
    80206be2:	8082                	ret

0000000080206be4 <task_manager_fetch_2>:
task_manager_fetch_2():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:18

void* task_manager_fetch_2(TaskManager_2* manager) 
{
    80206be4:	1101                	addi	sp,sp,-32
    80206be6:	ec06                	sd	ra,24(sp)
    80206be8:	e822                	sd	s0,16(sp)
    80206bea:	1000                	addi	s0,sp,32
    80206bec:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:19
    return queue_dequeue(manager->ready_queue);
    80206bf0:	fe843783          	ld	a5,-24(s0)
    80206bf4:	639c                	ld	a5,0(a5)
    80206bf6:	853e                	mv	a0,a5
    80206bf8:	7da010ef          	jal	ra,802083d2 <queue_dequeue>
    80206bfc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:20
}
    80206bfe:	853e                	mv	a0,a5
    80206c00:	60e2                	ld	ra,24(sp)
    80206c02:	6442                	ld	s0,16(sp)
    80206c04:	6105                	addi	sp,sp,32
    80206c06:	8082                	ret

0000000080206c08 <task_manager_fetch_task>:
task_manager_fetch_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:23


struct TaskControlBlock *task_manager_fetch_task() {
    80206c08:	1141                	addi	sp,sp,-16
    80206c0a:	e406                	sd	ra,8(sp)
    80206c0c:	e022                	sd	s0,0(sp)
    80206c0e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:24
  return task_manager_fetch_2(&TASK_MANAGER_2);
    80206c10:	00b1e517          	auipc	a0,0xb1e
    80206c14:	6b850513          	addi	a0,a0,1720 # 80d252c8 <TASK_MANAGER_2>
    80206c18:	fcdff0ef          	jal	ra,80206be4 <task_manager_fetch_2>
    80206c1c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/taskmanager.c:25
}
    80206c1e:	853e                	mv	a0,a5
    80206c20:	60a2                	ld	ra,8(sp)
    80206c22:	6402                	ld	s0,0(sp)
    80206c24:	0141                	addi	sp,sp,16
    80206c26:	8082                	ret

0000000080206c28 <init_appmanager>:
init_appmanager():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:13
#include "mem.h"
#include "task.h"
struct AppManager app_manager;
extern struct TaskManager TASK_MANAGER;
void init_appmanager()
{
    80206c28:	1101                	addi	sp,sp,-32
    80206c2a:	ec06                	sd	ra,24(sp)
    80206c2c:	e822                	sd	s0,16(sp)
    80206c2e:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:14
    app_manager.app_num = _num_app[0];
    80206c30:	00003797          	auipc	a5,0x3
    80206c34:	40878793          	addi	a5,a5,1032 # 8020a038 <_num_app>
    80206c38:	6398                	ld	a4,0(a5)
    80206c3a:	00b1e797          	auipc	a5,0xb1e
    80206c3e:	b8e78793          	addi	a5,a5,-1138 # 80d247c8 <app_manager>
    80206c42:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80206c44:	fe043423          	sd	zero,-24(s0)
    80206c48:	a085                	j	80206ca8 <init_appmanager+0x80>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:17 (discriminator 3)
    {
        app_manager.app_start[i] = _num_app[1 + i * 2];
    80206c4a:	fe843783          	ld	a5,-24(s0)
    80206c4e:	0786                	slli	a5,a5,0x1
    80206c50:	0785                	addi	a5,a5,1
    80206c52:	00003717          	auipc	a4,0x3
    80206c56:	3e670713          	addi	a4,a4,998 # 8020a038 <_num_app>
    80206c5a:	078e                	slli	a5,a5,0x3
    80206c5c:	97ba                	add	a5,a5,a4
    80206c5e:	6398                	ld	a4,0(a5)
    80206c60:	00b1e697          	auipc	a3,0xb1e
    80206c64:	b6868693          	addi	a3,a3,-1176 # 80d247c8 <app_manager>
    80206c68:	fe843783          	ld	a5,-24(s0)
    80206c6c:	0789                	addi	a5,a5,2
    80206c6e:	078e                	slli	a5,a5,0x3
    80206c70:	97b6                	add	a5,a5,a3
    80206c72:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:18 (discriminator 3)
        app_manager.app_end[i] = _num_app[2 + i * 2];
    80206c74:	fe843783          	ld	a5,-24(s0)
    80206c78:	0785                	addi	a5,a5,1
    80206c7a:	0786                	slli	a5,a5,0x1
    80206c7c:	00003717          	auipc	a4,0x3
    80206c80:	3bc70713          	addi	a4,a4,956 # 8020a038 <_num_app>
    80206c84:	078e                	slli	a5,a5,0x3
    80206c86:	97ba                	add	a5,a5,a4
    80206c88:	6398                	ld	a4,0(a5)
    80206c8a:	00b1e697          	auipc	a3,0xb1e
    80206c8e:	b3e68693          	addi	a3,a3,-1218 # 80d247c8 <app_manager>
    80206c92:	fe843783          	ld	a5,-24(s0)
    80206c96:	07d9                	addi	a5,a5,22
    80206c98:	078e                	slli	a5,a5,0x3
    80206c9a:	97b6                	add	a5,a5,a3
    80206c9c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 3)
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80206c9e:	fe843783          	ld	a5,-24(s0)
    80206ca2:	0785                	addi	a5,a5,1
    80206ca4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 1)
    80206ca8:	00b1e797          	auipc	a5,0xb1e
    80206cac:	b2078793          	addi	a5,a5,-1248 # 80d247c8 <app_manager>
    80206cb0:	639c                	ld	a5,0(a5)
    80206cb2:	fe843703          	ld	a4,-24(s0)
    80206cb6:	f8f76ae3          	bltu	a4,a5,80206c4a <init_appmanager+0x22>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:20
    }
    app_manager.current_app = 0;
    80206cba:	00b1e797          	auipc	a5,0xb1e
    80206cbe:	b0e78793          	addi	a5,a5,-1266 # 80d247c8 <app_manager>
    80206cc2:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:21
    print_app_info(&app_manager);
    80206cc6:	00b1e517          	auipc	a0,0xb1e
    80206cca:	b0250513          	addi	a0,a0,-1278 # 80d247c8 <app_manager>
    80206cce:	00e000ef          	jal	ra,80206cdc <print_app_info>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:22
}
    80206cd2:	0001                	nop
    80206cd4:	60e2                	ld	ra,24(sp)
    80206cd6:	6442                	ld	s0,16(sp)
    80206cd8:	6105                	addi	sp,sp,32
    80206cda:	8082                	ret

0000000080206cdc <print_app_info>:
print_app_info():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:25


void print_app_info(struct AppManager *manager) {
    80206cdc:	7179                	addi	sp,sp,-48
    80206cde:	f406                	sd	ra,40(sp)
    80206ce0:	f022                	sd	s0,32(sp)
    80206ce2:	1800                	addi	s0,sp,48
    80206ce4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:26
    print_str("Total applications: ");
    80206ce8:	00003517          	auipc	a0,0x3
    80206cec:	87850513          	addi	a0,a0,-1928 # 80209560 <MMIO+0x10>
    80206cf0:	ee4ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:27
    print_uint64(manager->app_num);
    80206cf4:	fd843783          	ld	a5,-40(s0)
    80206cf8:	639c                	ld	a5,0(a5)
    80206cfa:	853e                	mv	a0,a5
    80206cfc:	857ff0ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:28
    print_str("\n");
    80206d00:	00003517          	auipc	a0,0x3
    80206d04:	87850513          	addi	a0,a0,-1928 # 80209578 <MMIO+0x28>
    80206d08:	eccff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30

    for (uint64_t i = 0; i < manager->app_num; ++i) {
    80206d0c:	fe043423          	sd	zero,-24(s0)
    80206d10:	a885                	j	80206d80 <print_app_info+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:31 (discriminator 3)
        print_str("App ");
    80206d12:	00003517          	auipc	a0,0x3
    80206d16:	86e50513          	addi	a0,a0,-1938 # 80209580 <MMIO+0x30>
    80206d1a:	ebaff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:32 (discriminator 3)
        print_uint64(i);
    80206d1e:	fe843503          	ld	a0,-24(s0)
    80206d22:	831ff0ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:33 (discriminator 3)
        print_str(":\n  Start Address: ");
    80206d26:	00003517          	auipc	a0,0x3
    80206d2a:	86250513          	addi	a0,a0,-1950 # 80209588 <MMIO+0x38>
    80206d2e:	ea6ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:34 (discriminator 3)
        print_uint64(manager->app_start[i]);
    80206d32:	fd843703          	ld	a4,-40(s0)
    80206d36:	fe843783          	ld	a5,-24(s0)
    80206d3a:	0789                	addi	a5,a5,2
    80206d3c:	078e                	slli	a5,a5,0x3
    80206d3e:	97ba                	add	a5,a5,a4
    80206d40:	639c                	ld	a5,0(a5)
    80206d42:	853e                	mv	a0,a5
    80206d44:	80fff0ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:35 (discriminator 3)
        print_str("\n  End Address:   ");
    80206d48:	00003517          	auipc	a0,0x3
    80206d4c:	85850513          	addi	a0,a0,-1960 # 802095a0 <MMIO+0x50>
    80206d50:	e84ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:36 (discriminator 3)
        print_uint64(manager->app_end[i]);
    80206d54:	fd843703          	ld	a4,-40(s0)
    80206d58:	fe843783          	ld	a5,-24(s0)
    80206d5c:	07d9                	addi	a5,a5,22
    80206d5e:	078e                	slli	a5,a5,0x3
    80206d60:	97ba                	add	a5,a5,a4
    80206d62:	639c                	ld	a5,0(a5)
    80206d64:	853e                	mv	a0,a5
    80206d66:	fecff0ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:37 (discriminator 3)
        print_str("\n");
    80206d6a:	00003517          	auipc	a0,0x3
    80206d6e:	80e50513          	addi	a0,a0,-2034 # 80209578 <MMIO+0x28>
    80206d72:	e62ff0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 3)
    for (uint64_t i = 0; i < manager->app_num; ++i) {
    80206d76:	fe843783          	ld	a5,-24(s0)
    80206d7a:	0785                	addi	a5,a5,1
    80206d7c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 1)
    80206d80:	fd843783          	ld	a5,-40(s0)
    80206d84:	639c                	ld	a5,0(a5)
    80206d86:	fe843703          	ld	a4,-24(s0)
    80206d8a:	f8f764e3          	bltu	a4,a5,80206d12 <print_app_info+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:39
    }
}
    80206d8e:	0001                	nop
    80206d90:	0001                	nop
    80206d92:	70a2                	ld	ra,40(sp)
    80206d94:	7402                	ld	s0,32(sp)
    80206d96:	6145                	addi	sp,sp,48
    80206d98:	8082                	ret

0000000080206d9a <get_trap_cx>:
get_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:42

struct TrapContext *get_trap_cx(struct TaskControlBlock *s) 
{
    80206d9a:	1101                	addi	sp,sp,-32
    80206d9c:	ec22                	sd	s0,24(sp)
    80206d9e:	1000                	addi	s0,sp,32
    80206da0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:43
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
    80206da4:	fe843783          	ld	a5,-24(s0)
    80206da8:	6b9c                	ld	a5,16(a5)
    80206daa:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:44
}
    80206dac:	853e                	mv	a0,a5
    80206dae:	6462                	ld	s0,24(sp)
    80206db0:	6105                	addi	sp,sp,32
    80206db2:	8082                	ret

0000000080206db4 <run_first_app>:
run_first_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:67
//     //__restore(trapcontext);
//     __restore((uint64_t)cx);
// }

void run_first_app()
{
    80206db4:	1101                	addi	sp,sp,-32
    80206db6:	ec06                	sd	ra,24(sp)
    80206db8:	e822                	sd	s0,16(sp)
    80206dba:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:70
    extern void __switch(struct TaskContext **current_task_cx_ptr2,
                       struct TaskContext **next_task_cx_ptr2);
    TASK_MANAGER.tasks[0].task_status = Running;
    80206dbc:	00b1c797          	auipc	a5,0xb1c
    80206dc0:	25c78793          	addi	a5,a5,604 # 80d23018 <TASK_MANAGER>
    80206dc4:	4709                	li	a4,2
    80206dc6:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:72
  struct TaskContext **next_task_cx_ptr2 =
      get_task_cx_ptr2(&(TASK_MANAGER.tasks[0]));
    80206dca:	00b1c517          	auipc	a0,0xb1c
    80206dce:	24e50513          	addi	a0,a0,590 # 80d23018 <TASK_MANAGER>
    80206dd2:	c21ff0ef          	jal	ra,802069f2 <get_task_cx_ptr2>
    80206dd6:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:73
  uint64_t _unused = 0;
    80206dda:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:75
  //printk("run_fisrt_app_end\n");
  __switch((struct TaskContext **)&_unused, next_task_cx_ptr2);
    80206dde:	fe040793          	addi	a5,s0,-32
    80206de2:	fe843583          	ld	a1,-24(s0)
    80206de6:	853e                	mv	a0,a5
    80206de8:	6da010ef          	jal	ra,802084c2 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76
}
    80206dec:	0001                	nop
    80206dee:	60e2                	ld	ra,24(sp)
    80206df0:	6442                	ld	s0,16(sp)
    80206df2:	6105                	addi	sp,sp,32
    80206df4:	8082                	ret

0000000080206df6 <task_manager_get_current_trap_cx>:
task_manager_get_current_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:109
//     }
// }


struct TrapContext *task_manager_get_current_trap_cx() 
{
    80206df6:	1101                	addi	sp,sp,-32
    80206df8:	ec06                	sd	ra,24(sp)
    80206dfa:	e822                	sd	s0,16(sp)
    80206dfc:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:110
  uint64_t current = TASK_MANAGER.current_task;
    80206dfe:	00b1c717          	auipc	a4,0xb1c
    80206e02:	21a70713          	addi	a4,a4,538 # 80d23018 <TASK_MANAGER>
    80206e06:	6785                	lui	a5,0x1
    80206e08:	97ba                	add	a5,a5,a4
    80206e0a:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206e0e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:111
  return get_trap_cx(&TASK_MANAGER.tasks[current]);
    80206e12:	fe843703          	ld	a4,-24(s0)
    80206e16:	87ba                	mv	a5,a4
    80206e18:	078e                	slli	a5,a5,0x3
    80206e1a:	97ba                	add	a5,a5,a4
    80206e1c:	0796                	slli	a5,a5,0x5
    80206e1e:	00b1c717          	auipc	a4,0xb1c
    80206e22:	1fa70713          	addi	a4,a4,506 # 80d23018 <TASK_MANAGER>
    80206e26:	97ba                	add	a5,a5,a4
    80206e28:	853e                	mv	a0,a5
    80206e2a:	f71ff0ef          	jal	ra,80206d9a <get_trap_cx>
    80206e2e:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:112
}
    80206e30:	853e                	mv	a0,a5
    80206e32:	60e2                	ld	ra,24(sp)
    80206e34:	6442                	ld	s0,16(sp)
    80206e36:	6105                	addi	sp,sp,32
    80206e38:	8082                	ret

0000000080206e3a <task_control_block_free>:
task_control_block_free():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:114

void task_control_block_free(struct TaskControlBlock *s) {
    80206e3a:	1101                	addi	sp,sp,-32
    80206e3c:	ec06                	sd	ra,24(sp)
    80206e3e:	e822                	sd	s0,16(sp)
    80206e40:	1000                	addi	s0,sp,32
    80206e42:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:115
  memory_set_free(&s->memory_set);
    80206e46:	fe843783          	ld	a5,-24(s0)
    80206e4a:	09878793          	addi	a5,a5,152
    80206e4e:	853e                	mv	a0,a5
    80206e50:	99afd0ef          	jal	ra,80203fea <memory_set_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:116
}
    80206e54:	0001                	nop
    80206e56:	60e2                	ld	ra,24(sp)
    80206e58:	6442                	ld	s0,16(sp)
    80206e5a:	6105                	addi	sp,sp,32
    80206e5c:	8082                	ret

0000000080206e5e <task_manager_mark_current_exited>:
task_manager_mark_current_exited():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:119

void task_manager_mark_current_exited() 
{
    80206e5e:	1101                	addi	sp,sp,-32
    80206e60:	ec06                	sd	ra,24(sp)
    80206e62:	e822                	sd	s0,16(sp)
    80206e64:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:120
  uint64_t current = TASK_MANAGER.current_task;
    80206e66:	00b1c717          	auipc	a4,0xb1c
    80206e6a:	1b270713          	addi	a4,a4,434 # 80d23018 <TASK_MANAGER>
    80206e6e:	6785                	lui	a5,0x1
    80206e70:	97ba                	add	a5,a5,a4
    80206e72:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206e76:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:121
  task_control_block_free(&TASK_MANAGER.tasks[current]);
    80206e7a:	fe843703          	ld	a4,-24(s0)
    80206e7e:	87ba                	mv	a5,a4
    80206e80:	078e                	slli	a5,a5,0x3
    80206e82:	97ba                	add	a5,a5,a4
    80206e84:	0796                	slli	a5,a5,0x5
    80206e86:	00b1c717          	auipc	a4,0xb1c
    80206e8a:	19270713          	addi	a4,a4,402 # 80d23018 <TASK_MANAGER>
    80206e8e:	97ba                	add	a5,a5,a4
    80206e90:	853e                	mv	a0,a5
    80206e92:	fa9ff0ef          	jal	ra,80206e3a <task_control_block_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:122
  TASK_MANAGER.tasks[current].task_status = Exited;
    80206e96:	00b1c697          	auipc	a3,0xb1c
    80206e9a:	18268693          	addi	a3,a3,386 # 80d23018 <TASK_MANAGER>
    80206e9e:	fe843703          	ld	a4,-24(s0)
    80206ea2:	87ba                	mv	a5,a4
    80206ea4:	078e                	slli	a5,a5,0x3
    80206ea6:	97ba                	add	a5,a5,a4
    80206ea8:	0796                	slli	a5,a5,0x5
    80206eaa:	97b6                	add	a5,a5,a3
    80206eac:	470d                	li	a4,3
    80206eae:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:123
}
    80206eb2:	0001                	nop
    80206eb4:	60e2                	ld	ra,24(sp)
    80206eb6:	6442                	ld	s0,16(sp)
    80206eb8:	6105                	addi	sp,sp,32
    80206eba:	8082                	ret

0000000080206ebc <task_manager_find_next_task>:
task_manager_find_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:126

int64_t task_manager_find_next_task()
{
    80206ebc:	715d                	addi	sp,sp,-80
    80206ebe:	e4a2                	sd	s0,72(sp)
    80206ec0:	0880                	addi	s0,sp,80
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:127
  uint64_t num_app = TASK_MANAGER.num_app;
    80206ec2:	00b1c717          	auipc	a4,0xb1c
    80206ec6:	15670713          	addi	a4,a4,342 # 80d23018 <TASK_MANAGER>
    80206eca:	6785                	lui	a5,0x1
    80206ecc:	97ba                	add	a5,a5,a4
    80206ece:	6887b783          	ld	a5,1672(a5) # 1688 <n+0x1668>
    80206ed2:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:128
  uint64_t min_stride = __UINT64_MAX__;
    80206ed6:	57fd                	li	a5,-1
    80206ed8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:129
  int64_t min_id = -1;
    80206edc:	57fd                	li	a5,-1
    80206ede:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:130
  uint64_t start_id = (TASK_MANAGER.current_task + 1) % num_app; // Start from the next task of the current task.
    80206ee2:	00b1c717          	auipc	a4,0xb1c
    80206ee6:	13670713          	addi	a4,a4,310 # 80d23018 <TASK_MANAGER>
    80206eea:	6785                	lui	a5,0x1
    80206eec:	97ba                	add	a5,a5,a4
    80206eee:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206ef2:	00178713          	addi	a4,a5,1
    80206ef6:	fd043783          	ld	a5,-48(s0)
    80206efa:	02f777b3          	remu	a5,a4,a5
    80206efe:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:131
  uint64_t checked = 0; // Number of tasks checked.
    80206f02:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:133

  for (uint64_t i = start_id; checked < num_app; i = (i + 1) % num_app) {
    80206f06:	fc043783          	ld	a5,-64(s0)
    80206f0a:	fcf43c23          	sd	a5,-40(s0)
    80206f0e:	a8bd                	j	80206f8c <task_manager_find_next_task+0xd0>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:134
    if (TASK_MANAGER.tasks[i].task_status == Ready) {
    80206f10:	00b1c697          	auipc	a3,0xb1c
    80206f14:	10868693          	addi	a3,a3,264 # 80d23018 <TASK_MANAGER>
    80206f18:	fd843703          	ld	a4,-40(s0)
    80206f1c:	87ba                	mv	a5,a4
    80206f1e:	078e                	slli	a5,a5,0x3
    80206f20:	97ba                	add	a5,a5,a4
    80206f22:	0796                	slli	a5,a5,0x5
    80206f24:	97b6                	add	a5,a5,a3
    80206f26:	0907a783          	lw	a5,144(a5)
    80206f2a:	873e                	mv	a4,a5
    80206f2c:	4785                	li	a5,1
    80206f2e:	04f71063          	bne	a4,a5,80206f6e <task_manager_find_next_task+0xb2>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:135
      uint64_t current_stride = TASK_MANAGER.tasks[i].stride;
    80206f32:	00b1c697          	auipc	a3,0xb1c
    80206f36:	0e668693          	addi	a3,a3,230 # 80d23018 <TASK_MANAGER>
    80206f3a:	fd843703          	ld	a4,-40(s0)
    80206f3e:	87ba                	mv	a5,a4
    80206f40:	078e                	slli	a5,a5,0x3
    80206f42:	97ba                	add	a5,a5,a4
    80206f44:	0796                	slli	a5,a5,0x5
    80206f46:	97b6                	add	a5,a5,a3
    80206f48:	1187b783          	ld	a5,280(a5)
    80206f4c:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:136
      if (current_stride < min_stride) {
    80206f50:	fb843703          	ld	a4,-72(s0)
    80206f54:	fc843783          	ld	a5,-56(s0)
    80206f58:	00f77b63          	bgeu	a4,a5,80206f6e <task_manager_find_next_task+0xb2>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:137
        min_stride = current_stride;
    80206f5c:	fb843783          	ld	a5,-72(s0)
    80206f60:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:138
        min_id = i;
    80206f64:	fd843783          	ld	a5,-40(s0)
    80206f68:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:139
        break; // Stop the loop once the first ready task is found.
    80206f6c:	a035                	j	80206f98 <task_manager_find_next_task+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:142 (discriminator 2)
      }
    }
    checked++;
    80206f6e:	fe043783          	ld	a5,-32(s0)
    80206f72:	0785                	addi	a5,a5,1
    80206f74:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:133 (discriminator 2)
  for (uint64_t i = start_id; checked < num_app; i = (i + 1) % num_app) {
    80206f78:	fd843783          	ld	a5,-40(s0)
    80206f7c:	00178713          	addi	a4,a5,1
    80206f80:	fd043783          	ld	a5,-48(s0)
    80206f84:	02f777b3          	remu	a5,a4,a5
    80206f88:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:133 (discriminator 1)
    80206f8c:	fe043703          	ld	a4,-32(s0)
    80206f90:	fd043783          	ld	a5,-48(s0)
    80206f94:	f6f76ee3          	bltu	a4,a5,80206f10 <task_manager_find_next_task+0x54>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:145
  }

  return min_id;
    80206f98:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:146
}
    80206f9c:	853e                	mv	a0,a5
    80206f9e:	6426                	ld	s0,72(sp)
    80206fa0:	6161                	addi	sp,sp,80
    80206fa2:	8082                	ret

0000000080206fa4 <task_manager_run_next_task>:
task_manager_run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:149

void task_manager_run_next_task() 
{
    80206fa4:	7139                	addi	sp,sp,-64
    80206fa6:	fc06                	sd	ra,56(sp)
    80206fa8:	f822                	sd	s0,48(sp)
    80206faa:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:152
    extern void __switch(struct TaskContext **current_task_cx_ptr2,
                     struct TaskContext **next_task_cx_ptr2);
  int64_t next = task_manager_find_next_task();
    80206fac:	f11ff0ef          	jal	ra,80206ebc <task_manager_find_next_task>
    80206fb0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:153
  if (next >= 0)
    80206fb4:	fe843783          	ld	a5,-24(s0)
    80206fb8:	0e07cd63          	bltz	a5,802070b2 <task_manager_run_next_task+0x10e>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:155
  {
    uint64_t current = TASK_MANAGER.current_task;
    80206fbc:	00b1c717          	auipc	a4,0xb1c
    80206fc0:	05c70713          	addi	a4,a4,92 # 80d23018 <TASK_MANAGER>
    80206fc4:	6785                	lui	a5,0x1
    80206fc6:	97ba                	add	a5,a5,a4
    80206fc8:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80206fcc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:156
    TASK_MANAGER.tasks[next].task_status = Running;
    80206fd0:	00b1c697          	auipc	a3,0xb1c
    80206fd4:	04868693          	addi	a3,a3,72 # 80d23018 <TASK_MANAGER>
    80206fd8:	fe843703          	ld	a4,-24(s0)
    80206fdc:	87ba                	mv	a5,a4
    80206fde:	078e                	slli	a5,a5,0x3
    80206fe0:	97ba                	add	a5,a5,a4
    80206fe2:	0796                	slli	a5,a5,0x5
    80206fe4:	97b6                	add	a5,a5,a3
    80206fe6:	4709                	li	a4,2
    80206fe8:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:157
    uint64_t pass = BIG_STRIDE / TASK_MANAGER.tasks[next].priority;
    80206fec:	00b1c697          	auipc	a3,0xb1c
    80206ff0:	02c68693          	addi	a3,a3,44 # 80d23018 <TASK_MANAGER>
    80206ff4:	fe843703          	ld	a4,-24(s0)
    80206ff8:	87ba                	mv	a5,a4
    80206ffa:	078e                	slli	a5,a5,0x3
    80206ffc:	97ba                	add	a5,a5,a4
    80206ffe:	0796                	slli	a5,a5,0x5
    80207000:	97b6                	add	a5,a5,a3
    80207002:	1107b783          	ld	a5,272(a5)
    80207006:	6761                	lui	a4,0x18
    80207008:	6a070713          	addi	a4,a4,1696 # 186a0 <n+0x18680>
    8020700c:	02f757b3          	divu	a5,a4,a5
    80207010:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:158
    TASK_MANAGER.tasks[next].stride += pass;
    80207014:	00b1c697          	auipc	a3,0xb1c
    80207018:	00468693          	addi	a3,a3,4 # 80d23018 <TASK_MANAGER>
    8020701c:	fe843703          	ld	a4,-24(s0)
    80207020:	87ba                	mv	a5,a4
    80207022:	078e                	slli	a5,a5,0x3
    80207024:	97ba                	add	a5,a5,a4
    80207026:	0796                	slli	a5,a5,0x5
    80207028:	97b6                	add	a5,a5,a3
    8020702a:	1187b703          	ld	a4,280(a5)
    8020702e:	fd843783          	ld	a5,-40(s0)
    80207032:	00f706b3          	add	a3,a4,a5
    80207036:	00b1c617          	auipc	a2,0xb1c
    8020703a:	fe260613          	addi	a2,a2,-30 # 80d23018 <TASK_MANAGER>
    8020703e:	fe843703          	ld	a4,-24(s0)
    80207042:	87ba                	mv	a5,a4
    80207044:	078e                	slli	a5,a5,0x3
    80207046:	97ba                	add	a5,a5,a4
    80207048:	0796                	slli	a5,a5,0x5
    8020704a:	97b2                	add	a5,a5,a2
    8020704c:	10d7bc23          	sd	a3,280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:159
    TASK_MANAGER.current_task = next;
    80207050:	fe843703          	ld	a4,-24(s0)
    80207054:	00b1c697          	auipc	a3,0xb1c
    80207058:	fc468693          	addi	a3,a3,-60 # 80d23018 <TASK_MANAGER>
    8020705c:	6785                	lui	a5,0x1
    8020705e:	97b6                	add	a5,a5,a3
    80207060:	68e7b023          	sd	a4,1664(a5) # 1680 <n+0x1660>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:161
    struct TaskContext **current_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[current]));
    80207064:	fe043703          	ld	a4,-32(s0)
    80207068:	87ba                	mv	a5,a4
    8020706a:	078e                	slli	a5,a5,0x3
    8020706c:	97ba                	add	a5,a5,a4
    8020706e:	0796                	slli	a5,a5,0x5
    80207070:	00b1c717          	auipc	a4,0xb1c
    80207074:	fa870713          	addi	a4,a4,-88 # 80d23018 <TASK_MANAGER>
    80207078:	97ba                	add	a5,a5,a4
    8020707a:	853e                	mv	a0,a5
    8020707c:	977ff0ef          	jal	ra,802069f2 <get_task_cx_ptr2>
    80207080:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:163
    struct TaskContext **next_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[next]));
    80207084:	fe843703          	ld	a4,-24(s0)
    80207088:	87ba                	mv	a5,a4
    8020708a:	078e                	slli	a5,a5,0x3
    8020708c:	97ba                	add	a5,a5,a4
    8020708e:	0796                	slli	a5,a5,0x5
    80207090:	00b1c717          	auipc	a4,0xb1c
    80207094:	f8870713          	addi	a4,a4,-120 # 80d23018 <TASK_MANAGER>
    80207098:	97ba                	add	a5,a5,a4
    8020709a:	853e                	mv	a0,a5
    8020709c:	957ff0ef          	jal	ra,802069f2 <get_task_cx_ptr2>
    802070a0:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:164
    __switch(current_task_cx_ptr2, next_task_cx_ptr2);
    802070a4:	fc843583          	ld	a1,-56(s0)
    802070a8:	fd043503          	ld	a0,-48(s0)
    802070ac:	416010ef          	jal	ra,802084c2 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:169
  } else {
    mm_free();
    panic("All applications completed!\n");
  }
}
    802070b0:	a839                	j	802070ce <task_manager_run_next_task+0x12a>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:166
    mm_free();
    802070b2:	bf8fe0ef          	jal	ra,802054aa <mm_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:167
    panic("All applications completed!\n");
    802070b6:	00002617          	auipc	a2,0x2
    802070ba:	50260613          	addi	a2,a2,1282 # 802095b8 <MMIO+0x68>
    802070be:	0a700593          	li	a1,167
    802070c2:	00002517          	auipc	a0,0x2
    802070c6:	51650513          	addi	a0,a0,1302 # 802095d8 <MMIO+0x88>
    802070ca:	dceff0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:169
}
    802070ce:	0001                	nop
    802070d0:	70e2                	ld	ra,56(sp)
    802070d2:	7442                	ld	s0,48(sp)
    802070d4:	6121                	addi	sp,sp,64
    802070d6:	8082                	ret

00000000802070d8 <task_exit_current_and_run_next>:
task_exit_current_and_run_next():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:172

void task_exit_current_and_run_next() 
{
    802070d8:	1141                	addi	sp,sp,-16
    802070da:	e406                	sd	ra,8(sp)
    802070dc:	e022                	sd	s0,0(sp)
    802070de:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:173
  task_manager_mark_current_exited();
    802070e0:	d7fff0ef          	jal	ra,80206e5e <task_manager_mark_current_exited>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:174
  task_manager_run_next_task();
    802070e4:	ec1ff0ef          	jal	ra,80206fa4 <task_manager_run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:175
}
    802070e8:	0001                	nop
    802070ea:	60a2                	ld	ra,8(sp)
    802070ec:	6402                	ld	s0,0(sp)
    802070ee:	0141                	addi	sp,sp,16
    802070f0:	8082                	ret

00000000802070f2 <task_manager_mark_current_suspended>:
task_manager_mark_current_suspended():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:178

void task_manager_mark_current_suspended() 
{
    802070f2:	1101                	addi	sp,sp,-32
    802070f4:	ec22                	sd	s0,24(sp)
    802070f6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:179
  uint64_t current = TASK_MANAGER.current_task;
    802070f8:	00b1c717          	auipc	a4,0xb1c
    802070fc:	f2070713          	addi	a4,a4,-224 # 80d23018 <TASK_MANAGER>
    80207100:	6785                	lui	a5,0x1
    80207102:	97ba                	add	a5,a5,a4
    80207104:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80207108:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:180
  TASK_MANAGER.tasks[current].task_status = Ready;
    8020710c:	00b1c697          	auipc	a3,0xb1c
    80207110:	f0c68693          	addi	a3,a3,-244 # 80d23018 <TASK_MANAGER>
    80207114:	fe843703          	ld	a4,-24(s0)
    80207118:	87ba                	mv	a5,a4
    8020711a:	078e                	slli	a5,a5,0x3
    8020711c:	97ba                	add	a5,a5,a4
    8020711e:	0796                	slli	a5,a5,0x5
    80207120:	97b6                	add	a5,a5,a3
    80207122:	4705                	li	a4,1
    80207124:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:181
}
    80207128:	0001                	nop
    8020712a:	6462                	ld	s0,24(sp)
    8020712c:	6105                	addi	sp,sp,32
    8020712e:	8082                	ret

0000000080207130 <task_suspend_current_and_run_next>:
task_suspend_current_and_run_next():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:185


void task_suspend_current_and_run_next() 
{
    80207130:	1141                	addi	sp,sp,-16
    80207132:	e406                	sd	ra,8(sp)
    80207134:	e022                	sd	s0,0(sp)
    80207136:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:186
  task_manager_mark_current_suspended();
    80207138:	fbbff0ef          	jal	ra,802070f2 <task_manager_mark_current_suspended>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:187
  task_manager_run_next_task();
    8020713c:	e69ff0ef          	jal	ra,80206fa4 <task_manager_run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:188
    80207140:	0001                	nop
    80207142:	60a2                	ld	ra,8(sp)
    80207144:	6402                	ld	s0,0(sp)
    80207146:	0141                	addi	sp,sp,16
    80207148:	8082                	ret

000000008020714a <processor_init>:
processor_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:12
extern void __switch(struct TaskContext *current_task_cx_ptr,
                     struct TaskContext *next_task_cx_ptr);


void processor_init(Processor *processor) 
{
    8020714a:	1101                	addi	sp,sp,-32
    8020714c:	ec06                	sd	ra,24(sp)
    8020714e:	e822                	sd	s0,16(sp)
    80207150:	1000                	addi	s0,sp,32
    80207152:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:13
  processor->current = NULL;
    80207156:	fe843783          	ld	a5,-24(s0)
    8020715a:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:14
  task_context_zero_init(&processor->idle_task_cx);
    8020715e:	fe843783          	ld	a5,-24(s0)
    80207162:	07a1                	addi	a5,a5,8
    80207164:	853e                	mv	a0,a5
    80207166:	90dff0ef          	jal	ra,80206a72 <task_context_zero_init>
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:15
}
    8020716a:	0001                	nop
    8020716c:	60e2                	ld	ra,24(sp)
    8020716e:	6442                	ld	s0,16(sp)
    80207170:	6105                	addi	sp,sp,32
    80207172:	8082                	ret

0000000080207174 <processor_take_current>:
processor_take_current():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:17

struct TaskControlBlock *processor_take_current(Processor *processor) {
    80207174:	1101                	addi	sp,sp,-32
    80207176:	ec22                	sd	s0,24(sp)
    80207178:	1000                	addi	s0,sp,32
    8020717a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:18
  return processor->current;
    8020717e:	fe843783          	ld	a5,-24(s0)
    80207182:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:19
}
    80207184:	853e                	mv	a0,a5
    80207186:	6462                	ld	s0,24(sp)
    80207188:	6105                	addi	sp,sp,32
    8020718a:	8082                	ret

000000008020718c <processor_get_idle_task_cx_ptr>:
processor_get_idle_task_cx_ptr():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:22


struct TaskContext *processor_get_idle_task_cx_ptr(Processor *processor) {
    8020718c:	1101                	addi	sp,sp,-32
    8020718e:	ec22                	sd	s0,24(sp)
    80207190:	1000                	addi	s0,sp,32
    80207192:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:23
  return &processor->idle_task_cx;
    80207196:	fe843783          	ld	a5,-24(s0)
    8020719a:	07a1                	addi	a5,a5,8
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:24
}
    8020719c:	853e                	mv	a0,a5
    8020719e:	6462                	ld	s0,24(sp)
    802071a0:	6105                	addi	sp,sp,32
    802071a2:	8082                	ret

00000000802071a4 <processor_current_user_token>:
processor_current_user_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:27


uint64_t processor_current_user_token() {
    802071a4:	1101                	addi	sp,sp,-32
    802071a6:	ec06                	sd	ra,24(sp)
    802071a8:	e822                	sd	s0,16(sp)
    802071aa:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:28
  struct TaskControlBlock *task = processor_current_task();
    802071ac:	01c000ef          	jal	ra,802071c8 <processor_current_task>
    802071b0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:29
  return task_control_block_get_user_token(task);
    802071b4:	fe843503          	ld	a0,-24(s0)
    802071b8:	90fff0ef          	jal	ra,80206ac6 <task_control_block_get_user_token>
    802071bc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:30
}
    802071be:	853e                	mv	a0,a5
    802071c0:	60e2                	ld	ra,24(sp)
    802071c2:	6442                	ld	s0,16(sp)
    802071c4:	6105                	addi	sp,sp,32
    802071c6:	8082                	ret

00000000802071c8 <processor_current_task>:
processor_current_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:34



struct TaskControlBlock *processor_current_task() {
    802071c8:	1141                	addi	sp,sp,-16
    802071ca:	e406                	sd	ra,8(sp)
    802071cc:	e022                	sd	s0,0(sp)
    802071ce:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:35
  return processor_current_task(&PROCESSOR);
    802071d0:	00b1d517          	auipc	a0,0xb1d
    802071d4:	74850513          	addi	a0,a0,1864 # 80d24918 <PROCESSOR>
    802071d8:	ff1ff0ef          	jal	ra,802071c8 <processor_current_task>
    802071dc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:36
}
    802071de:	853e                	mv	a0,a5
    802071e0:	60a2                	ld	ra,8(sp)
    802071e2:	6402                	ld	s0,0(sp)
    802071e4:	0141                	addi	sp,sp,16
    802071e6:	8082                	ret

00000000802071e8 <processor_run_tasks>:
processor_run_tasks():
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:40


void processor_run_tasks() 
{
    802071e8:	7179                	addi	sp,sp,-48
    802071ea:	f406                	sd	ra,40(sp)
    802071ec:	f022                	sd	s0,32(sp)
    802071ee:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:41
  processor_init(&PROCESSOR);
    802071f0:	00b1d517          	auipc	a0,0xb1d
    802071f4:	72850513          	addi	a0,a0,1832 # 80d24918 <PROCESSOR>
    802071f8:	f53ff0ef          	jal	ra,8020714a <processor_init>
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:46
  struct TaskControlBlock *task;
  struct TaskContext *idle_task_cx_ptr;
  struct TaskContext *next_task_cx_ptr;
  while (1) {
    task = task_manager_fetch_task();
    802071fc:	a0dff0ef          	jal	ra,80206c08 <task_manager_fetch_task>
    80207200:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:47
    if (task) {
    80207204:	fe843783          	ld	a5,-24(s0)
    80207208:	dbf5                	beqz	a5,802071fc <processor_run_tasks+0x14>
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:48
      idle_task_cx_ptr = processor_get_idle_task_cx_ptr(&PROCESSOR);
    8020720a:	00b1d517          	auipc	a0,0xb1d
    8020720e:	70e50513          	addi	a0,a0,1806 # 80d24918 <PROCESSOR>
    80207212:	f7bff0ef          	jal	ra,8020718c <processor_get_idle_task_cx_ptr>
    80207216:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:49
      next_task_cx_ptr = &task->task_cx;
    8020721a:	fe843783          	ld	a5,-24(s0)
    8020721e:	02078793          	addi	a5,a5,32
    80207222:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:50
      task->task_status = Running;
    80207226:	fe843783          	ld	a5,-24(s0)
    8020722a:	4709                	li	a4,2
    8020722c:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:51
      PROCESSOR.current = task;
    80207230:	00b1d797          	auipc	a5,0xb1d
    80207234:	6e878793          	addi	a5,a5,1768 # 80d24918 <PROCESSOR>
    80207238:	fe843703          	ld	a4,-24(s0)
    8020723c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:52
      __switch(idle_task_cx_ptr, next_task_cx_ptr);
    8020723e:	fd843583          	ld	a1,-40(s0)
    80207242:	fe043503          	ld	a0,-32(s0)
    80207246:	27c010ef          	jal	ra,802084c2 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/processor/processor.c:46
    task = task_manager_fetch_task();
    8020724a:	bf4d                	j	802071fc <processor_run_tasks+0x14>

000000008020724c <kernel_stack_position>:
kernel_stack_position():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:34
//     *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
//     return stackTop; // 返回新的栈顶地址
// }

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top) 
{
    8020724c:	7179                	addi	sp,sp,-48
    8020724e:	f422                	sd	s0,40(sp)
    80207250:	1800                	addi	s0,sp,48
    80207252:	fea43423          	sd	a0,-24(s0)
    80207256:	feb43023          	sd	a1,-32(s0)
    8020725a:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:35
    *top = TRAMPOLINE - app_id * (KERNEL_STACK_SIZE + PAGE_SIZE);
    8020725e:	fe843703          	ld	a4,-24(s0)
    80207262:	87ba                	mv	a5,a4
    80207264:	0786                	slli	a5,a5,0x1
    80207266:	97ba                	add	a5,a5,a4
    80207268:	07b2                	slli	a5,a5,0xc
    8020726a:	873e                	mv	a4,a5
    8020726c:	77fd                	lui	a5,0xfffff
    8020726e:	40e78733          	sub	a4,a5,a4
    80207272:	fd843783          	ld	a5,-40(s0)
    80207276:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:36
    *bottom = *top - KERNEL_STACK_SIZE;
    80207278:	fd843783          	ld	a5,-40(s0)
    8020727c:	6398                	ld	a4,0(a5)
    8020727e:	77f9                	lui	a5,0xffffe
    80207280:	973e                	add	a4,a4,a5
    80207282:	fe043783          	ld	a5,-32(s0)
    80207286:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:37
}
    80207288:	0001                	nop
    8020728a:	7422                	ld	s0,40(sp)
    8020728c:	6145                	addi	sp,sp,48
    8020728e:	8082                	ret

0000000080207290 <kernel_stack_push_on_top>:
kernel_stack_push_on_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:40

void* kernel_stack_push_on_top(struct KernelStack stack, void* value)
{
    80207290:	7179                	addi	sp,sp,-48
    80207292:	f406                	sd	ra,40(sp)
    80207294:	f022                	sd	s0,32(sp)
    80207296:	1800                	addi	s0,sp,48
    80207298:	fca43c23          	sd	a0,-40(s0)
    8020729c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:41
    uint64_t kernel_stack_top = kernel_stack_get_top(stack);
    802072a0:	fd843503          	ld	a0,-40(s0)
    802072a4:	02a000ef          	jal	ra,802072ce <kernel_stack_get_top>
    802072a8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:42
    void* ptr = (void*)(kernel_stack_top - sizeof(void*));
    802072ac:	fe843783          	ld	a5,-24(s0)
    802072b0:	17e1                	addi	a5,a5,-8
    802072b2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:43
    *(void**)ptr = value;
    802072b6:	fe043783          	ld	a5,-32(s0)
    802072ba:	fd043703          	ld	a4,-48(s0)
    802072be:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:44
    return ptr;
    802072c0:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:45
}
    802072c4:	853e                	mv	a0,a5
    802072c6:	70a2                	ld	ra,40(sp)
    802072c8:	7402                	ld	s0,32(sp)
    802072ca:	6145                	addi	sp,sp,48
    802072cc:	8082                	ret

00000000802072ce <kernel_stack_get_top>:
kernel_stack_get_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:48

uint64_t kernel_stack_get_top(struct KernelStack stack)
{
    802072ce:	7179                	addi	sp,sp,-48
    802072d0:	f406                	sd	ra,40(sp)
    802072d2:	f022                	sd	s0,32(sp)
    802072d4:	1800                	addi	s0,sp,48
    802072d6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:50
    uint64_t bottom, top;
    kernel_stack_position(stack.pid.pid, &bottom, &top);
    802072da:	fd843783          	ld	a5,-40(s0)
    802072de:	fe040693          	addi	a3,s0,-32
    802072e2:	fe840713          	addi	a4,s0,-24
    802072e6:	8636                	mv	a2,a3
    802072e8:	85ba                	mv	a1,a4
    802072ea:	853e                	mv	a0,a5
    802072ec:	f61ff0ef          	jal	ra,8020724c <kernel_stack_position>
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:51
    return top;
    802072f0:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:52
}
    802072f4:	853e                	mv	a0,a5
    802072f6:	70a2                	ld	ra,40(sp)
    802072f8:	7402                	ld	s0,32(sp)
    802072fa:	6145                	addi	sp,sp,48
    802072fc:	8082                	ret

00000000802072fe <kernel_stack_new>:
kernel_stack_new():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:54

void kernel_stack_new(struct KernelStack *ks, PidHandle pid) {
    802072fe:	7179                	addi	sp,sp,-48
    80207300:	f406                	sd	ra,40(sp)
    80207302:	f022                	sd	s0,32(sp)
    80207304:	1800                	addi	s0,sp,48
    80207306:	fca43c23          	sd	a0,-40(s0)
    8020730a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:55
  uint64_t kernel_stack_bottom = kernel_stack_position_bottom(pid.pid);
    8020730e:	fd043703          	ld	a4,-48(s0)
    80207312:	87ba                	mv	a5,a4
    80207314:	0786                	slli	a5,a5,0x1
    80207316:	97ba                	add	a5,a5,a4
    80207318:	07b2                	slli	a5,a5,0xc
    8020731a:	873e                	mv	a4,a5
    8020731c:	77f5                	lui	a5,0xffffd
    8020731e:	8f99                	sub	a5,a5,a4
    80207320:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:56
  uint64_t kernel_stack_top = kernel_stack_position_top(pid.pid);
    80207324:	fd043703          	ld	a4,-48(s0)
    80207328:	87ba                	mv	a5,a4
    8020732a:	0786                	slli	a5,a5,0x1
    8020732c:	97ba                	add	a5,a5,a4
    8020732e:	07b2                	slli	a5,a5,0xc
    80207330:	873e                	mv	a4,a5
    80207332:	77fd                	lui	a5,0xfffff
    80207334:	8f99                	sub	a5,a5,a4
    80207336:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:57
  kernel_space_insert_framed_area(kernel_stack_bottom, kernel_stack_top,
    8020733a:	4619                	li	a2,6
    8020733c:	fe043583          	ld	a1,-32(s0)
    80207340:	fe843503          	ld	a0,-24(s0)
    80207344:	c12fd0ef          	jal	ra,80204756 <kernel_space_insert_framed_area>
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:59
                                  MAP_PERM_R | MAP_PERM_W);
  ks->pid = pid;
    80207348:	fd843783          	ld	a5,-40(s0)
    8020734c:	fd043703          	ld	a4,-48(s0)
    80207350:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:60
}
    80207352:	0001                	nop
    80207354:	70a2                	ld	ra,40(sp)
    80207356:	7402                	ld	s0,32(sp)
    80207358:	6145                	addi	sp,sp,48
    8020735a:	8082                	ret

000000008020735c <loader_get_num_app>:
loader_get_num_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:8
#include "task.h"
#include "string.h"
#include "loader.h"
char APP_NAMES[MAX_APP_NUM][MAX_APP_NAME_LENGTH];
uint64_t loader_get_num_app() 
{
    8020735c:	1141                	addi	sp,sp,-16
    8020735e:	e422                	sd	s0,8(sp)
    80207360:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:10
  extern uint64_t _num_app[];
  return _num_app[0];
    80207362:	00003797          	auipc	a5,0x3
    80207366:	cd678793          	addi	a5,a5,-810 # 8020a038 <_num_app>
    8020736a:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:11
}
    8020736c:	853e                	mv	a0,a5
    8020736e:	6422                	ld	s0,8(sp)
    80207370:	0141                	addi	sp,sp,16
    80207372:	8082                	ret

0000000080207374 <loader_get_app_data>:
loader_get_app_data():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:14

uint8_t *loader_get_app_data(uint64_t app_id) 
{
    80207374:	1101                	addi	sp,sp,-32
    80207376:	ec06                	sd	ra,24(sp)
    80207378:	e822                	sd	s0,16(sp)
    8020737a:	1000                	addi	s0,sp,32
    8020737c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:15
    ASSERT(app_id < loader_get_num_app());
    80207380:	fddff0ef          	jal	ra,8020735c <loader_get_num_app>
    80207384:	872a                	mv	a4,a0
    80207386:	fe843783          	ld	a5,-24(s0)
    8020738a:	00e7ed63          	bltu	a5,a4,802073a4 <loader_get_app_data+0x30>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:15 (discriminator 1)
    8020738e:	00002617          	auipc	a2,0x2
    80207392:	29260613          	addi	a2,a2,658 # 80209620 <MMIO+0x10>
    80207396:	45bd                	li	a1,15
    80207398:	00002517          	auipc	a0,0x2
    8020739c:	2b850513          	addi	a0,a0,696 # 80209650 <MMIO+0x40>
    802073a0:	af8ff0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:23
    {
    &app_0_start,
    &app_1_start,
    &app_2_start
    };
    return app_starts[app_id];
    802073a4:	00003717          	auipc	a4,0x3
    802073a8:	c5c70713          	addi	a4,a4,-932 # 8020a000 <app_starts.1>
    802073ac:	fe843783          	ld	a5,-24(s0)
    802073b0:	078e                	slli	a5,a5,0x3
    802073b2:	97ba                	add	a5,a5,a4
    802073b4:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:24
}
    802073b6:	853e                	mv	a0,a5
    802073b8:	60e2                	ld	ra,24(sp)
    802073ba:	6442                	ld	s0,16(sp)
    802073bc:	6105                	addi	sp,sp,32
    802073be:	8082                	ret

00000000802073c0 <loader_get_app_size>:
loader_get_app_size():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:28


size_t loader_get_app_size(uint64_t app_id) 
{
    802073c0:	7179                	addi	sp,sp,-48
    802073c2:	f406                	sd	ra,40(sp)
    802073c4:	f022                	sd	s0,32(sp)
    802073c6:	1800                	addi	s0,sp,48
    802073c8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:32
    //printk("loader_get_app_size start\n");
    
    // 确保提供的 app_id 是有效的
    uint64_t num_app = loader_get_num_app();
    802073cc:	f91ff0ef          	jal	ra,8020735c <loader_get_num_app>
    802073d0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:33
    ASSERT(app_id < num_app);
    802073d4:	fd843703          	ld	a4,-40(s0)
    802073d8:	fe843783          	ld	a5,-24(s0)
    802073dc:	00f76e63          	bltu	a4,a5,802073f8 <loader_get_app_size+0x38>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:33 (discriminator 1)
    802073e0:	00002617          	auipc	a2,0x2
    802073e4:	29060613          	addi	a2,a2,656 # 80209670 <MMIO+0x60>
    802073e8:	02100593          	li	a1,33
    802073ec:	00002517          	auipc	a0,0x2
    802073f0:	26450513          	addi	a0,a0,612 # 80209650 <MMIO+0x40>
    802073f4:	aa4ff0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:46
        &app_2_start,
        &app_2_end, // 用于计算最后一个应用程序的大小
    };

    // 计算并返回应用程序的大小
    size_t app_size = app_starts_ends[app_id + 1] - app_starts_ends[app_id];
    802073f8:	fd843783          	ld	a5,-40(s0)
    802073fc:	0785                	addi	a5,a5,1
    802073fe:	00003717          	auipc	a4,0x3
    80207402:	c1a70713          	addi	a4,a4,-998 # 8020a018 <app_starts_ends.0>
    80207406:	078e                	slli	a5,a5,0x3
    80207408:	97ba                	add	a5,a5,a4
    8020740a:	6398                	ld	a4,0(a5)
    8020740c:	00003697          	auipc	a3,0x3
    80207410:	c0c68693          	addi	a3,a3,-1012 # 8020a018 <app_starts_ends.0>
    80207414:	fd843783          	ld	a5,-40(s0)
    80207418:	078e                	slli	a5,a5,0x3
    8020741a:	97b6                	add	a5,a5,a3
    8020741c:	639c                	ld	a5,0(a5)
    8020741e:	40f707b3          	sub	a5,a4,a5
    80207422:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:55
    // }
    
    // printk("App ID: %d Size: %d\n", app_id, app_size);
    //ASSERT(0);
    //printk("App ID: %d Size: %d\n", app_id, app_size);
    return app_size;
    80207426:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:56
}
    8020742a:	853e                	mv	a0,a5
    8020742c:	70a2                	ld	ra,40(sp)
    8020742e:	7402                	ld	s0,32(sp)
    80207430:	6145                	addi	sp,sp,48
    80207432:	8082                	ret

0000000080207434 <loader_init_and_list_apps>:
loader_init_and_list_apps():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:60


void loader_init_and_list_apps() 
{
    80207434:	7179                	addi	sp,sp,-48
    80207436:	f406                	sd	ra,40(sp)
    80207438:	f022                	sd	s0,32(sp)
    8020743a:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:62
  extern uint64_t _app_names;
  uint64_t num_app = loader_get_num_app();
    8020743c:	f21ff0ef          	jal	ra,8020735c <loader_get_num_app>
    80207440:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:63
  uint8_t *ptr = (uint8_t *)&_app_names;
    80207444:	00003797          	auipc	a5,0x3
    80207448:	c1c78793          	addi	a5,a5,-996 # 8020a060 <_app_names>
    8020744c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:64
  for (uint64_t i = 0; i < num_app; i++) 
    80207450:	fe043023          	sd	zero,-32(s0)
    80207454:	a089                	j	80207496 <loader_init_and_list_apps+0x62>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:66 (discriminator 3)
  {
    strcpy_t(APP_NAMES[i], (char *)ptr);
    80207456:	fe043783          	ld	a5,-32(s0)
    8020745a:	00679713          	slli	a4,a5,0x6
    8020745e:	00b1d797          	auipc	a5,0xb1d
    80207462:	53278793          	addi	a5,a5,1330 # 80d24990 <APP_NAMES>
    80207466:	97ba                	add	a5,a5,a4
    80207468:	fe843583          	ld	a1,-24(s0)
    8020746c:	853e                	mv	a0,a5
    8020746e:	a12fc0ef          	jal	ra,80203680 <strcpy_t>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:67 (discriminator 3)
    ptr += (strlen_t((char *)ptr) + 1);
    80207472:	fe843503          	ld	a0,-24(s0)
    80207476:	f05fb0ef          	jal	ra,8020337a <strlen_t>
    8020747a:	87aa                	mv	a5,a0
    8020747c:	2785                	addiw	a5,a5,1
    8020747e:	2781                	sext.w	a5,a5
    80207480:	873e                	mv	a4,a5
    80207482:	fe843783          	ld	a5,-24(s0)
    80207486:	97ba                	add	a5,a5,a4
    80207488:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:64 (discriminator 3)
  for (uint64_t i = 0; i < num_app; i++) 
    8020748c:	fe043783          	ld	a5,-32(s0)
    80207490:	0785                	addi	a5,a5,1
    80207492:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:64 (discriminator 1)
    80207496:	fe043703          	ld	a4,-32(s0)
    8020749a:	fd843783          	ld	a5,-40(s0)
    8020749e:	faf76ce3          	bltu	a4,a5,80207456 <loader_init_and_list_apps+0x22>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:69
  }
}
    802074a2:	0001                	nop
    802074a4:	0001                	nop
    802074a6:	70a2                	ld	ra,40(sp)
    802074a8:	7402                	ld	s0,32(sp)
    802074aa:	6145                	addi	sp,sp,48
    802074ac:	8082                	ret

00000000802074ae <list_apps>:
list_apps():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:72

void list_apps() 
{
    802074ae:	1101                	addi	sp,sp,-32
    802074b0:	ec06                	sd	ra,24(sp)
    802074b2:	e822                	sd	s0,16(sp)
    802074b4:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:73
    printk("/**** APPS ****\n");
    802074b6:	00002517          	auipc	a0,0x2
    802074ba:	1e250513          	addi	a0,a0,482 # 80209698 <MMIO+0x88>
    802074be:	b2cfb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:74
    int num_app = loader_get_num_app();
    802074c2:	e9bff0ef          	jal	ra,8020735c <loader_get_num_app>
    802074c6:	87aa                	mv	a5,a0
    802074c8:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:75
    for (int i = 0; i < num_app; i++) {
    802074cc:	fe042623          	sw	zero,-20(s0)
    802074d0:	a035                	j	802074fc <list_apps+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:76 (discriminator 3)
        printk("%s\n", APP_NAMES[i]);
    802074d2:	fec42783          	lw	a5,-20(s0)
    802074d6:	00679713          	slli	a4,a5,0x6
    802074da:	00b1d797          	auipc	a5,0xb1d
    802074de:	4b678793          	addi	a5,a5,1206 # 80d24990 <APP_NAMES>
    802074e2:	97ba                	add	a5,a5,a4
    802074e4:	85be                	mv	a1,a5
    802074e6:	00002517          	auipc	a0,0x2
    802074ea:	1ca50513          	addi	a0,a0,458 # 802096b0 <MMIO+0xa0>
    802074ee:	afcfb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:75 (discriminator 3)
    for (int i = 0; i < num_app; i++) {
    802074f2:	fec42783          	lw	a5,-20(s0)
    802074f6:	2785                	addiw	a5,a5,1
    802074f8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:75 (discriminator 1)
    802074fc:	fec42703          	lw	a4,-20(s0)
    80207500:	fe842783          	lw	a5,-24(s0)
    80207504:	2701                	sext.w	a4,a4
    80207506:	2781                	sext.w	a5,a5
    80207508:	fcf745e3          	blt	a4,a5,802074d2 <list_apps+0x24>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:78
    }
    printk("**************/\n");
    8020750c:	00002517          	auipc	a0,0x2
    80207510:	1ac50513          	addi	a0,a0,428 # 802096b8 <MMIO+0xa8>
    80207514:	ad6fb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:79
}
    80207518:	0001                	nop
    8020751a:	60e2                	ld	ra,24(sp)
    8020751c:	6442                	ld	s0,16(sp)
    8020751e:	6105                	addi	sp,sp,32
    80207520:	8082                	ret

0000000080207522 <loader_get_app_data_by_name>:
loader_get_app_data_by_name():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:82

uint8_t* loader_get_app_data_by_name(char* name) 
{
    80207522:	7179                	addi	sp,sp,-48
    80207524:	f406                	sd	ra,40(sp)
    80207526:	f022                	sd	s0,32(sp)
    80207528:	1800                	addi	s0,sp,48
    8020752a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:83
    int num_app = loader_get_num_app();
    8020752e:	e2fff0ef          	jal	ra,8020735c <loader_get_num_app>
    80207532:	87aa                	mv	a5,a0
    80207534:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:84
    for (int i = 0; i < num_app; i++) 
    80207538:	fe042623          	sw	zero,-20(s0)
    8020753c:	a82d                	j	80207576 <loader_get_app_data_by_name+0x54>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:86
    {
        if (strcmp_t(APP_NAMES[i], name) == 0) 
    8020753e:	fec42783          	lw	a5,-20(s0)
    80207542:	00679713          	slli	a4,a5,0x6
    80207546:	00b1d797          	auipc	a5,0xb1d
    8020754a:	44a78793          	addi	a5,a5,1098 # 80d24990 <APP_NAMES>
    8020754e:	97ba                	add	a5,a5,a4
    80207550:	fd843583          	ld	a1,-40(s0)
    80207554:	853e                	mv	a0,a5
    80207556:	89cfc0ef          	jal	ra,802035f2 <strcmp_t>
    8020755a:	87aa                	mv	a5,a0
    8020755c:	eb81                	bnez	a5,8020756c <loader_get_app_data_by_name+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:88
        {
            return loader_get_app_data(i);
    8020755e:	fec42783          	lw	a5,-20(s0)
    80207562:	853e                	mv	a0,a5
    80207564:	e11ff0ef          	jal	ra,80207374 <loader_get_app_data>
    80207568:	87aa                	mv	a5,a0
    8020756a:	a839                	j	80207588 <loader_get_app_data_by_name+0x66>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:84 (discriminator 2)
    for (int i = 0; i < num_app; i++) 
    8020756c:	fec42783          	lw	a5,-20(s0)
    80207570:	2785                	addiw	a5,a5,1
    80207572:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:84 (discriminator 1)
    80207576:	fec42703          	lw	a4,-20(s0)
    8020757a:	fe842783          	lw	a5,-24(s0)
    8020757e:	2701                	sext.w	a4,a4
    80207580:	2781                	sext.w	a5,a5
    80207582:	faf74ee3          	blt	a4,a5,8020753e <loader_get_app_data_by_name+0x1c>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:91
        }
    }
    return NULL; // Return NULL if no match is found
    80207586:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:92
}
    80207588:	853e                	mv	a0,a5
    8020758a:	70a2                	ld	ra,40(sp)
    8020758c:	7402                	ld	s0,32(sp)
    8020758e:	6145                	addi	sp,sp,48
    80207590:	8082                	ret

0000000080207592 <loader_get_app_size_by_name>:
loader_get_app_size_by_name():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:96



size_t loader_get_app_size_by_name(char *name) {
    80207592:	7179                	addi	sp,sp,-48
    80207594:	f406                	sd	ra,40(sp)
    80207596:	f022                	sd	s0,32(sp)
    80207598:	1800                	addi	s0,sp,48
    8020759a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:97
  uint64_t num_app = loader_get_num_app();
    8020759e:	dbfff0ef          	jal	ra,8020735c <loader_get_num_app>
    802075a2:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:98
  for (uint64_t i = 0; i < num_app; i++) {
    802075a6:	fe043423          	sd	zero,-24(s0)
    802075aa:	a825                	j	802075e2 <loader_get_app_size_by_name+0x50>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:99
    if (strcmp_t(APP_NAMES[i], name) == 0) {
    802075ac:	fe843783          	ld	a5,-24(s0)
    802075b0:	00679713          	slli	a4,a5,0x6
    802075b4:	00b1d797          	auipc	a5,0xb1d
    802075b8:	3dc78793          	addi	a5,a5,988 # 80d24990 <APP_NAMES>
    802075bc:	97ba                	add	a5,a5,a4
    802075be:	fd843583          	ld	a1,-40(s0)
    802075c2:	853e                	mv	a0,a5
    802075c4:	82efc0ef          	jal	ra,802035f2 <strcmp_t>
    802075c8:	87aa                	mv	a5,a0
    802075ca:	e799                	bnez	a5,802075d8 <loader_get_app_size_by_name+0x46>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:100
      return loader_get_app_size(i);
    802075cc:	fe843503          	ld	a0,-24(s0)
    802075d0:	df1ff0ef          	jal	ra,802073c0 <loader_get_app_size>
    802075d4:	87aa                	mv	a5,a0
    802075d6:	a829                	j	802075f0 <loader_get_app_size_by_name+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:98 (discriminator 2)
  for (uint64_t i = 0; i < num_app; i++) {
    802075d8:	fe843783          	ld	a5,-24(s0)
    802075dc:	0785                	addi	a5,a5,1
    802075de:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:98 (discriminator 1)
    802075e2:	fe843703          	ld	a4,-24(s0)
    802075e6:	fe043783          	ld	a5,-32(s0)
    802075ea:	fcf761e3          	bltu	a4,a5,802075ac <loader_get_app_size_by_name+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:103
    }
  }
  return 0;
    802075ee:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:104
    802075f0:	853e                	mv	a0,a5
    802075f2:	70a2                	ld	ra,40(sp)
    802075f4:	7402                	ld	s0,32(sp)
    802075f6:	6145                	addi	sp,sp,48
    802075f8:	8082                	ret

00000000802075fa <r_sstatus>:
r_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:46
static inline uint64_t r_sstatus() {
    802075fa:	1101                	addi	sp,sp,-32
    802075fc:	ec22                	sd	s0,24(sp)
    802075fe:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:48
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80207600:	100027f3          	csrr	a5,sstatus
    80207604:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:49
  return x;
    80207608:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:50
}
    8020760c:	853e                	mv	a0,a5
    8020760e:	6462                	ld	s0,24(sp)
    80207610:	6105                	addi	sp,sp,32
    80207612:	8082                	ret

0000000080207614 <set_sstatus_spp_user>:
set_sstatus_spp_user():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:7
#include "stdint.h"
#include "context.h"
#include "riscv.h"
#include "trap.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    80207614:	7179                	addi	sp,sp,-48
    80207616:	f422                	sd	s0,40(sp)
    80207618:	1800                	addi	s0,sp,48
    8020761a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:8
    uint64_t mask = 1UL << 8;
    8020761e:	10000793          	li	a5,256
    80207622:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:9
    *sstatus &= ~mask;
    80207626:	fd843783          	ld	a5,-40(s0)
    8020762a:	6398                	ld	a4,0(a5)
    8020762c:	fe843783          	ld	a5,-24(s0)
    80207630:	fff7c793          	not	a5,a5
    80207634:	8f7d                	and	a4,a4,a5
    80207636:	fd843783          	ld	a5,-40(s0)
    8020763a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:10
}
    8020763c:	0001                	nop
    8020763e:	7422                	ld	s0,40(sp)
    80207640:	6145                	addi	sp,sp,48
    80207642:	8082                	ret

0000000080207644 <read_sstatus>:
read_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:13

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    80207644:	1101                	addi	sp,sp,-32
    80207646:	ec22                	sd	s0,24(sp)
    80207648:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:14
    return READ_CSR(sstatus);
    8020764a:	100027f3          	csrr	a5,sstatus
    8020764e:	fef43423          	sd	a5,-24(s0)
    80207652:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:15
}
    80207656:	853e                	mv	a0,a5
    80207658:	6462                	ld	s0,24(sp)
    8020765a:	6105                	addi	sp,sp,32
    8020765c:	8082                	ret

000000008020765e <set_sp>:
set_sp():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:18

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    8020765e:	1101                	addi	sp,sp,-32
    80207660:	ec22                	sd	s0,24(sp)
    80207662:	1000                	addi	s0,sp,32
    80207664:	fea43423          	sd	a0,-24(s0)
    80207668:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:19
    ctx->x[2] = sp;
    8020766c:	fe843783          	ld	a5,-24(s0)
    80207670:	fe043703          	ld	a4,-32(s0)
    80207674:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:20
}
    80207676:	0001                	nop
    80207678:	6462                	ld	s0,24(sp)
    8020767a:	6105                	addi	sp,sp,32
    8020767c:	8082                	ret

000000008020767e <app_init_context>:
app_init_context():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:27


void app_init_context(uint64_t entry, uint64_t sp, uint64_t kernel_satp,
                      uint64_t kernel_sp, uint64_t trap_handler,
                      struct TrapContext *c) 
{
    8020767e:	715d                	addi	sp,sp,-80
    80207680:	e486                	sd	ra,72(sp)
    80207682:	e0a2                	sd	s0,64(sp)
    80207684:	0880                	addi	s0,sp,80
    80207686:	fca43c23          	sd	a0,-40(s0)
    8020768a:	fcb43823          	sd	a1,-48(s0)
    8020768e:	fcc43423          	sd	a2,-56(s0)
    80207692:	fcd43023          	sd	a3,-64(s0)
    80207696:	fae43c23          	sd	a4,-72(s0)
    8020769a:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:28
  uint64_t sstatus = r_sstatus();
    8020769e:	f5dff0ef          	jal	ra,802075fa <r_sstatus>
    802076a2:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:29
  sstatus &= ~SSTATUS_SPP;
    802076a6:	fe043783          	ld	a5,-32(s0)
    802076aa:	eff7f793          	andi	a5,a5,-257
    802076ae:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31

  for (int i = 0; i < 32; i++)
    802076b2:	fe042623          	sw	zero,-20(s0)
    802076b6:	a831                	j	802076d2 <app_init_context+0x54>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:32 (discriminator 3)
    c->x[i] = 0;
    802076b8:	fb043703          	ld	a4,-80(s0)
    802076bc:	fec42783          	lw	a5,-20(s0)
    802076c0:	078e                	slli	a5,a5,0x3
    802076c2:	97ba                	add	a5,a5,a4
    802076c4:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31 (discriminator 3)
  for (int i = 0; i < 32; i++)
    802076c8:	fec42783          	lw	a5,-20(s0)
    802076cc:	2785                	addiw	a5,a5,1
    802076ce:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31 (discriminator 1)
    802076d2:	fec42783          	lw	a5,-20(s0)
    802076d6:	0007871b          	sext.w	a4,a5
    802076da:	47fd                	li	a5,31
    802076dc:	fce7dee3          	bge	a5,a4,802076b8 <app_init_context+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:33
  c->sstatus = sstatus;
    802076e0:	fb043783          	ld	a5,-80(s0)
    802076e4:	fe043703          	ld	a4,-32(s0)
    802076e8:	10e7b023          	sd	a4,256(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:34
  c->sepc = entry;
    802076ec:	fb043783          	ld	a5,-80(s0)
    802076f0:	fd843703          	ld	a4,-40(s0)
    802076f4:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:35
  c->kernel_satp = kernel_satp;
    802076f8:	fb043783          	ld	a5,-80(s0)
    802076fc:	fc843703          	ld	a4,-56(s0)
    80207700:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:36
  c->kernel_sp = kernel_sp;
    80207704:	fb043783          	ld	a5,-80(s0)
    80207708:	fc043703          	ld	a4,-64(s0)
    8020770c:	10e7bc23          	sd	a4,280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:37
  c->trap_handler = trap_handler;
    80207710:	fb043783          	ld	a5,-80(s0)
    80207714:	fb843703          	ld	a4,-72(s0)
    80207718:	12e7b023          	sd	a4,288(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:38
  c->x[2] = sp;
    8020771c:	fb043783          	ld	a5,-80(s0)
    80207720:	fd043703          	ld	a4,-48(s0)
    80207724:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:39
}
    80207726:	0001                	nop
    80207728:	60a6                	ld	ra,72(sp)
    8020772a:	6406                	ld	s0,64(sp)
    8020772c:	6161                	addi	sp,sp,80
    8020772e:	8082                	ret

0000000080207730 <task_context_goto_trap_return>:
task_context_goto_trap_return():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:41

void task_context_goto_trap_return(struct TaskContext *cx, uint64_t kstack_ptr) {
    80207730:	7179                	addi	sp,sp,-48
    80207732:	f422                	sd	s0,40(sp)
    80207734:	1800                	addi	s0,sp,48
    80207736:	fca43c23          	sd	a0,-40(s0)
    8020773a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:42
  cx->ra = (uint64_t)trap_return;
    8020773e:	00000717          	auipc	a4,0x0
    80207742:	32270713          	addi	a4,a4,802 # 80207a60 <trap_return>
    80207746:	fd843783          	ld	a5,-40(s0)
    8020774a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:43
  cx->sp = kstack_ptr;
    8020774c:	fd843783          	ld	a5,-40(s0)
    80207750:	fd043703          	ld	a4,-48(s0)
    80207754:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44
  for (int i = 0; i < 12; i++)
    80207756:	fe042623          	sw	zero,-20(s0)
    8020775a:	a839                	j	80207778 <task_context_goto_trap_return+0x48>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:45 (discriminator 3)
    cx->x[i] = 0;
    8020775c:	fd843703          	ld	a4,-40(s0)
    80207760:	fec42783          	lw	a5,-20(s0)
    80207764:	0789                	addi	a5,a5,2
    80207766:	078e                	slli	a5,a5,0x3
    80207768:	97ba                	add	a5,a5,a4
    8020776a:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44 (discriminator 3)
  for (int i = 0; i < 12; i++)
    8020776e:	fec42783          	lw	a5,-20(s0)
    80207772:	2785                	addiw	a5,a5,1
    80207774:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44 (discriminator 1)
    80207778:	fec42783          	lw	a5,-20(s0)
    8020777c:	0007871b          	sext.w	a4,a5
    80207780:	47ad                	li	a5,11
    80207782:	fce7dde3          	bge	a5,a4,8020775c <task_context_goto_trap_return+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:46
}
    80207786:	0001                	nop
    80207788:	0001                	nop
    8020778a:	7422                	ld	s0,40(sp)
    8020778c:	6145                	addi	sp,sp,48
    8020778e:	8082                	ret

0000000080207790 <PidAllocator_init>:
PidAllocator_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:6
#include "pid.h"
#include "stdint.h"
#include "debug.h"
PidAllocator PID_ALLOCATOR;
void PidAllocator_init(PidAllocator* allocator) 
{
    80207790:	1101                	addi	sp,sp,-32
    80207792:	ec06                	sd	ra,24(sp)
    80207794:	e822                	sd	s0,16(sp)
    80207796:	1000                	addi	s0,sp,32
    80207798:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:7
    allocator->current.pid = 0;
    8020779c:	fe843783          	ld	a5,-24(s0)
    802077a0:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:8
    vector_new(&allocator->recycled,10);
    802077a4:	fe843783          	ld	a5,-24(s0)
    802077a8:	07a1                	addi	a5,a5,8
    802077aa:	45a9                	li	a1,10
    802077ac:	853e                	mv	a0,a5
    802077ae:	06d000ef          	jal	ra,8020801a <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:9
}
    802077b2:	0001                	nop
    802077b4:	60e2                	ld	ra,24(sp)
    802077b6:	6442                	ld	s0,16(sp)
    802077b8:	6105                	addi	sp,sp,32
    802077ba:	8082                	ret

00000000802077bc <PidAllocator_alloc>:
PidAllocator_alloc():
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:12

PidHandle PidAllocator_alloc()
{
    802077bc:	1101                	addi	sp,sp,-32
    802077be:	ec06                	sd	ra,24(sp)
    802077c0:	e822                	sd	s0,16(sp)
    802077c2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:14
    PidHandle handle;
    if (vector_size(&PID_ALLOCATOR.recycled) > 0) {
    802077c4:	00b1d517          	auipc	a0,0xb1d
    802077c8:	6d450513          	addi	a0,a0,1748 # 80d24e98 <PID_ALLOCATOR+0x8>
    802077cc:	32b000ef          	jal	ra,802082f6 <vector_size>
    802077d0:	87aa                	mv	a5,a0
    802077d2:	c395                	beqz	a5,802077f6 <PidAllocator_alloc+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:15
        handle.pid = *(uint64_t*)vector_back(&PID_ALLOCATOR.recycled);
    802077d4:	00b1d517          	auipc	a0,0xb1d
    802077d8:	6c450513          	addi	a0,a0,1732 # 80d24e98 <PID_ALLOCATOR+0x8>
    802077dc:	19f000ef          	jal	ra,8020817a <vector_back>
    802077e0:	87aa                	mv	a5,a0
    802077e2:	639c                	ld	a5,0(a5)
    802077e4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:16
        vector_pop(&PID_ALLOCATOR.recycled);
    802077e8:	00b1d517          	auipc	a0,0xb1d
    802077ec:	6b050513          	addi	a0,a0,1712 # 80d24e98 <PID_ALLOCATOR+0x8>
    802077f0:	147000ef          	jal	ra,80208136 <vector_pop>
    802077f4:	a025                	j	8020781c <PidAllocator_alloc+0x60>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:18
    } else {
        handle.pid = PID_ALLOCATOR.current.pid;
    802077f6:	00b1d797          	auipc	a5,0xb1d
    802077fa:	69a78793          	addi	a5,a5,1690 # 80d24e90 <PID_ALLOCATOR>
    802077fe:	639c                	ld	a5,0(a5)
    80207800:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:19
        PID_ALLOCATOR.current.pid++;
    80207804:	00b1d797          	auipc	a5,0xb1d
    80207808:	68c78793          	addi	a5,a5,1676 # 80d24e90 <PID_ALLOCATOR>
    8020780c:	639c                	ld	a5,0(a5)
    8020780e:	00178713          	addi	a4,a5,1
    80207812:	00b1d797          	auipc	a5,0xb1d
    80207816:	67e78793          	addi	a5,a5,1662 # 80d24e90 <PID_ALLOCATOR>
    8020781a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:21
    }
    return handle;
    8020781c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:22
}
    80207820:	853e                	mv	a0,a5
    80207822:	60e2                	ld	ra,24(sp)
    80207824:	6442                	ld	s0,16(sp)
    80207826:	6105                	addi	sp,sp,32
    80207828:	8082                	ret

000000008020782a <PidAllocator_dealloc>:
PidAllocator_dealloc():
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:25

void PidAllocator_dealloc(PidHandle pid) 
{
    8020782a:	7139                	addi	sp,sp,-64
    8020782c:	fc06                	sd	ra,56(sp)
    8020782e:	f822                	sd	s0,48(sp)
    80207830:	f426                	sd	s1,40(sp)
    80207832:	0080                	addi	s0,sp,64
    80207834:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:26
    ASSERT(pid.pid < PID_ALLOCATOR.current.pid);
    80207838:	fc843703          	ld	a4,-56(s0)
    8020783c:	00b1d797          	auipc	a5,0xb1d
    80207840:	65478793          	addi	a5,a5,1620 # 80d24e90 <PID_ALLOCATOR>
    80207844:	639c                	ld	a5,0(a5)
    80207846:	00f76d63          	bltu	a4,a5,80207860 <PidAllocator_dealloc+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:26 (discriminator 1)
    8020784a:	00002617          	auipc	a2,0x2
    8020784e:	e9660613          	addi	a2,a2,-362 # 802096e0 <MMIO+0x10>
    80207852:	45e9                	li	a1,26
    80207854:	00002517          	auipc	a0,0x2
    80207858:	ec450513          	addi	a0,a0,-316 # 80209718 <MMIO+0x48>
    8020785c:	e3dfe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:27
    for (size_t i = 0; i < vector_size(&PID_ALLOCATOR.recycled); ++i) {
    80207860:	fc043c23          	sd	zero,-40(s0)
    80207864:	a83d                	j	802078a2 <PidAllocator_dealloc+0x78>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:28
        ASSERT(pid.pid != *(uint64_t*)vector_get(&PID_ALLOCATOR.recycled, i));
    80207866:	fc843483          	ld	s1,-56(s0)
    8020786a:	fd843583          	ld	a1,-40(s0)
    8020786e:	00b1d517          	auipc	a0,0xb1d
    80207872:	62a50513          	addi	a0,a0,1578 # 80d24e98 <PID_ALLOCATOR+0x8>
    80207876:	243000ef          	jal	ra,802082b8 <vector_get>
    8020787a:	87aa                	mv	a5,a0
    8020787c:	639c                	ld	a5,0(a5)
    8020787e:	00f49d63          	bne	s1,a5,80207898 <PidAllocator_dealloc+0x6e>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:28 (discriminator 1)
    80207882:	00002617          	auipc	a2,0x2
    80207886:	eae60613          	addi	a2,a2,-338 # 80209730 <MMIO+0x60>
    8020788a:	45f1                	li	a1,28
    8020788c:	00002517          	auipc	a0,0x2
    80207890:	e8c50513          	addi	a0,a0,-372 # 80209718 <MMIO+0x48>
    80207894:	e05fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:27 (discriminator 2)
    for (size_t i = 0; i < vector_size(&PID_ALLOCATOR.recycled); ++i) {
    80207898:	fd843783          	ld	a5,-40(s0)
    8020789c:	0785                	addi	a5,a5,1
    8020789e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:27 (discriminator 1)
    802078a2:	00b1d517          	auipc	a0,0xb1d
    802078a6:	5f650513          	addi	a0,a0,1526 # 80d24e98 <PID_ALLOCATOR+0x8>
    802078aa:	24d000ef          	jal	ra,802082f6 <vector_size>
    802078ae:	872a                	mv	a4,a0
    802078b0:	fd843783          	ld	a5,-40(s0)
    802078b4:	fae7e9e3          	bltu	a5,a4,80207866 <PidAllocator_dealloc+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:30
    }
    vector_push(&PID_ALLOCATOR.recycled, &pid);
    802078b8:	fc840793          	addi	a5,s0,-56
    802078bc:	85be                	mv	a1,a5
    802078be:	00b1d517          	auipc	a0,0xb1d
    802078c2:	5da50513          	addi	a0,a0,1498 # 80d24e98 <PID_ALLOCATOR+0x8>
    802078c6:	7a6000ef          	jal	ra,8020806c <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/batch/pid/pid.c:31
    802078ca:	0001                	nop
    802078cc:	70e2                	ld	ra,56(sp)
    802078ce:	7442                	ld	s0,48(sp)
    802078d0:	74a2                	ld	s1,40(sp)
    802078d2:	6121                	addi	sp,sp,64
    802078d4:	8082                	ret

00000000802078d6 <w_stvec>:
w_stvec():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:132
static inline void w_stvec(uint64_t x) {
    802078d6:	1101                	addi	sp,sp,-32
    802078d8:	ec22                	sd	s0,24(sp)
    802078da:	1000                	addi	s0,sp,32
    802078dc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:133
  asm volatile("csrw stvec, %0" : : "r"(x));
    802078e0:	fe843783          	ld	a5,-24(s0)
    802078e4:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:134
}
    802078e8:	0001                	nop
    802078ea:	6462                	ld	s0,24(sp)
    802078ec:	6105                	addi	sp,sp,32
    802078ee:	8082                	ret

00000000802078f0 <r_scause>:
r_scause():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:174
static inline uint64_t r_scause() {
    802078f0:	1101                	addi	sp,sp,-32
    802078f2:	ec22                	sd	s0,24(sp)
    802078f4:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:176
  asm volatile("csrr %0, scause" : "=r"(x));
    802078f6:	142027f3          	csrr	a5,scause
    802078fa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:177
  return x;
    802078fe:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:178
}
    80207902:	853e                	mv	a0,a5
    80207904:	6462                	ld	s0,24(sp)
    80207906:	6105                	addi	sp,sp,32
    80207908:	8082                	ret

000000008020790a <print_sepc>:
print_sepc():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:18
extern void __alltraps();
extern void __restore();


void print_sepc()
{
    8020790a:	1101                	addi	sp,sp,-32
    8020790c:	ec06                	sd	ra,24(sp)
    8020790e:	e822                	sd	s0,16(sp)
    80207910:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:19
    print_str("sepc : ");
    80207912:	00002517          	auipc	a0,0x2
    80207916:	e7e50513          	addi	a0,a0,-386 # 80209790 <MMIO+0x10>
    8020791a:	abbfe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:20
    print_uint64(READ_CSR(sepc));
    8020791e:	141027f3          	csrr	a5,sepc
    80207922:	fef43423          	sd	a5,-24(s0)
    80207926:	fe843783          	ld	a5,-24(s0)
    8020792a:	853e                	mv	a0,a5
    8020792c:	c27fe0ef          	jal	ra,80206552 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:21
    print_str("\n");    
    80207930:	00002517          	auipc	a0,0x2
    80207934:	e6850513          	addi	a0,a0,-408 # 80209798 <MMIO+0x18>
    80207938:	a9dfe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:22
}
    8020793c:	0001                	nop
    8020793e:	60e2                	ld	ra,24(sp)
    80207940:	6442                	ld	s0,16(sp)
    80207942:	6105                	addi	sp,sp,32
    80207944:	8082                	ret

0000000080207946 <trap_handler>:
trap_handler():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:40
//     WRITE_CSR(sie, sie);
//     WRITE_CSR(sscratch,Trap_Stack);
// }

void trap_handler() 
{
    80207946:	1101                	addi	sp,sp,-32
    80207948:	ec06                	sd	ra,24(sp)
    8020794a:	e822                	sd	s0,16(sp)
    8020794c:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:41
  set_kernel_trap_entry();
    8020794e:	280000ef          	jal	ra,80207bce <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:43

  struct TrapContext *cx = task_current_trap_cx();
    80207952:	888ff0ef          	jal	ra,802069da <task_current_trap_cx>
    80207956:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:44
  uint64_t scause = r_scause();
    8020795a:	f97ff0ef          	jal	ra,802078f0 <r_scause>
    8020795e:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:46

  if (scause & (1ULL << 63)) {
    80207962:	fe043783          	ld	a5,-32(s0)
    80207966:	0207d363          	bgez	a5,8020798c <trap_handler+0x46>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:47
    scause &= ~(1ULL << 63);
    8020796a:	fe043703          	ld	a4,-32(s0)
    8020796e:	57fd                	li	a5,-1
    80207970:	8385                	srli	a5,a5,0x1
    80207972:	8ff9                	and	a5,a5,a4
    80207974:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:48
    switch (scause) {
    80207978:	fe043703          	ld	a4,-32(s0)
    8020797c:	4795                	li	a5,5
    8020797e:	0af71163          	bne	a4,a5,80207a20 <trap_handler+0xda>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:50
    case SupervisorTimer:
      intr_timer_handle();
    80207982:	4d4000ef          	jal	ra,80207e56 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:51
      task_exit_current_and_run_next();
    80207986:	f52ff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:52
      break;
    8020798a:	a861                	j	80207a22 <trap_handler+0xdc>
    8020798c:	fe043703          	ld	a4,-32(s0)
    80207990:	47bd                	li	a5,15
    80207992:	06e7ea63          	bltu	a5,a4,80207a06 <trap_handler+0xc0>
    80207996:	fe043783          	ld	a5,-32(s0)
    8020799a:	00279713          	slli	a4,a5,0x2
    8020799e:	00002797          	auipc	a5,0x2
    802079a2:	e2e78793          	addi	a5,a5,-466 # 802097cc <MMIO+0x4c>
    802079a6:	97ba                	add	a5,a5,a4
    802079a8:	439c                	lw	a5,0(a5)
    802079aa:	0007871b          	sext.w	a4,a5
    802079ae:	00002797          	auipc	a5,0x2
    802079b2:	e1e78793          	addi	a5,a5,-482 # 802097cc <MMIO+0x4c>
    802079b6:	97ba                	add	a5,a5,a4
    802079b8:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:60
      break;
    }
  } else {
    switch (scause) {
    case UserEnvCall:
      cx->sepc += 4;
    802079ba:	fe843783          	ld	a5,-24(s0)
    802079be:	1087b783          	ld	a5,264(a5)
    802079c2:	00478713          	addi	a4,a5,4
    802079c6:	fe843783          	ld	a5,-24(s0)
    802079ca:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:61
      cx->x[10] = syscall(cx->x[17], cx->x[10], cx->x[11], cx->x[12]);
    802079ce:	fe843783          	ld	a5,-24(s0)
    802079d2:	67d8                	ld	a4,136(a5)
    802079d4:	fe843783          	ld	a5,-24(s0)
    802079d8:	6bac                	ld	a1,80(a5)
    802079da:	fe843783          	ld	a5,-24(s0)
    802079de:	6fb0                	ld	a2,88(a5)
    802079e0:	fe843783          	ld	a5,-24(s0)
    802079e4:	73bc                	ld	a5,96(a5)
    802079e6:	86be                	mv	a3,a5
    802079e8:	853a                	mv	a0,a4
    802079ea:	354000ef          	jal	ra,80207d3e <syscall>
    802079ee:	87aa                	mv	a5,a0
    802079f0:	873e                	mv	a4,a5
    802079f2:	fe843783          	ld	a5,-24(s0)
    802079f6:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:62
      break;
    802079f8:	a02d                	j	80207a22 <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:71
    case InstructionPageFault:
    case LoadFault:
    case LoadPageFault:
      ASSERT("Exception %lld in application, bad addr = %llx, bad instruction = ");
      ASSERT("LoadPageFault\n");
      task_exit_current_and_run_next();
    802079fa:	edeff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:72
      break;
    802079fe:	a015                	j	80207a22 <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:75
    case IllegalInstruction:
      ASSERT("IllegalInstruction in application, core dumped.\n");
      task_exit_current_and_run_next();
    80207a00:	ed8ff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:76
      break;
    80207a04:	a839                	j	80207a22 <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:78 (discriminator 1)
    default:
      ASSERT(0);
    80207a06:	00002617          	auipc	a2,0x2
    80207a0a:	d9a60613          	addi	a2,a2,-614 # 802097a0 <MMIO+0x20>
    80207a0e:	04e00593          	li	a1,78
    80207a12:	00002517          	auipc	a0,0x2
    80207a16:	da650513          	addi	a0,a0,-602 # 802097b8 <MMIO+0x38>
    80207a1a:	c7ffe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:79 (discriminator 1)
      break;
    80207a1e:	a011                	j	80207a22 <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:55
      break;
    80207a20:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:83
    }
  }

  trap_return();
    80207a22:	03e000ef          	jal	ra,80207a60 <trap_return>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:84
}
    80207a26:	0001                	nop
    80207a28:	60e2                	ld	ra,24(sp)
    80207a2a:	6442                	ld	s0,16(sp)
    80207a2c:	6105                	addi	sp,sp,32
    80207a2e:	8082                	ret

0000000080207a30 <set_user_trap_entry>:
set_user_trap_entry():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:88


void set_user_trap_entry() 
{
    80207a30:	1141                	addi	sp,sp,-16
    80207a32:	e406                	sd	ra,8(sp)
    80207a34:	e022                	sd	s0,0(sp)
    80207a36:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:89
  w_stvec((uint64_t)TRAMPOLINE);
    80207a38:	757d                	lui	a0,0xfffff
    80207a3a:	e9dff0ef          	jal	ra,802078d6 <w_stvec>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:90
}
    80207a3e:	0001                	nop
    80207a40:	60a2                	ld	ra,8(sp)
    80207a42:	6402                	ld	s0,0(sp)
    80207a44:	0141                	addi	sp,sp,16
    80207a46:	8082                	ret

0000000080207a48 <task_current_user_token>:
task_current_user_token():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:93


uint64_t task_current_user_token() {
    80207a48:	1141                	addi	sp,sp,-16
    80207a4a:	e406                	sd	ra,8(sp)
    80207a4c:	e022                	sd	s0,0(sp)
    80207a4e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:94
  return task_manager_get_current_token();
    80207a50:	dfffe0ef          	jal	ra,8020684e <task_manager_get_current_token>
    80207a54:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:95
}
    80207a56:	853e                	mv	a0,a5
    80207a58:	60a2                	ld	ra,8(sp)
    80207a5a:	6402                	ld	s0,0(sp)
    80207a5c:	0141                	addi	sp,sp,16
    80207a5e:	8082                	ret

0000000080207a60 <trap_return>:
trap_return():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:98

void trap_return() 
{
    80207a60:	7179                	addi	sp,sp,-48
    80207a62:	f406                	sd	ra,40(sp)
    80207a64:	f022                	sd	s0,32(sp)
    80207a66:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:99
  set_user_trap_entry();
    80207a68:	fc9ff0ef          	jal	ra,80207a30 <set_user_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:100
  uint64_t trap_cx_ptr = TRAP_CONTEXT;
    80207a6c:	77f9                	lui	a5,0xffffe
    80207a6e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:101
  uint64_t user_satp = task_current_user_token();
    80207a72:	fd7ff0ef          	jal	ra,80207a48 <task_current_user_token>
    80207a76:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:102
  uint64_t restore_va = (uint64_t)__restore - (uint64_t)__alltraps + TRAMPOLINE;
    80207a7a:	ffff9717          	auipc	a4,0xffff9
    80207a7e:	5e670713          	addi	a4,a4,1510 # 80201060 <__restore>
    80207a82:	77fd                	lui	a5,0xfffff
    80207a84:	973e                	add	a4,a4,a5
    80207a86:	ffff9797          	auipc	a5,0xffff9
    80207a8a:	57a78793          	addi	a5,a5,1402 # 80201000 <__alltraps>
    80207a8e:	40f707b3          	sub	a5,a4,a5
    80207a92:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:103
  asm volatile("fence.i");
    80207a96:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:105
  asm volatile("");
  asm volatile("mv x10, %1\n"
    80207a9a:	fd843783          	ld	a5,-40(s0)
    80207a9e:	fe843703          	ld	a4,-24(s0)
    80207aa2:	fe043683          	ld	a3,-32(s0)
    80207aa6:	853a                	mv	a0,a4
    80207aa8:	85b6                	mv	a1,a3
    80207aaa:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:111
               "mv x11, %2\n"
               "jr %0\n"
               :
               : "r"(restore_va), "r"(trap_cx_ptr), "r"(user_satp)
               : "memory", "x10", "x11");
  panic("Unreachable in back_to_user!\n");
    80207aac:	00002617          	auipc	a2,0x2
    80207ab0:	d6460613          	addi	a2,a2,-668 # 80209810 <MMIO+0x90>
    80207ab4:	06f00593          	li	a1,111
    80207ab8:	00002517          	auipc	a0,0x2
    80207abc:	d0050513          	addi	a0,a0,-768 # 802097b8 <MMIO+0x38>
    80207ac0:	bd9fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:112
}
    80207ac4:	0001                	nop
    80207ac6:	70a2                	ld	ra,40(sp)
    80207ac8:	7402                	ld	s0,32(sp)
    80207aca:	6145                	addi	sp,sp,48
    80207acc:	8082                	ret

0000000080207ace <init_trap>:
init_trap():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:116


void init_trap()
{
    80207ace:	1141                	addi	sp,sp,-16
    80207ad0:	e406                	sd	ra,8(sp)
    80207ad2:	e022                	sd	s0,0(sp)
    80207ad4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:117
    set_kernel_trap_entry();
    80207ad6:	0f8000ef          	jal	ra,80207bce <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:118
}
    80207ada:	0001                	nop
    80207adc:	60a2                	ld	ra,8(sp)
    80207ade:	6402                	ld	s0,0(sp)
    80207ae0:	0141                	addi	sp,sp,16
    80207ae2:	8082                	ret

0000000080207ae4 <trap_from_kernel>:
trap_from_kernel():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:122


void trap_from_kernel() 
{
    80207ae4:	1101                	addi	sp,sp,-32
    80207ae6:	ec06                	sd	ra,24(sp)
    80207ae8:	e822                	sd	s0,16(sp)
    80207aea:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:123
  set_kernel_trap_entry();
    80207aec:	0e2000ef          	jal	ra,80207bce <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:125

  struct TrapContext *cx = task_current_trap_cx();
    80207af0:	eebfe0ef          	jal	ra,802069da <task_current_trap_cx>
    80207af4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:126
  uint64_t scause = r_scause();
    80207af8:	df9ff0ef          	jal	ra,802078f0 <r_scause>
    80207afc:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:128

  if (scause & (1ULL << 63)) {
    80207b00:	fe043783          	ld	a5,-32(s0)
    80207b04:	0207d363          	bgez	a5,80207b2a <trap_from_kernel+0x46>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:129
    scause &= ~(1ULL << 63);
    80207b08:	fe043703          	ld	a4,-32(s0)
    80207b0c:	57fd                	li	a5,-1
    80207b0e:	8385                	srli	a5,a5,0x1
    80207b10:	8ff9                	and	a5,a5,a4
    80207b12:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:130
    switch (scause) {
    80207b16:	fe043703          	ld	a4,-32(s0)
    80207b1a:	4795                	li	a5,5
    80207b1c:	0af71163          	bne	a4,a5,80207bbe <trap_from_kernel+0xda>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:132
    case SupervisorTimer:
      intr_timer_handle();
    80207b20:	336000ef          	jal	ra,80207e56 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:133
      task_exit_current_and_run_next();
    80207b24:	db4ff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:134
      break;
    80207b28:	a861                	j	80207bc0 <trap_from_kernel+0xdc>
    80207b2a:	fe043703          	ld	a4,-32(s0)
    80207b2e:	47bd                	li	a5,15
    80207b30:	06e7ea63          	bltu	a5,a4,80207ba4 <trap_from_kernel+0xc0>
    80207b34:	fe043783          	ld	a5,-32(s0)
    80207b38:	00279713          	slli	a4,a5,0x2
    80207b3c:	00002797          	auipc	a5,0x2
    80207b40:	cf478793          	addi	a5,a5,-780 # 80209830 <MMIO+0xb0>
    80207b44:	97ba                	add	a5,a5,a4
    80207b46:	439c                	lw	a5,0(a5)
    80207b48:	0007871b          	sext.w	a4,a5
    80207b4c:	00002797          	auipc	a5,0x2
    80207b50:	ce478793          	addi	a5,a5,-796 # 80209830 <MMIO+0xb0>
    80207b54:	97ba                	add	a5,a5,a4
    80207b56:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:142
      break;
    }
  } else {
    switch (scause) {
    case UserEnvCall:
      cx->sepc += 4;
    80207b58:	fe843783          	ld	a5,-24(s0)
    80207b5c:	1087b783          	ld	a5,264(a5)
    80207b60:	00478713          	addi	a4,a5,4
    80207b64:	fe843783          	ld	a5,-24(s0)
    80207b68:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:143
      cx->x[10] = syscall(cx->x[17], cx->x[10], cx->x[11], cx->x[12]);
    80207b6c:	fe843783          	ld	a5,-24(s0)
    80207b70:	67d8                	ld	a4,136(a5)
    80207b72:	fe843783          	ld	a5,-24(s0)
    80207b76:	6bac                	ld	a1,80(a5)
    80207b78:	fe843783          	ld	a5,-24(s0)
    80207b7c:	6fb0                	ld	a2,88(a5)
    80207b7e:	fe843783          	ld	a5,-24(s0)
    80207b82:	73bc                	ld	a5,96(a5)
    80207b84:	86be                	mv	a3,a5
    80207b86:	853a                	mv	a0,a4
    80207b88:	1b6000ef          	jal	ra,80207d3e <syscall>
    80207b8c:	87aa                	mv	a5,a0
    80207b8e:	873e                	mv	a4,a5
    80207b90:	fe843783          	ld	a5,-24(s0)
    80207b94:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:144
      break;
    80207b96:	a02d                	j	80207bc0 <trap_from_kernel+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:153
    case InstructionPageFault:
    case LoadFault:
    case LoadPageFault:
      ASSERT("Exception %lld in application, bad addr = %llx, bad instruction = ");
      ASSERT("LoadPageFault\n");
      task_exit_current_and_run_next();
    80207b98:	d40ff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:154
      break;
    80207b9c:	a015                	j	80207bc0 <trap_from_kernel+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:157
    case IllegalInstruction:
      ASSERT("IllegalInstruction in application, core dumped.\n");
      task_exit_current_and_run_next();
    80207b9e:	d3aff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:158
      break;
    80207ba2:	a839                	j	80207bc0 <trap_from_kernel+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:160 (discriminator 1)
    default:
      ASSERT(0);
    80207ba4:	00002617          	auipc	a2,0x2
    80207ba8:	bfc60613          	addi	a2,a2,-1028 # 802097a0 <MMIO+0x20>
    80207bac:	0a000593          	li	a1,160
    80207bb0:	00002517          	auipc	a0,0x2
    80207bb4:	c0850513          	addi	a0,a0,-1016 # 802097b8 <MMIO+0x38>
    80207bb8:	ae1fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:161 (discriminator 1)
      break;
    80207bbc:	a011                	j	80207bc0 <trap_from_kernel+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:137
      break;
    80207bbe:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:165
    }
  }

  trap_return();
    80207bc0:	ea1ff0ef          	jal	ra,80207a60 <trap_return>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:166
}
    80207bc4:	0001                	nop
    80207bc6:	60e2                	ld	ra,24(sp)
    80207bc8:	6442                	ld	s0,16(sp)
    80207bca:	6105                	addi	sp,sp,32
    80207bcc:	8082                	ret

0000000080207bce <set_kernel_trap_entry>:
set_kernel_trap_entry():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:170


void set_kernel_trap_entry()
{
    80207bce:	1141                	addi	sp,sp,-16
    80207bd0:	e406                	sd	ra,8(sp)
    80207bd2:	e022                	sd	s0,0(sp)
    80207bd4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:171
    w_stvec((uint64_t)trap_from_kernel);
    80207bd6:	00000797          	auipc	a5,0x0
    80207bda:	f0e78793          	addi	a5,a5,-242 # 80207ae4 <trap_from_kernel>
    80207bde:	853e                	mv	a0,a5
    80207be0:	cf7ff0ef          	jal	ra,802078d6 <w_stvec>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:172
}
    80207be4:	0001                	nop
    80207be6:	60a2                	ld	ra,8(sp)
    80207be8:	6402                	ld	s0,0(sp)
    80207bea:	0141                	addi	sp,sp,16
    80207bec:	8082                	ret

0000000080207bee <exit>:
exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:12
#include "sbi.h"
#include "mem.h"
#include "stdint.h"
#include "trap.h"
int32_t exit(int32_t value)
{
    80207bee:	1101                	addi	sp,sp,-32
    80207bf0:	ec06                	sd	ra,24(sp)
    80207bf2:	e822                	sd	s0,16(sp)
    80207bf4:	1000                	addi	s0,sp,32
    80207bf6:	87aa                	mv	a5,a0
    80207bf8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:13
    print_str("exit : ");
    80207bfc:	00002517          	auipc	a0,0x2
    80207c00:	c8450513          	addi	a0,a0,-892 # 80209880 <MMIO+0x10>
    80207c04:	fd0fe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:14
    print_uint32((uint32_t)value);
    80207c08:	fec42783          	lw	a5,-20(s0)
    80207c0c:	853e                	mv	a0,a5
    80207c0e:	891fe0ef          	jal	ra,8020649e <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:15
    print_str("\n");
    80207c12:	00002517          	auipc	a0,0x2
    80207c16:	c7650513          	addi	a0,a0,-906 # 80209888 <MMIO+0x18>
    80207c1a:	fbafe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:16
    return value;
    80207c1e:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:17
}
    80207c22:	853e                	mv	a0,a5
    80207c24:	60e2                	ld	ra,24(sp)
    80207c26:	6442                	ld	s0,16(sp)
    80207c28:	6105                	addi	sp,sp,32
    80207c2a:	8082                	ret

0000000080207c2c <write>:
write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:19

int64_t write(uint64_t fd, char *buf, uint64_t len) {
    80207c2c:	7139                	addi	sp,sp,-64
    80207c2e:	fc06                	sd	ra,56(sp)
    80207c30:	f822                	sd	s0,48(sp)
    80207c32:	0080                	addi	s0,sp,64
    80207c34:	fca43c23          	sd	a0,-40(s0)
    80207c38:	fcb43823          	sd	a1,-48(s0)
    80207c3c:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:22
  static uint8_t sys_write_buf[1024];

  switch (fd) {
    80207c40:	fd843703          	ld	a4,-40(s0)
    80207c44:	4785                	li	a5,1
    80207c46:	04f71e63          	bne	a4,a5,80207ca2 <write+0x76>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:24
  case 1:
    copy_byte_buffer(task_current_user_token(), sys_write_buf, (uint8_t *)buf,
    80207c4a:	dffff0ef          	jal	ra,80207a48 <task_current_user_token>
    80207c4e:	87aa                	mv	a5,a0
    80207c50:	4701                	li	a4,0
    80207c52:	fc843683          	ld	a3,-56(s0)
    80207c56:	fd043603          	ld	a2,-48(s0)
    80207c5a:	00b1d597          	auipc	a1,0xb1d
    80207c5e:	26658593          	addi	a1,a1,614 # 80d24ec0 <sys_write_buf.0>
    80207c62:	853e                	mv	a0,a5
    80207c64:	dc0fd0ef          	jal	ra,80205224 <copy_byte_buffer>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:26
                     len, FROM_USER);
    for (uint64_t i = 0; i < len; i++) 
    80207c68:	fe043423          	sd	zero,-24(s0)
    80207c6c:	a015                	j	80207c90 <write+0x64>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:28 (discriminator 3)
    {
      console_putchar(sys_write_buf[i]);
    80207c6e:	00b1d717          	auipc	a4,0xb1d
    80207c72:	25270713          	addi	a4,a4,594 # 80d24ec0 <sys_write_buf.0>
    80207c76:	fe843783          	ld	a5,-24(s0)
    80207c7a:	97ba                	add	a5,a5,a4
    80207c7c:	0007c783          	lbu	a5,0(a5)
    80207c80:	853e                	mv	a0,a5
    80207c82:	e6afb0ef          	jal	ra,802032ec <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:26 (discriminator 3)
    for (uint64_t i = 0; i < len; i++) 
    80207c86:	fe843783          	ld	a5,-24(s0)
    80207c8a:	0785                	addi	a5,a5,1
    80207c8c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:26 (discriminator 1)
    80207c90:	fe843703          	ld	a4,-24(s0)
    80207c94:	fc843783          	ld	a5,-56(s0)
    80207c98:	fcf76be3          	bltu	a4,a5,80207c6e <write+0x42>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:30
    }
    return (int64_t)len;
    80207c9c:	fc843783          	ld	a5,-56(s0)
    80207ca0:	a019                	j	80207ca6 <write+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:32
  default:
    break;
    80207ca2:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:34
  }
  return -1;
    80207ca4:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:35
}
    80207ca6:	853e                	mv	a0,a5
    80207ca8:	70e2                	ld	ra,56(sp)
    80207caa:	7442                	ld	s0,48(sp)
    80207cac:	6121                	addi	sp,sp,64
    80207cae:	8082                	ret

0000000080207cb0 <yield>:
yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:38

int64_t yield()
{
    80207cb0:	1141                	addi	sp,sp,-16
    80207cb2:	e406                	sd	ra,8(sp)
    80207cb4:	e022                	sd	s0,0(sp)
    80207cb6:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:39
    print_str("\n-------yield------\n");
    80207cb8:	00002517          	auipc	a0,0x2
    80207cbc:	bd850513          	addi	a0,a0,-1064 # 80209890 <MMIO+0x20>
    80207cc0:	f14fe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:40
    task_suspend_current_and_run_next();
    80207cc4:	c6cff0ef          	jal	ra,80207130 <task_suspend_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:41
    return 1;
    80207cc8:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:42
}
    80207cca:	853e                	mv	a0,a5
    80207ccc:	60a2                	ld	ra,8(sp)
    80207cce:	6402                	ld	s0,0(sp)
    80207cd0:	0141                	addi	sp,sp,16
    80207cd2:	8082                	ret

0000000080207cd4 <sys_write>:
sys_write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:45

int64_t sys_write(uint64_t fd, char *buf, uint64_t count) 
{
    80207cd4:	7179                	addi	sp,sp,-48
    80207cd6:	f406                	sd	ra,40(sp)
    80207cd8:	f022                	sd	s0,32(sp)
    80207cda:	1800                	addi	s0,sp,48
    80207cdc:	fea43423          	sd	a0,-24(s0)
    80207ce0:	feb43023          	sd	a1,-32(s0)
    80207ce4:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:46
    return write(fd, buf, count); // 使用POSIX write
    80207ce8:	fd843603          	ld	a2,-40(s0)
    80207cec:	fe043583          	ld	a1,-32(s0)
    80207cf0:	fe843503          	ld	a0,-24(s0)
    80207cf4:	f39ff0ef          	jal	ra,80207c2c <write>
    80207cf8:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:47
}
    80207cfa:	853e                	mv	a0,a5
    80207cfc:	70a2                	ld	ra,40(sp)
    80207cfe:	7402                	ld	s0,32(sp)
    80207d00:	6145                	addi	sp,sp,48
    80207d02:	8082                	ret

0000000080207d04 <sys_exit>:
sys_exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:50

void sys_exit(int32_t status) 
{
    80207d04:	1101                	addi	sp,sp,-32
    80207d06:	ec06                	sd	ra,24(sp)
    80207d08:	e822                	sd	s0,16(sp)
    80207d0a:	1000                	addi	s0,sp,32
    80207d0c:	87aa                	mv	a5,a0
    80207d0e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:51
    exit(status);
    80207d12:	fec42783          	lw	a5,-20(s0)
    80207d16:	853e                	mv	a0,a5
    80207d18:	ed7ff0ef          	jal	ra,80207bee <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:52
}
    80207d1c:	0001                	nop
    80207d1e:	60e2                	ld	ra,24(sp)
    80207d20:	6442                	ld	s0,16(sp)
    80207d22:	6105                	addi	sp,sp,32
    80207d24:	8082                	ret

0000000080207d26 <sys_yield>:
sys_yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:55

int64_t sys_yield()
{
    80207d26:	1141                	addi	sp,sp,-16
    80207d28:	e406                	sd	ra,8(sp)
    80207d2a:	e022                	sd	s0,0(sp)
    80207d2c:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:56
    return yield();
    80207d2e:	f83ff0ef          	jal	ra,80207cb0 <yield>
    80207d32:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:57
}
    80207d34:	853e                	mv	a0,a5
    80207d36:	60a2                	ld	ra,8(sp)
    80207d38:	6402                	ld	s0,0(sp)
    80207d3a:	0141                	addi	sp,sp,16
    80207d3c:	8082                	ret

0000000080207d3e <syscall>:
syscall():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:61

// 系统调用处理函数
int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2)
{   
    80207d3e:	7179                	addi	sp,sp,-48
    80207d40:	f406                	sd	ra,40(sp)
    80207d42:	f022                	sd	s0,32(sp)
    80207d44:	1800                	addi	s0,sp,48
    80207d46:	fea43423          	sd	a0,-24(s0)
    80207d4a:	feb43023          	sd	a1,-32(s0)
    80207d4e:	fcc43c23          	sd	a2,-40(s0)
    80207d52:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:63
    //printk("syscall\n");
    switch (syscall_id)
    80207d56:	fe843703          	ld	a4,-24(s0)
    80207d5a:	07c00793          	li	a5,124
    80207d5e:	04f70863          	beq	a4,a5,80207dae <syscall+0x70>
    80207d62:	fe843703          	ld	a4,-24(s0)
    80207d66:	07c00793          	li	a5,124
    80207d6a:	04e7e663          	bltu	a5,a4,80207db6 <syscall+0x78>
    80207d6e:	fe843703          	ld	a4,-24(s0)
    80207d72:	04000793          	li	a5,64
    80207d76:	00f70963          	beq	a4,a5,80207d88 <syscall+0x4a>
    80207d7a:	fe843703          	ld	a4,-24(s0)
    80207d7e:	05d00793          	li	a5,93
    80207d82:	00f70e63          	beq	a4,a5,80207d9e <syscall+0x60>
    80207d86:	a805                	j	80207db6 <syscall+0x78>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:66
    {
        case SYSCALL_WRITE:
            return sys_write(a0, (char *)a1, a2);
    80207d88:	fd843783          	ld	a5,-40(s0)
    80207d8c:	fd043603          	ld	a2,-48(s0)
    80207d90:	85be                	mv	a1,a5
    80207d92:	fe043503          	ld	a0,-32(s0)
    80207d96:	f3fff0ef          	jal	ra,80207cd4 <sys_write>
    80207d9a:	87aa                	mv	a5,a0
    80207d9c:	a8a1                	j	80207df4 <syscall+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:68
        case SYSCALL_EXIT:
            sys_exit((int32_t)a0);
    80207d9e:	fe043783          	ld	a5,-32(s0)
    80207da2:	2781                	sext.w	a5,a5
    80207da4:	853e                	mv	a0,a5
    80207da6:	f5fff0ef          	jal	ra,80207d04 <sys_exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:69
            task_exit_current_and_run_next();
    80207daa:	b2eff0ef          	jal	ra,802070d8 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:72
        case SYSCALL_YIELD:
            // task_exit_current_and_run_next();
            return sys_yield();
    80207dae:	f79ff0ef          	jal	ra,80207d26 <sys_yield>
    80207db2:	87aa                	mv	a5,a0
    80207db4:	a081                	j	80207df4 <syscall+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:74
        default:
            print_str("unsupportable syscall_id\n");
    80207db6:	00002517          	auipc	a0,0x2
    80207dba:	af250513          	addi	a0,a0,-1294 # 802098a8 <MMIO+0x38>
    80207dbe:	e16fe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:75
            ASSERT(0);
    80207dc2:	00002617          	auipc	a2,0x2
    80207dc6:	b0660613          	addi	a2,a2,-1274 # 802098c8 <MMIO+0x58>
    80207dca:	04b00593          	li	a1,75
    80207dce:	00002517          	auipc	a0,0x2
    80207dd2:	b1250513          	addi	a0,a0,-1262 # 802098e0 <MMIO+0x70>
    80207dd6:	8c3fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:77
    }
    ASSERT(0);
    80207dda:	00002617          	auipc	a2,0x2
    80207dde:	aee60613          	addi	a2,a2,-1298 # 802098c8 <MMIO+0x58>
    80207de2:	04d00593          	li	a1,77
    80207de6:	00002517          	auipc	a0,0x2
    80207dea:	afa50513          	addi	a0,a0,-1286 # 802098e0 <MMIO+0x70>
    80207dee:	8abfe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:78
    return -1;
    80207df2:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:79
}
    80207df4:	853e                	mv	a0,a5
    80207df6:	70a2                	ld	ra,40(sp)
    80207df8:	7402                	ld	s0,32(sp)
    80207dfa:	6145                	addi	sp,sp,48
    80207dfc:	8082                	ret

0000000080207dfe <read_time>:
read_time():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:5
#include "timer.h"
#include "sbi.h"
#include "task.h"
static inline uint64_t read_time(void) 
{
    80207dfe:	1101                	addi	sp,sp,-32
    80207e00:	ec22                	sd	s0,24(sp)
    80207e02:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:7
    uint64_t time;
    __asm__ volatile ("csrr %0, time" : "=r"(time));
    80207e04:	c01027f3          	rdtime	a5
    80207e08:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:8
    return time;
    80207e0c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:9
}
    80207e10:	853e                	mv	a0,a5
    80207e12:	6462                	ld	s0,24(sp)
    80207e14:	6105                	addi	sp,sp,32
    80207e16:	8082                	ret

0000000080207e18 <clock_set_next_event>:
clock_set_next_event():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:12

void clock_set_next_event() 
{
    80207e18:	1141                	addi	sp,sp,-16
    80207e1a:	e406                	sd	ra,8(sp)
    80207e1c:	e022                	sd	s0,0(sp)
    80207e1e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:13
    sbi_set_timer(read_time() + TIMEBASE);
    80207e20:	fdfff0ef          	jal	ra,80207dfe <read_time>
    80207e24:	872a                	mv	a4,a0
    80207e26:	05f5e7b7          	lui	a5,0x5f5e
    80207e2a:	10078793          	addi	a5,a5,256 # 5f5e100 <n+0x5f5e0e0>
    80207e2e:	97ba                	add	a5,a5,a4
    80207e30:	853e                	mv	a0,a5
    80207e32:	d20fb0ef          	jal	ra,80203352 <sbi_set_timer>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:14
}
    80207e36:	0001                	nop
    80207e38:	60a2                	ld	ra,8(sp)
    80207e3a:	6402                	ld	s0,0(sp)
    80207e3c:	0141                	addi	sp,sp,16
    80207e3e:	8082                	ret

0000000080207e40 <timer_init>:
timer_init():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:18


void timer_init()
{
    80207e40:	1141                	addi	sp,sp,-16
    80207e42:	e406                	sd	ra,8(sp)
    80207e44:	e022                	sd	s0,0(sp)
    80207e46:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:19
    clock_set_next_event();
    80207e48:	fd1ff0ef          	jal	ra,80207e18 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:21
    //print_str("----timer_init----\n");
}
    80207e4c:	0001                	nop
    80207e4e:	60a2                	ld	ra,8(sp)
    80207e50:	6402                	ld	s0,0(sp)
    80207e52:	0141                	addi	sp,sp,16
    80207e54:	8082                	ret

0000000080207e56 <intr_timer_handle>:
intr_timer_handle():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:25


void intr_timer_handle()
{
    80207e56:	1141                	addi	sp,sp,-16
    80207e58:	e406                	sd	ra,8(sp)
    80207e5a:	e022                	sd	s0,0(sp)
    80207e5c:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:26
    printk("intr_timer_handle\n");
    80207e5e:	00002517          	auipc	a0,0x2
    80207e62:	ab250513          	addi	a0,a0,-1358 # 80209910 <MMIO+0x10>
    80207e66:	985fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:28
    //run_next_task(1);
    ticks++;
    80207e6a:	00b1d797          	auipc	a5,0xb1d
    80207e6e:	45678793          	addi	a5,a5,1110 # 80d252c0 <ticks>
    80207e72:	639c                	ld	a5,0(a5)
    80207e74:	00178713          	addi	a4,a5,1
    80207e78:	00b1d797          	auipc	a5,0xb1d
    80207e7c:	44878793          	addi	a5,a5,1096 # 80d252c0 <ticks>
    80207e80:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:29
    clock_set_next_event();
    80207e82:	f97ff0ef          	jal	ra,80207e18 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:30
    if(ticks % 10 == 0)
    80207e86:	00b1d797          	auipc	a5,0xb1d
    80207e8a:	43a78793          	addi	a5,a5,1082 # 80d252c0 <ticks>
    80207e8e:	6398                	ld	a4,0(a5)
    80207e90:	47a9                	li	a5,10
    80207e92:	02f777b3          	remu	a5,a4,a5
    80207e96:	e799                	bnez	a5,80207ea4 <intr_timer_handle+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:32
    {
        print_str("timer_interrupt\n");
    80207e98:	00002517          	auipc	a0,0x2
    80207e9c:	a9050513          	addi	a0,a0,-1392 # 80209928 <MMIO+0x28>
    80207ea0:	d34fe0ef          	jal	ra,802063d4 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:41
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
    80207ea4:	0001                	nop
    80207ea6:	60a2                	ld	ra,8(sp)
    80207ea8:	6402                	ld	s0,0(sp)
    80207eaa:	0141                	addi	sp,sp,16
    80207eac:	8082                	ret

0000000080207eae <lst_init>:
lst_init():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:10
#include "debug.h"
// double-linked, circular list. double-linked makes remove
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void lst_init(struct list *lst) {
    80207eae:	1101                	addi	sp,sp,-32
    80207eb0:	ec22                	sd	s0,24(sp)
    80207eb2:	1000                	addi	s0,sp,32
    80207eb4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:11
  lst->next = lst;
    80207eb8:	fe843783          	ld	a5,-24(s0)
    80207ebc:	fe843703          	ld	a4,-24(s0)
    80207ec0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:12
  lst->prev = lst;
    80207ec2:	fe843783          	ld	a5,-24(s0)
    80207ec6:	fe843703          	ld	a4,-24(s0)
    80207eca:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:13
}
    80207ecc:	0001                	nop
    80207ece:	6462                	ld	s0,24(sp)
    80207ed0:	6105                	addi	sp,sp,32
    80207ed2:	8082                	ret

0000000080207ed4 <lst_empty>:
lst_empty():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:15

int lst_empty(struct list *lst) { return lst->next == lst; }
    80207ed4:	1101                	addi	sp,sp,-32
    80207ed6:	ec22                	sd	s0,24(sp)
    80207ed8:	1000                	addi	s0,sp,32
    80207eda:	fea43423          	sd	a0,-24(s0)
    80207ede:	fe843783          	ld	a5,-24(s0)
    80207ee2:	639c                	ld	a5,0(a5)
    80207ee4:	fe843703          	ld	a4,-24(s0)
    80207ee8:	40f707b3          	sub	a5,a4,a5
    80207eec:	0017b793          	seqz	a5,a5
    80207ef0:	0ff7f793          	andi	a5,a5,255
    80207ef4:	2781                	sext.w	a5,a5
    80207ef6:	853e                	mv	a0,a5
    80207ef8:	6462                	ld	s0,24(sp)
    80207efa:	6105                	addi	sp,sp,32
    80207efc:	8082                	ret

0000000080207efe <lst_remove>:
lst_remove():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:17

void lst_remove(struct list *e) {
    80207efe:	1101                	addi	sp,sp,-32
    80207f00:	ec22                	sd	s0,24(sp)
    80207f02:	1000                	addi	s0,sp,32
    80207f04:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:18
  e->prev->next = e->next;
    80207f08:	fe843783          	ld	a5,-24(s0)
    80207f0c:	679c                	ld	a5,8(a5)
    80207f0e:	fe843703          	ld	a4,-24(s0)
    80207f12:	6318                	ld	a4,0(a4)
    80207f14:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:19
  e->next->prev = e->prev;
    80207f16:	fe843783          	ld	a5,-24(s0)
    80207f1a:	639c                	ld	a5,0(a5)
    80207f1c:	fe843703          	ld	a4,-24(s0)
    80207f20:	6718                	ld	a4,8(a4)
    80207f22:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:20
}
    80207f24:	0001                	nop
    80207f26:	6462                	ld	s0,24(sp)
    80207f28:	6105                	addi	sp,sp,32
    80207f2a:	8082                	ret

0000000080207f2c <lst_pop>:
lst_pop():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:22

void *lst_pop(struct list *lst) {
    80207f2c:	7179                	addi	sp,sp,-48
    80207f2e:	f406                	sd	ra,40(sp)
    80207f30:	f022                	sd	s0,32(sp)
    80207f32:	1800                	addi	s0,sp,48
    80207f34:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:23
  if (lst->next == lst)
    80207f38:	fd843783          	ld	a5,-40(s0)
    80207f3c:	639c                	ld	a5,0(a5)
    80207f3e:	fd843703          	ld	a4,-40(s0)
    80207f42:	00f71d63          	bne	a4,a5,80207f5c <lst_pop+0x30>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:24
    panic("lst_pop");
    80207f46:	00002617          	auipc	a2,0x2
    80207f4a:	9fa60613          	addi	a2,a2,-1542 # 80209940 <MMIO+0x40>
    80207f4e:	45e1                	li	a1,24
    80207f50:	00002517          	auipc	a0,0x2
    80207f54:	9f850513          	addi	a0,a0,-1544 # 80209948 <MMIO+0x48>
    80207f58:	f40fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:25
  struct list *p = lst->next;
    80207f5c:	fd843783          	ld	a5,-40(s0)
    80207f60:	639c                	ld	a5,0(a5)
    80207f62:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:26
  lst_remove(p);
    80207f66:	fe843503          	ld	a0,-24(s0)
    80207f6a:	f95ff0ef          	jal	ra,80207efe <lst_remove>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:27
  return (void *)p;
    80207f6e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:28
}
    80207f72:	853e                	mv	a0,a5
    80207f74:	70a2                	ld	ra,40(sp)
    80207f76:	7402                	ld	s0,32(sp)
    80207f78:	6145                	addi	sp,sp,48
    80207f7a:	8082                	ret

0000000080207f7c <lst_push>:
lst_push():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:30

void lst_push(struct list *lst, void *p) {
    80207f7c:	7179                	addi	sp,sp,-48
    80207f7e:	f422                	sd	s0,40(sp)
    80207f80:	1800                	addi	s0,sp,48
    80207f82:	fca43c23          	sd	a0,-40(s0)
    80207f86:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:31
  struct list *e = (struct list *)p;
    80207f8a:	fd043783          	ld	a5,-48(s0)
    80207f8e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:32
  e->next = lst->next;
    80207f92:	fd843783          	ld	a5,-40(s0)
    80207f96:	6398                	ld	a4,0(a5)
    80207f98:	fe843783          	ld	a5,-24(s0)
    80207f9c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:33
  e->prev = lst;
    80207f9e:	fe843783          	ld	a5,-24(s0)
    80207fa2:	fd843703          	ld	a4,-40(s0)
    80207fa6:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:34
  lst->next->prev = p;
    80207fa8:	fd843783          	ld	a5,-40(s0)
    80207fac:	639c                	ld	a5,0(a5)
    80207fae:	fd043703          	ld	a4,-48(s0)
    80207fb2:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:35
  lst->next = e;
    80207fb4:	fd843783          	ld	a5,-40(s0)
    80207fb8:	fe843703          	ld	a4,-24(s0)
    80207fbc:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:36
}
    80207fbe:	0001                	nop
    80207fc0:	7422                	ld	s0,40(sp)
    80207fc2:	6145                	addi	sp,sp,48
    80207fc4:	8082                	ret

0000000080207fc6 <lst_print>:
lst_print():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:38

void lst_print(struct list *lst) {
    80207fc6:	7179                	addi	sp,sp,-48
    80207fc8:	f406                	sd	ra,40(sp)
    80207fca:	f022                	sd	s0,32(sp)
    80207fcc:	1800                	addi	s0,sp,48
    80207fce:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80207fd2:	fd843783          	ld	a5,-40(s0)
    80207fd6:	639c                	ld	a5,0(a5)
    80207fd8:	fef43423          	sd	a5,-24(s0)
    80207fdc:	a831                	j	80207ff8 <lst_print+0x32>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:40 (discriminator 3)
    printk(" %p", p);
    80207fde:	fe843583          	ld	a1,-24(s0)
    80207fe2:	00002517          	auipc	a0,0x2
    80207fe6:	98650513          	addi	a0,a0,-1658 # 80209968 <MMIO+0x68>
    80207fea:	801fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39 (discriminator 3)
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80207fee:	fe843783          	ld	a5,-24(s0)
    80207ff2:	639c                	ld	a5,0(a5)
    80207ff4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39 (discriminator 1)
    80207ff8:	fe843703          	ld	a4,-24(s0)
    80207ffc:	fd843783          	ld	a5,-40(s0)
    80208000:	fcf71fe3          	bne	a4,a5,80207fde <lst_print+0x18>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:42
  }
  printk("\n");
    80208004:	00002517          	auipc	a0,0x2
    80208008:	96c50513          	addi	a0,a0,-1684 # 80209970 <MMIO+0x70>
    8020800c:	fdefa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:43
}
    80208010:	0001                	nop
    80208012:	70a2                	ld	ra,40(sp)
    80208014:	7402                	ld	s0,32(sp)
    80208016:	6145                	addi	sp,sp,48
    80208018:	8082                	ret

000000008020801a <vector_new>:
vector_new():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:9
#include "string.h"
#include "buddy.h"
#include "debug.h"
#define VECTOR_INIT_CAPACITY 8

void vector_new(struct vector *v, uint64_t dsize) {
    8020801a:	1101                	addi	sp,sp,-32
    8020801c:	ec06                	sd	ra,24(sp)
    8020801e:	e822                	sd	s0,16(sp)
    80208020:	1000                	addi	s0,sp,32
    80208022:	fea43423          	sd	a0,-24(s0)
    80208026:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:10
  v->size = 0;
    8020802a:	fe843783          	ld	a5,-24(s0)
    8020802e:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:11
  v->capacity = VECTOR_INIT_CAPACITY;
    80208032:	fe843783          	ld	a5,-24(s0)
    80208036:	4721                	li	a4,8
    80208038:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:12
  v->dsize = dsize;
    8020803a:	fe843783          	ld	a5,-24(s0)
    8020803e:	fe043703          	ld	a4,-32(s0)
    80208042:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:13
  v->buffer = bd_malloc(v->capacity * v->dsize);
    80208044:	fe843783          	ld	a5,-24(s0)
    80208048:	6798                	ld	a4,8(a5)
    8020804a:	fe843783          	ld	a5,-24(s0)
    8020804e:	6b9c                	ld	a5,16(a5)
    80208050:	02f707b3          	mul	a5,a4,a5
    80208054:	853e                	mv	a0,a5
    80208056:	879fd0ef          	jal	ra,802058ce <bd_malloc>
    8020805a:	872a                	mv	a4,a0
    8020805c:	fe843783          	ld	a5,-24(s0)
    80208060:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:14
}
    80208062:	0001                	nop
    80208064:	60e2                	ld	ra,24(sp)
    80208066:	6442                	ld	s0,16(sp)
    80208068:	6105                	addi	sp,sp,32
    8020806a:	8082                	ret

000000008020806c <vector_push>:
vector_push():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:16

void vector_push(struct vector *v, void *d) {
    8020806c:	7179                	addi	sp,sp,-48
    8020806e:	f406                	sd	ra,40(sp)
    80208070:	f022                	sd	s0,32(sp)
    80208072:	1800                	addi	s0,sp,48
    80208074:	fca43c23          	sd	a0,-40(s0)
    80208078:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:17
  if (v->size == v->capacity) {
    8020807c:	fd843783          	ld	a5,-40(s0)
    80208080:	6398                	ld	a4,0(a5)
    80208082:	fd843783          	ld	a5,-40(s0)
    80208086:	679c                	ld	a5,8(a5)
    80208088:	06f71763          	bne	a4,a5,802080f6 <vector_push+0x8a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:18
    v->capacity <<= 1;
    8020808c:	fd843783          	ld	a5,-40(s0)
    80208090:	679c                	ld	a5,8(a5)
    80208092:	00179713          	slli	a4,a5,0x1
    80208096:	fd843783          	ld	a5,-40(s0)
    8020809a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:19
    char *t = bd_malloc(v->capacity * v->dsize);
    8020809c:	fd843783          	ld	a5,-40(s0)
    802080a0:	6798                	ld	a4,8(a5)
    802080a2:	fd843783          	ld	a5,-40(s0)
    802080a6:	6b9c                	ld	a5,16(a5)
    802080a8:	02f707b3          	mul	a5,a4,a5
    802080ac:	853e                	mv	a0,a5
    802080ae:	821fd0ef          	jal	ra,802058ce <bd_malloc>
    802080b2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:20
    memcpy((uint8_t*)t, (uint8_t*)v->buffer, v->size * v->dsize);
    802080b6:	fd843783          	ld	a5,-40(s0)
    802080ba:	6f94                	ld	a3,24(a5)
    802080bc:	fd843783          	ld	a5,-40(s0)
    802080c0:	639c                	ld	a5,0(a5)
    802080c2:	0007871b          	sext.w	a4,a5
    802080c6:	fd843783          	ld	a5,-40(s0)
    802080ca:	6b9c                	ld	a5,16(a5)
    802080cc:	2781                	sext.w	a5,a5
    802080ce:	02f707bb          	mulw	a5,a4,a5
    802080d2:	2781                	sext.w	a5,a5
    802080d4:	863e                	mv	a2,a5
    802080d6:	85b6                	mv	a1,a3
    802080d8:	fe843503          	ld	a0,-24(s0)
    802080dc:	e66fb0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:21
    bd_free(v->buffer);
    802080e0:	fd843783          	ld	a5,-40(s0)
    802080e4:	6f9c                	ld	a5,24(a5)
    802080e6:	853e                	mv	a0,a5
    802080e8:	9e9fd0ef          	jal	ra,80205ad0 <bd_free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:22
    v->buffer = t;
    802080ec:	fd843783          	ld	a5,-40(s0)
    802080f0:	fe843703          	ld	a4,-24(s0)
    802080f4:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:24
  }
  memcpy((uint8_t*)(v->buffer + (v->size++) * v->dsize), d, v->dsize);
    802080f6:	fd843783          	ld	a5,-40(s0)
    802080fa:	6f98                	ld	a4,24(a5)
    802080fc:	fd843783          	ld	a5,-40(s0)
    80208100:	639c                	ld	a5,0(a5)
    80208102:	00178613          	addi	a2,a5,1
    80208106:	fd843683          	ld	a3,-40(s0)
    8020810a:	e290                	sd	a2,0(a3)
    8020810c:	fd843683          	ld	a3,-40(s0)
    80208110:	6a94                	ld	a3,16(a3)
    80208112:	02d787b3          	mul	a5,a5,a3
    80208116:	973e                	add	a4,a4,a5
    80208118:	fd843783          	ld	a5,-40(s0)
    8020811c:	6b9c                	ld	a5,16(a5)
    8020811e:	2781                	sext.w	a5,a5
    80208120:	863e                	mv	a2,a5
    80208122:	fd043583          	ld	a1,-48(s0)
    80208126:	853a                	mv	a0,a4
    80208128:	e1afb0ef          	jal	ra,80203742 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:25
}
    8020812c:	0001                	nop
    8020812e:	70a2                	ld	ra,40(sp)
    80208130:	7402                	ld	s0,32(sp)
    80208132:	6145                	addi	sp,sp,48
    80208134:	8082                	ret

0000000080208136 <vector_pop>:
vector_pop():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:28

void vector_pop(struct vector *v) 
{
    80208136:	1101                	addi	sp,sp,-32
    80208138:	ec06                	sd	ra,24(sp)
    8020813a:	e822                	sd	s0,16(sp)
    8020813c:	1000                	addi	s0,sp,32
    8020813e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:29
  if (v->size == 0)
    80208142:	fe843783          	ld	a5,-24(s0)
    80208146:	639c                	ld	a5,0(a5)
    80208148:	ef81                	bnez	a5,80208160 <vector_pop+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:30
    panic("empty vector pop\n");
    8020814a:	00002617          	auipc	a2,0x2
    8020814e:	82e60613          	addi	a2,a2,-2002 # 80209978 <MMIO+0x78>
    80208152:	45f9                	li	a1,30
    80208154:	00002517          	auipc	a0,0x2
    80208158:	83c50513          	addi	a0,a0,-1988 # 80209990 <MMIO+0x90>
    8020815c:	d3cfe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:31
  v->size--;
    80208160:	fe843783          	ld	a5,-24(s0)
    80208164:	639c                	ld	a5,0(a5)
    80208166:	fff78713          	addi	a4,a5,-1
    8020816a:	fe843783          	ld	a5,-24(s0)
    8020816e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:32
}
    80208170:	0001                	nop
    80208172:	60e2                	ld	ra,24(sp)
    80208174:	6442                	ld	s0,16(sp)
    80208176:	6105                	addi	sp,sp,32
    80208178:	8082                	ret

000000008020817a <vector_back>:
vector_back():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:34

void *vector_back(struct vector *v) {
    8020817a:	1101                	addi	sp,sp,-32
    8020817c:	ec06                	sd	ra,24(sp)
    8020817e:	e822                	sd	s0,16(sp)
    80208180:	1000                	addi	s0,sp,32
    80208182:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:35
  if (!v->size)
    80208186:	fe843783          	ld	a5,-24(s0)
    8020818a:	639c                	ld	a5,0(a5)
    8020818c:	ef89                	bnez	a5,802081a6 <vector_back+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:36
    panic("empty vector back\n");
    8020818e:	00002617          	auipc	a2,0x2
    80208192:	82260613          	addi	a2,a2,-2014 # 802099b0 <MMIO+0xb0>
    80208196:	02400593          	li	a1,36
    8020819a:	00001517          	auipc	a0,0x1
    8020819e:	7f650513          	addi	a0,a0,2038 # 80209990 <MMIO+0x90>
    802081a2:	cf6fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:37
  return v->buffer + (v->size - 1) * v->dsize;
    802081a6:	fe843783          	ld	a5,-24(s0)
    802081aa:	6f98                	ld	a4,24(a5)
    802081ac:	fe843783          	ld	a5,-24(s0)
    802081b0:	639c                	ld	a5,0(a5)
    802081b2:	fff78693          	addi	a3,a5,-1
    802081b6:	fe843783          	ld	a5,-24(s0)
    802081ba:	6b9c                	ld	a5,16(a5)
    802081bc:	02f687b3          	mul	a5,a3,a5
    802081c0:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38
}
    802081c2:	853e                	mv	a0,a5
    802081c4:	60e2                	ld	ra,24(sp)
    802081c6:	6442                	ld	s0,16(sp)
    802081c8:	6105                	addi	sp,sp,32
    802081ca:	8082                	ret

00000000802081cc <vector_empty>:
vector_empty():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:40

int vector_empty(struct vector *v) { return !v->size; }
    802081cc:	1101                	addi	sp,sp,-32
    802081ce:	ec22                	sd	s0,24(sp)
    802081d0:	1000                	addi	s0,sp,32
    802081d2:	fea43423          	sd	a0,-24(s0)
    802081d6:	fe843783          	ld	a5,-24(s0)
    802081da:	639c                	ld	a5,0(a5)
    802081dc:	0017b793          	seqz	a5,a5
    802081e0:	0ff7f793          	andi	a5,a5,255
    802081e4:	2781                	sext.w	a5,a5
    802081e6:	853e                	mv	a0,a5
    802081e8:	6462                	ld	s0,24(sp)
    802081ea:	6105                	addi	sp,sp,32
    802081ec:	8082                	ret

00000000802081ee <vector_free>:
vector_free():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:42

void vector_free(struct vector *v) { bd_free(v->buffer); }
    802081ee:	1101                	addi	sp,sp,-32
    802081f0:	ec06                	sd	ra,24(sp)
    802081f2:	e822                	sd	s0,16(sp)
    802081f4:	1000                	addi	s0,sp,32
    802081f6:	fea43423          	sd	a0,-24(s0)
    802081fa:	fe843783          	ld	a5,-24(s0)
    802081fe:	6f9c                	ld	a5,24(a5)
    80208200:	853e                	mv	a0,a5
    80208202:	8cffd0ef          	jal	ra,80205ad0 <bd_free>
    80208206:	0001                	nop
    80208208:	60e2                	ld	ra,24(sp)
    8020820a:	6442                	ld	s0,16(sp)
    8020820c:	6105                	addi	sp,sp,32
    8020820e:	8082                	ret

0000000080208210 <vector_remove>:
vector_remove():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:44

void vector_remove(struct vector *v, uint64_t idx) {
    80208210:	1101                	addi	sp,sp,-32
    80208212:	ec06                	sd	ra,24(sp)
    80208214:	e822                	sd	s0,16(sp)
    80208216:	1000                	addi	s0,sp,32
    80208218:	fea43423          	sd	a0,-24(s0)
    8020821c:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:45
  if (idx >= v->size)
    80208220:	fe843783          	ld	a5,-24(s0)
    80208224:	639c                	ld	a5,0(a5)
    80208226:	fe043703          	ld	a4,-32(s0)
    8020822a:	00f76e63          	bltu	a4,a5,80208246 <vector_remove+0x36>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:47
  {
    panic("invalid idx in vector remove\n");
    8020822e:	00001617          	auipc	a2,0x1
    80208232:	79a60613          	addi	a2,a2,1946 # 802099c8 <MMIO+0xc8>
    80208236:	02f00593          	li	a1,47
    8020823a:	00001517          	auipc	a0,0x1
    8020823e:	75650513          	addi	a0,a0,1878 # 80209990 <MMIO+0x90>
    80208242:	c56fe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:49
  }
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80208246:	fe843783          	ld	a5,-24(s0)
    8020824a:	6f98                	ld	a4,24(a5)
    8020824c:	fe843783          	ld	a5,-24(s0)
    80208250:	6b94                	ld	a3,16(a5)
    80208252:	fe043783          	ld	a5,-32(s0)
    80208256:	02f687b3          	mul	a5,a3,a5
    8020825a:	00f70533          	add	a0,a4,a5
    8020825e:	fe843783          	ld	a5,-24(s0)
    80208262:	6f98                	ld	a4,24(a5)
    80208264:	fe043783          	ld	a5,-32(s0)
    80208268:	00178693          	addi	a3,a5,1
    8020826c:	fe843783          	ld	a5,-24(s0)
    80208270:	6b9c                	ld	a5,16(a5)
    80208272:	02f687b3          	mul	a5,a3,a5
    80208276:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:50
          (v->size - idx - 1) * v->dsize);
    8020827a:	fe843783          	ld	a5,-24(s0)
    8020827e:	6398                	ld	a4,0(a5)
    80208280:	fe043783          	ld	a5,-32(s0)
    80208284:	40f707b3          	sub	a5,a4,a5
    80208288:	fff78713          	addi	a4,a5,-1
    8020828c:	fe843783          	ld	a5,-24(s0)
    80208290:	6b9c                	ld	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:49
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80208292:	02f707b3          	mul	a5,a4,a5
    80208296:	863e                	mv	a2,a5
    80208298:	85b6                	mv	a1,a3
    8020829a:	dc2fb0ef          	jal	ra,8020385c <memmove>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:51
  v->size--;
    8020829e:	fe843783          	ld	a5,-24(s0)
    802082a2:	639c                	ld	a5,0(a5)
    802082a4:	fff78713          	addi	a4,a5,-1
    802082a8:	fe843783          	ld	a5,-24(s0)
    802082ac:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:52
}
    802082ae:	0001                	nop
    802082b0:	60e2                	ld	ra,24(sp)
    802082b2:	6442                	ld	s0,16(sp)
    802082b4:	6105                	addi	sp,sp,32
    802082b6:	8082                	ret

00000000802082b8 <vector_get>:
vector_get():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:55


void *vector_get(struct vector *v, uint64_t index) {
    802082b8:	1101                	addi	sp,sp,-32
    802082ba:	ec22                	sd	s0,24(sp)
    802082bc:	1000                	addi	s0,sp,32
    802082be:	fea43423          	sd	a0,-24(s0)
    802082c2:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:56
    if (index >= v->size) {
    802082c6:	fe843783          	ld	a5,-24(s0)
    802082ca:	639c                	ld	a5,0(a5)
    802082cc:	fe043703          	ld	a4,-32(s0)
    802082d0:	00f76463          	bltu	a4,a5,802082d8 <vector_get+0x20>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:57
        return NULL;
    802082d4:	4781                	li	a5,0
    802082d6:	a821                	j	802082ee <vector_get+0x36>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:59
    }
    return (void *)(v->buffer + (index * v->dsize));
    802082d8:	fe843783          	ld	a5,-24(s0)
    802082dc:	6f98                	ld	a4,24(a5)
    802082de:	fe843783          	ld	a5,-24(s0)
    802082e2:	6b94                	ld	a3,16(a5)
    802082e4:	fe043783          	ld	a5,-32(s0)
    802082e8:	02f687b3          	mul	a5,a3,a5
    802082ec:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:60
}
    802082ee:	853e                	mv	a0,a5
    802082f0:	6462                	ld	s0,24(sp)
    802082f2:	6105                	addi	sp,sp,32
    802082f4:	8082                	ret

00000000802082f6 <vector_size>:
vector_size():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:63

uint64_t vector_size(struct vector *v)
{
    802082f6:	1101                	addi	sp,sp,-32
    802082f8:	ec22                	sd	s0,24(sp)
    802082fa:	1000                	addi	s0,sp,32
    802082fc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:64
    return v->size;
    80208300:	fe843783          	ld	a5,-24(s0)
    80208304:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:65
    80208306:	853e                	mv	a0,a5
    80208308:	6462                	ld	s0,24(sp)
    8020830a:	6105                	addi	sp,sp,32
    8020830c:	8082                	ret

000000008020830e <queue_init>:
queue_init():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:5
// queue.c
#include "queue.h"
#include "mem.h"
#include "kernel_heap.h"
void queue_init(Queue* q) {
    8020830e:	1101                	addi	sp,sp,-32
    80208310:	ec22                	sd	s0,24(sp)
    80208312:	1000                	addi	s0,sp,32
    80208314:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:6
    q->head = NULL;
    80208318:	fe843783          	ld	a5,-24(s0)
    8020831c:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:7
    q->tail = NULL;
    80208320:	fe843783          	ld	a5,-24(s0)
    80208324:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:8
    q->size = 0;
    80208328:	fe843783          	ld	a5,-24(s0)
    8020832c:	0007a823          	sw	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:9
}
    80208330:	0001                	nop
    80208332:	6462                	ld	s0,24(sp)
    80208334:	6105                	addi	sp,sp,32
    80208336:	8082                	ret

0000000080208338 <queue_enqueue>:
queue_enqueue():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:11

void queue_enqueue(Queue* q, void* data) {
    80208338:	7179                	addi	sp,sp,-48
    8020833a:	f406                	sd	ra,40(sp)
    8020833c:	f022                	sd	s0,32(sp)
    8020833e:	1800                	addi	s0,sp,48
    80208340:	fca43c23          	sd	a0,-40(s0)
    80208344:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:12
    Node* newNode = (Node*)bd_malloc(sizeof(Node));
    80208348:	4541                	li	a0,16
    8020834a:	d84fd0ef          	jal	ra,802058ce <bd_malloc>
    8020834e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:13
    if (newNode == NULL) {
    80208352:	fe843783          	ld	a5,-24(s0)
    80208356:	ef81                	bnez	a5,8020836e <queue_enqueue+0x36>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:14 (discriminator 1)
        ASSERT(0);
    80208358:	00001617          	auipc	a2,0x1
    8020835c:	6a060613          	addi	a2,a2,1696 # 802099f8 <MMIO+0x10>
    80208360:	45b9                	li	a1,14
    80208362:	00001517          	auipc	a0,0x1
    80208366:	6ae50513          	addi	a0,a0,1710 # 80209a10 <MMIO+0x28>
    8020836a:	b2efe0ef          	jal	ra,80206698 <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:16
    }
    newNode->data = data;
    8020836e:	fe843783          	ld	a5,-24(s0)
    80208372:	fd043703          	ld	a4,-48(s0)
    80208376:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:17
    newNode->next = NULL;
    80208378:	fe843783          	ld	a5,-24(s0)
    8020837c:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:19

    if (q->tail == NULL) { // Empty queue
    80208380:	fd843783          	ld	a5,-40(s0)
    80208384:	679c                	ld	a5,8(a5)
    80208386:	ef89                	bnez	a5,802083a0 <queue_enqueue+0x68>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:20
        q->head = q->tail = newNode;
    80208388:	fd843783          	ld	a5,-40(s0)
    8020838c:	fe843703          	ld	a4,-24(s0)
    80208390:	e798                	sd	a4,8(a5)
    80208392:	fd843783          	ld	a5,-40(s0)
    80208396:	6798                	ld	a4,8(a5)
    80208398:	fd843783          	ld	a5,-40(s0)
    8020839c:	e398                	sd	a4,0(a5)
    8020839e:	a821                	j	802083b6 <queue_enqueue+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:22
    } else {
        q->tail->next = newNode;
    802083a0:	fd843783          	ld	a5,-40(s0)
    802083a4:	679c                	ld	a5,8(a5)
    802083a6:	fe843703          	ld	a4,-24(s0)
    802083aa:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:23
        q->tail = newNode;
    802083ac:	fd843783          	ld	a5,-40(s0)
    802083b0:	fe843703          	ld	a4,-24(s0)
    802083b4:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:25
    }
    q->size++;
    802083b6:	fd843783          	ld	a5,-40(s0)
    802083ba:	4b9c                	lw	a5,16(a5)
    802083bc:	2785                	addiw	a5,a5,1
    802083be:	0007871b          	sext.w	a4,a5
    802083c2:	fd843783          	ld	a5,-40(s0)
    802083c6:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:26
}
    802083c8:	0001                	nop
    802083ca:	70a2                	ld	ra,40(sp)
    802083cc:	7402                	ld	s0,32(sp)
    802083ce:	6145                	addi	sp,sp,48
    802083d0:	8082                	ret

00000000802083d2 <queue_dequeue>:
queue_dequeue():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:28

void* queue_dequeue(Queue* q) {
    802083d2:	7179                	addi	sp,sp,-48
    802083d4:	f406                	sd	ra,40(sp)
    802083d6:	f022                	sd	s0,32(sp)
    802083d8:	1800                	addi	s0,sp,48
    802083da:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:29
    if (q->head == NULL) {
    802083de:	fd843783          	ld	a5,-40(s0)
    802083e2:	639c                	ld	a5,0(a5)
    802083e4:	e399                	bnez	a5,802083ea <queue_dequeue+0x18>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:30
        return NULL; // Empty queue
    802083e6:	4781                	li	a5,0
    802083e8:	a889                	j	8020843a <queue_dequeue+0x68>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:33
    }

    Node* temp = q->head;
    802083ea:	fd843783          	ld	a5,-40(s0)
    802083ee:	639c                	ld	a5,0(a5)
    802083f0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:34
    void* data = temp->data;
    802083f4:	fe843783          	ld	a5,-24(s0)
    802083f8:	639c                	ld	a5,0(a5)
    802083fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:35
    q->head = q->head->next;
    802083fe:	fd843783          	ld	a5,-40(s0)
    80208402:	639c                	ld	a5,0(a5)
    80208404:	6798                	ld	a4,8(a5)
    80208406:	fd843783          	ld	a5,-40(s0)
    8020840a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:37

    if (q->head == NULL) {
    8020840c:	fd843783          	ld	a5,-40(s0)
    80208410:	639c                	ld	a5,0(a5)
    80208412:	e789                	bnez	a5,8020841c <queue_dequeue+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:38
        q->tail = NULL; // Queue is now empty
    80208414:	fd843783          	ld	a5,-40(s0)
    80208418:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:41
    }

    free(temp);
    8020841c:	fe843503          	ld	a0,-24(s0)
    80208420:	df0fb0ef          	jal	ra,80203a10 <free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:42
    q->size--;
    80208424:	fd843783          	ld	a5,-40(s0)
    80208428:	4b9c                	lw	a5,16(a5)
    8020842a:	37fd                	addiw	a5,a5,-1
    8020842c:	0007871b          	sext.w	a4,a5
    80208430:	fd843783          	ld	a5,-40(s0)
    80208434:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:43
    return data;
    80208436:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:44
}
    8020843a:	853e                	mv	a0,a5
    8020843c:	70a2                	ld	ra,40(sp)
    8020843e:	7402                	ld	s0,32(sp)
    80208440:	6145                	addi	sp,sp,48
    80208442:	8082                	ret

0000000080208444 <queue_clear>:
queue_clear():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:46

void queue_clear(Queue* q) {
    80208444:	7179                	addi	sp,sp,-48
    80208446:	f406                	sd	ra,40(sp)
    80208448:	f022                	sd	s0,32(sp)
    8020844a:	1800                	addi	s0,sp,48
    8020844c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:47
    Node* current = q->head;
    80208450:	fd843783          	ld	a5,-40(s0)
    80208454:	639c                	ld	a5,0(a5)
    80208456:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:50
    Node* next;

    while (current != NULL) {
    8020845a:	a831                	j	80208476 <queue_clear+0x32>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:51
        next = current->next;
    8020845c:	fe843783          	ld	a5,-24(s0)
    80208460:	679c                	ld	a5,8(a5)
    80208462:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:52
        free(current);
    80208466:	fe843503          	ld	a0,-24(s0)
    8020846a:	da6fb0ef          	jal	ra,80203a10 <free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:53
        current = next;
    8020846e:	fe043783          	ld	a5,-32(s0)
    80208472:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:50
    while (current != NULL) {
    80208476:	fe843783          	ld	a5,-24(s0)
    8020847a:	f3ed                	bnez	a5,8020845c <queue_clear+0x18>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:56
    }

    q->head = NULL;
    8020847c:	fd843783          	ld	a5,-40(s0)
    80208480:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:57
    q->tail = NULL;
    80208484:	fd843783          	ld	a5,-40(s0)
    80208488:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:58
    q->size = 0;
    8020848c:	fd843783          	ld	a5,-40(s0)
    80208490:	0007a823          	sw	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:59
}
    80208494:	0001                	nop
    80208496:	70a2                	ld	ra,40(sp)
    80208498:	7402                	ld	s0,32(sp)
    8020849a:	6145                	addi	sp,sp,48
    8020849c:	8082                	ret

000000008020849e <queue_is_empty>:
queue_is_empty():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:61

int queue_is_empty(const Queue* q) {
    8020849e:	1101                	addi	sp,sp,-32
    802084a0:	ec22                	sd	s0,24(sp)
    802084a2:	1000                	addi	s0,sp,32
    802084a4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:62
    return q->size == 0;
    802084a8:	fe843783          	ld	a5,-24(s0)
    802084ac:	4b9c                	lw	a5,16(a5)
    802084ae:	0017b793          	seqz	a5,a5
    802084b2:	0ff7f793          	andi	a5,a5,255
    802084b6:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/data_structure/queue.c:63
}
    802084b8:	853e                	mv	a0,a5
    802084ba:	6462                	ld	s0,24(sp)
    802084bc:	6105                	addi	sp,sp,32
    802084be:	8082                	ret
	...

00000000802084c2 <__switch>:
__switch():
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:16
  # __switch(
  #     current_task_cx_ptr2: &*const TaskContext,
  #     next_task_cx_ptr2: &*const TaskContext
  # )
  # push TaskContext to current sp and save its address to where a0 points to
  addi sp, sp, -13*8
    802084c2:	f9810113          	addi	sp,sp,-104
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:17
  sd sp, 0(a0)
    802084c6:	00253023          	sd	sp,0(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:19
  # fill TaskContext with ra & s0-s11
  sd ra, 0(sp)
    802084ca:	e006                	sd	ra,0(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:24
  .set n, 0
  .rept 12
    SAVE_SN %n
    .set n, n + 1
  .endr
    802084cc:	e422                	sd	s0,8(sp)
    802084ce:	e826                	sd	s1,16(sp)
    802084d0:	ec4a                	sd	s2,24(sp)
    802084d2:	f04e                	sd	s3,32(sp)
    802084d4:	f452                	sd	s4,40(sp)
    802084d6:	f856                	sd	s5,48(sp)
    802084d8:	fc5a                	sd	s6,56(sp)
    802084da:	e0de                	sd	s7,64(sp)
    802084dc:	e4e2                	sd	s8,72(sp)
    802084de:	e8e6                	sd	s9,80(sp)
    802084e0:	ecea                	sd	s10,88(sp)
    802084e2:	f0ee                	sd	s11,96(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:26
  # ready for loading TaskContext a1 points to
  ld sp, 0(a1)
    802084e4:	0005b103          	ld	sp,0(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:28
  # load registers in the TaskContext
  ld ra, 0(sp)
    802084e8:	6082                	ld	ra,0(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:33
  .set n, 0
  .rept 12
    LOAD_SN %n
    .set n, n + 1
  .endr
    802084ea:	6422                	ld	s0,8(sp)
    802084ec:	64c2                	ld	s1,16(sp)
    802084ee:	6962                	ld	s2,24(sp)
    802084f0:	7982                	ld	s3,32(sp)
    802084f2:	7a22                	ld	s4,40(sp)
    802084f4:	7ac2                	ld	s5,48(sp)
    802084f6:	7b62                	ld	s6,56(sp)
    802084f8:	6b86                	ld	s7,64(sp)
    802084fa:	6c26                	ld	s8,72(sp)
    802084fc:	6cc6                	ld	s9,80(sp)
    802084fe:	6d66                	ld	s10,88(sp)
    80208500:	7d86                	ld	s11,96(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:35
  # pop TaskContext
  addi sp, sp, 13*8
    80208502:	06810113          	addi	sp,sp,104
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:36
  ret
    80208506:	8082                	ret
