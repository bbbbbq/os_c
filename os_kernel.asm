
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
stext():
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:4
    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    80200000:	00025117          	auipc	sp,0x25
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
    80202020:	2de010ef          	jal	ra,802032fe <console_putchar>
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
    8020252c:	00006797          	auipc	a5,0x6
    80202530:	ad478793          	addi	a5,a5,-1324 # 80208000 <etext>
    80202534:	97ba                	add	a5,a5,a4
    80202536:	439c                	lw	a5,0(a5)
    80202538:	0007871b          	sext.w	a4,a5
    8020253c:	00006797          	auipc	a5,0x6
    80202540:	ac478793          	addi	a5,a5,-1340 # 80208000 <etext>
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
/home/caigoubencai/Desktop/os_c/kernel/main.c:13
#include "buddy.h"
#include "mem.h"

extern uint8_t sbss, ebss;

void clear_bss() {
    80202920:	1101                	addi	sp,sp,-32
    80202922:	ec22                	sd	s0,24(sp)
    80202924:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/main.c:14
  for (uint8_t *i = &sbss; i < &ebss; i++) {
    80202926:	00022797          	auipc	a5,0x22
    8020292a:	6da78793          	addi	a5,a5,1754 # 80225000 <ticks>
    8020292e:	fef43423          	sd	a5,-24(s0)
    80202932:	a811                	j	80202946 <clear_bss+0x26>
/home/caigoubencai/Desktop/os_c/kernel/main.c:15 (discriminator 3)
    *i = 0;
    80202934:	fe843783          	ld	a5,-24(s0)
    80202938:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/main.c:14 (discriminator 3)
  for (uint8_t *i = &sbss; i < &ebss; i++) {
    8020293c:	fe843783          	ld	a5,-24(s0)
    80202940:	0785                	addi	a5,a5,1
    80202942:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/main.c:14 (discriminator 1)
    80202946:	fe843703          	ld	a4,-24(s0)
    8020294a:	00b74797          	auipc	a5,0xb74
    8020294e:	6b678793          	addi	a5,a5,1718 # 80d77000 <ebss>
    80202952:	fef761e3          	bltu	a4,a5,80202934 <clear_bss+0x14>
/home/caigoubencai/Desktop/os_c/kernel/main.c:17
  }
}
    80202956:	0001                	nop
    80202958:	0001                	nop
    8020295a:	6462                	ld	s0,24(sp)
    8020295c:	6105                	addi	sp,sp,32
    8020295e:	8082                	ret

0000000080202960 <main_os>:
main_os():
/home/caigoubencai/Desktop/os_c/kernel/main.c:19
int main_os()
{
    80202960:	1141                	addi	sp,sp,-16
    80202962:	e406                	sd	ra,8(sp)
    80202964:	e022                	sd	s0,0(sp)
    80202966:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/main.c:20
    mm_init();
    80202968:	333020ef          	jal	ra,8020549a <mm_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:21
    printk("123%d\n",123);
    8020296c:	07b00593          	li	a1,123
    80202970:	00005517          	auipc	a0,0x5
    80202974:	72850513          	addi	a0,a0,1832 # 80208098 <MMIO+0x10>
    80202978:	e73ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/main.c:22
    init_interrupt();
    8020297c:	18d040ef          	jal	ra,80207308 <init_interrupt>
/home/caigoubencai/Desktop/os_c/kernel/main.c:23
    init_trap();
    80202980:	3a3040ef          	jal	ra,80207522 <init_trap>
/home/caigoubencai/Desktop/os_c/kernel/main.c:24
    timer_init(); 
    80202984:	12e050ef          	jal	ra,80207ab2 <timer_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:25
    task_manager_init();
    80202988:	561030ef          	jal	ra,802066e8 <task_manager_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:28
    //asm("ebreak");
    // while(1){}
    run_first_app();
    8020298c:	298040ef          	jal	ra,80206c24 <run_first_app>
/home/caigoubencai/Desktop/os_c/kernel/main.c:29
    ASSERT(0);
    80202990:	00005617          	auipc	a2,0x5
    80202994:	71060613          	addi	a2,a2,1808 # 802080a0 <MMIO+0x18>
    80202998:	45f5                	li	a1,29
    8020299a:	00005517          	auipc	a0,0x5
    8020299e:	71e50513          	addi	a0,a0,1822 # 802080b8 <MMIO+0x30>
    802029a2:	509030ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/main.c:30
    802029a6:	0001                	nop
    802029a8:	853e                	mv	a0,a5
    802029aa:	60a2                	ld	ra,8(sp)
    802029ac:	6402                	ld	s0,0(sp)
    802029ae:	0141                	addi	sp,sp,16
    802029b0:	8082                	ret

00000000802029b2 <elf_load_sections_loop>:
elf_load_sections_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:18

/*
** traverse the section header table and load each section
*/
static int elf_load_sections_loop(t_elf *elf, size_t shoff, size_t shnum,
                                  size_t shentsize) {
    802029b2:	715d                	addi	sp,sp,-80
    802029b4:	e486                	sd	ra,72(sp)
    802029b6:	e0a2                	sd	s0,64(sp)
    802029b8:	0880                	addi	s0,sp,80
    802029ba:	fca43423          	sd	a0,-56(s0)
    802029be:	fcb43023          	sd	a1,-64(s0)
    802029c2:	fac43c23          	sd	a2,-72(s0)
    802029c6:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:23
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    802029ca:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    802029ce:	a0dd                	j	80202ab4 <elf_load_sections_loop+0x102>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:25
    if (i >= MAX_SECTION_NUM) {
    802029d0:	fe843703          	ld	a4,-24(s0)
    802029d4:	03f00793          	li	a5,63
    802029d8:	00e7f463          	bgeu	a5,a4,802029e0 <elf_load_sections_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:26
      return (-1);
    802029dc:	57fd                	li	a5,-1
    802029de:	a0d5                	j	80202ac2 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:29
    }
    elf->sections[i].header =
        (union u_elf_sh *)(elf->raw_data + shoff + i * shentsize);
    802029e0:	fc843783          	ld	a5,-56(s0)
    802029e4:	6798                	ld	a4,8(a5)
    802029e6:	fe843683          	ld	a3,-24(s0)
    802029ea:	fb043783          	ld	a5,-80(s0)
    802029ee:	02f686b3          	mul	a3,a3,a5
    802029f2:	fc043783          	ld	a5,-64(s0)
    802029f6:	97b6                	add	a5,a5,a3
    802029f8:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:28
    elf->sections[i].header =
    802029fa:	fc843683          	ld	a3,-56(s0)
    802029fe:	fe843783          	ld	a5,-24(s0)
    80202a02:	0789                	addi	a5,a5,2
    80202a04:	0792                	slli	a5,a5,0x4
    80202a06:	97b6                	add	a5,a5,a3
    80202a08:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:30
    type = elf_section_get_type(elf, &elf->sections[i]);
    80202a0a:	fe843783          	ld	a5,-24(s0)
    80202a0e:	0789                	addi	a5,a5,2
    80202a10:	0792                	slli	a5,a5,0x4
    80202a12:	fc843703          	ld	a4,-56(s0)
    80202a16:	97ba                	add	a5,a5,a4
    80202a18:	07a1                	addi	a5,a5,8
    80202a1a:	85be                	mv	a1,a5
    80202a1c:	fc843503          	ld	a0,-56(s0)
    80202a20:	58e000ef          	jal	ra,80202fae <elf_section_get_type>
    80202a24:	87aa                	mv	a5,a0
    80202a26:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31
    if (type != SHT_NULL && type != SHT_NOBITS) {
    80202a2a:	fe442783          	lw	a5,-28(s0)
    80202a2e:	2781                	sext.w	a5,a5
    80202a30:	cfad                	beqz	a5,80202aaa <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31 (discriminator 1)
    80202a32:	fe442783          	lw	a5,-28(s0)
    80202a36:	0007871b          	sext.w	a4,a5
    80202a3a:	47a1                	li	a5,8
    80202a3c:	06f70763          	beq	a4,a5,80202aaa <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:32
      content_offset = elf_section_get_offset(elf, &elf->sections[i]);
    80202a40:	fe843783          	ld	a5,-24(s0)
    80202a44:	0789                	addi	a5,a5,2
    80202a46:	0792                	slli	a5,a5,0x4
    80202a48:	fc843703          	ld	a4,-56(s0)
    80202a4c:	97ba                	add	a5,a5,a4
    80202a4e:	07a1                	addi	a5,a5,8
    80202a50:	85be                	mv	a1,a5
    80202a52:	fc843503          	ld	a0,-56(s0)
    80202a56:	59c000ef          	jal	ra,80202ff2 <elf_section_get_offset>
    80202a5a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80202a5e:	fe843783          	ld	a5,-24(s0)
    80202a62:	0789                	addi	a5,a5,2
    80202a64:	0792                	slli	a5,a5,0x4
    80202a66:	fc843703          	ld	a4,-56(s0)
    80202a6a:	97ba                	add	a5,a5,a4
    80202a6c:	07a1                	addi	a5,a5,8
    80202a6e:	85be                	mv	a1,a5
    80202a70:	fc843503          	ld	a0,-56(s0)
    80202a74:	5c6000ef          	jal	ra,8020303a <elf_section_get_size>
    80202a78:	872a                	mv	a4,a0
    80202a7a:	fd843783          	ld	a5,-40(s0)
    80202a7e:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:34
          elf->size) {
    80202a80:	fc843783          	ld	a5,-56(s0)
    80202a84:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80202a86:	00e7f463          	bgeu	a5,a4,80202a8e <elf_load_sections_loop+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:35
        return (-1);
    80202a8a:	57fd                	li	a5,-1
    80202a8c:	a81d                	j	80202ac2 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:37
      }
      elf->sections[i].content = elf->raw_data + content_offset;
    80202a8e:	fc843783          	ld	a5,-56(s0)
    80202a92:	6798                	ld	a4,8(a5)
    80202a94:	fd843783          	ld	a5,-40(s0)
    80202a98:	973e                	add	a4,a4,a5
    80202a9a:	fc843683          	ld	a3,-56(s0)
    80202a9e:	fe843783          	ld	a5,-24(s0)
    80202aa2:	0789                	addi	a5,a5,2
    80202aa4:	0792                	slli	a5,a5,0x4
    80202aa6:	97b6                	add	a5,a5,a3
    80202aa8:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:39
    }
    i++;
    80202aaa:	fe843783          	ld	a5,-24(s0)
    80202aae:	0785                	addi	a5,a5,1
    80202ab0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    80202ab4:	fe843703          	ld	a4,-24(s0)
    80202ab8:	fb843783          	ld	a5,-72(s0)
    80202abc:	f0f76ae3          	bltu	a4,a5,802029d0 <elf_load_sections_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:41
  }
  return (0);
    80202ac0:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:42
}
    80202ac2:	853e                	mv	a0,a5
    80202ac4:	60a6                	ld	ra,72(sp)
    80202ac6:	6406                	ld	s0,64(sp)
    80202ac8:	6161                	addi	sp,sp,80
    80202aca:	8082                	ret

0000000080202acc <elf_load_sections>:
elf_load_sections():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:48

/*
** Load sections. Create a table of t_elf_section in elf->sections.
** This table is null if there is no section header table.
*/
int elf_load_sections(t_elf *elf) {
    80202acc:	7139                	addi	sp,sp,-64
    80202ace:	fc06                	sd	ra,56(sp)
    80202ad0:	f822                	sd	s0,48(sp)
    80202ad2:	0080                	addi	s0,sp,64
    80202ad4:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:53
  size_t shoff;
  size_t shnum;
  size_t shentsize;

  if ((shoff = elf_header_get_shoff(elf)) > 0) {
    80202ad8:	fc843503          	ld	a0,-56(s0)
    80202adc:	0cc000ef          	jal	ra,80202ba8 <elf_header_get_shoff>
    80202ae0:	fea43423          	sd	a0,-24(s0)
    80202ae4:	fe843783          	ld	a5,-24(s0)
    80202ae8:	cfb1                	beqz	a5,80202b44 <elf_load_sections+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:54
    shnum = elf_header_get_shnum(elf);
    80202aea:	fc843503          	ld	a0,-56(s0)
    80202aee:	142000ef          	jal	ra,80202c30 <elf_header_get_shnum>
    80202af2:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:55
    shentsize = elf_header_get_shentsize(elf);
    80202af6:	fc843503          	ld	a0,-56(s0)
    80202afa:	0f2000ef          	jal	ra,80202bec <elf_header_get_shentsize>
    80202afe:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:56
    if (shoff + shnum * shentsize > elf->size) {
    80202b02:	fe043703          	ld	a4,-32(s0)
    80202b06:	fd843783          	ld	a5,-40(s0)
    80202b0a:	02f70733          	mul	a4,a4,a5
    80202b0e:	fe843783          	ld	a5,-24(s0)
    80202b12:	973e                	add	a4,a4,a5
    80202b14:	fc843783          	ld	a5,-56(s0)
    80202b18:	639c                	ld	a5,0(a5)
    80202b1a:	00e7f463          	bgeu	a5,a4,80202b22 <elf_load_sections+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:57
      return (-1);
    80202b1e:	57fd                	li	a5,-1
    80202b20:	a82d                	j	80202b5a <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:59
    }
    if (elf_load_sections_loop(elf, shoff, shnum, shentsize) == -1) {
    80202b22:	fd843683          	ld	a3,-40(s0)
    80202b26:	fe043603          	ld	a2,-32(s0)
    80202b2a:	fe843583          	ld	a1,-24(s0)
    80202b2e:	fc843503          	ld	a0,-56(s0)
    80202b32:	e81ff0ef          	jal	ra,802029b2 <elf_load_sections_loop>
    80202b36:	87aa                	mv	a5,a0
    80202b38:	873e                	mv	a4,a5
    80202b3a:	57fd                	li	a5,-1
    80202b3c:	00f71e63          	bne	a4,a5,80202b58 <elf_load_sections+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:60
      return (-1);
    80202b40:	57fd                	li	a5,-1
    80202b42:	a821                	j	80202b5a <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:63
    }
  } else
    memset(elf->sections, 0, MAX_SECTION_NUM * sizeof(t_elf_section));
    80202b44:	fc843783          	ld	a5,-56(s0)
    80202b48:	02878793          	addi	a5,a5,40
    80202b4c:	40000613          	li	a2,1024
    80202b50:	4581                	li	a1,0
    80202b52:	853e                	mv	a0,a5
    80202b54:	44f000ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:64
  return (0);
    80202b58:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:65
}
    80202b5a:	853e                	mv	a0,a5
    80202b5c:	70e2                	ld	ra,56(sp)
    80202b5e:	7442                	ld	s0,48(sp)
    80202b60:	6121                	addi	sp,sp,64
    80202b62:	8082                	ret

0000000080202b64 <elf_header_get_entry>:
elf_header_get_entry():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:14
** Last update Mon Mar 10 20:51:03 2014 Barthelemy Delemotte
*/

#include "elfparse.h"

size_t elf_header_get_entry(t_elf *elf) {
    80202b64:	7179                	addi	sp,sp,-48
    80202b66:	f422                	sd	s0,40(sp)
    80202b68:	1800                	addi	s0,sp,48
    80202b6a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:17
  size_t entry;

  if (ELF_IS_32(elf))
    80202b6e:	fd843783          	ld	a5,-40(s0)
    80202b72:	0187c783          	lbu	a5,24(a5)
    80202b76:	873e                	mv	a4,a5
    80202b78:	4785                	li	a5,1
    80202b7a:	00f71b63          	bne	a4,a5,80202b90 <elf_header_get_entry+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:18
    entry = (size_t)elf->header->_32.e_entry;
    80202b7e:	fd843783          	ld	a5,-40(s0)
    80202b82:	739c                	ld	a5,32(a5)
    80202b84:	4f9c                	lw	a5,24(a5)
    80202b86:	1782                	slli	a5,a5,0x20
    80202b88:	9381                	srli	a5,a5,0x20
    80202b8a:	fef43423          	sd	a5,-24(s0)
    80202b8e:	a039                	j	80202b9c <elf_header_get_entry+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:20
  else
    entry = (size_t)elf->header->_64.e_entry;
    80202b90:	fd843783          	ld	a5,-40(s0)
    80202b94:	739c                	ld	a5,32(a5)
    80202b96:	6f9c                	ld	a5,24(a5)
    80202b98:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:21
  return (entry);
    80202b9c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:22
}
    80202ba0:	853e                	mv	a0,a5
    80202ba2:	7422                	ld	s0,40(sp)
    80202ba4:	6145                	addi	sp,sp,48
    80202ba6:	8082                	ret

0000000080202ba8 <elf_header_get_shoff>:
elf_header_get_shoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:17
#include "elfparse.h"

/*
** Get the section header table offset
*/
size_t elf_header_get_shoff(t_elf *elf) {
    80202ba8:	7179                	addi	sp,sp,-48
    80202baa:	f422                	sd	s0,40(sp)
    80202bac:	1800                	addi	s0,sp,48
    80202bae:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:20
  size_t shoff;

  if (ELF_IS_32(elf))
    80202bb2:	fd843783          	ld	a5,-40(s0)
    80202bb6:	0187c783          	lbu	a5,24(a5)
    80202bba:	873e                	mv	a4,a5
    80202bbc:	4785                	li	a5,1
    80202bbe:	00f71b63          	bne	a4,a5,80202bd4 <elf_header_get_shoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:21
    shoff = (size_t)elf->header->_32.e_shoff;
    80202bc2:	fd843783          	ld	a5,-40(s0)
    80202bc6:	739c                	ld	a5,32(a5)
    80202bc8:	539c                	lw	a5,32(a5)
    80202bca:	1782                	slli	a5,a5,0x20
    80202bcc:	9381                	srli	a5,a5,0x20
    80202bce:	fef43423          	sd	a5,-24(s0)
    80202bd2:	a039                	j	80202be0 <elf_header_get_shoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:23
  else
    shoff = (size_t)elf->header->_64.e_shoff;
    80202bd4:	fd843783          	ld	a5,-40(s0)
    80202bd8:	739c                	ld	a5,32(a5)
    80202bda:	779c                	ld	a5,40(a5)
    80202bdc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:24
  return (shoff);
    80202be0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:25
}
    80202be4:	853e                	mv	a0,a5
    80202be6:	7422                	ld	s0,40(sp)
    80202be8:	6145                	addi	sp,sp,48
    80202bea:	8082                	ret

0000000080202bec <elf_header_get_shentsize>:
elf_header_get_shentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:30

/*
** Get the size of one section header
*/
size_t elf_header_get_shentsize(t_elf *elf) {
    80202bec:	7179                	addi	sp,sp,-48
    80202bee:	f422                	sd	s0,40(sp)
    80202bf0:	1800                	addi	s0,sp,48
    80202bf2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:33
  size_t shentsize;

  if (ELF_IS_32(elf))
    80202bf6:	fd843783          	ld	a5,-40(s0)
    80202bfa:	0187c783          	lbu	a5,24(a5)
    80202bfe:	873e                	mv	a4,a5
    80202c00:	4785                	li	a5,1
    80202c02:	00f71a63          	bne	a4,a5,80202c16 <elf_header_get_shentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:34
    shentsize = (size_t)elf->header->_32.e_shentsize;
    80202c06:	fd843783          	ld	a5,-40(s0)
    80202c0a:	739c                	ld	a5,32(a5)
    80202c0c:	02e7d783          	lhu	a5,46(a5)
    80202c10:	fef43423          	sd	a5,-24(s0)
    80202c14:	a801                	j	80202c24 <elf_header_get_shentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:36
  else
    shentsize = (size_t)elf->header->_64.e_shentsize;
    80202c16:	fd843783          	ld	a5,-40(s0)
    80202c1a:	739c                	ld	a5,32(a5)
    80202c1c:	03a7d783          	lhu	a5,58(a5)
    80202c20:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:37
  return (shentsize);
    80202c24:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:38
}
    80202c28:	853e                	mv	a0,a5
    80202c2a:	7422                	ld	s0,40(sp)
    80202c2c:	6145                	addi	sp,sp,48
    80202c2e:	8082                	ret

0000000080202c30 <elf_header_get_shnum>:
elf_header_get_shnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:43

/*
** Get the number of entry in the section header table
*/
size_t elf_header_get_shnum(t_elf *elf) {
    80202c30:	7179                	addi	sp,sp,-48
    80202c32:	f422                	sd	s0,40(sp)
    80202c34:	1800                	addi	s0,sp,48
    80202c36:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:46
  size_t shum;

  if (ELF_IS_32(elf))
    80202c3a:	fd843783          	ld	a5,-40(s0)
    80202c3e:	0187c783          	lbu	a5,24(a5)
    80202c42:	873e                	mv	a4,a5
    80202c44:	4785                	li	a5,1
    80202c46:	00f71a63          	bne	a4,a5,80202c5a <elf_header_get_shnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:47
    shum = (size_t)elf->header->_32.e_shnum;
    80202c4a:	fd843783          	ld	a5,-40(s0)
    80202c4e:	739c                	ld	a5,32(a5)
    80202c50:	0307d783          	lhu	a5,48(a5)
    80202c54:	fef43423          	sd	a5,-24(s0)
    80202c58:	a801                	j	80202c68 <elf_header_get_shnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:49
  else
    shum = (size_t)elf->header->_64.e_shnum;
    80202c5a:	fd843783          	ld	a5,-40(s0)
    80202c5e:	739c                	ld	a5,32(a5)
    80202c60:	03c7d783          	lhu	a5,60(a5)
    80202c64:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:50
  return (shum);
    80202c68:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:51
}
    80202c6c:	853e                	mv	a0,a5
    80202c6e:	7422                	ld	s0,40(sp)
    80202c70:	6145                	addi	sp,sp,48
    80202c72:	8082                	ret

0000000080202c74 <elf_program_get_type>:
elf_program_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:8
#include "elfparse.h"

/*
** Get the program type.
*/
uint32_t elf_program_get_type(t_elf *elf, t_elf_program *program) {
    80202c74:	7179                	addi	sp,sp,-48
    80202c76:	f422                	sd	s0,40(sp)
    80202c78:	1800                	addi	s0,sp,48
    80202c7a:	fca43c23          	sd	a0,-40(s0)
    80202c7e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:11
  uint32_t type;

  if (ELF_IS_32(elf))
    80202c82:	fd843783          	ld	a5,-40(s0)
    80202c86:	0187c783          	lbu	a5,24(a5)
    80202c8a:	873e                	mv	a4,a5
    80202c8c:	4785                	li	a5,1
    80202c8e:	00f71963          	bne	a4,a5,80202ca0 <elf_program_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:12
    type = (uint32_t)program->header->_32.p_type;
    80202c92:	fd043783          	ld	a5,-48(s0)
    80202c96:	639c                	ld	a5,0(a5)
    80202c98:	439c                	lw	a5,0(a5)
    80202c9a:	fef42623          	sw	a5,-20(s0)
    80202c9e:	a039                	j	80202cac <elf_program_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:14
  else
    type = (uint32_t)program->header->_64.p_type;
    80202ca0:	fd043783          	ld	a5,-48(s0)
    80202ca4:	639c                	ld	a5,0(a5)
    80202ca6:	439c                	lw	a5,0(a5)
    80202ca8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:15
  return (type);
    80202cac:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:16
}
    80202cb0:	853e                	mv	a0,a5
    80202cb2:	7422                	ld	s0,40(sp)
    80202cb4:	6145                	addi	sp,sp,48
    80202cb6:	8082                	ret

0000000080202cb8 <elf_program_get_offset>:
elf_program_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:21

/*
** Get the program offset (from the begin of the file)
*/
size_t elf_program_get_offset(t_elf *elf, t_elf_program *program) {
    80202cb8:	7179                	addi	sp,sp,-48
    80202cba:	f422                	sd	s0,40(sp)
    80202cbc:	1800                	addi	s0,sp,48
    80202cbe:	fca43c23          	sd	a0,-40(s0)
    80202cc2:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:24
  size_t offset;

  if (ELF_IS_32(elf))
    80202cc6:	fd843783          	ld	a5,-40(s0)
    80202cca:	0187c783          	lbu	a5,24(a5)
    80202cce:	873e                	mv	a4,a5
    80202cd0:	4785                	li	a5,1
    80202cd2:	00f71b63          	bne	a4,a5,80202ce8 <elf_program_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:25
    offset = (size_t)program->header->_32.p_offset;
    80202cd6:	fd043783          	ld	a5,-48(s0)
    80202cda:	639c                	ld	a5,0(a5)
    80202cdc:	43dc                	lw	a5,4(a5)
    80202cde:	1782                	slli	a5,a5,0x20
    80202ce0:	9381                	srli	a5,a5,0x20
    80202ce2:	fef43423          	sd	a5,-24(s0)
    80202ce6:	a039                	j	80202cf4 <elf_program_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:27
  else
    offset = (size_t)program->header->_64.p_offset;
    80202ce8:	fd043783          	ld	a5,-48(s0)
    80202cec:	639c                	ld	a5,0(a5)
    80202cee:	679c                	ld	a5,8(a5)
    80202cf0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:28
  return (offset);
    80202cf4:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:29
}
    80202cf8:	853e                	mv	a0,a5
    80202cfa:	7422                	ld	s0,40(sp)
    80202cfc:	6145                	addi	sp,sp,48
    80202cfe:	8082                	ret

0000000080202d00 <elf_program_get_flags>:
elf_program_get_flags():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:34

/*
** Get the flags of the program
*/
uint64_t elf_program_get_flags(t_elf *elf, t_elf_program *program) {
    80202d00:	7179                	addi	sp,sp,-48
    80202d02:	f422                	sd	s0,40(sp)
    80202d04:	1800                	addi	s0,sp,48
    80202d06:	fca43c23          	sd	a0,-40(s0)
    80202d0a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:37
  uint64_t flags;

  if (ELF_IS_32(elf))
    80202d0e:	fd843783          	ld	a5,-40(s0)
    80202d12:	0187c783          	lbu	a5,24(a5)
    80202d16:	873e                	mv	a4,a5
    80202d18:	4785                	li	a5,1
    80202d1a:	00f71b63          	bne	a4,a5,80202d30 <elf_program_get_flags+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:38
    flags = (uint64_t)program->header->_32.p_flags;
    80202d1e:	fd043783          	ld	a5,-48(s0)
    80202d22:	639c                	ld	a5,0(a5)
    80202d24:	4f9c                	lw	a5,24(a5)
    80202d26:	1782                	slli	a5,a5,0x20
    80202d28:	9381                	srli	a5,a5,0x20
    80202d2a:	fef43423          	sd	a5,-24(s0)
    80202d2e:	a809                	j	80202d40 <elf_program_get_flags+0x40>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:40
  else
    flags = (uint64_t)program->header->_64.p_flags;
    80202d30:	fd043783          	ld	a5,-48(s0)
    80202d34:	639c                	ld	a5,0(a5)
    80202d36:	43dc                	lw	a5,4(a5)
    80202d38:	1782                	slli	a5,a5,0x20
    80202d3a:	9381                	srli	a5,a5,0x20
    80202d3c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:41
  return (flags);
    80202d40:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:42
}
    80202d44:	853e                	mv	a0,a5
    80202d46:	7422                	ld	s0,40(sp)
    80202d48:	6145                	addi	sp,sp,48
    80202d4a:	8082                	ret

0000000080202d4c <elf_program_get_vaddr>:
elf_program_get_vaddr():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:47

/*
** Get the virtual address of the program
*/
uint64_t elf_program_get_vaddr(t_elf *elf, t_elf_program *program) {
    80202d4c:	7179                	addi	sp,sp,-48
    80202d4e:	f422                	sd	s0,40(sp)
    80202d50:	1800                	addi	s0,sp,48
    80202d52:	fca43c23          	sd	a0,-40(s0)
    80202d56:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:50
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202d5a:	fd843783          	ld	a5,-40(s0)
    80202d5e:	0187c783          	lbu	a5,24(a5)
    80202d62:	873e                	mv	a4,a5
    80202d64:	4785                	li	a5,1
    80202d66:	00f71b63          	bne	a4,a5,80202d7c <elf_program_get_vaddr+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:51
    addr = (uint64_t)program->header->_32.p_vaddr;
    80202d6a:	fd043783          	ld	a5,-48(s0)
    80202d6e:	639c                	ld	a5,0(a5)
    80202d70:	479c                	lw	a5,8(a5)
    80202d72:	1782                	slli	a5,a5,0x20
    80202d74:	9381                	srli	a5,a5,0x20
    80202d76:	fef43423          	sd	a5,-24(s0)
    80202d7a:	a039                	j	80202d88 <elf_program_get_vaddr+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:53
  else
    addr = (uint64_t)program->header->_64.p_vaddr;
    80202d7c:	fd043783          	ld	a5,-48(s0)
    80202d80:	639c                	ld	a5,0(a5)
    80202d82:	6b9c                	ld	a5,16(a5)
    80202d84:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:54
  return (addr);
    80202d88:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:55
}
    80202d8c:	853e                	mv	a0,a5
    80202d8e:	7422                	ld	s0,40(sp)
    80202d90:	6145                	addi	sp,sp,48
    80202d92:	8082                	ret

0000000080202d94 <elf_program_get_memsz>:
elf_program_get_memsz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:60

/*
** Get the memory size of the program
*/
uint64_t elf_program_get_memsz(t_elf *elf, t_elf_program *program) {
    80202d94:	7179                	addi	sp,sp,-48
    80202d96:	f422                	sd	s0,40(sp)
    80202d98:	1800                	addi	s0,sp,48
    80202d9a:	fca43c23          	sd	a0,-40(s0)
    80202d9e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:63
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202da2:	fd843783          	ld	a5,-40(s0)
    80202da6:	0187c783          	lbu	a5,24(a5)
    80202daa:	873e                	mv	a4,a5
    80202dac:	4785                	li	a5,1
    80202dae:	00f71b63          	bne	a4,a5,80202dc4 <elf_program_get_memsz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:64
    addr = (uint64_t)program->header->_32.p_memsz;
    80202db2:	fd043783          	ld	a5,-48(s0)
    80202db6:	639c                	ld	a5,0(a5)
    80202db8:	4bdc                	lw	a5,20(a5)
    80202dba:	1782                	slli	a5,a5,0x20
    80202dbc:	9381                	srli	a5,a5,0x20
    80202dbe:	fef43423          	sd	a5,-24(s0)
    80202dc2:	a039                	j	80202dd0 <elf_program_get_memsz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:66
  else
    addr = (uint64_t)program->header->_64.p_memsz;
    80202dc4:	fd043783          	ld	a5,-48(s0)
    80202dc8:	639c                	ld	a5,0(a5)
    80202dca:	779c                	ld	a5,40(a5)
    80202dcc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:67
  return (addr);
    80202dd0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:68
}
    80202dd4:	853e                	mv	a0,a5
    80202dd6:	7422                	ld	s0,40(sp)
    80202dd8:	6145                	addi	sp,sp,48
    80202dda:	8082                	ret

0000000080202ddc <elf_program_get_filesz>:
elf_program_get_filesz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:73

/*
** Get the file size of the program
*/
uint64_t elf_program_get_filesz(t_elf *elf, t_elf_program *program) {
    80202ddc:	7179                	addi	sp,sp,-48
    80202dde:	f422                	sd	s0,40(sp)
    80202de0:	1800                	addi	s0,sp,48
    80202de2:	fca43c23          	sd	a0,-40(s0)
    80202de6:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:76
  uint64_t addr;

  if (ELF_IS_32(elf))
    80202dea:	fd843783          	ld	a5,-40(s0)
    80202dee:	0187c783          	lbu	a5,24(a5)
    80202df2:	873e                	mv	a4,a5
    80202df4:	4785                	li	a5,1
    80202df6:	00f71b63          	bne	a4,a5,80202e0c <elf_program_get_filesz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:77
    addr = (uint64_t)program->header->_32.p_filesz;
    80202dfa:	fd043783          	ld	a5,-48(s0)
    80202dfe:	639c                	ld	a5,0(a5)
    80202e00:	4b9c                	lw	a5,16(a5)
    80202e02:	1782                	slli	a5,a5,0x20
    80202e04:	9381                	srli	a5,a5,0x20
    80202e06:	fef43423          	sd	a5,-24(s0)
    80202e0a:	a039                	j	80202e18 <elf_program_get_filesz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:79
  else
    addr = (uint64_t)program->header->_64.p_filesz;
    80202e0c:	fd043783          	ld	a5,-48(s0)
    80202e10:	639c                	ld	a5,0(a5)
    80202e12:	739c                	ld	a5,32(a5)
    80202e14:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:80
  return (addr);
    80202e18:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:81
}
    80202e1c:	853e                	mv	a0,a5
    80202e1e:	7422                	ld	s0,40(sp)
    80202e20:	6145                	addi	sp,sp,48
    80202e22:	8082                	ret

0000000080202e24 <elf_load_ident>:
elf_load_ident():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:18
#include "string.h"
/*
** Load the identity of the file.
*/
static int elf_load_ident(t_elf *elf) 
{
    80202e24:	1101                	addi	sp,sp,-32
    80202e26:	ec06                	sd	ra,24(sp)
    80202e28:	e822                	sd	s0,16(sp)
    80202e2a:	1000                	addi	s0,sp,32
    80202e2c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:19
  printk("elf_load_ident start\n");
    80202e30:	00005517          	auipc	a0,0x5
    80202e34:	29850513          	addi	a0,a0,664 # 802080c8 <MMIO+0x40>
    80202e38:	9b3ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:20
  if (elf->size < EI_NIDENT || memcmp(elf->raw_data, ELFMAG, 4)) {
    80202e3c:	fe843783          	ld	a5,-24(s0)
    80202e40:	6398                	ld	a4,0(a5)
    80202e42:	47bd                	li	a5,15
    80202e44:	00e7ff63          	bgeu	a5,a4,80202e62 <elf_load_ident+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:20 (discriminator 1)
    80202e48:	fe843783          	ld	a5,-24(s0)
    80202e4c:	679c                	ld	a5,8(a5)
    80202e4e:	4611                	li	a2,4
    80202e50:	00005597          	auipc	a1,0x5
    80202e54:	29058593          	addi	a1,a1,656 # 802080e0 <MMIO+0x58>
    80202e58:	853e                	mv	a0,a5
    80202e5a:	181000ef          	jal	ra,802037da <memcmp>
    80202e5e:	87aa                	mv	a5,a0
    80202e60:	c399                	beqz	a5,80202e66 <elf_load_ident+0x42>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:21
    return (-1);
    80202e62:	57fd                	li	a5,-1
    80202e64:	a831                	j	80202e80 <elf_load_ident+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:23
  }
  elf->ident = elf->raw_data;
    80202e66:	fe843783          	ld	a5,-24(s0)
    80202e6a:	6798                	ld	a4,8(a5)
    80202e6c:	fe843783          	ld	a5,-24(s0)
    80202e70:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:24
  printk("elf_load_ident end\n");
    80202e72:	00005517          	auipc	a0,0x5
    80202e76:	27650513          	addi	a0,a0,630 # 802080e8 <MMIO+0x60>
    80202e7a:	971ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:25
  return (0);
    80202e7e:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:26
}
    80202e80:	853e                	mv	a0,a5
    80202e82:	60e2                	ld	ra,24(sp)
    80202e84:	6442                	ld	s0,16(sp)
    80202e86:	6105                	addi	sp,sp,32
    80202e88:	8082                	ret

0000000080202e8a <elf_load_header>:
elf_load_header():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:33
/*
** Load the elf header in the elf structure.
** The identity is loaded first. Then, when the file class has been
** reconized, the entire header is loaded in the field 'elf->header'
*/
int elf_load_header(t_elf *elf) {
    80202e8a:	1101                	addi	sp,sp,-32
    80202e8c:	ec06                	sd	ra,24(sp)
    80202e8e:	e822                	sd	s0,16(sp)
    80202e90:	1000                	addi	s0,sp,32
    80202e92:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:35
  //printk("eld load_header\n");
  if (elf_load_ident(elf) == -1)
    80202e96:	fe843503          	ld	a0,-24(s0)
    80202e9a:	f8bff0ef          	jal	ra,80202e24 <elf_load_ident>
    80202e9e:	87aa                	mv	a5,a0
    80202ea0:	873e                	mv	a4,a5
    80202ea2:	57fd                	li	a5,-1
    80202ea4:	00f71463          	bne	a4,a5,80202eac <elf_load_header+0x22>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:36
    return (-1);
    80202ea8:	57fd                	li	a5,-1
    80202eaa:	a059                	j	80202f30 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:37
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80202eac:	fe843783          	ld	a5,-24(s0)
    80202eb0:	6b9c                	ld	a5,16(a5)
    80202eb2:	0047c703          	lbu	a4,4(a5)
    80202eb6:	fe843783          	ld	a5,-24(s0)
    80202eba:	00e78c23          	sb	a4,24(a5)
    80202ebe:	fe843783          	ld	a5,-24(s0)
    80202ec2:	0187c783          	lbu	a5,24(a5)
    80202ec6:	873e                	mv	a4,a5
    80202ec8:	4785                	li	a5,1
    80202eca:	00f70c63          	beq	a4,a5,80202ee2 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:38 (discriminator 1)
      elf->class != ELFCLASS64) {
    80202ece:	fe843783          	ld	a5,-24(s0)
    80202ed2:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:37 (discriminator 1)
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80202ed6:	873e                	mv	a4,a5
    80202ed8:	4789                	li	a5,2
    80202eda:	00f70463          	beq	a4,a5,80202ee2 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:39
    return (-1);
    80202ede:	57fd                	li	a5,-1
    80202ee0:	a881                	j	80202f30 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:41
  }
  elf->header = (t_elf_header *)elf->raw_data;
    80202ee2:	fe843783          	ld	a5,-24(s0)
    80202ee6:	6798                	ld	a4,8(a5)
    80202ee8:	fe843783          	ld	a5,-24(s0)
    80202eec:	f398                	sd	a4,32(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:42
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80202eee:	fe843783          	ld	a5,-24(s0)
    80202ef2:	0187c783          	lbu	a5,24(a5)
    80202ef6:	873e                	mv	a4,a5
    80202ef8:	4785                	li	a5,1
    80202efa:	00f71963          	bne	a4,a5,80202f0c <elf_load_header+0x82>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:42 (discriminator 1)
    80202efe:	fe843783          	ld	a5,-24(s0)
    80202f02:	6398                	ld	a4,0(a5)
    80202f04:	03300793          	li	a5,51
    80202f08:	02e7f163          	bgeu	a5,a4,80202f2a <elf_load_header+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:43 (discriminator 3)
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80202f0c:	fe843783          	ld	a5,-24(s0)
    80202f10:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:42 (discriminator 3)
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80202f14:	873e                	mv	a4,a5
    80202f16:	4789                	li	a5,2
    80202f18:	00f71b63          	bne	a4,a5,80202f2e <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:43
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80202f1c:	fe843783          	ld	a5,-24(s0)
    80202f20:	6398                	ld	a4,0(a5)
    80202f22:	03f00793          	li	a5,63
    80202f26:	00e7e463          	bltu	a5,a4,80202f2e <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:44
    return (-1);
    80202f2a:	57fd                	li	a5,-1
    80202f2c:	a011                	j	80202f30 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:47
  }
  //printk("eld load end\n");
  return (0);
    80202f2e:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:48
}
    80202f30:	853e                	mv	a0,a5
    80202f32:	60e2                	ld	ra,24(sp)
    80202f34:	6442                	ld	s0,16(sp)
    80202f36:	6105                	addi	sp,sp,32
    80202f38:	8082                	ret

0000000080202f3a <elf_load>:
elf_load():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:10
/*
** Load the elf file present in the buffer.
** This function is used to parse elf file contained in a static library
** archive.
*/
int elf_load(uint8_t *elf_data, size_t elf_size, t_elf *elf) {
    80202f3a:	7179                	addi	sp,sp,-48
    80202f3c:	f406                	sd	ra,40(sp)
    80202f3e:	f022                	sd	s0,32(sp)
    80202f40:	1800                	addi	s0,sp,48
    80202f42:	fea43423          	sd	a0,-24(s0)
    80202f46:	feb43023          	sd	a1,-32(s0)
    80202f4a:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:12
  //printk("elf load\n");
  memset(elf, 0, sizeof(t_elf));
    80202f4e:	6785                	lui	a5,0x1
    80202f50:	82878613          	addi	a2,a5,-2008 # 828 <n+0x808>
    80202f54:	4581                	li	a1,0
    80202f56:	fd843503          	ld	a0,-40(s0)
    80202f5a:	049000ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:13
  elf->size = elf_size;
    80202f5e:	fd843783          	ld	a5,-40(s0)
    80202f62:	fe043703          	ld	a4,-32(s0)
    80202f66:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:14
  elf->raw_data = elf_data;
    80202f68:	fd843783          	ld	a5,-40(s0)
    80202f6c:	fe843703          	ld	a4,-24(s0)
    80202f70:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:16

  if (elf_load_header(elf) != 0) {
    80202f72:	fd843503          	ld	a0,-40(s0)
    80202f76:	f15ff0ef          	jal	ra,80202e8a <elf_load_header>
    80202f7a:	87aa                	mv	a5,a0
    80202f7c:	c399                	beqz	a5,80202f82 <elf_load+0x48>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:17
    return -1;
    80202f7e:	57fd                	li	a5,-1
    80202f80:	a015                	j	80202fa4 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:20
  }

  if (elf_load_sections(elf) != 0) {
    80202f82:	fd843503          	ld	a0,-40(s0)
    80202f86:	b47ff0ef          	jal	ra,80202acc <elf_load_sections>
    80202f8a:	87aa                	mv	a5,a0
    80202f8c:	c399                	beqz	a5,80202f92 <elf_load+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:21
    return -1;
    80202f8e:	57fd                	li	a5,-1
    80202f90:	a811                	j	80202fa4 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:24
  }

  if (elf_load_programs(elf) != 0) {
    80202f92:	fd843503          	ld	a0,-40(s0)
    80202f96:	29c000ef          	jal	ra,80203232 <elf_load_programs>
    80202f9a:	87aa                	mv	a5,a0
    80202f9c:	c399                	beqz	a5,80202fa2 <elf_load+0x68>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:25
    return -1;
    80202f9e:	57fd                	li	a5,-1
    80202fa0:	a011                	j	80202fa4 <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:28
  }
  //printk("elf load end\n");
  return 0;
    80202fa2:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:29
}
    80202fa4:	853e                	mv	a0,a5
    80202fa6:	70a2                	ld	ra,40(sp)
    80202fa8:	7402                	ld	s0,32(sp)
    80202faa:	6145                	addi	sp,sp,48
    80202fac:	8082                	ret

0000000080202fae <elf_section_get_type>:
elf_section_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:17
#include "elfparse.h"

/*
** Get the section type.
*/
uint32_t elf_section_get_type(t_elf *elf, t_elf_section *section) {
    80202fae:	7179                	addi	sp,sp,-48
    80202fb0:	f422                	sd	s0,40(sp)
    80202fb2:	1800                	addi	s0,sp,48
    80202fb4:	fca43c23          	sd	a0,-40(s0)
    80202fb8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:20
  uint32_t type;

  if (ELF_IS_32(elf))
    80202fbc:	fd843783          	ld	a5,-40(s0)
    80202fc0:	0187c783          	lbu	a5,24(a5)
    80202fc4:	873e                	mv	a4,a5
    80202fc6:	4785                	li	a5,1
    80202fc8:	00f71963          	bne	a4,a5,80202fda <elf_section_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:21
    type = (uint32_t)section->header->_32.sh_type;
    80202fcc:	fd043783          	ld	a5,-48(s0)
    80202fd0:	639c                	ld	a5,0(a5)
    80202fd2:	43dc                	lw	a5,4(a5)
    80202fd4:	fef42623          	sw	a5,-20(s0)
    80202fd8:	a039                	j	80202fe6 <elf_section_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:23
  else
    type = (uint32_t)section->header->_64.sh_type;
    80202fda:	fd043783          	ld	a5,-48(s0)
    80202fde:	639c                	ld	a5,0(a5)
    80202fe0:	43dc                	lw	a5,4(a5)
    80202fe2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:24
  return (type);
    80202fe6:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:25
}
    80202fea:	853e                	mv	a0,a5
    80202fec:	7422                	ld	s0,40(sp)
    80202fee:	6145                	addi	sp,sp,48
    80202ff0:	8082                	ret

0000000080202ff2 <elf_section_get_offset>:
elf_section_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:30

/*
** Get the section offset (from the begin of the file)
*/
size_t elf_section_get_offset(t_elf *elf, t_elf_section *section) {
    80202ff2:	7179                	addi	sp,sp,-48
    80202ff4:	f422                	sd	s0,40(sp)
    80202ff6:	1800                	addi	s0,sp,48
    80202ff8:	fca43c23          	sd	a0,-40(s0)
    80202ffc:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:33
  size_t offset;

  if (ELF_IS_32(elf))
    80203000:	fd843783          	ld	a5,-40(s0)
    80203004:	0187c783          	lbu	a5,24(a5)
    80203008:	873e                	mv	a4,a5
    8020300a:	4785                	li	a5,1
    8020300c:	00f71b63          	bne	a4,a5,80203022 <elf_section_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:34
    offset = (size_t)section->header->_32.sh_offset;
    80203010:	fd043783          	ld	a5,-48(s0)
    80203014:	639c                	ld	a5,0(a5)
    80203016:	4b9c                	lw	a5,16(a5)
    80203018:	1782                	slli	a5,a5,0x20
    8020301a:	9381                	srli	a5,a5,0x20
    8020301c:	fef43423          	sd	a5,-24(s0)
    80203020:	a039                	j	8020302e <elf_section_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:36
  else
    offset = (size_t)section->header->_64.sh_offset;
    80203022:	fd043783          	ld	a5,-48(s0)
    80203026:	639c                	ld	a5,0(a5)
    80203028:	6f9c                	ld	a5,24(a5)
    8020302a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:37
  return (offset);
    8020302e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:38
}
    80203032:	853e                	mv	a0,a5
    80203034:	7422                	ld	s0,40(sp)
    80203036:	6145                	addi	sp,sp,48
    80203038:	8082                	ret

000000008020303a <elf_section_get_size>:
elf_section_get_size():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:43

/*
** Get the size of the section
*/
size_t elf_section_get_size(t_elf *elf, t_elf_section *section) {
    8020303a:	7179                	addi	sp,sp,-48
    8020303c:	f422                	sd	s0,40(sp)
    8020303e:	1800                	addi	s0,sp,48
    80203040:	fca43c23          	sd	a0,-40(s0)
    80203044:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:46
  size_t size;

  if (ELF_IS_32(elf))
    80203048:	fd843783          	ld	a5,-40(s0)
    8020304c:	0187c783          	lbu	a5,24(a5)
    80203050:	873e                	mv	a4,a5
    80203052:	4785                	li	a5,1
    80203054:	00f71b63          	bne	a4,a5,8020306a <elf_section_get_size+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:47
    size = (size_t)section->header->_32.sh_size;
    80203058:	fd043783          	ld	a5,-48(s0)
    8020305c:	639c                	ld	a5,0(a5)
    8020305e:	4bdc                	lw	a5,20(a5)
    80203060:	1782                	slli	a5,a5,0x20
    80203062:	9381                	srli	a5,a5,0x20
    80203064:	fef43423          	sd	a5,-24(s0)
    80203068:	a039                	j	80203076 <elf_section_get_size+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:49
  else
    size = (size_t)section->header->_64.sh_size;
    8020306a:	fd043783          	ld	a5,-48(s0)
    8020306e:	639c                	ld	a5,0(a5)
    80203070:	739c                	ld	a5,32(a5)
    80203072:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:50
  return (size);
    80203076:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:51
}
    8020307a:	853e                	mv	a0,a5
    8020307c:	7422                	ld	s0,40(sp)
    8020307e:	6145                	addi	sp,sp,48
    80203080:	8082                	ret

0000000080203082 <elf_header_get_phoff>:
elf_header_get_phoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:17
#include "elfparse.h"

/*
** Get the program header table offset
*/
size_t elf_header_get_phoff(t_elf *elf) {
    80203082:	7179                	addi	sp,sp,-48
    80203084:	f422                	sd	s0,40(sp)
    80203086:	1800                	addi	s0,sp,48
    80203088:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:20
  size_t phoff;

  if (ELF_IS_32(elf))
    8020308c:	fd843783          	ld	a5,-40(s0)
    80203090:	0187c783          	lbu	a5,24(a5)
    80203094:	873e                	mv	a4,a5
    80203096:	4785                	li	a5,1
    80203098:	00f71b63          	bne	a4,a5,802030ae <elf_header_get_phoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:21
    phoff = (size_t)elf->header->_32.e_phoff;
    8020309c:	fd843783          	ld	a5,-40(s0)
    802030a0:	739c                	ld	a5,32(a5)
    802030a2:	4fdc                	lw	a5,28(a5)
    802030a4:	1782                	slli	a5,a5,0x20
    802030a6:	9381                	srli	a5,a5,0x20
    802030a8:	fef43423          	sd	a5,-24(s0)
    802030ac:	a039                	j	802030ba <elf_header_get_phoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:23
  else
    phoff = (size_t)elf->header->_64.e_phoff;
    802030ae:	fd843783          	ld	a5,-40(s0)
    802030b2:	739c                	ld	a5,32(a5)
    802030b4:	739c                	ld	a5,32(a5)
    802030b6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:24
  return (phoff);
    802030ba:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:25
}
    802030be:	853e                	mv	a0,a5
    802030c0:	7422                	ld	s0,40(sp)
    802030c2:	6145                	addi	sp,sp,48
    802030c4:	8082                	ret

00000000802030c6 <elf_header_get_phentsize>:
elf_header_get_phentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:30

/*
** Get the size of one program header
*/
size_t elf_header_get_phentsize(t_elf *elf) {
    802030c6:	7179                	addi	sp,sp,-48
    802030c8:	f422                	sd	s0,40(sp)
    802030ca:	1800                	addi	s0,sp,48
    802030cc:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:33
  size_t phentsize;

  if (ELF_IS_32(elf))
    802030d0:	fd843783          	ld	a5,-40(s0)
    802030d4:	0187c783          	lbu	a5,24(a5)
    802030d8:	873e                	mv	a4,a5
    802030da:	4785                	li	a5,1
    802030dc:	00f71a63          	bne	a4,a5,802030f0 <elf_header_get_phentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:34
    phentsize = (size_t)elf->header->_32.e_phentsize;
    802030e0:	fd843783          	ld	a5,-40(s0)
    802030e4:	739c                	ld	a5,32(a5)
    802030e6:	02a7d783          	lhu	a5,42(a5)
    802030ea:	fef43423          	sd	a5,-24(s0)
    802030ee:	a801                	j	802030fe <elf_header_get_phentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:36
  else
    phentsize = (size_t)elf->header->_64.e_phentsize;
    802030f0:	fd843783          	ld	a5,-40(s0)
    802030f4:	739c                	ld	a5,32(a5)
    802030f6:	0367d783          	lhu	a5,54(a5)
    802030fa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:37
  return (phentsize);
    802030fe:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:38
}
    80203102:	853e                	mv	a0,a5
    80203104:	7422                	ld	s0,40(sp)
    80203106:	6145                	addi	sp,sp,48
    80203108:	8082                	ret

000000008020310a <elf_header_get_phnum>:
elf_header_get_phnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:43

/*
** Get the number of entry in the program header table
*/
size_t elf_header_get_phnum(t_elf *elf) {
    8020310a:	7179                	addi	sp,sp,-48
    8020310c:	f422                	sd	s0,40(sp)
    8020310e:	1800                	addi	s0,sp,48
    80203110:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:46
  size_t phnum;

  if (ELF_IS_32(elf))
    80203114:	fd843783          	ld	a5,-40(s0)
    80203118:	0187c783          	lbu	a5,24(a5)
    8020311c:	873e                	mv	a4,a5
    8020311e:	4785                	li	a5,1
    80203120:	00f71a63          	bne	a4,a5,80203134 <elf_header_get_phnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:47
    phnum = (size_t)elf->header->_32.e_phnum;
    80203124:	fd843783          	ld	a5,-40(s0)
    80203128:	739c                	ld	a5,32(a5)
    8020312a:	02c7d783          	lhu	a5,44(a5)
    8020312e:	fef43423          	sd	a5,-24(s0)
    80203132:	a801                	j	80203142 <elf_header_get_phnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:49
  else
    phnum = (size_t)elf->header->_64.e_phnum;
    80203134:	fd843783          	ld	a5,-40(s0)
    80203138:	739c                	ld	a5,32(a5)
    8020313a:	0387d783          	lhu	a5,56(a5)
    8020313e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:50
  return (phnum);
    80203142:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:51
}
    80203146:	853e                	mv	a0,a5
    80203148:	7422                	ld	s0,40(sp)
    8020314a:	6145                	addi	sp,sp,48
    8020314c:	8082                	ret

000000008020314e <elf_load_programs_loop>:
elf_load_programs_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:9

/*
** traverse the program header table and load each segment
*/
static int elf_load_programs_loop(t_elf *elf, size_t phoff, size_t phnum,
                                  size_t phentsize) {
    8020314e:	715d                	addi	sp,sp,-80
    80203150:	e486                	sd	ra,72(sp)
    80203152:	e0a2                	sd	s0,64(sp)
    80203154:	0880                	addi	s0,sp,80
    80203156:	fca43423          	sd	a0,-56(s0)
    8020315a:	fcb43023          	sd	a1,-64(s0)
    8020315e:	fac43c23          	sd	a2,-72(s0)
    80203162:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:14
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    80203166:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    8020316a:	a845                	j	8020321a <elf_load_programs_loop+0xcc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:16
    if (i >= MAX_PROGRAM_NUM) {
    8020316c:	fe843703          	ld	a4,-24(s0)
    80203170:	03f00793          	li	a5,63
    80203174:	00e7f463          	bgeu	a5,a4,8020317c <elf_load_programs_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:17
      return (-1);
    80203178:	57fd                	li	a5,-1
    8020317a:	a07d                	j	80203228 <elf_load_programs_loop+0xda>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:20
    }
    elf->programs[i].header =
        (union u_elf_ph *)(elf->raw_data + phoff + i * phentsize);
    8020317c:	fc843783          	ld	a5,-56(s0)
    80203180:	6798                	ld	a4,8(a5)
    80203182:	fe843683          	ld	a3,-24(s0)
    80203186:	fb043783          	ld	a5,-80(s0)
    8020318a:	02f686b3          	mul	a3,a3,a5
    8020318e:	fc043783          	ld	a5,-64(s0)
    80203192:	97b6                	add	a5,a5,a3
    80203194:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:19
    elf->programs[i].header =
    80203196:	fc843683          	ld	a3,-56(s0)
    8020319a:	fe843783          	ld	a5,-24(s0)
    8020319e:	04278793          	addi	a5,a5,66
    802031a2:	0792                	slli	a5,a5,0x4
    802031a4:	97b6                	add	a5,a5,a3
    802031a6:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:21
    type = elf_program_get_type(elf, &elf->programs[i]);
    802031a8:	fe843783          	ld	a5,-24(s0)
    802031ac:	04278793          	addi	a5,a5,66
    802031b0:	0792                	slli	a5,a5,0x4
    802031b2:	fc843703          	ld	a4,-56(s0)
    802031b6:	97ba                	add	a5,a5,a4
    802031b8:	07a1                	addi	a5,a5,8
    802031ba:	85be                	mv	a1,a5
    802031bc:	fc843503          	ld	a0,-56(s0)
    802031c0:	ab5ff0ef          	jal	ra,80202c74 <elf_program_get_type>
    802031c4:	87aa                	mv	a5,a0
    802031c6:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:22
    if (type != PT_NULL) {
    802031ca:	fe442783          	lw	a5,-28(s0)
    802031ce:	2781                	sext.w	a5,a5
    802031d0:	c3a1                	beqz	a5,80203210 <elf_load_programs_loop+0xc2>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:23
      content_offset = elf_program_get_offset(elf, &elf->programs[i]);
    802031d2:	fe843783          	ld	a5,-24(s0)
    802031d6:	04278793          	addi	a5,a5,66
    802031da:	0792                	slli	a5,a5,0x4
    802031dc:	fc843703          	ld	a4,-56(s0)
    802031e0:	97ba                	add	a5,a5,a4
    802031e2:	07a1                	addi	a5,a5,8
    802031e4:	85be                	mv	a1,a5
    802031e6:	fc843503          	ld	a0,-56(s0)
    802031ea:	acfff0ef          	jal	ra,80202cb8 <elf_program_get_offset>
    802031ee:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:24
      elf->programs[i].content = elf->raw_data + content_offset;
    802031f2:	fc843783          	ld	a5,-56(s0)
    802031f6:	6798                	ld	a4,8(a5)
    802031f8:	fd843783          	ld	a5,-40(s0)
    802031fc:	973e                	add	a4,a4,a5
    802031fe:	fc843683          	ld	a3,-56(s0)
    80203202:	fe843783          	ld	a5,-24(s0)
    80203206:	04278793          	addi	a5,a5,66
    8020320a:	0792                	slli	a5,a5,0x4
    8020320c:	97b6                	add	a5,a5,a3
    8020320e:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:26
    }
    i++;
    80203210:	fe843783          	ld	a5,-24(s0)
    80203214:	0785                	addi	a5,a5,1
    80203216:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    8020321a:	fe843703          	ld	a4,-24(s0)
    8020321e:	fb843783          	ld	a5,-72(s0)
    80203222:	f4f765e3          	bltu	a4,a5,8020316c <elf_load_programs_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:28
  }
  return (0);
    80203226:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:29
}
    80203228:	853e                	mv	a0,a5
    8020322a:	60a6                	ld	ra,72(sp)
    8020322c:	6406                	ld	s0,64(sp)
    8020322e:	6161                	addi	sp,sp,80
    80203230:	8082                	ret

0000000080203232 <elf_load_programs>:
elf_load_programs():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:35

/*
** Load programs. Create a table of t_elf_program in elf->programs.
** This table is null if there is no program header table.
*/
int elf_load_programs(t_elf *elf) {
    80203232:	7139                	addi	sp,sp,-64
    80203234:	fc06                	sd	ra,56(sp)
    80203236:	f822                	sd	s0,48(sp)
    80203238:	0080                	addi	s0,sp,64
    8020323a:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:40
  size_t phoff;
  size_t phnum;
  size_t phentsize;

  if ((phoff = elf_header_get_phoff(elf)) > 0) {
    8020323e:	fc843503          	ld	a0,-56(s0)
    80203242:	e41ff0ef          	jal	ra,80203082 <elf_header_get_phoff>
    80203246:	fea43423          	sd	a0,-24(s0)
    8020324a:	fe843783          	ld	a5,-24(s0)
    8020324e:	cfb1                	beqz	a5,802032aa <elf_load_programs+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:41
    phnum = elf_header_get_phnum(elf);
    80203250:	fc843503          	ld	a0,-56(s0)
    80203254:	eb7ff0ef          	jal	ra,8020310a <elf_header_get_phnum>
    80203258:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:42
    phentsize = elf_header_get_phentsize(elf);
    8020325c:	fc843503          	ld	a0,-56(s0)
    80203260:	e67ff0ef          	jal	ra,802030c6 <elf_header_get_phentsize>
    80203264:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:43
    if (phoff + phnum * phentsize > elf->size) {
    80203268:	fe043703          	ld	a4,-32(s0)
    8020326c:	fd843783          	ld	a5,-40(s0)
    80203270:	02f70733          	mul	a4,a4,a5
    80203274:	fe843783          	ld	a5,-24(s0)
    80203278:	973e                	add	a4,a4,a5
    8020327a:	fc843783          	ld	a5,-56(s0)
    8020327e:	639c                	ld	a5,0(a5)
    80203280:	00e7f463          	bgeu	a5,a4,80203288 <elf_load_programs+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:44
      return (-1);
    80203284:	57fd                	li	a5,-1
    80203286:	a82d                	j	802032c0 <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:46
    }
    if (elf_load_programs_loop(elf, phoff, phnum, phentsize) == -1) {
    80203288:	fd843683          	ld	a3,-40(s0)
    8020328c:	fe043603          	ld	a2,-32(s0)
    80203290:	fe843583          	ld	a1,-24(s0)
    80203294:	fc843503          	ld	a0,-56(s0)
    80203298:	eb7ff0ef          	jal	ra,8020314e <elf_load_programs_loop>
    8020329c:	87aa                	mv	a5,a0
    8020329e:	873e                	mv	a4,a5
    802032a0:	57fd                	li	a5,-1
    802032a2:	00f71e63          	bne	a4,a5,802032be <elf_load_programs+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:47
      return (-1);
    802032a6:	57fd                	li	a5,-1
    802032a8:	a821                	j	802032c0 <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:50
    }
  } else
    memset(elf->programs, 0, MAX_PROGRAM_NUM * sizeof(t_elf_program));
    802032aa:	fc843783          	ld	a5,-56(s0)
    802032ae:	42878793          	addi	a5,a5,1064
    802032b2:	40000613          	li	a2,1024
    802032b6:	4581                	li	a1,0
    802032b8:	853e                	mv	a0,a5
    802032ba:	4e8000ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:51
  return (0);
    802032be:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:52
}
    802032c0:	853e                	mv	a0,a5
    802032c2:	70e2                	ld	ra,56(sp)
    802032c4:	7442                	ld	s0,48(sp)
    802032c6:	6121                	addi	sp,sp,64
    802032c8:	8082                	ret

00000000802032ca <sbi_call>:
sbi_call():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:16
#define SBI_REMOTE_SFENCE_VMA 6
#define SBI_REMOTE_SFENCE_VMA_ASID 7
#define SBI_SHUTDOWN 8


static inline uint64_t sbi_call(long which, long arg0, long arg1, long arg2) {
    802032ca:	7179                	addi	sp,sp,-48
    802032cc:	f422                	sd	s0,40(sp)
    802032ce:	1800                	addi	s0,sp,48
    802032d0:	fea43423          	sd	a0,-24(s0)
    802032d4:	feb43023          	sd	a1,-32(s0)
    802032d8:	fcc43c23          	sd	a2,-40(s0)
    802032dc:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:17
    register long a0 asm("a0") = arg0;
    802032e0:	fe043503          	ld	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:18
    register long a1 asm("a1") = arg1;
    802032e4:	fd843583          	ld	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:19
    register long a2 asm("a2") = arg2;
    802032e8:	fd043603          	ld	a2,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:20
    register long a7 asm("a7") = which;
    802032ec:	fe843883          	ld	a7,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:22

    asm volatile("ecall"
    802032f0:	00000073          	ecall
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:27
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");

    return a0;
    802032f4:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:28
}
    802032f6:	853e                	mv	a0,a5
    802032f8:	7422                	ld	s0,40(sp)
    802032fa:	6145                	addi	sp,sp,48
    802032fc:	8082                	ret

00000000802032fe <console_putchar>:
console_putchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:30

void console_putchar(uint64_t ch) {
    802032fe:	1101                	addi	sp,sp,-32
    80203300:	ec06                	sd	ra,24(sp)
    80203302:	e822                	sd	s0,16(sp)
    80203304:	1000                	addi	s0,sp,32
    80203306:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:31
    sbi_call(0x01, ch, 0, 0);
    8020330a:	fe843783          	ld	a5,-24(s0)
    8020330e:	4681                	li	a3,0
    80203310:	4601                	li	a2,0
    80203312:	85be                	mv	a1,a5
    80203314:	4505                	li	a0,1
    80203316:	fb5ff0ef          	jal	ra,802032ca <sbi_call>
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:32
}
    8020331a:	0001                	nop
    8020331c:	60e2                	ld	ra,24(sp)
    8020331e:	6442                	ld	s0,16(sp)
    80203320:	6105                	addi	sp,sp,32
    80203322:	8082                	ret

0000000080203324 <console_getchar>:
console_getchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:34

uint64_t console_getchar(void) {
    80203324:	1141                	addi	sp,sp,-16
    80203326:	e406                	sd	ra,8(sp)
    80203328:	e022                	sd	s0,0(sp)
    8020332a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:35
    return sbi_call(0x02, 0, 0, 0);
    8020332c:	4681                	li	a3,0
    8020332e:	4601                	li	a2,0
    80203330:	4581                	li	a1,0
    80203332:	4509                	li	a0,2
    80203334:	f97ff0ef          	jal	ra,802032ca <sbi_call>
    80203338:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:36
}
    8020333a:	853e                	mv	a0,a5
    8020333c:	60a2                	ld	ra,8(sp)
    8020333e:	6402                	ld	s0,0(sp)
    80203340:	0141                	addi	sp,sp,16
    80203342:	8082                	ret

0000000080203344 <sbi_shutdown>:
sbi_shutdown():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:38

uint64_t sbi_shutdown(void) {
    80203344:	1141                	addi	sp,sp,-16
    80203346:	e406                	sd	ra,8(sp)
    80203348:	e022                	sd	s0,0(sp)
    8020334a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:39
    return sbi_call(0x08, 0, 0, 0);
    8020334c:	4681                	li	a3,0
    8020334e:	4601                	li	a2,0
    80203350:	4581                	li	a1,0
    80203352:	4521                	li	a0,8
    80203354:	f77ff0ef          	jal	ra,802032ca <sbi_call>
    80203358:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:40
}
    8020335a:	853e                	mv	a0,a5
    8020335c:	60a2                	ld	ra,8(sp)
    8020335e:	6402                	ld	s0,0(sp)
    80203360:	0141                	addi	sp,sp,16
    80203362:	8082                	ret

0000000080203364 <sbi_set_timer>:
sbi_set_timer():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:43

uint64_t sbi_set_timer(uint64_t stime_value)
{
    80203364:	1101                	addi	sp,sp,-32
    80203366:	ec06                	sd	ra,24(sp)
    80203368:	e822                	sd	s0,16(sp)
    8020336a:	1000                	addi	s0,sp,32
    8020336c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:44
    return sbi_call(0x00,stime_value,0,0);
    80203370:	fe843783          	ld	a5,-24(s0)
    80203374:	4681                	li	a3,0
    80203376:	4601                	li	a2,0
    80203378:	85be                	mv	a1,a5
    8020337a:	4501                	li	a0,0
    8020337c:	f4fff0ef          	jal	ra,802032ca <sbi_call>
    80203380:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:45
    80203382:	853e                	mv	a0,a5
    80203384:	60e2                	ld	ra,24(sp)
    80203386:	6442                	ld	s0,16(sp)
    80203388:	6105                	addi	sp,sp,32
    8020338a:	8082                	ret

000000008020338c <strlen_t>:
strlen_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:6

#include "string.h"


int strlen_t(const char *src)
{
    8020338c:	7179                	addi	sp,sp,-48
    8020338e:	f422                	sd	s0,40(sp)
    80203390:	1800                	addi	s0,sp,48
    80203392:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8
    int i;
    for (i = 0; src[i] != '\0'; i++) {
    80203396:	fe042623          	sw	zero,-20(s0)
    8020339a:	a031                	j	802033a6 <strlen_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 3)
    8020339c:	fec42783          	lw	a5,-20(s0)
    802033a0:	2785                	addiw	a5,a5,1
    802033a2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 1)
    802033a6:	fec42783          	lw	a5,-20(s0)
    802033aa:	fd843703          	ld	a4,-40(s0)
    802033ae:	97ba                	add	a5,a5,a4
    802033b0:	0007c783          	lbu	a5,0(a5)
    802033b4:	f7e5                	bnez	a5,8020339c <strlen_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:10
    }
    return i;
    802033b6:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:11
}
    802033ba:	853e                	mv	a0,a5
    802033bc:	7422                	ld	s0,40(sp)
    802033be:	6145                	addi	sp,sp,48
    802033c0:	8082                	ret

00000000802033c2 <memcpy_t>:
memcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:14

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    802033c2:	7179                	addi	sp,sp,-48
    802033c4:	f422                	sd	s0,40(sp)
    802033c6:	1800                	addi	s0,sp,48
    802033c8:	fea43423          	sd	a0,-24(s0)
    802033cc:	feb43023          	sd	a1,-32(s0)
    802033d0:	87b2                	mv	a5,a2
    802033d2:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15
    for (; len != 0; len--) {
    802033d6:	a035                	j	80203402 <memcpy_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:16 (discriminator 2)
        *dest++ = *src++;
    802033d8:	fe043703          	ld	a4,-32(s0)
    802033dc:	00170793          	addi	a5,a4,1
    802033e0:	fef43023          	sd	a5,-32(s0)
    802033e4:	fe843783          	ld	a5,-24(s0)
    802033e8:	00178693          	addi	a3,a5,1
    802033ec:	fed43423          	sd	a3,-24(s0)
    802033f0:	00074703          	lbu	a4,0(a4)
    802033f4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 2)
    for (; len != 0; len--) {
    802033f8:	fdc42783          	lw	a5,-36(s0)
    802033fc:	37fd                	addiw	a5,a5,-1
    802033fe:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 1)
    80203402:	fdc42783          	lw	a5,-36(s0)
    80203406:	2781                	sext.w	a5,a5
    80203408:	fbe1                	bnez	a5,802033d8 <memcpy_t+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:18
    }
}
    8020340a:	0001                	nop
    8020340c:	0001                	nop
    8020340e:	7422                	ld	s0,40(sp)
    80203410:	6145                	addi	sp,sp,48
    80203412:	8082                	ret

0000000080203414 <memcmp_t>:
memcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:21

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    80203414:	7139                	addi	sp,sp,-64
    80203416:	fc22                	sd	s0,56(sp)
    80203418:	0080                	addi	s0,sp,64
    8020341a:	fca43c23          	sd	a0,-40(s0)
    8020341e:	fcb43823          	sd	a1,-48(s0)
    80203422:	87b2                	mv	a5,a2
    80203424:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22
    for (int i = 0; i < num; ++i) {
    80203428:	fe042623          	sw	zero,-20(s0)
    8020342c:	a8a1                	j	80203484 <memcmp_t+0x70>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:23
        if (((char*)ptr1)[i] != ((char*)ptr2)[i]) {
    8020342e:	fec42783          	lw	a5,-20(s0)
    80203432:	fd843703          	ld	a4,-40(s0)
    80203436:	97ba                	add	a5,a5,a4
    80203438:	0007c683          	lbu	a3,0(a5)
    8020343c:	fec42783          	lw	a5,-20(s0)
    80203440:	fd043703          	ld	a4,-48(s0)
    80203444:	97ba                	add	a5,a5,a4
    80203446:	0007c783          	lbu	a5,0(a5)
    8020344a:	8736                	mv	a4,a3
    8020344c:	02f70763          	beq	a4,a5,8020347a <memcmp_t+0x66>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:24
            return ((char*)ptr1)[i] - ((char*)ptr2)[i];
    80203450:	fec42783          	lw	a5,-20(s0)
    80203454:	fd843703          	ld	a4,-40(s0)
    80203458:	97ba                	add	a5,a5,a4
    8020345a:	0007c783          	lbu	a5,0(a5)
    8020345e:	0007871b          	sext.w	a4,a5
    80203462:	fec42783          	lw	a5,-20(s0)
    80203466:	fd043683          	ld	a3,-48(s0)
    8020346a:	97b6                	add	a5,a5,a3
    8020346c:	0007c783          	lbu	a5,0(a5)
    80203470:	2781                	sext.w	a5,a5
    80203472:	40f707bb          	subw	a5,a4,a5
    80203476:	2781                	sext.w	a5,a5
    80203478:	a831                	j	80203494 <memcmp_t+0x80>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 2)
    for (int i = 0; i < num; ++i) {
    8020347a:	fec42783          	lw	a5,-20(s0)
    8020347e:	2785                	addiw	a5,a5,1
    80203480:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 1)
    80203484:	fec42703          	lw	a4,-20(s0)
    80203488:	fcc42783          	lw	a5,-52(s0)
    8020348c:	2781                	sext.w	a5,a5
    8020348e:	faf760e3          	bltu	a4,a5,8020342e <memcmp_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:27
        }
    }
    return 0;
    80203492:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:28
}
    80203494:	853e                	mv	a0,a5
    80203496:	7462                	ld	s0,56(sp)
    80203498:	6121                	addi	sp,sp,64
    8020349a:	8082                	ret

000000008020349c <memmove_t>:
memmove_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:31

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    8020349c:	715d                	addi	sp,sp,-80
    8020349e:	e4a2                	sd	s0,72(sp)
    802034a0:	0880                	addi	s0,sp,80
    802034a2:	fca43423          	sd	a0,-56(s0)
    802034a6:	fcb43023          	sd	a1,-64(s0)
    802034aa:	86b2                	mv	a3,a2
    802034ac:	fad42e23          	sw	a3,-68(s0)
    802034b0:	868a                	mv	a3,sp
    802034b2:	85b6                	mv	a1,a3
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:32
    u8 temp[len];
    802034b4:	fbc42683          	lw	a3,-68(s0)
    802034b8:	02069613          	slli	a2,a3,0x20
    802034bc:	9201                	srli	a2,a2,0x20
    802034be:	167d                	addi	a2,a2,-1
    802034c0:	fec43423          	sd	a2,-24(s0)
    802034c4:	02069613          	slli	a2,a3,0x20
    802034c8:	9201                	srli	a2,a2,0x20
    802034ca:	8e32                	mv	t3,a2
    802034cc:	4e81                	li	t4,0
    802034ce:	03de5613          	srli	a2,t3,0x3d
    802034d2:	003e9893          	slli	a7,t4,0x3
    802034d6:	011668b3          	or	a7,a2,a7
    802034da:	003e1813          	slli	a6,t3,0x3
    802034de:	02069613          	slli	a2,a3,0x20
    802034e2:	9201                	srli	a2,a2,0x20
    802034e4:	8332                	mv	t1,a2
    802034e6:	4381                	li	t2,0
    802034e8:	03d35613          	srli	a2,t1,0x3d
    802034ec:	00339793          	slli	a5,t2,0x3
    802034f0:	8fd1                	or	a5,a5,a2
    802034f2:	00331713          	slli	a4,t1,0x3
    802034f6:	02069793          	slli	a5,a3,0x20
    802034fa:	9381                	srli	a5,a5,0x20
    802034fc:	07bd                	addi	a5,a5,15
    802034fe:	8391                	srli	a5,a5,0x4
    80203500:	0792                	slli	a5,a5,0x4
    80203502:	40f10133          	sub	sp,sp,a5
    80203506:	878a                	mv	a5,sp
    80203508:	00078793          	mv	a5,a5
    8020350c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34
    i32 i;
    for (i = 0; len != 0; len--) {
    80203510:	fc042e23          	sw	zero,-36(s0)
    80203514:	a02d                	j	8020353e <memmove_t+0xa2>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:35 (discriminator 3)
        temp[i] = *src++;
    80203516:	fc043783          	ld	a5,-64(s0)
    8020351a:	00178713          	addi	a4,a5,1
    8020351e:	fce43023          	sd	a4,-64(s0)
    80203522:	0007c703          	lbu	a4,0(a5)
    80203526:	fe043683          	ld	a3,-32(s0)
    8020352a:	fdc42783          	lw	a5,-36(s0)
    8020352e:	97b6                	add	a5,a5,a3
    80203530:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 3)
    for (i = 0; len != 0; len--) {
    80203534:	fbc42783          	lw	a5,-68(s0)
    80203538:	37fd                	addiw	a5,a5,-1
    8020353a:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 1)
    8020353e:	fbc42783          	lw	a5,-68(s0)
    80203542:	2781                	sext.w	a5,a5
    80203544:	fbe9                	bnez	a5,80203516 <memmove_t+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37
    }
    for (; len != 0; len--) {
    80203546:	a02d                	j	80203570 <memmove_t+0xd4>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:38 (discriminator 2)
        *dest++ = temp[i];
    80203548:	fc843783          	ld	a5,-56(s0)
    8020354c:	00178713          	addi	a4,a5,1
    80203550:	fce43423          	sd	a4,-56(s0)
    80203554:	fe043683          	ld	a3,-32(s0)
    80203558:	fdc42703          	lw	a4,-36(s0)
    8020355c:	9736                	add	a4,a4,a3
    8020355e:	00074703          	lbu	a4,0(a4)
    80203562:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 2)
    for (; len != 0; len--) {
    80203566:	fbc42783          	lw	a5,-68(s0)
    8020356a:	37fd                	addiw	a5,a5,-1
    8020356c:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 1)
    80203570:	fbc42783          	lw	a5,-68(s0)
    80203574:	2781                	sext.w	a5,a5
    80203576:	fbe9                	bnez	a5,80203548 <memmove_t+0xac>
    80203578:	812e                	mv	sp,a1
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:40
    }
}
    8020357a:	0001                	nop
    8020357c:	fb040113          	addi	sp,s0,-80
    80203580:	6426                	ld	s0,72(sp)
    80203582:	6161                	addi	sp,sp,80
    80203584:	8082                	ret

0000000080203586 <memset_t>:
memset_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:43

void memset_t(void *dest, u8 val, u32 len)
{
    80203586:	7179                	addi	sp,sp,-48
    80203588:	f422                	sd	s0,40(sp)
    8020358a:	1800                	addi	s0,sp,48
    8020358c:	fca43c23          	sd	a0,-40(s0)
    80203590:	87ae                	mv	a5,a1
    80203592:	8732                	mv	a4,a2
    80203594:	fcf40ba3          	sb	a5,-41(s0)
    80203598:	87ba                	mv	a5,a4
    8020359a:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:44
    u8 *dst = (u8 *)dest;
    8020359e:	fd843783          	ld	a5,-40(s0)
    802035a2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46

    for (; len != 0; len--) 
    802035a6:	a005                	j	802035c6 <memset_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:48 (discriminator 2)
    {
        *dst++ = val;
    802035a8:	fe843783          	ld	a5,-24(s0)
    802035ac:	00178713          	addi	a4,a5,1
    802035b0:	fee43423          	sd	a4,-24(s0)
    802035b4:	fd744703          	lbu	a4,-41(s0)
    802035b8:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 2)
    for (; len != 0; len--) 
    802035bc:	fd042783          	lw	a5,-48(s0)
    802035c0:	37fd                	addiw	a5,a5,-1
    802035c2:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 1)
    802035c6:	fd042783          	lw	a5,-48(s0)
    802035ca:	2781                	sext.w	a5,a5
    802035cc:	fff1                	bnez	a5,802035a8 <memset_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:50
    }
}
    802035ce:	0001                	nop
    802035d0:	0001                	nop
    802035d2:	7422                	ld	s0,40(sp)
    802035d4:	6145                	addi	sp,sp,48
    802035d6:	8082                	ret

00000000802035d8 <bzero_t>:
bzero_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:52

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }
    802035d8:	1101                	addi	sp,sp,-32
    802035da:	ec06                	sd	ra,24(sp)
    802035dc:	e822                	sd	s0,16(sp)
    802035de:	1000                	addi	s0,sp,32
    802035e0:	fea43423          	sd	a0,-24(s0)
    802035e4:	87ae                	mv	a5,a1
    802035e6:	fef42223          	sw	a5,-28(s0)
    802035ea:	fe442783          	lw	a5,-28(s0)
    802035ee:	863e                	mv	a2,a5
    802035f0:	4581                	li	a1,0
    802035f2:	fe843503          	ld	a0,-24(s0)
    802035f6:	f91ff0ef          	jal	ra,80203586 <memset_t>
    802035fa:	0001                	nop
    802035fc:	60e2                	ld	ra,24(sp)
    802035fe:	6442                	ld	s0,16(sp)
    80203600:	6105                	addi	sp,sp,32
    80203602:	8082                	ret

0000000080203604 <strcmp_t>:
strcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:55

int strcmp_t(const char *str1, const char *str2)
{
    80203604:	1101                	addi	sp,sp,-32
    80203606:	ec22                	sd	s0,24(sp)
    80203608:	1000                	addi	s0,sp,32
    8020360a:	fea43423          	sd	a0,-24(s0)
    8020360e:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56
    while (*str1 && *str2) {
    80203612:	a0a1                	j	8020365a <strcmp_t+0x56>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:57
        if (*str1 != *str2) {
    80203614:	fe843783          	ld	a5,-24(s0)
    80203618:	0007c703          	lbu	a4,0(a5)
    8020361c:	fe043783          	ld	a5,-32(s0)
    80203620:	0007c783          	lbu	a5,0(a5)
    80203624:	02f70163          	beq	a4,a5,80203646 <strcmp_t+0x42>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:58
            return (*str1) - (*str2);
    80203628:	fe843783          	ld	a5,-24(s0)
    8020362c:	0007c783          	lbu	a5,0(a5)
    80203630:	0007871b          	sext.w	a4,a5
    80203634:	fe043783          	ld	a5,-32(s0)
    80203638:	0007c783          	lbu	a5,0(a5)
    8020363c:	2781                	sext.w	a5,a5
    8020363e:	40f707bb          	subw	a5,a4,a5
    80203642:	2781                	sext.w	a5,a5
    80203644:	a099                	j	8020368a <strcmp_t+0x86>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:60
        }
        ++str1;
    80203646:	fe843783          	ld	a5,-24(s0)
    8020364a:	0785                	addi	a5,a5,1
    8020364c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:61
        ++str2;
    80203650:	fe043783          	ld	a5,-32(s0)
    80203654:	0785                	addi	a5,a5,1
    80203656:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56
    while (*str1 && *str2) {
    8020365a:	fe843783          	ld	a5,-24(s0)
    8020365e:	0007c783          	lbu	a5,0(a5)
    80203662:	c791                	beqz	a5,8020366e <strcmp_t+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56 (discriminator 1)
    80203664:	fe043783          	ld	a5,-32(s0)
    80203668:	0007c783          	lbu	a5,0(a5)
    8020366c:	f7c5                	bnez	a5,80203614 <strcmp_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:63
    }
    return (*str1) - (*str2);
    8020366e:	fe843783          	ld	a5,-24(s0)
    80203672:	0007c783          	lbu	a5,0(a5)
    80203676:	0007871b          	sext.w	a4,a5
    8020367a:	fe043783          	ld	a5,-32(s0)
    8020367e:	0007c783          	lbu	a5,0(a5)
    80203682:	2781                	sext.w	a5,a5
    80203684:	40f707bb          	subw	a5,a4,a5
    80203688:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:64
}
    8020368a:	853e                	mv	a0,a5
    8020368c:	6462                	ld	s0,24(sp)
    8020368e:	6105                	addi	sp,sp,32
    80203690:	8082                	ret

0000000080203692 <strcpy_t>:
strcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:67

char *strcpy_t(char *dest, const char *src)
{
    80203692:	7179                	addi	sp,sp,-48
    80203694:	f422                	sd	s0,40(sp)
    80203696:	1800                	addi	s0,sp,48
    80203698:	fca43c23          	sd	a0,-40(s0)
    8020369c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:68
    char *tmp = dest;
    802036a0:	fd843783          	ld	a5,-40(s0)
    802036a4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:70

    while (*src) {
    802036a8:	a00d                	j	802036ca <strcpy_t+0x38>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:71
        *dest++ = *src++;
    802036aa:	fd043703          	ld	a4,-48(s0)
    802036ae:	00170793          	addi	a5,a4,1
    802036b2:	fcf43823          	sd	a5,-48(s0)
    802036b6:	fd843783          	ld	a5,-40(s0)
    802036ba:	00178693          	addi	a3,a5,1
    802036be:	fcd43c23          	sd	a3,-40(s0)
    802036c2:	00074703          	lbu	a4,0(a4)
    802036c6:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:70
    while (*src) {
    802036ca:	fd043783          	ld	a5,-48(s0)
    802036ce:	0007c783          	lbu	a5,0(a5)
    802036d2:	ffe1                	bnez	a5,802036aa <strcpy_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:74
    }

    *dest = '\0';
    802036d4:	fd843783          	ld	a5,-40(s0)
    802036d8:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:76

    return tmp;
    802036dc:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:77
}
    802036e0:	853e                	mv	a0,a5
    802036e2:	7422                	ld	s0,40(sp)
    802036e4:	6145                	addi	sp,sp,48
    802036e6:	8082                	ret

00000000802036e8 <strcat_t>:
strcat_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:80

char *strcat_t(char *dest, const char *src)
{
    802036e8:	7179                	addi	sp,sp,-48
    802036ea:	f422                	sd	s0,40(sp)
    802036ec:	1800                	addi	s0,sp,48
    802036ee:	fca43c23          	sd	a0,-40(s0)
    802036f2:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:81
    char *tmp = dest;
    802036f6:	fd843783          	ld	a5,-40(s0)
    802036fa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83

    while (*dest != '\0') { dest++; }
    802036fe:	a031                	j	8020370a <strcat_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83 (discriminator 2)
    80203700:	fd843783          	ld	a5,-40(s0)
    80203704:	0785                	addi	a5,a5,1
    80203706:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83 (discriminator 1)
    8020370a:	fd843783          	ld	a5,-40(s0)
    8020370e:	0007c783          	lbu	a5,0(a5)
    80203712:	f7fd                	bnez	a5,80203700 <strcat_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:84
    while (*src) {
    80203714:	a00d                	j	80203736 <strcat_t+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:85
        *dest++ = *src++;
    80203716:	fd043703          	ld	a4,-48(s0)
    8020371a:	00170793          	addi	a5,a4,1
    8020371e:	fcf43823          	sd	a5,-48(s0)
    80203722:	fd843783          	ld	a5,-40(s0)
    80203726:	00178693          	addi	a3,a5,1
    8020372a:	fcd43c23          	sd	a3,-40(s0)
    8020372e:	00074703          	lbu	a4,0(a4)
    80203732:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:84
    while (*src) {
    80203736:	fd043783          	ld	a5,-48(s0)
    8020373a:	0007c783          	lbu	a5,0(a5)
    8020373e:	ffe1                	bnez	a5,80203716 <strcat_t+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:88
    }

    *dest = '\0';
    80203740:	fd843783          	ld	a5,-40(s0)
    80203744:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:90

    return tmp;
    80203748:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:91
}
    8020374c:	853e                	mv	a0,a5
    8020374e:	7422                	ld	s0,40(sp)
    80203750:	6145                	addi	sp,sp,48
    80203752:	8082                	ret

0000000080203754 <memcpy>:
memcpy():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:94

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    80203754:	7179                	addi	sp,sp,-48
    80203756:	f422                	sd	s0,40(sp)
    80203758:	1800                	addi	s0,sp,48
    8020375a:	fea43423          	sd	a0,-24(s0)
    8020375e:	feb43023          	sd	a1,-32(s0)
    80203762:	87b2                	mv	a5,a2
    80203764:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:95
    while (len--) {
    80203768:	a00d                	j	8020378a <memcpy+0x36>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:96
        *dest++ = *src++;
    8020376a:	fe043703          	ld	a4,-32(s0)
    8020376e:	00170793          	addi	a5,a4,1
    80203772:	fef43023          	sd	a5,-32(s0)
    80203776:	fe843783          	ld	a5,-24(s0)
    8020377a:	00178693          	addi	a3,a5,1
    8020377e:	fed43423          	sd	a3,-24(s0)
    80203782:	00074703          	lbu	a4,0(a4)
    80203786:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:95
    while (len--) {
    8020378a:	fdc42783          	lw	a5,-36(s0)
    8020378e:	fff7871b          	addiw	a4,a5,-1
    80203792:	fce42e23          	sw	a4,-36(s0)
    80203796:	fbf1                	bnez	a5,8020376a <memcpy+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:98
    }
}
    80203798:	0001                	nop
    8020379a:	0001                	nop
    8020379c:	7422                	ld	s0,40(sp)
    8020379e:	6145                	addi	sp,sp,48
    802037a0:	8082                	ret

00000000802037a2 <memset>:
memset():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:101

void memset(void *dest, u8 val, u32 len)
{
    802037a2:	1101                	addi	sp,sp,-32
    802037a4:	ec06                	sd	ra,24(sp)
    802037a6:	e822                	sd	s0,16(sp)
    802037a8:	1000                	addi	s0,sp,32
    802037aa:	fea43423          	sd	a0,-24(s0)
    802037ae:	87ae                	mv	a5,a1
    802037b0:	8732                	mv	a4,a2
    802037b2:	fef403a3          	sb	a5,-25(s0)
    802037b6:	87ba                	mv	a5,a4
    802037b8:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:102
    memset_t(dest,val,len);
    802037bc:	fe042703          	lw	a4,-32(s0)
    802037c0:	fe744783          	lbu	a5,-25(s0)
    802037c4:	863a                	mv	a2,a4
    802037c6:	85be                	mv	a1,a5
    802037c8:	fe843503          	ld	a0,-24(s0)
    802037cc:	dbbff0ef          	jal	ra,80203586 <memset_t>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:103
}
    802037d0:	0001                	nop
    802037d2:	60e2                	ld	ra,24(sp)
    802037d4:	6442                	ld	s0,16(sp)
    802037d6:	6105                	addi	sp,sp,32
    802037d8:	8082                	ret

00000000802037da <memcmp>:
memcmp():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:105
int memcmp(const void *ptr1, const void *ptr2, size_t num) 
{
    802037da:	715d                	addi	sp,sp,-80
    802037dc:	e4a2                	sd	s0,72(sp)
    802037de:	0880                	addi	s0,sp,80
    802037e0:	fca43423          	sd	a0,-56(s0)
    802037e4:	fcb43023          	sd	a1,-64(s0)
    802037e8:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:106
    const unsigned char *p1 = ptr1, *p2 = ptr2;
    802037ec:	fc843783          	ld	a5,-56(s0)
    802037f0:	fef43023          	sd	a5,-32(s0)
    802037f4:	fc043783          	ld	a5,-64(s0)
    802037f8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107
    for (size_t i = 0; i < num; i++) 
    802037fc:	fe043423          	sd	zero,-24(s0)
    80203800:	a8a1                	j	80203858 <memcmp+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:109
    {
        if (p1[i] != p2[i]) 
    80203802:	fe043703          	ld	a4,-32(s0)
    80203806:	fe843783          	ld	a5,-24(s0)
    8020380a:	97ba                	add	a5,a5,a4
    8020380c:	0007c683          	lbu	a3,0(a5)
    80203810:	fd843703          	ld	a4,-40(s0)
    80203814:	fe843783          	ld	a5,-24(s0)
    80203818:	97ba                	add	a5,a5,a4
    8020381a:	0007c783          	lbu	a5,0(a5)
    8020381e:	8736                	mv	a4,a3
    80203820:	02f70763          	beq	a4,a5,8020384e <memcmp+0x74>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:111
        {
            return (int)p1[i] - (int)p2[i];
    80203824:	fe043703          	ld	a4,-32(s0)
    80203828:	fe843783          	ld	a5,-24(s0)
    8020382c:	97ba                	add	a5,a5,a4
    8020382e:	0007c783          	lbu	a5,0(a5)
    80203832:	0007871b          	sext.w	a4,a5
    80203836:	fd843683          	ld	a3,-40(s0)
    8020383a:	fe843783          	ld	a5,-24(s0)
    8020383e:	97b6                	add	a5,a5,a3
    80203840:	0007c783          	lbu	a5,0(a5)
    80203844:	2781                	sext.w	a5,a5
    80203846:	40f707bb          	subw	a5,a4,a5
    8020384a:	2781                	sext.w	a5,a5
    8020384c:	a829                	j	80203866 <memcmp+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 2)
    for (size_t i = 0; i < num; i++) 
    8020384e:	fe843783          	ld	a5,-24(s0)
    80203852:	0785                	addi	a5,a5,1
    80203854:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 1)
    80203858:	fe843703          	ld	a4,-24(s0)
    8020385c:	fb843783          	ld	a5,-72(s0)
    80203860:	faf761e3          	bltu	a4,a5,80203802 <memcmp+0x28>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:114
        }
    }
    return 0;
    80203864:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:115
}
    80203866:	853e                	mv	a0,a5
    80203868:	6426                	ld	s0,72(sp)
    8020386a:	6161                	addi	sp,sp,80
    8020386c:	8082                	ret

000000008020386e <memmove>:
memmove():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:118


void *memmove(void *dest, const void *src, size_t n) {
    8020386e:	715d                	addi	sp,sp,-80
    80203870:	e4a2                	sd	s0,72(sp)
    80203872:	0880                	addi	s0,sp,80
    80203874:	fca43423          	sd	a0,-56(s0)
    80203878:	fcb43023          	sd	a1,-64(s0)
    8020387c:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:119
    u8 *d = (u8 *)dest;
    80203880:	fc843783          	ld	a5,-56(s0)
    80203884:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:120
    const u8 *s = (const u8 *)src;
    80203888:	fc043783          	ld	a5,-64(s0)
    8020388c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:123

    // 如果源和目标相同，就没有复制的必要
    if (d == s) {
    80203890:	fd843703          	ld	a4,-40(s0)
    80203894:	fd043783          	ld	a5,-48(s0)
    80203898:	00f71563          	bne	a4,a5,802038a2 <memmove+0x34>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:124
        return dest;
    8020389c:	fc843783          	ld	a5,-56(s0)
    802038a0:	a861                	j	80203938 <memmove+0xca>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:128
    }

    // 如果源地址小于目标地址，并且两者重叠，则从后向前复制
    if (s < d && d < s + n) {
    802038a2:	fd043703          	ld	a4,-48(s0)
    802038a6:	fd843783          	ld	a5,-40(s0)
    802038aa:	04f77963          	bgeu	a4,a5,802038fc <memmove+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:128 (discriminator 1)
    802038ae:	fd043703          	ld	a4,-48(s0)
    802038b2:	fb843783          	ld	a5,-72(s0)
    802038b6:	97ba                	add	a5,a5,a4
    802038b8:	fd843703          	ld	a4,-40(s0)
    802038bc:	04f77063          	bgeu	a4,a5,802038fc <memmove+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129
        for (size_t i = n; i != 0; i--) {
    802038c0:	fb843783          	ld	a5,-72(s0)
    802038c4:	fef43423          	sd	a5,-24(s0)
    802038c8:	a035                	j	802038f4 <memmove+0x86>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:130 (discriminator 3)
            d[i - 1] = s[i - 1];
    802038ca:	fe843783          	ld	a5,-24(s0)
    802038ce:	17fd                	addi	a5,a5,-1
    802038d0:	fd043703          	ld	a4,-48(s0)
    802038d4:	973e                	add	a4,a4,a5
    802038d6:	fe843783          	ld	a5,-24(s0)
    802038da:	17fd                	addi	a5,a5,-1
    802038dc:	fd843683          	ld	a3,-40(s0)
    802038e0:	97b6                	add	a5,a5,a3
    802038e2:	00074703          	lbu	a4,0(a4)
    802038e6:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129 (discriminator 3)
        for (size_t i = n; i != 0; i--) {
    802038ea:	fe843783          	ld	a5,-24(s0)
    802038ee:	17fd                	addi	a5,a5,-1
    802038f0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129 (discriminator 1)
    802038f4:	fe843783          	ld	a5,-24(s0)
    802038f8:	fbe9                	bnez	a5,802038ca <memmove+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:129
    802038fa:	a82d                	j	80203934 <memmove+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134
        }
    } else {
        // 否则，从前向后复制
        for (size_t i = 0; i < n; i++) {
    802038fc:	fe043023          	sd	zero,-32(s0)
    80203900:	a025                	j	80203928 <memmove+0xba>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:135 (discriminator 3)
            d[i] = s[i];
    80203902:	fd043703          	ld	a4,-48(s0)
    80203906:	fe043783          	ld	a5,-32(s0)
    8020390a:	973e                	add	a4,a4,a5
    8020390c:	fd843683          	ld	a3,-40(s0)
    80203910:	fe043783          	ld	a5,-32(s0)
    80203914:	97b6                	add	a5,a5,a3
    80203916:	00074703          	lbu	a4,0(a4)
    8020391a:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134 (discriminator 3)
        for (size_t i = 0; i < n; i++) {
    8020391e:	fe043783          	ld	a5,-32(s0)
    80203922:	0785                	addi	a5,a5,1
    80203924:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:134 (discriminator 1)
    80203928:	fe043703          	ld	a4,-32(s0)
    8020392c:	fb843783          	ld	a5,-72(s0)
    80203930:	fcf769e3          	bltu	a4,a5,80203902 <memmove+0x94>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:139
        }
    }

    return dest;
    80203934:	fc843783          	ld	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:140
    80203938:	853e                	mv	a0,a5
    8020393a:	6426                	ld	s0,72(sp)
    8020393c:	6161                	addi	sp,sp,80
    8020393e:	8082                	ret

0000000080203940 <init_heap>:
init_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:16

static char heap[HEAP_SIZE];  // 堆空间

// 初始化堆
void init_heap() 
{
    80203940:	1101                	addi	sp,sp,-32
    80203942:	ec22                	sd	s0,24(sp)
    80203944:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:18
    // 初始化堆的第一个块
    BlockHeader* header = (BlockHeader*)heap;
    80203946:	00021797          	auipc	a5,0x21
    8020394a:	6c278793          	addi	a5,a5,1730 # 80225008 <heap>
    8020394e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:19
    header->size = HEAP_SIZE - sizeof(BlockHeader); // 设置第一个块的大小
    80203952:	fe843783          	ld	a5,-24(s0)
    80203956:	00800737          	lui	a4,0x800
    8020395a:	1741                	addi	a4,a4,-16
    8020395c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:20
    header->free = 1; // 设置第一个块为空闲
    8020395e:	fe843783          	ld	a5,-24(s0)
    80203962:	4705                	li	a4,1
    80203964:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:21
}
    80203966:	0001                	nop
    80203968:	6462                	ld	s0,24(sp)
    8020396a:	6105                	addi	sp,sp,32
    8020396c:	8082                	ret

000000008020396e <malloc>:
malloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:24

// 分配内存
void* malloc(uint64_t size) {
    8020396e:	7179                	addi	sp,sp,-48
    80203970:	f422                	sd	s0,40(sp)
    80203972:	1800                	addi	s0,sp,48
    80203974:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:26
    // 从堆的开始处搜索合适的内存块
    BlockHeader* header = (BlockHeader*)heap;
    80203978:	00021797          	auipc	a5,0x21
    8020397c:	69078793          	addi	a5,a5,1680 # 80225008 <heap>
    80203980:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29

    // 搜索未分配且大小合适的内存块
    while (header->size < size || !header->free) {
    80203984:	a025                	j	802039ac <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:30
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    80203986:	fe843783          	ld	a5,-24(s0)
    8020398a:	639c                	ld	a5,0(a5)
    8020398c:	07c1                	addi	a5,a5,16
    8020398e:	fe843703          	ld	a4,-24(s0)
    80203992:	97ba                	add	a5,a5,a4
    80203994:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:31
        if ((char*)header >= (char*)heap + HEAP_SIZE) {
    80203998:	00821797          	auipc	a5,0x821
    8020399c:	67078793          	addi	a5,a5,1648 # 80a25008 <KERNEL_SPACE>
    802039a0:	fe843703          	ld	a4,-24(s0)
    802039a4:	00f76463          	bltu	a4,a5,802039ac <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:33
            // 搜索到堆的末尾还未找到合适的内存块
            return NULL;
    802039a8:	4781                	li	a5,0
    802039aa:	a885                	j	80203a1a <malloc+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29
    while (header->size < size || !header->free) {
    802039ac:	fe843783          	ld	a5,-24(s0)
    802039b0:	639c                	ld	a5,0(a5)
    802039b2:	fd843703          	ld	a4,-40(s0)
    802039b6:	fce7e8e3          	bltu	a5,a4,80203986 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:29 (discriminator 1)
    802039ba:	fe843783          	ld	a5,-24(s0)
    802039be:	479c                	lw	a5,8(a5)
    802039c0:	d3f9                	beqz	a5,80203986 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:38
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4) {
    802039c2:	fe843783          	ld	a5,-24(s0)
    802039c6:	6398                	ld	a4,0(a5)
    802039c8:	fd843783          	ld	a5,-40(s0)
    802039cc:	07d1                	addi	a5,a5,20
    802039ce:	02f76f63          	bltu	a4,a5,80203a0c <malloc+0x9e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:40
        // 分割内存块以减少浪费
        BlockHeader* new_header = (BlockHeader*)((char*)header + size + sizeof(BlockHeader));
    802039d2:	fd843783          	ld	a5,-40(s0)
    802039d6:	07c1                	addi	a5,a5,16
    802039d8:	fe843703          	ld	a4,-24(s0)
    802039dc:	97ba                	add	a5,a5,a4
    802039de:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:41
        new_header->size = header->size - size - sizeof(BlockHeader); // 计算新内存块的大小
    802039e2:	fe843783          	ld	a5,-24(s0)
    802039e6:	6398                	ld	a4,0(a5)
    802039e8:	fd843783          	ld	a5,-40(s0)
    802039ec:	40f707b3          	sub	a5,a4,a5
    802039f0:	ff078713          	addi	a4,a5,-16
    802039f4:	fe043783          	ld	a5,-32(s0)
    802039f8:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:42
        new_header->free = 1; // 设置新内存块为空闲
    802039fa:	fe043783          	ld	a5,-32(s0)
    802039fe:	4705                	li	a4,1
    80203a00:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:43
        header->size = size; // 更新当前内存块的大小
    80203a02:	fe843783          	ld	a5,-24(s0)
    80203a06:	fd843703          	ld	a4,-40(s0)
    80203a0a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:46
    }

    header->free = 0; // 标记当前内存块为已分配
    80203a0c:	fe843783          	ld	a5,-24(s0)
    80203a10:	0007a423          	sw	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:47
    return (void*)(header + 1); // 返回内存块数据区的地址
    80203a14:	fe843783          	ld	a5,-24(s0)
    80203a18:	07c1                	addi	a5,a5,16
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:48
}
    80203a1a:	853e                	mv	a0,a5
    80203a1c:	7422                	ld	s0,40(sp)
    80203a1e:	6145                	addi	sp,sp,48
    80203a20:	8082                	ret

0000000080203a22 <free>:
free():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:51

// 释放内存
void free(void* ptr) {
    80203a22:	7179                	addi	sp,sp,-48
    80203a24:	f422                	sd	s0,40(sp)
    80203a26:	1800                	addi	s0,sp,48
    80203a28:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:53
    // 如果指针为空，则不进行操作
    if (ptr == NULL) {
    80203a2c:	fd843783          	ld	a5,-40(s0)
    80203a30:	cb99                	beqz	a5,80203a46 <free+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:58
        return;
    }

    // 获取内存块头部
    BlockHeader* header = (BlockHeader*)ptr - 1;
    80203a32:	fd843783          	ld	a5,-40(s0)
    80203a36:	17c1                	addi	a5,a5,-16
    80203a38:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:59
    header->free = 1; // 标记内存块为空闲
    80203a3c:	fe843783          	ld	a5,-24(s0)
    80203a40:	4705                	li	a4,1
    80203a42:	c798                	sw	a4,8(a5)
    80203a44:	a011                	j	80203a48 <free+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:54
        return;
    80203a46:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:60
}
    80203a48:	7422                	ld	s0,40(sp)
    80203a4a:	6145                	addi	sp,sp,48
    80203a4c:	8082                	ret

0000000080203a4e <print_heap>:
print_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:63

// 打印堆的状态
void print_heap() {
    80203a4e:	1101                	addi	sp,sp,-32
    80203a50:	ec06                	sd	ra,24(sp)
    80203a52:	e822                	sd	s0,16(sp)
    80203a54:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:64
    BlockHeader* header = (BlockHeader*)heap;
    80203a56:	00021797          	auipc	a5,0x21
    80203a5a:	5b278793          	addi	a5,a5,1458 # 80225008 <heap>
    80203a5e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:67

    // 遍历堆中的所有内存块
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    80203a62:	a095                	j	80203ac6 <print_heap+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:68
        print_str("Block size: ");
    80203a64:	00004517          	auipc	a0,0x4
    80203a68:	69c50513          	addi	a0,a0,1692 # 80208100 <MMIO+0x78>
    80203a6c:	17b020ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:69
        print_uint64(header->size); // 打印内存块大小
    80203a70:	fe843783          	ld	a5,-24(s0)
    80203a74:	639c                	ld	a5,0(a5)
    80203a76:	853e                	mv	a0,a5
    80203a78:	2ed020ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:70
        print_str(", Free: ");
    80203a7c:	00004517          	auipc	a0,0x4
    80203a80:	69450513          	addi	a0,a0,1684 # 80208110 <MMIO+0x88>
    80203a84:	163020ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71
        print_str(header->free ? "Yes" : "No"); // 打印内存块是否空闲
    80203a88:	fe843783          	ld	a5,-24(s0)
    80203a8c:	479c                	lw	a5,8(a5)
    80203a8e:	c791                	beqz	a5,80203a9a <print_heap+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 1)
    80203a90:	00004797          	auipc	a5,0x4
    80203a94:	69078793          	addi	a5,a5,1680 # 80208120 <MMIO+0x98>
    80203a98:	a029                	j	80203aa2 <print_heap+0x54>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 2)
    80203a9a:	00004797          	auipc	a5,0x4
    80203a9e:	68e78793          	addi	a5,a5,1678 # 80208128 <MMIO+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:71 (discriminator 4)
    80203aa2:	853e                	mv	a0,a5
    80203aa4:	143020ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:72 (discriminator 4)
        print_str("\n");
    80203aa8:	00004517          	auipc	a0,0x4
    80203aac:	68850513          	addi	a0,a0,1672 # 80208130 <MMIO+0xa8>
    80203ab0:	137020ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:75 (discriminator 4)

        // 移动到下一个内存块
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    80203ab4:	fe843783          	ld	a5,-24(s0)
    80203ab8:	639c                	ld	a5,0(a5)
    80203aba:	07c1                	addi	a5,a5,16
    80203abc:	fe843703          	ld	a4,-24(s0)
    80203ac0:	97ba                	add	a5,a5,a4
    80203ac2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:67
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    80203ac6:	00821797          	auipc	a5,0x821
    80203aca:	54278793          	addi	a5,a5,1346 # 80a25008 <KERNEL_SPACE>
    80203ace:	fe843703          	ld	a4,-24(s0)
    80203ad2:	f8f769e3          	bltu	a4,a5,80203a64 <print_heap+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:77
    }
}
    80203ad6:	0001                	nop
    80203ad8:	0001                	nop
    80203ada:	60e2                	ld	ra,24(sp)
    80203adc:	6442                	ld	s0,16(sp)
    80203ade:	6105                	addi	sp,sp,32
    80203ae0:	8082                	ret

0000000080203ae2 <realloc>:
realloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:81

// 重新分配内存
void* realloc(void* ptr, uint64_t new_size) 
{
    80203ae2:	7139                	addi	sp,sp,-64
    80203ae4:	fc06                	sd	ra,56(sp)
    80203ae6:	f822                	sd	s0,48(sp)
    80203ae8:	0080                	addi	s0,sp,64
    80203aea:	fca43423          	sd	a0,-56(s0)
    80203aee:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:82
    if (new_size == 0) {
    80203af2:	fc043783          	ld	a5,-64(s0)
    80203af6:	e799                	bnez	a5,80203b04 <realloc+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:84
        // 如果新大小为0，则释放原有内存并返回NULL
        free(ptr);
    80203af8:	fc843503          	ld	a0,-56(s0)
    80203afc:	f27ff0ef          	jal	ra,80203a22 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:85
        return NULL;
    80203b00:	4781                	li	a5,0
    80203b02:	a045                	j	80203ba2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:88
    }

    if (ptr == NULL) {
    80203b04:	fc843783          	ld	a5,-56(s0)
    80203b08:	e799                	bnez	a5,80203b16 <realloc+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:90
        // 如果原始指针为NULL，则行为等同于malloc
        return malloc(new_size);
    80203b0a:	fc043503          	ld	a0,-64(s0)
    80203b0e:	e61ff0ef          	jal	ra,8020396e <malloc>
    80203b12:	87aa                	mv	a5,a0
    80203b14:	a079                	j	80203ba2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:93
    }

    BlockHeader* header = (BlockHeader*)ptr - 1;
    80203b16:	fc843783          	ld	a5,-56(s0)
    80203b1a:	17c1                	addi	a5,a5,-16
    80203b1c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:94
    if (header->size >= new_size) {
    80203b20:	fe043783          	ld	a5,-32(s0)
    80203b24:	639c                	ld	a5,0(a5)
    80203b26:	fc043703          	ld	a4,-64(s0)
    80203b2a:	00e7e563          	bltu	a5,a4,80203b34 <realloc+0x52>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:96
        // 如果原始内存块大小已满足需求，则直接返回原始指针
        return ptr;
    80203b2e:	fc843783          	ld	a5,-56(s0)
    80203b32:	a885                	j	80203ba2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:99
    } else {
        // 如果新大小超出原始大小，则分配一个新的内存块并复制原始数据
        void* new_ptr = malloc(new_size);
    80203b34:	fc043503          	ld	a0,-64(s0)
    80203b38:	e37ff0ef          	jal	ra,8020396e <malloc>
    80203b3c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:100
        if (new_ptr == NULL) {
    80203b40:	fd843783          	ld	a5,-40(s0)
    80203b44:	e399                	bnez	a5,80203b4a <realloc+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:102
            // 分配失败
            return NULL;
    80203b46:	4781                	li	a5,0
    80203b48:	a8a9                	j	80203ba2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:106
        }

        // 复制原始内存数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
    80203b4a:	fe043783          	ld	a5,-32(s0)
    80203b4e:	6398                	ld	a4,0(a5)
    80203b50:	fc043783          	ld	a5,-64(s0)
    80203b54:	00f77363          	bgeu	a4,a5,80203b5a <realloc+0x78>
    80203b58:	87ba                	mv	a5,a4
    80203b5a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107
        for (uint64_t i = 0; i < copy_size; ++i) {
    80203b5e:	fe043423          	sd	zero,-24(s0)
    80203b62:	a025                	j	80203b8a <realloc+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:108 (discriminator 3)
            *((char*)new_ptr + i) = *((char*)ptr + i);
    80203b64:	fc843703          	ld	a4,-56(s0)
    80203b68:	fe843783          	ld	a5,-24(s0)
    80203b6c:	973e                	add	a4,a4,a5
    80203b6e:	fd843683          	ld	a3,-40(s0)
    80203b72:	fe843783          	ld	a5,-24(s0)
    80203b76:	97b6                	add	a5,a5,a3
    80203b78:	00074703          	lbu	a4,0(a4) # 800000 <n+0x7fffe0>
    80203b7c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107 (discriminator 3)
        for (uint64_t i = 0; i < copy_size; ++i) {
    80203b80:	fe843783          	ld	a5,-24(s0)
    80203b84:	0785                	addi	a5,a5,1
    80203b86:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:107 (discriminator 1)
    80203b8a:	fe843703          	ld	a4,-24(s0)
    80203b8e:	fd043783          	ld	a5,-48(s0)
    80203b92:	fcf769e3          	bltu	a4,a5,80203b64 <realloc+0x82>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:112
        }

        // 释放原始内存块
        free(ptr);
    80203b96:	fc843503          	ld	a0,-56(s0)
    80203b9a:	e89ff0ef          	jal	ra,80203a22 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:113
        return new_ptr;
    80203b9e:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_address/kernel_heap.c:115
    }
}
    80203ba2:	853e                	mv	a0,a5
    80203ba4:	70e2                	ld	ra,56(sp)
    80203ba6:	7442                	ld	s0,48(sp)
    80203ba8:	6121                	addi	sp,sp,64
    80203baa:	8082                	ret

0000000080203bac <w_satp>:
w_satp():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:154

#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64_t)pagetable) >> 12))

// supervisor address translation and protection;
// holds the address of the page table.
static inline void w_satp(uint64_t x) {
    80203bac:	1101                	addi	sp,sp,-32
    80203bae:	ec22                	sd	s0,24(sp)
    80203bb0:	1000                	addi	s0,sp,32
    80203bb2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:155
  asm volatile("csrw satp, %0" : : "r"(x));
    80203bb6:	fe843783          	ld	a5,-24(s0)
    80203bba:	18079073          	csrw	satp,a5
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:156
}
    80203bbe:	0001                	nop
    80203bc0:	6462                	ld	s0,24(sp)
    80203bc2:	6105                	addi	sp,sp,32
    80203bc4:	8082                	ret

0000000080203bc6 <sfence_vma>:
sfence_vma():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:240
  asm volatile("mv %0, ra" : "=r"(x));
  return x;
}

// flush the TLB.
static inline void sfence_vma() {
    80203bc6:	1141                	addi	sp,sp,-16
    80203bc8:	e422                	sd	s0,8(sp)
    80203bca:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:242
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80203bcc:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:243
}
    80203bd0:	0001                	nop
    80203bd2:	6422                	ld	s0,8(sp)
    80203bd4:	0141                	addi	sp,sp,16
    80203bd6:	8082                	ret

0000000080203bd8 <map_area_from_another>:
map_area_from_another():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:6
#include "elfparse.h"
#include "mem.h"
#include "riscv.h"
#include "string.h"
#include "debug.h"
static void map_area_from_another(MapArea *map_area, MapArea *another) {
    80203bd8:	1101                	addi	sp,sp,-32
    80203bda:	ec22                	sd	s0,24(sp)
    80203bdc:	1000                	addi	s0,sp,32
    80203bde:	fea43423          	sd	a0,-24(s0)
    80203be2:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:7
  map_area->vpn_range.l = another->vpn_range.l;
    80203be6:	fe043783          	ld	a5,-32(s0)
    80203bea:	6398                	ld	a4,0(a5)
    80203bec:	fe843783          	ld	a5,-24(s0)
    80203bf0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:8
  map_area->vpn_range.r = another->vpn_range.r;
    80203bf2:	fe043783          	ld	a5,-32(s0)
    80203bf6:	6798                	ld	a4,8(a5)
    80203bf8:	fe843783          	ld	a5,-24(s0)
    80203bfc:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:9
  map_area->map_type = another->map_type;
    80203bfe:	fe043783          	ld	a5,-32(s0)
    80203c02:	0107c703          	lbu	a4,16(a5)
    80203c06:	fe843783          	ld	a5,-24(s0)
    80203c0a:	00e78823          	sb	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:10
  map_area->map_perm = another->map_perm;
    80203c0e:	fe043783          	ld	a5,-32(s0)
    80203c12:	0117c703          	lbu	a4,17(a5)
    80203c16:	fe843783          	ld	a5,-24(s0)
    80203c1a:	00e788a3          	sb	a4,17(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:11
}
    80203c1e:	0001                	nop
    80203c20:	6462                	ld	s0,24(sp)
    80203c22:	6105                	addi	sp,sp,32
    80203c24:	8082                	ret

0000000080203c26 <map_area_map_one>:
map_area_map_one():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:14

static void map_area_map_one(MapArea *map_area, PageTable *pt,
                             VirtPageNum vpn) {
    80203c26:	7139                	addi	sp,sp,-64
    80203c28:	fc06                	sd	ra,56(sp)
    80203c2a:	f822                	sd	s0,48(sp)
    80203c2c:	0080                	addi	s0,sp,64
    80203c2e:	fca43c23          	sd	a0,-40(s0)
    80203c32:	fcb43823          	sd	a1,-48(s0)
    80203c36:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:16
  PhysPageNum ppn;
  if (map_area->map_type == MAP_IDENTICAL) {
    80203c3a:	fd843783          	ld	a5,-40(s0)
    80203c3e:	0107c783          	lbu	a5,16(a5)
    80203c42:	e791                	bnez	a5,80203c4e <map_area_map_one+0x28>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:17
    ppn = (PhysPageNum)vpn;
    80203c44:	fc843783          	ld	a5,-56(s0)
    80203c48:	fef43023          	sd	a5,-32(s0)
    80203c4c:	a031                	j	80203c58 <map_area_map_one+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:19
  } else {
    ppn = frame_alloc();
    80203c4e:	032010ef          	jal	ra,80204c80 <frame_alloc>
    80203c52:	87aa                	mv	a5,a0
    80203c54:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:21
  }
  PTEFlags pte_flags = (PTEFlags)(map_area->map_perm);
    80203c58:	fd843783          	ld	a5,-40(s0)
    80203c5c:	0117c783          	lbu	a5,17(a5)
    80203c60:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:22
  page_table_map(pt, vpn, ppn, pte_flags);
    80203c64:	fe043783          	ld	a5,-32(s0)
    80203c68:	fef44703          	lbu	a4,-17(s0)
    80203c6c:	86ba                	mv	a3,a4
    80203c6e:	863e                	mv	a2,a5
    80203c70:	fc843583          	ld	a1,-56(s0)
    80203c74:	fd043503          	ld	a0,-48(s0)
    80203c78:	492010ef          	jal	ra,8020510a <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:23
  vector_push(&pt->frames, &ppn);
    80203c7c:	fd043783          	ld	a5,-48(s0)
    80203c80:	07a1                	addi	a5,a5,8
    80203c82:	fe040713          	addi	a4,s0,-32
    80203c86:	85ba                	mv	a1,a4
    80203c88:	853e                	mv	a0,a5
    80203c8a:	066040ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:24
}
    80203c8e:	0001                	nop
    80203c90:	70e2                	ld	ra,56(sp)
    80203c92:	7442                	ld	s0,48(sp)
    80203c94:	6121                	addi	sp,sp,64
    80203c96:	8082                	ret

0000000080203c98 <map_area_unmap_one>:
map_area_unmap_one():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:27

static void map_area_unmap_one(MapArea *map_area, PageTable *pt,
                               VirtPageNum vpn, bool dealloc) {
    80203c98:	7139                	addi	sp,sp,-64
    80203c9a:	fc06                	sd	ra,56(sp)
    80203c9c:	f822                	sd	s0,48(sp)
    80203c9e:	0080                	addi	s0,sp,64
    80203ca0:	fca43c23          	sd	a0,-40(s0)
    80203ca4:	fcb43823          	sd	a1,-48(s0)
    80203ca8:	fcc43423          	sd	a2,-56(s0)
    80203cac:	87b6                	mv	a5,a3
    80203cae:	fcf42223          	sw	a5,-60(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:28
  PhysPageNum ppn = pte_ppn(*page_table_translate(pt, vpn));
    80203cb2:	fc843583          	ld	a1,-56(s0)
    80203cb6:	fd043503          	ld	a0,-48(s0)
    80203cba:	512010ef          	jal	ra,802051cc <page_table_translate>
    80203cbe:	87aa                	mv	a5,a0
    80203cc0:	639c                	ld	a5,0(a5)
    80203cc2:	00a7d713          	srli	a4,a5,0xa
    80203cc6:	57fd                	li	a5,-1
    80203cc8:	83d1                	srli	a5,a5,0x14
    80203cca:	8ff9                	and	a5,a5,a4
    80203ccc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:29
  page_table_unmap(pt, vpn);
    80203cd0:	fc843583          	ld	a1,-56(s0)
    80203cd4:	fd043503          	ld	a0,-48(s0)
    80203cd8:	4a0010ef          	jal	ra,80205178 <page_table_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:30
  if (dealloc) {
    80203cdc:	fc442783          	lw	a5,-60(s0)
    80203ce0:	2781                	sext.w	a5,a5
    80203ce2:	c789                	beqz	a5,80203cec <map_area_unmap_one+0x54>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:31
    frame_dealloc(ppn);
    80203ce4:	fe843503          	ld	a0,-24(s0)
    80203ce8:	04c010ef          	jal	ra,80204d34 <frame_dealloc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:33
  }
}
    80203cec:	0001                	nop
    80203cee:	70e2                	ld	ra,56(sp)
    80203cf0:	7442                	ld	s0,48(sp)
    80203cf2:	6121                	addi	sp,sp,64
    80203cf4:	8082                	ret

0000000080203cf6 <map_area_map>:
map_area_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:35

static void map_area_map(MapArea *map_area, PageTable *pt) {
    80203cf6:	7179                	addi	sp,sp,-48
    80203cf8:	f406                	sd	ra,40(sp)
    80203cfa:	f022                	sd	s0,32(sp)
    80203cfc:	1800                	addi	s0,sp,48
    80203cfe:	fca43c23          	sd	a0,-40(s0)
    80203d02:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:36
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d06:	fd843783          	ld	a5,-40(s0)
    80203d0a:	639c                	ld	a5,0(a5)
    80203d0c:	fef43423          	sd	a5,-24(s0)
    80203d10:	a831                	j	80203d2c <map_area_map+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:38
       vpn++) {
    map_area_map_one(map_area, pt, vpn);
    80203d12:	fe843603          	ld	a2,-24(s0)
    80203d16:	fd043583          	ld	a1,-48(s0)
    80203d1a:	fd843503          	ld	a0,-40(s0)
    80203d1e:	f09ff0ef          	jal	ra,80203c26 <map_area_map_one>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:37
       vpn++) {
    80203d22:	fe843783          	ld	a5,-24(s0)
    80203d26:	0785                	addi	a5,a5,1
    80203d28:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:36 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d2c:	fd843783          	ld	a5,-40(s0)
    80203d30:	679c                	ld	a5,8(a5)
    80203d32:	fe843703          	ld	a4,-24(s0)
    80203d36:	fcf76ee3          	bltu	a4,a5,80203d12 <map_area_map+0x1c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:40
  }
}
    80203d3a:	0001                	nop
    80203d3c:	0001                	nop
    80203d3e:	70a2                	ld	ra,40(sp)
    80203d40:	7402                	ld	s0,32(sp)
    80203d42:	6145                	addi	sp,sp,48
    80203d44:	8082                	ret

0000000080203d46 <map_area_unmap>:
map_area_unmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:42

static void map_area_unmap(MapArea *map_area, PageTable *pt, bool dealloc) {
    80203d46:	7139                	addi	sp,sp,-64
    80203d48:	fc06                	sd	ra,56(sp)
    80203d4a:	f822                	sd	s0,48(sp)
    80203d4c:	0080                	addi	s0,sp,64
    80203d4e:	fca43c23          	sd	a0,-40(s0)
    80203d52:	fcb43823          	sd	a1,-48(s0)
    80203d56:	87b2                	mv	a5,a2
    80203d58:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:43
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d5c:	fd843783          	ld	a5,-40(s0)
    80203d60:	639c                	ld	a5,0(a5)
    80203d62:	fef43423          	sd	a5,-24(s0)
    80203d66:	a00d                	j	80203d88 <map_area_unmap+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:45
       vpn++) {
    map_area_unmap_one(map_area, pt, vpn, dealloc);
    80203d68:	fcc42783          	lw	a5,-52(s0)
    80203d6c:	86be                	mv	a3,a5
    80203d6e:	fe843603          	ld	a2,-24(s0)
    80203d72:	fd043583          	ld	a1,-48(s0)
    80203d76:	fd843503          	ld	a0,-40(s0)
    80203d7a:	f1fff0ef          	jal	ra,80203c98 <map_area_unmap_one>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:44
       vpn++) {
    80203d7e:	fe843783          	ld	a5,-24(s0)
    80203d82:	0785                	addi	a5,a5,1
    80203d84:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:43 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80203d88:	fd843783          	ld	a5,-40(s0)
    80203d8c:	679c                	ld	a5,8(a5)
    80203d8e:	fe843703          	ld	a4,-24(s0)
    80203d92:	fcf76be3          	bltu	a4,a5,80203d68 <map_area_unmap+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:47
  }
}
    80203d96:	0001                	nop
    80203d98:	0001                	nop
    80203d9a:	70e2                	ld	ra,56(sp)
    80203d9c:	7442                	ld	s0,48(sp)
    80203d9e:	6121                	addi	sp,sp,64
    80203da0:	8082                	ret

0000000080203da2 <map_area_copy_data>:
map_area_copy_data():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:50

static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len) {
    80203da2:	711d                	addi	sp,sp,-96
    80203da4:	ec86                	sd	ra,88(sp)
    80203da6:	e8a2                	sd	s0,80(sp)
    80203da8:	1080                	addi	s0,sp,96
    80203daa:	faa43c23          	sd	a0,-72(s0)
    80203dae:	fab43823          	sd	a1,-80(s0)
    80203db2:	fac43423          	sd	a2,-88(s0)
    80203db6:	fad43023          	sd	a3,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:51
  uint64_t start = 0;
    80203dba:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:52
  VirtPageNum current_vpn = map_area->vpn_range.l;
    80203dbe:	fb843783          	ld	a5,-72(s0)
    80203dc2:	639c                	ld	a5,0(a5)
    80203dc4:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:54
  for (;;) {
    uint8_t *src = &data[start];
    80203dc8:	fa843703          	ld	a4,-88(s0)
    80203dcc:	fe843783          	ld	a5,-24(s0)
    80203dd0:	97ba                	add	a5,a5,a4
    80203dd2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:56
    uint8_t *dst =
        ppn_get_bytes_array(pte_ppn(*page_table_translate(pt, current_vpn)));
    80203dd6:	fe043583          	ld	a1,-32(s0)
    80203dda:	fb043503          	ld	a0,-80(s0)
    80203dde:	3ee010ef          	jal	ra,802051cc <page_table_translate>
    80203de2:	87aa                	mv	a5,a0
    80203de4:	639c                	ld	a5,0(a5)
    80203de6:	00a7d713          	srli	a4,a5,0xa
    80203dea:	57fd                	li	a5,-1
    80203dec:	83d1                	srli	a5,a5,0x14
    80203dee:	8ff9                	and	a5,a5,a4
    80203df0:	853e                	mv	a0,a5
    80203df2:	607000ef          	jal	ra,80204bf8 <ppn_get_bytes_array>
    80203df6:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:57
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    80203dfa:	fa043703          	ld	a4,-96(s0)
    80203dfe:	fe843783          	ld	a5,-24(s0)
    80203e02:	40f707b3          	sub	a5,a4,a5
    80203e06:	6705                	lui	a4,0x1
    80203e08:	00f77363          	bgeu	a4,a5,80203e0e <map_area_copy_data+0x6c>
    80203e0c:	6785                	lui	a5,0x1
    80203e0e:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:58
    memcpy(dst, src, cpy_len);
    80203e12:	fc843783          	ld	a5,-56(s0)
    80203e16:	2781                	sext.w	a5,a5
    80203e18:	863e                	mv	a2,a5
    80203e1a:	fd843583          	ld	a1,-40(s0)
    80203e1e:	fd043503          	ld	a0,-48(s0)
    80203e22:	933ff0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:59
    start += PAGE_SIZE;
    80203e26:	fe843703          	ld	a4,-24(s0)
    80203e2a:	6785                	lui	a5,0x1
    80203e2c:	97ba                	add	a5,a5,a4
    80203e2e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:60
    if (start >= len) {
    80203e32:	fe843703          	ld	a4,-24(s0)
    80203e36:	fa043783          	ld	a5,-96(s0)
    80203e3a:	00f77863          	bgeu	a4,a5,80203e4a <map_area_copy_data+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:63
      break;
    }
    current_vpn += 1;
    80203e3e:	fe043783          	ld	a5,-32(s0)
    80203e42:	0785                	addi	a5,a5,1
    80203e44:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:53
  for (;;) {
    80203e48:	b741                	j	80203dc8 <map_area_copy_data+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:61
      break;
    80203e4a:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:65
  }
}
    80203e4c:	0001                	nop
    80203e4e:	60e6                	ld	ra,88(sp)
    80203e50:	6446                	ld	s0,80(sp)
    80203e52:	6125                	addi	sp,sp,96
    80203e54:	8082                	ret

0000000080203e56 <memory_set_new_bare>:
memory_set_new_bare():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:67

static void memory_set_new_bare(MemorySet *memory_set) {
    80203e56:	1101                	addi	sp,sp,-32
    80203e58:	ec06                	sd	ra,24(sp)
    80203e5a:	e822                	sd	s0,16(sp)
    80203e5c:	1000                	addi	s0,sp,32
    80203e5e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:68
  page_table_new(&memory_set->page_table);
    80203e62:	fe843783          	ld	a5,-24(s0)
    80203e66:	853e                	mv	a0,a5
    80203e68:	03c010ef          	jal	ra,80204ea4 <page_table_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:69
  vector_new(&memory_set->areas, sizeof(MapArea));
    80203e6c:	fe843783          	ld	a5,-24(s0)
    80203e70:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80203e74:	45e1                	li	a1,24
    80203e76:	853e                	mv	a0,a5
    80203e78:	627030ef          	jal	ra,80207c9e <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:70
}
    80203e7c:	0001                	nop
    80203e7e:	60e2                	ld	ra,24(sp)
    80203e80:	6442                	ld	s0,16(sp)
    80203e82:	6105                	addi	sp,sp,32
    80203e84:	8082                	ret

0000000080203e86 <memory_set_token>:
memory_set_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:72

uint64_t memory_set_token(MemorySet *memory_set) {
    80203e86:	1101                	addi	sp,sp,-32
    80203e88:	ec06                	sd	ra,24(sp)
    80203e8a:	e822                	sd	s0,16(sp)
    80203e8c:	1000                	addi	s0,sp,32
    80203e8e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:73
  return page_table_token(&memory_set->page_table);
    80203e92:	fe843783          	ld	a5,-24(s0)
    80203e96:	853e                	mv	a0,a5
    80203e98:	380010ef          	jal	ra,80205218 <page_table_token>
    80203e9c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:74
}
    80203e9e:	853e                	mv	a0,a5
    80203ea0:	60e2                	ld	ra,24(sp)
    80203ea2:	6442                	ld	s0,16(sp)
    80203ea4:	6105                	addi	sp,sp,32
    80203ea6:	8082                	ret

0000000080203ea8 <memory_set_push>:
memory_set_push():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:77

static void memory_set_push(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len) {
    80203ea8:	7179                	addi	sp,sp,-48
    80203eaa:	f406                	sd	ra,40(sp)
    80203eac:	f022                	sd	s0,32(sp)
    80203eae:	1800                	addi	s0,sp,48
    80203eb0:	fea43423          	sd	a0,-24(s0)
    80203eb4:	feb43023          	sd	a1,-32(s0)
    80203eb8:	fcc43c23          	sd	a2,-40(s0)
    80203ebc:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:78
  map_area_map(map_area, &memory_set->page_table);
    80203ec0:	fe843783          	ld	a5,-24(s0)
    80203ec4:	85be                	mv	a1,a5
    80203ec6:	fe043503          	ld	a0,-32(s0)
    80203eca:	e2dff0ef          	jal	ra,80203cf6 <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:79
  if (data && len >= 0) {
    80203ece:	fd843783          	ld	a5,-40(s0)
    80203ed2:	cf81                	beqz	a5,80203eea <memory_set_push+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:80
    map_area_copy_data(map_area, &memory_set->page_table, data, len);
    80203ed4:	fe843783          	ld	a5,-24(s0)
    80203ed8:	fd043683          	ld	a3,-48(s0)
    80203edc:	fd843603          	ld	a2,-40(s0)
    80203ee0:	85be                	mv	a1,a5
    80203ee2:	fe043503          	ld	a0,-32(s0)
    80203ee6:	ebdff0ef          	jal	ra,80203da2 <map_area_copy_data>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:82
  }
  vector_push(&memory_set->areas, map_area);
    80203eea:	fe843783          	ld	a5,-24(s0)
    80203eee:	02878793          	addi	a5,a5,40
    80203ef2:	fe043583          	ld	a1,-32(s0)
    80203ef6:	853e                	mv	a0,a5
    80203ef8:	5f9030ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:83
}
    80203efc:	0001                	nop
    80203efe:	70a2                	ld	ra,40(sp)
    80203f00:	7402                	ld	s0,32(sp)
    80203f02:	6145                	addi	sp,sp,48
    80203f04:	8082                	ret

0000000080203f06 <memory_set_insert_framed_area>:
memory_set_insert_framed_area():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:88

// Assume that no conflicts.
static void memory_set_insert_framed_area(MemorySet *memory_set,
                                          VirtAddr start_va, VirtAddr end_va,
                                          MapPermission permission) {
    80203f06:	715d                	addi	sp,sp,-80
    80203f08:	e486                	sd	ra,72(sp)
    80203f0a:	e0a2                	sd	s0,64(sp)
    80203f0c:	0880                	addi	s0,sp,80
    80203f0e:	fca43423          	sd	a0,-56(s0)
    80203f12:	fcb43023          	sd	a1,-64(s0)
    80203f16:	fac43c23          	sd	a2,-72(s0)
    80203f1a:	87b6                	mv	a5,a3
    80203f1c:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:90
  MapArea map_area;
  map_area.vpn_range.l = page_floor(start_va);
    80203f20:	fc043783          	ld	a5,-64(s0)
    80203f24:	83b1                	srli	a5,a5,0xc
    80203f26:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:91
  map_area.vpn_range.r = page_ceil(end_va);
    80203f2a:	fb843703          	ld	a4,-72(s0)
    80203f2e:	6785                	lui	a5,0x1
    80203f30:	17fd                	addi	a5,a5,-1
    80203f32:	97ba                	add	a5,a5,a4
    80203f34:	83b1                	srli	a5,a5,0xc
    80203f36:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:92
  map_area.map_type = MAP_FRAMED;
    80203f3a:	4785                	li	a5,1
    80203f3c:	fef40423          	sb	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:93
  map_area.map_perm = permission;
    80203f40:	fb744783          	lbu	a5,-73(s0)
    80203f44:	fef404a3          	sb	a5,-23(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:94
  memory_set_push(memory_set, &map_area, NULL, 0);
    80203f48:	fd840793          	addi	a5,s0,-40
    80203f4c:	4681                	li	a3,0
    80203f4e:	4601                	li	a2,0
    80203f50:	85be                	mv	a1,a5
    80203f52:	fc843503          	ld	a0,-56(s0)
    80203f56:	f53ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:95
}
    80203f5a:	0001                	nop
    80203f5c:	60a6                	ld	ra,72(sp)
    80203f5e:	6406                	ld	s0,64(sp)
    80203f60:	6161                	addi	sp,sp,80
    80203f62:	8082                	ret

0000000080203f64 <memory_set_remove_area_with_start_vpn>:
memory_set_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:98

static void memory_set_remove_area_with_start_vpn(MemorySet *memory_set,
                                                  VirtPageNum start_vpn) {
    80203f64:	7179                	addi	sp,sp,-48
    80203f66:	f406                	sd	ra,40(sp)
    80203f68:	f022                	sd	s0,32(sp)
    80203f6a:	1800                	addi	s0,sp,48
    80203f6c:	fca43c23          	sd	a0,-40(s0)
    80203f70:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:99
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    80203f74:	fd843783          	ld	a5,-40(s0)
    80203f78:	63bc                	ld	a5,64(a5)
    80203f7a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:100
  uint64_t i = 0;
    80203f7e:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:101
  while (i < memory_set->areas.size) {
    80203f82:	a085                	j	80203fe2 <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:102
    if (x[i].vpn_range.l == start_vpn) {
    80203f84:	fe843703          	ld	a4,-24(s0)
    80203f88:	87ba                	mv	a5,a4
    80203f8a:	0786                	slli	a5,a5,0x1
    80203f8c:	97ba                	add	a5,a5,a4
    80203f8e:	078e                	slli	a5,a5,0x3
    80203f90:	873e                	mv	a4,a5
    80203f92:	fe043783          	ld	a5,-32(s0)
    80203f96:	97ba                	add	a5,a5,a4
    80203f98:	639c                	ld	a5,0(a5)
    80203f9a:	fd043703          	ld	a4,-48(s0)
    80203f9e:	02f71d63          	bne	a4,a5,80203fd8 <memory_set_remove_area_with_start_vpn+0x74>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:103
      map_area_unmap(&x[i], &memory_set->page_table, true);
    80203fa2:	fe843703          	ld	a4,-24(s0)
    80203fa6:	87ba                	mv	a5,a4
    80203fa8:	0786                	slli	a5,a5,0x1
    80203faa:	97ba                	add	a5,a5,a4
    80203fac:	078e                	slli	a5,a5,0x3
    80203fae:	873e                	mv	a4,a5
    80203fb0:	fe043783          	ld	a5,-32(s0)
    80203fb4:	97ba                	add	a5,a5,a4
    80203fb6:	fd843703          	ld	a4,-40(s0)
    80203fba:	4605                	li	a2,1
    80203fbc:	85ba                	mv	a1,a4
    80203fbe:	853e                	mv	a0,a5
    80203fc0:	d87ff0ef          	jal	ra,80203d46 <map_area_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:104
      vector_remove(&memory_set->areas, i);
    80203fc4:	fd843783          	ld	a5,-40(s0)
    80203fc8:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80203fcc:	fe843583          	ld	a1,-24(s0)
    80203fd0:	853e                	mv	a0,a5
    80203fd2:	6c3030ef          	jal	ra,80207e94 <vector_remove>
    80203fd6:	a031                	j	80203fe2 <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:106
    } else {
      i++;
    80203fd8:	fe843783          	ld	a5,-24(s0)
    80203fdc:	0785                	addi	a5,a5,1
    80203fde:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:101
  while (i < memory_set->areas.size) {
    80203fe2:	fd843783          	ld	a5,-40(s0)
    80203fe6:	779c                	ld	a5,40(a5)
    80203fe8:	fe843703          	ld	a4,-24(s0)
    80203fec:	f8f76ce3          	bltu	a4,a5,80203f84 <memory_set_remove_area_with_start_vpn+0x20>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:109
    }
  }
}
    80203ff0:	0001                	nop
    80203ff2:	0001                	nop
    80203ff4:	70a2                	ld	ra,40(sp)
    80203ff6:	7402                	ld	s0,32(sp)
    80203ff8:	6145                	addi	sp,sp,48
    80203ffa:	8082                	ret

0000000080203ffc <memory_set_free>:
memory_set_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:111

void memory_set_free(MemorySet *memory_set) {
    80203ffc:	7179                	addi	sp,sp,-48
    80203ffe:	f406                	sd	ra,40(sp)
    80204000:	f022                	sd	s0,32(sp)
    80204002:	1800                	addi	s0,sp,48
    80204004:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:112
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    80204008:	fd843783          	ld	a5,-40(s0)
    8020400c:	63bc                	ld	a5,64(a5)
    8020400e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113
  for (uint64_t i = 0; i < memory_set->areas.size; i++) {
    80204012:	fe043423          	sd	zero,-24(s0)
    80204016:	a03d                	j	80204044 <memory_set_free+0x48>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:114 (discriminator 3)
    map_area_unmap(&x[i], &memory_set->page_table, false);
    80204018:	fe843703          	ld	a4,-24(s0)
    8020401c:	87ba                	mv	a5,a4
    8020401e:	0786                	slli	a5,a5,0x1
    80204020:	97ba                	add	a5,a5,a4
    80204022:	078e                	slli	a5,a5,0x3
    80204024:	873e                	mv	a4,a5
    80204026:	fe043783          	ld	a5,-32(s0)
    8020402a:	97ba                	add	a5,a5,a4
    8020402c:	fd843703          	ld	a4,-40(s0)
    80204030:	4601                	li	a2,0
    80204032:	85ba                	mv	a1,a4
    80204034:	853e                	mv	a0,a5
    80204036:	d11ff0ef          	jal	ra,80203d46 <map_area_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113 (discriminator 3)
  for (uint64_t i = 0; i < memory_set->areas.size; i++) {
    8020403a:	fe843783          	ld	a5,-24(s0)
    8020403e:	0785                	addi	a5,a5,1
    80204040:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:113 (discriminator 1)
    80204044:	fd843783          	ld	a5,-40(s0)
    80204048:	779c                	ld	a5,40(a5)
    8020404a:	fe843703          	ld	a4,-24(s0)
    8020404e:	fcf765e3          	bltu	a4,a5,80204018 <memory_set_free+0x1c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:116
  }
  vector_free(&memory_set->areas);
    80204052:	fd843783          	ld	a5,-40(s0)
    80204056:	02878793          	addi	a5,a5,40
    8020405a:	853e                	mv	a0,a5
    8020405c:	617030ef          	jal	ra,80207e72 <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:117
  page_table_free(&memory_set->page_table);
    80204060:	fd843783          	ld	a5,-40(s0)
    80204064:	853e                	mv	a0,a5
    80204066:	689000ef          	jal	ra,80204eee <page_table_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:118
}
    8020406a:	0001                	nop
    8020406c:	70a2                	ld	ra,40(sp)
    8020406e:	7402                	ld	s0,32(sp)
    80204070:	6145                	addi	sp,sp,48
    80204072:	8082                	ret

0000000080204074 <memory_set_map_trampoline>:
memory_set_map_trampoline():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:132
extern uint8_t ebss;
extern uint8_t ekernel;
extern uint8_t strampoline;

// Mention that trampoline is not collected by areas.
static inline void memory_set_map_trampoline(MemorySet *memory_set) {
    80204074:	1101                	addi	sp,sp,-32
    80204076:	ec06                	sd	ra,24(sp)
    80204078:	e822                	sd	s0,16(sp)
    8020407a:	1000                	addi	s0,sp,32
    8020407c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:133
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    80204080:	fe843703          	ld	a4,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:134
                 addr2pn((PhysAddr)&strampoline), PTE_R | PTE_X);
    80204084:	ffffd797          	auipc	a5,0xffffd
    80204088:	f7c78793          	addi	a5,a5,-132 # 80201000 <__alltraps>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:133
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    8020408c:	83b1                	srli	a5,a5,0xc
    8020408e:	46a9                	li	a3,10
    80204090:	863e                	mv	a2,a5
    80204092:	57fd                	li	a5,-1
    80204094:	00c7d593          	srli	a1,a5,0xc
    80204098:	853a                	mv	a0,a4
    8020409a:	070010ef          	jal	ra,8020510a <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:135
}
    8020409e:	0001                	nop
    802040a0:	60e2                	ld	ra,24(sp)
    802040a2:	6442                	ld	s0,16(sp)
    802040a4:	6105                	addi	sp,sp,32
    802040a6:	8082                	ret

00000000802040a8 <memory_set_new_kernel>:
memory_set_new_kernel():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:138

static MemorySet KERNEL_SPACE;
static void memory_set_new_kernel() {
    802040a8:	7179                	addi	sp,sp,-48
    802040aa:	f406                	sd	ra,40(sp)
    802040ac:	f022                	sd	s0,32(sp)
    802040ae:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:139
  MemorySet *memory_set = &KERNEL_SPACE;
    802040b0:	00821797          	auipc	a5,0x821
    802040b4:	f5878793          	addi	a5,a5,-168 # 80a25008 <KERNEL_SPACE>
    802040b8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:140
  memory_set_new_bare(memory_set);
    802040bc:	fe843503          	ld	a0,-24(s0)
    802040c0:	d97ff0ef          	jal	ra,80203e56 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:143

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802040c4:	fe843503          	ld	a0,-24(s0)
    802040c8:	fadff0ef          	jal	ra,80204074 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:154
  // info("boot_stack [0x%llx, 0x%llx)\n", &sbss_with_stack, &ebss);

  MapArea map_area;

  // info("mapping .text section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&stext);
    802040cc:	ffffc797          	auipc	a5,0xffffc
    802040d0:	f3478793          	addi	a5,a5,-204 # 80200000 <_start>
    802040d4:	83b1                	srli	a5,a5,0xc
    802040d6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:155
  map_area.vpn_range.r = page_ceil((PhysAddr)&etext);
    802040da:	00004717          	auipc	a4,0x4
    802040de:	f2670713          	addi	a4,a4,-218 # 80208000 <etext>
    802040e2:	6785                	lui	a5,0x1
    802040e4:	17fd                	addi	a5,a5,-1
    802040e6:	97ba                	add	a5,a5,a4
    802040e8:	83b1                	srli	a5,a5,0xc
    802040ea:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:156
  map_area.map_type = MAP_IDENTICAL;
    802040ee:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:157
  map_area.map_perm = MAP_PERM_R | MAP_PERM_X;
    802040f2:	47a9                	li	a5,10
    802040f4:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:158
  memory_set_push(memory_set, &map_area, NULL, 0);
    802040f8:	fd040793          	addi	a5,s0,-48
    802040fc:	4681                	li	a3,0
    802040fe:	4601                	li	a2,0
    80204100:	85be                	mv	a1,a5
    80204102:	fe843503          	ld	a0,-24(s0)
    80204106:	da3ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:161

  // info("mapping .rodata section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&srodata);
    8020410a:	00004797          	auipc	a5,0x4
    8020410e:	ef678793          	addi	a5,a5,-266 # 80208000 <etext>
    80204112:	83b1                	srli	a5,a5,0xc
    80204114:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:162
  map_area.vpn_range.r = page_ceil((PhysAddr)&erodata);
    80204118:	00005717          	auipc	a4,0x5
    8020411c:	ee870713          	addi	a4,a4,-280 # 80209000 <app_starts.1>
    80204120:	6785                	lui	a5,0x1
    80204122:	17fd                	addi	a5,a5,-1
    80204124:	97ba                	add	a5,a5,a4
    80204126:	83b1                	srli	a5,a5,0xc
    80204128:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:163
  map_area.map_type = MAP_IDENTICAL;
    8020412c:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:164
  map_area.map_perm = MAP_PERM_R;
    80204130:	4789                	li	a5,2
    80204132:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:165
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204136:	fd040793          	addi	a5,s0,-48
    8020413a:	4681                	li	a3,0
    8020413c:	4601                	li	a2,0
    8020413e:	85be                	mv	a1,a5
    80204140:	fe843503          	ld	a0,-24(s0)
    80204144:	d65ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:168

  // info("mapping .data section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sdata);
    80204148:	00005797          	auipc	a5,0x5
    8020414c:	eb878793          	addi	a5,a5,-328 # 80209000 <app_starts.1>
    80204150:	83b1                	srli	a5,a5,0xc
    80204152:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:169
  map_area.vpn_range.r = page_ceil((PhysAddr)&edata);
    80204156:	00011717          	auipc	a4,0x11
    8020415a:	eaa70713          	addi	a4,a4,-342 # 80215000 <boot_stack_lower_bound>
    8020415e:	6785                	lui	a5,0x1
    80204160:	17fd                	addi	a5,a5,-1
    80204162:	97ba                	add	a5,a5,a4
    80204164:	83b1                	srli	a5,a5,0xc
    80204166:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:170
  map_area.map_type = MAP_IDENTICAL;
    8020416a:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:171
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    8020416e:	4799                	li	a5,6
    80204170:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:172
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204174:	fd040793          	addi	a5,s0,-48
    80204178:	4681                	li	a3,0
    8020417a:	4601                	li	a2,0
    8020417c:	85be                	mv	a1,a5
    8020417e:	fe843503          	ld	a0,-24(s0)
    80204182:	d27ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:175

  // info("mapping .bss section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sbss_with_stack);
    80204186:	00011797          	auipc	a5,0x11
    8020418a:	e7a78793          	addi	a5,a5,-390 # 80215000 <boot_stack_lower_bound>
    8020418e:	83b1                	srli	a5,a5,0xc
    80204190:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:176
  map_area.vpn_range.r = page_ceil((PhysAddr)&ebss);
    80204194:	00b73717          	auipc	a4,0xb73
    80204198:	e6c70713          	addi	a4,a4,-404 # 80d77000 <ebss>
    8020419c:	6785                	lui	a5,0x1
    8020419e:	17fd                	addi	a5,a5,-1
    802041a0:	97ba                	add	a5,a5,a4
    802041a2:	83b1                	srli	a5,a5,0xc
    802041a4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:177
  map_area.map_type = MAP_IDENTICAL;
    802041a8:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:178
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    802041ac:	4799                	li	a5,6
    802041ae:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:179
  memory_set_push(memory_set, &map_area, NULL, 0);
    802041b2:	fd040793          	addi	a5,s0,-48
    802041b6:	4681                	li	a3,0
    802041b8:	4601                	li	a2,0
    802041ba:	85be                	mv	a1,a5
    802041bc:	fe843503          	ld	a0,-24(s0)
    802041c0:	ce9ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:182

  // info("mapping physical memory\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&ekernel);
    802041c4:	00b73797          	auipc	a5,0xb73
    802041c8:	e3c78793          	addi	a5,a5,-452 # 80d77000 <ebss>
    802041cc:	83b1                	srli	a5,a5,0xc
    802041ce:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:183
  map_area.vpn_range.r = page_ceil((PhysAddr)MEMORY_END);
    802041d2:	000817b7          	lui	a5,0x81
    802041d6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:184
  map_area.map_type = MAP_IDENTICAL;
    802041da:	fe040023          	sb	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:185
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    802041de:	4799                	li	a5,6
    802041e0:	fef400a3          	sb	a5,-31(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:186
  memory_set_push(memory_set, &map_area, NULL, 0);
    802041e4:	fd040793          	addi	a5,s0,-48
    802041e8:	4681                	li	a3,0
    802041ea:	4601                	li	a2,0
    802041ec:	85be                	mv	a1,a5
    802041ee:	fe843503          	ld	a0,-24(s0)
    802041f2:	cb7ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:187
}
    802041f6:	0001                	nop
    802041f8:	70a2                	ld	ra,40(sp)
    802041fa:	7402                	ld	s0,32(sp)
    802041fc:	6145                	addi	sp,sp,48
    802041fe:	8082                	ret

0000000080204200 <memory_set_from_elf>:
memory_set_from_elf():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:192

void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point) 
{
    80204200:	7111                	addi	sp,sp,-256
    80204202:	fd86                	sd	ra,248(sp)
    80204204:	f9a2                	sd	s0,240(sp)
    80204206:	f5a6                	sd	s1,232(sp)
    80204208:	0200                	addi	s0,sp,256
    8020420a:	81010113          	addi	sp,sp,-2032 # 80224810 <boot_stack_lower_bound+0xf810>
    8020420e:	77fd                	lui	a5,0xfffff
    80204210:	fe040493          	addi	s1,s0,-32
    80204214:	97a6                	add	a5,a5,s1
    80204216:	74a7bc23          	sd	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    8020421a:	77fd                	lui	a5,0xfffff
    8020421c:	fe040513          	addi	a0,s0,-32
    80204220:	97aa                	add	a5,a5,a0
    80204222:	74b7b823          	sd	a1,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f288750>
    80204226:	77fd                	lui	a5,0xfffff
    80204228:	fe040593          	addi	a1,s0,-32
    8020422c:	97ae                	add	a5,a5,a1
    8020422e:	74c7b423          	sd	a2,1864(a5) # fffffffffffff748 <ebss+0xffffffff7f288748>
    80204232:	77fd                	lui	a5,0xfffff
    80204234:	fe040613          	addi	a2,s0,-32
    80204238:	97b2                	add	a5,a5,a2
    8020423a:	74d7b023          	sd	a3,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f288740>
    8020423e:	77fd                	lui	a5,0xfffff
    80204240:	fe040693          	addi	a3,s0,-32
    80204244:	97b6                	add	a5,a5,a3
    80204246:	72e7bc23          	sd	a4,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f288738>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:193
  memory_set_new_bare(memory_set);
    8020424a:	77fd                	lui	a5,0xfffff
    8020424c:	fe040713          	addi	a4,s0,-32
    80204250:	97ba                	add	a5,a5,a4
    80204252:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    80204256:	c01ff0ef          	jal	ra,80203e56 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:196

  // map trampoline
  memory_set_map_trampoline(memory_set);
    8020425a:	77fd                	lui	a5,0xfffff
    8020425c:	fe040713          	addi	a4,s0,-32
    80204260:	97ba                	add	a5,a5,a4
    80204262:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    80204266:	e0fff0ef          	jal	ra,80204074 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:200

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
    8020426a:	77fd                	lui	a5,0xfffff
    8020426c:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    80204270:	fe040713          	addi	a4,s0,-32
    80204274:	00f706b3          	add	a3,a4,a5
    80204278:	77fd                	lui	a5,0xfffff
    8020427a:	fe040713          	addi	a4,s0,-32
    8020427e:	973e                	add	a4,a4,a5
    80204280:	77fd                	lui	a5,0xfffff
    80204282:	fe040613          	addi	a2,s0,-32
    80204286:	97b2                	add	a5,a5,a2
    80204288:	8636                	mv	a2,a3
    8020428a:	74873583          	ld	a1,1864(a4)
    8020428e:	7507b503          	ld	a0,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f288750>
    80204292:	ca9fe0ef          	jal	ra,80202f3a <elf_load>
    80204296:	87aa                	mv	a5,a0
    80204298:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:201
  if (elf_load_ret != 0)
    8020429c:	fcc42783          	lw	a5,-52(s0)
    802042a0:	2781                	sext.w	a5,a5
    802042a2:	cf89                	beqz	a5,802042bc <memory_set_from_elf+0xbc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:203
  {
    panic("Elf load error.\n");
    802042a4:	00004617          	auipc	a2,0x4
    802042a8:	ea460613          	addi	a2,a2,-348 # 80208148 <MMIO+0x10>
    802042ac:	0cb00593          	li	a1,203
    802042b0:	00004517          	auipc	a0,0x4
    802042b4:	eb050513          	addi	a0,a0,-336 # 80208160 <MMIO+0x28>
    802042b8:	3f2020ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:206
  }

  size_t ph_count = elf_header_get_phnum(&elf);
    802042bc:	77fd                	lui	a5,0xfffff
    802042be:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    802042c2:	fe040713          	addi	a4,s0,-32
    802042c6:	97ba                	add	a5,a5,a4
    802042c8:	853e                	mv	a0,a5
    802042ca:	e41fe0ef          	jal	ra,8020310a <elf_header_get_phnum>
    802042ce:	fca43023          	sd	a0,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:211
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn = 0;
    802042d2:	fc043c23          	sd	zero,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212
  for (size_t i = 0; i < ph_count; i++) {
    802042d6:	fc043823          	sd	zero,-48(s0)
    802042da:	a261                	j	80204462 <memory_set_from_elf+0x262>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:213
    t_elf_program *ph = &elf.programs[i];
    802042dc:	77fd                	lui	a5,0xfffff
    802042de:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    802042e2:	fe040713          	addi	a4,s0,-32
    802042e6:	973e                	add	a4,a4,a5
    802042e8:	fd043783          	ld	a5,-48(s0)
    802042ec:	04278793          	addi	a5,a5,66
    802042f0:	0792                	slli	a5,a5,0x4
    802042f2:	97ba                	add	a5,a5,a4
    802042f4:	07a1                	addi	a5,a5,8
    802042f6:	faf43023          	sd	a5,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:214
    if (elf_program_get_type(&elf, ph) == PT_LOAD) {
    802042fa:	77fd                	lui	a5,0xfffff
    802042fc:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    80204300:	fe040713          	addi	a4,s0,-32
    80204304:	97ba                	add	a5,a5,a4
    80204306:	fa043583          	ld	a1,-96(s0)
    8020430a:	853e                	mv	a0,a5
    8020430c:	969fe0ef          	jal	ra,80202c74 <elf_program_get_type>
    80204310:	87aa                	mv	a5,a0
    80204312:	2781                	sext.w	a5,a5
    80204314:	873e                	mv	a4,a5
    80204316:	4785                	li	a5,1
    80204318:	14f71063          	bne	a4,a5,80204458 <memory_set_from_elf+0x258>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:215
      start_va = (VirtAddr)elf_program_get_vaddr(&elf, ph);
    8020431c:	77fd                	lui	a5,0xfffff
    8020431e:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    80204322:	fe040713          	addi	a4,s0,-32
    80204326:	97ba                	add	a5,a5,a4
    80204328:	fa043583          	ld	a1,-96(s0)
    8020432c:	853e                	mv	a0,a5
    8020432e:	a1ffe0ef          	jal	ra,80202d4c <elf_program_get_vaddr>
    80204332:	f8a43c23          	sd	a0,-104(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:216
      end_va = (VirtAddr)(start_va + elf_program_get_memsz(&elf, ph));
    80204336:	77fd                	lui	a5,0xfffff
    80204338:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    8020433c:	fe040713          	addi	a4,s0,-32
    80204340:	97ba                	add	a5,a5,a4
    80204342:	fa043583          	ld	a1,-96(s0)
    80204346:	853e                	mv	a0,a5
    80204348:	a4dfe0ef          	jal	ra,80202d94 <elf_program_get_memsz>
    8020434c:	872a                	mv	a4,a0
    8020434e:	f9843783          	ld	a5,-104(s0)
    80204352:	97ba                	add	a5,a5,a4
    80204354:	f8f43823          	sd	a5,-112(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:217
      map_perm = MAP_PERM_U;
    80204358:	47c1                	li	a5,16
    8020435a:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:218
      ph_flags = elf_program_get_flags(&elf, ph);
    8020435e:	77fd                	lui	a5,0xfffff
    80204360:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    80204364:	fe040713          	addi	a4,s0,-32
    80204368:	97ba                	add	a5,a5,a4
    8020436a:	fa043583          	ld	a1,-96(s0)
    8020436e:	853e                	mv	a0,a5
    80204370:	991fe0ef          	jal	ra,80202d00 <elf_program_get_flags>
    80204374:	f8a43023          	sd	a0,-128(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:220
      if (ph_flags | PF_R) {
        map_perm |= MAP_PERM_R;
    80204378:	f8f44783          	lbu	a5,-113(s0)
    8020437c:	0027e793          	ori	a5,a5,2
    80204380:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:223
      }
      if (ph_flags | PF_W) {
        map_perm |= MAP_PERM_W;
    80204384:	f8f44783          	lbu	a5,-113(s0)
    80204388:	0047e793          	ori	a5,a5,4
    8020438c:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:226
      }
      if (ph_flags | PF_X) {
        map_perm |= MAP_PERM_X;
    80204390:	f8f44783          	lbu	a5,-113(s0)
    80204394:	0087e793          	ori	a5,a5,8
    80204398:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:228
      }
      map_area.vpn_range.l = page_floor(start_va);
    8020439c:	f9843783          	ld	a5,-104(s0)
    802043a0:	00c7d713          	srli	a4,a5,0xc
    802043a4:	77fd                	lui	a5,0xfffff
    802043a6:	fe040693          	addi	a3,s0,-32
    802043aa:	97b6                	add	a5,a5,a3
    802043ac:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f288760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:229
      map_area.vpn_range.r = page_ceil(end_va);
    802043b0:	f9043703          	ld	a4,-112(s0)
    802043b4:	6785                	lui	a5,0x1
    802043b6:	17fd                	addi	a5,a5,-1
    802043b8:	97ba                	add	a5,a5,a4
    802043ba:	00c7d713          	srli	a4,a5,0xc
    802043be:	77fd                	lui	a5,0xfffff
    802043c0:	fe040693          	addi	a3,s0,-32
    802043c4:	97b6                	add	a5,a5,a3
    802043c6:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f288768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:230
      map_area.map_type = MAP_FRAMED;
    802043ca:	77fd                	lui	a5,0xfffff
    802043cc:	fe040713          	addi	a4,s0,-32
    802043d0:	97ba                	add	a5,a5,a4
    802043d2:	4705                	li	a4,1
    802043d4:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f288770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:231
      map_area.map_perm = map_perm;
    802043d8:	77fd                	lui	a5,0xfffff
    802043da:	fe040713          	addi	a4,s0,-32
    802043de:	97ba                	add	a5,a5,a4
    802043e0:	f8f44703          	lbu	a4,-113(s0)
    802043e4:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f288771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:232
      max_end_vpn = map_area.vpn_range.r;
    802043e8:	77fd                	lui	a5,0xfffff
    802043ea:	fe040713          	addi	a4,s0,-32
    802043ee:	97ba                	add	a5,a5,a4
    802043f0:	7687b783          	ld	a5,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f288768>
    802043f4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:234
      memory_set_push(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
    802043f8:	77fd                	lui	a5,0xfffff
    802043fa:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    802043fe:	fe040713          	addi	a4,s0,-32
    80204402:	97ba                	add	a5,a5,a4
    80204404:	fa043583          	ld	a1,-96(s0)
    80204408:	853e                	mv	a0,a5
    8020440a:	8affe0ef          	jal	ra,80202cb8 <elf_program_get_offset>
    8020440e:	872a                	mv	a4,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:233
      memory_set_push(memory_set, &map_area,
    80204410:	77fd                	lui	a5,0xfffff
    80204412:	fe040693          	addi	a3,s0,-32
    80204416:	97b6                	add	a5,a5,a3
    80204418:	7507b783          	ld	a5,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f288750>
    8020441c:	00e784b3          	add	s1,a5,a4
    80204420:	77fd                	lui	a5,0xfffff
    80204422:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    80204426:	fe040713          	addi	a4,s0,-32
    8020442a:	97ba                	add	a5,a5,a4
    8020442c:	fa043583          	ld	a1,-96(s0)
    80204430:	853e                	mv	a0,a5
    80204432:	9abfe0ef          	jal	ra,80202ddc <elf_program_get_filesz>
    80204436:	86aa                	mv	a3,a0
    80204438:	77fd                	lui	a5,0xfffff
    8020443a:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f288760>
    8020443e:	fe040713          	addi	a4,s0,-32
    80204442:	973e                	add	a4,a4,a5
    80204444:	77fd                	lui	a5,0xfffff
    80204446:	fe040613          	addi	a2,s0,-32
    8020444a:	97b2                	add	a5,a5,a2
    8020444c:	8626                	mv	a2,s1
    8020444e:	85ba                	mv	a1,a4
    80204450:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    80204454:	a55ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212 (discriminator 2)
  for (size_t i = 0; i < ph_count; i++) {
    80204458:	fd043783          	ld	a5,-48(s0)
    8020445c:	0785                	addi	a5,a5,1
    8020445e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:212 (discriminator 1)
    80204462:	fd043703          	ld	a4,-48(s0)
    80204466:	fc043783          	ld	a5,-64(s0)
    8020446a:	e6f769e3          	bltu	a4,a5,802042dc <memory_set_from_elf+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:240
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = pn2addr(max_end_vpn);
    8020446e:	fd843783          	ld	a5,-40(s0)
    80204472:	07b2                	slli	a5,a5,0xc
    80204474:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:241
  VirtAddr user_stack_bottom = max_end_va;
    80204478:	fb843783          	ld	a5,-72(s0)
    8020447c:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:243
  // guard page
  user_stack_bottom += PAGE_SIZE;
    80204480:	fb043703          	ld	a4,-80(s0)
    80204484:	6785                	lui	a5,0x1
    80204486:	97ba                	add	a5,a5,a4
    80204488:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:244
  VirtAddr user_stack_top = user_stack_bottom + USER_STACK_SIZE;
    8020448c:	fb043703          	ld	a4,-80(s0)
    80204490:	6789                	lui	a5,0x2
    80204492:	97ba                	add	a5,a5,a4
    80204494:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:245
  map_area.vpn_range.l = page_floor(user_stack_bottom);
    80204498:	fb043783          	ld	a5,-80(s0)
    8020449c:	00c7d713          	srli	a4,a5,0xc
    802044a0:	77fd                	lui	a5,0xfffff
    802044a2:	fe040693          	addi	a3,s0,-32
    802044a6:	97b6                	add	a5,a5,a3
    802044a8:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f288760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:246
  map_area.vpn_range.r = page_ceil(user_stack_top);
    802044ac:	fa843703          	ld	a4,-88(s0)
    802044b0:	6785                	lui	a5,0x1
    802044b2:	17fd                	addi	a5,a5,-1
    802044b4:	97ba                	add	a5,a5,a4
    802044b6:	00c7d713          	srli	a4,a5,0xc
    802044ba:	77fd                	lui	a5,0xfffff
    802044bc:	fe040693          	addi	a3,s0,-32
    802044c0:	97b6                	add	a5,a5,a3
    802044c2:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f288768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:247
  map_area.map_type = MAP_FRAMED;
    802044c6:	77fd                	lui	a5,0xfffff
    802044c8:	fe040713          	addi	a4,s0,-32
    802044cc:	97ba                	add	a5,a5,a4
    802044ce:	4705                	li	a4,1
    802044d0:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f288770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:248
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
    802044d4:	77fd                	lui	a5,0xfffff
    802044d6:	fe040713          	addi	a4,s0,-32
    802044da:	97ba                	add	a5,a5,a4
    802044dc:	4759                	li	a4,22
    802044de:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f288771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:249
  memory_set_push(memory_set, &map_area, NULL, 0);
    802044e2:	77fd                	lui	a5,0xfffff
    802044e4:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f288760>
    802044e8:	fe040713          	addi	a4,s0,-32
    802044ec:	973e                	add	a4,a4,a5
    802044ee:	77fd                	lui	a5,0xfffff
    802044f0:	fe040693          	addi	a3,s0,-32
    802044f4:	97b6                	add	a5,a5,a3
    802044f6:	4681                	li	a3,0
    802044f8:	4601                	li	a2,0
    802044fa:	85ba                	mv	a1,a4
    802044fc:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    80204500:	9a9ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:252

  // map TrapContext
  map_area.vpn_range.l = page_floor(TRAP_CONTEXT);
    80204504:	77fd                	lui	a5,0xfffff
    80204506:	fe040713          	addi	a4,s0,-32
    8020450a:	97ba                	add	a5,a5,a4
    8020450c:	7779                	lui	a4,0xffffe
    8020450e:	8331                	srli	a4,a4,0xc
    80204510:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f288760>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:253
  map_area.vpn_range.r = page_ceil(TRAMPOLINE);
    80204514:	77fd                	lui	a5,0xfffff
    80204516:	fe040713          	addi	a4,s0,-32
    8020451a:	97ba                	add	a5,a5,a4
    8020451c:	577d                	li	a4,-1
    8020451e:	8331                	srli	a4,a4,0xc
    80204520:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f288768>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:254
  map_area.map_type = MAP_FRAMED;
    80204524:	77fd                	lui	a5,0xfffff
    80204526:	fe040713          	addi	a4,s0,-32
    8020452a:	97ba                	add	a5,a5,a4
    8020452c:	4705                	li	a4,1
    8020452e:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f288770>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:255
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80204532:	77fd                	lui	a5,0xfffff
    80204534:	fe040713          	addi	a4,s0,-32
    80204538:	97ba                	add	a5,a5,a4
    8020453a:	4719                	li	a4,6
    8020453c:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f288771>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:256
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204540:	77fd                	lui	a5,0xfffff
    80204542:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f288760>
    80204546:	fe040713          	addi	a4,s0,-32
    8020454a:	973e                	add	a4,a4,a5
    8020454c:	77fd                	lui	a5,0xfffff
    8020454e:	fe040693          	addi	a3,s0,-32
    80204552:	97b6                	add	a5,a5,a3
    80204554:	4681                	li	a3,0
    80204556:	4601                	li	a2,0
    80204558:	85ba                	mv	a1,a4
    8020455a:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f288758>
    8020455e:	94bff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:259

  // return
  *user_sp = (uint64_t)user_stack_top;
    80204562:	77fd                	lui	a5,0xfffff
    80204564:	fe040713          	addi	a4,s0,-32
    80204568:	97ba                	add	a5,a5,a4
    8020456a:	7407b783          	ld	a5,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f288740>
    8020456e:	fa843703          	ld	a4,-88(s0)
    80204572:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:260
  *entry_point = elf_header_get_entry(&elf);
    80204574:	77fd                	lui	a5,0xfffff
    80204576:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f288778>
    8020457a:	fe040713          	addi	a4,s0,-32
    8020457e:	97ba                	add	a5,a5,a4
    80204580:	853e                	mv	a0,a5
    80204582:	de2fe0ef          	jal	ra,80202b64 <elf_header_get_entry>
    80204586:	872a                	mv	a4,a0
    80204588:	77fd                	lui	a5,0xfffff
    8020458a:	fe040693          	addi	a3,s0,-32
    8020458e:	97b6                	add	a5,a5,a3
    80204590:	7387b783          	ld	a5,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f288738>
    80204594:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:261
}
    80204596:	0001                	nop
    80204598:	7f010113          	addi	sp,sp,2032
    8020459c:	70ee                	ld	ra,248(sp)
    8020459e:	744e                	ld	s0,240(sp)
    802045a0:	74ae                	ld	s1,232(sp)
    802045a2:	6111                	addi	sp,sp,256
    802045a4:	8082                	ret

00000000802045a6 <memory_set_from_existed_user>:
memory_set_from_existed_user():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:264

void memory_set_from_existed_user(MemorySet *memory_set,
                                  MemorySet *user_space) {
    802045a6:	7159                	addi	sp,sp,-112
    802045a8:	f486                	sd	ra,104(sp)
    802045aa:	f0a2                	sd	s0,96(sp)
    802045ac:	eca6                	sd	s1,88(sp)
    802045ae:	1880                	addi	s0,sp,112
    802045b0:	f8a43c23          	sd	a0,-104(s0)
    802045b4:	f8b43823          	sd	a1,-112(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:266

  memory_set_new_bare(memory_set);
    802045b8:	f9843503          	ld	a0,-104(s0)
    802045bc:	89bff0ef          	jal	ra,80203e56 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:269

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802045c0:	f9843503          	ld	a0,-104(s0)
    802045c4:	ab1ff0ef          	jal	ra,80204074 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:273

  // copy data sections / trap_context / user_stack
  MapArea new_area;
  MapArea *x = (MapArea *)(user_space->areas.buffer);
    802045c8:	f9043783          	ld	a5,-112(s0)
    802045cc:	63bc                	ld	a5,64(a5)
    802045ce:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275
  PhysPageNum src_ppn, dst_ppn;
  for (uint64_t i = 0; i < user_space->areas.size; i++) {
    802045d2:	fc043c23          	sd	zero,-40(s0)
    802045d6:	a8f1                	j	802046b2 <memory_set_from_existed_user+0x10c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:276
    map_area_from_another(&new_area, &x[i]);
    802045d8:	fd843703          	ld	a4,-40(s0)
    802045dc:	87ba                	mv	a5,a4
    802045de:	0786                	slli	a5,a5,0x1
    802045e0:	97ba                	add	a5,a5,a4
    802045e2:	078e                	slli	a5,a5,0x3
    802045e4:	873e                	mv	a4,a5
    802045e6:	fc843783          	ld	a5,-56(s0)
    802045ea:	973e                	add	a4,a4,a5
    802045ec:	fa040793          	addi	a5,s0,-96
    802045f0:	85ba                	mv	a1,a4
    802045f2:	853e                	mv	a0,a5
    802045f4:	de4ff0ef          	jal	ra,80203bd8 <map_area_from_another>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:277
    memory_set_push(memory_set, &new_area, NULL, 0);
    802045f8:	fa040793          	addi	a5,s0,-96
    802045fc:	4681                	li	a3,0
    802045fe:	4601                	li	a2,0
    80204600:	85be                	mv	a1,a5
    80204602:	f9843503          	ld	a0,-104(s0)
    80204606:	8a3ff0ef          	jal	ra,80203ea8 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279
    // copy data from another space
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++) {
    8020460a:	fd843703          	ld	a4,-40(s0)
    8020460e:	87ba                	mv	a5,a4
    80204610:	0786                	slli	a5,a5,0x1
    80204612:	97ba                	add	a5,a5,a4
    80204614:	078e                	slli	a5,a5,0x3
    80204616:	873e                	mv	a4,a5
    80204618:	fc843783          	ld	a5,-56(s0)
    8020461c:	97ba                	add	a5,a5,a4
    8020461e:	639c                	ld	a5,0(a5)
    80204620:	fcf43823          	sd	a5,-48(s0)
    80204624:	a09d                	j	8020468a <memory_set_from_existed_user+0xe4>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:280 (discriminator 3)
      src_ppn = pte_ppn(*memory_set_translate(user_space, vpn));
    80204626:	fd043583          	ld	a1,-48(s0)
    8020462a:	f9043503          	ld	a0,-112(s0)
    8020462e:	0f2000ef          	jal	ra,80204720 <memory_set_translate>
    80204632:	87aa                	mv	a5,a0
    80204634:	639c                	ld	a5,0(a5)
    80204636:	00a7d713          	srli	a4,a5,0xa
    8020463a:	57fd                	li	a5,-1
    8020463c:	83d1                	srli	a5,a5,0x14
    8020463e:	8ff9                	and	a5,a5,a4
    80204640:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:281 (discriminator 3)
      dst_ppn = pte_ppn(*memory_set_translate(memory_set, vpn));
    80204644:	fd043583          	ld	a1,-48(s0)
    80204648:	f9843503          	ld	a0,-104(s0)
    8020464c:	0d4000ef          	jal	ra,80204720 <memory_set_translate>
    80204650:	87aa                	mv	a5,a0
    80204652:	639c                	ld	a5,0(a5)
    80204654:	00a7d713          	srli	a4,a5,0xa
    80204658:	57fd                	li	a5,-1
    8020465a:	83d1                	srli	a5,a5,0x14
    8020465c:	8ff9                	and	a5,a5,a4
    8020465e:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:282 (discriminator 3)
      memcpy(ppn_get_bytes_array(dst_ppn), ppn_get_bytes_array(src_ppn),
    80204662:	fb843503          	ld	a0,-72(s0)
    80204666:	592000ef          	jal	ra,80204bf8 <ppn_get_bytes_array>
    8020466a:	84aa                	mv	s1,a0
    8020466c:	fc043503          	ld	a0,-64(s0)
    80204670:	588000ef          	jal	ra,80204bf8 <ppn_get_bytes_array>
    80204674:	87aa                	mv	a5,a0
    80204676:	6605                	lui	a2,0x1
    80204678:	85be                	mv	a1,a5
    8020467a:	8526                	mv	a0,s1
    8020467c:	8d8ff0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279 (discriminator 3)
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++) {
    80204680:	fd043783          	ld	a5,-48(s0)
    80204684:	0785                	addi	a5,a5,1
    80204686:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:279 (discriminator 1)
    8020468a:	fd843703          	ld	a4,-40(s0)
    8020468e:	87ba                	mv	a5,a4
    80204690:	0786                	slli	a5,a5,0x1
    80204692:	97ba                	add	a5,a5,a4
    80204694:	078e                	slli	a5,a5,0x3
    80204696:	873e                	mv	a4,a5
    80204698:	fc843783          	ld	a5,-56(s0)
    8020469c:	97ba                	add	a5,a5,a4
    8020469e:	679c                	ld	a5,8(a5)
    802046a0:	fd043703          	ld	a4,-48(s0)
    802046a4:	f8f761e3          	bltu	a4,a5,80204626 <memory_set_from_existed_user+0x80>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275 (discriminator 2)
  for (uint64_t i = 0; i < user_space->areas.size; i++) {
    802046a8:	fd843783          	ld	a5,-40(s0)
    802046ac:	0785                	addi	a5,a5,1
    802046ae:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:275 (discriminator 1)
    802046b2:	f9043783          	ld	a5,-112(s0)
    802046b6:	779c                	ld	a5,40(a5)
    802046b8:	fd843703          	ld	a4,-40(s0)
    802046bc:	f0f76ee3          	bltu	a4,a5,802045d8 <memory_set_from_existed_user+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:286
             PAGE_SIZE);
    }
  }
}
    802046c0:	0001                	nop
    802046c2:	0001                	nop
    802046c4:	70a6                	ld	ra,104(sp)
    802046c6:	7406                	ld	s0,96(sp)
    802046c8:	64e6                	ld	s1,88(sp)
    802046ca:	6165                	addi	sp,sp,112
    802046cc:	8082                	ret

00000000802046ce <memory_set_activate>:
memory_set_activate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:288

static void memory_set_activate(MemorySet *memory_set) {
    802046ce:	7179                	addi	sp,sp,-48
    802046d0:	f406                	sd	ra,40(sp)
    802046d2:	f022                	sd	s0,32(sp)
    802046d4:	1800                	addi	s0,sp,48
    802046d6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:289
  uint64_t satp = page_table_token(&memory_set->page_table);
    802046da:	fd843783          	ld	a5,-40(s0)
    802046de:	853e                	mv	a0,a5
    802046e0:	339000ef          	jal	ra,80205218 <page_table_token>
    802046e4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:290
  w_satp(satp);
    802046e8:	fe843503          	ld	a0,-24(s0)
    802046ec:	cc0ff0ef          	jal	ra,80203bac <w_satp>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:291
  sfence_vma();
    802046f0:	cd6ff0ef          	jal	ra,80203bc6 <sfence_vma>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:292
}
    802046f4:	0001                	nop
    802046f6:	70a2                	ld	ra,40(sp)
    802046f8:	7402                	ld	s0,32(sp)
    802046fa:	6145                	addi	sp,sp,48
    802046fc:	8082                	ret

00000000802046fe <memory_set_kernel_init>:
memory_set_kernel_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:294

void memory_set_kernel_init() {
    802046fe:	1141                	addi	sp,sp,-16
    80204700:	e406                	sd	ra,8(sp)
    80204702:	e022                	sd	s0,0(sp)
    80204704:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:295
  memory_set_new_kernel();
    80204706:	9a3ff0ef          	jal	ra,802040a8 <memory_set_new_kernel>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:296
  memory_set_activate(&KERNEL_SPACE);
    8020470a:	00821517          	auipc	a0,0x821
    8020470e:	8fe50513          	addi	a0,a0,-1794 # 80a25008 <KERNEL_SPACE>
    80204712:	fbdff0ef          	jal	ra,802046ce <memory_set_activate>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:297
}
    80204716:	0001                	nop
    80204718:	60a2                	ld	ra,8(sp)
    8020471a:	6402                	ld	s0,0(sp)
    8020471c:	0141                	addi	sp,sp,16
    8020471e:	8082                	ret

0000000080204720 <memory_set_translate>:
memory_set_translate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:299

PageTableEntry *memory_set_translate(MemorySet *memory_set, VirtPageNum vpn) {
    80204720:	1101                	addi	sp,sp,-32
    80204722:	ec06                	sd	ra,24(sp)
    80204724:	e822                	sd	s0,16(sp)
    80204726:	1000                	addi	s0,sp,32
    80204728:	fea43423          	sd	a0,-24(s0)
    8020472c:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:300
  return page_table_translate(&memory_set->page_table, vpn);
    80204730:	fe843783          	ld	a5,-24(s0)
    80204734:	fe043583          	ld	a1,-32(s0)
    80204738:	853e                	mv	a0,a5
    8020473a:	293000ef          	jal	ra,802051cc <page_table_translate>
    8020473e:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:301
}
    80204740:	853e                	mv	a0,a5
    80204742:	60e2                	ld	ra,24(sp)
    80204744:	6442                	ld	s0,16(sp)
    80204746:	6105                	addi	sp,sp,32
    80204748:	8082                	ret

000000008020474a <memory_set_recycle_data_pages>:
memory_set_recycle_data_pages():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:303

void memory_set_recycle_data_pages(MemorySet *memory_set) {
    8020474a:	1101                	addi	sp,sp,-32
    8020474c:	ec06                	sd	ra,24(sp)
    8020474e:	e822                	sd	s0,16(sp)
    80204750:	1000                	addi	s0,sp,32
    80204752:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:304
  memory_set_free(memory_set);
    80204756:	fe843503          	ld	a0,-24(s0)
    8020475a:	8a3ff0ef          	jal	ra,80203ffc <memory_set_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:305
}
    8020475e:	0001                	nop
    80204760:	60e2                	ld	ra,24(sp)
    80204762:	6442                	ld	s0,16(sp)
    80204764:	6105                	addi	sp,sp,32
    80204766:	8082                	ret

0000000080204768 <kernel_space_insert_framed_area>:
kernel_space_insert_framed_area():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:308

void kernel_space_insert_framed_area(VirtAddr start_va, VirtAddr end_va,
                                     MapPermission permission) {
    80204768:	7179                	addi	sp,sp,-48
    8020476a:	f406                	sd	ra,40(sp)
    8020476c:	f022                	sd	s0,32(sp)
    8020476e:	1800                	addi	s0,sp,48
    80204770:	fea43423          	sd	a0,-24(s0)
    80204774:	feb43023          	sd	a1,-32(s0)
    80204778:	87b2                	mv	a5,a2
    8020477a:	fcf40fa3          	sb	a5,-33(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:309
  memory_set_insert_framed_area(&KERNEL_SPACE, start_va, end_va, permission);
    8020477e:	fdf44783          	lbu	a5,-33(s0)
    80204782:	86be                	mv	a3,a5
    80204784:	fe043603          	ld	a2,-32(s0)
    80204788:	fe843583          	ld	a1,-24(s0)
    8020478c:	00821517          	auipc	a0,0x821
    80204790:	87c50513          	addi	a0,a0,-1924 # 80a25008 <KERNEL_SPACE>
    80204794:	f72ff0ef          	jal	ra,80203f06 <memory_set_insert_framed_area>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:310
}
    80204798:	0001                	nop
    8020479a:	70a2                	ld	ra,40(sp)
    8020479c:	7402                	ld	s0,32(sp)
    8020479e:	6145                	addi	sp,sp,48
    802047a0:	8082                	ret

00000000802047a2 <kernel_space_remove_area_with_start_vpn>:
kernel_space_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:312

void kernel_space_remove_area_with_start_vpn(VirtPageNum start_vpn) {
    802047a2:	1101                	addi	sp,sp,-32
    802047a4:	ec06                	sd	ra,24(sp)
    802047a6:	e822                	sd	s0,16(sp)
    802047a8:	1000                	addi	s0,sp,32
    802047aa:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:313
  memory_set_remove_area_with_start_vpn(&KERNEL_SPACE, start_vpn);
    802047ae:	fe843583          	ld	a1,-24(s0)
    802047b2:	00821517          	auipc	a0,0x821
    802047b6:	85650513          	addi	a0,a0,-1962 # 80a25008 <KERNEL_SPACE>
    802047ba:	faaff0ef          	jal	ra,80203f64 <memory_set_remove_area_with_start_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:314
}
    802047be:	0001                	nop
    802047c0:	60e2                	ld	ra,24(sp)
    802047c2:	6442                	ld	s0,16(sp)
    802047c4:	6105                	addi	sp,sp,32
    802047c6:	8082                	ret

00000000802047c8 <kernel_space_token>:
kernel_space_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:316

uint64_t kernel_space_token() { return memory_set_token(&KERNEL_SPACE); }
    802047c8:	1141                	addi	sp,sp,-16
    802047ca:	e406                	sd	ra,8(sp)
    802047cc:	e022                	sd	s0,0(sp)
    802047ce:	0800                	addi	s0,sp,16
    802047d0:	00821517          	auipc	a0,0x821
    802047d4:	83850513          	addi	a0,a0,-1992 # 80a25008 <KERNEL_SPACE>
    802047d8:	eaeff0ef          	jal	ra,80203e86 <memory_set_token>
    802047dc:	87aa                	mv	a5,a0
    802047de:	853e                	mv	a0,a5
    802047e0:	60a2                	ld	ra,8(sp)
    802047e2:	6402                	ld	s0,0(sp)
    802047e4:	0141                	addi	sp,sp,16
    802047e6:	8082                	ret

00000000802047e8 <memory_set_mmap>:
memory_set_mmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:319

int64_t memory_set_mmap(MemorySet *memory_set, uint64_t start, uint64_t len,
                        uint64_t prot) {
    802047e8:	7119                	addi	sp,sp,-128
    802047ea:	fc86                	sd	ra,120(sp)
    802047ec:	f8a2                	sd	s0,112(sp)
    802047ee:	0100                	addi	s0,sp,128
    802047f0:	f8a43c23          	sd	a0,-104(s0)
    802047f4:	f8b43823          	sd	a1,-112(s0)
    802047f8:	f8c43423          	sd	a2,-120(s0)
    802047fc:	f8d43023          	sd	a3,-128(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:320
  if (len == 0) {
    80204800:	f8843783          	ld	a5,-120(s0)
    80204804:	e399                	bnez	a5,8020480a <memory_set_mmap+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:321
    return 0;
    80204806:	4781                	li	a5,0
    80204808:	a2b5                	j	80204974 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    8020480a:	f9043703          	ld	a4,-112(s0)
    8020480e:	6785                	lui	a5,0x1
    80204810:	17fd                	addi	a5,a5,-1
    80204812:	8ff9                	and	a5,a5,a4
    80204814:	ef99                	bnez	a5,80204832 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 1)
    80204816:	f8843703          	ld	a4,-120(s0)
    8020481a:	400007b7          	lui	a5,0x40000
    8020481e:	00e7ea63          	bltu	a5,a4,80204832 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 2)
    80204822:	f8043783          	ld	a5,-128(s0)
    80204826:	9be1                	andi	a5,a5,-8
    80204828:	e789                	bnez	a5,80204832 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:325 (discriminator 3)
      ((prot & 0x7) == 0)) {
    8020482a:	f8043783          	ld	a5,-128(s0)
    8020482e:	8b9d                	andi	a5,a5,7
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:324 (discriminator 3)
  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    80204830:	e399                	bnez	a5,80204836 <memory_set_mmap+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:326
    return -1;
    80204832:	57fd                	li	a5,-1
    80204834:	a281                	j	80204974 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:329
  }

  len = page_ceil(len) * PAGE_SIZE;
    80204836:	f8843703          	ld	a4,-120(s0)
    8020483a:	6785                	lui	a5,0x1
    8020483c:	17fd                	addi	a5,a5,-1
    8020483e:	973e                	add	a4,a4,a5
    80204840:	77fd                	lui	a5,0xfffff
    80204842:	8ff9                	and	a5,a5,a4
    80204844:	f8f43423          	sd	a5,-120(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:330
  VirtPageNum vpn_start = addr2pn(start);
    80204848:	f9043783          	ld	a5,-112(s0)
    8020484c:	83b1                	srli	a5,a5,0xc
    8020484e:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:331
  VirtPageNum vpn_end = addr2pn(start + len);
    80204852:	f9043703          	ld	a4,-112(s0)
    80204856:	f8843783          	ld	a5,-120(s0)
    8020485a:	97ba                	add	a5,a5,a4
    8020485c:	83b1                	srli	a5,a5,0xc
    8020485e:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:332
  PageTable *pt = &memory_set->page_table;
    80204862:	f9843783          	ld	a5,-104(s0)
    80204866:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    8020486a:	fc843783          	ld	a5,-56(s0)
    8020486e:	fef43423          	sd	a5,-24(s0)
    80204872:	a005                	j	80204892 <memory_set_mmap+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:336
    if (page_table_find_pte(pt, vpn)) {
    80204874:	fe843583          	ld	a1,-24(s0)
    80204878:	fb843503          	ld	a0,-72(s0)
    8020487c:	7da000ef          	jal	ra,80205056 <page_table_find_pte>
    80204880:	87aa                	mv	a5,a0
    80204882:	c399                	beqz	a5,80204888 <memory_set_mmap+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:337
      return -1;
    80204884:	57fd                	li	a5,-1
    80204886:	a0fd                	j	80204974 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204888:	fe843783          	ld	a5,-24(s0)
    8020488c:	0785                	addi	a5,a5,1
    8020488e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:335 (discriminator 1)
    80204892:	fe843703          	ld	a4,-24(s0)
    80204896:	fc043783          	ld	a5,-64(s0)
    8020489a:	fcf76de3          	bltu	a4,a5,80204874 <memory_set_mmap+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:341
    }
  }

  MapPermission map_perm = MAP_PERM_U;
    8020489e:	47c1                	li	a5,16
    802048a0:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:342
  if ((prot & 0x1) != 0)
    802048a4:	f8043783          	ld	a5,-128(s0)
    802048a8:	8b85                	andi	a5,a5,1
    802048aa:	c799                	beqz	a5,802048b8 <memory_set_mmap+0xd0>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:343
    map_perm |= MAP_PERM_R;
    802048ac:	fe744783          	lbu	a5,-25(s0)
    802048b0:	0027e793          	ori	a5,a5,2
    802048b4:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:344
  if ((prot & 0x2) != 0)
    802048b8:	f8043783          	ld	a5,-128(s0)
    802048bc:	8b89                	andi	a5,a5,2
    802048be:	c799                	beqz	a5,802048cc <memory_set_mmap+0xe4>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:345
    map_perm |= MAP_PERM_W;
    802048c0:	fe744783          	lbu	a5,-25(s0)
    802048c4:	0047e793          	ori	a5,a5,4
    802048c8:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:346
  if ((prot & 0x4) != 0)
    802048cc:	f8043783          	ld	a5,-128(s0)
    802048d0:	8b91                	andi	a5,a5,4
    802048d2:	c799                	beqz	a5,802048e0 <memory_set_mmap+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:347
    map_perm |= MAP_PERM_X;
    802048d4:	fe744783          	lbu	a5,-25(s0)
    802048d8:	0087e793          	ori	a5,a5,8
    802048dc:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352

  // map
  PhysPageNum ppn;
  PTEFlags pte_flags;
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    802048e0:	fc843783          	ld	a5,-56(s0)
    802048e4:	fcf43c23          	sd	a5,-40(s0)
    802048e8:	a0a1                	j	80204930 <memory_set_mmap+0x148>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:353 (discriminator 3)
    ppn = frame_alloc();
    802048ea:	396000ef          	jal	ra,80204c80 <frame_alloc>
    802048ee:	87aa                	mv	a5,a0
    802048f0:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:354 (discriminator 3)
    pte_flags = (PTEFlags)(map_perm);
    802048f4:	fe744783          	lbu	a5,-25(s0)
    802048f8:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:355 (discriminator 3)
    page_table_map(pt, vpn, ppn, pte_flags);
    802048fc:	fa843783          	ld	a5,-88(s0)
    80204900:	fb744703          	lbu	a4,-73(s0)
    80204904:	86ba                	mv	a3,a4
    80204906:	863e                	mv	a2,a5
    80204908:	fd843583          	ld	a1,-40(s0)
    8020490c:	fb843503          	ld	a0,-72(s0)
    80204910:	7fa000ef          	jal	ra,8020510a <page_table_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:356 (discriminator 3)
    vector_push(&pt->frames, &ppn);
    80204914:	fb843783          	ld	a5,-72(s0)
    80204918:	07a1                	addi	a5,a5,8
    8020491a:	fa840713          	addi	a4,s0,-88
    8020491e:	85ba                	mv	a1,a4
    80204920:	853e                	mv	a0,a5
    80204922:	3ce030ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204926:	fd843783          	ld	a5,-40(s0)
    8020492a:	0785                	addi	a5,a5,1
    8020492c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:352 (discriminator 1)
    80204930:	fd843703          	ld	a4,-40(s0)
    80204934:	fc043783          	ld	a5,-64(s0)
    80204938:	faf769e3          	bltu	a4,a5,802048ea <memory_set_mmap+0x102>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360
  }

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    8020493c:	fc843783          	ld	a5,-56(s0)
    80204940:	fcf43823          	sd	a5,-48(s0)
    80204944:	a005                	j	80204964 <memory_set_mmap+0x17c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:361
    if (!page_table_find_pte(pt, vpn)) {
    80204946:	fd043583          	ld	a1,-48(s0)
    8020494a:	fb843503          	ld	a0,-72(s0)
    8020494e:	708000ef          	jal	ra,80205056 <page_table_find_pte>
    80204952:	87aa                	mv	a5,a0
    80204954:	e399                	bnez	a5,8020495a <memory_set_mmap+0x172>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:362
      return -1;
    80204956:	57fd                	li	a5,-1
    80204958:	a831                	j	80204974 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    8020495a:	fd043783          	ld	a5,-48(s0)
    8020495e:	0785                	addi	a5,a5,1
    80204960:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:360 (discriminator 1)
    80204964:	fd043703          	ld	a4,-48(s0)
    80204968:	fc043783          	ld	a5,-64(s0)
    8020496c:	fcf76de3          	bltu	a4,a5,80204946 <memory_set_mmap+0x15e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:366
    }
  }

  return len;
    80204970:	f8843783          	ld	a5,-120(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:367 (discriminator 1)
}
    80204974:	853e                	mv	a0,a5
    80204976:	70e6                	ld	ra,120(sp)
    80204978:	7446                	ld	s0,112(sp)
    8020497a:	6109                	addi	sp,sp,128
    8020497c:	8082                	ret

000000008020497e <memory_set_munmap>:
memory_set_munmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:369

int64_t memory_set_munmap(MemorySet *memory_set, uint64_t start, uint64_t len) {
    8020497e:	711d                	addi	sp,sp,-96
    80204980:	ec86                	sd	ra,88(sp)
    80204982:	e8a2                	sd	s0,80(sp)
    80204984:	1080                	addi	s0,sp,96
    80204986:	faa43c23          	sd	a0,-72(s0)
    8020498a:	fab43823          	sd	a1,-80(s0)
    8020498e:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:370
  if (len == 0) {
    80204992:	fa843783          	ld	a5,-88(s0)
    80204996:	e399                	bnez	a5,8020499c <memory_set_munmap+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:371
    return 0;
    80204998:	4781                	li	a5,0
    8020499a:	a0ed                	j	80204a84 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:374
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE)) {
    8020499c:	fb043703          	ld	a4,-80(s0)
    802049a0:	6785                	lui	a5,0x1
    802049a2:	17fd                	addi	a5,a5,-1
    802049a4:	8ff9                	and	a5,a5,a4
    802049a6:	e799                	bnez	a5,802049b4 <memory_set_munmap+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:374 (discriminator 1)
    802049a8:	fa843703          	ld	a4,-88(s0)
    802049ac:	400007b7          	lui	a5,0x40000
    802049b0:	00e7f463          	bgeu	a5,a4,802049b8 <memory_set_munmap+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:375
    return -1;
    802049b4:	57fd                	li	a5,-1
    802049b6:	a0f9                	j	80204a84 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:378
  }

  len = page_ceil(len) * PAGE_SIZE;
    802049b8:	fa843703          	ld	a4,-88(s0)
    802049bc:	6785                	lui	a5,0x1
    802049be:	17fd                	addi	a5,a5,-1
    802049c0:	973e                	add	a4,a4,a5
    802049c2:	77fd                	lui	a5,0xfffff
    802049c4:	8ff9                	and	a5,a5,a4
    802049c6:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:379
  VirtPageNum vpn_start = addr2pn(start);
    802049ca:	fb043783          	ld	a5,-80(s0)
    802049ce:	83b1                	srli	a5,a5,0xc
    802049d0:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:380
  VirtPageNum vpn_end = addr2pn(start + len);
    802049d4:	fb043703          	ld	a4,-80(s0)
    802049d8:	fa843783          	ld	a5,-88(s0)
    802049dc:	97ba                	add	a5,a5,a4
    802049de:	83b1                	srli	a5,a5,0xc
    802049e0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:381
  PageTable *pt = &memory_set->page_table;
    802049e4:	fb843783          	ld	a5,-72(s0)
    802049e8:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    802049ec:	fd043783          	ld	a5,-48(s0)
    802049f0:	fef43423          	sd	a5,-24(s0)
    802049f4:	a005                	j	80204a14 <memory_set_munmap+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:385
    if (!page_table_find_pte(pt, vpn)) {
    802049f6:	fe843583          	ld	a1,-24(s0)
    802049fa:	fc043503          	ld	a0,-64(s0)
    802049fe:	658000ef          	jal	ra,80205056 <page_table_find_pte>
    80204a02:	87aa                	mv	a5,a0
    80204a04:	e399                	bnez	a5,80204a0a <memory_set_munmap+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:386
      return -1;
    80204a06:	57fd                	li	a5,-1
    80204a08:	a8b5                	j	80204a84 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a0a:	fe843783          	ld	a5,-24(s0)
    80204a0e:	0785                	addi	a5,a5,1
    80204a10:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:384 (discriminator 1)
    80204a14:	fe843703          	ld	a4,-24(s0)
    80204a18:	fc843783          	ld	a5,-56(s0)
    80204a1c:	fcf76de3          	bltu	a4,a5,802049f6 <memory_set_munmap+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391
    }
  }

  // unmap
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a20:	fd043783          	ld	a5,-48(s0)
    80204a24:	fef43023          	sd	a5,-32(s0)
    80204a28:	a821                	j	80204a40 <memory_set_munmap+0xc2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:392 (discriminator 3)
    page_table_unmap(pt, vpn);
    80204a2a:	fe043583          	ld	a1,-32(s0)
    80204a2e:	fc043503          	ld	a0,-64(s0)
    80204a32:	746000ef          	jal	ra,80205178 <page_table_unmap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a36:	fe043783          	ld	a5,-32(s0)
    80204a3a:	0785                	addi	a5,a5,1
    80204a3c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:391 (discriminator 1)
    80204a40:	fe043703          	ld	a4,-32(s0)
    80204a44:	fc843783          	ld	a5,-56(s0)
    80204a48:	fef761e3          	bltu	a4,a5,80204a2a <memory_set_munmap+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396
  }

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a4c:	fd043783          	ld	a5,-48(s0)
    80204a50:	fcf43c23          	sd	a5,-40(s0)
    80204a54:	a005                	j	80204a74 <memory_set_munmap+0xf6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:397
    if (page_table_find_pte(pt, vpn)) {
    80204a56:	fd843583          	ld	a1,-40(s0)
    80204a5a:	fc043503          	ld	a0,-64(s0)
    80204a5e:	5f8000ef          	jal	ra,80205056 <page_table_find_pte>
    80204a62:	87aa                	mv	a5,a0
    80204a64:	c399                	beqz	a5,80204a6a <memory_set_munmap+0xec>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:398
      return -1;
    80204a66:	57fd                	li	a5,-1
    80204a68:	a831                	j	80204a84 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++) {
    80204a6a:	fd843783          	ld	a5,-40(s0)
    80204a6e:	0785                	addi	a5,a5,1
    80204a70:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:396 (discriminator 1)
    80204a74:	fd843703          	ld	a4,-40(s0)
    80204a78:	fc843783          	ld	a5,-56(s0)
    80204a7c:	fcf76de3          	bltu	a4,a5,80204a56 <memory_set_munmap+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:402
    }
  }

  return len;
    80204a80:	fa843783          	ld	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:403
}
    80204a84:	853e                	mv	a0,a5
    80204a86:	60e6                	ld	ra,88(sp)
    80204a88:	6446                	ld	s0,80(sp)
    80204a8a:	6125                	addi	sp,sp,96
    80204a8c:	8082                	ret

0000000080204a8e <memory_set_remap_test>:
memory_set_remap_test():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:406

void memory_set_remap_test() 
{
    80204a8e:	7179                	addi	sp,sp,-48
    80204a90:	f406                	sd	ra,40(sp)
    80204a92:	f022                	sd	s0,32(sp)
    80204a94:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:407
  VirtAddr mid_text = (VirtAddr)(((uint64_t)&stext + (uint64_t)&etext) / 2);
    80204a96:	ffffb717          	auipc	a4,0xffffb
    80204a9a:	56a70713          	addi	a4,a4,1386 # 80200000 <_start>
    80204a9e:	00003797          	auipc	a5,0x3
    80204aa2:	56278793          	addi	a5,a5,1378 # 80208000 <etext>
    80204aa6:	97ba                	add	a5,a5,a4
    80204aa8:	8385                	srli	a5,a5,0x1
    80204aaa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:409
  VirtAddr mid_rodata =
      (VirtAddr)(((uint64_t)&srodata + (uint64_t)&erodata) / 2);
    80204aae:	00003717          	auipc	a4,0x3
    80204ab2:	55270713          	addi	a4,a4,1362 # 80208000 <etext>
    80204ab6:	00004797          	auipc	a5,0x4
    80204aba:	54a78793          	addi	a5,a5,1354 # 80209000 <app_starts.1>
    80204abe:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:408
  VirtAddr mid_rodata =
    80204ac0:	8385                	srli	a5,a5,0x1
    80204ac2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:410
  VirtAddr mid_data = (VirtAddr)(((uint64_t)&sdata + (uint64_t)&edata) / 2);
    80204ac6:	00004717          	auipc	a4,0x4
    80204aca:	53a70713          	addi	a4,a4,1338 # 80209000 <app_starts.1>
    80204ace:	00010797          	auipc	a5,0x10
    80204ad2:	53278793          	addi	a5,a5,1330 # 80215000 <boot_stack_lower_bound>
    80204ad6:	97ba                	add	a5,a5,a4
    80204ad8:	8385                	srli	a5,a5,0x1
    80204ada:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:412

  ASSERT(!pte_writable(*page_table_translate(
    80204ade:	fe843783          	ld	a5,-24(s0)
    80204ae2:	83b1                	srli	a5,a5,0xc
    80204ae4:	85be                	mv	a1,a5
    80204ae6:	00820517          	auipc	a0,0x820
    80204aea:	52250513          	addi	a0,a0,1314 # 80a25008 <KERNEL_SPACE>
    80204aee:	6de000ef          	jal	ra,802051cc <page_table_translate>
    80204af2:	87aa                	mv	a5,a0
    80204af4:	639c                	ld	a5,0(a5)
    80204af6:	8b91                	andi	a5,a5,4
    80204af8:	cf89                	beqz	a5,80204b12 <memory_set_remap_test+0x84>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:412 (discriminator 1)
    80204afa:	00003617          	auipc	a2,0x3
    80204afe:	68660613          	addi	a2,a2,1670 # 80208180 <MMIO+0x48>
    80204b02:	19c00593          	li	a1,412
    80204b06:	00003517          	auipc	a0,0x3
    80204b0a:	65a50513          	addi	a0,a0,1626 # 80208160 <MMIO+0x28>
    80204b0e:	39d010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:414
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_text))));
  ASSERT(!pte_writable(*page_table_translate(
    80204b12:	fe043783          	ld	a5,-32(s0)
    80204b16:	83b1                	srli	a5,a5,0xc
    80204b18:	85be                	mv	a1,a5
    80204b1a:	00820517          	auipc	a0,0x820
    80204b1e:	4ee50513          	addi	a0,a0,1262 # 80a25008 <KERNEL_SPACE>
    80204b22:	6aa000ef          	jal	ra,802051cc <page_table_translate>
    80204b26:	87aa                	mv	a5,a0
    80204b28:	639c                	ld	a5,0(a5)
    80204b2a:	8b91                	andi	a5,a5,4
    80204b2c:	cf89                	beqz	a5,80204b46 <memory_set_remap_test+0xb8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:414 (discriminator 1)
    80204b2e:	00003617          	auipc	a2,0x3
    80204b32:	6ca60613          	addi	a2,a2,1738 # 802081f8 <MMIO+0xc0>
    80204b36:	19e00593          	li	a1,414
    80204b3a:	00003517          	auipc	a0,0x3
    80204b3e:	62650513          	addi	a0,a0,1574 # 80208160 <MMIO+0x28>
    80204b42:	369010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:416
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_rodata))));
  ASSERT(!pte_executable(*page_table_translate(
    80204b46:	fd843783          	ld	a5,-40(s0)
    80204b4a:	83b1                	srli	a5,a5,0xc
    80204b4c:	85be                	mv	a1,a5
    80204b4e:	00820517          	auipc	a0,0x820
    80204b52:	4ba50513          	addi	a0,a0,1210 # 80a25008 <KERNEL_SPACE>
    80204b56:	676000ef          	jal	ra,802051cc <page_table_translate>
    80204b5a:	87aa                	mv	a5,a0
    80204b5c:	639c                	ld	a5,0(a5)
    80204b5e:	8ba1                	andi	a5,a5,8
    80204b60:	cf89                	beqz	a5,80204b7a <memory_set_remap_test+0xec>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:416 (discriminator 1)
    80204b62:	00003617          	auipc	a2,0x3
    80204b66:	70e60613          	addi	a2,a2,1806 # 80208270 <MMIO+0x138>
    80204b6a:	1a000593          	li	a1,416
    80204b6e:	00003517          	auipc	a0,0x3
    80204b72:	5f250513          	addi	a0,a0,1522 # 80208160 <MMIO+0x28>
    80204b76:	335010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/memory_set.c:418
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_data))));
}
    80204b7a:	0001                	nop
    80204b7c:	70a2                	ld	ra,40(sp)
    80204b7e:	7402                	ld	s0,32(sp)
    80204b80:	6145                	addi	sp,sp,48
    80204b82:	8082                	ret

0000000080204b84 <vpn_indexes>:
vpn_indexes():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:4
#include "config.h"
#include "mem.h"

void vpn_indexes(VirtPageNum vpn, uint64_t *idx) {
    80204b84:	7179                	addi	sp,sp,-48
    80204b86:	f422                	sd	s0,40(sp)
    80204b88:	1800                	addi	s0,sp,48
    80204b8a:	fca43c23          	sd	a0,-40(s0)
    80204b8e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5
  for (int i = 2; i >= 0; i--) {
    80204b92:	4789                	li	a5,2
    80204b94:	fef42623          	sw	a5,-20(s0)
    80204b98:	a035                	j	80204bc4 <vpn_indexes+0x40>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:6 (discriminator 3)
    idx[i] = vpn & 0x1ff;
    80204b9a:	fec42783          	lw	a5,-20(s0)
    80204b9e:	078e                	slli	a5,a5,0x3
    80204ba0:	fd043703          	ld	a4,-48(s0)
    80204ba4:	97ba                	add	a5,a5,a4
    80204ba6:	fd843703          	ld	a4,-40(s0)
    80204baa:	1ff77713          	andi	a4,a4,511
    80204bae:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:7 (discriminator 3)
    vpn >>= 9;
    80204bb0:	fd843783          	ld	a5,-40(s0)
    80204bb4:	83a5                	srli	a5,a5,0x9
    80204bb6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5 (discriminator 3)
  for (int i = 2; i >= 0; i--) {
    80204bba:	fec42783          	lw	a5,-20(s0)
    80204bbe:	37fd                	addiw	a5,a5,-1
    80204bc0:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:5 (discriminator 1)
    80204bc4:	fec42783          	lw	a5,-20(s0)
    80204bc8:	2781                	sext.w	a5,a5
    80204bca:	fc07d8e3          	bgez	a5,80204b9a <vpn_indexes+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:9
  }
}
    80204bce:	0001                	nop
    80204bd0:	0001                	nop
    80204bd2:	7422                	ld	s0,40(sp)
    80204bd4:	6145                	addi	sp,sp,48
    80204bd6:	8082                	ret

0000000080204bd8 <ppn_get_pte_array>:
ppn_get_pte_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:11

PageTableEntry *ppn_get_pte_array(PhysPageNum ppn) {
    80204bd8:	7179                	addi	sp,sp,-48
    80204bda:	f422                	sd	s0,40(sp)
    80204bdc:	1800                	addi	s0,sp,48
    80204bde:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:12
  PhysAddr pa = pn2addr(ppn);
    80204be2:	fd843783          	ld	a5,-40(s0)
    80204be6:	07b2                	slli	a5,a5,0xc
    80204be8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:13
  return (PageTableEntry *)pa; // len = 512 * 8
    80204bec:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:14
}
    80204bf0:	853e                	mv	a0,a5
    80204bf2:	7422                	ld	s0,40(sp)
    80204bf4:	6145                	addi	sp,sp,48
    80204bf6:	8082                	ret

0000000080204bf8 <ppn_get_bytes_array>:
ppn_get_bytes_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:16

uint8_t *ppn_get_bytes_array(PhysPageNum ppn) {
    80204bf8:	7179                	addi	sp,sp,-48
    80204bfa:	f422                	sd	s0,40(sp)
    80204bfc:	1800                	addi	s0,sp,48
    80204bfe:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:17
  PhysAddr pa = pn2addr(ppn);
    80204c02:	fd843783          	ld	a5,-40(s0)
    80204c06:	07b2                	slli	a5,a5,0xc
    80204c08:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:18
  return (uint8_t *)pa; // len = PAGE_SIZE (4096)
    80204c0c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/address.c:19
}
    80204c10:	853e                	mv	a0,a5
    80204c12:	7422                	ld	s0,40(sp)
    80204c14:	6145                	addi	sp,sp,48
    80204c16:	8082                	ret

0000000080204c18 <frame_allocator_init>:
frame_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:14
  struct vector recycled;
} StackFrameAllocator;

static StackFrameAllocator FRAME_ALLOCATOR;

void frame_allocator_init() {
    80204c18:	1141                	addi	sp,sp,-16
    80204c1a:	e406                	sd	ra,8(sp)
    80204c1c:	e022                	sd	s0,0(sp)
    80204c1e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:16
  extern uint8_t ekernel;
  FRAME_ALLOCATOR.current = page_ceil((PhysAddr)&ekernel);
    80204c20:	00b72717          	auipc	a4,0xb72
    80204c24:	3e070713          	addi	a4,a4,992 # 80d77000 <ebss>
    80204c28:	6785                	lui	a5,0x1
    80204c2a:	17fd                	addi	a5,a5,-1
    80204c2c:	97ba                	add	a5,a5,a4
    80204c2e:	00c7d713          	srli	a4,a5,0xc
    80204c32:	00820797          	auipc	a5,0x820
    80204c36:	41e78793          	addi	a5,a5,1054 # 80a25050 <FRAME_ALLOCATOR>
    80204c3a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:17
  FRAME_ALLOCATOR.end = page_floor(MEMORY_END);
    80204c3c:	00820797          	auipc	a5,0x820
    80204c40:	41478793          	addi	a5,a5,1044 # 80a25050 <FRAME_ALLOCATOR>
    80204c44:	00081737          	lui	a4,0x81
    80204c48:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:18
  vector_new(&FRAME_ALLOCATOR.recycled, sizeof(PhysPageNum));
    80204c4a:	45a1                	li	a1,8
    80204c4c:	00820517          	auipc	a0,0x820
    80204c50:	41450513          	addi	a0,a0,1044 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204c54:	04a030ef          	jal	ra,80207c9e <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:19
}
    80204c58:	0001                	nop
    80204c5a:	60a2                	ld	ra,8(sp)
    80204c5c:	6402                	ld	s0,0(sp)
    80204c5e:	0141                	addi	sp,sp,16
    80204c60:	8082                	ret

0000000080204c62 <frame_allocator_free>:
frame_allocator_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:21

void frame_allocator_free() { vector_free(&FRAME_ALLOCATOR.recycled); }
    80204c62:	1141                	addi	sp,sp,-16
    80204c64:	e406                	sd	ra,8(sp)
    80204c66:	e022                	sd	s0,0(sp)
    80204c68:	0800                	addi	s0,sp,16
    80204c6a:	00820517          	auipc	a0,0x820
    80204c6e:	3f650513          	addi	a0,a0,1014 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204c72:	200030ef          	jal	ra,80207e72 <vector_free>
    80204c76:	0001                	nop
    80204c78:	60a2                	ld	ra,8(sp)
    80204c7a:	6402                	ld	s0,0(sp)
    80204c7c:	0141                	addi	sp,sp,16
    80204c7e:	8082                	ret

0000000080204c80 <frame_alloc>:
frame_alloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:24

PhysPageNum frame_alloc() 
{
    80204c80:	1101                	addi	sp,sp,-32
    80204c82:	ec06                	sd	ra,24(sp)
    80204c84:	e822                	sd	s0,16(sp)
    80204c86:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:25
  PhysPageNum ppn = 0;
    80204c88:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:26
  if (!vector_empty(&FRAME_ALLOCATOR.recycled)) 
    80204c8c:	00820517          	auipc	a0,0x820
    80204c90:	3d450513          	addi	a0,a0,980 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204c94:	1bc030ef          	jal	ra,80207e50 <vector_empty>
    80204c98:	87aa                	mv	a5,a0
    80204c9a:	e395                	bnez	a5,80204cbe <frame_alloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:28
  {
    ppn = *(PhysPageNum *)vector_back(&FRAME_ALLOCATOR.recycled);
    80204c9c:	00820517          	auipc	a0,0x820
    80204ca0:	3c450513          	addi	a0,a0,964 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204ca4:	15a030ef          	jal	ra,80207dfe <vector_back>
    80204ca8:	87aa                	mv	a5,a0
    80204caa:	639c                	ld	a5,0(a5)
    80204cac:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:29
    vector_pop(&FRAME_ALLOCATOR.recycled);
    80204cb0:	00820517          	auipc	a0,0x820
    80204cb4:	3b050513          	addi	a0,a0,944 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204cb8:	102030ef          	jal	ra,80207dba <vector_pop>
    80204cbc:	a8a9                	j	80204d16 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:31
  } else {
    if (FRAME_ALLOCATOR.current == FRAME_ALLOCATOR.end) {
    80204cbe:	00820797          	auipc	a5,0x820
    80204cc2:	39278793          	addi	a5,a5,914 # 80a25050 <FRAME_ALLOCATOR>
    80204cc6:	6398                	ld	a4,0(a5)
    80204cc8:	00820797          	auipc	a5,0x820
    80204ccc:	38878793          	addi	a5,a5,904 # 80a25050 <FRAME_ALLOCATOR>
    80204cd0:	679c                	ld	a5,8(a5)
    80204cd2:	00f71f63          	bne	a4,a5,80204cf0 <frame_alloc+0x70>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:32
      panic("No empty physical page.\n");
    80204cd6:	00003617          	auipc	a2,0x3
    80204cda:	63260613          	addi	a2,a2,1586 # 80208308 <MMIO+0x10>
    80204cde:	02000593          	li	a1,32
    80204ce2:	00003517          	auipc	a0,0x3
    80204ce6:	64650513          	addi	a0,a0,1606 # 80208328 <MMIO+0x30>
    80204cea:	1c1010ef          	jal	ra,802066aa <_panic>
    80204cee:	a025                	j	80204d16 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:34
    } else {
      ppn = FRAME_ALLOCATOR.current;
    80204cf0:	00820797          	auipc	a5,0x820
    80204cf4:	36078793          	addi	a5,a5,864 # 80a25050 <FRAME_ALLOCATOR>
    80204cf8:	639c                	ld	a5,0(a5)
    80204cfa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:35
      FRAME_ALLOCATOR.current++;
    80204cfe:	00820797          	auipc	a5,0x820
    80204d02:	35278793          	addi	a5,a5,850 # 80a25050 <FRAME_ALLOCATOR>
    80204d06:	639c                	ld	a5,0(a5)
    80204d08:	00178713          	addi	a4,a5,1
    80204d0c:	00820797          	auipc	a5,0x820
    80204d10:	34478793          	addi	a5,a5,836 # 80a25050 <FRAME_ALLOCATOR>
    80204d14:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:38
    }
  }
  memset((uint8_t *)pn2addr(ppn), 0, PAGE_SIZE);
    80204d16:	fe843783          	ld	a5,-24(s0)
    80204d1a:	07b2                	slli	a5,a5,0xc
    80204d1c:	6605                	lui	a2,0x1
    80204d1e:	4581                	li	a1,0
    80204d20:	853e                	mv	a0,a5
    80204d22:	a81fe0ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:39
  return ppn;
    80204d26:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:40
}
    80204d2a:	853e                	mv	a0,a5
    80204d2c:	60e2                	ld	ra,24(sp)
    80204d2e:	6442                	ld	s0,16(sp)
    80204d30:	6105                	addi	sp,sp,32
    80204d32:	8082                	ret

0000000080204d34 <frame_dealloc>:
frame_dealloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:42

void frame_dealloc(PhysPageNum ppn) {
    80204d34:	7139                	addi	sp,sp,-64
    80204d36:	fc06                	sd	ra,56(sp)
    80204d38:	f822                	sd	s0,48(sp)
    80204d3a:	0080                	addi	s0,sp,64
    80204d3c:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:43
  bool in_recycled = false;
    80204d40:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:44
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80204d44:	00820797          	auipc	a5,0x820
    80204d48:	30c78793          	addi	a5,a5,780 # 80a25050 <FRAME_ALLOCATOR>
    80204d4c:	779c                	ld	a5,40(a5)
    80204d4e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204d52:	fe043023          	sd	zero,-32(s0)
    80204d56:	a02d                	j	80204d80 <frame_dealloc+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:46
    if (x[i] == ppn) {
    80204d58:	fe043783          	ld	a5,-32(s0)
    80204d5c:	078e                	slli	a5,a5,0x3
    80204d5e:	fd843703          	ld	a4,-40(s0)
    80204d62:	97ba                	add	a5,a5,a4
    80204d64:	6398                	ld	a4,0(a5)
    80204d66:	fc843783          	ld	a5,-56(s0)
    80204d6a:	00f71663          	bne	a4,a5,80204d76 <frame_dealloc+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:47
      in_recycled = true;
    80204d6e:	4785                	li	a5,1
    80204d70:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:48
      break;
    80204d74:	a839                	j	80204d92 <frame_dealloc+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45 (discriminator 2)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204d76:	fe043783          	ld	a5,-32(s0)
    80204d7a:	0785                	addi	a5,a5,1
    80204d7c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:45 (discriminator 1)
    80204d80:	00820797          	auipc	a5,0x820
    80204d84:	2d078793          	addi	a5,a5,720 # 80a25050 <FRAME_ALLOCATOR>
    80204d88:	6b9c                	ld	a5,16(a5)
    80204d8a:	fe043703          	ld	a4,-32(s0)
    80204d8e:	fcf765e3          	bltu	a4,a5,80204d58 <frame_dealloc+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:51
    }
  }
  if (ppn >= FRAME_ALLOCATOR.current || in_recycled) {
    80204d92:	00820797          	auipc	a5,0x820
    80204d96:	2be78793          	addi	a5,a5,702 # 80a25050 <FRAME_ALLOCATOR>
    80204d9a:	6398                	ld	a4,0(a5)
    80204d9c:	fc843783          	ld	a5,-56(s0)
    80204da0:	00e7f663          	bgeu	a5,a4,80204dac <frame_dealloc+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:51 (discriminator 1)
    80204da4:	fec42783          	lw	a5,-20(s0)
    80204da8:	2781                	sext.w	a5,a5
    80204daa:	cf89                	beqz	a5,80204dc4 <frame_dealloc+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:52
    panic("Frame ppn= has not been allocated!\n");
    80204dac:	00003617          	auipc	a2,0x3
    80204db0:	5a460613          	addi	a2,a2,1444 # 80208350 <MMIO+0x58>
    80204db4:	03400593          	li	a1,52
    80204db8:	00003517          	auipc	a0,0x3
    80204dbc:	57050513          	addi	a0,a0,1392 # 80208328 <MMIO+0x30>
    80204dc0:	0eb010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:54
  }
  vector_push(&FRAME_ALLOCATOR.recycled, &ppn);
    80204dc4:	fc840793          	addi	a5,s0,-56
    80204dc8:	85be                	mv	a1,a5
    80204dca:	00820517          	auipc	a0,0x820
    80204dce:	29650513          	addi	a0,a0,662 # 80a25060 <FRAME_ALLOCATOR+0x10>
    80204dd2:	71f020ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:55
}
    80204dd6:	0001                	nop
    80204dd8:	70e2                	ld	ra,56(sp)
    80204dda:	7442                	ld	s0,48(sp)
    80204ddc:	6121                	addi	sp,sp,64
    80204dde:	8082                	ret

0000000080204de0 <frame_remaining_pages>:
frame_remaining_pages():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:57

uint64_t frame_remaining_pages() {
    80204de0:	1101                	addi	sp,sp,-32
    80204de2:	ec22                	sd	s0,24(sp)
    80204de4:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:58
  uint64_t x = (uint64_t)(FRAME_ALLOCATOR.end - FRAME_ALLOCATOR.current);
    80204de6:	00820797          	auipc	a5,0x820
    80204dea:	26a78793          	addi	a5,a5,618 # 80a25050 <FRAME_ALLOCATOR>
    80204dee:	6798                	ld	a4,8(a5)
    80204df0:	00820797          	auipc	a5,0x820
    80204df4:	26078793          	addi	a5,a5,608 # 80a25050 <FRAME_ALLOCATOR>
    80204df8:	639c                	ld	a5,0(a5)
    80204dfa:	40f707b3          	sub	a5,a4,a5
    80204dfe:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:59
  uint64_t y = (uint64_t)FRAME_ALLOCATOR.recycled.size;
    80204e02:	00820797          	auipc	a5,0x820
    80204e06:	24e78793          	addi	a5,a5,590 # 80a25050 <FRAME_ALLOCATOR>
    80204e0a:	6b9c                	ld	a5,16(a5)
    80204e0c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:60
  return x + y;
    80204e10:	fe843703          	ld	a4,-24(s0)
    80204e14:	fe043783          	ld	a5,-32(s0)
    80204e18:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:61
}
    80204e1a:	853e                	mv	a0,a5
    80204e1c:	6462                	ld	s0,24(sp)
    80204e1e:	6105                	addi	sp,sp,32
    80204e20:	8082                	ret

0000000080204e22 <frame_allocator_print>:
frame_allocator_print():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:63

void frame_allocator_print() {
    80204e22:	1101                	addi	sp,sp,-32
    80204e24:	ec06                	sd	ra,24(sp)
    80204e26:	e822                	sd	s0,16(sp)
    80204e28:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:64
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80204e2a:	00820797          	auipc	a5,0x820
    80204e2e:	22678793          	addi	a5,a5,550 # 80a25050 <FRAME_ALLOCATOR>
    80204e32:	779c                	ld	a5,40(a5)
    80204e34:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:65
  printk("FRAME_ALLOCATOR current = %llx, recycled = [ ",
    80204e38:	00820797          	auipc	a5,0x820
    80204e3c:	21878793          	addi	a5,a5,536 # 80a25050 <FRAME_ALLOCATOR>
    80204e40:	639c                	ld	a5,0(a5)
    80204e42:	85be                	mv	a1,a5
    80204e44:	00003517          	auipc	a0,0x3
    80204e48:	53450513          	addi	a0,a0,1332 # 80208378 <MMIO+0x80>
    80204e4c:	99ffd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67
         FRAME_ALLOCATOR.current);
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204e50:	fe043423          	sd	zero,-24(s0)
    80204e54:	a025                	j	80204e7c <frame_allocator_print+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:68 (discriminator 3)
    printk("%llx ", x[i]);
    80204e56:	fe843783          	ld	a5,-24(s0)
    80204e5a:	078e                	slli	a5,a5,0x3
    80204e5c:	fe043703          	ld	a4,-32(s0)
    80204e60:	97ba                	add	a5,a5,a4
    80204e62:	639c                	ld	a5,0(a5)
    80204e64:	85be                	mv	a1,a5
    80204e66:	00003517          	auipc	a0,0x3
    80204e6a:	54250513          	addi	a0,a0,1346 # 802083a8 <MMIO+0xb0>
    80204e6e:	97dfd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67 (discriminator 3)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++) {
    80204e72:	fe843783          	ld	a5,-24(s0)
    80204e76:	0785                	addi	a5,a5,1
    80204e78:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:67 (discriminator 1)
    80204e7c:	00820797          	auipc	a5,0x820
    80204e80:	1d478793          	addi	a5,a5,468 # 80a25050 <FRAME_ALLOCATOR>
    80204e84:	6b9c                	ld	a5,16(a5)
    80204e86:	fe843703          	ld	a4,-24(s0)
    80204e8a:	fcf766e3          	bltu	a4,a5,80204e56 <frame_allocator_print+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:70
  }
  printk("]\n");
    80204e8e:	00003517          	auipc	a0,0x3
    80204e92:	52250513          	addi	a0,a0,1314 # 802083b0 <MMIO+0xb8>
    80204e96:	955fd0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/frame_allocator.c:71
}
    80204e9a:	0001                	nop
    80204e9c:	60e2                	ld	ra,24(sp)
    80204e9e:	6442                	ld	s0,16(sp)
    80204ea0:	6105                	addi	sp,sp,32
    80204ea2:	8082                	ret

0000000080204ea4 <page_table_new>:
page_table_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:4
#include "mem.h"
#include "string.h"
#include "debug.h"
void page_table_new(PageTable *pt) {
    80204ea4:	7179                	addi	sp,sp,-48
    80204ea6:	f406                	sd	ra,40(sp)
    80204ea8:	f022                	sd	s0,32(sp)
    80204eaa:	1800                	addi	s0,sp,48
    80204eac:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:5
  PhysPageNum frame = frame_alloc();
    80204eb0:	dd1ff0ef          	jal	ra,80204c80 <frame_alloc>
    80204eb4:	87aa                	mv	a5,a0
    80204eb6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:6
  pt->root_ppn = frame;
    80204eba:	fe843703          	ld	a4,-24(s0)
    80204ebe:	fd843783          	ld	a5,-40(s0)
    80204ec2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:7
  vector_new(&pt->frames, sizeof(PhysPageNum));
    80204ec4:	fd843783          	ld	a5,-40(s0)
    80204ec8:	07a1                	addi	a5,a5,8
    80204eca:	45a1                	li	a1,8
    80204ecc:	853e                	mv	a0,a5
    80204ece:	5d1020ef          	jal	ra,80207c9e <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:8
  vector_push(&pt->frames, &frame);
    80204ed2:	fd843783          	ld	a5,-40(s0)
    80204ed6:	07a1                	addi	a5,a5,8
    80204ed8:	fe840713          	addi	a4,s0,-24
    80204edc:	85ba                	mv	a1,a4
    80204ede:	853e                	mv	a0,a5
    80204ee0:	611020ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:9
}
    80204ee4:	0001                	nop
    80204ee6:	70a2                	ld	ra,40(sp)
    80204ee8:	7402                	ld	s0,32(sp)
    80204eea:	6145                	addi	sp,sp,48
    80204eec:	8082                	ret

0000000080204eee <page_table_free>:
page_table_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:11

void page_table_free(PageTable *pt) {
    80204eee:	7179                	addi	sp,sp,-48
    80204ef0:	f406                	sd	ra,40(sp)
    80204ef2:	f022                	sd	s0,32(sp)
    80204ef4:	1800                	addi	s0,sp,48
    80204ef6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:13
  PhysPageNum frame;
  while (!vector_empty(&pt->frames)) {
    80204efa:	a02d                	j	80204f24 <page_table_free+0x36>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:14
    frame = *(PhysPageNum *)vector_back(&pt->frames);
    80204efc:	fd843783          	ld	a5,-40(s0)
    80204f00:	07a1                	addi	a5,a5,8
    80204f02:	853e                	mv	a0,a5
    80204f04:	6fb020ef          	jal	ra,80207dfe <vector_back>
    80204f08:	87aa                	mv	a5,a0
    80204f0a:	639c                	ld	a5,0(a5)
    80204f0c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:15
    vector_pop(&pt->frames);
    80204f10:	fd843783          	ld	a5,-40(s0)
    80204f14:	07a1                	addi	a5,a5,8
    80204f16:	853e                	mv	a0,a5
    80204f18:	6a3020ef          	jal	ra,80207dba <vector_pop>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:16
    frame_dealloc(frame);
    80204f1c:	fe843503          	ld	a0,-24(s0)
    80204f20:	e15ff0ef          	jal	ra,80204d34 <frame_dealloc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:13
  while (!vector_empty(&pt->frames)) {
    80204f24:	fd843783          	ld	a5,-40(s0)
    80204f28:	07a1                	addi	a5,a5,8
    80204f2a:	853e                	mv	a0,a5
    80204f2c:	725020ef          	jal	ra,80207e50 <vector_empty>
    80204f30:	87aa                	mv	a5,a0
    80204f32:	d7e9                	beqz	a5,80204efc <page_table_free+0xe>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:18
  }
  vector_free(&pt->frames);
    80204f34:	fd843783          	ld	a5,-40(s0)
    80204f38:	07a1                	addi	a5,a5,8
    80204f3a:	853e                	mv	a0,a5
    80204f3c:	737020ef          	jal	ra,80207e72 <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:19
}
    80204f40:	0001                	nop
    80204f42:	70a2                	ld	ra,40(sp)
    80204f44:	7402                	ld	s0,32(sp)
    80204f46:	6145                	addi	sp,sp,48
    80204f48:	8082                	ret

0000000080204f4a <page_table_from_token>:
page_table_from_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:21

void page_table_from_token(PageTable *pt, uint64_t satp) {
    80204f4a:	1101                	addi	sp,sp,-32
    80204f4c:	ec22                	sd	s0,24(sp)
    80204f4e:	1000                	addi	s0,sp,32
    80204f50:	fea43423          	sd	a0,-24(s0)
    80204f54:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:22
  pt->root_ppn = (PhysPageNum)(satp & ((1L << 44) - 1));
    80204f58:	fe043703          	ld	a4,-32(s0)
    80204f5c:	57fd                	li	a5,-1
    80204f5e:	83d1                	srli	a5,a5,0x14
    80204f60:	8f7d                	and	a4,a4,a5
    80204f62:	fe843783          	ld	a5,-24(s0)
    80204f66:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:23
}
    80204f68:	0001                	nop
    80204f6a:	6462                	ld	s0,24(sp)
    80204f6c:	6105                	addi	sp,sp,32
    80204f6e:	8082                	ret

0000000080204f70 <page_table_find_pte_create>:
page_table_find_pte_create():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:25

PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn) {
    80204f70:	711d                	addi	sp,sp,-96
    80204f72:	ec86                	sd	ra,88(sp)
    80204f74:	e8a2                	sd	s0,80(sp)
    80204f76:	1080                	addi	s0,sp,96
    80204f78:	faa43423          	sd	a0,-88(s0)
    80204f7c:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:27
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    80204f80:	fb840793          	addi	a5,s0,-72
    80204f84:	85be                	mv	a1,a5
    80204f86:	fa043503          	ld	a0,-96(s0)
    80204f8a:	bfbff0ef          	jal	ra,80204b84 <vpn_indexes>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:28
  PhysPageNum ppn = pt->root_ppn;
    80204f8e:	fa843783          	ld	a5,-88(s0)
    80204f92:	639c                	ld	a5,0(a5)
    80204f94:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:29
  PageTableEntry *result = NULL;
    80204f98:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30
  for (unsigned i = 0; i < 3; i++) {
    80204f9c:	fc042e23          	sw	zero,-36(s0)
    80204fa0:	a869                	j	8020503a <page_table_find_pte_create+0xca>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:31
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    80204fa2:	fe843503          	ld	a0,-24(s0)
    80204fa6:	c33ff0ef          	jal	ra,80204bd8 <ppn_get_pte_array>
    80204faa:	872a                	mv	a4,a0
    80204fac:	fdc46783          	lwu	a5,-36(s0)
    80204fb0:	078e                	slli	a5,a5,0x3
    80204fb2:	ff040693          	addi	a3,s0,-16
    80204fb6:	97b6                	add	a5,a5,a3
    80204fb8:	fc87b783          	ld	a5,-56(a5)
    80204fbc:	078e                	slli	a5,a5,0x3
    80204fbe:	97ba                	add	a5,a5,a4
    80204fc0:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:32
    if (i == 2) {
    80204fc4:	fdc42783          	lw	a5,-36(s0)
    80204fc8:	0007871b          	sext.w	a4,a5
    80204fcc:	4789                	li	a5,2
    80204fce:	00f71763          	bne	a4,a5,80204fdc <page_table_find_pte_create+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:33
      result = pte;
    80204fd2:	fd043783          	ld	a5,-48(s0)
    80204fd6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:34
      break;
    80204fda:	a0bd                	j	80205048 <page_table_find_pte_create+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:36
    }
    if (!pte_is_valid(*pte)) {
    80204fdc:	fd043783          	ld	a5,-48(s0)
    80204fe0:	639c                	ld	a5,0(a5)
    80204fe2:	8b85                	andi	a5,a5,1
    80204fe4:	ef85                	bnez	a5,8020501c <page_table_find_pte_create+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:37
      PhysPageNum frame = frame_alloc();
    80204fe6:	c9bff0ef          	jal	ra,80204c80 <frame_alloc>
    80204fea:	87aa                	mv	a5,a0
    80204fec:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:38
      if (!frame) {
    80204ff0:	fb043783          	ld	a5,-80(s0)
    80204ff4:	e399                	bnez	a5,80204ffa <page_table_find_pte_create+0x8a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:39
        return NULL;
    80204ff6:	4781                	li	a5,0
    80204ff8:	a891                	j	8020504c <page_table_find_pte_create+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:41
      }
      *pte = pte_new(frame, PTE_V);
    80204ffa:	fb043783          	ld	a5,-80(s0)
    80204ffe:	07aa                	slli	a5,a5,0xa
    80205000:	0017e713          	ori	a4,a5,1
    80205004:	fd043783          	ld	a5,-48(s0)
    80205008:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:42
      vector_push(&pt->frames, &frame);
    8020500a:	fa843783          	ld	a5,-88(s0)
    8020500e:	07a1                	addi	a5,a5,8
    80205010:	fb040713          	addi	a4,s0,-80
    80205014:	85ba                	mv	a1,a4
    80205016:	853e                	mv	a0,a5
    80205018:	4d9020ef          	jal	ra,80207cf0 <vector_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:44 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    8020501c:	fd043783          	ld	a5,-48(s0)
    80205020:	639c                	ld	a5,0(a5)
    80205022:	00a7d713          	srli	a4,a5,0xa
    80205026:	57fd                	li	a5,-1
    80205028:	83d1                	srli	a5,a5,0x14
    8020502a:	8ff9                	and	a5,a5,a4
    8020502c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) {
    80205030:	fdc42783          	lw	a5,-36(s0)
    80205034:	2785                	addiw	a5,a5,1
    80205036:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:30 (discriminator 1)
    8020503a:	fdc42783          	lw	a5,-36(s0)
    8020503e:	0007871b          	sext.w	a4,a5
    80205042:	4789                	li	a5,2
    80205044:	f4e7ffe3          	bgeu	a5,a4,80204fa2 <page_table_find_pte_create+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:46
  }
  return result;
    80205048:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:47 (discriminator 1)
}
    8020504c:	853e                	mv	a0,a5
    8020504e:	60e6                	ld	ra,88(sp)
    80205050:	6446                	ld	s0,80(sp)
    80205052:	6125                	addi	sp,sp,96
    80205054:	8082                	ret

0000000080205056 <page_table_find_pte>:
page_table_find_pte():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:49

PageTableEntry *page_table_find_pte(PageTable *pt, VirtPageNum vpn) {
    80205056:	711d                	addi	sp,sp,-96
    80205058:	ec86                	sd	ra,88(sp)
    8020505a:	e8a2                	sd	s0,80(sp)
    8020505c:	1080                	addi	s0,sp,96
    8020505e:	faa43423          	sd	a0,-88(s0)
    80205062:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:51
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    80205066:	fb840793          	addi	a5,s0,-72
    8020506a:	85be                	mv	a1,a5
    8020506c:	fa043503          	ld	a0,-96(s0)
    80205070:	b15ff0ef          	jal	ra,80204b84 <vpn_indexes>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:52
  PhysPageNum ppn = pt->root_ppn;
    80205074:	fa843783          	ld	a5,-88(s0)
    80205078:	639c                	ld	a5,0(a5)
    8020507a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:53
  PageTableEntry *result = NULL;
    8020507e:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55
  PageTableEntry *pte;
  for (unsigned i = 0; i < 3; i++) {
    80205082:	fc042e23          	sw	zero,-36(s0)
    80205086:	a0a5                	j	802050ee <page_table_find_pte+0x98>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:56
    pte = ppn_get_pte_array(ppn) + idxs[i];
    80205088:	fe843503          	ld	a0,-24(s0)
    8020508c:	b4dff0ef          	jal	ra,80204bd8 <ppn_get_pte_array>
    80205090:	872a                	mv	a4,a0
    80205092:	fdc46783          	lwu	a5,-36(s0)
    80205096:	078e                	slli	a5,a5,0x3
    80205098:	ff040693          	addi	a3,s0,-16
    8020509c:	97b6                	add	a5,a5,a3
    8020509e:	fc87b783          	ld	a5,-56(a5)
    802050a2:	078e                	slli	a5,a5,0x3
    802050a4:	97ba                	add	a5,a5,a4
    802050a6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:57
    if (!pte_is_valid(*pte)) {
    802050aa:	fd043783          	ld	a5,-48(s0)
    802050ae:	639c                	ld	a5,0(a5)
    802050b0:	8b85                	andi	a5,a5,1
    802050b2:	e399                	bnez	a5,802050b8 <page_table_find_pte+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:58
      return NULL;
    802050b4:	4781                	li	a5,0
    802050b6:	a0a9                	j	80205100 <page_table_find_pte+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:60
    }
    if (i == 2) {
    802050b8:	fdc42783          	lw	a5,-36(s0)
    802050bc:	0007871b          	sext.w	a4,a5
    802050c0:	4789                	li	a5,2
    802050c2:	00f71763          	bne	a4,a5,802050d0 <page_table_find_pte+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:61
      result = pte;
    802050c6:	fd043783          	ld	a5,-48(s0)
    802050ca:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:62
      break;
    802050ce:	a03d                	j	802050fc <page_table_find_pte+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:64 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    802050d0:	fd043783          	ld	a5,-48(s0)
    802050d4:	639c                	ld	a5,0(a5)
    802050d6:	00a7d713          	srli	a4,a5,0xa
    802050da:	57fd                	li	a5,-1
    802050dc:	83d1                	srli	a5,a5,0x14
    802050de:	8ff9                	and	a5,a5,a4
    802050e0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) {
    802050e4:	fdc42783          	lw	a5,-36(s0)
    802050e8:	2785                	addiw	a5,a5,1
    802050ea:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:55 (discriminator 1)
    802050ee:	fdc42783          	lw	a5,-36(s0)
    802050f2:	0007871b          	sext.w	a4,a5
    802050f6:	4789                	li	a5,2
    802050f8:	f8e7f8e3          	bgeu	a5,a4,80205088 <page_table_find_pte+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:66
  }
  return result;
    802050fc:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:67 (discriminator 1)
}
    80205100:	853e                	mv	a0,a5
    80205102:	60e6                	ld	ra,88(sp)
    80205104:	6446                	ld	s0,80(sp)
    80205106:	6125                	addi	sp,sp,96
    80205108:	8082                	ret

000000008020510a <page_table_map>:
page_table_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:70

void page_table_map(PageTable *pt, VirtPageNum vpn, PhysPageNum ppn,
                    PTEFlags flags) {
    8020510a:	7139                	addi	sp,sp,-64
    8020510c:	fc06                	sd	ra,56(sp)
    8020510e:	f822                	sd	s0,48(sp)
    80205110:	0080                	addi	s0,sp,64
    80205112:	fca43c23          	sd	a0,-40(s0)
    80205116:	fcb43823          	sd	a1,-48(s0)
    8020511a:	fcc43423          	sd	a2,-56(s0)
    8020511e:	87b6                	mv	a5,a3
    80205120:	fcf403a3          	sb	a5,-57(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:71
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80205124:	fd043583          	ld	a1,-48(s0)
    80205128:	fd843503          	ld	a0,-40(s0)
    8020512c:	e45ff0ef          	jal	ra,80204f70 <page_table_find_pte_create>
    80205130:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:72
  if (pte_is_valid(*pte)) {
    80205134:	fe843783          	ld	a5,-24(s0)
    80205138:	639c                	ld	a5,0(a5)
    8020513a:	8b85                	andi	a5,a5,1
    8020513c:	cf89                	beqz	a5,80205156 <page_table_map+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:73
    panic("VPN 0x is mapped before mapping.\n");
    8020513e:	00003617          	auipc	a2,0x3
    80205142:	28a60613          	addi	a2,a2,650 # 802083c8 <MMIO+0x10>
    80205146:	04900593          	li	a1,73
    8020514a:	00003517          	auipc	a0,0x3
    8020514e:	2a650513          	addi	a0,a0,678 # 802083f0 <MMIO+0x38>
    80205152:	558010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:75
  }
  *pte = pte_new(ppn, flags | PTE_V);
    80205156:	fc843783          	ld	a5,-56(s0)
    8020515a:	00a79713          	slli	a4,a5,0xa
    8020515e:	fc744783          	lbu	a5,-57(s0)
    80205162:	8fd9                	or	a5,a5,a4
    80205164:	0017e713          	ori	a4,a5,1
    80205168:	fe843783          	ld	a5,-24(s0)
    8020516c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:76
}
    8020516e:	0001                	nop
    80205170:	70e2                	ld	ra,56(sp)
    80205172:	7442                	ld	s0,48(sp)
    80205174:	6121                	addi	sp,sp,64
    80205176:	8082                	ret

0000000080205178 <page_table_unmap>:
page_table_unmap():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:78

void page_table_unmap(PageTable *pt, VirtPageNum vpn) {
    80205178:	7179                	addi	sp,sp,-48
    8020517a:	f406                	sd	ra,40(sp)
    8020517c:	f022                	sd	s0,32(sp)
    8020517e:	1800                	addi	s0,sp,48
    80205180:	fca43c23          	sd	a0,-40(s0)
    80205184:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:79
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80205188:	fd043583          	ld	a1,-48(s0)
    8020518c:	fd843503          	ld	a0,-40(s0)
    80205190:	de1ff0ef          	jal	ra,80204f70 <page_table_find_pte_create>
    80205194:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:80
  if (!pte_is_valid(*pte)) {
    80205198:	fe843783          	ld	a5,-24(s0)
    8020519c:	639c                	ld	a5,0(a5)
    8020519e:	8b85                	andi	a5,a5,1
    802051a0:	ef89                	bnez	a5,802051ba <page_table_unmap+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:81 (discriminator 1)
    ASSERT(0);
    802051a2:	00003617          	auipc	a2,0x3
    802051a6:	26e60613          	addi	a2,a2,622 # 80208410 <MMIO+0x58>
    802051aa:	05100593          	li	a1,81
    802051ae:	00003517          	auipc	a0,0x3
    802051b2:	24250513          	addi	a0,a0,578 # 802083f0 <MMIO+0x38>
    802051b6:	4f4010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:83
  }
  *pte = pte_empty();
    802051ba:	fe843783          	ld	a5,-24(s0)
    802051be:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:84
}
    802051c2:	0001                	nop
    802051c4:	70a2                	ld	ra,40(sp)
    802051c6:	7402                	ld	s0,32(sp)
    802051c8:	6145                	addi	sp,sp,48
    802051ca:	8082                	ret

00000000802051cc <page_table_translate>:
page_table_translate():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:86

PageTableEntry *page_table_translate(PageTable *pt, VirtPageNum vpn) {
    802051cc:	7179                	addi	sp,sp,-48
    802051ce:	f406                	sd	ra,40(sp)
    802051d0:	f022                	sd	s0,32(sp)
    802051d2:	1800                	addi	s0,sp,48
    802051d4:	fca43c23          	sd	a0,-40(s0)
    802051d8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:87
  PageTableEntry *pte = page_table_find_pte(pt, vpn);
    802051dc:	fd043583          	ld	a1,-48(s0)
    802051e0:	fd843503          	ld	a0,-40(s0)
    802051e4:	e73ff0ef          	jal	ra,80205056 <page_table_find_pte>
    802051e8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:88
  if (pte == NULL) {
    802051ec:	fe843783          	ld	a5,-24(s0)
    802051f0:	ef89                	bnez	a5,8020520a <page_table_translate+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:89 (discriminator 1)
    ASSERT(0);
    802051f2:	00003617          	auipc	a2,0x3
    802051f6:	21e60613          	addi	a2,a2,542 # 80208410 <MMIO+0x58>
    802051fa:	05900593          	li	a1,89
    802051fe:	00003517          	auipc	a0,0x3
    80205202:	1f250513          	addi	a0,a0,498 # 802083f0 <MMIO+0x38>
    80205206:	4a4010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:91
  }
  return pte;
    8020520a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:92
}
    8020520e:	853e                	mv	a0,a5
    80205210:	70a2                	ld	ra,40(sp)
    80205212:	7402                	ld	s0,32(sp)
    80205214:	6145                	addi	sp,sp,48
    80205216:	8082                	ret

0000000080205218 <page_table_token>:
page_table_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:94

uint64_t page_table_token(PageTable *pt) { return ((8L << 60) | pt->root_ppn); }
    80205218:	1101                	addi	sp,sp,-32
    8020521a:	ec22                	sd	s0,24(sp)
    8020521c:	1000                	addi	s0,sp,32
    8020521e:	fea43423          	sd	a0,-24(s0)
    80205222:	fe843783          	ld	a5,-24(s0)
    80205226:	6398                	ld	a4,0(a5)
    80205228:	57fd                	li	a5,-1
    8020522a:	17fe                	slli	a5,a5,0x3f
    8020522c:	8fd9                	or	a5,a5,a4
    8020522e:	853e                	mv	a0,a5
    80205230:	6462                	ld	s0,24(sp)
    80205232:	6105                	addi	sp,sp,32
    80205234:	8082                	ret

0000000080205236 <copy_byte_buffer>:
copy_byte_buffer():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:97

int64_t copy_byte_buffer(uint64_t token, uint8_t *kernel, uint8_t *user,
                         uint64_t len, uint64_t direction) {
    80205236:	7171                	addi	sp,sp,-176
    80205238:	f506                	sd	ra,168(sp)
    8020523a:	f122                	sd	s0,160(sp)
    8020523c:	1900                	addi	s0,sp,176
    8020523e:	f6a43c23          	sd	a0,-136(s0)
    80205242:	f6b43823          	sd	a1,-144(s0)
    80205246:	f6c43423          	sd	a2,-152(s0)
    8020524a:	f6d43023          	sd	a3,-160(s0)
    8020524e:	f4e43c23          	sd	a4,-168(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:98
  if (direction != FROM_USER && direction != TO_USER) {
    80205252:	f5843783          	ld	a5,-168(s0)
    80205256:	c395                	beqz	a5,8020527a <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:98 (discriminator 1)
    80205258:	f5843703          	ld	a4,-168(s0)
    8020525c:	4785                	li	a5,1
    8020525e:	00f70e63          	beq	a4,a5,8020527a <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:99
    panic("Unknown direction in copy_byte_buffer.\n");
    80205262:	00003617          	auipc	a2,0x3
    80205266:	1c660613          	addi	a2,a2,454 # 80208428 <MMIO+0x70>
    8020526a:	06300593          	li	a1,99
    8020526e:	00003517          	auipc	a0,0x3
    80205272:	18250513          	addi	a0,a0,386 # 802083f0 <MMIO+0x38>
    80205276:	434010ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:101
  }
  if (len == 0) {
    8020527a:	f6043783          	ld	a5,-160(s0)
    8020527e:	e399                	bnez	a5,80205284 <copy_byte_buffer+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:102
    return 0;
    80205280:	4781                	li	a5,0
    80205282:	a439                	j	80205490 <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:106
  }

  PageTable page_table;
  page_table_from_token(&page_table, token);
    80205284:	f8040793          	addi	a5,s0,-128
    80205288:	f7843583          	ld	a1,-136(s0)
    8020528c:	853e                	mv	a0,a5
    8020528e:	cbdff0ef          	jal	ra,80204f4a <page_table_from_token>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:107
  uint64_t start = (uint64_t)user;
    80205292:	f6843783          	ld	a5,-152(s0)
    80205296:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:108
  uint64_t end = start + len;
    8020529a:	fe843703          	ld	a4,-24(s0)
    8020529e:	f6043783          	ld	a5,-160(s0)
    802052a2:	97ba                	add	a5,a5,a4
    802052a4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:109
  uint64_t kernel_i = 0;
    802052a8:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:117
  VirtPageNum vpn;
  PhysPageNum ppn;
  PageTableEntry *pte_ptr;
  uint8_t *bytes_array;

  while (start < end) {
    802052ac:	aad1                	j	80205480 <copy_byte_buffer+0x24a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:118
    start_va = (VirtAddr)start;
    802052ae:	fe843783          	ld	a5,-24(s0)
    802052b2:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:119
    vpn = page_floor(start_va);
    802052b6:	fc843783          	ld	a5,-56(s0)
    802052ba:	83b1                	srli	a5,a5,0xc
    802052bc:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:120
    pte_ptr = page_table_translate(&page_table, vpn);
    802052c0:	f8040793          	addi	a5,s0,-128
    802052c4:	fc043583          	ld	a1,-64(s0)
    802052c8:	853e                	mv	a0,a5
    802052ca:	f03ff0ef          	jal	ra,802051cc <page_table_translate>
    802052ce:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:121
    if (pte_ptr == NULL) {
    802052d2:	fb843783          	ld	a5,-72(s0)
    802052d6:	e399                	bnez	a5,802052dc <copy_byte_buffer+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:122
      return -1;
    802052d8:	57fd                	li	a5,-1
    802052da:	aa5d                	j	80205490 <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:124
    }
    ppn = pte_ppn(*pte_ptr);
    802052dc:	fb843783          	ld	a5,-72(s0)
    802052e0:	639c                	ld	a5,0(a5)
    802052e2:	00a7d713          	srli	a4,a5,0xa
    802052e6:	57fd                	li	a5,-1
    802052e8:	83d1                	srli	a5,a5,0x14
    802052ea:	8ff9                	and	a5,a5,a4
    802052ec:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:125
    vpn++;
    802052f0:	fc043783          	ld	a5,-64(s0)
    802052f4:	0785                	addi	a5,a5,1
    802052f6:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:126
    end_va = (VirtAddr)pn2addr(vpn);
    802052fa:	fc043783          	ld	a5,-64(s0)
    802052fe:	07b2                	slli	a5,a5,0xc
    80205300:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:127
    if ((VirtAddr)end < end_va) {
    80205304:	fd043703          	ld	a4,-48(s0)
    80205308:	fd843783          	ld	a5,-40(s0)
    8020530c:	00f77663          	bgeu	a4,a5,80205318 <copy_byte_buffer+0xe2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:128
      end_va = (VirtAddr)end;
    80205310:	fd043783          	ld	a5,-48(s0)
    80205314:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:130
    }
    bytes_array = ppn_get_bytes_array(ppn);
    80205318:	fb043503          	ld	a0,-80(s0)
    8020531c:	8ddff0ef          	jal	ra,80204bf8 <ppn_get_bytes_array>
    80205320:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:131
    if (page_aligned(end_va)) {
    80205324:	fd843703          	ld	a4,-40(s0)
    80205328:	6785                	lui	a5,0x1
    8020532a:	17fd                	addi	a5,a5,-1
    8020532c:	8ff9                	and	a5,a5,a4
    8020532e:	e3d1                	bnez	a5,802053b2 <copy_byte_buffer+0x17c>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:132
      if (direction == FROM_USER)
    80205330:	f5843783          	ld	a5,-168(s0)
    80205334:	eb95                	bnez	a5,80205368 <copy_byte_buffer+0x132>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:133
        memcpy(kernel + kernel_i, bytes_array,
    80205336:	f7043703          	ld	a4,-144(s0)
    8020533a:	fe043783          	ld	a5,-32(s0)
    8020533e:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:134
               PAGE_SIZE - page_offset(start_va));
    80205342:	fc843783          	ld	a5,-56(s0)
    80205346:	2781                	sext.w	a5,a5
    80205348:	873e                	mv	a4,a5
    8020534a:	6785                	lui	a5,0x1
    8020534c:	17fd                	addi	a5,a5,-1
    8020534e:	8ff9                	and	a5,a5,a4
    80205350:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:133
        memcpy(kernel + kernel_i, bytes_array,
    80205352:	6705                	lui	a4,0x1
    80205354:	40f707bb          	subw	a5,a4,a5
    80205358:	2781                	sext.w	a5,a5
    8020535a:	863e                	mv	a2,a5
    8020535c:	fa843583          	ld	a1,-88(s0)
    80205360:	8536                	mv	a0,a3
    80205362:	bf2fe0ef          	jal	ra,80203754 <memcpy>
    80205366:	a80d                	j	80205398 <copy_byte_buffer+0x162>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:136
      else
        memcpy(bytes_array, kernel + kernel_i,
    80205368:	f7043703          	ld	a4,-144(s0)
    8020536c:	fe043783          	ld	a5,-32(s0)
    80205370:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:137
               PAGE_SIZE - page_offset(start_va));
    80205374:	fc843783          	ld	a5,-56(s0)
    80205378:	2781                	sext.w	a5,a5
    8020537a:	873e                	mv	a4,a5
    8020537c:	6785                	lui	a5,0x1
    8020537e:	17fd                	addi	a5,a5,-1
    80205380:	8ff9                	and	a5,a5,a4
    80205382:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:136
        memcpy(bytes_array, kernel + kernel_i,
    80205384:	6705                	lui	a4,0x1
    80205386:	40f707bb          	subw	a5,a4,a5
    8020538a:	2781                	sext.w	a5,a5
    8020538c:	863e                	mv	a2,a5
    8020538e:	85b6                	mv	a1,a3
    80205390:	fa843503          	ld	a0,-88(s0)
    80205394:	bc0fe0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:138
      kernel_i += PAGE_SIZE - page_offset(start_va);
    80205398:	fc843703          	ld	a4,-56(s0)
    8020539c:	6785                	lui	a5,0x1
    8020539e:	17fd                	addi	a5,a5,-1
    802053a0:	8ff9                	and	a5,a5,a4
    802053a2:	fe043703          	ld	a4,-32(s0)
    802053a6:	8f1d                	sub	a4,a4,a5
    802053a8:	6785                	lui	a5,0x1
    802053aa:	97ba                	add	a5,a5,a4
    802053ac:	fef43023          	sd	a5,-32(s0)
    802053b0:	a0e1                	j	80205478 <copy_byte_buffer+0x242>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:140
    } else {
      if (direction == FROM_USER)
    802053b2:	f5843783          	ld	a5,-168(s0)
    802053b6:	eba9                	bnez	a5,80205408 <copy_byte_buffer+0x1d2>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:141
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    802053b8:	f7043703          	ld	a4,-144(s0)
    802053bc:	fe043783          	ld	a5,-32(s0)
    802053c0:	00f706b3          	add	a3,a4,a5
    802053c4:	fc843703          	ld	a4,-56(s0)
    802053c8:	6785                	lui	a5,0x1
    802053ca:	17fd                	addi	a5,a5,-1
    802053cc:	8ff9                	and	a5,a5,a4
    802053ce:	fa843703          	ld	a4,-88(s0)
    802053d2:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:142
               page_offset(end_va) - page_offset(start_va));
    802053d6:	fd843783          	ld	a5,-40(s0)
    802053da:	2781                	sext.w	a5,a5
    802053dc:	873e                	mv	a4,a5
    802053de:	6785                	lui	a5,0x1
    802053e0:	17fd                	addi	a5,a5,-1
    802053e2:	8ff9                	and	a5,a5,a4
    802053e4:	0007871b          	sext.w	a4,a5
    802053e8:	fc843783          	ld	a5,-56(s0)
    802053ec:	2781                	sext.w	a5,a5
    802053ee:	863e                	mv	a2,a5
    802053f0:	6785                	lui	a5,0x1
    802053f2:	17fd                	addi	a5,a5,-1
    802053f4:	8ff1                	and	a5,a5,a2
    802053f6:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:141
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    802053f8:	40f707bb          	subw	a5,a4,a5
    802053fc:	2781                	sext.w	a5,a5
    802053fe:	863e                	mv	a2,a5
    80205400:	8536                	mv	a0,a3
    80205402:	b52fe0ef          	jal	ra,80203754 <memcpy>
    80205406:	a881                	j	80205456 <copy_byte_buffer+0x220>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:144
      else
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    80205408:	fc843703          	ld	a4,-56(s0)
    8020540c:	6785                	lui	a5,0x1
    8020540e:	17fd                	addi	a5,a5,-1
    80205410:	8ff9                	and	a5,a5,a4
    80205412:	fa843703          	ld	a4,-88(s0)
    80205416:	00f706b3          	add	a3,a4,a5
    8020541a:	f7043703          	ld	a4,-144(s0)
    8020541e:	fe043783          	ld	a5,-32(s0)
    80205422:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:145
               page_offset(end_va) - page_offset(start_va));
    80205426:	fd843783          	ld	a5,-40(s0)
    8020542a:	2781                	sext.w	a5,a5
    8020542c:	873e                	mv	a4,a5
    8020542e:	6785                	lui	a5,0x1
    80205430:	17fd                	addi	a5,a5,-1
    80205432:	8ff9                	and	a5,a5,a4
    80205434:	0007871b          	sext.w	a4,a5
    80205438:	fc843783          	ld	a5,-56(s0)
    8020543c:	2781                	sext.w	a5,a5
    8020543e:	863e                	mv	a2,a5
    80205440:	6785                	lui	a5,0x1
    80205442:	17fd                	addi	a5,a5,-1
    80205444:	8ff1                	and	a5,a5,a2
    80205446:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:144
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    80205448:	40f707bb          	subw	a5,a4,a5
    8020544c:	2781                	sext.w	a5,a5
    8020544e:	863e                	mv	a2,a5
    80205450:	8536                	mv	a0,a3
    80205452:	b02fe0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:146
      kernel_i += page_offset(end_va) - page_offset(start_va);
    80205456:	fd843703          	ld	a4,-40(s0)
    8020545a:	6785                	lui	a5,0x1
    8020545c:	17fd                	addi	a5,a5,-1
    8020545e:	8f7d                	and	a4,a4,a5
    80205460:	fc843683          	ld	a3,-56(s0)
    80205464:	6785                	lui	a5,0x1
    80205466:	17fd                	addi	a5,a5,-1
    80205468:	8ff5                	and	a5,a5,a3
    8020546a:	40f707b3          	sub	a5,a4,a5
    8020546e:	fe043703          	ld	a4,-32(s0)
    80205472:	97ba                	add	a5,a5,a4
    80205474:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:148
    }
    start = (uint64_t)end_va;
    80205478:	fd843783          	ld	a5,-40(s0)
    8020547c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:117
  while (start < end) {
    80205480:	fe843703          	ld	a4,-24(s0)
    80205484:	fd043783          	ld	a5,-48(s0)
    80205488:	e2f763e3          	bltu	a4,a5,802052ae <copy_byte_buffer+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:150
  }
  return len;
    8020548c:	f6043783          	ld	a5,-160(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/page_table.c:151 (discriminator 1)
}
    80205490:	853e                	mv	a0,a5
    80205492:	70aa                	ld	ra,168(sp)
    80205494:	740a                	ld	s0,160(sp)
    80205496:	614d                	addi	sp,sp,176
    80205498:	8082                	ret

000000008020549a <mm_init>:
mm_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:4
#include "mem.h"

void mm_init() 
{
    8020549a:	1141                	addi	sp,sp,-16
    8020549c:	e406                	sd	ra,8(sp)
    8020549e:	e022                	sd	s0,0(sp)
    802054a0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:5
  heap_allocator_init();
    802054a2:	030000ef          	jal	ra,802054d2 <heap_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:6
  frame_allocator_init();
    802054a6:	f72ff0ef          	jal	ra,80204c18 <frame_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:7
  memory_set_kernel_init();
    802054aa:	a54ff0ef          	jal	ra,802046fe <memory_set_kernel_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:8
  memory_set_remap_test();
    802054ae:	de0ff0ef          	jal	ra,80204a8e <memory_set_remap_test>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:9
}
    802054b2:	0001                	nop
    802054b4:	60a2                	ld	ra,8(sp)
    802054b6:	6402                	ld	s0,0(sp)
    802054b8:	0141                	addi	sp,sp,16
    802054ba:	8082                	ret

00000000802054bc <mm_free>:
mm_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:11

void mm_free() {
    802054bc:	1141                	addi	sp,sp,-16
    802054be:	e406                	sd	ra,8(sp)
    802054c0:	e022                	sd	s0,0(sp)
    802054c2:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:12
  frame_allocator_free();
    802054c4:	f9eff0ef          	jal	ra,80204c62 <frame_allocator_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/mm.c:13
}
    802054c8:	0001                	nop
    802054ca:	60a2                	ld	ra,8(sp)
    802054cc:	6402                	ld	s0,0(sp)
    802054ce:	0141                	addi	sp,sp,16
    802054d0:	8082                	ret

00000000802054d2 <heap_allocator_init>:
heap_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:9
#include "mem.h"
#include "string.h"

static uint8_t HEAP_SPACE[KERNEL_HEAP_SIZE] __attribute__((aligned(4096)));

void heap_allocator_init() {
    802054d2:	1141                	addi	sp,sp,-16
    802054d4:	e406                	sd	ra,8(sp)
    802054d6:	e022                	sd	s0,0(sp)
    802054d8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:10
  memset(HEAP_SPACE, 0, KERNEL_HEAP_SIZE);
    802054da:	00300637          	lui	a2,0x300
    802054de:	4581                	li	a1,0
    802054e0:	00821517          	auipc	a0,0x821
    802054e4:	b2050513          	addi	a0,a0,-1248 # 80a26000 <HEAP_SPACE>
    802054e8:	abafe0ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:11
  bd_init(HEAP_SPACE, HEAP_SPACE + KERNEL_HEAP_SIZE);
    802054ec:	00b21797          	auipc	a5,0xb21
    802054f0:	b1478793          	addi	a5,a5,-1260 # 80d26000 <nsizes>
    802054f4:	85be                	mv	a1,a5
    802054f6:	00821517          	auipc	a0,0x821
    802054fa:	b0a50513          	addi	a0,a0,-1270 # 80a26000 <HEAP_SPACE>
    802054fe:	3cd000ef          	jal	ra,802060ca <bd_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem/heap_allocator.c:12
}
    80205502:	0001                	nop
    80205504:	60a2                	ld	ra,8(sp)
    80205506:	6402                	ld	s0,0(sp)
    80205508:	0141                	addi	sp,sp,16
    8020550a:	8082                	ret

000000008020550c <bit_isset>:
bit_isset():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:38
static Sz_info *bd_sizes;
static void *bd_base; // start address of memory managed by the buddy allocator
// static struct spinlock lock;

// Return 1 if bit at position index in array is set to 1
int bit_isset(char *array, int index) {
    8020550c:	7179                	addi	sp,sp,-48
    8020550e:	f422                	sd	s0,40(sp)
    80205510:	1800                	addi	s0,sp,48
    80205512:	fca43c23          	sd	a0,-40(s0)
    80205516:	87ae                	mv	a5,a1
    80205518:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:39
  char b = array[index / 8];
    8020551c:	fd442783          	lw	a5,-44(s0)
    80205520:	41f7d71b          	sraiw	a4,a5,0x1f
    80205524:	01d7571b          	srliw	a4,a4,0x1d
    80205528:	9fb9                	addw	a5,a5,a4
    8020552a:	4037d79b          	sraiw	a5,a5,0x3
    8020552e:	2781                	sext.w	a5,a5
    80205530:	873e                	mv	a4,a5
    80205532:	fd843783          	ld	a5,-40(s0)
    80205536:	97ba                	add	a5,a5,a4
    80205538:	0007c783          	lbu	a5,0(a5)
    8020553c:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:40
  char m = (1 << (index % 8));
    80205540:	fd442703          	lw	a4,-44(s0)
    80205544:	41f7579b          	sraiw	a5,a4,0x1f
    80205548:	01d7d79b          	srliw	a5,a5,0x1d
    8020554c:	9f3d                	addw	a4,a4,a5
    8020554e:	8b1d                	andi	a4,a4,7
    80205550:	40f707bb          	subw	a5,a4,a5
    80205554:	2781                	sext.w	a5,a5
    80205556:	4705                	li	a4,1
    80205558:	00f717bb          	sllw	a5,a4,a5
    8020555c:	2781                	sext.w	a5,a5
    8020555e:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:41
  return (b & m) == m;
    80205562:	fef44703          	lbu	a4,-17(s0)
    80205566:	fee44783          	lbu	a5,-18(s0)
    8020556a:	8ff9                	and	a5,a5,a4
    8020556c:	0ff7f793          	andi	a5,a5,255
    80205570:	fee44703          	lbu	a4,-18(s0)
    80205574:	2701                	sext.w	a4,a4
    80205576:	2781                	sext.w	a5,a5
    80205578:	40f707b3          	sub	a5,a4,a5
    8020557c:	0017b793          	seqz	a5,a5
    80205580:	0ff7f793          	andi	a5,a5,255
    80205584:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:42
}
    80205586:	853e                	mv	a0,a5
    80205588:	7422                	ld	s0,40(sp)
    8020558a:	6145                	addi	sp,sp,48
    8020558c:	8082                	ret

000000008020558e <bit_set>:
bit_set():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:45

// Set bit at position index in array to 1
void bit_set(char *array, int index) {
    8020558e:	7179                	addi	sp,sp,-48
    80205590:	f422                	sd	s0,40(sp)
    80205592:	1800                	addi	s0,sp,48
    80205594:	fca43c23          	sd	a0,-40(s0)
    80205598:	87ae                	mv	a5,a1
    8020559a:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:46
  char b = array[index / 8];
    8020559e:	fd442783          	lw	a5,-44(s0)
    802055a2:	41f7d71b          	sraiw	a4,a5,0x1f
    802055a6:	01d7571b          	srliw	a4,a4,0x1d
    802055aa:	9fb9                	addw	a5,a5,a4
    802055ac:	4037d79b          	sraiw	a5,a5,0x3
    802055b0:	2781                	sext.w	a5,a5
    802055b2:	873e                	mv	a4,a5
    802055b4:	fd843783          	ld	a5,-40(s0)
    802055b8:	97ba                	add	a5,a5,a4
    802055ba:	0007c783          	lbu	a5,0(a5)
    802055be:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:47
  char m = (1 << (index % 8));
    802055c2:	fd442703          	lw	a4,-44(s0)
    802055c6:	41f7579b          	sraiw	a5,a4,0x1f
    802055ca:	01d7d79b          	srliw	a5,a5,0x1d
    802055ce:	9f3d                	addw	a4,a4,a5
    802055d0:	8b1d                	andi	a4,a4,7
    802055d2:	40f707bb          	subw	a5,a4,a5
    802055d6:	2781                	sext.w	a5,a5
    802055d8:	4705                	li	a4,1
    802055da:	00f717bb          	sllw	a5,a4,a5
    802055de:	2781                	sext.w	a5,a5
    802055e0:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:48
  array[index / 8] = (b | m);
    802055e4:	fd442783          	lw	a5,-44(s0)
    802055e8:	41f7d71b          	sraiw	a4,a5,0x1f
    802055ec:	01d7571b          	srliw	a4,a4,0x1d
    802055f0:	9fb9                	addw	a5,a5,a4
    802055f2:	4037d79b          	sraiw	a5,a5,0x3
    802055f6:	2781                	sext.w	a5,a5
    802055f8:	873e                	mv	a4,a5
    802055fa:	fd843783          	ld	a5,-40(s0)
    802055fe:	97ba                	add	a5,a5,a4
    80205600:	fef44683          	lbu	a3,-17(s0)
    80205604:	fee44703          	lbu	a4,-18(s0)
    80205608:	8f55                	or	a4,a4,a3
    8020560a:	0ff77713          	andi	a4,a4,255
    8020560e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:49
}
    80205612:	0001                	nop
    80205614:	7422                	ld	s0,40(sp)
    80205616:	6145                	addi	sp,sp,48
    80205618:	8082                	ret

000000008020561a <bit_clear>:
bit_clear():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:52

// Clear bit at position index in array
void bit_clear(char *array, int index) {
    8020561a:	7179                	addi	sp,sp,-48
    8020561c:	f422                	sd	s0,40(sp)
    8020561e:	1800                	addi	s0,sp,48
    80205620:	fca43c23          	sd	a0,-40(s0)
    80205624:	87ae                	mv	a5,a1
    80205626:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:53
  char b = array[index / 8];
    8020562a:	fd442783          	lw	a5,-44(s0)
    8020562e:	41f7d71b          	sraiw	a4,a5,0x1f
    80205632:	01d7571b          	srliw	a4,a4,0x1d
    80205636:	9fb9                	addw	a5,a5,a4
    80205638:	4037d79b          	sraiw	a5,a5,0x3
    8020563c:	2781                	sext.w	a5,a5
    8020563e:	873e                	mv	a4,a5
    80205640:	fd843783          	ld	a5,-40(s0)
    80205644:	97ba                	add	a5,a5,a4
    80205646:	0007c783          	lbu	a5,0(a5)
    8020564a:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:54
  char m = (1 << (index % 8));
    8020564e:	fd442703          	lw	a4,-44(s0)
    80205652:	41f7579b          	sraiw	a5,a4,0x1f
    80205656:	01d7d79b          	srliw	a5,a5,0x1d
    8020565a:	9f3d                	addw	a4,a4,a5
    8020565c:	8b1d                	andi	a4,a4,7
    8020565e:	40f707bb          	subw	a5,a4,a5
    80205662:	2781                	sext.w	a5,a5
    80205664:	4705                	li	a4,1
    80205666:	00f717bb          	sllw	a5,a4,a5
    8020566a:	2781                	sext.w	a5,a5
    8020566c:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:55
  array[index / 8] = (b & ~m);
    80205670:	fee40783          	lb	a5,-18(s0)
    80205674:	fff7c793          	not	a5,a5
    80205678:	0187971b          	slliw	a4,a5,0x18
    8020567c:	4187571b          	sraiw	a4,a4,0x18
    80205680:	fef40783          	lb	a5,-17(s0)
    80205684:	8ff9                	and	a5,a5,a4
    80205686:	0187969b          	slliw	a3,a5,0x18
    8020568a:	4186d69b          	sraiw	a3,a3,0x18
    8020568e:	fd442783          	lw	a5,-44(s0)
    80205692:	41f7d71b          	sraiw	a4,a5,0x1f
    80205696:	01d7571b          	srliw	a4,a4,0x1d
    8020569a:	9fb9                	addw	a5,a5,a4
    8020569c:	4037d79b          	sraiw	a5,a5,0x3
    802056a0:	2781                	sext.w	a5,a5
    802056a2:	873e                	mv	a4,a5
    802056a4:	fd843783          	ld	a5,-40(s0)
    802056a8:	97ba                	add	a5,a5,a4
    802056aa:	0ff6f713          	andi	a4,a3,255
    802056ae:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:56
}
    802056b2:	0001                	nop
    802056b4:	7422                	ld	s0,40(sp)
    802056b6:	6145                	addi	sp,sp,48
    802056b8:	8082                	ret

00000000802056ba <bd_print_vector>:
bd_print_vector():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:59

// Print a bit vector as a list of ranges of 1 bits
void bd_print_vector(char *vector, int len) {
    802056ba:	7179                	addi	sp,sp,-48
    802056bc:	f406                	sd	ra,40(sp)
    802056be:	f022                	sd	s0,32(sp)
    802056c0:	1800                	addi	s0,sp,48
    802056c2:	fca43c23          	sd	a0,-40(s0)
    802056c6:	87ae                	mv	a5,a1
    802056c8:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:62
  int last, lb;

  last = 1;
    802056cc:	4785                	li	a5,1
    802056ce:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:63
  lb = 0;
    802056d2:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64
  for (int b = 0; b < len; b++) {
    802056d6:	fe042423          	sw	zero,-24(s0)
    802056da:	a0a1                	j	80205722 <bd_print_vector+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:65
    if (last == bit_isset(vector, b))
    802056dc:	fe842783          	lw	a5,-24(s0)
    802056e0:	85be                	mv	a1,a5
    802056e2:	fd843503          	ld	a0,-40(s0)
    802056e6:	e27ff0ef          	jal	ra,8020550c <bit_isset>
    802056ea:	87aa                	mv	a5,a0
    802056ec:	873e                	mv	a4,a5
    802056ee:	fec42783          	lw	a5,-20(s0)
    802056f2:	2781                	sext.w	a5,a5
    802056f4:	02e78163          	beq	a5,a4,80205716 <bd_print_vector+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:67
      continue;
    lb = b;
    802056f8:	fe842783          	lw	a5,-24(s0)
    802056fc:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:68
    last = bit_isset(vector, b);
    80205700:	fe842783          	lw	a5,-24(s0)
    80205704:	85be                	mv	a1,a5
    80205706:	fd843503          	ld	a0,-40(s0)
    8020570a:	e03ff0ef          	jal	ra,8020550c <bit_isset>
    8020570e:	87aa                	mv	a5,a0
    80205710:	fef42623          	sw	a5,-20(s0)
    80205714:	a011                	j	80205718 <bd_print_vector+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:66
      continue;
    80205716:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64 (discriminator 2)
  for (int b = 0; b < len; b++) {
    80205718:	fe842783          	lw	a5,-24(s0)
    8020571c:	2785                	addiw	a5,a5,1
    8020571e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:64 (discriminator 1)
    80205722:	fe842703          	lw	a4,-24(s0)
    80205726:	fd442783          	lw	a5,-44(s0)
    8020572a:	2701                	sext.w	a4,a4
    8020572c:	2781                	sext.w	a5,a5
    8020572e:	faf747e3          	blt	a4,a5,802056dc <bd_print_vector+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:72
  }
  if (lb == 0 || last == 1) {
  }
}
    80205732:	0001                	nop
    80205734:	0001                	nop
    80205736:	70a2                	ld	ra,40(sp)
    80205738:	7402                	ld	s0,32(sp)
    8020573a:	6145                	addi	sp,sp,48
    8020573c:	8082                	ret

000000008020573e <bd_print>:
bd_print():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:75

// Print buddy's data structures
void bd_print() {
    8020573e:	1101                	addi	sp,sp,-32
    80205740:	ec06                	sd	ra,24(sp)
    80205742:	e822                	sd	s0,16(sp)
    80205744:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76
  for (int k = 0; k < nsizes; k++) {
    80205746:	fe042623          	sw	zero,-20(s0)
    8020574a:	a06d                	j	802057f4 <bd_print+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:77
    lst_print(&bd_sizes[k].free);
    8020574c:	00b21797          	auipc	a5,0xb21
    80205750:	8bc78793          	addi	a5,a5,-1860 # 80d26008 <bd_sizes>
    80205754:	6398                	ld	a4,0(a5)
    80205756:	fec42783          	lw	a5,-20(s0)
    8020575a:	0796                	slli	a5,a5,0x5
    8020575c:	97ba                	add	a5,a5,a4
    8020575e:	853e                	mv	a0,a5
    80205760:	4ea020ef          	jal	ra,80207c4a <lst_print>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:78
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80205764:	00b21797          	auipc	a5,0xb21
    80205768:	8a478793          	addi	a5,a5,-1884 # 80d26008 <bd_sizes>
    8020576c:	6398                	ld	a4,0(a5)
    8020576e:	fec42783          	lw	a5,-20(s0)
    80205772:	0796                	slli	a5,a5,0x5
    80205774:	97ba                	add	a5,a5,a4
    80205776:	6b94                	ld	a3,16(a5)
    80205778:	00b21797          	auipc	a5,0xb21
    8020577c:	88878793          	addi	a5,a5,-1912 # 80d26000 <nsizes>
    80205780:	439c                	lw	a5,0(a5)
    80205782:	37fd                	addiw	a5,a5,-1
    80205784:	0007871b          	sext.w	a4,a5
    80205788:	fec42783          	lw	a5,-20(s0)
    8020578c:	40f707bb          	subw	a5,a4,a5
    80205790:	2781                	sext.w	a5,a5
    80205792:	4705                	li	a4,1
    80205794:	00f717bb          	sllw	a5,a4,a5
    80205798:	2781                	sext.w	a5,a5
    8020579a:	85be                	mv	a1,a5
    8020579c:	8536                	mv	a0,a3
    8020579e:	f1dff0ef          	jal	ra,802056ba <bd_print_vector>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:79
    if (k > 0) {
    802057a2:	fec42783          	lw	a5,-20(s0)
    802057a6:	2781                	sext.w	a5,a5
    802057a8:	04f05163          	blez	a5,802057ea <bd_print+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:80
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    802057ac:	00b21797          	auipc	a5,0xb21
    802057b0:	85c78793          	addi	a5,a5,-1956 # 80d26008 <bd_sizes>
    802057b4:	6398                	ld	a4,0(a5)
    802057b6:	fec42783          	lw	a5,-20(s0)
    802057ba:	0796                	slli	a5,a5,0x5
    802057bc:	97ba                	add	a5,a5,a4
    802057be:	6f94                	ld	a3,24(a5)
    802057c0:	00b21797          	auipc	a5,0xb21
    802057c4:	84078793          	addi	a5,a5,-1984 # 80d26000 <nsizes>
    802057c8:	439c                	lw	a5,0(a5)
    802057ca:	37fd                	addiw	a5,a5,-1
    802057cc:	0007871b          	sext.w	a4,a5
    802057d0:	fec42783          	lw	a5,-20(s0)
    802057d4:	40f707bb          	subw	a5,a4,a5
    802057d8:	2781                	sext.w	a5,a5
    802057da:	4705                	li	a4,1
    802057dc:	00f717bb          	sllw	a5,a4,a5
    802057e0:	2781                	sext.w	a5,a5
    802057e2:	85be                	mv	a1,a5
    802057e4:	8536                	mv	a0,a3
    802057e6:	ed5ff0ef          	jal	ra,802056ba <bd_print_vector>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    802057ea:	fec42783          	lw	a5,-20(s0)
    802057ee:	2785                	addiw	a5,a5,1
    802057f0:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:76 (discriminator 1)
    802057f4:	00b21797          	auipc	a5,0xb21
    802057f8:	80c78793          	addi	a5,a5,-2036 # 80d26000 <nsizes>
    802057fc:	4398                	lw	a4,0(a5)
    802057fe:	fec42783          	lw	a5,-20(s0)
    80205802:	2781                	sext.w	a5,a5
    80205804:	f4e7c4e3          	blt	a5,a4,8020574c <bd_print+0xe>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:83
    }
  }
}
    80205808:	0001                	nop
    8020580a:	0001                	nop
    8020580c:	60e2                	ld	ra,24(sp)
    8020580e:	6442                	ld	s0,16(sp)
    80205810:	6105                	addi	sp,sp,32
    80205812:	8082                	ret

0000000080205814 <firstk>:
firstk():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:86

// What is the first k such that 2^k >= n?
int firstk(uint64_t n) {
    80205814:	7179                	addi	sp,sp,-48
    80205816:	f422                	sd	s0,40(sp)
    80205818:	1800                	addi	s0,sp,48
    8020581a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:87
  int k = 0;
    8020581e:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:88
  uint64_t size = LEAF_SIZE;
    80205822:	47c1                	li	a5,16
    80205824:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:90

  while (size < n) {
    80205828:	a819                	j	8020583e <firstk+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:91
    k++;
    8020582a:	fec42783          	lw	a5,-20(s0)
    8020582e:	2785                	addiw	a5,a5,1
    80205830:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:92
    size *= 2;
    80205834:	fe043783          	ld	a5,-32(s0)
    80205838:	0786                	slli	a5,a5,0x1
    8020583a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:90
  while (size < n) {
    8020583e:	fe043703          	ld	a4,-32(s0)
    80205842:	fd843783          	ld	a5,-40(s0)
    80205846:	fef762e3          	bltu	a4,a5,8020582a <firstk+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:94
  }
  return k;
    8020584a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:95
}
    8020584e:	853e                	mv	a0,a5
    80205850:	7422                	ld	s0,40(sp)
    80205852:	6145                	addi	sp,sp,48
    80205854:	8082                	ret

0000000080205856 <blk_index>:
blk_index():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:98

// Compute the block index for address p at size k
int blk_index(int k, char *p) {
    80205856:	7179                	addi	sp,sp,-48
    80205858:	f422                	sd	s0,40(sp)
    8020585a:	1800                	addi	s0,sp,48
    8020585c:	87aa                	mv	a5,a0
    8020585e:	fcb43823          	sd	a1,-48(s0)
    80205862:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:99
  int n = p - (char *)bd_base;
    80205866:	00b20797          	auipc	a5,0xb20
    8020586a:	7aa78793          	addi	a5,a5,1962 # 80d26010 <bd_base>
    8020586e:	639c                	ld	a5,0(a5)
    80205870:	fd043703          	ld	a4,-48(s0)
    80205874:	40f707b3          	sub	a5,a4,a5
    80205878:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:100
  return n / BLK_SIZE(k);
    8020587c:	fec42703          	lw	a4,-20(s0)
    80205880:	fdc42783          	lw	a5,-36(s0)
    80205884:	46c1                	li	a3,16
    80205886:	00f697b3          	sll	a5,a3,a5
    8020588a:	02f747b3          	div	a5,a4,a5
    8020588e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:101
}
    80205890:	853e                	mv	a0,a5
    80205892:	7422                	ld	s0,40(sp)
    80205894:	6145                	addi	sp,sp,48
    80205896:	8082                	ret

0000000080205898 <addr>:
addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:104

// Convert a block index at size k back into an address
void *addr(int k, int bi) {
    80205898:	7179                	addi	sp,sp,-48
    8020589a:	f422                	sd	s0,40(sp)
    8020589c:	1800                	addi	s0,sp,48
    8020589e:	87aa                	mv	a5,a0
    802058a0:	872e                	mv	a4,a1
    802058a2:	fcf42e23          	sw	a5,-36(s0)
    802058a6:	87ba                	mv	a5,a4
    802058a8:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:105
  int n = bi * BLK_SIZE(k);
    802058ac:	fdc42783          	lw	a5,-36(s0)
    802058b0:	4741                	li	a4,16
    802058b2:	00f717b3          	sll	a5,a4,a5
    802058b6:	0007871b          	sext.w	a4,a5
    802058ba:	fd842783          	lw	a5,-40(s0)
    802058be:	02f707bb          	mulw	a5,a4,a5
    802058c2:	2781                	sext.w	a5,a5
    802058c4:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:106
  return (char *)bd_base + n;
    802058c8:	00b20797          	auipc	a5,0xb20
    802058cc:	74878793          	addi	a5,a5,1864 # 80d26010 <bd_base>
    802058d0:	6398                	ld	a4,0(a5)
    802058d2:	fec42783          	lw	a5,-20(s0)
    802058d6:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:107
}
    802058d8:	853e                	mv	a0,a5
    802058da:	7422                	ld	s0,40(sp)
    802058dc:	6145                	addi	sp,sp,48
    802058de:	8082                	ret

00000000802058e0 <bd_malloc>:
bd_malloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:110

// allocate nbytes, but malloc won't return anything smaller than LEAF_SIZE
void *bd_malloc(uint64_t nbytes) {
    802058e0:	715d                	addi	sp,sp,-80
    802058e2:	e486                	sd	ra,72(sp)
    802058e4:	e0a2                	sd	s0,64(sp)
    802058e6:	fc26                	sd	s1,56(sp)
    802058e8:	0880                	addi	s0,sp,80
    802058ea:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:116
  int fk, k;

  // acquire(&lock);

  // Find a free block >= nbytes, starting with smallest k possible
  fk = firstk(nbytes);
    802058ee:	fb843503          	ld	a0,-72(s0)
    802058f2:	f23ff0ef          	jal	ra,80205814 <firstk>
    802058f6:	87aa                	mv	a5,a0
    802058f8:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117
  for (k = fk; k < nsizes; k++) {
    802058fc:	fd842783          	lw	a5,-40(s0)
    80205900:	fcf42e23          	sw	a5,-36(s0)
    80205904:	a025                	j	8020592c <bd_malloc+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:118
    if (!lst_empty(&bd_sizes[k].free))
    80205906:	00b20797          	auipc	a5,0xb20
    8020590a:	70278793          	addi	a5,a5,1794 # 80d26008 <bd_sizes>
    8020590e:	6398                	ld	a4,0(a5)
    80205910:	fdc42783          	lw	a5,-36(s0)
    80205914:	0796                	slli	a5,a5,0x5
    80205916:	97ba                	add	a5,a5,a4
    80205918:	853e                	mv	a0,a5
    8020591a:	23e020ef          	jal	ra,80207b58 <lst_empty>
    8020591e:	87aa                	mv	a5,a0
    80205920:	c38d                	beqz	a5,80205942 <bd_malloc+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117 (discriminator 2)
  for (k = fk; k < nsizes; k++) {
    80205922:	fdc42783          	lw	a5,-36(s0)
    80205926:	2785                	addiw	a5,a5,1
    80205928:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:117 (discriminator 1)
    8020592c:	00b20797          	auipc	a5,0xb20
    80205930:	6d478793          	addi	a5,a5,1748 # 80d26000 <nsizes>
    80205934:	4398                	lw	a4,0(a5)
    80205936:	fdc42783          	lw	a5,-36(s0)
    8020593a:	2781                	sext.w	a5,a5
    8020593c:	fce7c5e3          	blt	a5,a4,80205906 <bd_malloc+0x26>
    80205940:	a011                	j	80205944 <bd_malloc+0x64>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:119
      break;
    80205942:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:121
  }
  if (k >= nsizes) { // No free blocks?
    80205944:	00b20797          	auipc	a5,0xb20
    80205948:	6bc78793          	addi	a5,a5,1724 # 80d26000 <nsizes>
    8020594c:	4398                	lw	a4,0(a5)
    8020594e:	fdc42783          	lw	a5,-36(s0)
    80205952:	2781                	sext.w	a5,a5
    80205954:	00e7c463          	blt	a5,a4,8020595c <bd_malloc+0x7c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:123
    // release(&lock);
    return 0;
    80205958:	4781                	li	a5,0
    8020595a:	a201                	j	80205a5a <bd_malloc+0x17a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:127
  }

  // Found a block; pop it and potentially split it.
  char *p = lst_pop(&bd_sizes[k].free);
    8020595c:	00b20797          	auipc	a5,0xb20
    80205960:	6ac78793          	addi	a5,a5,1708 # 80d26008 <bd_sizes>
    80205964:	6398                	ld	a4,0(a5)
    80205966:	fdc42783          	lw	a5,-36(s0)
    8020596a:	0796                	slli	a5,a5,0x5
    8020596c:	97ba                	add	a5,a5,a4
    8020596e:	853e                	mv	a0,a5
    80205970:	240020ef          	jal	ra,80207bb0 <lst_pop>
    80205974:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:128
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
    80205978:	00b20797          	auipc	a5,0xb20
    8020597c:	69078793          	addi	a5,a5,1680 # 80d26008 <bd_sizes>
    80205980:	6398                	ld	a4,0(a5)
    80205982:	fdc42783          	lw	a5,-36(s0)
    80205986:	0796                	slli	a5,a5,0x5
    80205988:	97ba                	add	a5,a5,a4
    8020598a:	6b84                	ld	s1,16(a5)
    8020598c:	fdc42783          	lw	a5,-36(s0)
    80205990:	fd043583          	ld	a1,-48(s0)
    80205994:	853e                	mv	a0,a5
    80205996:	ec1ff0ef          	jal	ra,80205856 <blk_index>
    8020599a:	87aa                	mv	a5,a0
    8020599c:	85be                	mv	a1,a5
    8020599e:	8526                	mv	a0,s1
    802059a0:	befff0ef          	jal	ra,8020558e <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129
  for (; k > fk; k--) {
    802059a4:	a04d                	j	80205a46 <bd_malloc+0x166>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:132 (discriminator 2)
    // split a block at size k and mark one half allocated at size k-1
    // and put the buddy on the free list at size k-1
    char *q = p + BLK_SIZE(k - 1); // p's buddy
    802059a6:	fdc42783          	lw	a5,-36(s0)
    802059aa:	37fd                	addiw	a5,a5,-1
    802059ac:	2781                	sext.w	a5,a5
    802059ae:	4741                	li	a4,16
    802059b0:	00f717b3          	sll	a5,a4,a5
    802059b4:	873e                	mv	a4,a5
    802059b6:	fd043783          	ld	a5,-48(s0)
    802059ba:	97ba                	add	a5,a5,a4
    802059bc:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:133 (discriminator 2)
    bit_set(bd_sizes[k].split, blk_index(k, p));
    802059c0:	00b20797          	auipc	a5,0xb20
    802059c4:	64878793          	addi	a5,a5,1608 # 80d26008 <bd_sizes>
    802059c8:	6398                	ld	a4,0(a5)
    802059ca:	fdc42783          	lw	a5,-36(s0)
    802059ce:	0796                	slli	a5,a5,0x5
    802059d0:	97ba                	add	a5,a5,a4
    802059d2:	6f84                	ld	s1,24(a5)
    802059d4:	fdc42783          	lw	a5,-36(s0)
    802059d8:	fd043583          	ld	a1,-48(s0)
    802059dc:	853e                	mv	a0,a5
    802059de:	e79ff0ef          	jal	ra,80205856 <blk_index>
    802059e2:	87aa                	mv	a5,a0
    802059e4:	85be                	mv	a1,a5
    802059e6:	8526                	mv	a0,s1
    802059e8:	ba7ff0ef          	jal	ra,8020558e <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:134 (discriminator 2)
    bit_set(bd_sizes[k - 1].alloc, blk_index(k - 1, p));
    802059ec:	00b20797          	auipc	a5,0xb20
    802059f0:	61c78793          	addi	a5,a5,1564 # 80d26008 <bd_sizes>
    802059f4:	6398                	ld	a4,0(a5)
    802059f6:	fdc42783          	lw	a5,-36(s0)
    802059fa:	0796                	slli	a5,a5,0x5
    802059fc:	1781                	addi	a5,a5,-32
    802059fe:	97ba                	add	a5,a5,a4
    80205a00:	6b84                	ld	s1,16(a5)
    80205a02:	fdc42783          	lw	a5,-36(s0)
    80205a06:	37fd                	addiw	a5,a5,-1
    80205a08:	2781                	sext.w	a5,a5
    80205a0a:	fd043583          	ld	a1,-48(s0)
    80205a0e:	853e                	mv	a0,a5
    80205a10:	e47ff0ef          	jal	ra,80205856 <blk_index>
    80205a14:	87aa                	mv	a5,a0
    80205a16:	85be                	mv	a1,a5
    80205a18:	8526                	mv	a0,s1
    80205a1a:	b75ff0ef          	jal	ra,8020558e <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:135 (discriminator 2)
    lst_push(&bd_sizes[k - 1].free, q);
    80205a1e:	00b20797          	auipc	a5,0xb20
    80205a22:	5ea78793          	addi	a5,a5,1514 # 80d26008 <bd_sizes>
    80205a26:	6398                	ld	a4,0(a5)
    80205a28:	fdc42783          	lw	a5,-36(s0)
    80205a2c:	0796                	slli	a5,a5,0x5
    80205a2e:	1781                	addi	a5,a5,-32
    80205a30:	97ba                	add	a5,a5,a4
    80205a32:	fc843583          	ld	a1,-56(s0)
    80205a36:	853e                	mv	a0,a5
    80205a38:	1c8020ef          	jal	ra,80207c00 <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129 (discriminator 2)
  for (; k > fk; k--) {
    80205a3c:	fdc42783          	lw	a5,-36(s0)
    80205a40:	37fd                	addiw	a5,a5,-1
    80205a42:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:129 (discriminator 1)
    80205a46:	fdc42703          	lw	a4,-36(s0)
    80205a4a:	fd842783          	lw	a5,-40(s0)
    80205a4e:	2701                	sext.w	a4,a4
    80205a50:	2781                	sext.w	a5,a5
    80205a52:	f4e7cae3          	blt	a5,a4,802059a6 <bd_malloc+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:139
  }
  // release(&lock);

  return p;
    80205a56:	fd043783          	ld	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:140
}
    80205a5a:	853e                	mv	a0,a5
    80205a5c:	60a6                	ld	ra,72(sp)
    80205a5e:	6406                	ld	s0,64(sp)
    80205a60:	74e2                	ld	s1,56(sp)
    80205a62:	6161                	addi	sp,sp,80
    80205a64:	8082                	ret

0000000080205a66 <size>:
size():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:143

// Find the size of the block that p points to.
int size(char *p) {
    80205a66:	7139                	addi	sp,sp,-64
    80205a68:	fc06                	sd	ra,56(sp)
    80205a6a:	f822                	sd	s0,48(sp)
    80205a6c:	f426                	sd	s1,40(sp)
    80205a6e:	0080                	addi	s0,sp,64
    80205a70:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144
  for (int k = 0; k < nsizes; k++) {
    80205a74:	fc042e23          	sw	zero,-36(s0)
    80205a78:	a0a1                	j	80205ac0 <size+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:145
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p))) {
    80205a7a:	00b20797          	auipc	a5,0xb20
    80205a7e:	58e78793          	addi	a5,a5,1422 # 80d26008 <bd_sizes>
    80205a82:	6398                	ld	a4,0(a5)
    80205a84:	fdc42783          	lw	a5,-36(s0)
    80205a88:	0785                	addi	a5,a5,1
    80205a8a:	0796                	slli	a5,a5,0x5
    80205a8c:	97ba                	add	a5,a5,a4
    80205a8e:	6f84                	ld	s1,24(a5)
    80205a90:	fdc42783          	lw	a5,-36(s0)
    80205a94:	2785                	addiw	a5,a5,1
    80205a96:	2781                	sext.w	a5,a5
    80205a98:	fc843583          	ld	a1,-56(s0)
    80205a9c:	853e                	mv	a0,a5
    80205a9e:	db9ff0ef          	jal	ra,80205856 <blk_index>
    80205aa2:	87aa                	mv	a5,a0
    80205aa4:	85be                	mv	a1,a5
    80205aa6:	8526                	mv	a0,s1
    80205aa8:	a65ff0ef          	jal	ra,8020550c <bit_isset>
    80205aac:	87aa                	mv	a5,a0
    80205aae:	c781                	beqz	a5,80205ab6 <size+0x50>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:146
      return k;
    80205ab0:	fdc42783          	lw	a5,-36(s0)
    80205ab4:	a00d                	j	80205ad6 <size+0x70>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    80205ab6:	fdc42783          	lw	a5,-36(s0)
    80205aba:	2785                	addiw	a5,a5,1
    80205abc:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:144 (discriminator 1)
    80205ac0:	00b20797          	auipc	a5,0xb20
    80205ac4:	54078793          	addi	a5,a5,1344 # 80d26000 <nsizes>
    80205ac8:	4398                	lw	a4,0(a5)
    80205aca:	fdc42783          	lw	a5,-36(s0)
    80205ace:	2781                	sext.w	a5,a5
    80205ad0:	fae7c5e3          	blt	a5,a4,80205a7a <size+0x14>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:149
    }
  }
  return 0;
    80205ad4:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:150
}
    80205ad6:	853e                	mv	a0,a5
    80205ad8:	70e2                	ld	ra,56(sp)
    80205ada:	7442                	ld	s0,48(sp)
    80205adc:	74a2                	ld	s1,40(sp)
    80205ade:	6121                	addi	sp,sp,64
    80205ae0:	8082                	ret

0000000080205ae2 <bd_free>:
bd_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:154

// Free memory pointed to by p, which was earlier allocated using
// bd_malloc.
void bd_free(void *p) {
    80205ae2:	715d                	addi	sp,sp,-80
    80205ae4:	e486                	sd	ra,72(sp)
    80205ae6:	e0a2                	sd	s0,64(sp)
    80205ae8:	fc26                	sd	s1,56(sp)
    80205aea:	0880                	addi	s0,sp,80
    80205aec:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159
  void *q;
  int k;

  // acquire(&lock);
  for (k = size(p); k < MAXSIZE; k++) {
    80205af0:	fb843503          	ld	a0,-72(s0)
    80205af4:	f73ff0ef          	jal	ra,80205a66 <size>
    80205af8:	87aa                	mv	a5,a0
    80205afa:	fcf42e23          	sw	a5,-36(s0)
    80205afe:	a0d5                	j	80205be2 <bd_free+0x100>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:160
    int bi = blk_index(k, p);
    80205b00:	fdc42783          	lw	a5,-36(s0)
    80205b04:	fb843583          	ld	a1,-72(s0)
    80205b08:	853e                	mv	a0,a5
    80205b0a:	d4dff0ef          	jal	ra,80205856 <blk_index>
    80205b0e:	87aa                	mv	a5,a0
    80205b10:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80205b14:	fd842783          	lw	a5,-40(s0)
    80205b18:	8b85                	andi	a5,a5,1
    80205b1a:	2781                	sext.w	a5,a5
    80205b1c:	e791                	bnez	a5,80205b28 <bd_free+0x46>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 1)
    80205b1e:	fd842783          	lw	a5,-40(s0)
    80205b22:	2785                	addiw	a5,a5,1
    80205b24:	2781                	sext.w	a5,a5
    80205b26:	a029                	j	80205b30 <bd_free+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 2)
    80205b28:	fd842783          	lw	a5,-40(s0)
    80205b2c:	37fd                	addiw	a5,a5,-1
    80205b2e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:161 (discriminator 4)
    80205b30:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:162 (discriminator 4)
    bit_clear(bd_sizes[k].alloc, bi);          // free p at size k
    80205b34:	00b20797          	auipc	a5,0xb20
    80205b38:	4d478793          	addi	a5,a5,1236 # 80d26008 <bd_sizes>
    80205b3c:	6398                	ld	a4,0(a5)
    80205b3e:	fdc42783          	lw	a5,-36(s0)
    80205b42:	0796                	slli	a5,a5,0x5
    80205b44:	97ba                	add	a5,a5,a4
    80205b46:	6b9c                	ld	a5,16(a5)
    80205b48:	fd842703          	lw	a4,-40(s0)
    80205b4c:	85ba                	mv	a1,a4
    80205b4e:	853e                	mv	a0,a5
    80205b50:	acbff0ef          	jal	ra,8020561a <bit_clear>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:163 (discriminator 4)
    if (bit_isset(bd_sizes[k].alloc, buddy)) { // is buddy allocated?
    80205b54:	00b20797          	auipc	a5,0xb20
    80205b58:	4b478793          	addi	a5,a5,1204 # 80d26008 <bd_sizes>
    80205b5c:	6398                	ld	a4,0(a5)
    80205b5e:	fdc42783          	lw	a5,-36(s0)
    80205b62:	0796                	slli	a5,a5,0x5
    80205b64:	97ba                	add	a5,a5,a4
    80205b66:	6b9c                	ld	a5,16(a5)
    80205b68:	fd442703          	lw	a4,-44(s0)
    80205b6c:	85ba                	mv	a1,a4
    80205b6e:	853e                	mv	a0,a5
    80205b70:	99dff0ef          	jal	ra,8020550c <bit_isset>
    80205b74:	87aa                	mv	a5,a0
    80205b76:	e7c1                	bnez	a5,80205bfe <bd_free+0x11c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:167
      break;                                   // break out of loop
    }
    // budy is free; merge with buddy
    q = addr(k, buddy);
    80205b78:	fd442703          	lw	a4,-44(s0)
    80205b7c:	fdc42783          	lw	a5,-36(s0)
    80205b80:	85ba                	mv	a1,a4
    80205b82:	853e                	mv	a0,a5
    80205b84:	d15ff0ef          	jal	ra,80205898 <addr>
    80205b88:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:168
    lst_remove(q); // remove buddy from free list
    80205b8c:	fc843503          	ld	a0,-56(s0)
    80205b90:	7f3010ef          	jal	ra,80207b82 <lst_remove>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:169
    if (buddy % 2 == 0) {
    80205b94:	fd442783          	lw	a5,-44(s0)
    80205b98:	8b85                	andi	a5,a5,1
    80205b9a:	2781                	sext.w	a5,a5
    80205b9c:	e789                	bnez	a5,80205ba6 <bd_free+0xc4>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:170
      p = q;
    80205b9e:	fc843783          	ld	a5,-56(s0)
    80205ba2:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:174 (discriminator 2)
    }
    // at size k+1, mark that the merged buddy pair isn't split
    // anymore
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
    80205ba6:	00b20797          	auipc	a5,0xb20
    80205baa:	46278793          	addi	a5,a5,1122 # 80d26008 <bd_sizes>
    80205bae:	6398                	ld	a4,0(a5)
    80205bb0:	fdc42783          	lw	a5,-36(s0)
    80205bb4:	0785                	addi	a5,a5,1
    80205bb6:	0796                	slli	a5,a5,0x5
    80205bb8:	97ba                	add	a5,a5,a4
    80205bba:	6f84                	ld	s1,24(a5)
    80205bbc:	fdc42783          	lw	a5,-36(s0)
    80205bc0:	2785                	addiw	a5,a5,1
    80205bc2:	2781                	sext.w	a5,a5
    80205bc4:	fb843583          	ld	a1,-72(s0)
    80205bc8:	853e                	mv	a0,a5
    80205bca:	c8dff0ef          	jal	ra,80205856 <blk_index>
    80205bce:	87aa                	mv	a5,a0
    80205bd0:	85be                	mv	a1,a5
    80205bd2:	8526                	mv	a0,s1
    80205bd4:	a47ff0ef          	jal	ra,8020561a <bit_clear>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159 (discriminator 2)
  for (k = size(p); k < MAXSIZE; k++) {
    80205bd8:	fdc42783          	lw	a5,-36(s0)
    80205bdc:	2785                	addiw	a5,a5,1
    80205bde:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:159 (discriminator 1)
    80205be2:	00b20797          	auipc	a5,0xb20
    80205be6:	41e78793          	addi	a5,a5,1054 # 80d26000 <nsizes>
    80205bea:	439c                	lw	a5,0(a5)
    80205bec:	37fd                	addiw	a5,a5,-1
    80205bee:	0007871b          	sext.w	a4,a5
    80205bf2:	fdc42783          	lw	a5,-36(s0)
    80205bf6:	2781                	sext.w	a5,a5
    80205bf8:	f0e7c4e3          	blt	a5,a4,80205b00 <bd_free+0x1e>
    80205bfc:	a011                	j	80205c00 <bd_free+0x11e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:164
      break;                                   // break out of loop
    80205bfe:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:176
  }
  lst_push(&bd_sizes[k].free, p);
    80205c00:	00b20797          	auipc	a5,0xb20
    80205c04:	40878793          	addi	a5,a5,1032 # 80d26008 <bd_sizes>
    80205c08:	6398                	ld	a4,0(a5)
    80205c0a:	fdc42783          	lw	a5,-36(s0)
    80205c0e:	0796                	slli	a5,a5,0x5
    80205c10:	97ba                	add	a5,a5,a4
    80205c12:	fb843583          	ld	a1,-72(s0)
    80205c16:	853e                	mv	a0,a5
    80205c18:	7e9010ef          	jal	ra,80207c00 <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:178
  // release(&lock);
}
    80205c1c:	0001                	nop
    80205c1e:	60a6                	ld	ra,72(sp)
    80205c20:	6406                	ld	s0,64(sp)
    80205c22:	74e2                	ld	s1,56(sp)
    80205c24:	6161                	addi	sp,sp,80
    80205c26:	8082                	ret

0000000080205c28 <blk_index_next>:
blk_index_next():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:181

// Compute the first block at size k that doesn't contain p
int blk_index_next(int k, char *p) {
    80205c28:	7179                	addi	sp,sp,-48
    80205c2a:	f422                	sd	s0,40(sp)
    80205c2c:	1800                	addi	s0,sp,48
    80205c2e:	87aa                	mv	a5,a0
    80205c30:	fcb43823          	sd	a1,-48(s0)
    80205c34:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:182
  int n = (p - (char *)bd_base) / BLK_SIZE(k);
    80205c38:	00b20797          	auipc	a5,0xb20
    80205c3c:	3d878793          	addi	a5,a5,984 # 80d26010 <bd_base>
    80205c40:	639c                	ld	a5,0(a5)
    80205c42:	fd043703          	ld	a4,-48(s0)
    80205c46:	8f1d                	sub	a4,a4,a5
    80205c48:	fdc42783          	lw	a5,-36(s0)
    80205c4c:	46c1                	li	a3,16
    80205c4e:	00f697b3          	sll	a5,a3,a5
    80205c52:	02f747b3          	div	a5,a4,a5
    80205c56:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:183
  if ((p - (char *)bd_base) % BLK_SIZE(k) != 0)
    80205c5a:	00b20797          	auipc	a5,0xb20
    80205c5e:	3b678793          	addi	a5,a5,950 # 80d26010 <bd_base>
    80205c62:	639c                	ld	a5,0(a5)
    80205c64:	fd043703          	ld	a4,-48(s0)
    80205c68:	8f1d                	sub	a4,a4,a5
    80205c6a:	fdc42783          	lw	a5,-36(s0)
    80205c6e:	46c1                	li	a3,16
    80205c70:	00f697b3          	sll	a5,a3,a5
    80205c74:	02f767b3          	rem	a5,a4,a5
    80205c78:	c791                	beqz	a5,80205c84 <blk_index_next+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:184
    n++;
    80205c7a:	fec42783          	lw	a5,-20(s0)
    80205c7e:	2785                	addiw	a5,a5,1
    80205c80:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:185
  return n;
    80205c84:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:186
}
    80205c88:	853e                	mv	a0,a5
    80205c8a:	7422                	ld	s0,40(sp)
    80205c8c:	6145                	addi	sp,sp,48
    80205c8e:	8082                	ret

0000000080205c90 <_log2>:
_log2():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:188

static int _log2(uint64_t n) {
    80205c90:	7179                	addi	sp,sp,-48
    80205c92:	f422                	sd	s0,40(sp)
    80205c94:	1800                	addi	s0,sp,48
    80205c96:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:189
  int k = 0;
    80205c9a:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:190
  while (n > 1) {
    80205c9e:	a819                	j	80205cb4 <_log2+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:191
    k++;
    80205ca0:	fec42783          	lw	a5,-20(s0)
    80205ca4:	2785                	addiw	a5,a5,1
    80205ca6:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:192
    n = n >> 1;
    80205caa:	fd843783          	ld	a5,-40(s0)
    80205cae:	8385                	srli	a5,a5,0x1
    80205cb0:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:190
  while (n > 1) {
    80205cb4:	fd843703          	ld	a4,-40(s0)
    80205cb8:	4785                	li	a5,1
    80205cba:	fee7e3e3          	bltu	a5,a4,80205ca0 <_log2+0x10>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:194
  }
  return k;
    80205cbe:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:195
}
    80205cc2:	853e                	mv	a0,a5
    80205cc4:	7422                	ld	s0,40(sp)
    80205cc6:	6145                	addi	sp,sp,48
    80205cc8:	8082                	ret

0000000080205cca <bd_mark>:
bd_mark():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:198

// Mark memory from [start, stop), starting at size 0, as allocated.
void bd_mark(void *start, void *stop) {
    80205cca:	7179                	addi	sp,sp,-48
    80205ccc:	f406                	sd	ra,40(sp)
    80205cce:	f022                	sd	s0,32(sp)
    80205cd0:	1800                	addi	s0,sp,48
    80205cd2:	fca43c23          	sd	a0,-40(s0)
    80205cd6:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:201
  int bi, bj;

  if (((uint64_t)start % LEAF_SIZE != 0) || ((uint64_t)stop % LEAF_SIZE != 0))
    80205cda:	fd843783          	ld	a5,-40(s0)
    80205cde:	8bbd                	andi	a5,a5,15
    80205ce0:	e789                	bnez	a5,80205cea <bd_mark+0x20>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:201 (discriminator 1)
    80205ce2:	fd043783          	ld	a5,-48(s0)
    80205ce6:	8bbd                	andi	a5,a5,15
    80205ce8:	cf89                	beqz	a5,80205d02 <bd_mark+0x38>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:202
    panic("bd_mark\n");
    80205cea:	00002617          	auipc	a2,0x2
    80205cee:	78660613          	addi	a2,a2,1926 # 80208470 <MMIO+0x10>
    80205cf2:	0ca00593          	li	a1,202
    80205cf6:	00002517          	auipc	a0,0x2
    80205cfa:	78a50513          	addi	a0,a0,1930 # 80208480 <MMIO+0x20>
    80205cfe:	1ad000ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204

  for (int k = 0; k < nsizes; k++) {
    80205d02:	fe042423          	sw	zero,-24(s0)
    80205d06:	a869                	j	80205da0 <bd_mark+0xd6>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:205
    bi = blk_index(k, start);
    80205d08:	fe842783          	lw	a5,-24(s0)
    80205d0c:	fd843583          	ld	a1,-40(s0)
    80205d10:	853e                	mv	a0,a5
    80205d12:	b45ff0ef          	jal	ra,80205856 <blk_index>
    80205d16:	87aa                	mv	a5,a0
    80205d18:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:206
    bj = blk_index_next(k, stop);
    80205d1c:	fe842783          	lw	a5,-24(s0)
    80205d20:	fd043583          	ld	a1,-48(s0)
    80205d24:	853e                	mv	a0,a5
    80205d26:	f03ff0ef          	jal	ra,80205c28 <blk_index_next>
    80205d2a:	87aa                	mv	a5,a0
    80205d2c:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207
    for (; bi < bj; bi++) {
    80205d30:	a899                	j	80205d86 <bd_mark+0xbc>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:208
      if (k > 0) {
    80205d32:	fe842783          	lw	a5,-24(s0)
    80205d36:	2781                	sext.w	a5,a5
    80205d38:	02f05263          	blez	a5,80205d5c <bd_mark+0x92>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:210
        // if a block is allocated at size k, mark it as split too.
        bit_set(bd_sizes[k].split, bi);
    80205d3c:	00b20797          	auipc	a5,0xb20
    80205d40:	2cc78793          	addi	a5,a5,716 # 80d26008 <bd_sizes>
    80205d44:	6398                	ld	a4,0(a5)
    80205d46:	fe842783          	lw	a5,-24(s0)
    80205d4a:	0796                	slli	a5,a5,0x5
    80205d4c:	97ba                	add	a5,a5,a4
    80205d4e:	6f9c                	ld	a5,24(a5)
    80205d50:	fec42703          	lw	a4,-20(s0)
    80205d54:	85ba                	mv	a1,a4
    80205d56:	853e                	mv	a0,a5
    80205d58:	837ff0ef          	jal	ra,8020558e <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:212
      }
      bit_set(bd_sizes[k].alloc, bi);
    80205d5c:	00b20797          	auipc	a5,0xb20
    80205d60:	2ac78793          	addi	a5,a5,684 # 80d26008 <bd_sizes>
    80205d64:	6398                	ld	a4,0(a5)
    80205d66:	fe842783          	lw	a5,-24(s0)
    80205d6a:	0796                	slli	a5,a5,0x5
    80205d6c:	97ba                	add	a5,a5,a4
    80205d6e:	6b9c                	ld	a5,16(a5)
    80205d70:	fec42703          	lw	a4,-20(s0)
    80205d74:	85ba                	mv	a1,a4
    80205d76:	853e                	mv	a0,a5
    80205d78:	817ff0ef          	jal	ra,8020558e <bit_set>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207
    for (; bi < bj; bi++) {
    80205d7c:	fec42783          	lw	a5,-20(s0)
    80205d80:	2785                	addiw	a5,a5,1
    80205d82:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:207 (discriminator 1)
    80205d86:	fec42703          	lw	a4,-20(s0)
    80205d8a:	fe442783          	lw	a5,-28(s0)
    80205d8e:	2701                	sext.w	a4,a4
    80205d90:	2781                	sext.w	a5,a5
    80205d92:	faf740e3          	blt	a4,a5,80205d32 <bd_mark+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204 (discriminator 2)
  for (int k = 0; k < nsizes; k++) {
    80205d96:	fe842783          	lw	a5,-24(s0)
    80205d9a:	2785                	addiw	a5,a5,1
    80205d9c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:204 (discriminator 1)
    80205da0:	00b20797          	auipc	a5,0xb20
    80205da4:	26078793          	addi	a5,a5,608 # 80d26000 <nsizes>
    80205da8:	4398                	lw	a4,0(a5)
    80205daa:	fe842783          	lw	a5,-24(s0)
    80205dae:	2781                	sext.w	a5,a5
    80205db0:	f4e7cce3          	blt	a5,a4,80205d08 <bd_mark+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:215
    }
  }
}
    80205db4:	0001                	nop
    80205db6:	0001                	nop
    80205db8:	70a2                	ld	ra,40(sp)
    80205dba:	7402                	ld	s0,32(sp)
    80205dbc:	6145                	addi	sp,sp,48
    80205dbe:	8082                	ret

0000000080205dc0 <bd_initfree_pair>:
bd_initfree_pair():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:219

// If a block is marked as allocated and the buddy is free, put the
// buddy on the free list at size k.
int bd_initfree_pair(int k, int bi) {
    80205dc0:	7139                	addi	sp,sp,-64
    80205dc2:	fc06                	sd	ra,56(sp)
    80205dc4:	f822                	sd	s0,48(sp)
    80205dc6:	f426                	sd	s1,40(sp)
    80205dc8:	0080                	addi	s0,sp,64
    80205dca:	87aa                	mv	a5,a0
    80205dcc:	872e                	mv	a4,a1
    80205dce:	fcf42623          	sw	a5,-52(s0)
    80205dd2:	87ba                	mv	a5,a4
    80205dd4:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80205dd8:	fc842783          	lw	a5,-56(s0)
    80205ddc:	8b85                	andi	a5,a5,1
    80205dde:	2781                	sext.w	a5,a5
    80205de0:	e791                	bnez	a5,80205dec <bd_initfree_pair+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 1)
    80205de2:	fc842783          	lw	a5,-56(s0)
    80205de6:	2785                	addiw	a5,a5,1
    80205de8:	2781                	sext.w	a5,a5
    80205dea:	a029                	j	80205df4 <bd_initfree_pair+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 2)
    80205dec:	fc842783          	lw	a5,-56(s0)
    80205df0:	37fd                	addiw	a5,a5,-1
    80205df2:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:220 (discriminator 4)
    80205df4:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:221 (discriminator 4)
  int free = 0;
    80205df8:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:222 (discriminator 4)
  if (bit_isset(bd_sizes[k].alloc, bi) != bit_isset(bd_sizes[k].alloc, buddy)) {
    80205dfc:	00b20797          	auipc	a5,0xb20
    80205e00:	20c78793          	addi	a5,a5,524 # 80d26008 <bd_sizes>
    80205e04:	6398                	ld	a4,0(a5)
    80205e06:	fcc42783          	lw	a5,-52(s0)
    80205e0a:	0796                	slli	a5,a5,0x5
    80205e0c:	97ba                	add	a5,a5,a4
    80205e0e:	6b9c                	ld	a5,16(a5)
    80205e10:	fc842703          	lw	a4,-56(s0)
    80205e14:	85ba                	mv	a1,a4
    80205e16:	853e                	mv	a0,a5
    80205e18:	ef4ff0ef          	jal	ra,8020550c <bit_isset>
    80205e1c:	87aa                	mv	a5,a0
    80205e1e:	84be                	mv	s1,a5
    80205e20:	00b20797          	auipc	a5,0xb20
    80205e24:	1e878793          	addi	a5,a5,488 # 80d26008 <bd_sizes>
    80205e28:	6398                	ld	a4,0(a5)
    80205e2a:	fcc42783          	lw	a5,-52(s0)
    80205e2e:	0796                	slli	a5,a5,0x5
    80205e30:	97ba                	add	a5,a5,a4
    80205e32:	6b9c                	ld	a5,16(a5)
    80205e34:	fd842703          	lw	a4,-40(s0)
    80205e38:	85ba                	mv	a1,a4
    80205e3a:	853e                	mv	a0,a5
    80205e3c:	ed0ff0ef          	jal	ra,8020550c <bit_isset>
    80205e40:	87aa                	mv	a5,a0
    80205e42:	8726                	mv	a4,s1
    80205e44:	08f70a63          	beq	a4,a5,80205ed8 <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:224
    // one of the pair is free
    free = BLK_SIZE(k);
    80205e48:	fcc42783          	lw	a5,-52(s0)
    80205e4c:	4741                	li	a4,16
    80205e4e:	00f717b3          	sll	a5,a4,a5
    80205e52:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:225
    if (bit_isset(bd_sizes[k].alloc, bi))
    80205e56:	00b20797          	auipc	a5,0xb20
    80205e5a:	1b278793          	addi	a5,a5,434 # 80d26008 <bd_sizes>
    80205e5e:	6398                	ld	a4,0(a5)
    80205e60:	fcc42783          	lw	a5,-52(s0)
    80205e64:	0796                	slli	a5,a5,0x5
    80205e66:	97ba                	add	a5,a5,a4
    80205e68:	6b9c                	ld	a5,16(a5)
    80205e6a:	fc842703          	lw	a4,-56(s0)
    80205e6e:	85ba                	mv	a1,a4
    80205e70:	853e                	mv	a0,a5
    80205e72:	e9aff0ef          	jal	ra,8020550c <bit_isset>
    80205e76:	87aa                	mv	a5,a0
    80205e78:	cb8d                	beqz	a5,80205eaa <bd_initfree_pair+0xea>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:226
      lst_push(&bd_sizes[k].free, addr(k, buddy)); // put buddy on free list
    80205e7a:	00b20797          	auipc	a5,0xb20
    80205e7e:	18e78793          	addi	a5,a5,398 # 80d26008 <bd_sizes>
    80205e82:	6398                	ld	a4,0(a5)
    80205e84:	fcc42783          	lw	a5,-52(s0)
    80205e88:	0796                	slli	a5,a5,0x5
    80205e8a:	97ba                	add	a5,a5,a4
    80205e8c:	84be                	mv	s1,a5
    80205e8e:	fd842703          	lw	a4,-40(s0)
    80205e92:	fcc42783          	lw	a5,-52(s0)
    80205e96:	85ba                	mv	a1,a4
    80205e98:	853e                	mv	a0,a5
    80205e9a:	9ffff0ef          	jal	ra,80205898 <addr>
    80205e9e:	87aa                	mv	a5,a0
    80205ea0:	85be                	mv	a1,a5
    80205ea2:	8526                	mv	a0,s1
    80205ea4:	55d010ef          	jal	ra,80207c00 <lst_push>
    80205ea8:	a805                	j	80205ed8 <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:228
    else
      lst_push(&bd_sizes[k].free, addr(k, bi)); // put bi on free list
    80205eaa:	00b20797          	auipc	a5,0xb20
    80205eae:	15e78793          	addi	a5,a5,350 # 80d26008 <bd_sizes>
    80205eb2:	6398                	ld	a4,0(a5)
    80205eb4:	fcc42783          	lw	a5,-52(s0)
    80205eb8:	0796                	slli	a5,a5,0x5
    80205eba:	97ba                	add	a5,a5,a4
    80205ebc:	84be                	mv	s1,a5
    80205ebe:	fc842703          	lw	a4,-56(s0)
    80205ec2:	fcc42783          	lw	a5,-52(s0)
    80205ec6:	85ba                	mv	a1,a4
    80205ec8:	853e                	mv	a0,a5
    80205eca:	9cfff0ef          	jal	ra,80205898 <addr>
    80205ece:	87aa                	mv	a5,a0
    80205ed0:	85be                	mv	a1,a5
    80205ed2:	8526                	mv	a0,s1
    80205ed4:	52d010ef          	jal	ra,80207c00 <lst_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:230
  }
  return free;
    80205ed8:	fdc42783          	lw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:231
}
    80205edc:	853e                	mv	a0,a5
    80205ede:	70e2                	ld	ra,56(sp)
    80205ee0:	7442                	ld	s0,48(sp)
    80205ee2:	74a2                	ld	s1,40(sp)
    80205ee4:	6121                	addi	sp,sp,64
    80205ee6:	8082                	ret

0000000080205ee8 <bd_initfree>:
bd_initfree():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:236

// Initialize the free lists for each size k.  For each size k, there
// are only two pairs that may have a buddy that should be on free list:
// bd_left and bd_right.
int bd_initfree(void *bd_left, void *bd_right) {
    80205ee8:	7179                	addi	sp,sp,-48
    80205eea:	f406                	sd	ra,40(sp)
    80205eec:	f022                	sd	s0,32(sp)
    80205eee:	1800                	addi	s0,sp,48
    80205ef0:	fca43c23          	sd	a0,-40(s0)
    80205ef4:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:237
  int free = 0;
    80205ef8:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239

  for (int k = 0; k < MAXSIZE; k++) { // skip max size
    80205efc:	fe042423          	sw	zero,-24(s0)
    80205f00:	a051                	j	80205f84 <bd_initfree+0x9c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:240
    int left = blk_index_next(k, bd_left);
    80205f02:	fe842783          	lw	a5,-24(s0)
    80205f06:	fd843583          	ld	a1,-40(s0)
    80205f0a:	853e                	mv	a0,a5
    80205f0c:	d1dff0ef          	jal	ra,80205c28 <blk_index_next>
    80205f10:	87aa                	mv	a5,a0
    80205f12:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:241
    int right = blk_index(k, bd_right);
    80205f16:	fe842783          	lw	a5,-24(s0)
    80205f1a:	fd043583          	ld	a1,-48(s0)
    80205f1e:	853e                	mv	a0,a5
    80205f20:	937ff0ef          	jal	ra,80205856 <blk_index>
    80205f24:	87aa                	mv	a5,a0
    80205f26:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:242
    free += bd_initfree_pair(k, left);
    80205f2a:	fe442703          	lw	a4,-28(s0)
    80205f2e:	fe842783          	lw	a5,-24(s0)
    80205f32:	85ba                	mv	a1,a4
    80205f34:	853e                	mv	a0,a5
    80205f36:	e8bff0ef          	jal	ra,80205dc0 <bd_initfree_pair>
    80205f3a:	87aa                	mv	a5,a0
    80205f3c:	873e                	mv	a4,a5
    80205f3e:	fec42783          	lw	a5,-20(s0)
    80205f42:	9fb9                	addw	a5,a5,a4
    80205f44:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:243
    if (right <= left)
    80205f48:	fe042703          	lw	a4,-32(s0)
    80205f4c:	fe442783          	lw	a5,-28(s0)
    80205f50:	2701                	sext.w	a4,a4
    80205f52:	2781                	sext.w	a5,a5
    80205f54:	02e7d263          	bge	a5,a4,80205f78 <bd_initfree+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:245
      continue;
    free += bd_initfree_pair(k, right);
    80205f58:	fe042703          	lw	a4,-32(s0)
    80205f5c:	fe842783          	lw	a5,-24(s0)
    80205f60:	85ba                	mv	a1,a4
    80205f62:	853e                	mv	a0,a5
    80205f64:	e5dff0ef          	jal	ra,80205dc0 <bd_initfree_pair>
    80205f68:	87aa                	mv	a5,a0
    80205f6a:	873e                	mv	a4,a5
    80205f6c:	fec42783          	lw	a5,-20(s0)
    80205f70:	9fb9                	addw	a5,a5,a4
    80205f72:	fef42623          	sw	a5,-20(s0)
    80205f76:	a011                	j	80205f7a <bd_initfree+0x92>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:244
      continue;
    80205f78:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239 (discriminator 2)
  for (int k = 0; k < MAXSIZE; k++) { // skip max size
    80205f7a:	fe842783          	lw	a5,-24(s0)
    80205f7e:	2785                	addiw	a5,a5,1
    80205f80:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:239 (discriminator 1)
    80205f84:	00b20797          	auipc	a5,0xb20
    80205f88:	07c78793          	addi	a5,a5,124 # 80d26000 <nsizes>
    80205f8c:	439c                	lw	a5,0(a5)
    80205f8e:	37fd                	addiw	a5,a5,-1
    80205f90:	0007871b          	sext.w	a4,a5
    80205f94:	fe842783          	lw	a5,-24(s0)
    80205f98:	2781                	sext.w	a5,a5
    80205f9a:	f6e7c4e3          	blt	a5,a4,80205f02 <bd_initfree+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:247
  }
  return free;
    80205f9e:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:248
}
    80205fa2:	853e                	mv	a0,a5
    80205fa4:	70a2                	ld	ra,40(sp)
    80205fa6:	7402                	ld	s0,32(sp)
    80205fa8:	6145                	addi	sp,sp,48
    80205faa:	8082                	ret

0000000080205fac <bd_mark_data_structures>:
bd_mark_data_structures():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:251

// Mark the range [bd_base,p) as allocated
int bd_mark_data_structures(char *p) {
    80205fac:	7179                	addi	sp,sp,-48
    80205fae:	f406                	sd	ra,40(sp)
    80205fb0:	f022                	sd	s0,32(sp)
    80205fb2:	1800                	addi	s0,sp,48
    80205fb4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:252
  int meta = p - (char *)bd_base;
    80205fb8:	00b20797          	auipc	a5,0xb20
    80205fbc:	05878793          	addi	a5,a5,88 # 80d26010 <bd_base>
    80205fc0:	639c                	ld	a5,0(a5)
    80205fc2:	fd843703          	ld	a4,-40(s0)
    80205fc6:	40f707b3          	sub	a5,a4,a5
    80205fca:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:253
  bd_mark(bd_base, p);
    80205fce:	00b20797          	auipc	a5,0xb20
    80205fd2:	04278793          	addi	a5,a5,66 # 80d26010 <bd_base>
    80205fd6:	639c                	ld	a5,0(a5)
    80205fd8:	fd843583          	ld	a1,-40(s0)
    80205fdc:	853e                	mv	a0,a5
    80205fde:	cedff0ef          	jal	ra,80205cca <bd_mark>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:254
  return meta;
    80205fe2:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:255
}
    80205fe6:	853e                	mv	a0,a5
    80205fe8:	70a2                	ld	ra,40(sp)
    80205fea:	7402                	ld	s0,32(sp)
    80205fec:	6145                	addi	sp,sp,48
    80205fee:	8082                	ret

0000000080205ff0 <bd_mark_unavailable>:
bd_mark_unavailable():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:258

// Mark the range [end, HEAPSIZE) as allocated
int bd_mark_unavailable(void *end, void *left) {
    80205ff0:	7179                	addi	sp,sp,-48
    80205ff2:	f406                	sd	ra,40(sp)
    80205ff4:	f022                	sd	s0,32(sp)
    80205ff6:	1800                	addi	s0,sp,48
    80205ff8:	fca43c23          	sd	a0,-40(s0)
    80205ffc:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:259
  int unavailable = BLK_SIZE(MAXSIZE) - (end - bd_base);
    80206000:	00b20797          	auipc	a5,0xb20
    80206004:	00078793          	mv	a5,a5
    80206008:	439c                	lw	a5,0(a5)
    8020600a:	37fd                	addiw	a5,a5,-1
    8020600c:	2781                	sext.w	a5,a5
    8020600e:	4741                	li	a4,16
    80206010:	00f717b3          	sll	a5,a4,a5
    80206014:	0007871b          	sext.w	a4,a5
    80206018:	00b20797          	auipc	a5,0xb20
    8020601c:	ff878793          	addi	a5,a5,-8 # 80d26010 <bd_base>
    80206020:	639c                	ld	a5,0(a5)
    80206022:	fd843683          	ld	a3,-40(s0)
    80206026:	40f687b3          	sub	a5,a3,a5
    8020602a:	2781                	sext.w	a5,a5
    8020602c:	40f707bb          	subw	a5,a4,a5
    80206030:	2781                	sext.w	a5,a5
    80206032:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:260
  if (unavailable > 0)
    80206036:	fec42783          	lw	a5,-20(s0)
    8020603a:	2781                	sext.w	a5,a5
    8020603c:	02f05463          	blez	a5,80206064 <bd_mark_unavailable+0x74>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:261
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    80206040:	fec42783          	lw	a5,-20(s0)
    80206044:	37fd                	addiw	a5,a5,-1
    80206046:	2781                	sext.w	a5,a5
    80206048:	41f7d71b          	sraiw	a4,a5,0x1f
    8020604c:	01c7571b          	srliw	a4,a4,0x1c
    80206050:	9fb9                	addw	a5,a5,a4
    80206052:	4047d79b          	sraiw	a5,a5,0x4
    80206056:	2781                	sext.w	a5,a5
    80206058:	2785                	addiw	a5,a5,1
    8020605a:	2781                	sext.w	a5,a5
    8020605c:	0047979b          	slliw	a5,a5,0x4
    80206060:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:263

  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    80206064:	00b20797          	auipc	a5,0xb20
    80206068:	fac78793          	addi	a5,a5,-84 # 80d26010 <bd_base>
    8020606c:	6398                	ld	a4,0(a5)
    8020606e:	00b20797          	auipc	a5,0xb20
    80206072:	f9278793          	addi	a5,a5,-110 # 80d26000 <nsizes>
    80206076:	439c                	lw	a5,0(a5)
    80206078:	37fd                	addiw	a5,a5,-1
    8020607a:	2781                	sext.w	a5,a5
    8020607c:	46c1                	li	a3,16
    8020607e:	00f697b3          	sll	a5,a3,a5
    80206082:	86be                	mv	a3,a5
    80206084:	fec42783          	lw	a5,-20(s0)
    80206088:	40f687b3          	sub	a5,a3,a5
    8020608c:	97ba                	add	a5,a5,a4
    8020608e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:264
  bd_mark(bd_end, bd_base + BLK_SIZE(MAXSIZE));
    80206092:	00b20797          	auipc	a5,0xb20
    80206096:	f7e78793          	addi	a5,a5,-130 # 80d26010 <bd_base>
    8020609a:	639c                	ld	a5,0(a5)
    8020609c:	00b20717          	auipc	a4,0xb20
    802060a0:	f6470713          	addi	a4,a4,-156 # 80d26000 <nsizes>
    802060a4:	4318                	lw	a4,0(a4)
    802060a6:	377d                	addiw	a4,a4,-1
    802060a8:	2701                	sext.w	a4,a4
    802060aa:	46c1                	li	a3,16
    802060ac:	00e69733          	sll	a4,a3,a4
    802060b0:	97ba                	add	a5,a5,a4
    802060b2:	85be                	mv	a1,a5
    802060b4:	fe043503          	ld	a0,-32(s0)
    802060b8:	c13ff0ef          	jal	ra,80205cca <bd_mark>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:265
  return unavailable;
    802060bc:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:266
}
    802060c0:	853e                	mv	a0,a5
    802060c2:	70a2                	ld	ra,40(sp)
    802060c4:	7402                	ld	s0,32(sp)
    802060c6:	6145                	addi	sp,sp,48
    802060c8:	8082                	ret

00000000802060ca <bd_init>:
bd_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:269

// Initialize the buddy allocator: it manages memory from [base, end).
void bd_init(void *base, void *end) {
    802060ca:	715d                	addi	sp,sp,-80
    802060cc:	e486                	sd	ra,72(sp)
    802060ce:	e0a2                	sd	s0,64(sp)
    802060d0:	0880                	addi	s0,sp,80
    802060d2:	faa43c23          	sd	a0,-72(s0)
    802060d6:	fab43823          	sd	a1,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:270
  char *p = (char *)ROUNDUP((uint64_t)base, LEAF_SIZE);
    802060da:	fb843783          	ld	a5,-72(s0)
    802060de:	17fd                	addi	a5,a5,-1
    802060e0:	8391                	srli	a5,a5,0x4
    802060e2:	0785                	addi	a5,a5,1
    802060e4:	0792                	slli	a5,a5,0x4
    802060e6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:274
  int sz;

  // initlock(&lock, "buddy");
  bd_base = (void *)p;
    802060ea:	00b20797          	auipc	a5,0xb20
    802060ee:	f2678793          	addi	a5,a5,-218 # 80d26010 <bd_base>
    802060f2:	fe843703          	ld	a4,-24(s0)
    802060f6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:277

  // compute the number of sizes we need to manage [base, end)
  nsizes = _log2(((char *)end - p) / LEAF_SIZE) + 1;
    802060f8:	fb043703          	ld	a4,-80(s0)
    802060fc:	fe843783          	ld	a5,-24(s0)
    80206100:	40f707b3          	sub	a5,a4,a5
    80206104:	43f7d713          	srai	a4,a5,0x3f
    80206108:	8b3d                	andi	a4,a4,15
    8020610a:	97ba                	add	a5,a5,a4
    8020610c:	8791                	srai	a5,a5,0x4
    8020610e:	853e                	mv	a0,a5
    80206110:	b81ff0ef          	jal	ra,80205c90 <_log2>
    80206114:	87aa                	mv	a5,a0
    80206116:	2785                	addiw	a5,a5,1
    80206118:	0007871b          	sext.w	a4,a5
    8020611c:	00b20797          	auipc	a5,0xb20
    80206120:	ee478793          	addi	a5,a5,-284 # 80d26000 <nsizes>
    80206124:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:278
  if ((char *)end - p > BLK_SIZE(MAXSIZE)) {
    80206126:	fb043703          	ld	a4,-80(s0)
    8020612a:	fe843783          	ld	a5,-24(s0)
    8020612e:	8f1d                	sub	a4,a4,a5
    80206130:	00b20797          	auipc	a5,0xb20
    80206134:	ed078793          	addi	a5,a5,-304 # 80d26000 <nsizes>
    80206138:	439c                	lw	a5,0(a5)
    8020613a:	37fd                	addiw	a5,a5,-1
    8020613c:	2781                	sext.w	a5,a5
    8020613e:	46c1                	li	a3,16
    80206140:	00f697b3          	sll	a5,a3,a5
    80206144:	00e7df63          	bge	a5,a4,80206162 <bd_init+0x98>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:279
    nsizes++; // round up to the next power of 2
    80206148:	00b20797          	auipc	a5,0xb20
    8020614c:	eb878793          	addi	a5,a5,-328 # 80d26000 <nsizes>
    80206150:	439c                	lw	a5,0(a5)
    80206152:	2785                	addiw	a5,a5,1
    80206154:	0007871b          	sext.w	a4,a5
    80206158:	00b20797          	auipc	a5,0xb20
    8020615c:	ea878793          	addi	a5,a5,-344 # 80d26000 <nsizes>
    80206160:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:283
  }

  // allocate bd_sizes array
  bd_sizes = (Sz_info *)p;
    80206162:	00b20797          	auipc	a5,0xb20
    80206166:	ea678793          	addi	a5,a5,-346 # 80d26008 <bd_sizes>
    8020616a:	fe843703          	ld	a4,-24(s0)
    8020616e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:284
  p += sizeof(Sz_info) * nsizes;
    80206170:	00b20797          	auipc	a5,0xb20
    80206174:	e9078793          	addi	a5,a5,-368 # 80d26000 <nsizes>
    80206178:	439c                	lw	a5,0(a5)
    8020617a:	0796                	slli	a5,a5,0x5
    8020617c:	fe843703          	ld	a4,-24(s0)
    80206180:	97ba                	add	a5,a5,a4
    80206182:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:285
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    80206186:	00b20797          	auipc	a5,0xb20
    8020618a:	e8278793          	addi	a5,a5,-382 # 80d26008 <bd_sizes>
    8020618e:	6398                	ld	a4,0(a5)
    80206190:	00b20797          	auipc	a5,0xb20
    80206194:	e7078793          	addi	a5,a5,-400 # 80d26000 <nsizes>
    80206198:	439c                	lw	a5,0(a5)
    8020619a:	2781                	sext.w	a5,a5
    8020619c:	0057979b          	slliw	a5,a5,0x5
    802061a0:	2781                	sext.w	a5,a5
    802061a2:	863e                	mv	a2,a5
    802061a4:	4581                	li	a1,0
    802061a6:	853a                	mv	a0,a4
    802061a8:	dfafd0ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288

  // initialize free list and allocate the alloc array for each size k
  for (int k = 0; k < nsizes; k++) {
    802061ac:	fe042223          	sw	zero,-28(s0)
    802061b0:	a84d                	j	80206262 <bd_init+0x198>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:289 (discriminator 3)
    lst_init(&bd_sizes[k].free);
    802061b2:	00b20797          	auipc	a5,0xb20
    802061b6:	e5678793          	addi	a5,a5,-426 # 80d26008 <bd_sizes>
    802061ba:	6398                	ld	a4,0(a5)
    802061bc:	fe442783          	lw	a5,-28(s0)
    802061c0:	0796                	slli	a5,a5,0x5
    802061c2:	97ba                	add	a5,a5,a4
    802061c4:	853e                	mv	a0,a5
    802061c6:	16d010ef          	jal	ra,80207b32 <lst_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:290 (discriminator 3)
    sz = sizeof(char) * ROUNDUP(NBLK(k), 8) / 8;
    802061ca:	00b20797          	auipc	a5,0xb20
    802061ce:	e3678793          	addi	a5,a5,-458 # 80d26000 <nsizes>
    802061d2:	439c                	lw	a5,0(a5)
    802061d4:	37fd                	addiw	a5,a5,-1
    802061d6:	0007871b          	sext.w	a4,a5
    802061da:	fe442783          	lw	a5,-28(s0)
    802061de:	40f707bb          	subw	a5,a4,a5
    802061e2:	2781                	sext.w	a5,a5
    802061e4:	4705                	li	a4,1
    802061e6:	00f717bb          	sllw	a5,a4,a5
    802061ea:	2781                	sext.w	a5,a5
    802061ec:	37fd                	addiw	a5,a5,-1
    802061ee:	2781                	sext.w	a5,a5
    802061f0:	41f7d71b          	sraiw	a4,a5,0x1f
    802061f4:	01d7571b          	srliw	a4,a4,0x1d
    802061f8:	9fb9                	addw	a5,a5,a4
    802061fa:	4037d79b          	sraiw	a5,a5,0x3
    802061fe:	2781                	sext.w	a5,a5
    80206200:	2785                	addiw	a5,a5,1
    80206202:	2781                	sext.w	a5,a5
    80206204:	0037979b          	slliw	a5,a5,0x3
    80206208:	2781                	sext.w	a5,a5
    8020620a:	838d                	srli	a5,a5,0x3
    8020620c:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:291 (discriminator 3)
    bd_sizes[k].alloc = p;
    80206210:	00b20797          	auipc	a5,0xb20
    80206214:	df878793          	addi	a5,a5,-520 # 80d26008 <bd_sizes>
    80206218:	6398                	ld	a4,0(a5)
    8020621a:	fe442783          	lw	a5,-28(s0)
    8020621e:	0796                	slli	a5,a5,0x5
    80206220:	97ba                	add	a5,a5,a4
    80206222:	fe843703          	ld	a4,-24(s0)
    80206226:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:292 (discriminator 3)
    memset(bd_sizes[k].alloc, 0, sz);
    80206228:	00b20797          	auipc	a5,0xb20
    8020622c:	de078793          	addi	a5,a5,-544 # 80d26008 <bd_sizes>
    80206230:	6398                	ld	a4,0(a5)
    80206232:	fe442783          	lw	a5,-28(s0)
    80206236:	0796                	slli	a5,a5,0x5
    80206238:	97ba                	add	a5,a5,a4
    8020623a:	6b9c                	ld	a5,16(a5)
    8020623c:	fc842703          	lw	a4,-56(s0)
    80206240:	863a                	mv	a2,a4
    80206242:	4581                	li	a1,0
    80206244:	853e                	mv	a0,a5
    80206246:	d5cfd0ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:293 (discriminator 3)
    p += sz;
    8020624a:	fc842783          	lw	a5,-56(s0)
    8020624e:	fe843703          	ld	a4,-24(s0)
    80206252:	97ba                	add	a5,a5,a4
    80206254:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288 (discriminator 3)
  for (int k = 0; k < nsizes; k++) {
    80206258:	fe442783          	lw	a5,-28(s0)
    8020625c:	2785                	addiw	a5,a5,1
    8020625e:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:288 (discriminator 1)
    80206262:	00b20797          	auipc	a5,0xb20
    80206266:	d9e78793          	addi	a5,a5,-610 # 80d26000 <nsizes>
    8020626a:	4398                	lw	a4,0(a5)
    8020626c:	fe442783          	lw	a5,-28(s0)
    80206270:	2781                	sext.w	a5,a5
    80206272:	f4e7c0e3          	blt	a5,a4,802061b2 <bd_init+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298
  }

  // allocate the split array for each size k, except for k = 0, since
  // we will not split blocks of size k = 0, the smallest size.
  for (int k = 1; k < nsizes; k++) {
    80206276:	4785                	li	a5,1
    80206278:	fef42023          	sw	a5,-32(s0)
    8020627c:	a869                	j	80206316 <bd_init+0x24c>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:299 (discriminator 3)
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    8020627e:	00b20797          	auipc	a5,0xb20
    80206282:	d8278793          	addi	a5,a5,-638 # 80d26000 <nsizes>
    80206286:	439c                	lw	a5,0(a5)
    80206288:	37fd                	addiw	a5,a5,-1
    8020628a:	0007871b          	sext.w	a4,a5
    8020628e:	fe042783          	lw	a5,-32(s0)
    80206292:	40f707bb          	subw	a5,a4,a5
    80206296:	2781                	sext.w	a5,a5
    80206298:	4705                	li	a4,1
    8020629a:	00f717bb          	sllw	a5,a4,a5
    8020629e:	2781                	sext.w	a5,a5
    802062a0:	37fd                	addiw	a5,a5,-1
    802062a2:	2781                	sext.w	a5,a5
    802062a4:	41f7d71b          	sraiw	a4,a5,0x1f
    802062a8:	01d7571b          	srliw	a4,a4,0x1d
    802062ac:	9fb9                	addw	a5,a5,a4
    802062ae:	4037d79b          	sraiw	a5,a5,0x3
    802062b2:	2781                	sext.w	a5,a5
    802062b4:	2785                	addiw	a5,a5,1
    802062b6:	2781                	sext.w	a5,a5
    802062b8:	0037979b          	slliw	a5,a5,0x3
    802062bc:	2781                	sext.w	a5,a5
    802062be:	838d                	srli	a5,a5,0x3
    802062c0:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:300 (discriminator 3)
    bd_sizes[k].split = p;
    802062c4:	00b20797          	auipc	a5,0xb20
    802062c8:	d4478793          	addi	a5,a5,-700 # 80d26008 <bd_sizes>
    802062cc:	6398                	ld	a4,0(a5)
    802062ce:	fe042783          	lw	a5,-32(s0)
    802062d2:	0796                	slli	a5,a5,0x5
    802062d4:	97ba                	add	a5,a5,a4
    802062d6:	fe843703          	ld	a4,-24(s0)
    802062da:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:301 (discriminator 3)
    memset(bd_sizes[k].split, 0, sz);
    802062dc:	00b20797          	auipc	a5,0xb20
    802062e0:	d2c78793          	addi	a5,a5,-724 # 80d26008 <bd_sizes>
    802062e4:	6398                	ld	a4,0(a5)
    802062e6:	fe042783          	lw	a5,-32(s0)
    802062ea:	0796                	slli	a5,a5,0x5
    802062ec:	97ba                	add	a5,a5,a4
    802062ee:	6f9c                	ld	a5,24(a5)
    802062f0:	fc842703          	lw	a4,-56(s0)
    802062f4:	863a                	mv	a2,a4
    802062f6:	4581                	li	a1,0
    802062f8:	853e                	mv	a0,a5
    802062fa:	ca8fd0ef          	jal	ra,802037a2 <memset>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:302 (discriminator 3)
    p += sz;
    802062fe:	fc842783          	lw	a5,-56(s0)
    80206302:	fe843703          	ld	a4,-24(s0)
    80206306:	97ba                	add	a5,a5,a4
    80206308:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298 (discriminator 3)
  for (int k = 1; k < nsizes; k++) {
    8020630c:	fe042783          	lw	a5,-32(s0)
    80206310:	2785                	addiw	a5,a5,1
    80206312:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:298 (discriminator 1)
    80206316:	00b20797          	auipc	a5,0xb20
    8020631a:	cea78793          	addi	a5,a5,-790 # 80d26000 <nsizes>
    8020631e:	4398                	lw	a4,0(a5)
    80206320:	fe042783          	lw	a5,-32(s0)
    80206324:	2781                	sext.w	a5,a5
    80206326:	f4e7cce3          	blt	a5,a4,8020627e <bd_init+0x1b4>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:304
  }
  p = (char *)ROUNDUP((uint64_t)p, LEAF_SIZE);
    8020632a:	fe843783          	ld	a5,-24(s0)
    8020632e:	17fd                	addi	a5,a5,-1
    80206330:	8391                	srli	a5,a5,0x4
    80206332:	0785                	addi	a5,a5,1
    80206334:	0792                	slli	a5,a5,0x4
    80206336:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:308

  // done allocating; mark the memory range [base, p) as allocated, so
  // that buddy will not hand out that memory.
  int meta = bd_mark_data_structures(p);
    8020633a:	fe843503          	ld	a0,-24(s0)
    8020633e:	c6fff0ef          	jal	ra,80205fac <bd_mark_data_structures>
    80206342:	87aa                	mv	a5,a0
    80206344:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:312

  // mark the unavailable memory range [end, HEAP_SIZE) as allocated,
  // so that buddy will not hand out that memory.
  int unavailable = bd_mark_unavailable(end, p);
    80206348:	fe843583          	ld	a1,-24(s0)
    8020634c:	fb043503          	ld	a0,-80(s0)
    80206350:	ca1ff0ef          	jal	ra,80205ff0 <bd_mark_unavailable>
    80206354:	87aa                	mv	a5,a0
    80206356:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:313
  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    8020635a:	00b20797          	auipc	a5,0xb20
    8020635e:	cb678793          	addi	a5,a5,-842 # 80d26010 <bd_base>
    80206362:	6398                	ld	a4,0(a5)
    80206364:	00b20797          	auipc	a5,0xb20
    80206368:	c9c78793          	addi	a5,a5,-868 # 80d26000 <nsizes>
    8020636c:	439c                	lw	a5,0(a5)
    8020636e:	37fd                	addiw	a5,a5,-1
    80206370:	2781                	sext.w	a5,a5
    80206372:	46c1                	li	a3,16
    80206374:	00f697b3          	sll	a5,a3,a5
    80206378:	86be                	mv	a3,a5
    8020637a:	fd842783          	lw	a5,-40(s0)
    8020637e:	40f687b3          	sub	a5,a3,a5
    80206382:	97ba                	add	a5,a5,a4
    80206384:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:316

  // initialize free lists for each size k
  int free = bd_initfree(p, bd_end);
    80206388:	fd043583          	ld	a1,-48(s0)
    8020638c:	fe843503          	ld	a0,-24(s0)
    80206390:	b59ff0ef          	jal	ra,80205ee8 <bd_initfree>
    80206394:	87aa                	mv	a5,a0
    80206396:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:319

  // check if the amount that is free is what we expect
  if (free != BLK_SIZE(MAXSIZE) - meta - unavailable) {
    8020639a:	fcc42703          	lw	a4,-52(s0)
    8020639e:	00b20797          	auipc	a5,0xb20
    802063a2:	c6278793          	addi	a5,a5,-926 # 80d26000 <nsizes>
    802063a6:	439c                	lw	a5,0(a5)
    802063a8:	37fd                	addiw	a5,a5,-1
    802063aa:	2781                	sext.w	a5,a5
    802063ac:	46c1                	li	a3,16
    802063ae:	00f696b3          	sll	a3,a3,a5
    802063b2:	fdc42783          	lw	a5,-36(s0)
    802063b6:	8e9d                	sub	a3,a3,a5
    802063b8:	fd842783          	lw	a5,-40(s0)
    802063bc:	40f687b3          	sub	a5,a3,a5
    802063c0:	00f70e63          	beq	a4,a5,802063dc <bd_init+0x312>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:320
    panic("bd_init: free mem\n");
    802063c4:	00002617          	auipc	a2,0x2
    802063c8:	0dc60613          	addi	a2,a2,220 # 802084a0 <MMIO+0x40>
    802063cc:	14000593          	li	a1,320
    802063d0:	00002517          	auipc	a0,0x2
    802063d4:	0b050513          	addi	a0,a0,176 # 80208480 <MMIO+0x20>
    802063d8:	2d2000ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/buddy/buddy.c:322
  }
}
    802063dc:	0001                	nop
    802063de:	60a6                	ld	ra,72(sp)
    802063e0:	6406                	ld	s0,64(sp)
    802063e2:	6161                	addi	sp,sp,80
    802063e4:	8082                	ret

00000000802063e6 <print_str>:
print_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:3
#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    802063e6:	1101                	addi	sp,sp,-32
    802063e8:	ec06                	sd	ra,24(sp)
    802063ea:	e822                	sd	s0,16(sp)
    802063ec:	1000                	addi	s0,sp,32
    802063ee:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) 
    802063f2:	a829                	j	8020640c <print_str+0x26>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:6
    {
        console_putchar((uint64_t)(*str));
    802063f4:	fe843783          	ld	a5,-24(s0)
    802063f8:	0007c783          	lbu	a5,0(a5)
    802063fc:	853e                	mv	a0,a5
    802063fe:	f01fc0ef          	jal	ra,802032fe <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:7
        str++;
    80206402:	fe843783          	ld	a5,-24(s0)
    80206406:	0785                	addi	a5,a5,1
    80206408:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) 
    8020640c:	fe843783          	ld	a5,-24(s0)
    80206410:	0007c783          	lbu	a5,0(a5)
    80206414:	f3e5                	bnez	a5,802063f4 <print_str+0xe>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:9
    }
}
    80206416:	0001                	nop
    80206418:	0001                	nop
    8020641a:	60e2                	ld	ra,24(sp)
    8020641c:	6442                	ld	s0,16(sp)
    8020641e:	6105                	addi	sp,sp,32
    80206420:	8082                	ret

0000000080206422 <reverse_str>:
reverse_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:11

void reverse_str(char* str, int length) {
    80206422:	7179                	addi	sp,sp,-48
    80206424:	f422                	sd	s0,40(sp)
    80206426:	1800                	addi	s0,sp,48
    80206428:	fca43c23          	sd	a0,-40(s0)
    8020642c:	87ae                	mv	a5,a1
    8020642e:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:12
    int start = 0;
    80206432:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    int end = length - 1;
    80206436:	fd442783          	lw	a5,-44(s0)
    8020643a:	37fd                	addiw	a5,a5,-1
    8020643c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
    while (start < end) {
    80206440:	a899                	j	80206496 <reverse_str+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:15
        char temp = str[start];
    80206442:	fec42783          	lw	a5,-20(s0)
    80206446:	fd843703          	ld	a4,-40(s0)
    8020644a:	97ba                	add	a5,a5,a4
    8020644c:	0007c783          	lbu	a5,0(a5)
    80206450:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:16
        str[start] = str[end];
    80206454:	fe842783          	lw	a5,-24(s0)
    80206458:	fd843703          	ld	a4,-40(s0)
    8020645c:	973e                	add	a4,a4,a5
    8020645e:	fec42783          	lw	a5,-20(s0)
    80206462:	fd843683          	ld	a3,-40(s0)
    80206466:	97b6                	add	a5,a5,a3
    80206468:	00074703          	lbu	a4,0(a4)
    8020646c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:17
        str[end] = temp;
    80206470:	fe842783          	lw	a5,-24(s0)
    80206474:	fd843703          	ld	a4,-40(s0)
    80206478:	97ba                	add	a5,a5,a4
    8020647a:	fe744703          	lbu	a4,-25(s0)
    8020647e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:18
        start++;
    80206482:	fec42783          	lw	a5,-20(s0)
    80206486:	2785                	addiw	a5,a5,1
    80206488:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:19
        end--;
    8020648c:	fe842783          	lw	a5,-24(s0)
    80206490:	37fd                	addiw	a5,a5,-1
    80206492:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
    while (start < end) {
    80206496:	fec42703          	lw	a4,-20(s0)
    8020649a:	fe842783          	lw	a5,-24(s0)
    8020649e:	2701                	sext.w	a4,a4
    802064a0:	2781                	sext.w	a5,a5
    802064a2:	faf740e3          	blt	a4,a5,80206442 <reverse_str+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:21
    }
}
    802064a6:	0001                	nop
    802064a8:	0001                	nop
    802064aa:	7422                	ld	s0,40(sp)
    802064ac:	6145                	addi	sp,sp,48
    802064ae:	8082                	ret

00000000802064b0 <print_uint32>:
print_uint32():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:23

void print_uint32(uint32_t value) {
    802064b0:	7139                	addi	sp,sp,-64
    802064b2:	fc06                	sd	ra,56(sp)
    802064b4:	f822                	sd	s0,48(sp)
    802064b6:	0080                	addi	s0,sp,64
    802064b8:	87aa                	mv	a5,a0
    802064ba:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:25
    char buffer[12];
    int i = 0;
    802064be:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:26
    if (value == 0) {
    802064c2:	fcc42783          	lw	a5,-52(s0)
    802064c6:	2781                	sext.w	a5,a5
    802064c8:	e3ad                	bnez	a5,8020652a <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:27
        buffer[i++] = '0';
    802064ca:	fec42783          	lw	a5,-20(s0)
    802064ce:	0017871b          	addiw	a4,a5,1
    802064d2:	fee42623          	sw	a4,-20(s0)
    802064d6:	ff040713          	addi	a4,s0,-16
    802064da:	97ba                	add	a5,a5,a4
    802064dc:	03000713          	li	a4,48
    802064e0:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
    }
    while (value != 0) {
    802064e4:	a099                	j	8020652a <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:30
        int digit = value % 10;
    802064e6:	fcc42703          	lw	a4,-52(s0)
    802064ea:	47a9                	li	a5,10
    802064ec:	02f777bb          	remuw	a5,a4,a5
    802064f0:	2781                	sext.w	a5,a5
    802064f2:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:31
        buffer[i++] = digit + '0';
    802064f6:	fe842783          	lw	a5,-24(s0)
    802064fa:	0ff7f713          	andi	a4,a5,255
    802064fe:	fec42783          	lw	a5,-20(s0)
    80206502:	0017869b          	addiw	a3,a5,1
    80206506:	fed42623          	sw	a3,-20(s0)
    8020650a:	0307071b          	addiw	a4,a4,48
    8020650e:	0ff77713          	andi	a4,a4,255
    80206512:	ff040693          	addi	a3,s0,-16
    80206516:	97b6                	add	a5,a5,a3
    80206518:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:32
        value /= 10;
    8020651c:	fcc42703          	lw	a4,-52(s0)
    80206520:	47a9                	li	a5,10
    80206522:	02f757bb          	divuw	a5,a4,a5
    80206526:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
    while (value != 0) {
    8020652a:	fcc42783          	lw	a5,-52(s0)
    8020652e:	2781                	sext.w	a5,a5
    80206530:	fbdd                	bnez	a5,802064e6 <print_uint32+0x36>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:34
    }
    buffer[i] = '\0';
    80206532:	fec42783          	lw	a5,-20(s0)
    80206536:	ff040713          	addi	a4,s0,-16
    8020653a:	97ba                	add	a5,a5,a4
    8020653c:	fe078423          	sb	zero,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:35
    reverse_str(buffer, i);
    80206540:	fec42703          	lw	a4,-20(s0)
    80206544:	fd840793          	addi	a5,s0,-40
    80206548:	85ba                	mv	a1,a4
    8020654a:	853e                	mv	a0,a5
    8020654c:	ed7ff0ef          	jal	ra,80206422 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:36
    print_str(buffer);
    80206550:	fd840793          	addi	a5,s0,-40
    80206554:	853e                	mv	a0,a5
    80206556:	e91ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:37
}
    8020655a:	0001                	nop
    8020655c:	70e2                	ld	ra,56(sp)
    8020655e:	7442                	ld	s0,48(sp)
    80206560:	6121                	addi	sp,sp,64
    80206562:	8082                	ret

0000000080206564 <print_uint64>:
print_uint64():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:40

void print_uint64(uint64_t value) 
{
    80206564:	7139                	addi	sp,sp,-64
    80206566:	fc06                	sd	ra,56(sp)
    80206568:	f822                	sd	s0,48(sp)
    8020656a:	0080                	addi	s0,sp,64
    8020656c:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:42
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    80206570:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:43
    if (value == 0) 
    80206574:	fc843783          	ld	a5,-56(s0)
    80206578:	e3a5                	bnez	a5,802065d8 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:45
    {
        buffer[i++] = '0';
    8020657a:	fec42783          	lw	a5,-20(s0)
    8020657e:	0017871b          	addiw	a4,a5,1
    80206582:	fee42623          	sw	a4,-20(s0)
    80206586:	ff040713          	addi	a4,s0,-16
    8020658a:	97ba                	add	a5,a5,a4
    8020658c:	03000713          	li	a4,48
    80206590:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
    }
    while (value != 0) 
    80206594:	a091                	j	802065d8 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:49
    {
        int digit = value % 10;
    80206596:	fc843703          	ld	a4,-56(s0)
    8020659a:	47a9                	li	a5,10
    8020659c:	02f777b3          	remu	a5,a4,a5
    802065a0:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:50
        buffer[i++] = digit + '0';
    802065a4:	fe842783          	lw	a5,-24(s0)
    802065a8:	0ff7f713          	andi	a4,a5,255
    802065ac:	fec42783          	lw	a5,-20(s0)
    802065b0:	0017869b          	addiw	a3,a5,1
    802065b4:	fed42623          	sw	a3,-20(s0)
    802065b8:	0307071b          	addiw	a4,a4,48
    802065bc:	0ff77713          	andi	a4,a4,255
    802065c0:	ff040693          	addi	a3,s0,-16
    802065c4:	97b6                	add	a5,a5,a3
    802065c6:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:51
        value /= 10;
    802065ca:	fc843703          	ld	a4,-56(s0)
    802065ce:	47a9                	li	a5,10
    802065d0:	02f757b3          	divu	a5,a4,a5
    802065d4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
    while (value != 0) 
    802065d8:	fc843783          	ld	a5,-56(s0)
    802065dc:	ffcd                	bnez	a5,80206596 <print_uint64+0x32>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:53
    }
    buffer[i] = '\0';
    802065de:	fec42783          	lw	a5,-20(s0)
    802065e2:	ff040713          	addi	a4,s0,-16
    802065e6:	97ba                	add	a5,a5,a4
    802065e8:	fe078023          	sb	zero,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:54
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    802065ec:	fec42703          	lw	a4,-20(s0)
    802065f0:	fd040793          	addi	a5,s0,-48
    802065f4:	85ba                	mv	a1,a4
    802065f6:	853e                	mv	a0,a5
    802065f8:	e2bff0ef          	jal	ra,80206422 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:55
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
    802065fc:	fd040793          	addi	a5,s0,-48
    80206600:	853e                	mv	a0,a5
    80206602:	de5ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:56
}
    80206606:	0001                	nop
    80206608:	70e2                	ld	ra,56(sp)
    8020660a:	7442                	ld	s0,48(sp)
    8020660c:	6121                	addi	sp,sp,64
    8020660e:	8082                	ret

0000000080206610 <print_uint64_hex>:
print_uint64_hex():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:59

void print_uint64_hex(uint64_t value) 
{
    80206610:	7179                	addi	sp,sp,-48
    80206612:	f406                	sd	ra,40(sp)
    80206614:	f022                	sd	s0,32(sp)
    80206616:	1800                	addi	s0,sp,48
    80206618:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60
    print_str("0x"); // 打印十六进制前缀
    8020661c:	00002517          	auipc	a0,0x2
    80206620:	e9c50513          	addi	a0,a0,-356 # 802084b8 <MMIO+0x58>
    80206624:	dc3ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61
    for (int i = 15; i >= 0; i--) 
    80206628:	47bd                	li	a5,15
    8020662a:	fef42623          	sw	a5,-20(s0)
    8020662e:	a09d                	j	80206694 <print_uint64_hex+0x84>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:63
    {
        int digit = (value >> (i * 4)) & 0xF; // 获取每个十六进制位
    80206630:	fec42783          	lw	a5,-20(s0)
    80206634:	0027979b          	slliw	a5,a5,0x2
    80206638:	2781                	sext.w	a5,a5
    8020663a:	873e                	mv	a4,a5
    8020663c:	fd843783          	ld	a5,-40(s0)
    80206640:	00e7d7b3          	srl	a5,a5,a4
    80206644:	2781                	sext.w	a5,a5
    80206646:	8bbd                	andi	a5,a5,15
    80206648:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64
        char hex = digit < 10 ? '0' + digit : 'A' + digit - 10; // 转换为字符
    8020664c:	fe842783          	lw	a5,-24(s0)
    80206650:	0007871b          	sext.w	a4,a5
    80206654:	47a5                	li	a5,9
    80206656:	00e7cb63          	blt	a5,a4,8020666c <print_uint64_hex+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 1)
    8020665a:	fe842783          	lw	a5,-24(s0)
    8020665e:	0ff7f793          	andi	a5,a5,255
    80206662:	0307879b          	addiw	a5,a5,48
    80206666:	0ff7f793          	andi	a5,a5,255
    8020666a:	a809                	j	8020667c <print_uint64_hex+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 2)
    8020666c:	fe842783          	lw	a5,-24(s0)
    80206670:	0ff7f793          	andi	a5,a5,255
    80206674:	0377879b          	addiw	a5,a5,55
    80206678:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:64 (discriminator 4)
    8020667c:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:65 (discriminator 4)
        console_putchar((uint64_t)hex); // 输出字符
    80206680:	fe744783          	lbu	a5,-25(s0)
    80206684:	853e                	mv	a0,a5
    80206686:	c79fc0ef          	jal	ra,802032fe <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 4)
    for (int i = 15; i >= 0; i--) 
    8020668a:	fec42783          	lw	a5,-20(s0)
    8020668e:	37fd                	addiw	a5,a5,-1
    80206690:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 2)
    80206694:	fec42783          	lw	a5,-20(s0)
    80206698:	2781                	sext.w	a5,a5
    8020669a:	f807dbe3          	bgez	a5,80206630 <print_uint64_hex+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:67
    }
    8020669e:	0001                	nop
    802066a0:	0001                	nop
    802066a2:	70a2                	ld	ra,40(sp)
    802066a4:	7402                	ld	s0,32(sp)
    802066a6:	6145                	addi	sp,sp,48
    802066a8:	8082                	ret

00000000802066aa <_panic>:
_panic():
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:4
#include "console.h"
#include "sbi.h"
// panic函数现在接收文件名和行号作为参数
void _panic(const char* file, int line, const char* msg) {
    802066aa:	7179                	addi	sp,sp,-48
    802066ac:	f406                	sd	ra,40(sp)
    802066ae:	f022                	sd	s0,32(sp)
    802066b0:	1800                	addi	s0,sp,48
    802066b2:	fea43423          	sd	a0,-24(s0)
    802066b6:	87ae                	mv	a5,a1
    802066b8:	fcc43c23          	sd	a2,-40(s0)
    802066bc:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:5
    printk("PANIC in %s at line %d: %s\n", file, line, msg);
    802066c0:	fe442783          	lw	a5,-28(s0)
    802066c4:	fd843683          	ld	a3,-40(s0)
    802066c8:	863e                	mv	a2,a5
    802066ca:	fe843583          	ld	a1,-24(s0)
    802066ce:	00002517          	auipc	a0,0x2
    802066d2:	df250513          	addi	a0,a0,-526 # 802084c0 <MMIO+0x60>
    802066d6:	914fc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:6
    sbi_shutdown();
    802066da:	c6bfc0ef          	jal	ra,80203344 <sbi_shutdown>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:7
}
    802066de:	0001                	nop
    802066e0:	70a2                	ld	ra,40(sp)
    802066e2:	7402                	ld	s0,32(sp)
    802066e4:	6145                	addi	sp,sp,48
    802066e6:	8082                	ret

00000000802066e8 <task_manager_init>:
task_manager_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:16
struct TaskManager TASK_MANAGER;
extern void __switch(struct TaskContext**,struct TaskContext**);
extern uint64_t _num_app[];

void task_manager_init()
{
    802066e8:	7179                	addi	sp,sp,-48
    802066ea:	f406                	sd	ra,40(sp)
    802066ec:	f022                	sd	s0,32(sp)
    802066ee:	ec26                	sd	s1,24(sp)
    802066f0:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:17
   TASK_MANAGER.num_app = loader_get_num_app();
    802066f2:	11d000ef          	jal	ra,8020700e <loader_get_num_app>
    802066f6:	86aa                	mv	a3,a0
    802066f8:	00b20717          	auipc	a4,0xb20
    802066fc:	92070713          	addi	a4,a4,-1760 # 80d26018 <TASK_MANAGER>
    80206700:	6785                	lui	a5,0x1
    80206702:	97ba                	add	a5,a5,a4
    80206704:	96d7b423          	sd	a3,-1688(a5) # 968 <n+0x948>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:18
  for (unsigned i = 0; i < TASK_MANAGER.num_app; i++) 
    80206708:	fc042e23          	sw	zero,-36(s0)
    8020670c:	a099                	j	80206752 <task_manager_init+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:20 (discriminator 3)
  {
    task_control_block_new(loader_get_app_data(i), loader_get_app_size(i), i,
    8020670e:	fdc46783          	lwu	a5,-36(s0)
    80206712:	853e                	mv	a0,a5
    80206714:	113000ef          	jal	ra,80207026 <loader_get_app_data>
    80206718:	84aa                	mv	s1,a0
    8020671a:	fdc46783          	lwu	a5,-36(s0)
    8020671e:	853e                	mv	a0,a5
    80206720:	153000ef          	jal	ra,80207072 <loader_get_app_size>
    80206724:	85aa                	mv	a1,a0
    80206726:	fdc46603          	lwu	a2,-36(s0)
    8020672a:	fdc46703          	lwu	a4,-36(s0)
    8020672e:	87ba                	mv	a5,a4
    80206730:	0792                	slli	a5,a5,0x4
    80206732:	8f99                	sub	a5,a5,a4
    80206734:	078e                	slli	a5,a5,0x3
    80206736:	00b20717          	auipc	a4,0xb20
    8020673a:	8e270713          	addi	a4,a4,-1822 # 80d26018 <TASK_MANAGER>
    8020673e:	97ba                	add	a5,a5,a4
    80206740:	86be                	mv	a3,a5
    80206742:	8526                	mv	a0,s1
    80206744:	204000ef          	jal	ra,80206948 <task_control_block_new>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:18 (discriminator 3)
  for (unsigned i = 0; i < TASK_MANAGER.num_app; i++) 
    80206748:	fdc42783          	lw	a5,-36(s0)
    8020674c:	2785                	addiw	a5,a5,1
    8020674e:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:18 (discriminator 1)
    80206752:	fdc46703          	lwu	a4,-36(s0)
    80206756:	00b20697          	auipc	a3,0xb20
    8020675a:	8c268693          	addi	a3,a3,-1854 # 80d26018 <TASK_MANAGER>
    8020675e:	6785                	lui	a5,0x1
    80206760:	97b6                	add	a5,a5,a3
    80206762:	9687b783          	ld	a5,-1688(a5) # 968 <n+0x948>
    80206766:	faf764e3          	bltu	a4,a5,8020670e <task_manager_init+0x26>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23
                           &TASK_MANAGER.tasks[i]);
  }
  printk("task_manager_init_end\n");
    8020676a:	00002517          	auipc	a0,0x2
    8020676e:	d8650513          	addi	a0,a0,-634 # 802084f0 <MMIO+0x10>
    80206772:	878fc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:24
  TASK_MANAGER.current_task = 0;
    80206776:	00b20717          	auipc	a4,0xb20
    8020677a:	8a270713          	addi	a4,a4,-1886 # 80d26018 <TASK_MANAGER>
    8020677e:	6785                	lui	a5,0x1
    80206780:	97ba                	add	a5,a5,a4
    80206782:	9607b023          	sd	zero,-1696(a5) # 960 <n+0x940>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:25
}
    80206786:	0001                	nop
    80206788:	70a2                	ld	ra,40(sp)
    8020678a:	7402                	ld	s0,32(sp)
    8020678c:	64e2                	ld	s1,24(sp)
    8020678e:	6145                	addi	sp,sp,48
    80206790:	8082                	ret

0000000080206792 <run_next_task>:
run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:29


void run_next_task(uint64_t status) 
{
    80206792:	7139                	addi	sp,sp,-64
    80206794:	fc06                	sd	ra,56(sp)
    80206796:	f822                	sd	s0,48(sp)
    80206798:	0080                	addi	s0,sp,64
    8020679a:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:32
    // 寻找ready的task
    uint64_t target_task_num;
    for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    8020679e:	00b20717          	auipc	a4,0xb20
    802067a2:	87a70713          	addi	a4,a4,-1926 # 80d26018 <TASK_MANAGER>
    802067a6:	6785                	lui	a5,0x1
    802067a8:	97ba                	add	a5,a5,a4
    802067aa:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    802067ae:	00178713          	addi	a4,a5,1
    802067b2:	47d1                	li	a5,20
    802067b4:	02f777b3          	remu	a5,a4,a5
    802067b8:	fef43423          	sd	a5,-24(s0)
    802067bc:	a815                	j	802067f0 <run_next_task+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:33
        if (TASK_MANAGER.tasks[target_task_num].task_status == Ready) {
    802067be:	00b20697          	auipc	a3,0xb20
    802067c2:	85a68693          	addi	a3,a3,-1958 # 80d26018 <TASK_MANAGER>
    802067c6:	fe843703          	ld	a4,-24(s0)
    802067ca:	87ba                	mv	a5,a4
    802067cc:	0792                	slli	a5,a5,0x4
    802067ce:	8f99                	sub	a5,a5,a4
    802067d0:	078e                	slli	a5,a5,0x3
    802067d2:	97b6                	add	a5,a5,a3
    802067d4:	479c                	lw	a5,8(a5)
    802067d6:	873e                	mv	a4,a5
    802067d8:	4785                	li	a5,1
    802067da:	02f70863          	beq	a4,a5,8020680a <run_next_task+0x78>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:32 (discriminator 2)
    for (target_task_num = (TASK_MANAGER.current_task + 1) % MAX_APP_NUM; target_task_num != TASK_MANAGER.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    802067de:	fe843783          	ld	a5,-24(s0)
    802067e2:	00178713          	addi	a4,a5,1
    802067e6:	47d1                	li	a5,20
    802067e8:	02f777b3          	remu	a5,a4,a5
    802067ec:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:32 (discriminator 1)
    802067f0:	00b20717          	auipc	a4,0xb20
    802067f4:	82870713          	addi	a4,a4,-2008 # 80d26018 <TASK_MANAGER>
    802067f8:	6785                	lui	a5,0x1
    802067fa:	97ba                	add	a5,a5,a4
    802067fc:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    80206800:	fe843703          	ld	a4,-24(s0)
    80206804:	faf71de3          	bne	a4,a5,802067be <run_next_task+0x2c>
    80206808:	a011                	j	8020680c <run_next_task+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:34
            break;
    8020680a:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:38
        }
    }
    // 没有ready的任务
    if ((target_task_num == TASK_MANAGER.current_task) && (TASK_MANAGER.tasks[target_task_num].task_status != Ready)) {
    8020680c:	00b20717          	auipc	a4,0xb20
    80206810:	80c70713          	addi	a4,a4,-2036 # 80d26018 <TASK_MANAGER>
    80206814:	6785                	lui	a5,0x1
    80206816:	97ba                	add	a5,a5,a4
    80206818:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    8020681c:	fe843703          	ld	a4,-24(s0)
    80206820:	02f71e63          	bne	a4,a5,8020685c <run_next_task+0xca>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:38 (discriminator 1)
    80206824:	00b1f697          	auipc	a3,0xb1f
    80206828:	7f468693          	addi	a3,a3,2036 # 80d26018 <TASK_MANAGER>
    8020682c:	fe843703          	ld	a4,-24(s0)
    80206830:	87ba                	mv	a5,a4
    80206832:	0792                	slli	a5,a5,0x4
    80206834:	8f99                	sub	a5,a5,a4
    80206836:	078e                	slli	a5,a5,0x3
    80206838:	97b6                	add	a5,a5,a3
    8020683a:	479c                	lw	a5,8(a5)
    8020683c:	873e                	mv	a4,a5
    8020683e:	4785                	li	a5,1
    80206840:	00f70e63          	beq	a4,a5,8020685c <run_next_task+0xca>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:39 (discriminator 1)
        ASSERT(0);
    80206844:	00002617          	auipc	a2,0x2
    80206848:	cc460613          	addi	a2,a2,-828 # 80208508 <MMIO+0x28>
    8020684c:	02700593          	li	a1,39
    80206850:	00002517          	auipc	a0,0x2
    80206854:	cd050513          	addi	a0,a0,-816 # 80208520 <MMIO+0x40>
    80206858:	e53ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42
    }

    struct TaskControlBlock* target_task_tcb = &TASK_MANAGER.tasks[target_task_num];
    8020685c:	fe843703          	ld	a4,-24(s0)
    80206860:	87ba                	mv	a5,a4
    80206862:	0792                	slli	a5,a5,0x4
    80206864:	8f99                	sub	a5,a5,a4
    80206866:	078e                	slli	a5,a5,0x3
    80206868:	00b1f717          	auipc	a4,0xb1f
    8020686c:	7b070713          	addi	a4,a4,1968 # 80d26018 <TASK_MANAGER>
    80206870:	97ba                	add	a5,a5,a4
    80206872:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:43
    struct TaskControlBlock* current_task_tcb = &TASK_MANAGER.tasks[TASK_MANAGER.current_task];
    80206876:	00b1f717          	auipc	a4,0xb1f
    8020687a:	7a270713          	addi	a4,a4,1954 # 80d26018 <TASK_MANAGER>
    8020687e:	6785                	lui	a5,0x1
    80206880:	97ba                	add	a5,a5,a4
    80206882:	9607b703          	ld	a4,-1696(a5) # 960 <n+0x940>
    80206886:	87ba                	mv	a5,a4
    80206888:	0792                	slli	a5,a5,0x4
    8020688a:	8f99                	sub	a5,a5,a4
    8020688c:	078e                	slli	a5,a5,0x3
    8020688e:	00b1f717          	auipc	a4,0xb1f
    80206892:	78a70713          	addi	a4,a4,1930 # 80d26018 <TASK_MANAGER>
    80206896:	97ba                	add	a5,a5,a4
    80206898:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:46

    // 改变状态
    current_task_tcb->task_status = status;
    8020689c:	fc843783          	ld	a5,-56(s0)
    802068a0:	0007871b          	sext.w	a4,a5
    802068a4:	fd843783          	ld	a5,-40(s0)
    802068a8:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:47
    target_task_tcb->task_status = Running;
    802068aa:	fe043783          	ld	a5,-32(s0)
    802068ae:	4709                	li	a4,2
    802068b0:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:48
    TASK_MANAGER.current_task = target_task_num;
    802068b2:	00b1f717          	auipc	a4,0xb1f
    802068b6:	76670713          	addi	a4,a4,1894 # 80d26018 <TASK_MANAGER>
    802068ba:	6785                	lui	a5,0x1
    802068bc:	97ba                	add	a5,a5,a4
    802068be:	fe843703          	ld	a4,-24(s0)
    802068c2:	96e7b023          	sd	a4,-1696(a5) # 960 <n+0x940>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:49
    __switch(&(current_task_tcb->task_cx_ptr), &(target_task_tcb->task_cx_ptr));
    802068c6:	fd843783          	ld	a5,-40(s0)
    802068ca:	fe043703          	ld	a4,-32(s0)
    802068ce:	85ba                	mv	a1,a4
    802068d0:	853e                	mv	a0,a5
    802068d2:	670010ef          	jal	ra,80207f42 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:50
}
    802068d6:	0001                	nop
    802068d8:	70e2                	ld	ra,56(sp)
    802068da:	7442                	ld	s0,48(sp)
    802068dc:	6121                	addi	sp,sp,64
    802068de:	8082                	ret

00000000802068e0 <task_manager_get_current_token>:
task_manager_get_current_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:64
//     ASSERT(0);
// }


uint64_t task_manager_get_current_token() 
{
    802068e0:	1101                	addi	sp,sp,-32
    802068e2:	ec06                	sd	ra,24(sp)
    802068e4:	e822                	sd	s0,16(sp)
    802068e6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:65
  uint64_t current = TASK_MANAGER.current_task;
    802068e8:	00b1f717          	auipc	a4,0xb1f
    802068ec:	73070713          	addi	a4,a4,1840 # 80d26018 <TASK_MANAGER>
    802068f0:	6785                	lui	a5,0x1
    802068f2:	97ba                	add	a5,a5,a4
    802068f4:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    802068f8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:66
  return get_user_token(&TASK_MANAGER.tasks[current]);
    802068fc:	fe843703          	ld	a4,-24(s0)
    80206900:	87ba                	mv	a5,a4
    80206902:	0792                	slli	a5,a5,0x4
    80206904:	8f99                	sub	a5,a5,a4
    80206906:	078e                	slli	a5,a5,0x3
    80206908:	00b1f717          	auipc	a4,0xb1f
    8020690c:	71070713          	addi	a4,a4,1808 # 80d26018 <TASK_MANAGER>
    80206910:	97ba                	add	a5,a5,a4
    80206912:	853e                	mv	a0,a5
    80206914:	010000ef          	jal	ra,80206924 <get_user_token>
    80206918:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:67
}
    8020691a:	853e                	mv	a0,a5
    8020691c:	60e2                	ld	ra,24(sp)
    8020691e:	6442                	ld	s0,16(sp)
    80206920:	6105                	addi	sp,sp,32
    80206922:	8082                	ret

0000000080206924 <get_user_token>:
get_user_token():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:71


uint64_t get_user_token(struct TaskControlBlock *s) 
{
    80206924:	1101                	addi	sp,sp,-32
    80206926:	ec06                	sd	ra,24(sp)
    80206928:	e822                	sd	s0,16(sp)
    8020692a:	1000                	addi	s0,sp,32
    8020692c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:72
  return memory_set_token(&s->memory_set);
    80206930:	fe843783          	ld	a5,-24(s0)
    80206934:	07c1                	addi	a5,a5,16
    80206936:	853e                	mv	a0,a5
    80206938:	d4efd0ef          	jal	ra,80203e86 <memory_set_token>
    8020693c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:73
}
    8020693e:	853e                	mv	a0,a5
    80206940:	60e2                	ld	ra,24(sp)
    80206942:	6442                	ld	s0,16(sp)
    80206944:	6105                	addi	sp,sp,32
    80206946:	8082                	ret

0000000080206948 <task_control_block_new>:
task_control_block_new():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:79



void task_control_block_new(uint8_t *elf_data, size_t elf_size, uint64_t app_id,
                            struct TaskControlBlock *s) 
{
    80206948:	7119                	addi	sp,sp,-128
    8020694a:	fc86                	sd	ra,120(sp)
    8020694c:	f8a2                	sd	s0,112(sp)
    8020694e:	f4a6                	sd	s1,104(sp)
    80206950:	f0ca                	sd	s2,96(sp)
    80206952:	0100                	addi	s0,sp,128
    80206954:	f8a43c23          	sd	a0,-104(s0)
    80206958:	f8b43823          	sd	a1,-112(s0)
    8020695c:	f8c43423          	sd	a2,-120(s0)
    80206960:	f8d43023          	sd	a3,-128(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:83
  // memory_set with elf program headers/trampoline/trap context/user stack
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
    80206964:	f8043783          	ld	a5,-128(s0)
    80206968:	07c1                	addi	a5,a5,16
    8020696a:	fa840713          	addi	a4,s0,-88
    8020696e:	fb040693          	addi	a3,s0,-80
    80206972:	f9043603          	ld	a2,-112(s0)
    80206976:	f9843583          	ld	a1,-104(s0)
    8020697a:	853e                	mv	a0,a5
    8020697c:	885fd0ef          	jal	ra,80204200 <memory_set_from_elf>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:85
                      &entry_point);
  PhysPageNum trap_cx_ppn = pte_ppn(*memory_set_translate(
    80206980:	f8043783          	ld	a5,-128(s0)
    80206984:	01078713          	addi	a4,a5,16
    80206988:	77f9                	lui	a5,0xffffe
    8020698a:	00c7d593          	srli	a1,a5,0xc
    8020698e:	853a                	mv	a0,a4
    80206990:	d91fd0ef          	jal	ra,80204720 <memory_set_translate>
    80206994:	87aa                	mv	a5,a0
    80206996:	639c                	ld	a5,0(a5)
    80206998:	00a7d713          	srli	a4,a5,0xa
    8020699c:	57fd                	li	a5,-1
    8020699e:	83d1                	srli	a5,a5,0x14
    802069a0:	8ff9                	and	a5,a5,a4
    802069a2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:89
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // map a kernel-stack in kernel space
  uint64_t kernel_stack_bottom = kernel_stack_position_bottom(app_id);
    802069a6:	f8843703          	ld	a4,-120(s0)
    802069aa:	87ba                	mv	a5,a4
    802069ac:	0786                	slli	a5,a5,0x1
    802069ae:	97ba                	add	a5,a5,a4
    802069b0:	07b2                	slli	a5,a5,0xc
    802069b2:	873e                	mv	a4,a5
    802069b4:	77f5                	lui	a5,0xffffd
    802069b6:	8f99                	sub	a5,a5,a4
    802069b8:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:90
  uint64_t kernel_stack_top = kernel_stack_position_top(app_id);
    802069bc:	f8843703          	ld	a4,-120(s0)
    802069c0:	87ba                	mv	a5,a4
    802069c2:	0786                	slli	a5,a5,0x1
    802069c4:	97ba                	add	a5,a5,a4
    802069c6:	07b2                	slli	a5,a5,0xc
    802069c8:	873e                	mv	a4,a5
    802069ca:	77fd                	lui	a5,0xfffff
    802069cc:	8f99                	sub	a5,a5,a4
    802069ce:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:91
  kernel_space_insert_framed_area((VirtAddr)kernel_stack_bottom,
    802069d2:	4619                	li	a2,6
    802069d4:	fc843583          	ld	a1,-56(s0)
    802069d8:	fd043503          	ld	a0,-48(s0)
    802069dc:	d8dfd0ef          	jal	ra,80204768 <kernel_space_insert_framed_area>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:96
                                  (VirtAddr)kernel_stack_top,
                                  MAP_PERM_R | MAP_PERM_W);

  struct TaskContext *task_cx_ptr =
      (struct TaskContext *)(kernel_stack_top - sizeof(struct TaskContext));
    802069e0:	fc843783          	ld	a5,-56(s0)
    802069e4:	f9878793          	addi	a5,a5,-104 # ffffffffffffef98 <ebss+0xffffffff7f287f98>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:95
  struct TaskContext *task_cx_ptr =
    802069e8:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:97
  task_context_goto_trap_return(task_cx_ptr);
    802069ec:	fc043503          	ld	a0,-64(s0)
    802069f0:	03f000ef          	jal	ra,8020722e <task_context_goto_trap_return>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:99

  s->task_cx_ptr = task_cx_ptr;
    802069f4:	f8043783          	ld	a5,-128(s0)
    802069f8:	fc043703          	ld	a4,-64(s0)
    802069fc:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:100
  s->task_status = Ready;
    802069fe:	f8043783          	ld	a5,-128(s0)
    80206a02:	4705                	li	a4,1
    80206a04:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:101
  s->trap_cx_ppn = trap_cx_ppn;
    80206a06:	f8043783          	ld	a5,-128(s0)
    80206a0a:	fd843703          	ld	a4,-40(s0)
    80206a0e:	efb8                	sd	a4,88(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:102
  s->base_size = user_sp;
    80206a10:	fb043703          	ld	a4,-80(s0)
    80206a14:	f8043783          	ld	a5,-128(s0)
    80206a18:	f3b8                	sd	a4,96(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:105

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = get_trap_cx(s);
    80206a1a:	f8043503          	ld	a0,-128(s0)
    80206a1e:	1ec000ef          	jal	ra,80206c0a <get_trap_cx>
    80206a22:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:106
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
    80206a26:	fa843483          	ld	s1,-88(s0)
    80206a2a:	fb043903          	ld	s2,-80(s0)
    80206a2e:	d9bfd0ef          	jal	ra,802047c8 <kernel_space_token>
    80206a32:	862a                	mv	a2,a0
    80206a34:	00001717          	auipc	a4,0x1
    80206a38:	95a70713          	addi	a4,a4,-1702 # 8020738e <trap_handler>
    80206a3c:	fb843783          	ld	a5,-72(s0)
    80206a40:	fc843683          	ld	a3,-56(s0)
    80206a44:	85ca                	mv	a1,s2
    80206a46:	8526                	mv	a0,s1
    80206a48:	734000ef          	jal	ra,8020717c <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:108
                   (uint64_t)trap_handler, trap_cx);
  s->priority = DEFAULT_PRIORITY;
    80206a4c:	f8043783          	ld	a5,-128(s0)
    80206a50:	4741                	li	a4,16
    80206a52:	f7b8                	sd	a4,104(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:109
  s->stride = 0;
    80206a54:	f8043783          	ld	a5,-128(s0)
    80206a58:	0607b823          	sd	zero,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:135
//        (unsigned long)(trap_cx->kernel_sp & 0xFFFFFFFF));
// printk("trap_handler = 0x%lx%08lx\n",
//        (unsigned long)(trap_cx->trap_handler >> 32),
//        (unsigned long)(trap_cx->trap_handler & 0xFFFFFFFF));
//   }
}
    80206a5c:	0001                	nop
    80206a5e:	70e6                	ld	ra,120(sp)
    80206a60:	7446                	ld	s0,112(sp)
    80206a62:	74a6                	ld	s1,104(sp)
    80206a64:	7906                	ld	s2,96(sp)
    80206a66:	6109                	addi	sp,sp,128
    80206a68:	8082                	ret

0000000080206a6a <task_current_trap_cx>:
task_current_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:138

struct TrapContext *task_current_trap_cx()
{
    80206a6a:	1141                	addi	sp,sp,-16
    80206a6c:	e406                	sd	ra,8(sp)
    80206a6e:	e022                	sd	s0,0(sp)
    80206a70:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:139
  return task_manager_get_current_trap_cx();
    80206a72:	1fe000ef          	jal	ra,80206c70 <task_manager_get_current_trap_cx>
    80206a76:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:140
}
    80206a78:	853e                	mv	a0,a5
    80206a7a:	60a2                	ld	ra,8(sp)
    80206a7c:	6402                	ld	s0,0(sp)
    80206a7e:	0141                	addi	sp,sp,16
    80206a80:	8082                	ret

0000000080206a82 <get_task_cx_ptr2>:
get_task_cx_ptr2():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:143

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s) 
{
    80206a82:	1101                	addi	sp,sp,-32
    80206a84:	ec22                	sd	s0,24(sp)
    80206a86:	1000                	addi	s0,sp,32
    80206a88:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:144
  return (struct TaskContext **)(&(s->task_cx_ptr));
    80206a8c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:145
    80206a90:	853e                	mv	a0,a5
    80206a92:	6462                	ld	s0,24(sp)
    80206a94:	6105                	addi	sp,sp,32
    80206a96:	8082                	ret

0000000080206a98 <init_appmanager>:
init_appmanager():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:13
#include "mem.h"
#include "task.h"
struct AppManager app_manager;
extern struct TaskManager TASK_MANAGER;
void init_appmanager()
{
    80206a98:	1101                	addi	sp,sp,-32
    80206a9a:	ec06                	sd	ra,24(sp)
    80206a9c:	e822                	sd	s0,16(sp)
    80206a9e:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:14
    app_manager.app_num = _num_app[0];
    80206aa0:	00002797          	auipc	a5,0x2
    80206aa4:	59878793          	addi	a5,a5,1432 # 80209038 <_num_app>
    80206aa8:	6398                	ld	a4,0(a5)
    80206aaa:	00b20797          	auipc	a5,0xb20
    80206aae:	ede78793          	addi	a5,a5,-290 # 80d26988 <app_manager>
    80206ab2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80206ab4:	fe043423          	sd	zero,-24(s0)
    80206ab8:	a085                	j	80206b18 <init_appmanager+0x80>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:17 (discriminator 3)
    {
        app_manager.app_start[i] = _num_app[1 + i * 2];
    80206aba:	fe843783          	ld	a5,-24(s0)
    80206abe:	0786                	slli	a5,a5,0x1
    80206ac0:	0785                	addi	a5,a5,1
    80206ac2:	00002717          	auipc	a4,0x2
    80206ac6:	57670713          	addi	a4,a4,1398 # 80209038 <_num_app>
    80206aca:	078e                	slli	a5,a5,0x3
    80206acc:	97ba                	add	a5,a5,a4
    80206ace:	6398                	ld	a4,0(a5)
    80206ad0:	00b20697          	auipc	a3,0xb20
    80206ad4:	eb868693          	addi	a3,a3,-328 # 80d26988 <app_manager>
    80206ad8:	fe843783          	ld	a5,-24(s0)
    80206adc:	0789                	addi	a5,a5,2
    80206ade:	078e                	slli	a5,a5,0x3
    80206ae0:	97b6                	add	a5,a5,a3
    80206ae2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:18 (discriminator 3)
        app_manager.app_end[i] = _num_app[2 + i * 2];
    80206ae4:	fe843783          	ld	a5,-24(s0)
    80206ae8:	0785                	addi	a5,a5,1
    80206aea:	0786                	slli	a5,a5,0x1
    80206aec:	00002717          	auipc	a4,0x2
    80206af0:	54c70713          	addi	a4,a4,1356 # 80209038 <_num_app>
    80206af4:	078e                	slli	a5,a5,0x3
    80206af6:	97ba                	add	a5,a5,a4
    80206af8:	6398                	ld	a4,0(a5)
    80206afa:	00b20697          	auipc	a3,0xb20
    80206afe:	e8e68693          	addi	a3,a3,-370 # 80d26988 <app_manager>
    80206b02:	fe843783          	ld	a5,-24(s0)
    80206b06:	07d9                	addi	a5,a5,22
    80206b08:	078e                	slli	a5,a5,0x3
    80206b0a:	97b6                	add	a5,a5,a3
    80206b0c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 3)
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80206b0e:	fe843783          	ld	a5,-24(s0)
    80206b12:	0785                	addi	a5,a5,1
    80206b14:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 1)
    80206b18:	00b20797          	auipc	a5,0xb20
    80206b1c:	e7078793          	addi	a5,a5,-400 # 80d26988 <app_manager>
    80206b20:	639c                	ld	a5,0(a5)
    80206b22:	fe843703          	ld	a4,-24(s0)
    80206b26:	f8f76ae3          	bltu	a4,a5,80206aba <init_appmanager+0x22>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:20
    }
    app_manager.current_app = 0;
    80206b2a:	00b20797          	auipc	a5,0xb20
    80206b2e:	e5e78793          	addi	a5,a5,-418 # 80d26988 <app_manager>
    80206b32:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:21
    print_app_info(&app_manager);
    80206b36:	00b20517          	auipc	a0,0xb20
    80206b3a:	e5250513          	addi	a0,a0,-430 # 80d26988 <app_manager>
    80206b3e:	00e000ef          	jal	ra,80206b4c <print_app_info>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:22
}
    80206b42:	0001                	nop
    80206b44:	60e2                	ld	ra,24(sp)
    80206b46:	6442                	ld	s0,16(sp)
    80206b48:	6105                	addi	sp,sp,32
    80206b4a:	8082                	ret

0000000080206b4c <print_app_info>:
print_app_info():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:25


void print_app_info(struct AppManager *manager) {
    80206b4c:	7179                	addi	sp,sp,-48
    80206b4e:	f406                	sd	ra,40(sp)
    80206b50:	f022                	sd	s0,32(sp)
    80206b52:	1800                	addi	s0,sp,48
    80206b54:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:26
    print_str("Total applications: ");
    80206b58:	00002517          	auipc	a0,0x2
    80206b5c:	9f850513          	addi	a0,a0,-1544 # 80208550 <MMIO+0x10>
    80206b60:	887ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:27
    print_uint64(manager->app_num);
    80206b64:	fd843783          	ld	a5,-40(s0)
    80206b68:	639c                	ld	a5,0(a5)
    80206b6a:	853e                	mv	a0,a5
    80206b6c:	9f9ff0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:28
    print_str("\n");
    80206b70:	00002517          	auipc	a0,0x2
    80206b74:	9f850513          	addi	a0,a0,-1544 # 80208568 <MMIO+0x28>
    80206b78:	86fff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30

    for (uint64_t i = 0; i < manager->app_num; ++i) {
    80206b7c:	fe043423          	sd	zero,-24(s0)
    80206b80:	a885                	j	80206bf0 <print_app_info+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:31 (discriminator 3)
        print_str("App ");
    80206b82:	00002517          	auipc	a0,0x2
    80206b86:	9ee50513          	addi	a0,a0,-1554 # 80208570 <MMIO+0x30>
    80206b8a:	85dff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:32 (discriminator 3)
        print_uint64(i);
    80206b8e:	fe843503          	ld	a0,-24(s0)
    80206b92:	9d3ff0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:33 (discriminator 3)
        print_str(":\n  Start Address: ");
    80206b96:	00002517          	auipc	a0,0x2
    80206b9a:	9e250513          	addi	a0,a0,-1566 # 80208578 <MMIO+0x38>
    80206b9e:	849ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:34 (discriminator 3)
        print_uint64(manager->app_start[i]);
    80206ba2:	fd843703          	ld	a4,-40(s0)
    80206ba6:	fe843783          	ld	a5,-24(s0)
    80206baa:	0789                	addi	a5,a5,2
    80206bac:	078e                	slli	a5,a5,0x3
    80206bae:	97ba                	add	a5,a5,a4
    80206bb0:	639c                	ld	a5,0(a5)
    80206bb2:	853e                	mv	a0,a5
    80206bb4:	9b1ff0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:35 (discriminator 3)
        print_str("\n  End Address:   ");
    80206bb8:	00002517          	auipc	a0,0x2
    80206bbc:	9d850513          	addi	a0,a0,-1576 # 80208590 <MMIO+0x50>
    80206bc0:	827ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:36 (discriminator 3)
        print_uint64(manager->app_end[i]);
    80206bc4:	fd843703          	ld	a4,-40(s0)
    80206bc8:	fe843783          	ld	a5,-24(s0)
    80206bcc:	07d9                	addi	a5,a5,22
    80206bce:	078e                	slli	a5,a5,0x3
    80206bd0:	97ba                	add	a5,a5,a4
    80206bd2:	639c                	ld	a5,0(a5)
    80206bd4:	853e                	mv	a0,a5
    80206bd6:	98fff0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:37 (discriminator 3)
        print_str("\n");
    80206bda:	00002517          	auipc	a0,0x2
    80206bde:	98e50513          	addi	a0,a0,-1650 # 80208568 <MMIO+0x28>
    80206be2:	805ff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 3)
    for (uint64_t i = 0; i < manager->app_num; ++i) {
    80206be6:	fe843783          	ld	a5,-24(s0)
    80206bea:	0785                	addi	a5,a5,1
    80206bec:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 1)
    80206bf0:	fd843783          	ld	a5,-40(s0)
    80206bf4:	639c                	ld	a5,0(a5)
    80206bf6:	fe843703          	ld	a4,-24(s0)
    80206bfa:	f8f764e3          	bltu	a4,a5,80206b82 <print_app_info+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:39
    }
}
    80206bfe:	0001                	nop
    80206c00:	0001                	nop
    80206c02:	70a2                	ld	ra,40(sp)
    80206c04:	7402                	ld	s0,32(sp)
    80206c06:	6145                	addi	sp,sp,48
    80206c08:	8082                	ret

0000000080206c0a <get_trap_cx>:
get_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:42

struct TrapContext *get_trap_cx(struct TaskControlBlock *s) 
{
    80206c0a:	1101                	addi	sp,sp,-32
    80206c0c:	ec22                	sd	s0,24(sp)
    80206c0e:	1000                	addi	s0,sp,32
    80206c10:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:43
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
    80206c14:	fe843783          	ld	a5,-24(s0)
    80206c18:	6fbc                	ld	a5,88(a5)
    80206c1a:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:44
}
    80206c1c:	853e                	mv	a0,a5
    80206c1e:	6462                	ld	s0,24(sp)
    80206c20:	6105                	addi	sp,sp,32
    80206c22:	8082                	ret

0000000080206c24 <run_first_app>:
run_first_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:67
//     //__restore(trapcontext);
//     __restore((uint64_t)cx);
// }

void run_first_app()
{
    80206c24:	1101                	addi	sp,sp,-32
    80206c26:	ec06                	sd	ra,24(sp)
    80206c28:	e822                	sd	s0,16(sp)
    80206c2a:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:70
    extern void __switch(struct TaskContext **current_task_cx_ptr2,
                       struct TaskContext **next_task_cx_ptr2);
    TASK_MANAGER.tasks[0].task_status = Running;
    80206c2c:	00b1f797          	auipc	a5,0xb1f
    80206c30:	3ec78793          	addi	a5,a5,1004 # 80d26018 <TASK_MANAGER>
    80206c34:	4709                	li	a4,2
    80206c36:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:72
  struct TaskContext **next_task_cx_ptr2 =
      get_task_cx_ptr2(&(TASK_MANAGER.tasks[0]));
    80206c38:	00b1f517          	auipc	a0,0xb1f
    80206c3c:	3e050513          	addi	a0,a0,992 # 80d26018 <TASK_MANAGER>
    80206c40:	e43ff0ef          	jal	ra,80206a82 <get_task_cx_ptr2>
    80206c44:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:73
  uint64_t _unused = 0;
    80206c48:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:74
  printk("run_fisrt_app_end\n");
    80206c4c:	00002517          	auipc	a0,0x2
    80206c50:	95c50513          	addi	a0,a0,-1700 # 802085a8 <MMIO+0x68>
    80206c54:	b97fb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:75
  __switch((struct TaskContext **)&_unused, next_task_cx_ptr2);
    80206c58:	fe040793          	addi	a5,s0,-32
    80206c5c:	fe843583          	ld	a1,-24(s0)
    80206c60:	853e                	mv	a0,a5
    80206c62:	2e0010ef          	jal	ra,80207f42 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76
}
    80206c66:	0001                	nop
    80206c68:	60e2                	ld	ra,24(sp)
    80206c6a:	6442                	ld	s0,16(sp)
    80206c6c:	6105                	addi	sp,sp,32
    80206c6e:	8082                	ret

0000000080206c70 <task_manager_get_current_trap_cx>:
task_manager_get_current_trap_cx():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:109
//     }
// }


struct TrapContext *task_manager_get_current_trap_cx() 
{
    80206c70:	1101                	addi	sp,sp,-32
    80206c72:	ec06                	sd	ra,24(sp)
    80206c74:	e822                	sd	s0,16(sp)
    80206c76:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:110
  uint64_t current = TASK_MANAGER.current_task;
    80206c78:	00b1f717          	auipc	a4,0xb1f
    80206c7c:	3a070713          	addi	a4,a4,928 # 80d26018 <TASK_MANAGER>
    80206c80:	6785                	lui	a5,0x1
    80206c82:	97ba                	add	a5,a5,a4
    80206c84:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    80206c88:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:111
  return get_trap_cx(&TASK_MANAGER.tasks[current]);
    80206c8c:	fe843703          	ld	a4,-24(s0)
    80206c90:	87ba                	mv	a5,a4
    80206c92:	0792                	slli	a5,a5,0x4
    80206c94:	8f99                	sub	a5,a5,a4
    80206c96:	078e                	slli	a5,a5,0x3
    80206c98:	00b1f717          	auipc	a4,0xb1f
    80206c9c:	38070713          	addi	a4,a4,896 # 80d26018 <TASK_MANAGER>
    80206ca0:	97ba                	add	a5,a5,a4
    80206ca2:	853e                	mv	a0,a5
    80206ca4:	f67ff0ef          	jal	ra,80206c0a <get_trap_cx>
    80206ca8:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:112
}
    80206caa:	853e                	mv	a0,a5
    80206cac:	60e2                	ld	ra,24(sp)
    80206cae:	6442                	ld	s0,16(sp)
    80206cb0:	6105                	addi	sp,sp,32
    80206cb2:	8082                	ret

0000000080206cb4 <task_control_block_free>:
task_control_block_free():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:114

void task_control_block_free(struct TaskControlBlock *s) {
    80206cb4:	1101                	addi	sp,sp,-32
    80206cb6:	ec06                	sd	ra,24(sp)
    80206cb8:	e822                	sd	s0,16(sp)
    80206cba:	1000                	addi	s0,sp,32
    80206cbc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:115
  memory_set_free(&s->memory_set);
    80206cc0:	fe843783          	ld	a5,-24(s0)
    80206cc4:	07c1                	addi	a5,a5,16
    80206cc6:	853e                	mv	a0,a5
    80206cc8:	b34fd0ef          	jal	ra,80203ffc <memory_set_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:116
}
    80206ccc:	0001                	nop
    80206cce:	60e2                	ld	ra,24(sp)
    80206cd0:	6442                	ld	s0,16(sp)
    80206cd2:	6105                	addi	sp,sp,32
    80206cd4:	8082                	ret

0000000080206cd6 <task_manager_mark_current_exited>:
task_manager_mark_current_exited():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:119

void task_manager_mark_current_exited() 
{
    80206cd6:	1101                	addi	sp,sp,-32
    80206cd8:	ec06                	sd	ra,24(sp)
    80206cda:	e822                	sd	s0,16(sp)
    80206cdc:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:120
  uint64_t current = TASK_MANAGER.current_task;
    80206cde:	00b1f717          	auipc	a4,0xb1f
    80206ce2:	33a70713          	addi	a4,a4,826 # 80d26018 <TASK_MANAGER>
    80206ce6:	6785                	lui	a5,0x1
    80206ce8:	97ba                	add	a5,a5,a4
    80206cea:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    80206cee:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:121
  task_control_block_free(&TASK_MANAGER.tasks[current]);
    80206cf2:	fe843703          	ld	a4,-24(s0)
    80206cf6:	87ba                	mv	a5,a4
    80206cf8:	0792                	slli	a5,a5,0x4
    80206cfa:	8f99                	sub	a5,a5,a4
    80206cfc:	078e                	slli	a5,a5,0x3
    80206cfe:	00b1f717          	auipc	a4,0xb1f
    80206d02:	31a70713          	addi	a4,a4,794 # 80d26018 <TASK_MANAGER>
    80206d06:	97ba                	add	a5,a5,a4
    80206d08:	853e                	mv	a0,a5
    80206d0a:	fabff0ef          	jal	ra,80206cb4 <task_control_block_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:122
  TASK_MANAGER.tasks[current].task_status = Exited;
    80206d0e:	00b1f697          	auipc	a3,0xb1f
    80206d12:	30a68693          	addi	a3,a3,778 # 80d26018 <TASK_MANAGER>
    80206d16:	fe843703          	ld	a4,-24(s0)
    80206d1a:	87ba                	mv	a5,a4
    80206d1c:	0792                	slli	a5,a5,0x4
    80206d1e:	8f99                	sub	a5,a5,a4
    80206d20:	078e                	slli	a5,a5,0x3
    80206d22:	97b6                	add	a5,a5,a3
    80206d24:	470d                	li	a4,3
    80206d26:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:123
}
    80206d28:	0001                	nop
    80206d2a:	60e2                	ld	ra,24(sp)
    80206d2c:	6442                	ld	s0,16(sp)
    80206d2e:	6105                	addi	sp,sp,32
    80206d30:	8082                	ret

0000000080206d32 <task_manager_find_next_task>:
task_manager_find_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:127


int64_t task_manager_find_next_task() 
{
    80206d32:	7139                	addi	sp,sp,-64
    80206d34:	fc22                	sd	s0,56(sp)
    80206d36:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:128
  uint64_t num_app = TASK_MANAGER.num_app;
    80206d38:	00b1f717          	auipc	a4,0xb1f
    80206d3c:	2e070713          	addi	a4,a4,736 # 80d26018 <TASK_MANAGER>
    80206d40:	6785                	lui	a5,0x1
    80206d42:	97ba                	add	a5,a5,a4
    80206d44:	9687b783          	ld	a5,-1688(a5) # 968 <n+0x948>
    80206d48:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:129
  uint64_t min_stride = __UINT64_MAX__;
    80206d4c:	57fd                	li	a5,-1
    80206d4e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:130
  uint64_t min_id = -1;
    80206d52:	57fd                	li	a5,-1
    80206d54:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:131
  for (uint64_t i = 0; i < num_app; i++) 
    80206d58:	fc043c23          	sd	zero,-40(s0)
    80206d5c:	a095                	j	80206dc0 <task_manager_find_next_task+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:133
  {
    if (TASK_MANAGER.tasks[i].task_status == Ready) {
    80206d5e:	00b1f697          	auipc	a3,0xb1f
    80206d62:	2ba68693          	addi	a3,a3,698 # 80d26018 <TASK_MANAGER>
    80206d66:	fd843703          	ld	a4,-40(s0)
    80206d6a:	87ba                	mv	a5,a4
    80206d6c:	0792                	slli	a5,a5,0x4
    80206d6e:	8f99                	sub	a5,a5,a4
    80206d70:	078e                	slli	a5,a5,0x3
    80206d72:	97b6                	add	a5,a5,a3
    80206d74:	479c                	lw	a5,8(a5)
    80206d76:	873e                	mv	a4,a5
    80206d78:	4785                	li	a5,1
    80206d7a:	02f71e63          	bne	a4,a5,80206db6 <task_manager_find_next_task+0x84>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:134
      uint64_t current_stride = TASK_MANAGER.tasks[i].stride;
    80206d7e:	00b1f697          	auipc	a3,0xb1f
    80206d82:	29a68693          	addi	a3,a3,666 # 80d26018 <TASK_MANAGER>
    80206d86:	fd843703          	ld	a4,-40(s0)
    80206d8a:	87ba                	mv	a5,a4
    80206d8c:	0792                	slli	a5,a5,0x4
    80206d8e:	8f99                	sub	a5,a5,a4
    80206d90:	078e                	slli	a5,a5,0x3
    80206d92:	97b6                	add	a5,a5,a3
    80206d94:	7bbc                	ld	a5,112(a5)
    80206d96:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:135
      if (current_stride < min_stride) 
    80206d9a:	fc843703          	ld	a4,-56(s0)
    80206d9e:	fe843783          	ld	a5,-24(s0)
    80206da2:	00f77a63          	bgeu	a4,a5,80206db6 <task_manager_find_next_task+0x84>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:137
      {
        min_stride = current_stride;
    80206da6:	fc843783          	ld	a5,-56(s0)
    80206daa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:138
        min_id = i;
    80206dae:	fd843783          	ld	a5,-40(s0)
    80206db2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:131 (discriminator 2)
  for (uint64_t i = 0; i < num_app; i++) 
    80206db6:	fd843783          	ld	a5,-40(s0)
    80206dba:	0785                	addi	a5,a5,1
    80206dbc:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:131 (discriminator 1)
    80206dc0:	fd843703          	ld	a4,-40(s0)
    80206dc4:	fd043783          	ld	a5,-48(s0)
    80206dc8:	f8f76be3          	bltu	a4,a5,80206d5e <task_manager_find_next_task+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:142
      }
    }
  }
  return min_id;
    80206dcc:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:143
}
    80206dd0:	853e                	mv	a0,a5
    80206dd2:	7462                	ld	s0,56(sp)
    80206dd4:	6121                	addi	sp,sp,64
    80206dd6:	8082                	ret

0000000080206dd8 <task_manager_run_next_task>:
task_manager_run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:146

void task_manager_run_next_task() 
{
    80206dd8:	7139                	addi	sp,sp,-64
    80206dda:	fc06                	sd	ra,56(sp)
    80206ddc:	f822                	sd	s0,48(sp)
    80206dde:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:149
    extern void __switch(struct TaskContext **current_task_cx_ptr2,
                     struct TaskContext **next_task_cx_ptr2);
  int64_t next = task_manager_find_next_task();
    80206de0:	f53ff0ef          	jal	ra,80206d32 <task_manager_find_next_task>
    80206de4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:150
  if (next >= 0)
    80206de8:	fe843783          	ld	a5,-24(s0)
    80206dec:	0e07c963          	bltz	a5,80206ede <task_manager_run_next_task+0x106>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:152
  {
    uint64_t current = TASK_MANAGER.current_task;
    80206df0:	00b1f717          	auipc	a4,0xb1f
    80206df4:	22870713          	addi	a4,a4,552 # 80d26018 <TASK_MANAGER>
    80206df8:	6785                	lui	a5,0x1
    80206dfa:	97ba                	add	a5,a5,a4
    80206dfc:	9607b783          	ld	a5,-1696(a5) # 960 <n+0x940>
    80206e00:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:153
    TASK_MANAGER.tasks[next].task_status = Running;
    80206e04:	00b1f697          	auipc	a3,0xb1f
    80206e08:	21468693          	addi	a3,a3,532 # 80d26018 <TASK_MANAGER>
    80206e0c:	fe843703          	ld	a4,-24(s0)
    80206e10:	87ba                	mv	a5,a4
    80206e12:	0792                	slli	a5,a5,0x4
    80206e14:	8f99                	sub	a5,a5,a4
    80206e16:	078e                	slli	a5,a5,0x3
    80206e18:	97b6                	add	a5,a5,a3
    80206e1a:	4709                	li	a4,2
    80206e1c:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:154
    uint64_t pass = BIG_STRIDE / TASK_MANAGER.tasks[next].priority;
    80206e1e:	00b1f697          	auipc	a3,0xb1f
    80206e22:	1fa68693          	addi	a3,a3,506 # 80d26018 <TASK_MANAGER>
    80206e26:	fe843703          	ld	a4,-24(s0)
    80206e2a:	87ba                	mv	a5,a4
    80206e2c:	0792                	slli	a5,a5,0x4
    80206e2e:	8f99                	sub	a5,a5,a4
    80206e30:	078e                	slli	a5,a5,0x3
    80206e32:	97b6                	add	a5,a5,a3
    80206e34:	77bc                	ld	a5,104(a5)
    80206e36:	6761                	lui	a4,0x18
    80206e38:	6a070713          	addi	a4,a4,1696 # 186a0 <n+0x18680>
    80206e3c:	02f757b3          	divu	a5,a4,a5
    80206e40:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:155
    TASK_MANAGER.tasks[next].stride += pass;
    80206e44:	00b1f697          	auipc	a3,0xb1f
    80206e48:	1d468693          	addi	a3,a3,468 # 80d26018 <TASK_MANAGER>
    80206e4c:	fe843703          	ld	a4,-24(s0)
    80206e50:	87ba                	mv	a5,a4
    80206e52:	0792                	slli	a5,a5,0x4
    80206e54:	8f99                	sub	a5,a5,a4
    80206e56:	078e                	slli	a5,a5,0x3
    80206e58:	97b6                	add	a5,a5,a3
    80206e5a:	7bb8                	ld	a4,112(a5)
    80206e5c:	fd843783          	ld	a5,-40(s0)
    80206e60:	00f706b3          	add	a3,a4,a5
    80206e64:	00b1f617          	auipc	a2,0xb1f
    80206e68:	1b460613          	addi	a2,a2,436 # 80d26018 <TASK_MANAGER>
    80206e6c:	fe843703          	ld	a4,-24(s0)
    80206e70:	87ba                	mv	a5,a4
    80206e72:	0792                	slli	a5,a5,0x4
    80206e74:	8f99                	sub	a5,a5,a4
    80206e76:	078e                	slli	a5,a5,0x3
    80206e78:	97b2                	add	a5,a5,a2
    80206e7a:	fbb4                	sd	a3,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:156
    TASK_MANAGER.current_task = next;
    80206e7c:	fe843703          	ld	a4,-24(s0)
    80206e80:	00b1f697          	auipc	a3,0xb1f
    80206e84:	19868693          	addi	a3,a3,408 # 80d26018 <TASK_MANAGER>
    80206e88:	6785                	lui	a5,0x1
    80206e8a:	97b6                	add	a5,a5,a3
    80206e8c:	96e7b023          	sd	a4,-1696(a5) # 960 <n+0x940>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:158
    struct TaskContext **current_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[current]));
    80206e90:	fe043703          	ld	a4,-32(s0)
    80206e94:	87ba                	mv	a5,a4
    80206e96:	0792                	slli	a5,a5,0x4
    80206e98:	8f99                	sub	a5,a5,a4
    80206e9a:	078e                	slli	a5,a5,0x3
    80206e9c:	00b1f717          	auipc	a4,0xb1f
    80206ea0:	17c70713          	addi	a4,a4,380 # 80d26018 <TASK_MANAGER>
    80206ea4:	97ba                	add	a5,a5,a4
    80206ea6:	853e                	mv	a0,a5
    80206ea8:	bdbff0ef          	jal	ra,80206a82 <get_task_cx_ptr2>
    80206eac:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:160
    struct TaskContext **next_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[next]));
    80206eb0:	fe843703          	ld	a4,-24(s0)
    80206eb4:	87ba                	mv	a5,a4
    80206eb6:	0792                	slli	a5,a5,0x4
    80206eb8:	8f99                	sub	a5,a5,a4
    80206eba:	078e                	slli	a5,a5,0x3
    80206ebc:	00b1f717          	auipc	a4,0xb1f
    80206ec0:	15c70713          	addi	a4,a4,348 # 80d26018 <TASK_MANAGER>
    80206ec4:	97ba                	add	a5,a5,a4
    80206ec6:	853e                	mv	a0,a5
    80206ec8:	bbbff0ef          	jal	ra,80206a82 <get_task_cx_ptr2>
    80206ecc:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:161
    __switch(current_task_cx_ptr2, next_task_cx_ptr2);
    80206ed0:	fc843583          	ld	a1,-56(s0)
    80206ed4:	fd043503          	ld	a0,-48(s0)
    80206ed8:	06a010ef          	jal	ra,80207f42 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:166
  } else {
    mm_free();
    panic("All applications completed!\n");
  }
}
    80206edc:	a839                	j	80206efa <task_manager_run_next_task+0x122>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:163
    mm_free();
    80206ede:	ddefe0ef          	jal	ra,802054bc <mm_free>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:164
    panic("All applications completed!\n");
    80206ee2:	00001617          	auipc	a2,0x1
    80206ee6:	6de60613          	addi	a2,a2,1758 # 802085c0 <MMIO+0x80>
    80206eea:	0a400593          	li	a1,164
    80206eee:	00001517          	auipc	a0,0x1
    80206ef2:	6f250513          	addi	a0,a0,1778 # 802085e0 <MMIO+0xa0>
    80206ef6:	fb4ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:166
}
    80206efa:	0001                	nop
    80206efc:	70e2                	ld	ra,56(sp)
    80206efe:	7442                	ld	s0,48(sp)
    80206f00:	6121                	addi	sp,sp,64
    80206f02:	8082                	ret

0000000080206f04 <task_exit_current_and_run_next>:
task_exit_current_and_run_next():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:169

void task_exit_current_and_run_next() 
{
    80206f04:	1141                	addi	sp,sp,-16
    80206f06:	e406                	sd	ra,8(sp)
    80206f08:	e022                	sd	s0,0(sp)
    80206f0a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:170
  task_manager_mark_current_exited();
    80206f0c:	dcbff0ef          	jal	ra,80206cd6 <task_manager_mark_current_exited>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:171
  task_manager_run_next_task();
    80206f10:	ec9ff0ef          	jal	ra,80206dd8 <task_manager_run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:172
    80206f14:	0001                	nop
    80206f16:	60a2                	ld	ra,8(sp)
    80206f18:	6402                	ld	s0,0(sp)
    80206f1a:	0141                	addi	sp,sp,16
    80206f1c:	8082                	ret

0000000080206f1e <get_kernel_stack_top>:
get_kernel_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:14
uint8_t Trap_Stack[1024];
uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];


uint64_t get_kernel_stack_top( uint64_t app_id ) {
    80206f1e:	1101                	addi	sp,sp,-32
    80206f20:	ec22                	sd	s0,24(sp)
    80206f22:	1000                	addi	s0,sp,32
    80206f24:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:15
    return (uint64_t)(Kernelstack[app_id]) + KERNEL_STACK_SIZE;
    80206f28:	fe843783          	ld	a5,-24(s0)
    80206f2c:	00d79713          	slli	a4,a5,0xd
    80206f30:	00b48797          	auipc	a5,0xb48
    80206f34:	fa878793          	addi	a5,a5,-88 # 80d4eed8 <Kernelstack>
    80206f38:	97ba                	add	a5,a5,a4
    80206f3a:	873e                	mv	a4,a5
    80206f3c:	6789                	lui	a5,0x2
    80206f3e:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:16
}
    80206f40:	853e                	mv	a0,a5
    80206f42:	6462                	ld	s0,24(sp)
    80206f44:	6105                	addi	sp,sp,32
    80206f46:	8082                	ret

0000000080206f48 <get_user_stack_top>:
get_user_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:19


uint64_t get_user_stack_top( uint64_t app_id ) {
    80206f48:	1101                	addi	sp,sp,-32
    80206f4a:	ec22                	sd	s0,24(sp)
    80206f4c:	1000                	addi	s0,sp,32
    80206f4e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:20
    return (uint64_t)(UserStack[app_id]) + USER_STACK_SIZE;
    80206f52:	fe843783          	ld	a5,-24(s0)
    80206f56:	00d79713          	slli	a4,a5,0xd
    80206f5a:	00b20797          	auipc	a5,0xb20
    80206f5e:	f7e78793          	addi	a5,a5,-130 # 80d26ed8 <UserStack>
    80206f62:	97ba                	add	a5,a5,a4
    80206f64:	873e                	mv	a4,a5
    80206f66:	6789                	lui	a5,0x2
    80206f68:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:21
}
    80206f6a:	853e                	mv	a0,a5
    80206f6c:	6462                	ld	s0,24(sp)
    80206f6e:	6105                	addi	sp,sp,32
    80206f70:	8082                	ret

0000000080206f72 <Kernelstack_push_TrapContext>:
Kernelstack_push_TrapContext():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:25


uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
{
    80206f72:	7179                	addi	sp,sp,-48
    80206f74:	f406                	sd	ra,40(sp)
    80206f76:	f022                	sd	s0,32(sp)
    80206f78:	1800                	addi	s0,sp,48
    80206f7a:	80aa                	mv	ra,a0
    80206f7c:	fcb43c23          	sd	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:26
    uint8_t* stackTop = Kernelstack[task_id] + KERNEL_STACK_SIZE; // 指向栈顶
    80206f80:	fd843783          	ld	a5,-40(s0)
    80206f84:	00d79713          	slli	a4,a5,0xd
    80206f88:	00b48797          	auipc	a5,0xb48
    80206f8c:	f5078793          	addi	a5,a5,-176 # 80d4eed8 <Kernelstack>
    80206f90:	973e                	add	a4,a4,a5
    80206f92:	6789                	lui	a5,0x2
    80206f94:	97ba                	add	a5,a5,a4
    80206f96:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:27
    stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
    80206f9a:	fe843783          	ld	a5,-24(s0)
    80206f9e:	ed878793          	addi	a5,a5,-296 # 1ed8 <n+0x1eb8>
    80206fa2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:28
    *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
    80206fa6:	fe843783          	ld	a5,-24(s0)
    80206faa:	873e                	mv	a4,a5
    80206fac:	8686                	mv	a3,ra
    80206fae:	12800793          	li	a5,296
    80206fb2:	863e                	mv	a2,a5
    80206fb4:	85b6                	mv	a1,a3
    80206fb6:	853a                	mv	a0,a4
    80206fb8:	f9cfc0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:29
    return stackTop; // 返回新的栈顶地址
    80206fbc:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:30
}
    80206fc0:	853e                	mv	a0,a5
    80206fc2:	70a2                	ld	ra,40(sp)
    80206fc4:	7402                	ld	s0,32(sp)
    80206fc6:	6145                	addi	sp,sp,48
    80206fc8:	8082                	ret

0000000080206fca <kernel_stack_position>:
kernel_stack_position():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:33

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top) 
{
    80206fca:	7179                	addi	sp,sp,-48
    80206fcc:	f422                	sd	s0,40(sp)
    80206fce:	1800                	addi	s0,sp,48
    80206fd0:	fea43423          	sd	a0,-24(s0)
    80206fd4:	feb43023          	sd	a1,-32(s0)
    80206fd8:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:34
    *top = TRAMPOLINE - app_id * (KERNEL_STACK_SIZE + PAGE_SIZE);
    80206fdc:	fe843703          	ld	a4,-24(s0)
    80206fe0:	87ba                	mv	a5,a4
    80206fe2:	0786                	slli	a5,a5,0x1
    80206fe4:	97ba                	add	a5,a5,a4
    80206fe6:	07b2                	slli	a5,a5,0xc
    80206fe8:	873e                	mv	a4,a5
    80206fea:	77fd                	lui	a5,0xfffff
    80206fec:	40e78733          	sub	a4,a5,a4
    80206ff0:	fd843783          	ld	a5,-40(s0)
    80206ff4:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:35
    *bottom = *top - KERNEL_STACK_SIZE;
    80206ff6:	fd843783          	ld	a5,-40(s0)
    80206ffa:	6398                	ld	a4,0(a5)
    80206ffc:	77f9                	lui	a5,0xffffe
    80206ffe:	973e                	add	a4,a4,a5
    80207000:	fe043783          	ld	a5,-32(s0)
    80207004:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:36
    80207006:	0001                	nop
    80207008:	7422                	ld	s0,40(sp)
    8020700a:	6145                	addi	sp,sp,48
    8020700c:	8082                	ret

000000008020700e <loader_get_num_app>:
loader_get_num_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:4
#include "config.h"
#include "debug.h"
uint64_t loader_get_num_app() 
{
    8020700e:	1141                	addi	sp,sp,-16
    80207010:	e422                	sd	s0,8(sp)
    80207012:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:6
  extern uint64_t _num_app;
  return _num_app;
    80207014:	00002797          	auipc	a5,0x2
    80207018:	02478793          	addi	a5,a5,36 # 80209038 <_num_app>
    8020701c:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:7
}
    8020701e:	853e                	mv	a0,a5
    80207020:	6422                	ld	s0,8(sp)
    80207022:	0141                	addi	sp,sp,16
    80207024:	8082                	ret

0000000080207026 <loader_get_app_data>:
loader_get_app_data():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:10

uint8_t *loader_get_app_data(uint64_t app_id) 
{
    80207026:	1101                	addi	sp,sp,-32
    80207028:	ec06                	sd	ra,24(sp)
    8020702a:	e822                	sd	s0,16(sp)
    8020702c:	1000                	addi	s0,sp,32
    8020702e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:11
    ASSERT(app_id < loader_get_num_app());
    80207032:	fddff0ef          	jal	ra,8020700e <loader_get_num_app>
    80207036:	872a                	mv	a4,a0
    80207038:	fe843783          	ld	a5,-24(s0)
    8020703c:	00e7ed63          	bltu	a5,a4,80207056 <loader_get_app_data+0x30>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:11 (discriminator 1)
    80207040:	00001617          	auipc	a2,0x1
    80207044:	5d860613          	addi	a2,a2,1496 # 80208618 <MMIO+0x10>
    80207048:	45ad                	li	a1,11
    8020704a:	00001517          	auipc	a0,0x1
    8020704e:	5fe50513          	addi	a0,a0,1534 # 80208648 <MMIO+0x40>
    80207052:	e58ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:19
    {
    &app_0_start,
    &app_1_start,
    &app_2_start
    };
    return app_starts[app_id];
    80207056:	00002717          	auipc	a4,0x2
    8020705a:	faa70713          	addi	a4,a4,-86 # 80209000 <app_starts.1>
    8020705e:	fe843783          	ld	a5,-24(s0)
    80207062:	078e                	slli	a5,a5,0x3
    80207064:	97ba                	add	a5,a5,a4
    80207066:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:20
}
    80207068:	853e                	mv	a0,a5
    8020706a:	60e2                	ld	ra,24(sp)
    8020706c:	6442                	ld	s0,16(sp)
    8020706e:	6105                	addi	sp,sp,32
    80207070:	8082                	ret

0000000080207072 <loader_get_app_size>:
loader_get_app_size():
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:24


size_t loader_get_app_size(uint64_t app_id) 
{
    80207072:	7179                	addi	sp,sp,-48
    80207074:	f406                	sd	ra,40(sp)
    80207076:	f022                	sd	s0,32(sp)
    80207078:	1800                	addi	s0,sp,48
    8020707a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:28
    //printk("loader_get_app_size start\n");
    
    // 确保提供的 app_id 是有效的
    uint64_t num_app = loader_get_num_app();
    8020707e:	f91ff0ef          	jal	ra,8020700e <loader_get_num_app>
    80207082:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:29
    ASSERT(app_id < num_app);
    80207086:	fd843703          	ld	a4,-40(s0)
    8020708a:	fe843783          	ld	a5,-24(s0)
    8020708e:	00f76d63          	bltu	a4,a5,802070a8 <loader_get_app_size+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:29 (discriminator 1)
    80207092:	00001617          	auipc	a2,0x1
    80207096:	5d660613          	addi	a2,a2,1494 # 80208668 <MMIO+0x60>
    8020709a:	45f5                	li	a1,29
    8020709c:	00001517          	auipc	a0,0x1
    802070a0:	5ac50513          	addi	a0,a0,1452 # 80208648 <MMIO+0x40>
    802070a4:	e06ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:42
        &app_2_start,
        &app_2_end, // 用于计算最后一个应用程序的大小
    };

    // 计算并返回应用程序的大小
    size_t app_size = app_starts_ends[app_id + 1] - app_starts_ends[app_id];
    802070a8:	fd843783          	ld	a5,-40(s0)
    802070ac:	0785                	addi	a5,a5,1
    802070ae:	00002717          	auipc	a4,0x2
    802070b2:	f6a70713          	addi	a4,a4,-150 # 80209018 <app_starts_ends.0>
    802070b6:	078e                	slli	a5,a5,0x3
    802070b8:	97ba                	add	a5,a5,a4
    802070ba:	6398                	ld	a4,0(a5)
    802070bc:	00002697          	auipc	a3,0x2
    802070c0:	f5c68693          	addi	a3,a3,-164 # 80209018 <app_starts_ends.0>
    802070c4:	fd843783          	ld	a5,-40(s0)
    802070c8:	078e                	slli	a5,a5,0x3
    802070ca:	97b6                	add	a5,a5,a3
    802070cc:	639c                	ld	a5,0(a5)
    802070ce:	40f707b3          	sub	a5,a4,a5
    802070d2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:50
    //     printk("App %d Start/End Address: %d\n", i, (uint64_t)app_starts_ends[i]);
    // }
    
    // printk("App ID: %d Size: %d\n", app_id, app_size);
    //ASSERT(0);
    printk("App ID: %d Size: %d\n", app_id, app_size);
    802070d6:	fe043603          	ld	a2,-32(s0)
    802070da:	fd843583          	ld	a1,-40(s0)
    802070de:	00001517          	auipc	a0,0x1
    802070e2:	5b250513          	addi	a0,a0,1458 # 80208690 <MMIO+0x88>
    802070e6:	f04fb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:51
    return app_size;
    802070ea:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/loader/loader.c:52
}
    802070ee:	853e                	mv	a0,a5
    802070f0:	70a2                	ld	ra,40(sp)
    802070f2:	7402                	ld	s0,32(sp)
    802070f4:	6145                	addi	sp,sp,48
    802070f6:	8082                	ret

00000000802070f8 <r_sstatus>:
r_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:46
static inline uint64_t r_sstatus() {
    802070f8:	1101                	addi	sp,sp,-32
    802070fa:	ec22                	sd	s0,24(sp)
    802070fc:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:48
  asm volatile("csrr %0, sstatus" : "=r"(x));
    802070fe:	100027f3          	csrr	a5,sstatus
    80207102:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:49
  return x;
    80207106:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:50
}
    8020710a:	853e                	mv	a0,a5
    8020710c:	6462                	ld	s0,24(sp)
    8020710e:	6105                	addi	sp,sp,32
    80207110:	8082                	ret

0000000080207112 <set_sstatus_spp_user>:
set_sstatus_spp_user():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:7
#include "stdint.h"
#include "context.h"
#include "riscv.h"
#include "trap.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    80207112:	7179                	addi	sp,sp,-48
    80207114:	f422                	sd	s0,40(sp)
    80207116:	1800                	addi	s0,sp,48
    80207118:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:8
    uint64_t mask = 1UL << 8;
    8020711c:	10000793          	li	a5,256
    80207120:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:9
    *sstatus &= ~mask;
    80207124:	fd843783          	ld	a5,-40(s0)
    80207128:	6398                	ld	a4,0(a5)
    8020712a:	fe843783          	ld	a5,-24(s0)
    8020712e:	fff7c793          	not	a5,a5
    80207132:	8f7d                	and	a4,a4,a5
    80207134:	fd843783          	ld	a5,-40(s0)
    80207138:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:10
}
    8020713a:	0001                	nop
    8020713c:	7422                	ld	s0,40(sp)
    8020713e:	6145                	addi	sp,sp,48
    80207140:	8082                	ret

0000000080207142 <read_sstatus>:
read_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:13

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    80207142:	1101                	addi	sp,sp,-32
    80207144:	ec22                	sd	s0,24(sp)
    80207146:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:14
    return READ_CSR(sstatus);
    80207148:	100027f3          	csrr	a5,sstatus
    8020714c:	fef43423          	sd	a5,-24(s0)
    80207150:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:15
}
    80207154:	853e                	mv	a0,a5
    80207156:	6462                	ld	s0,24(sp)
    80207158:	6105                	addi	sp,sp,32
    8020715a:	8082                	ret

000000008020715c <set_sp>:
set_sp():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:18

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    8020715c:	1101                	addi	sp,sp,-32
    8020715e:	ec22                	sd	s0,24(sp)
    80207160:	1000                	addi	s0,sp,32
    80207162:	fea43423          	sd	a0,-24(s0)
    80207166:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:19
    ctx->x[2] = sp;
    8020716a:	fe843783          	ld	a5,-24(s0)
    8020716e:	fe043703          	ld	a4,-32(s0)
    80207172:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:20
}
    80207174:	0001                	nop
    80207176:	6462                	ld	s0,24(sp)
    80207178:	6105                	addi	sp,sp,32
    8020717a:	8082                	ret

000000008020717c <app_init_context>:
app_init_context():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:27


void app_init_context(uint64_t entry, uint64_t sp, uint64_t kernel_satp,
                      uint64_t kernel_sp, uint64_t trap_handler,
                      struct TrapContext *c) 
{
    8020717c:	715d                	addi	sp,sp,-80
    8020717e:	e486                	sd	ra,72(sp)
    80207180:	e0a2                	sd	s0,64(sp)
    80207182:	0880                	addi	s0,sp,80
    80207184:	fca43c23          	sd	a0,-40(s0)
    80207188:	fcb43823          	sd	a1,-48(s0)
    8020718c:	fcc43423          	sd	a2,-56(s0)
    80207190:	fcd43023          	sd	a3,-64(s0)
    80207194:	fae43c23          	sd	a4,-72(s0)
    80207198:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:28
  uint64_t sstatus = r_sstatus();
    8020719c:	f5dff0ef          	jal	ra,802070f8 <r_sstatus>
    802071a0:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:29
  sstatus &= ~SSTATUS_SPP;
    802071a4:	fe043783          	ld	a5,-32(s0)
    802071a8:	eff7f793          	andi	a5,a5,-257
    802071ac:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31

  for (int i = 0; i < 32; i++)
    802071b0:	fe042623          	sw	zero,-20(s0)
    802071b4:	a831                	j	802071d0 <app_init_context+0x54>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:32 (discriminator 3)
    c->x[i] = 0;
    802071b6:	fb043703          	ld	a4,-80(s0)
    802071ba:	fec42783          	lw	a5,-20(s0)
    802071be:	078e                	slli	a5,a5,0x3
    802071c0:	97ba                	add	a5,a5,a4
    802071c2:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31 (discriminator 3)
  for (int i = 0; i < 32; i++)
    802071c6:	fec42783          	lw	a5,-20(s0)
    802071ca:	2785                	addiw	a5,a5,1
    802071cc:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:31 (discriminator 1)
    802071d0:	fec42783          	lw	a5,-20(s0)
    802071d4:	0007871b          	sext.w	a4,a5
    802071d8:	47fd                	li	a5,31
    802071da:	fce7dee3          	bge	a5,a4,802071b6 <app_init_context+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:33
  c->sstatus = sstatus;
    802071de:	fb043783          	ld	a5,-80(s0)
    802071e2:	fe043703          	ld	a4,-32(s0)
    802071e6:	10e7b023          	sd	a4,256(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:34
  c->sepc = entry;
    802071ea:	fb043783          	ld	a5,-80(s0)
    802071ee:	fd843703          	ld	a4,-40(s0)
    802071f2:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:35
  c->kernel_satp = kernel_satp;
    802071f6:	fb043783          	ld	a5,-80(s0)
    802071fa:	fc843703          	ld	a4,-56(s0)
    802071fe:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:36
  c->kernel_sp = kernel_sp;
    80207202:	fb043783          	ld	a5,-80(s0)
    80207206:	fc043703          	ld	a4,-64(s0)
    8020720a:	10e7bc23          	sd	a4,280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:37
  c->trap_handler = trap_handler;
    8020720e:	fb043783          	ld	a5,-80(s0)
    80207212:	fb843703          	ld	a4,-72(s0)
    80207216:	12e7b023          	sd	a4,288(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:38
  c->x[2] = sp;
    8020721a:	fb043783          	ld	a5,-80(s0)
    8020721e:	fd043703          	ld	a4,-48(s0)
    80207222:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:39
}
    80207224:	0001                	nop
    80207226:	60a6                	ld	ra,72(sp)
    80207228:	6406                	ld	s0,64(sp)
    8020722a:	6161                	addi	sp,sp,80
    8020722c:	8082                	ret

000000008020722e <task_context_goto_trap_return>:
task_context_goto_trap_return():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:42

void task_context_goto_trap_return(struct TaskContext *cx) 
{
    8020722e:	7179                	addi	sp,sp,-48
    80207230:	f422                	sd	s0,40(sp)
    80207232:	1800                	addi	s0,sp,48
    80207234:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:43
  cx->ra = (uint64_t)trap_return;
    80207238:	00000717          	auipc	a4,0x0
    8020723c:	27070713          	addi	a4,a4,624 # 802074a8 <trap_return>
    80207240:	fd843783          	ld	a5,-40(s0)
    80207244:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44
  for (int i = 0; i < 12; i++)
    80207246:	fe042623          	sw	zero,-20(s0)
    8020724a:	a831                	j	80207266 <task_context_goto_trap_return+0x38>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:45 (discriminator 3)
    cx->x[i] = 0;
    8020724c:	fd843703          	ld	a4,-40(s0)
    80207250:	fec42783          	lw	a5,-20(s0)
    80207254:	078e                	slli	a5,a5,0x3
    80207256:	97ba                	add	a5,a5,a4
    80207258:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44 (discriminator 3)
  for (int i = 0; i < 12; i++)
    8020725c:	fec42783          	lw	a5,-20(s0)
    80207260:	2785                	addiw	a5,a5,1
    80207262:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:44 (discriminator 1)
    80207266:	fec42783          	lw	a5,-20(s0)
    8020726a:	0007871b          	sext.w	a4,a5
    8020726e:	47ad                	li	a5,11
    80207270:	fce7dee3          	bge	a5,a4,8020724c <task_context_goto_trap_return+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:46
}
    80207274:	0001                	nop
    80207276:	0001                	nop
    80207278:	7422                	ld	s0,40(sp)
    8020727a:	6145                	addi	sp,sp,48
    8020727c:	8082                	ret

000000008020727e <r_sepc>:
r_sepc():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:102
static inline uint64_t r_sepc() {
    8020727e:	1101                	addi	sp,sp,-32
    80207280:	ec22                	sd	s0,24(sp)
    80207282:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:104
  asm volatile("csrr %0, sepc" : "=r"(x));
    80207284:	141027f3          	csrr	a5,sepc
    80207288:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:105
  return x;
    8020728c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:106
}
    80207290:	853e                	mv	a0,a5
    80207292:	6462                	ld	s0,24(sp)
    80207294:	6105                	addi	sp,sp,32
    80207296:	8082                	ret

0000000080207298 <w_stvec>:
w_stvec():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:132
static inline void w_stvec(uint64_t x) {
    80207298:	1101                	addi	sp,sp,-32
    8020729a:	ec22                	sd	s0,24(sp)
    8020729c:	1000                	addi	s0,sp,32
    8020729e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:133
  asm volatile("csrw stvec, %0" : : "r"(x));
    802072a2:	fe843783          	ld	a5,-24(s0)
    802072a6:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:134
}
    802072aa:	0001                	nop
    802072ac:	6462                	ld	s0,24(sp)
    802072ae:	6105                	addi	sp,sp,32
    802072b0:	8082                	ret

00000000802072b2 <r_scause>:
r_scause():
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:174
static inline uint64_t r_scause() {
    802072b2:	1101                	addi	sp,sp,-32
    802072b4:	ec22                	sd	s0,24(sp)
    802072b6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:176
  asm volatile("csrr %0, scause" : "=r"(x));
    802072b8:	142027f3          	csrr	a5,scause
    802072bc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:177
  return x;
    802072c0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/globle/riscv.h:178
}
    802072c4:	853e                	mv	a0,a5
    802072c6:	6462                	ld	s0,24(sp)
    802072c8:	6105                	addi	sp,sp,32
    802072ca:	8082                	ret

00000000802072cc <print_sepc>:
print_sepc():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:18
extern void __alltraps();
extern void __restore();


void print_sepc()
{
    802072cc:	1101                	addi	sp,sp,-32
    802072ce:	ec06                	sd	ra,24(sp)
    802072d0:	e822                	sd	s0,16(sp)
    802072d2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:19
    print_str("sepc : ");
    802072d4:	00001517          	auipc	a0,0x1
    802072d8:	3f450513          	addi	a0,a0,1012 # 802086c8 <MMIO+0x10>
    802072dc:	90aff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:20
    print_uint64(READ_CSR(sepc));
    802072e0:	141027f3          	csrr	a5,sepc
    802072e4:	fef43423          	sd	a5,-24(s0)
    802072e8:	fe843783          	ld	a5,-24(s0)
    802072ec:	853e                	mv	a0,a5
    802072ee:	a76ff0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:21
    print_str("\n");    
    802072f2:	00001517          	auipc	a0,0x1
    802072f6:	3de50513          	addi	a0,a0,990 # 802086d0 <MMIO+0x18>
    802072fa:	8ecff0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:22
}
    802072fe:	0001                	nop
    80207300:	60e2                	ld	ra,24(sp)
    80207302:	6442                	ld	s0,16(sp)
    80207304:	6105                	addi	sp,sp,32
    80207306:	8082                	ret

0000000080207308 <init_interrupt>:
init_interrupt():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:25

void init_interrupt()
{
    80207308:	7139                	addi	sp,sp,-64
    8020730a:	fc22                	sd	s0,56(sp)
    8020730c:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:26
    uint64_t stvec_value = (uint64_t)(__alltraps);
    8020730e:	ffffa797          	auipc	a5,0xffffa
    80207312:	cf278793          	addi	a5,a5,-782 # 80201000 <__alltraps>
    80207316:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:27
    asm volatile("csrw stvec, %0" :: "r"(stvec_value));
    8020731a:	fe843783          	ld	a5,-24(s0)
    8020731e:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:28
    uint64_t mask = 0x202;
    80207322:	20200793          	li	a5,514
    80207326:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:29
    WRITE_CSR(sie,mask);
    8020732a:	fe043783          	ld	a5,-32(s0)
    8020732e:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:30
    uint64_t sstatus = READ_CSR(sstatus);
    80207332:	100027f3          	csrr	a5,sstatus
    80207336:	fcf43c23          	sd	a5,-40(s0)
    8020733a:	fd843783          	ld	a5,-40(s0)
    8020733e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:31
    sstatus |= SSTATUS_SIE_BIT;
    80207342:	fd043783          	ld	a5,-48(s0)
    80207346:	0027e793          	ori	a5,a5,2
    8020734a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:32
    WRITE_CSR(sstatus, sstatus);
    8020734e:	fd043783          	ld	a5,-48(s0)
    80207352:	10079073          	csrw	sstatus,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:33
    uint64_t sie = READ_CSR(sie);
    80207356:	104027f3          	csrr	a5,sie
    8020735a:	fcf43423          	sd	a5,-56(s0)
    8020735e:	fc843783          	ld	a5,-56(s0)
    80207362:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:34
    sie |= SIE_SSIE_BIT | SIE_STIE_BIT | SIE_SEIE_BIT;
    80207366:	fc043783          	ld	a5,-64(s0)
    8020736a:	2227e793          	ori	a5,a5,546
    8020736e:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:35
    WRITE_CSR(sie, sie);
    80207372:	fc043783          	ld	a5,-64(s0)
    80207376:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:36
    WRITE_CSR(sscratch,Trap_Stack);
    8020737a:	00b1f797          	auipc	a5,0xb1f
    8020737e:	75e78793          	addi	a5,a5,1886 # 80d26ad8 <Trap_Stack>
    80207382:	14079073          	csrw	sscratch,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:37
}
    80207386:	0001                	nop
    80207388:	7462                	ld	s0,56(sp)
    8020738a:	6121                	addi	sp,sp,64
    8020738c:	8082                	ret

000000008020738e <trap_handler>:
trap_handler():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:39

void trap_handler() {
    8020738e:	1101                	addi	sp,sp,-32
    80207390:	ec06                	sd	ra,24(sp)
    80207392:	e822                	sd	s0,16(sp)
    80207394:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:40
  set_kernel_trap_entry();
    80207396:	4a6000ef          	jal	ra,8020783c <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:42

  struct TrapContext *cx = task_current_trap_cx();
    8020739a:	ed0ff0ef          	jal	ra,80206a6a <task_current_trap_cx>
    8020739e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:43
  uint64_t scause = r_scause();
    802073a2:	f11ff0ef          	jal	ra,802072b2 <r_scause>
    802073a6:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:46
  //uint64_t stval = r_stval();

  if (scause & (1ULL << 63)) {
    802073aa:	fe043783          	ld	a5,-32(s0)
    802073ae:	0207d363          	bgez	a5,802073d4 <trap_handler+0x46>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:47
    scause &= ~(1ULL << 63);
    802073b2:	fe043703          	ld	a4,-32(s0)
    802073b6:	57fd                	li	a5,-1
    802073b8:	8385                	srli	a5,a5,0x1
    802073ba:	8ff9                	and	a5,a5,a4
    802073bc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:48
    switch (scause) {
    802073c0:	fe043703          	ld	a4,-32(s0)
    802073c4:	4795                	li	a5,5
    802073c6:	0af71163          	bne	a4,a5,80207468 <trap_handler+0xda>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:50
    case SupervisorTimer:
      intr_timer_handle();
    802073ca:	70a000ef          	jal	ra,80207ad4 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:51
      task_exit_current_and_run_next();
    802073ce:	b37ff0ef          	jal	ra,80206f04 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:52
      break;
    802073d2:	a861                	j	8020746a <trap_handler+0xdc>
    802073d4:	fe043703          	ld	a4,-32(s0)
    802073d8:	47bd                	li	a5,15
    802073da:	06e7ea63          	bltu	a5,a4,8020744e <trap_handler+0xc0>
    802073de:	fe043783          	ld	a5,-32(s0)
    802073e2:	00279713          	slli	a4,a5,0x2
    802073e6:	00001797          	auipc	a5,0x1
    802073ea:	31e78793          	addi	a5,a5,798 # 80208704 <MMIO+0x4c>
    802073ee:	97ba                	add	a5,a5,a4
    802073f0:	439c                	lw	a5,0(a5)
    802073f2:	0007871b          	sext.w	a4,a5
    802073f6:	00001797          	auipc	a5,0x1
    802073fa:	30e78793          	addi	a5,a5,782 # 80208704 <MMIO+0x4c>
    802073fe:	97ba                	add	a5,a5,a4
    80207400:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:60
      break;
    }
  } else {
    switch (scause) {
    case UserEnvCall:
      cx->sepc += 4;
    80207402:	fe843783          	ld	a5,-24(s0)
    80207406:	1087b783          	ld	a5,264(a5)
    8020740a:	00478713          	addi	a4,a5,4
    8020740e:	fe843783          	ld	a5,-24(s0)
    80207412:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:61
      cx->x[10] = syscall(cx->x[17], cx->x[10], cx->x[11], cx->x[12]);
    80207416:	fe843783          	ld	a5,-24(s0)
    8020741a:	67d8                	ld	a4,136(a5)
    8020741c:	fe843783          	ld	a5,-24(s0)
    80207420:	6bac                	ld	a1,80(a5)
    80207422:	fe843783          	ld	a5,-24(s0)
    80207426:	6fb0                	ld	a2,88(a5)
    80207428:	fe843783          	ld	a5,-24(s0)
    8020742c:	73bc                	ld	a5,96(a5)
    8020742e:	86be                	mv	a3,a5
    80207430:	853a                	mv	a0,a4
    80207432:	578000ef          	jal	ra,802079aa <syscall>
    80207436:	87aa                	mv	a5,a0
    80207438:	873e                	mv	a4,a5
    8020743a:	fe843783          	ld	a5,-24(s0)
    8020743e:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:62
      break;
    80207440:	a02d                	j	8020746a <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:71
    case InstructionPageFault:
    case LoadFault:
    case LoadPageFault:
      ASSERT("Exception %lld in application, bad addr = %llx, bad instruction = ");
      ASSERT("LoadPageFault\n");
      task_exit_current_and_run_next();
    80207442:	ac3ff0ef          	jal	ra,80206f04 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:72
      break;
    80207446:	a015                	j	8020746a <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:75
    case IllegalInstruction:
      ASSERT("IllegalInstruction in application, core dumped.\n");
      task_exit_current_and_run_next();
    80207448:	abdff0ef          	jal	ra,80206f04 <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:76
      break;
    8020744c:	a839                	j	8020746a <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:78 (discriminator 1)
    default:
      ASSERT(0);
    8020744e:	00001617          	auipc	a2,0x1
    80207452:	28a60613          	addi	a2,a2,650 # 802086d8 <MMIO+0x20>
    80207456:	04e00593          	li	a1,78
    8020745a:	00001517          	auipc	a0,0x1
    8020745e:	29650513          	addi	a0,a0,662 # 802086f0 <MMIO+0x38>
    80207462:	a48ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:79 (discriminator 1)
      break;
    80207466:	a011                	j	8020746a <trap_handler+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:55
      break;
    80207468:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:83
    }
  }

  trap_return();
    8020746a:	03e000ef          	jal	ra,802074a8 <trap_return>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:84
}
    8020746e:	0001                	nop
    80207470:	60e2                	ld	ra,24(sp)
    80207472:	6442                	ld	s0,16(sp)
    80207474:	6105                	addi	sp,sp,32
    80207476:	8082                	ret

0000000080207478 <set_user_trap_entry>:
set_user_trap_entry():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:88


void set_user_trap_entry() 
{
    80207478:	1141                	addi	sp,sp,-16
    8020747a:	e406                	sd	ra,8(sp)
    8020747c:	e022                	sd	s0,0(sp)
    8020747e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:89
  w_stvec((uint64_t)TRAMPOLINE);
    80207480:	757d                	lui	a0,0xfffff
    80207482:	e17ff0ef          	jal	ra,80207298 <w_stvec>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:90
}
    80207486:	0001                	nop
    80207488:	60a2                	ld	ra,8(sp)
    8020748a:	6402                	ld	s0,0(sp)
    8020748c:	0141                	addi	sp,sp,16
    8020748e:	8082                	ret

0000000080207490 <task_current_user_token>:
task_current_user_token():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:93


uint64_t task_current_user_token() {
    80207490:	1141                	addi	sp,sp,-16
    80207492:	e406                	sd	ra,8(sp)
    80207494:	e022                	sd	s0,0(sp)
    80207496:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:94
  return task_manager_get_current_token();
    80207498:	c48ff0ef          	jal	ra,802068e0 <task_manager_get_current_token>
    8020749c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:95
}
    8020749e:	853e                	mv	a0,a5
    802074a0:	60a2                	ld	ra,8(sp)
    802074a2:	6402                	ld	s0,0(sp)
    802074a4:	0141                	addi	sp,sp,16
    802074a6:	8082                	ret

00000000802074a8 <trap_return>:
trap_return():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:98

void trap_return() 
{
    802074a8:	7179                	addi	sp,sp,-48
    802074aa:	f406                	sd	ra,40(sp)
    802074ac:	f022                	sd	s0,32(sp)
    802074ae:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:99
  printk("trap_return\n");
    802074b0:	00001517          	auipc	a0,0x1
    802074b4:	29850513          	addi	a0,a0,664 # 80208748 <MMIO+0x90>
    802074b8:	b32fb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:100
  set_user_trap_entry();
    802074bc:	fbdff0ef          	jal	ra,80207478 <set_user_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:101
  uint64_t trap_cx_ptr = TRAP_CONTEXT;
    802074c0:	77f9                	lui	a5,0xffffe
    802074c2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:102
  uint64_t user_satp = task_current_user_token();
    802074c6:	fcbff0ef          	jal	ra,80207490 <task_current_user_token>
    802074ca:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:103
  uint64_t restore_va = (uint64_t)__restore - (uint64_t)__alltraps + TRAMPOLINE;
    802074ce:	ffffa717          	auipc	a4,0xffffa
    802074d2:	b9270713          	addi	a4,a4,-1134 # 80201060 <__restore>
    802074d6:	77fd                	lui	a5,0xfffff
    802074d8:	973e                	add	a4,a4,a5
    802074da:	ffffa797          	auipc	a5,0xffffa
    802074de:	b2678793          	addi	a5,a5,-1242 # 80201000 <__alltraps>
    802074e2:	40f707b3          	sub	a5,a4,a5
    802074e6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:104
  asm volatile("fence.i");
    802074ea:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:106
  asm volatile("");
  asm volatile("mv x10, %1\n"
    802074ee:	fd843783          	ld	a5,-40(s0)
    802074f2:	fe843703          	ld	a4,-24(s0)
    802074f6:	fe043683          	ld	a3,-32(s0)
    802074fa:	853a                	mv	a0,a4
    802074fc:	85b6                	mv	a1,a3
    802074fe:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:112
               "mv x11, %2\n"
               "jr %0\n"
               :
               : "r"(restore_va), "r"(trap_cx_ptr), "r"(user_satp)
               : "memory", "x10", "x11");
  panic("Unreachable in back_to_user!\n");
    80207500:	00001617          	auipc	a2,0x1
    80207504:	25860613          	addi	a2,a2,600 # 80208758 <MMIO+0xa0>
    80207508:	07000593          	li	a1,112
    8020750c:	00001517          	auipc	a0,0x1
    80207510:	1e450513          	addi	a0,a0,484 # 802086f0 <MMIO+0x38>
    80207514:	996ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:113
}
    80207518:	0001                	nop
    8020751a:	70a2                	ld	ra,40(sp)
    8020751c:	7402                	ld	s0,32(sp)
    8020751e:	6145                	addi	sp,sp,48
    80207520:	8082                	ret

0000000080207522 <init_trap>:
init_trap():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:117


void init_trap()
{
    80207522:	1141                	addi	sp,sp,-16
    80207524:	e406                	sd	ra,8(sp)
    80207526:	e022                	sd	s0,0(sp)
    80207528:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:118
    set_kernel_trap_entry();
    8020752a:	312000ef          	jal	ra,8020783c <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:119
}
    8020752e:	0001                	nop
    80207530:	60a2                	ld	ra,8(sp)
    80207532:	6402                	ld	s0,0(sp)
    80207534:	0141                	addi	sp,sp,16
    80207536:	8082                	ret

0000000080207538 <trap_from_kernel>:
trap_from_kernel():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:123


void trap_from_kernel()
{
    80207538:	7139                	addi	sp,sp,-64
    8020753a:	fc06                	sd	ra,56(sp)
    8020753c:	f822                	sd	s0,48(sp)
    8020753e:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:124
    printk("a trap from kernel!\n");
    80207540:	00001517          	auipc	a0,0x1
    80207544:	23850513          	addi	a0,a0,568 # 80208778 <MMIO+0xc0>
    80207548:	aa2fb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:125
    uint64_t tmp = r_sepc();
    8020754c:	d33ff0ef          	jal	ra,8020727e <r_sepc>
    80207550:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:126
    printk("trap_from_kernel : sepc : %d\n",tmp);
    80207554:	fd843583          	ld	a1,-40(s0)
    80207558:	00001517          	auipc	a0,0x1
    8020755c:	23850513          	addi	a0,a0,568 # 80208790 <MMIO+0xd8>
    80207560:	a8afb0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:127
    uint64_t scause = READ_CSR(scause);
    80207564:	142027f3          	csrr	a5,scause
    80207568:	fcf43823          	sd	a5,-48(s0)
    8020756c:	fd043783          	ld	a5,-48(s0)
    80207570:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:129
    //uint64_t stval = READ_CSR(stval);
    switch (scause)
    80207574:	fc843703          	ld	a4,-56(s0)
    80207578:	47bd                	li	a5,15
    8020757a:	02e7e963          	bltu	a5,a4,802075ac <trap_from_kernel+0x74>
    8020757e:	fc843703          	ld	a4,-56(s0)
    80207582:	47bd                	li	a5,15
    80207584:	26e7ee63          	bltu	a5,a4,80207800 <trap_from_kernel+0x2c8>
    80207588:	fc843783          	ld	a5,-56(s0)
    8020758c:	00279713          	slli	a4,a5,0x2
    80207590:	00001797          	auipc	a5,0x1
    80207594:	41c78793          	addi	a5,a5,1052 # 802089ac <MMIO+0x2f4>
    80207598:	97ba                	add	a5,a5,a4
    8020759a:	439c                	lw	a5,0(a5)
    8020759c:	0007871b          	sext.w	a4,a5
    802075a0:	00001797          	auipc	a5,0x1
    802075a4:	40c78793          	addi	a5,a5,1036 # 802089ac <MMIO+0x2f4>
    802075a8:	97ba                	add	a5,a5,a4
    802075aa:	8782                	jr	a5
    802075ac:	fc843703          	ld	a4,-56(s0)
    802075b0:	57fd                	li	a5,-1
    802075b2:	17fe                	slli	a5,a5,0x3f
    802075b4:	0795                	addi	a5,a5,5
    802075b6:	24f70263          	beq	a4,a5,802077fa <trap_from_kernel+0x2c2>
    802075ba:	a499                	j	80207800 <trap_from_kernel+0x2c8>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:132
    {
        case 0x00: // 指令地址错位
            print_str("[kernel] Instruction Address Misaligned.\n");
    802075bc:	00001517          	auipc	a0,0x1
    802075c0:	1f450513          	addi	a0,a0,500 # 802087b0 <MMIO+0xf8>
    802075c4:	e23fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:133
            break;
    802075c8:	ac89                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:135
        case 0x01: // 指令访问故障
            print_str("[kernel] Instruction Access Fault.\n");
    802075ca:	00001517          	auipc	a0,0x1
    802075ce:	21650513          	addi	a0,a0,534 # 802087e0 <MMIO+0x128>
    802075d2:	e15fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:136
            run_next_task(3);
    802075d6:	450d                	li	a0,3
    802075d8:	9baff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:137
            break;
    802075dc:	ac3d                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:140
        case 0x02: // 非法指令
            //print_sepc();
            print_str("kernel] Illegal Instruction.\n");
    802075de:	00001517          	auipc	a0,0x1
    802075e2:	22a50513          	addi	a0,a0,554 # 80208808 <MMIO+0x150>
    802075e6:	e01fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:141
            ASSERT(0);
    802075ea:	00001617          	auipc	a2,0x1
    802075ee:	0ee60613          	addi	a2,a2,238 # 802086d8 <MMIO+0x20>
    802075f2:	08d00593          	li	a1,141
    802075f6:	00001517          	auipc	a0,0x1
    802075fa:	0fa50513          	addi	a0,a0,250 # 802086f0 <MMIO+0x38>
    802075fe:	8acff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:142
            run_next_task(3);
    80207602:	450d                	li	a0,3
    80207604:	98eff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:143
            break;
    80207608:	ac09                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:145
        case 0x03: // 断点
            print_str("[kernel] Breakpoint.\n");
    8020760a:	00001517          	auipc	a0,0x1
    8020760e:	21e50513          	addi	a0,a0,542 # 80208828 <MMIO+0x170>
    80207612:	dd5fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:147
            // 特定的调试处理或直接运行下一个应用
            ASSERT(0);
    80207616:	00001617          	auipc	a2,0x1
    8020761a:	0c260613          	addi	a2,a2,194 # 802086d8 <MMIO+0x20>
    8020761e:	09300593          	li	a1,147
    80207622:	00001517          	auipc	a0,0x1
    80207626:	0ce50513          	addi	a0,a0,206 # 802086f0 <MMIO+0x38>
    8020762a:	880ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:149
            //cx->sepc +=2;
            ASSERT(0);
    8020762e:	00001617          	auipc	a2,0x1
    80207632:	0aa60613          	addi	a2,a2,170 # 802086d8 <MMIO+0x20>
    80207636:	09500593          	li	a1,149
    8020763a:	00001517          	auipc	a0,0x1
    8020763e:	0b650513          	addi	a0,a0,182 # 802086f0 <MMIO+0x38>
    80207642:	868ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:151
            //run_next_app();
            break;
    80207646:	aad1                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:153
        case 0x04: // 加载地址错位
            print_str("[kernel] Load Address Misaligned.\n");
    80207648:	00001517          	auipc	a0,0x1
    8020764c:	1f850513          	addi	a0,a0,504 # 80208840 <MMIO+0x188>
    80207650:	d97fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:154
            ASSERT(0);
    80207654:	00001617          	auipc	a2,0x1
    80207658:	08460613          	addi	a2,a2,132 # 802086d8 <MMIO+0x20>
    8020765c:	09a00593          	li	a1,154
    80207660:	00001517          	auipc	a0,0x1
    80207664:	09050513          	addi	a0,a0,144 # 802086f0 <MMIO+0x38>
    80207668:	842ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:155
            run_next_task(3);
    8020766c:	450d                	li	a0,3
    8020766e:	924ff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:156
            break;
    80207672:	a265                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:159
        case 0x05: // 加载访问故障
            //print_sepc();
            print_str("[kernel] Load Access Fault.\n");
    80207674:	00001517          	auipc	a0,0x1
    80207678:	1f450513          	addi	a0,a0,500 # 80208868 <MMIO+0x1b0>
    8020767c:	d6bfe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:160
            ASSERT(0);
    80207680:	00001617          	auipc	a2,0x1
    80207684:	05860613          	addi	a2,a2,88 # 802086d8 <MMIO+0x20>
    80207688:	0a000593          	li	a1,160
    8020768c:	00001517          	auipc	a0,0x1
    80207690:	06450513          	addi	a0,a0,100 # 802086f0 <MMIO+0x38>
    80207694:	816ff0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:161
            run_next_task(3);
    80207698:	450d                	li	a0,3
    8020769a:	8f8ff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:162
            break;
    8020769e:	aab5                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:165
        case 0x06: // 存储地址错位
            //print_sepc();
            print_str("[kernel] Store/AMO Address Misaligned.\n");
    802076a0:	00001517          	auipc	a0,0x1
    802076a4:	1e850513          	addi	a0,a0,488 # 80208888 <MMIO+0x1d0>
    802076a8:	d3ffe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:166
            ASSERT(0);
    802076ac:	00001617          	auipc	a2,0x1
    802076b0:	02c60613          	addi	a2,a2,44 # 802086d8 <MMIO+0x20>
    802076b4:	0a600593          	li	a1,166
    802076b8:	00001517          	auipc	a0,0x1
    802076bc:	03850513          	addi	a0,a0,56 # 802086f0 <MMIO+0x38>
    802076c0:	febfe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:167
            run_next_task(3);
    802076c4:	450d                	li	a0,3
    802076c6:	8ccff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:168
            break;
    802076ca:	aa81                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:170
        case 0x07: // 存储/AMO访问故障
            print_str("[kernel] Store/AMO Access Fault.\n");
    802076cc:	00001517          	auipc	a0,0x1
    802076d0:	1e450513          	addi	a0,a0,484 # 802088b0 <MMIO+0x1f8>
    802076d4:	d13fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:172
            //print_sepc();
            ASSERT(0);
    802076d8:	00001617          	auipc	a2,0x1
    802076dc:	00060613          	mv	a2,a2
    802076e0:	0ac00593          	li	a1,172
    802076e4:	00001517          	auipc	a0,0x1
    802076e8:	00c50513          	addi	a0,a0,12 # 802086f0 <MMIO+0x38>
    802076ec:	fbffe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:173
            uint64_t cnt=10000000000;
    802076f0:	009507b7          	lui	a5,0x950
    802076f4:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    802076f8:	07aa                	slli	a5,a5,0xa
    802076fa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:174
            while(cnt--){}
    802076fe:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:174 (discriminator 1)
    80207700:	fe843783          	ld	a5,-24(s0)
    80207704:	fff78713          	addi	a4,a5,-1
    80207708:	fee43423          	sd	a4,-24(s0)
    8020770c:	fbf5                	bnez	a5,80207700 <trap_from_kernel+0x1c8>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:176
            //run_next_app();
            break;
    8020770e:	a231                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:181 (discriminator 1)
        case 0x08: // 环境调用来自U模式
            //cx->sepc += 4; // 跳过环境调用指令
            //uint64_t args[3] = {cx->x[10], cx->x[11], cx->x[12]};
            //cx->x[10] = syscall(cx->x[17], args); // 执行系统调用
            ASSERT(0);
    80207710:	00001617          	auipc	a2,0x1
    80207714:	fc860613          	addi	a2,a2,-56 # 802086d8 <MMIO+0x20>
    80207718:	0b500593          	li	a1,181
    8020771c:	00001517          	auipc	a0,0x1
    80207720:	fd450513          	addi	a0,a0,-44 # 802086f0 <MMIO+0x38>
    80207724:	f87fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:182 (discriminator 1)
            break;
    80207728:	a8cd                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:184
        case 0x09: // 环境调用来自S模式
            print_str("[kernel] Environment Call from S-mode.\n");
    8020772a:	00001517          	auipc	a0,0x1
    8020772e:	1ae50513          	addi	a0,a0,430 # 802088d8 <MMIO+0x220>
    80207732:	cb5fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:185
            uint64_t cnt1=10000000000;
    80207736:	009507b7          	lui	a5,0x950
    8020773a:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    8020773e:	07aa                	slli	a5,a5,0xa
    80207740:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:186
            while(cnt1--){}
    80207744:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:186 (discriminator 1)
    80207746:	fe043783          	ld	a5,-32(s0)
    8020774a:	fff78713          	addi	a4,a5,-1
    8020774e:	fee43023          	sd	a4,-32(s0)
    80207752:	fbf5                	bnez	a5,80207746 <trap_from_kernel+0x20e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:187 (discriminator 1)
            ASSERT(0);
    80207754:	00001617          	auipc	a2,0x1
    80207758:	f8460613          	addi	a2,a2,-124 # 802086d8 <MMIO+0x20>
    8020775c:	0bb00593          	li	a1,187
    80207760:	00001517          	auipc	a0,0x1
    80207764:	f9050513          	addi	a0,a0,-112 # 802086f0 <MMIO+0x38>
    80207768:	f43fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:188 (discriminator 1)
            run_next_task(3);
    8020776c:	450d                	li	a0,3
    8020776e:	824ff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:189 (discriminator 1)
            break;
    80207772:	a065                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:191
        case 0x0B: // 环境调用来自M模式
            print_str("[kernel] Environment Call from M-mode.\n");
    80207774:	00001517          	auipc	a0,0x1
    80207778:	18c50513          	addi	a0,a0,396 # 80208900 <MMIO+0x248>
    8020777c:	c6bfe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:193
            // 处理或运行下一个应用
            run_next_task(3);
    80207780:	450d                	li	a0,3
    80207782:	810ff0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:194
            break;
    80207786:	a851                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:196
        case 0x0C: // 指令页面错误
            print_str("[kernel] Instruction Page Fault.\n");
    80207788:	00001517          	auipc	a0,0x1
    8020778c:	1a050513          	addi	a0,a0,416 # 80208928 <MMIO+0x270>
    80207790:	c57fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:197
            ASSERT(0);
    80207794:	00001617          	auipc	a2,0x1
    80207798:	f4460613          	addi	a2,a2,-188 # 802086d8 <MMIO+0x20>
    8020779c:	0c500593          	li	a1,197
    802077a0:	00001517          	auipc	a0,0x1
    802077a4:	f5050513          	addi	a0,a0,-176 # 802086f0 <MMIO+0x38>
    802077a8:	f03fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:199
            //run_next_task(3);
            break;
    802077ac:	a0bd                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:201
        case 0x0D: // 加载页面错误
            print_str("[kernel] Load Page Fault.\n");
    802077ae:	00001517          	auipc	a0,0x1
    802077b2:	1a250513          	addi	a0,a0,418 # 80208950 <MMIO+0x298>
    802077b6:	c31fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:202
            ASSERT(0);
    802077ba:	00001617          	auipc	a2,0x1
    802077be:	f1e60613          	addi	a2,a2,-226 # 802086d8 <MMIO+0x20>
    802077c2:	0ca00593          	li	a1,202
    802077c6:	00001517          	auipc	a0,0x1
    802077ca:	f2a50513          	addi	a0,a0,-214 # 802086f0 <MMIO+0x38>
    802077ce:	eddfe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:204
            //run_next_task(3);
            break;
    802077d2:	a0a1                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:206
        case 0x0F: // 存储页面错误
            print_str("[kernel] Store/AMO Page Fault.\n");
    802077d4:	00001517          	auipc	a0,0x1
    802077d8:	19c50513          	addi	a0,a0,412 # 80208970 <MMIO+0x2b8>
    802077dc:	c0bfe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:207
            ASSERT(0);
    802077e0:	00001617          	auipc	a2,0x1
    802077e4:	ef860613          	addi	a2,a2,-264 # 802086d8 <MMIO+0x20>
    802077e8:	0cf00593          	li	a1,207
    802077ec:	00001517          	auipc	a0,0x1
    802077f0:	f0450513          	addi	a0,a0,-252 # 802086f0 <MMIO+0x38>
    802077f4:	eb7fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:209
            //run_next_task(3);
            break;
    802077f8:	a00d                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:212
        case 0x8000000000000005: 
            //print_str("intr_timer_handle\n");
            intr_timer_handle();
    802077fa:	2da000ef          	jal	ra,80207ad4 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:214
            //ASSERT(0);
            break;
    802077fe:	a831                	j	8020781a <trap_from_kernel+0x2e2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:216
        default:
            print_str("[kernel] Unsupported trap.\n");
    80207800:	00001517          	auipc	a0,0x1
    80207804:	19050513          	addi	a0,a0,400 # 80208990 <MMIO+0x2d8>
    80207808:	bdffe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:217
            print_uint64(scause);
    8020780c:	fc843503          	ld	a0,-56(s0)
    80207810:	d55fe0ef          	jal	ra,80206564 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:218
            exit(1);
    80207814:	4505                	li	a0,1
    80207816:	046000ef          	jal	ra,8020785c <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:220 (discriminator 1)
    }
    ASSERT(0);
    8020781a:	00001617          	auipc	a2,0x1
    8020781e:	ebe60613          	addi	a2,a2,-322 # 802086d8 <MMIO+0x20>
    80207822:	0dc00593          	li	a1,220
    80207826:	00001517          	auipc	a0,0x1
    8020782a:	eca50513          	addi	a0,a0,-310 # 802086f0 <MMIO+0x38>
    8020782e:	e7dfe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:221 (discriminator 1)
}
    80207832:	0001                	nop
    80207834:	70e2                	ld	ra,56(sp)
    80207836:	7442                	ld	s0,48(sp)
    80207838:	6121                	addi	sp,sp,64
    8020783a:	8082                	ret

000000008020783c <set_kernel_trap_entry>:
set_kernel_trap_entry():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:225


void set_kernel_trap_entry()
{
    8020783c:	1141                	addi	sp,sp,-16
    8020783e:	e406                	sd	ra,8(sp)
    80207840:	e022                	sd	s0,0(sp)
    80207842:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:226
    w_stvec((uint64_t)trap_from_kernel);
    80207844:	00000797          	auipc	a5,0x0
    80207848:	cf478793          	addi	a5,a5,-780 # 80207538 <trap_from_kernel>
    8020784c:	853e                	mv	a0,a5
    8020784e:	a4bff0ef          	jal	ra,80207298 <w_stvec>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:227
}
    80207852:	0001                	nop
    80207854:	60a2                	ld	ra,8(sp)
    80207856:	6402                	ld	s0,0(sp)
    80207858:	0141                	addi	sp,sp,16
    8020785a:	8082                	ret

000000008020785c <exit>:
exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:11
#include "task.h"
#include "sbi.h"


int32_t exit(int32_t value)
{
    8020785c:	1101                	addi	sp,sp,-32
    8020785e:	ec06                	sd	ra,24(sp)
    80207860:	e822                	sd	s0,16(sp)
    80207862:	1000                	addi	s0,sp,32
    80207864:	87aa                	mv	a5,a0
    80207866:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:12
    print_str("exit : ");
    8020786a:	00001517          	auipc	a0,0x1
    8020786e:	19650513          	addi	a0,a0,406 # 80208a00 <MMIO+0x10>
    80207872:	b75fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:13
    print_uint32((uint32_t)value);
    80207876:	fec42783          	lw	a5,-20(s0)
    8020787a:	853e                	mv	a0,a5
    8020787c:	c35fe0ef          	jal	ra,802064b0 <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:14
    print_str("\n");
    80207880:	00001517          	auipc	a0,0x1
    80207884:	18850513          	addi	a0,a0,392 # 80208a08 <MMIO+0x18>
    80207888:	b5ffe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:15
    return value;
    8020788c:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:16
}
    80207890:	853e                	mv	a0,a5
    80207892:	60e2                	ld	ra,24(sp)
    80207894:	6442                	ld	s0,16(sp)
    80207896:	6105                	addi	sp,sp,32
    80207898:	8082                	ret

000000008020789a <write>:
write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:19

int64_t write(uint64_t fd, char* buf, uint64_t count)
{
    8020789a:	7139                	addi	sp,sp,-64
    8020789c:	fc06                	sd	ra,56(sp)
    8020789e:	f822                	sd	s0,48(sp)
    802078a0:	0080                	addi	s0,sp,64
    802078a2:	fca43c23          	sd	a0,-40(s0)
    802078a6:	fcb43823          	sd	a1,-48(s0)
    802078aa:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:20
    printk("\n\nwrite\n\n");
    802078ae:	00001517          	auipc	a0,0x1
    802078b2:	16250513          	addi	a0,a0,354 # 80208a10 <MMIO+0x20>
    802078b6:	f35fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:21
    if(fd==1)
    802078ba:	fd843703          	ld	a4,-40(s0)
    802078be:	4785                	li	a5,1
    802078c0:	02f71b63          	bne	a4,a5,802078f6 <write+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:23
    {
        for (uint64_t i = 0; i < count; i++) 
    802078c4:	fe043423          	sd	zero,-24(s0)
    802078c8:	a005                	j	802078e8 <write+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:25 (discriminator 3)
        {
            console_putchar(buf[i]);
    802078ca:	fd043703          	ld	a4,-48(s0)
    802078ce:	fe843783          	ld	a5,-24(s0)
    802078d2:	97ba                	add	a5,a5,a4
    802078d4:	0007c783          	lbu	a5,0(a5)
    802078d8:	853e                	mv	a0,a5
    802078da:	a25fb0ef          	jal	ra,802032fe <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:23 (discriminator 3)
        for (uint64_t i = 0; i < count; i++) 
    802078de:	fe843783          	ld	a5,-24(s0)
    802078e2:	0785                	addi	a5,a5,1
    802078e4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:23 (discriminator 1)
    802078e8:	fe843703          	ld	a4,-24(s0)
    802078ec:	fc843783          	ld	a5,-56(s0)
    802078f0:	fcf76de3          	bltu	a4,a5,802078ca <write+0x30>
    802078f4:	a821                	j	8020790c <write+0x72>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:29 (discriminator 1)
        }
    }else 
    {
        ASSERT(0);
    802078f6:	00001617          	auipc	a2,0x1
    802078fa:	12a60613          	addi	a2,a2,298 # 80208a20 <MMIO+0x30>
    802078fe:	45f5                	li	a1,29
    80207900:	00001517          	auipc	a0,0x1
    80207904:	13850513          	addi	a0,a0,312 # 80208a38 <MMIO+0x48>
    80207908:	da3fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:31
    }
    return count;
    8020790c:	fc843783          	ld	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:32
}
    80207910:	853e                	mv	a0,a5
    80207912:	70e2                	ld	ra,56(sp)
    80207914:	7442                	ld	s0,48(sp)
    80207916:	6121                	addi	sp,sp,64
    80207918:	8082                	ret

000000008020791a <yield>:
yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:35

int64_t yield()
{
    8020791a:	1141                	addi	sp,sp,-16
    8020791c:	e406                	sd	ra,8(sp)
    8020791e:	e022                	sd	s0,0(sp)
    80207920:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:36
    print_str("\n-------yield------\n");
    80207922:	00001517          	auipc	a0,0x1
    80207926:	13650513          	addi	a0,a0,310 # 80208a58 <MMIO+0x68>
    8020792a:	abdfe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:37
    run_next_task(1);
    8020792e:	4505                	li	a0,1
    80207930:	e63fe0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:38
    return 1;
    80207934:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:39
}
    80207936:	853e                	mv	a0,a5
    80207938:	60a2                	ld	ra,8(sp)
    8020793a:	6402                	ld	s0,0(sp)
    8020793c:	0141                	addi	sp,sp,16
    8020793e:	8082                	ret

0000000080207940 <sys_write>:
sys_write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:42

int64_t sys_write(uint64_t fd, char *buf, uint64_t count) 
{
    80207940:	7179                	addi	sp,sp,-48
    80207942:	f406                	sd	ra,40(sp)
    80207944:	f022                	sd	s0,32(sp)
    80207946:	1800                	addi	s0,sp,48
    80207948:	fea43423          	sd	a0,-24(s0)
    8020794c:	feb43023          	sd	a1,-32(s0)
    80207950:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:43
    return write(fd, buf, count); // 使用POSIX write
    80207954:	fd843603          	ld	a2,-40(s0)
    80207958:	fe043583          	ld	a1,-32(s0)
    8020795c:	fe843503          	ld	a0,-24(s0)
    80207960:	f3bff0ef          	jal	ra,8020789a <write>
    80207964:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:44
}
    80207966:	853e                	mv	a0,a5
    80207968:	70a2                	ld	ra,40(sp)
    8020796a:	7402                	ld	s0,32(sp)
    8020796c:	6145                	addi	sp,sp,48
    8020796e:	8082                	ret

0000000080207970 <sys_exit>:
sys_exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:47

void sys_exit(int32_t status) 
{
    80207970:	1101                	addi	sp,sp,-32
    80207972:	ec06                	sd	ra,24(sp)
    80207974:	e822                	sd	s0,16(sp)
    80207976:	1000                	addi	s0,sp,32
    80207978:	87aa                	mv	a5,a0
    8020797a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:48
    exit(status);
    8020797e:	fec42783          	lw	a5,-20(s0)
    80207982:	853e                	mv	a0,a5
    80207984:	ed9ff0ef          	jal	ra,8020785c <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:49
}
    80207988:	0001                	nop
    8020798a:	60e2                	ld	ra,24(sp)
    8020798c:	6442                	ld	s0,16(sp)
    8020798e:	6105                	addi	sp,sp,32
    80207990:	8082                	ret

0000000080207992 <sys_yield>:
sys_yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:52

int64_t sys_yield()
{
    80207992:	1141                	addi	sp,sp,-16
    80207994:	e406                	sd	ra,8(sp)
    80207996:	e022                	sd	s0,0(sp)
    80207998:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:53
    return yield();
    8020799a:	f81ff0ef          	jal	ra,8020791a <yield>
    8020799e:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:54
}
    802079a0:	853e                	mv	a0,a5
    802079a2:	60a2                	ld	ra,8(sp)
    802079a4:	6402                	ld	s0,0(sp)
    802079a6:	0141                	addi	sp,sp,16
    802079a8:	8082                	ret

00000000802079aa <syscall>:
syscall():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:58

// 系统调用处理函数
int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2)
{   
    802079aa:	7179                	addi	sp,sp,-48
    802079ac:	f406                	sd	ra,40(sp)
    802079ae:	f022                	sd	s0,32(sp)
    802079b0:	1800                	addi	s0,sp,48
    802079b2:	fea43423          	sd	a0,-24(s0)
    802079b6:	feb43023          	sd	a1,-32(s0)
    802079ba:	fcc43c23          	sd	a2,-40(s0)
    802079be:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:59
    printk("syscall\n");
    802079c2:	00001517          	auipc	a0,0x1
    802079c6:	0ae50513          	addi	a0,a0,174 # 80208a70 <MMIO+0x80>
    802079ca:	e21fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:60
    switch (syscall_id)
    802079ce:	fe843703          	ld	a4,-24(s0)
    802079d2:	07c00793          	li	a5,124
    802079d6:	04f70663          	beq	a4,a5,80207a22 <syscall+0x78>
    802079da:	fe843703          	ld	a4,-24(s0)
    802079de:	07c00793          	li	a5,124
    802079e2:	04e7e463          	bltu	a5,a4,80207a2a <syscall+0x80>
    802079e6:	fe843703          	ld	a4,-24(s0)
    802079ea:	04000793          	li	a5,64
    802079ee:	00f70963          	beq	a4,a5,80207a00 <syscall+0x56>
    802079f2:	fe843703          	ld	a4,-24(s0)
    802079f6:	05d00793          	li	a5,93
    802079fa:	00f70e63          	beq	a4,a5,80207a16 <syscall+0x6c>
    802079fe:	a035                	j	80207a2a <syscall+0x80>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:63
    {
        case SYSCALL_WRITE:
            return sys_write(a0, (char *)a1, a2);
    80207a00:	fd843783          	ld	a5,-40(s0)
    80207a04:	fd043603          	ld	a2,-48(s0)
    80207a08:	85be                	mv	a1,a5
    80207a0a:	fe043503          	ld	a0,-32(s0)
    80207a0e:	f33ff0ef          	jal	ra,80207940 <sys_write>
    80207a12:	87aa                	mv	a5,a0
    80207a14:	a891                	j	80207a68 <syscall+0xbe>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:65
        case SYSCALL_EXIT:
            sys_exit((int32_t)a0);
    80207a16:	fe043783          	ld	a5,-32(s0)
    80207a1a:	2781                	sext.w	a5,a5
    80207a1c:	853e                	mv	a0,a5
    80207a1e:	f53ff0ef          	jal	ra,80207970 <sys_exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:67
        case SYSCALL_YIELD:
            return sys_yield();
    80207a22:	f71ff0ef          	jal	ra,80207992 <sys_yield>
    80207a26:	87aa                	mv	a5,a0
    80207a28:	a081                	j	80207a68 <syscall+0xbe>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:69
        default:
            print_str("unsupportable syscall_id\n");
    80207a2a:	00001517          	auipc	a0,0x1
    80207a2e:	05650513          	addi	a0,a0,86 # 80208a80 <MMIO+0x90>
    80207a32:	9b5fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:70
            ASSERT(0);
    80207a36:	00001617          	auipc	a2,0x1
    80207a3a:	fea60613          	addi	a2,a2,-22 # 80208a20 <MMIO+0x30>
    80207a3e:	04600593          	li	a1,70
    80207a42:	00001517          	auipc	a0,0x1
    80207a46:	ff650513          	addi	a0,a0,-10 # 80208a38 <MMIO+0x48>
    80207a4a:	c61fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:72
    }
    ASSERT(0);
    80207a4e:	00001617          	auipc	a2,0x1
    80207a52:	fd260613          	addi	a2,a2,-46 # 80208a20 <MMIO+0x30>
    80207a56:	04800593          	li	a1,72
    80207a5a:	00001517          	auipc	a0,0x1
    80207a5e:	fde50513          	addi	a0,a0,-34 # 80208a38 <MMIO+0x48>
    80207a62:	c49fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:73
    return -1;
    80207a66:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:74
}
    80207a68:	853e                	mv	a0,a5
    80207a6a:	70a2                	ld	ra,40(sp)
    80207a6c:	7402                	ld	s0,32(sp)
    80207a6e:	6145                	addi	sp,sp,48
    80207a70:	8082                	ret

0000000080207a72 <read_time>:
read_time():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:5
#include "timer.h"
#include "sbi.h"
#include "task.h"
static inline uint64_t read_time(void) 
{
    80207a72:	1101                	addi	sp,sp,-32
    80207a74:	ec22                	sd	s0,24(sp)
    80207a76:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:7
    uint64_t time;
    __asm__ volatile ("csrr %0, time" : "=r"(time));
    80207a78:	c01027f3          	rdtime	a5
    80207a7c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:8
    return time;
    80207a80:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:9
}
    80207a84:	853e                	mv	a0,a5
    80207a86:	6462                	ld	s0,24(sp)
    80207a88:	6105                	addi	sp,sp,32
    80207a8a:	8082                	ret

0000000080207a8c <clock_set_next_event>:
clock_set_next_event():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:12

void clock_set_next_event() 
{
    80207a8c:	1141                	addi	sp,sp,-16
    80207a8e:	e406                	sd	ra,8(sp)
    80207a90:	e022                	sd	s0,0(sp)
    80207a92:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:13
    sbi_set_timer(read_time() + TIMEBASE);
    80207a94:	fdfff0ef          	jal	ra,80207a72 <read_time>
    80207a98:	872a                	mv	a4,a0
    80207a9a:	67e1                	lui	a5,0x18
    80207a9c:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    80207aa0:	97ba                	add	a5,a5,a4
    80207aa2:	853e                	mv	a0,a5
    80207aa4:	8c1fb0ef          	jal	ra,80203364 <sbi_set_timer>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:14
}
    80207aa8:	0001                	nop
    80207aaa:	60a2                	ld	ra,8(sp)
    80207aac:	6402                	ld	s0,0(sp)
    80207aae:	0141                	addi	sp,sp,16
    80207ab0:	8082                	ret

0000000080207ab2 <timer_init>:
timer_init():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:18


void timer_init()
{
    80207ab2:	1141                	addi	sp,sp,-16
    80207ab4:	e406                	sd	ra,8(sp)
    80207ab6:	e022                	sd	s0,0(sp)
    80207ab8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:19
    clock_set_next_event();
    80207aba:	fd3ff0ef          	jal	ra,80207a8c <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:20
    print_str("----timer_init----\n");
    80207abe:	00001517          	auipc	a0,0x1
    80207ac2:	ff250513          	addi	a0,a0,-14 # 80208ab0 <MMIO+0x10>
    80207ac6:	921fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:21
}
    80207aca:	0001                	nop
    80207acc:	60a2                	ld	ra,8(sp)
    80207ace:	6402                	ld	s0,0(sp)
    80207ad0:	0141                	addi	sp,sp,16
    80207ad2:	8082                	ret

0000000080207ad4 <intr_timer_handle>:
intr_timer_handle():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:25


void intr_timer_handle()
{
    80207ad4:	1141                	addi	sp,sp,-16
    80207ad6:	e406                	sd	ra,8(sp)
    80207ad8:	e022                	sd	s0,0(sp)
    80207ada:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:26
    printk("intr_timer_handle\n");
    80207adc:	00001517          	auipc	a0,0x1
    80207ae0:	fec50513          	addi	a0,a0,-20 # 80208ac8 <MMIO+0x28>
    80207ae4:	d07fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:27
    run_next_task(1);
    80207ae8:	4505                	li	a0,1
    80207aea:	ca9fe0ef          	jal	ra,80206792 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:28
    ticks++;
    80207aee:	00b6f797          	auipc	a5,0xb6f
    80207af2:	3f278793          	addi	a5,a5,1010 # 80d76ee0 <ticks>
    80207af6:	639c                	ld	a5,0(a5)
    80207af8:	00178713          	addi	a4,a5,1
    80207afc:	00b6f797          	auipc	a5,0xb6f
    80207b00:	3e478793          	addi	a5,a5,996 # 80d76ee0 <ticks>
    80207b04:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:29
    clock_set_next_event();
    80207b06:	f87ff0ef          	jal	ra,80207a8c <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:30
    if(ticks % 10 == 0)
    80207b0a:	00b6f797          	auipc	a5,0xb6f
    80207b0e:	3d678793          	addi	a5,a5,982 # 80d76ee0 <ticks>
    80207b12:	6398                	ld	a4,0(a5)
    80207b14:	47a9                	li	a5,10
    80207b16:	02f777b3          	remu	a5,a4,a5
    80207b1a:	e799                	bnez	a5,80207b28 <intr_timer_handle+0x54>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:32
    {
        print_str("timer_interrupt\n");
    80207b1c:	00001517          	auipc	a0,0x1
    80207b20:	fc450513          	addi	a0,a0,-60 # 80208ae0 <MMIO+0x40>
    80207b24:	8c3fe0ef          	jal	ra,802063e6 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:40
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
    80207b28:	0001                	nop
    80207b2a:	60a2                	ld	ra,8(sp)
    80207b2c:	6402                	ld	s0,0(sp)
    80207b2e:	0141                	addi	sp,sp,16
    80207b30:	8082                	ret

0000000080207b32 <lst_init>:
lst_init():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:10
#include "debug.h"
// double-linked, circular list. double-linked makes remove
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void lst_init(struct list *lst) {
    80207b32:	1101                	addi	sp,sp,-32
    80207b34:	ec22                	sd	s0,24(sp)
    80207b36:	1000                	addi	s0,sp,32
    80207b38:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:11
  lst->next = lst;
    80207b3c:	fe843783          	ld	a5,-24(s0)
    80207b40:	fe843703          	ld	a4,-24(s0)
    80207b44:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:12
  lst->prev = lst;
    80207b46:	fe843783          	ld	a5,-24(s0)
    80207b4a:	fe843703          	ld	a4,-24(s0)
    80207b4e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:13
}
    80207b50:	0001                	nop
    80207b52:	6462                	ld	s0,24(sp)
    80207b54:	6105                	addi	sp,sp,32
    80207b56:	8082                	ret

0000000080207b58 <lst_empty>:
lst_empty():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:15

int lst_empty(struct list *lst) { return lst->next == lst; }
    80207b58:	1101                	addi	sp,sp,-32
    80207b5a:	ec22                	sd	s0,24(sp)
    80207b5c:	1000                	addi	s0,sp,32
    80207b5e:	fea43423          	sd	a0,-24(s0)
    80207b62:	fe843783          	ld	a5,-24(s0)
    80207b66:	639c                	ld	a5,0(a5)
    80207b68:	fe843703          	ld	a4,-24(s0)
    80207b6c:	40f707b3          	sub	a5,a4,a5
    80207b70:	0017b793          	seqz	a5,a5
    80207b74:	0ff7f793          	andi	a5,a5,255
    80207b78:	2781                	sext.w	a5,a5
    80207b7a:	853e                	mv	a0,a5
    80207b7c:	6462                	ld	s0,24(sp)
    80207b7e:	6105                	addi	sp,sp,32
    80207b80:	8082                	ret

0000000080207b82 <lst_remove>:
lst_remove():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:17

void lst_remove(struct list *e) {
    80207b82:	1101                	addi	sp,sp,-32
    80207b84:	ec22                	sd	s0,24(sp)
    80207b86:	1000                	addi	s0,sp,32
    80207b88:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:18
  e->prev->next = e->next;
    80207b8c:	fe843783          	ld	a5,-24(s0)
    80207b90:	679c                	ld	a5,8(a5)
    80207b92:	fe843703          	ld	a4,-24(s0)
    80207b96:	6318                	ld	a4,0(a4)
    80207b98:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:19
  e->next->prev = e->prev;
    80207b9a:	fe843783          	ld	a5,-24(s0)
    80207b9e:	639c                	ld	a5,0(a5)
    80207ba0:	fe843703          	ld	a4,-24(s0)
    80207ba4:	6718                	ld	a4,8(a4)
    80207ba6:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:20
}
    80207ba8:	0001                	nop
    80207baa:	6462                	ld	s0,24(sp)
    80207bac:	6105                	addi	sp,sp,32
    80207bae:	8082                	ret

0000000080207bb0 <lst_pop>:
lst_pop():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:22

void *lst_pop(struct list *lst) {
    80207bb0:	7179                	addi	sp,sp,-48
    80207bb2:	f406                	sd	ra,40(sp)
    80207bb4:	f022                	sd	s0,32(sp)
    80207bb6:	1800                	addi	s0,sp,48
    80207bb8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:23
  if (lst->next == lst)
    80207bbc:	fd843783          	ld	a5,-40(s0)
    80207bc0:	639c                	ld	a5,0(a5)
    80207bc2:	fd843703          	ld	a4,-40(s0)
    80207bc6:	00f71d63          	bne	a4,a5,80207be0 <lst_pop+0x30>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:24
    panic("lst_pop");
    80207bca:	00001617          	auipc	a2,0x1
    80207bce:	f2e60613          	addi	a2,a2,-210 # 80208af8 <MMIO+0x58>
    80207bd2:	45e1                	li	a1,24
    80207bd4:	00001517          	auipc	a0,0x1
    80207bd8:	f2c50513          	addi	a0,a0,-212 # 80208b00 <MMIO+0x60>
    80207bdc:	acffe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:25
  struct list *p = lst->next;
    80207be0:	fd843783          	ld	a5,-40(s0)
    80207be4:	639c                	ld	a5,0(a5)
    80207be6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:26
  lst_remove(p);
    80207bea:	fe843503          	ld	a0,-24(s0)
    80207bee:	f95ff0ef          	jal	ra,80207b82 <lst_remove>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:27
  return (void *)p;
    80207bf2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:28
}
    80207bf6:	853e                	mv	a0,a5
    80207bf8:	70a2                	ld	ra,40(sp)
    80207bfa:	7402                	ld	s0,32(sp)
    80207bfc:	6145                	addi	sp,sp,48
    80207bfe:	8082                	ret

0000000080207c00 <lst_push>:
lst_push():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:30

void lst_push(struct list *lst, void *p) {
    80207c00:	7179                	addi	sp,sp,-48
    80207c02:	f422                	sd	s0,40(sp)
    80207c04:	1800                	addi	s0,sp,48
    80207c06:	fca43c23          	sd	a0,-40(s0)
    80207c0a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:31
  struct list *e = (struct list *)p;
    80207c0e:	fd043783          	ld	a5,-48(s0)
    80207c12:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:32
  e->next = lst->next;
    80207c16:	fd843783          	ld	a5,-40(s0)
    80207c1a:	6398                	ld	a4,0(a5)
    80207c1c:	fe843783          	ld	a5,-24(s0)
    80207c20:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:33
  e->prev = lst;
    80207c22:	fe843783          	ld	a5,-24(s0)
    80207c26:	fd843703          	ld	a4,-40(s0)
    80207c2a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:34
  lst->next->prev = p;
    80207c2c:	fd843783          	ld	a5,-40(s0)
    80207c30:	639c                	ld	a5,0(a5)
    80207c32:	fd043703          	ld	a4,-48(s0)
    80207c36:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:35
  lst->next = e;
    80207c38:	fd843783          	ld	a5,-40(s0)
    80207c3c:	fe843703          	ld	a4,-24(s0)
    80207c40:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:36
}
    80207c42:	0001                	nop
    80207c44:	7422                	ld	s0,40(sp)
    80207c46:	6145                	addi	sp,sp,48
    80207c48:	8082                	ret

0000000080207c4a <lst_print>:
lst_print():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:38

void lst_print(struct list *lst) {
    80207c4a:	7179                	addi	sp,sp,-48
    80207c4c:	f406                	sd	ra,40(sp)
    80207c4e:	f022                	sd	s0,32(sp)
    80207c50:	1800                	addi	s0,sp,48
    80207c52:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80207c56:	fd843783          	ld	a5,-40(s0)
    80207c5a:	639c                	ld	a5,0(a5)
    80207c5c:	fef43423          	sd	a5,-24(s0)
    80207c60:	a831                	j	80207c7c <lst_print+0x32>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:40 (discriminator 3)
    printk(" %p", p);
    80207c62:	fe843583          	ld	a1,-24(s0)
    80207c66:	00001517          	auipc	a0,0x1
    80207c6a:	eba50513          	addi	a0,a0,-326 # 80208b20 <MMIO+0x80>
    80207c6e:	b7dfa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39 (discriminator 3)
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80207c72:	fe843783          	ld	a5,-24(s0)
    80207c76:	639c                	ld	a5,0(a5)
    80207c78:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:39 (discriminator 1)
    80207c7c:	fe843703          	ld	a4,-24(s0)
    80207c80:	fd843783          	ld	a5,-40(s0)
    80207c84:	fcf71fe3          	bne	a4,a5,80207c62 <lst_print+0x18>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:42
  }
  printk("\n");
    80207c88:	00001517          	auipc	a0,0x1
    80207c8c:	ea050513          	addi	a0,a0,-352 # 80208b28 <MMIO+0x88>
    80207c90:	b5bfa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/list.c:43
}
    80207c94:	0001                	nop
    80207c96:	70a2                	ld	ra,40(sp)
    80207c98:	7402                	ld	s0,32(sp)
    80207c9a:	6145                	addi	sp,sp,48
    80207c9c:	8082                	ret

0000000080207c9e <vector_new>:
vector_new():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:9
#include "string.h"
#include "buddy.h"
#include "debug.h"
#define VECTOR_INIT_CAPACITY 8

void vector_new(struct vector *v, uint64_t dsize) {
    80207c9e:	1101                	addi	sp,sp,-32
    80207ca0:	ec06                	sd	ra,24(sp)
    80207ca2:	e822                	sd	s0,16(sp)
    80207ca4:	1000                	addi	s0,sp,32
    80207ca6:	fea43423          	sd	a0,-24(s0)
    80207caa:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:10
  v->size = 0;
    80207cae:	fe843783          	ld	a5,-24(s0)
    80207cb2:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:11
  v->capacity = VECTOR_INIT_CAPACITY;
    80207cb6:	fe843783          	ld	a5,-24(s0)
    80207cba:	4721                	li	a4,8
    80207cbc:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:12
  v->dsize = dsize;
    80207cbe:	fe843783          	ld	a5,-24(s0)
    80207cc2:	fe043703          	ld	a4,-32(s0)
    80207cc6:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:13
  v->buffer = bd_malloc(v->capacity * v->dsize);
    80207cc8:	fe843783          	ld	a5,-24(s0)
    80207ccc:	6798                	ld	a4,8(a5)
    80207cce:	fe843783          	ld	a5,-24(s0)
    80207cd2:	6b9c                	ld	a5,16(a5)
    80207cd4:	02f707b3          	mul	a5,a4,a5
    80207cd8:	853e                	mv	a0,a5
    80207cda:	c07fd0ef          	jal	ra,802058e0 <bd_malloc>
    80207cde:	872a                	mv	a4,a0
    80207ce0:	fe843783          	ld	a5,-24(s0)
    80207ce4:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:14
}
    80207ce6:	0001                	nop
    80207ce8:	60e2                	ld	ra,24(sp)
    80207cea:	6442                	ld	s0,16(sp)
    80207cec:	6105                	addi	sp,sp,32
    80207cee:	8082                	ret

0000000080207cf0 <vector_push>:
vector_push():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:16

void vector_push(struct vector *v, void *d) {
    80207cf0:	7179                	addi	sp,sp,-48
    80207cf2:	f406                	sd	ra,40(sp)
    80207cf4:	f022                	sd	s0,32(sp)
    80207cf6:	1800                	addi	s0,sp,48
    80207cf8:	fca43c23          	sd	a0,-40(s0)
    80207cfc:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:17
  if (v->size == v->capacity) {
    80207d00:	fd843783          	ld	a5,-40(s0)
    80207d04:	6398                	ld	a4,0(a5)
    80207d06:	fd843783          	ld	a5,-40(s0)
    80207d0a:	679c                	ld	a5,8(a5)
    80207d0c:	06f71763          	bne	a4,a5,80207d7a <vector_push+0x8a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:18
    v->capacity <<= 1;
    80207d10:	fd843783          	ld	a5,-40(s0)
    80207d14:	679c                	ld	a5,8(a5)
    80207d16:	00179713          	slli	a4,a5,0x1
    80207d1a:	fd843783          	ld	a5,-40(s0)
    80207d1e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:19
    char *t = bd_malloc(v->capacity * v->dsize);
    80207d20:	fd843783          	ld	a5,-40(s0)
    80207d24:	6798                	ld	a4,8(a5)
    80207d26:	fd843783          	ld	a5,-40(s0)
    80207d2a:	6b9c                	ld	a5,16(a5)
    80207d2c:	02f707b3          	mul	a5,a4,a5
    80207d30:	853e                	mv	a0,a5
    80207d32:	baffd0ef          	jal	ra,802058e0 <bd_malloc>
    80207d36:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:20
    memcpy((uint8_t*)t, (uint8_t*)v->buffer, v->size * v->dsize);
    80207d3a:	fd843783          	ld	a5,-40(s0)
    80207d3e:	6f94                	ld	a3,24(a5)
    80207d40:	fd843783          	ld	a5,-40(s0)
    80207d44:	639c                	ld	a5,0(a5)
    80207d46:	0007871b          	sext.w	a4,a5
    80207d4a:	fd843783          	ld	a5,-40(s0)
    80207d4e:	6b9c                	ld	a5,16(a5)
    80207d50:	2781                	sext.w	a5,a5
    80207d52:	02f707bb          	mulw	a5,a4,a5
    80207d56:	2781                	sext.w	a5,a5
    80207d58:	863e                	mv	a2,a5
    80207d5a:	85b6                	mv	a1,a3
    80207d5c:	fe843503          	ld	a0,-24(s0)
    80207d60:	9f5fb0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:21
    bd_free(v->buffer);
    80207d64:	fd843783          	ld	a5,-40(s0)
    80207d68:	6f9c                	ld	a5,24(a5)
    80207d6a:	853e                	mv	a0,a5
    80207d6c:	d77fd0ef          	jal	ra,80205ae2 <bd_free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:22
    v->buffer = t;
    80207d70:	fd843783          	ld	a5,-40(s0)
    80207d74:	fe843703          	ld	a4,-24(s0)
    80207d78:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:24
  }
  memcpy((uint8_t*)(v->buffer + (v->size++) * v->dsize), d, v->dsize);
    80207d7a:	fd843783          	ld	a5,-40(s0)
    80207d7e:	6f98                	ld	a4,24(a5)
    80207d80:	fd843783          	ld	a5,-40(s0)
    80207d84:	639c                	ld	a5,0(a5)
    80207d86:	00178613          	addi	a2,a5,1
    80207d8a:	fd843683          	ld	a3,-40(s0)
    80207d8e:	e290                	sd	a2,0(a3)
    80207d90:	fd843683          	ld	a3,-40(s0)
    80207d94:	6a94                	ld	a3,16(a3)
    80207d96:	02d787b3          	mul	a5,a5,a3
    80207d9a:	973e                	add	a4,a4,a5
    80207d9c:	fd843783          	ld	a5,-40(s0)
    80207da0:	6b9c                	ld	a5,16(a5)
    80207da2:	2781                	sext.w	a5,a5
    80207da4:	863e                	mv	a2,a5
    80207da6:	fd043583          	ld	a1,-48(s0)
    80207daa:	853a                	mv	a0,a4
    80207dac:	9a9fb0ef          	jal	ra,80203754 <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:25
}
    80207db0:	0001                	nop
    80207db2:	70a2                	ld	ra,40(sp)
    80207db4:	7402                	ld	s0,32(sp)
    80207db6:	6145                	addi	sp,sp,48
    80207db8:	8082                	ret

0000000080207dba <vector_pop>:
vector_pop():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:27

void vector_pop(struct vector *v) {
    80207dba:	1101                	addi	sp,sp,-32
    80207dbc:	ec06                	sd	ra,24(sp)
    80207dbe:	e822                	sd	s0,16(sp)
    80207dc0:	1000                	addi	s0,sp,32
    80207dc2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:28
  if (v->size == 0)
    80207dc6:	fe843783          	ld	a5,-24(s0)
    80207dca:	639c                	ld	a5,0(a5)
    80207dcc:	ef81                	bnez	a5,80207de4 <vector_pop+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:29
    panic("empty vector pop\n");
    80207dce:	00001617          	auipc	a2,0x1
    80207dd2:	d6260613          	addi	a2,a2,-670 # 80208b30 <MMIO+0x90>
    80207dd6:	45f5                	li	a1,29
    80207dd8:	00001517          	auipc	a0,0x1
    80207ddc:	d7050513          	addi	a0,a0,-656 # 80208b48 <MMIO+0xa8>
    80207de0:	8cbfe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:30
  v->size--;
    80207de4:	fe843783          	ld	a5,-24(s0)
    80207de8:	639c                	ld	a5,0(a5)
    80207dea:	fff78713          	addi	a4,a5,-1
    80207dee:	fe843783          	ld	a5,-24(s0)
    80207df2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:31
}
    80207df4:	0001                	nop
    80207df6:	60e2                	ld	ra,24(sp)
    80207df8:	6442                	ld	s0,16(sp)
    80207dfa:	6105                	addi	sp,sp,32
    80207dfc:	8082                	ret

0000000080207dfe <vector_back>:
vector_back():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:33

void *vector_back(struct vector *v) {
    80207dfe:	1101                	addi	sp,sp,-32
    80207e00:	ec06                	sd	ra,24(sp)
    80207e02:	e822                	sd	s0,16(sp)
    80207e04:	1000                	addi	s0,sp,32
    80207e06:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:34
  if (!v->size)
    80207e0a:	fe843783          	ld	a5,-24(s0)
    80207e0e:	639c                	ld	a5,0(a5)
    80207e10:	ef89                	bnez	a5,80207e2a <vector_back+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:35
    panic("empty vector back\n");
    80207e12:	00001617          	auipc	a2,0x1
    80207e16:	d5660613          	addi	a2,a2,-682 # 80208b68 <MMIO+0xc8>
    80207e1a:	02300593          	li	a1,35
    80207e1e:	00001517          	auipc	a0,0x1
    80207e22:	d2a50513          	addi	a0,a0,-726 # 80208b48 <MMIO+0xa8>
    80207e26:	885fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:36
  return v->buffer + (v->size - 1) * v->dsize;
    80207e2a:	fe843783          	ld	a5,-24(s0)
    80207e2e:	6f98                	ld	a4,24(a5)
    80207e30:	fe843783          	ld	a5,-24(s0)
    80207e34:	639c                	ld	a5,0(a5)
    80207e36:	fff78693          	addi	a3,a5,-1
    80207e3a:	fe843783          	ld	a5,-24(s0)
    80207e3e:	6b9c                	ld	a5,16(a5)
    80207e40:	02f687b3          	mul	a5,a3,a5
    80207e44:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:37
}
    80207e46:	853e                	mv	a0,a5
    80207e48:	60e2                	ld	ra,24(sp)
    80207e4a:	6442                	ld	s0,16(sp)
    80207e4c:	6105                	addi	sp,sp,32
    80207e4e:	8082                	ret

0000000080207e50 <vector_empty>:
vector_empty():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:39

int vector_empty(struct vector *v) { return !v->size; }
    80207e50:	1101                	addi	sp,sp,-32
    80207e52:	ec22                	sd	s0,24(sp)
    80207e54:	1000                	addi	s0,sp,32
    80207e56:	fea43423          	sd	a0,-24(s0)
    80207e5a:	fe843783          	ld	a5,-24(s0)
    80207e5e:	639c                	ld	a5,0(a5)
    80207e60:	0017b793          	seqz	a5,a5
    80207e64:	0ff7f793          	andi	a5,a5,255
    80207e68:	2781                	sext.w	a5,a5
    80207e6a:	853e                	mv	a0,a5
    80207e6c:	6462                	ld	s0,24(sp)
    80207e6e:	6105                	addi	sp,sp,32
    80207e70:	8082                	ret

0000000080207e72 <vector_free>:
vector_free():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:41

void vector_free(struct vector *v) { bd_free(v->buffer); }
    80207e72:	1101                	addi	sp,sp,-32
    80207e74:	ec06                	sd	ra,24(sp)
    80207e76:	e822                	sd	s0,16(sp)
    80207e78:	1000                	addi	s0,sp,32
    80207e7a:	fea43423          	sd	a0,-24(s0)
    80207e7e:	fe843783          	ld	a5,-24(s0)
    80207e82:	6f9c                	ld	a5,24(a5)
    80207e84:	853e                	mv	a0,a5
    80207e86:	c5dfd0ef          	jal	ra,80205ae2 <bd_free>
    80207e8a:	0001                	nop
    80207e8c:	60e2                	ld	ra,24(sp)
    80207e8e:	6442                	ld	s0,16(sp)
    80207e90:	6105                	addi	sp,sp,32
    80207e92:	8082                	ret

0000000080207e94 <vector_remove>:
vector_remove():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:43

void vector_remove(struct vector *v, uint64_t idx) {
    80207e94:	1101                	addi	sp,sp,-32
    80207e96:	ec06                	sd	ra,24(sp)
    80207e98:	e822                	sd	s0,16(sp)
    80207e9a:	1000                	addi	s0,sp,32
    80207e9c:	fea43423          	sd	a0,-24(s0)
    80207ea0:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:44
  if (idx >= v->size)
    80207ea4:	fe843783          	ld	a5,-24(s0)
    80207ea8:	639c                	ld	a5,0(a5)
    80207eaa:	fe043703          	ld	a4,-32(s0)
    80207eae:	00f76e63          	bltu	a4,a5,80207eca <vector_remove+0x36>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:46
  {
    panic("invalid idx in vector remove\n");
    80207eb2:	00001617          	auipc	a2,0x1
    80207eb6:	cce60613          	addi	a2,a2,-818 # 80208b80 <MMIO+0xe0>
    80207eba:	02e00593          	li	a1,46
    80207ebe:	00001517          	auipc	a0,0x1
    80207ec2:	c8a50513          	addi	a0,a0,-886 # 80208b48 <MMIO+0xa8>
    80207ec6:	fe4fe0ef          	jal	ra,802066aa <_panic>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:48
  }
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80207eca:	fe843783          	ld	a5,-24(s0)
    80207ece:	6f98                	ld	a4,24(a5)
    80207ed0:	fe843783          	ld	a5,-24(s0)
    80207ed4:	6b94                	ld	a3,16(a5)
    80207ed6:	fe043783          	ld	a5,-32(s0)
    80207eda:	02f687b3          	mul	a5,a3,a5
    80207ede:	00f70533          	add	a0,a4,a5
    80207ee2:	fe843783          	ld	a5,-24(s0)
    80207ee6:	6f98                	ld	a4,24(a5)
    80207ee8:	fe043783          	ld	a5,-32(s0)
    80207eec:	00178693          	addi	a3,a5,1
    80207ef0:	fe843783          	ld	a5,-24(s0)
    80207ef4:	6b9c                	ld	a5,16(a5)
    80207ef6:	02f687b3          	mul	a5,a3,a5
    80207efa:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:49
          (v->size - idx - 1) * v->dsize);
    80207efe:	fe843783          	ld	a5,-24(s0)
    80207f02:	6398                	ld	a4,0(a5)
    80207f04:	fe043783          	ld	a5,-32(s0)
    80207f08:	40f707b3          	sub	a5,a4,a5
    80207f0c:	fff78713          	addi	a4,a5,-1
    80207f10:	fe843783          	ld	a5,-24(s0)
    80207f14:	6b9c                	ld	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:48
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80207f16:	02f707b3          	mul	a5,a4,a5
    80207f1a:	863e                	mv	a2,a5
    80207f1c:	85b6                	mv	a1,a3
    80207f1e:	951fb0ef          	jal	ra,8020386e <memmove>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:50
  v->size--;
    80207f22:	fe843783          	ld	a5,-24(s0)
    80207f26:	639c                	ld	a5,0(a5)
    80207f28:	fff78713          	addi	a4,a5,-1
    80207f2c:	fe843783          	ld	a5,-24(s0)
    80207f30:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:51
}
    80207f32:	0001                	nop
    80207f34:	60e2                	ld	ra,24(sp)
    80207f36:	6442                	ld	s0,16(sp)
    80207f38:	6105                	addi	sp,sp,32
    80207f3a:	8082                	ret
    80207f3c:	0000                	unimp
    80207f3e:	0000                	unimp
	...

0000000080207f42 <__switch>:
__switch():
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:16
  # __switch(
  #     current_task_cx_ptr2: &*const TaskContext,
  #     next_task_cx_ptr2: &*const TaskContext
  # )
  # push TaskContext to current sp and save its address to where a0 points to
  addi sp, sp, -13*8
    80207f42:	f9810113          	addi	sp,sp,-104
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:17
  sd sp, 0(a0)
    80207f46:	00253023          	sd	sp,0(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:19
  # fill TaskContext with ra & s0-s11
  sd ra, 0(sp)
    80207f4a:	e006                	sd	ra,0(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:24
  .set n, 0
  .rept 12
    SAVE_SN %n
    .set n, n + 1
  .endr
    80207f4c:	e422                	sd	s0,8(sp)
    80207f4e:	e826                	sd	s1,16(sp)
    80207f50:	ec4a                	sd	s2,24(sp)
    80207f52:	f04e                	sd	s3,32(sp)
    80207f54:	f452                	sd	s4,40(sp)
    80207f56:	f856                	sd	s5,48(sp)
    80207f58:	fc5a                	sd	s6,56(sp)
    80207f5a:	e0de                	sd	s7,64(sp)
    80207f5c:	e4e2                	sd	s8,72(sp)
    80207f5e:	e8e6                	sd	s9,80(sp)
    80207f60:	ecea                	sd	s10,88(sp)
    80207f62:	f0ee                	sd	s11,96(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:26
  # ready for loading TaskContext a1 points to
  ld sp, 0(a1)
    80207f64:	0005b103          	ld	sp,0(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:28
  # load registers in the TaskContext
  ld ra, 0(sp)
    80207f68:	6082                	ld	ra,0(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:33
  .set n, 0
  .rept 12
    LOAD_SN %n
    .set n, n + 1
  .endr
    80207f6a:	6422                	ld	s0,8(sp)
    80207f6c:	64c2                	ld	s1,16(sp)
    80207f6e:	6962                	ld	s2,24(sp)
    80207f70:	7982                	ld	s3,32(sp)
    80207f72:	7a22                	ld	s4,40(sp)
    80207f74:	7ac2                	ld	s5,48(sp)
    80207f76:	7b62                	ld	s6,56(sp)
    80207f78:	6b86                	ld	s7,64(sp)
    80207f7a:	6c26                	ld	s8,72(sp)
    80207f7c:	6cc6                	ld	s9,80(sp)
    80207f7e:	6d66                	ld	s10,88(sp)
    80207f80:	7d86                	ld	s11,96(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:35
  # pop TaskContext
  addi sp, sp, 13*8
    80207f82:	06810113          	addi	sp,sp,104
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:36
  ret
    80207f86:	8082                	ret
