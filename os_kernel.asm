
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
stext():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/entry.asm:4
    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    80200000:	00026117          	auipc	sp,0x26
    80200004:	00010113          	mv	sp,sp
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/entry.asm:5
    call main_os
    80200008:	584030ef          	jal	ra,8020358c <main_os>
	...

0000000080201000 <__alltraps>:
__alltraps():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:13
  .section .text.trampoline
  .globl __alltraps
  .globl __restore
  .align 2
__alltraps:
  csrrw sp, sscratch, sp
    80201000:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:16
  # now sp->*TrapContext in user space, sscratch->user stack
  # save other general purpose registers
  sd x1, 1*8(sp)
    80201004:	e406                	sd	ra,8(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:18
  # skip sp(x2), we will save it later
  sd x3, 3*8(sp)
    80201006:	ec0e                	sd	gp,24(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:25
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:27
  # we can use t0/t1/t2 freely, because they have been saved in TrapContext
  csrr t0, sstatus
    8020103e:	100022f3          	csrr	t0,sstatus
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:28
  csrr t1, sepc
    80201042:	14102373          	csrr	t1,sepc
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:29
  sd t0, 32*8(sp)
    80201046:	e216                	sd	t0,256(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:30
  sd t1, 33*8(sp)
    80201048:	e61a                	sd	t1,264(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:32
  # read user stack from sscratch and save it in TrapContext
  csrr t2, sscratch
    8020104a:	140023f3          	csrr	t2,sscratch
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:33
  sd t2, 2*8(sp)
    8020104e:	e81e                	sd	t2,16(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:35
  # load kernel_satp into t0
  ld t0, 34*8(sp)
    80201050:	62d2                	ld	t0,272(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:37
  # load trap_handler into t1
  ld t1, 36*8(sp)
    80201052:	7312                	ld	t1,288(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:39
  # move to kernel_sp
  ld sp, 35*8(sp)
    80201054:	6172                	ld	sp,280(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:41
  # switch to kernel space
  csrw satp, t0
    80201056:	18029073          	csrw	satp,t0
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:42
  sfence.vma
    8020105a:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:44
  # jump to trap_handler
  jr t1
    8020105e:	8302                	jr	t1

0000000080201060 <__restore>:
__restore():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:49

__restore:
  # a0: *TrapContext in user space(Constant); a1: user space token
  # switch to user space
  csrw satp, a1
    80201060:	18059073          	csrw	satp,a1
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:50
  sfence.vma
    80201064:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:51
  csrw sscratch, a0
    80201068:	14051073          	csrw	sscratch,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:52
  mv sp, a0
    8020106c:	812a                	mv	sp,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:55
  # now sp points to TrapContext in user space, start restoring based on it
  # restore sstatus/sepc
  ld t0, 32*8(sp)
    8020106e:	6292                	ld	t0,256(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:56
  ld t1, 33*8(sp)
    80201070:	6332                	ld	t1,264(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:57
  csrw sstatus, t0
    80201072:	10029073          	csrw	sstatus,t0
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:58
  csrw sepc, t1
    80201076:	14131073          	csrw	sepc,t1
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:60
  # restore general purpose registers except x0/sp/tp
  ld x1, 1*8(sp)
    8020107a:	60a2                	ld	ra,8(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:61
  ld x3, 3*8(sp)
    8020107c:	61e2                	ld	gp,24(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:66
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:68
  # back to user stack
  ld sp, 2*8(sp)
    802010b4:	6142                	ld	sp,16(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/trap.asm:69
  sret
    802010b6:	10200073          	sret
	...

0000000080202000 <port_write>:
port_write():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:10

/**
 *  @brief: 调用sbi输出函数，参数为固定要求，由_vprintk & _vprints调用
 */
void port_write(char *buf)
{
    80202000:	1101                	addi	sp,sp,-32
    80202002:	ec06                	sd	ra,24(sp)
    80202004:	e822                	sd	s0,16(sp)
    80202006:	1000                	addi	s0,sp,32
    80202008:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:11
    while (*buf != 0)
    8020200c:	a821                	j	80202024 <port_write+0x24>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:13
    {
        console_putchar(*buf++);
    8020200e:	fe843783          	ld	a5,-24(s0)
    80202012:	00178713          	addi	a4,a5,1
    80202016:	fee43423          	sd	a4,-24(s0)
    8020201a:	0007c783          	lbu	a5,0(a5)
    8020201e:	853e                	mv	a0,a5
    80202020:	378020ef          	jal	ra,80204398 <console_putchar>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:11
    while (*buf != 0)
    80202024:	fe843783          	ld	a5,-24(s0)
    80202028:	0007c783          	lbu	a5,0(a5)
    8020202c:	f3ed                	bnez	a5,8020200e <port_write+0xe>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:15
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:18

static unsigned int mini_strlen(const char *s)
{
    8020203a:	7179                	addi	sp,sp,-48
    8020203c:	f422                	sd	s0,40(sp)
    8020203e:	1800                	addi	s0,sp,48
    80202040:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:19
    unsigned int len = 0;
    80202044:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:20
    while (s[len] != '\0')
    80202048:	a031                	j	80202054 <mini_strlen+0x1a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:21
        len++;
    8020204a:	fec42783          	lw	a5,-20(s0)
    8020204e:	2785                	addiw	a5,a5,1
    80202050:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:20
    while (s[len] != '\0')
    80202054:	fec46783          	lwu	a5,-20(s0)
    80202058:	fd843703          	ld	a4,-40(s0)
    8020205c:	97ba                	add	a5,a5,a4
    8020205e:	0007c783          	lbu	a5,0(a5)
    80202062:	f7e5                	bnez	a5,8020204a <mini_strlen+0x10>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:22
    return len;
    80202064:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:23
}
    80202068:	853e                	mv	a0,a5
    8020206a:	7422                	ld	s0,40(sp)
    8020206c:	6145                	addi	sp,sp,48
    8020206e:	8082                	ret

0000000080202070 <mini_itoa>:
mini_itoa():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:28

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:29
    char *pbuffer = buffer;
    80202098:	fb043783          	ld	a5,-80(s0)
    8020209c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:30
    int negative = 0;
    802020a0:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:34
    unsigned int i, len;

    /* No support for unusual radixes. */
    if (radix > 16)
    802020a4:	fc442783          	lw	a5,-60(s0)
    802020a8:	0007871b          	sext.w	a4,a5
    802020ac:	47c1                	li	a5,16
    802020ae:	00e7f463          	bgeu	a5,a4,802020b6 <mini_itoa+0x46>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:35
        return 0;
    802020b2:	4781                	li	a5,0
    802020b4:	aae9                	j	8020228e <mini_itoa+0x21e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:37

    if (value < 0 && !unsig)
    802020b6:	fc843783          	ld	a5,-56(s0)
    802020ba:	0007df63          	bgez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:37 (discriminator 1)
    802020be:	fbc42783          	lw	a5,-68(s0)
    802020c2:	2781                	sext.w	a5,a5
    802020c4:	eb91                	bnez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:39
    {
        negative = 1;
    802020c6:	4785                	li	a5,1
    802020c8:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:40
        value = -value;
    802020cc:	fc843783          	ld	a5,-56(s0)
    802020d0:	40f007b3          	neg	a5,a5
    802020d4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:46
    }

    /* This builds the string back to front ... */
    do
    {
        int digit = 0;
    802020d8:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:47
        if (unsig)
    802020dc:	fbc42783          	lw	a5,-68(s0)
    802020e0:	2781                	sext.w	a5,a5
    802020e2:	cb91                	beqz	a5,802020f6 <mini_itoa+0x86>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:49
        {
            digit = (unsigned long)value % (unsigned)radix;
    802020e4:	fc843703          	ld	a4,-56(s0)
    802020e8:	fc446783          	lwu	a5,-60(s0)
    802020ec:	02f777b3          	remu	a5,a4,a5
    802020f0:	fcf42e23          	sw	a5,-36(s0)
    802020f4:	a809                	j	80202106 <mini_itoa+0x96>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:53
        }
        else
        {
            digit = value % radix;
    802020f6:	fc446783          	lwu	a5,-60(s0)
    802020fa:	fc843703          	ld	a4,-56(s0)
    802020fe:	02f767b3          	rem	a5,a4,a5
    80202102:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:55
        }
        *(pbuffer++) =
    80202106:	fdc42783          	lw	a5,-36(s0)
    8020210a:	0007871b          	sext.w	a4,a5
    8020210e:	47a5                	li	a5,9
    80202110:	00e7cb63          	blt	a5,a4,80202126 <mini_itoa+0xb6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:56 (discriminator 1)
            (digit < 10 ? '0' + digit : (uppercase ? 'A' : 'a') + digit - 10);
    80202114:	fdc42783          	lw	a5,-36(s0)
    80202118:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:55 (discriminator 1)
        *(pbuffer++) =
    8020211c:	0307879b          	addiw	a5,a5,48
    80202120:	0ff7f713          	andi	a4,a5,255
    80202124:	a025                	j	8020214c <mini_itoa+0xdc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:56
            (digit < 10 ? '0' + digit : (uppercase ? 'A' : 'a') + digit - 10);
    80202126:	fc042783          	lw	a5,-64(s0)
    8020212a:	2781                	sext.w	a5,a5
    8020212c:	c781                	beqz	a5,80202134 <mini_itoa+0xc4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:56 (discriminator 1)
    8020212e:	04100793          	li	a5,65
    80202132:	a019                	j	80202138 <mini_itoa+0xc8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:56 (discriminator 2)
    80202134:	06100793          	li	a5,97
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:56 (discriminator 4)
    80202138:	fdc42703          	lw	a4,-36(s0)
    8020213c:	0ff77713          	andi	a4,a4,255
    80202140:	9fb9                	addw	a5,a5,a4
    80202142:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:55 (discriminator 4)
        *(pbuffer++) =
    80202146:	37d9                	addiw	a5,a5,-10
    80202148:	0ff7f713          	andi	a4,a5,255
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:55 (discriminator 3)
    8020214c:	fe843783          	ld	a5,-24(s0)
    80202150:	00178693          	addi	a3,a5,1
    80202154:	fed43423          	sd	a3,-24(s0)
    80202158:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:57 (discriminator 3)
        if (unsig)
    8020215c:	fbc42783          	lw	a5,-68(s0)
    80202160:	2781                	sext.w	a5,a5
    80202162:	cb91                	beqz	a5,80202176 <mini_itoa+0x106>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:59
        {
            value = (unsigned long)value / (unsigned)radix;
    80202164:	fc843703          	ld	a4,-56(s0)
    80202168:	fc446783          	lwu	a5,-60(s0)
    8020216c:	02f757b3          	divu	a5,a4,a5
    80202170:	fcf43423          	sd	a5,-56(s0)
    80202174:	a809                	j	80202186 <mini_itoa+0x116>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:63
        }
        else
        {
            value /= radix;
    80202176:	fc446783          	lwu	a5,-60(s0)
    8020217a:	fc843703          	ld	a4,-56(s0)
    8020217e:	02f747b3          	div	a5,a4,a5
    80202182:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:65
        }
    } while (value != 0);
    80202186:	fc843783          	ld	a5,-56(s0)
    8020218a:	f7b9                	bnez	a5,802020d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:67

    for (i = (pbuffer - buffer); i < zero_pad; i++)
    8020218c:	fe843703          	ld	a4,-24(s0)
    80202190:	fb043783          	ld	a5,-80(s0)
    80202194:	40f707b3          	sub	a5,a4,a5
    80202198:	fef42023          	sw	a5,-32(s0)
    8020219c:	a005                	j	802021bc <mini_itoa+0x14c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:68 (discriminator 3)
        *(pbuffer++) = '0';
    8020219e:	fe843783          	ld	a5,-24(s0)
    802021a2:	00178713          	addi	a4,a5,1
    802021a6:	fee43423          	sd	a4,-24(s0)
    802021aa:	03000713          	li	a4,48
    802021ae:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:67 (discriminator 3)
    for (i = (pbuffer - buffer); i < zero_pad; i++)
    802021b2:	fe042783          	lw	a5,-32(s0)
    802021b6:	2785                	addiw	a5,a5,1
    802021b8:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:67 (discriminator 1)
    802021bc:	fe042703          	lw	a4,-32(s0)
    802021c0:	fb842783          	lw	a5,-72(s0)
    802021c4:	2701                	sext.w	a4,a4
    802021c6:	2781                	sext.w	a5,a5
    802021c8:	fcf76be3          	bltu	a4,a5,8020219e <mini_itoa+0x12e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:70

    if (negative)
    802021cc:	fe442783          	lw	a5,-28(s0)
    802021d0:	2781                	sext.w	a5,a5
    802021d2:	cb99                	beqz	a5,802021e8 <mini_itoa+0x178>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:71
        *(pbuffer++) = '-';
    802021d4:	fe843783          	ld	a5,-24(s0)
    802021d8:	00178713          	addi	a4,a5,1
    802021dc:	fee43423          	sd	a4,-24(s0)
    802021e0:	02d00713          	li	a4,45
    802021e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:73

    *(pbuffer) = '\0';
    802021e8:	fe843783          	ld	a5,-24(s0)
    802021ec:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:75

    len = (pbuffer - buffer);
    802021f0:	fe843703          	ld	a4,-24(s0)
    802021f4:	fb043783          	ld	a5,-80(s0)
    802021f8:	40f707b3          	sub	a5,a4,a5
    802021fc:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:76
    for (i = 0; i < len / 2; i++)
    80202200:	fe042023          	sw	zero,-32(s0)
    80202204:	a885                	j	80202274 <mini_itoa+0x204>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:78 (discriminator 3)
    {
        char j = buffer[i];
    80202206:	fe046783          	lwu	a5,-32(s0)
    8020220a:	fb043703          	ld	a4,-80(s0)
    8020220e:	97ba                	add	a5,a5,a4
    80202210:	0007c783          	lbu	a5,0(a5)
    80202214:	fcf40ba3          	sb	a5,-41(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:79 (discriminator 3)
        buffer[i] = buffer[len - i - 1];
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:80 (discriminator 3)
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:76 (discriminator 3)
    for (i = 0; i < len / 2; i++)
    8020226a:	fe042783          	lw	a5,-32(s0)
    8020226e:	2785                	addiw	a5,a5,1
    80202270:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:76 (discriminator 1)
    80202274:	fd842783          	lw	a5,-40(s0)
    80202278:	0017d79b          	srliw	a5,a5,0x1
    8020227c:	0007871b          	sext.w	a4,a5
    80202280:	fe042783          	lw	a5,-32(s0)
    80202284:	2781                	sext.w	a5,a5
    80202286:	f8e7e0e3          	bltu	a5,a4,80202206 <mini_itoa+0x196>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:83
    }

    return len;
    8020228a:	fd842783          	lw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:84
}
    8020228e:	853e                	mv	a0,a5
    80202290:	6426                	ld	s0,72(sp)
    80202292:	6161                	addi	sp,sp,80
    80202294:	8082                	ret

0000000080202296 <_putc>:
_putc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:93
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:94
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802022a6:	fe043783          	ld	a5,-32(s0)
    802022aa:	6798                	ld	a4,8(a5)
    802022ac:	fe043783          	ld	a5,-32(s0)
    802022b0:	639c                	ld	a5,0(a5)
    802022b2:	40f707b3          	sub	a5,a4,a5
    802022b6:	2781                	sext.w	a5,a5
    802022b8:	2785                	addiw	a5,a5,1
    802022ba:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:95
        b->buffer_len)
    802022be:	fe043783          	ld	a5,-32(s0)
    802022c2:	4b9c                	lw	a5,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:94
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802022c4:	00f76463          	bltu	a4,a5,802022cc <_putc+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:96
        return 0;
    802022c8:	4781                	li	a5,0
    802022ca:	a02d                	j	802022f4 <_putc+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:97
    *(b->pbuffer++) = ch;
    802022cc:	fe043783          	ld	a5,-32(s0)
    802022d0:	679c                	ld	a5,8(a5)
    802022d2:	00178693          	addi	a3,a5,1
    802022d6:	fe043703          	ld	a4,-32(s0)
    802022da:	e714                	sd	a3,8(a4)
    802022dc:	fec42703          	lw	a4,-20(s0)
    802022e0:	0ff77713          	andi	a4,a4,255
    802022e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:98
    *(b->pbuffer) = '\0';
    802022e8:	fe043783          	ld	a5,-32(s0)
    802022ec:	679c                	ld	a5,8(a5)
    802022ee:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:99
    return 1;
    802022f2:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:100
}
    802022f4:	853e                	mv	a0,a5
    802022f6:	6462                	ld	s0,24(sp)
    802022f8:	6105                	addi	sp,sp,32
    802022fa:	8082                	ret

00000000802022fc <_puts>:
_puts():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:103

static int _puts(char *s, unsigned int len, struct mini_buff *b)
{
    802022fc:	7139                	addi	sp,sp,-64
    802022fe:	fc22                	sd	s0,56(sp)
    80202300:	0080                	addi	s0,sp,64
    80202302:	fca43c23          	sd	a0,-40(s0)
    80202306:	87ae                	mv	a5,a1
    80202308:	fcc43423          	sd	a2,-56(s0)
    8020230c:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:106
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:107
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:110

    /* Copy to buffer */
    for (i = 0; i < len; i++)
    8020235a:	fe042623          	sw	zero,-20(s0)
    8020235e:	a03d                	j	8020238c <_puts+0x90>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:111 (discriminator 3)
        *(b->pbuffer++) = s[i];
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:110 (discriminator 3)
    for (i = 0; i < len; i++)
    80202382:	fec42783          	lw	a5,-20(s0)
    80202386:	2785                	addiw	a5,a5,1
    80202388:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:110 (discriminator 1)
    8020238c:	fec42703          	lw	a4,-20(s0)
    80202390:	fd442783          	lw	a5,-44(s0)
    80202394:	2701                	sext.w	a4,a4
    80202396:	2781                	sext.w	a5,a5
    80202398:	fcf764e3          	bltu	a4,a5,80202360 <_puts+0x64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:112
    *(b->pbuffer) = '\0';
    8020239c:	fc843783          	ld	a5,-56(s0)
    802023a0:	679c                	ld	a5,8(a5)
    802023a2:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:114

    return len;
    802023a6:	fd442783          	lw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:115
}
    802023aa:	853e                	mv	a0,a5
    802023ac:	7462                	ld	s0,56(sp)
    802023ae:	6121                	addi	sp,sp,64
    802023b0:	8082                	ret

00000000802023b2 <mini_vsnprintf>:
mini_vsnprintf():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:120

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:125
    struct mini_buff b;
    char bf[24];
    char ch;

    b.buffer = buffer;
    802023cc:	f9843783          	ld	a5,-104(s0)
    802023d0:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:126
    b.pbuffer = buffer;
    802023d4:	f9843783          	ld	a5,-104(s0)
    802023d8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:127
    b.buffer_len = buffer_len;
    802023dc:	f9442783          	lw	a5,-108(s0)
    802023e0:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:129

    while ((ch = *(fmt++)))
    802023e4:	a4f9                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:131
    {
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802023e6:	fc843703          	ld	a4,-56(s0)
    802023ea:	fc043783          	ld	a5,-64(s0)
    802023ee:	40f707b3          	sub	a5,a4,a5
    802023f2:	2781                	sext.w	a5,a5
    802023f4:	2785                	addiw	a5,a5,1
    802023f6:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:132
            b.buffer_len)
    802023fa:	fd042783          	lw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:131
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802023fe:	2cf77b63          	bgeu	a4,a5,802026d4 <mini_vsnprintf+0x322>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:134
            break;
        if (ch != '%')
    80202402:	fef44783          	lbu	a5,-17(s0)
    80202406:	0ff7f713          	andi	a4,a5,255
    8020240a:	02500793          	li	a5,37
    8020240e:	00f70c63          	beq	a4,a5,80202426 <mini_vsnprintf+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:135
            _putc(ch, &b);
    80202412:	fef44783          	lbu	a5,-17(s0)
    80202416:	2781                	sext.w	a5,a5
    80202418:	fc040713          	addi	a4,s0,-64
    8020241c:	85ba                	mv	a1,a4
    8020241e:	853e                	mv	a0,a5
    80202420:	e77ff0ef          	jal	ra,80202296 <_putc>
    80202424:	a479                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:138
        else
        {
            char zero_pad = 0;
    80202426:	fe040723          	sb	zero,-18(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:139
            int longflag = 0;
    8020242a:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:143
            char *ptr;
            unsigned int len;

            ch = *(fmt++);
    8020242e:	f8843783          	ld	a5,-120(s0)
    80202432:	00178713          	addi	a4,a5,1
    80202436:	f8e43423          	sd	a4,-120(s0)
    8020243a:	0007c783          	lbu	a5,0(a5)
    8020243e:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:146

            /* Zero padding requested */
            if (ch == '0')
    80202442:	fef44783          	lbu	a5,-17(s0)
    80202446:	0ff7f713          	andi	a4,a5,255
    8020244a:	03000793          	li	a5,48
    8020244e:	06f71b63          	bne	a4,a5,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:148
            {
                while ((ch = *(fmt++)))
    80202452:	a891                	j	802024a6 <mini_vsnprintf+0xf4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:150
                {
                    if (ch == '\0')
    80202454:	fef44783          	lbu	a5,-17(s0)
    80202458:	0ff7f793          	andi	a5,a5,255
    8020245c:	26078e63          	beqz	a5,802026d8 <mini_vsnprintf+0x326>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:152
                        goto end;
                    if (ch >= '0' && ch <= '9')
    80202460:	fef44783          	lbu	a5,-17(s0)
    80202464:	0ff7f713          	andi	a4,a5,255
    80202468:	02f00793          	li	a5,47
    8020246c:	04e7fc63          	bgeu	a5,a4,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:152 (discriminator 1)
    80202470:	fef44783          	lbu	a5,-17(s0)
    80202474:	0ff7f713          	andi	a4,a5,255
    80202478:	03900793          	li	a5,57
    8020247c:	04e7e463          	bltu	a5,a4,802024c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:154
                    {
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:148
                while ((ch = *(fmt++)))
    802024a6:	f8843783          	ld	a5,-120(s0)
    802024aa:	00178713          	addi	a4,a5,1
    802024ae:	f8e43423          	sd	a4,-120(s0)
    802024b2:	0007c783          	lbu	a5,0(a5)
    802024b6:	fef407a3          	sb	a5,-17(s0)
    802024ba:	fef44783          	lbu	a5,-17(s0)
    802024be:	0ff7f793          	andi	a5,a5,255
    802024c2:	fbc9                	bnez	a5,80202454 <mini_vsnprintf+0xa2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:162
                    {
                        break;
                    }
                }
            }
            if (ch == 'l')
    802024c4:	fef44783          	lbu	a5,-17(s0)
    802024c8:	0ff7f713          	andi	a4,a5,255
    802024cc:	06c00793          	li	a5,108
    802024d0:	00f71f63          	bne	a4,a5,802024ee <mini_vsnprintf+0x13c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:164
            {
                longflag = 1;
    802024d4:	4785                	li	a5,1
    802024d6:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:165
                ch = *(fmt++);
    802024da:	f8843783          	ld	a5,-120(s0)
    802024de:	00178713          	addi	a4,a5,1
    802024e2:	f8e43423          	sd	a4,-120(s0)
    802024e6:	0007c783          	lbu	a5,0(a5)
    802024ea:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:168
            }

            switch (ch)
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
    8020252c:	00008797          	auipc	a5,0x8
    80202530:	ad478793          	addi	a5,a5,-1324 # 8020a000 <etext>
    80202534:	97ba                	add	a5,a5,a4
    80202536:	439c                	lw	a5,0(a5)
    80202538:	0007871b          	sext.w	a4,a5
    8020253c:	00008797          	auipc	a5,0x8
    80202540:	ac478793          	addi	a5,a5,-1340 # 8020a000 <etext>
    80202544:	97ba                	add	a5,a5,a4
    80202546:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:174
            {
            case 0:
                goto end;

            case 'l':
                longflag = 1;
    80202548:	4785                	li	a5,1
    8020254a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:175
                break;
    8020254e:	a295                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:179

            case 'u':
            case 'd':
                len = mini_itoa(
    80202550:	fe842783          	lw	a5,-24(s0)
    80202554:	2781                	sext.w	a5,a5
    80202556:	ef81                	bnez	a5,8020256e <mini_vsnprintf+0x1bc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:180
                    longflag == 0 ? (unsigned long)va_arg(
    80202558:	f8043783          	ld	a5,-128(s0)
    8020255c:	00878713          	addi	a4,a5,8
    80202560:	f8e43023          	sd	a4,-128(s0)
    80202564:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:179
                len = mini_itoa(
    80202566:	02079513          	slli	a0,a5,0x20
    8020256a:	9101                	srli	a0,a0,0x20
    8020256c:	a809                	j	8020257e <mini_vsnprintf+0x1cc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:182
                                        va, unsigned int)
                                  : va_arg(va, unsigned long),
    8020256e:	f8043783          	ld	a5,-128(s0)
    80202572:	00878713          	addi	a4,a5,8
    80202576:	f8e43023          	sd	a4,-128(s0)
    8020257a:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:179
                len = mini_itoa(
    8020257c:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:179 (discriminator 4)
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:184 (discriminator 4)
                    10, 0, (ch == 'u'), bf, zero_pad);
                _puts(bf, len, &b);
    802025b2:	fc040693          	addi	a3,s0,-64
    802025b6:	fdc42703          	lw	a4,-36(s0)
    802025ba:	fa840793          	addi	a5,s0,-88
    802025be:	8636                	mv	a2,a3
    802025c0:	85ba                	mv	a1,a4
    802025c2:	853e                	mv	a0,a5
    802025c4:	d39ff0ef          	jal	ra,802022fc <_puts>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:185 (discriminator 4)
                longflag = 0;
    802025c8:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:186 (discriminator 4)
                break;
    802025cc:	a0dd                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:189
            case 'x':
            case 'X':
                len = mini_itoa(
    802025ce:	fe842783          	lw	a5,-24(s0)
    802025d2:	2781                	sext.w	a5,a5
    802025d4:	ef81                	bnez	a5,802025ec <mini_vsnprintf+0x23a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:190
                    longflag == 0 ? (unsigned long)va_arg(
    802025d6:	f8043783          	ld	a5,-128(s0)
    802025da:	00878713          	addi	a4,a5,8
    802025de:	f8e43023          	sd	a4,-128(s0)
    802025e2:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:189
                len = mini_itoa(
    802025e4:	02079513          	slli	a0,a5,0x20
    802025e8:	9101                	srli	a0,a0,0x20
    802025ea:	a809                	j	802025fc <mini_vsnprintf+0x24a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:192
                                        va, unsigned int)
                                  : va_arg(va, unsigned long),
    802025ec:	f8043783          	ld	a5,-128(s0)
    802025f0:	00878713          	addi	a4,a5,8
    802025f4:	f8e43023          	sd	a4,-128(s0)
    802025f8:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:189
                len = mini_itoa(
    802025fa:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:189 (discriminator 4)
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:194 (discriminator 4)
                    16, (ch == 'X'), 1, bf, zero_pad);
                _puts(bf, len, &b);
    80202630:	fc040693          	addi	a3,s0,-64
    80202634:	fdc42703          	lw	a4,-36(s0)
    80202638:	fa840793          	addi	a5,s0,-88
    8020263c:	8636                	mv	a2,a3
    8020263e:	85ba                	mv	a1,a4
    80202640:	853e                	mv	a0,a5
    80202642:	cbbff0ef          	jal	ra,802022fc <_puts>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:195 (discriminator 4)
                longflag = 0;
    80202646:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:196 (discriminator 4)
                break;
    8020264a:	a0a5                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:199

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:200
                break;
    8020266c:	a099                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:203

            case 's':
                ptr = va_arg(va, char *);
    8020266e:	f8043783          	ld	a5,-128(s0)
    80202672:	00878713          	addi	a4,a5,8
    80202676:	f8e43023          	sd	a4,-128(s0)
    8020267a:	639c                	ld	a5,0(a5)
    8020267c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:204
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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:205
                break;
    8020269c:	a819                	j	802026b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:208

            default:
                _putc(ch, &b);
    8020269e:	fef44783          	lbu	a5,-17(s0)
    802026a2:	2781                	sext.w	a5,a5
    802026a4:	fc040713          	addi	a4,s0,-64
    802026a8:	85ba                	mv	a1,a4
    802026aa:	853e                	mv	a0,a5
    802026ac:	bebff0ef          	jal	ra,80202296 <_putc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:209
                break;
    802026b0:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:129
    while ((ch = *(fmt++)))
    802026b2:	f8843783          	ld	a5,-120(s0)
    802026b6:	00178713          	addi	a4,a5,1
    802026ba:	f8e43423          	sd	a4,-120(s0)
    802026be:	0007c783          	lbu	a5,0(a5)
    802026c2:	fef407a3          	sb	a5,-17(s0)
    802026c6:	fef44783          	lbu	a5,-17(s0)
    802026ca:	0ff7f793          	andi	a5,a5,255
    802026ce:	d0079ce3          	bnez	a5,802023e6 <mini_vsnprintf+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:213
            }
        }
    }
end:
    802026d2:	a031                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:133
            break;
    802026d4:	0001                	nop
    802026d6:	a021                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:151
                        goto end;
    802026d8:	0001                	nop
    802026da:	a011                	j	802026de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:171
                goto end;
    802026dc:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:214
    return b.pbuffer - b.buffer;
    802026de:	fc843703          	ld	a4,-56(s0)
    802026e2:	fc043783          	ld	a5,-64(s0)
    802026e6:	40f707b3          	sub	a5,a4,a5
    802026ea:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:215
}
    802026ec:	853e                	mv	a0,a5
    802026ee:	70e6                	ld	ra,120(sp)
    802026f0:	7446                	ld	s0,112(sp)
    802026f2:	6109                	addi	sp,sp,128
    802026f4:	8082                	ret

00000000802026f6 <_vprintk>:
_vprintk():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:219

static int _vprintk(const char *fmt, va_list _va,
                    void (*output)(char *))
{
    802026f6:	7129                	addi	sp,sp,-320
    802026f8:	fe06                	sd	ra,312(sp)
    802026fa:	fa22                	sd	s0,304(sp)
    802026fc:	0280                	addi	s0,sp,320
    802026fe:	eca43c23          	sd	a0,-296(s0)
    80202702:	ecb43823          	sd	a1,-304(s0)
    80202706:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:221
    va_list va;
    va_copy(va, _va);
    8020270a:	ed043783          	ld	a5,-304(s0)
    8020270e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:226

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:228

    buff[ret] = '\0';
    80202730:	fec42783          	lw	a5,-20(s0)
    80202734:	ff040713          	addi	a4,s0,-16
    80202738:	97ba                	add	a5,a5,a4
    8020273a:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:233

    // disable_preempt();

    // 在此处调用sbi，output
    output(buff);
    8020273e:	ee040793          	addi	a5,s0,-288
    80202742:	ec843703          	ld	a4,-312(s0)
    80202746:	853e                	mv	a0,a5
    80202748:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:248
    //     }
    // }

    // enable_preempt();

    return ret;
    8020274a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:249
}
    8020274e:	853e                	mv	a0,a5
    80202750:	70f2                	ld	ra,312(sp)
    80202752:	7452                	ld	s0,304(sp)
    80202754:	6131                	addi	sp,sp,320
    80202756:	8082                	ret

0000000080202758 <_vprints>:
_vprints():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:253

static int _vprints(const char *fmt, va_list _va,
                    void (*output)(char *))
{
    80202758:	7129                	addi	sp,sp,-320
    8020275a:	fe06                	sd	ra,312(sp)
    8020275c:	fa22                	sd	s0,304(sp)
    8020275e:	0280                	addi	s0,sp,320
    80202760:	eca43c23          	sd	a0,-296(s0)
    80202764:	ecb43823          	sd	a1,-304(s0)
    80202768:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:255
    va_list va;
    va_copy(va, _va);
    8020276c:	ed043783          	ld	a5,-304(s0)
    80202770:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:260

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:262

    buff[ret] = '\0';
    80202792:	fec42783          	lw	a5,-20(s0)
    80202796:	ff040713          	addi	a4,s0,-16
    8020279a:	97ba                	add	a5,a5,a4
    8020279c:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:267

    // disable_preempt();

    // 在此处调用sbi，output
    output(buff);
    802027a0:	ee040793          	addi	a5,s0,-288
    802027a4:	ec843703          	ld	a4,-312(s0)
    802027a8:	853e                	mv	a0,a5
    802027aa:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:271

    // enable_preempt();

    return ret;
    802027ac:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:272
}
    802027b0:	853e                	mv	a0,a5
    802027b2:	70f2                	ld	ra,312(sp)
    802027b4:	7452                	ld	s0,304(sp)
    802027b6:	6131                	addi	sp,sp,320
    802027b8:	8082                	ret

00000000802027ba <vprintk>:
vprintk():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:275

int vprintk(const char *fmt, va_list _va)
{
    802027ba:	1101                	addi	sp,sp,-32
    802027bc:	ec06                	sd	ra,24(sp)
    802027be:	e822                	sd	s0,16(sp)
    802027c0:	1000                	addi	s0,sp,32
    802027c2:	fea43423          	sd	a0,-24(s0)
    802027c6:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:276
    return _vprintk(fmt, _va, port_write);
    802027ca:	00000617          	auipc	a2,0x0
    802027ce:	83660613          	addi	a2,a2,-1994 # 80202000 <port_write>
    802027d2:	fe043583          	ld	a1,-32(s0)
    802027d6:	fe843503          	ld	a0,-24(s0)
    802027da:	f1dff0ef          	jal	ra,802026f6 <_vprintk>
    802027de:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:277
}
    802027e0:	853e                	mv	a0,a5
    802027e2:	60e2                	ld	ra,24(sp)
    802027e4:	6442                	ld	s0,16(sp)
    802027e6:	6105                	addi	sp,sp,32
    802027e8:	8082                	ret

00000000802027ea <printk>:
printk():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:280

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:281
    int ret = 0;
    80202808:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:284
    va_list va;

    va_start(va, fmt);
    8020280c:	04040793          	addi	a5,s0,64
    80202810:	fcf43823          	sd	a5,-48(s0)
    80202814:	fd043783          	ld	a5,-48(s0)
    80202818:	fc878793          	addi	a5,a5,-56
    8020281c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:285
    ret = vprintk(fmt, va);
    80202820:	fe043783          	ld	a5,-32(s0)
    80202824:	85be                	mv	a1,a5
    80202826:	fd843503          	ld	a0,-40(s0)
    8020282a:	f91ff0ef          	jal	ra,802027ba <vprintk>
    8020282e:	87aa                	mv	a5,a0
    80202830:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:288
    va_end(va);

    return ret;
    80202834:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:289
}
    80202838:	853e                	mv	a0,a5
    8020283a:	70a2                	ld	ra,40(sp)
    8020283c:	7402                	ld	s0,32(sp)
    8020283e:	6165                	addi	sp,sp,112
    80202840:	8082                	ret

0000000080202842 <_vprintk_port>:
_vprintk_port():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:295

/* for port output, direct output */

static int _vprintk_port(const char *fmt, va_list _va,
                         void (*output)(char *))
{
    80202842:	7129                	addi	sp,sp,-320
    80202844:	fe06                	sd	ra,312(sp)
    80202846:	fa22                	sd	s0,304(sp)
    80202848:	0280                	addi	s0,sp,320
    8020284a:	eca43c23          	sd	a0,-296(s0)
    8020284e:	ecb43823          	sd	a1,-304(s0)
    80202852:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:297
    va_list va;
    va_copy(va, _va);
    80202856:	ed043783          	ld	a5,-304(s0)
    8020285a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:302

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:304

    buff[ret] = '\0';
    8020287c:	fec42783          	lw	a5,-20(s0)
    80202880:	ff040713          	addi	a4,s0,-16
    80202884:	97ba                	add	a5,a5,a4
    80202886:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:313
    // 在此处调用sbi，output
    // port_write(buff);

    // enable_preempt();

    return ret;
    8020288a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:314
}
    8020288e:	853e                	mv	a0,a5
    80202890:	70f2                	ld	ra,312(sp)
    80202892:	7452                	ld	s0,304(sp)
    80202894:	6131                	addi	sp,sp,320
    80202896:	8082                	ret

0000000080202898 <vprintk_port>:
vprintk_port():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:317

int vprintk_port(const char *fmt, va_list _va)
{
    80202898:	1101                	addi	sp,sp,-32
    8020289a:	ec06                	sd	ra,24(sp)
    8020289c:	e822                	sd	s0,16(sp)
    8020289e:	1000                	addi	s0,sp,32
    802028a0:	fea43423          	sd	a0,-24(s0)
    802028a4:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:318
    return _vprintk_port(fmt, _va, port_write);
    802028a8:	fffff617          	auipc	a2,0xfffff
    802028ac:	75860613          	addi	a2,a2,1880 # 80202000 <port_write>
    802028b0:	fe043583          	ld	a1,-32(s0)
    802028b4:	fe843503          	ld	a0,-24(s0)
    802028b8:	f8bff0ef          	jal	ra,80202842 <_vprintk_port>
    802028bc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:319
}
    802028be:	853e                	mv	a0,a5
    802028c0:	60e2                	ld	ra,24(sp)
    802028c2:	6442                	ld	s0,16(sp)
    802028c4:	6105                	addi	sp,sp,32
    802028c6:	8082                	ret

00000000802028c8 <printk_port>:
printk_port():
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:322

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
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:323
    uint32_t ret = 0;
    802028e6:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:326
    va_list va;

    va_start(va, fmt);
    802028ea:	04040793          	addi	a5,s0,64
    802028ee:	fcf43823          	sd	a5,-48(s0)
    802028f2:	fd043783          	ld	a5,-48(s0)
    802028f6:	fc878793          	addi	a5,a5,-56
    802028fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:327
    ret = vprintk_port(fmt, va);
    802028fe:	fe043783          	ld	a5,-32(s0)
    80202902:	85be                	mv	a1,a5
    80202904:	fd843503          	ld	a0,-40(s0)
    80202908:	f91ff0ef          	jal	ra,80202898 <vprintk_port>
    8020290c:	87aa                	mv	a5,a0
    8020290e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:330
    va_end(va);

    return ret;
    80202912:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/lib/printk.c:331
    80202916:	853e                	mv	a0,a5
    80202918:	70a2                	ld	ra,40(sp)
    8020291a:	7402                	ld	s0,32(sp)
    8020291c:	6165                	addi	sp,sp,112
    8020291e:	8082                	ret

0000000080202920 <write_addr>:
write_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:100
    uint32_t reserved; // 保留字段
    uint64_t sector;   // 扇区号
};

static void write_addr(uint32_t offset, uint32_t value)
{
    80202920:	7179                	addi	sp,sp,-48
    80202922:	f422                	sd	s0,40(sp)
    80202924:	1800                	addi	s0,sp,48
    80202926:	87aa                	mv	a5,a0
    80202928:	872e                	mv	a4,a1
    8020292a:	fcf42e23          	sw	a5,-36(s0)
    8020292e:	87ba                	mv	a5,a4
    80202930:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:101
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    80202934:	fdc42703          	lw	a4,-36(s0)
    80202938:	100017b7          	lui	a5,0x10001
    8020293c:	9fb9                	addw	a5,a5,a4
    8020293e:	2781                	sext.w	a5,a5
    80202940:	1782                	slli	a5,a5,0x20
    80202942:	9381                	srli	a5,a5,0x20
    80202944:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:102
    *addr = value;
    80202948:	fe843783          	ld	a5,-24(s0)
    8020294c:	fd842703          	lw	a4,-40(s0)
    80202950:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:103
}
    80202952:	0001                	nop
    80202954:	7422                	ld	s0,40(sp)
    80202956:	6145                	addi	sp,sp,48
    80202958:	8082                	ret

000000008020295a <read_addr>:
read_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:105
static uint32_t read_addr(uint32_t offset)
{
    8020295a:	7179                	addi	sp,sp,-48
    8020295c:	f422                	sd	s0,40(sp)
    8020295e:	1800                	addi	s0,sp,48
    80202960:	87aa                	mv	a5,a0
    80202962:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:106
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    80202966:	fdc42703          	lw	a4,-36(s0)
    8020296a:	100017b7          	lui	a5,0x10001
    8020296e:	9fb9                	addw	a5,a5,a4
    80202970:	2781                	sext.w	a5,a5
    80202972:	1782                	slli	a5,a5,0x20
    80202974:	9381                	srli	a5,a5,0x20
    80202976:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:107
    return *addr;
    8020297a:	fe843783          	ld	a5,-24(s0)
    8020297e:	439c                	lw	a5,0(a5)
    80202980:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:108
}
    80202982:	853e                	mv	a0,a5
    80202984:	7422                	ld	s0,40(sp)
    80202986:	6145                	addi	sp,sp,48
    80202988:	8082                	ret

000000008020298a <r_sstatus>:
r_sstatus():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:51
#define SSTATUS_UPIE (1L << 4) // User Previous Interrupt Enable
#define SSTATUS_SIE (1L << 1)  // Supervisor Interrupt Enable
#define SSTATUS_UIE (1L << 0)  // User Interrupt Enable

static inline uint64_t r_sstatus()
{
    8020298a:	1101                	addi	sp,sp,-32
    8020298c:	ec22                	sd	s0,24(sp)
    8020298e:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:53
  uint64_t x;
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80202990:	100027f3          	csrr	a5,sstatus
    80202994:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:54
  return x;
    80202998:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:55
}
    8020299c:	853e                	mv	a0,a5
    8020299e:	6462                	ld	s0,24(sp)
    802029a0:	6105                	addi	sp,sp,32
    802029a2:	8082                	ret

00000000802029a4 <w_sstatus>:
w_sstatus():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:58

static inline void w_sstatus(uint64_t x)
{
    802029a4:	1101                	addi	sp,sp,-32
    802029a6:	ec22                	sd	s0,24(sp)
    802029a8:	1000                	addi	s0,sp,32
    802029aa:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:59
  asm volatile("csrw sstatus, %0" : : "r"(x));
    802029ae:	fe843783          	ld	a5,-24(s0)
    802029b2:	10079073          	csrw	sstatus,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:60
}
    802029b6:	0001                	nop
    802029b8:	6462                	ld	s0,24(sp)
    802029ba:	6105                	addi	sp,sp,32
    802029bc:	8082                	ret

00000000802029be <intr_on>:
intr_on():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:236
  asm volatile("csrr %0, time" : "=r"(x));
  return x;
}

// enable device interrupts
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    802029be:	1141                	addi	sp,sp,-16
    802029c0:	e406                	sd	ra,8(sp)
    802029c2:	e022                	sd	s0,0(sp)
    802029c4:	0800                	addi	s0,sp,16
    802029c6:	fc5ff0ef          	jal	ra,8020298a <r_sstatus>
    802029ca:	87aa                	mv	a5,a0
    802029cc:	0027e793          	ori	a5,a5,2
    802029d0:	853e                	mv	a0,a5
    802029d2:	fd3ff0ef          	jal	ra,802029a4 <w_sstatus>
    802029d6:	0001                	nop
    802029d8:	60a2                	ld	ra,8(sp)
    802029da:	6402                	ld	s0,0(sp)
    802029dc:	0141                	addi	sp,sp,16
    802029de:	8082                	ret

00000000802029e0 <intr_off>:
intr_off():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:239

// disable device interrupts
static inline void intr_off() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }
    802029e0:	1141                	addi	sp,sp,-16
    802029e2:	e406                	sd	ra,8(sp)
    802029e4:	e022                	sd	s0,0(sp)
    802029e6:	0800                	addi	s0,sp,16
    802029e8:	fa3ff0ef          	jal	ra,8020298a <r_sstatus>
    802029ec:	87aa                	mv	a5,a0
    802029ee:	9bf5                	andi	a5,a5,-3
    802029f0:	853e                	mv	a0,a5
    802029f2:	fb3ff0ef          	jal	ra,802029a4 <w_sstatus>
    802029f6:	0001                	nop
    802029f8:	60a2                	ld	ra,8(sp)
    802029fa:	6402                	ld	s0,0(sp)
    802029fc:	0141                	addi	sp,sp,16
    802029fe:	8082                	ret

0000000080202a00 <virtio_disk_init>:
virtio_disk_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:8
#include "config.h"
#include "virtio_disk.h"
#include "riscv.h"

void virtio_disk_init()
{
    80202a00:	7179                	addi	sp,sp,-48
    80202a02:	f406                	sd	ra,40(sp)
    80202a04:	f022                	sd	s0,32(sp)
    80202a06:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:9
    uint32_t status = 0;
    80202a08:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:11

    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80202a0c:	100017b7          	lui	a5,0x10001
    80202a10:	439c                	lw	a5,0(a5)
    80202a12:	2781                	sext.w	a5,a5
    80202a14:	873e                	mv	a4,a5
    80202a16:	747277b7          	lui	a5,0x74727
    80202a1a:	97678793          	addi	a5,a5,-1674 # 74726976 <n+0x74726956>
    80202a1e:	04f71063          	bne	a4,a5,80202a5e <virtio_disk_init+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:12 (discriminator 1)
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80202a22:	100017b7          	lui	a5,0x10001
    80202a26:	0791                	addi	a5,a5,4
    80202a28:	439c                	lw	a5,0(a5)
    80202a2a:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:11 (discriminator 1)
    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80202a2c:	873e                	mv	a4,a5
    80202a2e:	4785                	li	a5,1
    80202a30:	02f71763          	bne	a4,a5,80202a5e <virtio_disk_init+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:12
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80202a34:	100017b7          	lui	a5,0x10001
    80202a38:	07a1                	addi	a5,a5,8
    80202a3a:	439c                	lw	a5,0(a5)
    80202a3c:	2781                	sext.w	a5,a5
    80202a3e:	873e                	mv	a4,a5
    80202a40:	4789                	li	a5,2
    80202a42:	00f71e63          	bne	a4,a5,80202a5e <virtio_disk_init+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:13 (discriminator 1)
        *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551)
    80202a46:	100017b7          	lui	a5,0x10001
    80202a4a:	07b1                	addi	a5,a5,12
    80202a4c:	439c                	lw	a5,0(a5)
    80202a4e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:12 (discriminator 1)
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80202a50:	873e                	mv	a4,a5
    80202a52:	554d47b7          	lui	a5,0x554d4
    80202a56:	55178793          	addi	a5,a5,1361 # 554d4551 <n+0x554d4531>
    80202a5a:	00f70d63          	beq	a4,a5,80202a74 <virtio_disk_init+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:15
    {
        panic("could not find virtio disk\n");
    80202a5e:	00007617          	auipc	a2,0x7
    80202a62:	63a60613          	addi	a2,a2,1594 # 8020a098 <MMIO+0x10>
    80202a66:	45bd                	li	a1,15
    80202a68:	00007517          	auipc	a0,0x7
    80202a6c:	65050513          	addi	a0,a0,1616 # 8020a0b8 <MMIO+0x30>
    80202a70:	56d040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:18
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80202a74:	fe842783          	lw	a5,-24(s0)
    80202a78:	0017e793          	ori	a5,a5,1
    80202a7c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:19
    *R(VIRTIO_MMIO_STATUS) = status;
    80202a80:	100017b7          	lui	a5,0x10001
    80202a84:	07078793          	addi	a5,a5,112 # 10001070 <n+0x10001050>
    80202a88:	fe842703          	lw	a4,-24(s0)
    80202a8c:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:21

    status |= VIRTIO_CONFIG_S_DRIVER;
    80202a8e:	fe842783          	lw	a5,-24(s0)
    80202a92:	0027e793          	ori	a5,a5,2
    80202a96:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:22
    *R(VIRTIO_MMIO_STATUS) = status;
    80202a9a:	100017b7          	lui	a5,0x10001
    80202a9e:	07078793          	addi	a5,a5,112 # 10001070 <n+0x10001050>
    80202aa2:	fe842703          	lw	a4,-24(s0)
    80202aa6:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:25

    // negotiate features
    uint64_t features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80202aa8:	100017b7          	lui	a5,0x10001
    80202aac:	07c1                	addi	a5,a5,16
    80202aae:	439c                	lw	a5,0(a5)
    80202ab0:	2781                	sext.w	a5,a5
    80202ab2:	1782                	slli	a5,a5,0x20
    80202ab4:	9381                	srli	a5,a5,0x20
    80202ab6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:26
    features &= ~(1 << VIRTIO_BLK_F_RO);
    80202aba:	fe043783          	ld	a5,-32(s0)
    80202abe:	fdf7f793          	andi	a5,a5,-33
    80202ac2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:27
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80202ac6:	fe043783          	ld	a5,-32(s0)
    80202aca:	f7f7f793          	andi	a5,a5,-129
    80202ace:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:28
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80202ad2:	fe043703          	ld	a4,-32(s0)
    80202ad6:	77fd                	lui	a5,0xfffff
    80202ad8:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <ebss+0xffffffff7f2d17ff>
    80202adc:	8ff9                	and	a5,a5,a4
    80202ade:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:29
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    80202ae2:	fe043703          	ld	a4,-32(s0)
    80202ae6:	77fd                	lui	a5,0xfffff
    80202ae8:	17fd                	addi	a5,a5,-1
    80202aea:	8ff9                	and	a5,a5,a4
    80202aec:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:30
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80202af0:	fe043703          	ld	a4,-32(s0)
    80202af4:	f80007b7          	lui	a5,0xf8000
    80202af8:	17fd                	addi	a5,a5,-1
    80202afa:	8ff9                	and	a5,a5,a4
    80202afc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:31
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80202b00:	fe043703          	ld	a4,-32(s0)
    80202b04:	e00007b7          	lui	a5,0xe0000
    80202b08:	17fd                	addi	a5,a5,-1
    80202b0a:	8ff9                	and	a5,a5,a4
    80202b0c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:32
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80202b10:	fe043703          	ld	a4,-32(s0)
    80202b14:	f00007b7          	lui	a5,0xf0000
    80202b18:	17fd                	addi	a5,a5,-1
    80202b1a:	8ff9                	and	a5,a5,a4
    80202b1c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:33
    *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80202b20:	100017b7          	lui	a5,0x10001
    80202b24:	02078793          	addi	a5,a5,32 # 10001020 <n+0x10001000>
    80202b28:	fe043703          	ld	a4,-32(s0)
    80202b2c:	2701                	sext.w	a4,a4
    80202b2e:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:36

    // tell device that feature negotiation is complete.
    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80202b30:	fe842783          	lw	a5,-24(s0)
    80202b34:	0087e793          	ori	a5,a5,8
    80202b38:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:37
    *R(VIRTIO_MMIO_STATUS) = status;
    80202b3c:	100017b7          	lui	a5,0x10001
    80202b40:	07078793          	addi	a5,a5,112 # 10001070 <n+0x10001050>
    80202b44:	fe842703          	lw	a4,-24(s0)
    80202b48:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:40

    // tell device we're completely ready.
    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80202b4a:	fe842783          	lw	a5,-24(s0)
    80202b4e:	0047e793          	ori	a5,a5,4
    80202b52:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:41
    *R(VIRTIO_MMIO_STATUS) = status;
    80202b56:	100017b7          	lui	a5,0x10001
    80202b5a:	07078793          	addi	a5,a5,112 # 10001070 <n+0x10001050>
    80202b5e:	fe842703          	lw	a4,-24(s0)
    80202b62:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:43

    *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGE_SIZE;
    80202b64:	100017b7          	lui	a5,0x10001
    80202b68:	02878793          	addi	a5,a5,40 # 10001028 <n+0x10001008>
    80202b6c:	6705                	lui	a4,0x1
    80202b6e:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:46

    // initialize queue 0.
    *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80202b70:	100017b7          	lui	a5,0x10001
    80202b74:	03078793          	addi	a5,a5,48 # 10001030 <n+0x10001010>
    80202b78:	0007a023          	sw	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:47
    uint32_t max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80202b7c:	100017b7          	lui	a5,0x10001
    80202b80:	03478793          	addi	a5,a5,52 # 10001034 <n+0x10001014>
    80202b84:	439c                	lw	a5,0(a5)
    80202b86:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:48
    if (max == 0)
    80202b8a:	fdc42783          	lw	a5,-36(s0)
    80202b8e:	2781                	sext.w	a5,a5
    80202b90:	ef89                	bnez	a5,80202baa <virtio_disk_init+0x1aa>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:49
        panic("virtio disk has no queue 0\n");
    80202b92:	00007617          	auipc	a2,0x7
    80202b96:	53e60613          	addi	a2,a2,1342 # 8020a0d0 <MMIO+0x48>
    80202b9a:	03100593          	li	a1,49
    80202b9e:	00007517          	auipc	a0,0x7
    80202ba2:	51a50513          	addi	a0,a0,1306 # 8020a0b8 <MMIO+0x30>
    80202ba6:	437040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:50
    if (max < NUM)
    80202baa:	fdc42783          	lw	a5,-36(s0)
    80202bae:	0007871b          	sext.w	a4,a5
    80202bb2:	479d                	li	a5,7
    80202bb4:	00e7ee63          	bltu	a5,a4,80202bd0 <virtio_disk_init+0x1d0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:51
        panic("virtio disk max queue too short\n");
    80202bb8:	00007617          	auipc	a2,0x7
    80202bbc:	53860613          	addi	a2,a2,1336 # 8020a0f0 <MMIO+0x68>
    80202bc0:	03300593          	li	a1,51
    80202bc4:	00007517          	auipc	a0,0x7
    80202bc8:	4f450513          	addi	a0,a0,1268 # 8020a0b8 <MMIO+0x30>
    80202bcc:	411040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:52
    *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80202bd0:	100017b7          	lui	a5,0x10001
    80202bd4:	03878793          	addi	a5,a5,56 # 10001038 <n+0x10001018>
    80202bd8:	4721                	li	a4,8
    80202bda:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:53
    memset(disk.pages, 0, sizeof(disk.pages));
    80202bdc:	6609                	lui	a2,0x2
    80202bde:	4581                	li	a1,0
    80202be0:	00024517          	auipc	a0,0x24
    80202be4:	42050513          	addi	a0,a0,1056 # 80227000 <disk>
    80202be8:	455010ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:54
    *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64_t)disk.pages) >> PAGE_SHIFT;
    80202bec:	00024797          	auipc	a5,0x24
    80202bf0:	41478793          	addi	a5,a5,1044 # 80227000 <disk>
    80202bf4:	00c7d713          	srli	a4,a5,0xc
    80202bf8:	100017b7          	lui	a5,0x10001
    80202bfc:	04078793          	addi	a5,a5,64 # 10001040 <n+0x10001020>
    80202c00:	2701                	sext.w	a4,a4
    80202c02:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:56

    disk.desc = (struct virtq_desc *)disk.pages;
    80202c04:	00024717          	auipc	a4,0x24
    80202c08:	3fc70713          	addi	a4,a4,1020 # 80227000 <disk>
    80202c0c:	6789                	lui	a5,0x2
    80202c0e:	97ba                	add	a5,a5,a4
    80202c10:	00024717          	auipc	a4,0x24
    80202c14:	3f070713          	addi	a4,a4,1008 # 80227000 <disk>
    80202c18:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:58
    disk.avail =
        (struct virtq_avail *)(disk.pages + NUM * sizeof(struct virtq_desc));
    80202c1a:	00024717          	auipc	a4,0x24
    80202c1e:	46670713          	addi	a4,a4,1126 # 80227080 <disk+0x80>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:57
    disk.avail =
    80202c22:	00024697          	auipc	a3,0x24
    80202c26:	3de68693          	addi	a3,a3,990 # 80227000 <disk>
    80202c2a:	6789                	lui	a5,0x2
    80202c2c:	97b6                	add	a5,a5,a3
    80202c2e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:59
    disk.used = (struct virtq_used *)(disk.pages + PAGE_SIZE);
    80202c30:	00025717          	auipc	a4,0x25
    80202c34:	3d070713          	addi	a4,a4,976 # 80228000 <disk+0x1000>
    80202c38:	00024697          	auipc	a3,0x24
    80202c3c:	3c868693          	addi	a3,a3,968 # 80227000 <disk>
    80202c40:	6789                	lui	a5,0x2
    80202c42:	97b6                	add	a5,a5,a3
    80202c44:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:62

    // all NUM descriptors start out unused.
    for (int i = 0; i < NUM; i++)
    80202c46:	fe042623          	sw	zero,-20(s0)
    80202c4a:	a015                	j	80202c6e <virtio_disk_init+0x26e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:63 (discriminator 3)
        disk.free[i] = 1;
    80202c4c:	00024717          	auipc	a4,0x24
    80202c50:	3b470713          	addi	a4,a4,948 # 80227000 <disk>
    80202c54:	fec42783          	lw	a5,-20(s0)
    80202c58:	97ba                	add	a5,a5,a4
    80202c5a:	6709                	lui	a4,0x2
    80202c5c:	97ba                	add	a5,a5,a4
    80202c5e:	4705                	li	a4,1
    80202c60:	00e78c23          	sb	a4,24(a5) # 2018 <n+0x1ff8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:62 (discriminator 3)
    for (int i = 0; i < NUM; i++)
    80202c64:	fec42783          	lw	a5,-20(s0)
    80202c68:	2785                	addiw	a5,a5,1
    80202c6a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:62 (discriminator 1)
    80202c6e:	fec42783          	lw	a5,-20(s0)
    80202c72:	0007871b          	sext.w	a4,a5
    80202c76:	479d                	li	a5,7
    80202c78:	fce7dae3          	bge	a5,a4,80202c4c <virtio_disk_init+0x24c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:66

    // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80202c7c:	0001                	nop
    80202c7e:	0001                	nop
    80202c80:	70a2                	ld	ra,40(sp)
    80202c82:	7402                	ld	s0,32(sp)
    80202c84:	6145                	addi	sp,sp,48
    80202c86:	8082                	ret

0000000080202c88 <alloc3_desc>:
alloc3_desc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:68
int alloc3_desc(int *idx)
{
    80202c88:	7139                	addi	sp,sp,-64
    80202c8a:	fc06                	sd	ra,56(sp)
    80202c8c:	f822                	sd	s0,48(sp)
    80202c8e:	f426                	sd	s1,40(sp)
    80202c90:	0080                	addi	s0,sp,64
    80202c92:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:69
    for (int i = 0; i < 3; i++)
    80202c96:	fc042e23          	sw	zero,-36(s0)
    80202c9a:	a0b5                	j	80202d06 <alloc3_desc+0x7e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:71
    {
        idx[i] = alloc_desc();
    80202c9c:	fdc42783          	lw	a5,-36(s0)
    80202ca0:	078a                	slli	a5,a5,0x2
    80202ca2:	fc843703          	ld	a4,-56(s0)
    80202ca6:	00f704b3          	add	s1,a4,a5
    80202caa:	1da000ef          	jal	ra,80202e84 <alloc_desc>
    80202cae:	87aa                	mv	a5,a0
    80202cb0:	c09c                	sw	a5,0(s1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:72
        if (idx[i] < 0)
    80202cb2:	fdc42783          	lw	a5,-36(s0)
    80202cb6:	078a                	slli	a5,a5,0x2
    80202cb8:	fc843703          	ld	a4,-56(s0)
    80202cbc:	97ba                	add	a5,a5,a4
    80202cbe:	439c                	lw	a5,0(a5)
    80202cc0:	0207de63          	bgez	a5,80202cfc <alloc3_desc+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:74
        {
            for (int j = 0; j < i; j++)
    80202cc4:	fc042c23          	sw	zero,-40(s0)
    80202cc8:	a005                	j	80202ce8 <alloc3_desc+0x60>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:75 (discriminator 3)
                free_desc(idx[j]);
    80202cca:	fd842783          	lw	a5,-40(s0)
    80202cce:	078a                	slli	a5,a5,0x2
    80202cd0:	fc843703          	ld	a4,-56(s0)
    80202cd4:	97ba                	add	a5,a5,a4
    80202cd6:	439c                	lw	a5,0(a5)
    80202cd8:	853e                	mv	a0,a5
    80202cda:	0bc000ef          	jal	ra,80202d96 <free_desc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:74 (discriminator 3)
            for (int j = 0; j < i; j++)
    80202cde:	fd842783          	lw	a5,-40(s0)
    80202ce2:	2785                	addiw	a5,a5,1
    80202ce4:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:74 (discriminator 1)
    80202ce8:	fd842703          	lw	a4,-40(s0)
    80202cec:	fdc42783          	lw	a5,-36(s0)
    80202cf0:	2701                	sext.w	a4,a4
    80202cf2:	2781                	sext.w	a5,a5
    80202cf4:	fcf74be3          	blt	a4,a5,80202cca <alloc3_desc+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:76
            return -1;
    80202cf8:	57fd                	li	a5,-1
    80202cfa:	a831                	j	80202d16 <alloc3_desc+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:69 (discriminator 2)
    for (int i = 0; i < 3; i++)
    80202cfc:	fdc42783          	lw	a5,-36(s0)
    80202d00:	2785                	addiw	a5,a5,1
    80202d02:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:69 (discriminator 1)
    80202d06:	fdc42783          	lw	a5,-36(s0)
    80202d0a:	0007871b          	sext.w	a4,a5
    80202d0e:	4789                	li	a5,2
    80202d10:	f8e7d6e3          	bge	a5,a4,80202c9c <alloc3_desc+0x14>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:79
        }
    }
    return 0;
    80202d14:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:80
}
    80202d16:	853e                	mv	a0,a5
    80202d18:	70e2                	ld	ra,56(sp)
    80202d1a:	7442                	ld	s0,48(sp)
    80202d1c:	74a2                	ld	s1,40(sp)
    80202d1e:	6121                	addi	sp,sp,64
    80202d20:	8082                	ret

0000000080202d22 <free_chain>:
free_chain():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:83

void free_chain(int i)
{
    80202d22:	7179                	addi	sp,sp,-48
    80202d24:	f406                	sd	ra,40(sp)
    80202d26:	f022                	sd	s0,32(sp)
    80202d28:	1800                	addi	s0,sp,48
    80202d2a:	87aa                	mv	a5,a0
    80202d2c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:86
    while (1)
    {
        int flag = disk.desc[i].flags;
    80202d30:	00024717          	auipc	a4,0x24
    80202d34:	2d070713          	addi	a4,a4,720 # 80227000 <disk>
    80202d38:	6789                	lui	a5,0x2
    80202d3a:	97ba                	add	a5,a5,a4
    80202d3c:	6398                	ld	a4,0(a5)
    80202d3e:	fdc42783          	lw	a5,-36(s0)
    80202d42:	0792                	slli	a5,a5,0x4
    80202d44:	97ba                	add	a5,a5,a4
    80202d46:	00c7d783          	lhu	a5,12(a5) # 200c <n+0x1fec>
    80202d4a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:87
        int nxt = disk.desc[i].next;
    80202d4e:	00024717          	auipc	a4,0x24
    80202d52:	2b270713          	addi	a4,a4,690 # 80227000 <disk>
    80202d56:	6789                	lui	a5,0x2
    80202d58:	97ba                	add	a5,a5,a4
    80202d5a:	6398                	ld	a4,0(a5)
    80202d5c:	fdc42783          	lw	a5,-36(s0)
    80202d60:	0792                	slli	a5,a5,0x4
    80202d62:	97ba                	add	a5,a5,a4
    80202d64:	00e7d783          	lhu	a5,14(a5) # 200e <n+0x1fee>
    80202d68:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:88
        free_desc(i);
    80202d6c:	fdc42783          	lw	a5,-36(s0)
    80202d70:	853e                	mv	a0,a5
    80202d72:	024000ef          	jal	ra,80202d96 <free_desc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:89
        if (flag & VRING_DESC_F_NEXT)
    80202d76:	fec42783          	lw	a5,-20(s0)
    80202d7a:	8b85                	andi	a5,a5,1
    80202d7c:	2781                	sext.w	a5,a5
    80202d7e:	c791                	beqz	a5,80202d8a <free_chain+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:90
            i = nxt;
    80202d80:	fe842783          	lw	a5,-24(s0)
    80202d84:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:85
    {
    80202d88:	b765                	j	80202d30 <free_chain+0xe>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:92
        else
            break;
    80202d8a:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:94
    }
}
    80202d8c:	0001                	nop
    80202d8e:	70a2                	ld	ra,40(sp)
    80202d90:	7402                	ld	s0,32(sp)
    80202d92:	6145                	addi	sp,sp,48
    80202d94:	8082                	ret

0000000080202d96 <free_desc>:
free_desc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:97

void free_desc(int i)
{
    80202d96:	1101                	addi	sp,sp,-32
    80202d98:	ec06                	sd	ra,24(sp)
    80202d9a:	e822                	sd	s0,16(sp)
    80202d9c:	1000                	addi	s0,sp,32
    80202d9e:	87aa                	mv	a5,a0
    80202da0:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:98
    if (i >= NUM)
    80202da4:	fec42783          	lw	a5,-20(s0)
    80202da8:	0007871b          	sext.w	a4,a5
    80202dac:	479d                	li	a5,7
    80202dae:	00e7de63          	bge	a5,a4,80202dca <free_desc+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:99
        panic("free_desc 1\n");
    80202db2:	00007617          	auipc	a2,0x7
    80202db6:	36660613          	addi	a2,a2,870 # 8020a118 <MMIO+0x90>
    80202dba:	06300593          	li	a1,99
    80202dbe:	00007517          	auipc	a0,0x7
    80202dc2:	2fa50513          	addi	a0,a0,762 # 8020a0b8 <MMIO+0x30>
    80202dc6:	217040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:100
    if (disk.free[i])
    80202dca:	00024717          	auipc	a4,0x24
    80202dce:	23670713          	addi	a4,a4,566 # 80227000 <disk>
    80202dd2:	fec42783          	lw	a5,-20(s0)
    80202dd6:	97ba                	add	a5,a5,a4
    80202dd8:	6709                	lui	a4,0x2
    80202dda:	97ba                	add	a5,a5,a4
    80202ddc:	0187c783          	lbu	a5,24(a5)
    80202de0:	cf89                	beqz	a5,80202dfa <free_desc+0x64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:101
        panic("free_desc 2\n");
    80202de2:	00007617          	auipc	a2,0x7
    80202de6:	34660613          	addi	a2,a2,838 # 8020a128 <MMIO+0xa0>
    80202dea:	06500593          	li	a1,101
    80202dee:	00007517          	auipc	a0,0x7
    80202df2:	2ca50513          	addi	a0,a0,714 # 8020a0b8 <MMIO+0x30>
    80202df6:	1e7040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:102
    disk.desc[i].addr = 0;
    80202dfa:	00024717          	auipc	a4,0x24
    80202dfe:	20670713          	addi	a4,a4,518 # 80227000 <disk>
    80202e02:	6789                	lui	a5,0x2
    80202e04:	97ba                	add	a5,a5,a4
    80202e06:	6398                	ld	a4,0(a5)
    80202e08:	fec42783          	lw	a5,-20(s0)
    80202e0c:	0792                	slli	a5,a5,0x4
    80202e0e:	97ba                	add	a5,a5,a4
    80202e10:	0007b023          	sd	zero,0(a5) # 2000 <n+0x1fe0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:103
    disk.desc[i].len = 0;
    80202e14:	00024717          	auipc	a4,0x24
    80202e18:	1ec70713          	addi	a4,a4,492 # 80227000 <disk>
    80202e1c:	6789                	lui	a5,0x2
    80202e1e:	97ba                	add	a5,a5,a4
    80202e20:	6398                	ld	a4,0(a5)
    80202e22:	fec42783          	lw	a5,-20(s0)
    80202e26:	0792                	slli	a5,a5,0x4
    80202e28:	97ba                	add	a5,a5,a4
    80202e2a:	0007a423          	sw	zero,8(a5) # 2008 <n+0x1fe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:104
    disk.desc[i].flags = 0;
    80202e2e:	00024717          	auipc	a4,0x24
    80202e32:	1d270713          	addi	a4,a4,466 # 80227000 <disk>
    80202e36:	6789                	lui	a5,0x2
    80202e38:	97ba                	add	a5,a5,a4
    80202e3a:	6398                	ld	a4,0(a5)
    80202e3c:	fec42783          	lw	a5,-20(s0)
    80202e40:	0792                	slli	a5,a5,0x4
    80202e42:	97ba                	add	a5,a5,a4
    80202e44:	00079623          	sh	zero,12(a5) # 200c <n+0x1fec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:105
    disk.desc[i].next = 0;
    80202e48:	00024717          	auipc	a4,0x24
    80202e4c:	1b870713          	addi	a4,a4,440 # 80227000 <disk>
    80202e50:	6789                	lui	a5,0x2
    80202e52:	97ba                	add	a5,a5,a4
    80202e54:	6398                	ld	a4,0(a5)
    80202e56:	fec42783          	lw	a5,-20(s0)
    80202e5a:	0792                	slli	a5,a5,0x4
    80202e5c:	97ba                	add	a5,a5,a4
    80202e5e:	00079723          	sh	zero,14(a5) # 200e <n+0x1fee>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:106
    disk.free[i] = 1;
    80202e62:	00024717          	auipc	a4,0x24
    80202e66:	19e70713          	addi	a4,a4,414 # 80227000 <disk>
    80202e6a:	fec42783          	lw	a5,-20(s0)
    80202e6e:	97ba                	add	a5,a5,a4
    80202e70:	6709                	lui	a4,0x2
    80202e72:	97ba                	add	a5,a5,a4
    80202e74:	4705                	li	a4,1
    80202e76:	00e78c23          	sb	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:107
}
    80202e7a:	0001                	nop
    80202e7c:	60e2                	ld	ra,24(sp)
    80202e7e:	6442                	ld	s0,16(sp)
    80202e80:	6105                	addi	sp,sp,32
    80202e82:	8082                	ret

0000000080202e84 <alloc_desc>:
alloc_desc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:110

int alloc_desc()
{
    80202e84:	1101                	addi	sp,sp,-32
    80202e86:	ec22                	sd	s0,24(sp)
    80202e88:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:111
    for (int i = 0; i < NUM; i++)
    80202e8a:	fe042623          	sw	zero,-20(s0)
    80202e8e:	a081                	j	80202ece <alloc_desc+0x4a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:113
    {
        if (disk.free[i])
    80202e90:	00024717          	auipc	a4,0x24
    80202e94:	17070713          	addi	a4,a4,368 # 80227000 <disk>
    80202e98:	fec42783          	lw	a5,-20(s0)
    80202e9c:	97ba                	add	a5,a5,a4
    80202e9e:	6709                	lui	a4,0x2
    80202ea0:	97ba                	add	a5,a5,a4
    80202ea2:	0187c783          	lbu	a5,24(a5)
    80202ea6:	cf99                	beqz	a5,80202ec4 <alloc_desc+0x40>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:115
        {
            disk.free[i] = 0;
    80202ea8:	00024717          	auipc	a4,0x24
    80202eac:	15870713          	addi	a4,a4,344 # 80227000 <disk>
    80202eb0:	fec42783          	lw	a5,-20(s0)
    80202eb4:	97ba                	add	a5,a5,a4
    80202eb6:	6709                	lui	a4,0x2
    80202eb8:	97ba                	add	a5,a5,a4
    80202eba:	00078c23          	sb	zero,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:116
            return i;
    80202ebe:	fec42783          	lw	a5,-20(s0)
    80202ec2:	a831                	j	80202ede <alloc_desc+0x5a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:111 (discriminator 2)
    for (int i = 0; i < NUM; i++)
    80202ec4:	fec42783          	lw	a5,-20(s0)
    80202ec8:	2785                	addiw	a5,a5,1
    80202eca:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:111 (discriminator 1)
    80202ece:	fec42783          	lw	a5,-20(s0)
    80202ed2:	0007871b          	sext.w	a4,a5
    80202ed6:	479d                	li	a5,7
    80202ed8:	fae7dce3          	bge	a5,a4,80202e90 <alloc_desc+0xc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:119
        }
    }
    return -1;
    80202edc:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:120
}
    80202ede:	853e                	mv	a0,a5
    80202ee0:	6462                	ld	s0,24(sp)
    80202ee2:	6105                	addi	sp,sp,32
    80202ee4:	8082                	ret

0000000080202ee6 <virtio_disk_rw>:
virtio_disk_rw():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:123

void virtio_disk_rw(BlockCache *b, int write)
{
    80202ee6:	715d                	addi	sp,sp,-80
    80202ee8:	e486                	sd	ra,72(sp)
    80202eea:	e0a2                	sd	s0,64(sp)
    80202eec:	0880                	addi	s0,sp,80
    80202eee:	faa43c23          	sd	a0,-72(s0)
    80202ef2:	87ae                	mv	a5,a1
    80202ef4:	faf42a23          	sw	a5,-76(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:124
    printk("virtio_disk_rw_start\n");
    80202ef8:	00007517          	auipc	a0,0x7
    80202efc:	24050513          	addi	a0,a0,576 # 8020a138 <MMIO+0xb0>
    80202f00:	8ebff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:125
    uint64_t sector = b->block_id * (BLOCK_SZ / 512);
    80202f04:	fb843783          	ld	a5,-72(s0)
    80202f08:	2007b783          	ld	a5,512(a5)
    80202f0c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:129
    int idx[3];
    while (1)
    {
        if (alloc3_desc(idx) == 0)
    80202f10:	fc840793          	addi	a5,s0,-56
    80202f14:	853e                	mv	a0,a5
    80202f16:	d73ff0ef          	jal	ra,80202c88 <alloc3_desc>
    80202f1a:	87aa                	mv	a5,a0
    80202f1c:	c391                	beqz	a5,80202f20 <virtio_disk_rw+0x3a>
    80202f1e:	bfcd                	j	80202f10 <virtio_disk_rw+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:131
        {
            break;
    80202f20:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:134
        }
    }
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80202f22:	fc842783          	lw	a5,-56(s0)
    80202f26:	20078793          	addi	a5,a5,512
    80202f2a:	00479713          	slli	a4,a5,0x4
    80202f2e:	00024797          	auipc	a5,0x24
    80202f32:	0d278793          	addi	a5,a5,210 # 80227000 <disk>
    80202f36:	97ba                	add	a5,a5,a4
    80202f38:	0a878793          	addi	a5,a5,168
    80202f3c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:136

    if (write)
    80202f40:	fb442783          	lw	a5,-76(s0)
    80202f44:	2781                	sext.w	a5,a5
    80202f46:	c791                	beqz	a5,80202f52 <virtio_disk_rw+0x6c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:137
        buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80202f48:	fe043783          	ld	a5,-32(s0)
    80202f4c:	4705                	li	a4,1
    80202f4e:	c398                	sw	a4,0(a5)
    80202f50:	a029                	j	80202f5a <virtio_disk_rw+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:139
    else
        buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80202f52:	fe043783          	ld	a5,-32(s0)
    80202f56:	0007a023          	sw	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:140
    buf0->reserved = 0;
    80202f5a:	fe043783          	ld	a5,-32(s0)
    80202f5e:	0007a223          	sw	zero,4(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:141
    buf0->sector = sector;
    80202f62:	fe043783          	ld	a5,-32(s0)
    80202f66:	fe843703          	ld	a4,-24(s0)
    80202f6a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:143

    disk.desc[idx[0]].addr = (uint64_t)buf0;
    80202f6c:	00024717          	auipc	a4,0x24
    80202f70:	09470713          	addi	a4,a4,148 # 80227000 <disk>
    80202f74:	6789                	lui	a5,0x2
    80202f76:	97ba                	add	a5,a5,a4
    80202f78:	6398                	ld	a4,0(a5)
    80202f7a:	fc842783          	lw	a5,-56(s0)
    80202f7e:	0792                	slli	a5,a5,0x4
    80202f80:	97ba                	add	a5,a5,a4
    80202f82:	fe043703          	ld	a4,-32(s0)
    80202f86:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:144
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80202f88:	00024717          	auipc	a4,0x24
    80202f8c:	07870713          	addi	a4,a4,120 # 80227000 <disk>
    80202f90:	6789                	lui	a5,0x2
    80202f92:	97ba                	add	a5,a5,a4
    80202f94:	6398                	ld	a4,0(a5)
    80202f96:	fc842783          	lw	a5,-56(s0)
    80202f9a:	0792                	slli	a5,a5,0x4
    80202f9c:	97ba                	add	a5,a5,a4
    80202f9e:	4741                	li	a4,16
    80202fa0:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:145
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80202fa2:	00024717          	auipc	a4,0x24
    80202fa6:	05e70713          	addi	a4,a4,94 # 80227000 <disk>
    80202faa:	6789                	lui	a5,0x2
    80202fac:	97ba                	add	a5,a5,a4
    80202fae:	6398                	ld	a4,0(a5)
    80202fb0:	fc842783          	lw	a5,-56(s0)
    80202fb4:	0792                	slli	a5,a5,0x4
    80202fb6:	97ba                	add	a5,a5,a4
    80202fb8:	4705                	li	a4,1
    80202fba:	00e79623          	sh	a4,12(a5) # 200c <n+0x1fec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:146
    disk.desc[idx[0]].next = idx[1];
    80202fbe:	fcc42683          	lw	a3,-52(s0)
    80202fc2:	00024717          	auipc	a4,0x24
    80202fc6:	03e70713          	addi	a4,a4,62 # 80227000 <disk>
    80202fca:	6789                	lui	a5,0x2
    80202fcc:	97ba                	add	a5,a5,a4
    80202fce:	6398                	ld	a4,0(a5)
    80202fd0:	fc842783          	lw	a5,-56(s0)
    80202fd4:	0792                	slli	a5,a5,0x4
    80202fd6:	97ba                	add	a5,a5,a4
    80202fd8:	03069713          	slli	a4,a3,0x30
    80202fdc:	9341                	srli	a4,a4,0x30
    80202fde:	00e79723          	sh	a4,14(a5) # 200e <n+0x1fee>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:148

    disk.desc[idx[1]].addr = (uint64_t)b->cache;
    80202fe2:	fb843683          	ld	a3,-72(s0)
    80202fe6:	00024717          	auipc	a4,0x24
    80202fea:	01a70713          	addi	a4,a4,26 # 80227000 <disk>
    80202fee:	6789                	lui	a5,0x2
    80202ff0:	97ba                	add	a5,a5,a4
    80202ff2:	6398                	ld	a4,0(a5)
    80202ff4:	fcc42783          	lw	a5,-52(s0)
    80202ff8:	0792                	slli	a5,a5,0x4
    80202ffa:	97ba                	add	a5,a5,a4
    80202ffc:	8736                	mv	a4,a3
    80202ffe:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:149
    disk.desc[idx[1]].len = BLOCK_SZ;
    80203000:	00024717          	auipc	a4,0x24
    80203004:	00070713          	mv	a4,a4
    80203008:	6789                	lui	a5,0x2
    8020300a:	97ba                	add	a5,a5,a4
    8020300c:	6398                	ld	a4,0(a5)
    8020300e:	fcc42783          	lw	a5,-52(s0)
    80203012:	0792                	slli	a5,a5,0x4
    80203014:	97ba                	add	a5,a5,a4
    80203016:	20000713          	li	a4,512
    8020301a:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:150
    if (write)
    8020301c:	fb442783          	lw	a5,-76(s0)
    80203020:	2781                	sext.w	a5,a5
    80203022:	cf99                	beqz	a5,80203040 <virtio_disk_rw+0x15a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:151
        disk.desc[idx[1]].flags = 0; // device reads b->cache
    80203024:	00024717          	auipc	a4,0x24
    80203028:	fdc70713          	addi	a4,a4,-36 # 80227000 <disk>
    8020302c:	6789                	lui	a5,0x2
    8020302e:	97ba                	add	a5,a5,a4
    80203030:	6398                	ld	a4,0(a5)
    80203032:	fcc42783          	lw	a5,-52(s0)
    80203036:	0792                	slli	a5,a5,0x4
    80203038:	97ba                	add	a5,a5,a4
    8020303a:	00079623          	sh	zero,12(a5) # 200c <n+0x1fec>
    8020303e:	a839                	j	8020305c <virtio_disk_rw+0x176>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:153
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->cache
    80203040:	00024717          	auipc	a4,0x24
    80203044:	fc070713          	addi	a4,a4,-64 # 80227000 <disk>
    80203048:	6789                	lui	a5,0x2
    8020304a:	97ba                	add	a5,a5,a4
    8020304c:	6398                	ld	a4,0(a5)
    8020304e:	fcc42783          	lw	a5,-52(s0)
    80203052:	0792                	slli	a5,a5,0x4
    80203054:	97ba                	add	a5,a5,a4
    80203056:	4709                	li	a4,2
    80203058:	00e79623          	sh	a4,12(a5) # 200c <n+0x1fec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:154
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8020305c:	00024717          	auipc	a4,0x24
    80203060:	fa470713          	addi	a4,a4,-92 # 80227000 <disk>
    80203064:	6789                	lui	a5,0x2
    80203066:	97ba                	add	a5,a5,a4
    80203068:	6398                	ld	a4,0(a5)
    8020306a:	fcc42783          	lw	a5,-52(s0)
    8020306e:	0792                	slli	a5,a5,0x4
    80203070:	97ba                	add	a5,a5,a4
    80203072:	00c7d703          	lhu	a4,12(a5) # 200c <n+0x1fec>
    80203076:	00024697          	auipc	a3,0x24
    8020307a:	f8a68693          	addi	a3,a3,-118 # 80227000 <disk>
    8020307e:	6789                	lui	a5,0x2
    80203080:	97b6                	add	a5,a5,a3
    80203082:	6394                	ld	a3,0(a5)
    80203084:	fcc42783          	lw	a5,-52(s0)
    80203088:	0792                	slli	a5,a5,0x4
    8020308a:	97b6                	add	a5,a5,a3
    8020308c:	00176713          	ori	a4,a4,1
    80203090:	1742                	slli	a4,a4,0x30
    80203092:	9341                	srli	a4,a4,0x30
    80203094:	00e79623          	sh	a4,12(a5) # 200c <n+0x1fec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:155
    disk.desc[idx[1]].next = idx[2];
    80203098:	fd042683          	lw	a3,-48(s0)
    8020309c:	00024717          	auipc	a4,0x24
    802030a0:	f6470713          	addi	a4,a4,-156 # 80227000 <disk>
    802030a4:	6789                	lui	a5,0x2
    802030a6:	97ba                	add	a5,a5,a4
    802030a8:	6398                	ld	a4,0(a5)
    802030aa:	fcc42783          	lw	a5,-52(s0)
    802030ae:	0792                	slli	a5,a5,0x4
    802030b0:	97ba                	add	a5,a5,a4
    802030b2:	03069713          	slli	a4,a3,0x30
    802030b6:	9341                	srli	a4,a4,0x30
    802030b8:	00e79723          	sh	a4,14(a5) # 200e <n+0x1fee>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:157

    disk.info[idx[2]].status = 0xfb; // device writes 0 on success
    802030bc:	fd042783          	lw	a5,-48(s0)
    802030c0:	00024717          	auipc	a4,0x24
    802030c4:	f4070713          	addi	a4,a4,-192 # 80227000 <disk>
    802030c8:	20078793          	addi	a5,a5,512
    802030cc:	0792                	slli	a5,a5,0x4
    802030ce:	97ba                	add	a5,a5,a4
    802030d0:	576d                	li	a4,-5
    802030d2:	02e78823          	sb	a4,48(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:158
    disk.desc[idx[2]].addr = (uint64_t)&disk.info[idx[0]].status;
    802030d6:	fc842783          	lw	a5,-56(s0)
    802030da:	20078793          	addi	a5,a5,512
    802030de:	00479713          	slli	a4,a5,0x4
    802030e2:	00024797          	auipc	a5,0x24
    802030e6:	f1e78793          	addi	a5,a5,-226 # 80227000 <disk>
    802030ea:	97ba                	add	a5,a5,a4
    802030ec:	03078693          	addi	a3,a5,48
    802030f0:	00024717          	auipc	a4,0x24
    802030f4:	f1070713          	addi	a4,a4,-240 # 80227000 <disk>
    802030f8:	6789                	lui	a5,0x2
    802030fa:	97ba                	add	a5,a5,a4
    802030fc:	6398                	ld	a4,0(a5)
    802030fe:	fd042783          	lw	a5,-48(s0)
    80203102:	0792                	slli	a5,a5,0x4
    80203104:	97ba                	add	a5,a5,a4
    80203106:	8736                	mv	a4,a3
    80203108:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:159
    disk.desc[idx[2]].len = 1;
    8020310a:	00024717          	auipc	a4,0x24
    8020310e:	ef670713          	addi	a4,a4,-266 # 80227000 <disk>
    80203112:	6789                	lui	a5,0x2
    80203114:	97ba                	add	a5,a5,a4
    80203116:	6398                	ld	a4,0(a5)
    80203118:	fd042783          	lw	a5,-48(s0)
    8020311c:	0792                	slli	a5,a5,0x4
    8020311e:	97ba                	add	a5,a5,a4
    80203120:	4705                	li	a4,1
    80203122:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:160
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80203124:	00024717          	auipc	a4,0x24
    80203128:	edc70713          	addi	a4,a4,-292 # 80227000 <disk>
    8020312c:	6789                	lui	a5,0x2
    8020312e:	97ba                	add	a5,a5,a4
    80203130:	6398                	ld	a4,0(a5)
    80203132:	fd042783          	lw	a5,-48(s0)
    80203136:	0792                	slli	a5,a5,0x4
    80203138:	97ba                	add	a5,a5,a4
    8020313a:	4709                	li	a4,2
    8020313c:	00e79623          	sh	a4,12(a5) # 200c <n+0x1fec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:161
    disk.desc[idx[2]].next = 0;
    80203140:	00024717          	auipc	a4,0x24
    80203144:	ec070713          	addi	a4,a4,-320 # 80227000 <disk>
    80203148:	6789                	lui	a5,0x2
    8020314a:	97ba                	add	a5,a5,a4
    8020314c:	6398                	ld	a4,0(a5)
    8020314e:	fd042783          	lw	a5,-48(s0)
    80203152:	0792                	slli	a5,a5,0x4
    80203154:	97ba                	add	a5,a5,a4
    80203156:	00079723          	sh	zero,14(a5) # 200e <n+0x1fee>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:163

    b->disk = true;
    8020315a:	fb843783          	ld	a5,-72(s0)
    8020315e:	4705                	li	a4,1
    80203160:	20e7a823          	sw	a4,528(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:164
    disk.info[idx[0]].b = b;
    80203164:	fc842783          	lw	a5,-56(s0)
    80203168:	00024717          	auipc	a4,0x24
    8020316c:	e9870713          	addi	a4,a4,-360 # 80227000 <disk>
    80203170:	20078793          	addi	a5,a5,512
    80203174:	0792                	slli	a5,a5,0x4
    80203176:	97ba                	add	a5,a5,a4
    80203178:	fb843703          	ld	a4,-72(s0)
    8020317c:	f798                	sd	a4,40(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:166

    disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    8020317e:	fc842603          	lw	a2,-56(s0)
    80203182:	00024717          	auipc	a4,0x24
    80203186:	e7e70713          	addi	a4,a4,-386 # 80227000 <disk>
    8020318a:	6789                	lui	a5,0x2
    8020318c:	97ba                	add	a5,a5,a4
    8020318e:	6794                	ld	a3,8(a5)
    80203190:	00024717          	auipc	a4,0x24
    80203194:	e7070713          	addi	a4,a4,-400 # 80227000 <disk>
    80203198:	6789                	lui	a5,0x2
    8020319a:	97ba                	add	a5,a5,a4
    8020319c:	679c                	ld	a5,8(a5)
    8020319e:	0027d783          	lhu	a5,2(a5) # 2002 <n+0x1fe2>
    802031a2:	2781                	sext.w	a5,a5
    802031a4:	8b9d                	andi	a5,a5,7
    802031a6:	2781                	sext.w	a5,a5
    802031a8:	03061713          	slli	a4,a2,0x30
    802031ac:	9341                	srli	a4,a4,0x30
    802031ae:	0786                	slli	a5,a5,0x1
    802031b0:	97b6                	add	a5,a5,a3
    802031b2:	00e79223          	sh	a4,4(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:168

    __sync_synchronize();
    802031b6:	0ff0000f          	fence
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:171

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM
    802031ba:	00024717          	auipc	a4,0x24
    802031be:	e4670713          	addi	a4,a4,-442 # 80227000 <disk>
    802031c2:	6789                	lui	a5,0x2
    802031c4:	97ba                	add	a5,a5,a4
    802031c6:	679c                	ld	a5,8(a5)
    802031c8:	0027d703          	lhu	a4,2(a5) # 2002 <n+0x1fe2>
    802031cc:	00024697          	auipc	a3,0x24
    802031d0:	e3468693          	addi	a3,a3,-460 # 80227000 <disk>
    802031d4:	6789                	lui	a5,0x2
    802031d6:	97b6                	add	a5,a5,a3
    802031d8:	679c                	ld	a5,8(a5)
    802031da:	2705                	addiw	a4,a4,1
    802031dc:	1742                	slli	a4,a4,0x30
    802031de:	9341                	srli	a4,a4,0x30
    802031e0:	00e79123          	sh	a4,2(a5) # 2002 <n+0x1fe2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:173

    __sync_synchronize();
    802031e4:	0ff0000f          	fence
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:175

    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    802031e8:	100017b7          	lui	a5,0x10001
    802031ec:	05078793          	addi	a5,a5,80 # 10001050 <n+0x10001030>
    802031f0:	0007a023          	sw	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:178

    // Wait for virtio_disk_intr() to say request has finished.
    BlockCache volatile *_b = b; // Make sure complier will load 'b' form memory
    802031f4:	fb843783          	ld	a5,-72(s0)
    802031f8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:179
    intr_on();
    802031fc:	fc2ff0ef          	jal	ra,802029be <intr_on>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:180
    while (_b->disk)
    80203200:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:180 (discriminator 1)
    80203202:	fd843783          	ld	a5,-40(s0)
    80203206:	2107a783          	lw	a5,528(a5)
    8020320a:	2781                	sext.w	a5,a5
    8020320c:	fbfd                	bnez	a5,80203202 <virtio_disk_rw+0x31c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:184
    {
        // printk("123");
    }
    intr_off();
    8020320e:	fd2ff0ef          	jal	ra,802029e0 <intr_off>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:185
    disk.info[idx[0]].b = 0;
    80203212:	fc842783          	lw	a5,-56(s0)
    80203216:	00024717          	auipc	a4,0x24
    8020321a:	dea70713          	addi	a4,a4,-534 # 80227000 <disk>
    8020321e:	20078793          	addi	a5,a5,512
    80203222:	0792                	slli	a5,a5,0x4
    80203224:	97ba                	add	a5,a5,a4
    80203226:	0207b423          	sd	zero,40(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:186
    free_chain(idx[0]);
    8020322a:	fc842783          	lw	a5,-56(s0)
    8020322e:	853e                	mv	a0,a5
    80203230:	af3ff0ef          	jal	ra,80202d22 <free_chain>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:187
}
    80203234:	0001                	nop
    80203236:	60a6                	ld	ra,72(sp)
    80203238:	6406                	ld	s0,64(sp)
    8020323a:	6161                	addi	sp,sp,80
    8020323c:	8082                	ret

000000008020323e <virtio_read_block>:
virtio_read_block():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:189

void virtio_read_block(BlockCache *b) { virtio_disk_rw(b, 0); }
    8020323e:	1101                	addi	sp,sp,-32
    80203240:	ec06                	sd	ra,24(sp)
    80203242:	e822                	sd	s0,16(sp)
    80203244:	1000                	addi	s0,sp,32
    80203246:	fea43423          	sd	a0,-24(s0)
    8020324a:	4581                	li	a1,0
    8020324c:	fe843503          	ld	a0,-24(s0)
    80203250:	c97ff0ef          	jal	ra,80202ee6 <virtio_disk_rw>
    80203254:	0001                	nop
    80203256:	60e2                	ld	ra,24(sp)
    80203258:	6442                	ld	s0,16(sp)
    8020325a:	6105                	addi	sp,sp,32
    8020325c:	8082                	ret

000000008020325e <virtio_write_block>:
virtio_write_block():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:191

void virtio_write_block(BlockCache *b) { virtio_disk_rw(b, 1); }
    8020325e:	1101                	addi	sp,sp,-32
    80203260:	ec06                	sd	ra,24(sp)
    80203262:	e822                	sd	s0,16(sp)
    80203264:	1000                	addi	s0,sp,32
    80203266:	fea43423          	sd	a0,-24(s0)
    8020326a:	4585                	li	a1,1
    8020326c:	fe843503          	ld	a0,-24(s0)
    80203270:	c77ff0ef          	jal	ra,80202ee6 <virtio_disk_rw>
    80203274:	0001                	nop
    80203276:	60e2                	ld	ra,24(sp)
    80203278:	6442                	ld	s0,16(sp)
    8020327a:	6105                	addi	sp,sp,32
    8020327c:	8082                	ret

000000008020327e <virtio_block_device_init>:
virtio_block_device_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:194

BlockDevice *virtio_block_device_init()
{
    8020327e:	1141                	addi	sp,sp,-16
    80203280:	e406                	sd	ra,8(sp)
    80203282:	e022                	sd	s0,0(sp)
    80203284:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:195
    printk("virtio_block_device_init_start\n");
    80203286:	00007517          	auipc	a0,0x7
    8020328a:	eca50513          	addi	a0,a0,-310 # 8020a150 <MMIO+0xc8>
    8020328e:	d5cff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:196
    virtio_disk_init();
    80203292:	f6eff0ef          	jal	ra,80202a00 <virtio_disk_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:197
    BLOCK_DEVICE.read_block = virtio_read_block;
    80203296:	00023797          	auipc	a5,0x23
    8020329a:	d6a78793          	addi	a5,a5,-662 # 80226000 <BLOCK_DEVICE>
    8020329e:	00000717          	auipc	a4,0x0
    802032a2:	fa070713          	addi	a4,a4,-96 # 8020323e <virtio_read_block>
    802032a6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:198
    BLOCK_DEVICE.write_block = virtio_write_block;
    802032a8:	00023797          	auipc	a5,0x23
    802032ac:	d5878793          	addi	a5,a5,-680 # 80226000 <BLOCK_DEVICE>
    802032b0:	00000717          	auipc	a4,0x0
    802032b4:	fae70713          	addi	a4,a4,-82 # 8020325e <virtio_write_block>
    802032b8:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:199
    return &BLOCK_DEVICE;
    802032ba:	00023797          	auipc	a5,0x23
    802032be:	d4678793          	addi	a5,a5,-698 # 80226000 <BLOCK_DEVICE>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:200
}
    802032c2:	853e                	mv	a0,a5
    802032c4:	60a2                	ld	ra,8(sp)
    802032c6:	6402                	ld	s0,0(sp)
    802032c8:	0141                	addi	sp,sp,16
    802032ca:	8082                	ret

00000000802032cc <virtio_disk_intr>:
virtio_disk_intr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:203

void virtio_disk_intr()
{
    802032cc:	1101                	addi	sp,sp,-32
    802032ce:	ec06                	sd	ra,24(sp)
    802032d0:	e822                	sd	s0,16(sp)
    802032d2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:210
    // we've seen this interrupt, which the following line does.
    // this may race with the device writing new entries to
    // the "used" ring, in which case we may process the new
    // completion entries in this interrupt, and have nothing to do
    // in the next interrupt, which is harmless.
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    802032d4:	100017b7          	lui	a5,0x10001
    802032d8:	06078793          	addi	a5,a5,96 # 10001060 <n+0x10001040>
    802032dc:	439c                	lw	a5,0(a5)
    802032de:	0007871b          	sext.w	a4,a5
    802032e2:	100017b7          	lui	a5,0x10001
    802032e6:	06478793          	addi	a5,a5,100 # 10001064 <n+0x10001044>
    802032ea:	8b0d                	andi	a4,a4,3
    802032ec:	2701                	sext.w	a4,a4
    802032ee:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:212

    __sync_synchronize();
    802032f0:	0ff0000f          	fence
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:217

    // the device increments disk.used->idx when it
    // adds an entry to the used ring.

    while (disk.used_idx != disk.used->idx)
    802032f4:	a845                	j	802033a4 <virtio_disk_intr+0xd8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:219
    {
        __sync_synchronize();
    802032f6:	0ff0000f          	fence
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:220
        int id = disk.used->ring[disk.used_idx % NUM].id;
    802032fa:	00024717          	auipc	a4,0x24
    802032fe:	d0670713          	addi	a4,a4,-762 # 80227000 <disk>
    80203302:	6789                	lui	a5,0x2
    80203304:	97ba                	add	a5,a5,a4
    80203306:	6b98                	ld	a4,16(a5)
    80203308:	00024697          	auipc	a3,0x24
    8020330c:	cf868693          	addi	a3,a3,-776 # 80227000 <disk>
    80203310:	6789                	lui	a5,0x2
    80203312:	97b6                	add	a5,a5,a3
    80203314:	0207d783          	lhu	a5,32(a5) # 2020 <n+0x2000>
    80203318:	2781                	sext.w	a5,a5
    8020331a:	8b9d                	andi	a5,a5,7
    8020331c:	2781                	sext.w	a5,a5
    8020331e:	078e                	slli	a5,a5,0x3
    80203320:	97ba                	add	a5,a5,a4
    80203322:	43dc                	lw	a5,4(a5)
    80203324:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:222

        if (disk.info[id].status != 0)
    80203328:	00024717          	auipc	a4,0x24
    8020332c:	cd870713          	addi	a4,a4,-808 # 80227000 <disk>
    80203330:	fec42783          	lw	a5,-20(s0)
    80203334:	20078793          	addi	a5,a5,512
    80203338:	0792                	slli	a5,a5,0x4
    8020333a:	97ba                	add	a5,a5,a4
    8020333c:	0307c783          	lbu	a5,48(a5)
    80203340:	cf89                	beqz	a5,8020335a <virtio_disk_intr+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:223
            panic("virtio_disk_intr status\n");
    80203342:	00007617          	auipc	a2,0x7
    80203346:	e2e60613          	addi	a2,a2,-466 # 8020a170 <MMIO+0xe8>
    8020334a:	0df00593          	li	a1,223
    8020334e:	00007517          	auipc	a0,0x7
    80203352:	d6a50513          	addi	a0,a0,-662 # 8020a0b8 <MMIO+0x30>
    80203356:	486040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:225

        BlockCache *b = disk.info[id].b;
    8020335a:	00024717          	auipc	a4,0x24
    8020335e:	ca670713          	addi	a4,a4,-858 # 80227000 <disk>
    80203362:	fec42783          	lw	a5,-20(s0)
    80203366:	20078793          	addi	a5,a5,512
    8020336a:	0792                	slli	a5,a5,0x4
    8020336c:	97ba                	add	a5,a5,a4
    8020336e:	779c                	ld	a5,40(a5)
    80203370:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:226
        b->disk = false;
    80203374:	fe043783          	ld	a5,-32(s0)
    80203378:	2007a823          	sw	zero,528(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:227
        disk.used_idx += 1;
    8020337c:	00024717          	auipc	a4,0x24
    80203380:	c8470713          	addi	a4,a4,-892 # 80227000 <disk>
    80203384:	6789                	lui	a5,0x2
    80203386:	97ba                	add	a5,a5,a4
    80203388:	0207d783          	lhu	a5,32(a5) # 2020 <n+0x2000>
    8020338c:	2785                	addiw	a5,a5,1
    8020338e:	03079713          	slli	a4,a5,0x30
    80203392:	9341                	srli	a4,a4,0x30
    80203394:	00024697          	auipc	a3,0x24
    80203398:	c6c68693          	addi	a3,a3,-916 # 80227000 <disk>
    8020339c:	6789                	lui	a5,0x2
    8020339e:	97b6                	add	a5,a5,a3
    802033a0:	02e79023          	sh	a4,32(a5) # 2020 <n+0x2000>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:217
    while (disk.used_idx != disk.used->idx)
    802033a4:	00024717          	auipc	a4,0x24
    802033a8:	c5c70713          	addi	a4,a4,-932 # 80227000 <disk>
    802033ac:	6789                	lui	a5,0x2
    802033ae:	97ba                	add	a5,a5,a4
    802033b0:	0207d683          	lhu	a3,32(a5) # 2020 <n+0x2000>
    802033b4:	00024717          	auipc	a4,0x24
    802033b8:	c4c70713          	addi	a4,a4,-948 # 80227000 <disk>
    802033bc:	6789                	lui	a5,0x2
    802033be:	97ba                	add	a5,a5,a4
    802033c0:	6b9c                	ld	a5,16(a5)
    802033c2:	0027d783          	lhu	a5,2(a5) # 2002 <n+0x1fe2>
    802033c6:	0006871b          	sext.w	a4,a3
    802033ca:	2781                	sext.w	a5,a5
    802033cc:	f2f715e3          	bne	a4,a5,802032f6 <virtio_disk_intr+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.c:229
    }
}
    802033d0:	0001                	nop
    802033d2:	0001                	nop
    802033d4:	60e2                	ld	ra,24(sp)
    802033d6:	6442                	ld	s0,16(sp)
    802033d8:	6105                	addi	sp,sp,32
    802033da:	8082                	ret

00000000802033dc <cpuid>:
cpuid():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:5
#include "plic.h"
#include "config.h"

static int cpuid()
{
    802033dc:	1141                	addi	sp,sp,-16
    802033de:	e422                	sd	s0,8(sp)
    802033e0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:6
    return 0;
    802033e2:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:7
}
    802033e4:	853e                	mv	a0,a5
    802033e6:	6422                	ld	s0,8(sp)
    802033e8:	0141                	addi	sp,sp,16
    802033ea:	8082                	ret

00000000802033ec <plic_init>:
plic_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:10

void plic_init()
{
    802033ec:	1101                	addi	sp,sp,-32
    802033ee:	ec06                	sd	ra,24(sp)
    802033f0:	e822                	sd	s0,16(sp)
    802033f2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:11
    printk("plic_init_start\n");
    802033f4:	00007517          	auipc	a0,0x7
    802033f8:	dac50513          	addi	a0,a0,-596 # 8020a1a0 <MMIO+0x10>
    802033fc:	beeff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:12
    *(uint32_t *)(PLIC + UART0_IRQ * 4) = 1;
    80203400:	0c0007b7          	lui	a5,0xc000
    80203404:	02878793          	addi	a5,a5,40 # c000028 <n+0xc000008>
    80203408:	4705                	li	a4,1
    8020340a:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:13
    *(uint32_t *)(PLIC + VIRTIO0_IRQ * 4) = 1;
    8020340c:	0c0007b7          	lui	a5,0xc000
    80203410:	0791                	addi	a5,a5,4
    80203412:	4705                	li	a4,1
    80203414:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:14
    int hart = cpuid();
    80203416:	fc7ff0ef          	jal	ra,802033dc <cpuid>
    8020341a:	87aa                	mv	a5,a0
    8020341c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:18

    // set enable bits for this hart's S-mode
    // for the uart and virtio disk.
    *(uint32_t *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80203420:	fec42783          	lw	a5,-20(s0)
    80203424:	0087979b          	slliw	a5,a5,0x8
    80203428:	2781                	sext.w	a5,a5
    8020342a:	873e                	mv	a4,a5
    8020342c:	0c0027b7          	lui	a5,0xc002
    80203430:	08078793          	addi	a5,a5,128 # c002080 <n+0xc002060>
    80203434:	97ba                	add	a5,a5,a4
    80203436:	873e                	mv	a4,a5
    80203438:	40200793          	li	a5,1026
    8020343c:	c31c                	sw	a5,0(a4)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:21

    // set this hart's S-mode priority threshold to 0.
    *(uint32_t *)PLIC_SPRIORITY(hart) = 0;
    8020343e:	fec42783          	lw	a5,-20(s0)
    80203442:	00d7979b          	slliw	a5,a5,0xd
    80203446:	2781                	sext.w	a5,a5
    80203448:	873e                	mv	a4,a5
    8020344a:	0c2017b7          	lui	a5,0xc201
    8020344e:	97ba                	add	a5,a5,a4
    80203450:	0007a023          	sw	zero,0(a5) # c201000 <n+0xc200fe0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:22
    printk("plic_init_end\n");
    80203454:	00007517          	auipc	a0,0x7
    80203458:	d6450513          	addi	a0,a0,-668 # 8020a1b8 <MMIO+0x28>
    8020345c:	b8eff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:23
}
    80203460:	0001                	nop
    80203462:	60e2                	ld	ra,24(sp)
    80203464:	6442                	ld	s0,16(sp)
    80203466:	6105                	addi	sp,sp,32
    80203468:	8082                	ret

000000008020346a <plic_claim>:
plic_claim():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:26

int plic_claim()
{
    8020346a:	1101                	addi	sp,sp,-32
    8020346c:	ec06                	sd	ra,24(sp)
    8020346e:	e822                	sd	s0,16(sp)
    80203470:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:27
    int hart = cpuid();
    80203472:	f6bff0ef          	jal	ra,802033dc <cpuid>
    80203476:	87aa                	mv	a5,a0
    80203478:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:28
    int irq = *(uint32_t *)PLIC_SCLAIM(hart);
    8020347c:	fec42783          	lw	a5,-20(s0)
    80203480:	00d7979b          	slliw	a5,a5,0xd
    80203484:	2781                	sext.w	a5,a5
    80203486:	873e                	mv	a4,a5
    80203488:	0c2017b7          	lui	a5,0xc201
    8020348c:	0791                	addi	a5,a5,4
    8020348e:	97ba                	add	a5,a5,a4
    80203490:	439c                	lw	a5,0(a5)
    80203492:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:29
    return irq;
    80203496:	fe842783          	lw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:30
}
    8020349a:	853e                	mv	a0,a5
    8020349c:	60e2                	ld	ra,24(sp)
    8020349e:	6442                	ld	s0,16(sp)
    802034a0:	6105                	addi	sp,sp,32
    802034a2:	8082                	ret

00000000802034a4 <plic_complete>:
plic_complete():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:33

void plic_complete(int irq)
{
    802034a4:	7179                	addi	sp,sp,-48
    802034a6:	f406                	sd	ra,40(sp)
    802034a8:	f022                	sd	s0,32(sp)
    802034aa:	1800                	addi	s0,sp,48
    802034ac:	87aa                	mv	a5,a0
    802034ae:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:34
    int hart = cpuid();
    802034b2:	f2bff0ef          	jal	ra,802033dc <cpuid>
    802034b6:	87aa                	mv	a5,a0
    802034b8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:35
    *(uint32_t *)PLIC_SCLAIM(hart) = irq;
    802034bc:	fec42783          	lw	a5,-20(s0)
    802034c0:	00d7979b          	slliw	a5,a5,0xd
    802034c4:	2781                	sext.w	a5,a5
    802034c6:	873e                	mv	a4,a5
    802034c8:	0c2017b7          	lui	a5,0xc201
    802034cc:	0791                	addi	a5,a5,4
    802034ce:	97ba                	add	a5,a5,a4
    802034d0:	873e                	mv	a4,a5
    802034d2:	fdc42783          	lw	a5,-36(s0)
    802034d6:	c31c                	sw	a5,0(a4)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/plic/plic.c:36
}
    802034d8:	0001                	nop
    802034da:	70a2                	ld	ra,40(sp)
    802034dc:	7402                	ld	s0,32(sp)
    802034de:	6145                	addi	sp,sp,48
    802034e0:	8082                	ret

00000000802034e2 <write_addr>:
write_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:100
{
    802034e2:	7179                	addi	sp,sp,-48
    802034e4:	f422                	sd	s0,40(sp)
    802034e6:	1800                	addi	s0,sp,48
    802034e8:	87aa                	mv	a5,a0
    802034ea:	872e                	mv	a4,a1
    802034ec:	fcf42e23          	sw	a5,-36(s0)
    802034f0:	87ba                	mv	a5,a4
    802034f2:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:101
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    802034f6:	fdc42703          	lw	a4,-36(s0)
    802034fa:	100017b7          	lui	a5,0x10001
    802034fe:	9fb9                	addw	a5,a5,a4
    80203500:	2781                	sext.w	a5,a5
    80203502:	1782                	slli	a5,a5,0x20
    80203504:	9381                	srli	a5,a5,0x20
    80203506:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:102
    *addr = value;
    8020350a:	fe843783          	ld	a5,-24(s0)
    8020350e:	fd842703          	lw	a4,-40(s0)
    80203512:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:103
}
    80203514:	0001                	nop
    80203516:	7422                	ld	s0,40(sp)
    80203518:	6145                	addi	sp,sp,48
    8020351a:	8082                	ret

000000008020351c <read_addr>:
read_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:105
{
    8020351c:	7179                	addi	sp,sp,-48
    8020351e:	f422                	sd	s0,40(sp)
    80203520:	1800                	addi	s0,sp,48
    80203522:	87aa                	mv	a5,a0
    80203524:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:106
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    80203528:	fdc42703          	lw	a4,-36(s0)
    8020352c:	100017b7          	lui	a5,0x10001
    80203530:	9fb9                	addw	a5,a5,a4
    80203532:	2781                	sext.w	a5,a5
    80203534:	1782                	slli	a5,a5,0x20
    80203536:	9381                	srli	a5,a5,0x20
    80203538:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:107
    return *addr;
    8020353c:	fe843783          	ld	a5,-24(s0)
    80203540:	439c                	lw	a5,0(a5)
    80203542:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:108
}
    80203544:	853e                	mv	a0,a5
    80203546:	7422                	ld	s0,40(sp)
    80203548:	6145                	addi	sp,sp,48
    8020354a:	8082                	ret

000000008020354c <clear_bss>:
clear_bss():
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:20
#include "string.h"
#include "riscv.h"
extern uint8_t sbss, ebss;

void clear_bss()
{
    8020354c:	1101                	addi	sp,sp,-32
    8020354e:	ec22                	sd	s0,24(sp)
    80203550:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:21
  for (uint8_t *i = &sbss; i < &ebss; i++)
    80203552:	00023797          	auipc	a5,0x23
    80203556:	aae78793          	addi	a5,a5,-1362 # 80226000 <BLOCK_DEVICE>
    8020355a:	fef43423          	sd	a5,-24(s0)
    8020355e:	a811                	j	80203572 <clear_bss+0x26>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:23 (discriminator 3)
  {
    *i = 0;
    80203560:	fe843783          	ld	a5,-24(s0)
    80203564:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:21 (discriminator 3)
  for (uint8_t *i = &sbss; i < &ebss; i++)
    80203568:	fe843783          	ld	a5,-24(s0)
    8020356c:	0785                	addi	a5,a5,1
    8020356e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:21 (discriminator 1)
    80203572:	fe843703          	ld	a4,-24(s0)
    80203576:	00b2b797          	auipc	a5,0xb2b
    8020357a:	a8a78793          	addi	a5,a5,-1398 # 80d2e000 <ebss>
    8020357e:	fef761e3          	bltu	a4,a5,80203560 <clear_bss+0x14>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:25
  }
}
    80203582:	0001                	nop
    80203584:	0001                	nop
    80203586:	6462                	ld	s0,24(sp)
    80203588:	6105                	addi	sp,sp,32
    8020358a:	8082                	ret

000000008020358c <main_os>:
main_os():
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:28

int main_os()
{
    8020358c:	1101                	addi	sp,sp,-32
    8020358e:	ec06                	sd	ra,24(sp)
    80203590:	e822                	sd	s0,16(sp)
    80203592:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:29
  mm_init();
    80203594:	038030ef          	jal	ra,802065cc <mm_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:30
  init_trap();
    80203598:	11f050ef          	jal	ra,80208eb6 <init_trap>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:31
  set_user_trap_entry();
    8020359c:	07d050ef          	jal	ra,80208e18 <set_user_trap_entry>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:32
  plic_init();
    802035a0:	e4dff0ef          	jal	ra,802033ec <plic_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:35
  // trap_enable_timer_interrupt();
  // timer_set_next_trigger();
  printk("Before ebreak\n");
    802035a4:	00007517          	auipc	a0,0x7
    802035a8:	c3450513          	addi	a0,a0,-972 # 8020a1d8 <MMIO+0x10>
    802035ac:	a3eff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:36
  __asm__ volatile("ebreak");
    802035b0:	9002                	ebreak
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:37
  printk("After ebreak\n");
    802035b2:	00007517          	auipc	a0,0x7
    802035b6:	c3650513          	addi	a0,a0,-970 # 8020a1e8 <MMIO+0x20>
    802035ba:	a30ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:38
  BLOCK_DEVICE = *virtio_block_device_init();
    802035be:	cc1ff0ef          	jal	ra,8020327e <virtio_block_device_init>
    802035c2:	872a                	mv	a4,a0
    802035c4:	00027797          	auipc	a5,0x27
    802035c8:	a4478793          	addi	a5,a5,-1468 # 8022a008 <BLOCK_DEVICE>
    802035cc:	6314                	ld	a3,0(a4)
    802035ce:	e394                	sd	a3,0(a5)
    802035d0:	6718                	ld	a4,8(a4)
    802035d2:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:39
  BlockCache_manager_init();
    802035d4:	0c8000ef          	jal	ra,8020369c <BlockCache_manager_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:40
  virtio_block_device_init();
    802035d8:	ca7ff0ef          	jal	ra,8020327e <virtio_block_device_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:42
  BlockCache *test;
  block_cache_new(test, 1, &BLOCK_DEVICE);
    802035dc:	00027617          	auipc	a2,0x27
    802035e0:	a2c60613          	addi	a2,a2,-1492 # 8022a008 <BLOCK_DEVICE>
    802035e4:	4585                	li	a1,1
    802035e6:	fe843503          	ld	a0,-24(s0)
    802035ea:	180000ef          	jal	ra,8020376a <block_cache_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:43
  BLOCK_DEVICE.write_block(test);
    802035ee:	00027797          	auipc	a5,0x27
    802035f2:	a1a78793          	addi	a5,a5,-1510 # 8022a008 <BLOCK_DEVICE>
    802035f6:	679c                	ld	a5,8(a5)
    802035f8:	fe843503          	ld	a0,-24(s0)
    802035fc:	9782                	jalr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:44
  loader_init_and_list_apps();
    802035fe:	1be050ef          	jal	ra,802087bc <loader_init_and_list_apps>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:45
  taks_init();
    80203602:	4fe040ef          	jal	ra,80207b00 <taks_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:46
  task_manager_add_2_initproc();
    80203606:	54c040ef          	jal	ra,80207b52 <task_manager_add_2_initproc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:47
  processor_run_tasks();
    8020360a:	6d1040ef          	jal	ra,802084da <processor_run_tasks>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:48
  ASSERT(0);
    8020360e:	00007617          	auipc	a2,0x7
    80203612:	bea60613          	addi	a2,a2,-1046 # 8020a1f8 <MMIO+0x30>
    80203616:	03000593          	li	a1,48
    8020361a:	00007517          	auipc	a0,0x7
    8020361e:	bf650513          	addi	a0,a0,-1034 # 8020a210 <MMIO+0x48>
    80203622:	1ba040ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:49
  return 0;
    80203626:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/main.c:50
    80203628:	853e                	mv	a0,a5
    8020362a:	60e2                	ld	ra,24(sp)
    8020362c:	6442                	ld	s0,16(sp)
    8020362e:	6105                	addi	sp,sp,32
    80203630:	8082                	ret

0000000080203632 <write_addr>:
write_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:100
{
    80203632:	7179                	addi	sp,sp,-48
    80203634:	f422                	sd	s0,40(sp)
    80203636:	1800                	addi	s0,sp,48
    80203638:	87aa                	mv	a5,a0
    8020363a:	872e                	mv	a4,a1
    8020363c:	fcf42e23          	sw	a5,-36(s0)
    80203640:	87ba                	mv	a5,a4
    80203642:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:101
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    80203646:	fdc42703          	lw	a4,-36(s0)
    8020364a:	100017b7          	lui	a5,0x10001
    8020364e:	9fb9                	addw	a5,a5,a4
    80203650:	2781                	sext.w	a5,a5
    80203652:	1782                	slli	a5,a5,0x20
    80203654:	9381                	srli	a5,a5,0x20
    80203656:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:102
    *addr = value;
    8020365a:	fe843783          	ld	a5,-24(s0)
    8020365e:	fd842703          	lw	a4,-40(s0)
    80203662:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:103
}
    80203664:	0001                	nop
    80203666:	7422                	ld	s0,40(sp)
    80203668:	6145                	addi	sp,sp,48
    8020366a:	8082                	ret

000000008020366c <read_addr>:
read_addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:105
{
    8020366c:	7179                	addi	sp,sp,-48
    8020366e:	f422                	sd	s0,40(sp)
    80203670:	1800                	addi	s0,sp,48
    80203672:	87aa                	mv	a5,a0
    80203674:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:106
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    80203678:	fdc42703          	lw	a4,-36(s0)
    8020367c:	100017b7          	lui	a5,0x10001
    80203680:	9fb9                	addw	a5,a5,a4
    80203682:	2781                	sext.w	a5,a5
    80203684:	1782                	slli	a5,a5,0x20
    80203686:	9381                	srli	a5,a5,0x20
    80203688:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:107
    return *addr;
    8020368c:	fe843783          	ld	a5,-24(s0)
    80203690:	439c                	lw	a5,0(a5)
    80203692:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/virtio/virtio.h:108
}
    80203694:	853e                	mv	a0,a5
    80203696:	7422                	ld	s0,40(sp)
    80203698:	6145                	addi	sp,sp,48
    8020369a:	8082                	ret

000000008020369c <BlockCache_manager_init>:
BlockCache_manager_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:8
#include "virtio.h"
#include "buddy.h"
BlockCache_Manager BLOCKCACHE_MANAGER;

void BlockCache_manager_init()
{
    8020369c:	1141                	addi	sp,sp,-16
    8020369e:	e406                	sd	ra,8(sp)
    802036a0:	e022                	sd	s0,0(sp)
    802036a2:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:9
    vector_new(&BLOCKCACHE_MANAGER.blockcache_vector, sizeof(BlockCache));
    802036a4:	22000593          	li	a1,544
    802036a8:	00027517          	auipc	a0,0x27
    802036ac:	97050513          	addi	a0,a0,-1680 # 8022a018 <BLOCKCACHE_MANAGER>
    802036b0:	1cc060ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:10
}
    802036b4:	0001                	nop
    802036b6:	60a2                	ld	ra,8(sp)
    802036b8:	6402                	ld	s0,0(sp)
    802036ba:	0141                	addi	sp,sp,16
    802036bc:	8082                	ret

00000000802036be <block_cache_sync_all>:
block_cache_sync_all():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:13

void block_cache_sync_all()
{
    802036be:	715d                	addi	sp,sp,-80
    802036c0:	e486                	sd	ra,72(sp)
    802036c2:	e0a2                	sd	s0,64(sp)
    802036c4:	0880                	addi	s0,sp,80
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:14
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    802036c6:	00027797          	auipc	a5,0x27
    802036ca:	95278793          	addi	a5,a5,-1710 # 8022a018 <BLOCKCACHE_MANAGER>
    802036ce:	6390                	ld	a2,0(a5)
    802036d0:	6794                	ld	a3,8(a5)
    802036d2:	6b98                	ld	a4,16(a5)
    802036d4:	6f9c                	ld	a5,24(a5)
    802036d6:	fac43c23          	sd	a2,-72(s0)
    802036da:	fcd43023          	sd	a3,-64(s0)
    802036de:	fce43423          	sd	a4,-56(s0)
    802036e2:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:15
    uint64_t blockcache_num = blockcache_vector.size;
    802036e6:	fb843783          	ld	a5,-72(s0)
    802036ea:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:16
    for (int i = 0; i < blockcache_num; i++)
    802036ee:	fe042623          	sw	zero,-20(s0)
    802036f2:	a025                	j	8020371a <block_cache_sync_all+0x5c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:18 (discriminator 3)
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
    802036f4:	fec42703          	lw	a4,-20(s0)
    802036f8:	fb840793          	addi	a5,s0,-72
    802036fc:	85ba                	mv	a1,a4
    802036fe:	853e                	mv	a0,a5
    80203700:	41c060ef          	jal	ra,80209b1c <vector_get>
    80203704:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:19 (discriminator 3)
        block_cache_sync(blockcache_ve);
    80203708:	fd843503          	ld	a0,-40(s0)
    8020370c:	026000ef          	jal	ra,80203732 <block_cache_sync>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:16 (discriminator 3)
    for (int i = 0; i < blockcache_num; i++)
    80203710:	fec42783          	lw	a5,-20(s0)
    80203714:	2785                	addiw	a5,a5,1
    80203716:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:16 (discriminator 1)
    8020371a:	fec42783          	lw	a5,-20(s0)
    8020371e:	fe043703          	ld	a4,-32(s0)
    80203722:	fce7e9e3          	bltu	a5,a4,802036f4 <block_cache_sync_all+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:21
    }
}
    80203726:	0001                	nop
    80203728:	0001                	nop
    8020372a:	60a6                	ld	ra,72(sp)
    8020372c:	6406                	ld	s0,64(sp)
    8020372e:	6161                	addi	sp,sp,80
    80203730:	8082                	ret

0000000080203732 <block_cache_sync>:
block_cache_sync():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:24

void block_cache_sync(BlockCache *block_cache)
{
    80203732:	1101                	addi	sp,sp,-32
    80203734:	ec06                	sd	ra,24(sp)
    80203736:	e822                	sd	s0,16(sp)
    80203738:	1000                	addi	s0,sp,32
    8020373a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:25
    if (block_cache->modified)
    8020373e:	fe843783          	ld	a5,-24(s0)
    80203742:	2147a783          	lw	a5,532(a5)
    80203746:	cf89                	beqz	a5,80203760 <block_cache_sync+0x2e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:27
    {
        block_cache->modified = false;
    80203748:	fe843783          	ld	a5,-24(s0)
    8020374c:	2007aa23          	sw	zero,532(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:28
        block_cache->block_device->write_block(block_cache);
    80203750:	fe843783          	ld	a5,-24(s0)
    80203754:	2087b783          	ld	a5,520(a5)
    80203758:	679c                	ld	a5,8(a5)
    8020375a:	fe843503          	ld	a0,-24(s0)
    8020375e:	9782                	jalr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:30
    }
}
    80203760:	0001                	nop
    80203762:	60e2                	ld	ra,24(sp)
    80203764:	6442                	ld	s0,16(sp)
    80203766:	6105                	addi	sp,sp,32
    80203768:	8082                	ret

000000008020376a <block_cache_new>:
block_cache_new():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:33

void block_cache_new(BlockCache *block_cache, uint64_t block_id, BlockDevice *block_device)
{
    8020376a:	7179                	addi	sp,sp,-48
    8020376c:	f406                	sd	ra,40(sp)
    8020376e:	f022                	sd	s0,32(sp)
    80203770:	1800                	addi	s0,sp,48
    80203772:	fea43423          	sd	a0,-24(s0)
    80203776:	feb43023          	sd	a1,-32(s0)
    8020377a:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:34
    printk("1.1\n");
    8020377e:	00007517          	auipc	a0,0x7
    80203782:	ab250513          	addi	a0,a0,-1358 # 8020a230 <MMIO+0x10>
    80203786:	864ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:35
    block_cache = (BlockCache *)bd_malloc(sizeof(BlockCache));
    8020378a:	22000513          	li	a0,544
    8020378e:	284030ef          	jal	ra,80206a12 <bd_malloc>
    80203792:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:36
    printk("1.2\n");
    80203796:	00007517          	auipc	a0,0x7
    8020379a:	aa250513          	addi	a0,a0,-1374 # 8020a238 <MMIO+0x18>
    8020379e:	84cff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:37
    memset(block_cache->cache, 0, BLOCK_SZ);
    802037a2:	fe843783          	ld	a5,-24(s0)
    802037a6:	20000613          	li	a2,512
    802037aa:	4581                	li	a1,0
    802037ac:	853e                	mv	a0,a5
    802037ae:	08e010ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:38
    printk("1.3\n");
    802037b2:	00007517          	auipc	a0,0x7
    802037b6:	a8e50513          	addi	a0,a0,-1394 # 8020a240 <MMIO+0x20>
    802037ba:	830ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:39
    block_cache->block_id = block_id;
    802037be:	fe843783          	ld	a5,-24(s0)
    802037c2:	fe043703          	ld	a4,-32(s0)
    802037c6:	20e7b023          	sd	a4,512(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:40
    printk("1.4\n");
    802037ca:	00007517          	auipc	a0,0x7
    802037ce:	a7e50513          	addi	a0,a0,-1410 # 8020a248 <MMIO+0x28>
    802037d2:	818ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:41
    block_cache->block_device = block_device;
    802037d6:	fe843783          	ld	a5,-24(s0)
    802037da:	fd843703          	ld	a4,-40(s0)
    802037de:	20e7b423          	sd	a4,520(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:42
    printk("1.5\n");
    802037e2:	00007517          	auipc	a0,0x7
    802037e6:	a6e50513          	addi	a0,a0,-1426 # 8020a250 <MMIO+0x30>
    802037ea:	800ff0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:43
    block_cache->modified = false;
    802037ee:	fe843783          	ld	a5,-24(s0)
    802037f2:	2007aa23          	sw	zero,532(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:44
    printk("1.6\n");
    802037f6:	00007517          	auipc	a0,0x7
    802037fa:	a6250513          	addi	a0,a0,-1438 # 8020a258 <MMIO+0x38>
    802037fe:	fedfe0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:45
    block_cache->ref = 0;
    80203802:	fe843783          	ld	a5,-24(s0)
    80203806:	2007bc23          	sd	zero,536(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:46
    printk("1.7\n");
    8020380a:	00007517          	auipc	a0,0x7
    8020380e:	a5650513          	addi	a0,a0,-1450 # 8020a260 <MMIO+0x40>
    80203812:	fd9fe0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:47
    block_cache->block_device->read_block(block_cache);
    80203816:	fe843783          	ld	a5,-24(s0)
    8020381a:	2087b783          	ld	a5,520(a5)
    8020381e:	639c                	ld	a5,0(a5)
    80203820:	fe843503          	ld	a0,-24(s0)
    80203824:	9782                	jalr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:48
    printk("1.8\n");
    80203826:	00007517          	auipc	a0,0x7
    8020382a:	a4250513          	addi	a0,a0,-1470 # 8020a268 <MMIO+0x48>
    8020382e:	fbdfe0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:49
}
    80203832:	0001                	nop
    80203834:	70a2                	ld	ra,40(sp)
    80203836:	7402                	ld	s0,32(sp)
    80203838:	6145                	addi	sp,sp,48
    8020383a:	8082                	ret

000000008020383c <BlockCache_find_block_by_index>:
BlockCache_find_block_by_index():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:52

BlockCache *BlockCache_find_block_by_index(BlockDevice *blockdevice, uint64_t index)
{
    8020383c:	711d                	addi	sp,sp,-96
    8020383e:	ec86                	sd	ra,88(sp)
    80203840:	e8a2                	sd	s0,80(sp)
    80203842:	1080                	addi	s0,sp,96
    80203844:	faa43423          	sd	a0,-88(s0)
    80203848:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:53
    ASSERT(blockdevice != NULL);
    8020384c:	fa843783          	ld	a5,-88(s0)
    80203850:	ef89                	bnez	a5,8020386a <BlockCache_find_block_by_index+0x2e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:53 (discriminator 1)
    80203852:	00007617          	auipc	a2,0x7
    80203856:	a1e60613          	addi	a2,a2,-1506 # 8020a270 <MMIO+0x50>
    8020385a:	03500593          	li	a1,53
    8020385e:	00007517          	auipc	a0,0x7
    80203862:	a3a50513          	addi	a0,a0,-1478 # 8020a298 <MMIO+0x78>
    80203866:	777030ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:54
    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    8020386a:	00026797          	auipc	a5,0x26
    8020386e:	7ae78793          	addi	a5,a5,1966 # 8022a018 <BLOCKCACHE_MANAGER>
    80203872:	6390                	ld	a2,0(a5)
    80203874:	6794                	ld	a3,8(a5)
    80203876:	6b98                	ld	a4,16(a5)
    80203878:	6f9c                	ld	a5,24(a5)
    8020387a:	fac43823          	sd	a2,-80(s0)
    8020387e:	fad43c23          	sd	a3,-72(s0)
    80203882:	fce43023          	sd	a4,-64(s0)
    80203886:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:55
    ASSERT(blockcache_vector.size >= index);
    8020388a:	fb043783          	ld	a5,-80(s0)
    8020388e:	fa043703          	ld	a4,-96(s0)
    80203892:	00e7fe63          	bgeu	a5,a4,802038ae <BlockCache_find_block_by_index+0x72>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:55 (discriminator 1)
    80203896:	00007617          	auipc	a2,0x7
    8020389a:	a2a60613          	addi	a2,a2,-1494 # 8020a2c0 <MMIO+0xa0>
    8020389e:	03700593          	li	a1,55
    802038a2:	00007517          	auipc	a0,0x7
    802038a6:	9f650513          	addi	a0,a0,-1546 # 8020a298 <MMIO+0x78>
    802038aa:	733030ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:56
    uint64_t blockcache_num = blockcache_vector.size;
    802038ae:	fb043783          	ld	a5,-80(s0)
    802038b2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:57
    for (int i = 0; i < blockcache_num; i++)
    802038b6:	fe042623          	sw	zero,-20(s0)
    802038ba:	a099                	j	80203900 <BlockCache_find_block_by_index+0xc4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:59
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
    802038bc:	fec42703          	lw	a4,-20(s0)
    802038c0:	fb040793          	addi	a5,s0,-80
    802038c4:	85ba                	mv	a1,a4
    802038c6:	853e                	mv	a0,a5
    802038c8:	254060ef          	jal	ra,80209b1c <vector_get>
    802038cc:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:60
        if (blockcache_ve->block_device == blockdevice && blockcache_ve->block_id == index)
    802038d0:	fd043783          	ld	a5,-48(s0)
    802038d4:	2087b783          	ld	a5,520(a5)
    802038d8:	fa843703          	ld	a4,-88(s0)
    802038dc:	00f71d63          	bne	a4,a5,802038f6 <BlockCache_find_block_by_index+0xba>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:60 (discriminator 1)
    802038e0:	fd043783          	ld	a5,-48(s0)
    802038e4:	2007b783          	ld	a5,512(a5)
    802038e8:	fa043703          	ld	a4,-96(s0)
    802038ec:	00f71563          	bne	a4,a5,802038f6 <BlockCache_find_block_by_index+0xba>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:62
        {
            return blockcache_ve;
    802038f0:	fd043783          	ld	a5,-48(s0)
    802038f4:	a851                	j	80203988 <BlockCache_find_block_by_index+0x14c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:57 (discriminator 2)
    for (int i = 0; i < blockcache_num; i++)
    802038f6:	fec42783          	lw	a5,-20(s0)
    802038fa:	2785                	addiw	a5,a5,1
    802038fc:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:57 (discriminator 1)
    80203900:	fec42783          	lw	a5,-20(s0)
    80203904:	fe043703          	ld	a4,-32(s0)
    80203908:	fae7eae3          	bltu	a5,a4,802038bc <BlockCache_find_block_by_index+0x80>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:65
        }
    }
    for (int i = 0; i < blockcache_num; i++)
    8020390c:	fe042423          	sw	zero,-24(s0)
    80203910:	a889                	j	80203962 <BlockCache_find_block_by_index+0x126>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:67
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
    80203912:	fe842703          	lw	a4,-24(s0)
    80203916:	fb040793          	addi	a5,s0,-80
    8020391a:	85ba                	mv	a1,a4
    8020391c:	853e                	mv	a0,a5
    8020391e:	1fe060ef          	jal	ra,80209b1c <vector_get>
    80203922:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:68
        if (blockcache_ve->ref == 0)
    80203926:	fd843783          	ld	a5,-40(s0)
    8020392a:	2187b783          	ld	a5,536(a5)
    8020392e:	e78d                	bnez	a5,80203958 <BlockCache_find_block_by_index+0x11c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:70
        {
            block_cache_sync(blockcache_ve);
    80203930:	fd843503          	ld	a0,-40(s0)
    80203934:	dffff0ef          	jal	ra,80203732 <block_cache_sync>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:71
            block_cache_new(blockcache_ve, index, blockdevice);
    80203938:	fa843603          	ld	a2,-88(s0)
    8020393c:	fa043583          	ld	a1,-96(s0)
    80203940:	fd843503          	ld	a0,-40(s0)
    80203944:	e27ff0ef          	jal	ra,8020376a <block_cache_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:72
            blockcache_ve->ref = 1;
    80203948:	fd843783          	ld	a5,-40(s0)
    8020394c:	4705                	li	a4,1
    8020394e:	20e7bc23          	sd	a4,536(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:73
            return blockcache_ve;
    80203952:	fd843783          	ld	a5,-40(s0)
    80203956:	a80d                	j	80203988 <BlockCache_find_block_by_index+0x14c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:65 (discriminator 2)
    for (int i = 0; i < blockcache_num; i++)
    80203958:	fe842783          	lw	a5,-24(s0)
    8020395c:	2785                	addiw	a5,a5,1
    8020395e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:65 (discriminator 1)
    80203962:	fe842783          	lw	a5,-24(s0)
    80203966:	fe043703          	ld	a4,-32(s0)
    8020396a:	fae7e4e3          	bltu	a5,a4,80203912 <BlockCache_find_block_by_index+0xd6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:76 (discriminator 1)
        }
    }
    ASSERT(0);
    8020396e:	00007617          	auipc	a2,0x7
    80203972:	98a60613          	addi	a2,a2,-1654 # 8020a2f8 <MMIO+0xd8>
    80203976:	04c00593          	li	a1,76
    8020397a:	00007517          	auipc	a0,0x7
    8020397e:	91e50513          	addi	a0,a0,-1762 # 8020a298 <MMIO+0x78>
    80203982:	65b030ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:77 (discriminator 1)
    return NULL;
    80203986:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:78 (discriminator 1)
}
    80203988:	853e                	mv	a0,a5
    8020398a:	60e6                	ld	ra,88(sp)
    8020398c:	6446                	ld	s0,80(sp)
    8020398e:	6125                	addi	sp,sp,96
    80203990:	8082                	ret

0000000080203992 <block_cache_release>:
block_cache_release():
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:80
void block_cache_release(BlockCache *b)
{
    80203992:	711d                	addi	sp,sp,-96
    80203994:	ec86                	sd	ra,88(sp)
    80203996:	e8a2                	sd	s0,80(sp)
    80203998:	1080                	addi	s0,sp,96
    8020399a:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:81
    if (b == NULL)
    8020399e:	fa843783          	ld	a5,-88(s0)
    802039a2:	ef91                	bnez	a5,802039be <block_cache_release+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:83 (discriminator 1)
    {
        ASSERT(0);
    802039a4:	00007617          	auipc	a2,0x7
    802039a8:	95460613          	addi	a2,a2,-1708 # 8020a2f8 <MMIO+0xd8>
    802039ac:	05300593          	li	a1,83
    802039b0:	00007517          	auipc	a0,0x7
    802039b4:	8e850513          	addi	a0,a0,-1816 # 8020a298 <MMIO+0x78>
    802039b8:	625030ef          	jal	ra,802077dc <_panic>
    802039bc:	a045                	j	80203a5c <block_cache_release+0xca>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:87
        return;
    }

    struct vector blockcache_vector = BLOCKCACHE_MANAGER.blockcache_vector;
    802039be:	00026797          	auipc	a5,0x26
    802039c2:	65a78793          	addi	a5,a5,1626 # 8022a018 <BLOCKCACHE_MANAGER>
    802039c6:	6390                	ld	a2,0(a5)
    802039c8:	6794                	ld	a3,8(a5)
    802039ca:	6b98                	ld	a4,16(a5)
    802039cc:	6f9c                	ld	a5,24(a5)
    802039ce:	fac43c23          	sd	a2,-72(s0)
    802039d2:	fcd43023          	sd	a3,-64(s0)
    802039d6:	fce43423          	sd	a4,-56(s0)
    802039da:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:88
    uint64_t blockcache_num = blockcache_vector.size;
    802039de:	fb843783          	ld	a5,-72(s0)
    802039e2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:89
    bool found = false;
    802039e6:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:90
    for (int i = 0; i < blockcache_num; i++)
    802039ea:	fe042423          	sw	zero,-24(s0)
    802039ee:	a089                	j	80203a30 <block_cache_release+0x9e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:92
    {
        BlockCache *blockcache_ve = vector_get(&blockcache_vector, i);
    802039f0:	fe842703          	lw	a4,-24(s0)
    802039f4:	fb840793          	addi	a5,s0,-72
    802039f8:	85ba                	mv	a1,a4
    802039fa:	853e                	mv	a0,a5
    802039fc:	120060ef          	jal	ra,80209b1c <vector_get>
    80203a00:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:93
        if (blockcache_ve == b)
    80203a04:	fd843703          	ld	a4,-40(s0)
    80203a08:	fa843783          	ld	a5,-88(s0)
    80203a0c:	00f71d63          	bne	a4,a5,80203a26 <block_cache_release+0x94>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:95
        {
            vector_remove(&blockcache_vector, i);
    80203a10:	fe842703          	lw	a4,-24(s0)
    80203a14:	fb840793          	addi	a5,s0,-72
    80203a18:	85ba                	mv	a1,a4
    80203a1a:	853e                	mv	a0,a5
    80203a1c:	058060ef          	jal	ra,80209a74 <vector_remove>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:96
            found = true;
    80203a20:	4785                	li	a5,1
    80203a22:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:90 (discriminator 2)
    for (int i = 0; i < blockcache_num; i++)
    80203a26:	fe842783          	lw	a5,-24(s0)
    80203a2a:	2785                	addiw	a5,a5,1
    80203a2c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:90 (discriminator 1)
    80203a30:	fe842783          	lw	a5,-24(s0)
    80203a34:	fe043703          	ld	a4,-32(s0)
    80203a38:	fae7ece3          	bltu	a5,a4,802039f0 <block_cache_release+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:99
        }
    }
    if (!found)
    80203a3c:	fec42783          	lw	a5,-20(s0)
    80203a40:	2781                	sext.w	a5,a5
    80203a42:	ef89                	bnez	a5,80203a5c <block_cache_release+0xca>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:100 (discriminator 1)
        ASSERT(0);
    80203a44:	00007617          	auipc	a2,0x7
    80203a48:	8b460613          	addi	a2,a2,-1868 # 8020a2f8 <MMIO+0xd8>
    80203a4c:	06400593          	li	a1,100
    80203a50:	00007517          	auipc	a0,0x7
    80203a54:	84850513          	addi	a0,a0,-1976 # 8020a298 <MMIO+0x78>
    80203a58:	585030ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/fs/block_cache/block_cache.c:101
    80203a5c:	60e6                	ld	ra,88(sp)
    80203a5e:	6446                	ld	s0,80(sp)
    80203a60:	6125                	addi	sp,sp,96
    80203a62:	8082                	ret

0000000080203a64 <elf_load_sections_loop>:
elf_load_sections_loop():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:19
/*
** traverse the section header table and load each section
*/
static int elf_load_sections_loop(t_elf *elf, size_t shoff, size_t shnum,
                                  size_t shentsize)
{
    80203a64:	715d                	addi	sp,sp,-80
    80203a66:	e486                	sd	ra,72(sp)
    80203a68:	e0a2                	sd	s0,64(sp)
    80203a6a:	0880                	addi	s0,sp,80
    80203a6c:	fca43423          	sd	a0,-56(s0)
    80203a70:	fcb43023          	sd	a1,-64(s0)
    80203a74:	fac43c23          	sd	a2,-72(s0)
    80203a78:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:24
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    80203a7c:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:25
  while (i < shnum)
    80203a80:	a0dd                	j	80203b66 <elf_load_sections_loop+0x102>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:27
  {
    if (i >= MAX_SECTION_NUM)
    80203a82:	fe843703          	ld	a4,-24(s0)
    80203a86:	03f00793          	li	a5,63
    80203a8a:	00e7f463          	bgeu	a5,a4,80203a92 <elf_load_sections_loop+0x2e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:29
    {
      return (-1);
    80203a8e:	57fd                	li	a5,-1
    80203a90:	a0d5                	j	80203b74 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:32
    }
    elf->sections[i].header =
        (union u_elf_sh *)(elf->raw_data + shoff + i * shentsize);
    80203a92:	fc843783          	ld	a5,-56(s0)
    80203a96:	6798                	ld	a4,8(a5)
    80203a98:	fe843683          	ld	a3,-24(s0)
    80203a9c:	fb043783          	ld	a5,-80(s0)
    80203aa0:	02f686b3          	mul	a3,a3,a5
    80203aa4:	fc043783          	ld	a5,-64(s0)
    80203aa8:	97b6                	add	a5,a5,a3
    80203aaa:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:31
    elf->sections[i].header =
    80203aac:	fc843683          	ld	a3,-56(s0)
    80203ab0:	fe843783          	ld	a5,-24(s0)
    80203ab4:	0789                	addi	a5,a5,2
    80203ab6:	0792                	slli	a5,a5,0x4
    80203ab8:	97b6                	add	a5,a5,a3
    80203aba:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:33
    type = elf_section_get_type(elf, &elf->sections[i]);
    80203abc:	fe843783          	ld	a5,-24(s0)
    80203ac0:	0789                	addi	a5,a5,2
    80203ac2:	0792                	slli	a5,a5,0x4
    80203ac4:	fc843703          	ld	a4,-56(s0)
    80203ac8:	97ba                	add	a5,a5,a4
    80203aca:	07a1                	addi	a5,a5,8
    80203acc:	85be                	mv	a1,a5
    80203ace:	fc843503          	ld	a0,-56(s0)
    80203ad2:	576000ef          	jal	ra,80204048 <elf_section_get_type>
    80203ad6:	87aa                	mv	a5,a0
    80203ad8:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:34
    if (type != SHT_NULL && type != SHT_NOBITS)
    80203adc:	fe442783          	lw	a5,-28(s0)
    80203ae0:	2781                	sext.w	a5,a5
    80203ae2:	cfad                	beqz	a5,80203b5c <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:34 (discriminator 1)
    80203ae4:	fe442783          	lw	a5,-28(s0)
    80203ae8:	0007871b          	sext.w	a4,a5
    80203aec:	47a1                	li	a5,8
    80203aee:	06f70763          	beq	a4,a5,80203b5c <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:36
    {
      content_offset = elf_section_get_offset(elf, &elf->sections[i]);
    80203af2:	fe843783          	ld	a5,-24(s0)
    80203af6:	0789                	addi	a5,a5,2
    80203af8:	0792                	slli	a5,a5,0x4
    80203afa:	fc843703          	ld	a4,-56(s0)
    80203afe:	97ba                	add	a5,a5,a4
    80203b00:	07a1                	addi	a5,a5,8
    80203b02:	85be                	mv	a1,a5
    80203b04:	fc843503          	ld	a0,-56(s0)
    80203b08:	584000ef          	jal	ra,8020408c <elf_section_get_offset>
    80203b0c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:37
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80203b10:	fe843783          	ld	a5,-24(s0)
    80203b14:	0789                	addi	a5,a5,2
    80203b16:	0792                	slli	a5,a5,0x4
    80203b18:	fc843703          	ld	a4,-56(s0)
    80203b1c:	97ba                	add	a5,a5,a4
    80203b1e:	07a1                	addi	a5,a5,8
    80203b20:	85be                	mv	a1,a5
    80203b22:	fc843503          	ld	a0,-56(s0)
    80203b26:	5ae000ef          	jal	ra,802040d4 <elf_section_get_size>
    80203b2a:	872a                	mv	a4,a0
    80203b2c:	fd843783          	ld	a5,-40(s0)
    80203b30:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:38
          elf->size)
    80203b32:	fc843783          	ld	a5,-56(s0)
    80203b36:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:37
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80203b38:	00e7f463          	bgeu	a5,a4,80203b40 <elf_load_sections_loop+0xdc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:40
      {
        return (-1);
    80203b3c:	57fd                	li	a5,-1
    80203b3e:	a81d                	j	80203b74 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:42
      }
      elf->sections[i].content = elf->raw_data + content_offset;
    80203b40:	fc843783          	ld	a5,-56(s0)
    80203b44:	6798                	ld	a4,8(a5)
    80203b46:	fd843783          	ld	a5,-40(s0)
    80203b4a:	973e                	add	a4,a4,a5
    80203b4c:	fc843683          	ld	a3,-56(s0)
    80203b50:	fe843783          	ld	a5,-24(s0)
    80203b54:	0789                	addi	a5,a5,2
    80203b56:	0792                	slli	a5,a5,0x4
    80203b58:	97b6                	add	a5,a5,a3
    80203b5a:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:44
    }
    i++;
    80203b5c:	fe843783          	ld	a5,-24(s0)
    80203b60:	0785                	addi	a5,a5,1
    80203b62:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:25
  while (i < shnum)
    80203b66:	fe843703          	ld	a4,-24(s0)
    80203b6a:	fb843783          	ld	a5,-72(s0)
    80203b6e:	f0f76ae3          	bltu	a4,a5,80203a82 <elf_load_sections_loop+0x1e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:46
  }
  return (0);
    80203b72:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:47
}
    80203b74:	853e                	mv	a0,a5
    80203b76:	60a6                	ld	ra,72(sp)
    80203b78:	6406                	ld	s0,64(sp)
    80203b7a:	6161                	addi	sp,sp,80
    80203b7c:	8082                	ret

0000000080203b7e <elf_load_sections>:
elf_load_sections():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:54
/*
** Load sections. Create a table of t_elf_section in elf->sections.
** This table is null if there is no section header table.
*/
int elf_load_sections(t_elf *elf)
{
    80203b7e:	7139                	addi	sp,sp,-64
    80203b80:	fc06                	sd	ra,56(sp)
    80203b82:	f822                	sd	s0,48(sp)
    80203b84:	0080                	addi	s0,sp,64
    80203b86:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:59
  size_t shoff;
  size_t shnum;
  size_t shentsize;

  if ((shoff = elf_header_get_shoff(elf)) > 0)
    80203b8a:	fc843503          	ld	a0,-56(s0)
    80203b8e:	0cc000ef          	jal	ra,80203c5a <elf_header_get_shoff>
    80203b92:	fea43423          	sd	a0,-24(s0)
    80203b96:	fe843783          	ld	a5,-24(s0)
    80203b9a:	cfb1                	beqz	a5,80203bf6 <elf_load_sections+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:61
  {
    shnum = elf_header_get_shnum(elf);
    80203b9c:	fc843503          	ld	a0,-56(s0)
    80203ba0:	142000ef          	jal	ra,80203ce2 <elf_header_get_shnum>
    80203ba4:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:62
    shentsize = elf_header_get_shentsize(elf);
    80203ba8:	fc843503          	ld	a0,-56(s0)
    80203bac:	0f2000ef          	jal	ra,80203c9e <elf_header_get_shentsize>
    80203bb0:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:63
    if (shoff + shnum * shentsize > elf->size)
    80203bb4:	fe043703          	ld	a4,-32(s0)
    80203bb8:	fd843783          	ld	a5,-40(s0)
    80203bbc:	02f70733          	mul	a4,a4,a5
    80203bc0:	fe843783          	ld	a5,-24(s0)
    80203bc4:	973e                	add	a4,a4,a5
    80203bc6:	fc843783          	ld	a5,-56(s0)
    80203bca:	639c                	ld	a5,0(a5)
    80203bcc:	00e7f463          	bgeu	a5,a4,80203bd4 <elf_load_sections+0x56>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:65
    {
      return (-1);
    80203bd0:	57fd                	li	a5,-1
    80203bd2:	a82d                	j	80203c0c <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:67
    }
    if (elf_load_sections_loop(elf, shoff, shnum, shentsize) == -1)
    80203bd4:	fd843683          	ld	a3,-40(s0)
    80203bd8:	fe043603          	ld	a2,-32(s0)
    80203bdc:	fe843583          	ld	a1,-24(s0)
    80203be0:	fc843503          	ld	a0,-56(s0)
    80203be4:	e81ff0ef          	jal	ra,80203a64 <elf_load_sections_loop>
    80203be8:	87aa                	mv	a5,a0
    80203bea:	873e                	mv	a4,a5
    80203bec:	57fd                	li	a5,-1
    80203bee:	00f71e63          	bne	a4,a5,80203c0a <elf_load_sections+0x8c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:69
    {
      return (-1);
    80203bf2:	57fd                	li	a5,-1
    80203bf4:	a821                	j	80203c0c <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:73
    }
  }
  else
    memset(elf->sections, 0, MAX_SECTION_NUM * sizeof(t_elf_section));
    80203bf6:	fc843783          	ld	a5,-56(s0)
    80203bfa:	02878793          	addi	a5,a5,40
    80203bfe:	40000613          	li	a2,1024
    80203c02:	4581                	li	a1,0
    80203c04:	853e                	mv	a0,a5
    80203c06:	437000ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:74
  return (0);
    80203c0a:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_sections.c:75
}
    80203c0c:	853e                	mv	a0,a5
    80203c0e:	70e2                	ld	ra,56(sp)
    80203c10:	7442                	ld	s0,48(sp)
    80203c12:	6121                	addi	sp,sp,64
    80203c14:	8082                	ret

0000000080203c16 <elf_header_get_entry>:
elf_header_get_entry():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:15
*/

#include "elfparse.h"

size_t elf_header_get_entry(t_elf *elf)
{
    80203c16:	7179                	addi	sp,sp,-48
    80203c18:	f422                	sd	s0,40(sp)
    80203c1a:	1800                	addi	s0,sp,48
    80203c1c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:18
  size_t entry;

  if (ELF_IS_32(elf))
    80203c20:	fd843783          	ld	a5,-40(s0)
    80203c24:	0187c783          	lbu	a5,24(a5)
    80203c28:	873e                	mv	a4,a5
    80203c2a:	4785                	li	a5,1
    80203c2c:	00f71b63          	bne	a4,a5,80203c42 <elf_header_get_entry+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:19
    entry = (size_t)elf->header->_32.e_entry;
    80203c30:	fd843783          	ld	a5,-40(s0)
    80203c34:	739c                	ld	a5,32(a5)
    80203c36:	4f9c                	lw	a5,24(a5)
    80203c38:	1782                	slli	a5,a5,0x20
    80203c3a:	9381                	srli	a5,a5,0x20
    80203c3c:	fef43423          	sd	a5,-24(s0)
    80203c40:	a039                	j	80203c4e <elf_header_get_entry+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:21
  else
    entry = (size_t)elf->header->_64.e_entry;
    80203c42:	fd843783          	ld	a5,-40(s0)
    80203c46:	739c                	ld	a5,32(a5)
    80203c48:	6f9c                	ld	a5,24(a5)
    80203c4a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:22
  return (entry);
    80203c4e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get.c:23
}
    80203c52:	853e                	mv	a0,a5
    80203c54:	7422                	ld	s0,40(sp)
    80203c56:	6145                	addi	sp,sp,48
    80203c58:	8082                	ret

0000000080203c5a <elf_header_get_shoff>:
elf_header_get_shoff():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:18

/*
** Get the section header table offset
*/
size_t elf_header_get_shoff(t_elf *elf)
{
    80203c5a:	7179                	addi	sp,sp,-48
    80203c5c:	f422                	sd	s0,40(sp)
    80203c5e:	1800                	addi	s0,sp,48
    80203c60:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:21
  size_t shoff;

  if (ELF_IS_32(elf))
    80203c64:	fd843783          	ld	a5,-40(s0)
    80203c68:	0187c783          	lbu	a5,24(a5)
    80203c6c:	873e                	mv	a4,a5
    80203c6e:	4785                	li	a5,1
    80203c70:	00f71b63          	bne	a4,a5,80203c86 <elf_header_get_shoff+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:22
    shoff = (size_t)elf->header->_32.e_shoff;
    80203c74:	fd843783          	ld	a5,-40(s0)
    80203c78:	739c                	ld	a5,32(a5)
    80203c7a:	539c                	lw	a5,32(a5)
    80203c7c:	1782                	slli	a5,a5,0x20
    80203c7e:	9381                	srli	a5,a5,0x20
    80203c80:	fef43423          	sd	a5,-24(s0)
    80203c84:	a039                	j	80203c92 <elf_header_get_shoff+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:24
  else
    shoff = (size_t)elf->header->_64.e_shoff;
    80203c86:	fd843783          	ld	a5,-40(s0)
    80203c8a:	739c                	ld	a5,32(a5)
    80203c8c:	779c                	ld	a5,40(a5)
    80203c8e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:25
  return (shoff);
    80203c92:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:26
}
    80203c96:	853e                	mv	a0,a5
    80203c98:	7422                	ld	s0,40(sp)
    80203c9a:	6145                	addi	sp,sp,48
    80203c9c:	8082                	ret

0000000080203c9e <elf_header_get_shentsize>:
elf_header_get_shentsize():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:32

/*
** Get the size of one section header
*/
size_t elf_header_get_shentsize(t_elf *elf)
{
    80203c9e:	7179                	addi	sp,sp,-48
    80203ca0:	f422                	sd	s0,40(sp)
    80203ca2:	1800                	addi	s0,sp,48
    80203ca4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:35
  size_t shentsize;

  if (ELF_IS_32(elf))
    80203ca8:	fd843783          	ld	a5,-40(s0)
    80203cac:	0187c783          	lbu	a5,24(a5)
    80203cb0:	873e                	mv	a4,a5
    80203cb2:	4785                	li	a5,1
    80203cb4:	00f71a63          	bne	a4,a5,80203cc8 <elf_header_get_shentsize+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:36
    shentsize = (size_t)elf->header->_32.e_shentsize;
    80203cb8:	fd843783          	ld	a5,-40(s0)
    80203cbc:	739c                	ld	a5,32(a5)
    80203cbe:	02e7d783          	lhu	a5,46(a5)
    80203cc2:	fef43423          	sd	a5,-24(s0)
    80203cc6:	a801                	j	80203cd6 <elf_header_get_shentsize+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:38
  else
    shentsize = (size_t)elf->header->_64.e_shentsize;
    80203cc8:	fd843783          	ld	a5,-40(s0)
    80203ccc:	739c                	ld	a5,32(a5)
    80203cce:	03a7d783          	lhu	a5,58(a5)
    80203cd2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:39
  return (shentsize);
    80203cd6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:40
}
    80203cda:	853e                	mv	a0,a5
    80203cdc:	7422                	ld	s0,40(sp)
    80203cde:	6145                	addi	sp,sp,48
    80203ce0:	8082                	ret

0000000080203ce2 <elf_header_get_shnum>:
elf_header_get_shnum():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:46

/*
** Get the number of entry in the section header table
*/
size_t elf_header_get_shnum(t_elf *elf)
{
    80203ce2:	7179                	addi	sp,sp,-48
    80203ce4:	f422                	sd	s0,40(sp)
    80203ce6:	1800                	addi	s0,sp,48
    80203ce8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:49
  size_t shum;

  if (ELF_IS_32(elf))
    80203cec:	fd843783          	ld	a5,-40(s0)
    80203cf0:	0187c783          	lbu	a5,24(a5)
    80203cf4:	873e                	mv	a4,a5
    80203cf6:	4785                	li	a5,1
    80203cf8:	00f71a63          	bne	a4,a5,80203d0c <elf_header_get_shnum+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:50
    shum = (size_t)elf->header->_32.e_shnum;
    80203cfc:	fd843783          	ld	a5,-40(s0)
    80203d00:	739c                	ld	a5,32(a5)
    80203d02:	0307d783          	lhu	a5,48(a5)
    80203d06:	fef43423          	sd	a5,-24(s0)
    80203d0a:	a801                	j	80203d1a <elf_header_get_shnum+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:52
  else
    shum = (size_t)elf->header->_64.e_shnum;
    80203d0c:	fd843783          	ld	a5,-40(s0)
    80203d10:	739c                	ld	a5,32(a5)
    80203d12:	03c7d783          	lhu	a5,60(a5)
    80203d16:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:53
  return (shum);
    80203d1a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_sh.c:54
}
    80203d1e:	853e                	mv	a0,a5
    80203d20:	7422                	ld	s0,40(sp)
    80203d22:	6145                	addi	sp,sp,48
    80203d24:	8082                	ret

0000000080203d26 <elf_program_get_type>:
elf_program_get_type():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:9

/*
** Get the program type.
*/
uint32_t elf_program_get_type(t_elf *elf, t_elf_program *program)
{
    80203d26:	7179                	addi	sp,sp,-48
    80203d28:	f422                	sd	s0,40(sp)
    80203d2a:	1800                	addi	s0,sp,48
    80203d2c:	fca43c23          	sd	a0,-40(s0)
    80203d30:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:12
  uint32_t type;

  if (ELF_IS_32(elf))
    80203d34:	fd843783          	ld	a5,-40(s0)
    80203d38:	0187c783          	lbu	a5,24(a5)
    80203d3c:	873e                	mv	a4,a5
    80203d3e:	4785                	li	a5,1
    80203d40:	00f71963          	bne	a4,a5,80203d52 <elf_program_get_type+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:13
    type = (uint32_t)program->header->_32.p_type;
    80203d44:	fd043783          	ld	a5,-48(s0)
    80203d48:	639c                	ld	a5,0(a5)
    80203d4a:	439c                	lw	a5,0(a5)
    80203d4c:	fef42623          	sw	a5,-20(s0)
    80203d50:	a039                	j	80203d5e <elf_program_get_type+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:15
  else
    type = (uint32_t)program->header->_64.p_type;
    80203d52:	fd043783          	ld	a5,-48(s0)
    80203d56:	639c                	ld	a5,0(a5)
    80203d58:	439c                	lw	a5,0(a5)
    80203d5a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:16
  return (type);
    80203d5e:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:17
}
    80203d62:	853e                	mv	a0,a5
    80203d64:	7422                	ld	s0,40(sp)
    80203d66:	6145                	addi	sp,sp,48
    80203d68:	8082                	ret

0000000080203d6a <elf_program_get_offset>:
elf_program_get_offset():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:23

/*
** Get the program offset (from the begin of the file)
*/
size_t elf_program_get_offset(t_elf *elf, t_elf_program *program)
{
    80203d6a:	7179                	addi	sp,sp,-48
    80203d6c:	f422                	sd	s0,40(sp)
    80203d6e:	1800                	addi	s0,sp,48
    80203d70:	fca43c23          	sd	a0,-40(s0)
    80203d74:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:26
  size_t offset;

  if (ELF_IS_32(elf))
    80203d78:	fd843783          	ld	a5,-40(s0)
    80203d7c:	0187c783          	lbu	a5,24(a5)
    80203d80:	873e                	mv	a4,a5
    80203d82:	4785                	li	a5,1
    80203d84:	00f71b63          	bne	a4,a5,80203d9a <elf_program_get_offset+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:27
    offset = (size_t)program->header->_32.p_offset;
    80203d88:	fd043783          	ld	a5,-48(s0)
    80203d8c:	639c                	ld	a5,0(a5)
    80203d8e:	43dc                	lw	a5,4(a5)
    80203d90:	1782                	slli	a5,a5,0x20
    80203d92:	9381                	srli	a5,a5,0x20
    80203d94:	fef43423          	sd	a5,-24(s0)
    80203d98:	a039                	j	80203da6 <elf_program_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:29
  else
    offset = (size_t)program->header->_64.p_offset;
    80203d9a:	fd043783          	ld	a5,-48(s0)
    80203d9e:	639c                	ld	a5,0(a5)
    80203da0:	679c                	ld	a5,8(a5)
    80203da2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:30
  return (offset);
    80203da6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:31
}
    80203daa:	853e                	mv	a0,a5
    80203dac:	7422                	ld	s0,40(sp)
    80203dae:	6145                	addi	sp,sp,48
    80203db0:	8082                	ret

0000000080203db2 <elf_program_get_flags>:
elf_program_get_flags():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:37

/*
** Get the flags of the program
*/
uint64_t elf_program_get_flags(t_elf *elf, t_elf_program *program)
{
    80203db2:	7179                	addi	sp,sp,-48
    80203db4:	f422                	sd	s0,40(sp)
    80203db6:	1800                	addi	s0,sp,48
    80203db8:	fca43c23          	sd	a0,-40(s0)
    80203dbc:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:40
  uint64_t flags;

  if (ELF_IS_32(elf))
    80203dc0:	fd843783          	ld	a5,-40(s0)
    80203dc4:	0187c783          	lbu	a5,24(a5)
    80203dc8:	873e                	mv	a4,a5
    80203dca:	4785                	li	a5,1
    80203dcc:	00f71b63          	bne	a4,a5,80203de2 <elf_program_get_flags+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:41
    flags = (uint64_t)program->header->_32.p_flags;
    80203dd0:	fd043783          	ld	a5,-48(s0)
    80203dd4:	639c                	ld	a5,0(a5)
    80203dd6:	4f9c                	lw	a5,24(a5)
    80203dd8:	1782                	slli	a5,a5,0x20
    80203dda:	9381                	srli	a5,a5,0x20
    80203ddc:	fef43423          	sd	a5,-24(s0)
    80203de0:	a809                	j	80203df2 <elf_program_get_flags+0x40>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:43
  else
    flags = (uint64_t)program->header->_64.p_flags;
    80203de2:	fd043783          	ld	a5,-48(s0)
    80203de6:	639c                	ld	a5,0(a5)
    80203de8:	43dc                	lw	a5,4(a5)
    80203dea:	1782                	slli	a5,a5,0x20
    80203dec:	9381                	srli	a5,a5,0x20
    80203dee:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:44
  return (flags);
    80203df2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:45
}
    80203df6:	853e                	mv	a0,a5
    80203df8:	7422                	ld	s0,40(sp)
    80203dfa:	6145                	addi	sp,sp,48
    80203dfc:	8082                	ret

0000000080203dfe <elf_program_get_vaddr>:
elf_program_get_vaddr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:51

/*
** Get the virtual address of the program
*/
uint64_t elf_program_get_vaddr(t_elf *elf, t_elf_program *program)
{
    80203dfe:	7179                	addi	sp,sp,-48
    80203e00:	f422                	sd	s0,40(sp)
    80203e02:	1800                	addi	s0,sp,48
    80203e04:	fca43c23          	sd	a0,-40(s0)
    80203e08:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:54
  uint64_t addr;

  if (ELF_IS_32(elf))
    80203e0c:	fd843783          	ld	a5,-40(s0)
    80203e10:	0187c783          	lbu	a5,24(a5)
    80203e14:	873e                	mv	a4,a5
    80203e16:	4785                	li	a5,1
    80203e18:	00f71b63          	bne	a4,a5,80203e2e <elf_program_get_vaddr+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:55
    addr = (uint64_t)program->header->_32.p_vaddr;
    80203e1c:	fd043783          	ld	a5,-48(s0)
    80203e20:	639c                	ld	a5,0(a5)
    80203e22:	479c                	lw	a5,8(a5)
    80203e24:	1782                	slli	a5,a5,0x20
    80203e26:	9381                	srli	a5,a5,0x20
    80203e28:	fef43423          	sd	a5,-24(s0)
    80203e2c:	a039                	j	80203e3a <elf_program_get_vaddr+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:57
  else
    addr = (uint64_t)program->header->_64.p_vaddr;
    80203e2e:	fd043783          	ld	a5,-48(s0)
    80203e32:	639c                	ld	a5,0(a5)
    80203e34:	6b9c                	ld	a5,16(a5)
    80203e36:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:58
  return (addr);
    80203e3a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:59
}
    80203e3e:	853e                	mv	a0,a5
    80203e40:	7422                	ld	s0,40(sp)
    80203e42:	6145                	addi	sp,sp,48
    80203e44:	8082                	ret

0000000080203e46 <elf_program_get_memsz>:
elf_program_get_memsz():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:65

/*
** Get the memory size of the program
*/
uint64_t elf_program_get_memsz(t_elf *elf, t_elf_program *program)
{
    80203e46:	7179                	addi	sp,sp,-48
    80203e48:	f422                	sd	s0,40(sp)
    80203e4a:	1800                	addi	s0,sp,48
    80203e4c:	fca43c23          	sd	a0,-40(s0)
    80203e50:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:68
  uint64_t addr;

  if (ELF_IS_32(elf))
    80203e54:	fd843783          	ld	a5,-40(s0)
    80203e58:	0187c783          	lbu	a5,24(a5)
    80203e5c:	873e                	mv	a4,a5
    80203e5e:	4785                	li	a5,1
    80203e60:	00f71b63          	bne	a4,a5,80203e76 <elf_program_get_memsz+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:69
    addr = (uint64_t)program->header->_32.p_memsz;
    80203e64:	fd043783          	ld	a5,-48(s0)
    80203e68:	639c                	ld	a5,0(a5)
    80203e6a:	4bdc                	lw	a5,20(a5)
    80203e6c:	1782                	slli	a5,a5,0x20
    80203e6e:	9381                	srli	a5,a5,0x20
    80203e70:	fef43423          	sd	a5,-24(s0)
    80203e74:	a039                	j	80203e82 <elf_program_get_memsz+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:71
  else
    addr = (uint64_t)program->header->_64.p_memsz;
    80203e76:	fd043783          	ld	a5,-48(s0)
    80203e7a:	639c                	ld	a5,0(a5)
    80203e7c:	779c                	ld	a5,40(a5)
    80203e7e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:72
  return (addr);
    80203e82:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:73
}
    80203e86:	853e                	mv	a0,a5
    80203e88:	7422                	ld	s0,40(sp)
    80203e8a:	6145                	addi	sp,sp,48
    80203e8c:	8082                	ret

0000000080203e8e <elf_program_get_filesz>:
elf_program_get_filesz():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:79

/*
** Get the file size of the program
*/
uint64_t elf_program_get_filesz(t_elf *elf, t_elf_program *program)
{
    80203e8e:	7179                	addi	sp,sp,-48
    80203e90:	f422                	sd	s0,40(sp)
    80203e92:	1800                	addi	s0,sp,48
    80203e94:	fca43c23          	sd	a0,-40(s0)
    80203e98:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:82
  uint64_t addr;

  if (ELF_IS_32(elf))
    80203e9c:	fd843783          	ld	a5,-40(s0)
    80203ea0:	0187c783          	lbu	a5,24(a5)
    80203ea4:	873e                	mv	a4,a5
    80203ea6:	4785                	li	a5,1
    80203ea8:	00f71b63          	bne	a4,a5,80203ebe <elf_program_get_filesz+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:83
    addr = (uint64_t)program->header->_32.p_filesz;
    80203eac:	fd043783          	ld	a5,-48(s0)
    80203eb0:	639c                	ld	a5,0(a5)
    80203eb2:	4b9c                	lw	a5,16(a5)
    80203eb4:	1782                	slli	a5,a5,0x20
    80203eb6:	9381                	srli	a5,a5,0x20
    80203eb8:	fef43423          	sd	a5,-24(s0)
    80203ebc:	a039                	j	80203eca <elf_program_get_filesz+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:85
  else
    addr = (uint64_t)program->header->_64.p_filesz;
    80203ebe:	fd043783          	ld	a5,-48(s0)
    80203ec2:	639c                	ld	a5,0(a5)
    80203ec4:	739c                	ld	a5,32(a5)
    80203ec6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:86
  return (addr);
    80203eca:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_program_get.c:87
}
    80203ece:	853e                	mv	a0,a5
    80203ed0:	7422                	ld	s0,40(sp)
    80203ed2:	6145                	addi	sp,sp,48
    80203ed4:	8082                	ret

0000000080203ed6 <elf_load_ident>:
elf_load_ident():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:18
#include "string.h"
/*
** Load the identity of the file.
*/
static int elf_load_ident(t_elf *elf)
{
    80203ed6:	1101                	addi	sp,sp,-32
    80203ed8:	ec06                	sd	ra,24(sp)
    80203eda:	e822                	sd	s0,16(sp)
    80203edc:	1000                	addi	s0,sp,32
    80203ede:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:19
  if (elf->size < EI_NIDENT || memcmp(elf->raw_data, ELFMAG, 4))
    80203ee2:	fe843783          	ld	a5,-24(s0)
    80203ee6:	6398                	ld	a4,0(a5)
    80203ee8:	47bd                	li	a5,15
    80203eea:	00e7ff63          	bgeu	a5,a4,80203f08 <elf_load_ident+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:19 (discriminator 1)
    80203eee:	fe843783          	ld	a5,-24(s0)
    80203ef2:	679c                	ld	a5,8(a5)
    80203ef4:	4611                	li	a2,4
    80203ef6:	00006597          	auipc	a1,0x6
    80203efa:	41a58593          	addi	a1,a1,1050 # 8020a310 <MMIO+0xf0>
    80203efe:	853e                	mv	a0,a5
    80203f00:	175000ef          	jal	ra,80204874 <memcmp>
    80203f04:	87aa                	mv	a5,a0
    80203f06:	c399                	beqz	a5,80203f0c <elf_load_ident+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:21
  {
    return (-1);
    80203f08:	57fd                	li	a5,-1
    80203f0a:	a801                	j	80203f1a <elf_load_ident+0x44>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:23
  }
  elf->ident = elf->raw_data;
    80203f0c:	fe843783          	ld	a5,-24(s0)
    80203f10:	6798                	ld	a4,8(a5)
    80203f12:	fe843783          	ld	a5,-24(s0)
    80203f16:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:24
  return (0);
    80203f18:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:25
}
    80203f1a:	853e                	mv	a0,a5
    80203f1c:	60e2                	ld	ra,24(sp)
    80203f1e:	6442                	ld	s0,16(sp)
    80203f20:	6105                	addi	sp,sp,32
    80203f22:	8082                	ret

0000000080203f24 <elf_load_header>:
elf_load_header():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:33
** Load the elf header in the elf structure.
** The identity is loaded first. Then, when the file class has been
** reconized, the entire header is loaded in the field 'elf->header'
*/
int elf_load_header(t_elf *elf)
{
    80203f24:	1101                	addi	sp,sp,-32
    80203f26:	ec06                	sd	ra,24(sp)
    80203f28:	e822                	sd	s0,16(sp)
    80203f2a:	1000                	addi	s0,sp,32
    80203f2c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:35
  // printk("eld load_header\n");
  if (elf_load_ident(elf) == -1)
    80203f30:	fe843503          	ld	a0,-24(s0)
    80203f34:	fa3ff0ef          	jal	ra,80203ed6 <elf_load_ident>
    80203f38:	87aa                	mv	a5,a0
    80203f3a:	873e                	mv	a4,a5
    80203f3c:	57fd                	li	a5,-1
    80203f3e:	00f71463          	bne	a4,a5,80203f46 <elf_load_header+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:36
    return (-1);
    80203f42:	57fd                	li	a5,-1
    80203f44:	a059                	j	80203fca <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:37
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80203f46:	fe843783          	ld	a5,-24(s0)
    80203f4a:	6b9c                	ld	a5,16(a5)
    80203f4c:	0047c703          	lbu	a4,4(a5)
    80203f50:	fe843783          	ld	a5,-24(s0)
    80203f54:	00e78c23          	sb	a4,24(a5)
    80203f58:	fe843783          	ld	a5,-24(s0)
    80203f5c:	0187c783          	lbu	a5,24(a5)
    80203f60:	873e                	mv	a4,a5
    80203f62:	4785                	li	a5,1
    80203f64:	00f70c63          	beq	a4,a5,80203f7c <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:38 (discriminator 1)
      elf->class != ELFCLASS64)
    80203f68:	fe843783          	ld	a5,-24(s0)
    80203f6c:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:37 (discriminator 1)
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80203f70:	873e                	mv	a4,a5
    80203f72:	4789                	li	a5,2
    80203f74:	00f70463          	beq	a4,a5,80203f7c <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:40
  {
    return (-1);
    80203f78:	57fd                	li	a5,-1
    80203f7a:	a881                	j	80203fca <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:42
  }
  elf->header = (t_elf_header *)elf->raw_data;
    80203f7c:	fe843783          	ld	a5,-24(s0)
    80203f80:	6798                	ld	a4,8(a5)
    80203f82:	fe843783          	ld	a5,-24(s0)
    80203f86:	f398                	sd	a4,32(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:43
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80203f88:	fe843783          	ld	a5,-24(s0)
    80203f8c:	0187c783          	lbu	a5,24(a5)
    80203f90:	873e                	mv	a4,a5
    80203f92:	4785                	li	a5,1
    80203f94:	00f71963          	bne	a4,a5,80203fa6 <elf_load_header+0x82>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:43 (discriminator 1)
    80203f98:	fe843783          	ld	a5,-24(s0)
    80203f9c:	6398                	ld	a4,0(a5)
    80203f9e:	03300793          	li	a5,51
    80203fa2:	02e7f163          	bgeu	a5,a4,80203fc4 <elf_load_header+0xa0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:44 (discriminator 3)
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr)))
    80203fa6:	fe843783          	ld	a5,-24(s0)
    80203faa:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:43 (discriminator 3)
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80203fae:	873e                	mv	a4,a5
    80203fb0:	4789                	li	a5,2
    80203fb2:	00f71b63          	bne	a4,a5,80203fc8 <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:44
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr)))
    80203fb6:	fe843783          	ld	a5,-24(s0)
    80203fba:	6398                	ld	a4,0(a5)
    80203fbc:	03f00793          	li	a5,63
    80203fc0:	00e7e463          	bltu	a5,a4,80203fc8 <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:46
  {
    return (-1);
    80203fc4:	57fd                	li	a5,-1
    80203fc6:	a011                	j	80203fca <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:49
  }
  // printk("eld load end\n");
  return (0);
    80203fc8:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_header.c:50
}
    80203fca:	853e                	mv	a0,a5
    80203fcc:	60e2                	ld	ra,24(sp)
    80203fce:	6442                	ld	s0,16(sp)
    80203fd0:	6105                	addi	sp,sp,32
    80203fd2:	8082                	ret

0000000080203fd4 <elf_load>:
elf_load():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:11
** Load the elf file present in the buffer.
** This function is used to parse elf file contained in a static library
** archive.
*/
int elf_load(uint8_t *elf_data, size_t elf_size, t_elf *elf)
{
    80203fd4:	7179                	addi	sp,sp,-48
    80203fd6:	f406                	sd	ra,40(sp)
    80203fd8:	f022                	sd	s0,32(sp)
    80203fda:	1800                	addi	s0,sp,48
    80203fdc:	fea43423          	sd	a0,-24(s0)
    80203fe0:	feb43023          	sd	a1,-32(s0)
    80203fe4:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:13
  // printk("elf load\n");
  memset(elf, 0, sizeof(t_elf));
    80203fe8:	6785                	lui	a5,0x1
    80203fea:	82878613          	addi	a2,a5,-2008 # 828 <n+0x808>
    80203fee:	4581                	li	a1,0
    80203ff0:	fd843503          	ld	a0,-40(s0)
    80203ff4:	049000ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:14
  elf->size = elf_size;
    80203ff8:	fd843783          	ld	a5,-40(s0)
    80203ffc:	fe043703          	ld	a4,-32(s0)
    80204000:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:15
  elf->raw_data = elf_data;
    80204002:	fd843783          	ld	a5,-40(s0)
    80204006:	fe843703          	ld	a4,-24(s0)
    8020400a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:17

  if (elf_load_header(elf) != 0)
    8020400c:	fd843503          	ld	a0,-40(s0)
    80204010:	f15ff0ef          	jal	ra,80203f24 <elf_load_header>
    80204014:	87aa                	mv	a5,a0
    80204016:	c399                	beqz	a5,8020401c <elf_load+0x48>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:19
  {
    return -1;
    80204018:	57fd                	li	a5,-1
    8020401a:	a015                	j	8020403e <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:22
  }

  if (elf_load_sections(elf) != 0)
    8020401c:	fd843503          	ld	a0,-40(s0)
    80204020:	b5fff0ef          	jal	ra,80203b7e <elf_load_sections>
    80204024:	87aa                	mv	a5,a0
    80204026:	c399                	beqz	a5,8020402c <elf_load+0x58>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:24
  {
    return -1;
    80204028:	57fd                	li	a5,-1
    8020402a:	a811                	j	8020403e <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:27
  }

  if (elf_load_programs(elf) != 0)
    8020402c:	fd843503          	ld	a0,-40(s0)
    80204030:	29c000ef          	jal	ra,802042cc <elf_load_programs>
    80204034:	87aa                	mv	a5,a0
    80204036:	c399                	beqz	a5,8020403c <elf_load+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:29
  {
    return -1;
    80204038:	57fd                	li	a5,-1
    8020403a:	a011                	j	8020403e <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:32
  }
  // printk("elf load end\n");
  return 0;
    8020403c:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load.c:33
}
    8020403e:	853e                	mv	a0,a5
    80204040:	70a2                	ld	ra,40(sp)
    80204042:	7402                	ld	s0,32(sp)
    80204044:	6145                	addi	sp,sp,48
    80204046:	8082                	ret

0000000080204048 <elf_section_get_type>:
elf_section_get_type():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:18

/*
** Get the section type.
*/
uint32_t elf_section_get_type(t_elf *elf, t_elf_section *section)
{
    80204048:	7179                	addi	sp,sp,-48
    8020404a:	f422                	sd	s0,40(sp)
    8020404c:	1800                	addi	s0,sp,48
    8020404e:	fca43c23          	sd	a0,-40(s0)
    80204052:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:21
  uint32_t type;

  if (ELF_IS_32(elf))
    80204056:	fd843783          	ld	a5,-40(s0)
    8020405a:	0187c783          	lbu	a5,24(a5)
    8020405e:	873e                	mv	a4,a5
    80204060:	4785                	li	a5,1
    80204062:	00f71963          	bne	a4,a5,80204074 <elf_section_get_type+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:22
    type = (uint32_t)section->header->_32.sh_type;
    80204066:	fd043783          	ld	a5,-48(s0)
    8020406a:	639c                	ld	a5,0(a5)
    8020406c:	43dc                	lw	a5,4(a5)
    8020406e:	fef42623          	sw	a5,-20(s0)
    80204072:	a039                	j	80204080 <elf_section_get_type+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:24
  else
    type = (uint32_t)section->header->_64.sh_type;
    80204074:	fd043783          	ld	a5,-48(s0)
    80204078:	639c                	ld	a5,0(a5)
    8020407a:	43dc                	lw	a5,4(a5)
    8020407c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:25
  return (type);
    80204080:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:26
}
    80204084:	853e                	mv	a0,a5
    80204086:	7422                	ld	s0,40(sp)
    80204088:	6145                	addi	sp,sp,48
    8020408a:	8082                	ret

000000008020408c <elf_section_get_offset>:
elf_section_get_offset():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:32

/*
** Get the section offset (from the begin of the file)
*/
size_t elf_section_get_offset(t_elf *elf, t_elf_section *section)
{
    8020408c:	7179                	addi	sp,sp,-48
    8020408e:	f422                	sd	s0,40(sp)
    80204090:	1800                	addi	s0,sp,48
    80204092:	fca43c23          	sd	a0,-40(s0)
    80204096:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:35
  size_t offset;

  if (ELF_IS_32(elf))
    8020409a:	fd843783          	ld	a5,-40(s0)
    8020409e:	0187c783          	lbu	a5,24(a5)
    802040a2:	873e                	mv	a4,a5
    802040a4:	4785                	li	a5,1
    802040a6:	00f71b63          	bne	a4,a5,802040bc <elf_section_get_offset+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:36
    offset = (size_t)section->header->_32.sh_offset;
    802040aa:	fd043783          	ld	a5,-48(s0)
    802040ae:	639c                	ld	a5,0(a5)
    802040b0:	4b9c                	lw	a5,16(a5)
    802040b2:	1782                	slli	a5,a5,0x20
    802040b4:	9381                	srli	a5,a5,0x20
    802040b6:	fef43423          	sd	a5,-24(s0)
    802040ba:	a039                	j	802040c8 <elf_section_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:38
  else
    offset = (size_t)section->header->_64.sh_offset;
    802040bc:	fd043783          	ld	a5,-48(s0)
    802040c0:	639c                	ld	a5,0(a5)
    802040c2:	6f9c                	ld	a5,24(a5)
    802040c4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:39
  return (offset);
    802040c8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:40
}
    802040cc:	853e                	mv	a0,a5
    802040ce:	7422                	ld	s0,40(sp)
    802040d0:	6145                	addi	sp,sp,48
    802040d2:	8082                	ret

00000000802040d4 <elf_section_get_size>:
elf_section_get_size():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:46

/*
** Get the size of the section
*/
size_t elf_section_get_size(t_elf *elf, t_elf_section *section)
{
    802040d4:	7179                	addi	sp,sp,-48
    802040d6:	f422                	sd	s0,40(sp)
    802040d8:	1800                	addi	s0,sp,48
    802040da:	fca43c23          	sd	a0,-40(s0)
    802040de:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:49
  size_t size;

  if (ELF_IS_32(elf))
    802040e2:	fd843783          	ld	a5,-40(s0)
    802040e6:	0187c783          	lbu	a5,24(a5)
    802040ea:	873e                	mv	a4,a5
    802040ec:	4785                	li	a5,1
    802040ee:	00f71b63          	bne	a4,a5,80204104 <elf_section_get_size+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:50
    size = (size_t)section->header->_32.sh_size;
    802040f2:	fd043783          	ld	a5,-48(s0)
    802040f6:	639c                	ld	a5,0(a5)
    802040f8:	4bdc                	lw	a5,20(a5)
    802040fa:	1782                	slli	a5,a5,0x20
    802040fc:	9381                	srli	a5,a5,0x20
    802040fe:	fef43423          	sd	a5,-24(s0)
    80204102:	a039                	j	80204110 <elf_section_get_size+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:52
  else
    size = (size_t)section->header->_64.sh_size;
    80204104:	fd043783          	ld	a5,-48(s0)
    80204108:	639c                	ld	a5,0(a5)
    8020410a:	739c                	ld	a5,32(a5)
    8020410c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:53
  return (size);
    80204110:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_section_get.c:54
}
    80204114:	853e                	mv	a0,a5
    80204116:	7422                	ld	s0,40(sp)
    80204118:	6145                	addi	sp,sp,48
    8020411a:	8082                	ret

000000008020411c <elf_header_get_phoff>:
elf_header_get_phoff():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:18

/*
** Get the program header table offset
*/
size_t elf_header_get_phoff(t_elf *elf)
{
    8020411c:	7179                	addi	sp,sp,-48
    8020411e:	f422                	sd	s0,40(sp)
    80204120:	1800                	addi	s0,sp,48
    80204122:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:21
  size_t phoff;

  if (ELF_IS_32(elf))
    80204126:	fd843783          	ld	a5,-40(s0)
    8020412a:	0187c783          	lbu	a5,24(a5)
    8020412e:	873e                	mv	a4,a5
    80204130:	4785                	li	a5,1
    80204132:	00f71b63          	bne	a4,a5,80204148 <elf_header_get_phoff+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:22
    phoff = (size_t)elf->header->_32.e_phoff;
    80204136:	fd843783          	ld	a5,-40(s0)
    8020413a:	739c                	ld	a5,32(a5)
    8020413c:	4fdc                	lw	a5,28(a5)
    8020413e:	1782                	slli	a5,a5,0x20
    80204140:	9381                	srli	a5,a5,0x20
    80204142:	fef43423          	sd	a5,-24(s0)
    80204146:	a039                	j	80204154 <elf_header_get_phoff+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:24
  else
    phoff = (size_t)elf->header->_64.e_phoff;
    80204148:	fd843783          	ld	a5,-40(s0)
    8020414c:	739c                	ld	a5,32(a5)
    8020414e:	739c                	ld	a5,32(a5)
    80204150:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:25
  return (phoff);
    80204154:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:26
}
    80204158:	853e                	mv	a0,a5
    8020415a:	7422                	ld	s0,40(sp)
    8020415c:	6145                	addi	sp,sp,48
    8020415e:	8082                	ret

0000000080204160 <elf_header_get_phentsize>:
elf_header_get_phentsize():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:32

/*
** Get the size of one program header
*/
size_t elf_header_get_phentsize(t_elf *elf)
{
    80204160:	7179                	addi	sp,sp,-48
    80204162:	f422                	sd	s0,40(sp)
    80204164:	1800                	addi	s0,sp,48
    80204166:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:35
  size_t phentsize;

  if (ELF_IS_32(elf))
    8020416a:	fd843783          	ld	a5,-40(s0)
    8020416e:	0187c783          	lbu	a5,24(a5)
    80204172:	873e                	mv	a4,a5
    80204174:	4785                	li	a5,1
    80204176:	00f71a63          	bne	a4,a5,8020418a <elf_header_get_phentsize+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:36
    phentsize = (size_t)elf->header->_32.e_phentsize;
    8020417a:	fd843783          	ld	a5,-40(s0)
    8020417e:	739c                	ld	a5,32(a5)
    80204180:	02a7d783          	lhu	a5,42(a5)
    80204184:	fef43423          	sd	a5,-24(s0)
    80204188:	a801                	j	80204198 <elf_header_get_phentsize+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:38
  else
    phentsize = (size_t)elf->header->_64.e_phentsize;
    8020418a:	fd843783          	ld	a5,-40(s0)
    8020418e:	739c                	ld	a5,32(a5)
    80204190:	0367d783          	lhu	a5,54(a5)
    80204194:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:39
  return (phentsize);
    80204198:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:40
}
    8020419c:	853e                	mv	a0,a5
    8020419e:	7422                	ld	s0,40(sp)
    802041a0:	6145                	addi	sp,sp,48
    802041a2:	8082                	ret

00000000802041a4 <elf_header_get_phnum>:
elf_header_get_phnum():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:46

/*
** Get the number of entry in the program header table
*/
size_t elf_header_get_phnum(t_elf *elf)
{
    802041a4:	7179                	addi	sp,sp,-48
    802041a6:	f422                	sd	s0,40(sp)
    802041a8:	1800                	addi	s0,sp,48
    802041aa:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:49
  size_t phnum;

  if (ELF_IS_32(elf))
    802041ae:	fd843783          	ld	a5,-40(s0)
    802041b2:	0187c783          	lbu	a5,24(a5)
    802041b6:	873e                	mv	a4,a5
    802041b8:	4785                	li	a5,1
    802041ba:	00f71a63          	bne	a4,a5,802041ce <elf_header_get_phnum+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:50
    phnum = (size_t)elf->header->_32.e_phnum;
    802041be:	fd843783          	ld	a5,-40(s0)
    802041c2:	739c                	ld	a5,32(a5)
    802041c4:	02c7d783          	lhu	a5,44(a5)
    802041c8:	fef43423          	sd	a5,-24(s0)
    802041cc:	a801                	j	802041dc <elf_header_get_phnum+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:52
  else
    phnum = (size_t)elf->header->_64.e_phnum;
    802041ce:	fd843783          	ld	a5,-40(s0)
    802041d2:	739c                	ld	a5,32(a5)
    802041d4:	0387d783          	lhu	a5,56(a5)
    802041d8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:53
  return (phnum);
    802041dc:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_header_get_ph.c:54
}
    802041e0:	853e                	mv	a0,a5
    802041e2:	7422                	ld	s0,40(sp)
    802041e4:	6145                	addi	sp,sp,48
    802041e6:	8082                	ret

00000000802041e8 <elf_load_programs_loop>:
elf_load_programs_loop():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:10
/*
** traverse the program header table and load each segment
*/
static int elf_load_programs_loop(t_elf *elf, size_t phoff, size_t phnum,
                                  size_t phentsize)
{
    802041e8:	715d                	addi	sp,sp,-80
    802041ea:	e486                	sd	ra,72(sp)
    802041ec:	e0a2                	sd	s0,64(sp)
    802041ee:	0880                	addi	s0,sp,80
    802041f0:	fca43423          	sd	a0,-56(s0)
    802041f4:	fcb43023          	sd	a1,-64(s0)
    802041f8:	fac43c23          	sd	a2,-72(s0)
    802041fc:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:15
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    80204200:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:16
  while (i < phnum)
    80204204:	a845                	j	802042b4 <elf_load_programs_loop+0xcc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:18
  {
    if (i >= MAX_PROGRAM_NUM)
    80204206:	fe843703          	ld	a4,-24(s0)
    8020420a:	03f00793          	li	a5,63
    8020420e:	00e7f463          	bgeu	a5,a4,80204216 <elf_load_programs_loop+0x2e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:20
    {
      return (-1);
    80204212:	57fd                	li	a5,-1
    80204214:	a07d                	j	802042c2 <elf_load_programs_loop+0xda>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:23
    }
    elf->programs[i].header =
        (union u_elf_ph *)(elf->raw_data + phoff + i * phentsize);
    80204216:	fc843783          	ld	a5,-56(s0)
    8020421a:	6798                	ld	a4,8(a5)
    8020421c:	fe843683          	ld	a3,-24(s0)
    80204220:	fb043783          	ld	a5,-80(s0)
    80204224:	02f686b3          	mul	a3,a3,a5
    80204228:	fc043783          	ld	a5,-64(s0)
    8020422c:	97b6                	add	a5,a5,a3
    8020422e:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:22
    elf->programs[i].header =
    80204230:	fc843683          	ld	a3,-56(s0)
    80204234:	fe843783          	ld	a5,-24(s0)
    80204238:	04278793          	addi	a5,a5,66
    8020423c:	0792                	slli	a5,a5,0x4
    8020423e:	97b6                	add	a5,a5,a3
    80204240:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:24
    type = elf_program_get_type(elf, &elf->programs[i]);
    80204242:	fe843783          	ld	a5,-24(s0)
    80204246:	04278793          	addi	a5,a5,66
    8020424a:	0792                	slli	a5,a5,0x4
    8020424c:	fc843703          	ld	a4,-56(s0)
    80204250:	97ba                	add	a5,a5,a4
    80204252:	07a1                	addi	a5,a5,8
    80204254:	85be                	mv	a1,a5
    80204256:	fc843503          	ld	a0,-56(s0)
    8020425a:	acdff0ef          	jal	ra,80203d26 <elf_program_get_type>
    8020425e:	87aa                	mv	a5,a0
    80204260:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:25
    if (type != PT_NULL)
    80204264:	fe442783          	lw	a5,-28(s0)
    80204268:	2781                	sext.w	a5,a5
    8020426a:	c3a1                	beqz	a5,802042aa <elf_load_programs_loop+0xc2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:27
    {
      content_offset = elf_program_get_offset(elf, &elf->programs[i]);
    8020426c:	fe843783          	ld	a5,-24(s0)
    80204270:	04278793          	addi	a5,a5,66
    80204274:	0792                	slli	a5,a5,0x4
    80204276:	fc843703          	ld	a4,-56(s0)
    8020427a:	97ba                	add	a5,a5,a4
    8020427c:	07a1                	addi	a5,a5,8
    8020427e:	85be                	mv	a1,a5
    80204280:	fc843503          	ld	a0,-56(s0)
    80204284:	ae7ff0ef          	jal	ra,80203d6a <elf_program_get_offset>
    80204288:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:28
      elf->programs[i].content = elf->raw_data + content_offset;
    8020428c:	fc843783          	ld	a5,-56(s0)
    80204290:	6798                	ld	a4,8(a5)
    80204292:	fd843783          	ld	a5,-40(s0)
    80204296:	973e                	add	a4,a4,a5
    80204298:	fc843683          	ld	a3,-56(s0)
    8020429c:	fe843783          	ld	a5,-24(s0)
    802042a0:	04278793          	addi	a5,a5,66
    802042a4:	0792                	slli	a5,a5,0x4
    802042a6:	97b6                	add	a5,a5,a3
    802042a8:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:30
    }
    i++;
    802042aa:	fe843783          	ld	a5,-24(s0)
    802042ae:	0785                	addi	a5,a5,1
    802042b0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:16
  while (i < phnum)
    802042b4:	fe843703          	ld	a4,-24(s0)
    802042b8:	fb843783          	ld	a5,-72(s0)
    802042bc:	f4f765e3          	bltu	a4,a5,80204206 <elf_load_programs_loop+0x1e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:32
  }
  return (0);
    802042c0:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:33
}
    802042c2:	853e                	mv	a0,a5
    802042c4:	60a6                	ld	ra,72(sp)
    802042c6:	6406                	ld	s0,64(sp)
    802042c8:	6161                	addi	sp,sp,80
    802042ca:	8082                	ret

00000000802042cc <elf_load_programs>:
elf_load_programs():
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:40
/*
** Load programs. Create a table of t_elf_program in elf->programs.
** This table is null if there is no program header table.
*/
int elf_load_programs(t_elf *elf)
{
    802042cc:	7139                	addi	sp,sp,-64
    802042ce:	fc06                	sd	ra,56(sp)
    802042d0:	f822                	sd	s0,48(sp)
    802042d2:	0080                	addi	s0,sp,64
    802042d4:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:45
  size_t phoff;
  size_t phnum;
  size_t phentsize;

  if ((phoff = elf_header_get_phoff(elf)) > 0)
    802042d8:	fc843503          	ld	a0,-56(s0)
    802042dc:	e41ff0ef          	jal	ra,8020411c <elf_header_get_phoff>
    802042e0:	fea43423          	sd	a0,-24(s0)
    802042e4:	fe843783          	ld	a5,-24(s0)
    802042e8:	cfb1                	beqz	a5,80204344 <elf_load_programs+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:47
  {
    phnum = elf_header_get_phnum(elf);
    802042ea:	fc843503          	ld	a0,-56(s0)
    802042ee:	eb7ff0ef          	jal	ra,802041a4 <elf_header_get_phnum>
    802042f2:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:48
    phentsize = elf_header_get_phentsize(elf);
    802042f6:	fc843503          	ld	a0,-56(s0)
    802042fa:	e67ff0ef          	jal	ra,80204160 <elf_header_get_phentsize>
    802042fe:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:49
    if (phoff + phnum * phentsize > elf->size)
    80204302:	fe043703          	ld	a4,-32(s0)
    80204306:	fd843783          	ld	a5,-40(s0)
    8020430a:	02f70733          	mul	a4,a4,a5
    8020430e:	fe843783          	ld	a5,-24(s0)
    80204312:	973e                	add	a4,a4,a5
    80204314:	fc843783          	ld	a5,-56(s0)
    80204318:	639c                	ld	a5,0(a5)
    8020431a:	00e7f463          	bgeu	a5,a4,80204322 <elf_load_programs+0x56>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:51
    {
      return (-1);
    8020431e:	57fd                	li	a5,-1
    80204320:	a82d                	j	8020435a <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:53
    }
    if (elf_load_programs_loop(elf, phoff, phnum, phentsize) == -1)
    80204322:	fd843683          	ld	a3,-40(s0)
    80204326:	fe043603          	ld	a2,-32(s0)
    8020432a:	fe843583          	ld	a1,-24(s0)
    8020432e:	fc843503          	ld	a0,-56(s0)
    80204332:	eb7ff0ef          	jal	ra,802041e8 <elf_load_programs_loop>
    80204336:	87aa                	mv	a5,a0
    80204338:	873e                	mv	a4,a5
    8020433a:	57fd                	li	a5,-1
    8020433c:	00f71e63          	bne	a4,a5,80204358 <elf_load_programs+0x8c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:55
    {
      return (-1);
    80204340:	57fd                	li	a5,-1
    80204342:	a821                	j	8020435a <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:59
    }
  }
  else
    memset(elf->programs, 0, MAX_PROGRAM_NUM * sizeof(t_elf_program));
    80204344:	fc843783          	ld	a5,-56(s0)
    80204348:	42878793          	addi	a5,a5,1064
    8020434c:	40000613          	li	a2,1024
    80204350:	4581                	li	a1,0
    80204352:	853e                	mv	a0,a5
    80204354:	4e8000ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:60
  return (0);
    80204358:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/elf/elf_load_programs.c:61
}
    8020435a:	853e                	mv	a0,a5
    8020435c:	70e2                	ld	ra,56(sp)
    8020435e:	7442                	ld	s0,48(sp)
    80204360:	6121                	addi	sp,sp,64
    80204362:	8082                	ret

0000000080204364 <sbi_call>:
sbi_call():
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:14
#define SBI_REMOTE_SFENCE_VMA 6
#define SBI_REMOTE_SFENCE_VMA_ASID 7
#define SBI_SHUTDOWN 8

static inline uint64_t sbi_call(long which, long arg0, long arg1, long arg2)
{
    80204364:	7179                	addi	sp,sp,-48
    80204366:	f422                	sd	s0,40(sp)
    80204368:	1800                	addi	s0,sp,48
    8020436a:	fea43423          	sd	a0,-24(s0)
    8020436e:	feb43023          	sd	a1,-32(s0)
    80204372:	fcc43c23          	sd	a2,-40(s0)
    80204376:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:15
    register long a0 asm("a0") = arg0;
    8020437a:	fe043503          	ld	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:16
    register long a1 asm("a1") = arg1;
    8020437e:	fd843583          	ld	a1,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:17
    register long a2 asm("a2") = arg2;
    80204382:	fd043603          	ld	a2,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:18
    register long a7 asm("a7") = which;
    80204386:	fe843883          	ld	a7,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:20

    asm volatile("ecall"
    8020438a:	00000073          	ecall
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:25
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");

    return a0;
    8020438e:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:26
}
    80204390:	853e                	mv	a0,a5
    80204392:	7422                	ld	s0,40(sp)
    80204394:	6145                	addi	sp,sp,48
    80204396:	8082                	ret

0000000080204398 <console_putchar>:
console_putchar():
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:29

void console_putchar(uint64_t ch)
{
    80204398:	1101                	addi	sp,sp,-32
    8020439a:	ec06                	sd	ra,24(sp)
    8020439c:	e822                	sd	s0,16(sp)
    8020439e:	1000                	addi	s0,sp,32
    802043a0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:30
    sbi_call(0x01, ch, 0, 0);
    802043a4:	fe843783          	ld	a5,-24(s0)
    802043a8:	4681                	li	a3,0
    802043aa:	4601                	li	a2,0
    802043ac:	85be                	mv	a1,a5
    802043ae:	4505                	li	a0,1
    802043b0:	fb5ff0ef          	jal	ra,80204364 <sbi_call>
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:31
}
    802043b4:	0001                	nop
    802043b6:	60e2                	ld	ra,24(sp)
    802043b8:	6442                	ld	s0,16(sp)
    802043ba:	6105                	addi	sp,sp,32
    802043bc:	8082                	ret

00000000802043be <console_getchar>:
console_getchar():
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:34

uint64_t console_getchar(void)
{
    802043be:	1141                	addi	sp,sp,-16
    802043c0:	e406                	sd	ra,8(sp)
    802043c2:	e022                	sd	s0,0(sp)
    802043c4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:35
    return sbi_call(0x02, 0, 0, 0);
    802043c6:	4681                	li	a3,0
    802043c8:	4601                	li	a2,0
    802043ca:	4581                	li	a1,0
    802043cc:	4509                	li	a0,2
    802043ce:	f97ff0ef          	jal	ra,80204364 <sbi_call>
    802043d2:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:36
}
    802043d4:	853e                	mv	a0,a5
    802043d6:	60a2                	ld	ra,8(sp)
    802043d8:	6402                	ld	s0,0(sp)
    802043da:	0141                	addi	sp,sp,16
    802043dc:	8082                	ret

00000000802043de <sbi_shutdown>:
sbi_shutdown():
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:39

uint64_t sbi_shutdown(void)
{
    802043de:	1141                	addi	sp,sp,-16
    802043e0:	e406                	sd	ra,8(sp)
    802043e2:	e022                	sd	s0,0(sp)
    802043e4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:40
    return sbi_call(0x08, 0, 0, 0);
    802043e6:	4681                	li	a3,0
    802043e8:	4601                	li	a2,0
    802043ea:	4581                	li	a1,0
    802043ec:	4521                	li	a0,8
    802043ee:	f77ff0ef          	jal	ra,80204364 <sbi_call>
    802043f2:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:41
}
    802043f4:	853e                	mv	a0,a5
    802043f6:	60a2                	ld	ra,8(sp)
    802043f8:	6402                	ld	s0,0(sp)
    802043fa:	0141                	addi	sp,sp,16
    802043fc:	8082                	ret

00000000802043fe <sbi_set_timer>:
sbi_set_timer():
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:44

uint64_t sbi_set_timer(uint64_t stime_value)
{
    802043fe:	1101                	addi	sp,sp,-32
    80204400:	ec06                	sd	ra,24(sp)
    80204402:	e822                	sd	s0,16(sp)
    80204404:	1000                	addi	s0,sp,32
    80204406:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:45
    return sbi_call(0x00, stime_value, 0, 0);
    8020440a:	fe843783          	ld	a5,-24(s0)
    8020440e:	4681                	li	a3,0
    80204410:	4601                	li	a2,0
    80204412:	85be                	mv	a1,a5
    80204414:	4501                	li	a0,0
    80204416:	f4fff0ef          	jal	ra,80204364 <sbi_call>
    8020441a:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/sbi/sbi.c:46
    8020441c:	853e                	mv	a0,a5
    8020441e:	60e2                	ld	ra,24(sp)
    80204420:	6442                	ld	s0,16(sp)
    80204422:	6105                	addi	sp,sp,32
    80204424:	8082                	ret

0000000080204426 <strlen_t>:
strlen_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:5

#include "string.h"

int strlen_t(const char *src)
{
    80204426:	7179                	addi	sp,sp,-48
    80204428:	f422                	sd	s0,40(sp)
    8020442a:	1800                	addi	s0,sp,48
    8020442c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:7
    int i;
    for (i = 0; src[i] != '\0'; i++)
    80204430:	fe042623          	sw	zero,-20(s0)
    80204434:	a031                	j	80204440 <strlen_t+0x1a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:7 (discriminator 3)
    80204436:	fec42783          	lw	a5,-20(s0)
    8020443a:	2785                	addiw	a5,a5,1
    8020443c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:7 (discriminator 1)
    80204440:	fec42783          	lw	a5,-20(s0)
    80204444:	fd843703          	ld	a4,-40(s0)
    80204448:	97ba                	add	a5,a5,a4
    8020444a:	0007c783          	lbu	a5,0(a5)
    8020444e:	f7e5                	bnez	a5,80204436 <strlen_t+0x10>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:10
    {
    }
    return i;
    80204450:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:11
}
    80204454:	853e                	mv	a0,a5
    80204456:	7422                	ld	s0,40(sp)
    80204458:	6145                	addi	sp,sp,48
    8020445a:	8082                	ret

000000008020445c <memcpy_t>:
memcpy_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:14

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    8020445c:	7179                	addi	sp,sp,-48
    8020445e:	f422                	sd	s0,40(sp)
    80204460:	1800                	addi	s0,sp,48
    80204462:	fea43423          	sd	a0,-24(s0)
    80204466:	feb43023          	sd	a1,-32(s0)
    8020446a:	87b2                	mv	a5,a2
    8020446c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:15
    for (; len != 0; len--)
    80204470:	a035                	j	8020449c <memcpy_t+0x40>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:17 (discriminator 2)
    {
        *dest++ = *src++;
    80204472:	fe043703          	ld	a4,-32(s0)
    80204476:	00170793          	addi	a5,a4,1
    8020447a:	fef43023          	sd	a5,-32(s0)
    8020447e:	fe843783          	ld	a5,-24(s0)
    80204482:	00178693          	addi	a3,a5,1
    80204486:	fed43423          	sd	a3,-24(s0)
    8020448a:	00074703          	lbu	a4,0(a4)
    8020448e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:15 (discriminator 2)
    for (; len != 0; len--)
    80204492:	fdc42783          	lw	a5,-36(s0)
    80204496:	37fd                	addiw	a5,a5,-1
    80204498:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:15 (discriminator 1)
    8020449c:	fdc42783          	lw	a5,-36(s0)
    802044a0:	2781                	sext.w	a5,a5
    802044a2:	fbe1                	bnez	a5,80204472 <memcpy_t+0x16>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:19
    }
}
    802044a4:	0001                	nop
    802044a6:	0001                	nop
    802044a8:	7422                	ld	s0,40(sp)
    802044aa:	6145                	addi	sp,sp,48
    802044ac:	8082                	ret

00000000802044ae <memcmp_t>:
memcmp_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:22

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    802044ae:	7139                	addi	sp,sp,-64
    802044b0:	fc22                	sd	s0,56(sp)
    802044b2:	0080                	addi	s0,sp,64
    802044b4:	fca43c23          	sd	a0,-40(s0)
    802044b8:	fcb43823          	sd	a1,-48(s0)
    802044bc:	87b2                	mv	a5,a2
    802044be:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:23
    for (int i = 0; i < num; ++i)
    802044c2:	fe042623          	sw	zero,-20(s0)
    802044c6:	a8a1                	j	8020451e <memcmp_t+0x70>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:25
    {
        if (((char *)ptr1)[i] != ((char *)ptr2)[i])
    802044c8:	fec42783          	lw	a5,-20(s0)
    802044cc:	fd843703          	ld	a4,-40(s0)
    802044d0:	97ba                	add	a5,a5,a4
    802044d2:	0007c683          	lbu	a3,0(a5)
    802044d6:	fec42783          	lw	a5,-20(s0)
    802044da:	fd043703          	ld	a4,-48(s0)
    802044de:	97ba                	add	a5,a5,a4
    802044e0:	0007c783          	lbu	a5,0(a5)
    802044e4:	8736                	mv	a4,a3
    802044e6:	02f70763          	beq	a4,a5,80204514 <memcmp_t+0x66>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:27
        {
            return ((char *)ptr1)[i] - ((char *)ptr2)[i];
    802044ea:	fec42783          	lw	a5,-20(s0)
    802044ee:	fd843703          	ld	a4,-40(s0)
    802044f2:	97ba                	add	a5,a5,a4
    802044f4:	0007c783          	lbu	a5,0(a5)
    802044f8:	0007871b          	sext.w	a4,a5
    802044fc:	fec42783          	lw	a5,-20(s0)
    80204500:	fd043683          	ld	a3,-48(s0)
    80204504:	97b6                	add	a5,a5,a3
    80204506:	0007c783          	lbu	a5,0(a5)
    8020450a:	2781                	sext.w	a5,a5
    8020450c:	40f707bb          	subw	a5,a4,a5
    80204510:	2781                	sext.w	a5,a5
    80204512:	a831                	j	8020452e <memcmp_t+0x80>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:23 (discriminator 2)
    for (int i = 0; i < num; ++i)
    80204514:	fec42783          	lw	a5,-20(s0)
    80204518:	2785                	addiw	a5,a5,1
    8020451a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:23 (discriminator 1)
    8020451e:	fec42703          	lw	a4,-20(s0)
    80204522:	fcc42783          	lw	a5,-52(s0)
    80204526:	2781                	sext.w	a5,a5
    80204528:	faf760e3          	bltu	a4,a5,802044c8 <memcmp_t+0x1a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:30
        }
    }
    return 0;
    8020452c:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:31
}
    8020452e:	853e                	mv	a0,a5
    80204530:	7462                	ld	s0,56(sp)
    80204532:	6121                	addi	sp,sp,64
    80204534:	8082                	ret

0000000080204536 <memmove_t>:
memmove_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:34

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    80204536:	715d                	addi	sp,sp,-80
    80204538:	e4a2                	sd	s0,72(sp)
    8020453a:	0880                	addi	s0,sp,80
    8020453c:	fca43423          	sd	a0,-56(s0)
    80204540:	fcb43023          	sd	a1,-64(s0)
    80204544:	86b2                	mv	a3,a2
    80204546:	fad42e23          	sw	a3,-68(s0)
    8020454a:	868a                	mv	a3,sp
    8020454c:	85b6                	mv	a1,a3
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:35
    u8 temp[len];
    8020454e:	fbc42683          	lw	a3,-68(s0)
    80204552:	02069613          	slli	a2,a3,0x20
    80204556:	9201                	srli	a2,a2,0x20
    80204558:	167d                	addi	a2,a2,-1
    8020455a:	fec43423          	sd	a2,-24(s0)
    8020455e:	02069613          	slli	a2,a3,0x20
    80204562:	9201                	srli	a2,a2,0x20
    80204564:	8e32                	mv	t3,a2
    80204566:	4e81                	li	t4,0
    80204568:	03de5613          	srli	a2,t3,0x3d
    8020456c:	003e9893          	slli	a7,t4,0x3
    80204570:	011668b3          	or	a7,a2,a7
    80204574:	003e1813          	slli	a6,t3,0x3
    80204578:	02069613          	slli	a2,a3,0x20
    8020457c:	9201                	srli	a2,a2,0x20
    8020457e:	8332                	mv	t1,a2
    80204580:	4381                	li	t2,0
    80204582:	03d35613          	srli	a2,t1,0x3d
    80204586:	00339793          	slli	a5,t2,0x3
    8020458a:	8fd1                	or	a5,a5,a2
    8020458c:	00331713          	slli	a4,t1,0x3
    80204590:	02069793          	slli	a5,a3,0x20
    80204594:	9381                	srli	a5,a5,0x20
    80204596:	07bd                	addi	a5,a5,15
    80204598:	8391                	srli	a5,a5,0x4
    8020459a:	0792                	slli	a5,a5,0x4
    8020459c:	40f10133          	sub	sp,sp,a5
    802045a0:	878a                	mv	a5,sp
    802045a2:	00078793          	mv	a5,a5
    802045a6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:37
    i32 i;
    for (i = 0; len != 0; len--)
    802045aa:	fc042e23          	sw	zero,-36(s0)
    802045ae:	a02d                	j	802045d8 <memmove_t+0xa2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:39 (discriminator 3)
    {
        temp[i] = *src++;
    802045b0:	fc043783          	ld	a5,-64(s0)
    802045b4:	00178713          	addi	a4,a5,1
    802045b8:	fce43023          	sd	a4,-64(s0)
    802045bc:	0007c703          	lbu	a4,0(a5)
    802045c0:	fe043683          	ld	a3,-32(s0)
    802045c4:	fdc42783          	lw	a5,-36(s0)
    802045c8:	97b6                	add	a5,a5,a3
    802045ca:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:37 (discriminator 3)
    for (i = 0; len != 0; len--)
    802045ce:	fbc42783          	lw	a5,-68(s0)
    802045d2:	37fd                	addiw	a5,a5,-1
    802045d4:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:37 (discriminator 1)
    802045d8:	fbc42783          	lw	a5,-68(s0)
    802045dc:	2781                	sext.w	a5,a5
    802045de:	fbe9                	bnez	a5,802045b0 <memmove_t+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:41
    }
    for (; len != 0; len--)
    802045e0:	a02d                	j	8020460a <memmove_t+0xd4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:43 (discriminator 2)
    {
        *dest++ = temp[i];
    802045e2:	fc843783          	ld	a5,-56(s0)
    802045e6:	00178713          	addi	a4,a5,1
    802045ea:	fce43423          	sd	a4,-56(s0)
    802045ee:	fe043683          	ld	a3,-32(s0)
    802045f2:	fdc42703          	lw	a4,-36(s0)
    802045f6:	9736                	add	a4,a4,a3
    802045f8:	00074703          	lbu	a4,0(a4)
    802045fc:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:41 (discriminator 2)
    for (; len != 0; len--)
    80204600:	fbc42783          	lw	a5,-68(s0)
    80204604:	37fd                	addiw	a5,a5,-1
    80204606:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:41 (discriminator 1)
    8020460a:	fbc42783          	lw	a5,-68(s0)
    8020460e:	2781                	sext.w	a5,a5
    80204610:	fbe9                	bnez	a5,802045e2 <memmove_t+0xac>
    80204612:	812e                	mv	sp,a1
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:45
    }
}
    80204614:	0001                	nop
    80204616:	fb040113          	addi	sp,s0,-80
    8020461a:	6426                	ld	s0,72(sp)
    8020461c:	6161                	addi	sp,sp,80
    8020461e:	8082                	ret

0000000080204620 <memset_t>:
memset_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:48

void memset_t(void *dest, u8 val, u32 len)
{
    80204620:	7179                	addi	sp,sp,-48
    80204622:	f422                	sd	s0,40(sp)
    80204624:	1800                	addi	s0,sp,48
    80204626:	fca43c23          	sd	a0,-40(s0)
    8020462a:	87ae                	mv	a5,a1
    8020462c:	8732                	mv	a4,a2
    8020462e:	fcf40ba3          	sb	a5,-41(s0)
    80204632:	87ba                	mv	a5,a4
    80204634:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:49
    u8 *dst = (u8 *)dest;
    80204638:	fd843783          	ld	a5,-40(s0)
    8020463c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:51

    for (; len != 0; len--)
    80204640:	a005                	j	80204660 <memset_t+0x40>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:53 (discriminator 2)
    {
        *dst++ = val;
    80204642:	fe843783          	ld	a5,-24(s0)
    80204646:	00178713          	addi	a4,a5,1
    8020464a:	fee43423          	sd	a4,-24(s0)
    8020464e:	fd744703          	lbu	a4,-41(s0)
    80204652:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:51 (discriminator 2)
    for (; len != 0; len--)
    80204656:	fd042783          	lw	a5,-48(s0)
    8020465a:	37fd                	addiw	a5,a5,-1
    8020465c:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:51 (discriminator 1)
    80204660:	fd042783          	lw	a5,-48(s0)
    80204664:	2781                	sext.w	a5,a5
    80204666:	fff1                	bnez	a5,80204642 <memset_t+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:55
    }
}
    80204668:	0001                	nop
    8020466a:	0001                	nop
    8020466c:	7422                	ld	s0,40(sp)
    8020466e:	6145                	addi	sp,sp,48
    80204670:	8082                	ret

0000000080204672 <bzero_t>:
bzero_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:57

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }
    80204672:	1101                	addi	sp,sp,-32
    80204674:	ec06                	sd	ra,24(sp)
    80204676:	e822                	sd	s0,16(sp)
    80204678:	1000                	addi	s0,sp,32
    8020467a:	fea43423          	sd	a0,-24(s0)
    8020467e:	87ae                	mv	a5,a1
    80204680:	fef42223          	sw	a5,-28(s0)
    80204684:	fe442783          	lw	a5,-28(s0)
    80204688:	863e                	mv	a2,a5
    8020468a:	4581                	li	a1,0
    8020468c:	fe843503          	ld	a0,-24(s0)
    80204690:	f91ff0ef          	jal	ra,80204620 <memset_t>
    80204694:	0001                	nop
    80204696:	60e2                	ld	ra,24(sp)
    80204698:	6442                	ld	s0,16(sp)
    8020469a:	6105                	addi	sp,sp,32
    8020469c:	8082                	ret

000000008020469e <strcmp_t>:
strcmp_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:60

int strcmp_t(const char *str1, const char *str2)
{
    8020469e:	1101                	addi	sp,sp,-32
    802046a0:	ec22                	sd	s0,24(sp)
    802046a2:	1000                	addi	s0,sp,32
    802046a4:	fea43423          	sd	a0,-24(s0)
    802046a8:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:61
    while (*str1 && *str2)
    802046ac:	a0a1                	j	802046f4 <strcmp_t+0x56>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:63
    {
        if (*str1 != *str2)
    802046ae:	fe843783          	ld	a5,-24(s0)
    802046b2:	0007c703          	lbu	a4,0(a5)
    802046b6:	fe043783          	ld	a5,-32(s0)
    802046ba:	0007c783          	lbu	a5,0(a5)
    802046be:	02f70163          	beq	a4,a5,802046e0 <strcmp_t+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:65
        {
            return (*str1) - (*str2);
    802046c2:	fe843783          	ld	a5,-24(s0)
    802046c6:	0007c783          	lbu	a5,0(a5)
    802046ca:	0007871b          	sext.w	a4,a5
    802046ce:	fe043783          	ld	a5,-32(s0)
    802046d2:	0007c783          	lbu	a5,0(a5)
    802046d6:	2781                	sext.w	a5,a5
    802046d8:	40f707bb          	subw	a5,a4,a5
    802046dc:	2781                	sext.w	a5,a5
    802046de:	a099                	j	80204724 <strcmp_t+0x86>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:67
        }
        ++str1;
    802046e0:	fe843783          	ld	a5,-24(s0)
    802046e4:	0785                	addi	a5,a5,1
    802046e6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:68
        ++str2;
    802046ea:	fe043783          	ld	a5,-32(s0)
    802046ee:	0785                	addi	a5,a5,1
    802046f0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:61
    while (*str1 && *str2)
    802046f4:	fe843783          	ld	a5,-24(s0)
    802046f8:	0007c783          	lbu	a5,0(a5)
    802046fc:	c791                	beqz	a5,80204708 <strcmp_t+0x6a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:61 (discriminator 1)
    802046fe:	fe043783          	ld	a5,-32(s0)
    80204702:	0007c783          	lbu	a5,0(a5)
    80204706:	f7c5                	bnez	a5,802046ae <strcmp_t+0x10>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:70
    }
    return (*str1) - (*str2);
    80204708:	fe843783          	ld	a5,-24(s0)
    8020470c:	0007c783          	lbu	a5,0(a5)
    80204710:	0007871b          	sext.w	a4,a5
    80204714:	fe043783          	ld	a5,-32(s0)
    80204718:	0007c783          	lbu	a5,0(a5)
    8020471c:	2781                	sext.w	a5,a5
    8020471e:	40f707bb          	subw	a5,a4,a5
    80204722:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:71
}
    80204724:	853e                	mv	a0,a5
    80204726:	6462                	ld	s0,24(sp)
    80204728:	6105                	addi	sp,sp,32
    8020472a:	8082                	ret

000000008020472c <strcpy_t>:
strcpy_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:74

char *strcpy_t(char *dest, const char *src)
{
    8020472c:	7179                	addi	sp,sp,-48
    8020472e:	f422                	sd	s0,40(sp)
    80204730:	1800                	addi	s0,sp,48
    80204732:	fca43c23          	sd	a0,-40(s0)
    80204736:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:75
    char *tmp = dest;
    8020473a:	fd843783          	ld	a5,-40(s0)
    8020473e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:77

    while (*src)
    80204742:	a00d                	j	80204764 <strcpy_t+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:79
    {
        *dest++ = *src++;
    80204744:	fd043703          	ld	a4,-48(s0)
    80204748:	00170793          	addi	a5,a4,1
    8020474c:	fcf43823          	sd	a5,-48(s0)
    80204750:	fd843783          	ld	a5,-40(s0)
    80204754:	00178693          	addi	a3,a5,1
    80204758:	fcd43c23          	sd	a3,-40(s0)
    8020475c:	00074703          	lbu	a4,0(a4)
    80204760:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:77
    while (*src)
    80204764:	fd043783          	ld	a5,-48(s0)
    80204768:	0007c783          	lbu	a5,0(a5)
    8020476c:	ffe1                	bnez	a5,80204744 <strcpy_t+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:82
    }

    *dest = '\0';
    8020476e:	fd843783          	ld	a5,-40(s0)
    80204772:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:84

    return tmp;
    80204776:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:85
}
    8020477a:	853e                	mv	a0,a5
    8020477c:	7422                	ld	s0,40(sp)
    8020477e:	6145                	addi	sp,sp,48
    80204780:	8082                	ret

0000000080204782 <strcat_t>:
strcat_t():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:88

char *strcat_t(char *dest, const char *src)
{
    80204782:	7179                	addi	sp,sp,-48
    80204784:	f422                	sd	s0,40(sp)
    80204786:	1800                	addi	s0,sp,48
    80204788:	fca43c23          	sd	a0,-40(s0)
    8020478c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:89
    char *tmp = dest;
    80204790:	fd843783          	ld	a5,-40(s0)
    80204794:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:91

    while (*dest != '\0')
    80204798:	a031                	j	802047a4 <strcat_t+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:93
    {
        dest++;
    8020479a:	fd843783          	ld	a5,-40(s0)
    8020479e:	0785                	addi	a5,a5,1
    802047a0:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:91
    while (*dest != '\0')
    802047a4:	fd843783          	ld	a5,-40(s0)
    802047a8:	0007c783          	lbu	a5,0(a5)
    802047ac:	f7fd                	bnez	a5,8020479a <strcat_t+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:95
    }
    while (*src)
    802047ae:	a00d                	j	802047d0 <strcat_t+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:97
    {
        *dest++ = *src++;
    802047b0:	fd043703          	ld	a4,-48(s0)
    802047b4:	00170793          	addi	a5,a4,1
    802047b8:	fcf43823          	sd	a5,-48(s0)
    802047bc:	fd843783          	ld	a5,-40(s0)
    802047c0:	00178693          	addi	a3,a5,1
    802047c4:	fcd43c23          	sd	a3,-40(s0)
    802047c8:	00074703          	lbu	a4,0(a4)
    802047cc:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:95
    while (*src)
    802047d0:	fd043783          	ld	a5,-48(s0)
    802047d4:	0007c783          	lbu	a5,0(a5)
    802047d8:	ffe1                	bnez	a5,802047b0 <strcat_t+0x2e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:100
    }

    *dest = '\0';
    802047da:	fd843783          	ld	a5,-40(s0)
    802047de:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:102

    return tmp;
    802047e2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:103
}
    802047e6:	853e                	mv	a0,a5
    802047e8:	7422                	ld	s0,40(sp)
    802047ea:	6145                	addi	sp,sp,48
    802047ec:	8082                	ret

00000000802047ee <memcpy>:
memcpy():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:106

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    802047ee:	7179                	addi	sp,sp,-48
    802047f0:	f422                	sd	s0,40(sp)
    802047f2:	1800                	addi	s0,sp,48
    802047f4:	fea43423          	sd	a0,-24(s0)
    802047f8:	feb43023          	sd	a1,-32(s0)
    802047fc:	87b2                	mv	a5,a2
    802047fe:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:107
    while (len--)
    80204802:	a00d                	j	80204824 <memcpy+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:109
    {
        *dest++ = *src++;
    80204804:	fe043703          	ld	a4,-32(s0)
    80204808:	00170793          	addi	a5,a4,1
    8020480c:	fef43023          	sd	a5,-32(s0)
    80204810:	fe843783          	ld	a5,-24(s0)
    80204814:	00178693          	addi	a3,a5,1
    80204818:	fed43423          	sd	a3,-24(s0)
    8020481c:	00074703          	lbu	a4,0(a4)
    80204820:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:107
    while (len--)
    80204824:	fdc42783          	lw	a5,-36(s0)
    80204828:	fff7871b          	addiw	a4,a5,-1
    8020482c:	fce42e23          	sw	a4,-36(s0)
    80204830:	fbf1                	bnez	a5,80204804 <memcpy+0x16>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:111
    }
}
    80204832:	0001                	nop
    80204834:	0001                	nop
    80204836:	7422                	ld	s0,40(sp)
    80204838:	6145                	addi	sp,sp,48
    8020483a:	8082                	ret

000000008020483c <memset>:
memset():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:114

void memset(void *dest, u8 val, u32 len)
{
    8020483c:	1101                	addi	sp,sp,-32
    8020483e:	ec06                	sd	ra,24(sp)
    80204840:	e822                	sd	s0,16(sp)
    80204842:	1000                	addi	s0,sp,32
    80204844:	fea43423          	sd	a0,-24(s0)
    80204848:	87ae                	mv	a5,a1
    8020484a:	8732                	mv	a4,a2
    8020484c:	fef403a3          	sb	a5,-25(s0)
    80204850:	87ba                	mv	a5,a4
    80204852:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:115
    memset_t(dest, val, len);
    80204856:	fe042703          	lw	a4,-32(s0)
    8020485a:	fe744783          	lbu	a5,-25(s0)
    8020485e:	863a                	mv	a2,a4
    80204860:	85be                	mv	a1,a5
    80204862:	fe843503          	ld	a0,-24(s0)
    80204866:	dbbff0ef          	jal	ra,80204620 <memset_t>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:116
}
    8020486a:	0001                	nop
    8020486c:	60e2                	ld	ra,24(sp)
    8020486e:	6442                	ld	s0,16(sp)
    80204870:	6105                	addi	sp,sp,32
    80204872:	8082                	ret

0000000080204874 <memcmp>:
memcmp():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:118
int memcmp(const void *ptr1, const void *ptr2, size_t num)
{
    80204874:	715d                	addi	sp,sp,-80
    80204876:	e4a2                	sd	s0,72(sp)
    80204878:	0880                	addi	s0,sp,80
    8020487a:	fca43423          	sd	a0,-56(s0)
    8020487e:	fcb43023          	sd	a1,-64(s0)
    80204882:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:119
    const unsigned char *p1 = ptr1, *p2 = ptr2;
    80204886:	fc843783          	ld	a5,-56(s0)
    8020488a:	fef43023          	sd	a5,-32(s0)
    8020488e:	fc043783          	ld	a5,-64(s0)
    80204892:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:120
    for (size_t i = 0; i < num; i++)
    80204896:	fe043423          	sd	zero,-24(s0)
    8020489a:	a8a1                	j	802048f2 <memcmp+0x7e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:122
    {
        if (p1[i] != p2[i])
    8020489c:	fe043703          	ld	a4,-32(s0)
    802048a0:	fe843783          	ld	a5,-24(s0)
    802048a4:	97ba                	add	a5,a5,a4
    802048a6:	0007c683          	lbu	a3,0(a5)
    802048aa:	fd843703          	ld	a4,-40(s0)
    802048ae:	fe843783          	ld	a5,-24(s0)
    802048b2:	97ba                	add	a5,a5,a4
    802048b4:	0007c783          	lbu	a5,0(a5)
    802048b8:	8736                	mv	a4,a3
    802048ba:	02f70763          	beq	a4,a5,802048e8 <memcmp+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:124
        {
            return (int)p1[i] - (int)p2[i];
    802048be:	fe043703          	ld	a4,-32(s0)
    802048c2:	fe843783          	ld	a5,-24(s0)
    802048c6:	97ba                	add	a5,a5,a4
    802048c8:	0007c783          	lbu	a5,0(a5)
    802048cc:	0007871b          	sext.w	a4,a5
    802048d0:	fd843683          	ld	a3,-40(s0)
    802048d4:	fe843783          	ld	a5,-24(s0)
    802048d8:	97b6                	add	a5,a5,a3
    802048da:	0007c783          	lbu	a5,0(a5)
    802048de:	2781                	sext.w	a5,a5
    802048e0:	40f707bb          	subw	a5,a4,a5
    802048e4:	2781                	sext.w	a5,a5
    802048e6:	a829                	j	80204900 <memcmp+0x8c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:120 (discriminator 2)
    for (size_t i = 0; i < num; i++)
    802048e8:	fe843783          	ld	a5,-24(s0)
    802048ec:	0785                	addi	a5,a5,1
    802048ee:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:120 (discriminator 1)
    802048f2:	fe843703          	ld	a4,-24(s0)
    802048f6:	fb843783          	ld	a5,-72(s0)
    802048fa:	faf761e3          	bltu	a4,a5,8020489c <memcmp+0x28>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:127
        }
    }
    return 0;
    802048fe:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:128
}
    80204900:	853e                	mv	a0,a5
    80204902:	6426                	ld	s0,72(sp)
    80204904:	6161                	addi	sp,sp,80
    80204906:	8082                	ret

0000000080204908 <memmove>:
memmove():
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:131

void *memmove(void *dest, const void *src, size_t n)
{
    80204908:	715d                	addi	sp,sp,-80
    8020490a:	e4a2                	sd	s0,72(sp)
    8020490c:	0880                	addi	s0,sp,80
    8020490e:	fca43423          	sd	a0,-56(s0)
    80204912:	fcb43023          	sd	a1,-64(s0)
    80204916:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:132
    u8 *d = (u8 *)dest;
    8020491a:	fc843783          	ld	a5,-56(s0)
    8020491e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:133
    const u8 *s = (const u8 *)src;
    80204922:	fc043783          	ld	a5,-64(s0)
    80204926:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:136

    // 如果源和目标相同，就没有复制的必要
    if (d == s)
    8020492a:	fd843703          	ld	a4,-40(s0)
    8020492e:	fd043783          	ld	a5,-48(s0)
    80204932:	00f71563          	bne	a4,a5,8020493c <memmove+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:138
    {
        return dest;
    80204936:	fc843783          	ld	a5,-56(s0)
    8020493a:	a861                	j	802049d2 <memmove+0xca>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:142
    }

    // 如果源地址小于目标地址，并且两者重叠，则从后向前复制
    if (s < d && d < s + n)
    8020493c:	fd043703          	ld	a4,-48(s0)
    80204940:	fd843783          	ld	a5,-40(s0)
    80204944:	04f77963          	bgeu	a4,a5,80204996 <memmove+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:142 (discriminator 1)
    80204948:	fd043703          	ld	a4,-48(s0)
    8020494c:	fb843783          	ld	a5,-72(s0)
    80204950:	97ba                	add	a5,a5,a4
    80204952:	fd843703          	ld	a4,-40(s0)
    80204956:	04f77063          	bgeu	a4,a5,80204996 <memmove+0x8e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:144
    {
        for (size_t i = n; i != 0; i--)
    8020495a:	fb843783          	ld	a5,-72(s0)
    8020495e:	fef43423          	sd	a5,-24(s0)
    80204962:	a035                	j	8020498e <memmove+0x86>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:146 (discriminator 3)
        {
            d[i - 1] = s[i - 1];
    80204964:	fe843783          	ld	a5,-24(s0)
    80204968:	17fd                	addi	a5,a5,-1
    8020496a:	fd043703          	ld	a4,-48(s0)
    8020496e:	973e                	add	a4,a4,a5
    80204970:	fe843783          	ld	a5,-24(s0)
    80204974:	17fd                	addi	a5,a5,-1
    80204976:	fd843683          	ld	a3,-40(s0)
    8020497a:	97b6                	add	a5,a5,a3
    8020497c:	00074703          	lbu	a4,0(a4)
    80204980:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:144 (discriminator 3)
        for (size_t i = n; i != 0; i--)
    80204984:	fe843783          	ld	a5,-24(s0)
    80204988:	17fd                	addi	a5,a5,-1
    8020498a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:144 (discriminator 1)
    8020498e:	fe843783          	ld	a5,-24(s0)
    80204992:	fbe9                	bnez	a5,80204964 <memmove+0x5c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:144
    80204994:	a82d                	j	802049ce <memmove+0xc6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:152
        }
    }
    else
    {
        // 否则，从前向后复制
        for (size_t i = 0; i < n; i++)
    80204996:	fe043023          	sd	zero,-32(s0)
    8020499a:	a025                	j	802049c2 <memmove+0xba>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:154 (discriminator 3)
        {
            d[i] = s[i];
    8020499c:	fd043703          	ld	a4,-48(s0)
    802049a0:	fe043783          	ld	a5,-32(s0)
    802049a4:	973e                	add	a4,a4,a5
    802049a6:	fd843683          	ld	a3,-40(s0)
    802049aa:	fe043783          	ld	a5,-32(s0)
    802049ae:	97b6                	add	a5,a5,a3
    802049b0:	00074703          	lbu	a4,0(a4)
    802049b4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:152 (discriminator 3)
        for (size_t i = 0; i < n; i++)
    802049b8:	fe043783          	ld	a5,-32(s0)
    802049bc:	0785                	addi	a5,a5,1
    802049be:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:152 (discriminator 1)
    802049c2:	fe043703          	ld	a4,-32(s0)
    802049c6:	fb843783          	ld	a5,-72(s0)
    802049ca:	fcf769e3          	bltu	a4,a5,8020499c <memmove+0x94>
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:158
        }
    }

    return dest;
    802049ce:	fc843783          	ld	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/string/string.c:159
    802049d2:	853e                	mv	a0,a5
    802049d4:	6426                	ld	s0,72(sp)
    802049d6:	6161                	addi	sp,sp,80
    802049d8:	8082                	ret

00000000802049da <init_heap>:
init_heap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:17

static char heap[HEAP_SIZE]; // 堆空间

// 初始化堆
void init_heap()
{
    802049da:	1101                	addi	sp,sp,-32
    802049dc:	ec22                	sd	s0,24(sp)
    802049de:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:19
    // 初始化堆的第一个块
    BlockHeader *header = (BlockHeader *)heap;
    802049e0:	00025797          	auipc	a5,0x25
    802049e4:	66878793          	addi	a5,a5,1640 # 8022a048 <heap>
    802049e8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:20
    header->size = HEAP_SIZE - sizeof(BlockHeader); // 设置第一个块的大小
    802049ec:	fe843783          	ld	a5,-24(s0)
    802049f0:	00800737          	lui	a4,0x800
    802049f4:	1741                	addi	a4,a4,-16
    802049f6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:21
    header->free = 1;                               // 设置第一个块为空闲
    802049f8:	fe843783          	ld	a5,-24(s0)
    802049fc:	4705                	li	a4,1
    802049fe:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:22
}
    80204a00:	0001                	nop
    80204a02:	6462                	ld	s0,24(sp)
    80204a04:	6105                	addi	sp,sp,32
    80204a06:	8082                	ret

0000000080204a08 <malloc>:
malloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:26

// 分配内存
void *malloc(uint64_t size)
{
    80204a08:	7179                	addi	sp,sp,-48
    80204a0a:	f422                	sd	s0,40(sp)
    80204a0c:	1800                	addi	s0,sp,48
    80204a0e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:28
    // 从堆的开始处搜索合适的内存块
    BlockHeader *header = (BlockHeader *)heap;
    80204a12:	00025797          	auipc	a5,0x25
    80204a16:	63678793          	addi	a5,a5,1590 # 8022a048 <heap>
    80204a1a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:31

    // 搜索未分配且大小合适的内存块
    while (header->size < size || !header->free)
    80204a1e:	a025                	j	80204a46 <malloc+0x3e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:33
    {
        header = (BlockHeader *)((char *)header + header->size + sizeof(BlockHeader));
    80204a20:	fe843783          	ld	a5,-24(s0)
    80204a24:	639c                	ld	a5,0(a5)
    80204a26:	07c1                	addi	a5,a5,16
    80204a28:	fe843703          	ld	a4,-24(s0)
    80204a2c:	97ba                	add	a5,a5,a4
    80204a2e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:34
        if ((char *)header >= (char *)heap + HEAP_SIZE)
    80204a32:	00825797          	auipc	a5,0x825
    80204a36:	61678793          	addi	a5,a5,1558 # 80a2a048 <KERNEL_SPACE>
    80204a3a:	fe843703          	ld	a4,-24(s0)
    80204a3e:	00f76463          	bltu	a4,a5,80204a46 <malloc+0x3e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:37
        {
            // 搜索到堆的末尾还未找到合适的内存块
            return NULL;
    80204a42:	4781                	li	a5,0
    80204a44:	a885                	j	80204ab4 <malloc+0xac>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:31
    while (header->size < size || !header->free)
    80204a46:	fe843783          	ld	a5,-24(s0)
    80204a4a:	639c                	ld	a5,0(a5)
    80204a4c:	fd843703          	ld	a4,-40(s0)
    80204a50:	fce7e8e3          	bltu	a5,a4,80204a20 <malloc+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:31 (discriminator 1)
    80204a54:	fe843783          	ld	a5,-24(s0)
    80204a58:	479c                	lw	a5,8(a5)
    80204a5a:	d3f9                	beqz	a5,80204a20 <malloc+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:42
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4)
    80204a5c:	fe843783          	ld	a5,-24(s0)
    80204a60:	6398                	ld	a4,0(a5)
    80204a62:	fd843783          	ld	a5,-40(s0)
    80204a66:	07d1                	addi	a5,a5,20
    80204a68:	02f76f63          	bltu	a4,a5,80204aa6 <malloc+0x9e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:45
    {
        // 分割内存块以减少浪费
        BlockHeader *new_header = (BlockHeader *)((char *)header + size + sizeof(BlockHeader));
    80204a6c:	fd843783          	ld	a5,-40(s0)
    80204a70:	07c1                	addi	a5,a5,16
    80204a72:	fe843703          	ld	a4,-24(s0)
    80204a76:	97ba                	add	a5,a5,a4
    80204a78:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:46
        new_header->size = header->size - size - sizeof(BlockHeader); // 计算新内存块的大小
    80204a7c:	fe843783          	ld	a5,-24(s0)
    80204a80:	6398                	ld	a4,0(a5)
    80204a82:	fd843783          	ld	a5,-40(s0)
    80204a86:	40f707b3          	sub	a5,a4,a5
    80204a8a:	ff078713          	addi	a4,a5,-16
    80204a8e:	fe043783          	ld	a5,-32(s0)
    80204a92:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:47
        new_header->free = 1;                                         // 设置新内存块为空闲
    80204a94:	fe043783          	ld	a5,-32(s0)
    80204a98:	4705                	li	a4,1
    80204a9a:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:48
        header->size = size;                                          // 更新当前内存块的大小
    80204a9c:	fe843783          	ld	a5,-24(s0)
    80204aa0:	fd843703          	ld	a4,-40(s0)
    80204aa4:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:51
    }

    header->free = 0;            // 标记当前内存块为已分配
    80204aa6:	fe843783          	ld	a5,-24(s0)
    80204aaa:	0007a423          	sw	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:52
    return (void *)(header + 1); // 返回内存块数据区的地址
    80204aae:	fe843783          	ld	a5,-24(s0)
    80204ab2:	07c1                	addi	a5,a5,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:53
}
    80204ab4:	853e                	mv	a0,a5
    80204ab6:	7422                	ld	s0,40(sp)
    80204ab8:	6145                	addi	sp,sp,48
    80204aba:	8082                	ret

0000000080204abc <free>:
free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:57

// 释放内存
void free(void *ptr)
{
    80204abc:	7179                	addi	sp,sp,-48
    80204abe:	f422                	sd	s0,40(sp)
    80204ac0:	1800                	addi	s0,sp,48
    80204ac2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:59
    // 如果指针为空，则不进行操作
    if (ptr == NULL)
    80204ac6:	fd843783          	ld	a5,-40(s0)
    80204aca:	cb99                	beqz	a5,80204ae0 <free+0x24>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:65
    {
        return;
    }

    // 获取内存块头部
    BlockHeader *header = (BlockHeader *)ptr - 1;
    80204acc:	fd843783          	ld	a5,-40(s0)
    80204ad0:	17c1                	addi	a5,a5,-16
    80204ad2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:66
    header->free = 1; // 标记内存块为空闲
    80204ad6:	fe843783          	ld	a5,-24(s0)
    80204ada:	4705                	li	a4,1
    80204adc:	c798                	sw	a4,8(a5)
    80204ade:	a011                	j	80204ae2 <free+0x26>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:61
        return;
    80204ae0:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:67
}
    80204ae2:	7422                	ld	s0,40(sp)
    80204ae4:	6145                	addi	sp,sp,48
    80204ae6:	8082                	ret

0000000080204ae8 <print_heap>:
print_heap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:71

// 打印堆的状态
void print_heap()
{
    80204ae8:	1101                	addi	sp,sp,-32
    80204aea:	ec06                	sd	ra,24(sp)
    80204aec:	e822                	sd	s0,16(sp)
    80204aee:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:72
    BlockHeader *header = (BlockHeader *)heap;
    80204af0:	00025797          	auipc	a5,0x25
    80204af4:	55878793          	addi	a5,a5,1368 # 8022a048 <heap>
    80204af8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:75

    // 遍历堆中的所有内存块
    while ((char *)header < (char *)heap + HEAP_SIZE)
    80204afc:	a095                	j	80204b60 <print_heap+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:77
    {
        print_str("Block size: ");
    80204afe:	00006517          	auipc	a0,0x6
    80204b02:	81a50513          	addi	a0,a0,-2022 # 8020a318 <MMIO+0xf8>
    80204b06:	213020ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:78
        print_uint64(header->size); // 打印内存块大小
    80204b0a:	fe843783          	ld	a5,-24(s0)
    80204b0e:	639c                	ld	a5,0(a5)
    80204b10:	853e                	mv	a0,a5
    80204b12:	385020ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:79
        print_str(", Free: ");
    80204b16:	00006517          	auipc	a0,0x6
    80204b1a:	81250513          	addi	a0,a0,-2030 # 8020a328 <MMIO+0x108>
    80204b1e:	1fb020ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:80
        print_str(header->free ? "Yes" : "No"); // 打印内存块是否空闲
    80204b22:	fe843783          	ld	a5,-24(s0)
    80204b26:	479c                	lw	a5,8(a5)
    80204b28:	c791                	beqz	a5,80204b34 <print_heap+0x4c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:80 (discriminator 1)
    80204b2a:	00006797          	auipc	a5,0x6
    80204b2e:	80e78793          	addi	a5,a5,-2034 # 8020a338 <MMIO+0x118>
    80204b32:	a029                	j	80204b3c <print_heap+0x54>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:80 (discriminator 2)
    80204b34:	00006797          	auipc	a5,0x6
    80204b38:	80c78793          	addi	a5,a5,-2036 # 8020a340 <MMIO+0x120>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:80 (discriminator 4)
    80204b3c:	853e                	mv	a0,a5
    80204b3e:	1db020ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:81 (discriminator 4)
        print_str("\n");
    80204b42:	00006517          	auipc	a0,0x6
    80204b46:	80650513          	addi	a0,a0,-2042 # 8020a348 <MMIO+0x128>
    80204b4a:	1cf020ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:84 (discriminator 4)

        // 移动到下一个内存块
        header = (BlockHeader *)((char *)header + header->size + sizeof(BlockHeader));
    80204b4e:	fe843783          	ld	a5,-24(s0)
    80204b52:	639c                	ld	a5,0(a5)
    80204b54:	07c1                	addi	a5,a5,16
    80204b56:	fe843703          	ld	a4,-24(s0)
    80204b5a:	97ba                	add	a5,a5,a4
    80204b5c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:75
    while ((char *)header < (char *)heap + HEAP_SIZE)
    80204b60:	00825797          	auipc	a5,0x825
    80204b64:	4e878793          	addi	a5,a5,1256 # 80a2a048 <KERNEL_SPACE>
    80204b68:	fe843703          	ld	a4,-24(s0)
    80204b6c:	f8f769e3          	bltu	a4,a5,80204afe <print_heap+0x16>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:86
    }
}
    80204b70:	0001                	nop
    80204b72:	0001                	nop
    80204b74:	60e2                	ld	ra,24(sp)
    80204b76:	6442                	ld	s0,16(sp)
    80204b78:	6105                	addi	sp,sp,32
    80204b7a:	8082                	ret

0000000080204b7c <realloc>:
realloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:90

// 重新分配内存
void *realloc(void *ptr, uint64_t new_size)
{
    80204b7c:	7139                	addi	sp,sp,-64
    80204b7e:	fc06                	sd	ra,56(sp)
    80204b80:	f822                	sd	s0,48(sp)
    80204b82:	0080                	addi	s0,sp,64
    80204b84:	fca43423          	sd	a0,-56(s0)
    80204b88:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:91
    if (new_size == 0)
    80204b8c:	fc043783          	ld	a5,-64(s0)
    80204b90:	e799                	bnez	a5,80204b9e <realloc+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:94
    {
        // 如果新大小为0，则释放原有内存并返回NULL
        free(ptr);
    80204b92:	fc843503          	ld	a0,-56(s0)
    80204b96:	f27ff0ef          	jal	ra,80204abc <free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:95
        return NULL;
    80204b9a:	4781                	li	a5,0
    80204b9c:	a045                	j	80204c3c <realloc+0xc0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:98
    }

    if (ptr == NULL)
    80204b9e:	fc843783          	ld	a5,-56(s0)
    80204ba2:	e799                	bnez	a5,80204bb0 <realloc+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:101
    {
        // 如果原始指针为NULL，则行为等同于malloc
        return malloc(new_size);
    80204ba4:	fc043503          	ld	a0,-64(s0)
    80204ba8:	e61ff0ef          	jal	ra,80204a08 <malloc>
    80204bac:	87aa                	mv	a5,a0
    80204bae:	a079                	j	80204c3c <realloc+0xc0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:104
    }

    BlockHeader *header = (BlockHeader *)ptr - 1;
    80204bb0:	fc843783          	ld	a5,-56(s0)
    80204bb4:	17c1                	addi	a5,a5,-16
    80204bb6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:105
    if (header->size >= new_size)
    80204bba:	fe043783          	ld	a5,-32(s0)
    80204bbe:	639c                	ld	a5,0(a5)
    80204bc0:	fc043703          	ld	a4,-64(s0)
    80204bc4:	00e7e563          	bltu	a5,a4,80204bce <realloc+0x52>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:108
    {
        // 如果原始内存块大小已满足需求，则直接返回原始指针
        return ptr;
    80204bc8:	fc843783          	ld	a5,-56(s0)
    80204bcc:	a885                	j	80204c3c <realloc+0xc0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:113
    }
    else
    {
        // 如果新大小超出原始大小，则分配一个新的内存块并复制原始数据
        void *new_ptr = malloc(new_size);
    80204bce:	fc043503          	ld	a0,-64(s0)
    80204bd2:	e37ff0ef          	jal	ra,80204a08 <malloc>
    80204bd6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:114
        if (new_ptr == NULL)
    80204bda:	fd843783          	ld	a5,-40(s0)
    80204bde:	e399                	bnez	a5,80204be4 <realloc+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:117
        {
            // 分配失败
            return NULL;
    80204be0:	4781                	li	a5,0
    80204be2:	a8a9                	j	80204c3c <realloc+0xc0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:121
        }

        // 复制原始内存数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
    80204be4:	fe043783          	ld	a5,-32(s0)
    80204be8:	6398                	ld	a4,0(a5)
    80204bea:	fc043783          	ld	a5,-64(s0)
    80204bee:	00f77363          	bgeu	a4,a5,80204bf4 <realloc+0x78>
    80204bf2:	87ba                	mv	a5,a4
    80204bf4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:122
        for (uint64_t i = 0; i < copy_size; ++i)
    80204bf8:	fe043423          	sd	zero,-24(s0)
    80204bfc:	a025                	j	80204c24 <realloc+0xa8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:124 (discriminator 3)
        {
            *((char *)new_ptr + i) = *((char *)ptr + i);
    80204bfe:	fc843703          	ld	a4,-56(s0)
    80204c02:	fe843783          	ld	a5,-24(s0)
    80204c06:	973e                	add	a4,a4,a5
    80204c08:	fd843683          	ld	a3,-40(s0)
    80204c0c:	fe843783          	ld	a5,-24(s0)
    80204c10:	97b6                	add	a5,a5,a3
    80204c12:	00074703          	lbu	a4,0(a4) # 800000 <n+0x7fffe0>
    80204c16:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:122 (discriminator 3)
        for (uint64_t i = 0; i < copy_size; ++i)
    80204c1a:	fe843783          	ld	a5,-24(s0)
    80204c1e:	0785                	addi	a5,a5,1
    80204c20:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:122 (discriminator 1)
    80204c24:	fe843703          	ld	a4,-24(s0)
    80204c28:	fd043783          	ld	a5,-48(s0)
    80204c2c:	fcf769e3          	bltu	a4,a5,80204bfe <realloc+0x82>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:128
        }

        // 释放原始内存块
        free(ptr);
    80204c30:	fc843503          	ld	a0,-56(s0)
    80204c34:	e89ff0ef          	jal	ra,80204abc <free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:129
        return new_ptr;
    80204c38:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/kernel_address/kernel_heap.c:131
    }
}
    80204c3c:	853e                	mv	a0,a5
    80204c3e:	70e2                	ld	ra,56(sp)
    80204c40:	7442                	ld	s0,48(sp)
    80204c42:	6121                	addi	sp,sp,64
    80204c44:	8082                	ret

0000000080204c46 <w_satp>:
w_satp():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:176
{
    80204c46:	1101                	addi	sp,sp,-32
    80204c48:	ec22                	sd	s0,24(sp)
    80204c4a:	1000                	addi	s0,sp,32
    80204c4c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:177
  asm volatile("csrw satp, %0" : : "r"(x));
    80204c50:	fe843783          	ld	a5,-24(s0)
    80204c54:	18079073          	csrw	satp,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:178
}
    80204c58:	0001                	nop
    80204c5a:	6462                	ld	s0,24(sp)
    80204c5c:	6105                	addi	sp,sp,32
    80204c5e:	8082                	ret

0000000080204c60 <sfence_vma>:
sfence_vma():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:275
  return x;
}

// flush the TLB.
static inline void sfence_vma()
{
    80204c60:	1141                	addi	sp,sp,-16
    80204c62:	e422                	sd	s0,8(sp)
    80204c64:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:277
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80204c66:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:278
}
    80204c6a:	0001                	nop
    80204c6c:	6422                	ld	s0,8(sp)
    80204c6e:	0141                	addi	sp,sp,16
    80204c70:	8082                	ret

0000000080204c72 <map_area_from_another>:
map_area_from_another():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:7
#include "mem.h"
#include "riscv.h"
#include "string.h"
#include "debug.h"
static void map_area_from_another(MapArea *map_area, MapArea *another)
{
    80204c72:	1101                	addi	sp,sp,-32
    80204c74:	ec22                	sd	s0,24(sp)
    80204c76:	1000                	addi	s0,sp,32
    80204c78:	fea43423          	sd	a0,-24(s0)
    80204c7c:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:8
  map_area->vpn_range.l = another->vpn_range.l;
    80204c80:	fe043783          	ld	a5,-32(s0)
    80204c84:	6398                	ld	a4,0(a5)
    80204c86:	fe843783          	ld	a5,-24(s0)
    80204c8a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:9
  map_area->vpn_range.r = another->vpn_range.r;
    80204c8c:	fe043783          	ld	a5,-32(s0)
    80204c90:	6798                	ld	a4,8(a5)
    80204c92:	fe843783          	ld	a5,-24(s0)
    80204c96:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:10
  map_area->map_type = another->map_type;
    80204c98:	fe043783          	ld	a5,-32(s0)
    80204c9c:	0107c703          	lbu	a4,16(a5)
    80204ca0:	fe843783          	ld	a5,-24(s0)
    80204ca4:	00e78823          	sb	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:11
  map_area->map_perm = another->map_perm;
    80204ca8:	fe043783          	ld	a5,-32(s0)
    80204cac:	0117c703          	lbu	a4,17(a5)
    80204cb0:	fe843783          	ld	a5,-24(s0)
    80204cb4:	00e788a3          	sb	a4,17(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:12
}
    80204cb8:	0001                	nop
    80204cba:	6462                	ld	s0,24(sp)
    80204cbc:	6105                	addi	sp,sp,32
    80204cbe:	8082                	ret

0000000080204cc0 <map_area_map_one>:
map_area_map_one():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:16

static void map_area_map_one(MapArea *map_area, PageTable *pt,
                             VirtPageNum vpn)
{
    80204cc0:	7139                	addi	sp,sp,-64
    80204cc2:	fc06                	sd	ra,56(sp)
    80204cc4:	f822                	sd	s0,48(sp)
    80204cc6:	0080                	addi	s0,sp,64
    80204cc8:	fca43c23          	sd	a0,-40(s0)
    80204ccc:	fcb43823          	sd	a1,-48(s0)
    80204cd0:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:18
  PhysPageNum ppn;
  if (map_area->map_type == MAP_IDENTICAL)
    80204cd4:	fd843783          	ld	a5,-40(s0)
    80204cd8:	0107c783          	lbu	a5,16(a5)
    80204cdc:	e791                	bnez	a5,80204ce8 <map_area_map_one+0x28>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:20
  {
    ppn = (PhysPageNum)vpn;
    80204cde:	fc843783          	ld	a5,-56(s0)
    80204ce2:	fef43023          	sd	a5,-32(s0)
    80204ce6:	a031                	j	80204cf2 <map_area_map_one+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:24
  }
  else
  {
    ppn = frame_alloc();
    80204ce8:	0ca010ef          	jal	ra,80205db2 <frame_alloc>
    80204cec:	87aa                	mv	a5,a0
    80204cee:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:26
  }
  PTEFlags pte_flags = (PTEFlags)(map_area->map_perm);
    80204cf2:	fd843783          	ld	a5,-40(s0)
    80204cf6:	0117c783          	lbu	a5,17(a5)
    80204cfa:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:27
  page_table_map(pt, vpn, ppn, pte_flags);
    80204cfe:	fe043783          	ld	a5,-32(s0)
    80204d02:	fef44703          	lbu	a4,-17(s0)
    80204d06:	86ba                	mv	a3,a4
    80204d08:	863e                	mv	a2,a5
    80204d0a:	fc843583          	ld	a1,-56(s0)
    80204d0e:	fd043503          	ld	a0,-48(s0)
    80204d12:	52a010ef          	jal	ra,8020623c <page_table_map>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:28
  vector_push(&pt->frames, &ppn);
    80204d16:	fd043783          	ld	a5,-48(s0)
    80204d1a:	07a1                	addi	a5,a5,8
    80204d1c:	fe040713          	addi	a4,s0,-32
    80204d20:	85ba                	mv	a1,a4
    80204d22:	853e                	mv	a0,a5
    80204d24:	3ab040ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:29
}
    80204d28:	0001                	nop
    80204d2a:	70e2                	ld	ra,56(sp)
    80204d2c:	7442                	ld	s0,48(sp)
    80204d2e:	6121                	addi	sp,sp,64
    80204d30:	8082                	ret

0000000080204d32 <map_area_unmap_one>:
map_area_unmap_one():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:33

static void map_area_unmap_one(MapArea *map_area, PageTable *pt,
                               VirtPageNum vpn, bool dealloc)
{
    80204d32:	7139                	addi	sp,sp,-64
    80204d34:	fc06                	sd	ra,56(sp)
    80204d36:	f822                	sd	s0,48(sp)
    80204d38:	0080                	addi	s0,sp,64
    80204d3a:	fca43c23          	sd	a0,-40(s0)
    80204d3e:	fcb43823          	sd	a1,-48(s0)
    80204d42:	fcc43423          	sd	a2,-56(s0)
    80204d46:	87b6                	mv	a5,a3
    80204d48:	fcf42223          	sw	a5,-60(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:34
  PhysPageNum ppn = pte_ppn(*page_table_translate(pt, vpn));
    80204d4c:	fc843583          	ld	a1,-56(s0)
    80204d50:	fd043503          	ld	a0,-48(s0)
    80204d54:	5aa010ef          	jal	ra,802062fe <page_table_translate>
    80204d58:	87aa                	mv	a5,a0
    80204d5a:	639c                	ld	a5,0(a5)
    80204d5c:	00a7d713          	srli	a4,a5,0xa
    80204d60:	57fd                	li	a5,-1
    80204d62:	83d1                	srli	a5,a5,0x14
    80204d64:	8ff9                	and	a5,a5,a4
    80204d66:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:35
  page_table_unmap(pt, vpn);
    80204d6a:	fc843583          	ld	a1,-56(s0)
    80204d6e:	fd043503          	ld	a0,-48(s0)
    80204d72:	538010ef          	jal	ra,802062aa <page_table_unmap>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:36
  if (dealloc)
    80204d76:	fc442783          	lw	a5,-60(s0)
    80204d7a:	2781                	sext.w	a5,a5
    80204d7c:	c789                	beqz	a5,80204d86 <map_area_unmap_one+0x54>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:38
  {
    frame_dealloc(ppn);
    80204d7e:	fe843503          	ld	a0,-24(s0)
    80204d82:	0e4010ef          	jal	ra,80205e66 <frame_dealloc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:40
  }
}
    80204d86:	0001                	nop
    80204d88:	70e2                	ld	ra,56(sp)
    80204d8a:	7442                	ld	s0,48(sp)
    80204d8c:	6121                	addi	sp,sp,64
    80204d8e:	8082                	ret

0000000080204d90 <map_area_map>:
map_area_map():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:43

static void map_area_map(MapArea *map_area, PageTable *pt)
{
    80204d90:	7179                	addi	sp,sp,-48
    80204d92:	f406                	sd	ra,40(sp)
    80204d94:	f022                	sd	s0,32(sp)
    80204d96:	1800                	addi	s0,sp,48
    80204d98:	fca43c23          	sd	a0,-40(s0)
    80204d9c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:44
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80204da0:	fd843783          	ld	a5,-40(s0)
    80204da4:	639c                	ld	a5,0(a5)
    80204da6:	fef43423          	sd	a5,-24(s0)
    80204daa:	a831                	j	80204dc6 <map_area_map+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:47
       vpn++)
  {
    map_area_map_one(map_area, pt, vpn);
    80204dac:	fe843603          	ld	a2,-24(s0)
    80204db0:	fd043583          	ld	a1,-48(s0)
    80204db4:	fd843503          	ld	a0,-40(s0)
    80204db8:	f09ff0ef          	jal	ra,80204cc0 <map_area_map_one>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:45
       vpn++)
    80204dbc:	fe843783          	ld	a5,-24(s0)
    80204dc0:	0785                	addi	a5,a5,1
    80204dc2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:44 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80204dc6:	fd843783          	ld	a5,-40(s0)
    80204dca:	679c                	ld	a5,8(a5)
    80204dcc:	fe843703          	ld	a4,-24(s0)
    80204dd0:	fcf76ee3          	bltu	a4,a5,80204dac <map_area_map+0x1c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:49
  }
}
    80204dd4:	0001                	nop
    80204dd6:	0001                	nop
    80204dd8:	70a2                	ld	ra,40(sp)
    80204dda:	7402                	ld	s0,32(sp)
    80204ddc:	6145                	addi	sp,sp,48
    80204dde:	8082                	ret

0000000080204de0 <map_area_unmap>:
map_area_unmap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:52

static void map_area_unmap(MapArea *map_area, PageTable *pt, bool dealloc)
{
    80204de0:	7139                	addi	sp,sp,-64
    80204de2:	fc06                	sd	ra,56(sp)
    80204de4:	f822                	sd	s0,48(sp)
    80204de6:	0080                	addi	s0,sp,64
    80204de8:	fca43c23          	sd	a0,-40(s0)
    80204dec:	fcb43823          	sd	a1,-48(s0)
    80204df0:	87b2                	mv	a5,a2
    80204df2:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:53
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80204df6:	fd843783          	ld	a5,-40(s0)
    80204dfa:	639c                	ld	a5,0(a5)
    80204dfc:	fef43423          	sd	a5,-24(s0)
    80204e00:	a00d                	j	80204e22 <map_area_unmap+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:56
       vpn++)
  {
    map_area_unmap_one(map_area, pt, vpn, dealloc);
    80204e02:	fcc42783          	lw	a5,-52(s0)
    80204e06:	86be                	mv	a3,a5
    80204e08:	fe843603          	ld	a2,-24(s0)
    80204e0c:	fd043583          	ld	a1,-48(s0)
    80204e10:	fd843503          	ld	a0,-40(s0)
    80204e14:	f1fff0ef          	jal	ra,80204d32 <map_area_unmap_one>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:54
       vpn++)
    80204e18:	fe843783          	ld	a5,-24(s0)
    80204e1c:	0785                	addi	a5,a5,1
    80204e1e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:53 (discriminator 1)
  for (VirtPageNum vpn = map_area->vpn_range.l; vpn < map_area->vpn_range.r;
    80204e22:	fd843783          	ld	a5,-40(s0)
    80204e26:	679c                	ld	a5,8(a5)
    80204e28:	fe843703          	ld	a4,-24(s0)
    80204e2c:	fcf76be3          	bltu	a4,a5,80204e02 <map_area_unmap+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:58
  }
}
    80204e30:	0001                	nop
    80204e32:	0001                	nop
    80204e34:	70e2                	ld	ra,56(sp)
    80204e36:	7442                	ld	s0,48(sp)
    80204e38:	6121                	addi	sp,sp,64
    80204e3a:	8082                	ret

0000000080204e3c <map_area_copy_data>:
map_area_copy_data():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:62

static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len)
{
    80204e3c:	711d                	addi	sp,sp,-96
    80204e3e:	ec86                	sd	ra,88(sp)
    80204e40:	e8a2                	sd	s0,80(sp)
    80204e42:	1080                	addi	s0,sp,96
    80204e44:	faa43c23          	sd	a0,-72(s0)
    80204e48:	fab43823          	sd	a1,-80(s0)
    80204e4c:	fac43423          	sd	a2,-88(s0)
    80204e50:	fad43023          	sd	a3,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:63
  uint64_t start = 0;
    80204e54:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:64
  VirtPageNum current_vpn = map_area->vpn_range.l;
    80204e58:	fb843783          	ld	a5,-72(s0)
    80204e5c:	639c                	ld	a5,0(a5)
    80204e5e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:67
  for (;;)
  {
    uint8_t *src = &data[start];
    80204e62:	fa843703          	ld	a4,-88(s0)
    80204e66:	fe843783          	ld	a5,-24(s0)
    80204e6a:	97ba                	add	a5,a5,a4
    80204e6c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:69
    uint8_t *dst =
        ppn_get_bytes_array(pte_ppn(*page_table_translate(pt, current_vpn)));
    80204e70:	fe043583          	ld	a1,-32(s0)
    80204e74:	fb043503          	ld	a0,-80(s0)
    80204e78:	486010ef          	jal	ra,802062fe <page_table_translate>
    80204e7c:	87aa                	mv	a5,a0
    80204e7e:	639c                	ld	a5,0(a5)
    80204e80:	00a7d713          	srli	a4,a5,0xa
    80204e84:	57fd                	li	a5,-1
    80204e86:	83d1                	srli	a5,a5,0x14
    80204e88:	8ff9                	and	a5,a5,a4
    80204e8a:	853e                	mv	a0,a5
    80204e8c:	69f000ef          	jal	ra,80205d2a <ppn_get_bytes_array>
    80204e90:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:70
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    80204e94:	fa043703          	ld	a4,-96(s0)
    80204e98:	fe843783          	ld	a5,-24(s0)
    80204e9c:	40f707b3          	sub	a5,a4,a5
    80204ea0:	6705                	lui	a4,0x1
    80204ea2:	00f77363          	bgeu	a4,a5,80204ea8 <map_area_copy_data+0x6c>
    80204ea6:	6785                	lui	a5,0x1
    80204ea8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:71
    memcpy(dst, src, cpy_len);
    80204eac:	fc843783          	ld	a5,-56(s0)
    80204eb0:	2781                	sext.w	a5,a5
    80204eb2:	863e                	mv	a2,a5
    80204eb4:	fd843583          	ld	a1,-40(s0)
    80204eb8:	fd043503          	ld	a0,-48(s0)
    80204ebc:	933ff0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:72
    start += PAGE_SIZE;
    80204ec0:	fe843703          	ld	a4,-24(s0)
    80204ec4:	6785                	lui	a5,0x1
    80204ec6:	97ba                	add	a5,a5,a4
    80204ec8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:73
    if (start >= len)
    80204ecc:	fe843703          	ld	a4,-24(s0)
    80204ed0:	fa043783          	ld	a5,-96(s0)
    80204ed4:	00f77863          	bgeu	a4,a5,80204ee4 <map_area_copy_data+0xa8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:77
    {
      break;
    }
    current_vpn += 1;
    80204ed8:	fe043783          	ld	a5,-32(s0)
    80204edc:	0785                	addi	a5,a5,1
    80204ede:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:66
  {
    80204ee2:	b741                	j	80204e62 <map_area_copy_data+0x26>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:75
      break;
    80204ee4:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:79
  }
}
    80204ee6:	0001                	nop
    80204ee8:	60e6                	ld	ra,88(sp)
    80204eea:	6446                	ld	s0,80(sp)
    80204eec:	6125                	addi	sp,sp,96
    80204eee:	8082                	ret

0000000080204ef0 <memory_set_new_bare>:
memory_set_new_bare():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:82

static void memory_set_new_bare(MemorySet *memory_set)
{
    80204ef0:	1101                	addi	sp,sp,-32
    80204ef2:	ec06                	sd	ra,24(sp)
    80204ef4:	e822                	sd	s0,16(sp)
    80204ef6:	1000                	addi	s0,sp,32
    80204ef8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:83
  page_table_new(&memory_set->page_table);
    80204efc:	fe843783          	ld	a5,-24(s0)
    80204f00:	853e                	mv	a0,a5
    80204f02:	0d4010ef          	jal	ra,80205fd6 <page_table_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:84
  vector_new(&memory_set->areas, sizeof(MapArea));
    80204f06:	fe843783          	ld	a5,-24(s0)
    80204f0a:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80204f0e:	45e1                	li	a1,24
    80204f10:	853e                	mv	a0,a5
    80204f12:	16b040ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:85
}
    80204f16:	0001                	nop
    80204f18:	60e2                	ld	ra,24(sp)
    80204f1a:	6442                	ld	s0,16(sp)
    80204f1c:	6105                	addi	sp,sp,32
    80204f1e:	8082                	ret

0000000080204f20 <memory_set_token>:
memory_set_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:88

uint64_t memory_set_token(MemorySet *memory_set)
{
    80204f20:	1101                	addi	sp,sp,-32
    80204f22:	ec06                	sd	ra,24(sp)
    80204f24:	e822                	sd	s0,16(sp)
    80204f26:	1000                	addi	s0,sp,32
    80204f28:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:89
  return page_table_token(&memory_set->page_table);
    80204f2c:	fe843783          	ld	a5,-24(s0)
    80204f30:	853e                	mv	a0,a5
    80204f32:	418010ef          	jal	ra,8020634a <page_table_token>
    80204f36:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:90
}
    80204f38:	853e                	mv	a0,a5
    80204f3a:	60e2                	ld	ra,24(sp)
    80204f3c:	6442                	ld	s0,16(sp)
    80204f3e:	6105                	addi	sp,sp,32
    80204f40:	8082                	ret

0000000080204f42 <memory_set_push>:
memory_set_push():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:94

static void memory_set_push(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len)
{
    80204f42:	7179                	addi	sp,sp,-48
    80204f44:	f406                	sd	ra,40(sp)
    80204f46:	f022                	sd	s0,32(sp)
    80204f48:	1800                	addi	s0,sp,48
    80204f4a:	fea43423          	sd	a0,-24(s0)
    80204f4e:	feb43023          	sd	a1,-32(s0)
    80204f52:	fcc43c23          	sd	a2,-40(s0)
    80204f56:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:95
  map_area_map(map_area, &memory_set->page_table);
    80204f5a:	fe843783          	ld	a5,-24(s0)
    80204f5e:	85be                	mv	a1,a5
    80204f60:	fe043503          	ld	a0,-32(s0)
    80204f64:	e2dff0ef          	jal	ra,80204d90 <map_area_map>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:96
  if (data && len >= 0)
    80204f68:	fd843783          	ld	a5,-40(s0)
    80204f6c:	cf81                	beqz	a5,80204f84 <memory_set_push+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:98
  {
    map_area_copy_data(map_area, &memory_set->page_table, data, len);
    80204f6e:	fe843783          	ld	a5,-24(s0)
    80204f72:	fd043683          	ld	a3,-48(s0)
    80204f76:	fd843603          	ld	a2,-40(s0)
    80204f7a:	85be                	mv	a1,a5
    80204f7c:	fe043503          	ld	a0,-32(s0)
    80204f80:	ebdff0ef          	jal	ra,80204e3c <map_area_copy_data>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:100
  }
  vector_push(&memory_set->areas, map_area);
    80204f84:	fe843783          	ld	a5,-24(s0)
    80204f88:	02878793          	addi	a5,a5,40
    80204f8c:	fe043583          	ld	a1,-32(s0)
    80204f90:	853e                	mv	a0,a5
    80204f92:	13d040ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:101
}
    80204f96:	0001                	nop
    80204f98:	70a2                	ld	ra,40(sp)
    80204f9a:	7402                	ld	s0,32(sp)
    80204f9c:	6145                	addi	sp,sp,48
    80204f9e:	8082                	ret

0000000080204fa0 <memory_set_insert_framed_area>:
memory_set_insert_framed_area():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:107

// Assume that no conflicts.
static void memory_set_insert_framed_area(MemorySet *memory_set,
                                          VirtAddr start_va, VirtAddr end_va,
                                          MapPermission permission)
{
    80204fa0:	715d                	addi	sp,sp,-80
    80204fa2:	e486                	sd	ra,72(sp)
    80204fa4:	e0a2                	sd	s0,64(sp)
    80204fa6:	0880                	addi	s0,sp,80
    80204fa8:	fca43423          	sd	a0,-56(s0)
    80204fac:	fcb43023          	sd	a1,-64(s0)
    80204fb0:	fac43c23          	sd	a2,-72(s0)
    80204fb4:	87b6                	mv	a5,a3
    80204fb6:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:109
  MapArea map_area;
  map_area.vpn_range.l = page_floor(start_va);
    80204fba:	fc043783          	ld	a5,-64(s0)
    80204fbe:	83b1                	srli	a5,a5,0xc
    80204fc0:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:110
  map_area.vpn_range.r = page_ceil(end_va);
    80204fc4:	fb843703          	ld	a4,-72(s0)
    80204fc8:	6785                	lui	a5,0x1
    80204fca:	17fd                	addi	a5,a5,-1
    80204fcc:	97ba                	add	a5,a5,a4
    80204fce:	83b1                	srli	a5,a5,0xc
    80204fd0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:111
  map_area.map_type = MAP_FRAMED;
    80204fd4:	4785                	li	a5,1
    80204fd6:	fef40423          	sb	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:112
  map_area.map_perm = permission;
    80204fda:	fb744783          	lbu	a5,-73(s0)
    80204fde:	fef404a3          	sb	a5,-23(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:113
  memory_set_push(memory_set, &map_area, NULL, 0);
    80204fe2:	fd840793          	addi	a5,s0,-40
    80204fe6:	4681                	li	a3,0
    80204fe8:	4601                	li	a2,0
    80204fea:	85be                	mv	a1,a5
    80204fec:	fc843503          	ld	a0,-56(s0)
    80204ff0:	f53ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:114
}
    80204ff4:	0001                	nop
    80204ff6:	60a6                	ld	ra,72(sp)
    80204ff8:	6406                	ld	s0,64(sp)
    80204ffa:	6161                	addi	sp,sp,80
    80204ffc:	8082                	ret

0000000080204ffe <memory_set_remove_area_with_start_vpn>:
memory_set_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:118

static void memory_set_remove_area_with_start_vpn(MemorySet *memory_set,
                                                  VirtPageNum start_vpn)
{
    80204ffe:	7179                	addi	sp,sp,-48
    80205000:	f406                	sd	ra,40(sp)
    80205002:	f022                	sd	s0,32(sp)
    80205004:	1800                	addi	s0,sp,48
    80205006:	fca43c23          	sd	a0,-40(s0)
    8020500a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:119
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    8020500e:	fd843783          	ld	a5,-40(s0)
    80205012:	63bc                	ld	a5,64(a5)
    80205014:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:120
  uint64_t i = 0;
    80205018:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:121
  while (i < memory_set->areas.size)
    8020501c:	a085                	j	8020507c <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:123
  {
    if (x[i].vpn_range.l == start_vpn)
    8020501e:	fe843703          	ld	a4,-24(s0)
    80205022:	87ba                	mv	a5,a4
    80205024:	0786                	slli	a5,a5,0x1
    80205026:	97ba                	add	a5,a5,a4
    80205028:	078e                	slli	a5,a5,0x3
    8020502a:	873e                	mv	a4,a5
    8020502c:	fe043783          	ld	a5,-32(s0)
    80205030:	97ba                	add	a5,a5,a4
    80205032:	639c                	ld	a5,0(a5)
    80205034:	fd043703          	ld	a4,-48(s0)
    80205038:	02f71d63          	bne	a4,a5,80205072 <memory_set_remove_area_with_start_vpn+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:125
    {
      map_area_unmap(&x[i], &memory_set->page_table, true);
    8020503c:	fe843703          	ld	a4,-24(s0)
    80205040:	87ba                	mv	a5,a4
    80205042:	0786                	slli	a5,a5,0x1
    80205044:	97ba                	add	a5,a5,a4
    80205046:	078e                	slli	a5,a5,0x3
    80205048:	873e                	mv	a4,a5
    8020504a:	fe043783          	ld	a5,-32(s0)
    8020504e:	97ba                	add	a5,a5,a4
    80205050:	fd843703          	ld	a4,-40(s0)
    80205054:	4605                	li	a2,1
    80205056:	85ba                	mv	a1,a4
    80205058:	853e                	mv	a0,a5
    8020505a:	d87ff0ef          	jal	ra,80204de0 <map_area_unmap>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:126
      vector_remove(&memory_set->areas, i);
    8020505e:	fd843783          	ld	a5,-40(s0)
    80205062:	02878793          	addi	a5,a5,40 # 1028 <n+0x1008>
    80205066:	fe843583          	ld	a1,-24(s0)
    8020506a:	853e                	mv	a0,a5
    8020506c:	209040ef          	jal	ra,80209a74 <vector_remove>
    80205070:	a031                	j	8020507c <memory_set_remove_area_with_start_vpn+0x7e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:130
    }
    else
    {
      i++;
    80205072:	fe843783          	ld	a5,-24(s0)
    80205076:	0785                	addi	a5,a5,1
    80205078:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:121
  while (i < memory_set->areas.size)
    8020507c:	fd843783          	ld	a5,-40(s0)
    80205080:	779c                	ld	a5,40(a5)
    80205082:	fe843703          	ld	a4,-24(s0)
    80205086:	f8f76ce3          	bltu	a4,a5,8020501e <memory_set_remove_area_with_start_vpn+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:133
    }
  }
}
    8020508a:	0001                	nop
    8020508c:	0001                	nop
    8020508e:	70a2                	ld	ra,40(sp)
    80205090:	7402                	ld	s0,32(sp)
    80205092:	6145                	addi	sp,sp,48
    80205094:	8082                	ret

0000000080205096 <memory_set_free>:
memory_set_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:136

void memory_set_free(MemorySet *memory_set)
{
    80205096:	7179                	addi	sp,sp,-48
    80205098:	f406                	sd	ra,40(sp)
    8020509a:	f022                	sd	s0,32(sp)
    8020509c:	1800                	addi	s0,sp,48
    8020509e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:137
  MapArea *x = (MapArea *)(memory_set->areas.buffer);
    802050a2:	fd843783          	ld	a5,-40(s0)
    802050a6:	63bc                	ld	a5,64(a5)
    802050a8:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:138
  for (uint64_t i = 0; i < memory_set->areas.size; i++)
    802050ac:	fe043423          	sd	zero,-24(s0)
    802050b0:	a03d                	j	802050de <memory_set_free+0x48>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:140 (discriminator 3)
  {
    map_area_unmap(&x[i], &memory_set->page_table, false);
    802050b2:	fe843703          	ld	a4,-24(s0)
    802050b6:	87ba                	mv	a5,a4
    802050b8:	0786                	slli	a5,a5,0x1
    802050ba:	97ba                	add	a5,a5,a4
    802050bc:	078e                	slli	a5,a5,0x3
    802050be:	873e                	mv	a4,a5
    802050c0:	fe043783          	ld	a5,-32(s0)
    802050c4:	97ba                	add	a5,a5,a4
    802050c6:	fd843703          	ld	a4,-40(s0)
    802050ca:	4601                	li	a2,0
    802050cc:	85ba                	mv	a1,a4
    802050ce:	853e                	mv	a0,a5
    802050d0:	d11ff0ef          	jal	ra,80204de0 <map_area_unmap>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:138 (discriminator 3)
  for (uint64_t i = 0; i < memory_set->areas.size; i++)
    802050d4:	fe843783          	ld	a5,-24(s0)
    802050d8:	0785                	addi	a5,a5,1
    802050da:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:138 (discriminator 1)
    802050de:	fd843783          	ld	a5,-40(s0)
    802050e2:	779c                	ld	a5,40(a5)
    802050e4:	fe843703          	ld	a4,-24(s0)
    802050e8:	fcf765e3          	bltu	a4,a5,802050b2 <memory_set_free+0x1c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:142
  }
  vector_free(&memory_set->areas);
    802050ec:	fd843783          	ld	a5,-40(s0)
    802050f0:	02878793          	addi	a5,a5,40
    802050f4:	853e                	mv	a0,a5
    802050f6:	15d040ef          	jal	ra,80209a52 <vector_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:143
  page_table_free(&memory_set->page_table);
    802050fa:	fd843783          	ld	a5,-40(s0)
    802050fe:	853e                	mv	a0,a5
    80205100:	721000ef          	jal	ra,80206020 <page_table_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:144
}
    80205104:	0001                	nop
    80205106:	70a2                	ld	ra,40(sp)
    80205108:	7402                	ld	s0,32(sp)
    8020510a:	6145                	addi	sp,sp,48
    8020510c:	8082                	ret

000000008020510e <memory_set_map_trampoline>:
memory_set_map_trampoline():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:159
extern uint8_t ekernel;
extern uint8_t strampoline;

// Mention that trampoline is not collected by areas.
static inline void memory_set_map_trampoline(MemorySet *memory_set)
{
    8020510e:	1101                	addi	sp,sp,-32
    80205110:	ec06                	sd	ra,24(sp)
    80205112:	e822                	sd	s0,16(sp)
    80205114:	1000                	addi	s0,sp,32
    80205116:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:160
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    8020511a:	fe843703          	ld	a4,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:161
                 addr2pn((PhysAddr)&strampoline), PTE_R | PTE_X);
    8020511e:	ffffc797          	auipc	a5,0xffffc
    80205122:	ee278793          	addi	a5,a5,-286 # 80201000 <__alltraps>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:160
  page_table_map(&memory_set->page_table, addr2pn(TRAMPOLINE),
    80205126:	83b1                	srli	a5,a5,0xc
    80205128:	46a9                	li	a3,10
    8020512a:	863e                	mv	a2,a5
    8020512c:	57fd                	li	a5,-1
    8020512e:	00c7d593          	srli	a1,a5,0xc
    80205132:	853a                	mv	a0,a4
    80205134:	108010ef          	jal	ra,8020623c <page_table_map>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:162
}
    80205138:	0001                	nop
    8020513a:	60e2                	ld	ra,24(sp)
    8020513c:	6442                	ld	s0,16(sp)
    8020513e:	6105                	addi	sp,sp,32
    80205140:	8082                	ret

0000000080205142 <memory_set_new_kernel>:
memory_set_new_kernel():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:166

static MemorySet KERNEL_SPACE;
static void memory_set_new_kernel()
{
    80205142:	7139                	addi	sp,sp,-64
    80205144:	fc06                	sd	ra,56(sp)
    80205146:	f822                	sd	s0,48(sp)
    80205148:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:167
  MemorySet *memory_set = &KERNEL_SPACE;
    8020514a:	00825797          	auipc	a5,0x825
    8020514e:	efe78793          	addi	a5,a5,-258 # 80a2a048 <KERNEL_SPACE>
    80205152:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:168
  memory_set_new_bare(memory_set);
    80205156:	fe043503          	ld	a0,-32(s0)
    8020515a:	d97ff0ef          	jal	ra,80204ef0 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:171

  // map trampoline
  memory_set_map_trampoline(memory_set);
    8020515e:	fe043503          	ld	a0,-32(s0)
    80205162:	fadff0ef          	jal	ra,8020510e <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:182
  // info("boot_stack [0x%llx, 0x%llx)\n", &sbss_with_stack, &ebss);

  MapArea map_area;

  // info("mapping .text section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&stext);
    80205166:	ffffb797          	auipc	a5,0xffffb
    8020516a:	e9a78793          	addi	a5,a5,-358 # 80200000 <_start>
    8020516e:	83b1                	srli	a5,a5,0xc
    80205170:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:183
  map_area.vpn_range.r = page_ceil((PhysAddr)&etext);
    80205174:	00005717          	auipc	a4,0x5
    80205178:	e8c70713          	addi	a4,a4,-372 # 8020a000 <etext>
    8020517c:	6785                	lui	a5,0x1
    8020517e:	17fd                	addi	a5,a5,-1
    80205180:	97ba                	add	a5,a5,a4
    80205182:	83b1                	srli	a5,a5,0xc
    80205184:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:184
  map_area.map_type = MAP_IDENTICAL;
    80205188:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:185
  map_area.map_perm = MAP_PERM_R | MAP_PERM_X;
    8020518c:	47a9                	li	a5,10
    8020518e:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:186
  memory_set_push(memory_set, &map_area, NULL, 0);
    80205192:	fc840793          	addi	a5,s0,-56
    80205196:	4681                	li	a3,0
    80205198:	4601                	li	a2,0
    8020519a:	85be                	mv	a1,a5
    8020519c:	fe043503          	ld	a0,-32(s0)
    802051a0:	da3ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:189

  // info("mapping .rodata section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&srodata);
    802051a4:	00005797          	auipc	a5,0x5
    802051a8:	e5c78793          	addi	a5,a5,-420 # 8020a000 <etext>
    802051ac:	83b1                	srli	a5,a5,0xc
    802051ae:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:190
  map_area.vpn_range.r = page_ceil((PhysAddr)&erodata);
    802051b2:	00006717          	auipc	a4,0x6
    802051b6:	e4e70713          	addi	a4,a4,-434 # 8020b000 <app_starts.1>
    802051ba:	6785                	lui	a5,0x1
    802051bc:	17fd                	addi	a5,a5,-1
    802051be:	97ba                	add	a5,a5,a4
    802051c0:	83b1                	srli	a5,a5,0xc
    802051c2:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:191
  map_area.map_type = MAP_IDENTICAL;
    802051c6:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:192
  map_area.map_perm = MAP_PERM_R;
    802051ca:	4789                	li	a5,2
    802051cc:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:193
  memory_set_push(memory_set, &map_area, NULL, 0);
    802051d0:	fc840793          	addi	a5,s0,-56
    802051d4:	4681                	li	a3,0
    802051d6:	4601                	li	a2,0
    802051d8:	85be                	mv	a1,a5
    802051da:	fe043503          	ld	a0,-32(s0)
    802051de:	d65ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:196

  // info("mapping .data section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sdata);
    802051e2:	00006797          	auipc	a5,0x6
    802051e6:	e1e78793          	addi	a5,a5,-482 # 8020b000 <app_starts.1>
    802051ea:	83b1                	srli	a5,a5,0xc
    802051ec:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:197
  map_area.vpn_range.r = page_ceil((PhysAddr)&edata);
    802051f0:	00011717          	auipc	a4,0x11
    802051f4:	e1070713          	addi	a4,a4,-496 # 80216000 <boot_stack_lower_bound>
    802051f8:	6785                	lui	a5,0x1
    802051fa:	17fd                	addi	a5,a5,-1
    802051fc:	97ba                	add	a5,a5,a4
    802051fe:	83b1                	srli	a5,a5,0xc
    80205200:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:198
  map_area.map_type = MAP_IDENTICAL;
    80205204:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:199
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80205208:	4799                	li	a5,6
    8020520a:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:200
  memory_set_push(memory_set, &map_area, NULL, 0);
    8020520e:	fc840793          	addi	a5,s0,-56
    80205212:	4681                	li	a3,0
    80205214:	4601                	li	a2,0
    80205216:	85be                	mv	a1,a5
    80205218:	fe043503          	ld	a0,-32(s0)
    8020521c:	d27ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:203

  // info("mapping .bss section\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&sbss_with_stack);
    80205220:	00011797          	auipc	a5,0x11
    80205224:	de078793          	addi	a5,a5,-544 # 80216000 <boot_stack_lower_bound>
    80205228:	83b1                	srli	a5,a5,0xc
    8020522a:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:204
  map_area.vpn_range.r = page_ceil((PhysAddr)&ebss);
    8020522e:	00b29717          	auipc	a4,0xb29
    80205232:	dd270713          	addi	a4,a4,-558 # 80d2e000 <ebss>
    80205236:	6785                	lui	a5,0x1
    80205238:	17fd                	addi	a5,a5,-1
    8020523a:	97ba                	add	a5,a5,a4
    8020523c:	83b1                	srli	a5,a5,0xc
    8020523e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:205
  map_area.map_type = MAP_IDENTICAL;
    80205242:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:206
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80205246:	4799                	li	a5,6
    80205248:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:207
  memory_set_push(memory_set, &map_area, NULL, 0);
    8020524c:	fc840793          	addi	a5,s0,-56
    80205250:	4681                	li	a3,0
    80205252:	4601                	li	a2,0
    80205254:	85be                	mv	a1,a5
    80205256:	fe043503          	ld	a0,-32(s0)
    8020525a:	ce9ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:210

  // info("mapping physical memory\n");
  map_area.vpn_range.l = page_floor((PhysAddr)&ekernel);
    8020525e:	00b29797          	auipc	a5,0xb29
    80205262:	da278793          	addi	a5,a5,-606 # 80d2e000 <ebss>
    80205266:	83b1                	srli	a5,a5,0xc
    80205268:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:211
  map_area.vpn_range.r = page_ceil((PhysAddr)MEMORY_END);
    8020526c:	000817b7          	lui	a5,0x81
    80205270:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:212
  map_area.map_type = MAP_IDENTICAL;
    80205274:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:213
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80205278:	4799                	li	a5,6
    8020527a:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:214
  memory_set_push(memory_set, &map_area, NULL, 0);
    8020527e:	fc840793          	addi	a5,s0,-56
    80205282:	4681                	li	a3,0
    80205284:	4601                	li	a2,0
    80205286:	85be                	mv	a1,a5
    80205288:	fe043503          	ld	a0,-32(s0)
    8020528c:	cb7ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:217

  // info("mapping memory-mapped registers\n");
  for (uint64_t i = 0; i < MMIO_NUM; i++)
    80205290:	fe043423          	sd	zero,-24(s0)
    80205294:	a08d                	j	802052f6 <memory_set_new_kernel+0x1b4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:219 (discriminator 3)
  {
    map_area.vpn_range.l = page_floor((PhysAddr)MMIO[i][0]);
    80205296:	00005717          	auipc	a4,0x5
    8020529a:	0ba70713          	addi	a4,a4,186 # 8020a350 <MMIO>
    8020529e:	fe843783          	ld	a5,-24(s0)
    802052a2:	0792                	slli	a5,a5,0x4
    802052a4:	97ba                	add	a5,a5,a4
    802052a6:	639c                	ld	a5,0(a5)
    802052a8:	83b1                	srli	a5,a5,0xc
    802052aa:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:220 (discriminator 3)
    map_area.vpn_range.r = page_ceil((PhysAddr)(MMIO[i][0] + MMIO[i][1]));
    802052ae:	00005717          	auipc	a4,0x5
    802052b2:	0a270713          	addi	a4,a4,162 # 8020a350 <MMIO>
    802052b6:	fe843783          	ld	a5,-24(s0)
    802052ba:	0792                	slli	a5,a5,0x4
    802052bc:	97ba                	add	a5,a5,a4
    802052be:	6398                	ld	a4,0(a5)
    802052c0:	6785                	lui	a5,0x1
    802052c2:	973e                	add	a4,a4,a5
    802052c4:	6785                	lui	a5,0x1
    802052c6:	17fd                	addi	a5,a5,-1
    802052c8:	97ba                	add	a5,a5,a4
    802052ca:	83b1                	srli	a5,a5,0xc
    802052cc:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:221 (discriminator 3)
    map_area.map_type = MAP_IDENTICAL;
    802052d0:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:222 (discriminator 3)
    map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    802052d4:	4799                	li	a5,6
    802052d6:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:223 (discriminator 3)
    memory_set_push(memory_set, &map_area, NULL, 0);
    802052da:	fc840793          	addi	a5,s0,-56
    802052de:	4681                	li	a3,0
    802052e0:	4601                	li	a2,0
    802052e2:	85be                	mv	a1,a5
    802052e4:	fe043503          	ld	a0,-32(s0)
    802052e8:	c5bff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:217 (discriminator 3)
  for (uint64_t i = 0; i < MMIO_NUM; i++)
    802052ec:	fe843783          	ld	a5,-24(s0)
    802052f0:	0785                	addi	a5,a5,1
    802052f2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:217 (discriminator 1)
    802052f6:	fe843783          	ld	a5,-24(s0)
    802052fa:	dfd1                	beqz	a5,80205296 <memory_set_new_kernel+0x154>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:227
  }

  // info("mapping plic\n");
  map_area.vpn_range.l = page_floor((PhysAddr)PLIC);
    802052fc:	67b1                	lui	a5,0xc
    802052fe:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:228
  map_area.vpn_range.r = page_ceil((PhysAddr)(PLIC + 0x400000));
    80205302:	67b1                	lui	a5,0xc
    80205304:	40078793          	addi	a5,a5,1024 # c400 <n+0xc3e0>
    80205308:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:229
  map_area.map_type = MAP_IDENTICAL;
    8020530c:	fc040c23          	sb	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:230
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80205310:	4799                	li	a5,6
    80205312:	fcf40ca3          	sb	a5,-39(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:231
  memory_set_push(memory_set, &map_area, NULL, 0);
    80205316:	fc840793          	addi	a5,s0,-56
    8020531a:	4681                	li	a3,0
    8020531c:	4601                	li	a2,0
    8020531e:	85be                	mv	a1,a5
    80205320:	fe043503          	ld	a0,-32(s0)
    80205324:	c1fff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:232
}
    80205328:	0001                	nop
    8020532a:	70e2                	ld	ra,56(sp)
    8020532c:	7442                	ld	s0,48(sp)
    8020532e:	6121                	addi	sp,sp,64
    80205330:	8082                	ret

0000000080205332 <memory_set_from_elf>:
memory_set_from_elf():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:237

void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point)
{
    80205332:	7111                	addi	sp,sp,-256
    80205334:	fd86                	sd	ra,248(sp)
    80205336:	f9a2                	sd	s0,240(sp)
    80205338:	f5a6                	sd	s1,232(sp)
    8020533a:	0200                	addi	s0,sp,256
    8020533c:	81010113          	addi	sp,sp,-2032 # 80225810 <boot_stack_lower_bound+0xf810>
    80205340:	77fd                	lui	a5,0xfffff
    80205342:	fe040493          	addi	s1,s0,-32
    80205346:	97a6                	add	a5,a5,s1
    80205348:	74a7bc23          	sd	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    8020534c:	77fd                	lui	a5,0xfffff
    8020534e:	fe040513          	addi	a0,s0,-32
    80205352:	97aa                	add	a5,a5,a0
    80205354:	74b7b823          	sd	a1,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d1750>
    80205358:	77fd                	lui	a5,0xfffff
    8020535a:	fe040593          	addi	a1,s0,-32
    8020535e:	97ae                	add	a5,a5,a1
    80205360:	74c7b423          	sd	a2,1864(a5) # fffffffffffff748 <ebss+0xffffffff7f2d1748>
    80205364:	77fd                	lui	a5,0xfffff
    80205366:	fe040613          	addi	a2,s0,-32
    8020536a:	97b2                	add	a5,a5,a2
    8020536c:	74d7b023          	sd	a3,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f2d1740>
    80205370:	77fd                	lui	a5,0xfffff
    80205372:	fe040693          	addi	a3,s0,-32
    80205376:	97b6                	add	a5,a5,a3
    80205378:	72e7bc23          	sd	a4,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f2d1738>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:238
  memory_set_new_bare(memory_set);
    8020537c:	77fd                	lui	a5,0xfffff
    8020537e:	fe040713          	addi	a4,s0,-32
    80205382:	97ba                	add	a5,a5,a4
    80205384:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    80205388:	b69ff0ef          	jal	ra,80204ef0 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:241

  // map trampoline
  memory_set_map_trampoline(memory_set);
    8020538c:	77fd                	lui	a5,0xfffff
    8020538e:	fe040713          	addi	a4,s0,-32
    80205392:	97ba                	add	a5,a5,a4
    80205394:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    80205398:	d77ff0ef          	jal	ra,8020510e <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:245

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
    8020539c:	77fd                	lui	a5,0xfffff
    8020539e:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    802053a2:	fe040713          	addi	a4,s0,-32
    802053a6:	00f706b3          	add	a3,a4,a5
    802053aa:	77fd                	lui	a5,0xfffff
    802053ac:	fe040713          	addi	a4,s0,-32
    802053b0:	973e                	add	a4,a4,a5
    802053b2:	77fd                	lui	a5,0xfffff
    802053b4:	fe040613          	addi	a2,s0,-32
    802053b8:	97b2                	add	a5,a5,a2
    802053ba:	8636                	mv	a2,a3
    802053bc:	74873583          	ld	a1,1864(a4)
    802053c0:	7507b503          	ld	a0,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d1750>
    802053c4:	c11fe0ef          	jal	ra,80203fd4 <elf_load>
    802053c8:	87aa                	mv	a5,a0
    802053ca:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:246
  if (elf_load_ret != 0)
    802053ce:	fcc42783          	lw	a5,-52(s0)
    802053d2:	2781                	sext.w	a5,a5
    802053d4:	cf89                	beqz	a5,802053ee <memory_set_from_elf+0xbc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:248
  {
    panic("Elf load error.\n");
    802053d6:	00005617          	auipc	a2,0x5
    802053da:	f8a60613          	addi	a2,a2,-118 # 8020a360 <MMIO+0x10>
    802053de:	0f800593          	li	a1,248
    802053e2:	00005517          	auipc	a0,0x5
    802053e6:	f9650513          	addi	a0,a0,-106 # 8020a378 <MMIO+0x28>
    802053ea:	3f2020ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:251
  }

  size_t ph_count = elf_header_get_phnum(&elf);
    802053ee:	77fd                	lui	a5,0xfffff
    802053f0:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    802053f4:	fe040713          	addi	a4,s0,-32
    802053f8:	97ba                	add	a5,a5,a4
    802053fa:	853e                	mv	a0,a5
    802053fc:	da9fe0ef          	jal	ra,802041a4 <elf_header_get_phnum>
    80205400:	fca43023          	sd	a0,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:256
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn = 0;
    80205404:	fc043c23          	sd	zero,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:257
  for (size_t i = 0; i < ph_count; i++)
    80205408:	fc043823          	sd	zero,-48(s0)
    8020540c:	a261                	j	80205594 <memory_set_from_elf+0x262>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:259
  {
    t_elf_program *ph = &elf.programs[i];
    8020540e:	77fd                	lui	a5,0xfffff
    80205410:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205414:	fe040713          	addi	a4,s0,-32
    80205418:	973e                	add	a4,a4,a5
    8020541a:	fd043783          	ld	a5,-48(s0)
    8020541e:	04278793          	addi	a5,a5,66
    80205422:	0792                	slli	a5,a5,0x4
    80205424:	97ba                	add	a5,a5,a4
    80205426:	07a1                	addi	a5,a5,8
    80205428:	faf43023          	sd	a5,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:260
    if (elf_program_get_type(&elf, ph) == PT_LOAD)
    8020542c:	77fd                	lui	a5,0xfffff
    8020542e:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205432:	fe040713          	addi	a4,s0,-32
    80205436:	97ba                	add	a5,a5,a4
    80205438:	fa043583          	ld	a1,-96(s0)
    8020543c:	853e                	mv	a0,a5
    8020543e:	8e9fe0ef          	jal	ra,80203d26 <elf_program_get_type>
    80205442:	87aa                	mv	a5,a0
    80205444:	2781                	sext.w	a5,a5
    80205446:	873e                	mv	a4,a5
    80205448:	4785                	li	a5,1
    8020544a:	14f71063          	bne	a4,a5,8020558a <memory_set_from_elf+0x258>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:262
    {
      start_va = (VirtAddr)elf_program_get_vaddr(&elf, ph);
    8020544e:	77fd                	lui	a5,0xfffff
    80205450:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205454:	fe040713          	addi	a4,s0,-32
    80205458:	97ba                	add	a5,a5,a4
    8020545a:	fa043583          	ld	a1,-96(s0)
    8020545e:	853e                	mv	a0,a5
    80205460:	99ffe0ef          	jal	ra,80203dfe <elf_program_get_vaddr>
    80205464:	f8a43c23          	sd	a0,-104(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:263
      end_va = (VirtAddr)(start_va + elf_program_get_memsz(&elf, ph));
    80205468:	77fd                	lui	a5,0xfffff
    8020546a:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    8020546e:	fe040713          	addi	a4,s0,-32
    80205472:	97ba                	add	a5,a5,a4
    80205474:	fa043583          	ld	a1,-96(s0)
    80205478:	853e                	mv	a0,a5
    8020547a:	9cdfe0ef          	jal	ra,80203e46 <elf_program_get_memsz>
    8020547e:	872a                	mv	a4,a0
    80205480:	f9843783          	ld	a5,-104(s0)
    80205484:	97ba                	add	a5,a5,a4
    80205486:	f8f43823          	sd	a5,-112(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:264
      map_perm = MAP_PERM_U;
    8020548a:	47c1                	li	a5,16
    8020548c:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:265
      ph_flags = elf_program_get_flags(&elf, ph);
    80205490:	77fd                	lui	a5,0xfffff
    80205492:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205496:	fe040713          	addi	a4,s0,-32
    8020549a:	97ba                	add	a5,a5,a4
    8020549c:	fa043583          	ld	a1,-96(s0)
    802054a0:	853e                	mv	a0,a5
    802054a2:	911fe0ef          	jal	ra,80203db2 <elf_program_get_flags>
    802054a6:	f8a43023          	sd	a0,-128(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:268
      if (ph_flags | PF_R)
      {
        map_perm |= MAP_PERM_R;
    802054aa:	f8f44783          	lbu	a5,-113(s0)
    802054ae:	0027e793          	ori	a5,a5,2
    802054b2:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:272
      }
      if (ph_flags | PF_W)
      {
        map_perm |= MAP_PERM_W;
    802054b6:	f8f44783          	lbu	a5,-113(s0)
    802054ba:	0047e793          	ori	a5,a5,4
    802054be:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:276
      }
      if (ph_flags | PF_X)
      {
        map_perm |= MAP_PERM_X;
    802054c2:	f8f44783          	lbu	a5,-113(s0)
    802054c6:	0087e793          	ori	a5,a5,8
    802054ca:	f8f407a3          	sb	a5,-113(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:278
      }
      map_area.vpn_range.l = page_floor(start_va);
    802054ce:	f9843783          	ld	a5,-104(s0)
    802054d2:	00c7d713          	srli	a4,a5,0xc
    802054d6:	77fd                	lui	a5,0xfffff
    802054d8:	fe040693          	addi	a3,s0,-32
    802054dc:	97b6                	add	a5,a5,a3
    802054de:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d1760>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:279
      map_area.vpn_range.r = page_ceil(end_va);
    802054e2:	f9043703          	ld	a4,-112(s0)
    802054e6:	6785                	lui	a5,0x1
    802054e8:	17fd                	addi	a5,a5,-1
    802054ea:	97ba                	add	a5,a5,a4
    802054ec:	00c7d713          	srli	a4,a5,0xc
    802054f0:	77fd                	lui	a5,0xfffff
    802054f2:	fe040693          	addi	a3,s0,-32
    802054f6:	97b6                	add	a5,a5,a3
    802054f8:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d1768>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:280
      map_area.map_type = MAP_FRAMED;
    802054fc:	77fd                	lui	a5,0xfffff
    802054fe:	fe040713          	addi	a4,s0,-32
    80205502:	97ba                	add	a5,a5,a4
    80205504:	4705                	li	a4,1
    80205506:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d1770>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:281
      map_area.map_perm = map_perm;
    8020550a:	77fd                	lui	a5,0xfffff
    8020550c:	fe040713          	addi	a4,s0,-32
    80205510:	97ba                	add	a5,a5,a4
    80205512:	f8f44703          	lbu	a4,-113(s0)
    80205516:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d1771>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:282
      max_end_vpn = map_area.vpn_range.r;
    8020551a:	77fd                	lui	a5,0xfffff
    8020551c:	fe040713          	addi	a4,s0,-32
    80205520:	97ba                	add	a5,a5,a4
    80205522:	7687b783          	ld	a5,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d1768>
    80205526:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:284
      memory_set_push(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
    8020552a:	77fd                	lui	a5,0xfffff
    8020552c:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205530:	fe040713          	addi	a4,s0,-32
    80205534:	97ba                	add	a5,a5,a4
    80205536:	fa043583          	ld	a1,-96(s0)
    8020553a:	853e                	mv	a0,a5
    8020553c:	82ffe0ef          	jal	ra,80203d6a <elf_program_get_offset>
    80205540:	872a                	mv	a4,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:283
      memory_set_push(memory_set, &map_area,
    80205542:	77fd                	lui	a5,0xfffff
    80205544:	fe040693          	addi	a3,s0,-32
    80205548:	97b6                	add	a5,a5,a3
    8020554a:	7507b783          	ld	a5,1872(a5) # fffffffffffff750 <ebss+0xffffffff7f2d1750>
    8020554e:	00e784b3          	add	s1,a5,a4
    80205552:	77fd                	lui	a5,0xfffff
    80205554:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    80205558:	fe040713          	addi	a4,s0,-32
    8020555c:	97ba                	add	a5,a5,a4
    8020555e:	fa043583          	ld	a1,-96(s0)
    80205562:	853e                	mv	a0,a5
    80205564:	92bfe0ef          	jal	ra,80203e8e <elf_program_get_filesz>
    80205568:	86aa                	mv	a3,a0
    8020556a:	77fd                	lui	a5,0xfffff
    8020556c:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d1760>
    80205570:	fe040713          	addi	a4,s0,-32
    80205574:	973e                	add	a4,a4,a5
    80205576:	77fd                	lui	a5,0xfffff
    80205578:	fe040613          	addi	a2,s0,-32
    8020557c:	97b2                	add	a5,a5,a2
    8020557e:	8626                	mv	a2,s1
    80205580:	85ba                	mv	a1,a4
    80205582:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    80205586:	9bdff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:257 (discriminator 2)
  for (size_t i = 0; i < ph_count; i++)
    8020558a:	fd043783          	ld	a5,-48(s0)
    8020558e:	0785                	addi	a5,a5,1
    80205590:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:257 (discriminator 1)
    80205594:	fd043703          	ld	a4,-48(s0)
    80205598:	fc043783          	ld	a5,-64(s0)
    8020559c:	e6f769e3          	bltu	a4,a5,8020540e <memory_set_from_elf+0xdc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:290
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = pn2addr(max_end_vpn);
    802055a0:	fd843783          	ld	a5,-40(s0)
    802055a4:	07b2                	slli	a5,a5,0xc
    802055a6:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:291
  VirtAddr user_stack_bottom = max_end_va;
    802055aa:	fb843783          	ld	a5,-72(s0)
    802055ae:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:293
  // guard page
  user_stack_bottom += PAGE_SIZE;
    802055b2:	fb043703          	ld	a4,-80(s0)
    802055b6:	6785                	lui	a5,0x1
    802055b8:	97ba                	add	a5,a5,a4
    802055ba:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:294
  VirtAddr user_stack_top = user_stack_bottom + USER_STACK_SIZE;
    802055be:	fb043703          	ld	a4,-80(s0)
    802055c2:	6789                	lui	a5,0x2
    802055c4:	97ba                	add	a5,a5,a4
    802055c6:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:295
  map_area.vpn_range.l = page_floor(user_stack_bottom);
    802055ca:	fb043783          	ld	a5,-80(s0)
    802055ce:	00c7d713          	srli	a4,a5,0xc
    802055d2:	77fd                	lui	a5,0xfffff
    802055d4:	fe040693          	addi	a3,s0,-32
    802055d8:	97b6                	add	a5,a5,a3
    802055da:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d1760>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:296
  map_area.vpn_range.r = page_ceil(user_stack_top);
    802055de:	fa843703          	ld	a4,-88(s0)
    802055e2:	6785                	lui	a5,0x1
    802055e4:	17fd                	addi	a5,a5,-1
    802055e6:	97ba                	add	a5,a5,a4
    802055e8:	00c7d713          	srli	a4,a5,0xc
    802055ec:	77fd                	lui	a5,0xfffff
    802055ee:	fe040693          	addi	a3,s0,-32
    802055f2:	97b6                	add	a5,a5,a3
    802055f4:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d1768>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:297
  map_area.map_type = MAP_FRAMED;
    802055f8:	77fd                	lui	a5,0xfffff
    802055fa:	fe040713          	addi	a4,s0,-32
    802055fe:	97ba                	add	a5,a5,a4
    80205600:	4705                	li	a4,1
    80205602:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d1770>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:298
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
    80205606:	77fd                	lui	a5,0xfffff
    80205608:	fe040713          	addi	a4,s0,-32
    8020560c:	97ba                	add	a5,a5,a4
    8020560e:	4759                	li	a4,22
    80205610:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d1771>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:299
  memory_set_push(memory_set, &map_area, NULL, 0);
    80205614:	77fd                	lui	a5,0xfffff
    80205616:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d1760>
    8020561a:	fe040713          	addi	a4,s0,-32
    8020561e:	973e                	add	a4,a4,a5
    80205620:	77fd                	lui	a5,0xfffff
    80205622:	fe040693          	addi	a3,s0,-32
    80205626:	97b6                	add	a5,a5,a3
    80205628:	4681                	li	a3,0
    8020562a:	4601                	li	a2,0
    8020562c:	85ba                	mv	a1,a4
    8020562e:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    80205632:	911ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:302

  // map TrapContext
  map_area.vpn_range.l = page_floor(TRAP_CONTEXT);
    80205636:	77fd                	lui	a5,0xfffff
    80205638:	fe040713          	addi	a4,s0,-32
    8020563c:	97ba                	add	a5,a5,a4
    8020563e:	7779                	lui	a4,0xffffe
    80205640:	8331                	srli	a4,a4,0xc
    80205642:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <ebss+0xffffffff7f2d1760>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:303
  map_area.vpn_range.r = page_ceil(TRAMPOLINE);
    80205646:	77fd                	lui	a5,0xfffff
    80205648:	fe040713          	addi	a4,s0,-32
    8020564c:	97ba                	add	a5,a5,a4
    8020564e:	577d                	li	a4,-1
    80205650:	8331                	srli	a4,a4,0xc
    80205652:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <ebss+0xffffffff7f2d1768>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:304
  map_area.map_type = MAP_FRAMED;
    80205656:	77fd                	lui	a5,0xfffff
    80205658:	fe040713          	addi	a4,s0,-32
    8020565c:	97ba                	add	a5,a5,a4
    8020565e:	4705                	li	a4,1
    80205660:	76e78823          	sb	a4,1904(a5) # fffffffffffff770 <ebss+0xffffffff7f2d1770>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:305
  map_area.map_perm = MAP_PERM_R | MAP_PERM_W;
    80205664:	77fd                	lui	a5,0xfffff
    80205666:	fe040713          	addi	a4,s0,-32
    8020566a:	97ba                	add	a5,a5,a4
    8020566c:	4719                	li	a4,6
    8020566e:	76e788a3          	sb	a4,1905(a5) # fffffffffffff771 <ebss+0xffffffff7f2d1771>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:306
  memory_set_push(memory_set, &map_area, NULL, 0);
    80205672:	77fd                	lui	a5,0xfffff
    80205674:	76078793          	addi	a5,a5,1888 # fffffffffffff760 <ebss+0xffffffff7f2d1760>
    80205678:	fe040713          	addi	a4,s0,-32
    8020567c:	973e                	add	a4,a4,a5
    8020567e:	77fd                	lui	a5,0xfffff
    80205680:	fe040693          	addi	a3,s0,-32
    80205684:	97b6                	add	a5,a5,a3
    80205686:	4681                	li	a3,0
    80205688:	4601                	li	a2,0
    8020568a:	85ba                	mv	a1,a4
    8020568c:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <ebss+0xffffffff7f2d1758>
    80205690:	8b3ff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:309

  // return
  *user_sp = (uint64_t)user_stack_top;
    80205694:	77fd                	lui	a5,0xfffff
    80205696:	fe040713          	addi	a4,s0,-32
    8020569a:	97ba                	add	a5,a5,a4
    8020569c:	7407b783          	ld	a5,1856(a5) # fffffffffffff740 <ebss+0xffffffff7f2d1740>
    802056a0:	fa843703          	ld	a4,-88(s0)
    802056a4:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:310
  *entry_point = elf_header_get_entry(&elf);
    802056a6:	77fd                	lui	a5,0xfffff
    802056a8:	77878793          	addi	a5,a5,1912 # fffffffffffff778 <ebss+0xffffffff7f2d1778>
    802056ac:	fe040713          	addi	a4,s0,-32
    802056b0:	97ba                	add	a5,a5,a4
    802056b2:	853e                	mv	a0,a5
    802056b4:	d62fe0ef          	jal	ra,80203c16 <elf_header_get_entry>
    802056b8:	872a                	mv	a4,a0
    802056ba:	77fd                	lui	a5,0xfffff
    802056bc:	fe040693          	addi	a3,s0,-32
    802056c0:	97b6                	add	a5,a5,a3
    802056c2:	7387b783          	ld	a5,1848(a5) # fffffffffffff738 <ebss+0xffffffff7f2d1738>
    802056c6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:311
}
    802056c8:	0001                	nop
    802056ca:	7f010113          	addi	sp,sp,2032
    802056ce:	70ee                	ld	ra,248(sp)
    802056d0:	744e                	ld	s0,240(sp)
    802056d2:	74ae                	ld	s1,232(sp)
    802056d4:	6111                	addi	sp,sp,256
    802056d6:	8082                	ret

00000000802056d8 <memory_set_from_existed_user>:
memory_set_from_existed_user():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:315

void memory_set_from_existed_user(MemorySet *memory_set,
                                  MemorySet *user_space)
{
    802056d8:	7159                	addi	sp,sp,-112
    802056da:	f486                	sd	ra,104(sp)
    802056dc:	f0a2                	sd	s0,96(sp)
    802056de:	eca6                	sd	s1,88(sp)
    802056e0:	1880                	addi	s0,sp,112
    802056e2:	f8a43c23          	sd	a0,-104(s0)
    802056e6:	f8b43823          	sd	a1,-112(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:317

  memory_set_new_bare(memory_set);
    802056ea:	f9843503          	ld	a0,-104(s0)
    802056ee:	803ff0ef          	jal	ra,80204ef0 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:320

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802056f2:	f9843503          	ld	a0,-104(s0)
    802056f6:	a19ff0ef          	jal	ra,8020510e <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:324

  // copy data sections / trap_context / user_stack
  MapArea new_area;
  MapArea *x = (MapArea *)(user_space->areas.buffer);
    802056fa:	f9043783          	ld	a5,-112(s0)
    802056fe:	63bc                	ld	a5,64(a5)
    80205700:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:326
  PhysPageNum src_ppn, dst_ppn;
  for (uint64_t i = 0; i < user_space->areas.size; i++)
    80205704:	fc043c23          	sd	zero,-40(s0)
    80205708:	a8f1                	j	802057e4 <memory_set_from_existed_user+0x10c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:328
  {
    map_area_from_another(&new_area, &x[i]);
    8020570a:	fd843703          	ld	a4,-40(s0)
    8020570e:	87ba                	mv	a5,a4
    80205710:	0786                	slli	a5,a5,0x1
    80205712:	97ba                	add	a5,a5,a4
    80205714:	078e                	slli	a5,a5,0x3
    80205716:	873e                	mv	a4,a5
    80205718:	fc843783          	ld	a5,-56(s0)
    8020571c:	973e                	add	a4,a4,a5
    8020571e:	fa040793          	addi	a5,s0,-96
    80205722:	85ba                	mv	a1,a4
    80205724:	853e                	mv	a0,a5
    80205726:	d4cff0ef          	jal	ra,80204c72 <map_area_from_another>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:329
    memory_set_push(memory_set, &new_area, NULL, 0);
    8020572a:	fa040793          	addi	a5,s0,-96
    8020572e:	4681                	li	a3,0
    80205730:	4601                	li	a2,0
    80205732:	85be                	mv	a1,a5
    80205734:	f9843503          	ld	a0,-104(s0)
    80205738:	80bff0ef          	jal	ra,80204f42 <memory_set_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:331
    // copy data from another space
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++)
    8020573c:	fd843703          	ld	a4,-40(s0)
    80205740:	87ba                	mv	a5,a4
    80205742:	0786                	slli	a5,a5,0x1
    80205744:	97ba                	add	a5,a5,a4
    80205746:	078e                	slli	a5,a5,0x3
    80205748:	873e                	mv	a4,a5
    8020574a:	fc843783          	ld	a5,-56(s0)
    8020574e:	97ba                	add	a5,a5,a4
    80205750:	639c                	ld	a5,0(a5)
    80205752:	fcf43823          	sd	a5,-48(s0)
    80205756:	a09d                	j	802057bc <memory_set_from_existed_user+0xe4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:333 (discriminator 3)
    {
      src_ppn = pte_ppn(*memory_set_translate(user_space, vpn));
    80205758:	fd043583          	ld	a1,-48(s0)
    8020575c:	f9043503          	ld	a0,-112(s0)
    80205760:	0f2000ef          	jal	ra,80205852 <memory_set_translate>
    80205764:	87aa                	mv	a5,a0
    80205766:	639c                	ld	a5,0(a5)
    80205768:	00a7d713          	srli	a4,a5,0xa
    8020576c:	57fd                	li	a5,-1
    8020576e:	83d1                	srli	a5,a5,0x14
    80205770:	8ff9                	and	a5,a5,a4
    80205772:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:334 (discriminator 3)
      dst_ppn = pte_ppn(*memory_set_translate(memory_set, vpn));
    80205776:	fd043583          	ld	a1,-48(s0)
    8020577a:	f9843503          	ld	a0,-104(s0)
    8020577e:	0d4000ef          	jal	ra,80205852 <memory_set_translate>
    80205782:	87aa                	mv	a5,a0
    80205784:	639c                	ld	a5,0(a5)
    80205786:	00a7d713          	srli	a4,a5,0xa
    8020578a:	57fd                	li	a5,-1
    8020578c:	83d1                	srli	a5,a5,0x14
    8020578e:	8ff9                	and	a5,a5,a4
    80205790:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:335 (discriminator 3)
      memcpy(ppn_get_bytes_array(dst_ppn), ppn_get_bytes_array(src_ppn),
    80205794:	fb843503          	ld	a0,-72(s0)
    80205798:	592000ef          	jal	ra,80205d2a <ppn_get_bytes_array>
    8020579c:	84aa                	mv	s1,a0
    8020579e:	fc043503          	ld	a0,-64(s0)
    802057a2:	588000ef          	jal	ra,80205d2a <ppn_get_bytes_array>
    802057a6:	87aa                	mv	a5,a0
    802057a8:	6605                	lui	a2,0x1
    802057aa:	85be                	mv	a1,a5
    802057ac:	8526                	mv	a0,s1
    802057ae:	840ff0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:331 (discriminator 3)
    for (VirtPageNum vpn = x[i].vpn_range.l; vpn < x[i].vpn_range.r; vpn++)
    802057b2:	fd043783          	ld	a5,-48(s0)
    802057b6:	0785                	addi	a5,a5,1
    802057b8:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:331 (discriminator 1)
    802057bc:	fd843703          	ld	a4,-40(s0)
    802057c0:	87ba                	mv	a5,a4
    802057c2:	0786                	slli	a5,a5,0x1
    802057c4:	97ba                	add	a5,a5,a4
    802057c6:	078e                	slli	a5,a5,0x3
    802057c8:	873e                	mv	a4,a5
    802057ca:	fc843783          	ld	a5,-56(s0)
    802057ce:	97ba                	add	a5,a5,a4
    802057d0:	679c                	ld	a5,8(a5)
    802057d2:	fd043703          	ld	a4,-48(s0)
    802057d6:	f8f761e3          	bltu	a4,a5,80205758 <memory_set_from_existed_user+0x80>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:326 (discriminator 2)
  for (uint64_t i = 0; i < user_space->areas.size; i++)
    802057da:	fd843783          	ld	a5,-40(s0)
    802057de:	0785                	addi	a5,a5,1
    802057e0:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:326 (discriminator 1)
    802057e4:	f9043783          	ld	a5,-112(s0)
    802057e8:	779c                	ld	a5,40(a5)
    802057ea:	fd843703          	ld	a4,-40(s0)
    802057ee:	f0f76ee3          	bltu	a4,a5,8020570a <memory_set_from_existed_user+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:339
             PAGE_SIZE);
    }
  }
}
    802057f2:	0001                	nop
    802057f4:	0001                	nop
    802057f6:	70a6                	ld	ra,104(sp)
    802057f8:	7406                	ld	s0,96(sp)
    802057fa:	64e6                	ld	s1,88(sp)
    802057fc:	6165                	addi	sp,sp,112
    802057fe:	8082                	ret

0000000080205800 <memory_set_activate>:
memory_set_activate():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:342

static void memory_set_activate(MemorySet *memory_set)
{
    80205800:	7179                	addi	sp,sp,-48
    80205802:	f406                	sd	ra,40(sp)
    80205804:	f022                	sd	s0,32(sp)
    80205806:	1800                	addi	s0,sp,48
    80205808:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:343
  uint64_t satp = page_table_token(&memory_set->page_table);
    8020580c:	fd843783          	ld	a5,-40(s0)
    80205810:	853e                	mv	a0,a5
    80205812:	339000ef          	jal	ra,8020634a <page_table_token>
    80205816:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:344
  w_satp(satp);
    8020581a:	fe843503          	ld	a0,-24(s0)
    8020581e:	c28ff0ef          	jal	ra,80204c46 <w_satp>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:345
  sfence_vma();
    80205822:	c3eff0ef          	jal	ra,80204c60 <sfence_vma>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:346
}
    80205826:	0001                	nop
    80205828:	70a2                	ld	ra,40(sp)
    8020582a:	7402                	ld	s0,32(sp)
    8020582c:	6145                	addi	sp,sp,48
    8020582e:	8082                	ret

0000000080205830 <memory_set_kernel_init>:
memory_set_kernel_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:349

void memory_set_kernel_init()
{
    80205830:	1141                	addi	sp,sp,-16
    80205832:	e406                	sd	ra,8(sp)
    80205834:	e022                	sd	s0,0(sp)
    80205836:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:350
  memory_set_new_kernel();
    80205838:	90bff0ef          	jal	ra,80205142 <memory_set_new_kernel>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:351
  memory_set_activate(&KERNEL_SPACE);
    8020583c:	00825517          	auipc	a0,0x825
    80205840:	80c50513          	addi	a0,a0,-2036 # 80a2a048 <KERNEL_SPACE>
    80205844:	fbdff0ef          	jal	ra,80205800 <memory_set_activate>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:352
}
    80205848:	0001                	nop
    8020584a:	60a2                	ld	ra,8(sp)
    8020584c:	6402                	ld	s0,0(sp)
    8020584e:	0141                	addi	sp,sp,16
    80205850:	8082                	ret

0000000080205852 <memory_set_translate>:
memory_set_translate():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:355

PageTableEntry *memory_set_translate(MemorySet *memory_set, VirtPageNum vpn)
{
    80205852:	1101                	addi	sp,sp,-32
    80205854:	ec06                	sd	ra,24(sp)
    80205856:	e822                	sd	s0,16(sp)
    80205858:	1000                	addi	s0,sp,32
    8020585a:	fea43423          	sd	a0,-24(s0)
    8020585e:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:356
  return page_table_translate(&memory_set->page_table, vpn);
    80205862:	fe843783          	ld	a5,-24(s0)
    80205866:	fe043583          	ld	a1,-32(s0)
    8020586a:	853e                	mv	a0,a5
    8020586c:	293000ef          	jal	ra,802062fe <page_table_translate>
    80205870:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:357
}
    80205872:	853e                	mv	a0,a5
    80205874:	60e2                	ld	ra,24(sp)
    80205876:	6442                	ld	s0,16(sp)
    80205878:	6105                	addi	sp,sp,32
    8020587a:	8082                	ret

000000008020587c <memory_set_recycle_data_pages>:
memory_set_recycle_data_pages():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:360

void memory_set_recycle_data_pages(MemorySet *memory_set)
{
    8020587c:	1101                	addi	sp,sp,-32
    8020587e:	ec06                	sd	ra,24(sp)
    80205880:	e822                	sd	s0,16(sp)
    80205882:	1000                	addi	s0,sp,32
    80205884:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:361
  memory_set_free(memory_set);
    80205888:	fe843503          	ld	a0,-24(s0)
    8020588c:	80bff0ef          	jal	ra,80205096 <memory_set_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:362
}
    80205890:	0001                	nop
    80205892:	60e2                	ld	ra,24(sp)
    80205894:	6442                	ld	s0,16(sp)
    80205896:	6105                	addi	sp,sp,32
    80205898:	8082                	ret

000000008020589a <kernel_space_insert_framed_area>:
kernel_space_insert_framed_area():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:366

void kernel_space_insert_framed_area(VirtAddr start_va, VirtAddr end_va,
                                     MapPermission permission)
{
    8020589a:	7179                	addi	sp,sp,-48
    8020589c:	f406                	sd	ra,40(sp)
    8020589e:	f022                	sd	s0,32(sp)
    802058a0:	1800                	addi	s0,sp,48
    802058a2:	fea43423          	sd	a0,-24(s0)
    802058a6:	feb43023          	sd	a1,-32(s0)
    802058aa:	87b2                	mv	a5,a2
    802058ac:	fcf40fa3          	sb	a5,-33(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:367
  memory_set_insert_framed_area(&KERNEL_SPACE, start_va, end_va, permission);
    802058b0:	fdf44783          	lbu	a5,-33(s0)
    802058b4:	86be                	mv	a3,a5
    802058b6:	fe043603          	ld	a2,-32(s0)
    802058ba:	fe843583          	ld	a1,-24(s0)
    802058be:	00824517          	auipc	a0,0x824
    802058c2:	78a50513          	addi	a0,a0,1930 # 80a2a048 <KERNEL_SPACE>
    802058c6:	edaff0ef          	jal	ra,80204fa0 <memory_set_insert_framed_area>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:368
}
    802058ca:	0001                	nop
    802058cc:	70a2                	ld	ra,40(sp)
    802058ce:	7402                	ld	s0,32(sp)
    802058d0:	6145                	addi	sp,sp,48
    802058d2:	8082                	ret

00000000802058d4 <kernel_space_remove_area_with_start_vpn>:
kernel_space_remove_area_with_start_vpn():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:371

void kernel_space_remove_area_with_start_vpn(VirtPageNum start_vpn)
{
    802058d4:	1101                	addi	sp,sp,-32
    802058d6:	ec06                	sd	ra,24(sp)
    802058d8:	e822                	sd	s0,16(sp)
    802058da:	1000                	addi	s0,sp,32
    802058dc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:372
  memory_set_remove_area_with_start_vpn(&KERNEL_SPACE, start_vpn);
    802058e0:	fe843583          	ld	a1,-24(s0)
    802058e4:	00824517          	auipc	a0,0x824
    802058e8:	76450513          	addi	a0,a0,1892 # 80a2a048 <KERNEL_SPACE>
    802058ec:	f12ff0ef          	jal	ra,80204ffe <memory_set_remove_area_with_start_vpn>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:373
}
    802058f0:	0001                	nop
    802058f2:	60e2                	ld	ra,24(sp)
    802058f4:	6442                	ld	s0,16(sp)
    802058f6:	6105                	addi	sp,sp,32
    802058f8:	8082                	ret

00000000802058fa <kernel_space_token>:
kernel_space_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:375

uint64_t kernel_space_token() { return memory_set_token(&KERNEL_SPACE); }
    802058fa:	1141                	addi	sp,sp,-16
    802058fc:	e406                	sd	ra,8(sp)
    802058fe:	e022                	sd	s0,0(sp)
    80205900:	0800                	addi	s0,sp,16
    80205902:	00824517          	auipc	a0,0x824
    80205906:	74650513          	addi	a0,a0,1862 # 80a2a048 <KERNEL_SPACE>
    8020590a:	e16ff0ef          	jal	ra,80204f20 <memory_set_token>
    8020590e:	87aa                	mv	a5,a0
    80205910:	853e                	mv	a0,a5
    80205912:	60a2                	ld	ra,8(sp)
    80205914:	6402                	ld	s0,0(sp)
    80205916:	0141                	addi	sp,sp,16
    80205918:	8082                	ret

000000008020591a <memory_set_mmap>:
memory_set_mmap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:379

int64_t memory_set_mmap(MemorySet *memory_set, uint64_t start, uint64_t len,
                        uint64_t prot)
{
    8020591a:	7119                	addi	sp,sp,-128
    8020591c:	fc86                	sd	ra,120(sp)
    8020591e:	f8a2                	sd	s0,112(sp)
    80205920:	0100                	addi	s0,sp,128
    80205922:	f8a43c23          	sd	a0,-104(s0)
    80205926:	f8b43823          	sd	a1,-112(s0)
    8020592a:	f8c43423          	sd	a2,-120(s0)
    8020592e:	f8d43023          	sd	a3,-128(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:380
  if (len == 0)
    80205932:	f8843783          	ld	a5,-120(s0)
    80205936:	e399                	bnez	a5,8020593c <memory_set_mmap+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:382
  {
    return 0;
    80205938:	4781                	li	a5,0
    8020593a:	a2b5                	j	80205aa6 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:385
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    8020593c:	f9043703          	ld	a4,-112(s0)
    80205940:	6785                	lui	a5,0x1
    80205942:	17fd                	addi	a5,a5,-1
    80205944:	8ff9                	and	a5,a5,a4
    80205946:	ef99                	bnez	a5,80205964 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:385 (discriminator 1)
    80205948:	f8843703          	ld	a4,-120(s0)
    8020594c:	400007b7          	lui	a5,0x40000
    80205950:	00e7ea63          	bltu	a5,a4,80205964 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:385 (discriminator 2)
    80205954:	f8043783          	ld	a5,-128(s0)
    80205958:	9be1                	andi	a5,a5,-8
    8020595a:	e789                	bnez	a5,80205964 <memory_set_mmap+0x4a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:386 (discriminator 3)
      ((prot & 0x7) == 0))
    8020595c:	f8043783          	ld	a5,-128(s0)
    80205960:	8b9d                	andi	a5,a5,7
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:385 (discriminator 3)
  if (!page_aligned(start) || (len > MMAP_MAX_SIZE) || ((prot & ~0x7) != 0) ||
    80205962:	e399                	bnez	a5,80205968 <memory_set_mmap+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:388
  {
    return -1;
    80205964:	57fd                	li	a5,-1
    80205966:	a281                	j	80205aa6 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:391
  }

  len = page_ceil(len) * PAGE_SIZE;
    80205968:	f8843703          	ld	a4,-120(s0)
    8020596c:	6785                	lui	a5,0x1
    8020596e:	17fd                	addi	a5,a5,-1
    80205970:	973e                	add	a4,a4,a5
    80205972:	77fd                	lui	a5,0xfffff
    80205974:	8ff9                	and	a5,a5,a4
    80205976:	f8f43423          	sd	a5,-120(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:392
  VirtPageNum vpn_start = addr2pn(start);
    8020597a:	f9043783          	ld	a5,-112(s0)
    8020597e:	83b1                	srli	a5,a5,0xc
    80205980:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:393
  VirtPageNum vpn_end = addr2pn(start + len);
    80205984:	f9043703          	ld	a4,-112(s0)
    80205988:	f8843783          	ld	a5,-120(s0)
    8020598c:	97ba                	add	a5,a5,a4
    8020598e:	83b1                	srli	a5,a5,0xc
    80205990:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:394
  PageTable *pt = &memory_set->page_table;
    80205994:	f9843783          	ld	a5,-104(s0)
    80205998:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:397

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    8020599c:	fc843783          	ld	a5,-56(s0)
    802059a0:	fef43423          	sd	a5,-24(s0)
    802059a4:	a005                	j	802059c4 <memory_set_mmap+0xaa>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:399
  {
    if (page_table_find_pte(pt, vpn))
    802059a6:	fe843583          	ld	a1,-24(s0)
    802059aa:	fb843503          	ld	a0,-72(s0)
    802059ae:	7da000ef          	jal	ra,80206188 <page_table_find_pte>
    802059b2:	87aa                	mv	a5,a0
    802059b4:	c399                	beqz	a5,802059ba <memory_set_mmap+0xa0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:401
    {
      return -1;
    802059b6:	57fd                	li	a5,-1
    802059b8:	a0fd                	j	80205aa6 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:397 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    802059ba:	fe843783          	ld	a5,-24(s0)
    802059be:	0785                	addi	a5,a5,1
    802059c0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:397 (discriminator 1)
    802059c4:	fe843703          	ld	a4,-24(s0)
    802059c8:	fc043783          	ld	a5,-64(s0)
    802059cc:	fcf76de3          	bltu	a4,a5,802059a6 <memory_set_mmap+0x8c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:405
    }
  }

  MapPermission map_perm = MAP_PERM_U;
    802059d0:	47c1                	li	a5,16
    802059d2:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:406
  if ((prot & 0x1) != 0)
    802059d6:	f8043783          	ld	a5,-128(s0)
    802059da:	8b85                	andi	a5,a5,1
    802059dc:	c799                	beqz	a5,802059ea <memory_set_mmap+0xd0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:407
    map_perm |= MAP_PERM_R;
    802059de:	fe744783          	lbu	a5,-25(s0)
    802059e2:	0027e793          	ori	a5,a5,2
    802059e6:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:408
  if ((prot & 0x2) != 0)
    802059ea:	f8043783          	ld	a5,-128(s0)
    802059ee:	8b89                	andi	a5,a5,2
    802059f0:	c799                	beqz	a5,802059fe <memory_set_mmap+0xe4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:409
    map_perm |= MAP_PERM_W;
    802059f2:	fe744783          	lbu	a5,-25(s0)
    802059f6:	0047e793          	ori	a5,a5,4
    802059fa:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:410
  if ((prot & 0x4) != 0)
    802059fe:	f8043783          	ld	a5,-128(s0)
    80205a02:	8b91                	andi	a5,a5,4
    80205a04:	c799                	beqz	a5,80205a12 <memory_set_mmap+0xf8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:411
    map_perm |= MAP_PERM_X;
    80205a06:	fe744783          	lbu	a5,-25(s0)
    80205a0a:	0087e793          	ori	a5,a5,8
    80205a0e:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:416

  // map
  PhysPageNum ppn;
  PTEFlags pte_flags;
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205a12:	fc843783          	ld	a5,-56(s0)
    80205a16:	fcf43c23          	sd	a5,-40(s0)
    80205a1a:	a0a1                	j	80205a62 <memory_set_mmap+0x148>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:418 (discriminator 3)
  {
    ppn = frame_alloc();
    80205a1c:	396000ef          	jal	ra,80205db2 <frame_alloc>
    80205a20:	87aa                	mv	a5,a0
    80205a22:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:419 (discriminator 3)
    pte_flags = (PTEFlags)(map_perm);
    80205a26:	fe744783          	lbu	a5,-25(s0)
    80205a2a:	faf40ba3          	sb	a5,-73(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:420 (discriminator 3)
    page_table_map(pt, vpn, ppn, pte_flags);
    80205a2e:	fa843783          	ld	a5,-88(s0)
    80205a32:	fb744703          	lbu	a4,-73(s0)
    80205a36:	86ba                	mv	a3,a4
    80205a38:	863e                	mv	a2,a5
    80205a3a:	fd843583          	ld	a1,-40(s0)
    80205a3e:	fb843503          	ld	a0,-72(s0)
    80205a42:	7fa000ef          	jal	ra,8020623c <page_table_map>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:421 (discriminator 3)
    vector_push(&pt->frames, &ppn);
    80205a46:	fb843783          	ld	a5,-72(s0)
    80205a4a:	07a1                	addi	a5,a5,8
    80205a4c:	fa840713          	addi	a4,s0,-88
    80205a50:	85ba                	mv	a1,a4
    80205a52:	853e                	mv	a0,a5
    80205a54:	67b030ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:416 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205a58:	fd843783          	ld	a5,-40(s0)
    80205a5c:	0785                	addi	a5,a5,1
    80205a5e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:416 (discriminator 1)
    80205a62:	fd843703          	ld	a4,-40(s0)
    80205a66:	fc043783          	ld	a5,-64(s0)
    80205a6a:	faf769e3          	bltu	a4,a5,80205a1c <memory_set_mmap+0x102>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:425
  }

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205a6e:	fc843783          	ld	a5,-56(s0)
    80205a72:	fcf43823          	sd	a5,-48(s0)
    80205a76:	a005                	j	80205a96 <memory_set_mmap+0x17c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:427
  {
    if (!page_table_find_pte(pt, vpn))
    80205a78:	fd043583          	ld	a1,-48(s0)
    80205a7c:	fb843503          	ld	a0,-72(s0)
    80205a80:	708000ef          	jal	ra,80206188 <page_table_find_pte>
    80205a84:	87aa                	mv	a5,a0
    80205a86:	e399                	bnez	a5,80205a8c <memory_set_mmap+0x172>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:429
    {
      return -1;
    80205a88:	57fd                	li	a5,-1
    80205a8a:	a831                	j	80205aa6 <memory_set_mmap+0x18c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:425 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205a8c:	fd043783          	ld	a5,-48(s0)
    80205a90:	0785                	addi	a5,a5,1
    80205a92:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:425 (discriminator 1)
    80205a96:	fd043703          	ld	a4,-48(s0)
    80205a9a:	fc043783          	ld	a5,-64(s0)
    80205a9e:	fcf76de3          	bltu	a4,a5,80205a78 <memory_set_mmap+0x15e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:433
    }
  }

  return len;
    80205aa2:	f8843783          	ld	a5,-120(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:434 (discriminator 1)
}
    80205aa6:	853e                	mv	a0,a5
    80205aa8:	70e6                	ld	ra,120(sp)
    80205aaa:	7446                	ld	s0,112(sp)
    80205aac:	6109                	addi	sp,sp,128
    80205aae:	8082                	ret

0000000080205ab0 <memory_set_munmap>:
memory_set_munmap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:437

int64_t memory_set_munmap(MemorySet *memory_set, uint64_t start, uint64_t len)
{
    80205ab0:	711d                	addi	sp,sp,-96
    80205ab2:	ec86                	sd	ra,88(sp)
    80205ab4:	e8a2                	sd	s0,80(sp)
    80205ab6:	1080                	addi	s0,sp,96
    80205ab8:	faa43c23          	sd	a0,-72(s0)
    80205abc:	fab43823          	sd	a1,-80(s0)
    80205ac0:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:438
  if (len == 0)
    80205ac4:	fa843783          	ld	a5,-88(s0)
    80205ac8:	e399                	bnez	a5,80205ace <memory_set_munmap+0x1e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:440
  {
    return 0;
    80205aca:	4781                	li	a5,0
    80205acc:	a0ed                	j	80205bb6 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:443
  }

  if (!page_aligned(start) || (len > MMAP_MAX_SIZE))
    80205ace:	fb043703          	ld	a4,-80(s0)
    80205ad2:	6785                	lui	a5,0x1
    80205ad4:	17fd                	addi	a5,a5,-1
    80205ad6:	8ff9                	and	a5,a5,a4
    80205ad8:	e799                	bnez	a5,80205ae6 <memory_set_munmap+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:443 (discriminator 1)
    80205ada:	fa843703          	ld	a4,-88(s0)
    80205ade:	400007b7          	lui	a5,0x40000
    80205ae2:	00e7f463          	bgeu	a5,a4,80205aea <memory_set_munmap+0x3a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:445
  {
    return -1;
    80205ae6:	57fd                	li	a5,-1
    80205ae8:	a0f9                	j	80205bb6 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:448
  }

  len = page_ceil(len) * PAGE_SIZE;
    80205aea:	fa843703          	ld	a4,-88(s0)
    80205aee:	6785                	lui	a5,0x1
    80205af0:	17fd                	addi	a5,a5,-1
    80205af2:	973e                	add	a4,a4,a5
    80205af4:	77fd                	lui	a5,0xfffff
    80205af6:	8ff9                	and	a5,a5,a4
    80205af8:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:449
  VirtPageNum vpn_start = addr2pn(start);
    80205afc:	fb043783          	ld	a5,-80(s0)
    80205b00:	83b1                	srli	a5,a5,0xc
    80205b02:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:450
  VirtPageNum vpn_end = addr2pn(start + len);
    80205b06:	fb043703          	ld	a4,-80(s0)
    80205b0a:	fa843783          	ld	a5,-88(s0)
    80205b0e:	97ba                	add	a5,a5,a4
    80205b10:	83b1                	srli	a5,a5,0xc
    80205b12:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:451
  PageTable *pt = &memory_set->page_table;
    80205b16:	fb843783          	ld	a5,-72(s0)
    80205b1a:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:454

  // check mapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b1e:	fd043783          	ld	a5,-48(s0)
    80205b22:	fef43423          	sd	a5,-24(s0)
    80205b26:	a005                	j	80205b46 <memory_set_munmap+0x96>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:456
  {
    if (!page_table_find_pte(pt, vpn))
    80205b28:	fe843583          	ld	a1,-24(s0)
    80205b2c:	fc043503          	ld	a0,-64(s0)
    80205b30:	658000ef          	jal	ra,80206188 <page_table_find_pte>
    80205b34:	87aa                	mv	a5,a0
    80205b36:	e399                	bnez	a5,80205b3c <memory_set_munmap+0x8c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:458
    {
      return -1;
    80205b38:	57fd                	li	a5,-1
    80205b3a:	a8b5                	j	80205bb6 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:454 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b3c:	fe843783          	ld	a5,-24(s0)
    80205b40:	0785                	addi	a5,a5,1
    80205b42:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:454 (discriminator 1)
    80205b46:	fe843703          	ld	a4,-24(s0)
    80205b4a:	fc843783          	ld	a5,-56(s0)
    80205b4e:	fcf76de3          	bltu	a4,a5,80205b28 <memory_set_munmap+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:463
    }
  }

  // unmap
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b52:	fd043783          	ld	a5,-48(s0)
    80205b56:	fef43023          	sd	a5,-32(s0)
    80205b5a:	a821                	j	80205b72 <memory_set_munmap+0xc2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:465 (discriminator 3)
  {
    page_table_unmap(pt, vpn);
    80205b5c:	fe043583          	ld	a1,-32(s0)
    80205b60:	fc043503          	ld	a0,-64(s0)
    80205b64:	746000ef          	jal	ra,802062aa <page_table_unmap>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:463 (discriminator 3)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b68:	fe043783          	ld	a5,-32(s0)
    80205b6c:	0785                	addi	a5,a5,1
    80205b6e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:463 (discriminator 1)
    80205b72:	fe043703          	ld	a4,-32(s0)
    80205b76:	fc843783          	ld	a5,-56(s0)
    80205b7a:	fef761e3          	bltu	a4,a5,80205b5c <memory_set_munmap+0xac>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:469
  }

  // check unmapped
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b7e:	fd043783          	ld	a5,-48(s0)
    80205b82:	fcf43c23          	sd	a5,-40(s0)
    80205b86:	a005                	j	80205ba6 <memory_set_munmap+0xf6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:471
  {
    if (page_table_find_pte(pt, vpn))
    80205b88:	fd843583          	ld	a1,-40(s0)
    80205b8c:	fc043503          	ld	a0,-64(s0)
    80205b90:	5f8000ef          	jal	ra,80206188 <page_table_find_pte>
    80205b94:	87aa                	mv	a5,a0
    80205b96:	c399                	beqz	a5,80205b9c <memory_set_munmap+0xec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:473
    {
      return -1;
    80205b98:	57fd                	li	a5,-1
    80205b9a:	a831                	j	80205bb6 <memory_set_munmap+0x106>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:469 (discriminator 2)
  for (VirtPageNum vpn = vpn_start; vpn < vpn_end; vpn++)
    80205b9c:	fd843783          	ld	a5,-40(s0)
    80205ba0:	0785                	addi	a5,a5,1
    80205ba2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:469 (discriminator 1)
    80205ba6:	fd843703          	ld	a4,-40(s0)
    80205baa:	fc843783          	ld	a5,-56(s0)
    80205bae:	fcf76de3          	bltu	a4,a5,80205b88 <memory_set_munmap+0xd8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:477
    }
  }

  return len;
    80205bb2:	fa843783          	ld	a5,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:478
}
    80205bb6:	853e                	mv	a0,a5
    80205bb8:	60e6                	ld	ra,88(sp)
    80205bba:	6446                	ld	s0,80(sp)
    80205bbc:	6125                	addi	sp,sp,96
    80205bbe:	8082                	ret

0000000080205bc0 <memory_set_remap_test>:
memory_set_remap_test():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:481

void memory_set_remap_test()
{
    80205bc0:	7179                	addi	sp,sp,-48
    80205bc2:	f406                	sd	ra,40(sp)
    80205bc4:	f022                	sd	s0,32(sp)
    80205bc6:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:482
  VirtAddr mid_text = (VirtAddr)(((uint64_t)&stext + (uint64_t)&etext) / 2);
    80205bc8:	ffffa717          	auipc	a4,0xffffa
    80205bcc:	43870713          	addi	a4,a4,1080 # 80200000 <_start>
    80205bd0:	00004797          	auipc	a5,0x4
    80205bd4:	43078793          	addi	a5,a5,1072 # 8020a000 <etext>
    80205bd8:	97ba                	add	a5,a5,a4
    80205bda:	8385                	srli	a5,a5,0x1
    80205bdc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:484
  VirtAddr mid_rodata =
      (VirtAddr)(((uint64_t)&srodata + (uint64_t)&erodata) / 2);
    80205be0:	00004717          	auipc	a4,0x4
    80205be4:	42070713          	addi	a4,a4,1056 # 8020a000 <etext>
    80205be8:	00005797          	auipc	a5,0x5
    80205bec:	41878793          	addi	a5,a5,1048 # 8020b000 <app_starts.1>
    80205bf0:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:483
  VirtAddr mid_rodata =
    80205bf2:	8385                	srli	a5,a5,0x1
    80205bf4:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:485
  VirtAddr mid_data = (VirtAddr)(((uint64_t)&sdata + (uint64_t)&edata) / 2);
    80205bf8:	00005717          	auipc	a4,0x5
    80205bfc:	40870713          	addi	a4,a4,1032 # 8020b000 <app_starts.1>
    80205c00:	00010797          	auipc	a5,0x10
    80205c04:	40078793          	addi	a5,a5,1024 # 80216000 <boot_stack_lower_bound>
    80205c08:	97ba                	add	a5,a5,a4
    80205c0a:	8385                	srli	a5,a5,0x1
    80205c0c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:487

  ASSERT(!pte_writable(*page_table_translate(
    80205c10:	fe843783          	ld	a5,-24(s0)
    80205c14:	83b1                	srli	a5,a5,0xc
    80205c16:	85be                	mv	a1,a5
    80205c18:	00824517          	auipc	a0,0x824
    80205c1c:	43050513          	addi	a0,a0,1072 # 80a2a048 <KERNEL_SPACE>
    80205c20:	6de000ef          	jal	ra,802062fe <page_table_translate>
    80205c24:	87aa                	mv	a5,a0
    80205c26:	639c                	ld	a5,0(a5)
    80205c28:	8b91                	andi	a5,a5,4
    80205c2a:	cf89                	beqz	a5,80205c44 <memory_set_remap_test+0x84>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:487 (discriminator 1)
    80205c2c:	00004617          	auipc	a2,0x4
    80205c30:	76c60613          	addi	a2,a2,1900 # 8020a398 <MMIO+0x48>
    80205c34:	1e700593          	li	a1,487
    80205c38:	00004517          	auipc	a0,0x4
    80205c3c:	74050513          	addi	a0,a0,1856 # 8020a378 <MMIO+0x28>
    80205c40:	39d010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:489
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_text))));
  ASSERT(!pte_writable(*page_table_translate(
    80205c44:	fe043783          	ld	a5,-32(s0)
    80205c48:	83b1                	srli	a5,a5,0xc
    80205c4a:	85be                	mv	a1,a5
    80205c4c:	00824517          	auipc	a0,0x824
    80205c50:	3fc50513          	addi	a0,a0,1020 # 80a2a048 <KERNEL_SPACE>
    80205c54:	6aa000ef          	jal	ra,802062fe <page_table_translate>
    80205c58:	87aa                	mv	a5,a0
    80205c5a:	639c                	ld	a5,0(a5)
    80205c5c:	8b91                	andi	a5,a5,4
    80205c5e:	cf89                	beqz	a5,80205c78 <memory_set_remap_test+0xb8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:489 (discriminator 1)
    80205c60:	00004617          	auipc	a2,0x4
    80205c64:	7b060613          	addi	a2,a2,1968 # 8020a410 <MMIO+0xc0>
    80205c68:	1e900593          	li	a1,489
    80205c6c:	00004517          	auipc	a0,0x4
    80205c70:	70c50513          	addi	a0,a0,1804 # 8020a378 <MMIO+0x28>
    80205c74:	369010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:491
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_rodata))));
  ASSERT(!pte_executable(*page_table_translate(
    80205c78:	fd843783          	ld	a5,-40(s0)
    80205c7c:	83b1                	srli	a5,a5,0xc
    80205c7e:	85be                	mv	a1,a5
    80205c80:	00824517          	auipc	a0,0x824
    80205c84:	3c850513          	addi	a0,a0,968 # 80a2a048 <KERNEL_SPACE>
    80205c88:	676000ef          	jal	ra,802062fe <page_table_translate>
    80205c8c:	87aa                	mv	a5,a0
    80205c8e:	639c                	ld	a5,0(a5)
    80205c90:	8ba1                	andi	a5,a5,8
    80205c92:	cf89                	beqz	a5,80205cac <memory_set_remap_test+0xec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:491 (discriminator 1)
    80205c94:	00004617          	auipc	a2,0x4
    80205c98:	7f460613          	addi	a2,a2,2036 # 8020a488 <MMIO+0x138>
    80205c9c:	1eb00593          	li	a1,491
    80205ca0:	00004517          	auipc	a0,0x4
    80205ca4:	6d850513          	addi	a0,a0,1752 # 8020a378 <MMIO+0x28>
    80205ca8:	335010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/memory_set.c:493
      &KERNEL_SPACE.page_table, (VirtPageNum)page_floor(mid_data))));
    80205cac:	0001                	nop
    80205cae:	70a2                	ld	ra,40(sp)
    80205cb0:	7402                	ld	s0,32(sp)
    80205cb2:	6145                	addi	sp,sp,48
    80205cb4:	8082                	ret

0000000080205cb6 <vpn_indexes>:
vpn_indexes():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:5
#include "config.h"
#include "mem.h"

void vpn_indexes(VirtPageNum vpn, uint64_t *idx)
{
    80205cb6:	7179                	addi	sp,sp,-48
    80205cb8:	f422                	sd	s0,40(sp)
    80205cba:	1800                	addi	s0,sp,48
    80205cbc:	fca43c23          	sd	a0,-40(s0)
    80205cc0:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:6
  for (int i = 2; i >= 0; i--)
    80205cc4:	4789                	li	a5,2
    80205cc6:	fef42623          	sw	a5,-20(s0)
    80205cca:	a035                	j	80205cf6 <vpn_indexes+0x40>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:8 (discriminator 3)
  {
    idx[i] = vpn & 0x1ff;
    80205ccc:	fec42783          	lw	a5,-20(s0)
    80205cd0:	078e                	slli	a5,a5,0x3
    80205cd2:	fd043703          	ld	a4,-48(s0)
    80205cd6:	97ba                	add	a5,a5,a4
    80205cd8:	fd843703          	ld	a4,-40(s0)
    80205cdc:	1ff77713          	andi	a4,a4,511
    80205ce0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:9 (discriminator 3)
    vpn >>= 9;
    80205ce2:	fd843783          	ld	a5,-40(s0)
    80205ce6:	83a5                	srli	a5,a5,0x9
    80205ce8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:6 (discriminator 3)
  for (int i = 2; i >= 0; i--)
    80205cec:	fec42783          	lw	a5,-20(s0)
    80205cf0:	37fd                	addiw	a5,a5,-1
    80205cf2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:6 (discriminator 1)
    80205cf6:	fec42783          	lw	a5,-20(s0)
    80205cfa:	2781                	sext.w	a5,a5
    80205cfc:	fc07d8e3          	bgez	a5,80205ccc <vpn_indexes+0x16>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:11
  }
}
    80205d00:	0001                	nop
    80205d02:	0001                	nop
    80205d04:	7422                	ld	s0,40(sp)
    80205d06:	6145                	addi	sp,sp,48
    80205d08:	8082                	ret

0000000080205d0a <ppn_get_pte_array>:
ppn_get_pte_array():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:14

PageTableEntry *ppn_get_pte_array(PhysPageNum ppn)
{
    80205d0a:	7179                	addi	sp,sp,-48
    80205d0c:	f422                	sd	s0,40(sp)
    80205d0e:	1800                	addi	s0,sp,48
    80205d10:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:15
  PhysAddr pa = pn2addr(ppn);
    80205d14:	fd843783          	ld	a5,-40(s0)
    80205d18:	07b2                	slli	a5,a5,0xc
    80205d1a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:16
  return (PageTableEntry *)pa; // len = 512 * 8
    80205d1e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:17
}
    80205d22:	853e                	mv	a0,a5
    80205d24:	7422                	ld	s0,40(sp)
    80205d26:	6145                	addi	sp,sp,48
    80205d28:	8082                	ret

0000000080205d2a <ppn_get_bytes_array>:
ppn_get_bytes_array():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:20

uint8_t *ppn_get_bytes_array(PhysPageNum ppn)
{
    80205d2a:	7179                	addi	sp,sp,-48
    80205d2c:	f422                	sd	s0,40(sp)
    80205d2e:	1800                	addi	s0,sp,48
    80205d30:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:21
  PhysAddr pa = pn2addr(ppn);
    80205d34:	fd843783          	ld	a5,-40(s0)
    80205d38:	07b2                	slli	a5,a5,0xc
    80205d3a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:22
  return (uint8_t *)pa; // len = PAGE_SIZE (4096)
    80205d3e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/address.c:23
}
    80205d42:	853e                	mv	a0,a5
    80205d44:	7422                	ld	s0,40(sp)
    80205d46:	6145                	addi	sp,sp,48
    80205d48:	8082                	ret

0000000080205d4a <frame_allocator_init>:
frame_allocator_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:16
} StackFrameAllocator;

static StackFrameAllocator FRAME_ALLOCATOR;

void frame_allocator_init()
{
    80205d4a:	1141                	addi	sp,sp,-16
    80205d4c:	e406                	sd	ra,8(sp)
    80205d4e:	e022                	sd	s0,0(sp)
    80205d50:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:18
  extern uint8_t ekernel;
  FRAME_ALLOCATOR.current = page_ceil((PhysAddr)&ekernel);
    80205d52:	00b28717          	auipc	a4,0xb28
    80205d56:	2ae70713          	addi	a4,a4,686 # 80d2e000 <ebss>
    80205d5a:	6785                	lui	a5,0x1
    80205d5c:	17fd                	addi	a5,a5,-1
    80205d5e:	97ba                	add	a5,a5,a4
    80205d60:	00c7d713          	srli	a4,a5,0xc
    80205d64:	00824797          	auipc	a5,0x824
    80205d68:	32c78793          	addi	a5,a5,812 # 80a2a090 <FRAME_ALLOCATOR>
    80205d6c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:19
  FRAME_ALLOCATOR.end = page_floor(MEMORY_END);
    80205d6e:	00824797          	auipc	a5,0x824
    80205d72:	32278793          	addi	a5,a5,802 # 80a2a090 <FRAME_ALLOCATOR>
    80205d76:	00081737          	lui	a4,0x81
    80205d7a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:20
  vector_new(&FRAME_ALLOCATOR.recycled, sizeof(PhysPageNum));
    80205d7c:	45a1                	li	a1,8
    80205d7e:	00824517          	auipc	a0,0x824
    80205d82:	32250513          	addi	a0,a0,802 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205d86:	2f7030ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:21
}
    80205d8a:	0001                	nop
    80205d8c:	60a2                	ld	ra,8(sp)
    80205d8e:	6402                	ld	s0,0(sp)
    80205d90:	0141                	addi	sp,sp,16
    80205d92:	8082                	ret

0000000080205d94 <frame_allocator_free>:
frame_allocator_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:23

void frame_allocator_free() { vector_free(&FRAME_ALLOCATOR.recycled); }
    80205d94:	1141                	addi	sp,sp,-16
    80205d96:	e406                	sd	ra,8(sp)
    80205d98:	e022                	sd	s0,0(sp)
    80205d9a:	0800                	addi	s0,sp,16
    80205d9c:	00824517          	auipc	a0,0x824
    80205da0:	30450513          	addi	a0,a0,772 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205da4:	4af030ef          	jal	ra,80209a52 <vector_free>
    80205da8:	0001                	nop
    80205daa:	60a2                	ld	ra,8(sp)
    80205dac:	6402                	ld	s0,0(sp)
    80205dae:	0141                	addi	sp,sp,16
    80205db0:	8082                	ret

0000000080205db2 <frame_alloc>:
frame_alloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:26

PhysPageNum frame_alloc()
{
    80205db2:	1101                	addi	sp,sp,-32
    80205db4:	ec06                	sd	ra,24(sp)
    80205db6:	e822                	sd	s0,16(sp)
    80205db8:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:27
  PhysPageNum ppn = 0;
    80205dba:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:28
  if (!vector_empty(&FRAME_ALLOCATOR.recycled))
    80205dbe:	00824517          	auipc	a0,0x824
    80205dc2:	2e250513          	addi	a0,a0,738 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205dc6:	46b030ef          	jal	ra,80209a30 <vector_empty>
    80205dca:	87aa                	mv	a5,a0
    80205dcc:	e395                	bnez	a5,80205df0 <frame_alloc+0x3e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:30
  {
    ppn = *(PhysPageNum *)vector_back(&FRAME_ALLOCATOR.recycled);
    80205dce:	00824517          	auipc	a0,0x824
    80205dd2:	2d250513          	addi	a0,a0,722 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205dd6:	409030ef          	jal	ra,802099de <vector_back>
    80205dda:	87aa                	mv	a5,a0
    80205ddc:	639c                	ld	a5,0(a5)
    80205dde:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:31
    vector_pop(&FRAME_ALLOCATOR.recycled);
    80205de2:	00824517          	auipc	a0,0x824
    80205de6:	2be50513          	addi	a0,a0,702 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205dea:	3af030ef          	jal	ra,80209998 <vector_pop>
    80205dee:	a8a9                	j	80205e48 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:35
  }
  else
  {
    if (FRAME_ALLOCATOR.current == FRAME_ALLOCATOR.end)
    80205df0:	00824797          	auipc	a5,0x824
    80205df4:	2a078793          	addi	a5,a5,672 # 80a2a090 <FRAME_ALLOCATOR>
    80205df8:	6398                	ld	a4,0(a5)
    80205dfa:	00824797          	auipc	a5,0x824
    80205dfe:	29678793          	addi	a5,a5,662 # 80a2a090 <FRAME_ALLOCATOR>
    80205e02:	679c                	ld	a5,8(a5)
    80205e04:	00f71f63          	bne	a4,a5,80205e22 <frame_alloc+0x70>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:37
    {
      panic("No empty physical page.\n");
    80205e08:	00004617          	auipc	a2,0x4
    80205e0c:	71860613          	addi	a2,a2,1816 # 8020a520 <MMIO+0x10>
    80205e10:	02500593          	li	a1,37
    80205e14:	00004517          	auipc	a0,0x4
    80205e18:	72c50513          	addi	a0,a0,1836 # 8020a540 <MMIO+0x30>
    80205e1c:	1c1010ef          	jal	ra,802077dc <_panic>
    80205e20:	a025                	j	80205e48 <frame_alloc+0x96>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:41
    }
    else
    {
      ppn = FRAME_ALLOCATOR.current;
    80205e22:	00824797          	auipc	a5,0x824
    80205e26:	26e78793          	addi	a5,a5,622 # 80a2a090 <FRAME_ALLOCATOR>
    80205e2a:	639c                	ld	a5,0(a5)
    80205e2c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:42
      FRAME_ALLOCATOR.current++;
    80205e30:	00824797          	auipc	a5,0x824
    80205e34:	26078793          	addi	a5,a5,608 # 80a2a090 <FRAME_ALLOCATOR>
    80205e38:	639c                	ld	a5,0(a5)
    80205e3a:	00178713          	addi	a4,a5,1
    80205e3e:	00824797          	auipc	a5,0x824
    80205e42:	25278793          	addi	a5,a5,594 # 80a2a090 <FRAME_ALLOCATOR>
    80205e46:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:45
    }
  }
  memset((uint8_t *)pn2addr(ppn), 0, PAGE_SIZE);
    80205e48:	fe843783          	ld	a5,-24(s0)
    80205e4c:	07b2                	slli	a5,a5,0xc
    80205e4e:	6605                	lui	a2,0x1
    80205e50:	4581                	li	a1,0
    80205e52:	853e                	mv	a0,a5
    80205e54:	9e9fe0ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:46
  return ppn;
    80205e58:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:47
}
    80205e5c:	853e                	mv	a0,a5
    80205e5e:	60e2                	ld	ra,24(sp)
    80205e60:	6442                	ld	s0,16(sp)
    80205e62:	6105                	addi	sp,sp,32
    80205e64:	8082                	ret

0000000080205e66 <frame_dealloc>:
frame_dealloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:50

void frame_dealloc(PhysPageNum ppn)
{
    80205e66:	7139                	addi	sp,sp,-64
    80205e68:	fc06                	sd	ra,56(sp)
    80205e6a:	f822                	sd	s0,48(sp)
    80205e6c:	0080                	addi	s0,sp,64
    80205e6e:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:51
  bool in_recycled = false;
    80205e72:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:52
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80205e76:	00824797          	auipc	a5,0x824
    80205e7a:	21a78793          	addi	a5,a5,538 # 80a2a090 <FRAME_ALLOCATOR>
    80205e7e:	779c                	ld	a5,40(a5)
    80205e80:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:53
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++)
    80205e84:	fe043023          	sd	zero,-32(s0)
    80205e88:	a02d                	j	80205eb2 <frame_dealloc+0x4c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:55
  {
    if (x[i] == ppn)
    80205e8a:	fe043783          	ld	a5,-32(s0)
    80205e8e:	078e                	slli	a5,a5,0x3
    80205e90:	fd843703          	ld	a4,-40(s0)
    80205e94:	97ba                	add	a5,a5,a4
    80205e96:	6398                	ld	a4,0(a5)
    80205e98:	fc843783          	ld	a5,-56(s0)
    80205e9c:	00f71663          	bne	a4,a5,80205ea8 <frame_dealloc+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:57
    {
      in_recycled = true;
    80205ea0:	4785                	li	a5,1
    80205ea2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:58
      break;
    80205ea6:	a839                	j	80205ec4 <frame_dealloc+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:53 (discriminator 2)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++)
    80205ea8:	fe043783          	ld	a5,-32(s0)
    80205eac:	0785                	addi	a5,a5,1
    80205eae:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:53 (discriminator 1)
    80205eb2:	00824797          	auipc	a5,0x824
    80205eb6:	1de78793          	addi	a5,a5,478 # 80a2a090 <FRAME_ALLOCATOR>
    80205eba:	6b9c                	ld	a5,16(a5)
    80205ebc:	fe043703          	ld	a4,-32(s0)
    80205ec0:	fcf765e3          	bltu	a4,a5,80205e8a <frame_dealloc+0x24>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:61
    }
  }
  if (ppn >= FRAME_ALLOCATOR.current || in_recycled)
    80205ec4:	00824797          	auipc	a5,0x824
    80205ec8:	1cc78793          	addi	a5,a5,460 # 80a2a090 <FRAME_ALLOCATOR>
    80205ecc:	6398                	ld	a4,0(a5)
    80205ece:	fc843783          	ld	a5,-56(s0)
    80205ed2:	00e7f663          	bgeu	a5,a4,80205ede <frame_dealloc+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:61 (discriminator 1)
    80205ed6:	fec42783          	lw	a5,-20(s0)
    80205eda:	2781                	sext.w	a5,a5
    80205edc:	cf89                	beqz	a5,80205ef6 <frame_dealloc+0x90>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:63
  {
    panic("Frame ppn= has not been allocated!\n");
    80205ede:	00004617          	auipc	a2,0x4
    80205ee2:	68a60613          	addi	a2,a2,1674 # 8020a568 <MMIO+0x58>
    80205ee6:	03f00593          	li	a1,63
    80205eea:	00004517          	auipc	a0,0x4
    80205eee:	65650513          	addi	a0,a0,1622 # 8020a540 <MMIO+0x30>
    80205ef2:	0eb010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:65
  }
  vector_push(&FRAME_ALLOCATOR.recycled, &ppn);
    80205ef6:	fc840793          	addi	a5,s0,-56
    80205efa:	85be                	mv	a1,a5
    80205efc:	00824517          	auipc	a0,0x824
    80205f00:	1a450513          	addi	a0,a0,420 # 80a2a0a0 <FRAME_ALLOCATOR+0x10>
    80205f04:	1cb030ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:66
}
    80205f08:	0001                	nop
    80205f0a:	70e2                	ld	ra,56(sp)
    80205f0c:	7442                	ld	s0,48(sp)
    80205f0e:	6121                	addi	sp,sp,64
    80205f10:	8082                	ret

0000000080205f12 <frame_remaining_pages>:
frame_remaining_pages():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:69

uint64_t frame_remaining_pages()
{
    80205f12:	1101                	addi	sp,sp,-32
    80205f14:	ec22                	sd	s0,24(sp)
    80205f16:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:70
  uint64_t x = (uint64_t)(FRAME_ALLOCATOR.end - FRAME_ALLOCATOR.current);
    80205f18:	00824797          	auipc	a5,0x824
    80205f1c:	17878793          	addi	a5,a5,376 # 80a2a090 <FRAME_ALLOCATOR>
    80205f20:	6798                	ld	a4,8(a5)
    80205f22:	00824797          	auipc	a5,0x824
    80205f26:	16e78793          	addi	a5,a5,366 # 80a2a090 <FRAME_ALLOCATOR>
    80205f2a:	639c                	ld	a5,0(a5)
    80205f2c:	40f707b3          	sub	a5,a4,a5
    80205f30:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:71
  uint64_t y = (uint64_t)FRAME_ALLOCATOR.recycled.size;
    80205f34:	00824797          	auipc	a5,0x824
    80205f38:	15c78793          	addi	a5,a5,348 # 80a2a090 <FRAME_ALLOCATOR>
    80205f3c:	6b9c                	ld	a5,16(a5)
    80205f3e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:72
  return x + y;
    80205f42:	fe843703          	ld	a4,-24(s0)
    80205f46:	fe043783          	ld	a5,-32(s0)
    80205f4a:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:73
}
    80205f4c:	853e                	mv	a0,a5
    80205f4e:	6462                	ld	s0,24(sp)
    80205f50:	6105                	addi	sp,sp,32
    80205f52:	8082                	ret

0000000080205f54 <frame_allocator_print>:
frame_allocator_print():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:76

void frame_allocator_print()
{
    80205f54:	1101                	addi	sp,sp,-32
    80205f56:	ec06                	sd	ra,24(sp)
    80205f58:	e822                	sd	s0,16(sp)
    80205f5a:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:77
  PhysPageNum *x = (PhysPageNum *)(FRAME_ALLOCATOR.recycled.buffer);
    80205f5c:	00824797          	auipc	a5,0x824
    80205f60:	13478793          	addi	a5,a5,308 # 80a2a090 <FRAME_ALLOCATOR>
    80205f64:	779c                	ld	a5,40(a5)
    80205f66:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:78
  printk("FRAME_ALLOCATOR current = %llx, recycled = [ ",
    80205f6a:	00824797          	auipc	a5,0x824
    80205f6e:	12678793          	addi	a5,a5,294 # 80a2a090 <FRAME_ALLOCATOR>
    80205f72:	639c                	ld	a5,0(a5)
    80205f74:	85be                	mv	a1,a5
    80205f76:	00004517          	auipc	a0,0x4
    80205f7a:	61a50513          	addi	a0,a0,1562 # 8020a590 <MMIO+0x80>
    80205f7e:	86dfc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:80
         FRAME_ALLOCATOR.current);
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++)
    80205f82:	fe043423          	sd	zero,-24(s0)
    80205f86:	a025                	j	80205fae <frame_allocator_print+0x5a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:82 (discriminator 3)
  {
    printk("%llx ", x[i]);
    80205f88:	fe843783          	ld	a5,-24(s0)
    80205f8c:	078e                	slli	a5,a5,0x3
    80205f8e:	fe043703          	ld	a4,-32(s0)
    80205f92:	97ba                	add	a5,a5,a4
    80205f94:	639c                	ld	a5,0(a5)
    80205f96:	85be                	mv	a1,a5
    80205f98:	00004517          	auipc	a0,0x4
    80205f9c:	62850513          	addi	a0,a0,1576 # 8020a5c0 <MMIO+0xb0>
    80205fa0:	84bfc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:80 (discriminator 3)
  for (uint64_t i = 0; i < FRAME_ALLOCATOR.recycled.size; i++)
    80205fa4:	fe843783          	ld	a5,-24(s0)
    80205fa8:	0785                	addi	a5,a5,1
    80205faa:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:80 (discriminator 1)
    80205fae:	00824797          	auipc	a5,0x824
    80205fb2:	0e278793          	addi	a5,a5,226 # 80a2a090 <FRAME_ALLOCATOR>
    80205fb6:	6b9c                	ld	a5,16(a5)
    80205fb8:	fe843703          	ld	a4,-24(s0)
    80205fbc:	fcf766e3          	bltu	a4,a5,80205f88 <frame_allocator_print+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:84
  }
  printk("]\n");
    80205fc0:	00004517          	auipc	a0,0x4
    80205fc4:	60850513          	addi	a0,a0,1544 # 8020a5c8 <MMIO+0xb8>
    80205fc8:	823fc0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/frame_allocator.c:85
}
    80205fcc:	0001                	nop
    80205fce:	60e2                	ld	ra,24(sp)
    80205fd0:	6442                	ld	s0,16(sp)
    80205fd2:	6105                	addi	sp,sp,32
    80205fd4:	8082                	ret

0000000080205fd6 <page_table_new>:
page_table_new():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:5
#include "mem.h"
#include "string.h"
#include "debug.h"
void page_table_new(PageTable *pt)
{
    80205fd6:	7179                	addi	sp,sp,-48
    80205fd8:	f406                	sd	ra,40(sp)
    80205fda:	f022                	sd	s0,32(sp)
    80205fdc:	1800                	addi	s0,sp,48
    80205fde:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:6
  PhysPageNum frame = frame_alloc();
    80205fe2:	dd1ff0ef          	jal	ra,80205db2 <frame_alloc>
    80205fe6:	87aa                	mv	a5,a0
    80205fe8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:7
  pt->root_ppn = frame;
    80205fec:	fe843703          	ld	a4,-24(s0)
    80205ff0:	fd843783          	ld	a5,-40(s0)
    80205ff4:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:8
  vector_new(&pt->frames, sizeof(PhysPageNum));
    80205ff6:	fd843783          	ld	a5,-40(s0)
    80205ffa:	07a1                	addi	a5,a5,8
    80205ffc:	45a1                	li	a1,8
    80205ffe:	853e                	mv	a0,a5
    80206000:	07d030ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:9
  vector_push(&pt->frames, &frame);
    80206004:	fd843783          	ld	a5,-40(s0)
    80206008:	07a1                	addi	a5,a5,8
    8020600a:	fe840713          	addi	a4,s0,-24
    8020600e:	85ba                	mv	a1,a4
    80206010:	853e                	mv	a0,a5
    80206012:	0bd030ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:10
}
    80206016:	0001                	nop
    80206018:	70a2                	ld	ra,40(sp)
    8020601a:	7402                	ld	s0,32(sp)
    8020601c:	6145                	addi	sp,sp,48
    8020601e:	8082                	ret

0000000080206020 <page_table_free>:
page_table_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:13

void page_table_free(PageTable *pt)
{
    80206020:	7179                	addi	sp,sp,-48
    80206022:	f406                	sd	ra,40(sp)
    80206024:	f022                	sd	s0,32(sp)
    80206026:	1800                	addi	s0,sp,48
    80206028:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:15
  PhysPageNum frame;
  while (!vector_empty(&pt->frames))
    8020602c:	a02d                	j	80206056 <page_table_free+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:17
  {
    frame = *(PhysPageNum *)vector_back(&pt->frames);
    8020602e:	fd843783          	ld	a5,-40(s0)
    80206032:	07a1                	addi	a5,a5,8
    80206034:	853e                	mv	a0,a5
    80206036:	1a9030ef          	jal	ra,802099de <vector_back>
    8020603a:	87aa                	mv	a5,a0
    8020603c:	639c                	ld	a5,0(a5)
    8020603e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:18
    vector_pop(&pt->frames);
    80206042:	fd843783          	ld	a5,-40(s0)
    80206046:	07a1                	addi	a5,a5,8
    80206048:	853e                	mv	a0,a5
    8020604a:	14f030ef          	jal	ra,80209998 <vector_pop>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:19
    frame_dealloc(frame);
    8020604e:	fe843503          	ld	a0,-24(s0)
    80206052:	e15ff0ef          	jal	ra,80205e66 <frame_dealloc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:15
  while (!vector_empty(&pt->frames))
    80206056:	fd843783          	ld	a5,-40(s0)
    8020605a:	07a1                	addi	a5,a5,8
    8020605c:	853e                	mv	a0,a5
    8020605e:	1d3030ef          	jal	ra,80209a30 <vector_empty>
    80206062:	87aa                	mv	a5,a0
    80206064:	d7e9                	beqz	a5,8020602e <page_table_free+0xe>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:21
  }
  vector_free(&pt->frames);
    80206066:	fd843783          	ld	a5,-40(s0)
    8020606a:	07a1                	addi	a5,a5,8
    8020606c:	853e                	mv	a0,a5
    8020606e:	1e5030ef          	jal	ra,80209a52 <vector_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:22
}
    80206072:	0001                	nop
    80206074:	70a2                	ld	ra,40(sp)
    80206076:	7402                	ld	s0,32(sp)
    80206078:	6145                	addi	sp,sp,48
    8020607a:	8082                	ret

000000008020607c <page_table_from_token>:
page_table_from_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:25

void page_table_from_token(PageTable *pt, uint64_t satp)
{
    8020607c:	1101                	addi	sp,sp,-32
    8020607e:	ec22                	sd	s0,24(sp)
    80206080:	1000                	addi	s0,sp,32
    80206082:	fea43423          	sd	a0,-24(s0)
    80206086:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:26
  pt->root_ppn = (PhysPageNum)(satp & ((1L << 44) - 1));
    8020608a:	fe043703          	ld	a4,-32(s0)
    8020608e:	57fd                	li	a5,-1
    80206090:	83d1                	srli	a5,a5,0x14
    80206092:	8f7d                	and	a4,a4,a5
    80206094:	fe843783          	ld	a5,-24(s0)
    80206098:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:27
}
    8020609a:	0001                	nop
    8020609c:	6462                	ld	s0,24(sp)
    8020609e:	6105                	addi	sp,sp,32
    802060a0:	8082                	ret

00000000802060a2 <page_table_find_pte_create>:
page_table_find_pte_create():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:30

PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn)
{
    802060a2:	711d                	addi	sp,sp,-96
    802060a4:	ec86                	sd	ra,88(sp)
    802060a6:	e8a2                	sd	s0,80(sp)
    802060a8:	1080                	addi	s0,sp,96
    802060aa:	faa43423          	sd	a0,-88(s0)
    802060ae:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:32
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    802060b2:	fb840793          	addi	a5,s0,-72
    802060b6:	85be                	mv	a1,a5
    802060b8:	fa043503          	ld	a0,-96(s0)
    802060bc:	bfbff0ef          	jal	ra,80205cb6 <vpn_indexes>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:33
  PhysPageNum ppn = pt->root_ppn;
    802060c0:	fa843783          	ld	a5,-88(s0)
    802060c4:	639c                	ld	a5,0(a5)
    802060c6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:34
  PageTableEntry *result = NULL;
    802060ca:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:35
  for (unsigned i = 0; i < 3; i++)
    802060ce:	fc042e23          	sw	zero,-36(s0)
    802060d2:	a869                	j	8020616c <page_table_find_pte_create+0xca>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:37
  {
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    802060d4:	fe843503          	ld	a0,-24(s0)
    802060d8:	c33ff0ef          	jal	ra,80205d0a <ppn_get_pte_array>
    802060dc:	872a                	mv	a4,a0
    802060de:	fdc46783          	lwu	a5,-36(s0)
    802060e2:	078e                	slli	a5,a5,0x3
    802060e4:	ff040693          	addi	a3,s0,-16
    802060e8:	97b6                	add	a5,a5,a3
    802060ea:	fc87b783          	ld	a5,-56(a5)
    802060ee:	078e                	slli	a5,a5,0x3
    802060f0:	97ba                	add	a5,a5,a4
    802060f2:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:38
    if (i == 2)
    802060f6:	fdc42783          	lw	a5,-36(s0)
    802060fa:	0007871b          	sext.w	a4,a5
    802060fe:	4789                	li	a5,2
    80206100:	00f71763          	bne	a4,a5,8020610e <page_table_find_pte_create+0x6c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:40
    {
      result = pte;
    80206104:	fd043783          	ld	a5,-48(s0)
    80206108:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:41
      break;
    8020610c:	a0bd                	j	8020617a <page_table_find_pte_create+0xd8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:43
    }
    if (!pte_is_valid(*pte))
    8020610e:	fd043783          	ld	a5,-48(s0)
    80206112:	639c                	ld	a5,0(a5)
    80206114:	8b85                	andi	a5,a5,1
    80206116:	ef85                	bnez	a5,8020614e <page_table_find_pte_create+0xac>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:45
    {
      PhysPageNum frame = frame_alloc();
    80206118:	c9bff0ef          	jal	ra,80205db2 <frame_alloc>
    8020611c:	87aa                	mv	a5,a0
    8020611e:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:46
      if (!frame)
    80206122:	fb043783          	ld	a5,-80(s0)
    80206126:	e399                	bnez	a5,8020612c <page_table_find_pte_create+0x8a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:48
      {
        return NULL;
    80206128:	4781                	li	a5,0
    8020612a:	a891                	j	8020617e <page_table_find_pte_create+0xdc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:50
      }
      *pte = pte_new(frame, PTE_V);
    8020612c:	fb043783          	ld	a5,-80(s0)
    80206130:	07aa                	slli	a5,a5,0xa
    80206132:	0017e713          	ori	a4,a5,1
    80206136:	fd043783          	ld	a5,-48(s0)
    8020613a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:51
      vector_push(&pt->frames, &frame);
    8020613c:	fa843783          	ld	a5,-88(s0)
    80206140:	07a1                	addi	a5,a5,8
    80206142:	fb040713          	addi	a4,s0,-80
    80206146:	85ba                	mv	a1,a4
    80206148:	853e                	mv	a0,a5
    8020614a:	784030ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:53 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    8020614e:	fd043783          	ld	a5,-48(s0)
    80206152:	639c                	ld	a5,0(a5)
    80206154:	00a7d713          	srli	a4,a5,0xa
    80206158:	57fd                	li	a5,-1
    8020615a:	83d1                	srli	a5,a5,0x14
    8020615c:	8ff9                	and	a5,a5,a4
    8020615e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:35 (discriminator 2)
  for (unsigned i = 0; i < 3; i++)
    80206162:	fdc42783          	lw	a5,-36(s0)
    80206166:	2785                	addiw	a5,a5,1
    80206168:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:35 (discriminator 1)
    8020616c:	fdc42783          	lw	a5,-36(s0)
    80206170:	0007871b          	sext.w	a4,a5
    80206174:	4789                	li	a5,2
    80206176:	f4e7ffe3          	bgeu	a5,a4,802060d4 <page_table_find_pte_create+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:55
  }
  return result;
    8020617a:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:56 (discriminator 1)
}
    8020617e:	853e                	mv	a0,a5
    80206180:	60e6                	ld	ra,88(sp)
    80206182:	6446                	ld	s0,80(sp)
    80206184:	6125                	addi	sp,sp,96
    80206186:	8082                	ret

0000000080206188 <page_table_find_pte>:
page_table_find_pte():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:59

PageTableEntry *page_table_find_pte(PageTable *pt, VirtPageNum vpn)
{
    80206188:	711d                	addi	sp,sp,-96
    8020618a:	ec86                	sd	ra,88(sp)
    8020618c:	e8a2                	sd	s0,80(sp)
    8020618e:	1080                	addi	s0,sp,96
    80206190:	faa43423          	sd	a0,-88(s0)
    80206194:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:61
  uint64_t idxs[3];
  vpn_indexes(vpn, idxs);
    80206198:	fb840793          	addi	a5,s0,-72
    8020619c:	85be                	mv	a1,a5
    8020619e:	fa043503          	ld	a0,-96(s0)
    802061a2:	b15ff0ef          	jal	ra,80205cb6 <vpn_indexes>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:62
  PhysPageNum ppn = pt->root_ppn;
    802061a6:	fa843783          	ld	a5,-88(s0)
    802061aa:	639c                	ld	a5,0(a5)
    802061ac:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:63
  PageTableEntry *result = NULL;
    802061b0:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:65
  PageTableEntry *pte;
  for (unsigned i = 0; i < 3; i++)
    802061b4:	fc042e23          	sw	zero,-36(s0)
    802061b8:	a0a5                	j	80206220 <page_table_find_pte+0x98>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:67
  {
    pte = ppn_get_pte_array(ppn) + idxs[i];
    802061ba:	fe843503          	ld	a0,-24(s0)
    802061be:	b4dff0ef          	jal	ra,80205d0a <ppn_get_pte_array>
    802061c2:	872a                	mv	a4,a0
    802061c4:	fdc46783          	lwu	a5,-36(s0)
    802061c8:	078e                	slli	a5,a5,0x3
    802061ca:	ff040693          	addi	a3,s0,-16
    802061ce:	97b6                	add	a5,a5,a3
    802061d0:	fc87b783          	ld	a5,-56(a5)
    802061d4:	078e                	slli	a5,a5,0x3
    802061d6:	97ba                	add	a5,a5,a4
    802061d8:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:68
    if (!pte_is_valid(*pte))
    802061dc:	fd043783          	ld	a5,-48(s0)
    802061e0:	639c                	ld	a5,0(a5)
    802061e2:	8b85                	andi	a5,a5,1
    802061e4:	e399                	bnez	a5,802061ea <page_table_find_pte+0x62>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:70
    {
      return NULL;
    802061e6:	4781                	li	a5,0
    802061e8:	a0a9                	j	80206232 <page_table_find_pte+0xaa>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:72
    }
    if (i == 2)
    802061ea:	fdc42783          	lw	a5,-36(s0)
    802061ee:	0007871b          	sext.w	a4,a5
    802061f2:	4789                	li	a5,2
    802061f4:	00f71763          	bne	a4,a5,80206202 <page_table_find_pte+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:74
    {
      result = pte;
    802061f8:	fd043783          	ld	a5,-48(s0)
    802061fc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:75
      break;
    80206200:	a03d                	j	8020622e <page_table_find_pte+0xa6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:77 (discriminator 2)
    }
    ppn = pte_ppn(*pte);
    80206202:	fd043783          	ld	a5,-48(s0)
    80206206:	639c                	ld	a5,0(a5)
    80206208:	00a7d713          	srli	a4,a5,0xa
    8020620c:	57fd                	li	a5,-1
    8020620e:	83d1                	srli	a5,a5,0x14
    80206210:	8ff9                	and	a5,a5,a4
    80206212:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:65 (discriminator 2)
  for (unsigned i = 0; i < 3; i++)
    80206216:	fdc42783          	lw	a5,-36(s0)
    8020621a:	2785                	addiw	a5,a5,1
    8020621c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:65 (discriminator 1)
    80206220:	fdc42783          	lw	a5,-36(s0)
    80206224:	0007871b          	sext.w	a4,a5
    80206228:	4789                	li	a5,2
    8020622a:	f8e7f8e3          	bgeu	a5,a4,802061ba <page_table_find_pte+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:79
  }
  return result;
    8020622e:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:80 (discriminator 1)
}
    80206232:	853e                	mv	a0,a5
    80206234:	60e6                	ld	ra,88(sp)
    80206236:	6446                	ld	s0,80(sp)
    80206238:	6125                	addi	sp,sp,96
    8020623a:	8082                	ret

000000008020623c <page_table_map>:
page_table_map():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:84

void page_table_map(PageTable *pt, VirtPageNum vpn, PhysPageNum ppn,
                    PTEFlags flags)
{
    8020623c:	7139                	addi	sp,sp,-64
    8020623e:	fc06                	sd	ra,56(sp)
    80206240:	f822                	sd	s0,48(sp)
    80206242:	0080                	addi	s0,sp,64
    80206244:	fca43c23          	sd	a0,-40(s0)
    80206248:	fcb43823          	sd	a1,-48(s0)
    8020624c:	fcc43423          	sd	a2,-56(s0)
    80206250:	87b6                	mv	a5,a3
    80206252:	fcf403a3          	sb	a5,-57(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:85
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80206256:	fd043583          	ld	a1,-48(s0)
    8020625a:	fd843503          	ld	a0,-40(s0)
    8020625e:	e45ff0ef          	jal	ra,802060a2 <page_table_find_pte_create>
    80206262:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:86
  ASSERT(!pte_is_valid(*pte));
    80206266:	fe843783          	ld	a5,-24(s0)
    8020626a:	639c                	ld	a5,0(a5)
    8020626c:	8b85                	andi	a5,a5,1
    8020626e:	cf89                	beqz	a5,80206288 <page_table_map+0x4c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:86 (discriminator 1)
    80206270:	00004617          	auipc	a2,0x4
    80206274:	37060613          	addi	a2,a2,880 # 8020a5e0 <MMIO+0x10>
    80206278:	05600593          	li	a1,86
    8020627c:	00004517          	auipc	a0,0x4
    80206280:	38c50513          	addi	a0,a0,908 # 8020a608 <MMIO+0x38>
    80206284:	558010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:87
  *pte = pte_new(ppn, flags | PTE_V);
    80206288:	fc843783          	ld	a5,-56(s0)
    8020628c:	00a79713          	slli	a4,a5,0xa
    80206290:	fc744783          	lbu	a5,-57(s0)
    80206294:	8fd9                	or	a5,a5,a4
    80206296:	0017e713          	ori	a4,a5,1
    8020629a:	fe843783          	ld	a5,-24(s0)
    8020629e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:88
}
    802062a0:	0001                	nop
    802062a2:	70e2                	ld	ra,56(sp)
    802062a4:	7442                	ld	s0,48(sp)
    802062a6:	6121                	addi	sp,sp,64
    802062a8:	8082                	ret

00000000802062aa <page_table_unmap>:
page_table_unmap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:91

void page_table_unmap(PageTable *pt, VirtPageNum vpn)
{
    802062aa:	7179                	addi	sp,sp,-48
    802062ac:	f406                	sd	ra,40(sp)
    802062ae:	f022                	sd	s0,32(sp)
    802062b0:	1800                	addi	s0,sp,48
    802062b2:	fca43c23          	sd	a0,-40(s0)
    802062b6:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:92
  PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    802062ba:	fd043583          	ld	a1,-48(s0)
    802062be:	fd843503          	ld	a0,-40(s0)
    802062c2:	de1ff0ef          	jal	ra,802060a2 <page_table_find_pte_create>
    802062c6:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:93
  if (!pte_is_valid(*pte))
    802062ca:	fe843783          	ld	a5,-24(s0)
    802062ce:	639c                	ld	a5,0(a5)
    802062d0:	8b85                	andi	a5,a5,1
    802062d2:	ef89                	bnez	a5,802062ec <page_table_unmap+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:95 (discriminator 1)
  {
    ASSERT(0);
    802062d4:	00004617          	auipc	a2,0x4
    802062d8:	35460613          	addi	a2,a2,852 # 8020a628 <MMIO+0x58>
    802062dc:	05f00593          	li	a1,95
    802062e0:	00004517          	auipc	a0,0x4
    802062e4:	32850513          	addi	a0,a0,808 # 8020a608 <MMIO+0x38>
    802062e8:	4f4010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:97
  }
  *pte = pte_empty();
    802062ec:	fe843783          	ld	a5,-24(s0)
    802062f0:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:98
}
    802062f4:	0001                	nop
    802062f6:	70a2                	ld	ra,40(sp)
    802062f8:	7402                	ld	s0,32(sp)
    802062fa:	6145                	addi	sp,sp,48
    802062fc:	8082                	ret

00000000802062fe <page_table_translate>:
page_table_translate():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:101

PageTableEntry *page_table_translate(PageTable *pt, VirtPageNum vpn)
{
    802062fe:	7179                	addi	sp,sp,-48
    80206300:	f406                	sd	ra,40(sp)
    80206302:	f022                	sd	s0,32(sp)
    80206304:	1800                	addi	s0,sp,48
    80206306:	fca43c23          	sd	a0,-40(s0)
    8020630a:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:102
  PageTableEntry *pte = page_table_find_pte(pt, vpn);
    8020630e:	fd043583          	ld	a1,-48(s0)
    80206312:	fd843503          	ld	a0,-40(s0)
    80206316:	e73ff0ef          	jal	ra,80206188 <page_table_find_pte>
    8020631a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:103
  if (pte == NULL)
    8020631e:	fe843783          	ld	a5,-24(s0)
    80206322:	ef89                	bnez	a5,8020633c <page_table_translate+0x3e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:105 (discriminator 1)
  {
    ASSERT(0);
    80206324:	00004617          	auipc	a2,0x4
    80206328:	30460613          	addi	a2,a2,772 # 8020a628 <MMIO+0x58>
    8020632c:	06900593          	li	a1,105
    80206330:	00004517          	auipc	a0,0x4
    80206334:	2d850513          	addi	a0,a0,728 # 8020a608 <MMIO+0x38>
    80206338:	4a4010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:107
  }
  return pte;
    8020633c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:108
}
    80206340:	853e                	mv	a0,a5
    80206342:	70a2                	ld	ra,40(sp)
    80206344:	7402                	ld	s0,32(sp)
    80206346:	6145                	addi	sp,sp,48
    80206348:	8082                	ret

000000008020634a <page_table_token>:
page_table_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:110

uint64_t page_table_token(PageTable *pt) { return ((8L << 60) | pt->root_ppn); }
    8020634a:	1101                	addi	sp,sp,-32
    8020634c:	ec22                	sd	s0,24(sp)
    8020634e:	1000                	addi	s0,sp,32
    80206350:	fea43423          	sd	a0,-24(s0)
    80206354:	fe843783          	ld	a5,-24(s0)
    80206358:	6398                	ld	a4,0(a5)
    8020635a:	57fd                	li	a5,-1
    8020635c:	17fe                	slli	a5,a5,0x3f
    8020635e:	8fd9                	or	a5,a5,a4
    80206360:	853e                	mv	a0,a5
    80206362:	6462                	ld	s0,24(sp)
    80206364:	6105                	addi	sp,sp,32
    80206366:	8082                	ret

0000000080206368 <copy_byte_buffer>:
copy_byte_buffer():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:114

int64_t copy_byte_buffer(uint64_t token, uint8_t *kernel, uint8_t *user,
                         uint64_t len, uint64_t direction)
{
    80206368:	7171                	addi	sp,sp,-176
    8020636a:	f506                	sd	ra,168(sp)
    8020636c:	f122                	sd	s0,160(sp)
    8020636e:	1900                	addi	s0,sp,176
    80206370:	f6a43c23          	sd	a0,-136(s0)
    80206374:	f6b43823          	sd	a1,-144(s0)
    80206378:	f6c43423          	sd	a2,-152(s0)
    8020637c:	f6d43023          	sd	a3,-160(s0)
    80206380:	f4e43c23          	sd	a4,-168(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:115
  if (direction != FROM_USER && direction != TO_USER)
    80206384:	f5843783          	ld	a5,-168(s0)
    80206388:	c395                	beqz	a5,802063ac <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:115 (discriminator 1)
    8020638a:	f5843703          	ld	a4,-168(s0)
    8020638e:	4785                	li	a5,1
    80206390:	00f70e63          	beq	a4,a5,802063ac <copy_byte_buffer+0x44>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:117
  {
    panic("Unknown direction in copy_byte_buffer.\n");
    80206394:	00004617          	auipc	a2,0x4
    80206398:	2ac60613          	addi	a2,a2,684 # 8020a640 <MMIO+0x70>
    8020639c:	07500593          	li	a1,117
    802063a0:	00004517          	auipc	a0,0x4
    802063a4:	26850513          	addi	a0,a0,616 # 8020a608 <MMIO+0x38>
    802063a8:	434010ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:119
  }
  if (len == 0)
    802063ac:	f6043783          	ld	a5,-160(s0)
    802063b0:	e399                	bnez	a5,802063b6 <copy_byte_buffer+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:121
  {
    return 0;
    802063b2:	4781                	li	a5,0
    802063b4:	a439                	j	802065c2 <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:125
  }

  PageTable page_table;
  page_table_from_token(&page_table, token);
    802063b6:	f8040793          	addi	a5,s0,-128
    802063ba:	f7843583          	ld	a1,-136(s0)
    802063be:	853e                	mv	a0,a5
    802063c0:	cbdff0ef          	jal	ra,8020607c <page_table_from_token>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:126
  uint64_t start = (uint64_t)user;
    802063c4:	f6843783          	ld	a5,-152(s0)
    802063c8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:127
  uint64_t end = start + len;
    802063cc:	fe843703          	ld	a4,-24(s0)
    802063d0:	f6043783          	ld	a5,-160(s0)
    802063d4:	97ba                	add	a5,a5,a4
    802063d6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:128
  uint64_t kernel_i = 0;
    802063da:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:136
  VirtPageNum vpn;
  PhysPageNum ppn;
  PageTableEntry *pte_ptr;
  uint8_t *bytes_array;

  while (start < end)
    802063de:	aad1                	j	802065b2 <copy_byte_buffer+0x24a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:138
  {
    start_va = (VirtAddr)start;
    802063e0:	fe843783          	ld	a5,-24(s0)
    802063e4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:139
    vpn = page_floor(start_va);
    802063e8:	fc843783          	ld	a5,-56(s0)
    802063ec:	83b1                	srli	a5,a5,0xc
    802063ee:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:140
    pte_ptr = page_table_translate(&page_table, vpn);
    802063f2:	f8040793          	addi	a5,s0,-128
    802063f6:	fc043583          	ld	a1,-64(s0)
    802063fa:	853e                	mv	a0,a5
    802063fc:	f03ff0ef          	jal	ra,802062fe <page_table_translate>
    80206400:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:141
    if (pte_ptr == NULL)
    80206404:	fb843783          	ld	a5,-72(s0)
    80206408:	e399                	bnez	a5,8020640e <copy_byte_buffer+0xa6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:143
    {
      return -1;
    8020640a:	57fd                	li	a5,-1
    8020640c:	aa5d                	j	802065c2 <copy_byte_buffer+0x25a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:145
    }
    ppn = pte_ppn(*pte_ptr);
    8020640e:	fb843783          	ld	a5,-72(s0)
    80206412:	639c                	ld	a5,0(a5)
    80206414:	00a7d713          	srli	a4,a5,0xa
    80206418:	57fd                	li	a5,-1
    8020641a:	83d1                	srli	a5,a5,0x14
    8020641c:	8ff9                	and	a5,a5,a4
    8020641e:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:146
    vpn++;
    80206422:	fc043783          	ld	a5,-64(s0)
    80206426:	0785                	addi	a5,a5,1
    80206428:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:147
    end_va = (VirtAddr)pn2addr(vpn);
    8020642c:	fc043783          	ld	a5,-64(s0)
    80206430:	07b2                	slli	a5,a5,0xc
    80206432:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:148
    if ((VirtAddr)end < end_va)
    80206436:	fd043703          	ld	a4,-48(s0)
    8020643a:	fd843783          	ld	a5,-40(s0)
    8020643e:	00f77663          	bgeu	a4,a5,8020644a <copy_byte_buffer+0xe2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:150
    {
      end_va = (VirtAddr)end;
    80206442:	fd043783          	ld	a5,-48(s0)
    80206446:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:152
    }
    bytes_array = ppn_get_bytes_array(ppn);
    8020644a:	fb043503          	ld	a0,-80(s0)
    8020644e:	8ddff0ef          	jal	ra,80205d2a <ppn_get_bytes_array>
    80206452:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:153
    if (page_aligned(end_va))
    80206456:	fd843703          	ld	a4,-40(s0)
    8020645a:	6785                	lui	a5,0x1
    8020645c:	17fd                	addi	a5,a5,-1
    8020645e:	8ff9                	and	a5,a5,a4
    80206460:	e3d1                	bnez	a5,802064e4 <copy_byte_buffer+0x17c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:155
    {
      if (direction == FROM_USER)
    80206462:	f5843783          	ld	a5,-168(s0)
    80206466:	eb95                	bnez	a5,8020649a <copy_byte_buffer+0x132>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:156
        memcpy(kernel + kernel_i, bytes_array,
    80206468:	f7043703          	ld	a4,-144(s0)
    8020646c:	fe043783          	ld	a5,-32(s0)
    80206470:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:157
               PAGE_SIZE - page_offset(start_va));
    80206474:	fc843783          	ld	a5,-56(s0)
    80206478:	2781                	sext.w	a5,a5
    8020647a:	873e                	mv	a4,a5
    8020647c:	6785                	lui	a5,0x1
    8020647e:	17fd                	addi	a5,a5,-1
    80206480:	8ff9                	and	a5,a5,a4
    80206482:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:156
        memcpy(kernel + kernel_i, bytes_array,
    80206484:	6705                	lui	a4,0x1
    80206486:	40f707bb          	subw	a5,a4,a5
    8020648a:	2781                	sext.w	a5,a5
    8020648c:	863e                	mv	a2,a5
    8020648e:	fa843583          	ld	a1,-88(s0)
    80206492:	8536                	mv	a0,a3
    80206494:	b5afe0ef          	jal	ra,802047ee <memcpy>
    80206498:	a80d                	j	802064ca <copy_byte_buffer+0x162>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:159
      else
        memcpy(bytes_array, kernel + kernel_i,
    8020649a:	f7043703          	ld	a4,-144(s0)
    8020649e:	fe043783          	ld	a5,-32(s0)
    802064a2:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:160
               PAGE_SIZE - page_offset(start_va));
    802064a6:	fc843783          	ld	a5,-56(s0)
    802064aa:	2781                	sext.w	a5,a5
    802064ac:	873e                	mv	a4,a5
    802064ae:	6785                	lui	a5,0x1
    802064b0:	17fd                	addi	a5,a5,-1
    802064b2:	8ff9                	and	a5,a5,a4
    802064b4:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:159
        memcpy(bytes_array, kernel + kernel_i,
    802064b6:	6705                	lui	a4,0x1
    802064b8:	40f707bb          	subw	a5,a4,a5
    802064bc:	2781                	sext.w	a5,a5
    802064be:	863e                	mv	a2,a5
    802064c0:	85b6                	mv	a1,a3
    802064c2:	fa843503          	ld	a0,-88(s0)
    802064c6:	b28fe0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:161
      kernel_i += PAGE_SIZE - page_offset(start_va);
    802064ca:	fc843703          	ld	a4,-56(s0)
    802064ce:	6785                	lui	a5,0x1
    802064d0:	17fd                	addi	a5,a5,-1
    802064d2:	8ff9                	and	a5,a5,a4
    802064d4:	fe043703          	ld	a4,-32(s0)
    802064d8:	8f1d                	sub	a4,a4,a5
    802064da:	6785                	lui	a5,0x1
    802064dc:	97ba                	add	a5,a5,a4
    802064de:	fef43023          	sd	a5,-32(s0)
    802064e2:	a0e1                	j	802065aa <copy_byte_buffer+0x242>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:165
    }
    else
    {
      if (direction == FROM_USER)
    802064e4:	f5843783          	ld	a5,-168(s0)
    802064e8:	eba9                	bnez	a5,8020653a <copy_byte_buffer+0x1d2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:166
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    802064ea:	f7043703          	ld	a4,-144(s0)
    802064ee:	fe043783          	ld	a5,-32(s0)
    802064f2:	00f706b3          	add	a3,a4,a5
    802064f6:	fc843703          	ld	a4,-56(s0)
    802064fa:	6785                	lui	a5,0x1
    802064fc:	17fd                	addi	a5,a5,-1
    802064fe:	8ff9                	and	a5,a5,a4
    80206500:	fa843703          	ld	a4,-88(s0)
    80206504:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:167
               page_offset(end_va) - page_offset(start_va));
    80206508:	fd843783          	ld	a5,-40(s0)
    8020650c:	2781                	sext.w	a5,a5
    8020650e:	873e                	mv	a4,a5
    80206510:	6785                	lui	a5,0x1
    80206512:	17fd                	addi	a5,a5,-1
    80206514:	8ff9                	and	a5,a5,a4
    80206516:	0007871b          	sext.w	a4,a5
    8020651a:	fc843783          	ld	a5,-56(s0)
    8020651e:	2781                	sext.w	a5,a5
    80206520:	863e                	mv	a2,a5
    80206522:	6785                	lui	a5,0x1
    80206524:	17fd                	addi	a5,a5,-1
    80206526:	8ff1                	and	a5,a5,a2
    80206528:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:166
        memcpy(kernel + kernel_i, bytes_array + page_offset(start_va),
    8020652a:	40f707bb          	subw	a5,a4,a5
    8020652e:	2781                	sext.w	a5,a5
    80206530:	863e                	mv	a2,a5
    80206532:	8536                	mv	a0,a3
    80206534:	abafe0ef          	jal	ra,802047ee <memcpy>
    80206538:	a881                	j	80206588 <copy_byte_buffer+0x220>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:169
      else
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    8020653a:	fc843703          	ld	a4,-56(s0)
    8020653e:	6785                	lui	a5,0x1
    80206540:	17fd                	addi	a5,a5,-1
    80206542:	8ff9                	and	a5,a5,a4
    80206544:	fa843703          	ld	a4,-88(s0)
    80206548:	00f706b3          	add	a3,a4,a5
    8020654c:	f7043703          	ld	a4,-144(s0)
    80206550:	fe043783          	ld	a5,-32(s0)
    80206554:	00f705b3          	add	a1,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:170
               page_offset(end_va) - page_offset(start_va));
    80206558:	fd843783          	ld	a5,-40(s0)
    8020655c:	2781                	sext.w	a5,a5
    8020655e:	873e                	mv	a4,a5
    80206560:	6785                	lui	a5,0x1
    80206562:	17fd                	addi	a5,a5,-1
    80206564:	8ff9                	and	a5,a5,a4
    80206566:	0007871b          	sext.w	a4,a5
    8020656a:	fc843783          	ld	a5,-56(s0)
    8020656e:	2781                	sext.w	a5,a5
    80206570:	863e                	mv	a2,a5
    80206572:	6785                	lui	a5,0x1
    80206574:	17fd                	addi	a5,a5,-1
    80206576:	8ff1                	and	a5,a5,a2
    80206578:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:169
        memcpy(bytes_array + page_offset(start_va), kernel + kernel_i,
    8020657a:	40f707bb          	subw	a5,a4,a5
    8020657e:	2781                	sext.w	a5,a5
    80206580:	863e                	mv	a2,a5
    80206582:	8536                	mv	a0,a3
    80206584:	a6afe0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:171
      kernel_i += page_offset(end_va) - page_offset(start_va);
    80206588:	fd843703          	ld	a4,-40(s0)
    8020658c:	6785                	lui	a5,0x1
    8020658e:	17fd                	addi	a5,a5,-1
    80206590:	8f7d                	and	a4,a4,a5
    80206592:	fc843683          	ld	a3,-56(s0)
    80206596:	6785                	lui	a5,0x1
    80206598:	17fd                	addi	a5,a5,-1
    8020659a:	8ff5                	and	a5,a5,a3
    8020659c:	40f707b3          	sub	a5,a4,a5
    802065a0:	fe043703          	ld	a4,-32(s0)
    802065a4:	97ba                	add	a5,a5,a4
    802065a6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:173
    }
    start = (uint64_t)end_va;
    802065aa:	fd843783          	ld	a5,-40(s0)
    802065ae:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:136
  while (start < end)
    802065b2:	fe843703          	ld	a4,-24(s0)
    802065b6:	fd043783          	ld	a5,-48(s0)
    802065ba:	e2f763e3          	bltu	a4,a5,802063e0 <copy_byte_buffer+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:175
  }
  return len;
    802065be:	f6043783          	ld	a5,-160(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/page_table.c:176 (discriminator 1)
}
    802065c2:	853e                	mv	a0,a5
    802065c4:	70aa                	ld	ra,168(sp)
    802065c6:	740a                	ld	s0,160(sp)
    802065c8:	614d                	addi	sp,sp,176
    802065ca:	8082                	ret

00000000802065cc <mm_init>:
mm_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:4
#include "mem.h"

void mm_init()
{
    802065cc:	1141                	addi	sp,sp,-16
    802065ce:	e406                	sd	ra,8(sp)
    802065d0:	e022                	sd	s0,0(sp)
    802065d2:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:5
  heap_allocator_init();
    802065d4:	030000ef          	jal	ra,80206604 <heap_allocator_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:6
  frame_allocator_init();
    802065d8:	f72ff0ef          	jal	ra,80205d4a <frame_allocator_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:7
  memory_set_kernel_init();
    802065dc:	a54ff0ef          	jal	ra,80205830 <memory_set_kernel_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:8
  memory_set_remap_test();
    802065e0:	de0ff0ef          	jal	ra,80205bc0 <memory_set_remap_test>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:9
}
    802065e4:	0001                	nop
    802065e6:	60a2                	ld	ra,8(sp)
    802065e8:	6402                	ld	s0,0(sp)
    802065ea:	0141                	addi	sp,sp,16
    802065ec:	8082                	ret

00000000802065ee <mm_free>:
mm_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:12

void mm_free()
{
    802065ee:	1141                	addi	sp,sp,-16
    802065f0:	e406                	sd	ra,8(sp)
    802065f2:	e022                	sd	s0,0(sp)
    802065f4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:13
  frame_allocator_free();
    802065f6:	f9eff0ef          	jal	ra,80205d94 <frame_allocator_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/mm.c:14
}
    802065fa:	0001                	nop
    802065fc:	60a2                	ld	ra,8(sp)
    802065fe:	6402                	ld	s0,0(sp)
    80206600:	0141                	addi	sp,sp,16
    80206602:	8082                	ret

0000000080206604 <heap_allocator_init>:
heap_allocator_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/heap_allocator.c:10
#include "string.h"

static uint8_t HEAP_SPACE[KERNEL_HEAP_SIZE] __attribute__((aligned(4096)));

void heap_allocator_init()
{
    80206604:	1141                	addi	sp,sp,-16
    80206606:	e406                	sd	ra,8(sp)
    80206608:	e022                	sd	s0,0(sp)
    8020660a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/heap_allocator.c:11
  memset(HEAP_SPACE, 0, KERNEL_HEAP_SIZE);
    8020660c:	00300637          	lui	a2,0x300
    80206610:	4581                	li	a1,0
    80206612:	00825517          	auipc	a0,0x825
    80206616:	9ee50513          	addi	a0,a0,-1554 # 80a2b000 <HEAP_SPACE>
    8020661a:	a22fe0ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/heap_allocator.c:12
  bd_init(HEAP_SPACE, HEAP_SPACE + KERNEL_HEAP_SIZE);
    8020661e:	00b25797          	auipc	a5,0xb25
    80206622:	9e278793          	addi	a5,a5,-1566 # 80d2b000 <nsizes>
    80206626:	85be                	mv	a1,a5
    80206628:	00825517          	auipc	a0,0x825
    8020662c:	9d850513          	addi	a0,a0,-1576 # 80a2b000 <HEAP_SPACE>
    80206630:	3cd000ef          	jal	ra,802071fc <bd_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/mem/heap_allocator.c:13
}
    80206634:	0001                	nop
    80206636:	60a2                	ld	ra,8(sp)
    80206638:	6402                	ld	s0,0(sp)
    8020663a:	0141                	addi	sp,sp,16
    8020663c:	8082                	ret

000000008020663e <bit_isset>:
bit_isset():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:26
static void *bd_base; // 由buddy分配器管理的内存的起始地址
// static struct spinlock lock;

// 如果数组中索引位置的位被设置为1，则返回1
int bit_isset(char *array, int index)
{
    8020663e:	7179                	addi	sp,sp,-48
    80206640:	f422                	sd	s0,40(sp)
    80206642:	1800                	addi	s0,sp,48
    80206644:	fca43c23          	sd	a0,-40(s0)
    80206648:	87ae                	mv	a5,a1
    8020664a:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:27
  char b = array[index / 8];
    8020664e:	fd442783          	lw	a5,-44(s0)
    80206652:	41f7d71b          	sraiw	a4,a5,0x1f
    80206656:	01d7571b          	srliw	a4,a4,0x1d
    8020665a:	9fb9                	addw	a5,a5,a4
    8020665c:	4037d79b          	sraiw	a5,a5,0x3
    80206660:	2781                	sext.w	a5,a5
    80206662:	873e                	mv	a4,a5
    80206664:	fd843783          	ld	a5,-40(s0)
    80206668:	97ba                	add	a5,a5,a4
    8020666a:	0007c783          	lbu	a5,0(a5)
    8020666e:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:28
  char m = (1 << (index % 8));
    80206672:	fd442703          	lw	a4,-44(s0)
    80206676:	41f7579b          	sraiw	a5,a4,0x1f
    8020667a:	01d7d79b          	srliw	a5,a5,0x1d
    8020667e:	9f3d                	addw	a4,a4,a5
    80206680:	8b1d                	andi	a4,a4,7
    80206682:	40f707bb          	subw	a5,a4,a5
    80206686:	2781                	sext.w	a5,a5
    80206688:	4705                	li	a4,1
    8020668a:	00f717bb          	sllw	a5,a4,a5
    8020668e:	2781                	sext.w	a5,a5
    80206690:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:29
  return (b & m) == m;
    80206694:	fef44703          	lbu	a4,-17(s0)
    80206698:	fee44783          	lbu	a5,-18(s0)
    8020669c:	8ff9                	and	a5,a5,a4
    8020669e:	0ff7f793          	andi	a5,a5,255
    802066a2:	fee44703          	lbu	a4,-18(s0)
    802066a6:	2701                	sext.w	a4,a4
    802066a8:	2781                	sext.w	a5,a5
    802066aa:	40f707b3          	sub	a5,a4,a5
    802066ae:	0017b793          	seqz	a5,a5
    802066b2:	0ff7f793          	andi	a5,a5,255
    802066b6:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:30
}
    802066b8:	853e                	mv	a0,a5
    802066ba:	7422                	ld	s0,40(sp)
    802066bc:	6145                	addi	sp,sp,48
    802066be:	8082                	ret

00000000802066c0 <bit_set>:
bit_set():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:34

// 将数组中索引位置的位设置为1
void bit_set(char *array, int index)
{
    802066c0:	7179                	addi	sp,sp,-48
    802066c2:	f422                	sd	s0,40(sp)
    802066c4:	1800                	addi	s0,sp,48
    802066c6:	fca43c23          	sd	a0,-40(s0)
    802066ca:	87ae                	mv	a5,a1
    802066cc:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:35
  char b = array[index / 8];
    802066d0:	fd442783          	lw	a5,-44(s0)
    802066d4:	41f7d71b          	sraiw	a4,a5,0x1f
    802066d8:	01d7571b          	srliw	a4,a4,0x1d
    802066dc:	9fb9                	addw	a5,a5,a4
    802066de:	4037d79b          	sraiw	a5,a5,0x3
    802066e2:	2781                	sext.w	a5,a5
    802066e4:	873e                	mv	a4,a5
    802066e6:	fd843783          	ld	a5,-40(s0)
    802066ea:	97ba                	add	a5,a5,a4
    802066ec:	0007c783          	lbu	a5,0(a5)
    802066f0:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:36
  char m = (1 << (index % 8));
    802066f4:	fd442703          	lw	a4,-44(s0)
    802066f8:	41f7579b          	sraiw	a5,a4,0x1f
    802066fc:	01d7d79b          	srliw	a5,a5,0x1d
    80206700:	9f3d                	addw	a4,a4,a5
    80206702:	8b1d                	andi	a4,a4,7
    80206704:	40f707bb          	subw	a5,a4,a5
    80206708:	2781                	sext.w	a5,a5
    8020670a:	4705                	li	a4,1
    8020670c:	00f717bb          	sllw	a5,a4,a5
    80206710:	2781                	sext.w	a5,a5
    80206712:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:37
  array[index / 8] = (b | m);
    80206716:	fd442783          	lw	a5,-44(s0)
    8020671a:	41f7d71b          	sraiw	a4,a5,0x1f
    8020671e:	01d7571b          	srliw	a4,a4,0x1d
    80206722:	9fb9                	addw	a5,a5,a4
    80206724:	4037d79b          	sraiw	a5,a5,0x3
    80206728:	2781                	sext.w	a5,a5
    8020672a:	873e                	mv	a4,a5
    8020672c:	fd843783          	ld	a5,-40(s0)
    80206730:	97ba                	add	a5,a5,a4
    80206732:	fef44683          	lbu	a3,-17(s0)
    80206736:	fee44703          	lbu	a4,-18(s0)
    8020673a:	8f55                	or	a4,a4,a3
    8020673c:	0ff77713          	andi	a4,a4,255
    80206740:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:38
}
    80206744:	0001                	nop
    80206746:	7422                	ld	s0,40(sp)
    80206748:	6145                	addi	sp,sp,48
    8020674a:	8082                	ret

000000008020674c <bit_clear>:
bit_clear():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:42

// 清除数组中索引位置的位
void bit_clear(char *array, int index)
{
    8020674c:	7179                	addi	sp,sp,-48
    8020674e:	f422                	sd	s0,40(sp)
    80206750:	1800                	addi	s0,sp,48
    80206752:	fca43c23          	sd	a0,-40(s0)
    80206756:	87ae                	mv	a5,a1
    80206758:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:43
  char b = array[index / 8];
    8020675c:	fd442783          	lw	a5,-44(s0)
    80206760:	41f7d71b          	sraiw	a4,a5,0x1f
    80206764:	01d7571b          	srliw	a4,a4,0x1d
    80206768:	9fb9                	addw	a5,a5,a4
    8020676a:	4037d79b          	sraiw	a5,a5,0x3
    8020676e:	2781                	sext.w	a5,a5
    80206770:	873e                	mv	a4,a5
    80206772:	fd843783          	ld	a5,-40(s0)
    80206776:	97ba                	add	a5,a5,a4
    80206778:	0007c783          	lbu	a5,0(a5)
    8020677c:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:44
  char m = (1 << (index % 8));
    80206780:	fd442703          	lw	a4,-44(s0)
    80206784:	41f7579b          	sraiw	a5,a4,0x1f
    80206788:	01d7d79b          	srliw	a5,a5,0x1d
    8020678c:	9f3d                	addw	a4,a4,a5
    8020678e:	8b1d                	andi	a4,a4,7
    80206790:	40f707bb          	subw	a5,a4,a5
    80206794:	2781                	sext.w	a5,a5
    80206796:	4705                	li	a4,1
    80206798:	00f717bb          	sllw	a5,a4,a5
    8020679c:	2781                	sext.w	a5,a5
    8020679e:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:45
  array[index / 8] = (b & ~m);
    802067a2:	fee40783          	lb	a5,-18(s0)
    802067a6:	fff7c793          	not	a5,a5
    802067aa:	0187971b          	slliw	a4,a5,0x18
    802067ae:	4187571b          	sraiw	a4,a4,0x18
    802067b2:	fef40783          	lb	a5,-17(s0)
    802067b6:	8ff9                	and	a5,a5,a4
    802067b8:	0187969b          	slliw	a3,a5,0x18
    802067bc:	4186d69b          	sraiw	a3,a3,0x18
    802067c0:	fd442783          	lw	a5,-44(s0)
    802067c4:	41f7d71b          	sraiw	a4,a5,0x1f
    802067c8:	01d7571b          	srliw	a4,a4,0x1d
    802067cc:	9fb9                	addw	a5,a5,a4
    802067ce:	4037d79b          	sraiw	a5,a5,0x3
    802067d2:	2781                	sext.w	a5,a5
    802067d4:	873e                	mv	a4,a5
    802067d6:	fd843783          	ld	a5,-40(s0)
    802067da:	97ba                	add	a5,a5,a4
    802067dc:	0ff6f713          	andi	a4,a3,255
    802067e0:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:46
}
    802067e4:	0001                	nop
    802067e6:	7422                	ld	s0,40(sp)
    802067e8:	6145                	addi	sp,sp,48
    802067ea:	8082                	ret

00000000802067ec <bd_print_vector>:
bd_print_vector():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:50

// 以1位的范围列表打印位向量
void bd_print_vector(char *vector, int len)
{
    802067ec:	7179                	addi	sp,sp,-48
    802067ee:	f406                	sd	ra,40(sp)
    802067f0:	f022                	sd	s0,32(sp)
    802067f2:	1800                	addi	s0,sp,48
    802067f4:	fca43c23          	sd	a0,-40(s0)
    802067f8:	87ae                	mv	a5,a1
    802067fa:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:53
  int last, lb;

  last = 1;
    802067fe:	4785                	li	a5,1
    80206800:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:54
  lb = 0;
    80206804:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:55
  for (int b = 0; b < len; b++)
    80206808:	fe042423          	sw	zero,-24(s0)
    8020680c:	a0a1                	j	80206854 <bd_print_vector+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:57
  {
    if (last == bit_isset(vector, b))
    8020680e:	fe842783          	lw	a5,-24(s0)
    80206812:	85be                	mv	a1,a5
    80206814:	fd843503          	ld	a0,-40(s0)
    80206818:	e27ff0ef          	jal	ra,8020663e <bit_isset>
    8020681c:	87aa                	mv	a5,a0
    8020681e:	873e                	mv	a4,a5
    80206820:	fec42783          	lw	a5,-20(s0)
    80206824:	2781                	sext.w	a5,a5
    80206826:	02e78163          	beq	a5,a4,80206848 <bd_print_vector+0x5c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:59
      continue;
    lb = b;
    8020682a:	fe842783          	lw	a5,-24(s0)
    8020682e:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:60
    last = bit_isset(vector, b);
    80206832:	fe842783          	lw	a5,-24(s0)
    80206836:	85be                	mv	a1,a5
    80206838:	fd843503          	ld	a0,-40(s0)
    8020683c:	e03ff0ef          	jal	ra,8020663e <bit_isset>
    80206840:	87aa                	mv	a5,a0
    80206842:	fef42623          	sw	a5,-20(s0)
    80206846:	a011                	j	8020684a <bd_print_vector+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:58
      continue;
    80206848:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:55 (discriminator 2)
  for (int b = 0; b < len; b++)
    8020684a:	fe842783          	lw	a5,-24(s0)
    8020684e:	2785                	addiw	a5,a5,1
    80206850:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:55 (discriminator 1)
    80206854:	fe842703          	lw	a4,-24(s0)
    80206858:	fd442783          	lw	a5,-44(s0)
    8020685c:	2701                	sext.w	a4,a4
    8020685e:	2781                	sext.w	a5,a5
    80206860:	faf747e3          	blt	a4,a5,8020680e <bd_print_vector+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:65
  }
  if (lb == 0 || last == 1)
  {
  }
}
    80206864:	0001                	nop
    80206866:	0001                	nop
    80206868:	70a2                	ld	ra,40(sp)
    8020686a:	7402                	ld	s0,32(sp)
    8020686c:	6145                	addi	sp,sp,48
    8020686e:	8082                	ret

0000000080206870 <bd_print>:
bd_print():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:69

// 打印buddy的数据结构
void bd_print()
{
    80206870:	1101                	addi	sp,sp,-32
    80206872:	ec06                	sd	ra,24(sp)
    80206874:	e822                	sd	s0,16(sp)
    80206876:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:70
  for (int k = 0; k < nsizes; k++)
    80206878:	fe042623          	sw	zero,-20(s0)
    8020687c:	a06d                	j	80206926 <bd_print+0xb6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:72
  {
    lst_print(&bd_sizes[k].free);
    8020687e:	00b24797          	auipc	a5,0xb24
    80206882:	78a78793          	addi	a5,a5,1930 # 80d2b008 <bd_sizes>
    80206886:	6398                	ld	a4,0(a5)
    80206888:	fec42783          	lw	a5,-20(s0)
    8020688c:	0796                	slli	a5,a5,0x5
    8020688e:	97ba                	add	a5,a5,a4
    80206890:	853e                	mv	a0,a5
    80206892:	797020ef          	jal	ra,80209828 <lst_print>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:73
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80206896:	00b24797          	auipc	a5,0xb24
    8020689a:	77278793          	addi	a5,a5,1906 # 80d2b008 <bd_sizes>
    8020689e:	6398                	ld	a4,0(a5)
    802068a0:	fec42783          	lw	a5,-20(s0)
    802068a4:	0796                	slli	a5,a5,0x5
    802068a6:	97ba                	add	a5,a5,a4
    802068a8:	6b94                	ld	a3,16(a5)
    802068aa:	00b24797          	auipc	a5,0xb24
    802068ae:	75678793          	addi	a5,a5,1878 # 80d2b000 <nsizes>
    802068b2:	439c                	lw	a5,0(a5)
    802068b4:	37fd                	addiw	a5,a5,-1
    802068b6:	0007871b          	sext.w	a4,a5
    802068ba:	fec42783          	lw	a5,-20(s0)
    802068be:	40f707bb          	subw	a5,a4,a5
    802068c2:	2781                	sext.w	a5,a5
    802068c4:	4705                	li	a4,1
    802068c6:	00f717bb          	sllw	a5,a4,a5
    802068ca:	2781                	sext.w	a5,a5
    802068cc:	85be                	mv	a1,a5
    802068ce:	8536                	mv	a0,a3
    802068d0:	f1dff0ef          	jal	ra,802067ec <bd_print_vector>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:74
    if (k > 0)
    802068d4:	fec42783          	lw	a5,-20(s0)
    802068d8:	2781                	sext.w	a5,a5
    802068da:	04f05163          	blez	a5,8020691c <bd_print+0xac>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:76
    {
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    802068de:	00b24797          	auipc	a5,0xb24
    802068e2:	72a78793          	addi	a5,a5,1834 # 80d2b008 <bd_sizes>
    802068e6:	6398                	ld	a4,0(a5)
    802068e8:	fec42783          	lw	a5,-20(s0)
    802068ec:	0796                	slli	a5,a5,0x5
    802068ee:	97ba                	add	a5,a5,a4
    802068f0:	6f94                	ld	a3,24(a5)
    802068f2:	00b24797          	auipc	a5,0xb24
    802068f6:	70e78793          	addi	a5,a5,1806 # 80d2b000 <nsizes>
    802068fa:	439c                	lw	a5,0(a5)
    802068fc:	37fd                	addiw	a5,a5,-1
    802068fe:	0007871b          	sext.w	a4,a5
    80206902:	fec42783          	lw	a5,-20(s0)
    80206906:	40f707bb          	subw	a5,a4,a5
    8020690a:	2781                	sext.w	a5,a5
    8020690c:	4705                	li	a4,1
    8020690e:	00f717bb          	sllw	a5,a4,a5
    80206912:	2781                	sext.w	a5,a5
    80206914:	85be                	mv	a1,a5
    80206916:	8536                	mv	a0,a3
    80206918:	ed5ff0ef          	jal	ra,802067ec <bd_print_vector>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:70 (discriminator 2)
  for (int k = 0; k < nsizes; k++)
    8020691c:	fec42783          	lw	a5,-20(s0)
    80206920:	2785                	addiw	a5,a5,1
    80206922:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:70 (discriminator 1)
    80206926:	00b24797          	auipc	a5,0xb24
    8020692a:	6da78793          	addi	a5,a5,1754 # 80d2b000 <nsizes>
    8020692e:	4398                	lw	a4,0(a5)
    80206930:	fec42783          	lw	a5,-20(s0)
    80206934:	2781                	sext.w	a5,a5
    80206936:	f4e7c4e3          	blt	a5,a4,8020687e <bd_print+0xe>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:79
    }
  }
}
    8020693a:	0001                	nop
    8020693c:	0001                	nop
    8020693e:	60e2                	ld	ra,24(sp)
    80206940:	6442                	ld	s0,16(sp)
    80206942:	6105                	addi	sp,sp,32
    80206944:	8082                	ret

0000000080206946 <firstk>:
firstk():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:83

// 计算使2^k >= n的最小k值是多少？
int firstk(uint64_t n)
{
    80206946:	7179                	addi	sp,sp,-48
    80206948:	f422                	sd	s0,40(sp)
    8020694a:	1800                	addi	s0,sp,48
    8020694c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:84
  int k = 0;
    80206950:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:85
  uint64_t size = LEAF_SIZE;
    80206954:	47c1                	li	a5,16
    80206956:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:87

  while (size < n)
    8020695a:	a819                	j	80206970 <firstk+0x2a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:89
  {
    k++;
    8020695c:	fec42783          	lw	a5,-20(s0)
    80206960:	2785                	addiw	a5,a5,1
    80206962:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:90
    size *= 2;
    80206966:	fe043783          	ld	a5,-32(s0)
    8020696a:	0786                	slli	a5,a5,0x1
    8020696c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:87
  while (size < n)
    80206970:	fe043703          	ld	a4,-32(s0)
    80206974:	fd843783          	ld	a5,-40(s0)
    80206978:	fef762e3          	bltu	a4,a5,8020695c <firstk+0x16>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:92
  }
  return k;
    8020697c:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:93
}
    80206980:	853e                	mv	a0,a5
    80206982:	7422                	ld	s0,40(sp)
    80206984:	6145                	addi	sp,sp,48
    80206986:	8082                	ret

0000000080206988 <blk_index>:
blk_index():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:97

// 计算大小为k的块中地址p的块索引
int blk_index(int k, char *p)
{
    80206988:	7179                	addi	sp,sp,-48
    8020698a:	f422                	sd	s0,40(sp)
    8020698c:	1800                	addi	s0,sp,48
    8020698e:	87aa                	mv	a5,a0
    80206990:	fcb43823          	sd	a1,-48(s0)
    80206994:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:98
  int n = p - (char *)bd_base;
    80206998:	00b24797          	auipc	a5,0xb24
    8020699c:	67878793          	addi	a5,a5,1656 # 80d2b010 <bd_base>
    802069a0:	639c                	ld	a5,0(a5)
    802069a2:	fd043703          	ld	a4,-48(s0)
    802069a6:	40f707b3          	sub	a5,a4,a5
    802069aa:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:99
  return n / BLK_SIZE(k);
    802069ae:	fec42703          	lw	a4,-20(s0)
    802069b2:	fdc42783          	lw	a5,-36(s0)
    802069b6:	46c1                	li	a3,16
    802069b8:	00f697b3          	sll	a5,a3,a5
    802069bc:	02f747b3          	div	a5,a4,a5
    802069c0:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:100
}
    802069c2:	853e                	mv	a0,a5
    802069c4:	7422                	ld	s0,40(sp)
    802069c6:	6145                	addi	sp,sp,48
    802069c8:	8082                	ret

00000000802069ca <addr>:
addr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:104

// 将大小k的块索引转换回地址
void *addr(int k, int bi)
{
    802069ca:	7179                	addi	sp,sp,-48
    802069cc:	f422                	sd	s0,40(sp)
    802069ce:	1800                	addi	s0,sp,48
    802069d0:	87aa                	mv	a5,a0
    802069d2:	872e                	mv	a4,a1
    802069d4:	fcf42e23          	sw	a5,-36(s0)
    802069d8:	87ba                	mv	a5,a4
    802069da:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:105
  int n = bi * BLK_SIZE(k);
    802069de:	fdc42783          	lw	a5,-36(s0)
    802069e2:	4741                	li	a4,16
    802069e4:	00f717b3          	sll	a5,a4,a5
    802069e8:	0007871b          	sext.w	a4,a5
    802069ec:	fd842783          	lw	a5,-40(s0)
    802069f0:	02f707bb          	mulw	a5,a4,a5
    802069f4:	2781                	sext.w	a5,a5
    802069f6:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:106
  return (char *)bd_base + n;
    802069fa:	00b24797          	auipc	a5,0xb24
    802069fe:	61678793          	addi	a5,a5,1558 # 80d2b010 <bd_base>
    80206a02:	6398                	ld	a4,0(a5)
    80206a04:	fec42783          	lw	a5,-20(s0)
    80206a08:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:107
}
    80206a0a:	853e                	mv	a0,a5
    80206a0c:	7422                	ld	s0,40(sp)
    80206a0e:	6145                	addi	sp,sp,48
    80206a10:	8082                	ret

0000000080206a12 <bd_malloc>:
bd_malloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:111

// 分配nbytes大小的内存，但malloc不会返回小于LEAF_SIZE的内存
void *bd_malloc(uint64_t nbytes)
{
    80206a12:	715d                	addi	sp,sp,-80
    80206a14:	e486                	sd	ra,72(sp)
    80206a16:	e0a2                	sd	s0,64(sp)
    80206a18:	fc26                	sd	s1,56(sp)
    80206a1a:	0880                	addi	s0,sp,80
    80206a1c:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:117
  int fk, k;

  // acquire(&lock);

  // 找到一个大于等于nbytes的空闲块，从可能的最小k开始
  fk = firstk(nbytes);
    80206a20:	fb843503          	ld	a0,-72(s0)
    80206a24:	f23ff0ef          	jal	ra,80206946 <firstk>
    80206a28:	87aa                	mv	a5,a0
    80206a2a:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:118
  for (k = fk; k < nsizes; k++)
    80206a2e:	fd842783          	lw	a5,-40(s0)
    80206a32:	fcf42e23          	sw	a5,-36(s0)
    80206a36:	a025                	j	80206a5e <bd_malloc+0x4c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:120
  {
    if (!lst_empty(&bd_sizes[k].free))
    80206a38:	00b24797          	auipc	a5,0xb24
    80206a3c:	5d078793          	addi	a5,a5,1488 # 80d2b008 <bd_sizes>
    80206a40:	6398                	ld	a4,0(a5)
    80206a42:	fdc42783          	lw	a5,-36(s0)
    80206a46:	0796                	slli	a5,a5,0x5
    80206a48:	97ba                	add	a5,a5,a4
    80206a4a:	853e                	mv	a0,a5
    80206a4c:	4eb020ef          	jal	ra,80209736 <lst_empty>
    80206a50:	87aa                	mv	a5,a0
    80206a52:	c38d                	beqz	a5,80206a74 <bd_malloc+0x62>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:118 (discriminator 2)
  for (k = fk; k < nsizes; k++)
    80206a54:	fdc42783          	lw	a5,-36(s0)
    80206a58:	2785                	addiw	a5,a5,1
    80206a5a:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:118 (discriminator 1)
    80206a5e:	00b24797          	auipc	a5,0xb24
    80206a62:	5a278793          	addi	a5,a5,1442 # 80d2b000 <nsizes>
    80206a66:	4398                	lw	a4,0(a5)
    80206a68:	fdc42783          	lw	a5,-36(s0)
    80206a6c:	2781                	sext.w	a5,a5
    80206a6e:	fce7c5e3          	blt	a5,a4,80206a38 <bd_malloc+0x26>
    80206a72:	a011                	j	80206a76 <bd_malloc+0x64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:121
      break;
    80206a74:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:123
  }
  if (k >= nsizes)
    80206a76:	00b24797          	auipc	a5,0xb24
    80206a7a:	58a78793          	addi	a5,a5,1418 # 80d2b000 <nsizes>
    80206a7e:	4398                	lw	a4,0(a5)
    80206a80:	fdc42783          	lw	a5,-36(s0)
    80206a84:	2781                	sext.w	a5,a5
    80206a86:	00e7c463          	blt	a5,a4,80206a8e <bd_malloc+0x7c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:126
  { // 没有空闲块？
    // release(&lock);
    return 0;
    80206a8a:	4781                	li	a5,0
    80206a8c:	a201                	j	80206b8c <bd_malloc+0x17a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:130
  }

  // 找到一个块；取出它并可能将其分割。
  char *p = lst_pop(&bd_sizes[k].free);
    80206a8e:	00b24797          	auipc	a5,0xb24
    80206a92:	57a78793          	addi	a5,a5,1402 # 80d2b008 <bd_sizes>
    80206a96:	6398                	ld	a4,0(a5)
    80206a98:	fdc42783          	lw	a5,-36(s0)
    80206a9c:	0796                	slli	a5,a5,0x5
    80206a9e:	97ba                	add	a5,a5,a4
    80206aa0:	853e                	mv	a0,a5
    80206aa2:	4ed020ef          	jal	ra,8020978e <lst_pop>
    80206aa6:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:131
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
    80206aaa:	00b24797          	auipc	a5,0xb24
    80206aae:	55e78793          	addi	a5,a5,1374 # 80d2b008 <bd_sizes>
    80206ab2:	6398                	ld	a4,0(a5)
    80206ab4:	fdc42783          	lw	a5,-36(s0)
    80206ab8:	0796                	slli	a5,a5,0x5
    80206aba:	97ba                	add	a5,a5,a4
    80206abc:	6b84                	ld	s1,16(a5)
    80206abe:	fdc42783          	lw	a5,-36(s0)
    80206ac2:	fd043583          	ld	a1,-48(s0)
    80206ac6:	853e                	mv	a0,a5
    80206ac8:	ec1ff0ef          	jal	ra,80206988 <blk_index>
    80206acc:	87aa                	mv	a5,a0
    80206ace:	85be                	mv	a1,a5
    80206ad0:	8526                	mv	a0,s1
    80206ad2:	befff0ef          	jal	ra,802066c0 <bit_set>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:132
  for (; k > fk; k--)
    80206ad6:	a04d                	j	80206b78 <bd_malloc+0x166>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:136 (discriminator 2)
  {
    // 分割大小为k的块，并标记大小为k-1的一半为已分配
    // 并将另一半放入大小为k-1的空闲列表中
    char *q = p + BLK_SIZE(k - 1); // p的伙伴
    80206ad8:	fdc42783          	lw	a5,-36(s0)
    80206adc:	37fd                	addiw	a5,a5,-1
    80206ade:	2781                	sext.w	a5,a5
    80206ae0:	4741                	li	a4,16
    80206ae2:	00f717b3          	sll	a5,a4,a5
    80206ae6:	873e                	mv	a4,a5
    80206ae8:	fd043783          	ld	a5,-48(s0)
    80206aec:	97ba                	add	a5,a5,a4
    80206aee:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:137 (discriminator 2)
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80206af2:	00b24797          	auipc	a5,0xb24
    80206af6:	51678793          	addi	a5,a5,1302 # 80d2b008 <bd_sizes>
    80206afa:	6398                	ld	a4,0(a5)
    80206afc:	fdc42783          	lw	a5,-36(s0)
    80206b00:	0796                	slli	a5,a5,0x5
    80206b02:	97ba                	add	a5,a5,a4
    80206b04:	6f84                	ld	s1,24(a5)
    80206b06:	fdc42783          	lw	a5,-36(s0)
    80206b0a:	fd043583          	ld	a1,-48(s0)
    80206b0e:	853e                	mv	a0,a5
    80206b10:	e79ff0ef          	jal	ra,80206988 <blk_index>
    80206b14:	87aa                	mv	a5,a0
    80206b16:	85be                	mv	a1,a5
    80206b18:	8526                	mv	a0,s1
    80206b1a:	ba7ff0ef          	jal	ra,802066c0 <bit_set>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:138 (discriminator 2)
    bit_set(bd_sizes[k - 1].alloc, blk_index(k - 1, p));
    80206b1e:	00b24797          	auipc	a5,0xb24
    80206b22:	4ea78793          	addi	a5,a5,1258 # 80d2b008 <bd_sizes>
    80206b26:	6398                	ld	a4,0(a5)
    80206b28:	fdc42783          	lw	a5,-36(s0)
    80206b2c:	0796                	slli	a5,a5,0x5
    80206b2e:	1781                	addi	a5,a5,-32
    80206b30:	97ba                	add	a5,a5,a4
    80206b32:	6b84                	ld	s1,16(a5)
    80206b34:	fdc42783          	lw	a5,-36(s0)
    80206b38:	37fd                	addiw	a5,a5,-1
    80206b3a:	2781                	sext.w	a5,a5
    80206b3c:	fd043583          	ld	a1,-48(s0)
    80206b40:	853e                	mv	a0,a5
    80206b42:	e47ff0ef          	jal	ra,80206988 <blk_index>
    80206b46:	87aa                	mv	a5,a0
    80206b48:	85be                	mv	a1,a5
    80206b4a:	8526                	mv	a0,s1
    80206b4c:	b75ff0ef          	jal	ra,802066c0 <bit_set>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:139 (discriminator 2)
    lst_push(&bd_sizes[k - 1].free, q);
    80206b50:	00b24797          	auipc	a5,0xb24
    80206b54:	4b878793          	addi	a5,a5,1208 # 80d2b008 <bd_sizes>
    80206b58:	6398                	ld	a4,0(a5)
    80206b5a:	fdc42783          	lw	a5,-36(s0)
    80206b5e:	0796                	slli	a5,a5,0x5
    80206b60:	1781                	addi	a5,a5,-32
    80206b62:	97ba                	add	a5,a5,a4
    80206b64:	fc843583          	ld	a1,-56(s0)
    80206b68:	853e                	mv	a0,a5
    80206b6a:	475020ef          	jal	ra,802097de <lst_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:132 (discriminator 2)
  for (; k > fk; k--)
    80206b6e:	fdc42783          	lw	a5,-36(s0)
    80206b72:	37fd                	addiw	a5,a5,-1
    80206b74:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:132 (discriminator 1)
    80206b78:	fdc42703          	lw	a4,-36(s0)
    80206b7c:	fd842783          	lw	a5,-40(s0)
    80206b80:	2701                	sext.w	a4,a4
    80206b82:	2781                	sext.w	a5,a5
    80206b84:	f4e7cae3          	blt	a5,a4,80206ad8 <bd_malloc+0xc6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:143
  }
  // release(&lock);

  return p;
    80206b88:	fd043783          	ld	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:144
}
    80206b8c:	853e                	mv	a0,a5
    80206b8e:	60a6                	ld	ra,72(sp)
    80206b90:	6406                	ld	s0,64(sp)
    80206b92:	74e2                	ld	s1,56(sp)
    80206b94:	6161                	addi	sp,sp,80
    80206b96:	8082                	ret

0000000080206b98 <size>:
size():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:148

// 查找指针p指向的块的大小。
int size(char *p)
{
    80206b98:	7139                	addi	sp,sp,-64
    80206b9a:	fc06                	sd	ra,56(sp)
    80206b9c:	f822                	sd	s0,48(sp)
    80206b9e:	f426                	sd	s1,40(sp)
    80206ba0:	0080                	addi	s0,sp,64
    80206ba2:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:149
  for (int k = 0; k < nsizes; k++)
    80206ba6:	fc042e23          	sw	zero,-36(s0)
    80206baa:	a0a1                	j	80206bf2 <size+0x5a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:151
  {
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p)))
    80206bac:	00b24797          	auipc	a5,0xb24
    80206bb0:	45c78793          	addi	a5,a5,1116 # 80d2b008 <bd_sizes>
    80206bb4:	6398                	ld	a4,0(a5)
    80206bb6:	fdc42783          	lw	a5,-36(s0)
    80206bba:	0785                	addi	a5,a5,1
    80206bbc:	0796                	slli	a5,a5,0x5
    80206bbe:	97ba                	add	a5,a5,a4
    80206bc0:	6f84                	ld	s1,24(a5)
    80206bc2:	fdc42783          	lw	a5,-36(s0)
    80206bc6:	2785                	addiw	a5,a5,1
    80206bc8:	2781                	sext.w	a5,a5
    80206bca:	fc843583          	ld	a1,-56(s0)
    80206bce:	853e                	mv	a0,a5
    80206bd0:	db9ff0ef          	jal	ra,80206988 <blk_index>
    80206bd4:	87aa                	mv	a5,a0
    80206bd6:	85be                	mv	a1,a5
    80206bd8:	8526                	mv	a0,s1
    80206bda:	a65ff0ef          	jal	ra,8020663e <bit_isset>
    80206bde:	87aa                	mv	a5,a0
    80206be0:	c781                	beqz	a5,80206be8 <size+0x50>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:153
    {
      return k;
    80206be2:	fdc42783          	lw	a5,-36(s0)
    80206be6:	a00d                	j	80206c08 <size+0x70>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:149 (discriminator 2)
  for (int k = 0; k < nsizes; k++)
    80206be8:	fdc42783          	lw	a5,-36(s0)
    80206bec:	2785                	addiw	a5,a5,1
    80206bee:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:149 (discriminator 1)
    80206bf2:	00b24797          	auipc	a5,0xb24
    80206bf6:	40e78793          	addi	a5,a5,1038 # 80d2b000 <nsizes>
    80206bfa:	4398                	lw	a4,0(a5)
    80206bfc:	fdc42783          	lw	a5,-36(s0)
    80206c00:	2781                	sext.w	a5,a5
    80206c02:	fae7c5e3          	blt	a5,a4,80206bac <size+0x14>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:156
    }
  }
  return 0;
    80206c06:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:157
}
    80206c08:	853e                	mv	a0,a5
    80206c0a:	70e2                	ld	ra,56(sp)
    80206c0c:	7442                	ld	s0,48(sp)
    80206c0e:	74a2                	ld	s1,40(sp)
    80206c10:	6121                	addi	sp,sp,64
    80206c12:	8082                	ret

0000000080206c14 <bd_free>:
bd_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:161

// 释放之前使用bd_malloc分配的内存p。
void bd_free(void *p)
{
    80206c14:	715d                	addi	sp,sp,-80
    80206c16:	e486                	sd	ra,72(sp)
    80206c18:	e0a2                	sd	s0,64(sp)
    80206c1a:	fc26                	sd	s1,56(sp)
    80206c1c:	0880                	addi	s0,sp,80
    80206c1e:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:166
  void *q;
  int k;

  // acquire(&lock);
  for (k = size(p); k < MAXSIZE; k++)
    80206c22:	fb843503          	ld	a0,-72(s0)
    80206c26:	f73ff0ef          	jal	ra,80206b98 <size>
    80206c2a:	87aa                	mv	a5,a0
    80206c2c:	fcf42e23          	sw	a5,-36(s0)
    80206c30:	a0d5                	j	80206d14 <bd_free+0x100>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:168
  {
    int bi = blk_index(k, p);
    80206c32:	fdc42783          	lw	a5,-36(s0)
    80206c36:	fb843583          	ld	a1,-72(s0)
    80206c3a:	853e                	mv	a0,a5
    80206c3c:	d4dff0ef          	jal	ra,80206988 <blk_index>
    80206c40:	87aa                	mv	a5,a0
    80206c42:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:169
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80206c46:	fd842783          	lw	a5,-40(s0)
    80206c4a:	8b85                	andi	a5,a5,1
    80206c4c:	2781                	sext.w	a5,a5
    80206c4e:	e791                	bnez	a5,80206c5a <bd_free+0x46>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:169 (discriminator 1)
    80206c50:	fd842783          	lw	a5,-40(s0)
    80206c54:	2785                	addiw	a5,a5,1
    80206c56:	2781                	sext.w	a5,a5
    80206c58:	a029                	j	80206c62 <bd_free+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:169 (discriminator 2)
    80206c5a:	fd842783          	lw	a5,-40(s0)
    80206c5e:	37fd                	addiw	a5,a5,-1
    80206c60:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:169 (discriminator 4)
    80206c62:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:170 (discriminator 4)
    bit_clear(bd_sizes[k].alloc, bi); // 在大小为k的位置释放p
    80206c66:	00b24797          	auipc	a5,0xb24
    80206c6a:	3a278793          	addi	a5,a5,930 # 80d2b008 <bd_sizes>
    80206c6e:	6398                	ld	a4,0(a5)
    80206c70:	fdc42783          	lw	a5,-36(s0)
    80206c74:	0796                	slli	a5,a5,0x5
    80206c76:	97ba                	add	a5,a5,a4
    80206c78:	6b9c                	ld	a5,16(a5)
    80206c7a:	fd842703          	lw	a4,-40(s0)
    80206c7e:	85ba                	mv	a1,a4
    80206c80:	853e                	mv	a0,a5
    80206c82:	acbff0ef          	jal	ra,8020674c <bit_clear>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:171 (discriminator 4)
    if (bit_isset(bd_sizes[k].alloc, buddy))
    80206c86:	00b24797          	auipc	a5,0xb24
    80206c8a:	38278793          	addi	a5,a5,898 # 80d2b008 <bd_sizes>
    80206c8e:	6398                	ld	a4,0(a5)
    80206c90:	fdc42783          	lw	a5,-36(s0)
    80206c94:	0796                	slli	a5,a5,0x5
    80206c96:	97ba                	add	a5,a5,a4
    80206c98:	6b9c                	ld	a5,16(a5)
    80206c9a:	fd442703          	lw	a4,-44(s0)
    80206c9e:	85ba                	mv	a1,a4
    80206ca0:	853e                	mv	a0,a5
    80206ca2:	99dff0ef          	jal	ra,8020663e <bit_isset>
    80206ca6:	87aa                	mv	a5,a0
    80206ca8:	e7c1                	bnez	a5,80206d30 <bd_free+0x11c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:176
    {        // 伙伴是否已分配？
      break; // 跳出循环
    }
    // 伙伴是空闲的；与伙伴合并
    q = addr(k, buddy);
    80206caa:	fd442703          	lw	a4,-44(s0)
    80206cae:	fdc42783          	lw	a5,-36(s0)
    80206cb2:	85ba                	mv	a1,a4
    80206cb4:	853e                	mv	a0,a5
    80206cb6:	d15ff0ef          	jal	ra,802069ca <addr>
    80206cba:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:177
    lst_remove(q); // 从空闲列表中移除伙伴
    80206cbe:	fc843503          	ld	a0,-56(s0)
    80206cc2:	29f020ef          	jal	ra,80209760 <lst_remove>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:178
    if (buddy % 2 == 0)
    80206cc6:	fd442783          	lw	a5,-44(s0)
    80206cca:	8b85                	andi	a5,a5,1
    80206ccc:	2781                	sext.w	a5,a5
    80206cce:	e789                	bnez	a5,80206cd8 <bd_free+0xc4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:180
    {
      p = q;
    80206cd0:	fc843783          	ld	a5,-56(s0)
    80206cd4:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:183 (discriminator 2)
    }
    // 在大小为k+1的位置标记合并的伙伴对不再分割
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
    80206cd8:	00b24797          	auipc	a5,0xb24
    80206cdc:	33078793          	addi	a5,a5,816 # 80d2b008 <bd_sizes>
    80206ce0:	6398                	ld	a4,0(a5)
    80206ce2:	fdc42783          	lw	a5,-36(s0)
    80206ce6:	0785                	addi	a5,a5,1
    80206ce8:	0796                	slli	a5,a5,0x5
    80206cea:	97ba                	add	a5,a5,a4
    80206cec:	6f84                	ld	s1,24(a5)
    80206cee:	fdc42783          	lw	a5,-36(s0)
    80206cf2:	2785                	addiw	a5,a5,1
    80206cf4:	2781                	sext.w	a5,a5
    80206cf6:	fb843583          	ld	a1,-72(s0)
    80206cfa:	853e                	mv	a0,a5
    80206cfc:	c8dff0ef          	jal	ra,80206988 <blk_index>
    80206d00:	87aa                	mv	a5,a0
    80206d02:	85be                	mv	a1,a5
    80206d04:	8526                	mv	a0,s1
    80206d06:	a47ff0ef          	jal	ra,8020674c <bit_clear>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:166 (discriminator 2)
  for (k = size(p); k < MAXSIZE; k++)
    80206d0a:	fdc42783          	lw	a5,-36(s0)
    80206d0e:	2785                	addiw	a5,a5,1
    80206d10:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:166 (discriminator 1)
    80206d14:	00b24797          	auipc	a5,0xb24
    80206d18:	2ec78793          	addi	a5,a5,748 # 80d2b000 <nsizes>
    80206d1c:	439c                	lw	a5,0(a5)
    80206d1e:	37fd                	addiw	a5,a5,-1
    80206d20:	0007871b          	sext.w	a4,a5
    80206d24:	fdc42783          	lw	a5,-36(s0)
    80206d28:	2781                	sext.w	a5,a5
    80206d2a:	f0e7c4e3          	blt	a5,a4,80206c32 <bd_free+0x1e>
    80206d2e:	a011                	j	80206d32 <bd_free+0x11e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:173
      break; // 跳出循环
    80206d30:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:185
  }
  lst_push(&bd_sizes[k].free, p);
    80206d32:	00b24797          	auipc	a5,0xb24
    80206d36:	2d678793          	addi	a5,a5,726 # 80d2b008 <bd_sizes>
    80206d3a:	6398                	ld	a4,0(a5)
    80206d3c:	fdc42783          	lw	a5,-36(s0)
    80206d40:	0796                	slli	a5,a5,0x5
    80206d42:	97ba                	add	a5,a5,a4
    80206d44:	fb843583          	ld	a1,-72(s0)
    80206d48:	853e                	mv	a0,a5
    80206d4a:	295020ef          	jal	ra,802097de <lst_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:187
  // release(&lock);
}
    80206d4e:	0001                	nop
    80206d50:	60a6                	ld	ra,72(sp)
    80206d52:	6406                	ld	s0,64(sp)
    80206d54:	74e2                	ld	s1,56(sp)
    80206d56:	6161                	addi	sp,sp,80
    80206d58:	8082                	ret

0000000080206d5a <blk_index_next>:
blk_index_next():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:191

// 计算在大小为k的块中不包含p的第一个块的索引
int blk_index_next(int k, char *p)
{
    80206d5a:	7179                	addi	sp,sp,-48
    80206d5c:	f422                	sd	s0,40(sp)
    80206d5e:	1800                	addi	s0,sp,48
    80206d60:	87aa                	mv	a5,a0
    80206d62:	fcb43823          	sd	a1,-48(s0)
    80206d66:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:192
  int n = (p - (char *)bd_base) / BLK_SIZE(k);
    80206d6a:	00b24797          	auipc	a5,0xb24
    80206d6e:	2a678793          	addi	a5,a5,678 # 80d2b010 <bd_base>
    80206d72:	639c                	ld	a5,0(a5)
    80206d74:	fd043703          	ld	a4,-48(s0)
    80206d78:	8f1d                	sub	a4,a4,a5
    80206d7a:	fdc42783          	lw	a5,-36(s0)
    80206d7e:	46c1                	li	a3,16
    80206d80:	00f697b3          	sll	a5,a3,a5
    80206d84:	02f747b3          	div	a5,a4,a5
    80206d88:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:193
  if ((p - (char *)bd_base) % BLK_SIZE(k) != 0)
    80206d8c:	00b24797          	auipc	a5,0xb24
    80206d90:	28478793          	addi	a5,a5,644 # 80d2b010 <bd_base>
    80206d94:	639c                	ld	a5,0(a5)
    80206d96:	fd043703          	ld	a4,-48(s0)
    80206d9a:	8f1d                	sub	a4,a4,a5
    80206d9c:	fdc42783          	lw	a5,-36(s0)
    80206da0:	46c1                	li	a3,16
    80206da2:	00f697b3          	sll	a5,a3,a5
    80206da6:	02f767b3          	rem	a5,a4,a5
    80206daa:	c791                	beqz	a5,80206db6 <blk_index_next+0x5c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:194
    n++;
    80206dac:	fec42783          	lw	a5,-20(s0)
    80206db0:	2785                	addiw	a5,a5,1
    80206db2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:195
  return n;
    80206db6:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:196
}
    80206dba:	853e                	mv	a0,a5
    80206dbc:	7422                	ld	s0,40(sp)
    80206dbe:	6145                	addi	sp,sp,48
    80206dc0:	8082                	ret

0000000080206dc2 <_log2>:
_log2():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:199

static int _log2(uint64_t n)
{
    80206dc2:	7179                	addi	sp,sp,-48
    80206dc4:	f422                	sd	s0,40(sp)
    80206dc6:	1800                	addi	s0,sp,48
    80206dc8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:200
  int k = 0;
    80206dcc:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:201
  while (n > 1)
    80206dd0:	a819                	j	80206de6 <_log2+0x24>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:203
  {
    k++;
    80206dd2:	fec42783          	lw	a5,-20(s0)
    80206dd6:	2785                	addiw	a5,a5,1
    80206dd8:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:204
    n >>= 1;
    80206ddc:	fd843783          	ld	a5,-40(s0)
    80206de0:	8385                	srli	a5,a5,0x1
    80206de2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:201
  while (n > 1)
    80206de6:	fd843703          	ld	a4,-40(s0)
    80206dea:	4785                	li	a5,1
    80206dec:	fee7e3e3          	bltu	a5,a4,80206dd2 <_log2+0x10>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:206
  }
  return k;
    80206df0:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:207
}
    80206df4:	853e                	mv	a0,a5
    80206df6:	7422                	ld	s0,40(sp)
    80206df8:	6145                	addi	sp,sp,48
    80206dfa:	8082                	ret

0000000080206dfc <bd_mark>:
bd_mark():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:211

// 将内存范围[start, stop)标记为已分配，从大小0开始。
void bd_mark(void *start, void *stop)
{
    80206dfc:	7179                	addi	sp,sp,-48
    80206dfe:	f406                	sd	ra,40(sp)
    80206e00:	f022                	sd	s0,32(sp)
    80206e02:	1800                	addi	s0,sp,48
    80206e04:	fca43c23          	sd	a0,-40(s0)
    80206e08:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:214
  int bi, bj;

  if (((uint64_t)start % LEAF_SIZE != 0) || ((uint64_t)stop % LEAF_SIZE != 0))
    80206e0c:	fd843783          	ld	a5,-40(s0)
    80206e10:	8bbd                	andi	a5,a5,15
    80206e12:	e789                	bnez	a5,80206e1c <bd_mark+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:214 (discriminator 1)
    80206e14:	fd043783          	ld	a5,-48(s0)
    80206e18:	8bbd                	andi	a5,a5,15
    80206e1a:	cf89                	beqz	a5,80206e34 <bd_mark+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:215
    panic("bd_mark\n");
    80206e1c:	00004617          	auipc	a2,0x4
    80206e20:	86c60613          	addi	a2,a2,-1940 # 8020a688 <MMIO+0x10>
    80206e24:	0d700593          	li	a1,215
    80206e28:	00004517          	auipc	a0,0x4
    80206e2c:	87050513          	addi	a0,a0,-1936 # 8020a698 <MMIO+0x20>
    80206e30:	1ad000ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:217

  for (int k = 0; k < nsizes; k++)
    80206e34:	fe042423          	sw	zero,-24(s0)
    80206e38:	a869                	j	80206ed2 <bd_mark+0xd6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:219
  {
    bi = blk_index(k, start);
    80206e3a:	fe842783          	lw	a5,-24(s0)
    80206e3e:	fd843583          	ld	a1,-40(s0)
    80206e42:	853e                	mv	a0,a5
    80206e44:	b45ff0ef          	jal	ra,80206988 <blk_index>
    80206e48:	87aa                	mv	a5,a0
    80206e4a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:220
    bj = blk_index_next(k, stop);
    80206e4e:	fe842783          	lw	a5,-24(s0)
    80206e52:	fd043583          	ld	a1,-48(s0)
    80206e56:	853e                	mv	a0,a5
    80206e58:	f03ff0ef          	jal	ra,80206d5a <blk_index_next>
    80206e5c:	87aa                	mv	a5,a0
    80206e5e:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:221
    for (; bi < bj; bi++)
    80206e62:	a899                	j	80206eb8 <bd_mark+0xbc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:223
    {
      if (k > 0)
    80206e64:	fe842783          	lw	a5,-24(s0)
    80206e68:	2781                	sext.w	a5,a5
    80206e6a:	02f05263          	blez	a5,80206e8e <bd_mark+0x92>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:226
      {
        // 如果在大小k的块已被分配，也标记它已被分割
        bit_set(bd_sizes[k].split, bi);
    80206e6e:	00b24797          	auipc	a5,0xb24
    80206e72:	19a78793          	addi	a5,a5,410 # 80d2b008 <bd_sizes>
    80206e76:	6398                	ld	a4,0(a5)
    80206e78:	fe842783          	lw	a5,-24(s0)
    80206e7c:	0796                	slli	a5,a5,0x5
    80206e7e:	97ba                	add	a5,a5,a4
    80206e80:	6f9c                	ld	a5,24(a5)
    80206e82:	fec42703          	lw	a4,-20(s0)
    80206e86:	85ba                	mv	a1,a4
    80206e88:	853e                	mv	a0,a5
    80206e8a:	837ff0ef          	jal	ra,802066c0 <bit_set>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:228
      }
      bit_set(bd_sizes[k].alloc, bi);
    80206e8e:	00b24797          	auipc	a5,0xb24
    80206e92:	17a78793          	addi	a5,a5,378 # 80d2b008 <bd_sizes>
    80206e96:	6398                	ld	a4,0(a5)
    80206e98:	fe842783          	lw	a5,-24(s0)
    80206e9c:	0796                	slli	a5,a5,0x5
    80206e9e:	97ba                	add	a5,a5,a4
    80206ea0:	6b9c                	ld	a5,16(a5)
    80206ea2:	fec42703          	lw	a4,-20(s0)
    80206ea6:	85ba                	mv	a1,a4
    80206ea8:	853e                	mv	a0,a5
    80206eaa:	817ff0ef          	jal	ra,802066c0 <bit_set>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:221
    for (; bi < bj; bi++)
    80206eae:	fec42783          	lw	a5,-20(s0)
    80206eb2:	2785                	addiw	a5,a5,1
    80206eb4:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:221 (discriminator 1)
    80206eb8:	fec42703          	lw	a4,-20(s0)
    80206ebc:	fe442783          	lw	a5,-28(s0)
    80206ec0:	2701                	sext.w	a4,a4
    80206ec2:	2781                	sext.w	a5,a5
    80206ec4:	faf740e3          	blt	a4,a5,80206e64 <bd_mark+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:217 (discriminator 2)
  for (int k = 0; k < nsizes; k++)
    80206ec8:	fe842783          	lw	a5,-24(s0)
    80206ecc:	2785                	addiw	a5,a5,1
    80206ece:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:217 (discriminator 1)
    80206ed2:	00b24797          	auipc	a5,0xb24
    80206ed6:	12e78793          	addi	a5,a5,302 # 80d2b000 <nsizes>
    80206eda:	4398                	lw	a4,0(a5)
    80206edc:	fe842783          	lw	a5,-24(s0)
    80206ee0:	2781                	sext.w	a5,a5
    80206ee2:	f4e7cce3          	blt	a5,a4,80206e3a <bd_mark+0x3e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:231
    }
  }
}
    80206ee6:	0001                	nop
    80206ee8:	0001                	nop
    80206eea:	70a2                	ld	ra,40(sp)
    80206eec:	7402                	ld	s0,32(sp)
    80206eee:	6145                	addi	sp,sp,48
    80206ef0:	8082                	ret

0000000080206ef2 <bd_initfree_pair>:
bd_initfree_pair():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:235

// 如果一个块被标记为已分配且其伙伴是空闲的，则将伙伴放入大小为k的空闲列表。
int bd_initfree_pair(int k, int bi)
{
    80206ef2:	7139                	addi	sp,sp,-64
    80206ef4:	fc06                	sd	ra,56(sp)
    80206ef6:	f822                	sd	s0,48(sp)
    80206ef8:	f426                	sd	s1,40(sp)
    80206efa:	0080                	addi	s0,sp,64
    80206efc:	87aa                	mv	a5,a0
    80206efe:	872e                	mv	a4,a1
    80206f00:	fcf42623          	sw	a5,-52(s0)
    80206f04:	87ba                	mv	a5,a4
    80206f06:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:236
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80206f0a:	fc842783          	lw	a5,-56(s0)
    80206f0e:	8b85                	andi	a5,a5,1
    80206f10:	2781                	sext.w	a5,a5
    80206f12:	e791                	bnez	a5,80206f1e <bd_initfree_pair+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:236 (discriminator 1)
    80206f14:	fc842783          	lw	a5,-56(s0)
    80206f18:	2785                	addiw	a5,a5,1
    80206f1a:	2781                	sext.w	a5,a5
    80206f1c:	a029                	j	80206f26 <bd_initfree_pair+0x34>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:236 (discriminator 2)
    80206f1e:	fc842783          	lw	a5,-56(s0)
    80206f22:	37fd                	addiw	a5,a5,-1
    80206f24:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:236 (discriminator 4)
    80206f26:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:237 (discriminator 4)
  int free = 0;
    80206f2a:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:238 (discriminator 4)
  if (bit_isset(bd_sizes[k].alloc, bi) != bit_isset(bd_sizes[k].alloc, buddy))
    80206f2e:	00b24797          	auipc	a5,0xb24
    80206f32:	0da78793          	addi	a5,a5,218 # 80d2b008 <bd_sizes>
    80206f36:	6398                	ld	a4,0(a5)
    80206f38:	fcc42783          	lw	a5,-52(s0)
    80206f3c:	0796                	slli	a5,a5,0x5
    80206f3e:	97ba                	add	a5,a5,a4
    80206f40:	6b9c                	ld	a5,16(a5)
    80206f42:	fc842703          	lw	a4,-56(s0)
    80206f46:	85ba                	mv	a1,a4
    80206f48:	853e                	mv	a0,a5
    80206f4a:	ef4ff0ef          	jal	ra,8020663e <bit_isset>
    80206f4e:	87aa                	mv	a5,a0
    80206f50:	84be                	mv	s1,a5
    80206f52:	00b24797          	auipc	a5,0xb24
    80206f56:	0b678793          	addi	a5,a5,182 # 80d2b008 <bd_sizes>
    80206f5a:	6398                	ld	a4,0(a5)
    80206f5c:	fcc42783          	lw	a5,-52(s0)
    80206f60:	0796                	slli	a5,a5,0x5
    80206f62:	97ba                	add	a5,a5,a4
    80206f64:	6b9c                	ld	a5,16(a5)
    80206f66:	fd842703          	lw	a4,-40(s0)
    80206f6a:	85ba                	mv	a1,a4
    80206f6c:	853e                	mv	a0,a5
    80206f6e:	ed0ff0ef          	jal	ra,8020663e <bit_isset>
    80206f72:	87aa                	mv	a5,a0
    80206f74:	8726                	mv	a4,s1
    80206f76:	08f70a63          	beq	a4,a5,8020700a <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:241
  {
    // 一对中的一个是空闲的
    free = BLK_SIZE(k);
    80206f7a:	fcc42783          	lw	a5,-52(s0)
    80206f7e:	4741                	li	a4,16
    80206f80:	00f717b3          	sll	a5,a4,a5
    80206f84:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:242
    if (bit_isset(bd_sizes[k].alloc, bi))
    80206f88:	00b24797          	auipc	a5,0xb24
    80206f8c:	08078793          	addi	a5,a5,128 # 80d2b008 <bd_sizes>
    80206f90:	6398                	ld	a4,0(a5)
    80206f92:	fcc42783          	lw	a5,-52(s0)
    80206f96:	0796                	slli	a5,a5,0x5
    80206f98:	97ba                	add	a5,a5,a4
    80206f9a:	6b9c                	ld	a5,16(a5)
    80206f9c:	fc842703          	lw	a4,-56(s0)
    80206fa0:	85ba                	mv	a1,a4
    80206fa2:	853e                	mv	a0,a5
    80206fa4:	e9aff0ef          	jal	ra,8020663e <bit_isset>
    80206fa8:	87aa                	mv	a5,a0
    80206faa:	cb8d                	beqz	a5,80206fdc <bd_initfree_pair+0xea>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:243
      lst_push(&bd_sizes[k].free, addr(k, buddy)); // 将伙伴放入空闲列表
    80206fac:	00b24797          	auipc	a5,0xb24
    80206fb0:	05c78793          	addi	a5,a5,92 # 80d2b008 <bd_sizes>
    80206fb4:	6398                	ld	a4,0(a5)
    80206fb6:	fcc42783          	lw	a5,-52(s0)
    80206fba:	0796                	slli	a5,a5,0x5
    80206fbc:	97ba                	add	a5,a5,a4
    80206fbe:	84be                	mv	s1,a5
    80206fc0:	fd842703          	lw	a4,-40(s0)
    80206fc4:	fcc42783          	lw	a5,-52(s0)
    80206fc8:	85ba                	mv	a1,a4
    80206fca:	853e                	mv	a0,a5
    80206fcc:	9ffff0ef          	jal	ra,802069ca <addr>
    80206fd0:	87aa                	mv	a5,a0
    80206fd2:	85be                	mv	a1,a5
    80206fd4:	8526                	mv	a0,s1
    80206fd6:	009020ef          	jal	ra,802097de <lst_push>
    80206fda:	a805                	j	8020700a <bd_initfree_pair+0x118>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:245
    else
      lst_push(&bd_sizes[k].free, addr(k, bi)); // 将bi放入空闲列表
    80206fdc:	00b24797          	auipc	a5,0xb24
    80206fe0:	02c78793          	addi	a5,a5,44 # 80d2b008 <bd_sizes>
    80206fe4:	6398                	ld	a4,0(a5)
    80206fe6:	fcc42783          	lw	a5,-52(s0)
    80206fea:	0796                	slli	a5,a5,0x5
    80206fec:	97ba                	add	a5,a5,a4
    80206fee:	84be                	mv	s1,a5
    80206ff0:	fc842703          	lw	a4,-56(s0)
    80206ff4:	fcc42783          	lw	a5,-52(s0)
    80206ff8:	85ba                	mv	a1,a4
    80206ffa:	853e                	mv	a0,a5
    80206ffc:	9cfff0ef          	jal	ra,802069ca <addr>
    80207000:	87aa                	mv	a5,a0
    80207002:	85be                	mv	a1,a5
    80207004:	8526                	mv	a0,s1
    80207006:	7d8020ef          	jal	ra,802097de <lst_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:247
  }
  return free;
    8020700a:	fdc42783          	lw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:248
}
    8020700e:	853e                	mv	a0,a5
    80207010:	70e2                	ld	ra,56(sp)
    80207012:	7442                	ld	s0,48(sp)
    80207014:	74a2                	ld	s1,40(sp)
    80207016:	6121                	addi	sp,sp,64
    80207018:	8082                	ret

000000008020701a <bd_initfree>:
bd_initfree():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:252

// 为每个大小k初始化空闲列表。对于每个大小k，只有两对可能有一个伙伴应该在空闲列表上：bd_left和bd_right。
int bd_initfree(void *bd_left, void *bd_right)
{
    8020701a:	7179                	addi	sp,sp,-48
    8020701c:	f406                	sd	ra,40(sp)
    8020701e:	f022                	sd	s0,32(sp)
    80207020:	1800                	addi	s0,sp,48
    80207022:	fca43c23          	sd	a0,-40(s0)
    80207026:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:253
  int free = 0;
    8020702a:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:255

  for (int k = 0; k < MAXSIZE; k++)
    8020702e:	fe042423          	sw	zero,-24(s0)
    80207032:	a051                	j	802070b6 <bd_initfree+0x9c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:257
  { // 跳过最大大小
    int left = blk_index_next(k, bd_left);
    80207034:	fe842783          	lw	a5,-24(s0)
    80207038:	fd843583          	ld	a1,-40(s0)
    8020703c:	853e                	mv	a0,a5
    8020703e:	d1dff0ef          	jal	ra,80206d5a <blk_index_next>
    80207042:	87aa                	mv	a5,a0
    80207044:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:258
    int right = blk_index(k, bd_right);
    80207048:	fe842783          	lw	a5,-24(s0)
    8020704c:	fd043583          	ld	a1,-48(s0)
    80207050:	853e                	mv	a0,a5
    80207052:	937ff0ef          	jal	ra,80206988 <blk_index>
    80207056:	87aa                	mv	a5,a0
    80207058:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:259
    free += bd_initfree_pair(k, left);
    8020705c:	fe442703          	lw	a4,-28(s0)
    80207060:	fe842783          	lw	a5,-24(s0)
    80207064:	85ba                	mv	a1,a4
    80207066:	853e                	mv	a0,a5
    80207068:	e8bff0ef          	jal	ra,80206ef2 <bd_initfree_pair>
    8020706c:	87aa                	mv	a5,a0
    8020706e:	873e                	mv	a4,a5
    80207070:	fec42783          	lw	a5,-20(s0)
    80207074:	9fb9                	addw	a5,a5,a4
    80207076:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:260
    if (right <= left)
    8020707a:	fe042703          	lw	a4,-32(s0)
    8020707e:	fe442783          	lw	a5,-28(s0)
    80207082:	2701                	sext.w	a4,a4
    80207084:	2781                	sext.w	a5,a5
    80207086:	02e7d263          	bge	a5,a4,802070aa <bd_initfree+0x90>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:262
      continue;
    free += bd_initfree_pair(k, right);
    8020708a:	fe042703          	lw	a4,-32(s0)
    8020708e:	fe842783          	lw	a5,-24(s0)
    80207092:	85ba                	mv	a1,a4
    80207094:	853e                	mv	a0,a5
    80207096:	e5dff0ef          	jal	ra,80206ef2 <bd_initfree_pair>
    8020709a:	87aa                	mv	a5,a0
    8020709c:	873e                	mv	a4,a5
    8020709e:	fec42783          	lw	a5,-20(s0)
    802070a2:	9fb9                	addw	a5,a5,a4
    802070a4:	fef42623          	sw	a5,-20(s0)
    802070a8:	a011                	j	802070ac <bd_initfree+0x92>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:261
      continue;
    802070aa:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:255 (discriminator 2)
  for (int k = 0; k < MAXSIZE; k++)
    802070ac:	fe842783          	lw	a5,-24(s0)
    802070b0:	2785                	addiw	a5,a5,1
    802070b2:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:255 (discriminator 1)
    802070b6:	00b24797          	auipc	a5,0xb24
    802070ba:	f4a78793          	addi	a5,a5,-182 # 80d2b000 <nsizes>
    802070be:	439c                	lw	a5,0(a5)
    802070c0:	37fd                	addiw	a5,a5,-1
    802070c2:	0007871b          	sext.w	a4,a5
    802070c6:	fe842783          	lw	a5,-24(s0)
    802070ca:	2781                	sext.w	a5,a5
    802070cc:	f6e7c4e3          	blt	a5,a4,80207034 <bd_initfree+0x1a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:264
  }
  return free;
    802070d0:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:265
}
    802070d4:	853e                	mv	a0,a5
    802070d6:	70a2                	ld	ra,40(sp)
    802070d8:	7402                	ld	s0,32(sp)
    802070da:	6145                	addi	sp,sp,48
    802070dc:	8082                	ret

00000000802070de <bd_mark_data_structures>:
bd_mark_data_structures():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:269

// 将范围[bd_base,p)标记为已分配
int bd_mark_data_structures(char *p)
{
    802070de:	7179                	addi	sp,sp,-48
    802070e0:	f406                	sd	ra,40(sp)
    802070e2:	f022                	sd	s0,32(sp)
    802070e4:	1800                	addi	s0,sp,48
    802070e6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:270
  int meta = p - (char *)bd_base;
    802070ea:	00b24797          	auipc	a5,0xb24
    802070ee:	f2678793          	addi	a5,a5,-218 # 80d2b010 <bd_base>
    802070f2:	639c                	ld	a5,0(a5)
    802070f4:	fd843703          	ld	a4,-40(s0)
    802070f8:	40f707b3          	sub	a5,a4,a5
    802070fc:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:271
  bd_mark(bd_base, p);
    80207100:	00b24797          	auipc	a5,0xb24
    80207104:	f1078793          	addi	a5,a5,-240 # 80d2b010 <bd_base>
    80207108:	639c                	ld	a5,0(a5)
    8020710a:	fd843583          	ld	a1,-40(s0)
    8020710e:	853e                	mv	a0,a5
    80207110:	cedff0ef          	jal	ra,80206dfc <bd_mark>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:272
  return meta;
    80207114:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:273
}
    80207118:	853e                	mv	a0,a5
    8020711a:	70a2                	ld	ra,40(sp)
    8020711c:	7402                	ld	s0,32(sp)
    8020711e:	6145                	addi	sp,sp,48
    80207120:	8082                	ret

0000000080207122 <bd_mark_unavailable>:
bd_mark_unavailable():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:277

// 将范围[end, HEAPSIZE)标记为已分配
int bd_mark_unavailable(void *end, void *left)
{
    80207122:	7179                	addi	sp,sp,-48
    80207124:	f406                	sd	ra,40(sp)
    80207126:	f022                	sd	s0,32(sp)
    80207128:	1800                	addi	s0,sp,48
    8020712a:	fca43c23          	sd	a0,-40(s0)
    8020712e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:278
  int unavailable = BLK_SIZE(MAXSIZE) - (end - bd_base);
    80207132:	00b24797          	auipc	a5,0xb24
    80207136:	ece78793          	addi	a5,a5,-306 # 80d2b000 <nsizes>
    8020713a:	439c                	lw	a5,0(a5)
    8020713c:	37fd                	addiw	a5,a5,-1
    8020713e:	2781                	sext.w	a5,a5
    80207140:	4741                	li	a4,16
    80207142:	00f717b3          	sll	a5,a4,a5
    80207146:	0007871b          	sext.w	a4,a5
    8020714a:	00b24797          	auipc	a5,0xb24
    8020714e:	ec678793          	addi	a5,a5,-314 # 80d2b010 <bd_base>
    80207152:	639c                	ld	a5,0(a5)
    80207154:	fd843683          	ld	a3,-40(s0)
    80207158:	40f687b3          	sub	a5,a3,a5
    8020715c:	2781                	sext.w	a5,a5
    8020715e:	40f707bb          	subw	a5,a4,a5
    80207162:	2781                	sext.w	a5,a5
    80207164:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:279
  if (unavailable > 0)
    80207168:	fec42783          	lw	a5,-20(s0)
    8020716c:	2781                	sext.w	a5,a5
    8020716e:	02f05463          	blez	a5,80207196 <bd_mark_unavailable+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:280
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    80207172:	fec42783          	lw	a5,-20(s0)
    80207176:	37fd                	addiw	a5,a5,-1
    80207178:	2781                	sext.w	a5,a5
    8020717a:	41f7d71b          	sraiw	a4,a5,0x1f
    8020717e:	01c7571b          	srliw	a4,a4,0x1c
    80207182:	9fb9                	addw	a5,a5,a4
    80207184:	4047d79b          	sraiw	a5,a5,0x4
    80207188:	2781                	sext.w	a5,a5
    8020718a:	2785                	addiw	a5,a5,1
    8020718c:	2781                	sext.w	a5,a5
    8020718e:	0047979b          	slliw	a5,a5,0x4
    80207192:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:282

  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    80207196:	00b24797          	auipc	a5,0xb24
    8020719a:	e7a78793          	addi	a5,a5,-390 # 80d2b010 <bd_base>
    8020719e:	6398                	ld	a4,0(a5)
    802071a0:	00b24797          	auipc	a5,0xb24
    802071a4:	e6078793          	addi	a5,a5,-416 # 80d2b000 <nsizes>
    802071a8:	439c                	lw	a5,0(a5)
    802071aa:	37fd                	addiw	a5,a5,-1
    802071ac:	2781                	sext.w	a5,a5
    802071ae:	46c1                	li	a3,16
    802071b0:	00f697b3          	sll	a5,a3,a5
    802071b4:	86be                	mv	a3,a5
    802071b6:	fec42783          	lw	a5,-20(s0)
    802071ba:	40f687b3          	sub	a5,a3,a5
    802071be:	97ba                	add	a5,a5,a4
    802071c0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:283
  bd_mark(bd_end, bd_base + BLK_SIZE(MAXSIZE));
    802071c4:	00b24797          	auipc	a5,0xb24
    802071c8:	e4c78793          	addi	a5,a5,-436 # 80d2b010 <bd_base>
    802071cc:	639c                	ld	a5,0(a5)
    802071ce:	00b24717          	auipc	a4,0xb24
    802071d2:	e3270713          	addi	a4,a4,-462 # 80d2b000 <nsizes>
    802071d6:	4318                	lw	a4,0(a4)
    802071d8:	377d                	addiw	a4,a4,-1
    802071da:	2701                	sext.w	a4,a4
    802071dc:	46c1                	li	a3,16
    802071de:	00e69733          	sll	a4,a3,a4
    802071e2:	97ba                	add	a5,a5,a4
    802071e4:	85be                	mv	a1,a5
    802071e6:	fe043503          	ld	a0,-32(s0)
    802071ea:	c13ff0ef          	jal	ra,80206dfc <bd_mark>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:284
  return unavailable;
    802071ee:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:285
}
    802071f2:	853e                	mv	a0,a5
    802071f4:	70a2                	ld	ra,40(sp)
    802071f6:	7402                	ld	s0,32(sp)
    802071f8:	6145                	addi	sp,sp,48
    802071fa:	8082                	ret

00000000802071fc <bd_init>:
bd_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:289

// 初始化buddy分配器：它管理来自[base, end)的内存。
void bd_init(void *base, void *end)
{
    802071fc:	715d                	addi	sp,sp,-80
    802071fe:	e486                	sd	ra,72(sp)
    80207200:	e0a2                	sd	s0,64(sp)
    80207202:	0880                	addi	s0,sp,80
    80207204:	faa43c23          	sd	a0,-72(s0)
    80207208:	fab43823          	sd	a1,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:290
  char *p = (char *)ROUNDUP((uint64_t)base, LEAF_SIZE);
    8020720c:	fb843783          	ld	a5,-72(s0)
    80207210:	17fd                	addi	a5,a5,-1
    80207212:	8391                	srli	a5,a5,0x4
    80207214:	0785                	addi	a5,a5,1
    80207216:	0792                	slli	a5,a5,0x4
    80207218:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:294
  int sz;

  // initlock(&lock, "buddy");
  bd_base = (void *)p;
    8020721c:	00b24797          	auipc	a5,0xb24
    80207220:	df478793          	addi	a5,a5,-524 # 80d2b010 <bd_base>
    80207224:	fe843703          	ld	a4,-24(s0)
    80207228:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:297

  // 计算我们需要管理的大小数量[base, end)
  nsizes = _log2(((char *)end - p) / LEAF_SIZE) + 1;
    8020722a:	fb043703          	ld	a4,-80(s0)
    8020722e:	fe843783          	ld	a5,-24(s0)
    80207232:	40f707b3          	sub	a5,a4,a5
    80207236:	43f7d713          	srai	a4,a5,0x3f
    8020723a:	8b3d                	andi	a4,a4,15
    8020723c:	97ba                	add	a5,a5,a4
    8020723e:	8791                	srai	a5,a5,0x4
    80207240:	853e                	mv	a0,a5
    80207242:	b81ff0ef          	jal	ra,80206dc2 <_log2>
    80207246:	87aa                	mv	a5,a0
    80207248:	2785                	addiw	a5,a5,1
    8020724a:	0007871b          	sext.w	a4,a5
    8020724e:	00b24797          	auipc	a5,0xb24
    80207252:	db278793          	addi	a5,a5,-590 # 80d2b000 <nsizes>
    80207256:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:298
  if ((char *)end - p > BLK_SIZE(MAXSIZE))
    80207258:	fb043703          	ld	a4,-80(s0)
    8020725c:	fe843783          	ld	a5,-24(s0)
    80207260:	8f1d                	sub	a4,a4,a5
    80207262:	00b24797          	auipc	a5,0xb24
    80207266:	d9e78793          	addi	a5,a5,-610 # 80d2b000 <nsizes>
    8020726a:	439c                	lw	a5,0(a5)
    8020726c:	37fd                	addiw	a5,a5,-1
    8020726e:	2781                	sext.w	a5,a5
    80207270:	46c1                	li	a3,16
    80207272:	00f697b3          	sll	a5,a3,a5
    80207276:	00e7df63          	bge	a5,a4,80207294 <bd_init+0x98>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:300
  {
    nsizes++; // 向上取整到下一个2的幂
    8020727a:	00b24797          	auipc	a5,0xb24
    8020727e:	d8678793          	addi	a5,a5,-634 # 80d2b000 <nsizes>
    80207282:	439c                	lw	a5,0(a5)
    80207284:	2785                	addiw	a5,a5,1
    80207286:	0007871b          	sext.w	a4,a5
    8020728a:	00b24797          	auipc	a5,0xb24
    8020728e:	d7678793          	addi	a5,a5,-650 # 80d2b000 <nsizes>
    80207292:	c398                	sw	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:304
  }

  // 分配bd_sizes数组
  bd_sizes = (Sz_info *)p;
    80207294:	00b24797          	auipc	a5,0xb24
    80207298:	d7478793          	addi	a5,a5,-652 # 80d2b008 <bd_sizes>
    8020729c:	fe843703          	ld	a4,-24(s0)
    802072a0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:305
  p += sizeof(Sz_info) * nsizes;
    802072a2:	00b24797          	auipc	a5,0xb24
    802072a6:	d5e78793          	addi	a5,a5,-674 # 80d2b000 <nsizes>
    802072aa:	439c                	lw	a5,0(a5)
    802072ac:	0796                	slli	a5,a5,0x5
    802072ae:	fe843703          	ld	a4,-24(s0)
    802072b2:	97ba                	add	a5,a5,a4
    802072b4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:306
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    802072b8:	00b24797          	auipc	a5,0xb24
    802072bc:	d5078793          	addi	a5,a5,-688 # 80d2b008 <bd_sizes>
    802072c0:	6398                	ld	a4,0(a5)
    802072c2:	00b24797          	auipc	a5,0xb24
    802072c6:	d3e78793          	addi	a5,a5,-706 # 80d2b000 <nsizes>
    802072ca:	439c                	lw	a5,0(a5)
    802072cc:	2781                	sext.w	a5,a5
    802072ce:	0057979b          	slliw	a5,a5,0x5
    802072d2:	2781                	sext.w	a5,a5
    802072d4:	863e                	mv	a2,a5
    802072d6:	4581                	li	a1,0
    802072d8:	853a                	mv	a0,a4
    802072da:	d62fd0ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:309

  // 初始化空闲列表并为每个大小k分配alloc数组
  for (int k = 0; k < nsizes; k++)
    802072de:	fe042223          	sw	zero,-28(s0)
    802072e2:	a84d                	j	80207394 <bd_init+0x198>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:311 (discriminator 3)
  {
    lst_init(&bd_sizes[k].free);
    802072e4:	00b24797          	auipc	a5,0xb24
    802072e8:	d2478793          	addi	a5,a5,-732 # 80d2b008 <bd_sizes>
    802072ec:	6398                	ld	a4,0(a5)
    802072ee:	fe442783          	lw	a5,-28(s0)
    802072f2:	0796                	slli	a5,a5,0x5
    802072f4:	97ba                	add	a5,a5,a4
    802072f6:	853e                	mv	a0,a5
    802072f8:	418020ef          	jal	ra,80209710 <lst_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:312 (discriminator 3)
    sz = sizeof(char) * ROUNDUP(NBLK(k), 8) / 8;
    802072fc:	00b24797          	auipc	a5,0xb24
    80207300:	d0478793          	addi	a5,a5,-764 # 80d2b000 <nsizes>
    80207304:	439c                	lw	a5,0(a5)
    80207306:	37fd                	addiw	a5,a5,-1
    80207308:	0007871b          	sext.w	a4,a5
    8020730c:	fe442783          	lw	a5,-28(s0)
    80207310:	40f707bb          	subw	a5,a4,a5
    80207314:	2781                	sext.w	a5,a5
    80207316:	4705                	li	a4,1
    80207318:	00f717bb          	sllw	a5,a4,a5
    8020731c:	2781                	sext.w	a5,a5
    8020731e:	37fd                	addiw	a5,a5,-1
    80207320:	2781                	sext.w	a5,a5
    80207322:	41f7d71b          	sraiw	a4,a5,0x1f
    80207326:	01d7571b          	srliw	a4,a4,0x1d
    8020732a:	9fb9                	addw	a5,a5,a4
    8020732c:	4037d79b          	sraiw	a5,a5,0x3
    80207330:	2781                	sext.w	a5,a5
    80207332:	2785                	addiw	a5,a5,1
    80207334:	2781                	sext.w	a5,a5
    80207336:	0037979b          	slliw	a5,a5,0x3
    8020733a:	2781                	sext.w	a5,a5
    8020733c:	838d                	srli	a5,a5,0x3
    8020733e:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:313 (discriminator 3)
    bd_sizes[k].alloc = p;
    80207342:	00b24797          	auipc	a5,0xb24
    80207346:	cc678793          	addi	a5,a5,-826 # 80d2b008 <bd_sizes>
    8020734a:	6398                	ld	a4,0(a5)
    8020734c:	fe442783          	lw	a5,-28(s0)
    80207350:	0796                	slli	a5,a5,0x5
    80207352:	97ba                	add	a5,a5,a4
    80207354:	fe843703          	ld	a4,-24(s0)
    80207358:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:314 (discriminator 3)
    memset(bd_sizes[k].alloc, 0, sz);
    8020735a:	00b24797          	auipc	a5,0xb24
    8020735e:	cae78793          	addi	a5,a5,-850 # 80d2b008 <bd_sizes>
    80207362:	6398                	ld	a4,0(a5)
    80207364:	fe442783          	lw	a5,-28(s0)
    80207368:	0796                	slli	a5,a5,0x5
    8020736a:	97ba                	add	a5,a5,a4
    8020736c:	6b9c                	ld	a5,16(a5)
    8020736e:	fc842703          	lw	a4,-56(s0)
    80207372:	863a                	mv	a2,a4
    80207374:	4581                	li	a1,0
    80207376:	853e                	mv	a0,a5
    80207378:	cc4fd0ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:315 (discriminator 3)
    p += sz;
    8020737c:	fc842783          	lw	a5,-56(s0)
    80207380:	fe843703          	ld	a4,-24(s0)
    80207384:	97ba                	add	a5,a5,a4
    80207386:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:309 (discriminator 3)
  for (int k = 0; k < nsizes; k++)
    8020738a:	fe442783          	lw	a5,-28(s0)
    8020738e:	2785                	addiw	a5,a5,1
    80207390:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:309 (discriminator 1)
    80207394:	00b24797          	auipc	a5,0xb24
    80207398:	c6c78793          	addi	a5,a5,-916 # 80d2b000 <nsizes>
    8020739c:	4398                	lw	a4,0(a5)
    8020739e:	fe442783          	lw	a5,-28(s0)
    802073a2:	2781                	sext.w	a5,a5
    802073a4:	f4e7c0e3          	blt	a5,a4,802072e4 <bd_init+0xe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:319
  }

  // 为每个大小k分配split数组，除了k=0，因为我们不会分割大小为k=0的最小块。
  for (int k = 1; k < nsizes; k++)
    802073a8:	4785                	li	a5,1
    802073aa:	fef42023          	sw	a5,-32(s0)
    802073ae:	a869                	j	80207448 <bd_init+0x24c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:321 (discriminator 3)
  {
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    802073b0:	00b24797          	auipc	a5,0xb24
    802073b4:	c5078793          	addi	a5,a5,-944 # 80d2b000 <nsizes>
    802073b8:	439c                	lw	a5,0(a5)
    802073ba:	37fd                	addiw	a5,a5,-1
    802073bc:	0007871b          	sext.w	a4,a5
    802073c0:	fe042783          	lw	a5,-32(s0)
    802073c4:	40f707bb          	subw	a5,a4,a5
    802073c8:	2781                	sext.w	a5,a5
    802073ca:	4705                	li	a4,1
    802073cc:	00f717bb          	sllw	a5,a4,a5
    802073d0:	2781                	sext.w	a5,a5
    802073d2:	37fd                	addiw	a5,a5,-1
    802073d4:	2781                	sext.w	a5,a5
    802073d6:	41f7d71b          	sraiw	a4,a5,0x1f
    802073da:	01d7571b          	srliw	a4,a4,0x1d
    802073de:	9fb9                	addw	a5,a5,a4
    802073e0:	4037d79b          	sraiw	a5,a5,0x3
    802073e4:	2781                	sext.w	a5,a5
    802073e6:	2785                	addiw	a5,a5,1
    802073e8:	2781                	sext.w	a5,a5
    802073ea:	0037979b          	slliw	a5,a5,0x3
    802073ee:	2781                	sext.w	a5,a5
    802073f0:	838d                	srli	a5,a5,0x3
    802073f2:	fcf42423          	sw	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:322 (discriminator 3)
    bd_sizes[k].split = p;
    802073f6:	00b24797          	auipc	a5,0xb24
    802073fa:	c1278793          	addi	a5,a5,-1006 # 80d2b008 <bd_sizes>
    802073fe:	6398                	ld	a4,0(a5)
    80207400:	fe042783          	lw	a5,-32(s0)
    80207404:	0796                	slli	a5,a5,0x5
    80207406:	97ba                	add	a5,a5,a4
    80207408:	fe843703          	ld	a4,-24(s0)
    8020740c:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:323 (discriminator 3)
    memset(bd_sizes[k].split, 0, sz);
    8020740e:	00b24797          	auipc	a5,0xb24
    80207412:	bfa78793          	addi	a5,a5,-1030 # 80d2b008 <bd_sizes>
    80207416:	6398                	ld	a4,0(a5)
    80207418:	fe042783          	lw	a5,-32(s0)
    8020741c:	0796                	slli	a5,a5,0x5
    8020741e:	97ba                	add	a5,a5,a4
    80207420:	6f9c                	ld	a5,24(a5)
    80207422:	fc842703          	lw	a4,-56(s0)
    80207426:	863a                	mv	a2,a4
    80207428:	4581                	li	a1,0
    8020742a:	853e                	mv	a0,a5
    8020742c:	c10fd0ef          	jal	ra,8020483c <memset>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:324 (discriminator 3)
    p += sz;
    80207430:	fc842783          	lw	a5,-56(s0)
    80207434:	fe843703          	ld	a4,-24(s0)
    80207438:	97ba                	add	a5,a5,a4
    8020743a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:319 (discriminator 3)
  for (int k = 1; k < nsizes; k++)
    8020743e:	fe042783          	lw	a5,-32(s0)
    80207442:	2785                	addiw	a5,a5,1
    80207444:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:319 (discriminator 1)
    80207448:	00b24797          	auipc	a5,0xb24
    8020744c:	bb878793          	addi	a5,a5,-1096 # 80d2b000 <nsizes>
    80207450:	4398                	lw	a4,0(a5)
    80207452:	fe042783          	lw	a5,-32(s0)
    80207456:	2781                	sext.w	a5,a5
    80207458:	f4e7cce3          	blt	a5,a4,802073b0 <bd_init+0x1b4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:326
  }
  p = (char *)ROUNDUP((uint64_t)p, LEAF_SIZE);
    8020745c:	fe843783          	ld	a5,-24(s0)
    80207460:	17fd                	addi	a5,a5,-1
    80207462:	8391                	srli	a5,a5,0x4
    80207464:	0785                	addi	a5,a5,1
    80207466:	0792                	slli	a5,a5,0x4
    80207468:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:329

  // 完成分配；将内存范围[base, p)标记为已分配，以便buddy不会分配这些内存。
  int meta = bd_mark_data_structures(p);
    8020746c:	fe843503          	ld	a0,-24(s0)
    80207470:	c6fff0ef          	jal	ra,802070de <bd_mark_data_structures>
    80207474:	87aa                	mv	a5,a0
    80207476:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:332

  // 将不可用的内存范围[end, HEAP_SIZE)标记为已分配，以便buddy不会分配这些内存。
  int unavailable = bd_mark_unavailable(end, p);
    8020747a:	fe843583          	ld	a1,-24(s0)
    8020747e:	fb043503          	ld	a0,-80(s0)
    80207482:	ca1ff0ef          	jal	ra,80207122 <bd_mark_unavailable>
    80207486:	87aa                	mv	a5,a0
    80207488:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:333
  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    8020748c:	00b24797          	auipc	a5,0xb24
    80207490:	b8478793          	addi	a5,a5,-1148 # 80d2b010 <bd_base>
    80207494:	6398                	ld	a4,0(a5)
    80207496:	00b24797          	auipc	a5,0xb24
    8020749a:	b6a78793          	addi	a5,a5,-1174 # 80d2b000 <nsizes>
    8020749e:	439c                	lw	a5,0(a5)
    802074a0:	37fd                	addiw	a5,a5,-1
    802074a2:	2781                	sext.w	a5,a5
    802074a4:	46c1                	li	a3,16
    802074a6:	00f697b3          	sll	a5,a3,a5
    802074aa:	86be                	mv	a3,a5
    802074ac:	fd842783          	lw	a5,-40(s0)
    802074b0:	40f687b3          	sub	a5,a3,a5
    802074b4:	97ba                	add	a5,a5,a4
    802074b6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:336

  // 为每个大小k初始化空闲列表
  int free = bd_initfree(p, bd_end);
    802074ba:	fd043583          	ld	a1,-48(s0)
    802074be:	fe843503          	ld	a0,-24(s0)
    802074c2:	b59ff0ef          	jal	ra,8020701a <bd_initfree>
    802074c6:	87aa                	mv	a5,a0
    802074c8:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:339

  // 检查空闲的内存量是否符合预期
  if (free != BLK_SIZE(MAXSIZE) - meta - unavailable)
    802074cc:	fcc42703          	lw	a4,-52(s0)
    802074d0:	00b24797          	auipc	a5,0xb24
    802074d4:	b3078793          	addi	a5,a5,-1232 # 80d2b000 <nsizes>
    802074d8:	439c                	lw	a5,0(a5)
    802074da:	37fd                	addiw	a5,a5,-1
    802074dc:	2781                	sext.w	a5,a5
    802074de:	46c1                	li	a3,16
    802074e0:	00f696b3          	sll	a3,a3,a5
    802074e4:	fdc42783          	lw	a5,-36(s0)
    802074e8:	8e9d                	sub	a3,a3,a5
    802074ea:	fd842783          	lw	a5,-40(s0)
    802074ee:	40f687b3          	sub	a5,a3,a5
    802074f2:	00f70e63          	beq	a4,a5,8020750e <bd_init+0x312>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:341
  {
    panic("bd_init: free mem\n");
    802074f6:	00003617          	auipc	a2,0x3
    802074fa:	1c260613          	addi	a2,a2,450 # 8020a6b8 <MMIO+0x40>
    802074fe:	15500593          	li	a1,341
    80207502:	00003517          	auipc	a0,0x3
    80207506:	19650513          	addi	a0,a0,406 # 8020a698 <MMIO+0x20>
    8020750a:	2d2000ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/memory/buddy/buddy.c:343
  }
}
    8020750e:	0001                	nop
    80207510:	60a6                	ld	ra,72(sp)
    80207512:	6406                	ld	s0,64(sp)
    80207514:	6161                	addi	sp,sp,80
    80207516:	8082                	ret

0000000080207518 <print_str>:
print_str():
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:3
#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    80207518:	1101                	addi	sp,sp,-32
    8020751a:	ec06                	sd	ra,24(sp)
    8020751c:	e822                	sd	s0,16(sp)
    8020751e:	1000                	addi	s0,sp,32
    80207520:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:4
    while (*str) 
    80207524:	a829                	j	8020753e <print_str+0x26>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:6
    {
        console_putchar((uint64_t)(*str));
    80207526:	fe843783          	ld	a5,-24(s0)
    8020752a:	0007c783          	lbu	a5,0(a5)
    8020752e:	853e                	mv	a0,a5
    80207530:	e69fc0ef          	jal	ra,80204398 <console_putchar>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:7
        str++;
    80207534:	fe843783          	ld	a5,-24(s0)
    80207538:	0785                	addi	a5,a5,1
    8020753a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:4
    while (*str) 
    8020753e:	fe843783          	ld	a5,-24(s0)
    80207542:	0007c783          	lbu	a5,0(a5)
    80207546:	f3e5                	bnez	a5,80207526 <print_str+0xe>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:9
    }
}
    80207548:	0001                	nop
    8020754a:	0001                	nop
    8020754c:	60e2                	ld	ra,24(sp)
    8020754e:	6442                	ld	s0,16(sp)
    80207550:	6105                	addi	sp,sp,32
    80207552:	8082                	ret

0000000080207554 <reverse_str>:
reverse_str():
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:11

void reverse_str(char* str, int length) {
    80207554:	7179                	addi	sp,sp,-48
    80207556:	f422                	sd	s0,40(sp)
    80207558:	1800                	addi	s0,sp,48
    8020755a:	fca43c23          	sd	a0,-40(s0)
    8020755e:	87ae                	mv	a5,a1
    80207560:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:12
    int start = 0;
    80207564:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:13
    int end = length - 1;
    80207568:	fd442783          	lw	a5,-44(s0)
    8020756c:	37fd                	addiw	a5,a5,-1
    8020756e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:14
    while (start < end) {
    80207572:	a899                	j	802075c8 <reverse_str+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:15
        char temp = str[start];
    80207574:	fec42783          	lw	a5,-20(s0)
    80207578:	fd843703          	ld	a4,-40(s0)
    8020757c:	97ba                	add	a5,a5,a4
    8020757e:	0007c783          	lbu	a5,0(a5)
    80207582:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:16
        str[start] = str[end];
    80207586:	fe842783          	lw	a5,-24(s0)
    8020758a:	fd843703          	ld	a4,-40(s0)
    8020758e:	973e                	add	a4,a4,a5
    80207590:	fec42783          	lw	a5,-20(s0)
    80207594:	fd843683          	ld	a3,-40(s0)
    80207598:	97b6                	add	a5,a5,a3
    8020759a:	00074703          	lbu	a4,0(a4)
    8020759e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:17
        str[end] = temp;
    802075a2:	fe842783          	lw	a5,-24(s0)
    802075a6:	fd843703          	ld	a4,-40(s0)
    802075aa:	97ba                	add	a5,a5,a4
    802075ac:	fe744703          	lbu	a4,-25(s0)
    802075b0:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:18
        start++;
    802075b4:	fec42783          	lw	a5,-20(s0)
    802075b8:	2785                	addiw	a5,a5,1
    802075ba:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:19
        end--;
    802075be:	fe842783          	lw	a5,-24(s0)
    802075c2:	37fd                	addiw	a5,a5,-1
    802075c4:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:14
    while (start < end) {
    802075c8:	fec42703          	lw	a4,-20(s0)
    802075cc:	fe842783          	lw	a5,-24(s0)
    802075d0:	2701                	sext.w	a4,a4
    802075d2:	2781                	sext.w	a5,a5
    802075d4:	faf740e3          	blt	a4,a5,80207574 <reverse_str+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:21
    }
}
    802075d8:	0001                	nop
    802075da:	0001                	nop
    802075dc:	7422                	ld	s0,40(sp)
    802075de:	6145                	addi	sp,sp,48
    802075e0:	8082                	ret

00000000802075e2 <print_uint32>:
print_uint32():
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:23

void print_uint32(uint32_t value) {
    802075e2:	7139                	addi	sp,sp,-64
    802075e4:	fc06                	sd	ra,56(sp)
    802075e6:	f822                	sd	s0,48(sp)
    802075e8:	0080                	addi	s0,sp,64
    802075ea:	87aa                	mv	a5,a0
    802075ec:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:25
    char buffer[12];
    int i = 0;
    802075f0:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:26
    if (value == 0) {
    802075f4:	fcc42783          	lw	a5,-52(s0)
    802075f8:	2781                	sext.w	a5,a5
    802075fa:	e3ad                	bnez	a5,8020765c <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:27
        buffer[i++] = '0';
    802075fc:	fec42783          	lw	a5,-20(s0)
    80207600:	0017871b          	addiw	a4,a5,1
    80207604:	fee42623          	sw	a4,-20(s0)
    80207608:	ff040713          	addi	a4,s0,-16
    8020760c:	97ba                	add	a5,a5,a4
    8020760e:	03000713          	li	a4,48
    80207612:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:29
    }
    while (value != 0) {
    80207616:	a099                	j	8020765c <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:30
        int digit = value % 10;
    80207618:	fcc42703          	lw	a4,-52(s0)
    8020761c:	47a9                	li	a5,10
    8020761e:	02f777bb          	remuw	a5,a4,a5
    80207622:	2781                	sext.w	a5,a5
    80207624:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:31
        buffer[i++] = digit + '0';
    80207628:	fe842783          	lw	a5,-24(s0)
    8020762c:	0ff7f713          	andi	a4,a5,255
    80207630:	fec42783          	lw	a5,-20(s0)
    80207634:	0017869b          	addiw	a3,a5,1
    80207638:	fed42623          	sw	a3,-20(s0)
    8020763c:	0307071b          	addiw	a4,a4,48
    80207640:	0ff77713          	andi	a4,a4,255
    80207644:	ff040693          	addi	a3,s0,-16
    80207648:	97b6                	add	a5,a5,a3
    8020764a:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:32
        value /= 10;
    8020764e:	fcc42703          	lw	a4,-52(s0)
    80207652:	47a9                	li	a5,10
    80207654:	02f757bb          	divuw	a5,a4,a5
    80207658:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:29
    while (value != 0) {
    8020765c:	fcc42783          	lw	a5,-52(s0)
    80207660:	2781                	sext.w	a5,a5
    80207662:	fbdd                	bnez	a5,80207618 <print_uint32+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:34
    }
    buffer[i] = '\0';
    80207664:	fec42783          	lw	a5,-20(s0)
    80207668:	ff040713          	addi	a4,s0,-16
    8020766c:	97ba                	add	a5,a5,a4
    8020766e:	fe078423          	sb	zero,-24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:35
    reverse_str(buffer, i);
    80207672:	fec42703          	lw	a4,-20(s0)
    80207676:	fd840793          	addi	a5,s0,-40
    8020767a:	85ba                	mv	a1,a4
    8020767c:	853e                	mv	a0,a5
    8020767e:	ed7ff0ef          	jal	ra,80207554 <reverse_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:36
    print_str(buffer);
    80207682:	fd840793          	addi	a5,s0,-40
    80207686:	853e                	mv	a0,a5
    80207688:	e91ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:37
}
    8020768c:	0001                	nop
    8020768e:	70e2                	ld	ra,56(sp)
    80207690:	7442                	ld	s0,48(sp)
    80207692:	6121                	addi	sp,sp,64
    80207694:	8082                	ret

0000000080207696 <print_uint64>:
print_uint64():
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:40

void print_uint64(uint64_t value) 
{
    80207696:	7139                	addi	sp,sp,-64
    80207698:	fc06                	sd	ra,56(sp)
    8020769a:	f822                	sd	s0,48(sp)
    8020769c:	0080                	addi	s0,sp,64
    8020769e:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:42
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    802076a2:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:43
    if (value == 0) 
    802076a6:	fc843783          	ld	a5,-56(s0)
    802076aa:	e3a5                	bnez	a5,8020770a <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:45
    {
        buffer[i++] = '0';
    802076ac:	fec42783          	lw	a5,-20(s0)
    802076b0:	0017871b          	addiw	a4,a5,1
    802076b4:	fee42623          	sw	a4,-20(s0)
    802076b8:	ff040713          	addi	a4,s0,-16
    802076bc:	97ba                	add	a5,a5,a4
    802076be:	03000713          	li	a4,48
    802076c2:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:47
    }
    while (value != 0) 
    802076c6:	a091                	j	8020770a <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:49
    {
        int digit = value % 10;
    802076c8:	fc843703          	ld	a4,-56(s0)
    802076cc:	47a9                	li	a5,10
    802076ce:	02f777b3          	remu	a5,a4,a5
    802076d2:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:50
        buffer[i++] = digit + '0';
    802076d6:	fe842783          	lw	a5,-24(s0)
    802076da:	0ff7f713          	andi	a4,a5,255
    802076de:	fec42783          	lw	a5,-20(s0)
    802076e2:	0017869b          	addiw	a3,a5,1
    802076e6:	fed42623          	sw	a3,-20(s0)
    802076ea:	0307071b          	addiw	a4,a4,48
    802076ee:	0ff77713          	andi	a4,a4,255
    802076f2:	ff040693          	addi	a3,s0,-16
    802076f6:	97b6                	add	a5,a5,a3
    802076f8:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:51
        value /= 10;
    802076fc:	fc843703          	ld	a4,-56(s0)
    80207700:	47a9                	li	a5,10
    80207702:	02f757b3          	divu	a5,a4,a5
    80207706:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:47
    while (value != 0) 
    8020770a:	fc843783          	ld	a5,-56(s0)
    8020770e:	ffcd                	bnez	a5,802076c8 <print_uint64+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:53
    }
    buffer[i] = '\0';
    80207710:	fec42783          	lw	a5,-20(s0)
    80207714:	ff040713          	addi	a4,s0,-16
    80207718:	97ba                	add	a5,a5,a4
    8020771a:	fe078023          	sb	zero,-32(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:54
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    8020771e:	fec42703          	lw	a4,-20(s0)
    80207722:	fd040793          	addi	a5,s0,-48
    80207726:	85ba                	mv	a1,a4
    80207728:	853e                	mv	a0,a5
    8020772a:	e2bff0ef          	jal	ra,80207554 <reverse_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:55
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
    8020772e:	fd040793          	addi	a5,s0,-48
    80207732:	853e                	mv	a0,a5
    80207734:	de5ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:56
}
    80207738:	0001                	nop
    8020773a:	70e2                	ld	ra,56(sp)
    8020773c:	7442                	ld	s0,48(sp)
    8020773e:	6121                	addi	sp,sp,64
    80207740:	8082                	ret

0000000080207742 <print_uint64_hex>:
print_uint64_hex():
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:59

void print_uint64_hex(uint64_t value) 
{
    80207742:	7179                	addi	sp,sp,-48
    80207744:	f406                	sd	ra,40(sp)
    80207746:	f022                	sd	s0,32(sp)
    80207748:	1800                	addi	s0,sp,48
    8020774a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:60
    print_str("0x"); // 打印十六进制前缀
    8020774e:	00003517          	auipc	a0,0x3
    80207752:	f8250513          	addi	a0,a0,-126 # 8020a6d0 <MMIO+0x58>
    80207756:	dc3ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:61
    for (int i = 15; i >= 0; i--) 
    8020775a:	47bd                	li	a5,15
    8020775c:	fef42623          	sw	a5,-20(s0)
    80207760:	a09d                	j	802077c6 <print_uint64_hex+0x84>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:63
    {
        int digit = (value >> (i * 4)) & 0xF; // 获取每个十六进制位
    80207762:	fec42783          	lw	a5,-20(s0)
    80207766:	0027979b          	slliw	a5,a5,0x2
    8020776a:	2781                	sext.w	a5,a5
    8020776c:	873e                	mv	a4,a5
    8020776e:	fd843783          	ld	a5,-40(s0)
    80207772:	00e7d7b3          	srl	a5,a5,a4
    80207776:	2781                	sext.w	a5,a5
    80207778:	8bbd                	andi	a5,a5,15
    8020777a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:64
        char hex = digit < 10 ? '0' + digit : 'A' + digit - 10; // 转换为字符
    8020777e:	fe842783          	lw	a5,-24(s0)
    80207782:	0007871b          	sext.w	a4,a5
    80207786:	47a5                	li	a5,9
    80207788:	00e7cb63          	blt	a5,a4,8020779e <print_uint64_hex+0x5c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:64 (discriminator 1)
    8020778c:	fe842783          	lw	a5,-24(s0)
    80207790:	0ff7f793          	andi	a5,a5,255
    80207794:	0307879b          	addiw	a5,a5,48
    80207798:	0ff7f793          	andi	a5,a5,255
    8020779c:	a809                	j	802077ae <print_uint64_hex+0x6c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:64 (discriminator 2)
    8020779e:	fe842783          	lw	a5,-24(s0)
    802077a2:	0ff7f793          	andi	a5,a5,255
    802077a6:	0377879b          	addiw	a5,a5,55
    802077aa:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:64 (discriminator 4)
    802077ae:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:65 (discriminator 4)
        console_putchar((uint64_t)hex); // 输出字符
    802077b2:	fe744783          	lbu	a5,-25(s0)
    802077b6:	853e                	mv	a0,a5
    802077b8:	be1fc0ef          	jal	ra,80204398 <console_putchar>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:61 (discriminator 4)
    for (int i = 15; i >= 0; i--) 
    802077bc:	fec42783          	lw	a5,-20(s0)
    802077c0:	37fd                	addiw	a5,a5,-1
    802077c2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:61 (discriminator 2)
    802077c6:	fec42783          	lw	a5,-20(s0)
    802077ca:	2781                	sext.w	a5,a5
    802077cc:	f807dbe3          	bgez	a5,80207762 <print_uint64_hex+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/console/console.c:67
    }
    802077d0:	0001                	nop
    802077d2:	0001                	nop
    802077d4:	70a2                	ld	ra,40(sp)
    802077d6:	7402                	ld	s0,32(sp)
    802077d8:	6145                	addi	sp,sp,48
    802077da:	8082                	ret

00000000802077dc <_panic>:
_panic():
/home/caigoubencai/Desktop/os_c-ch6/kernel/debug/debug.c:5
#include "console.h"
#include "sbi.h"
// panic函数现在接收文件名和行号作为参数
void _panic(const char *file, int line, const char *msg)
{
    802077dc:	7179                	addi	sp,sp,-48
    802077de:	f406                	sd	ra,40(sp)
    802077e0:	f022                	sd	s0,32(sp)
    802077e2:	1800                	addi	s0,sp,48
    802077e4:	fea43423          	sd	a0,-24(s0)
    802077e8:	87ae                	mv	a5,a1
    802077ea:	fcc43c23          	sd	a2,-40(s0)
    802077ee:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/debug/debug.c:6
    printk("PANIC in %s at line %d: %s\n", file, line, msg);
    802077f2:	fe442783          	lw	a5,-28(s0)
    802077f6:	fd843683          	ld	a3,-40(s0)
    802077fa:	863e                	mv	a2,a5
    802077fc:	fe843583          	ld	a1,-24(s0)
    80207800:	00003517          	auipc	a0,0x3
    80207804:	ed850513          	addi	a0,a0,-296 # 8020a6d8 <MMIO+0x60>
    80207808:	fe3fa0ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/debug/debug.c:7
    sbi_shutdown();
    8020780c:	bd3fc0ef          	jal	ra,802043de <sbi_shutdown>
/home/caigoubencai/Desktop/os_c-ch6/kernel/debug/debug.c:8
}
    80207810:	0001                	nop
    80207812:	70a2                	ld	ra,40(sp)
    80207814:	7402                	ld	s0,32(sp)
    80207816:	6145                	addi	sp,sp,48
    80207818:	8082                	ret

000000008020781a <task_control_block_get_trap_cx>:
task_control_block_get_trap_cx():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:18
struct TaskControlBlock INITPROC;
extern void __switch(struct TaskContext **, struct TaskContext **);
extern uint64_t _num_app[];

struct TrapContext *task_control_block_get_trap_cx(struct TaskControlBlock *s)
{
    8020781a:	1101                	addi	sp,sp,-32
    8020781c:	ec22                	sd	s0,24(sp)
    8020781e:	1000                	addi	s0,sp,32
    80207820:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:19
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
    80207824:	fe843783          	ld	a5,-24(s0)
    80207828:	6b9c                	ld	a5,16(a5)
    8020782a:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:20
}
    8020782c:	853e                	mv	a0,a5
    8020782e:	6462                	ld	s0,24(sp)
    80207830:	6105                	addi	sp,sp,32
    80207832:	8082                	ret

0000000080207834 <run_next_task>:
run_next_task():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:35
//   //printk("task_manager_init_end\n");
//   TASK_MANAGER.current_task = 0;
// }

void run_next_task(uint64_t status)
{
    80207834:	1101                	addi	sp,sp,-32
    80207836:	ec06                	sd	ra,24(sp)
    80207838:	e822                	sd	s0,16(sp)
    8020783a:	1000                	addi	s0,sp,32
    8020783c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:36
  ASSERT(0);
    80207840:	00003617          	auipc	a2,0x3
    80207844:	ec860613          	addi	a2,a2,-312 # 8020a708 <MMIO+0x10>
    80207848:	02400593          	li	a1,36
    8020784c:	00003517          	auipc	a0,0x3
    80207850:	ed450513          	addi	a0,a0,-300 # 8020a720 <MMIO+0x28>
    80207854:	f89ff0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:57
  // // 改变状态
  // current_task_tcb->task_status = status;
  // target_task_tcb->task_status = Running;
  // TASK_MANAGER.current_task = target_task_num;
  // __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
}
    80207858:	0001                	nop
    8020785a:	60e2                	ld	ra,24(sp)
    8020785c:	6442                	ld	s0,16(sp)
    8020785e:	6105                	addi	sp,sp,32
    80207860:	8082                	ret

0000000080207862 <task_manager_get_current_token>:
task_manager_get_current_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:69
//     __switch(&temp, &TASK_MANAGER.tasks[TASK_MANAGER.current_task].task_cx_ptr);
//     ASSERT(0);
// }

uint64_t task_manager_get_current_token()
{
    80207862:	1101                	addi	sp,sp,-32
    80207864:	ec06                	sd	ra,24(sp)
    80207866:	e822                	sd	s0,16(sp)
    80207868:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:70
  uint64_t current = TASK_MANAGER.current_task;
    8020786a:	00b23717          	auipc	a4,0xb23
    8020786e:	7ae70713          	addi	a4,a4,1966 # 80d2b018 <TASK_MANAGER>
    80207872:	6785                	lui	a5,0x1
    80207874:	97ba                	add	a5,a5,a4
    80207876:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    8020787a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:71
  return get_user_token(&TASK_MANAGER.tasks[current]);
    8020787e:	fe843703          	ld	a4,-24(s0)
    80207882:	87ba                	mv	a5,a4
    80207884:	078e                	slli	a5,a5,0x3
    80207886:	97ba                	add	a5,a5,a4
    80207888:	0796                	slli	a5,a5,0x5
    8020788a:	00b23717          	auipc	a4,0xb23
    8020788e:	78e70713          	addi	a4,a4,1934 # 80d2b018 <TASK_MANAGER>
    80207892:	97ba                	add	a5,a5,a4
    80207894:	853e                	mv	a0,a5
    80207896:	010000ef          	jal	ra,802078a6 <get_user_token>
    8020789a:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:72
}
    8020789c:	853e                	mv	a0,a5
    8020789e:	60e2                	ld	ra,24(sp)
    802078a0:	6442                	ld	s0,16(sp)
    802078a2:	6105                	addi	sp,sp,32
    802078a4:	8082                	ret

00000000802078a6 <get_user_token>:
get_user_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:75

uint64_t get_user_token(struct TaskControlBlock *s)
{
    802078a6:	1101                	addi	sp,sp,-32
    802078a8:	ec06                	sd	ra,24(sp)
    802078aa:	e822                	sd	s0,16(sp)
    802078ac:	1000                	addi	s0,sp,32
    802078ae:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:76
  return memory_set_token(&s->memory_set);
    802078b2:	fe843783          	ld	a5,-24(s0)
    802078b6:	09878793          	addi	a5,a5,152
    802078ba:	853e                	mv	a0,a5
    802078bc:	e64fd0ef          	jal	ra,80204f20 <memory_set_token>
    802078c0:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:77
}
    802078c2:	853e                	mv	a0,a5
    802078c4:	60e2                	ld	ra,24(sp)
    802078c6:	6442                	ld	s0,16(sp)
    802078c8:	6105                	addi	sp,sp,32
    802078ca:	8082                	ret

00000000802078cc <task_control_block_new>:
task_control_block_new():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:81

void task_control_block_new(struct TaskControlBlock *s, uint8_t *elf_data,
                            size_t elf_size)
{
    802078cc:	711d                	addi	sp,sp,-96
    802078ce:	ec86                	sd	ra,88(sp)
    802078d0:	e8a2                	sd	s0,80(sp)
    802078d2:	e4a6                	sd	s1,72(sp)
    802078d4:	e0ca                	sd	s2,64(sp)
    802078d6:	1080                	addi	s0,sp,96
    802078d8:	faa43c23          	sd	a0,-72(s0)
    802078dc:	fab43823          	sd	a1,-80(s0)
    802078e0:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:84
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
    802078e4:	fb843783          	ld	a5,-72(s0)
    802078e8:	09878793          	addi	a5,a5,152
    802078ec:	fc040713          	addi	a4,s0,-64
    802078f0:	fc840693          	addi	a3,s0,-56
    802078f4:	fa843603          	ld	a2,-88(s0)
    802078f8:	fb043583          	ld	a1,-80(s0)
    802078fc:	853e                	mv	a0,a5
    802078fe:	a35fd0ef          	jal	ra,80205332 <memory_set_from_elf>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:86
                      &entry_point);
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
    80207902:	fb843783          	ld	a5,-72(s0)
    80207906:	09878713          	addi	a4,a5,152
    8020790a:	77f9                	lui	a5,0xffffe
    8020790c:	00c7d593          	srli	a1,a5,0xc
    80207910:	853a                	mv	a0,a4
    80207912:	f41fd0ef          	jal	ra,80205852 <memory_set_translate>
    80207916:	87aa                	mv	a5,a0
    80207918:	639c                	ld	a5,0(a5)
    8020791a:	00a7d713          	srli	a4,a5,0xa
    8020791e:	57fd                	li	a5,-1
    80207920:	83d1                	srli	a5,a5,0x14
    80207922:	8f7d                	and	a4,a4,a5
    80207924:	fb843783          	ld	a5,-72(s0)
    80207928:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:90
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // alloc a pid and a kernel stack in kernel space
  s->pid = PidAllocator_alloc();
    8020792a:	fb843483          	ld	s1,-72(s0)
    8020792e:	236010ef          	jal	ra,80208b64 <PidAllocator_alloc>
    80207932:	e088                	sd	a0,0(s1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:91
  kernel_stack_new(&s->kernel_stack, s->pid);
    80207934:	fb843783          	ld	a5,-72(s0)
    80207938:	00878713          	addi	a4,a5,8 # ffffffffffffe008 <ebss+0xffffffff7f2d0008>
    8020793c:	fb843783          	ld	a5,-72(s0)
    80207940:	638c                	ld	a1,0(a5)
    80207942:	853a                	mv	a0,a4
    80207944:	503000ef          	jal	ra,80208646 <kernel_stack_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:92
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);
    80207948:	fb843783          	ld	a5,-72(s0)
    8020794c:	6788                	ld	a0,8(a5)
    8020794e:	4c9000ef          	jal	ra,80208616 <kernel_stack_get_top>
    80207952:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:95

  // push a task context which goes to trap_return to the top of kernel stack
  s->base_size = user_sp;
    80207956:	fc843703          	ld	a4,-56(s0)
    8020795a:	fb843783          	ld	a5,-72(s0)
    8020795e:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:96
  task_context_goto_trap_return(&s->task_cx, kernel_stack_top);
    80207960:	fb843783          	ld	a5,-72(s0)
    80207964:	02078793          	addi	a5,a5,32
    80207968:	fd843583          	ld	a1,-40(s0)
    8020796c:	853e                	mv	a0,a5
    8020796e:	16a010ef          	jal	ra,80208ad8 <task_context_goto_trap_return>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:97
  s->task_status = Ready;
    80207972:	fb843783          	ld	a5,-72(s0)
    80207976:	4705                	li	a4,1
    80207978:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:98
  s->parent = NULL;
    8020797c:	fb843783          	ld	a5,-72(s0)
    80207980:	0e07b023          	sd	zero,224(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:99
  vector_new(&s->children, sizeof(struct TaskControlBlock *));
    80207984:	fb843783          	ld	a5,-72(s0)
    80207988:	0e878793          	addi	a5,a5,232
    8020798c:	45a1                	li	a1,8
    8020798e:	853e                	mv	a0,a5
    80207990:	6ed010ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:100
  s->exit_code = 0;
    80207994:	fb843783          	ld	a5,-72(s0)
    80207998:	1007a423          	sw	zero,264(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:103

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
    8020799c:	fb843503          	ld	a0,-72(s0)
    802079a0:	e7bff0ef          	jal	ra,8020781a <task_control_block_get_trap_cx>
    802079a4:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:104
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
    802079a8:	fc043483          	ld	s1,-64(s0)
    802079ac:	fc843903          	ld	s2,-56(s0)
    802079b0:	f4bfd0ef          	jal	ra,802058fa <kernel_space_token>
    802079b4:	862a                	mv	a2,a0
    802079b6:	00001717          	auipc	a4,0x1
    802079ba:	36c70713          	addi	a4,a4,876 # 80208d22 <trap_handler>
    802079be:	fd043783          	ld	a5,-48(s0)
    802079c2:	fd843683          	ld	a3,-40(s0)
    802079c6:	85ca                	mv	a1,s2
    802079c8:	8526                	mv	a0,s1
    802079ca:	05c010ef          	jal	ra,80208a26 <app_init_context>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:107
                   (uint64_t)trap_handler, trap_cx);

  s->priority = DEFAULT_PRIORITY;
    802079ce:	fb843783          	ld	a5,-72(s0)
    802079d2:	4741                	li	a4,16
    802079d4:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:108
  s->stride = 0;
    802079d8:	fb843783          	ld	a5,-72(s0)
    802079dc:	1007bc23          	sd	zero,280(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:109
}
    802079e0:	0001                	nop
    802079e2:	60e6                	ld	ra,88(sp)
    802079e4:	6446                	ld	s0,80(sp)
    802079e6:	64a6                	ld	s1,72(sp)
    802079e8:	6906                	ld	s2,64(sp)
    802079ea:	6125                	addi	sp,sp,96
    802079ec:	8082                	ret

00000000802079ee <task_current_trap_cx>:
task_current_trap_cx():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:112

struct TrapContext *task_current_trap_cx()
{
    802079ee:	1141                	addi	sp,sp,-16
    802079f0:	e406                	sd	ra,8(sp)
    802079f2:	e022                	sd	s0,0(sp)
    802079f4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:113
  return task_manager_get_current_trap_cx();
    802079f6:	414000ef          	jal	ra,80207e0a <task_manager_get_current_trap_cx>
    802079fa:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:114
}
    802079fc:	853e                	mv	a0,a5
    802079fe:	60a2                	ld	ra,8(sp)
    80207a00:	6402                	ld	s0,0(sp)
    80207a02:	0141                	addi	sp,sp,16
    80207a04:	8082                	ret

0000000080207a06 <get_task_cx_ptr2>:
get_task_cx_ptr2():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:117

struct TaskContext **get_task_cx_ptr2(struct TaskControlBlock *s)
{
    80207a06:	1101                	addi	sp,sp,-32
    80207a08:	ec22                	sd	s0,24(sp)
    80207a0a:	1000                	addi	s0,sp,32
    80207a0c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:118
  return (struct TaskContext **)(&(s->task_cx));
    80207a10:	fe843783          	ld	a5,-24(s0)
    80207a14:	02078793          	addi	a5,a5,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:119
}
    80207a18:	853e                	mv	a0,a5
    80207a1a:	6462                	ld	s0,24(sp)
    80207a1c:	6105                	addi	sp,sp,32
    80207a1e:	8082                	ret

0000000080207a20 <get_status>:
get_status():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:122

enum TaskStatus get_status(struct TaskControlBlock *self)
{
    80207a20:	1101                	addi	sp,sp,-32
    80207a22:	ec22                	sd	s0,24(sp)
    80207a24:	1000                	addi	s0,sp,32
    80207a26:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:123
  return self->task_status;
    80207a2a:	fe843783          	ld	a5,-24(s0)
    80207a2e:	0907a783          	lw	a5,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:124
}
    80207a32:	853e                	mv	a0,a5
    80207a34:	6462                	ld	s0,24(sp)
    80207a36:	6105                	addi	sp,sp,32
    80207a38:	8082                	ret

0000000080207a3a <is_zombie>:
is_zombie():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:127

int is_zombie(struct TaskControlBlock *self)
{
    80207a3a:	1101                	addi	sp,sp,-32
    80207a3c:	ec06                	sd	ra,24(sp)
    80207a3e:	e822                	sd	s0,16(sp)
    80207a40:	1000                	addi	s0,sp,32
    80207a42:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:128
  return get_status(self) == Zombie;
    80207a46:	fe843503          	ld	a0,-24(s0)
    80207a4a:	fd7ff0ef          	jal	ra,80207a20 <get_status>
    80207a4e:	87aa                	mv	a5,a0
    80207a50:	2781                	sext.w	a5,a5
    80207a52:	873e                	mv	a4,a5
    80207a54:	4791                	li	a5,4
    80207a56:	40f707b3          	sub	a5,a4,a5
    80207a5a:	0017b793          	seqz	a5,a5
    80207a5e:	0ff7f793          	andi	a5,a5,255
    80207a62:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:129
}
    80207a64:	853e                	mv	a0,a5
    80207a66:	60e2                	ld	ra,24(sp)
    80207a68:	6442                	ld	s0,16(sp)
    80207a6a:	6105                	addi	sp,sp,32
    80207a6c:	8082                	ret

0000000080207a6e <getpid>:
getpid():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:132

uint64_t getpid(struct TaskControlBlock *self)
{
    80207a6e:	1101                	addi	sp,sp,-32
    80207a70:	ec22                	sd	s0,24(sp)
    80207a72:	1000                	addi	s0,sp,32
    80207a74:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:133
  return self->pid.pid;
    80207a78:	fe843783          	ld	a5,-24(s0)
    80207a7c:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:134
}
    80207a7e:	853e                	mv	a0,a5
    80207a80:	6462                	ld	s0,24(sp)
    80207a82:	6105                	addi	sp,sp,32
    80207a84:	8082                	ret

0000000080207a86 <task_context_zero_init>:
task_context_zero_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:137

void task_context_zero_init(struct TaskContext *cx)
{
    80207a86:	7179                	addi	sp,sp,-48
    80207a88:	f422                	sd	s0,40(sp)
    80207a8a:	1800                	addi	s0,sp,48
    80207a8c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:138
  cx->ra = 0;
    80207a90:	fd843783          	ld	a5,-40(s0)
    80207a94:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:139
  cx->sp = 0;
    80207a98:	fd843783          	ld	a5,-40(s0)
    80207a9c:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:140
  for (int i = 0; i < 12; i++)
    80207aa0:	fe042623          	sw	zero,-20(s0)
    80207aa4:	a839                	j	80207ac2 <task_context_zero_init+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:142 (discriminator 3)
  {
    cx->x[i] = 0;
    80207aa6:	fd843703          	ld	a4,-40(s0)
    80207aaa:	fec42783          	lw	a5,-20(s0)
    80207aae:	0789                	addi	a5,a5,2
    80207ab0:	078e                	slli	a5,a5,0x3
    80207ab2:	97ba                	add	a5,a5,a4
    80207ab4:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:140 (discriminator 3)
  for (int i = 0; i < 12; i++)
    80207ab8:	fec42783          	lw	a5,-20(s0)
    80207abc:	2785                	addiw	a5,a5,1
    80207abe:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:140 (discriminator 1)
    80207ac2:	fec42783          	lw	a5,-20(s0)
    80207ac6:	0007871b          	sext.w	a4,a5
    80207aca:	47ad                	li	a5,11
    80207acc:	fce7dde3          	bge	a5,a4,80207aa6 <task_context_zero_init+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:144
  }
}
    80207ad0:	0001                	nop
    80207ad2:	0001                	nop
    80207ad4:	7422                	ld	s0,40(sp)
    80207ad6:	6145                	addi	sp,sp,48
    80207ad8:	8082                	ret

0000000080207ada <task_control_block_get_user_token>:
task_control_block_get_user_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:147

uint64_t task_control_block_get_user_token(struct TaskControlBlock *s)
{
    80207ada:	1101                	addi	sp,sp,-32
    80207adc:	ec06                	sd	ra,24(sp)
    80207ade:	e822                	sd	s0,16(sp)
    80207ae0:	1000                	addi	s0,sp,32
    80207ae2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:148
  return memory_set_token(&s->memory_set);
    80207ae6:	fe843783          	ld	a5,-24(s0)
    80207aea:	09878793          	addi	a5,a5,152
    80207aee:	853e                	mv	a0,a5
    80207af0:	c30fd0ef          	jal	ra,80204f20 <memory_set_token>
    80207af4:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:149
}
    80207af6:	853e                	mv	a0,a5
    80207af8:	60e2                	ld	ra,24(sp)
    80207afa:	6442                	ld	s0,16(sp)
    80207afc:	6105                	addi	sp,sp,32
    80207afe:	8082                	ret

0000000080207b00 <taks_init>:
taks_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:152

void taks_init()
{
    80207b00:	1101                	addi	sp,sp,-32
    80207b02:	ec06                	sd	ra,24(sp)
    80207b04:	e822                	sd	s0,16(sp)
    80207b06:	e426                	sd	s1,8(sp)
    80207b08:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:153
  PidAllocator_init(&PID_ALLOCATOR);
    80207b0a:	00b25517          	auipc	a0,0xb25
    80207b0e:	38650513          	addi	a0,a0,902 # 80d2ce90 <PID_ALLOCATOR>
    80207b12:	026010ef          	jal	ra,80208b38 <PidAllocator_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:154
  task_manager_init_2();
    80207b16:	062000ef          	jal	ra,80207b78 <task_manager_init_2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:155
  task_control_block_new(&INITPROC, loader_get_app_data_by_name("initproc"),
    80207b1a:	00003517          	auipc	a0,0x3
    80207b1e:	c2650513          	addi	a0,a0,-986 # 8020a740 <MMIO+0x48>
    80207b22:	589000ef          	jal	ra,802088aa <loader_get_app_data_by_name>
    80207b26:	84aa                	mv	s1,a0
    80207b28:	00003517          	auipc	a0,0x3
    80207b2c:	c1850513          	addi	a0,a0,-1000 # 8020a740 <MMIO+0x48>
    80207b30:	60b000ef          	jal	ra,8020893a <loader_get_app_size_by_name>
    80207b34:	87aa                	mv	a5,a0
    80207b36:	863e                	mv	a2,a5
    80207b38:	85a6                	mv	a1,s1
    80207b3a:	00b25517          	auipc	a0,0xb25
    80207b3e:	b6e50513          	addi	a0,a0,-1170 # 80d2c6a8 <INITPROC>
    80207b42:	d8bff0ef          	jal	ra,802078cc <task_control_block_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:157
                         loader_get_app_size_by_name("initproc"));
}
    80207b46:	0001                	nop
    80207b48:	60e2                	ld	ra,24(sp)
    80207b4a:	6442                	ld	s0,16(sp)
    80207b4c:	64a2                	ld	s1,8(sp)
    80207b4e:	6105                	addi	sp,sp,32
    80207b50:	8082                	ret

0000000080207b52 <task_manager_add_2_initproc>:
task_manager_add_2_initproc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:160

void task_manager_add_2_initproc()
{
    80207b52:	1141                	addi	sp,sp,-16
    80207b54:	e406                	sd	ra,8(sp)
    80207b56:	e022                	sd	s0,0(sp)
    80207b58:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:161
  task_manager_add_2(&TASK_MANAGER_2, &INITPROC);
    80207b5a:	00b25597          	auipc	a1,0xb25
    80207b5e:	b4e58593          	addi	a1,a1,-1202 # 80d2c6a8 <INITPROC>
    80207b62:	00b25517          	auipc	a0,0xb25
    80207b66:	76e50513          	addi	a0,a0,1902 # 80d2d2d0 <TASK_MANAGER_2>
    80207b6a:	064000ef          	jal	ra,80207bce <task_manager_add_2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/task.c:162
    80207b6e:	0001                	nop
    80207b70:	60a2                	ld	ra,8(sp)
    80207b72:	6402                	ld	s0,0(sp)
    80207b74:	0141                	addi	sp,sp,16
    80207b76:	8082                	ret

0000000080207b78 <task_manager_init_2>:
task_manager_init_2():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:6
#include "taskmanager.h"
#include "mem.h"
TaskManager_2 TASK_MANAGER_2;

void task_manager_init_2()
{
    80207b78:	1141                	addi	sp,sp,-16
    80207b7a:	e406                	sd	ra,8(sp)
    80207b7c:	e022                	sd	s0,0(sp)
    80207b7e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:7
    TASK_MANAGER_2.ready_queue = bd_malloc(sizeof(Queue *));
    80207b80:	4521                	li	a0,8
    80207b82:	e91fe0ef          	jal	ra,80206a12 <bd_malloc>
    80207b86:	872a                	mv	a4,a0
    80207b88:	00b25797          	auipc	a5,0xb25
    80207b8c:	74878793          	addi	a5,a5,1864 # 80d2d2d0 <TASK_MANAGER_2>
    80207b90:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:8
    if(TASK_MANAGER_2.ready_queue == NULL) ASSERT(0);
    80207b92:	00b25797          	auipc	a5,0xb25
    80207b96:	73e78793          	addi	a5,a5,1854 # 80d2d2d0 <TASK_MANAGER_2>
    80207b9a:	639c                	ld	a5,0(a5)
    80207b9c:	ef81                	bnez	a5,80207bb4 <task_manager_init_2+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:8 (discriminator 2)
    80207b9e:	00003617          	auipc	a2,0x3
    80207ba2:	bc260613          	addi	a2,a2,-1086 # 8020a760 <MMIO+0x10>
    80207ba6:	45a1                	li	a1,8
    80207ba8:	00003517          	auipc	a0,0x3
    80207bac:	bd050513          	addi	a0,a0,-1072 # 8020a778 <MMIO+0x28>
    80207bb0:	c2dff0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:9
    queue_init(TASK_MANAGER_2.ready_queue);
    80207bb4:	00b25797          	auipc	a5,0xb25
    80207bb8:	71c78793          	addi	a5,a5,1820 # 80d2d2d0 <TASK_MANAGER_2>
    80207bbc:	639c                	ld	a5,0(a5)
    80207bbe:	853e                	mv	a0,a5
    80207bc0:	7b3010ef          	jal	ra,80209b72 <queue_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:10
}
    80207bc4:	0001                	nop
    80207bc6:	60a2                	ld	ra,8(sp)
    80207bc8:	6402                	ld	s0,0(sp)
    80207bca:	0141                	addi	sp,sp,16
    80207bcc:	8082                	ret

0000000080207bce <task_manager_add_2>:
task_manager_add_2():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:13

void task_manager_add_2(TaskManager_2* manager, void* task) 
{
    80207bce:	1101                	addi	sp,sp,-32
    80207bd0:	ec06                	sd	ra,24(sp)
    80207bd2:	e822                	sd	s0,16(sp)
    80207bd4:	1000                	addi	s0,sp,32
    80207bd6:	fea43423          	sd	a0,-24(s0)
    80207bda:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:14
    queue_enqueue(manager->ready_queue, task);
    80207bde:	fe843783          	ld	a5,-24(s0)
    80207be2:	639c                	ld	a5,0(a5)
    80207be4:	fe043583          	ld	a1,-32(s0)
    80207be8:	853e                	mv	a0,a5
    80207bea:	7b3010ef          	jal	ra,80209b9c <queue_enqueue>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:15
}
    80207bee:	0001                	nop
    80207bf0:	60e2                	ld	ra,24(sp)
    80207bf2:	6442                	ld	s0,16(sp)
    80207bf4:	6105                	addi	sp,sp,32
    80207bf6:	8082                	ret

0000000080207bf8 <task_manager_fetch_2>:
task_manager_fetch_2():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:18

void* task_manager_fetch_2(TaskManager_2* manager) 
{
    80207bf8:	1101                	addi	sp,sp,-32
    80207bfa:	ec06                	sd	ra,24(sp)
    80207bfc:	e822                	sd	s0,16(sp)
    80207bfe:	1000                	addi	s0,sp,32
    80207c00:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:19
    return queue_dequeue(manager->ready_queue);
    80207c04:	fe843783          	ld	a5,-24(s0)
    80207c08:	639c                	ld	a5,0(a5)
    80207c0a:	853e                	mv	a0,a5
    80207c0c:	02a020ef          	jal	ra,80209c36 <queue_dequeue>
    80207c10:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:20
}
    80207c12:	853e                	mv	a0,a5
    80207c14:	60e2                	ld	ra,24(sp)
    80207c16:	6442                	ld	s0,16(sp)
    80207c18:	6105                	addi	sp,sp,32
    80207c1a:	8082                	ret

0000000080207c1c <task_manager_fetch_task>:
task_manager_fetch_task():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:23


struct TaskControlBlock *task_manager_fetch_task() {
    80207c1c:	1141                	addi	sp,sp,-16
    80207c1e:	e406                	sd	ra,8(sp)
    80207c20:	e022                	sd	s0,0(sp)
    80207c22:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:24
  return task_manager_fetch_2(&TASK_MANAGER_2);
    80207c24:	00b25517          	auipc	a0,0xb25
    80207c28:	6ac50513          	addi	a0,a0,1708 # 80d2d2d0 <TASK_MANAGER_2>
    80207c2c:	fcdff0ef          	jal	ra,80207bf8 <task_manager_fetch_2>
    80207c30:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/task/taskmanager.c:25
    80207c32:	853e                	mv	a0,a5
    80207c34:	60a2                	ld	ra,8(sp)
    80207c36:	6402                	ld	s0,0(sp)
    80207c38:	0141                	addi	sp,sp,16
    80207c3a:	8082                	ret

0000000080207c3c <init_appmanager>:
init_appmanager():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:16
struct AppManager app_manager;
extern struct TaskManager TASK_MANAGER;
extern struct TaskControlBlock INITPROC;
extern void trap_handler();
void init_appmanager()
{
    80207c3c:	1101                	addi	sp,sp,-32
    80207c3e:	ec06                	sd	ra,24(sp)
    80207c40:	e822                	sd	s0,16(sp)
    80207c42:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:17
  app_manager.app_num = _num_app[0];
    80207c44:	00003797          	auipc	a5,0x3
    80207c48:	3f478793          	addi	a5,a5,1012 # 8020b038 <_num_app>
    80207c4c:	6398                	ld	a4,0(a5)
    80207c4e:	00b25797          	auipc	a5,0xb25
    80207c52:	b7a78793          	addi	a5,a5,-1158 # 80d2c7c8 <app_manager>
    80207c56:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:18
  for (uint64_t i = 0; i < app_manager.app_num; i++)
    80207c58:	fe043423          	sd	zero,-24(s0)
    80207c5c:	a085                	j	80207cbc <init_appmanager+0x80>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:20 (discriminator 3)
  {
    app_manager.app_start[i] = _num_app[1 + i * 2];
    80207c5e:	fe843783          	ld	a5,-24(s0)
    80207c62:	0786                	slli	a5,a5,0x1
    80207c64:	0785                	addi	a5,a5,1
    80207c66:	00003717          	auipc	a4,0x3
    80207c6a:	3d270713          	addi	a4,a4,978 # 8020b038 <_num_app>
    80207c6e:	078e                	slli	a5,a5,0x3
    80207c70:	97ba                	add	a5,a5,a4
    80207c72:	6398                	ld	a4,0(a5)
    80207c74:	00b25697          	auipc	a3,0xb25
    80207c78:	b5468693          	addi	a3,a3,-1196 # 80d2c7c8 <app_manager>
    80207c7c:	fe843783          	ld	a5,-24(s0)
    80207c80:	0789                	addi	a5,a5,2
    80207c82:	078e                	slli	a5,a5,0x3
    80207c84:	97b6                	add	a5,a5,a3
    80207c86:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:21 (discriminator 3)
    app_manager.app_end[i] = _num_app[2 + i * 2];
    80207c88:	fe843783          	ld	a5,-24(s0)
    80207c8c:	0785                	addi	a5,a5,1
    80207c8e:	0786                	slli	a5,a5,0x1
    80207c90:	00003717          	auipc	a4,0x3
    80207c94:	3a870713          	addi	a4,a4,936 # 8020b038 <_num_app>
    80207c98:	078e                	slli	a5,a5,0x3
    80207c9a:	97ba                	add	a5,a5,a4
    80207c9c:	6398                	ld	a4,0(a5)
    80207c9e:	00b25697          	auipc	a3,0xb25
    80207ca2:	b2a68693          	addi	a3,a3,-1238 # 80d2c7c8 <app_manager>
    80207ca6:	fe843783          	ld	a5,-24(s0)
    80207caa:	07d9                	addi	a5,a5,22
    80207cac:	078e                	slli	a5,a5,0x3
    80207cae:	97b6                	add	a5,a5,a3
    80207cb0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:18 (discriminator 3)
  for (uint64_t i = 0; i < app_manager.app_num; i++)
    80207cb2:	fe843783          	ld	a5,-24(s0)
    80207cb6:	0785                	addi	a5,a5,1
    80207cb8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:18 (discriminator 1)
    80207cbc:	00b25797          	auipc	a5,0xb25
    80207cc0:	b0c78793          	addi	a5,a5,-1268 # 80d2c7c8 <app_manager>
    80207cc4:	639c                	ld	a5,0(a5)
    80207cc6:	fe843703          	ld	a4,-24(s0)
    80207cca:	f8f76ae3          	bltu	a4,a5,80207c5e <init_appmanager+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:23
  }
  app_manager.current_app = 0;
    80207cce:	00b25797          	auipc	a5,0xb25
    80207cd2:	afa78793          	addi	a5,a5,-1286 # 80d2c7c8 <app_manager>
    80207cd6:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:24
  print_app_info(&app_manager);
    80207cda:	00b25517          	auipc	a0,0xb25
    80207cde:	aee50513          	addi	a0,a0,-1298 # 80d2c7c8 <app_manager>
    80207ce2:	00e000ef          	jal	ra,80207cf0 <print_app_info>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:25
}
    80207ce6:	0001                	nop
    80207ce8:	60e2                	ld	ra,24(sp)
    80207cea:	6442                	ld	s0,16(sp)
    80207cec:	6105                	addi	sp,sp,32
    80207cee:	8082                	ret

0000000080207cf0 <print_app_info>:
print_app_info():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:28

void print_app_info(struct AppManager *manager)
{
    80207cf0:	7179                	addi	sp,sp,-48
    80207cf2:	f406                	sd	ra,40(sp)
    80207cf4:	f022                	sd	s0,32(sp)
    80207cf6:	1800                	addi	s0,sp,48
    80207cf8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:29
  print_str("Total applications: ");
    80207cfc:	00003517          	auipc	a0,0x3
    80207d00:	aac50513          	addi	a0,a0,-1364 # 8020a7a8 <MMIO+0x10>
    80207d04:	815ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:30
  print_uint64(manager->app_num);
    80207d08:	fd843783          	ld	a5,-40(s0)
    80207d0c:	639c                	ld	a5,0(a5)
    80207d0e:	853e                	mv	a0,a5
    80207d10:	987ff0ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:31
  print_str("\n");
    80207d14:	00003517          	auipc	a0,0x3
    80207d18:	aac50513          	addi	a0,a0,-1364 # 8020a7c0 <MMIO+0x28>
    80207d1c:	ffcff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:33

  for (uint64_t i = 0; i < manager->app_num; ++i)
    80207d20:	fe043423          	sd	zero,-24(s0)
    80207d24:	a885                	j	80207d94 <print_app_info+0xa4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:35 (discriminator 3)
  {
    print_str("App ");
    80207d26:	00003517          	auipc	a0,0x3
    80207d2a:	aa250513          	addi	a0,a0,-1374 # 8020a7c8 <MMIO+0x30>
    80207d2e:	feaff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:36 (discriminator 3)
    print_uint64(i);
    80207d32:	fe843503          	ld	a0,-24(s0)
    80207d36:	961ff0ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:37 (discriminator 3)
    print_str(":\n  Start Address: ");
    80207d3a:	00003517          	auipc	a0,0x3
    80207d3e:	a9650513          	addi	a0,a0,-1386 # 8020a7d0 <MMIO+0x38>
    80207d42:	fd6ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:38 (discriminator 3)
    print_uint64(manager->app_start[i]);
    80207d46:	fd843703          	ld	a4,-40(s0)
    80207d4a:	fe843783          	ld	a5,-24(s0)
    80207d4e:	0789                	addi	a5,a5,2
    80207d50:	078e                	slli	a5,a5,0x3
    80207d52:	97ba                	add	a5,a5,a4
    80207d54:	639c                	ld	a5,0(a5)
    80207d56:	853e                	mv	a0,a5
    80207d58:	93fff0ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:39 (discriminator 3)
    print_str("\n  End Address:   ");
    80207d5c:	00003517          	auipc	a0,0x3
    80207d60:	a8c50513          	addi	a0,a0,-1396 # 8020a7e8 <MMIO+0x50>
    80207d64:	fb4ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:40 (discriminator 3)
    print_uint64(manager->app_end[i]);
    80207d68:	fd843703          	ld	a4,-40(s0)
    80207d6c:	fe843783          	ld	a5,-24(s0)
    80207d70:	07d9                	addi	a5,a5,22
    80207d72:	078e                	slli	a5,a5,0x3
    80207d74:	97ba                	add	a5,a5,a4
    80207d76:	639c                	ld	a5,0(a5)
    80207d78:	853e                	mv	a0,a5
    80207d7a:	91dff0ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:41 (discriminator 3)
    print_str("\n");
    80207d7e:	00003517          	auipc	a0,0x3
    80207d82:	a4250513          	addi	a0,a0,-1470 # 8020a7c0 <MMIO+0x28>
    80207d86:	f92ff0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:33 (discriminator 3)
  for (uint64_t i = 0; i < manager->app_num; ++i)
    80207d8a:	fe843783          	ld	a5,-24(s0)
    80207d8e:	0785                	addi	a5,a5,1
    80207d90:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:33 (discriminator 1)
    80207d94:	fd843783          	ld	a5,-40(s0)
    80207d98:	639c                	ld	a5,0(a5)
    80207d9a:	fe843703          	ld	a4,-24(s0)
    80207d9e:	f8f764e3          	bltu	a4,a5,80207d26 <print_app_info+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:43
  }
}
    80207da2:	0001                	nop
    80207da4:	0001                	nop
    80207da6:	70a2                	ld	ra,40(sp)
    80207da8:	7402                	ld	s0,32(sp)
    80207daa:	6145                	addi	sp,sp,48
    80207dac:	8082                	ret

0000000080207dae <get_trap_cx>:
get_trap_cx():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:46

struct TrapContext *get_trap_cx(struct TaskControlBlock *s)
{
    80207dae:	1101                	addi	sp,sp,-32
    80207db0:	ec22                	sd	s0,24(sp)
    80207db2:	1000                	addi	s0,sp,32
    80207db4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:47
  return (struct TrapContext *)pn2addr(s->trap_cx_ppn);
    80207db8:	fe843783          	ld	a5,-24(s0)
    80207dbc:	6b9c                	ld	a5,16(a5)
    80207dbe:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:48
}
    80207dc0:	853e                	mv	a0,a5
    80207dc2:	6462                	ld	s0,24(sp)
    80207dc4:	6105                	addi	sp,sp,32
    80207dc6:	8082                	ret

0000000080207dc8 <run_first_app>:
run_first_app():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:71
//     //__restore(trapcontext);
//     __restore((uint64_t)cx);
// }

void run_first_app()
{
    80207dc8:	1101                	addi	sp,sp,-32
    80207dca:	ec06                	sd	ra,24(sp)
    80207dcc:	e822                	sd	s0,16(sp)
    80207dce:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:74
  extern void __switch(struct TaskContext * *current_task_cx_ptr2,
                       struct TaskContext * *next_task_cx_ptr2);
  TASK_MANAGER.tasks[0].task_status = Running;
    80207dd0:	00b23797          	auipc	a5,0xb23
    80207dd4:	24878793          	addi	a5,a5,584 # 80d2b018 <TASK_MANAGER>
    80207dd8:	4709                	li	a4,2
    80207dda:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:76
  struct TaskContext **next_task_cx_ptr2 =
      get_task_cx_ptr2(&(TASK_MANAGER.tasks[0]));
    80207dde:	00b23517          	auipc	a0,0xb23
    80207de2:	23a50513          	addi	a0,a0,570 # 80d2b018 <TASK_MANAGER>
    80207de6:	c21ff0ef          	jal	ra,80207a06 <get_task_cx_ptr2>
    80207dea:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:77
  uint64_t _unused = 0;
    80207dee:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:79
  // printk("run_fisrt_app_end\n");
  __switch((struct TaskContext **)&_unused, next_task_cx_ptr2);
    80207df2:	fe040793          	addi	a5,s0,-32
    80207df6:	fe843583          	ld	a1,-24(s0)
    80207dfa:	853e                	mv	a0,a5
    80207dfc:	7c7010ef          	jal	ra,80209dc2 <__switch>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:80
}
    80207e00:	0001                	nop
    80207e02:	60e2                	ld	ra,24(sp)
    80207e04:	6442                	ld	s0,16(sp)
    80207e06:	6105                	addi	sp,sp,32
    80207e08:	8082                	ret

0000000080207e0a <task_manager_get_current_trap_cx>:
task_manager_get_current_trap_cx():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:111
//         __asm__ volatile ("fence.i");
//     }
// }

struct TrapContext *task_manager_get_current_trap_cx()
{
    80207e0a:	1101                	addi	sp,sp,-32
    80207e0c:	ec06                	sd	ra,24(sp)
    80207e0e:	e822                	sd	s0,16(sp)
    80207e10:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:112
  uint64_t current = TASK_MANAGER.current_task;
    80207e12:	00b23717          	auipc	a4,0xb23
    80207e16:	20670713          	addi	a4,a4,518 # 80d2b018 <TASK_MANAGER>
    80207e1a:	6785                	lui	a5,0x1
    80207e1c:	97ba                	add	a5,a5,a4
    80207e1e:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80207e22:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:113
  return get_trap_cx(&TASK_MANAGER.tasks[current]);
    80207e26:	fe843703          	ld	a4,-24(s0)
    80207e2a:	87ba                	mv	a5,a4
    80207e2c:	078e                	slli	a5,a5,0x3
    80207e2e:	97ba                	add	a5,a5,a4
    80207e30:	0796                	slli	a5,a5,0x5
    80207e32:	00b23717          	auipc	a4,0xb23
    80207e36:	1e670713          	addi	a4,a4,486 # 80d2b018 <TASK_MANAGER>
    80207e3a:	97ba                	add	a5,a5,a4
    80207e3c:	853e                	mv	a0,a5
    80207e3e:	f71ff0ef          	jal	ra,80207dae <get_trap_cx>
    80207e42:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:114
}
    80207e44:	853e                	mv	a0,a5
    80207e46:	60e2                	ld	ra,24(sp)
    80207e48:	6442                	ld	s0,16(sp)
    80207e4a:	6105                	addi	sp,sp,32
    80207e4c:	8082                	ret

0000000080207e4e <task_control_block_free>:
task_control_block_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:117

void task_control_block_free(struct TaskControlBlock *s)
{
    80207e4e:	1101                	addi	sp,sp,-32
    80207e50:	ec06                	sd	ra,24(sp)
    80207e52:	e822                	sd	s0,16(sp)
    80207e54:	1000                	addi	s0,sp,32
    80207e56:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:118
  memory_set_free(&s->memory_set);
    80207e5a:	fe843783          	ld	a5,-24(s0)
    80207e5e:	09878793          	addi	a5,a5,152
    80207e62:	853e                	mv	a0,a5
    80207e64:	a32fd0ef          	jal	ra,80205096 <memory_set_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:119
}
    80207e68:	0001                	nop
    80207e6a:	60e2                	ld	ra,24(sp)
    80207e6c:	6442                	ld	s0,16(sp)
    80207e6e:	6105                	addi	sp,sp,32
    80207e70:	8082                	ret

0000000080207e72 <task_manager_mark_current_exited>:
task_manager_mark_current_exited():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:122

void task_manager_mark_current_exited()
{
    80207e72:	1101                	addi	sp,sp,-32
    80207e74:	ec06                	sd	ra,24(sp)
    80207e76:	e822                	sd	s0,16(sp)
    80207e78:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:123
  uint64_t current = TASK_MANAGER.current_task;
    80207e7a:	00b23717          	auipc	a4,0xb23
    80207e7e:	19e70713          	addi	a4,a4,414 # 80d2b018 <TASK_MANAGER>
    80207e82:	6785                	lui	a5,0x1
    80207e84:	97ba                	add	a5,a5,a4
    80207e86:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80207e8a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:124
  task_control_block_free(&TASK_MANAGER.tasks[current]);
    80207e8e:	fe843703          	ld	a4,-24(s0)
    80207e92:	87ba                	mv	a5,a4
    80207e94:	078e                	slli	a5,a5,0x3
    80207e96:	97ba                	add	a5,a5,a4
    80207e98:	0796                	slli	a5,a5,0x5
    80207e9a:	00b23717          	auipc	a4,0xb23
    80207e9e:	17e70713          	addi	a4,a4,382 # 80d2b018 <TASK_MANAGER>
    80207ea2:	97ba                	add	a5,a5,a4
    80207ea4:	853e                	mv	a0,a5
    80207ea6:	fa9ff0ef          	jal	ra,80207e4e <task_control_block_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:125
  TASK_MANAGER.tasks[current].task_status = Exited;
    80207eaa:	00b23697          	auipc	a3,0xb23
    80207eae:	16e68693          	addi	a3,a3,366 # 80d2b018 <TASK_MANAGER>
    80207eb2:	fe843703          	ld	a4,-24(s0)
    80207eb6:	87ba                	mv	a5,a4
    80207eb8:	078e                	slli	a5,a5,0x3
    80207eba:	97ba                	add	a5,a5,a4
    80207ebc:	0796                	slli	a5,a5,0x5
    80207ebe:	97b6                	add	a5,a5,a3
    80207ec0:	470d                	li	a4,3
    80207ec2:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:126
}
    80207ec6:	0001                	nop
    80207ec8:	60e2                	ld	ra,24(sp)
    80207eca:	6442                	ld	s0,16(sp)
    80207ecc:	6105                	addi	sp,sp,32
    80207ece:	8082                	ret

0000000080207ed0 <task_manager_find_next_task>:
task_manager_find_next_task():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:129

int64_t task_manager_find_next_task()
{
    80207ed0:	715d                	addi	sp,sp,-80
    80207ed2:	e4a2                	sd	s0,72(sp)
    80207ed4:	0880                	addi	s0,sp,80
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:130
  uint64_t num_app = TASK_MANAGER.num_app;
    80207ed6:	00b23717          	auipc	a4,0xb23
    80207eda:	14270713          	addi	a4,a4,322 # 80d2b018 <TASK_MANAGER>
    80207ede:	6785                	lui	a5,0x1
    80207ee0:	97ba                	add	a5,a5,a4
    80207ee2:	6887b783          	ld	a5,1672(a5) # 1688 <n+0x1668>
    80207ee6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:131
  uint64_t min_stride = __UINT64_MAX__;
    80207eea:	57fd                	li	a5,-1
    80207eec:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:132
  int64_t min_id = -1;
    80207ef0:	57fd                	li	a5,-1
    80207ef2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:133
  uint64_t start_id = (TASK_MANAGER.current_task + 1) % num_app; // Start from the next task of the current task.
    80207ef6:	00b23717          	auipc	a4,0xb23
    80207efa:	12270713          	addi	a4,a4,290 # 80d2b018 <TASK_MANAGER>
    80207efe:	6785                	lui	a5,0x1
    80207f00:	97ba                	add	a5,a5,a4
    80207f02:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80207f06:	00178713          	addi	a4,a5,1
    80207f0a:	fd043783          	ld	a5,-48(s0)
    80207f0e:	02f777b3          	remu	a5,a4,a5
    80207f12:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:134
  uint64_t checked = 0;                                          // Number of tasks checked.
    80207f16:	fe043023          	sd	zero,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:136

  for (uint64_t i = start_id; checked < num_app; i = (i + 1) % num_app)
    80207f1a:	fc043783          	ld	a5,-64(s0)
    80207f1e:	fcf43c23          	sd	a5,-40(s0)
    80207f22:	a8bd                	j	80207fa0 <task_manager_find_next_task+0xd0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:138
  {
    if (TASK_MANAGER.tasks[i].task_status == Ready)
    80207f24:	00b23697          	auipc	a3,0xb23
    80207f28:	0f468693          	addi	a3,a3,244 # 80d2b018 <TASK_MANAGER>
    80207f2c:	fd843703          	ld	a4,-40(s0)
    80207f30:	87ba                	mv	a5,a4
    80207f32:	078e                	slli	a5,a5,0x3
    80207f34:	97ba                	add	a5,a5,a4
    80207f36:	0796                	slli	a5,a5,0x5
    80207f38:	97b6                	add	a5,a5,a3
    80207f3a:	0907a783          	lw	a5,144(a5)
    80207f3e:	873e                	mv	a4,a5
    80207f40:	4785                	li	a5,1
    80207f42:	04f71063          	bne	a4,a5,80207f82 <task_manager_find_next_task+0xb2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:140
    {
      uint64_t current_stride = TASK_MANAGER.tasks[i].stride;
    80207f46:	00b23697          	auipc	a3,0xb23
    80207f4a:	0d268693          	addi	a3,a3,210 # 80d2b018 <TASK_MANAGER>
    80207f4e:	fd843703          	ld	a4,-40(s0)
    80207f52:	87ba                	mv	a5,a4
    80207f54:	078e                	slli	a5,a5,0x3
    80207f56:	97ba                	add	a5,a5,a4
    80207f58:	0796                	slli	a5,a5,0x5
    80207f5a:	97b6                	add	a5,a5,a3
    80207f5c:	1187b783          	ld	a5,280(a5)
    80207f60:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:141
      if (current_stride < min_stride)
    80207f64:	fb843703          	ld	a4,-72(s0)
    80207f68:	fc843783          	ld	a5,-56(s0)
    80207f6c:	00f77b63          	bgeu	a4,a5,80207f82 <task_manager_find_next_task+0xb2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:143
      {
        min_stride = current_stride;
    80207f70:	fb843783          	ld	a5,-72(s0)
    80207f74:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:144
        min_id = i;
    80207f78:	fd843783          	ld	a5,-40(s0)
    80207f7c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:145
        break; // Stop the loop once the first ready task is found.
    80207f80:	a035                	j	80207fac <task_manager_find_next_task+0xdc>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:148 (discriminator 2)
      }
    }
    checked++;
    80207f82:	fe043783          	ld	a5,-32(s0)
    80207f86:	0785                	addi	a5,a5,1
    80207f88:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:136 (discriminator 2)
  for (uint64_t i = start_id; checked < num_app; i = (i + 1) % num_app)
    80207f8c:	fd843783          	ld	a5,-40(s0)
    80207f90:	00178713          	addi	a4,a5,1
    80207f94:	fd043783          	ld	a5,-48(s0)
    80207f98:	02f777b3          	remu	a5,a4,a5
    80207f9c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:136 (discriminator 1)
    80207fa0:	fe043703          	ld	a4,-32(s0)
    80207fa4:	fd043783          	ld	a5,-48(s0)
    80207fa8:	f6f76ee3          	bltu	a4,a5,80207f24 <task_manager_find_next_task+0x54>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:151
  }

  return min_id;
    80207fac:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:152
}
    80207fb0:	853e                	mv	a0,a5
    80207fb2:	6426                	ld	s0,72(sp)
    80207fb4:	6161                	addi	sp,sp,80
    80207fb6:	8082                	ret

0000000080207fb8 <task_manager_run_next_task>:
task_manager_run_next_task():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:155

void task_manager_run_next_task()
{
    80207fb8:	7139                	addi	sp,sp,-64
    80207fba:	fc06                	sd	ra,56(sp)
    80207fbc:	f822                	sd	s0,48(sp)
    80207fbe:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:158
  extern void __switch(struct TaskContext * *current_task_cx_ptr2,
                       struct TaskContext * *next_task_cx_ptr2);
  int64_t next = task_manager_find_next_task();
    80207fc0:	f11ff0ef          	jal	ra,80207ed0 <task_manager_find_next_task>
    80207fc4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:159
  if (next >= 0)
    80207fc8:	fe843783          	ld	a5,-24(s0)
    80207fcc:	0e07cd63          	bltz	a5,802080c6 <task_manager_run_next_task+0x10e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:161
  {
    uint64_t current = TASK_MANAGER.current_task;
    80207fd0:	00b23717          	auipc	a4,0xb23
    80207fd4:	04870713          	addi	a4,a4,72 # 80d2b018 <TASK_MANAGER>
    80207fd8:	6785                	lui	a5,0x1
    80207fda:	97ba                	add	a5,a5,a4
    80207fdc:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    80207fe0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:162
    TASK_MANAGER.tasks[next].task_status = Running;
    80207fe4:	00b23697          	auipc	a3,0xb23
    80207fe8:	03468693          	addi	a3,a3,52 # 80d2b018 <TASK_MANAGER>
    80207fec:	fe843703          	ld	a4,-24(s0)
    80207ff0:	87ba                	mv	a5,a4
    80207ff2:	078e                	slli	a5,a5,0x3
    80207ff4:	97ba                	add	a5,a5,a4
    80207ff6:	0796                	slli	a5,a5,0x5
    80207ff8:	97b6                	add	a5,a5,a3
    80207ffa:	4709                	li	a4,2
    80207ffc:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:163
    uint64_t pass = BIG_STRIDE / TASK_MANAGER.tasks[next].priority;
    80208000:	00b23697          	auipc	a3,0xb23
    80208004:	01868693          	addi	a3,a3,24 # 80d2b018 <TASK_MANAGER>
    80208008:	fe843703          	ld	a4,-24(s0)
    8020800c:	87ba                	mv	a5,a4
    8020800e:	078e                	slli	a5,a5,0x3
    80208010:	97ba                	add	a5,a5,a4
    80208012:	0796                	slli	a5,a5,0x5
    80208014:	97b6                	add	a5,a5,a3
    80208016:	1107b783          	ld	a5,272(a5)
    8020801a:	6761                	lui	a4,0x18
    8020801c:	6a070713          	addi	a4,a4,1696 # 186a0 <n+0x18680>
    80208020:	02f757b3          	divu	a5,a4,a5
    80208024:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:164
    TASK_MANAGER.tasks[next].stride += pass;
    80208028:	00b23697          	auipc	a3,0xb23
    8020802c:	ff068693          	addi	a3,a3,-16 # 80d2b018 <TASK_MANAGER>
    80208030:	fe843703          	ld	a4,-24(s0)
    80208034:	87ba                	mv	a5,a4
    80208036:	078e                	slli	a5,a5,0x3
    80208038:	97ba                	add	a5,a5,a4
    8020803a:	0796                	slli	a5,a5,0x5
    8020803c:	97b6                	add	a5,a5,a3
    8020803e:	1187b703          	ld	a4,280(a5)
    80208042:	fd843783          	ld	a5,-40(s0)
    80208046:	00f706b3          	add	a3,a4,a5
    8020804a:	00b23617          	auipc	a2,0xb23
    8020804e:	fce60613          	addi	a2,a2,-50 # 80d2b018 <TASK_MANAGER>
    80208052:	fe843703          	ld	a4,-24(s0)
    80208056:	87ba                	mv	a5,a4
    80208058:	078e                	slli	a5,a5,0x3
    8020805a:	97ba                	add	a5,a5,a4
    8020805c:	0796                	slli	a5,a5,0x5
    8020805e:	97b2                	add	a5,a5,a2
    80208060:	10d7bc23          	sd	a3,280(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:165
    TASK_MANAGER.current_task = next;
    80208064:	fe843703          	ld	a4,-24(s0)
    80208068:	00b23697          	auipc	a3,0xb23
    8020806c:	fb068693          	addi	a3,a3,-80 # 80d2b018 <TASK_MANAGER>
    80208070:	6785                	lui	a5,0x1
    80208072:	97b6                	add	a5,a5,a3
    80208074:	68e7b023          	sd	a4,1664(a5) # 1680 <n+0x1660>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:167
    struct TaskContext **current_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[current]));
    80208078:	fe043703          	ld	a4,-32(s0)
    8020807c:	87ba                	mv	a5,a4
    8020807e:	078e                	slli	a5,a5,0x3
    80208080:	97ba                	add	a5,a5,a4
    80208082:	0796                	slli	a5,a5,0x5
    80208084:	00b23717          	auipc	a4,0xb23
    80208088:	f9470713          	addi	a4,a4,-108 # 80d2b018 <TASK_MANAGER>
    8020808c:	97ba                	add	a5,a5,a4
    8020808e:	853e                	mv	a0,a5
    80208090:	977ff0ef          	jal	ra,80207a06 <get_task_cx_ptr2>
    80208094:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:169
    struct TaskContext **next_task_cx_ptr2 =
        get_task_cx_ptr2(&(TASK_MANAGER.tasks[next]));
    80208098:	fe843703          	ld	a4,-24(s0)
    8020809c:	87ba                	mv	a5,a4
    8020809e:	078e                	slli	a5,a5,0x3
    802080a0:	97ba                	add	a5,a5,a4
    802080a2:	0796                	slli	a5,a5,0x5
    802080a4:	00b23717          	auipc	a4,0xb23
    802080a8:	f7470713          	addi	a4,a4,-140 # 80d2b018 <TASK_MANAGER>
    802080ac:	97ba                	add	a5,a5,a4
    802080ae:	853e                	mv	a0,a5
    802080b0:	957ff0ef          	jal	ra,80207a06 <get_task_cx_ptr2>
    802080b4:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:170
    __switch(current_task_cx_ptr2, next_task_cx_ptr2);
    802080b8:	fc843583          	ld	a1,-56(s0)
    802080bc:	fd043503          	ld	a0,-48(s0)
    802080c0:	503010ef          	jal	ra,80209dc2 <__switch>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:177
  else
  {
    mm_free();
    panic("All applications completed!\n");
  }
}
    802080c4:	a839                	j	802080e2 <task_manager_run_next_task+0x12a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:174
    mm_free();
    802080c6:	d28fe0ef          	jal	ra,802065ee <mm_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:175
    panic("All applications completed!\n");
    802080ca:	00002617          	auipc	a2,0x2
    802080ce:	73660613          	addi	a2,a2,1846 # 8020a800 <MMIO+0x68>
    802080d2:	0af00593          	li	a1,175
    802080d6:	00002517          	auipc	a0,0x2
    802080da:	74a50513          	addi	a0,a0,1866 # 8020a820 <MMIO+0x88>
    802080de:	efeff0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:177
}
    802080e2:	0001                	nop
    802080e4:	70e2                	ld	ra,56(sp)
    802080e6:	7442                	ld	s0,48(sp)
    802080e8:	6121                	addi	sp,sp,64
    802080ea:	8082                	ret

00000000802080ec <task_exit_current_and_run_next>:
task_exit_current_and_run_next():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:180

void task_exit_current_and_run_next()
{
    802080ec:	7135                	addi	sp,sp,-160
    802080ee:	ed06                	sd	ra,152(sp)
    802080f0:	e922                	sd	s0,144(sp)
    802080f2:	1100                	addi	s0,sp,160
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:181
  struct TaskControlBlock *task = processor_current_task();
    802080f4:	3a2000ef          	jal	ra,80208496 <processor_current_task>
    802080f8:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:182
  task->task_status = Zombie;
    802080fc:	fe043783          	ld	a5,-32(s0)
    80208100:	4711                	li	a4,4
    80208102:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:183
  task->exit_code = Exited;
    80208106:	fe043783          	ld	a5,-32(s0)
    8020810a:	470d                	li	a4,3
    8020810c:	10e7a423          	sw	a4,264(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:184
  struct TaskControlBlock **x = (struct TaskControlBlock **)(task->children.buffer);
    80208110:	fe043783          	ld	a5,-32(s0)
    80208114:	1007b783          	ld	a5,256(a5)
    80208118:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:185
  for (uint64_t i = 0; i < task->children.size; i++)
    8020811c:	fe043423          	sd	zero,-24(s0)
    80208120:	a081                	j	80208160 <task_exit_current_and_run_next+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:187 (discriminator 3)
  {
    x[i]->parent = &INITPROC;
    80208122:	fe843783          	ld	a5,-24(s0)
    80208126:	078e                	slli	a5,a5,0x3
    80208128:	fd843703          	ld	a4,-40(s0)
    8020812c:	97ba                	add	a5,a5,a4
    8020812e:	639c                	ld	a5,0(a5)
    80208130:	00b24717          	auipc	a4,0xb24
    80208134:	57870713          	addi	a4,a4,1400 # 80d2c6a8 <INITPROC>
    80208138:	f3f8                	sd	a4,224(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:188 (discriminator 3)
    vector_push(&INITPROC.children, x[i]);
    8020813a:	fe843783          	ld	a5,-24(s0)
    8020813e:	078e                	slli	a5,a5,0x3
    80208140:	fd843703          	ld	a4,-40(s0)
    80208144:	97ba                	add	a5,a5,a4
    80208146:	639c                	ld	a5,0(a5)
    80208148:	85be                	mv	a1,a5
    8020814a:	00b24517          	auipc	a0,0xb24
    8020814e:	64650513          	addi	a0,a0,1606 # 80d2c790 <INITPROC+0xe8>
    80208152:	77c010ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:185 (discriminator 3)
  for (uint64_t i = 0; i < task->children.size; i++)
    80208156:	fe843783          	ld	a5,-24(s0)
    8020815a:	0785                	addi	a5,a5,1
    8020815c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:185 (discriminator 1)
    80208160:	fe043783          	ld	a5,-32(s0)
    80208164:	77fc                	ld	a5,232(a5)
    80208166:	fe843703          	ld	a4,-24(s0)
    8020816a:	faf76ce3          	bltu	a4,a5,80208122 <task_exit_current_and_run_next+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:190
  }
  vector_free(&task->children);
    8020816e:	fe043783          	ld	a5,-32(s0)
    80208172:	0e878793          	addi	a5,a5,232
    80208176:	853e                	mv	a0,a5
    80208178:	0db010ef          	jal	ra,80209a52 <vector_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:191
  memory_set_recycle_data_pages(&task->memory_set);
    8020817c:	fe043783          	ld	a5,-32(s0)
    80208180:	09878793          	addi	a5,a5,152
    80208184:	853e                	mv	a0,a5
    80208186:	ef6fd0ef          	jal	ra,8020587c <memory_set_recycle_data_pages>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:192
  kernel_stack_free(&task->kernel_stack);
    8020818a:	fe043783          	ld	a5,-32(s0)
    8020818e:	07a1                	addi	a5,a5,8
    80208190:	853e                	mv	a0,a5
    80208192:	512000ef          	jal	ra,802086a4 <kernel_stack_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:194
  struct TaskContext _unused;
  task_context_zero_init(&_unused);
    80208196:	f6840793          	addi	a5,s0,-152
    8020819a:	853e                	mv	a0,a5
    8020819c:	8ebff0ef          	jal	ra,80207a86 <task_context_zero_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:195
  processor_schedule(&_unused);
    802081a0:	f6840793          	addi	a5,s0,-152
    802081a4:	853e                	mv	a0,a5
    802081a6:	3bc000ef          	jal	ra,80208562 <processor_schedule>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:196
}
    802081aa:	0001                	nop
    802081ac:	60ea                	ld	ra,152(sp)
    802081ae:	644a                	ld	s0,144(sp)
    802081b0:	610d                	addi	sp,sp,160
    802081b2:	8082                	ret

00000000802081b4 <task_manager_mark_current_suspended>:
task_manager_mark_current_suspended():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:199

void task_manager_mark_current_suspended()
{
    802081b4:	1101                	addi	sp,sp,-32
    802081b6:	ec22                	sd	s0,24(sp)
    802081b8:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:200
  uint64_t current = TASK_MANAGER.current_task;
    802081ba:	00b23717          	auipc	a4,0xb23
    802081be:	e5e70713          	addi	a4,a4,-418 # 80d2b018 <TASK_MANAGER>
    802081c2:	6785                	lui	a5,0x1
    802081c4:	97ba                	add	a5,a5,a4
    802081c6:	6807b783          	ld	a5,1664(a5) # 1680 <n+0x1660>
    802081ca:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:201
  TASK_MANAGER.tasks[current].task_status = Ready;
    802081ce:	00b23697          	auipc	a3,0xb23
    802081d2:	e4a68693          	addi	a3,a3,-438 # 80d2b018 <TASK_MANAGER>
    802081d6:	fe843703          	ld	a4,-24(s0)
    802081da:	87ba                	mv	a5,a4
    802081dc:	078e                	slli	a5,a5,0x3
    802081de:	97ba                	add	a5,a5,a4
    802081e0:	0796                	slli	a5,a5,0x5
    802081e2:	97b6                	add	a5,a5,a3
    802081e4:	4705                	li	a4,1
    802081e6:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:202
}
    802081ea:	0001                	nop
    802081ec:	6462                	ld	s0,24(sp)
    802081ee:	6105                	addi	sp,sp,32
    802081f0:	8082                	ret

00000000802081f2 <task_suspend_current_and_run_next>:
task_suspend_current_and_run_next():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:205

void task_suspend_current_and_run_next()
{
    802081f2:	1101                	addi	sp,sp,-32
    802081f4:	ec06                	sd	ra,24(sp)
    802081f6:	e822                	sd	s0,16(sp)
    802081f8:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:206
  struct TaskControlBlock *task = processor_current_task();
    802081fa:	29c000ef          	jal	ra,80208496 <processor_current_task>
    802081fe:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:207
  struct TaskContext *task_cx_ptr = &task->task_cx;
    80208202:	fe843783          	ld	a5,-24(s0)
    80208206:	02078793          	addi	a5,a5,32
    8020820a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:208
  task->task_status = Ready;
    8020820e:	fe843783          	ld	a5,-24(s0)
    80208212:	4705                	li	a4,1
    80208214:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:209
  task_manager_add_2(&TASK_MANAGER_2, task);
    80208218:	fe843583          	ld	a1,-24(s0)
    8020821c:	00b25517          	auipc	a0,0xb25
    80208220:	0b450513          	addi	a0,a0,180 # 80d2d2d0 <TASK_MANAGER_2>
    80208224:	9abff0ef          	jal	ra,80207bce <task_manager_add_2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:210
  processor_schedule(task_cx_ptr);
    80208228:	fe043503          	ld	a0,-32(s0)
    8020822c:	336000ef          	jal	ra,80208562 <processor_schedule>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:211
}
    80208230:	0001                	nop
    80208232:	60e2                	ld	ra,24(sp)
    80208234:	6442                	ld	s0,16(sp)
    80208236:	6105                	addi	sp,sp,32
    80208238:	8082                	ret

000000008020823a <task_control_block_fork>:
task_control_block_fork():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:214

struct TaskControlBlock *task_control_block_fork(struct TaskControlBlock *parent)
{
    8020823a:	715d                	addi	sp,sp,-80
    8020823c:	e486                	sd	ra,72(sp)
    8020823e:	e0a2                	sd	s0,64(sp)
    80208240:	fc26                	sd	s1,56(sp)
    80208242:	0880                	addi	s0,sp,80
    80208244:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:215
  struct TaskControlBlock *s = (struct TaskControlBlock *)bd_malloc(sizeof(struct TaskControlBlock));
    80208248:	12000513          	li	a0,288
    8020824c:	fc6fe0ef          	jal	ra,80206a12 <bd_malloc>
    80208250:	87aa                	mv	a5,a0
    80208252:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:218

  // copy user space (include trap context)
  memory_set_from_existed_user(&s->memory_set, &parent->memory_set);
    80208256:	fc843783          	ld	a5,-56(s0)
    8020825a:	09878713          	addi	a4,a5,152
    8020825e:	fb843783          	ld	a5,-72(s0)
    80208262:	09878793          	addi	a5,a5,152
    80208266:	85be                	mv	a1,a5
    80208268:	853a                	mv	a0,a4
    8020826a:	c6efd0ef          	jal	ra,802056d8 <memory_set_from_existed_user>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:219
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
    8020826e:	fc843783          	ld	a5,-56(s0)
    80208272:	09878713          	addi	a4,a5,152
    80208276:	77f9                	lui	a5,0xffffe
    80208278:	00c7d593          	srli	a1,a5,0xc
    8020827c:	853a                	mv	a0,a4
    8020827e:	dd4fd0ef          	jal	ra,80205852 <memory_set_translate>
    80208282:	87aa                	mv	a5,a0
    80208284:	639c                	ld	a5,0(a5)
    80208286:	00a7d693          	srli	a3,a5,0xa
    8020828a:	fc843783          	ld	a5,-56(s0)
    8020828e:	577d                	li	a4,-1
    80208290:	8351                	srli	a4,a4,0x14
    80208292:	8f75                	and	a4,a4,a3
    80208294:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:223
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // alloc a pid and a kernel stack in kernel space
  s->pid = PidAllocator_alloc();
    80208296:	fc843483          	ld	s1,-56(s0)
    8020829a:	0cb000ef          	jal	ra,80208b64 <PidAllocator_alloc>
    8020829e:	e088                	sd	a0,0(s1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:224
  kernel_stack_new(&s->kernel_stack, s->pid);
    802082a0:	fc843783          	ld	a5,-56(s0)
    802082a4:	00878713          	addi	a4,a5,8 # ffffffffffffe008 <ebss+0xffffffff7f2d0008>
    802082a8:	fc843783          	ld	a5,-56(s0)
    802082ac:	638c                	ld	a1,0(a5)
    802082ae:	853a                	mv	a0,a4
    802082b0:	396000ef          	jal	ra,80208646 <kernel_stack_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:225
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);
    802082b4:	fc843783          	ld	a5,-56(s0)
    802082b8:	6788                	ld	a0,8(a5)
    802082ba:	35c000ef          	jal	ra,80208616 <kernel_stack_get_top>
    802082be:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:227

  s->base_size = parent->base_size;
    802082c2:	fc843783          	ld	a5,-56(s0)
    802082c6:	fb843703          	ld	a4,-72(s0)
    802082ca:	6f18                	ld	a4,24(a4)
    802082cc:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:228
  task_context_goto_trap_return(&s->task_cx, kernel_stack_top);
    802082ce:	fc843783          	ld	a5,-56(s0)
    802082d2:	02078793          	addi	a5,a5,32
    802082d6:	fd843583          	ld	a1,-40(s0)
    802082da:	853e                	mv	a0,a5
    802082dc:	7fc000ef          	jal	ra,80208ad8 <task_context_goto_trap_return>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:229
  s->task_status = Ready;
    802082e0:	fc843783          	ld	a5,-56(s0)
    802082e4:	4705                	li	a4,1
    802082e6:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:230
  s->parent = parent;
    802082ea:	fc843783          	ld	a5,-56(s0)
    802082ee:	fb843703          	ld	a4,-72(s0)
    802082f2:	f3f8                	sd	a4,224(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:231
  vector_new(&s->children, sizeof(struct TaskControlBlock *));
    802082f4:	fc843783          	ld	a5,-56(s0)
    802082f8:	0e878793          	addi	a5,a5,232
    802082fc:	45a1                	li	a1,8
    802082fe:	853e                	mv	a0,a5
    80208300:	57c010ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:232
  s->exit_code = 0;
    80208304:	fc843783          	ld	a5,-56(s0)
    80208308:	1007a423          	sw	zero,264(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:234

  s->priority = parent->priority;
    8020830c:	fc843783          	ld	a5,-56(s0)
    80208310:	fb843703          	ld	a4,-72(s0)
    80208314:	11073703          	ld	a4,272(a4)
    80208318:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:235
  s->stride = parent->stride;
    8020831c:	fc843783          	ld	a5,-56(s0)
    80208320:	fb843703          	ld	a4,-72(s0)
    80208324:	11873703          	ld	a4,280(a4)
    80208328:	10e7bc23          	sd	a4,280(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:238

  // add child
  vector_push(&parent->children, &s);
    8020832c:	fb843783          	ld	a5,-72(s0)
    80208330:	0e878793          	addi	a5,a5,232
    80208334:	fc840713          	addi	a4,s0,-56
    80208338:	85ba                	mv	a1,a4
    8020833a:	853e                	mv	a0,a5
    8020833c:	592010ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:241

  // prepare TrapContext in user space
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
    80208340:	fc843783          	ld	a5,-56(s0)
    80208344:	853e                	mv	a0,a5
    80208346:	cd4ff0ef          	jal	ra,8020781a <task_control_block_get_trap_cx>
    8020834a:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:242
  trap_cx->kernel_sp = kernel_stack_top;
    8020834e:	fd043783          	ld	a5,-48(s0)
    80208352:	fd843703          	ld	a4,-40(s0)
    80208356:	10e7bc23          	sd	a4,280(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:244

  return s;
    8020835a:	fc843783          	ld	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:245
}
    8020835e:	853e                	mv	a0,a5
    80208360:	60a6                	ld	ra,72(sp)
    80208362:	6406                	ld	s0,64(sp)
    80208364:	74e2                	ld	s1,56(sp)
    80208366:	6161                	addi	sp,sp,80
    80208368:	8082                	ret

000000008020836a <task_control_block_exec>:
task_control_block_exec():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:249

void task_control_block_exec(struct TaskControlBlock *s, uint8_t *elf_data,
                             size_t elf_size)
{
    8020836a:	711d                	addi	sp,sp,-96
    8020836c:	ec86                	sd	ra,88(sp)
    8020836e:	e8a2                	sd	s0,80(sp)
    80208370:	e4a6                	sd	s1,72(sp)
    80208372:	e0ca                	sd	s2,64(sp)
    80208374:	1080                	addi	s0,sp,96
    80208376:	faa43c23          	sd	a0,-72(s0)
    8020837a:	fab43823          	sd	a1,-80(s0)
    8020837e:	fac43423          	sd	a2,-88(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:253
  // memory_set with elf program headers/trampoline/trap context/user stack
  uint64_t user_sp;
  uint64_t entry_point;
  memory_set_free(&s->memory_set);
    80208382:	fb843783          	ld	a5,-72(s0)
    80208386:	09878793          	addi	a5,a5,152
    8020838a:	853e                	mv	a0,a5
    8020838c:	d0bfc0ef          	jal	ra,80205096 <memory_set_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:256

  // substitute memory_set
  memory_set_from_elf(&s->memory_set, elf_data, elf_size, &user_sp,
    80208390:	fb843783          	ld	a5,-72(s0)
    80208394:	09878793          	addi	a5,a5,152
    80208398:	fc040713          	addi	a4,s0,-64
    8020839c:	fc840693          	addi	a3,s0,-56
    802083a0:	fa843603          	ld	a2,-88(s0)
    802083a4:	fb043583          	ld	a1,-80(s0)
    802083a8:	853e                	mv	a0,a5
    802083aa:	f89fc0ef          	jal	ra,80205332 <memory_set_from_elf>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:260
                      &entry_point);

  // update trap_cx ppn
  s->trap_cx_ppn = (PhysPageNum)pte_ppn(*memory_set_translate(
    802083ae:	fb843783          	ld	a5,-72(s0)
    802083b2:	09878713          	addi	a4,a5,152
    802083b6:	77f9                	lui	a5,0xffffe
    802083b8:	00c7d593          	srli	a1,a5,0xc
    802083bc:	853a                	mv	a0,a4
    802083be:	c94fd0ef          	jal	ra,80205852 <memory_set_translate>
    802083c2:	87aa                	mv	a5,a0
    802083c4:	639c                	ld	a5,0(a5)
    802083c6:	00a7d713          	srli	a4,a5,0xa
    802083ca:	57fd                	li	a5,-1
    802083cc:	83d1                	srli	a5,a5,0x14
    802083ce:	8f7d                	and	a4,a4,a5
    802083d0:	fb843783          	ld	a5,-72(s0)
    802083d4:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:264
      &s->memory_set, (VirtPageNum)addr2pn((VirtAddr)TRAP_CONTEXT)));

  // initialize trap_cx
  struct TrapContext *trap_cx = task_control_block_get_trap_cx(s);
    802083d6:	fb843503          	ld	a0,-72(s0)
    802083da:	c40ff0ef          	jal	ra,8020781a <task_control_block_get_trap_cx>
    802083de:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:265
  uint64_t kernel_stack_top = kernel_stack_get_top(s->kernel_stack);
    802083e2:	fb843783          	ld	a5,-72(s0)
    802083e6:	6788                	ld	a0,8(a5)
    802083e8:	22e000ef          	jal	ra,80208616 <kernel_stack_get_top>
    802083ec:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:266
  app_init_context(entry_point, user_sp, kernel_space_token(), kernel_stack_top,
    802083f0:	fc043483          	ld	s1,-64(s0)
    802083f4:	fc843903          	ld	s2,-56(s0)
    802083f8:	d02fd0ef          	jal	ra,802058fa <kernel_space_token>
    802083fc:	862a                	mv	a2,a0
    802083fe:	00001717          	auipc	a4,0x1
    80208402:	92470713          	addi	a4,a4,-1756 # 80208d22 <trap_handler>
    80208406:	fd843783          	ld	a5,-40(s0)
    8020840a:	fd043683          	ld	a3,-48(s0)
    8020840e:	85ca                	mv	a1,s2
    80208410:	8526                	mv	a0,s1
    80208412:	614000ef          	jal	ra,80208a26 <app_init_context>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/batch.c:268
                   (uint64_t)trap_handler, trap_cx);
}
    80208416:	0001                	nop
    80208418:	60e6                	ld	ra,88(sp)
    8020841a:	6446                	ld	s0,80(sp)
    8020841c:	64a6                	ld	s1,72(sp)
    8020841e:	6906                	ld	s2,64(sp)
    80208420:	6125                	addi	sp,sp,96
    80208422:	8082                	ret

0000000080208424 <processor_init>:
processor_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:11

extern void __switch(struct TaskContext *current_task_cx_ptr,
                     struct TaskContext *next_task_cx_ptr);

void processor_init(Processor *processor)
{
    80208424:	1101                	addi	sp,sp,-32
    80208426:	ec06                	sd	ra,24(sp)
    80208428:	e822                	sd	s0,16(sp)
    8020842a:	1000                	addi	s0,sp,32
    8020842c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:12
  processor->current = NULL;
    80208430:	fe843783          	ld	a5,-24(s0)
    80208434:	0007b023          	sd	zero,0(a5) # ffffffffffffe000 <ebss+0xffffffff7f2d0000>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:13
  task_context_zero_init(&processor->idle_task_cx);
    80208438:	fe843783          	ld	a5,-24(s0)
    8020843c:	07a1                	addi	a5,a5,8
    8020843e:	853e                	mv	a0,a5
    80208440:	e46ff0ef          	jal	ra,80207a86 <task_context_zero_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:14
}
    80208444:	0001                	nop
    80208446:	60e2                	ld	ra,24(sp)
    80208448:	6442                	ld	s0,16(sp)
    8020844a:	6105                	addi	sp,sp,32
    8020844c:	8082                	ret

000000008020844e <processor_take_current>:
processor_take_current():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:17

struct TaskControlBlock *processor_take_current(Processor *processor)
{
    8020844e:	1101                	addi	sp,sp,-32
    80208450:	ec22                	sd	s0,24(sp)
    80208452:	1000                	addi	s0,sp,32
    80208454:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:18
  return processor->current;
    80208458:	fe843783          	ld	a5,-24(s0)
    8020845c:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:19
}
    8020845e:	853e                	mv	a0,a5
    80208460:	6462                	ld	s0,24(sp)
    80208462:	6105                	addi	sp,sp,32
    80208464:	8082                	ret

0000000080208466 <processor_get_idle_task_cx_ptr>:
processor_get_idle_task_cx_ptr():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:22

struct TaskContext *processor_get_idle_task_cx_ptr(Processor *processor)
{
    80208466:	1101                	addi	sp,sp,-32
    80208468:	ec22                	sd	s0,24(sp)
    8020846a:	1000                	addi	s0,sp,32
    8020846c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:23
  return &processor->idle_task_cx;
    80208470:	fe843783          	ld	a5,-24(s0)
    80208474:	07a1                	addi	a5,a5,8
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:24
}
    80208476:	853e                	mv	a0,a5
    80208478:	6462                	ld	s0,24(sp)
    8020847a:	6105                	addi	sp,sp,32
    8020847c:	8082                	ret

000000008020847e <processor_current>:
processor_current():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:27

static struct TaskControlBlock *processor_current(Processor *processor)
{
    8020847e:	1101                	addi	sp,sp,-32
    80208480:	ec22                	sd	s0,24(sp)
    80208482:	1000                	addi	s0,sp,32
    80208484:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:28
  return processor->current;
    80208488:	fe843783          	ld	a5,-24(s0)
    8020848c:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:29
}
    8020848e:	853e                	mv	a0,a5
    80208490:	6462                	ld	s0,24(sp)
    80208492:	6105                	addi	sp,sp,32
    80208494:	8082                	ret

0000000080208496 <processor_current_task>:
processor_current_task():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:32

struct TaskControlBlock *processor_current_task()
{
    80208496:	1141                	addi	sp,sp,-16
    80208498:	e406                	sd	ra,8(sp)
    8020849a:	e022                	sd	s0,0(sp)
    8020849c:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:33
  return processor_current(&PROCESSOR);
    8020849e:	00b24517          	auipc	a0,0xb24
    802084a2:	47a50513          	addi	a0,a0,1146 # 80d2c918 <PROCESSOR>
    802084a6:	fd9ff0ef          	jal	ra,8020847e <processor_current>
    802084aa:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:34
}
    802084ac:	853e                	mv	a0,a5
    802084ae:	60a2                	ld	ra,8(sp)
    802084b0:	6402                	ld	s0,0(sp)
    802084b2:	0141                	addi	sp,sp,16
    802084b4:	8082                	ret

00000000802084b6 <processor_current_user_token>:
processor_current_user_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:37

uint64_t processor_current_user_token()
{
    802084b6:	1101                	addi	sp,sp,-32
    802084b8:	ec06                	sd	ra,24(sp)
    802084ba:	e822                	sd	s0,16(sp)
    802084bc:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:38
  struct TaskControlBlock *task = processor_current_task();
    802084be:	fd9ff0ef          	jal	ra,80208496 <processor_current_task>
    802084c2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:39
  return task_control_block_get_user_token(task);
    802084c6:	fe843503          	ld	a0,-24(s0)
    802084ca:	e10ff0ef          	jal	ra,80207ada <task_control_block_get_user_token>
    802084ce:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:40
}
    802084d0:	853e                	mv	a0,a5
    802084d2:	60e2                	ld	ra,24(sp)
    802084d4:	6442                	ld	s0,16(sp)
    802084d6:	6105                	addi	sp,sp,32
    802084d8:	8082                	ret

00000000802084da <processor_run_tasks>:
processor_run_tasks():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:43

void processor_run_tasks()
{
    802084da:	7179                	addi	sp,sp,-48
    802084dc:	f406                	sd	ra,40(sp)
    802084de:	f022                	sd	s0,32(sp)
    802084e0:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:44
  processor_init(&PROCESSOR);
    802084e2:	00b24517          	auipc	a0,0xb24
    802084e6:	43650513          	addi	a0,a0,1078 # 80d2c918 <PROCESSOR>
    802084ea:	f3bff0ef          	jal	ra,80208424 <processor_init>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:50
  struct TaskControlBlock *task;
  struct TaskContext *idle_task_cx_ptr;
  struct TaskContext *next_task_cx_ptr;
  while (1)
  {
    task = task_manager_fetch_task();
    802084ee:	f2eff0ef          	jal	ra,80207c1c <task_manager_fetch_task>
    802084f2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:51
    if (task)
    802084f6:	fe843783          	ld	a5,-24(s0)
    802084fa:	dbf5                	beqz	a5,802084ee <processor_run_tasks+0x14>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:53
    {
      idle_task_cx_ptr = processor_get_idle_task_cx_ptr(&PROCESSOR);
    802084fc:	00b24517          	auipc	a0,0xb24
    80208500:	41c50513          	addi	a0,a0,1052 # 80d2c918 <PROCESSOR>
    80208504:	f63ff0ef          	jal	ra,80208466 <processor_get_idle_task_cx_ptr>
    80208508:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:54
      next_task_cx_ptr = &task->task_cx;
    8020850c:	fe843783          	ld	a5,-24(s0)
    80208510:	02078793          	addi	a5,a5,32
    80208514:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:55
      task->task_status = Running;
    80208518:	fe843783          	ld	a5,-24(s0)
    8020851c:	4709                	li	a4,2
    8020851e:	08e7a823          	sw	a4,144(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:56
      PROCESSOR.current = task;
    80208522:	00b24797          	auipc	a5,0xb24
    80208526:	3f678793          	addi	a5,a5,1014 # 80d2c918 <PROCESSOR>
    8020852a:	fe843703          	ld	a4,-24(s0)
    8020852e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:57
      __switch(idle_task_cx_ptr, next_task_cx_ptr);
    80208530:	fd843583          	ld	a1,-40(s0)
    80208534:	fe043503          	ld	a0,-32(s0)
    80208538:	08b010ef          	jal	ra,80209dc2 <__switch>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:50
    task = task_manager_fetch_task();
    8020853c:	bf4d                	j	802084ee <processor_run_tasks+0x14>

000000008020853e <processor_current_trap_cx>:
processor_current_trap_cx():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:63
    }
  }
}

struct TrapContext *processor_current_trap_cx()
{
    8020853e:	1101                	addi	sp,sp,-32
    80208540:	ec06                	sd	ra,24(sp)
    80208542:	e822                	sd	s0,16(sp)
    80208544:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:64
  struct TaskControlBlock *task = processor_current_task();
    80208546:	f51ff0ef          	jal	ra,80208496 <processor_current_task>
    8020854a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:65
  return task_control_block_get_trap_cx(task);
    8020854e:	fe843503          	ld	a0,-24(s0)
    80208552:	ac8ff0ef          	jal	ra,8020781a <task_control_block_get_trap_cx>
    80208556:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:66
}
    80208558:	853e                	mv	a0,a5
    8020855a:	60e2                	ld	ra,24(sp)
    8020855c:	6442                	ld	s0,16(sp)
    8020855e:	6105                	addi	sp,sp,32
    80208560:	8082                	ret

0000000080208562 <processor_schedule>:
processor_schedule():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:69

void processor_schedule(struct TaskContext *switched_task_cx_ptr)
{
    80208562:	7179                	addi	sp,sp,-48
    80208564:	f406                	sd	ra,40(sp)
    80208566:	f022                	sd	s0,32(sp)
    80208568:	1800                	addi	s0,sp,48
    8020856a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:70
  struct TaskContext *idle_task_cx_ptr = processor_get_idle_task_cx_ptr(&PROCESSOR);
    8020856e:	00b24517          	auipc	a0,0xb24
    80208572:	3aa50513          	addi	a0,a0,938 # 80d2c918 <PROCESSOR>
    80208576:	ef1ff0ef          	jal	ra,80208466 <processor_get_idle_task_cx_ptr>
    8020857a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:71
  __switch(switched_task_cx_ptr, idle_task_cx_ptr);
    8020857e:	fe843583          	ld	a1,-24(s0)
    80208582:	fd843503          	ld	a0,-40(s0)
    80208586:	03d010ef          	jal	ra,80209dc2 <__switch>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/processor/processor.c:72
}
    8020858a:	0001                	nop
    8020858c:	70a2                	ld	ra,40(sp)
    8020858e:	7402                	ld	s0,32(sp)
    80208590:	6145                	addi	sp,sp,48
    80208592:	8082                	ret

0000000080208594 <kernel_stack_position>:
kernel_stack_position():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:34
//     *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
//     return stackTop; // 返回新的栈顶地址
// }

void kernel_stack_position(uint64_t app_id, uint64_t *bottom, uint64_t *top) 
{
    80208594:	7179                	addi	sp,sp,-48
    80208596:	f422                	sd	s0,40(sp)
    80208598:	1800                	addi	s0,sp,48
    8020859a:	fea43423          	sd	a0,-24(s0)
    8020859e:	feb43023          	sd	a1,-32(s0)
    802085a2:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:35
    *top = TRAMPOLINE - app_id * (KERNEL_STACK_SIZE + PAGE_SIZE);
    802085a6:	fe843703          	ld	a4,-24(s0)
    802085aa:	87ba                	mv	a5,a4
    802085ac:	0786                	slli	a5,a5,0x1
    802085ae:	97ba                	add	a5,a5,a4
    802085b0:	07b2                	slli	a5,a5,0xc
    802085b2:	873e                	mv	a4,a5
    802085b4:	77fd                	lui	a5,0xfffff
    802085b6:	40e78733          	sub	a4,a5,a4
    802085ba:	fd843783          	ld	a5,-40(s0)
    802085be:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:36
    *bottom = *top - KERNEL_STACK_SIZE;
    802085c0:	fd843783          	ld	a5,-40(s0)
    802085c4:	6398                	ld	a4,0(a5)
    802085c6:	77f9                	lui	a5,0xffffe
    802085c8:	973e                	add	a4,a4,a5
    802085ca:	fe043783          	ld	a5,-32(s0)
    802085ce:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:37
}
    802085d0:	0001                	nop
    802085d2:	7422                	ld	s0,40(sp)
    802085d4:	6145                	addi	sp,sp,48
    802085d6:	8082                	ret

00000000802085d8 <kernel_stack_push_on_top>:
kernel_stack_push_on_top():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:40

void* kernel_stack_push_on_top(struct KernelStack stack, void* value)
{
    802085d8:	7179                	addi	sp,sp,-48
    802085da:	f406                	sd	ra,40(sp)
    802085dc:	f022                	sd	s0,32(sp)
    802085de:	1800                	addi	s0,sp,48
    802085e0:	fca43c23          	sd	a0,-40(s0)
    802085e4:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:41
    uint64_t kernel_stack_top = kernel_stack_get_top(stack);
    802085e8:	fd843503          	ld	a0,-40(s0)
    802085ec:	02a000ef          	jal	ra,80208616 <kernel_stack_get_top>
    802085f0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:42
    void* ptr = (void*)(kernel_stack_top - sizeof(void*));
    802085f4:	fe843783          	ld	a5,-24(s0)
    802085f8:	17e1                	addi	a5,a5,-8
    802085fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:43
    *(void**)ptr = value;
    802085fe:	fe043783          	ld	a5,-32(s0)
    80208602:	fd043703          	ld	a4,-48(s0)
    80208606:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:44
    return ptr;
    80208608:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:45
}
    8020860c:	853e                	mv	a0,a5
    8020860e:	70a2                	ld	ra,40(sp)
    80208610:	7402                	ld	s0,32(sp)
    80208612:	6145                	addi	sp,sp,48
    80208614:	8082                	ret

0000000080208616 <kernel_stack_get_top>:
kernel_stack_get_top():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:48

uint64_t kernel_stack_get_top(struct KernelStack stack)
{
    80208616:	7179                	addi	sp,sp,-48
    80208618:	f406                	sd	ra,40(sp)
    8020861a:	f022                	sd	s0,32(sp)
    8020861c:	1800                	addi	s0,sp,48
    8020861e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:50
    uint64_t bottom, top;
    kernel_stack_position(stack.pid.pid, &bottom, &top);
    80208622:	fd843783          	ld	a5,-40(s0)
    80208626:	fe040693          	addi	a3,s0,-32
    8020862a:	fe840713          	addi	a4,s0,-24
    8020862e:	8636                	mv	a2,a3
    80208630:	85ba                	mv	a1,a4
    80208632:	853e                	mv	a0,a5
    80208634:	f61ff0ef          	jal	ra,80208594 <kernel_stack_position>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:51
    return top;
    80208638:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:52
}
    8020863c:	853e                	mv	a0,a5
    8020863e:	70a2                	ld	ra,40(sp)
    80208640:	7402                	ld	s0,32(sp)
    80208642:	6145                	addi	sp,sp,48
    80208644:	8082                	ret

0000000080208646 <kernel_stack_new>:
kernel_stack_new():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:54

void kernel_stack_new(struct KernelStack *ks, PidHandle pid) {
    80208646:	7179                	addi	sp,sp,-48
    80208648:	f406                	sd	ra,40(sp)
    8020864a:	f022                	sd	s0,32(sp)
    8020864c:	1800                	addi	s0,sp,48
    8020864e:	fca43c23          	sd	a0,-40(s0)
    80208652:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:55
  uint64_t kernel_stack_bottom = kernel_stack_position_bottom(pid.pid);
    80208656:	fd043703          	ld	a4,-48(s0)
    8020865a:	87ba                	mv	a5,a4
    8020865c:	0786                	slli	a5,a5,0x1
    8020865e:	97ba                	add	a5,a5,a4
    80208660:	07b2                	slli	a5,a5,0xc
    80208662:	873e                	mv	a4,a5
    80208664:	77f5                	lui	a5,0xffffd
    80208666:	8f99                	sub	a5,a5,a4
    80208668:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:56
  uint64_t kernel_stack_top = kernel_stack_position_top(pid.pid);
    8020866c:	fd043703          	ld	a4,-48(s0)
    80208670:	87ba                	mv	a5,a4
    80208672:	0786                	slli	a5,a5,0x1
    80208674:	97ba                	add	a5,a5,a4
    80208676:	07b2                	slli	a5,a5,0xc
    80208678:	873e                	mv	a4,a5
    8020867a:	77fd                	lui	a5,0xfffff
    8020867c:	8f99                	sub	a5,a5,a4
    8020867e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:57
  kernel_space_insert_framed_area(kernel_stack_bottom, kernel_stack_top,
    80208682:	4619                	li	a2,6
    80208684:	fe043583          	ld	a1,-32(s0)
    80208688:	fe843503          	ld	a0,-24(s0)
    8020868c:	a0efd0ef          	jal	ra,8020589a <kernel_space_insert_framed_area>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:59
                                  MAP_PERM_R | MAP_PERM_W);
  ks->pid = pid;
    80208690:	fd843783          	ld	a5,-40(s0)
    80208694:	fd043703          	ld	a4,-48(s0)
    80208698:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:60
}
    8020869a:	0001                	nop
    8020869c:	70a2                	ld	ra,40(sp)
    8020869e:	7402                	ld	s0,32(sp)
    802086a0:	6145                	addi	sp,sp,48
    802086a2:	8082                	ret

00000000802086a4 <kernel_stack_free>:
kernel_stack_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:64


void kernel_stack_free(struct KernelStack* ks)
{
    802086a4:	7179                	addi	sp,sp,-48
    802086a6:	f406                	sd	ra,40(sp)
    802086a8:	f022                	sd	s0,32(sp)
    802086aa:	1800                	addi	s0,sp,48
    802086ac:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:66
    VirtAddr kernel_stack_bottom_va =
      (VirtAddr)kernel_stack_position_bottom(ks->pid.pid);
    802086b0:	fd843783          	ld	a5,-40(s0)
    802086b4:	6398                	ld	a4,0(a5)
    802086b6:	87ba                	mv	a5,a4
    802086b8:	0786                	slli	a5,a5,0x1
    802086ba:	97ba                	add	a5,a5,a4
    802086bc:	07b2                	slli	a5,a5,0xc
    802086be:	873e                	mv	a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:65
    VirtAddr kernel_stack_bottom_va =
    802086c0:	77f5                	lui	a5,0xffffd
    802086c2:	8f99                	sub	a5,a5,a4
    802086c4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:67
    VirtPageNum kernel_stack_bottom_vpn = addr2pn(kernel_stack_bottom_va);
    802086c8:	fe843783          	ld	a5,-24(s0)
    802086cc:	83b1                	srli	a5,a5,0xc
    802086ce:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:68
    kernel_space_remove_area_with_start_vpn(kernel_stack_bottom_vpn);
    802086d2:	fe043503          	ld	a0,-32(s0)
    802086d6:	9fefd0ef          	jal	ra,802058d4 <kernel_space_remove_area_with_start_vpn>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/stack/stack.c:69
}
    802086da:	0001                	nop
    802086dc:	70a2                	ld	ra,40(sp)
    802086de:	7402                	ld	s0,32(sp)
    802086e0:	6145                	addi	sp,sp,48
    802086e2:	8082                	ret

00000000802086e4 <loader_get_num_app>:
loader_get_num_app():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:8
#include "task.h"
#include "string.h"
#include "loader.h"
char APP_NAMES[MAX_APP_NUM][MAX_APP_NAME_LENGTH];
uint64_t loader_get_num_app() 
{
    802086e4:	1141                	addi	sp,sp,-16
    802086e6:	e422                	sd	s0,8(sp)
    802086e8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:10
  extern uint64_t _num_app[];
  return _num_app[0];
    802086ea:	00003797          	auipc	a5,0x3
    802086ee:	94e78793          	addi	a5,a5,-1714 # 8020b038 <_num_app>
    802086f2:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:11
}
    802086f4:	853e                	mv	a0,a5
    802086f6:	6422                	ld	s0,8(sp)
    802086f8:	0141                	addi	sp,sp,16
    802086fa:	8082                	ret

00000000802086fc <loader_get_app_data>:
loader_get_app_data():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:14

uint8_t *loader_get_app_data(uint64_t app_id) 
{
    802086fc:	1101                	addi	sp,sp,-32
    802086fe:	ec06                	sd	ra,24(sp)
    80208700:	e822                	sd	s0,16(sp)
    80208702:	1000                	addi	s0,sp,32
    80208704:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:15
    ASSERT(app_id < loader_get_num_app());
    80208708:	fddff0ef          	jal	ra,802086e4 <loader_get_num_app>
    8020870c:	872a                	mv	a4,a0
    8020870e:	fe843783          	ld	a5,-24(s0)
    80208712:	00e7ed63          	bltu	a5,a4,8020872c <loader_get_app_data+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:15 (discriminator 1)
    80208716:	00002617          	auipc	a2,0x2
    8020871a:	15260613          	addi	a2,a2,338 # 8020a868 <MMIO+0x10>
    8020871e:	45bd                	li	a1,15
    80208720:	00002517          	auipc	a0,0x2
    80208724:	17850513          	addi	a0,a0,376 # 8020a898 <MMIO+0x40>
    80208728:	8b4ff0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:23
    {
    &app_0_start,
    &app_1_start,
    &app_2_start
    };
    return app_starts[app_id];
    8020872c:	00003717          	auipc	a4,0x3
    80208730:	8d470713          	addi	a4,a4,-1836 # 8020b000 <app_starts.1>
    80208734:	fe843783          	ld	a5,-24(s0)
    80208738:	078e                	slli	a5,a5,0x3
    8020873a:	97ba                	add	a5,a5,a4
    8020873c:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:24
}
    8020873e:	853e                	mv	a0,a5
    80208740:	60e2                	ld	ra,24(sp)
    80208742:	6442                	ld	s0,16(sp)
    80208744:	6105                	addi	sp,sp,32
    80208746:	8082                	ret

0000000080208748 <loader_get_app_size>:
loader_get_app_size():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:28


size_t loader_get_app_size(uint64_t app_id) 
{
    80208748:	7179                	addi	sp,sp,-48
    8020874a:	f406                	sd	ra,40(sp)
    8020874c:	f022                	sd	s0,32(sp)
    8020874e:	1800                	addi	s0,sp,48
    80208750:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:32
    //printk("loader_get_app_size start\n");
    
    // 确保提供的 app_id 是有效的
    uint64_t num_app = loader_get_num_app();
    80208754:	f91ff0ef          	jal	ra,802086e4 <loader_get_num_app>
    80208758:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:33
    ASSERT(app_id < num_app);
    8020875c:	fd843703          	ld	a4,-40(s0)
    80208760:	fe843783          	ld	a5,-24(s0)
    80208764:	00f76e63          	bltu	a4,a5,80208780 <loader_get_app_size+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:33 (discriminator 1)
    80208768:	00002617          	auipc	a2,0x2
    8020876c:	15060613          	addi	a2,a2,336 # 8020a8b8 <MMIO+0x60>
    80208770:	02100593          	li	a1,33
    80208774:	00002517          	auipc	a0,0x2
    80208778:	12450513          	addi	a0,a0,292 # 8020a898 <MMIO+0x40>
    8020877c:	860ff0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:46
        &app_2_start,
        &app_2_end, // 用于计算最后一个应用程序的大小
    };

    // 计算并返回应用程序的大小
    size_t app_size = app_starts_ends[app_id + 1] - app_starts_ends[app_id];
    80208780:	fd843783          	ld	a5,-40(s0)
    80208784:	0785                	addi	a5,a5,1
    80208786:	00003717          	auipc	a4,0x3
    8020878a:	89270713          	addi	a4,a4,-1902 # 8020b018 <app_starts_ends.0>
    8020878e:	078e                	slli	a5,a5,0x3
    80208790:	97ba                	add	a5,a5,a4
    80208792:	6398                	ld	a4,0(a5)
    80208794:	00003697          	auipc	a3,0x3
    80208798:	88468693          	addi	a3,a3,-1916 # 8020b018 <app_starts_ends.0>
    8020879c:	fd843783          	ld	a5,-40(s0)
    802087a0:	078e                	slli	a5,a5,0x3
    802087a2:	97b6                	add	a5,a5,a3
    802087a4:	639c                	ld	a5,0(a5)
    802087a6:	40f707b3          	sub	a5,a4,a5
    802087aa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:47
    return app_size;
    802087ae:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:48
}
    802087b2:	853e                	mv	a0,a5
    802087b4:	70a2                	ld	ra,40(sp)
    802087b6:	7402                	ld	s0,32(sp)
    802087b8:	6145                	addi	sp,sp,48
    802087ba:	8082                	ret

00000000802087bc <loader_init_and_list_apps>:
loader_init_and_list_apps():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:52


void loader_init_and_list_apps() 
{
    802087bc:	7179                	addi	sp,sp,-48
    802087be:	f406                	sd	ra,40(sp)
    802087c0:	f022                	sd	s0,32(sp)
    802087c2:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:54
  extern uint64_t _app_names;
  uint64_t num_app = loader_get_num_app();
    802087c4:	f21ff0ef          	jal	ra,802086e4 <loader_get_num_app>
    802087c8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:55
  uint8_t *ptr = (uint8_t *)&_app_names;
    802087cc:	00003797          	auipc	a5,0x3
    802087d0:	89478793          	addi	a5,a5,-1900 # 8020b060 <_app_names>
    802087d4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:56
  for (uint64_t i = 0; i < num_app; i++) 
    802087d8:	fe043023          	sd	zero,-32(s0)
    802087dc:	a089                	j	8020881e <loader_init_and_list_apps+0x62>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:58 (discriminator 3)
  {
    strcpy_t(APP_NAMES[i], (char *)ptr);
    802087de:	fe043783          	ld	a5,-32(s0)
    802087e2:	00679713          	slli	a4,a5,0x6
    802087e6:	00b24797          	auipc	a5,0xb24
    802087ea:	1aa78793          	addi	a5,a5,426 # 80d2c990 <APP_NAMES>
    802087ee:	97ba                	add	a5,a5,a4
    802087f0:	fe843583          	ld	a1,-24(s0)
    802087f4:	853e                	mv	a0,a5
    802087f6:	f37fb0ef          	jal	ra,8020472c <strcpy_t>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:59 (discriminator 3)
    ptr += (strlen_t((char *)ptr) + 1);
    802087fa:	fe843503          	ld	a0,-24(s0)
    802087fe:	c29fb0ef          	jal	ra,80204426 <strlen_t>
    80208802:	87aa                	mv	a5,a0
    80208804:	2785                	addiw	a5,a5,1
    80208806:	2781                	sext.w	a5,a5
    80208808:	873e                	mv	a4,a5
    8020880a:	fe843783          	ld	a5,-24(s0)
    8020880e:	97ba                	add	a5,a5,a4
    80208810:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:56 (discriminator 3)
  for (uint64_t i = 0; i < num_app; i++) 
    80208814:	fe043783          	ld	a5,-32(s0)
    80208818:	0785                	addi	a5,a5,1
    8020881a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:56 (discriminator 1)
    8020881e:	fe043703          	ld	a4,-32(s0)
    80208822:	fd843783          	ld	a5,-40(s0)
    80208826:	faf76ce3          	bltu	a4,a5,802087de <loader_init_and_list_apps+0x22>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:61
  }
}
    8020882a:	0001                	nop
    8020882c:	0001                	nop
    8020882e:	70a2                	ld	ra,40(sp)
    80208830:	7402                	ld	s0,32(sp)
    80208832:	6145                	addi	sp,sp,48
    80208834:	8082                	ret

0000000080208836 <list_apps>:
list_apps():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:64

void list_apps() 
{
    80208836:	1101                	addi	sp,sp,-32
    80208838:	ec06                	sd	ra,24(sp)
    8020883a:	e822                	sd	s0,16(sp)
    8020883c:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:65
    printk("/**** APPS ****\n");
    8020883e:	00002517          	auipc	a0,0x2
    80208842:	0a250513          	addi	a0,a0,162 # 8020a8e0 <MMIO+0x88>
    80208846:	fa5f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:66
    int num_app = loader_get_num_app();
    8020884a:	e9bff0ef          	jal	ra,802086e4 <loader_get_num_app>
    8020884e:	87aa                	mv	a5,a0
    80208850:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:67
    for (int i = 0; i < num_app; i++) {
    80208854:	fe042623          	sw	zero,-20(s0)
    80208858:	a035                	j	80208884 <list_apps+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:68 (discriminator 3)
        printk("%s\n", APP_NAMES[i]);
    8020885a:	fec42783          	lw	a5,-20(s0)
    8020885e:	00679713          	slli	a4,a5,0x6
    80208862:	00b24797          	auipc	a5,0xb24
    80208866:	12e78793          	addi	a5,a5,302 # 80d2c990 <APP_NAMES>
    8020886a:	97ba                	add	a5,a5,a4
    8020886c:	85be                	mv	a1,a5
    8020886e:	00002517          	auipc	a0,0x2
    80208872:	08a50513          	addi	a0,a0,138 # 8020a8f8 <MMIO+0xa0>
    80208876:	f75f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:67 (discriminator 3)
    for (int i = 0; i < num_app; i++) {
    8020887a:	fec42783          	lw	a5,-20(s0)
    8020887e:	2785                	addiw	a5,a5,1
    80208880:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:67 (discriminator 1)
    80208884:	fec42703          	lw	a4,-20(s0)
    80208888:	fe842783          	lw	a5,-24(s0)
    8020888c:	2701                	sext.w	a4,a4
    8020888e:	2781                	sext.w	a5,a5
    80208890:	fcf745e3          	blt	a4,a5,8020885a <list_apps+0x24>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:70
    }
    printk("**************/\n");
    80208894:	00002517          	auipc	a0,0x2
    80208898:	06c50513          	addi	a0,a0,108 # 8020a900 <MMIO+0xa8>
    8020889c:	f4ff90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:71
}
    802088a0:	0001                	nop
    802088a2:	60e2                	ld	ra,24(sp)
    802088a4:	6442                	ld	s0,16(sp)
    802088a6:	6105                	addi	sp,sp,32
    802088a8:	8082                	ret

00000000802088aa <loader_get_app_data_by_name>:
loader_get_app_data_by_name():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:74

uint8_t* loader_get_app_data_by_name(char* name) 
{
    802088aa:	7179                	addi	sp,sp,-48
    802088ac:	f406                	sd	ra,40(sp)
    802088ae:	f022                	sd	s0,32(sp)
    802088b0:	1800                	addi	s0,sp,48
    802088b2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:75
  print_str("current task: ");
    802088b6:	00002517          	auipc	a0,0x2
    802088ba:	06250513          	addi	a0,a0,98 # 8020a918 <MMIO+0xc0>
    802088be:	c5bfe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:76
  print_str(name);
    802088c2:	fd843503          	ld	a0,-40(s0)
    802088c6:	c53fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:77
  print_str("\n");
    802088ca:	00002517          	auipc	a0,0x2
    802088ce:	05e50513          	addi	a0,a0,94 # 8020a928 <MMIO+0xd0>
    802088d2:	c47fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:78
  int num_app = loader_get_num_app();
    802088d6:	e0fff0ef          	jal	ra,802086e4 <loader_get_num_app>
    802088da:	87aa                	mv	a5,a0
    802088dc:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:79
  for (int i = 0; i < num_app; i++)
    802088e0:	fe042623          	sw	zero,-20(s0)
    802088e4:	a82d                	j	8020891e <loader_get_app_data_by_name+0x74>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:81
  {
    if (strcmp_t(APP_NAMES[i], name) == 0)
    802088e6:	fec42783          	lw	a5,-20(s0)
    802088ea:	00679713          	slli	a4,a5,0x6
    802088ee:	00b24797          	auipc	a5,0xb24
    802088f2:	0a278793          	addi	a5,a5,162 # 80d2c990 <APP_NAMES>
    802088f6:	97ba                	add	a5,a5,a4
    802088f8:	fd843583          	ld	a1,-40(s0)
    802088fc:	853e                	mv	a0,a5
    802088fe:	da1fb0ef          	jal	ra,8020469e <strcmp_t>
    80208902:	87aa                	mv	a5,a0
    80208904:	eb81                	bnez	a5,80208914 <loader_get_app_data_by_name+0x6a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:83
    {
      return loader_get_app_data(i);
    80208906:	fec42783          	lw	a5,-20(s0)
    8020890a:	853e                	mv	a0,a5
    8020890c:	df1ff0ef          	jal	ra,802086fc <loader_get_app_data>
    80208910:	87aa                	mv	a5,a0
    80208912:	a839                	j	80208930 <loader_get_app_data_by_name+0x86>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:79 (discriminator 2)
  for (int i = 0; i < num_app; i++)
    80208914:	fec42783          	lw	a5,-20(s0)
    80208918:	2785                	addiw	a5,a5,1
    8020891a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:79 (discriminator 1)
    8020891e:	fec42703          	lw	a4,-20(s0)
    80208922:	fe842783          	lw	a5,-24(s0)
    80208926:	2701                	sext.w	a4,a4
    80208928:	2781                	sext.w	a5,a5
    8020892a:	faf74ee3          	blt	a4,a5,802088e6 <loader_get_app_data_by_name+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:86
    }
  }
    return NULL; // Return NULL if no match is found
    8020892e:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:87
}
    80208930:	853e                	mv	a0,a5
    80208932:	70a2                	ld	ra,40(sp)
    80208934:	7402                	ld	s0,32(sp)
    80208936:	6145                	addi	sp,sp,48
    80208938:	8082                	ret

000000008020893a <loader_get_app_size_by_name>:
loader_get_app_size_by_name():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:91



size_t loader_get_app_size_by_name(char *name) {
    8020893a:	7179                	addi	sp,sp,-48
    8020893c:	f406                	sd	ra,40(sp)
    8020893e:	f022                	sd	s0,32(sp)
    80208940:	1800                	addi	s0,sp,48
    80208942:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:92
  uint64_t num_app = loader_get_num_app();
    80208946:	d9fff0ef          	jal	ra,802086e4 <loader_get_num_app>
    8020894a:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:93
  for (uint64_t i = 0; i < num_app; i++) {
    8020894e:	fe043423          	sd	zero,-24(s0)
    80208952:	a825                	j	8020898a <loader_get_app_size_by_name+0x50>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:94
    if (strcmp_t(APP_NAMES[i], name) == 0) {
    80208954:	fe843783          	ld	a5,-24(s0)
    80208958:	00679713          	slli	a4,a5,0x6
    8020895c:	00b24797          	auipc	a5,0xb24
    80208960:	03478793          	addi	a5,a5,52 # 80d2c990 <APP_NAMES>
    80208964:	97ba                	add	a5,a5,a4
    80208966:	fd843583          	ld	a1,-40(s0)
    8020896a:	853e                	mv	a0,a5
    8020896c:	d33fb0ef          	jal	ra,8020469e <strcmp_t>
    80208970:	87aa                	mv	a5,a0
    80208972:	e799                	bnez	a5,80208980 <loader_get_app_size_by_name+0x46>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:95
      return loader_get_app_size(i);
    80208974:	fe843503          	ld	a0,-24(s0)
    80208978:	dd1ff0ef          	jal	ra,80208748 <loader_get_app_size>
    8020897c:	87aa                	mv	a5,a0
    8020897e:	a829                	j	80208998 <loader_get_app_size_by_name+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:93 (discriminator 2)
  for (uint64_t i = 0; i < num_app; i++) {
    80208980:	fe843783          	ld	a5,-24(s0)
    80208984:	0785                	addi	a5,a5,1
    80208986:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:93 (discriminator 1)
    8020898a:	fe843703          	ld	a4,-24(s0)
    8020898e:	fe043783          	ld	a5,-32(s0)
    80208992:	fcf761e3          	bltu	a4,a5,80208954 <loader_get_app_size_by_name+0x1a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:98
    }
  }
  return 0;
    80208996:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/loader/loader.c:99
    80208998:	853e                	mv	a0,a5
    8020899a:	70a2                	ld	ra,40(sp)
    8020899c:	7402                	ld	s0,32(sp)
    8020899e:	6145                	addi	sp,sp,48
    802089a0:	8082                	ret

00000000802089a2 <r_sstatus>:
r_sstatus():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:51
{
    802089a2:	1101                	addi	sp,sp,-32
    802089a4:	ec22                	sd	s0,24(sp)
    802089a6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:53
  asm volatile("csrr %0, sstatus" : "=r"(x));
    802089a8:	100027f3          	csrr	a5,sstatus
    802089ac:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:54
  return x;
    802089b0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:55
}
    802089b4:	853e                	mv	a0,a5
    802089b6:	6462                	ld	s0,24(sp)
    802089b8:	6105                	addi	sp,sp,32
    802089ba:	8082                	ret

00000000802089bc <set_sstatus_spp_user>:
set_sstatus_spp_user():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:7
#include "stdint.h"
#include "context.h"
#include "riscv.h"
#include "trap.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    802089bc:	7179                	addi	sp,sp,-48
    802089be:	f422                	sd	s0,40(sp)
    802089c0:	1800                	addi	s0,sp,48
    802089c2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:8
    uint64_t mask = 1UL << 8;
    802089c6:	10000793          	li	a5,256
    802089ca:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:9
    *sstatus &= ~mask;
    802089ce:	fd843783          	ld	a5,-40(s0)
    802089d2:	6398                	ld	a4,0(a5)
    802089d4:	fe843783          	ld	a5,-24(s0)
    802089d8:	fff7c793          	not	a5,a5
    802089dc:	8f7d                	and	a4,a4,a5
    802089de:	fd843783          	ld	a5,-40(s0)
    802089e2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:10
}
    802089e4:	0001                	nop
    802089e6:	7422                	ld	s0,40(sp)
    802089e8:	6145                	addi	sp,sp,48
    802089ea:	8082                	ret

00000000802089ec <read_sstatus>:
read_sstatus():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:13

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    802089ec:	1101                	addi	sp,sp,-32
    802089ee:	ec22                	sd	s0,24(sp)
    802089f0:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:14
    return READ_CSR(sstatus);
    802089f2:	100027f3          	csrr	a5,sstatus
    802089f6:	fef43423          	sd	a5,-24(s0)
    802089fa:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:15
}
    802089fe:	853e                	mv	a0,a5
    80208a00:	6462                	ld	s0,24(sp)
    80208a02:	6105                	addi	sp,sp,32
    80208a04:	8082                	ret

0000000080208a06 <set_sp>:
set_sp():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:18

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    80208a06:	1101                	addi	sp,sp,-32
    80208a08:	ec22                	sd	s0,24(sp)
    80208a0a:	1000                	addi	s0,sp,32
    80208a0c:	fea43423          	sd	a0,-24(s0)
    80208a10:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:19
    ctx->x[2] = sp;
    80208a14:	fe843783          	ld	a5,-24(s0)
    80208a18:	fe043703          	ld	a4,-32(s0)
    80208a1c:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:20
}
    80208a1e:	0001                	nop
    80208a20:	6462                	ld	s0,24(sp)
    80208a22:	6105                	addi	sp,sp,32
    80208a24:	8082                	ret

0000000080208a26 <app_init_context>:
app_init_context():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:27


void app_init_context(uint64_t entry, uint64_t sp, uint64_t kernel_satp,
                      uint64_t kernel_sp, uint64_t trap_handler,
                      struct TrapContext *c) 
{
    80208a26:	715d                	addi	sp,sp,-80
    80208a28:	e486                	sd	ra,72(sp)
    80208a2a:	e0a2                	sd	s0,64(sp)
    80208a2c:	0880                	addi	s0,sp,80
    80208a2e:	fca43c23          	sd	a0,-40(s0)
    80208a32:	fcb43823          	sd	a1,-48(s0)
    80208a36:	fcc43423          	sd	a2,-56(s0)
    80208a3a:	fcd43023          	sd	a3,-64(s0)
    80208a3e:	fae43c23          	sd	a4,-72(s0)
    80208a42:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:28
  uint64_t sstatus = r_sstatus();
    80208a46:	f5dff0ef          	jal	ra,802089a2 <r_sstatus>
    80208a4a:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:29
  sstatus &= ~SSTATUS_SPP;
    80208a4e:	fe043783          	ld	a5,-32(s0)
    80208a52:	eff7f793          	andi	a5,a5,-257
    80208a56:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:31

  for (int i = 0; i < 32; i++)
    80208a5a:	fe042623          	sw	zero,-20(s0)
    80208a5e:	a831                	j	80208a7a <app_init_context+0x54>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:32 (discriminator 3)
    c->x[i] = 0;
    80208a60:	fb043703          	ld	a4,-80(s0)
    80208a64:	fec42783          	lw	a5,-20(s0)
    80208a68:	078e                	slli	a5,a5,0x3
    80208a6a:	97ba                	add	a5,a5,a4
    80208a6c:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:31 (discriminator 3)
  for (int i = 0; i < 32; i++)
    80208a70:	fec42783          	lw	a5,-20(s0)
    80208a74:	2785                	addiw	a5,a5,1
    80208a76:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:31 (discriminator 1)
    80208a7a:	fec42783          	lw	a5,-20(s0)
    80208a7e:	0007871b          	sext.w	a4,a5
    80208a82:	47fd                	li	a5,31
    80208a84:	fce7dee3          	bge	a5,a4,80208a60 <app_init_context+0x3a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:33
  c->sstatus = sstatus;
    80208a88:	fb043783          	ld	a5,-80(s0)
    80208a8c:	fe043703          	ld	a4,-32(s0)
    80208a90:	10e7b023          	sd	a4,256(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:34
  c->sepc = entry;
    80208a94:	fb043783          	ld	a5,-80(s0)
    80208a98:	fd843703          	ld	a4,-40(s0)
    80208a9c:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:35
  c->kernel_satp = kernel_satp;
    80208aa0:	fb043783          	ld	a5,-80(s0)
    80208aa4:	fc843703          	ld	a4,-56(s0)
    80208aa8:	10e7b823          	sd	a4,272(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:36
  c->kernel_sp = kernel_sp;
    80208aac:	fb043783          	ld	a5,-80(s0)
    80208ab0:	fc043703          	ld	a4,-64(s0)
    80208ab4:	10e7bc23          	sd	a4,280(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:37
  c->trap_handler = trap_handler;
    80208ab8:	fb043783          	ld	a5,-80(s0)
    80208abc:	fb843703          	ld	a4,-72(s0)
    80208ac0:	12e7b023          	sd	a4,288(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:38
  c->x[2] = sp;
    80208ac4:	fb043783          	ld	a5,-80(s0)
    80208ac8:	fd043703          	ld	a4,-48(s0)
    80208acc:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:39
}
    80208ace:	0001                	nop
    80208ad0:	60a6                	ld	ra,72(sp)
    80208ad2:	6406                	ld	s0,64(sp)
    80208ad4:	6161                	addi	sp,sp,80
    80208ad6:	8082                	ret

0000000080208ad8 <task_context_goto_trap_return>:
task_context_goto_trap_return():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:41

void task_context_goto_trap_return(struct TaskContext *cx, uint64_t kstack_ptr) {
    80208ad8:	7179                	addi	sp,sp,-48
    80208ada:	f422                	sd	s0,40(sp)
    80208adc:	1800                	addi	s0,sp,48
    80208ade:	fca43c23          	sd	a0,-40(s0)
    80208ae2:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:42
  cx->ra = (uint64_t)trap_return;
    80208ae6:	00000717          	auipc	a4,0x0
    80208aea:	36270713          	addi	a4,a4,866 # 80208e48 <trap_return>
    80208aee:	fd843783          	ld	a5,-40(s0)
    80208af2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:43
  cx->sp = kstack_ptr;
    80208af4:	fd843783          	ld	a5,-40(s0)
    80208af8:	fd043703          	ld	a4,-48(s0)
    80208afc:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:44
  for (int i = 0; i < 12; i++)
    80208afe:	fe042623          	sw	zero,-20(s0)
    80208b02:	a839                	j	80208b20 <task_context_goto_trap_return+0x48>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:45 (discriminator 3)
    cx->x[i] = 0;
    80208b04:	fd843703          	ld	a4,-40(s0)
    80208b08:	fec42783          	lw	a5,-20(s0)
    80208b0c:	0789                	addi	a5,a5,2
    80208b0e:	078e                	slli	a5,a5,0x3
    80208b10:	97ba                	add	a5,a5,a4
    80208b12:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:44 (discriminator 3)
  for (int i = 0; i < 12; i++)
    80208b16:	fec42783          	lw	a5,-20(s0)
    80208b1a:	2785                	addiw	a5,a5,1
    80208b1c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:44 (discriminator 1)
    80208b20:	fec42783          	lw	a5,-20(s0)
    80208b24:	0007871b          	sext.w	a4,a5
    80208b28:	47ad                	li	a5,11
    80208b2a:	fce7dde3          	bge	a5,a4,80208b04 <task_context_goto_trap_return+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/context/context.c:46
}
    80208b2e:	0001                	nop
    80208b30:	0001                	nop
    80208b32:	7422                	ld	s0,40(sp)
    80208b34:	6145                	addi	sp,sp,48
    80208b36:	8082                	ret

0000000080208b38 <PidAllocator_init>:
PidAllocator_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:6
#include "pid.h"
#include "stdint.h"
#include "debug.h"
PidAllocator PID_ALLOCATOR;
void PidAllocator_init(PidAllocator* allocator) 
{
    80208b38:	1101                	addi	sp,sp,-32
    80208b3a:	ec06                	sd	ra,24(sp)
    80208b3c:	e822                	sd	s0,16(sp)
    80208b3e:	1000                	addi	s0,sp,32
    80208b40:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:7
    allocator->current.pid = 0;
    80208b44:	fe843783          	ld	a5,-24(s0)
    80208b48:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:8
    vector_new(&allocator->recycled,10);
    80208b4c:	fe843783          	ld	a5,-24(s0)
    80208b50:	07a1                	addi	a5,a5,8
    80208b52:	45a9                	li	a1,10
    80208b54:	853e                	mv	a0,a5
    80208b56:	527000ef          	jal	ra,8020987c <vector_new>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:9
}
    80208b5a:	0001                	nop
    80208b5c:	60e2                	ld	ra,24(sp)
    80208b5e:	6442                	ld	s0,16(sp)
    80208b60:	6105                	addi	sp,sp,32
    80208b62:	8082                	ret

0000000080208b64 <PidAllocator_alloc>:
PidAllocator_alloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:12

PidHandle PidAllocator_alloc()
{
    80208b64:	1101                	addi	sp,sp,-32
    80208b66:	ec06                	sd	ra,24(sp)
    80208b68:	e822                	sd	s0,16(sp)
    80208b6a:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:14
    PidHandle handle;
    if (vector_size(&PID_ALLOCATOR.recycled) > 0) {
    80208b6c:	00b24517          	auipc	a0,0xb24
    80208b70:	32c50513          	addi	a0,a0,812 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208b74:	7e7000ef          	jal	ra,80209b5a <vector_size>
    80208b78:	87aa                	mv	a5,a0
    80208b7a:	c395                	beqz	a5,80208b9e <PidAllocator_alloc+0x3a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:15
        handle.pid = *(uint64_t*)vector_back(&PID_ALLOCATOR.recycled);
    80208b7c:	00b24517          	auipc	a0,0xb24
    80208b80:	31c50513          	addi	a0,a0,796 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208b84:	65b000ef          	jal	ra,802099de <vector_back>
    80208b88:	87aa                	mv	a5,a0
    80208b8a:	639c                	ld	a5,0(a5)
    80208b8c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:16
        vector_pop(&PID_ALLOCATOR.recycled);
    80208b90:	00b24517          	auipc	a0,0xb24
    80208b94:	30850513          	addi	a0,a0,776 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208b98:	601000ef          	jal	ra,80209998 <vector_pop>
    80208b9c:	a025                	j	80208bc4 <PidAllocator_alloc+0x60>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:18
    } else {
        handle.pid = PID_ALLOCATOR.current.pid;
    80208b9e:	00b24797          	auipc	a5,0xb24
    80208ba2:	2f278793          	addi	a5,a5,754 # 80d2ce90 <PID_ALLOCATOR>
    80208ba6:	639c                	ld	a5,0(a5)
    80208ba8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:19
        PID_ALLOCATOR.current.pid++;
    80208bac:	00b24797          	auipc	a5,0xb24
    80208bb0:	2e478793          	addi	a5,a5,740 # 80d2ce90 <PID_ALLOCATOR>
    80208bb4:	639c                	ld	a5,0(a5)
    80208bb6:	00178713          	addi	a4,a5,1
    80208bba:	00b24797          	auipc	a5,0xb24
    80208bbe:	2d678793          	addi	a5,a5,726 # 80d2ce90 <PID_ALLOCATOR>
    80208bc2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:21
    }
    return handle;
    80208bc4:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:22
}
    80208bc8:	853e                	mv	a0,a5
    80208bca:	60e2                	ld	ra,24(sp)
    80208bcc:	6442                	ld	s0,16(sp)
    80208bce:	6105                	addi	sp,sp,32
    80208bd0:	8082                	ret

0000000080208bd2 <PidAllocator_dealloc>:
PidAllocator_dealloc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:25

void PidAllocator_dealloc(PidHandle pid) 
{
    80208bd2:	7139                	addi	sp,sp,-64
    80208bd4:	fc06                	sd	ra,56(sp)
    80208bd6:	f822                	sd	s0,48(sp)
    80208bd8:	f426                	sd	s1,40(sp)
    80208bda:	0080                	addi	s0,sp,64
    80208bdc:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:26
    ASSERT(pid.pid < PID_ALLOCATOR.current.pid);
    80208be0:	fc843703          	ld	a4,-56(s0)
    80208be4:	00b24797          	auipc	a5,0xb24
    80208be8:	2ac78793          	addi	a5,a5,684 # 80d2ce90 <PID_ALLOCATOR>
    80208bec:	639c                	ld	a5,0(a5)
    80208bee:	00f76d63          	bltu	a4,a5,80208c08 <PidAllocator_dealloc+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:26 (discriminator 1)
    80208bf2:	00002617          	auipc	a2,0x2
    80208bf6:	d4e60613          	addi	a2,a2,-690 # 8020a940 <MMIO+0x10>
    80208bfa:	45e9                	li	a1,26
    80208bfc:	00002517          	auipc	a0,0x2
    80208c00:	d7c50513          	addi	a0,a0,-644 # 8020a978 <MMIO+0x48>
    80208c04:	bd9fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:27
    for (size_t i = 0; i < vector_size(&PID_ALLOCATOR.recycled); ++i) {
    80208c08:	fc043c23          	sd	zero,-40(s0)
    80208c0c:	a83d                	j	80208c4a <PidAllocator_dealloc+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:28
        ASSERT(pid.pid != *(uint64_t*)vector_get(&PID_ALLOCATOR.recycled, i));
    80208c0e:	fc843483          	ld	s1,-56(s0)
    80208c12:	fd843583          	ld	a1,-40(s0)
    80208c16:	00b24517          	auipc	a0,0xb24
    80208c1a:	28250513          	addi	a0,a0,642 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208c1e:	6ff000ef          	jal	ra,80209b1c <vector_get>
    80208c22:	87aa                	mv	a5,a0
    80208c24:	639c                	ld	a5,0(a5)
    80208c26:	00f49d63          	bne	s1,a5,80208c40 <PidAllocator_dealloc+0x6e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:28 (discriminator 1)
    80208c2a:	00002617          	auipc	a2,0x2
    80208c2e:	d6660613          	addi	a2,a2,-666 # 8020a990 <MMIO+0x60>
    80208c32:	45f1                	li	a1,28
    80208c34:	00002517          	auipc	a0,0x2
    80208c38:	d4450513          	addi	a0,a0,-700 # 8020a978 <MMIO+0x48>
    80208c3c:	ba1fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:27 (discriminator 2)
    for (size_t i = 0; i < vector_size(&PID_ALLOCATOR.recycled); ++i) {
    80208c40:	fd843783          	ld	a5,-40(s0)
    80208c44:	0785                	addi	a5,a5,1
    80208c46:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:27 (discriminator 1)
    80208c4a:	00b24517          	auipc	a0,0xb24
    80208c4e:	24e50513          	addi	a0,a0,590 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208c52:	709000ef          	jal	ra,80209b5a <vector_size>
    80208c56:	872a                	mv	a4,a0
    80208c58:	fd843783          	ld	a5,-40(s0)
    80208c5c:	fae7e9e3          	bltu	a5,a4,80208c0e <PidAllocator_dealloc+0x3c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:30
    }
    vector_push(&PID_ALLOCATOR.recycled, &pid);
    80208c60:	fc840793          	addi	a5,s0,-56
    80208c64:	85be                	mv	a1,a5
    80208c66:	00b24517          	auipc	a0,0xb24
    80208c6a:	23250513          	addi	a0,a0,562 # 80d2ce98 <PID_ALLOCATOR+0x8>
    80208c6e:	461000ef          	jal	ra,802098ce <vector_push>
/home/caigoubencai/Desktop/os_c-ch6/kernel/batch/pid/pid.c:31
    80208c72:	0001                	nop
    80208c74:	70e2                	ld	ra,56(sp)
    80208c76:	7442                	ld	s0,48(sp)
    80208c78:	74a2                	ld	s1,40(sp)
    80208c7a:	6121                	addi	sp,sp,64
    80208c7c:	8082                	ret

0000000080208c7e <r_sie>:
r_sie():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:80
{
    80208c7e:	1101                	addi	sp,sp,-32
    80208c80:	ec22                	sd	s0,24(sp)
    80208c82:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:82
  asm volatile("csrr %0, sie" : "=r"(x));
    80208c84:	104027f3          	csrr	a5,sie
    80208c88:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:83
  return x;
    80208c8c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:84
}
    80208c90:	853e                	mv	a0,a5
    80208c92:	6462                	ld	s0,24(sp)
    80208c94:	6105                	addi	sp,sp,32
    80208c96:	8082                	ret

0000000080208c98 <w_sie>:
w_sie():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:87
{
    80208c98:	1101                	addi	sp,sp,-32
    80208c9a:	ec22                	sd	s0,24(sp)
    80208c9c:	1000                	addi	s0,sp,32
    80208c9e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:88
  asm volatile("csrw sie, %0" : : "r"(x));
    80208ca2:	fe843783          	ld	a5,-24(s0)
    80208ca6:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:89
}
    80208caa:	0001                	nop
    80208cac:	6462                	ld	s0,24(sp)
    80208cae:	6105                	addi	sp,sp,32
    80208cb0:	8082                	ret

0000000080208cb2 <w_stvec>:
w_stvec():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:151
{
    80208cb2:	1101                	addi	sp,sp,-32
    80208cb4:	ec22                	sd	s0,24(sp)
    80208cb6:	1000                	addi	s0,sp,32
    80208cb8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:152
  asm volatile("csrw stvec, %0" : : "r"(x));
    80208cbc:	fe843783          	ld	a5,-24(s0)
    80208cc0:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:153
}
    80208cc4:	0001                	nop
    80208cc6:	6462                	ld	s0,24(sp)
    80208cc8:	6105                	addi	sp,sp,32
    80208cca:	8082                	ret

0000000080208ccc <r_scause>:
r_scause():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:200
{
    80208ccc:	1101                	addi	sp,sp,-32
    80208cce:	ec22                	sd	s0,24(sp)
    80208cd0:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:202
  asm volatile("csrr %0, scause" : "=r"(x));
    80208cd2:	142027f3          	csrr	a5,scause
    80208cd6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:203
  return x;
    80208cda:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:204
}
    80208cde:	853e                	mv	a0,a5
    80208ce0:	6462                	ld	s0,24(sp)
    80208ce2:	6105                	addi	sp,sp,32
    80208ce4:	8082                	ret

0000000080208ce6 <print_sepc>:
print_sepc():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:19
#include "plic.h"
extern void __alltraps();
extern void __restore();

void print_sepc()
{
    80208ce6:	1101                	addi	sp,sp,-32
    80208ce8:	ec06                	sd	ra,24(sp)
    80208cea:	e822                	sd	s0,16(sp)
    80208cec:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:20
  print_str("sepc : ");
    80208cee:	00002517          	auipc	a0,0x2
    80208cf2:	d0250513          	addi	a0,a0,-766 # 8020a9f0 <MMIO+0x10>
    80208cf6:	823fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:21
  print_uint64(READ_CSR(sepc));
    80208cfa:	141027f3          	csrr	a5,sepc
    80208cfe:	fef43423          	sd	a5,-24(s0)
    80208d02:	fe843783          	ld	a5,-24(s0)
    80208d06:	853e                	mv	a0,a5
    80208d08:	98ffe0ef          	jal	ra,80207696 <print_uint64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:22
  print_str("\n");
    80208d0c:	00002517          	auipc	a0,0x2
    80208d10:	cec50513          	addi	a0,a0,-788 # 8020a9f8 <MMIO+0x18>
    80208d14:	805fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:23
}
    80208d18:	0001                	nop
    80208d1a:	60e2                	ld	ra,24(sp)
    80208d1c:	6442                	ld	s0,16(sp)
    80208d1e:	6105                	addi	sp,sp,32
    80208d20:	8082                	ret

0000000080208d22 <trap_handler>:
trap_handler():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:41
//     WRITE_CSR(sie, sie);
//     WRITE_CSR(sscratch,Trap_Stack);
// }

void trap_handler()
{
    80208d22:	1101                	addi	sp,sp,-32
    80208d24:	ec06                	sd	ra,24(sp)
    80208d26:	e822                	sd	s0,16(sp)
    80208d28:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:42
  printk("trap_handler \n");
    80208d2a:	00002517          	auipc	a0,0x2
    80208d2e:	cd650513          	addi	a0,a0,-810 # 8020aa00 <MMIO+0x20>
    80208d32:	ab9f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:43
  set_kernel_trap_entry();
    80208d36:	264000ef          	jal	ra,80208f9a <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:45

  struct TrapContext *cx = processor_current_trap_cx();
    80208d3a:	805ff0ef          	jal	ra,8020853e <processor_current_trap_cx>
    80208d3e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:46
  uint64_t scause = r_scause();
    80208d42:	f8bff0ef          	jal	ra,80208ccc <r_scause>
    80208d46:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:48

  if (scause & (1ULL << 63))
    80208d4a:	fe043783          	ld	a5,-32(s0)
    80208d4e:	0207d363          	bgez	a5,80208d74 <trap_handler+0x52>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:50
  {
    scause &= ~(1ULL << 63);
    80208d52:	fe043703          	ld	a4,-32(s0)
    80208d56:	57fd                	li	a5,-1
    80208d58:	8385                	srli	a5,a5,0x1
    80208d5a:	8ff9                	and	a5,a5,a4
    80208d5c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:51
    switch (scause)
    80208d60:	fe043703          	ld	a4,-32(s0)
    80208d64:	4795                	li	a5,5
    80208d66:	0af71163          	bne	a4,a5,80208e08 <trap_handler+0xe6>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:54
    {
    case SupervisorTimer:
      intr_timer_handle();
    80208d6a:	0cf000ef          	jal	ra,80209638 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:55
      task_exit_current_and_run_next();
    80208d6e:	b7eff0ef          	jal	ra,802080ec <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:56
      break;
    80208d72:	a861                	j	80208e0a <trap_handler+0xe8>
    80208d74:	fe043703          	ld	a4,-32(s0)
    80208d78:	47bd                	li	a5,15
    80208d7a:	06e7ea63          	bltu	a5,a4,80208dee <trap_handler+0xcc>
    80208d7e:	fe043783          	ld	a5,-32(s0)
    80208d82:	00279713          	slli	a4,a5,0x2
    80208d86:	00002797          	auipc	a5,0x2
    80208d8a:	cb678793          	addi	a5,a5,-842 # 8020aa3c <MMIO+0x5c>
    80208d8e:	97ba                	add	a5,a5,a4
    80208d90:	439c                	lw	a5,0(a5)
    80208d92:	0007871b          	sext.w	a4,a5
    80208d96:	00002797          	auipc	a5,0x2
    80208d9a:	ca678793          	addi	a5,a5,-858 # 8020aa3c <MMIO+0x5c>
    80208d9e:	97ba                	add	a5,a5,a4
    80208da0:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:67
  else
  {
    switch (scause)
    {
    case UserEnvCall:
      cx->sepc += 4;
    80208da2:	fe843783          	ld	a5,-24(s0)
    80208da6:	1087b783          	ld	a5,264(a5)
    80208daa:	00478713          	addi	a4,a5,4
    80208dae:	fe843783          	ld	a5,-24(s0)
    80208db2:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:68
      cx->x[10] = syscall(cx->x[17], cx->x[10], cx->x[11], cx->x[12]);
    80208db6:	fe843783          	ld	a5,-24(s0)
    80208dba:	67d8                	ld	a4,136(a5)
    80208dbc:	fe843783          	ld	a5,-24(s0)
    80208dc0:	6bac                	ld	a1,80(a5)
    80208dc2:	fe843783          	ld	a5,-24(s0)
    80208dc6:	6fb0                	ld	a2,88(a5)
    80208dc8:	fe843783          	ld	a5,-24(s0)
    80208dcc:	73bc                	ld	a5,96(a5)
    80208dce:	86be                	mv	a3,a5
    80208dd0:	853a                	mv	a0,a4
    80208dd2:	636000ef          	jal	ra,80209408 <syscall>
    80208dd6:	87aa                	mv	a5,a0
    80208dd8:	873e                	mv	a4,a5
    80208dda:	fe843783          	ld	a5,-24(s0)
    80208dde:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:69
      break;
    80208de0:	a02d                	j	80208e0a <trap_handler+0xe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:78
    case InstructionPageFault:
    case LoadFault:
    case LoadPageFault:
      ASSERT("Exception %lld in application, bad addr = %llx, bad instruction = ");
      ASSERT("LoadPageFault\n");
      task_exit_current_and_run_next();
    80208de2:	b0aff0ef          	jal	ra,802080ec <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:79
      break;
    80208de6:	a015                	j	80208e0a <trap_handler+0xe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:82
    case IllegalInstruction:
      ASSERT("IllegalInstruction in application, core dumped.\n");
      task_exit_current_and_run_next();
    80208de8:	b04ff0ef          	jal	ra,802080ec <task_exit_current_and_run_next>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:83
      break;
    80208dec:	a839                	j	80208e0a <trap_handler+0xe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:85 (discriminator 1)
    default:
      ASSERT(0);
    80208dee:	00002617          	auipc	a2,0x2
    80208df2:	c2260613          	addi	a2,a2,-990 # 8020aa10 <MMIO+0x30>
    80208df6:	05500593          	li	a1,85
    80208dfa:	00002517          	auipc	a0,0x2
    80208dfe:	c2e50513          	addi	a0,a0,-978 # 8020aa28 <MMIO+0x48>
    80208e02:	9dbfe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:86 (discriminator 1)
      break;
    80208e06:	a011                	j	80208e0a <trap_handler+0xe8>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:59
      break;
    80208e08:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:90
    }
  }

  trap_return();
    80208e0a:	03e000ef          	jal	ra,80208e48 <trap_return>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:91
}
    80208e0e:	0001                	nop
    80208e10:	60e2                	ld	ra,24(sp)
    80208e12:	6442                	ld	s0,16(sp)
    80208e14:	6105                	addi	sp,sp,32
    80208e16:	8082                	ret

0000000080208e18 <set_user_trap_entry>:
set_user_trap_entry():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:94

void set_user_trap_entry()
{
    80208e18:	1141                	addi	sp,sp,-16
    80208e1a:	e406                	sd	ra,8(sp)
    80208e1c:	e022                	sd	s0,0(sp)
    80208e1e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:95
  w_stvec((uint64_t)TRAMPOLINE);
    80208e20:	757d                	lui	a0,0xfffff
    80208e22:	e91ff0ef          	jal	ra,80208cb2 <w_stvec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:96
}
    80208e26:	0001                	nop
    80208e28:	60a2                	ld	ra,8(sp)
    80208e2a:	6402                	ld	s0,0(sp)
    80208e2c:	0141                	addi	sp,sp,16
    80208e2e:	8082                	ret

0000000080208e30 <task_current_user_token>:
task_current_user_token():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:99

uint64_t task_current_user_token()
{
    80208e30:	1141                	addi	sp,sp,-16
    80208e32:	e406                	sd	ra,8(sp)
    80208e34:	e022                	sd	s0,0(sp)
    80208e36:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:100
  return task_manager_get_current_token();
    80208e38:	a2bfe0ef          	jal	ra,80207862 <task_manager_get_current_token>
    80208e3c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:101
}
    80208e3e:	853e                	mv	a0,a5
    80208e40:	60a2                	ld	ra,8(sp)
    80208e42:	6402                	ld	s0,0(sp)
    80208e44:	0141                	addi	sp,sp,16
    80208e46:	8082                	ret

0000000080208e48 <trap_return>:
trap_return():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:104

void trap_return()
{
    80208e48:	7179                	addi	sp,sp,-48
    80208e4a:	f406                	sd	ra,40(sp)
    80208e4c:	f022                	sd	s0,32(sp)
    80208e4e:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:106
  // printk("trap_return\n");
  set_user_trap_entry();
    80208e50:	fc9ff0ef          	jal	ra,80208e18 <set_user_trap_entry>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:107
  uint64_t trap_cx_ptr = TRAP_CONTEXT;
    80208e54:	77f9                	lui	a5,0xffffe
    80208e56:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:108
  uint64_t user_satp = processor_current_user_token();
    80208e5a:	e5cff0ef          	jal	ra,802084b6 <processor_current_user_token>
    80208e5e:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:109
  uint64_t restore_va = (uint64_t)__restore - (uint64_t)__alltraps + TRAMPOLINE;
    80208e62:	ffff8717          	auipc	a4,0xffff8
    80208e66:	1fe70713          	addi	a4,a4,510 # 80201060 <__restore>
    80208e6a:	77fd                	lui	a5,0xfffff
    80208e6c:	973e                	add	a4,a4,a5
    80208e6e:	ffff8797          	auipc	a5,0xffff8
    80208e72:	19278793          	addi	a5,a5,402 # 80201000 <__alltraps>
    80208e76:	40f707b3          	sub	a5,a4,a5
    80208e7a:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:110
  asm volatile("fence.i");
    80208e7e:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:111
  asm volatile("mv x10, %1\n"
    80208e82:	fd843783          	ld	a5,-40(s0)
    80208e86:	fe843703          	ld	a4,-24(s0)
    80208e8a:	fe043683          	ld	a3,-32(s0)
    80208e8e:	853a                	mv	a0,a4
    80208e90:	85b6                	mv	a1,a3
    80208e92:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:117
               "mv x11, %2\n"
               "jr %0\n"
               :
               : "r"(restore_va), "r"(trap_cx_ptr), "r"(user_satp)
               : "memory", "x10", "x11");
  panic("Unreachable in back_to_user!\n");
    80208e94:	00002617          	auipc	a2,0x2
    80208e98:	bec60613          	addi	a2,a2,-1044 # 8020aa80 <MMIO+0xa0>
    80208e9c:	07500593          	li	a1,117
    80208ea0:	00002517          	auipc	a0,0x2
    80208ea4:	b8850513          	addi	a0,a0,-1144 # 8020aa28 <MMIO+0x48>
    80208ea8:	935fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:118
}
    80208eac:	0001                	nop
    80208eae:	70a2                	ld	ra,40(sp)
    80208eb0:	7402                	ld	s0,32(sp)
    80208eb2:	6145                	addi	sp,sp,48
    80208eb4:	8082                	ret

0000000080208eb6 <init_trap>:
init_trap():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:121

void init_trap()
{
    80208eb6:	1141                	addi	sp,sp,-16
    80208eb8:	e406                	sd	ra,8(sp)
    80208eba:	e022                	sd	s0,0(sp)
    80208ebc:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:122
  set_kernel_trap_entry();
    80208ebe:	0dc000ef          	jal	ra,80208f9a <set_kernel_trap_entry>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:123
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE);
    80208ec2:	dbdff0ef          	jal	ra,80208c7e <r_sie>
    80208ec6:	87aa                	mv	a5,a0
    80208ec8:	2027e793          	ori	a5,a5,514
    80208ecc:	853e                	mv	a0,a5
    80208ece:	dcbff0ef          	jal	ra,80208c98 <w_sie>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:124
}
    80208ed2:	0001                	nop
    80208ed4:	60a2                	ld	ra,8(sp)
    80208ed6:	6402                	ld	s0,0(sp)
    80208ed8:	0141                	addi	sp,sp,16
    80208eda:	8082                	ret

0000000080208edc <trap_from_kernel>:
trap_from_kernel():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:127

void trap_from_kernel(uint64_t cause)
{
    80208edc:	7179                	addi	sp,sp,-48
    80208ede:	f406                	sd	ra,40(sp)
    80208ee0:	f022                	sd	s0,32(sp)
    80208ee2:	1800                	addi	s0,sp,48
    80208ee4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:128
  printk("trap_from_kernel\n");
    80208ee8:	00002517          	auipc	a0,0x2
    80208eec:	bb850513          	addi	a0,a0,-1096 # 8020aaa0 <MMIO+0xc0>
    80208ef0:	8fbf90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:130
  int irq;
  switch (cause)
    80208ef4:	fd843703          	ld	a4,-40(s0)
    80208ef8:	4795                	li	a5,5
    80208efa:	00f70863          	beq	a4,a5,80208f0a <trap_from_kernel+0x2e>
    80208efe:	fd843703          	ld	a4,-40(s0)
    80208f02:	47a5                	li	a5,9
    80208f04:	00f70663          	beq	a4,a5,80208f10 <trap_from_kernel+0x34>
    80208f08:	a0b5                	j	80208f74 <trap_from_kernel+0x98>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:133
  {
  case SupervisorTimer:
    timer_set_next_trigger();
    80208f0a:	7be000ef          	jal	ra,802096c8 <timer_set_next_trigger>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:134
    break;
    80208f0e:	a049                	j	80208f90 <trap_from_kernel+0xb4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:136
  case SupervisorExternal:
    irq = plic_claim();
    80208f10:	d5afa0ef          	jal	ra,8020346a <plic_claim>
    80208f14:	87aa                	mv	a5,a0
    80208f16:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:137
    if (irq == VIRTIO0_IRQ)
    80208f1a:	fec42783          	lw	a5,-20(s0)
    80208f1e:	0007871b          	sext.w	a4,a5
    80208f22:	4785                	li	a5,1
    80208f24:	00f71563          	bne	a4,a5,80208f2e <trap_from_kernel+0x52>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:139
    {
      virtio_disk_intr();
    80208f28:	ba4fa0ef          	jal	ra,802032cc <virtio_disk_intr>
    80208f2c:	a815                	j	80208f60 <trap_from_kernel+0x84>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:141
    }
    else if (irq)
    80208f2e:	fec42783          	lw	a5,-20(s0)
    80208f32:	2781                	sext.w	a5,a5
    80208f34:	c795                	beqz	a5,80208f60 <trap_from_kernel+0x84>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:143
    {
      printk("unexpected interrupt irq=%d\n", irq);
    80208f36:	fec42783          	lw	a5,-20(s0)
    80208f3a:	85be                	mv	a1,a5
    80208f3c:	00002517          	auipc	a0,0x2
    80208f40:	b7c50513          	addi	a0,a0,-1156 # 8020aab8 <MMIO+0xd8>
    80208f44:	8a7f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:144
      ASSERT(0);
    80208f48:	00002617          	auipc	a2,0x2
    80208f4c:	ac860613          	addi	a2,a2,-1336 # 8020aa10 <MMIO+0x30>
    80208f50:	09000593          	li	a1,144
    80208f54:	00002517          	auipc	a0,0x2
    80208f58:	ad450513          	addi	a0,a0,-1324 # 8020aa28 <MMIO+0x48>
    80208f5c:	881fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:146
    }
    if (irq)
    80208f60:	fec42783          	lw	a5,-20(s0)
    80208f64:	2781                	sext.w	a5,a5
    80208f66:	c785                	beqz	a5,80208f8e <trap_from_kernel+0xb2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:147
      plic_complete(irq);
    80208f68:	fec42783          	lw	a5,-20(s0)
    80208f6c:	853e                	mv	a0,a5
    80208f6e:	d36fa0ef          	jal	ra,802034a4 <plic_complete>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:148
    break;
    80208f72:	a831                	j	80208f8e <trap_from_kernel+0xb2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:150 (discriminator 1)
  default:
    ASSERT(0);
    80208f74:	00002617          	auipc	a2,0x2
    80208f78:	a9c60613          	addi	a2,a2,-1380 # 8020aa10 <MMIO+0x30>
    80208f7c:	09600593          	li	a1,150
    80208f80:	00002517          	auipc	a0,0x2
    80208f84:	aa850513          	addi	a0,a0,-1368 # 8020aa28 <MMIO+0x48>
    80208f88:	855fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:151 (discriminator 1)
    break;
    80208f8c:	a011                	j	80208f90 <trap_from_kernel+0xb4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:148
    break;
    80208f8e:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:153
  }
}
    80208f90:	0001                	nop
    80208f92:	70a2                	ld	ra,40(sp)
    80208f94:	7402                	ld	s0,32(sp)
    80208f96:	6145                	addi	sp,sp,48
    80208f98:	8082                	ret

0000000080208f9a <set_kernel_trap_entry>:
set_kernel_trap_entry():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:157

extern void kernelvec();
void set_kernel_trap_entry()
{
    80208f9a:	1141                	addi	sp,sp,-16
    80208f9c:	e406                	sd	ra,8(sp)
    80208f9e:	e022                	sd	s0,0(sp)
    80208fa0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:158
  w_stvec((uint64_t)kernelvec);
    80208fa2:	00001797          	auipc	a5,0x1
    80208fa6:	d8e78793          	addi	a5,a5,-626 # 80209d30 <kernelvec>
    80208faa:	853e                	mv	a0,a5
    80208fac:	d07ff0ef          	jal	ra,80208cb2 <w_stvec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/trap.c:159
}
    80208fb0:	0001                	nop
    80208fb2:	60a2                	ld	ra,8(sp)
    80208fb4:	6402                	ld	s0,0(sp)
    80208fb6:	0141                	addi	sp,sp,16
    80208fb8:	8082                	ret

0000000080208fba <exit>:
exit():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:14
#include "stdint.h"
#include "trap.h"
#include "processor.h"
#include "timer.h"
int32_t exit(int32_t value)
{
    80208fba:	1101                	addi	sp,sp,-32
    80208fbc:	ec06                	sd	ra,24(sp)
    80208fbe:	e822                	sd	s0,16(sp)
    80208fc0:	1000                	addi	s0,sp,32
    80208fc2:	87aa                	mv	a5,a0
    80208fc4:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:15
    print_str("exit : ");
    80208fc8:	00002517          	auipc	a0,0x2
    80208fcc:	b2050513          	addi	a0,a0,-1248 # 8020aae8 <MMIO+0x10>
    80208fd0:	d48fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:16
    print_uint32((uint32_t)value);
    80208fd4:	fec42783          	lw	a5,-20(s0)
    80208fd8:	853e                	mv	a0,a5
    80208fda:	e08fe0ef          	jal	ra,802075e2 <print_uint32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:17
    print_str("\n");
    80208fde:	00002517          	auipc	a0,0x2
    80208fe2:	b1250513          	addi	a0,a0,-1262 # 8020aaf0 <MMIO+0x18>
    80208fe6:	d32fe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:18
    return value;
    80208fea:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:19
}
    80208fee:	853e                	mv	a0,a5
    80208ff0:	60e2                	ld	ra,24(sp)
    80208ff2:	6442                	ld	s0,16(sp)
    80208ff4:	6105                	addi	sp,sp,32
    80208ff6:	8082                	ret

0000000080208ff8 <write>:
write():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:22

int64_t write(uint64_t fd, char *buf, size_t count)
{
    80208ff8:	7139                	addi	sp,sp,-64
    80208ffa:	fc06                	sd	ra,56(sp)
    80208ffc:	f822                	sd	s0,48(sp)
    80208ffe:	0080                	addi	s0,sp,64
    80209000:	fca43c23          	sd	a0,-40(s0)
    80209004:	fcb43823          	sd	a1,-48(s0)
    80209008:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:25
    static uint8_t sys_write_buf[1024];

    switch (fd)
    8020900c:	fd843703          	ld	a4,-40(s0)
    80209010:	4785                	li	a5,1
    80209012:	04f71e63          	bne	a4,a5,8020906e <write+0x76>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:28
    {
    case 1:
        copy_byte_buffer(processor_current_user_token(), sys_write_buf, (uint8_t *)buf,
    80209016:	ca0ff0ef          	jal	ra,802084b6 <processor_current_user_token>
    8020901a:	87aa                	mv	a5,a0
    8020901c:	4701                	li	a4,0
    8020901e:	fc843683          	ld	a3,-56(s0)
    80209022:	fd043603          	ld	a2,-48(s0)
    80209026:	00b24597          	auipc	a1,0xb24
    8020902a:	ea258593          	addi	a1,a1,-350 # 80d2cec8 <sys_write_buf.0>
    8020902e:	853e                	mv	a0,a5
    80209030:	b38fd0ef          	jal	ra,80206368 <copy_byte_buffer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:30
                         count, FROM_USER);
        for (uint64_t i = 0; i < count; i++)
    80209034:	fe043423          	sd	zero,-24(s0)
    80209038:	a015                	j	8020905c <write+0x64>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:32 (discriminator 3)
        {
            console_putchar(sys_write_buf[i]);
    8020903a:	00b24717          	auipc	a4,0xb24
    8020903e:	e8e70713          	addi	a4,a4,-370 # 80d2cec8 <sys_write_buf.0>
    80209042:	fe843783          	ld	a5,-24(s0)
    80209046:	97ba                	add	a5,a5,a4
    80209048:	0007c783          	lbu	a5,0(a5)
    8020904c:	853e                	mv	a0,a5
    8020904e:	b4afb0ef          	jal	ra,80204398 <console_putchar>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:30 (discriminator 3)
        for (uint64_t i = 0; i < count; i++)
    80209052:	fe843783          	ld	a5,-24(s0)
    80209056:	0785                	addi	a5,a5,1
    80209058:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:30 (discriminator 1)
    8020905c:	fe843703          	ld	a4,-24(s0)
    80209060:	fc843783          	ld	a5,-56(s0)
    80209064:	fcf76be3          	bltu	a4,a5,8020903a <write+0x42>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:34
        }
        return (int64_t)count;
    80209068:	fc843783          	ld	a5,-56(s0)
    8020906c:	a019                	j	80209072 <write+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:36
    default:
        break;
    8020906e:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:38
    }
    return -1;
    80209070:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:39
}
    80209072:	853e                	mv	a0,a5
    80209074:	70e2                	ld	ra,56(sp)
    80209076:	7442                	ld	s0,48(sp)
    80209078:	6121                	addi	sp,sp,64
    8020907a:	8082                	ret

000000008020907c <yield>:
yield():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:42

int64_t yield()
{
    8020907c:	1141                	addi	sp,sp,-16
    8020907e:	e406                	sd	ra,8(sp)
    80209080:	e022                	sd	s0,0(sp)
    80209082:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:43
    print_str("\n-------yield------\n");
    80209084:	00002517          	auipc	a0,0x2
    80209088:	a7450513          	addi	a0,a0,-1420 # 8020aaf8 <MMIO+0x20>
    8020908c:	c8cfe0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:44
    task_suspend_current_and_run_next();
    80209090:	962ff0ef          	jal	ra,802081f2 <task_suspend_current_and_run_next>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:45
    return 1;
    80209094:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:46
}
    80209096:	853e                	mv	a0,a5
    80209098:	60a2                	ld	ra,8(sp)
    8020909a:	6402                	ld	s0,0(sp)
    8020909c:	0141                	addi	sp,sp,16
    8020909e:	8082                	ret

00000000802090a0 <sys_write>:
sys_write():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:49

int64_t sys_write(uint64_t fd, char *buf, size_t count)
{
    802090a0:	7179                	addi	sp,sp,-48
    802090a2:	f406                	sd	ra,40(sp)
    802090a4:	f022                	sd	s0,32(sp)
    802090a6:	1800                	addi	s0,sp,48
    802090a8:	fea43423          	sd	a0,-24(s0)
    802090ac:	feb43023          	sd	a1,-32(s0)
    802090b0:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:50
    return write(fd, buf, count);
    802090b4:	fd843603          	ld	a2,-40(s0)
    802090b8:	fe043583          	ld	a1,-32(s0)
    802090bc:	fe843503          	ld	a0,-24(s0)
    802090c0:	f39ff0ef          	jal	ra,80208ff8 <write>
    802090c4:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:51
}
    802090c6:	853e                	mv	a0,a5
    802090c8:	70a2                	ld	ra,40(sp)
    802090ca:	7402                	ld	s0,32(sp)
    802090cc:	6145                	addi	sp,sp,48
    802090ce:	8082                	ret

00000000802090d0 <sys_exit>:
sys_exit():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:54

void sys_exit(int32_t status)
{
    802090d0:	1101                	addi	sp,sp,-32
    802090d2:	ec06                	sd	ra,24(sp)
    802090d4:	e822                	sd	s0,16(sp)
    802090d6:	1000                	addi	s0,sp,32
    802090d8:	87aa                	mv	a5,a0
    802090da:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:55
    exit(status);
    802090de:	fec42783          	lw	a5,-20(s0)
    802090e2:	853e                	mv	a0,a5
    802090e4:	ed7ff0ef          	jal	ra,80208fba <exit>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:56
}
    802090e8:	0001                	nop
    802090ea:	60e2                	ld	ra,24(sp)
    802090ec:	6442                	ld	s0,16(sp)
    802090ee:	6105                	addi	sp,sp,32
    802090f0:	8082                	ret

00000000802090f2 <sys_yield>:
sys_yield():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:59

int64_t sys_yield()
{
    802090f2:	1141                	addi	sp,sp,-16
    802090f4:	e406                	sd	ra,8(sp)
    802090f6:	e022                	sd	s0,0(sp)
    802090f8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:60
    return yield();
    802090fa:	f83ff0ef          	jal	ra,8020907c <yield>
    802090fe:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:61
}
    80209100:	853e                	mv	a0,a5
    80209102:	60a2                	ld	ra,8(sp)
    80209104:	6402                	ld	s0,0(sp)
    80209106:	0141                	addi	sp,sp,16
    80209108:	8082                	ret

000000008020910a <read>:
read():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:64

size_t read(int32_t fd, uint8_t *buf, size_t len)
{
    8020910a:	7139                	addi	sp,sp,-64
    8020910c:	fc06                	sd	ra,56(sp)
    8020910e:	f822                	sd	s0,48(sp)
    80209110:	0080                	addi	s0,sp,64
    80209112:	87aa                	mv	a5,a0
    80209114:	fcb43823          	sd	a1,-48(s0)
    80209118:	fcc43423          	sd	a2,-56(s0)
    8020911c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:65
    ASSERT(len == 1);
    80209120:	fc843703          	ld	a4,-56(s0)
    80209124:	4785                	li	a5,1
    80209126:	00f70e63          	beq	a4,a5,80209142 <read+0x38>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:65 (discriminator 1)
    8020912a:	00002617          	auipc	a2,0x2
    8020912e:	9e660613          	addi	a2,a2,-1562 # 8020ab10 <MMIO+0x38>
    80209132:	04100593          	li	a1,65
    80209136:	00002517          	auipc	a0,0x2
    8020913a:	9fa50513          	addi	a0,a0,-1542 # 8020ab30 <MMIO+0x58>
    8020913e:	e9efe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:66
    if (fd == 1)
    80209142:	fdc42783          	lw	a5,-36(s0)
    80209146:	0007871b          	sext.w	a4,a5
    8020914a:	4785                	li	a5,1
    8020914c:	00f71e63          	bne	a4,a5,80209168 <read+0x5e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:71
    {
        int32_t c;
        while (1)
        {
            c = console_getchar();
    80209150:	a6efb0ef          	jal	ra,802043be <console_getchar>
    80209154:	87aa                	mv	a5,a0
    80209156:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:72
            if (c == 0)
    8020915a:	fec42783          	lw	a5,-20(s0)
    8020915e:	2781                	sext.w	a5,a5
    80209160:	e38d                	bnez	a5,80209182 <read+0x78>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:74
            {
                task_suspend_current_and_run_next();
    80209162:	890ff0ef          	jal	ra,802081f2 <task_suspend_current_and_run_next>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:70
        {
    80209166:	b7ed                	j	80209150 <read+0x46>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:89 (discriminator 1)
            return 1;
        }
    }
    else
    {
        ASSERT(0);
    80209168:	00002617          	auipc	a2,0x2
    8020916c:	9e860613          	addi	a2,a2,-1560 # 8020ab50 <MMIO+0x78>
    80209170:	05900593          	li	a1,89
    80209174:	00002517          	auipc	a0,0x2
    80209178:	9bc50513          	addi	a0,a0,-1604 # 8020ab30 <MMIO+0x58>
    8020917c:	e60fe0ef          	jal	ra,802077dc <_panic>
    80209180:	a011                	j	80209184 <read+0x7a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:79
                break;
    80209182:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:91
    }
}
    80209184:	0001                	nop
    80209186:	853e                	mv	a0,a5
    80209188:	70e2                	ld	ra,56(sp)
    8020918a:	7442                	ld	s0,48(sp)
    8020918c:	6121                	addi	sp,sp,64
    8020918e:	8082                	ret

0000000080209190 <sys_waitpid>:
sys_waitpid():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:94

int64_t sys_waitpid(int64_t pid, int *exit_code_ptr)
{
    80209190:	711d                	addi	sp,sp,-96
    80209192:	ec86                	sd	ra,88(sp)
    80209194:	e8a2                	sd	s0,80(sp)
    80209196:	1080                	addi	s0,sp,96
    80209198:	faa43423          	sd	a0,-88(s0)
    8020919c:	fab43023          	sd	a1,-96(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:95
    struct TaskControlBlock *task = processor_current_task();
    802091a0:	af6ff0ef          	jal	ra,80208496 <processor_current_task>
    802091a4:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:97

    bool found = false;
    802091a8:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:101
    uint64_t found_idx;
    PidHandle found_pid;
    int exit_code;
    struct TaskControlBlock **x = (struct TaskControlBlock **)(task->children.buffer);
    802091ac:	fd043783          	ld	a5,-48(s0)
    802091b0:	1007b783          	ld	a5,256(a5)
    802091b4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:102
    for (int64_t i = task->children.size - 1; i >= 0; i--)
    802091b8:	fd043783          	ld	a5,-48(s0)
    802091bc:	77fc                	ld	a5,232(a5)
    802091be:	17fd                	addi	a5,a5,-1
    802091c0:	fcf43c23          	sd	a5,-40(s0)
    802091c4:	a0a5                	j	8020922c <sys_waitpid+0x9c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:104
    {
        if (pid == x[i]->pid.pid || pid == -1)
    802091c6:	fd843783          	ld	a5,-40(s0)
    802091ca:	078e                	slli	a5,a5,0x3
    802091cc:	fc843703          	ld	a4,-56(s0)
    802091d0:	97ba                	add	a5,a5,a4
    802091d2:	639c                	ld	a5,0(a5)
    802091d4:	6398                	ld	a4,0(a5)
    802091d6:	fa843783          	ld	a5,-88(s0)
    802091da:	00f70763          	beq	a4,a5,802091e8 <sys_waitpid+0x58>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:104 (discriminator 1)
    802091de:	fa843703          	ld	a4,-88(s0)
    802091e2:	57fd                	li	a5,-1
    802091e4:	02f71f63          	bne	a4,a5,80209222 <sys_waitpid+0x92>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:106
        {
            found = true;
    802091e8:	4785                	li	a5,1
    802091ea:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:107
            found_idx = i;
    802091ee:	fd843783          	ld	a5,-40(s0)
    802091f2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:108
            found_pid = x[i]->pid;
    802091f6:	fd843783          	ld	a5,-40(s0)
    802091fa:	078e                	slli	a5,a5,0x3
    802091fc:	fc843703          	ld	a4,-56(s0)
    80209200:	97ba                	add	a5,a5,a4
    80209202:	639c                	ld	a5,0(a5)
    80209204:	639c                	ld	a5,0(a5)
    80209206:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:109
            exit_code = x[i]->exit_code;
    8020920a:	fd843783          	ld	a5,-40(s0)
    8020920e:	078e                	slli	a5,a5,0x3
    80209210:	fc843703          	ld	a4,-56(s0)
    80209214:	97ba                	add	a5,a5,a4
    80209216:	639c                	ld	a5,0(a5)
    80209218:	1087a783          	lw	a5,264(a5)
    8020921c:	faf42a23          	sw	a5,-76(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:110
            break;
    80209220:	a811                	j	80209234 <sys_waitpid+0xa4>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:102 (discriminator 2)
    for (int64_t i = task->children.size - 1; i >= 0; i--)
    80209222:	fd843783          	ld	a5,-40(s0)
    80209226:	17fd                	addi	a5,a5,-1
    80209228:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:102 (discriminator 1)
    8020922c:	fd843783          	ld	a5,-40(s0)
    80209230:	f807dbe3          	bgez	a5,802091c6 <sys_waitpid+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:113
        }
    }
    if (!found)
    80209234:	fec42783          	lw	a5,-20(s0)
    80209238:	2781                	sext.w	a5,a5
    8020923a:	e399                	bnez	a5,80209240 <sys_waitpid+0xb0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:115
    {
        return -1;
    8020923c:	57fd                	li	a5,-1
    8020923e:	a09d                	j	802092a4 <sys_waitpid+0x114>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:118
    }

    struct TaskControlBlock *task_child = x[found_idx];
    80209240:	fe043783          	ld	a5,-32(s0)
    80209244:	078e                	slli	a5,a5,0x3
    80209246:	fc843703          	ld	a4,-56(s0)
    8020924a:	97ba                	add	a5,a5,a4
    8020924c:	639c                	ld	a5,0(a5)
    8020924e:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:120

    if (task_child->task_status == Zombie)
    80209252:	fc043783          	ld	a5,-64(s0)
    80209256:	0907a783          	lw	a5,144(a5)
    8020925a:	873e                	mv	a4,a5
    8020925c:	4791                	li	a5,4
    8020925e:	04f71263          	bne	a4,a5,802092a2 <sys_waitpid+0x112>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:122
    {
        task_control_block_free(task_child);
    80209262:	fc043503          	ld	a0,-64(s0)
    80209266:	be9fe0ef          	jal	ra,80207e4e <task_control_block_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:123
        vector_remove(&task->children, found_idx);
    8020926a:	fd043783          	ld	a5,-48(s0)
    8020926e:	0e878793          	addi	a5,a5,232
    80209272:	fe043583          	ld	a1,-32(s0)
    80209276:	853e                	mv	a0,a5
    80209278:	7fc000ef          	jal	ra,80209a74 <vector_remove>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:124
        copy_byte_buffer(memory_set_token(&task->memory_set), (uint8_t *)&exit_code,
    8020927c:	fd043783          	ld	a5,-48(s0)
    80209280:	09878793          	addi	a5,a5,152
    80209284:	853e                	mv	a0,a5
    80209286:	c9bfb0ef          	jal	ra,80204f20 <memory_set_token>
    8020928a:	fb440793          	addi	a5,s0,-76
    8020928e:	4705                	li	a4,1
    80209290:	4691                	li	a3,4
    80209292:	fa043603          	ld	a2,-96(s0)
    80209296:	85be                	mv	a1,a5
    80209298:	8d0fd0ef          	jal	ra,80206368 <copy_byte_buffer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:126
                         (uint8_t *)exit_code_ptr, sizeof(int), TO_USER);
        return (int64_t)found_pid.pid;
    8020929c:	fb843783          	ld	a5,-72(s0)
    802092a0:	a011                	j	802092a4 <sys_waitpid+0x114>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:130
    }
    else
    {
        return -2;
    802092a2:	57f9                	li	a5,-2
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:132 (discriminator 1)
    }
}
    802092a4:	853e                	mv	a0,a5
    802092a6:	60e6                	ld	ra,88(sp)
    802092a8:	6446                	ld	s0,80(sp)
    802092aa:	6125                	addi	sp,sp,96
    802092ac:	8082                	ret

00000000802092ae <sys_fork>:
sys_fork():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:134
int64_t sys_fork()
{
    802092ae:	7179                	addi	sp,sp,-48
    802092b0:	f406                	sd	ra,40(sp)
    802092b2:	f022                	sd	s0,32(sp)
    802092b4:	1800                	addi	s0,sp,48
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:135
    printk("[kernel] sys_fork \n\n");
    802092b6:	00002517          	auipc	a0,0x2
    802092ba:	8b250513          	addi	a0,a0,-1870 # 8020ab68 <MMIO+0x90>
    802092be:	d2cf90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:136
    struct TaskControlBlock *current_task = processor_current_task();
    802092c2:	9d4ff0ef          	jal	ra,80208496 <processor_current_task>
    802092c6:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:137
    struct TaskControlBlock *new_task = task_control_block_fork(current_task);
    802092ca:	fe843503          	ld	a0,-24(s0)
    802092ce:	f6dfe0ef          	jal	ra,8020823a <task_control_block_fork>
    802092d2:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:138
    PidHandle new_pid = new_task->pid;
    802092d6:	fe043783          	ld	a5,-32(s0)
    802092da:	639c                	ld	a5,0(a5)
    802092dc:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:142

    // modify trap context of new_task, because it returns immediately after
    // switching
    struct TrapContext *trap_cx = task_control_block_get_trap_cx(new_task);
    802092e0:	fe043503          	ld	a0,-32(s0)
    802092e4:	d36fe0ef          	jal	ra,8020781a <task_control_block_get_trap_cx>
    802092e8:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:146

    // we do not have to move to next instruction since we have done it before
    // for child process, fork returns 0
    trap_cx->x[10] = 0;
    802092ec:	fd843783          	ld	a5,-40(s0)
    802092f0:	0407b823          	sd	zero,80(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:149

    // add new task to scheduler
    task_manager_add_2(&TASK_MANAGER_2, new_task);
    802092f4:	fe043583          	ld	a1,-32(s0)
    802092f8:	00b24517          	auipc	a0,0xb24
    802092fc:	fd850513          	addi	a0,a0,-40 # 80d2d2d0 <TASK_MANAGER_2>
    80209300:	8cffe0ef          	jal	ra,80207bce <task_manager_add_2>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:151

    return (int64_t)new_pid.pid;
    80209304:	fd043783          	ld	a5,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:152
}
    80209308:	853e                	mv	a0,a5
    8020930a:	70a2                	ld	ra,40(sp)
    8020930c:	7402                	ld	s0,32(sp)
    8020930e:	6145                	addi	sp,sp,48
    80209310:	8082                	ret

0000000080209312 <sys_getpid>:
sys_getpid():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:155

int64_t sys_getpid()
{
    80209312:	1101                	addi	sp,sp,-32
    80209314:	ec06                	sd	ra,24(sp)
    80209316:	e822                	sd	s0,16(sp)
    80209318:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:156
    struct TaskControlBlock *task = processor_current_task();
    8020931a:	97cff0ef          	jal	ra,80208496 <processor_current_task>
    8020931e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:157
    return (int64_t)task->pid.pid;
    80209322:	fe843783          	ld	a5,-24(s0)
    80209326:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:158
}
    80209328:	853e                	mv	a0,a5
    8020932a:	60e2                	ld	ra,24(sp)
    8020932c:	6442                	ld	s0,16(sp)
    8020932e:	6105                	addi	sp,sp,32
    80209330:	8082                	ret

0000000080209332 <sys_exec>:
sys_exec():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:161

int64_t sys_exec(char *path)
{
    80209332:	7119                	addi	sp,sp,-128
    80209334:	fc86                	sd	ra,120(sp)
    80209336:	f8a2                	sd	s0,112(sp)
    80209338:	0100                	addi	s0,sp,128
    8020933a:	f8a43423          	sd	a0,-120(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:163
    char app_name[MAX_APP_NAME_LENGTH];
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)app_name,
    8020933e:	978ff0ef          	jal	ra,802084b6 <processor_current_user_token>
    80209342:	f9840793          	addi	a5,s0,-104
    80209346:	4701                	li	a4,0
    80209348:	04000693          	li	a3,64
    8020934c:	f8843603          	ld	a2,-120(s0)
    80209350:	85be                	mv	a1,a5
    80209352:	816fd0ef          	jal	ra,80206368 <copy_byte_buffer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:166
                     (uint8_t *)path, MAX_APP_NAME_LENGTH, FROM_USER);

    uint8_t *data = loader_get_app_data_by_name(app_name);
    80209356:	f9840793          	addi	a5,s0,-104
    8020935a:	853e                	mv	a0,a5
    8020935c:	d4eff0ef          	jal	ra,802088aa <loader_get_app_data_by_name>
    80209360:	87aa                	mv	a5,a0
    80209362:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:167
    size_t size = loader_get_app_size_by_name(app_name);
    80209366:	f9840793          	addi	a5,s0,-104
    8020936a:	853e                	mv	a0,a5
    8020936c:	dceff0ef          	jal	ra,8020893a <loader_get_app_size_by_name>
    80209370:	87aa                	mv	a5,a0
    80209372:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:170
    struct TaskControlBlock *task;

    if (data)
    80209376:	fe843783          	ld	a5,-24(s0)
    8020937a:	cf99                	beqz	a5,80209398 <sys_exec+0x66>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:172
    {
        task = processor_current_task();
    8020937c:	91aff0ef          	jal	ra,80208496 <processor_current_task>
    80209380:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:173
        task_control_block_exec(task, data, size);
    80209384:	fe043603          	ld	a2,-32(s0)
    80209388:	fe843583          	ld	a1,-24(s0)
    8020938c:	fd843503          	ld	a0,-40(s0)
    80209390:	fdbfe0ef          	jal	ra,8020836a <task_control_block_exec>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:174
        return 0;
    80209394:	4781                	li	a5,0
    80209396:	a011                	j	8020939a <sys_exec+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:178
    }
    else
    {
        return -1;
    80209398:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:180 (discriminator 1)
    }
}
    8020939a:	853e                	mv	a0,a5
    8020939c:	70e6                	ld	ra,120(sp)
    8020939e:	7446                	ld	s0,112(sp)
    802093a0:	6109                	addi	sp,sp,128
    802093a2:	8082                	ret

00000000802093a4 <sys_get_time>:
sys_get_time():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:183

int64_t sys_get_time(TimeVal *ts, int64_t tz)
{
    802093a4:	7139                	addi	sp,sp,-64
    802093a6:	fc06                	sd	ra,56(sp)
    802093a8:	f822                	sd	s0,48(sp)
    802093aa:	0080                	addi	s0,sp,64
    802093ac:	fca43423          	sd	a0,-56(s0)
    802093b0:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:185
    TimeVal sys_ts;
    int64_t time_us = timer_get_time_us();
    802093b4:	2f6000ef          	jal	ra,802096aa <timer_get_time_us>
    802093b8:	87aa                	mv	a5,a0
    802093ba:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:186
    sys_ts.sec = time_us / USEC_PER_SEC;
    802093be:	fe843703          	ld	a4,-24(s0)
    802093c2:	000f47b7          	lui	a5,0xf4
    802093c6:	24078793          	addi	a5,a5,576 # f4240 <n+0xf4220>
    802093ca:	02f747b3          	div	a5,a4,a5
    802093ce:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:187
    sys_ts.usec = time_us % USEC_PER_SEC;
    802093d2:	fe843703          	ld	a4,-24(s0)
    802093d6:	000f47b7          	lui	a5,0xf4
    802093da:	24078793          	addi	a5,a5,576 # f4240 <n+0xf4220>
    802093de:	02f767b3          	rem	a5,a4,a5
    802093e2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:188
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)&sys_ts,
    802093e6:	8d0ff0ef          	jal	ra,802084b6 <processor_current_user_token>
    802093ea:	fd840793          	addi	a5,s0,-40
    802093ee:	4705                	li	a4,1
    802093f0:	46c1                	li	a3,16
    802093f2:	fc843603          	ld	a2,-56(s0)
    802093f6:	85be                	mv	a1,a5
    802093f8:	f71fc0ef          	jal	ra,80206368 <copy_byte_buffer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:190
                     (uint8_t *)ts, sizeof(TimeVal), TO_USER);
    return 0;
    802093fc:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:191
}
    802093fe:	853e                	mv	a0,a5
    80209400:	70e2                	ld	ra,56(sp)
    80209402:	7442                	ld	s0,48(sp)
    80209404:	6121                	addi	sp,sp,64
    80209406:	8082                	ret

0000000080209408 <syscall>:
syscall():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:194

int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2)
{
    80209408:	7179                	addi	sp,sp,-48
    8020940a:	f406                	sd	ra,40(sp)
    8020940c:	f022                	sd	s0,32(sp)
    8020940e:	1800                	addi	s0,sp,48
    80209410:	fea43423          	sd	a0,-24(s0)
    80209414:	feb43023          	sd	a1,-32(s0)
    80209418:	fcc43c23          	sd	a2,-40(s0)
    8020941c:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:195
    switch (syscall_id)
    80209420:	fe843703          	ld	a4,-24(s0)
    80209424:	10400793          	li	a5,260
    80209428:	0af70d63          	beq	a4,a5,802094e2 <syscall+0xda>
    8020942c:	fe843703          	ld	a4,-24(s0)
    80209430:	10400793          	li	a5,260
    80209434:	14e7e463          	bltu	a5,a4,8020957c <syscall+0x174>
    80209438:	fe843703          	ld	a4,-24(s0)
    8020943c:	0dd00793          	li	a5,221
    80209440:	12f70763          	beq	a4,a5,8020956e <syscall+0x166>
    80209444:	fe843703          	ld	a4,-24(s0)
    80209448:	0dd00793          	li	a5,221
    8020944c:	12e7e863          	bltu	a5,a4,8020957c <syscall+0x174>
    80209450:	fe843703          	ld	a4,-24(s0)
    80209454:	0dc00793          	li	a5,220
    80209458:	10f70163          	beq	a4,a5,8020955a <syscall+0x152>
    8020945c:	fe843703          	ld	a4,-24(s0)
    80209460:	0dc00793          	li	a5,220
    80209464:	10e7ec63          	bltu	a5,a4,8020957c <syscall+0x174>
    80209468:	fe843703          	ld	a4,-24(s0)
    8020946c:	0ac00793          	li	a5,172
    80209470:	0ef70163          	beq	a4,a5,80209552 <syscall+0x14a>
    80209474:	fe843703          	ld	a4,-24(s0)
    80209478:	0ac00793          	li	a5,172
    8020947c:	10e7e063          	bltu	a5,a4,8020957c <syscall+0x174>
    80209480:	fe843703          	ld	a4,-24(s0)
    80209484:	0a900793          	li	a5,169
    80209488:	0af70b63          	beq	a4,a5,8020953e <syscall+0x136>
    8020948c:	fe843703          	ld	a4,-24(s0)
    80209490:	0a900793          	li	a5,169
    80209494:	0ee7e463          	bltu	a5,a4,8020957c <syscall+0x174>
    80209498:	fe843703          	ld	a4,-24(s0)
    8020949c:	07c00793          	li	a5,124
    802094a0:	08f70b63          	beq	a4,a5,80209536 <syscall+0x12e>
    802094a4:	fe843703          	ld	a4,-24(s0)
    802094a8:	07c00793          	li	a5,124
    802094ac:	0ce7e863          	bltu	a5,a4,8020957c <syscall+0x174>
    802094b0:	fe843703          	ld	a4,-24(s0)
    802094b4:	05d00793          	li	a5,93
    802094b8:	06f70763          	beq	a4,a5,80209526 <syscall+0x11e>
    802094bc:	fe843703          	ld	a4,-24(s0)
    802094c0:	05d00793          	li	a5,93
    802094c4:	0ae7ec63          	bltu	a5,a4,8020957c <syscall+0x174>
    802094c8:	fe843703          	ld	a4,-24(s0)
    802094cc:	03f00793          	li	a5,63
    802094d0:	02f70363          	beq	a4,a5,802094f6 <syscall+0xee>
    802094d4:	fe843703          	ld	a4,-24(s0)
    802094d8:	04000793          	li	a5,64
    802094dc:	02f70a63          	beq	a4,a5,80209510 <syscall+0x108>
    802094e0:	a871                	j	8020957c <syscall+0x174>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:198
    {
    case SYSCALL_WAITPID:
        return sys_waitpid((int64_t)a0, (int *)a1);
    802094e2:	fe043783          	ld	a5,-32(s0)
    802094e6:	fd843703          	ld	a4,-40(s0)
    802094ea:	85ba                	mv	a1,a4
    802094ec:	853e                	mv	a0,a5
    802094ee:	ca3ff0ef          	jal	ra,80209190 <sys_waitpid>
    802094f2:	87aa                	mv	a5,a0
    802094f4:	a855                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:200
    case SYSCALL_READ:
        return read(a0, (char *)a1, a2);
    802094f6:	fe043783          	ld	a5,-32(s0)
    802094fa:	2781                	sext.w	a5,a5
    802094fc:	fd843703          	ld	a4,-40(s0)
    80209500:	fd043603          	ld	a2,-48(s0)
    80209504:	85ba                	mv	a1,a4
    80209506:	853e                	mv	a0,a5
    80209508:	c03ff0ef          	jal	ra,8020910a <read>
    8020950c:	87aa                	mv	a5,a0
    8020950e:	a869                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:202
    case SYSCALL_WRITE:
        return sys_write(a0, (char *)a1, a2);
    80209510:	fd843783          	ld	a5,-40(s0)
    80209514:	fd043603          	ld	a2,-48(s0)
    80209518:	85be                	mv	a1,a5
    8020951a:	fe043503          	ld	a0,-32(s0)
    8020951e:	b83ff0ef          	jal	ra,802090a0 <sys_write>
    80209522:	87aa                	mv	a5,a0
    80209524:	a051                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:204
    case SYSCALL_EXIT:
        sys_exit((int)a0);
    80209526:	fe043783          	ld	a5,-32(s0)
    8020952a:	2781                	sext.w	a5,a5
    8020952c:	853e                	mv	a0,a5
    8020952e:	ba3ff0ef          	jal	ra,802090d0 <sys_exit>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:205
        return -1;
    80209532:	57fd                	li	a5,-1
    80209534:	a895                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:207
    case SYSCALL_YIELD:
        return yield();
    80209536:	b47ff0ef          	jal	ra,8020907c <yield>
    8020953a:	87aa                	mv	a5,a0
    8020953c:	a0b5                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:211
    // case SYSCALL_SET_PRIORITY:
    //     return set_priority((int64_t)a0);
    case SYSCALL_GET_TIME:
        return sys_get_time((TimeVal *)a0, (int64_t)a1);
    8020953e:	fe043783          	ld	a5,-32(s0)
    80209542:	fd843703          	ld	a4,-40(s0)
    80209546:	85ba                	mv	a1,a4
    80209548:	853e                	mv	a0,a5
    8020954a:	e5bff0ef          	jal	ra,802093a4 <sys_get_time>
    8020954e:	87aa                	mv	a5,a0
    80209550:	a8a1                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:213
    case SYSCALL_GETPID:
        return sys_getpid();
    80209552:	dc1ff0ef          	jal	ra,80209312 <sys_getpid>
    80209556:	87aa                	mv	a5,a0
    80209558:	a881                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:217
    // case SYSCALL_MUNMAP:
    //     return sys_munmap(a0, a1);
    case SYSCALL_FORK:
        printk("[kernel] sys_fork \n\n");
    8020955a:	00001517          	auipc	a0,0x1
    8020955e:	60e50513          	addi	a0,a0,1550 # 8020ab68 <MMIO+0x90>
    80209562:	a88f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:218
        return sys_fork();
    80209566:	d49ff0ef          	jal	ra,802092ae <sys_fork>
    8020956a:	87aa                	mv	a5,a0
    8020956c:	a835                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:220
    case SYSCALL_EXEC:
        return sys_exec((char *)a0);
    8020956e:	fe043783          	ld	a5,-32(s0)
    80209572:	853e                	mv	a0,a5
    80209574:	dbfff0ef          	jal	ra,80209332 <sys_exec>
    80209578:	87aa                	mv	a5,a0
    8020957a:	a03d                	j	802095a8 <syscall+0x1a0>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:228
    // case SYSCALL_WAITPID:
    //     return sys_waitpid((int64_t)a0, (int *)a1);
    // case SYSCALL_SPAWN:
    //     return sys_spawn((char *)a0);
    default:
        printk("unsopport_sys_id %d", syscall_id);
    8020957c:	fe843583          	ld	a1,-24(s0)
    80209580:	00001517          	auipc	a0,0x1
    80209584:	60050513          	addi	a0,a0,1536 # 8020ab80 <MMIO+0xa8>
    80209588:	a62f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:229
        ASSERT(0);
    8020958c:	00001617          	auipc	a2,0x1
    80209590:	5c460613          	addi	a2,a2,1476 # 8020ab50 <MMIO+0x78>
    80209594:	0e500593          	li	a1,229
    80209598:	00001517          	auipc	a0,0x1
    8020959c:	59850513          	addi	a0,a0,1432 # 8020ab30 <MMIO+0x58>
    802095a0:	a3cfe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:230
        break;
    802095a4:	0001                	nop
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:232
    }
    return -1;
    802095a6:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/syscall/syscall.c:233
}
    802095a8:	853e                	mv	a0,a5
    802095aa:	70a2                	ld	ra,40(sp)
    802095ac:	7402                	ld	s0,32(sp)
    802095ae:	6145                	addi	sp,sp,48
    802095b0:	8082                	ret

00000000802095b2 <r_sie>:
r_sie():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:80
{
    802095b2:	1101                	addi	sp,sp,-32
    802095b4:	ec22                	sd	s0,24(sp)
    802095b6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:82
  asm volatile("csrr %0, sie" : "=r"(x));
    802095b8:	104027f3          	csrr	a5,sie
    802095bc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:83
  return x;
    802095c0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:84
}
    802095c4:	853e                	mv	a0,a5
    802095c6:	6462                	ld	s0,24(sp)
    802095c8:	6105                	addi	sp,sp,32
    802095ca:	8082                	ret

00000000802095cc <w_sie>:
w_sie():
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:87
{
    802095cc:	1101                	addi	sp,sp,-32
    802095ce:	ec22                	sd	s0,24(sp)
    802095d0:	1000                	addi	s0,sp,32
    802095d2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:88
  asm volatile("csrw sie, %0" : : "r"(x));
    802095d6:	fe843783          	ld	a5,-24(s0)
    802095da:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/globle/riscv.h:89
}
    802095de:	0001                	nop
    802095e0:	6462                	ld	s0,24(sp)
    802095e2:	6105                	addi	sp,sp,32
    802095e4:	8082                	ret

00000000802095e6 <read_time>:
read_time():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:6
#include "timer.h"
#include "sbi.h"
#include "task.h"
#include "riscv.h"
static inline uint64_t read_time(void)
{
    802095e6:	1101                	addi	sp,sp,-32
    802095e8:	ec22                	sd	s0,24(sp)
    802095ea:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:8
    uint64_t time;
    __asm__ volatile("csrr %0, time" : "=r"(time));
    802095ec:	c01027f3          	rdtime	a5
    802095f0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:9
    return time;
    802095f4:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:10
}
    802095f8:	853e                	mv	a0,a5
    802095fa:	6462                	ld	s0,24(sp)
    802095fc:	6105                	addi	sp,sp,32
    802095fe:	8082                	ret

0000000080209600 <clock_set_next_event>:
clock_set_next_event():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:13

void clock_set_next_event()
{
    80209600:	1141                	addi	sp,sp,-16
    80209602:	e406                	sd	ra,8(sp)
    80209604:	e022                	sd	s0,0(sp)
    80209606:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:14
    sbi_set_timer(read_time() + TIMEBASE);
    80209608:	fdfff0ef          	jal	ra,802095e6 <read_time>
    8020960c:	87aa                	mv	a5,a0
    8020960e:	06478793          	addi	a5,a5,100
    80209612:	853e                	mv	a0,a5
    80209614:	debfa0ef          	jal	ra,802043fe <sbi_set_timer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:15
}
    80209618:	0001                	nop
    8020961a:	60a2                	ld	ra,8(sp)
    8020961c:	6402                	ld	s0,0(sp)
    8020961e:	0141                	addi	sp,sp,16
    80209620:	8082                	ret

0000000080209622 <timer_init>:
timer_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:18

void timer_init()
{
    80209622:	1141                	addi	sp,sp,-16
    80209624:	e406                	sd	ra,8(sp)
    80209626:	e022                	sd	s0,0(sp)
    80209628:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:19
    clock_set_next_event();
    8020962a:	fd7ff0ef          	jal	ra,80209600 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:21
    // print_str("----timer_init----\n");
}
    8020962e:	0001                	nop
    80209630:	60a2                	ld	ra,8(sp)
    80209632:	6402                	ld	s0,0(sp)
    80209634:	0141                	addi	sp,sp,16
    80209636:	8082                	ret

0000000080209638 <intr_timer_handle>:
intr_timer_handle():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:24

void intr_timer_handle()
{
    80209638:	1141                	addi	sp,sp,-16
    8020963a:	e406                	sd	ra,8(sp)
    8020963c:	e022                	sd	s0,0(sp)
    8020963e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:25
    printk("intr_timer_handle\n");
    80209640:	00001517          	auipc	a0,0x1
    80209644:	56850513          	addi	a0,a0,1384 # 8020aba8 <MMIO+0x10>
    80209648:	9a2f90ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:27
    // run_next_task(1);
    ticks++;
    8020964c:	00b24797          	auipc	a5,0xb24
    80209650:	c7c78793          	addi	a5,a5,-900 # 80d2d2c8 <ticks>
    80209654:	639c                	ld	a5,0(a5)
    80209656:	00178713          	addi	a4,a5,1
    8020965a:	00b24797          	auipc	a5,0xb24
    8020965e:	c6e78793          	addi	a5,a5,-914 # 80d2d2c8 <ticks>
    80209662:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:28
    clock_set_next_event();
    80209664:	f9dff0ef          	jal	ra,80209600 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:29
    if (ticks % 10 == 0)
    80209668:	00b24797          	auipc	a5,0xb24
    8020966c:	c6078793          	addi	a5,a5,-928 # 80d2d2c8 <ticks>
    80209670:	6398                	ld	a4,0(a5)
    80209672:	47a9                	li	a5,10
    80209674:	02f777b3          	remu	a5,a4,a5
    80209678:	e799                	bnez	a5,80209686 <intr_timer_handle+0x4e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:31
    {
        print_str("timer_interrupt\n");
    8020967a:	00001517          	auipc	a0,0x1
    8020967e:	54650513          	addi	a0,a0,1350 # 8020abc0 <MMIO+0x28>
    80209682:	e97fd0ef          	jal	ra,80207518 <print_str>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:40
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
}
    80209686:	0001                	nop
    80209688:	60a2                	ld	ra,8(sp)
    8020968a:	6402                	ld	s0,0(sp)
    8020968c:	0141                	addi	sp,sp,16
    8020968e:	8082                	ret

0000000080209690 <timer_get_time>:
timer_get_time():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:43

uint64_t timer_get_time()
{
    80209690:	1101                	addi	sp,sp,-32
    80209692:	ec22                	sd	s0,24(sp)
    80209694:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:45
    uint64_t time;
    asm volatile("rdtime %0" : "=r"(time));
    80209696:	c01027f3          	rdtime	a5
    8020969a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:46
    return time;
    8020969e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:47
}
    802096a2:	853e                	mv	a0,a5
    802096a4:	6462                	ld	s0,24(sp)
    802096a6:	6105                	addi	sp,sp,32
    802096a8:	8082                	ret

00000000802096aa <timer_get_time_us>:
timer_get_time_us():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:50

uint64_t timer_get_time_us()
{
    802096aa:	1141                	addi	sp,sp,-16
    802096ac:	e406                	sd	ra,8(sp)
    802096ae:	e022                	sd	s0,0(sp)
    802096b0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:51
    return timer_get_time() / (CLOCK_FREQ / USEC_PER_SEC);
    802096b2:	fdfff0ef          	jal	ra,80209690 <timer_get_time>
    802096b6:	872a                	mv	a4,a0
    802096b8:	47a9                	li	a5,10
    802096ba:	02f757b3          	divu	a5,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:52
}
    802096be:	853e                	mv	a0,a5
    802096c0:	60a2                	ld	ra,8(sp)
    802096c2:	6402                	ld	s0,0(sp)
    802096c4:	0141                	addi	sp,sp,16
    802096c6:	8082                	ret

00000000802096c8 <timer_set_next_trigger>:
timer_set_next_trigger():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:55

void timer_set_next_trigger()
{
    802096c8:	1141                	addi	sp,sp,-16
    802096ca:	e406                	sd	ra,8(sp)
    802096cc:	e022                	sd	s0,0(sp)
    802096ce:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:56
    sbi_set_timer(timer_get_time() + CLOCK_FREQ / TICKS_PER_SEC);
    802096d0:	fc1ff0ef          	jal	ra,80209690 <timer_get_time>
    802096d4:	872a                	mv	a4,a0
    802096d6:	67e1                	lui	a5,0x18
    802096d8:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    802096dc:	97ba                	add	a5,a5,a4
    802096de:	853e                	mv	a0,a5
    802096e0:	d1ffa0ef          	jal	ra,802043fe <sbi_set_timer>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:57
}
    802096e4:	0001                	nop
    802096e6:	60a2                	ld	ra,8(sp)
    802096e8:	6402                	ld	s0,0(sp)
    802096ea:	0141                	addi	sp,sp,16
    802096ec:	8082                	ret

00000000802096ee <trap_enable_timer_interrupt>:
trap_enable_timer_interrupt():
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:60

void trap_enable_timer_interrupt()
{
    802096ee:	1141                	addi	sp,sp,-16
    802096f0:	e406                	sd	ra,8(sp)
    802096f2:	e022                	sd	s0,0(sp)
    802096f4:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:62
    // Trap enable timer interrupt
    w_sie(r_sie() | SIE_STIE_BIT);
    802096f6:	ebdff0ef          	jal	ra,802095b2 <r_sie>
    802096fa:	87aa                	mv	a5,a0
    802096fc:	0207e793          	ori	a5,a5,32
    80209700:	853e                	mv	a0,a5
    80209702:	ecbff0ef          	jal	ra,802095cc <w_sie>
/home/caigoubencai/Desktop/os_c-ch6/kernel/trap/timer/timer.c:63
    80209706:	0001                	nop
    80209708:	60a2                	ld	ra,8(sp)
    8020970a:	6402                	ld	s0,0(sp)
    8020970c:	0141                	addi	sp,sp,16
    8020970e:	8082                	ret

0000000080209710 <lst_init>:
lst_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:11
// double-linked, circular list. double-linked makes remove
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void lst_init(struct list *lst)
{
    80209710:	1101                	addi	sp,sp,-32
    80209712:	ec22                	sd	s0,24(sp)
    80209714:	1000                	addi	s0,sp,32
    80209716:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:12
  lst->next = lst;
    8020971a:	fe843783          	ld	a5,-24(s0)
    8020971e:	fe843703          	ld	a4,-24(s0)
    80209722:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:13
  lst->prev = lst;
    80209724:	fe843783          	ld	a5,-24(s0)
    80209728:	fe843703          	ld	a4,-24(s0)
    8020972c:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:14
}
    8020972e:	0001                	nop
    80209730:	6462                	ld	s0,24(sp)
    80209732:	6105                	addi	sp,sp,32
    80209734:	8082                	ret

0000000080209736 <lst_empty>:
lst_empty():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:16

int lst_empty(struct list *lst) { return lst->next == lst; }
    80209736:	1101                	addi	sp,sp,-32
    80209738:	ec22                	sd	s0,24(sp)
    8020973a:	1000                	addi	s0,sp,32
    8020973c:	fea43423          	sd	a0,-24(s0)
    80209740:	fe843783          	ld	a5,-24(s0)
    80209744:	639c                	ld	a5,0(a5)
    80209746:	fe843703          	ld	a4,-24(s0)
    8020974a:	40f707b3          	sub	a5,a4,a5
    8020974e:	0017b793          	seqz	a5,a5
    80209752:	0ff7f793          	andi	a5,a5,255
    80209756:	2781                	sext.w	a5,a5
    80209758:	853e                	mv	a0,a5
    8020975a:	6462                	ld	s0,24(sp)
    8020975c:	6105                	addi	sp,sp,32
    8020975e:	8082                	ret

0000000080209760 <lst_remove>:
lst_remove():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:19

void lst_remove(struct list *e)
{
    80209760:	1101                	addi	sp,sp,-32
    80209762:	ec22                	sd	s0,24(sp)
    80209764:	1000                	addi	s0,sp,32
    80209766:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:20
  e->prev->next = e->next;
    8020976a:	fe843783          	ld	a5,-24(s0)
    8020976e:	679c                	ld	a5,8(a5)
    80209770:	fe843703          	ld	a4,-24(s0)
    80209774:	6318                	ld	a4,0(a4)
    80209776:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:21
  e->next->prev = e->prev;
    80209778:	fe843783          	ld	a5,-24(s0)
    8020977c:	639c                	ld	a5,0(a5)
    8020977e:	fe843703          	ld	a4,-24(s0)
    80209782:	6718                	ld	a4,8(a4)
    80209784:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:22
}
    80209786:	0001                	nop
    80209788:	6462                	ld	s0,24(sp)
    8020978a:	6105                	addi	sp,sp,32
    8020978c:	8082                	ret

000000008020978e <lst_pop>:
lst_pop():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:25

void *lst_pop(struct list *lst)
{
    8020978e:	7179                	addi	sp,sp,-48
    80209790:	f406                	sd	ra,40(sp)
    80209792:	f022                	sd	s0,32(sp)
    80209794:	1800                	addi	s0,sp,48
    80209796:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:26
  if (lst->next == lst)
    8020979a:	fd843783          	ld	a5,-40(s0)
    8020979e:	639c                	ld	a5,0(a5)
    802097a0:	fd843703          	ld	a4,-40(s0)
    802097a4:	00f71d63          	bne	a4,a5,802097be <lst_pop+0x30>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:27
    panic("lst_pop");
    802097a8:	00001617          	auipc	a2,0x1
    802097ac:	43060613          	addi	a2,a2,1072 # 8020abd8 <MMIO+0x40>
    802097b0:	45ed                	li	a1,27
    802097b2:	00001517          	auipc	a0,0x1
    802097b6:	42e50513          	addi	a0,a0,1070 # 8020abe0 <MMIO+0x48>
    802097ba:	822fe0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:28
  struct list *p = lst->next;
    802097be:	fd843783          	ld	a5,-40(s0)
    802097c2:	639c                	ld	a5,0(a5)
    802097c4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:29
  lst_remove(p);
    802097c8:	fe843503          	ld	a0,-24(s0)
    802097cc:	f95ff0ef          	jal	ra,80209760 <lst_remove>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:30
  return (void *)p;
    802097d0:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:31
}
    802097d4:	853e                	mv	a0,a5
    802097d6:	70a2                	ld	ra,40(sp)
    802097d8:	7402                	ld	s0,32(sp)
    802097da:	6145                	addi	sp,sp,48
    802097dc:	8082                	ret

00000000802097de <lst_push>:
lst_push():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:34

void lst_push(struct list *lst, void *p)
{
    802097de:	7179                	addi	sp,sp,-48
    802097e0:	f422                	sd	s0,40(sp)
    802097e2:	1800                	addi	s0,sp,48
    802097e4:	fca43c23          	sd	a0,-40(s0)
    802097e8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:35
  struct list *e = (struct list *)p;
    802097ec:	fd043783          	ld	a5,-48(s0)
    802097f0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:36
  e->next = lst->next;
    802097f4:	fd843783          	ld	a5,-40(s0)
    802097f8:	6398                	ld	a4,0(a5)
    802097fa:	fe843783          	ld	a5,-24(s0)
    802097fe:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:37
  e->prev = lst;
    80209800:	fe843783          	ld	a5,-24(s0)
    80209804:	fd843703          	ld	a4,-40(s0)
    80209808:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:38
  lst->next->prev = p;
    8020980a:	fd843783          	ld	a5,-40(s0)
    8020980e:	639c                	ld	a5,0(a5)
    80209810:	fd043703          	ld	a4,-48(s0)
    80209814:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:39
  lst->next = e;
    80209816:	fd843783          	ld	a5,-40(s0)
    8020981a:	fe843703          	ld	a4,-24(s0)
    8020981e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:40
}
    80209820:	0001                	nop
    80209822:	7422                	ld	s0,40(sp)
    80209824:	6145                	addi	sp,sp,48
    80209826:	8082                	ret

0000000080209828 <lst_print>:
lst_print():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:43

void lst_print(struct list *lst)
{
    80209828:	7179                	addi	sp,sp,-48
    8020982a:	f406                	sd	ra,40(sp)
    8020982c:	f022                	sd	s0,32(sp)
    8020982e:	1800                	addi	s0,sp,48
    80209830:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:44
  for (struct list *p = lst->next; p != lst; p = p->next)
    80209834:	fd843783          	ld	a5,-40(s0)
    80209838:	639c                	ld	a5,0(a5)
    8020983a:	fef43423          	sd	a5,-24(s0)
    8020983e:	a831                	j	8020985a <lst_print+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:46 (discriminator 3)
  {
    printk(" %p", p);
    80209840:	fe843583          	ld	a1,-24(s0)
    80209844:	00001517          	auipc	a0,0x1
    80209848:	3bc50513          	addi	a0,a0,956 # 8020ac00 <MMIO+0x68>
    8020984c:	f9ff80ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:44 (discriminator 3)
  for (struct list *p = lst->next; p != lst; p = p->next)
    80209850:	fe843783          	ld	a5,-24(s0)
    80209854:	639c                	ld	a5,0(a5)
    80209856:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:44 (discriminator 1)
    8020985a:	fe843703          	ld	a4,-24(s0)
    8020985e:	fd843783          	ld	a5,-40(s0)
    80209862:	fcf71fe3          	bne	a4,a5,80209840 <lst_print+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:48
  }
  printk("\n");
    80209866:	00001517          	auipc	a0,0x1
    8020986a:	3a250513          	addi	a0,a0,930 # 8020ac08 <MMIO+0x70>
    8020986e:	f7df80ef          	jal	ra,802027ea <printk>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/list.c:49
}
    80209872:	0001                	nop
    80209874:	70a2                	ld	ra,40(sp)
    80209876:	7402                	ld	s0,32(sp)
    80209878:	6145                	addi	sp,sp,48
    8020987a:	8082                	ret

000000008020987c <vector_new>:
vector_new():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:10
#include "buddy.h"
#include "debug.h"
#define VECTOR_INIT_CAPACITY 8

void vector_new(struct vector *v, uint64_t dsize)
{
    8020987c:	1101                	addi	sp,sp,-32
    8020987e:	ec06                	sd	ra,24(sp)
    80209880:	e822                	sd	s0,16(sp)
    80209882:	1000                	addi	s0,sp,32
    80209884:	fea43423          	sd	a0,-24(s0)
    80209888:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:11
  v->size = 0;
    8020988c:	fe843783          	ld	a5,-24(s0)
    80209890:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:12
  v->capacity = VECTOR_INIT_CAPACITY;
    80209894:	fe843783          	ld	a5,-24(s0)
    80209898:	4721                	li	a4,8
    8020989a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:13
  v->dsize = dsize;
    8020989c:	fe843783          	ld	a5,-24(s0)
    802098a0:	fe043703          	ld	a4,-32(s0)
    802098a4:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:14
  v->buffer = bd_malloc(v->capacity * v->dsize);
    802098a6:	fe843783          	ld	a5,-24(s0)
    802098aa:	6798                	ld	a4,8(a5)
    802098ac:	fe843783          	ld	a5,-24(s0)
    802098b0:	6b9c                	ld	a5,16(a5)
    802098b2:	02f707b3          	mul	a5,a4,a5
    802098b6:	853e                	mv	a0,a5
    802098b8:	95afd0ef          	jal	ra,80206a12 <bd_malloc>
    802098bc:	872a                	mv	a4,a0
    802098be:	fe843783          	ld	a5,-24(s0)
    802098c2:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:15
}
    802098c4:	0001                	nop
    802098c6:	60e2                	ld	ra,24(sp)
    802098c8:	6442                	ld	s0,16(sp)
    802098ca:	6105                	addi	sp,sp,32
    802098cc:	8082                	ret

00000000802098ce <vector_push>:
vector_push():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:18

void vector_push(struct vector *v, void *d)
{
    802098ce:	7179                	addi	sp,sp,-48
    802098d0:	f406                	sd	ra,40(sp)
    802098d2:	f022                	sd	s0,32(sp)
    802098d4:	1800                	addi	s0,sp,48
    802098d6:	fca43c23          	sd	a0,-40(s0)
    802098da:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:19
  if (v->size == v->capacity)
    802098de:	fd843783          	ld	a5,-40(s0)
    802098e2:	6398                	ld	a4,0(a5)
    802098e4:	fd843783          	ld	a5,-40(s0)
    802098e8:	679c                	ld	a5,8(a5)
    802098ea:	06f71763          	bne	a4,a5,80209958 <vector_push+0x8a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:21
  {
    v->capacity <<= 1;
    802098ee:	fd843783          	ld	a5,-40(s0)
    802098f2:	679c                	ld	a5,8(a5)
    802098f4:	00179713          	slli	a4,a5,0x1
    802098f8:	fd843783          	ld	a5,-40(s0)
    802098fc:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:22
    char *t = bd_malloc(v->capacity * v->dsize);
    802098fe:	fd843783          	ld	a5,-40(s0)
    80209902:	6798                	ld	a4,8(a5)
    80209904:	fd843783          	ld	a5,-40(s0)
    80209908:	6b9c                	ld	a5,16(a5)
    8020990a:	02f707b3          	mul	a5,a4,a5
    8020990e:	853e                	mv	a0,a5
    80209910:	902fd0ef          	jal	ra,80206a12 <bd_malloc>
    80209914:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:23
    memcpy((uint8_t *)t, (uint8_t *)v->buffer, v->size * v->dsize);
    80209918:	fd843783          	ld	a5,-40(s0)
    8020991c:	6f94                	ld	a3,24(a5)
    8020991e:	fd843783          	ld	a5,-40(s0)
    80209922:	639c                	ld	a5,0(a5)
    80209924:	0007871b          	sext.w	a4,a5
    80209928:	fd843783          	ld	a5,-40(s0)
    8020992c:	6b9c                	ld	a5,16(a5)
    8020992e:	2781                	sext.w	a5,a5
    80209930:	02f707bb          	mulw	a5,a4,a5
    80209934:	2781                	sext.w	a5,a5
    80209936:	863e                	mv	a2,a5
    80209938:	85b6                	mv	a1,a3
    8020993a:	fe843503          	ld	a0,-24(s0)
    8020993e:	eb1fa0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:24
    bd_free(v->buffer);
    80209942:	fd843783          	ld	a5,-40(s0)
    80209946:	6f9c                	ld	a5,24(a5)
    80209948:	853e                	mv	a0,a5
    8020994a:	acafd0ef          	jal	ra,80206c14 <bd_free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:25
    v->buffer = t;
    8020994e:	fd843783          	ld	a5,-40(s0)
    80209952:	fe843703          	ld	a4,-24(s0)
    80209956:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:27
  }
  memcpy((uint8_t *)(v->buffer + (v->size++) * v->dsize), d, v->dsize);
    80209958:	fd843783          	ld	a5,-40(s0)
    8020995c:	6f98                	ld	a4,24(a5)
    8020995e:	fd843783          	ld	a5,-40(s0)
    80209962:	639c                	ld	a5,0(a5)
    80209964:	00178613          	addi	a2,a5,1
    80209968:	fd843683          	ld	a3,-40(s0)
    8020996c:	e290                	sd	a2,0(a3)
    8020996e:	fd843683          	ld	a3,-40(s0)
    80209972:	6a94                	ld	a3,16(a3)
    80209974:	02d787b3          	mul	a5,a5,a3
    80209978:	973e                	add	a4,a4,a5
    8020997a:	fd843783          	ld	a5,-40(s0)
    8020997e:	6b9c                	ld	a5,16(a5)
    80209980:	2781                	sext.w	a5,a5
    80209982:	863e                	mv	a2,a5
    80209984:	fd043583          	ld	a1,-48(s0)
    80209988:	853a                	mv	a0,a4
    8020998a:	e65fa0ef          	jal	ra,802047ee <memcpy>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:28
}
    8020998e:	0001                	nop
    80209990:	70a2                	ld	ra,40(sp)
    80209992:	7402                	ld	s0,32(sp)
    80209994:	6145                	addi	sp,sp,48
    80209996:	8082                	ret

0000000080209998 <vector_pop>:
vector_pop():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:31

void vector_pop(struct vector *v)
{
    80209998:	1101                	addi	sp,sp,-32
    8020999a:	ec06                	sd	ra,24(sp)
    8020999c:	e822                	sd	s0,16(sp)
    8020999e:	1000                	addi	s0,sp,32
    802099a0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:32
  if (v->size == 0)
    802099a4:	fe843783          	ld	a5,-24(s0)
    802099a8:	639c                	ld	a5,0(a5)
    802099aa:	ef89                	bnez	a5,802099c4 <vector_pop+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:33
    panic("empty vector pop\n");
    802099ac:	00001617          	auipc	a2,0x1
    802099b0:	26460613          	addi	a2,a2,612 # 8020ac10 <MMIO+0x78>
    802099b4:	02100593          	li	a1,33
    802099b8:	00001517          	auipc	a0,0x1
    802099bc:	27050513          	addi	a0,a0,624 # 8020ac28 <MMIO+0x90>
    802099c0:	e1dfd0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:34
  v->size--;
    802099c4:	fe843783          	ld	a5,-24(s0)
    802099c8:	639c                	ld	a5,0(a5)
    802099ca:	fff78713          	addi	a4,a5,-1
    802099ce:	fe843783          	ld	a5,-24(s0)
    802099d2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:35
}
    802099d4:	0001                	nop
    802099d6:	60e2                	ld	ra,24(sp)
    802099d8:	6442                	ld	s0,16(sp)
    802099da:	6105                	addi	sp,sp,32
    802099dc:	8082                	ret

00000000802099de <vector_back>:
vector_back():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:38

void *vector_back(struct vector *v)
{
    802099de:	1101                	addi	sp,sp,-32
    802099e0:	ec06                	sd	ra,24(sp)
    802099e2:	e822                	sd	s0,16(sp)
    802099e4:	1000                	addi	s0,sp,32
    802099e6:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:39
  if (!v->size)
    802099ea:	fe843783          	ld	a5,-24(s0)
    802099ee:	639c                	ld	a5,0(a5)
    802099f0:	ef89                	bnez	a5,80209a0a <vector_back+0x2c>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:40
    panic("empty vector back\n");
    802099f2:	00001617          	auipc	a2,0x1
    802099f6:	25660613          	addi	a2,a2,598 # 8020ac48 <MMIO+0xb0>
    802099fa:	02800593          	li	a1,40
    802099fe:	00001517          	auipc	a0,0x1
    80209a02:	22a50513          	addi	a0,a0,554 # 8020ac28 <MMIO+0x90>
    80209a06:	dd7fd0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:41
  return v->buffer + (v->size - 1) * v->dsize;
    80209a0a:	fe843783          	ld	a5,-24(s0)
    80209a0e:	6f98                	ld	a4,24(a5)
    80209a10:	fe843783          	ld	a5,-24(s0)
    80209a14:	639c                	ld	a5,0(a5)
    80209a16:	fff78693          	addi	a3,a5,-1
    80209a1a:	fe843783          	ld	a5,-24(s0)
    80209a1e:	6b9c                	ld	a5,16(a5)
    80209a20:	02f687b3          	mul	a5,a3,a5
    80209a24:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:42
}
    80209a26:	853e                	mv	a0,a5
    80209a28:	60e2                	ld	ra,24(sp)
    80209a2a:	6442                	ld	s0,16(sp)
    80209a2c:	6105                	addi	sp,sp,32
    80209a2e:	8082                	ret

0000000080209a30 <vector_empty>:
vector_empty():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:44

int vector_empty(struct vector *v) { return !v->size; }
    80209a30:	1101                	addi	sp,sp,-32
    80209a32:	ec22                	sd	s0,24(sp)
    80209a34:	1000                	addi	s0,sp,32
    80209a36:	fea43423          	sd	a0,-24(s0)
    80209a3a:	fe843783          	ld	a5,-24(s0)
    80209a3e:	639c                	ld	a5,0(a5)
    80209a40:	0017b793          	seqz	a5,a5
    80209a44:	0ff7f793          	andi	a5,a5,255
    80209a48:	2781                	sext.w	a5,a5
    80209a4a:	853e                	mv	a0,a5
    80209a4c:	6462                	ld	s0,24(sp)
    80209a4e:	6105                	addi	sp,sp,32
    80209a50:	8082                	ret

0000000080209a52 <vector_free>:
vector_free():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:46

void vector_free(struct vector *v) { bd_free(v->buffer); }
    80209a52:	1101                	addi	sp,sp,-32
    80209a54:	ec06                	sd	ra,24(sp)
    80209a56:	e822                	sd	s0,16(sp)
    80209a58:	1000                	addi	s0,sp,32
    80209a5a:	fea43423          	sd	a0,-24(s0)
    80209a5e:	fe843783          	ld	a5,-24(s0)
    80209a62:	6f9c                	ld	a5,24(a5)
    80209a64:	853e                	mv	a0,a5
    80209a66:	9aefd0ef          	jal	ra,80206c14 <bd_free>
    80209a6a:	0001                	nop
    80209a6c:	60e2                	ld	ra,24(sp)
    80209a6e:	6442                	ld	s0,16(sp)
    80209a70:	6105                	addi	sp,sp,32
    80209a72:	8082                	ret

0000000080209a74 <vector_remove>:
vector_remove():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:49

void vector_remove(struct vector *v, uint64_t idx)
{
    80209a74:	1101                	addi	sp,sp,-32
    80209a76:	ec06                	sd	ra,24(sp)
    80209a78:	e822                	sd	s0,16(sp)
    80209a7a:	1000                	addi	s0,sp,32
    80209a7c:	fea43423          	sd	a0,-24(s0)
    80209a80:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:50
  if (idx >= v->size)
    80209a84:	fe843783          	ld	a5,-24(s0)
    80209a88:	639c                	ld	a5,0(a5)
    80209a8a:	fe043703          	ld	a4,-32(s0)
    80209a8e:	00f76e63          	bltu	a4,a5,80209aaa <vector_remove+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:52
  {
    panic("invalid idx in vector remove\n");
    80209a92:	00001617          	auipc	a2,0x1
    80209a96:	1ce60613          	addi	a2,a2,462 # 8020ac60 <MMIO+0xc8>
    80209a9a:	03400593          	li	a1,52
    80209a9e:	00001517          	auipc	a0,0x1
    80209aa2:	18a50513          	addi	a0,a0,394 # 8020ac28 <MMIO+0x90>
    80209aa6:	d37fd0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:54
  }
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80209aaa:	fe843783          	ld	a5,-24(s0)
    80209aae:	6f98                	ld	a4,24(a5)
    80209ab0:	fe843783          	ld	a5,-24(s0)
    80209ab4:	6b94                	ld	a3,16(a5)
    80209ab6:	fe043783          	ld	a5,-32(s0)
    80209aba:	02f687b3          	mul	a5,a3,a5
    80209abe:	00f70533          	add	a0,a4,a5
    80209ac2:	fe843783          	ld	a5,-24(s0)
    80209ac6:	6f98                	ld	a4,24(a5)
    80209ac8:	fe043783          	ld	a5,-32(s0)
    80209acc:	00178693          	addi	a3,a5,1
    80209ad0:	fe843783          	ld	a5,-24(s0)
    80209ad4:	6b9c                	ld	a5,16(a5)
    80209ad6:	02f687b3          	mul	a5,a3,a5
    80209ada:	00f706b3          	add	a3,a4,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:55
          (v->size - idx - 1) * v->dsize);
    80209ade:	fe843783          	ld	a5,-24(s0)
    80209ae2:	6398                	ld	a4,0(a5)
    80209ae4:	fe043783          	ld	a5,-32(s0)
    80209ae8:	40f707b3          	sub	a5,a4,a5
    80209aec:	fff78713          	addi	a4,a5,-1
    80209af0:	fe843783          	ld	a5,-24(s0)
    80209af4:	6b9c                	ld	a5,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:54
  memmove(v->buffer + idx * v->dsize, v->buffer + (idx + 1) * v->dsize,
    80209af6:	02f707b3          	mul	a5,a4,a5
    80209afa:	863e                	mv	a2,a5
    80209afc:	85b6                	mv	a1,a3
    80209afe:	e0bfa0ef          	jal	ra,80204908 <memmove>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:56
  v->size--;
    80209b02:	fe843783          	ld	a5,-24(s0)
    80209b06:	639c                	ld	a5,0(a5)
    80209b08:	fff78713          	addi	a4,a5,-1
    80209b0c:	fe843783          	ld	a5,-24(s0)
    80209b10:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:57
}
    80209b12:	0001                	nop
    80209b14:	60e2                	ld	ra,24(sp)
    80209b16:	6442                	ld	s0,16(sp)
    80209b18:	6105                	addi	sp,sp,32
    80209b1a:	8082                	ret

0000000080209b1c <vector_get>:
vector_get():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:60

void *vector_get(struct vector *v, uint64_t index)
{
    80209b1c:	1101                	addi	sp,sp,-32
    80209b1e:	ec22                	sd	s0,24(sp)
    80209b20:	1000                	addi	s0,sp,32
    80209b22:	fea43423          	sd	a0,-24(s0)
    80209b26:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:61
  if (index >= v->size)
    80209b2a:	fe843783          	ld	a5,-24(s0)
    80209b2e:	639c                	ld	a5,0(a5)
    80209b30:	fe043703          	ld	a4,-32(s0)
    80209b34:	00f76463          	bltu	a4,a5,80209b3c <vector_get+0x20>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:63
  {
    return NULL;
    80209b38:	4781                	li	a5,0
    80209b3a:	a821                	j	80209b52 <vector_get+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:65
  }
  return (void *)(v->buffer + (index * v->dsize));
    80209b3c:	fe843783          	ld	a5,-24(s0)
    80209b40:	6f98                	ld	a4,24(a5)
    80209b42:	fe843783          	ld	a5,-24(s0)
    80209b46:	6b94                	ld	a3,16(a5)
    80209b48:	fe043783          	ld	a5,-32(s0)
    80209b4c:	02f687b3          	mul	a5,a3,a5
    80209b50:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:66
}
    80209b52:	853e                	mv	a0,a5
    80209b54:	6462                	ld	s0,24(sp)
    80209b56:	6105                	addi	sp,sp,32
    80209b58:	8082                	ret

0000000080209b5a <vector_size>:
vector_size():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:69

uint64_t vector_size(struct vector *v)
{
    80209b5a:	1101                	addi	sp,sp,-32
    80209b5c:	ec22                	sd	s0,24(sp)
    80209b5e:	1000                	addi	s0,sp,32
    80209b60:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:70
  return v->size;
    80209b64:	fe843783          	ld	a5,-24(s0)
    80209b68:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/vector.c:71
    80209b6a:	853e                	mv	a0,a5
    80209b6c:	6462                	ld	s0,24(sp)
    80209b6e:	6105                	addi	sp,sp,32
    80209b70:	8082                	ret

0000000080209b72 <queue_init>:
queue_init():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:6
// queue.c
#include "queue.h"
#include "mem.h"
#include "kernel_heap.h"
void queue_init(Queue *q)
{
    80209b72:	1101                	addi	sp,sp,-32
    80209b74:	ec22                	sd	s0,24(sp)
    80209b76:	1000                	addi	s0,sp,32
    80209b78:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:7
    q->head = NULL;
    80209b7c:	fe843783          	ld	a5,-24(s0)
    80209b80:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:8
    q->tail = NULL;
    80209b84:	fe843783          	ld	a5,-24(s0)
    80209b88:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:9
    q->size = 0;
    80209b8c:	fe843783          	ld	a5,-24(s0)
    80209b90:	0007a823          	sw	zero,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:10
}
    80209b94:	0001                	nop
    80209b96:	6462                	ld	s0,24(sp)
    80209b98:	6105                	addi	sp,sp,32
    80209b9a:	8082                	ret

0000000080209b9c <queue_enqueue>:
queue_enqueue():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:13

void queue_enqueue(Queue *q, void *data)
{
    80209b9c:	7179                	addi	sp,sp,-48
    80209b9e:	f406                	sd	ra,40(sp)
    80209ba0:	f022                	sd	s0,32(sp)
    80209ba2:	1800                	addi	s0,sp,48
    80209ba4:	fca43c23          	sd	a0,-40(s0)
    80209ba8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:14
    Node *newNode = (Node *)bd_malloc(sizeof(Node));
    80209bac:	4541                	li	a0,16
    80209bae:	e65fc0ef          	jal	ra,80206a12 <bd_malloc>
    80209bb2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:15
    if (newNode == NULL)
    80209bb6:	fe843783          	ld	a5,-24(s0)
    80209bba:	ef81                	bnez	a5,80209bd2 <queue_enqueue+0x36>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:17 (discriminator 1)
    {
        ASSERT(0);
    80209bbc:	00001617          	auipc	a2,0x1
    80209bc0:	0d460613          	addi	a2,a2,212 # 8020ac90 <MMIO+0x10>
    80209bc4:	45c5                	li	a1,17
    80209bc6:	00001517          	auipc	a0,0x1
    80209bca:	0e250513          	addi	a0,a0,226 # 8020aca8 <MMIO+0x28>
    80209bce:	c0ffd0ef          	jal	ra,802077dc <_panic>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:19
    }
    newNode->data = data;
    80209bd2:	fe843783          	ld	a5,-24(s0)
    80209bd6:	fd043703          	ld	a4,-48(s0)
    80209bda:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:20
    newNode->next = NULL;
    80209bdc:	fe843783          	ld	a5,-24(s0)
    80209be0:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:22

    if (q->tail == NULL)
    80209be4:	fd843783          	ld	a5,-40(s0)
    80209be8:	679c                	ld	a5,8(a5)
    80209bea:	ef89                	bnez	a5,80209c04 <queue_enqueue+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:24
    { // Empty queue
        q->head = q->tail = newNode;
    80209bec:	fd843783          	ld	a5,-40(s0)
    80209bf0:	fe843703          	ld	a4,-24(s0)
    80209bf4:	e798                	sd	a4,8(a5)
    80209bf6:	fd843783          	ld	a5,-40(s0)
    80209bfa:	6798                	ld	a4,8(a5)
    80209bfc:	fd843783          	ld	a5,-40(s0)
    80209c00:	e398                	sd	a4,0(a5)
    80209c02:	a821                	j	80209c1a <queue_enqueue+0x7e>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:28
    }
    else
    {
        q->tail->next = newNode;
    80209c04:	fd843783          	ld	a5,-40(s0)
    80209c08:	679c                	ld	a5,8(a5)
    80209c0a:	fe843703          	ld	a4,-24(s0)
    80209c0e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:29
        q->tail = newNode;
    80209c10:	fd843783          	ld	a5,-40(s0)
    80209c14:	fe843703          	ld	a4,-24(s0)
    80209c18:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:31
    }
    q->size++;
    80209c1a:	fd843783          	ld	a5,-40(s0)
    80209c1e:	4b9c                	lw	a5,16(a5)
    80209c20:	2785                	addiw	a5,a5,1
    80209c22:	0007871b          	sext.w	a4,a5
    80209c26:	fd843783          	ld	a5,-40(s0)
    80209c2a:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:32
}
    80209c2c:	0001                	nop
    80209c2e:	70a2                	ld	ra,40(sp)
    80209c30:	7402                	ld	s0,32(sp)
    80209c32:	6145                	addi	sp,sp,48
    80209c34:	8082                	ret

0000000080209c36 <queue_dequeue>:
queue_dequeue():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:35

void *queue_dequeue(Queue *q)
{
    80209c36:	7179                	addi	sp,sp,-48
    80209c38:	f406                	sd	ra,40(sp)
    80209c3a:	f022                	sd	s0,32(sp)
    80209c3c:	1800                	addi	s0,sp,48
    80209c3e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:36
    if (q->head == NULL)
    80209c42:	fd843783          	ld	a5,-40(s0)
    80209c46:	639c                	ld	a5,0(a5)
    80209c48:	e399                	bnez	a5,80209c4e <queue_dequeue+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:38
    {
        return NULL; // Empty queue
    80209c4a:	4781                	li	a5,0
    80209c4c:	a889                	j	80209c9e <queue_dequeue+0x68>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:41
    }

    Node *temp = q->head;
    80209c4e:	fd843783          	ld	a5,-40(s0)
    80209c52:	639c                	ld	a5,0(a5)
    80209c54:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:42
    void *data = temp->data;
    80209c58:	fe843783          	ld	a5,-24(s0)
    80209c5c:	639c                	ld	a5,0(a5)
    80209c5e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:43
    q->head = q->head->next;
    80209c62:	fd843783          	ld	a5,-40(s0)
    80209c66:	639c                	ld	a5,0(a5)
    80209c68:	6798                	ld	a4,8(a5)
    80209c6a:	fd843783          	ld	a5,-40(s0)
    80209c6e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:45

    if (q->head == NULL)
    80209c70:	fd843783          	ld	a5,-40(s0)
    80209c74:	639c                	ld	a5,0(a5)
    80209c76:	e789                	bnez	a5,80209c80 <queue_dequeue+0x4a>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:47
    {
        q->tail = NULL; // Queue is now empty
    80209c78:	fd843783          	ld	a5,-40(s0)
    80209c7c:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:50
    }

    free(temp);
    80209c80:	fe843503          	ld	a0,-24(s0)
    80209c84:	e39fa0ef          	jal	ra,80204abc <free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:51
    q->size--;
    80209c88:	fd843783          	ld	a5,-40(s0)
    80209c8c:	4b9c                	lw	a5,16(a5)
    80209c8e:	37fd                	addiw	a5,a5,-1
    80209c90:	0007871b          	sext.w	a4,a5
    80209c94:	fd843783          	ld	a5,-40(s0)
    80209c98:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:52
    return data;
    80209c9a:	fe043783          	ld	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:53
}
    80209c9e:	853e                	mv	a0,a5
    80209ca0:	70a2                	ld	ra,40(sp)
    80209ca2:	7402                	ld	s0,32(sp)
    80209ca4:	6145                	addi	sp,sp,48
    80209ca6:	8082                	ret

0000000080209ca8 <queue_clear>:
queue_clear():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:56

void queue_clear(Queue *q)
{
    80209ca8:	7179                	addi	sp,sp,-48
    80209caa:	f406                	sd	ra,40(sp)
    80209cac:	f022                	sd	s0,32(sp)
    80209cae:	1800                	addi	s0,sp,48
    80209cb0:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:57
    Node *current = q->head;
    80209cb4:	fd843783          	ld	a5,-40(s0)
    80209cb8:	639c                	ld	a5,0(a5)
    80209cba:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:60
    Node *next;

    while (current != NULL)
    80209cbe:	a831                	j	80209cda <queue_clear+0x32>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:62
    {
        next = current->next;
    80209cc0:	fe843783          	ld	a5,-24(s0)
    80209cc4:	679c                	ld	a5,8(a5)
    80209cc6:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:63
        free(current);
    80209cca:	fe843503          	ld	a0,-24(s0)
    80209cce:	deffa0ef          	jal	ra,80204abc <free>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:64
        current = next;
    80209cd2:	fe043783          	ld	a5,-32(s0)
    80209cd6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:60
    while (current != NULL)
    80209cda:	fe843783          	ld	a5,-24(s0)
    80209cde:	f3ed                	bnez	a5,80209cc0 <queue_clear+0x18>
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:67
    }

    q->head = NULL;
    80209ce0:	fd843783          	ld	a5,-40(s0)
    80209ce4:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:68
    q->tail = NULL;
    80209ce8:	fd843783          	ld	a5,-40(s0)
    80209cec:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:69
    q->size = 0;
    80209cf0:	fd843783          	ld	a5,-40(s0)
    80209cf4:	0007a823          	sw	zero,16(a5)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:70
}
    80209cf8:	0001                	nop
    80209cfa:	70a2                	ld	ra,40(sp)
    80209cfc:	7402                	ld	s0,32(sp)
    80209cfe:	6145                	addi	sp,sp,48
    80209d00:	8082                	ret

0000000080209d02 <queue_is_empty>:
queue_is_empty():
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:73

int queue_is_empty(const Queue *q)
{
    80209d02:	1101                	addi	sp,sp,-32
    80209d04:	ec22                	sd	s0,24(sp)
    80209d06:	1000                	addi	s0,sp,32
    80209d08:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:74
    return q->size == 0;
    80209d0c:	fe843783          	ld	a5,-24(s0)
    80209d10:	4b9c                	lw	a5,16(a5)
    80209d12:	0017b793          	seqz	a5,a5
    80209d16:	0ff7f793          	andi	a5,a5,255
    80209d1a:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c-ch6/kernel/data_structure/queue.c:75
}
    80209d1c:	853e                	mv	a0,a5
    80209d1e:	6462                	ld	s0,24(sp)
    80209d20:	6105                	addi	sp,sp,32
    80209d22:	8082                	ret
	...

0000000080209d30 <kernelvec>:
kernelvec():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:13

  .globl trap_from_kernel
  .globl kernelvec
  .align 4
kernelvec:
  addi sp, sp, -256
    80209d30:	7111                	addi	sp,sp,-256
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:15
  # save the registers
  sd ra, 1*8(sp)
    80209d32:	e406                	sd	ra,8(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:16
  sd sp, 2*8(sp)
    80209d34:	e80a                	sd	sp,16(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:17
  sd gp, 3*8(sp)
    80209d36:	ec0e                	sd	gp,24(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:23
  # sd tp, 4*8(sp)  # This line appears to be commented out; ensure it's intentional.
  .set n, 5
  .rept 27
    SAVE_GP %n
    .set n, n+1
  .endr
    80209d38:	f416                	sd	t0,40(sp)
    80209d3a:	f81a                	sd	t1,48(sp)
    80209d3c:	fc1e                	sd	t2,56(sp)
    80209d3e:	e0a2                	sd	s0,64(sp)
    80209d40:	e4a6                	sd	s1,72(sp)
    80209d42:	e8aa                	sd	a0,80(sp)
    80209d44:	ecae                	sd	a1,88(sp)
    80209d46:	f0b2                	sd	a2,96(sp)
    80209d48:	f4b6                	sd	a3,104(sp)
    80209d4a:	f8ba                	sd	a4,112(sp)
    80209d4c:	fcbe                	sd	a5,120(sp)
    80209d4e:	e142                	sd	a6,128(sp)
    80209d50:	e546                	sd	a7,136(sp)
    80209d52:	e94a                	sd	s2,144(sp)
    80209d54:	ed4e                	sd	s3,152(sp)
    80209d56:	f152                	sd	s4,160(sp)
    80209d58:	f556                	sd	s5,168(sp)
    80209d5a:	f95a                	sd	s6,176(sp)
    80209d5c:	fd5e                	sd	s7,184(sp)
    80209d5e:	e1e2                	sd	s8,192(sp)
    80209d60:	e5e6                	sd	s9,200(sp)
    80209d62:	e9ea                	sd	s10,208(sp)
    80209d64:	edee                	sd	s11,216(sp)
    80209d66:	f1f2                	sd	t3,224(sp)
    80209d68:	f5f6                	sd	t4,232(sp)
    80209d6a:	f9fa                	sd	t5,240(sp)
    80209d6c:	fdfe                	sd	t6,248(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:26

  # call the C trap handler in trap.c
  call trap_from_kernel
    80209d6e:	96eff0ef          	jal	ra,80208edc <trap_from_kernel>

0000000080209d72 <kernelret>:
kernelret():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:30

kernelret:
  # restore registers
  ld ra, 1*8(sp)
    80209d72:	60a2                	ld	ra,8(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:31
  ld sp, 2*8(sp)
    80209d74:	6142                	ld	sp,16(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:32
  ld gp, 3*8(sp)
    80209d76:	61e2                	ld	gp,24(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:38
  # not this, in case we moved CPUs: ld tp, 24(sp)  # Adjust comment syntax if necessary
  .set n, 5
  .rept 27
    LOAD_GP %n
    .set n, n+1
  .endr
    80209d78:	72a2                	ld	t0,40(sp)
    80209d7a:	7342                	ld	t1,48(sp)
    80209d7c:	73e2                	ld	t2,56(sp)
    80209d7e:	6406                	ld	s0,64(sp)
    80209d80:	64a6                	ld	s1,72(sp)
    80209d82:	6546                	ld	a0,80(sp)
    80209d84:	65e6                	ld	a1,88(sp)
    80209d86:	7606                	ld	a2,96(sp)
    80209d88:	76a6                	ld	a3,104(sp)
    80209d8a:	7746                	ld	a4,112(sp)
    80209d8c:	77e6                	ld	a5,120(sp)
    80209d8e:	680a                	ld	a6,128(sp)
    80209d90:	68aa                	ld	a7,136(sp)
    80209d92:	694a                	ld	s2,144(sp)
    80209d94:	69ea                	ld	s3,152(sp)
    80209d96:	7a0a                	ld	s4,160(sp)
    80209d98:	7aaa                	ld	s5,168(sp)
    80209d9a:	7b4a                	ld	s6,176(sp)
    80209d9c:	7bea                	ld	s7,184(sp)
    80209d9e:	6c0e                	ld	s8,192(sp)
    80209da0:	6cae                	ld	s9,200(sp)
    80209da2:	6d4e                	ld	s10,208(sp)
    80209da4:	6dee                	ld	s11,216(sp)
    80209da6:	7e0e                	ld	t3,224(sp)
    80209da8:	7eae                	ld	t4,232(sp)
    80209daa:	7f4e                	ld	t5,240(sp)
    80209dac:	7fee                	ld	t6,248(sp)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:40

  addi sp, sp, 256
    80209dae:	6111                	addi	sp,sp,256
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/kernelvec.asm:43

  # return to whatever we were doing in the kernel
  sret
    80209db0:	10200073          	sret
	...

0000000080209dc2 <__switch>:
__switch():
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:16
  # __switch(
  #     current_task_cx_ptr: *mut TaskContext,
  #     next_task_cx_ptr: *const TaskContext
  # )
  # save kernel stack of current task
  sd sp, 8(a0)
    80209dc2:	00253423          	sd	sp,8(a0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:18
  # save ra & s0~s11 of current execution
  sd ra, 0(a0)
    80209dc6:	00153023          	sd	ra,0(a0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:23
  .set n, 0
  .rept 12
    SAVE_SN %n
    .set n, n + 1
  .endr
    80209dca:	e900                	sd	s0,16(a0)
    80209dcc:	ed04                	sd	s1,24(a0)
    80209dce:	03253023          	sd	s2,32(a0)
    80209dd2:	03353423          	sd	s3,40(a0)
    80209dd6:	03453823          	sd	s4,48(a0)
    80209dda:	03553c23          	sd	s5,56(a0)
    80209dde:	05653023          	sd	s6,64(a0)
    80209de2:	05753423          	sd	s7,72(a0)
    80209de6:	05853823          	sd	s8,80(a0)
    80209dea:	05953c23          	sd	s9,88(a0)
    80209dee:	07a53023          	sd	s10,96(a0)
    80209df2:	07b53423          	sd	s11,104(a0)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:25
  # restore ra & s0~s11 of next execution
  ld ra, 0(a1)
    80209df6:	0005b083          	ld	ra,0(a1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:30
  .set n, 0
  .rept 12
    LOAD_SN %n
    .set n, n + 1
  .endr
    80209dfa:	6980                	ld	s0,16(a1)
    80209dfc:	6d84                	ld	s1,24(a1)
    80209dfe:	0205b903          	ld	s2,32(a1)
    80209e02:	0285b983          	ld	s3,40(a1)
    80209e06:	0305ba03          	ld	s4,48(a1)
    80209e0a:	0385ba83          	ld	s5,56(a1)
    80209e0e:	0405bb03          	ld	s6,64(a1)
    80209e12:	0485bb83          	ld	s7,72(a1)
    80209e16:	0505bc03          	ld	s8,80(a1)
    80209e1a:	0585bc83          	ld	s9,88(a1)
    80209e1e:	0605bd03          	ld	s10,96(a1)
    80209e22:	0685bd83          	ld	s11,104(a1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:32
  # restore kernel stack of next task
  ld sp, 8(a1)
    80209e26:	0085b103          	ld	sp,8(a1)
/home/caigoubencai/Desktop/os_c-ch6/kernel/asm/switch.asm:33
  ret
    80209e2a:	8082                	ret
