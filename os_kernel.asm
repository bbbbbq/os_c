
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
_start():
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:4
    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    80200000:	0001a117          	auipc	sp,0x1a
    80200004:	00010113          	mv	sp,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/entry.asm:5
    call main_os
    80200008:	119010ef          	jal	ra,80201920 <main_os>
	...

0000000080201000 <port_write>:
port_write():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:9
#include "stdarg.h"

/**
 *  @brief: 调用sbi输出函数，参数为固定要求，由_vprintk & _vprints调用
 */
void port_write(char *buf) {
    80201000:	1101                	addi	sp,sp,-32
    80201002:	ec06                	sd	ra,24(sp)
    80201004:	e822                	sd	s0,16(sp)
    80201006:	1000                	addi	s0,sp,32
    80201008:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:10
    while(*buf != 0){
    8020100c:	a821                	j	80201024 <port_write+0x24>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:11
        console_putchar(*buf++);
    8020100e:	fe843783          	ld	a5,-24(s0)
    80201012:	00178713          	addi	a4,a5,1
    80201016:	fee43423          	sd	a4,-24(s0)
    8020101a:	0007c783          	lbu	a5,0(a5)
    8020101e:	853e                	mv	a0,a5
    80201020:	274010ef          	jal	ra,80202294 <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:10
    while(*buf != 0){
    80201024:	fe843783          	ld	a5,-24(s0)
    80201028:	0007c783          	lbu	a5,0(a5)
    8020102c:	f3ed                	bnez	a5,8020100e <port_write+0xe>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:13
    }
}
    8020102e:	0001                	nop
    80201030:	0001                	nop
    80201032:	60e2                	ld	ra,24(sp)
    80201034:	6442                	ld	s0,16(sp)
    80201036:	6105                	addi	sp,sp,32
    80201038:	8082                	ret

000000008020103a <mini_strlen>:
mini_strlen():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:17


static unsigned int mini_strlen(const char *s)
{
    8020103a:	7179                	addi	sp,sp,-48
    8020103c:	f422                	sd	s0,40(sp)
    8020103e:	1800                	addi	s0,sp,48
    80201040:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:18
    unsigned int len = 0;
    80201044:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19
    while (s[len] != '\0') len++;
    80201048:	a031                	j	80201054 <mini_strlen+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19 (discriminator 2)
    8020104a:	fec42783          	lw	a5,-20(s0)
    8020104e:	2785                	addiw	a5,a5,1
    80201050:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:19 (discriminator 1)
    80201054:	fec46783          	lwu	a5,-20(s0)
    80201058:	fd843703          	ld	a4,-40(s0)
    8020105c:	97ba                	add	a5,a5,a4
    8020105e:	0007c783          	lbu	a5,0(a5)
    80201062:	f7e5                	bnez	a5,8020104a <mini_strlen+0x10>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:20
    return len;
    80201064:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:21
}
    80201068:	853e                	mv	a0,a5
    8020106a:	7422                	ld	s0,40(sp)
    8020106c:	6145                	addi	sp,sp,48
    8020106e:	8082                	ret

0000000080201070 <mini_itoa>:
mini_itoa():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:26

static unsigned int mini_itoa(
    long value, unsigned int radix, unsigned int uppercase,
    unsigned int unsig, char *buffer, unsigned int zero_pad)
{
    80201070:	715d                	addi	sp,sp,-80
    80201072:	e4a2                	sd	s0,72(sp)
    80201074:	0880                	addi	s0,sp,80
    80201076:	fca43423          	sd	a0,-56(s0)
    8020107a:	fae43823          	sd	a4,-80(s0)
    8020107e:	873e                	mv	a4,a5
    80201080:	87ae                	mv	a5,a1
    80201082:	fcf42223          	sw	a5,-60(s0)
    80201086:	87b2                	mv	a5,a2
    80201088:	fcf42023          	sw	a5,-64(s0)
    8020108c:	87b6                	mv	a5,a3
    8020108e:	faf42e23          	sw	a5,-68(s0)
    80201092:	87ba                	mv	a5,a4
    80201094:	faf42c23          	sw	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:27
    char *pbuffer = buffer;
    80201098:	fb043783          	ld	a5,-80(s0)
    8020109c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:28
    int negative  = 0;
    802010a0:	fe042223          	sw	zero,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:32
    unsigned int i, len;

    /* No support for unusual radixes. */
    if (radix > 16) return 0;
    802010a4:	fc442783          	lw	a5,-60(s0)
    802010a8:	0007871b          	sext.w	a4,a5
    802010ac:	47c1                	li	a5,16
    802010ae:	00e7f463          	bgeu	a5,a4,802010b6 <mini_itoa+0x46>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:32 (discriminator 1)
    802010b2:	4781                	li	a5,0
    802010b4:	aae9                	j	8020128e <mini_itoa+0x21e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:34

    if (value < 0 && !unsig) {
    802010b6:	fc843783          	ld	a5,-56(s0)
    802010ba:	0007df63          	bgez	a5,802010d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:34 (discriminator 1)
    802010be:	fbc42783          	lw	a5,-68(s0)
    802010c2:	2781                	sext.w	a5,a5
    802010c4:	eb91                	bnez	a5,802010d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:35
        negative = 1;
    802010c6:	4785                	li	a5,1
    802010c8:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:36
        value    = -value;
    802010cc:	fc843783          	ld	a5,-56(s0)
    802010d0:	40f007b3          	neg	a5,a5
    802010d4:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:41
    }

    /* This builds the string back to front ... */
    do {
        int digit = 0;
    802010d8:	fc042e23          	sw	zero,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:42
        if (unsig) {
    802010dc:	fbc42783          	lw	a5,-68(s0)
    802010e0:	2781                	sext.w	a5,a5
    802010e2:	cb91                	beqz	a5,802010f6 <mini_itoa+0x86>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:43
            digit = (unsigned long)value % (unsigned)radix;
    802010e4:	fc843703          	ld	a4,-56(s0)
    802010e8:	fc446783          	lwu	a5,-60(s0)
    802010ec:	02f777b3          	remu	a5,a4,a5
    802010f0:	fcf42e23          	sw	a5,-36(s0)
    802010f4:	a809                	j	80201106 <mini_itoa+0x96>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:45
        } else {
            digit = value % radix;
    802010f6:	fc446783          	lwu	a5,-60(s0)
    802010fa:	fc843703          	ld	a4,-56(s0)
    802010fe:	02f767b3          	rem	a5,a4,a5
    80201102:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47
        }
        *(pbuffer++) =
    80201106:	fdc42783          	lw	a5,-36(s0)
    8020110a:	0007871b          	sext.w	a4,a5
    8020110e:	47a5                	li	a5,9
    80201110:	00e7cb63          	blt	a5,a4,80201126 <mini_itoa+0xb6>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:48 (discriminator 1)
            (digit < 10 ? '0' + digit :
    80201114:	fdc42783          	lw	a5,-36(s0)
    80201118:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 1)
        *(pbuffer++) =
    8020111c:	0307879b          	addiw	a5,a5,48
    80201120:	0ff7f713          	andi	a4,a5,255
    80201124:	a025                	j	8020114c <mini_itoa+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49
             (uppercase ? 'A' : 'a') + digit - 10);
    80201126:	fc042783          	lw	a5,-64(s0)
    8020112a:	2781                	sext.w	a5,a5
    8020112c:	c781                	beqz	a5,80201134 <mini_itoa+0xc4>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 1)
    8020112e:	04100793          	li	a5,65
    80201132:	a019                	j	80201138 <mini_itoa+0xc8>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 2)
    80201134:	06100793          	li	a5,97
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:49 (discriminator 4)
    80201138:	fdc42703          	lw	a4,-36(s0)
    8020113c:	0ff77713          	andi	a4,a4,255
    80201140:	9fb9                	addw	a5,a5,a4
    80201142:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 4)
        *(pbuffer++) =
    80201146:	37d9                	addiw	a5,a5,-10
    80201148:	0ff7f713          	andi	a4,a5,255
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:47 (discriminator 3)
    8020114c:	fe843783          	ld	a5,-24(s0)
    80201150:	00178693          	addi	a3,a5,1
    80201154:	fed43423          	sd	a3,-24(s0)
    80201158:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:50 (discriminator 3)
        if (unsig) {
    8020115c:	fbc42783          	lw	a5,-68(s0)
    80201160:	2781                	sext.w	a5,a5
    80201162:	cb91                	beqz	a5,80201176 <mini_itoa+0x106>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:51
            value = (unsigned long) value / (unsigned) radix;
    80201164:	fc843703          	ld	a4,-56(s0)
    80201168:	fc446783          	lwu	a5,-60(s0)
    8020116c:	02f757b3          	divu	a5,a4,a5
    80201170:	fcf43423          	sd	a5,-56(s0)
    80201174:	a809                	j	80201186 <mini_itoa+0x116>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:53
        } else {
            value /= radix;
    80201176:	fc446783          	lwu	a5,-60(s0)
    8020117a:	fc843703          	ld	a4,-56(s0)
    8020117e:	02f747b3          	div	a5,a4,a5
    80201182:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:55
        }
    } while (value != 0);
    80201186:	fc843783          	ld	a5,-56(s0)
    8020118a:	f7b9                	bnez	a5,802010d8 <mini_itoa+0x68>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57

    for (i = (pbuffer - buffer); i < zero_pad; i++)
    8020118c:	fe843703          	ld	a4,-24(s0)
    80201190:	fb043783          	ld	a5,-80(s0)
    80201194:	40f707b3          	sub	a5,a4,a5
    80201198:	fef42023          	sw	a5,-32(s0)
    8020119c:	a005                	j	802011bc <mini_itoa+0x14c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:58 (discriminator 3)
        *(pbuffer++) = '0';
    8020119e:	fe843783          	ld	a5,-24(s0)
    802011a2:	00178713          	addi	a4,a5,1
    802011a6:	fee43423          	sd	a4,-24(s0)
    802011aa:	03000713          	li	a4,48
    802011ae:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57 (discriminator 3)
    for (i = (pbuffer - buffer); i < zero_pad; i++)
    802011b2:	fe042783          	lw	a5,-32(s0)
    802011b6:	2785                	addiw	a5,a5,1
    802011b8:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:57 (discriminator 1)
    802011bc:	fe042703          	lw	a4,-32(s0)
    802011c0:	fb842783          	lw	a5,-72(s0)
    802011c4:	2701                	sext.w	a4,a4
    802011c6:	2781                	sext.w	a5,a5
    802011c8:	fcf76be3          	bltu	a4,a5,8020119e <mini_itoa+0x12e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:60

    if (negative) *(pbuffer++) = '-';
    802011cc:	fe442783          	lw	a5,-28(s0)
    802011d0:	2781                	sext.w	a5,a5
    802011d2:	cb99                	beqz	a5,802011e8 <mini_itoa+0x178>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:60 (discriminator 1)
    802011d4:	fe843783          	ld	a5,-24(s0)
    802011d8:	00178713          	addi	a4,a5,1
    802011dc:	fee43423          	sd	a4,-24(s0)
    802011e0:	02d00713          	li	a4,45
    802011e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:62

    *(pbuffer) = '\0';
    802011e8:	fe843783          	ld	a5,-24(s0)
    802011ec:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:64

    len = (pbuffer - buffer);
    802011f0:	fe843703          	ld	a4,-24(s0)
    802011f4:	fb043783          	ld	a5,-80(s0)
    802011f8:	40f707b3          	sub	a5,a4,a5
    802011fc:	fcf42c23          	sw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65
    for (i = 0; i < len / 2; i++) {
    80201200:	fe042023          	sw	zero,-32(s0)
    80201204:	a885                	j	80201274 <mini_itoa+0x204>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:66 (discriminator 3)
        char j              = buffer[i];
    80201206:	fe046783          	lwu	a5,-32(s0)
    8020120a:	fb043703          	ld	a4,-80(s0)
    8020120e:	97ba                	add	a5,a5,a4
    80201210:	0007c783          	lbu	a5,0(a5)
    80201214:	fcf40ba3          	sb	a5,-41(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:67 (discriminator 3)
        buffer[i]           = buffer[len - i - 1];
    80201218:	fd842703          	lw	a4,-40(s0)
    8020121c:	fe042783          	lw	a5,-32(s0)
    80201220:	40f707bb          	subw	a5,a4,a5
    80201224:	2781                	sext.w	a5,a5
    80201226:	37fd                	addiw	a5,a5,-1
    80201228:	2781                	sext.w	a5,a5
    8020122a:	1782                	slli	a5,a5,0x20
    8020122c:	9381                	srli	a5,a5,0x20
    8020122e:	fb043703          	ld	a4,-80(s0)
    80201232:	973e                	add	a4,a4,a5
    80201234:	fe046783          	lwu	a5,-32(s0)
    80201238:	fb043683          	ld	a3,-80(s0)
    8020123c:	97b6                	add	a5,a5,a3
    8020123e:	00074703          	lbu	a4,0(a4)
    80201242:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:68 (discriminator 3)
        buffer[len - i - 1] = j;
    80201246:	fd842703          	lw	a4,-40(s0)
    8020124a:	fe042783          	lw	a5,-32(s0)
    8020124e:	40f707bb          	subw	a5,a4,a5
    80201252:	2781                	sext.w	a5,a5
    80201254:	37fd                	addiw	a5,a5,-1
    80201256:	2781                	sext.w	a5,a5
    80201258:	1782                	slli	a5,a5,0x20
    8020125a:	9381                	srli	a5,a5,0x20
    8020125c:	fb043703          	ld	a4,-80(s0)
    80201260:	97ba                	add	a5,a5,a4
    80201262:	fd744703          	lbu	a4,-41(s0)
    80201266:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65 (discriminator 3)
    for (i = 0; i < len / 2; i++) {
    8020126a:	fe042783          	lw	a5,-32(s0)
    8020126e:	2785                	addiw	a5,a5,1
    80201270:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:65 (discriminator 1)
    80201274:	fd842783          	lw	a5,-40(s0)
    80201278:	0017d79b          	srliw	a5,a5,0x1
    8020127c:	0007871b          	sext.w	a4,a5
    80201280:	fe042783          	lw	a5,-32(s0)
    80201284:	2781                	sext.w	a5,a5
    80201286:	f8e7e0e3          	bltu	a5,a4,80201206 <mini_itoa+0x196>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:71
    }

    return len;
    8020128a:	fd842783          	lw	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:72
}
    8020128e:	853e                	mv	a0,a5
    80201290:	6426                	ld	s0,72(sp)
    80201292:	6161                	addi	sp,sp,80
    80201294:	8082                	ret

0000000080201296 <_putc>:
_putc():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:81
    char *buffer, *pbuffer;
    unsigned int buffer_len;
};

static int _putc(int ch, struct mini_buff *b)
{
    80201296:	1101                	addi	sp,sp,-32
    80201298:	ec22                	sd	s0,24(sp)
    8020129a:	1000                	addi	s0,sp,32
    8020129c:	87aa                	mv	a5,a0
    8020129e:	feb43023          	sd	a1,-32(s0)
    802012a2:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:82
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802012a6:	fe043783          	ld	a5,-32(s0)
    802012aa:	6798                	ld	a4,8(a5)
    802012ac:	fe043783          	ld	a5,-32(s0)
    802012b0:	639c                	ld	a5,0(a5)
    802012b2:	40f707b3          	sub	a5,a4,a5
    802012b6:	2781                	sext.w	a5,a5
    802012b8:	2785                	addiw	a5,a5,1
    802012ba:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:83
        b->buffer_len)
    802012be:	fe043783          	ld	a5,-32(s0)
    802012c2:	4b9c                	lw	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:82
    if ((unsigned int)((b->pbuffer - b->buffer) + 1) >=
    802012c4:	00f76463          	bltu	a4,a5,802012cc <_putc+0x36>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:84
        return 0;
    802012c8:	4781                	li	a5,0
    802012ca:	a02d                	j	802012f4 <_putc+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:85
    *(b->pbuffer++) = ch;
    802012cc:	fe043783          	ld	a5,-32(s0)
    802012d0:	679c                	ld	a5,8(a5)
    802012d2:	00178693          	addi	a3,a5,1
    802012d6:	fe043703          	ld	a4,-32(s0)
    802012da:	e714                	sd	a3,8(a4)
    802012dc:	fec42703          	lw	a4,-20(s0)
    802012e0:	0ff77713          	andi	a4,a4,255
    802012e4:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:86
    *(b->pbuffer)   = '\0';
    802012e8:	fe043783          	ld	a5,-32(s0)
    802012ec:	679c                	ld	a5,8(a5)
    802012ee:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:87
    return 1;
    802012f2:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:88
}
    802012f4:	853e                	mv	a0,a5
    802012f6:	6462                	ld	s0,24(sp)
    802012f8:	6105                	addi	sp,sp,32
    802012fa:	8082                	ret

00000000802012fc <_puts>:
_puts():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:91

static int _puts(char *s, unsigned int len, struct mini_buff *b)
{
    802012fc:	7139                	addi	sp,sp,-64
    802012fe:	fc22                	sd	s0,56(sp)
    80201300:	0080                	addi	s0,sp,64
    80201302:	fca43c23          	sd	a0,-40(s0)
    80201306:	87ae                	mv	a5,a1
    80201308:	fcc43423          	sd	a2,-56(s0)
    8020130c:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:94
    unsigned int i;

    if (b->buffer_len - (b->pbuffer - b->buffer) - 1 < len)
    80201310:	fc843783          	ld	a5,-56(s0)
    80201314:	4b9c                	lw	a5,16(a5)
    80201316:	02079713          	slli	a4,a5,0x20
    8020131a:	9301                	srli	a4,a4,0x20
    8020131c:	fc843783          	ld	a5,-56(s0)
    80201320:	6794                	ld	a3,8(a5)
    80201322:	fc843783          	ld	a5,-56(s0)
    80201326:	639c                	ld	a5,0(a5)
    80201328:	40f687b3          	sub	a5,a3,a5
    8020132c:	8f1d                	sub	a4,a4,a5
    8020132e:	fd446783          	lwu	a5,-44(s0)
    80201332:	02e7c463          	blt	a5,a4,8020135a <_puts+0x5e>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:95
        len = b->buffer_len - (b->pbuffer - b->buffer) - 1;
    80201336:	fc843783          	ld	a5,-56(s0)
    8020133a:	4b98                	lw	a4,16(a5)
    8020133c:	fc843783          	ld	a5,-56(s0)
    80201340:	6794                	ld	a3,8(a5)
    80201342:	fc843783          	ld	a5,-56(s0)
    80201346:	639c                	ld	a5,0(a5)
    80201348:	40f687b3          	sub	a5,a3,a5
    8020134c:	2781                	sext.w	a5,a5
    8020134e:	40f707bb          	subw	a5,a4,a5
    80201352:	2781                	sext.w	a5,a5
    80201354:	37fd                	addiw	a5,a5,-1
    80201356:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98

    /* Copy to buffer */
    for (i = 0; i < len; i++) *(b->pbuffer++) = s[i];
    8020135a:	fe042623          	sw	zero,-20(s0)
    8020135e:	a03d                	j	8020138c <_puts+0x90>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98 (discriminator 3)
    80201360:	fec46783          	lwu	a5,-20(s0)
    80201364:	fd843703          	ld	a4,-40(s0)
    80201368:	973e                	add	a4,a4,a5
    8020136a:	fc843783          	ld	a5,-56(s0)
    8020136e:	679c                	ld	a5,8(a5)
    80201370:	00178613          	addi	a2,a5,1
    80201374:	fc843683          	ld	a3,-56(s0)
    80201378:	e690                	sd	a2,8(a3)
    8020137a:	00074703          	lbu	a4,0(a4)
    8020137e:	00e78023          	sb	a4,0(a5)
    80201382:	fec42783          	lw	a5,-20(s0)
    80201386:	2785                	addiw	a5,a5,1
    80201388:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:98 (discriminator 1)
    8020138c:	fec42703          	lw	a4,-20(s0)
    80201390:	fd442783          	lw	a5,-44(s0)
    80201394:	2701                	sext.w	a4,a4
    80201396:	2781                	sext.w	a5,a5
    80201398:	fcf764e3          	bltu	a4,a5,80201360 <_puts+0x64>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:99
    *(b->pbuffer) = '\0';
    8020139c:	fc843783          	ld	a5,-56(s0)
    802013a0:	679c                	ld	a5,8(a5)
    802013a2:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:101

    return len;
    802013a6:	fd442783          	lw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:102
}
    802013aa:	853e                	mv	a0,a5
    802013ac:	7462                	ld	s0,56(sp)
    802013ae:	6121                	addi	sp,sp,64
    802013b0:	8082                	ret

00000000802013b2 <mini_vsnprintf>:
mini_vsnprintf():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:107

static int mini_vsnprintf(
    char *buffer, unsigned int buffer_len, const char *fmt,
    va_list va)
{
    802013b2:	7119                	addi	sp,sp,-128
    802013b4:	fc86                	sd	ra,120(sp)
    802013b6:	f8a2                	sd	s0,112(sp)
    802013b8:	0100                	addi	s0,sp,128
    802013ba:	f8a43c23          	sd	a0,-104(s0)
    802013be:	87ae                	mv	a5,a1
    802013c0:	f8c43423          	sd	a2,-120(s0)
    802013c4:	f8d43023          	sd	a3,-128(s0)
    802013c8:	f8f42a23          	sw	a5,-108(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:112
    struct mini_buff b;
    char bf[24];
    char ch;

    b.buffer     = buffer;
    802013cc:	f9843783          	ld	a5,-104(s0)
    802013d0:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:113
    b.pbuffer    = buffer;
    802013d4:	f9843783          	ld	a5,-104(s0)
    802013d8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:114
    b.buffer_len = buffer_len;
    802013dc:	f9442783          	lw	a5,-108(s0)
    802013e0:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:116

    while ((ch = *(fmt++))) {
    802013e4:	a4f9                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:117
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802013e6:	fc843703          	ld	a4,-56(s0)
    802013ea:	fc043783          	ld	a5,-64(s0)
    802013ee:	40f707b3          	sub	a5,a4,a5
    802013f2:	2781                	sext.w	a5,a5
    802013f4:	2785                	addiw	a5,a5,1
    802013f6:	0007871b          	sext.w	a4,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:118
            b.buffer_len)
    802013fa:	fd042783          	lw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:117
        if ((unsigned int)((b.pbuffer - b.buffer) + 1) >=
    802013fe:	2cf77b63          	bgeu	a4,a5,802016d4 <mini_vsnprintf+0x322>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:120
            break;
        if (ch != '%')
    80201402:	fef44783          	lbu	a5,-17(s0)
    80201406:	0ff7f713          	andi	a4,a5,255
    8020140a:	02500793          	li	a5,37
    8020140e:	00f70c63          	beq	a4,a5,80201426 <mini_vsnprintf+0x74>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:121
            _putc(ch, &b);
    80201412:	fef44783          	lbu	a5,-17(s0)
    80201416:	2781                	sext.w	a5,a5
    80201418:	fc040713          	addi	a4,s0,-64
    8020141c:	85ba                	mv	a1,a4
    8020141e:	853e                	mv	a0,a5
    80201420:	e77ff0ef          	jal	ra,80201296 <_putc>
    80201424:	a479                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:123
        else {
            char zero_pad = 0;
    80201426:	fe040723          	sb	zero,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:124
            int longflag = 0;
    8020142a:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:128
            char *ptr;
            unsigned int len;

            ch = *(fmt++);
    8020142e:	f8843783          	ld	a5,-120(s0)
    80201432:	00178713          	addi	a4,a5,1
    80201436:	f8e43423          	sd	a4,-120(s0)
    8020143a:	0007c783          	lbu	a5,0(a5)
    8020143e:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:131

            /* Zero padding requested */
            if (ch == '0') {
    80201442:	fef44783          	lbu	a5,-17(s0)
    80201446:	0ff7f713          	andi	a4,a5,255
    8020144a:	03000793          	li	a5,48
    8020144e:	06f71b63          	bne	a4,a5,802014c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:132
                while ((ch = *(fmt++))) {
    80201452:	a891                	j	802014a6 <mini_vsnprintf+0xf4>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:133
                    if (ch == '\0') goto end;
    80201454:	fef44783          	lbu	a5,-17(s0)
    80201458:	0ff7f793          	andi	a5,a5,255
    8020145c:	26078e63          	beqz	a5,802016d8 <mini_vsnprintf+0x326>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:134
                    if (ch >= '0' && ch <= '9') {
    80201460:	fef44783          	lbu	a5,-17(s0)
    80201464:	0ff7f713          	andi	a4,a5,255
    80201468:	02f00793          	li	a5,47
    8020146c:	04e7fc63          	bgeu	a5,a4,802014c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:134 (discriminator 1)
    80201470:	fef44783          	lbu	a5,-17(s0)
    80201474:	0ff7f713          	andi	a4,a5,255
    80201478:	03900793          	li	a5,57
    8020147c:	04e7e463          	bltu	a5,a4,802014c4 <mini_vsnprintf+0x112>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:135
                        zero_pad = zero_pad * 10 + ch - '0';
    80201480:	fee44703          	lbu	a4,-18(s0)
    80201484:	87ba                	mv	a5,a4
    80201486:	0027979b          	slliw	a5,a5,0x2
    8020148a:	9fb9                	addw	a5,a5,a4
    8020148c:	0017979b          	slliw	a5,a5,0x1
    80201490:	0ff7f793          	andi	a5,a5,255
    80201494:	fef44703          	lbu	a4,-17(s0)
    80201498:	9fb9                	addw	a5,a5,a4
    8020149a:	0ff7f793          	andi	a5,a5,255
    8020149e:	fd07879b          	addiw	a5,a5,-48
    802014a2:	fef40723          	sb	a5,-18(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:132
                while ((ch = *(fmt++))) {
    802014a6:	f8843783          	ld	a5,-120(s0)
    802014aa:	00178713          	addi	a4,a5,1
    802014ae:	f8e43423          	sd	a4,-120(s0)
    802014b2:	0007c783          	lbu	a5,0(a5)
    802014b6:	fef407a3          	sb	a5,-17(s0)
    802014ba:	fef44783          	lbu	a5,-17(s0)
    802014be:	0ff7f793          	andi	a5,a5,255
    802014c2:	fbc9                	bnez	a5,80201454 <mini_vsnprintf+0xa2>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:141
                    } else {
                        break;
                    }
                }
            }
            if (ch == 'l') {
    802014c4:	fef44783          	lbu	a5,-17(s0)
    802014c8:	0ff7f713          	andi	a4,a5,255
    802014cc:	06c00793          	li	a5,108
    802014d0:	00f71f63          	bne	a4,a5,802014ee <mini_vsnprintf+0x13c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:142
                longflag = 1;
    802014d4:	4785                	li	a5,1
    802014d6:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:143
                ch = *(fmt++);
    802014da:	f8843783          	ld	a5,-120(s0)
    802014de:	00178713          	addi	a4,a5,1
    802014e2:	f8e43423          	sd	a4,-120(s0)
    802014e6:	0007c783          	lbu	a5,0(a5)
    802014ea:	fef407a3          	sb	a5,-17(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:146
            }

            switch (ch) {
    802014ee:	fef44783          	lbu	a5,-17(s0)
    802014f2:	2781                	sext.w	a5,a5
    802014f4:	1e078463          	beqz	a5,802016dc <mini_vsnprintf+0x32a>
    802014f8:	873e                	mv	a4,a5
    802014fa:	1a074263          	bltz	a4,8020169e <mini_vsnprintf+0x2ec>
    802014fe:	86be                	mv	a3,a5
    80201500:	07800713          	li	a4,120
    80201504:	18d74d63          	blt	a4,a3,8020169e <mini_vsnprintf+0x2ec>
    80201508:	86be                	mv	a3,a5
    8020150a:	05800713          	li	a4,88
    8020150e:	18e6c863          	blt	a3,a4,8020169e <mini_vsnprintf+0x2ec>
    80201512:	fa87869b          	addiw	a3,a5,-88
    80201516:	0006871b          	sext.w	a4,a3
    8020151a:	02000793          	li	a5,32
    8020151e:	18e7e063          	bltu	a5,a4,8020169e <mini_vsnprintf+0x2ec>
    80201522:	02069793          	slli	a5,a3,0x20
    80201526:	9381                	srli	a5,a5,0x20
    80201528:	00279713          	slli	a4,a5,0x2
    8020152c:	00005797          	auipc	a5,0x5
    80201530:	ad478793          	addi	a5,a5,-1324 # 80206000 <rodata_start>
    80201534:	97ba                	add	a5,a5,a4
    80201536:	439c                	lw	a5,0(a5)
    80201538:	0007871b          	sext.w	a4,a5
    8020153c:	00005797          	auipc	a5,0x5
    80201540:	ac478793          	addi	a5,a5,-1340 # 80206000 <rodata_start>
    80201544:	97ba                	add	a5,a5,a4
    80201546:	8782                	jr	a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:151
                case 0:
                    goto end;

                case 'l':
                    longflag = 1;
    80201548:	4785                	li	a5,1
    8020154a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:152
                    break;
    8020154e:	a295                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156

                case 'u':
                case 'd':
                    len = mini_itoa(
    80201550:	fe842783          	lw	a5,-24(s0)
    80201554:	2781                	sext.w	a5,a5
    80201556:	ef81                	bnez	a5,8020156e <mini_vsnprintf+0x1bc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:157
                        longflag == 0 ? (unsigned long)va_arg(
    80201558:	f8043783          	ld	a5,-128(s0)
    8020155c:	00878713          	addi	a4,a5,8
    80201560:	f8e43023          	sd	a4,-128(s0)
    80201564:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156
                    len = mini_itoa(
    80201566:	02079513          	slli	a0,a5,0x20
    8020156a:	9101                	srli	a0,a0,0x20
    8020156c:	a809                	j	8020157e <mini_vsnprintf+0x1cc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:159
                                            va, unsigned int) :
                                        va_arg(va, unsigned long),
    8020156e:	f8043783          	ld	a5,-128(s0)
    80201572:	00878713          	addi	a4,a5,8
    80201576:	f8e43023          	sd	a4,-128(s0)
    8020157a:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156
                    len = mini_itoa(
    8020157c:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:156 (discriminator 4)
    8020157e:	fef44783          	lbu	a5,-17(s0)
    80201582:	0007871b          	sext.w	a4,a5
    80201586:	07500793          	li	a5,117
    8020158a:	40f707b3          	sub	a5,a4,a5
    8020158e:	0017b793          	seqz	a5,a5
    80201592:	0ff7f793          	andi	a5,a5,255
    80201596:	0007869b          	sext.w	a3,a5
    8020159a:	fee44783          	lbu	a5,-18(s0)
    8020159e:	2781                	sext.w	a5,a5
    802015a0:	fa840713          	addi	a4,s0,-88
    802015a4:	4601                	li	a2,0
    802015a6:	45a9                	li	a1,10
    802015a8:	ac9ff0ef          	jal	ra,80201070 <mini_itoa>
    802015ac:	87aa                	mv	a5,a0
    802015ae:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:161 (discriminator 4)
                        10, 0, (ch == 'u'), bf, zero_pad);
                    _puts(bf, len, &b);
    802015b2:	fc040693          	addi	a3,s0,-64
    802015b6:	fdc42703          	lw	a4,-36(s0)
    802015ba:	fa840793          	addi	a5,s0,-88
    802015be:	8636                	mv	a2,a3
    802015c0:	85ba                	mv	a1,a4
    802015c2:	853e                	mv	a0,a5
    802015c4:	d39ff0ef          	jal	ra,802012fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:162 (discriminator 4)
                    longflag = 0;
    802015c8:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:163 (discriminator 4)
                    break;
    802015cc:	a0dd                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                case 'x':
                case 'X':
                    len = mini_itoa(
    802015ce:	fe842783          	lw	a5,-24(s0)
    802015d2:	2781                	sext.w	a5,a5
    802015d4:	ef81                	bnez	a5,802015ec <mini_vsnprintf+0x23a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:167
                        longflag == 0 ? (unsigned long)va_arg(
    802015d6:	f8043783          	ld	a5,-128(s0)
    802015da:	00878713          	addi	a4,a5,8
    802015de:	f8e43023          	sd	a4,-128(s0)
    802015e2:	439c                	lw	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                    len = mini_itoa(
    802015e4:	02079513          	slli	a0,a5,0x20
    802015e8:	9101                	srli	a0,a0,0x20
    802015ea:	a809                	j	802015fc <mini_vsnprintf+0x24a>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:169
                                            va, unsigned int) :
                                        va_arg(va, unsigned long),
    802015ec:	f8043783          	ld	a5,-128(s0)
    802015f0:	00878713          	addi	a4,a5,8
    802015f4:	f8e43023          	sd	a4,-128(s0)
    802015f8:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166
                    len = mini_itoa(
    802015fa:	853e                	mv	a0,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:166 (discriminator 4)
    802015fc:	fef44783          	lbu	a5,-17(s0)
    80201600:	0007871b          	sext.w	a4,a5
    80201604:	05800793          	li	a5,88
    80201608:	40f707b3          	sub	a5,a4,a5
    8020160c:	0017b793          	seqz	a5,a5
    80201610:	0ff7f793          	andi	a5,a5,255
    80201614:	0007861b          	sext.w	a2,a5
    80201618:	fee44783          	lbu	a5,-18(s0)
    8020161c:	2781                	sext.w	a5,a5
    8020161e:	fa840713          	addi	a4,s0,-88
    80201622:	4685                	li	a3,1
    80201624:	45c1                	li	a1,16
    80201626:	a4bff0ef          	jal	ra,80201070 <mini_itoa>
    8020162a:	87aa                	mv	a5,a0
    8020162c:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:171 (discriminator 4)
                        16, (ch == 'X'), 1, bf, zero_pad);
                    _puts(bf, len, &b);
    80201630:	fc040693          	addi	a3,s0,-64
    80201634:	fdc42703          	lw	a4,-36(s0)
    80201638:	fa840793          	addi	a5,s0,-88
    8020163c:	8636                	mv	a2,a3
    8020163e:	85ba                	mv	a1,a4
    80201640:	853e                	mv	a0,a5
    80201642:	cbbff0ef          	jal	ra,802012fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:172 (discriminator 4)
                    longflag = 0;
    80201646:	fe042423          	sw	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:173 (discriminator 4)
                    break;
    8020164a:	a0a5                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:176

                case 'c':
                    _putc((char)(va_arg(va, int)), &b);
    8020164c:	f8043783          	ld	a5,-128(s0)
    80201650:	00878713          	addi	a4,a5,8
    80201654:	f8e43023          	sd	a4,-128(s0)
    80201658:	439c                	lw	a5,0(a5)
    8020165a:	0ff7f793          	andi	a5,a5,255
    8020165e:	2781                	sext.w	a5,a5
    80201660:	fc040713          	addi	a4,s0,-64
    80201664:	85ba                	mv	a1,a4
    80201666:	853e                	mv	a0,a5
    80201668:	c2fff0ef          	jal	ra,80201296 <_putc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:177
                    break;
    8020166c:	a099                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:180

                case 's':
                    ptr = va_arg(va, char *);
    8020166e:	f8043783          	ld	a5,-128(s0)
    80201672:	00878713          	addi	a4,a5,8
    80201676:	f8e43023          	sd	a4,-128(s0)
    8020167a:	639c                	ld	a5,0(a5)
    8020167c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:181
                    _puts(ptr, mini_strlen(ptr), &b);
    80201680:	fe043503          	ld	a0,-32(s0)
    80201684:	9b7ff0ef          	jal	ra,8020103a <mini_strlen>
    80201688:	87aa                	mv	a5,a0
    8020168a:	2781                	sext.w	a5,a5
    8020168c:	fc040713          	addi	a4,s0,-64
    80201690:	863a                	mv	a2,a4
    80201692:	85be                	mv	a1,a5
    80201694:	fe043503          	ld	a0,-32(s0)
    80201698:	c65ff0ef          	jal	ra,802012fc <_puts>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:182
                    break;
    8020169c:	a819                	j	802016b2 <mini_vsnprintf+0x300>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:185

                default:
                    _putc(ch, &b);
    8020169e:	fef44783          	lbu	a5,-17(s0)
    802016a2:	2781                	sext.w	a5,a5
    802016a4:	fc040713          	addi	a4,s0,-64
    802016a8:	85ba                	mv	a1,a4
    802016aa:	853e                	mv	a0,a5
    802016ac:	bebff0ef          	jal	ra,80201296 <_putc>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:186
                    break;
    802016b0:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:116
    while ((ch = *(fmt++))) {
    802016b2:	f8843783          	ld	a5,-120(s0)
    802016b6:	00178713          	addi	a4,a5,1
    802016ba:	f8e43423          	sd	a4,-120(s0)
    802016be:	0007c783          	lbu	a5,0(a5)
    802016c2:	fef407a3          	sb	a5,-17(s0)
    802016c6:	fef44783          	lbu	a5,-17(s0)
    802016ca:	0ff7f793          	andi	a5,a5,255
    802016ce:	d0079ce3          	bnez	a5,802013e6 <mini_vsnprintf+0x34>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:190
            }
        }
    }
end:
    802016d2:	a031                	j	802016de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:119
            break;
    802016d4:	0001                	nop
    802016d6:	a021                	j	802016de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:133
                    if (ch == '\0') goto end;
    802016d8:	0001                	nop
    802016da:	a011                	j	802016de <mini_vsnprintf+0x32c>
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:148
                    goto end;
    802016dc:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:191
    return b.pbuffer - b.buffer;
    802016de:	fc843703          	ld	a4,-56(s0)
    802016e2:	fc043783          	ld	a5,-64(s0)
    802016e6:	40f707b3          	sub	a5,a4,a5
    802016ea:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:192
}
    802016ec:	853e                	mv	a0,a5
    802016ee:	70e6                	ld	ra,120(sp)
    802016f0:	7446                	ld	s0,112(sp)
    802016f2:	6109                	addi	sp,sp,128
    802016f4:	8082                	ret

00000000802016f6 <_vprintk>:
_vprintk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:196

static int _vprintk(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    802016f6:	7129                	addi	sp,sp,-320
    802016f8:	fe06                	sd	ra,312(sp)
    802016fa:	fa22                	sd	s0,304(sp)
    802016fc:	0280                	addi	s0,sp,320
    802016fe:	eca43c23          	sd	a0,-296(s0)
    80201702:	ecb43823          	sd	a1,-304(s0)
    80201706:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:198
    va_list va;
    va_copy(va, _va);
    8020170a:	ed043783          	ld	a5,-304(s0)
    8020170e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:203

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    80201712:	fe043703          	ld	a4,-32(s0)
    80201716:	ee040793          	addi	a5,s0,-288
    8020171a:	86ba                	mv	a3,a4
    8020171c:	ed843603          	ld	a2,-296(s0)
    80201720:	10000593          	li	a1,256
    80201724:	853e                	mv	a0,a5
    80201726:	c8dff0ef          	jal	ra,802013b2 <mini_vsnprintf>
    8020172a:	87aa                	mv	a5,a0
    8020172c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:205

    buff[ret] = '\0';
    80201730:	fec42783          	lw	a5,-20(s0)
    80201734:	ff040713          	addi	a4,s0,-16
    80201738:	97ba                	add	a5,a5,a4
    8020173a:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:210

    // disable_preempt();
    
    // 在此处调用sbi，output
    output(buff);
    8020173e:	ee040793          	addi	a5,s0,-288
    80201742:	ec843703          	ld	a4,-312(s0)
    80201746:	853e                	mv	a0,a5
    80201748:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:225
    //     }
    // }

    // enable_preempt();

    return ret;
    8020174a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:226
}
    8020174e:	853e                	mv	a0,a5
    80201750:	70f2                	ld	ra,312(sp)
    80201752:	7452                	ld	s0,304(sp)
    80201754:	6131                	addi	sp,sp,320
    80201756:	8082                	ret

0000000080201758 <_vprints>:
_vprints():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:230

static int _vprints(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    80201758:	7129                	addi	sp,sp,-320
    8020175a:	fe06                	sd	ra,312(sp)
    8020175c:	fa22                	sd	s0,304(sp)
    8020175e:	0280                	addi	s0,sp,320
    80201760:	eca43c23          	sd	a0,-296(s0)
    80201764:	ecb43823          	sd	a1,-304(s0)
    80201768:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:232
    va_list va;
    va_copy(va, _va);
    8020176c:	ed043783          	ld	a5,-304(s0)
    80201770:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:237

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    80201774:	fe043703          	ld	a4,-32(s0)
    80201778:	ee040793          	addi	a5,s0,-288
    8020177c:	86ba                	mv	a3,a4
    8020177e:	ed843603          	ld	a2,-296(s0)
    80201782:	10000593          	li	a1,256
    80201786:	853e                	mv	a0,a5
    80201788:	c2bff0ef          	jal	ra,802013b2 <mini_vsnprintf>
    8020178c:	87aa                	mv	a5,a0
    8020178e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:239

    buff[ret] = '\0';
    80201792:	fec42783          	lw	a5,-20(s0)
    80201796:	ff040713          	addi	a4,s0,-16
    8020179a:	97ba                	add	a5,a5,a4
    8020179c:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:245


    // disable_preempt();

    // 在此处调用sbi，output
    output(buff);
    802017a0:	ee040793          	addi	a5,s0,-288
    802017a4:	ec843703          	ld	a4,-312(s0)
    802017a8:	853e                	mv	a0,a5
    802017aa:	9702                	jalr	a4
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:249

    // enable_preempt();

    return ret;
    802017ac:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:250
}
    802017b0:	853e                	mv	a0,a5
    802017b2:	70f2                	ld	ra,312(sp)
    802017b4:	7452                	ld	s0,304(sp)
    802017b6:	6131                	addi	sp,sp,320
    802017b8:	8082                	ret

00000000802017ba <vprintk>:
vprintk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:254


int vprintk(const char *fmt, va_list _va)
{
    802017ba:	1101                	addi	sp,sp,-32
    802017bc:	ec06                	sd	ra,24(sp)
    802017be:	e822                	sd	s0,16(sp)
    802017c0:	1000                	addi	s0,sp,32
    802017c2:	fea43423          	sd	a0,-24(s0)
    802017c6:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:255
    return _vprintk(fmt, _va, port_write);
    802017ca:	00000617          	auipc	a2,0x0
    802017ce:	83660613          	addi	a2,a2,-1994 # 80201000 <port_write>
    802017d2:	fe043583          	ld	a1,-32(s0)
    802017d6:	fe843503          	ld	a0,-24(s0)
    802017da:	f1dff0ef          	jal	ra,802016f6 <_vprintk>
    802017de:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:256
}
    802017e0:	853e                	mv	a0,a5
    802017e2:	60e2                	ld	ra,24(sp)
    802017e4:	6442                	ld	s0,16(sp)
    802017e6:	6105                	addi	sp,sp,32
    802017e8:	8082                	ret

00000000802017ea <printk>:
printk():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:259

int printk(const char *fmt, ...)
{
    802017ea:	7159                	addi	sp,sp,-112
    802017ec:	f406                	sd	ra,40(sp)
    802017ee:	f022                	sd	s0,32(sp)
    802017f0:	1800                	addi	s0,sp,48
    802017f2:	fca43c23          	sd	a0,-40(s0)
    802017f6:	e40c                	sd	a1,8(s0)
    802017f8:	e810                	sd	a2,16(s0)
    802017fa:	ec14                	sd	a3,24(s0)
    802017fc:	f018                	sd	a4,32(s0)
    802017fe:	f41c                	sd	a5,40(s0)
    80201800:	03043823          	sd	a6,48(s0)
    80201804:	03143c23          	sd	a7,56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:260
    int ret = 0;
    80201808:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:263
    va_list va;

    va_start(va, fmt);
    8020180c:	04040793          	addi	a5,s0,64
    80201810:	fcf43823          	sd	a5,-48(s0)
    80201814:	fd043783          	ld	a5,-48(s0)
    80201818:	fc878793          	addi	a5,a5,-56
    8020181c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:264
    ret = vprintk(fmt, va);
    80201820:	fe043783          	ld	a5,-32(s0)
    80201824:	85be                	mv	a1,a5
    80201826:	fd843503          	ld	a0,-40(s0)
    8020182a:	f91ff0ef          	jal	ra,802017ba <vprintk>
    8020182e:	87aa                	mv	a5,a0
    80201830:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:267
    va_end(va);

    return ret;
    80201834:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:268
}
    80201838:	853e                	mv	a0,a5
    8020183a:	70a2                	ld	ra,40(sp)
    8020183c:	7402                	ld	s0,32(sp)
    8020183e:	6165                	addi	sp,sp,112
    80201840:	8082                	ret

0000000080201842 <_vprintk_port>:
_vprintk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:274

/* for port output, direct output */

static int _vprintk_port(const char* fmt, va_list _va,
                   void (*output)(char*))
{
    80201842:	7129                	addi	sp,sp,-320
    80201844:	fe06                	sd	ra,312(sp)
    80201846:	fa22                	sd	s0,304(sp)
    80201848:	0280                	addi	s0,sp,320
    8020184a:	eca43c23          	sd	a0,-296(s0)
    8020184e:	ecb43823          	sd	a1,-304(s0)
    80201852:	ecc43423          	sd	a2,-312(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:276
    va_list va;
    va_copy(va, _va);
    80201856:	ed043783          	ld	a5,-304(s0)
    8020185a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:281

    int ret;
    char buff[256];

    ret = mini_vsnprintf(buff, 256, fmt, va);
    8020185e:	fe043703          	ld	a4,-32(s0)
    80201862:	ee040793          	addi	a5,s0,-288
    80201866:	86ba                	mv	a3,a4
    80201868:	ed843603          	ld	a2,-296(s0)
    8020186c:	10000593          	li	a1,256
    80201870:	853e                	mv	a0,a5
    80201872:	b41ff0ef          	jal	ra,802013b2 <mini_vsnprintf>
    80201876:	87aa                	mv	a5,a0
    80201878:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:283

    buff[ret] = '\0';
    8020187c:	fec42783          	lw	a5,-20(s0)
    80201880:	ff040713          	addi	a4,s0,-16
    80201884:	97ba                	add	a5,a5,a4
    80201886:	ee078823          	sb	zero,-272(a5)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:292
    // 在此处调用sbi，output
    // port_write(buff);

    // enable_preempt();

    return ret;
    8020188a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:293
}
    8020188e:	853e                	mv	a0,a5
    80201890:	70f2                	ld	ra,312(sp)
    80201892:	7452                	ld	s0,304(sp)
    80201894:	6131                	addi	sp,sp,320
    80201896:	8082                	ret

0000000080201898 <vprintk_port>:
vprintk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:297


int vprintk_port(const char *fmt, va_list _va)
{
    80201898:	1101                	addi	sp,sp,-32
    8020189a:	ec06                	sd	ra,24(sp)
    8020189c:	e822                	sd	s0,16(sp)
    8020189e:	1000                	addi	s0,sp,32
    802018a0:	fea43423          	sd	a0,-24(s0)
    802018a4:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:298
    return _vprintk_port(fmt, _va, port_write);
    802018a8:	fffff617          	auipc	a2,0xfffff
    802018ac:	75860613          	addi	a2,a2,1880 # 80201000 <port_write>
    802018b0:	fe043583          	ld	a1,-32(s0)
    802018b4:	fe843503          	ld	a0,-24(s0)
    802018b8:	f8bff0ef          	jal	ra,80201842 <_vprintk_port>
    802018bc:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:299
}
    802018be:	853e                	mv	a0,a5
    802018c0:	60e2                	ld	ra,24(sp)
    802018c2:	6442                	ld	s0,16(sp)
    802018c4:	6105                	addi	sp,sp,32
    802018c6:	8082                	ret

00000000802018c8 <printk_port>:
printk_port():
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:302

uint32_t printk_port(const char *fmt, ...)
{
    802018c8:	7159                	addi	sp,sp,-112
    802018ca:	f406                	sd	ra,40(sp)
    802018cc:	f022                	sd	s0,32(sp)
    802018ce:	1800                	addi	s0,sp,48
    802018d0:	fca43c23          	sd	a0,-40(s0)
    802018d4:	e40c                	sd	a1,8(s0)
    802018d6:	e810                	sd	a2,16(s0)
    802018d8:	ec14                	sd	a3,24(s0)
    802018da:	f018                	sd	a4,32(s0)
    802018dc:	f41c                	sd	a5,40(s0)
    802018de:	03043823          	sd	a6,48(s0)
    802018e2:	03143c23          	sd	a7,56(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:303
    uint32_t ret = 0;
    802018e6:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:306
    va_list va;

    va_start(va, fmt);
    802018ea:	04040793          	addi	a5,s0,64
    802018ee:	fcf43823          	sd	a5,-48(s0)
    802018f2:	fd043783          	ld	a5,-48(s0)
    802018f6:	fc878793          	addi	a5,a5,-56
    802018fa:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:307
    ret = vprintk_port(fmt, va);
    802018fe:	fe043783          	ld	a5,-32(s0)
    80201902:	85be                	mv	a1,a5
    80201904:	fd843503          	ld	a0,-40(s0)
    80201908:	f91ff0ef          	jal	ra,80201898 <vprintk_port>
    8020190c:	87aa                	mv	a5,a0
    8020190e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:310
    va_end(va);

    return ret;
    80201912:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/lib/printk.c:311
    80201916:	853e                	mv	a0,a5
    80201918:	70a2                	ld	ra,40(sp)
    8020191a:	7402                	ld	s0,32(sp)
    8020191c:	6165                	addi	sp,sp,112
    8020191e:	8082                	ret

0000000080201920 <main_os>:
main_os():
/home/caigoubencai/Desktop/os_c/kernel/main.c:13
#include "task.h"
#include "timer.h"
#include "kernel_heap.h"
#include "mem.h"
int main_os()
{
    80201920:	1141                	addi	sp,sp,-16
    80201922:	e406                	sd	ra,8(sp)
    80201924:	e022                	sd	s0,0(sp)
    80201926:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/main.c:14
    printk("123%d\n",123);
    80201928:	07b00593          	li	a1,123
    8020192c:	00004517          	auipc	a0,0x4
    80201930:	75c50513          	addi	a0,a0,1884 # 80206088 <rodata_start+0x88>
    80201934:	eb7ff0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/main.c:17
    // console_putchar('1');
    // print_str("123123\n");
    init_interrupt();
    80201938:	13a030ef          	jal	ra,80204a72 <init_interrupt>
/home/caigoubencai/Desktop/os_c/kernel/main.c:18
    load_app_test();
    8020193c:	653020ef          	jal	ra,8020478e <load_app_test>
/home/caigoubencai/Desktop/os_c/kernel/main.c:19
    timer_init();
    80201940:	60c030ef          	jal	ra,80204f4c <timer_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:22
    // init_appmanager();
    // run_first_app();
    init_appmanager();
    80201944:	321020ef          	jal	ra,80204464 <init_appmanager>
/home/caigoubencai/Desktop/os_c/kernel/main.c:24
    // init_appmanager();
    task_manager_init();
    80201948:	02f020ef          	jal	ra,80204176 <task_manager_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:26
    //printk("123%d\n",12);
    mm_init();
    8020194c:	6e3000ef          	jal	ra,8020282e <mm_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:27
    ASSERT(0);
    80201950:	45ed                	li	a1,27
    80201952:	00004517          	auipc	a0,0x4
    80201956:	73e50513          	addi	a0,a0,1854 # 80206090 <rodata_start+0x90>
    8020195a:	7ce020ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/main.c:28 (discriminator 1)
    while(1){}
    8020195e:	a001                	j	8020195e <main_os+0x3e>

0000000080201960 <elf_load_sections_loop>:
elf_load_sections_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:18

/*
** traverse the section header table and load each section
*/
static int elf_load_sections_loop(t_elf *elf, size_t shoff, size_t shnum,
                                  size_t shentsize) {
    80201960:	715d                	addi	sp,sp,-80
    80201962:	e486                	sd	ra,72(sp)
    80201964:	e0a2                	sd	s0,64(sp)
    80201966:	0880                	addi	s0,sp,80
    80201968:	fca43423          	sd	a0,-56(s0)
    8020196c:	fcb43023          	sd	a1,-64(s0)
    80201970:	fac43c23          	sd	a2,-72(s0)
    80201974:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:23
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    80201978:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    8020197c:	a0dd                	j	80201a62 <elf_load_sections_loop+0x102>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:25
    if (i >= MAX_SECTION_NUM) {
    8020197e:	fe843703          	ld	a4,-24(s0)
    80201982:	03f00793          	li	a5,63
    80201986:	00e7f463          	bgeu	a5,a4,8020198e <elf_load_sections_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:26
      return (-1);
    8020198a:	57fd                	li	a5,-1
    8020198c:	a0d5                	j	80201a70 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:29
    }
    elf->sections[i].header =
        (union u_elf_sh *)(elf->raw_data + shoff + i * shentsize);
    8020198e:	fc843783          	ld	a5,-56(s0)
    80201992:	6798                	ld	a4,8(a5)
    80201994:	fe843683          	ld	a3,-24(s0)
    80201998:	fb043783          	ld	a5,-80(s0)
    8020199c:	02f686b3          	mul	a3,a3,a5
    802019a0:	fc043783          	ld	a5,-64(s0)
    802019a4:	97b6                	add	a5,a5,a3
    802019a6:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:28
    elf->sections[i].header =
    802019a8:	fc843683          	ld	a3,-56(s0)
    802019ac:	fe843783          	ld	a5,-24(s0)
    802019b0:	0789                	addi	a5,a5,2
    802019b2:	0792                	slli	a5,a5,0x4
    802019b4:	97b6                	add	a5,a5,a3
    802019b6:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:30
    type = elf_section_get_type(elf, &elf->sections[i]);
    802019b8:	fe843783          	ld	a5,-24(s0)
    802019bc:	0789                	addi	a5,a5,2
    802019be:	0792                	slli	a5,a5,0x4
    802019c0:	fc843703          	ld	a4,-56(s0)
    802019c4:	97ba                	add	a5,a5,a4
    802019c6:	07a1                	addi	a5,a5,8
    802019c8:	85be                	mv	a1,a5
    802019ca:	fc843503          	ld	a0,-56(s0)
    802019ce:	576000ef          	jal	ra,80201f44 <elf_section_get_type>
    802019d2:	87aa                	mv	a5,a0
    802019d4:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31
    if (type != SHT_NULL && type != SHT_NOBITS) {
    802019d8:	fe442783          	lw	a5,-28(s0)
    802019dc:	2781                	sext.w	a5,a5
    802019de:	cfad                	beqz	a5,80201a58 <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:31 (discriminator 1)
    802019e0:	fe442783          	lw	a5,-28(s0)
    802019e4:	0007871b          	sext.w	a4,a5
    802019e8:	47a1                	li	a5,8
    802019ea:	06f70763          	beq	a4,a5,80201a58 <elf_load_sections_loop+0xf8>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:32
      content_offset = elf_section_get_offset(elf, &elf->sections[i]);
    802019ee:	fe843783          	ld	a5,-24(s0)
    802019f2:	0789                	addi	a5,a5,2
    802019f4:	0792                	slli	a5,a5,0x4
    802019f6:	fc843703          	ld	a4,-56(s0)
    802019fa:	97ba                	add	a5,a5,a4
    802019fc:	07a1                	addi	a5,a5,8
    802019fe:	85be                	mv	a1,a5
    80201a00:	fc843503          	ld	a0,-56(s0)
    80201a04:	584000ef          	jal	ra,80201f88 <elf_section_get_offset>
    80201a08:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80201a0c:	fe843783          	ld	a5,-24(s0)
    80201a10:	0789                	addi	a5,a5,2
    80201a12:	0792                	slli	a5,a5,0x4
    80201a14:	fc843703          	ld	a4,-56(s0)
    80201a18:	97ba                	add	a5,a5,a4
    80201a1a:	07a1                	addi	a5,a5,8
    80201a1c:	85be                	mv	a1,a5
    80201a1e:	fc843503          	ld	a0,-56(s0)
    80201a22:	5ae000ef          	jal	ra,80201fd0 <elf_section_get_size>
    80201a26:	872a                	mv	a4,a0
    80201a28:	fd843783          	ld	a5,-40(s0)
    80201a2c:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:34
          elf->size) {
    80201a2e:	fc843783          	ld	a5,-56(s0)
    80201a32:	639c                	ld	a5,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:33
      if (content_offset + elf_section_get_size(elf, &elf->sections[i]) >
    80201a34:	00e7f463          	bgeu	a5,a4,80201a3c <elf_load_sections_loop+0xdc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:35
        return (-1);
    80201a38:	57fd                	li	a5,-1
    80201a3a:	a81d                	j	80201a70 <elf_load_sections_loop+0x110>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:37
      }
      elf->sections[i].content = elf->raw_data + content_offset;
    80201a3c:	fc843783          	ld	a5,-56(s0)
    80201a40:	6798                	ld	a4,8(a5)
    80201a42:	fd843783          	ld	a5,-40(s0)
    80201a46:	973e                	add	a4,a4,a5
    80201a48:	fc843683          	ld	a3,-56(s0)
    80201a4c:	fe843783          	ld	a5,-24(s0)
    80201a50:	0789                	addi	a5,a5,2
    80201a52:	0792                	slli	a5,a5,0x4
    80201a54:	97b6                	add	a5,a5,a3
    80201a56:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:39
    }
    i++;
    80201a58:	fe843783          	ld	a5,-24(s0)
    80201a5c:	0785                	addi	a5,a5,1
    80201a5e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:24
  while (i < shnum) {
    80201a62:	fe843703          	ld	a4,-24(s0)
    80201a66:	fb843783          	ld	a5,-72(s0)
    80201a6a:	f0f76ae3          	bltu	a4,a5,8020197e <elf_load_sections_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:41
  }
  return (0);
    80201a6e:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:42
}
    80201a70:	853e                	mv	a0,a5
    80201a72:	60a6                	ld	ra,72(sp)
    80201a74:	6406                	ld	s0,64(sp)
    80201a76:	6161                	addi	sp,sp,80
    80201a78:	8082                	ret

0000000080201a7a <elf_load_sections>:
elf_load_sections():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:48

/*
** Load sections. Create a table of t_elf_section in elf->sections.
** This table is null if there is no section header table.
*/
int elf_load_sections(t_elf *elf) {
    80201a7a:	7139                	addi	sp,sp,-64
    80201a7c:	fc06                	sd	ra,56(sp)
    80201a7e:	f822                	sd	s0,48(sp)
    80201a80:	0080                	addi	s0,sp,64
    80201a82:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:53
  size_t shoff;
  size_t shnum;
  size_t shentsize;

  if ((shoff = elf_header_get_shoff(elf)) > 0) {
    80201a86:	fc843503          	ld	a0,-56(s0)
    80201a8a:	0cc000ef          	jal	ra,80201b56 <elf_header_get_shoff>
    80201a8e:	fea43423          	sd	a0,-24(s0)
    80201a92:	fe843783          	ld	a5,-24(s0)
    80201a96:	cfb1                	beqz	a5,80201af2 <elf_load_sections+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:54
    shnum = elf_header_get_shnum(elf);
    80201a98:	fc843503          	ld	a0,-56(s0)
    80201a9c:	142000ef          	jal	ra,80201bde <elf_header_get_shnum>
    80201aa0:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:55
    shentsize = elf_header_get_shentsize(elf);
    80201aa4:	fc843503          	ld	a0,-56(s0)
    80201aa8:	0f2000ef          	jal	ra,80201b9a <elf_header_get_shentsize>
    80201aac:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:56
    if (shoff + shnum * shentsize > elf->size) {
    80201ab0:	fe043703          	ld	a4,-32(s0)
    80201ab4:	fd843783          	ld	a5,-40(s0)
    80201ab8:	02f70733          	mul	a4,a4,a5
    80201abc:	fe843783          	ld	a5,-24(s0)
    80201ac0:	973e                	add	a4,a4,a5
    80201ac2:	fc843783          	ld	a5,-56(s0)
    80201ac6:	639c                	ld	a5,0(a5)
    80201ac8:	00e7f463          	bgeu	a5,a4,80201ad0 <elf_load_sections+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:57
      return (-1);
    80201acc:	57fd                	li	a5,-1
    80201ace:	a82d                	j	80201b08 <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:59
    }
    if (elf_load_sections_loop(elf, shoff, shnum, shentsize) == -1) {
    80201ad0:	fd843683          	ld	a3,-40(s0)
    80201ad4:	fe043603          	ld	a2,-32(s0)
    80201ad8:	fe843583          	ld	a1,-24(s0)
    80201adc:	fc843503          	ld	a0,-56(s0)
    80201ae0:	e81ff0ef          	jal	ra,80201960 <elf_load_sections_loop>
    80201ae4:	87aa                	mv	a5,a0
    80201ae6:	873e                	mv	a4,a5
    80201ae8:	57fd                	li	a5,-1
    80201aea:	00f71e63          	bne	a4,a5,80201b06 <elf_load_sections+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:60
      return (-1);
    80201aee:	57fd                	li	a5,-1
    80201af0:	a821                	j	80201b08 <elf_load_sections+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:63
    }
  } else
    memset(elf->sections, 0, MAX_SECTION_NUM * sizeof(t_elf_section));
    80201af2:	fc843783          	ld	a5,-56(s0)
    80201af6:	02878793          	addi	a5,a5,40
    80201afa:	40000613          	li	a2,1024
    80201afe:	4581                	li	a1,0
    80201b00:	853e                	mv	a0,a5
    80201b02:	437000ef          	jal	ra,80202738 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:64
  return (0);
    80201b06:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_sections.c:65
}
    80201b08:	853e                	mv	a0,a5
    80201b0a:	70e2                	ld	ra,56(sp)
    80201b0c:	7442                	ld	s0,48(sp)
    80201b0e:	6121                	addi	sp,sp,64
    80201b10:	8082                	ret

0000000080201b12 <elf_header_get_entry>:
elf_header_get_entry():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:14
** Last update Mon Mar 10 20:51:03 2014 Barthelemy Delemotte
*/

#include "elfparse.h"

size_t elf_header_get_entry(t_elf *elf) {
    80201b12:	7179                	addi	sp,sp,-48
    80201b14:	f422                	sd	s0,40(sp)
    80201b16:	1800                	addi	s0,sp,48
    80201b18:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:17
  size_t entry;

  if (ELF_IS_32(elf))
    80201b1c:	fd843783          	ld	a5,-40(s0)
    80201b20:	0187c783          	lbu	a5,24(a5)
    80201b24:	873e                	mv	a4,a5
    80201b26:	4785                	li	a5,1
    80201b28:	00f71b63          	bne	a4,a5,80201b3e <elf_header_get_entry+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:18
    entry = (size_t)elf->header->_32.e_entry;
    80201b2c:	fd843783          	ld	a5,-40(s0)
    80201b30:	739c                	ld	a5,32(a5)
    80201b32:	4f9c                	lw	a5,24(a5)
    80201b34:	1782                	slli	a5,a5,0x20
    80201b36:	9381                	srli	a5,a5,0x20
    80201b38:	fef43423          	sd	a5,-24(s0)
    80201b3c:	a039                	j	80201b4a <elf_header_get_entry+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:20
  else
    entry = (size_t)elf->header->_64.e_entry;
    80201b3e:	fd843783          	ld	a5,-40(s0)
    80201b42:	739c                	ld	a5,32(a5)
    80201b44:	6f9c                	ld	a5,24(a5)
    80201b46:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:21
  return (entry);
    80201b4a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get.c:22
}
    80201b4e:	853e                	mv	a0,a5
    80201b50:	7422                	ld	s0,40(sp)
    80201b52:	6145                	addi	sp,sp,48
    80201b54:	8082                	ret

0000000080201b56 <elf_header_get_shoff>:
elf_header_get_shoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:17
#include "elfparse.h"

/*
** Get the section header table offset
*/
size_t elf_header_get_shoff(t_elf *elf) {
    80201b56:	7179                	addi	sp,sp,-48
    80201b58:	f422                	sd	s0,40(sp)
    80201b5a:	1800                	addi	s0,sp,48
    80201b5c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:20
  size_t shoff;

  if (ELF_IS_32(elf))
    80201b60:	fd843783          	ld	a5,-40(s0)
    80201b64:	0187c783          	lbu	a5,24(a5)
    80201b68:	873e                	mv	a4,a5
    80201b6a:	4785                	li	a5,1
    80201b6c:	00f71b63          	bne	a4,a5,80201b82 <elf_header_get_shoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:21
    shoff = (size_t)elf->header->_32.e_shoff;
    80201b70:	fd843783          	ld	a5,-40(s0)
    80201b74:	739c                	ld	a5,32(a5)
    80201b76:	539c                	lw	a5,32(a5)
    80201b78:	1782                	slli	a5,a5,0x20
    80201b7a:	9381                	srli	a5,a5,0x20
    80201b7c:	fef43423          	sd	a5,-24(s0)
    80201b80:	a039                	j	80201b8e <elf_header_get_shoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:23
  else
    shoff = (size_t)elf->header->_64.e_shoff;
    80201b82:	fd843783          	ld	a5,-40(s0)
    80201b86:	739c                	ld	a5,32(a5)
    80201b88:	779c                	ld	a5,40(a5)
    80201b8a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:24
  return (shoff);
    80201b8e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:25
}
    80201b92:	853e                	mv	a0,a5
    80201b94:	7422                	ld	s0,40(sp)
    80201b96:	6145                	addi	sp,sp,48
    80201b98:	8082                	ret

0000000080201b9a <elf_header_get_shentsize>:
elf_header_get_shentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:30

/*
** Get the size of one section header
*/
size_t elf_header_get_shentsize(t_elf *elf) {
    80201b9a:	7179                	addi	sp,sp,-48
    80201b9c:	f422                	sd	s0,40(sp)
    80201b9e:	1800                	addi	s0,sp,48
    80201ba0:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:33
  size_t shentsize;

  if (ELF_IS_32(elf))
    80201ba4:	fd843783          	ld	a5,-40(s0)
    80201ba8:	0187c783          	lbu	a5,24(a5)
    80201bac:	873e                	mv	a4,a5
    80201bae:	4785                	li	a5,1
    80201bb0:	00f71a63          	bne	a4,a5,80201bc4 <elf_header_get_shentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:34
    shentsize = (size_t)elf->header->_32.e_shentsize;
    80201bb4:	fd843783          	ld	a5,-40(s0)
    80201bb8:	739c                	ld	a5,32(a5)
    80201bba:	02e7d783          	lhu	a5,46(a5)
    80201bbe:	fef43423          	sd	a5,-24(s0)
    80201bc2:	a801                	j	80201bd2 <elf_header_get_shentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:36
  else
    shentsize = (size_t)elf->header->_64.e_shentsize;
    80201bc4:	fd843783          	ld	a5,-40(s0)
    80201bc8:	739c                	ld	a5,32(a5)
    80201bca:	03a7d783          	lhu	a5,58(a5)
    80201bce:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:37
  return (shentsize);
    80201bd2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:38
}
    80201bd6:	853e                	mv	a0,a5
    80201bd8:	7422                	ld	s0,40(sp)
    80201bda:	6145                	addi	sp,sp,48
    80201bdc:	8082                	ret

0000000080201bde <elf_header_get_shnum>:
elf_header_get_shnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:43

/*
** Get the number of entry in the section header table
*/
size_t elf_header_get_shnum(t_elf *elf) {
    80201bde:	7179                	addi	sp,sp,-48
    80201be0:	f422                	sd	s0,40(sp)
    80201be2:	1800                	addi	s0,sp,48
    80201be4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:46
  size_t shum;

  if (ELF_IS_32(elf))
    80201be8:	fd843783          	ld	a5,-40(s0)
    80201bec:	0187c783          	lbu	a5,24(a5)
    80201bf0:	873e                	mv	a4,a5
    80201bf2:	4785                	li	a5,1
    80201bf4:	00f71a63          	bne	a4,a5,80201c08 <elf_header_get_shnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:47
    shum = (size_t)elf->header->_32.e_shnum;
    80201bf8:	fd843783          	ld	a5,-40(s0)
    80201bfc:	739c                	ld	a5,32(a5)
    80201bfe:	0307d783          	lhu	a5,48(a5)
    80201c02:	fef43423          	sd	a5,-24(s0)
    80201c06:	a801                	j	80201c16 <elf_header_get_shnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:49
  else
    shum = (size_t)elf->header->_64.e_shnum;
    80201c08:	fd843783          	ld	a5,-40(s0)
    80201c0c:	739c                	ld	a5,32(a5)
    80201c0e:	03c7d783          	lhu	a5,60(a5)
    80201c12:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:50
  return (shum);
    80201c16:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_sh.c:51
}
    80201c1a:	853e                	mv	a0,a5
    80201c1c:	7422                	ld	s0,40(sp)
    80201c1e:	6145                	addi	sp,sp,48
    80201c20:	8082                	ret

0000000080201c22 <elf_program_get_type>:
elf_program_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:8
#include "elfparse.h"

/*
** Get the program type.
*/
uint32_t elf_program_get_type(t_elf *elf, t_elf_program *program) {
    80201c22:	7179                	addi	sp,sp,-48
    80201c24:	f422                	sd	s0,40(sp)
    80201c26:	1800                	addi	s0,sp,48
    80201c28:	fca43c23          	sd	a0,-40(s0)
    80201c2c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:11
  uint32_t type;

  if (ELF_IS_32(elf))
    80201c30:	fd843783          	ld	a5,-40(s0)
    80201c34:	0187c783          	lbu	a5,24(a5)
    80201c38:	873e                	mv	a4,a5
    80201c3a:	4785                	li	a5,1
    80201c3c:	00f71963          	bne	a4,a5,80201c4e <elf_program_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:12
    type = (uint32_t)program->header->_32.p_type;
    80201c40:	fd043783          	ld	a5,-48(s0)
    80201c44:	639c                	ld	a5,0(a5)
    80201c46:	439c                	lw	a5,0(a5)
    80201c48:	fef42623          	sw	a5,-20(s0)
    80201c4c:	a039                	j	80201c5a <elf_program_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:14
  else
    type = (uint32_t)program->header->_64.p_type;
    80201c4e:	fd043783          	ld	a5,-48(s0)
    80201c52:	639c                	ld	a5,0(a5)
    80201c54:	439c                	lw	a5,0(a5)
    80201c56:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:15
  return (type);
    80201c5a:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:16
}
    80201c5e:	853e                	mv	a0,a5
    80201c60:	7422                	ld	s0,40(sp)
    80201c62:	6145                	addi	sp,sp,48
    80201c64:	8082                	ret

0000000080201c66 <elf_program_get_offset>:
elf_program_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:21

/*
** Get the program offset (from the begin of the file)
*/
size_t elf_program_get_offset(t_elf *elf, t_elf_program *program) {
    80201c66:	7179                	addi	sp,sp,-48
    80201c68:	f422                	sd	s0,40(sp)
    80201c6a:	1800                	addi	s0,sp,48
    80201c6c:	fca43c23          	sd	a0,-40(s0)
    80201c70:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:24
  size_t offset;

  if (ELF_IS_32(elf))
    80201c74:	fd843783          	ld	a5,-40(s0)
    80201c78:	0187c783          	lbu	a5,24(a5)
    80201c7c:	873e                	mv	a4,a5
    80201c7e:	4785                	li	a5,1
    80201c80:	00f71b63          	bne	a4,a5,80201c96 <elf_program_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:25
    offset = (size_t)program->header->_32.p_offset;
    80201c84:	fd043783          	ld	a5,-48(s0)
    80201c88:	639c                	ld	a5,0(a5)
    80201c8a:	43dc                	lw	a5,4(a5)
    80201c8c:	1782                	slli	a5,a5,0x20
    80201c8e:	9381                	srli	a5,a5,0x20
    80201c90:	fef43423          	sd	a5,-24(s0)
    80201c94:	a039                	j	80201ca2 <elf_program_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:27
  else
    offset = (size_t)program->header->_64.p_offset;
    80201c96:	fd043783          	ld	a5,-48(s0)
    80201c9a:	639c                	ld	a5,0(a5)
    80201c9c:	679c                	ld	a5,8(a5)
    80201c9e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:28
  return (offset);
    80201ca2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:29
}
    80201ca6:	853e                	mv	a0,a5
    80201ca8:	7422                	ld	s0,40(sp)
    80201caa:	6145                	addi	sp,sp,48
    80201cac:	8082                	ret

0000000080201cae <elf_program_get_flags>:
elf_program_get_flags():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:34

/*
** Get the flags of the program
*/
uint64_t elf_program_get_flags(t_elf *elf, t_elf_program *program) {
    80201cae:	7179                	addi	sp,sp,-48
    80201cb0:	f422                	sd	s0,40(sp)
    80201cb2:	1800                	addi	s0,sp,48
    80201cb4:	fca43c23          	sd	a0,-40(s0)
    80201cb8:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:37
  uint64_t flags;

  if (ELF_IS_32(elf))
    80201cbc:	fd843783          	ld	a5,-40(s0)
    80201cc0:	0187c783          	lbu	a5,24(a5)
    80201cc4:	873e                	mv	a4,a5
    80201cc6:	4785                	li	a5,1
    80201cc8:	00f71b63          	bne	a4,a5,80201cde <elf_program_get_flags+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:38
    flags = (uint64_t)program->header->_32.p_flags;
    80201ccc:	fd043783          	ld	a5,-48(s0)
    80201cd0:	639c                	ld	a5,0(a5)
    80201cd2:	4f9c                	lw	a5,24(a5)
    80201cd4:	1782                	slli	a5,a5,0x20
    80201cd6:	9381                	srli	a5,a5,0x20
    80201cd8:	fef43423          	sd	a5,-24(s0)
    80201cdc:	a809                	j	80201cee <elf_program_get_flags+0x40>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:40
  else
    flags = (uint64_t)program->header->_64.p_flags;
    80201cde:	fd043783          	ld	a5,-48(s0)
    80201ce2:	639c                	ld	a5,0(a5)
    80201ce4:	43dc                	lw	a5,4(a5)
    80201ce6:	1782                	slli	a5,a5,0x20
    80201ce8:	9381                	srli	a5,a5,0x20
    80201cea:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:41
  return (flags);
    80201cee:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:42
}
    80201cf2:	853e                	mv	a0,a5
    80201cf4:	7422                	ld	s0,40(sp)
    80201cf6:	6145                	addi	sp,sp,48
    80201cf8:	8082                	ret

0000000080201cfa <elf_program_get_vaddr>:
elf_program_get_vaddr():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:47

/*
** Get the virtual address of the program
*/
uint64_t elf_program_get_vaddr(t_elf *elf, t_elf_program *program) {
    80201cfa:	7179                	addi	sp,sp,-48
    80201cfc:	f422                	sd	s0,40(sp)
    80201cfe:	1800                	addi	s0,sp,48
    80201d00:	fca43c23          	sd	a0,-40(s0)
    80201d04:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:50
  uint64_t addr;

  if (ELF_IS_32(elf))
    80201d08:	fd843783          	ld	a5,-40(s0)
    80201d0c:	0187c783          	lbu	a5,24(a5)
    80201d10:	873e                	mv	a4,a5
    80201d12:	4785                	li	a5,1
    80201d14:	00f71b63          	bne	a4,a5,80201d2a <elf_program_get_vaddr+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:51
    addr = (uint64_t)program->header->_32.p_vaddr;
    80201d18:	fd043783          	ld	a5,-48(s0)
    80201d1c:	639c                	ld	a5,0(a5)
    80201d1e:	479c                	lw	a5,8(a5)
    80201d20:	1782                	slli	a5,a5,0x20
    80201d22:	9381                	srli	a5,a5,0x20
    80201d24:	fef43423          	sd	a5,-24(s0)
    80201d28:	a039                	j	80201d36 <elf_program_get_vaddr+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:53
  else
    addr = (uint64_t)program->header->_64.p_vaddr;
    80201d2a:	fd043783          	ld	a5,-48(s0)
    80201d2e:	639c                	ld	a5,0(a5)
    80201d30:	6b9c                	ld	a5,16(a5)
    80201d32:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:54
  return (addr);
    80201d36:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:55
}
    80201d3a:	853e                	mv	a0,a5
    80201d3c:	7422                	ld	s0,40(sp)
    80201d3e:	6145                	addi	sp,sp,48
    80201d40:	8082                	ret

0000000080201d42 <elf_program_get_memsz>:
elf_program_get_memsz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:60

/*
** Get the memory size of the program
*/
uint64_t elf_program_get_memsz(t_elf *elf, t_elf_program *program) {
    80201d42:	7179                	addi	sp,sp,-48
    80201d44:	f422                	sd	s0,40(sp)
    80201d46:	1800                	addi	s0,sp,48
    80201d48:	fca43c23          	sd	a0,-40(s0)
    80201d4c:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:63
  uint64_t addr;

  if (ELF_IS_32(elf))
    80201d50:	fd843783          	ld	a5,-40(s0)
    80201d54:	0187c783          	lbu	a5,24(a5)
    80201d58:	873e                	mv	a4,a5
    80201d5a:	4785                	li	a5,1
    80201d5c:	00f71b63          	bne	a4,a5,80201d72 <elf_program_get_memsz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:64
    addr = (uint64_t)program->header->_32.p_memsz;
    80201d60:	fd043783          	ld	a5,-48(s0)
    80201d64:	639c                	ld	a5,0(a5)
    80201d66:	4bdc                	lw	a5,20(a5)
    80201d68:	1782                	slli	a5,a5,0x20
    80201d6a:	9381                	srli	a5,a5,0x20
    80201d6c:	fef43423          	sd	a5,-24(s0)
    80201d70:	a039                	j	80201d7e <elf_program_get_memsz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:66
  else
    addr = (uint64_t)program->header->_64.p_memsz;
    80201d72:	fd043783          	ld	a5,-48(s0)
    80201d76:	639c                	ld	a5,0(a5)
    80201d78:	779c                	ld	a5,40(a5)
    80201d7a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:67
  return (addr);
    80201d7e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:68
}
    80201d82:	853e                	mv	a0,a5
    80201d84:	7422                	ld	s0,40(sp)
    80201d86:	6145                	addi	sp,sp,48
    80201d88:	8082                	ret

0000000080201d8a <elf_program_get_filesz>:
elf_program_get_filesz():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:73

/*
** Get the file size of the program
*/
uint64_t elf_program_get_filesz(t_elf *elf, t_elf_program *program) {
    80201d8a:	7179                	addi	sp,sp,-48
    80201d8c:	f422                	sd	s0,40(sp)
    80201d8e:	1800                	addi	s0,sp,48
    80201d90:	fca43c23          	sd	a0,-40(s0)
    80201d94:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:76
  uint64_t addr;

  if (ELF_IS_32(elf))
    80201d98:	fd843783          	ld	a5,-40(s0)
    80201d9c:	0187c783          	lbu	a5,24(a5)
    80201da0:	873e                	mv	a4,a5
    80201da2:	4785                	li	a5,1
    80201da4:	00f71b63          	bne	a4,a5,80201dba <elf_program_get_filesz+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:77
    addr = (uint64_t)program->header->_32.p_filesz;
    80201da8:	fd043783          	ld	a5,-48(s0)
    80201dac:	639c                	ld	a5,0(a5)
    80201dae:	4b9c                	lw	a5,16(a5)
    80201db0:	1782                	slli	a5,a5,0x20
    80201db2:	9381                	srli	a5,a5,0x20
    80201db4:	fef43423          	sd	a5,-24(s0)
    80201db8:	a039                	j	80201dc6 <elf_program_get_filesz+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:79
  else
    addr = (uint64_t)program->header->_64.p_filesz;
    80201dba:	fd043783          	ld	a5,-48(s0)
    80201dbe:	639c                	ld	a5,0(a5)
    80201dc0:	739c                	ld	a5,32(a5)
    80201dc2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:80
  return (addr);
    80201dc6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_program_get.c:81
}
    80201dca:	853e                	mv	a0,a5
    80201dcc:	7422                	ld	s0,40(sp)
    80201dce:	6145                	addi	sp,sp,48
    80201dd0:	8082                	ret

0000000080201dd2 <elf_load_ident>:
elf_load_ident():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:17
#include "elfparse.h"
#include "string.h"
/*
** Load the identity of the file.
*/
static int elf_load_ident(t_elf *elf) {
    80201dd2:	1101                	addi	sp,sp,-32
    80201dd4:	ec06                	sd	ra,24(sp)
    80201dd6:	e822                	sd	s0,16(sp)
    80201dd8:	1000                	addi	s0,sp,32
    80201dda:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:18
  if (elf->size < EI_NIDENT || memcmp(elf->raw_data, ELFMAG, 4)) {
    80201dde:	fe843783          	ld	a5,-24(s0)
    80201de2:	6398                	ld	a4,0(a5)
    80201de4:	47bd                	li	a5,15
    80201de6:	00e7ff63          	bgeu	a5,a4,80201e04 <elf_load_ident+0x32>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:18 (discriminator 1)
    80201dea:	fe843783          	ld	a5,-24(s0)
    80201dee:	679c                	ld	a5,8(a5)
    80201df0:	4611                	li	a2,4
    80201df2:	00004597          	auipc	a1,0x4
    80201df6:	2ae58593          	addi	a1,a1,686 # 802060a0 <rodata_start+0xa0>
    80201dfa:	853e                	mv	a0,a5
    80201dfc:	175000ef          	jal	ra,80202770 <memcmp>
    80201e00:	87aa                	mv	a5,a0
    80201e02:	c399                	beqz	a5,80201e08 <elf_load_ident+0x36>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:19
    return (-1);
    80201e04:	57fd                	li	a5,-1
    80201e06:	a801                	j	80201e16 <elf_load_ident+0x44>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:21
  }
  elf->ident = elf->raw_data;
    80201e08:	fe843783          	ld	a5,-24(s0)
    80201e0c:	6798                	ld	a4,8(a5)
    80201e0e:	fe843783          	ld	a5,-24(s0)
    80201e12:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:22
  return (0);
    80201e14:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:23
}
    80201e16:	853e                	mv	a0,a5
    80201e18:	60e2                	ld	ra,24(sp)
    80201e1a:	6442                	ld	s0,16(sp)
    80201e1c:	6105                	addi	sp,sp,32
    80201e1e:	8082                	ret

0000000080201e20 <elf_load_header>:
elf_load_header():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:30
/*
** Load the elf header in the elf structure.
** The identity is loaded first. Then, when the file class has been
** reconized, the entire header is loaded in the field 'elf->header'
*/
int elf_load_header(t_elf *elf) {
    80201e20:	1101                	addi	sp,sp,-32
    80201e22:	ec06                	sd	ra,24(sp)
    80201e24:	e822                	sd	s0,16(sp)
    80201e26:	1000                	addi	s0,sp,32
    80201e28:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:31
  if (elf_load_ident(elf) == -1)
    80201e2c:	fe843503          	ld	a0,-24(s0)
    80201e30:	fa3ff0ef          	jal	ra,80201dd2 <elf_load_ident>
    80201e34:	87aa                	mv	a5,a0
    80201e36:	873e                	mv	a4,a5
    80201e38:	57fd                	li	a5,-1
    80201e3a:	00f71463          	bne	a4,a5,80201e42 <elf_load_header+0x22>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:32
    return (-1);
    80201e3e:	57fd                	li	a5,-1
    80201e40:	a059                	j	80201ec6 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:33
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80201e42:	fe843783          	ld	a5,-24(s0)
    80201e46:	6b9c                	ld	a5,16(a5)
    80201e48:	0047c703          	lbu	a4,4(a5)
    80201e4c:	fe843783          	ld	a5,-24(s0)
    80201e50:	00e78c23          	sb	a4,24(a5)
    80201e54:	fe843783          	ld	a5,-24(s0)
    80201e58:	0187c783          	lbu	a5,24(a5)
    80201e5c:	873e                	mv	a4,a5
    80201e5e:	4785                	li	a5,1
    80201e60:	00f70c63          	beq	a4,a5,80201e78 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:34 (discriminator 1)
      elf->class != ELFCLASS64) {
    80201e64:	fe843783          	ld	a5,-24(s0)
    80201e68:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:33 (discriminator 1)
  if ((elf->class = elf->ident[EI_CLASS]) != ELFCLASS32 &&
    80201e6c:	873e                	mv	a4,a5
    80201e6e:	4789                	li	a5,2
    80201e70:	00f70463          	beq	a4,a5,80201e78 <elf_load_header+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:35
    return (-1);
    80201e74:	57fd                	li	a5,-1
    80201e76:	a881                	j	80201ec6 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:37
  }
  elf->header = (t_elf_header *)elf->raw_data;
    80201e78:	fe843783          	ld	a5,-24(s0)
    80201e7c:	6798                	ld	a4,8(a5)
    80201e7e:	fe843783          	ld	a5,-24(s0)
    80201e82:	f398                	sd	a4,32(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:38
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80201e84:	fe843783          	ld	a5,-24(s0)
    80201e88:	0187c783          	lbu	a5,24(a5)
    80201e8c:	873e                	mv	a4,a5
    80201e8e:	4785                	li	a5,1
    80201e90:	00f71963          	bne	a4,a5,80201ea2 <elf_load_header+0x82>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:38 (discriminator 1)
    80201e94:	fe843783          	ld	a5,-24(s0)
    80201e98:	6398                	ld	a4,0(a5)
    80201e9a:	03300793          	li	a5,51
    80201e9e:	02e7f163          	bgeu	a5,a4,80201ec0 <elf_load_header+0xa0>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:39 (discriminator 3)
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80201ea2:	fe843783          	ld	a5,-24(s0)
    80201ea6:	0187c783          	lbu	a5,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:38 (discriminator 3)
  if ((elf->class == ELFCLASS32 && elf->size < sizeof(Elf32_Ehdr)) ||
    80201eaa:	873e                	mv	a4,a5
    80201eac:	4789                	li	a5,2
    80201eae:	00f71b63          	bne	a4,a5,80201ec4 <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:39
      (elf->class == ELFCLASS64 && elf->size < sizeof(Elf64_Ehdr))) {
    80201eb2:	fe843783          	ld	a5,-24(s0)
    80201eb6:	6398                	ld	a4,0(a5)
    80201eb8:	03f00793          	li	a5,63
    80201ebc:	00e7e463          	bltu	a5,a4,80201ec4 <elf_load_header+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:40
    return (-1);
    80201ec0:	57fd                	li	a5,-1
    80201ec2:	a011                	j	80201ec6 <elf_load_header+0xa6>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:42
  }
  return (0);
    80201ec4:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_header.c:43
}
    80201ec6:	853e                	mv	a0,a5
    80201ec8:	60e2                	ld	ra,24(sp)
    80201eca:	6442                	ld	s0,16(sp)
    80201ecc:	6105                	addi	sp,sp,32
    80201ece:	8082                	ret

0000000080201ed0 <elf_load>:
elf_load():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:10
/*
** Load the elf file present in the buffer.
** This function is used to parse elf file contained in a static library
** archive.
*/
int elf_load(uint8_t *elf_data, size_t elf_size, t_elf *elf) {
    80201ed0:	7179                	addi	sp,sp,-48
    80201ed2:	f406                	sd	ra,40(sp)
    80201ed4:	f022                	sd	s0,32(sp)
    80201ed6:	1800                	addi	s0,sp,48
    80201ed8:	fea43423          	sd	a0,-24(s0)
    80201edc:	feb43023          	sd	a1,-32(s0)
    80201ee0:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:11
  memset(elf, 0, sizeof(t_elf));
    80201ee4:	6785                	lui	a5,0x1
    80201ee6:	82878613          	addi	a2,a5,-2008 # 828 <n+0x808>
    80201eea:	4581                	li	a1,0
    80201eec:	fd843503          	ld	a0,-40(s0)
    80201ef0:	049000ef          	jal	ra,80202738 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:12
  elf->size = elf_size;
    80201ef4:	fd843783          	ld	a5,-40(s0)
    80201ef8:	fe043703          	ld	a4,-32(s0)
    80201efc:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:13
  elf->raw_data = elf_data;
    80201efe:	fd843783          	ld	a5,-40(s0)
    80201f02:	fe843703          	ld	a4,-24(s0)
    80201f06:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:15

  if (elf_load_header(elf) != 0) {
    80201f08:	fd843503          	ld	a0,-40(s0)
    80201f0c:	f15ff0ef          	jal	ra,80201e20 <elf_load_header>
    80201f10:	87aa                	mv	a5,a0
    80201f12:	c399                	beqz	a5,80201f18 <elf_load+0x48>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:16
    return -1;
    80201f14:	57fd                	li	a5,-1
    80201f16:	a015                	j	80201f3a <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:19
  }

  if (elf_load_sections(elf) != 0) {
    80201f18:	fd843503          	ld	a0,-40(s0)
    80201f1c:	b5fff0ef          	jal	ra,80201a7a <elf_load_sections>
    80201f20:	87aa                	mv	a5,a0
    80201f22:	c399                	beqz	a5,80201f28 <elf_load+0x58>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:20
    return -1;
    80201f24:	57fd                	li	a5,-1
    80201f26:	a811                	j	80201f3a <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:23
  }

  if (elf_load_programs(elf) != 0) {
    80201f28:	fd843503          	ld	a0,-40(s0)
    80201f2c:	29c000ef          	jal	ra,802021c8 <elf_load_programs>
    80201f30:	87aa                	mv	a5,a0
    80201f32:	c399                	beqz	a5,80201f38 <elf_load+0x68>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:24
    return -1;
    80201f34:	57fd                	li	a5,-1
    80201f36:	a011                	j	80201f3a <elf_load+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:27
  }

  return 0;
    80201f38:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load.c:28
}
    80201f3a:	853e                	mv	a0,a5
    80201f3c:	70a2                	ld	ra,40(sp)
    80201f3e:	7402                	ld	s0,32(sp)
    80201f40:	6145                	addi	sp,sp,48
    80201f42:	8082                	ret

0000000080201f44 <elf_section_get_type>:
elf_section_get_type():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:17
#include "elfparse.h"

/*
** Get the section type.
*/
uint32_t elf_section_get_type(t_elf *elf, t_elf_section *section) {
    80201f44:	7179                	addi	sp,sp,-48
    80201f46:	f422                	sd	s0,40(sp)
    80201f48:	1800                	addi	s0,sp,48
    80201f4a:	fca43c23          	sd	a0,-40(s0)
    80201f4e:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:20
  uint32_t type;

  if (ELF_IS_32(elf))
    80201f52:	fd843783          	ld	a5,-40(s0)
    80201f56:	0187c783          	lbu	a5,24(a5)
    80201f5a:	873e                	mv	a4,a5
    80201f5c:	4785                	li	a5,1
    80201f5e:	00f71963          	bne	a4,a5,80201f70 <elf_section_get_type+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:21
    type = (uint32_t)section->header->_32.sh_type;
    80201f62:	fd043783          	ld	a5,-48(s0)
    80201f66:	639c                	ld	a5,0(a5)
    80201f68:	43dc                	lw	a5,4(a5)
    80201f6a:	fef42623          	sw	a5,-20(s0)
    80201f6e:	a039                	j	80201f7c <elf_section_get_type+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:23
  else
    type = (uint32_t)section->header->_64.sh_type;
    80201f70:	fd043783          	ld	a5,-48(s0)
    80201f74:	639c                	ld	a5,0(a5)
    80201f76:	43dc                	lw	a5,4(a5)
    80201f78:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:24
  return (type);
    80201f7c:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:25
}
    80201f80:	853e                	mv	a0,a5
    80201f82:	7422                	ld	s0,40(sp)
    80201f84:	6145                	addi	sp,sp,48
    80201f86:	8082                	ret

0000000080201f88 <elf_section_get_offset>:
elf_section_get_offset():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:30

/*
** Get the section offset (from the begin of the file)
*/
size_t elf_section_get_offset(t_elf *elf, t_elf_section *section) {
    80201f88:	7179                	addi	sp,sp,-48
    80201f8a:	f422                	sd	s0,40(sp)
    80201f8c:	1800                	addi	s0,sp,48
    80201f8e:	fca43c23          	sd	a0,-40(s0)
    80201f92:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:33
  size_t offset;

  if (ELF_IS_32(elf))
    80201f96:	fd843783          	ld	a5,-40(s0)
    80201f9a:	0187c783          	lbu	a5,24(a5)
    80201f9e:	873e                	mv	a4,a5
    80201fa0:	4785                	li	a5,1
    80201fa2:	00f71b63          	bne	a4,a5,80201fb8 <elf_section_get_offset+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:34
    offset = (size_t)section->header->_32.sh_offset;
    80201fa6:	fd043783          	ld	a5,-48(s0)
    80201faa:	639c                	ld	a5,0(a5)
    80201fac:	4b9c                	lw	a5,16(a5)
    80201fae:	1782                	slli	a5,a5,0x20
    80201fb0:	9381                	srli	a5,a5,0x20
    80201fb2:	fef43423          	sd	a5,-24(s0)
    80201fb6:	a039                	j	80201fc4 <elf_section_get_offset+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:36
  else
    offset = (size_t)section->header->_64.sh_offset;
    80201fb8:	fd043783          	ld	a5,-48(s0)
    80201fbc:	639c                	ld	a5,0(a5)
    80201fbe:	6f9c                	ld	a5,24(a5)
    80201fc0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:37
  return (offset);
    80201fc4:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:38
}
    80201fc8:	853e                	mv	a0,a5
    80201fca:	7422                	ld	s0,40(sp)
    80201fcc:	6145                	addi	sp,sp,48
    80201fce:	8082                	ret

0000000080201fd0 <elf_section_get_size>:
elf_section_get_size():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:43

/*
** Get the size of the section
*/
size_t elf_section_get_size(t_elf *elf, t_elf_section *section) {
    80201fd0:	7179                	addi	sp,sp,-48
    80201fd2:	f422                	sd	s0,40(sp)
    80201fd4:	1800                	addi	s0,sp,48
    80201fd6:	fca43c23          	sd	a0,-40(s0)
    80201fda:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:46
  size_t size;

  if (ELF_IS_32(elf))
    80201fde:	fd843783          	ld	a5,-40(s0)
    80201fe2:	0187c783          	lbu	a5,24(a5)
    80201fe6:	873e                	mv	a4,a5
    80201fe8:	4785                	li	a5,1
    80201fea:	00f71b63          	bne	a4,a5,80202000 <elf_section_get_size+0x30>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:47
    size = (size_t)section->header->_32.sh_size;
    80201fee:	fd043783          	ld	a5,-48(s0)
    80201ff2:	639c                	ld	a5,0(a5)
    80201ff4:	4bdc                	lw	a5,20(a5)
    80201ff6:	1782                	slli	a5,a5,0x20
    80201ff8:	9381                	srli	a5,a5,0x20
    80201ffa:	fef43423          	sd	a5,-24(s0)
    80201ffe:	a039                	j	8020200c <elf_section_get_size+0x3c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:49
  else
    size = (size_t)section->header->_64.sh_size;
    80202000:	fd043783          	ld	a5,-48(s0)
    80202004:	639c                	ld	a5,0(a5)
    80202006:	739c                	ld	a5,32(a5)
    80202008:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:50
  return (size);
    8020200c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_section_get.c:51
}
    80202010:	853e                	mv	a0,a5
    80202012:	7422                	ld	s0,40(sp)
    80202014:	6145                	addi	sp,sp,48
    80202016:	8082                	ret

0000000080202018 <elf_header_get_phoff>:
elf_header_get_phoff():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:17
#include "elfparse.h"

/*
** Get the program header table offset
*/
size_t elf_header_get_phoff(t_elf *elf) {
    80202018:	7179                	addi	sp,sp,-48
    8020201a:	f422                	sd	s0,40(sp)
    8020201c:	1800                	addi	s0,sp,48
    8020201e:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:20
  size_t phoff;

  if (ELF_IS_32(elf))
    80202022:	fd843783          	ld	a5,-40(s0)
    80202026:	0187c783          	lbu	a5,24(a5)
    8020202a:	873e                	mv	a4,a5
    8020202c:	4785                	li	a5,1
    8020202e:	00f71b63          	bne	a4,a5,80202044 <elf_header_get_phoff+0x2c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:21
    phoff = (size_t)elf->header->_32.e_phoff;
    80202032:	fd843783          	ld	a5,-40(s0)
    80202036:	739c                	ld	a5,32(a5)
    80202038:	4fdc                	lw	a5,28(a5)
    8020203a:	1782                	slli	a5,a5,0x20
    8020203c:	9381                	srli	a5,a5,0x20
    8020203e:	fef43423          	sd	a5,-24(s0)
    80202042:	a039                	j	80202050 <elf_header_get_phoff+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:23
  else
    phoff = (size_t)elf->header->_64.e_phoff;
    80202044:	fd843783          	ld	a5,-40(s0)
    80202048:	739c                	ld	a5,32(a5)
    8020204a:	739c                	ld	a5,32(a5)
    8020204c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:24
  return (phoff);
    80202050:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:25
}
    80202054:	853e                	mv	a0,a5
    80202056:	7422                	ld	s0,40(sp)
    80202058:	6145                	addi	sp,sp,48
    8020205a:	8082                	ret

000000008020205c <elf_header_get_phentsize>:
elf_header_get_phentsize():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:30

/*
** Get the size of one program header
*/
size_t elf_header_get_phentsize(t_elf *elf) {
    8020205c:	7179                	addi	sp,sp,-48
    8020205e:	f422                	sd	s0,40(sp)
    80202060:	1800                	addi	s0,sp,48
    80202062:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:33
  size_t phentsize;

  if (ELF_IS_32(elf))
    80202066:	fd843783          	ld	a5,-40(s0)
    8020206a:	0187c783          	lbu	a5,24(a5)
    8020206e:	873e                	mv	a4,a5
    80202070:	4785                	li	a5,1
    80202072:	00f71a63          	bne	a4,a5,80202086 <elf_header_get_phentsize+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:34
    phentsize = (size_t)elf->header->_32.e_phentsize;
    80202076:	fd843783          	ld	a5,-40(s0)
    8020207a:	739c                	ld	a5,32(a5)
    8020207c:	02a7d783          	lhu	a5,42(a5)
    80202080:	fef43423          	sd	a5,-24(s0)
    80202084:	a801                	j	80202094 <elf_header_get_phentsize+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:36
  else
    phentsize = (size_t)elf->header->_64.e_phentsize;
    80202086:	fd843783          	ld	a5,-40(s0)
    8020208a:	739c                	ld	a5,32(a5)
    8020208c:	0367d783          	lhu	a5,54(a5)
    80202090:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:37
  return (phentsize);
    80202094:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:38
}
    80202098:	853e                	mv	a0,a5
    8020209a:	7422                	ld	s0,40(sp)
    8020209c:	6145                	addi	sp,sp,48
    8020209e:	8082                	ret

00000000802020a0 <elf_header_get_phnum>:
elf_header_get_phnum():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:43

/*
** Get the number of entry in the program header table
*/
size_t elf_header_get_phnum(t_elf *elf) {
    802020a0:	7179                	addi	sp,sp,-48
    802020a2:	f422                	sd	s0,40(sp)
    802020a4:	1800                	addi	s0,sp,48
    802020a6:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:46
  size_t phnum;

  if (ELF_IS_32(elf))
    802020aa:	fd843783          	ld	a5,-40(s0)
    802020ae:	0187c783          	lbu	a5,24(a5)
    802020b2:	873e                	mv	a4,a5
    802020b4:	4785                	li	a5,1
    802020b6:	00f71a63          	bne	a4,a5,802020ca <elf_header_get_phnum+0x2a>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:47
    phnum = (size_t)elf->header->_32.e_phnum;
    802020ba:	fd843783          	ld	a5,-40(s0)
    802020be:	739c                	ld	a5,32(a5)
    802020c0:	02c7d783          	lhu	a5,44(a5)
    802020c4:	fef43423          	sd	a5,-24(s0)
    802020c8:	a801                	j	802020d8 <elf_header_get_phnum+0x38>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:49
  else
    phnum = (size_t)elf->header->_64.e_phnum;
    802020ca:	fd843783          	ld	a5,-40(s0)
    802020ce:	739c                	ld	a5,32(a5)
    802020d0:	0387d783          	lhu	a5,56(a5)
    802020d4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:50
  return (phnum);
    802020d8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_header_get_ph.c:51
}
    802020dc:	853e                	mv	a0,a5
    802020de:	7422                	ld	s0,40(sp)
    802020e0:	6145                	addi	sp,sp,48
    802020e2:	8082                	ret

00000000802020e4 <elf_load_programs_loop>:
elf_load_programs_loop():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:9

/*
** traverse the program header table and load each segment
*/
static int elf_load_programs_loop(t_elf *elf, size_t phoff, size_t phnum,
                                  size_t phentsize) {
    802020e4:	715d                	addi	sp,sp,-80
    802020e6:	e486                	sd	ra,72(sp)
    802020e8:	e0a2                	sd	s0,64(sp)
    802020ea:	0880                	addi	s0,sp,80
    802020ec:	fca43423          	sd	a0,-56(s0)
    802020f0:	fcb43023          	sd	a1,-64(s0)
    802020f4:	fac43c23          	sd	a2,-72(s0)
    802020f8:	fad43823          	sd	a3,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:14
  size_t i;
  size_t content_offset;
  uint32_t type;

  i = 0;
    802020fc:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    80202100:	a845                	j	802021b0 <elf_load_programs_loop+0xcc>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:16
    if (i >= MAX_PROGRAM_NUM) {
    80202102:	fe843703          	ld	a4,-24(s0)
    80202106:	03f00793          	li	a5,63
    8020210a:	00e7f463          	bgeu	a5,a4,80202112 <elf_load_programs_loop+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:17
      return (-1);
    8020210e:	57fd                	li	a5,-1
    80202110:	a07d                	j	802021be <elf_load_programs_loop+0xda>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:20
    }
    elf->programs[i].header =
        (union u_elf_ph *)(elf->raw_data + phoff + i * phentsize);
    80202112:	fc843783          	ld	a5,-56(s0)
    80202116:	6798                	ld	a4,8(a5)
    80202118:	fe843683          	ld	a3,-24(s0)
    8020211c:	fb043783          	ld	a5,-80(s0)
    80202120:	02f686b3          	mul	a3,a3,a5
    80202124:	fc043783          	ld	a5,-64(s0)
    80202128:	97b6                	add	a5,a5,a3
    8020212a:	973e                	add	a4,a4,a5
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:19
    elf->programs[i].header =
    8020212c:	fc843683          	ld	a3,-56(s0)
    80202130:	fe843783          	ld	a5,-24(s0)
    80202134:	04278793          	addi	a5,a5,66
    80202138:	0792                	slli	a5,a5,0x4
    8020213a:	97b6                	add	a5,a5,a3
    8020213c:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:21
    type = elf_program_get_type(elf, &elf->programs[i]);
    8020213e:	fe843783          	ld	a5,-24(s0)
    80202142:	04278793          	addi	a5,a5,66
    80202146:	0792                	slli	a5,a5,0x4
    80202148:	fc843703          	ld	a4,-56(s0)
    8020214c:	97ba                	add	a5,a5,a4
    8020214e:	07a1                	addi	a5,a5,8
    80202150:	85be                	mv	a1,a5
    80202152:	fc843503          	ld	a0,-56(s0)
    80202156:	acdff0ef          	jal	ra,80201c22 <elf_program_get_type>
    8020215a:	87aa                	mv	a5,a0
    8020215c:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:22
    if (type != PT_NULL) {
    80202160:	fe442783          	lw	a5,-28(s0)
    80202164:	2781                	sext.w	a5,a5
    80202166:	c3a1                	beqz	a5,802021a6 <elf_load_programs_loop+0xc2>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:23
      content_offset = elf_program_get_offset(elf, &elf->programs[i]);
    80202168:	fe843783          	ld	a5,-24(s0)
    8020216c:	04278793          	addi	a5,a5,66
    80202170:	0792                	slli	a5,a5,0x4
    80202172:	fc843703          	ld	a4,-56(s0)
    80202176:	97ba                	add	a5,a5,a4
    80202178:	07a1                	addi	a5,a5,8
    8020217a:	85be                	mv	a1,a5
    8020217c:	fc843503          	ld	a0,-56(s0)
    80202180:	ae7ff0ef          	jal	ra,80201c66 <elf_program_get_offset>
    80202184:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:24
      elf->programs[i].content = elf->raw_data + content_offset;
    80202188:	fc843783          	ld	a5,-56(s0)
    8020218c:	6798                	ld	a4,8(a5)
    8020218e:	fd843783          	ld	a5,-40(s0)
    80202192:	973e                	add	a4,a4,a5
    80202194:	fc843683          	ld	a3,-56(s0)
    80202198:	fe843783          	ld	a5,-24(s0)
    8020219c:	04278793          	addi	a5,a5,66
    802021a0:	0792                	slli	a5,a5,0x4
    802021a2:	97b6                	add	a5,a5,a3
    802021a4:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:26
    }
    i++;
    802021a6:	fe843783          	ld	a5,-24(s0)
    802021aa:	0785                	addi	a5,a5,1
    802021ac:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:15
  while (i < phnum) {
    802021b0:	fe843703          	ld	a4,-24(s0)
    802021b4:	fb843783          	ld	a5,-72(s0)
    802021b8:	f4f765e3          	bltu	a4,a5,80202102 <elf_load_programs_loop+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:28
  }
  return (0);
    802021bc:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:29
}
    802021be:	853e                	mv	a0,a5
    802021c0:	60a6                	ld	ra,72(sp)
    802021c2:	6406                	ld	s0,64(sp)
    802021c4:	6161                	addi	sp,sp,80
    802021c6:	8082                	ret

00000000802021c8 <elf_load_programs>:
elf_load_programs():
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:35

/*
** Load programs. Create a table of t_elf_program in elf->programs.
** This table is null if there is no program header table.
*/
int elf_load_programs(t_elf *elf) {
    802021c8:	7139                	addi	sp,sp,-64
    802021ca:	fc06                	sd	ra,56(sp)
    802021cc:	f822                	sd	s0,48(sp)
    802021ce:	0080                	addi	s0,sp,64
    802021d0:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:40
  size_t phoff;
  size_t phnum;
  size_t phentsize;

  if ((phoff = elf_header_get_phoff(elf)) > 0) {
    802021d4:	fc843503          	ld	a0,-56(s0)
    802021d8:	e41ff0ef          	jal	ra,80202018 <elf_header_get_phoff>
    802021dc:	fea43423          	sd	a0,-24(s0)
    802021e0:	fe843783          	ld	a5,-24(s0)
    802021e4:	cfb1                	beqz	a5,80202240 <elf_load_programs+0x78>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:41
    phnum = elf_header_get_phnum(elf);
    802021e6:	fc843503          	ld	a0,-56(s0)
    802021ea:	eb7ff0ef          	jal	ra,802020a0 <elf_header_get_phnum>
    802021ee:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:42
    phentsize = elf_header_get_phentsize(elf);
    802021f2:	fc843503          	ld	a0,-56(s0)
    802021f6:	e67ff0ef          	jal	ra,8020205c <elf_header_get_phentsize>
    802021fa:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:43
    if (phoff + phnum * phentsize > elf->size) {
    802021fe:	fe043703          	ld	a4,-32(s0)
    80202202:	fd843783          	ld	a5,-40(s0)
    80202206:	02f70733          	mul	a4,a4,a5
    8020220a:	fe843783          	ld	a5,-24(s0)
    8020220e:	973e                	add	a4,a4,a5
    80202210:	fc843783          	ld	a5,-56(s0)
    80202214:	639c                	ld	a5,0(a5)
    80202216:	00e7f463          	bgeu	a5,a4,8020221e <elf_load_programs+0x56>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:44
      return (-1);
    8020221a:	57fd                	li	a5,-1
    8020221c:	a82d                	j	80202256 <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:46
    }
    if (elf_load_programs_loop(elf, phoff, phnum, phentsize) == -1) {
    8020221e:	fd843683          	ld	a3,-40(s0)
    80202222:	fe043603          	ld	a2,-32(s0)
    80202226:	fe843583          	ld	a1,-24(s0)
    8020222a:	fc843503          	ld	a0,-56(s0)
    8020222e:	eb7ff0ef          	jal	ra,802020e4 <elf_load_programs_loop>
    80202232:	87aa                	mv	a5,a0
    80202234:	873e                	mv	a4,a5
    80202236:	57fd                	li	a5,-1
    80202238:	00f71e63          	bne	a4,a5,80202254 <elf_load_programs+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:47
      return (-1);
    8020223c:	57fd                	li	a5,-1
    8020223e:	a821                	j	80202256 <elf_load_programs+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:50
    }
  } else
    memset(elf->programs, 0, MAX_PROGRAM_NUM * sizeof(t_elf_program));
    80202240:	fc843783          	ld	a5,-56(s0)
    80202244:	42878793          	addi	a5,a5,1064
    80202248:	40000613          	li	a2,1024
    8020224c:	4581                	li	a1,0
    8020224e:	853e                	mv	a0,a5
    80202250:	4e8000ef          	jal	ra,80202738 <memset>
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:51
  return (0);
    80202254:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/elf/elf_load_programs.c:52
}
    80202256:	853e                	mv	a0,a5
    80202258:	70e2                	ld	ra,56(sp)
    8020225a:	7442                	ld	s0,48(sp)
    8020225c:	6121                	addi	sp,sp,64
    8020225e:	8082                	ret

0000000080202260 <sbi_call>:
sbi_call():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:16
#define SBI_REMOTE_SFENCE_VMA 6
#define SBI_REMOTE_SFENCE_VMA_ASID 7
#define SBI_SHUTDOWN 8


static inline uint64_t sbi_call(long which, long arg0, long arg1, long arg2) {
    80202260:	7179                	addi	sp,sp,-48
    80202262:	f422                	sd	s0,40(sp)
    80202264:	1800                	addi	s0,sp,48
    80202266:	fea43423          	sd	a0,-24(s0)
    8020226a:	feb43023          	sd	a1,-32(s0)
    8020226e:	fcc43c23          	sd	a2,-40(s0)
    80202272:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:17
    register long a0 asm("a0") = arg0;
    80202276:	fe043503          	ld	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:18
    register long a1 asm("a1") = arg1;
    8020227a:	fd843583          	ld	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:19
    register long a2 asm("a2") = arg2;
    8020227e:	fd043603          	ld	a2,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:20
    register long a7 asm("a7") = which;
    80202282:	fe843883          	ld	a7,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:22

    asm volatile("ecall"
    80202286:	00000073          	ecall
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:27
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");

    return a0;
    8020228a:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:28
}
    8020228c:	853e                	mv	a0,a5
    8020228e:	7422                	ld	s0,40(sp)
    80202290:	6145                	addi	sp,sp,48
    80202292:	8082                	ret

0000000080202294 <console_putchar>:
console_putchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:30

void console_putchar(uint64_t ch) {
    80202294:	1101                	addi	sp,sp,-32
    80202296:	ec06                	sd	ra,24(sp)
    80202298:	e822                	sd	s0,16(sp)
    8020229a:	1000                	addi	s0,sp,32
    8020229c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:31
    sbi_call(0x01, ch, 0, 0);
    802022a0:	fe843783          	ld	a5,-24(s0)
    802022a4:	4681                	li	a3,0
    802022a6:	4601                	li	a2,0
    802022a8:	85be                	mv	a1,a5
    802022aa:	4505                	li	a0,1
    802022ac:	fb5ff0ef          	jal	ra,80202260 <sbi_call>
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:32
}
    802022b0:	0001                	nop
    802022b2:	60e2                	ld	ra,24(sp)
    802022b4:	6442                	ld	s0,16(sp)
    802022b6:	6105                	addi	sp,sp,32
    802022b8:	8082                	ret

00000000802022ba <console_getchar>:
console_getchar():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:34

uint64_t console_getchar(void) {
    802022ba:	1141                	addi	sp,sp,-16
    802022bc:	e406                	sd	ra,8(sp)
    802022be:	e022                	sd	s0,0(sp)
    802022c0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:35
    return sbi_call(0x02, 0, 0, 0);
    802022c2:	4681                	li	a3,0
    802022c4:	4601                	li	a2,0
    802022c6:	4581                	li	a1,0
    802022c8:	4509                	li	a0,2
    802022ca:	f97ff0ef          	jal	ra,80202260 <sbi_call>
    802022ce:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:36
}
    802022d0:	853e                	mv	a0,a5
    802022d2:	60a2                	ld	ra,8(sp)
    802022d4:	6402                	ld	s0,0(sp)
    802022d6:	0141                	addi	sp,sp,16
    802022d8:	8082                	ret

00000000802022da <sbi_shutdown>:
sbi_shutdown():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:38

uint64_t sbi_shutdown(void) {
    802022da:	1141                	addi	sp,sp,-16
    802022dc:	e406                	sd	ra,8(sp)
    802022de:	e022                	sd	s0,0(sp)
    802022e0:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:39
    return sbi_call(0x08, 0, 0, 0);
    802022e2:	4681                	li	a3,0
    802022e4:	4601                	li	a2,0
    802022e6:	4581                	li	a1,0
    802022e8:	4521                	li	a0,8
    802022ea:	f77ff0ef          	jal	ra,80202260 <sbi_call>
    802022ee:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:40
}
    802022f0:	853e                	mv	a0,a5
    802022f2:	60a2                	ld	ra,8(sp)
    802022f4:	6402                	ld	s0,0(sp)
    802022f6:	0141                	addi	sp,sp,16
    802022f8:	8082                	ret

00000000802022fa <sbi_set_timer>:
sbi_set_timer():
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:43

uint64_t sbi_set_timer(uint64_t stime_value)
{
    802022fa:	1101                	addi	sp,sp,-32
    802022fc:	ec06                	sd	ra,24(sp)
    802022fe:	e822                	sd	s0,16(sp)
    80202300:	1000                	addi	s0,sp,32
    80202302:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:44
    return sbi_call(0x00,stime_value,0,0);
    80202306:	fe843783          	ld	a5,-24(s0)
    8020230a:	4681                	li	a3,0
    8020230c:	4601                	li	a2,0
    8020230e:	85be                	mv	a1,a5
    80202310:	4501                	li	a0,0
    80202312:	f4fff0ef          	jal	ra,80202260 <sbi_call>
    80202316:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/sbi/sbi.c:45
    80202318:	853e                	mv	a0,a5
    8020231a:	60e2                	ld	ra,24(sp)
    8020231c:	6442                	ld	s0,16(sp)
    8020231e:	6105                	addi	sp,sp,32
    80202320:	8082                	ret

0000000080202322 <strlen_t>:
strlen_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:6

#include "string.h"


int strlen_t(const char *src)
{
    80202322:	7179                	addi	sp,sp,-48
    80202324:	f422                	sd	s0,40(sp)
    80202326:	1800                	addi	s0,sp,48
    80202328:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8
    int i;
    for (i = 0; src[i] != '\0'; i++) {
    8020232c:	fe042623          	sw	zero,-20(s0)
    80202330:	a031                	j	8020233c <strlen_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 3)
    80202332:	fec42783          	lw	a5,-20(s0)
    80202336:	2785                	addiw	a5,a5,1
    80202338:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:8 (discriminator 1)
    8020233c:	fec42783          	lw	a5,-20(s0)
    80202340:	fd843703          	ld	a4,-40(s0)
    80202344:	97ba                	add	a5,a5,a4
    80202346:	0007c783          	lbu	a5,0(a5)
    8020234a:	f7e5                	bnez	a5,80202332 <strlen_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:10
    }
    return i;
    8020234c:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:11
}
    80202350:	853e                	mv	a0,a5
    80202352:	7422                	ld	s0,40(sp)
    80202354:	6145                	addi	sp,sp,48
    80202356:	8082                	ret

0000000080202358 <memcpy_t>:
memcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:14

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    80202358:	7179                	addi	sp,sp,-48
    8020235a:	f422                	sd	s0,40(sp)
    8020235c:	1800                	addi	s0,sp,48
    8020235e:	fea43423          	sd	a0,-24(s0)
    80202362:	feb43023          	sd	a1,-32(s0)
    80202366:	87b2                	mv	a5,a2
    80202368:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15
    for (; len != 0; len--) {
    8020236c:	a035                	j	80202398 <memcpy_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:16 (discriminator 2)
        *dest++ = *src++;
    8020236e:	fe043703          	ld	a4,-32(s0)
    80202372:	00170793          	addi	a5,a4,1
    80202376:	fef43023          	sd	a5,-32(s0)
    8020237a:	fe843783          	ld	a5,-24(s0)
    8020237e:	00178693          	addi	a3,a5,1
    80202382:	fed43423          	sd	a3,-24(s0)
    80202386:	00074703          	lbu	a4,0(a4)
    8020238a:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 2)
    for (; len != 0; len--) {
    8020238e:	fdc42783          	lw	a5,-36(s0)
    80202392:	37fd                	addiw	a5,a5,-1
    80202394:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:15 (discriminator 1)
    80202398:	fdc42783          	lw	a5,-36(s0)
    8020239c:	2781                	sext.w	a5,a5
    8020239e:	fbe1                	bnez	a5,8020236e <memcpy_t+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:18
    }
}
    802023a0:	0001                	nop
    802023a2:	0001                	nop
    802023a4:	7422                	ld	s0,40(sp)
    802023a6:	6145                	addi	sp,sp,48
    802023a8:	8082                	ret

00000000802023aa <memcmp_t>:
memcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:21

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    802023aa:	7139                	addi	sp,sp,-64
    802023ac:	fc22                	sd	s0,56(sp)
    802023ae:	0080                	addi	s0,sp,64
    802023b0:	fca43c23          	sd	a0,-40(s0)
    802023b4:	fcb43823          	sd	a1,-48(s0)
    802023b8:	87b2                	mv	a5,a2
    802023ba:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22
    for (int i = 0; i < num; ++i) {
    802023be:	fe042623          	sw	zero,-20(s0)
    802023c2:	a8a1                	j	8020241a <memcmp_t+0x70>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:23
        if (((char*)ptr1)[i] != ((char*)ptr2)[i]) {
    802023c4:	fec42783          	lw	a5,-20(s0)
    802023c8:	fd843703          	ld	a4,-40(s0)
    802023cc:	97ba                	add	a5,a5,a4
    802023ce:	0007c683          	lbu	a3,0(a5)
    802023d2:	fec42783          	lw	a5,-20(s0)
    802023d6:	fd043703          	ld	a4,-48(s0)
    802023da:	97ba                	add	a5,a5,a4
    802023dc:	0007c783          	lbu	a5,0(a5)
    802023e0:	8736                	mv	a4,a3
    802023e2:	02f70763          	beq	a4,a5,80202410 <memcmp_t+0x66>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:24
            return ((char*)ptr1)[i] - ((char*)ptr2)[i];
    802023e6:	fec42783          	lw	a5,-20(s0)
    802023ea:	fd843703          	ld	a4,-40(s0)
    802023ee:	97ba                	add	a5,a5,a4
    802023f0:	0007c783          	lbu	a5,0(a5)
    802023f4:	0007871b          	sext.w	a4,a5
    802023f8:	fec42783          	lw	a5,-20(s0)
    802023fc:	fd043683          	ld	a3,-48(s0)
    80202400:	97b6                	add	a5,a5,a3
    80202402:	0007c783          	lbu	a5,0(a5)
    80202406:	2781                	sext.w	a5,a5
    80202408:	40f707bb          	subw	a5,a4,a5
    8020240c:	2781                	sext.w	a5,a5
    8020240e:	a831                	j	8020242a <memcmp_t+0x80>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 2)
    for (int i = 0; i < num; ++i) {
    80202410:	fec42783          	lw	a5,-20(s0)
    80202414:	2785                	addiw	a5,a5,1
    80202416:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:22 (discriminator 1)
    8020241a:	fec42703          	lw	a4,-20(s0)
    8020241e:	fcc42783          	lw	a5,-52(s0)
    80202422:	2781                	sext.w	a5,a5
    80202424:	faf760e3          	bltu	a4,a5,802023c4 <memcmp_t+0x1a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:27
        }
    }
    return 0;
    80202428:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:28
}
    8020242a:	853e                	mv	a0,a5
    8020242c:	7462                	ld	s0,56(sp)
    8020242e:	6121                	addi	sp,sp,64
    80202430:	8082                	ret

0000000080202432 <memmove_t>:
memmove_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:31

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    80202432:	715d                	addi	sp,sp,-80
    80202434:	e4a2                	sd	s0,72(sp)
    80202436:	0880                	addi	s0,sp,80
    80202438:	fca43423          	sd	a0,-56(s0)
    8020243c:	fcb43023          	sd	a1,-64(s0)
    80202440:	86b2                	mv	a3,a2
    80202442:	fad42e23          	sw	a3,-68(s0)
    80202446:	868a                	mv	a3,sp
    80202448:	85b6                	mv	a1,a3
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:32
    u8 temp[len];
    8020244a:	fbc42683          	lw	a3,-68(s0)
    8020244e:	02069613          	slli	a2,a3,0x20
    80202452:	9201                	srli	a2,a2,0x20
    80202454:	167d                	addi	a2,a2,-1
    80202456:	fec43423          	sd	a2,-24(s0)
    8020245a:	02069613          	slli	a2,a3,0x20
    8020245e:	9201                	srli	a2,a2,0x20
    80202460:	8e32                	mv	t3,a2
    80202462:	4e81                	li	t4,0
    80202464:	03de5613          	srli	a2,t3,0x3d
    80202468:	003e9893          	slli	a7,t4,0x3
    8020246c:	011668b3          	or	a7,a2,a7
    80202470:	003e1813          	slli	a6,t3,0x3
    80202474:	02069613          	slli	a2,a3,0x20
    80202478:	9201                	srli	a2,a2,0x20
    8020247a:	8332                	mv	t1,a2
    8020247c:	4381                	li	t2,0
    8020247e:	03d35613          	srli	a2,t1,0x3d
    80202482:	00339793          	slli	a5,t2,0x3
    80202486:	8fd1                	or	a5,a5,a2
    80202488:	00331713          	slli	a4,t1,0x3
    8020248c:	02069793          	slli	a5,a3,0x20
    80202490:	9381                	srli	a5,a5,0x20
    80202492:	07bd                	addi	a5,a5,15
    80202494:	8391                	srli	a5,a5,0x4
    80202496:	0792                	slli	a5,a5,0x4
    80202498:	40f10133          	sub	sp,sp,a5
    8020249c:	878a                	mv	a5,sp
    8020249e:	00078793          	mv	a5,a5
    802024a2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34
    i32 i;
    for (i = 0; len != 0; len--) {
    802024a6:	fc042e23          	sw	zero,-36(s0)
    802024aa:	a02d                	j	802024d4 <memmove_t+0xa2>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:35 (discriminator 3)
        temp[i] = *src++;
    802024ac:	fc043783          	ld	a5,-64(s0)
    802024b0:	00178713          	addi	a4,a5,1
    802024b4:	fce43023          	sd	a4,-64(s0)
    802024b8:	0007c703          	lbu	a4,0(a5)
    802024bc:	fe043683          	ld	a3,-32(s0)
    802024c0:	fdc42783          	lw	a5,-36(s0)
    802024c4:	97b6                	add	a5,a5,a3
    802024c6:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 3)
    for (i = 0; len != 0; len--) {
    802024ca:	fbc42783          	lw	a5,-68(s0)
    802024ce:	37fd                	addiw	a5,a5,-1
    802024d0:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:34 (discriminator 1)
    802024d4:	fbc42783          	lw	a5,-68(s0)
    802024d8:	2781                	sext.w	a5,a5
    802024da:	fbe9                	bnez	a5,802024ac <memmove_t+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37
    }
    for (; len != 0; len--) {
    802024dc:	a02d                	j	80202506 <memmove_t+0xd4>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:38 (discriminator 2)
        *dest++ = temp[i];
    802024de:	fc843783          	ld	a5,-56(s0)
    802024e2:	00178713          	addi	a4,a5,1
    802024e6:	fce43423          	sd	a4,-56(s0)
    802024ea:	fe043683          	ld	a3,-32(s0)
    802024ee:	fdc42703          	lw	a4,-36(s0)
    802024f2:	9736                	add	a4,a4,a3
    802024f4:	00074703          	lbu	a4,0(a4)
    802024f8:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 2)
    for (; len != 0; len--) {
    802024fc:	fbc42783          	lw	a5,-68(s0)
    80202500:	37fd                	addiw	a5,a5,-1
    80202502:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:37 (discriminator 1)
    80202506:	fbc42783          	lw	a5,-68(s0)
    8020250a:	2781                	sext.w	a5,a5
    8020250c:	fbe9                	bnez	a5,802024de <memmove_t+0xac>
    8020250e:	812e                	mv	sp,a1
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:40
    }
}
    80202510:	0001                	nop
    80202512:	fb040113          	addi	sp,s0,-80
    80202516:	6426                	ld	s0,72(sp)
    80202518:	6161                	addi	sp,sp,80
    8020251a:	8082                	ret

000000008020251c <memset_t>:
memset_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:43

void memset_t(void *dest, u8 val, u32 len)
{
    8020251c:	7179                	addi	sp,sp,-48
    8020251e:	f422                	sd	s0,40(sp)
    80202520:	1800                	addi	s0,sp,48
    80202522:	fca43c23          	sd	a0,-40(s0)
    80202526:	87ae                	mv	a5,a1
    80202528:	8732                	mv	a4,a2
    8020252a:	fcf40ba3          	sb	a5,-41(s0)
    8020252e:	87ba                	mv	a5,a4
    80202530:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:44
    u8 *dst = (u8 *)dest;
    80202534:	fd843783          	ld	a5,-40(s0)
    80202538:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46

    for (; len != 0; len--) {
    8020253c:	a005                	j	8020255c <memset_t+0x40>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:47 (discriminator 2)
        *dst++ = val;
    8020253e:	fe843783          	ld	a5,-24(s0)
    80202542:	00178713          	addi	a4,a5,1
    80202546:	fee43423          	sd	a4,-24(s0)
    8020254a:	fd744703          	lbu	a4,-41(s0)
    8020254e:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 2)
    for (; len != 0; len--) {
    80202552:	fd042783          	lw	a5,-48(s0)
    80202556:	37fd                	addiw	a5,a5,-1
    80202558:	fcf42823          	sw	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:46 (discriminator 1)
    8020255c:	fd042783          	lw	a5,-48(s0)
    80202560:	2781                	sext.w	a5,a5
    80202562:	fff1                	bnez	a5,8020253e <memset_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:49
    }
}
    80202564:	0001                	nop
    80202566:	0001                	nop
    80202568:	7422                	ld	s0,40(sp)
    8020256a:	6145                	addi	sp,sp,48
    8020256c:	8082                	ret

000000008020256e <bzero_t>:
bzero_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:51

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }
    8020256e:	1101                	addi	sp,sp,-32
    80202570:	ec06                	sd	ra,24(sp)
    80202572:	e822                	sd	s0,16(sp)
    80202574:	1000                	addi	s0,sp,32
    80202576:	fea43423          	sd	a0,-24(s0)
    8020257a:	87ae                	mv	a5,a1
    8020257c:	fef42223          	sw	a5,-28(s0)
    80202580:	fe442783          	lw	a5,-28(s0)
    80202584:	863e                	mv	a2,a5
    80202586:	4581                	li	a1,0
    80202588:	fe843503          	ld	a0,-24(s0)
    8020258c:	f91ff0ef          	jal	ra,8020251c <memset_t>
    80202590:	0001                	nop
    80202592:	60e2                	ld	ra,24(sp)
    80202594:	6442                	ld	s0,16(sp)
    80202596:	6105                	addi	sp,sp,32
    80202598:	8082                	ret

000000008020259a <strcmp_t>:
strcmp_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:54

int strcmp_t(const char *str1, const char *str2)
{
    8020259a:	1101                	addi	sp,sp,-32
    8020259c:	ec22                	sd	s0,24(sp)
    8020259e:	1000                	addi	s0,sp,32
    802025a0:	fea43423          	sd	a0,-24(s0)
    802025a4:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:55
    while (*str1 && *str2) {
    802025a8:	a0a1                	j	802025f0 <strcmp_t+0x56>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:56
        if (*str1 != *str2) {
    802025aa:	fe843783          	ld	a5,-24(s0)
    802025ae:	0007c703          	lbu	a4,0(a5)
    802025b2:	fe043783          	ld	a5,-32(s0)
    802025b6:	0007c783          	lbu	a5,0(a5)
    802025ba:	02f70163          	beq	a4,a5,802025dc <strcmp_t+0x42>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:57
            return (*str1) - (*str2);
    802025be:	fe843783          	ld	a5,-24(s0)
    802025c2:	0007c783          	lbu	a5,0(a5)
    802025c6:	0007871b          	sext.w	a4,a5
    802025ca:	fe043783          	ld	a5,-32(s0)
    802025ce:	0007c783          	lbu	a5,0(a5)
    802025d2:	2781                	sext.w	a5,a5
    802025d4:	40f707bb          	subw	a5,a4,a5
    802025d8:	2781                	sext.w	a5,a5
    802025da:	a099                	j	80202620 <strcmp_t+0x86>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:59
        }
        ++str1;
    802025dc:	fe843783          	ld	a5,-24(s0)
    802025e0:	0785                	addi	a5,a5,1
    802025e2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:60
        ++str2;
    802025e6:	fe043783          	ld	a5,-32(s0)
    802025ea:	0785                	addi	a5,a5,1
    802025ec:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:55
    while (*str1 && *str2) {
    802025f0:	fe843783          	ld	a5,-24(s0)
    802025f4:	0007c783          	lbu	a5,0(a5)
    802025f8:	c791                	beqz	a5,80202604 <strcmp_t+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:55 (discriminator 1)
    802025fa:	fe043783          	ld	a5,-32(s0)
    802025fe:	0007c783          	lbu	a5,0(a5)
    80202602:	f7c5                	bnez	a5,802025aa <strcmp_t+0x10>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:62
    }
    return (*str1) - (*str2);
    80202604:	fe843783          	ld	a5,-24(s0)
    80202608:	0007c783          	lbu	a5,0(a5)
    8020260c:	0007871b          	sext.w	a4,a5
    80202610:	fe043783          	ld	a5,-32(s0)
    80202614:	0007c783          	lbu	a5,0(a5)
    80202618:	2781                	sext.w	a5,a5
    8020261a:	40f707bb          	subw	a5,a4,a5
    8020261e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:63
}
    80202620:	853e                	mv	a0,a5
    80202622:	6462                	ld	s0,24(sp)
    80202624:	6105                	addi	sp,sp,32
    80202626:	8082                	ret

0000000080202628 <strcpy_t>:
strcpy_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:66

char *strcpy_t(char *dest, const char *src)
{
    80202628:	7179                	addi	sp,sp,-48
    8020262a:	f422                	sd	s0,40(sp)
    8020262c:	1800                	addi	s0,sp,48
    8020262e:	fca43c23          	sd	a0,-40(s0)
    80202632:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:67
    char *tmp = dest;
    80202636:	fd843783          	ld	a5,-40(s0)
    8020263a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:69

    while (*src) {
    8020263e:	a00d                	j	80202660 <strcpy_t+0x38>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:70
        *dest++ = *src++;
    80202640:	fd043703          	ld	a4,-48(s0)
    80202644:	00170793          	addi	a5,a4,1
    80202648:	fcf43823          	sd	a5,-48(s0)
    8020264c:	fd843783          	ld	a5,-40(s0)
    80202650:	00178693          	addi	a3,a5,1
    80202654:	fcd43c23          	sd	a3,-40(s0)
    80202658:	00074703          	lbu	a4,0(a4)
    8020265c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:69
    while (*src) {
    80202660:	fd043783          	ld	a5,-48(s0)
    80202664:	0007c783          	lbu	a5,0(a5)
    80202668:	ffe1                	bnez	a5,80202640 <strcpy_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:73
    }

    *dest = '\0';
    8020266a:	fd843783          	ld	a5,-40(s0)
    8020266e:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:75

    return tmp;
    80202672:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:76
}
    80202676:	853e                	mv	a0,a5
    80202678:	7422                	ld	s0,40(sp)
    8020267a:	6145                	addi	sp,sp,48
    8020267c:	8082                	ret

000000008020267e <strcat_t>:
strcat_t():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:79

char *strcat_t(char *dest, const char *src)
{
    8020267e:	7179                	addi	sp,sp,-48
    80202680:	f422                	sd	s0,40(sp)
    80202682:	1800                	addi	s0,sp,48
    80202684:	fca43c23          	sd	a0,-40(s0)
    80202688:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:80
    char *tmp = dest;
    8020268c:	fd843783          	ld	a5,-40(s0)
    80202690:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:82

    while (*dest != '\0') { dest++; }
    80202694:	a031                	j	802026a0 <strcat_t+0x22>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:82 (discriminator 2)
    80202696:	fd843783          	ld	a5,-40(s0)
    8020269a:	0785                	addi	a5,a5,1
    8020269c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:82 (discriminator 1)
    802026a0:	fd843783          	ld	a5,-40(s0)
    802026a4:	0007c783          	lbu	a5,0(a5)
    802026a8:	f7fd                	bnez	a5,80202696 <strcat_t+0x18>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83
    while (*src) {
    802026aa:	a00d                	j	802026cc <strcat_t+0x4e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:84
        *dest++ = *src++;
    802026ac:	fd043703          	ld	a4,-48(s0)
    802026b0:	00170793          	addi	a5,a4,1
    802026b4:	fcf43823          	sd	a5,-48(s0)
    802026b8:	fd843783          	ld	a5,-40(s0)
    802026bc:	00178693          	addi	a3,a5,1
    802026c0:	fcd43c23          	sd	a3,-40(s0)
    802026c4:	00074703          	lbu	a4,0(a4)
    802026c8:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:83
    while (*src) {
    802026cc:	fd043783          	ld	a5,-48(s0)
    802026d0:	0007c783          	lbu	a5,0(a5)
    802026d4:	ffe1                	bnez	a5,802026ac <strcat_t+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:87
    }

    *dest = '\0';
    802026d6:	fd843783          	ld	a5,-40(s0)
    802026da:	00078023          	sb	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:89

    return tmp;
    802026de:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:90
}
    802026e2:	853e                	mv	a0,a5
    802026e4:	7422                	ld	s0,40(sp)
    802026e6:	6145                	addi	sp,sp,48
    802026e8:	8082                	ret

00000000802026ea <memcpy>:
memcpy():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:93

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    802026ea:	7179                	addi	sp,sp,-48
    802026ec:	f422                	sd	s0,40(sp)
    802026ee:	1800                	addi	s0,sp,48
    802026f0:	fea43423          	sd	a0,-24(s0)
    802026f4:	feb43023          	sd	a1,-32(s0)
    802026f8:	87b2                	mv	a5,a2
    802026fa:	fcf42e23          	sw	a5,-36(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:94
    while (len--) {
    802026fe:	a00d                	j	80202720 <memcpy+0x36>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:95
        *dest++ = *src++;
    80202700:	fe043703          	ld	a4,-32(s0)
    80202704:	00170793          	addi	a5,a4,1
    80202708:	fef43023          	sd	a5,-32(s0)
    8020270c:	fe843783          	ld	a5,-24(s0)
    80202710:	00178693          	addi	a3,a5,1
    80202714:	fed43423          	sd	a3,-24(s0)
    80202718:	00074703          	lbu	a4,0(a4)
    8020271c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:94
    while (len--) {
    80202720:	fdc42783          	lw	a5,-36(s0)
    80202724:	fff7871b          	addiw	a4,a5,-1
    80202728:	fce42e23          	sw	a4,-36(s0)
    8020272c:	fbf1                	bnez	a5,80202700 <memcpy+0x16>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:97
    }
}
    8020272e:	0001                	nop
    80202730:	0001                	nop
    80202732:	7422                	ld	s0,40(sp)
    80202734:	6145                	addi	sp,sp,48
    80202736:	8082                	ret

0000000080202738 <memset>:
memset():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:100

void memset(void *dest, u8 val, u32 len)
{
    80202738:	1101                	addi	sp,sp,-32
    8020273a:	ec06                	sd	ra,24(sp)
    8020273c:	e822                	sd	s0,16(sp)
    8020273e:	1000                	addi	s0,sp,32
    80202740:	fea43423          	sd	a0,-24(s0)
    80202744:	87ae                	mv	a5,a1
    80202746:	8732                	mv	a4,a2
    80202748:	fef403a3          	sb	a5,-25(s0)
    8020274c:	87ba                	mv	a5,a4
    8020274e:	fef42023          	sw	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:101
    memset_t(dest,val,len);
    80202752:	fe042703          	lw	a4,-32(s0)
    80202756:	fe744783          	lbu	a5,-25(s0)
    8020275a:	863a                	mv	a2,a4
    8020275c:	85be                	mv	a1,a5
    8020275e:	fe843503          	ld	a0,-24(s0)
    80202762:	dbbff0ef          	jal	ra,8020251c <memset_t>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:102
}
    80202766:	0001                	nop
    80202768:	60e2                	ld	ra,24(sp)
    8020276a:	6442                	ld	s0,16(sp)
    8020276c:	6105                	addi	sp,sp,32
    8020276e:	8082                	ret

0000000080202770 <memcmp>:
memcmp():
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:105

int memcmp(const void *ptr1, const void *ptr2, size_t num) 
{
    80202770:	715d                	addi	sp,sp,-80
    80202772:	e4a2                	sd	s0,72(sp)
    80202774:	0880                	addi	s0,sp,80
    80202776:	fca43423          	sd	a0,-56(s0)
    8020277a:	fcb43023          	sd	a1,-64(s0)
    8020277e:	fac43c23          	sd	a2,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:106
    const unsigned char *p1 = ptr1, *p2 = ptr2;
    80202782:	fc843783          	ld	a5,-56(s0)
    80202786:	fef43023          	sd	a5,-32(s0)
    8020278a:	fc043783          	ld	a5,-64(s0)
    8020278e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107
    for (size_t i = 0; i < num; i++) 
    80202792:	fe043423          	sd	zero,-24(s0)
    80202796:	a8a1                	j	802027ee <memcmp+0x7e>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:109
    {
        if (p1[i] != p2[i]) 
    80202798:	fe043703          	ld	a4,-32(s0)
    8020279c:	fe843783          	ld	a5,-24(s0)
    802027a0:	97ba                	add	a5,a5,a4
    802027a2:	0007c683          	lbu	a3,0(a5)
    802027a6:	fd843703          	ld	a4,-40(s0)
    802027aa:	fe843783          	ld	a5,-24(s0)
    802027ae:	97ba                	add	a5,a5,a4
    802027b0:	0007c783          	lbu	a5,0(a5)
    802027b4:	8736                	mv	a4,a3
    802027b6:	02f70763          	beq	a4,a5,802027e4 <memcmp+0x74>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:111
        {
            return p1[i] - p2[i];
    802027ba:	fe043703          	ld	a4,-32(s0)
    802027be:	fe843783          	ld	a5,-24(s0)
    802027c2:	97ba                	add	a5,a5,a4
    802027c4:	0007c783          	lbu	a5,0(a5)
    802027c8:	0007871b          	sext.w	a4,a5
    802027cc:	fd843683          	ld	a3,-40(s0)
    802027d0:	fe843783          	ld	a5,-24(s0)
    802027d4:	97b6                	add	a5,a5,a3
    802027d6:	0007c783          	lbu	a5,0(a5)
    802027da:	2781                	sext.w	a5,a5
    802027dc:	40f707bb          	subw	a5,a4,a5
    802027e0:	2781                	sext.w	a5,a5
    802027e2:	a829                	j	802027fc <memcmp+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 2)
    for (size_t i = 0; i < num; i++) 
    802027e4:	fe843783          	ld	a5,-24(s0)
    802027e8:	0785                	addi	a5,a5,1
    802027ea:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:107 (discriminator 1)
    802027ee:	fe843703          	ld	a4,-24(s0)
    802027f2:	fb843783          	ld	a5,-72(s0)
    802027f6:	faf761e3          	bltu	a4,a5,80202798 <memcmp+0x28>
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:114
        }
    }
    return 0;
    802027fa:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/string/string.c:115
    802027fc:	853e                	mv	a0,a5
    802027fe:	6426                	ld	s0,72(sp)
    80202800:	6161                	addi	sp,sp,80
    80202802:	8082                	ret

0000000080202804 <memory_set_kernel_init>:
memory_set_kernel_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:7
#include "kernel_heap.h"
#include "pagetable.h"
#include "task_memory.h"
#include "kernel_heap.h"
void memory_set_kernel_init() 
{
    80202804:	1141                	addi	sp,sp,-16
    80202806:	e406                	sd	ra,8(sp)
    80202808:	e022                	sd	s0,0(sp)
    8020280a:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:8
  memory_set_kernel_new(&KERNEL_SPACE);
    8020280c:	00817517          	auipc	a0,0x817
    80202810:	7fc50513          	addi	a0,a0,2044 # 80a1a008 <KERNEL_SPACE>
    80202814:	241000ef          	jal	ra,80203254 <memory_set_kernel_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:9
  memory_set_activate(&KERNEL_SPACE);
    80202818:	00817517          	auipc	a0,0x817
    8020281c:	7f050513          	addi	a0,a0,2032 # 80a1a008 <KERNEL_SPACE>
    80202820:	3d3000ef          	jal	ra,802033f2 <memory_set_activate>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:10
}
    80202824:	0001                	nop
    80202826:	60a2                	ld	ra,8(sp)
    80202828:	6402                	ld	s0,0(sp)
    8020282a:	0141                	addi	sp,sp,16
    8020282c:	8082                	ret

000000008020282e <mm_init>:
mm_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:13

void mm_init()
{
    8020282e:	1141                	addi	sp,sp,-16
    80202830:	e406                	sd	ra,8(sp)
    80202832:	e022                	sd	s0,0(sp)
    80202834:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:14
    init_heap();
    80202836:	01a000ef          	jal	ra,80202850 <init_heap>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:15
    frame_allocator_init();
    8020283a:	38e010ef          	jal	ra,80203bc8 <frame_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:16
    memory_set_kernel_init();
    8020283e:	fc7ff0ef          	jal	ra,80202804 <memory_set_kernel_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:17
    memory_set_remap_test();
    80202842:	3e1000ef          	jal	ra,80203422 <memory_set_remap_test>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:18
}
    80202846:	0001                	nop
    80202848:	60a2                	ld	ra,8(sp)
    8020284a:	6402                	ld	s0,0(sp)
    8020284c:	0141                	addi	sp,sp,16
    8020284e:	8082                	ret

0000000080202850 <init_heap>:
init_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:16

static char heap[HEAP_SIZE];  // 堆空间

// 初始化堆
void init_heap() 
{
    80202850:	1101                	addi	sp,sp,-32
    80202852:	ec22                	sd	s0,24(sp)
    80202854:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:18
    // 初始化堆的第一个块
    BlockHeader* header = (BlockHeader*)heap;
    80202856:	00017797          	auipc	a5,0x17
    8020285a:	7b278793          	addi	a5,a5,1970 # 8021a008 <heap>
    8020285e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:19
    header->size = HEAP_SIZE - sizeof(BlockHeader); // 设置第一个块的大小
    80202862:	fe843783          	ld	a5,-24(s0)
    80202866:	00800737          	lui	a4,0x800
    8020286a:	1741                	addi	a4,a4,-16
    8020286c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:20
    header->free = 1; // 设置第一个块为空闲
    8020286e:	fe843783          	ld	a5,-24(s0)
    80202872:	4705                	li	a4,1
    80202874:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:21
}
    80202876:	0001                	nop
    80202878:	6462                	ld	s0,24(sp)
    8020287a:	6105                	addi	sp,sp,32
    8020287c:	8082                	ret

000000008020287e <malloc>:
malloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:24

// 分配内存
void* malloc(uint64_t size) {
    8020287e:	7179                	addi	sp,sp,-48
    80202880:	f422                	sd	s0,40(sp)
    80202882:	1800                	addi	s0,sp,48
    80202884:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:26
    // 从堆的开始处搜索合适的内存块
    BlockHeader* header = (BlockHeader*)heap;
    80202888:	00017797          	auipc	a5,0x17
    8020288c:	78078793          	addi	a5,a5,1920 # 8021a008 <heap>
    80202890:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:29

    // 搜索未分配且大小合适的内存块
    while (header->size < size || !header->free) {
    80202894:	a025                	j	802028bc <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:30
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    80202896:	fe843783          	ld	a5,-24(s0)
    8020289a:	639c                	ld	a5,0(a5)
    8020289c:	07c1                	addi	a5,a5,16
    8020289e:	fe843703          	ld	a4,-24(s0)
    802028a2:	97ba                	add	a5,a5,a4
    802028a4:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:31
        if ((char*)header >= (char*)heap + HEAP_SIZE) {
    802028a8:	00817797          	auipc	a5,0x817
    802028ac:	76078793          	addi	a5,a5,1888 # 80a1a008 <KERNEL_SPACE>
    802028b0:	fe843703          	ld	a4,-24(s0)
    802028b4:	00f76463          	bltu	a4,a5,802028bc <malloc+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:33
            // 搜索到堆的末尾还未找到合适的内存块
            return NULL;
    802028b8:	4781                	li	a5,0
    802028ba:	a885                	j	8020292a <malloc+0xac>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:29
    while (header->size < size || !header->free) {
    802028bc:	fe843783          	ld	a5,-24(s0)
    802028c0:	639c                	ld	a5,0(a5)
    802028c2:	fd843703          	ld	a4,-40(s0)
    802028c6:	fce7e8e3          	bltu	a5,a4,80202896 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:29 (discriminator 1)
    802028ca:	fe843783          	ld	a5,-24(s0)
    802028ce:	479c                	lw	a5,8(a5)
    802028d0:	d3f9                	beqz	a5,80202896 <malloc+0x18>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:38
        }
    }

    // 找到合适的内存块
    if (header->size >= size + sizeof(BlockHeader) + 4) {
    802028d2:	fe843783          	ld	a5,-24(s0)
    802028d6:	6398                	ld	a4,0(a5)
    802028d8:	fd843783          	ld	a5,-40(s0)
    802028dc:	07d1                	addi	a5,a5,20
    802028de:	02f76f63          	bltu	a4,a5,8020291c <malloc+0x9e>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:40
        // 分割内存块以减少浪费
        BlockHeader* new_header = (BlockHeader*)((char*)header + size + sizeof(BlockHeader));
    802028e2:	fd843783          	ld	a5,-40(s0)
    802028e6:	07c1                	addi	a5,a5,16
    802028e8:	fe843703          	ld	a4,-24(s0)
    802028ec:	97ba                	add	a5,a5,a4
    802028ee:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:41
        new_header->size = header->size - size - sizeof(BlockHeader); // 计算新内存块的大小
    802028f2:	fe843783          	ld	a5,-24(s0)
    802028f6:	6398                	ld	a4,0(a5)
    802028f8:	fd843783          	ld	a5,-40(s0)
    802028fc:	40f707b3          	sub	a5,a4,a5
    80202900:	ff078713          	addi	a4,a5,-16
    80202904:	fe043783          	ld	a5,-32(s0)
    80202908:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:42
        new_header->free = 1; // 设置新内存块为空闲
    8020290a:	fe043783          	ld	a5,-32(s0)
    8020290e:	4705                	li	a4,1
    80202910:	c798                	sw	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:43
        header->size = size; // 更新当前内存块的大小
    80202912:	fe843783          	ld	a5,-24(s0)
    80202916:	fd843703          	ld	a4,-40(s0)
    8020291a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:46
    }

    header->free = 0; // 标记当前内存块为已分配
    8020291c:	fe843783          	ld	a5,-24(s0)
    80202920:	0007a423          	sw	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:47
    return (void*)(header + 1); // 返回内存块数据区的地址
    80202924:	fe843783          	ld	a5,-24(s0)
    80202928:	07c1                	addi	a5,a5,16
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:48
}
    8020292a:	853e                	mv	a0,a5
    8020292c:	7422                	ld	s0,40(sp)
    8020292e:	6145                	addi	sp,sp,48
    80202930:	8082                	ret

0000000080202932 <free>:
free():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:51

// 释放内存
void free(void* ptr) {
    80202932:	7179                	addi	sp,sp,-48
    80202934:	f422                	sd	s0,40(sp)
    80202936:	1800                	addi	s0,sp,48
    80202938:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:53
    // 如果指针为空，则不进行操作
    if (ptr == NULL) {
    8020293c:	fd843783          	ld	a5,-40(s0)
    80202940:	cb99                	beqz	a5,80202956 <free+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:58
        return;
    }

    // 获取内存块头部
    BlockHeader* header = (BlockHeader*)ptr - 1;
    80202942:	fd843783          	ld	a5,-40(s0)
    80202946:	17c1                	addi	a5,a5,-16
    80202948:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:59
    header->free = 1; // 标记内存块为空闲
    8020294c:	fe843783          	ld	a5,-24(s0)
    80202950:	4705                	li	a4,1
    80202952:	c798                	sw	a4,8(a5)
    80202954:	a011                	j	80202958 <free+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:54
        return;
    80202956:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:60
}
    80202958:	7422                	ld	s0,40(sp)
    8020295a:	6145                	addi	sp,sp,48
    8020295c:	8082                	ret

000000008020295e <print_heap>:
print_heap():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:63

// 打印堆的状态
void print_heap() {
    8020295e:	1101                	addi	sp,sp,-32
    80202960:	ec06                	sd	ra,24(sp)
    80202962:	e822                	sd	s0,16(sp)
    80202964:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:64
    BlockHeader* header = (BlockHeader*)heap;
    80202966:	00017797          	auipc	a5,0x17
    8020296a:	6a278793          	addi	a5,a5,1698 # 8021a008 <heap>
    8020296e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:67

    // 遍历堆中的所有内存块
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    80202972:	a095                	j	802029d6 <print_heap+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:68
        print_str("Block size: ");
    80202974:	00003517          	auipc	a0,0x3
    80202978:	73450513          	addi	a0,a0,1844 # 802060a8 <rodata_start+0xa8>
    8020297c:	4e8010ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:69
        print_uint64(header->size); // 打印内存块大小
    80202980:	fe843783          	ld	a5,-24(s0)
    80202984:	639c                	ld	a5,0(a5)
    80202986:	853e                	mv	a0,a5
    80202988:	65a010ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:70
        print_str(", Free: ");
    8020298c:	00003517          	auipc	a0,0x3
    80202990:	72c50513          	addi	a0,a0,1836 # 802060b8 <rodata_start+0xb8>
    80202994:	4d0010ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:71
        print_str(header->free ? "Yes" : "No"); // 打印内存块是否空闲
    80202998:	fe843783          	ld	a5,-24(s0)
    8020299c:	479c                	lw	a5,8(a5)
    8020299e:	c791                	beqz	a5,802029aa <print_heap+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:71 (discriminator 1)
    802029a0:	00003797          	auipc	a5,0x3
    802029a4:	72878793          	addi	a5,a5,1832 # 802060c8 <rodata_start+0xc8>
    802029a8:	a029                	j	802029b2 <print_heap+0x54>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:71 (discriminator 2)
    802029aa:	00003797          	auipc	a5,0x3
    802029ae:	72678793          	addi	a5,a5,1830 # 802060d0 <rodata_start+0xd0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:71 (discriminator 4)
    802029b2:	853e                	mv	a0,a5
    802029b4:	4b0010ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:72 (discriminator 4)
        print_str("\n");
    802029b8:	00003517          	auipc	a0,0x3
    802029bc:	72050513          	addi	a0,a0,1824 # 802060d8 <rodata_start+0xd8>
    802029c0:	4a4010ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:75 (discriminator 4)

        // 移动到下一个内存块
        header = (BlockHeader*)((char*)header + header->size + sizeof(BlockHeader));
    802029c4:	fe843783          	ld	a5,-24(s0)
    802029c8:	639c                	ld	a5,0(a5)
    802029ca:	07c1                	addi	a5,a5,16
    802029cc:	fe843703          	ld	a4,-24(s0)
    802029d0:	97ba                	add	a5,a5,a4
    802029d2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:67
    while ((char*)header < (char*)heap + HEAP_SIZE) {
    802029d6:	00817797          	auipc	a5,0x817
    802029da:	63278793          	addi	a5,a5,1586 # 80a1a008 <KERNEL_SPACE>
    802029de:	fe843703          	ld	a4,-24(s0)
    802029e2:	f8f769e3          	bltu	a4,a5,80202974 <print_heap+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:77
    }
}
    802029e6:	0001                	nop
    802029e8:	0001                	nop
    802029ea:	60e2                	ld	ra,24(sp)
    802029ec:	6442                	ld	s0,16(sp)
    802029ee:	6105                	addi	sp,sp,32
    802029f0:	8082                	ret

00000000802029f2 <realloc>:
realloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:81

// 重新分配内存
void* realloc(void* ptr, uint64_t new_size) 
{
    802029f2:	7139                	addi	sp,sp,-64
    802029f4:	fc06                	sd	ra,56(sp)
    802029f6:	f822                	sd	s0,48(sp)
    802029f8:	0080                	addi	s0,sp,64
    802029fa:	fca43423          	sd	a0,-56(s0)
    802029fe:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:82
    if (new_size == 0) {
    80202a02:	fc043783          	ld	a5,-64(s0)
    80202a06:	e799                	bnez	a5,80202a14 <realloc+0x22>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:84
        // 如果新大小为0，则释放原有内存并返回NULL
        free(ptr);
    80202a08:	fc843503          	ld	a0,-56(s0)
    80202a0c:	f27ff0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:85
        return NULL;
    80202a10:	4781                	li	a5,0
    80202a12:	a045                	j	80202ab2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:88
    }

    if (ptr == NULL) {
    80202a14:	fc843783          	ld	a5,-56(s0)
    80202a18:	e799                	bnez	a5,80202a26 <realloc+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:90
        // 如果原始指针为NULL，则行为等同于malloc
        return malloc(new_size);
    80202a1a:	fc043503          	ld	a0,-64(s0)
    80202a1e:	e61ff0ef          	jal	ra,8020287e <malloc>
    80202a22:	87aa                	mv	a5,a0
    80202a24:	a079                	j	80202ab2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:93
    }

    BlockHeader* header = (BlockHeader*)ptr - 1;
    80202a26:	fc843783          	ld	a5,-56(s0)
    80202a2a:	17c1                	addi	a5,a5,-16
    80202a2c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:94
    if (header->size >= new_size) {
    80202a30:	fe043783          	ld	a5,-32(s0)
    80202a34:	639c                	ld	a5,0(a5)
    80202a36:	fc043703          	ld	a4,-64(s0)
    80202a3a:	00e7e563          	bltu	a5,a4,80202a44 <realloc+0x52>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:96
        // 如果原始内存块大小已满足需求，则直接返回原始指针
        return ptr;
    80202a3e:	fc843783          	ld	a5,-56(s0)
    80202a42:	a885                	j	80202ab2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:99
    } else {
        // 如果新大小超出原始大小，则分配一个新的内存块并复制原始数据
        void* new_ptr = malloc(new_size);
    80202a44:	fc043503          	ld	a0,-64(s0)
    80202a48:	e37ff0ef          	jal	ra,8020287e <malloc>
    80202a4c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:100
        if (new_ptr == NULL) {
    80202a50:	fd843783          	ld	a5,-40(s0)
    80202a54:	e399                	bnez	a5,80202a5a <realloc+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:102
            // 分配失败
            return NULL;
    80202a56:	4781                	li	a5,0
    80202a58:	a8a9                	j	80202ab2 <realloc+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:106
        }

        // 复制原始内存数据到新的内存块
        uint64_t copy_size = header->size < new_size ? header->size : new_size;
    80202a5a:	fe043783          	ld	a5,-32(s0)
    80202a5e:	6398                	ld	a4,0(a5)
    80202a60:	fc043783          	ld	a5,-64(s0)
    80202a64:	00f77363          	bgeu	a4,a5,80202a6a <realloc+0x78>
    80202a68:	87ba                	mv	a5,a4
    80202a6a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:107
        for (uint64_t i = 0; i < copy_size; ++i) {
    80202a6e:	fe043423          	sd	zero,-24(s0)
    80202a72:	a025                	j	80202a9a <realloc+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:108 (discriminator 3)
            *((char*)new_ptr + i) = *((char*)ptr + i);
    80202a74:	fc843703          	ld	a4,-56(s0)
    80202a78:	fe843783          	ld	a5,-24(s0)
    80202a7c:	973e                	add	a4,a4,a5
    80202a7e:	fd843683          	ld	a3,-40(s0)
    80202a82:	fe843783          	ld	a5,-24(s0)
    80202a86:	97b6                	add	a5,a5,a3
    80202a88:	00074703          	lbu	a4,0(a4) # 800000 <n+0x7fffe0>
    80202a8c:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:107 (discriminator 3)
        for (uint64_t i = 0; i < copy_size; ++i) {
    80202a90:	fe843783          	ld	a5,-24(s0)
    80202a94:	0785                	addi	a5,a5,1
    80202a96:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:107 (discriminator 1)
    80202a9a:	fe843703          	ld	a4,-24(s0)
    80202a9e:	fd043783          	ld	a5,-48(s0)
    80202aa2:	fcf769e3          	bltu	a4,a5,80202a74 <realloc+0x82>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:112
        }

        // 释放原始内存块
        free(ptr);
    80202aa6:	fc843503          	ld	a0,-56(s0)
    80202aaa:	e89ff0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:113
        return new_ptr;
    80202aae:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:115
    }
}
    80202ab2:	853e                	mv	a0,a5
    80202ab4:	70e2                	ld	ra,56(sp)
    80202ab6:	7442                	ld	s0,48(sp)
    80202ab8:	6121                	addi	sp,sp,64
    80202aba:	8082                	ret

0000000080202abc <pte_new>:
pte_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:9
// 创建一个新的 PageTableEntry 实例
// @param ppn 物理页号
// @param flags 页表项的标志位
// @return 初始化的 PageTableEntry 结构体实例
PageTableEntry pte_new(uint64_t ppn, PTEFlags flags) 
{
    80202abc:	7179                	addi	sp,sp,-48
    80202abe:	f422                	sd	s0,40(sp)
    80202ac0:	1800                	addi	s0,sp,48
    80202ac2:	fca43c23          	sd	a0,-40(s0)
    80202ac6:	87ae                	mv	a5,a1
    80202ac8:	fcf40ba3          	sb	a5,-41(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:11
    PageTableEntry pte;
    pte.bits = (ppn << 10) | flags; // 将物理页号左移10位并与标志位进行按位或操作
    80202acc:	fd843783          	ld	a5,-40(s0)
    80202ad0:	00a79713          	slli	a4,a5,0xa
    80202ad4:	fd744783          	lbu	a5,-41(s0)
    80202ad8:	8fd9                	or	a5,a5,a4
    80202ada:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:12
    return pte;
    80202ade:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:13
}
    80202ae2:	853e                	mv	a0,a5
    80202ae4:	7422                	ld	s0,40(sp)
    80202ae6:	6145                	addi	sp,sp,48
    80202ae8:	8082                	ret

0000000080202aea <pte_empty>:
pte_empty():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:18

// 创建一个表示空页表项的 PageTableEntry 实例
// @return 全零的 PageTableEntry 结构体实例，表示无效的页表项
PageTableEntry pte_empty(void) 
{
    80202aea:	1101                	addi	sp,sp,-32
    80202aec:	ec22                	sd	s0,24(sp)
    80202aee:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:20
    PageTableEntry pte;
    pte.bits = 0; // 全零表示无效的页表项
    80202af0:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:21
    return pte;
    80202af4:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:22
}
    80202af8:	853e                	mv	a0,a5
    80202afa:	6462                	ld	s0,24(sp)
    80202afc:	6105                	addi	sp,sp,32
    80202afe:	8082                	ret

0000000080202b00 <pte_ppn>:
pte_ppn():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:28

// 获取页表项中的物理页号
// @param pte 页表项
// @return 页表项中的物理页号
uint64_t pte_ppn(PageTableEntry pte) 
{
    80202b00:	1101                	addi	sp,sp,-32
    80202b02:	ec22                	sd	s0,24(sp)
    80202b04:	1000                	addi	s0,sp,32
    80202b06:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:29
    return pte.bits >> 10 & ((1ULL << 44) - 1); // 从位域中提取物理页号
    80202b0a:	fe843783          	ld	a5,-24(s0)
    80202b0e:	00a7d713          	srli	a4,a5,0xa
    80202b12:	57fd                	li	a5,-1
    80202b14:	83d1                	srli	a5,a5,0x14
    80202b16:	8ff9                	and	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:30
}
    80202b18:	853e                	mv	a0,a5
    80202b1a:	6462                	ld	s0,24(sp)
    80202b1c:	6105                	addi	sp,sp,32
    80202b1e:	8082                	ret

0000000080202b20 <pte_flags>:
pte_flags():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:36

// 获取页表项中的标志位
// @param pte 页表项
// @return 页表项中的标志位
PTEFlags pte_flags(PageTableEntry pte) 
{
    80202b20:	1101                	addi	sp,sp,-32
    80202b22:	ec22                	sd	s0,24(sp)
    80202b24:	1000                	addi	s0,sp,32
    80202b26:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:37
    return pte.bits & 0x3FF; // 提取页表项的最低10位作为标志位
    80202b2a:	fe843783          	ld	a5,-24(s0)
    80202b2e:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:38
}
    80202b32:	853e                	mv	a0,a5
    80202b34:	6462                	ld	s0,24(sp)
    80202b36:	6105                	addi	sp,sp,32
    80202b38:	8082                	ret

0000000080202b3a <pte_is_valid>:
pte_is_valid():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:44

// 检查页表项是否有效
// @param pte 页表项
// @return 如果页表项有效返回非零值，否则返回0
int pte_is_valid(PageTableEntry pte) 
{
    80202b3a:	1101                	addi	sp,sp,-32
    80202b3c:	ec06                	sd	ra,24(sp)
    80202b3e:	e822                	sd	s0,16(sp)
    80202b40:	1000                	addi	s0,sp,32
    80202b42:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:45
    return (pte_flags(pte) & PTE_V) != 0; // 检查V标志位是否为1
    80202b46:	fe843503          	ld	a0,-24(s0)
    80202b4a:	fd7ff0ef          	jal	ra,80202b20 <pte_flags>
    80202b4e:	87aa                	mv	a5,a0
    80202b50:	2781                	sext.w	a5,a5
    80202b52:	8b85                	andi	a5,a5,1
    80202b54:	2781                	sext.w	a5,a5
    80202b56:	00f037b3          	snez	a5,a5
    80202b5a:	0ff7f793          	andi	a5,a5,255
    80202b5e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:46
}
    80202b60:	853e                	mv	a0,a5
    80202b62:	60e2                	ld	ra,24(sp)
    80202b64:	6442                	ld	s0,16(sp)
    80202b66:	6105                	addi	sp,sp,32
    80202b68:	8082                	ret

0000000080202b6a <pte_is_readable>:
pte_is_readable():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:49

int pte_is_readable(PageTableEntry pte) 
{
    80202b6a:	1101                	addi	sp,sp,-32
    80202b6c:	ec06                	sd	ra,24(sp)
    80202b6e:	e822                	sd	s0,16(sp)
    80202b70:	1000                	addi	s0,sp,32
    80202b72:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:50
    return (pte_flags(pte) & PTE_R) != 0;
    80202b76:	fe843503          	ld	a0,-24(s0)
    80202b7a:	fa7ff0ef          	jal	ra,80202b20 <pte_flags>
    80202b7e:	87aa                	mv	a5,a0
    80202b80:	2781                	sext.w	a5,a5
    80202b82:	8b89                	andi	a5,a5,2
    80202b84:	2781                	sext.w	a5,a5
    80202b86:	00f037b3          	snez	a5,a5
    80202b8a:	0ff7f793          	andi	a5,a5,255
    80202b8e:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:51
}
    80202b90:	853e                	mv	a0,a5
    80202b92:	60e2                	ld	ra,24(sp)
    80202b94:	6442                	ld	s0,16(sp)
    80202b96:	6105                	addi	sp,sp,32
    80202b98:	8082                	ret

0000000080202b9a <pte_is_writable>:
pte_is_writable():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:54

int pte_is_writable(PageTableEntry pte) 
{
    80202b9a:	1101                	addi	sp,sp,-32
    80202b9c:	ec06                	sd	ra,24(sp)
    80202b9e:	e822                	sd	s0,16(sp)
    80202ba0:	1000                	addi	s0,sp,32
    80202ba2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:55
    return (pte_flags(pte) & PTE_W) != 0;
    80202ba6:	fe843503          	ld	a0,-24(s0)
    80202baa:	f77ff0ef          	jal	ra,80202b20 <pte_flags>
    80202bae:	87aa                	mv	a5,a0
    80202bb0:	2781                	sext.w	a5,a5
    80202bb2:	8b91                	andi	a5,a5,4
    80202bb4:	2781                	sext.w	a5,a5
    80202bb6:	00f037b3          	snez	a5,a5
    80202bba:	0ff7f793          	andi	a5,a5,255
    80202bbe:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:56
}
    80202bc0:	853e                	mv	a0,a5
    80202bc2:	60e2                	ld	ra,24(sp)
    80202bc4:	6442                	ld	s0,16(sp)
    80202bc6:	6105                	addi	sp,sp,32
    80202bc8:	8082                	ret

0000000080202bca <pte_is_executable>:
pte_is_executable():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:59

int pte_is_executable(PageTableEntry pte) 
{
    80202bca:	1101                	addi	sp,sp,-32
    80202bcc:	ec06                	sd	ra,24(sp)
    80202bce:	e822                	sd	s0,16(sp)
    80202bd0:	1000                	addi	s0,sp,32
    80202bd2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:60
    return (pte_flags(pte) & PTE_X) != 0;
    80202bd6:	fe843503          	ld	a0,-24(s0)
    80202bda:	f47ff0ef          	jal	ra,80202b20 <pte_flags>
    80202bde:	87aa                	mv	a5,a0
    80202be0:	2781                	sext.w	a5,a5
    80202be2:	8ba1                	andi	a5,a5,8
    80202be4:	2781                	sext.w	a5,a5
    80202be6:	00f037b3          	snez	a5,a5
    80202bea:	0ff7f793          	andi	a5,a5,255
    80202bee:	2781                	sext.w	a5,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:61
}
    80202bf0:	853e                	mv	a0,a5
    80202bf2:	60e2                	ld	ra,24(sp)
    80202bf4:	6442                	ld	s0,16(sp)
    80202bf6:	6105                	addi	sp,sp,32
    80202bf8:	8082                	ret

0000000080202bfa <set_pte>:
set_pte():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:65


void set_pte(PageTableEntry* entry, uint64_t ppn, uint64_t flags)
{
    80202bfa:	7139                	addi	sp,sp,-64
    80202bfc:	fc22                	sd	s0,56(sp)
    80202bfe:	0080                	addi	s0,sp,64
    80202c00:	fca43c23          	sd	a0,-40(s0)
    80202c04:	fcb43823          	sd	a1,-48(s0)
    80202c08:	fcc43423          	sd	a2,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:66
    uint64_t ppn_part = ppn << PTE_PPN_SHIFT;
    80202c0c:	fd043783          	ld	a5,-48(s0)
    80202c10:	07aa                	slli	a5,a5,0xa
    80202c12:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:67
    entry->bits = ppn_part | (flags & ((1ULL << PTE_PPN_SHIFT) - 1));
    80202c16:	fc843783          	ld	a5,-56(s0)
    80202c1a:	3ff7f713          	andi	a4,a5,1023
    80202c1e:	fe843783          	ld	a5,-24(s0)
    80202c22:	8f5d                	or	a4,a4,a5
    80202c24:	fd843783          	ld	a5,-40(s0)
    80202c28:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:68
}
    80202c2a:	0001                	nop
    80202c2c:	7462                	ld	s0,56(sp)
    80202c2e:	6121                	addi	sp,sp,64
    80202c30:	8082                	ret

0000000080202c32 <ppn_get_pte_array>:
ppn_get_pte_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:72


PageTableEntry *ppn_get_pte_array(PhysPageNum ppn) 
{
    80202c32:	7179                	addi	sp,sp,-48
    80202c34:	f422                	sd	s0,40(sp)
    80202c36:	1800                	addi	s0,sp,48
    80202c38:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:74
  PhysAddr pa;
  pa.addr = ((ppn.num) << PAGE_SIZE_BITS);
    80202c3c:	fd843783          	ld	a5,-40(s0)
    80202c40:	07b2                	slli	a5,a5,0xc
    80202c42:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:75
  return (PageTableEntry*)pa.addr; // len = 512 * 8
    80202c46:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pte/pte.c:76
}
    80202c4a:	853e                	mv	a0,a5
    80202c4c:	7422                	ld	s0,40(sp)
    80202c4e:	6145                	addi	sp,sp,48
    80202c50:	8082                	ret

0000000080202c52 <PageTable_new>:
PageTable_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:10
#include "address.h"
#include "debug.h"

// 创建新的页表结构体并初始化
PageTable* PageTable_new(void) 
{
    80202c52:	1101                	addi	sp,sp,-32
    80202c54:	ec06                	sd	ra,24(sp)
    80202c56:	e822                	sd	s0,16(sp)
    80202c58:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:12
    // 申请PageTable结构体的内存空间
    PageTable *pt = (PageTable*)malloc(sizeof(PageTable));
    80202c5a:	02000513          	li	a0,32
    80202c5e:	c21ff0ef          	jal	ra,8020287e <malloc>
    80202c62:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:14
    // 检查内存是否申请成功
    if (pt == NULL) 
    80202c66:	fe843783          	ld	a5,-24(s0)
    80202c6a:	e399                	bnez	a5,80202c70 <PageTable_new+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:16
    {
        return NULL;
    80202c6c:	4781                	li	a5,0
    80202c6e:	a0b9                	j	80202cbc <PageTable_new+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:19
    }
    // 为页表分配一个物理页作为根页表
    PhysPageNum root_ppn = StackFrameAllocator_alloc(&fram_allocator);
    80202c70:	00817517          	auipc	a0,0x817
    80202c74:	3d050513          	addi	a0,a0,976 # 80a1a040 <fram_allocator>
    80202c78:	7b5000ef          	jal	ra,80203c2c <StackFrameAllocator_alloc>
    80202c7c:	87aa                	mv	a5,a0
    80202c7e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:21
    // 检查物理页是否分配成功
    if (root_ppn.num == 0) 
    80202c82:	fe043783          	ld	a5,-32(s0)
    80202c86:	e799                	bnez	a5,80202c94 <PageTable_new+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:24
    {
        // 分配失败，释放PageTable结构体内存并返回NULL
        free(pt);
    80202c88:	fe843503          	ld	a0,-24(s0)
    80202c8c:	ca7ff0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:25
        return NULL;
    80202c90:	4781                	li	a5,0
    80202c92:	a02d                	j	80202cbc <PageTable_new+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:28
    }
    // 设置根页表的物理页号
    pt->root_ppn = root_ppn;
    80202c94:	fe843783          	ld	a5,-24(s0)
    80202c98:	fe043703          	ld	a4,-32(s0)
    80202c9c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:30
    // 初始化页表项向量
    vector_init(&pt->frames);
    80202c9e:	fe843783          	ld	a5,-24(s0)
    80202ca2:	07a1                	addi	a5,a5,8
    80202ca4:	853e                	mv	a0,a5
    80202ca6:	31a020ef          	jal	ra,80204fc0 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:31
    vector_resize(&pt->frames, sizeof(PhysPageNum));
    80202caa:	fe843783          	ld	a5,-24(s0)
    80202cae:	07a1                	addi	a5,a5,8
    80202cb0:	45a1                	li	a1,8
    80202cb2:	853e                	mv	a0,a5
    80202cb4:	360020ef          	jal	ra,80205014 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:32
    return pt;
    80202cb8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:33 (discriminator 1)
}
    80202cbc:	853e                	mv	a0,a5
    80202cbe:	60e2                	ld	ra,24(sp)
    80202cc0:	6442                	ld	s0,16(sp)
    80202cc2:	6105                	addi	sp,sp,32
    80202cc4:	8082                	ret

0000000080202cc6 <PageTable_free>:
PageTable_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:37

// 释放页表结构体及其资源
void PageTable_free(PageTable* pt) 
{
    80202cc6:	1101                	addi	sp,sp,-32
    80202cc8:	ec06                	sd	ra,24(sp)
    80202cca:	e822                	sd	s0,16(sp)
    80202ccc:	1000                	addi	s0,sp,32
    80202cce:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:39
    // 释放页表项向量占用的内存
    vector_free(&pt->frames);
    80202cd2:	fe843783          	ld	a5,-24(s0)
    80202cd6:	07a1                	addi	a5,a5,8
    80202cd8:	853e                	mv	a0,a5
    80202cda:	4ea020ef          	jal	ra,802051c4 <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:41
    // 释放页表结构体占用的内存
    free(pt);
    80202cde:	fe843503          	ld	a0,-24(s0)
    80202ce2:	c51ff0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:42
}
    80202ce6:	0001                	nop
    80202ce8:	60e2                	ld	ra,24(sp)
    80202cea:	6442                	ld	s0,16(sp)
    80202cec:	6105                	addi	sp,sp,32
    80202cee:	8082                	ret

0000000080202cf0 <get_pte_address>:
get_pte_address():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:46

// 根据物理页号和索引获取页表项地址
PageTableEntry* get_pte_address(PhysPageNum current_ppn, uint64_t index) 
{
    80202cf0:	7179                	addi	sp,sp,-48
    80202cf2:	f406                	sd	ra,40(sp)
    80202cf4:	f022                	sd	s0,32(sp)
    80202cf6:	1800                	addi	s0,sp,48
    80202cf8:	fca43c23          	sd	a0,-40(s0)
    80202cfc:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:48
    // 检查索引是否超出每页的页表项上限
    if (index >= ENTRIES_PER_PAGE)
    80202d00:	fd043703          	ld	a4,-48(s0)
    80202d04:	6785                	lui	a5,0x1
    80202d06:	00f76463          	bltu	a4,a5,80202d0e <get_pte_address+0x1e>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:50
    {
        return NULL;
    80202d0a:	4781                	li	a5,0
    80202d0c:	a831                	j	80202d28 <get_pte_address+0x38>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:53
    }
    // 获取当前物理页的基地址
    PhysAddr base_address = phys_page_num_to_addr(current_ppn);
    80202d0e:	fd843503          	ld	a0,-40(s0)
    80202d12:	098010ef          	jal	ra,80203daa <phys_page_num_to_addr>
    80202d16:	87aa                	mv	a5,a0
    80202d18:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:55
    // 返回页表项地址
    return (PageTableEntry*)((uintptr_t)base_address.addr + index * sizeof(PageTableEntry));
    80202d1c:	fe843703          	ld	a4,-24(s0)
    80202d20:	fd043783          	ld	a5,-48(s0)
    80202d24:	078e                	slli	a5,a5,0x3
    80202d26:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:56 (discriminator 1)
}
    80202d28:	853e                	mv	a0,a5
    80202d2a:	70a2                	ld	ra,40(sp)
    80202d2c:	7402                	ld	s0,32(sp)
    80202d2e:	6145                	addi	sp,sp,48
    80202d30:	8082                	ret

0000000080202d32 <PageTable_map_ppn_2_vpn>:
PageTable_map_ppn_2_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:60

// 在页表中映射物理页号到虚拟页号
void PageTable_map_ppn_2_vpn(PageTable* pt, VirtPageNum vpn, PhysPageNum ppn, PTEFlags flags) 
{
    80202d32:	7139                	addi	sp,sp,-64
    80202d34:	fc06                	sd	ra,56(sp)
    80202d36:	f822                	sd	s0,48(sp)
    80202d38:	0080                	addi	s0,sp,64
    80202d3a:	fca43c23          	sd	a0,-40(s0)
    80202d3e:	fcb43823          	sd	a1,-48(s0)
    80202d42:	fcc43423          	sd	a2,-56(s0)
    80202d46:	87b6                	mv	a5,a3
    80202d48:	fcf403a3          	sb	a5,-57(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:61
    PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80202d4c:	fd043583          	ld	a1,-48(s0)
    80202d50:	fd843503          	ld	a0,-40(s0)
    80202d54:	182000ef          	jal	ra,80202ed6 <page_table_find_pte_create>
    80202d58:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:62
    if (pte_is_valid(*pte)) 
    80202d5c:	fe843783          	ld	a5,-24(s0)
    80202d60:	6388                	ld	a0,0(a5)
    80202d62:	dd9ff0ef          	jal	ra,80202b3a <pte_is_valid>
    80202d66:	87aa                	mv	a5,a0
    80202d68:	cb89                	beqz	a5,80202d7a <PageTable_map_ppn_2_vpn+0x48>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:64 (discriminator 1)
    {
        ASSERT(0);
    80202d6a:	04000593          	li	a1,64
    80202d6e:	00003517          	auipc	a0,0x3
    80202d72:	37250513          	addi	a0,a0,882 # 802060e0 <rodata_start+0xe0>
    80202d76:	3b2010ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:67
        //panic("VPN 0x%llx is mapped before mapping.\n", vpn);
    }
    *pte = pte_new(ppn.num, flags | PTE_V);
    80202d7a:	fc843703          	ld	a4,-56(s0)
    80202d7e:	fc744783          	lbu	a5,-57(s0)
    80202d82:	0017e793          	ori	a5,a5,1
    80202d86:	0ff7f793          	andi	a5,a5,255
    80202d8a:	85be                	mv	a1,a5
    80202d8c:	853a                	mv	a0,a4
    80202d8e:	d2fff0ef          	jal	ra,80202abc <pte_new>
    80202d92:	872a                	mv	a4,a0
    80202d94:	fe843783          	ld	a5,-24(s0)
    80202d98:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:68
}
    80202d9a:	0001                	nop
    80202d9c:	70e2                	ld	ra,56(sp)
    80202d9e:	7442                	ld	s0,48(sp)
    80202da0:	6121                	addi	sp,sp,64
    80202da2:	8082                	ret

0000000080202da4 <PageTable_unmap_ppn_2_vpn>:
PageTable_unmap_ppn_2_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:72

// 在页表中取消物理页号到虚拟页号的映射
void PageTable_unmap_ppn_2_vpn(PageTable* pt, VirtPageNum vpn) 
{
    80202da4:	7179                	addi	sp,sp,-48
    80202da6:	f406                	sd	ra,40(sp)
    80202da8:	f022                	sd	s0,32(sp)
    80202daa:	1800                	addi	s0,sp,48
    80202dac:	fca43c23          	sd	a0,-40(s0)
    80202db0:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:73
    PageTableEntry *pte = page_table_find_pte_create(pt, vpn);
    80202db4:	fd043583          	ld	a1,-48(s0)
    80202db8:	fd843503          	ld	a0,-40(s0)
    80202dbc:	11a000ef          	jal	ra,80202ed6 <page_table_find_pte_create>
    80202dc0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:74
  if (!pte_is_valid(*pte)) {
    80202dc4:	fe843783          	ld	a5,-24(s0)
    80202dc8:	6388                	ld	a0,0(a5)
    80202dca:	d71ff0ef          	jal	ra,80202b3a <pte_is_valid>
    80202dce:	87aa                	mv	a5,a0
    80202dd0:	eb89                	bnez	a5,80202de2 <PageTable_unmap_ppn_2_vpn+0x3e>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:75 (discriminator 1)
    ASSERT(0);
    80202dd2:	04b00593          	li	a1,75
    80202dd6:	00003517          	auipc	a0,0x3
    80202dda:	30a50513          	addi	a0,a0,778 # 802060e0 <rodata_start+0xe0>
    80202dde:	34a010ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:78
    //panic("VPN 0x%llx is invalid before unmapping.\n", vpn);
  }
  *pte = pte_empty();
    80202de2:	d09ff0ef          	jal	ra,80202aea <pte_empty>
    80202de6:	872a                	mv	a4,a0
    80202de8:	fe843783          	ld	a5,-24(s0)
    80202dec:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:79
}
    80202dee:	0001                	nop
    80202df0:	70a2                	ld	ra,40(sp)
    80202df2:	7402                	ld	s0,32(sp)
    80202df4:	6145                	addi	sp,sp,48
    80202df6:	8082                	ret

0000000080202df8 <pte_get_ppn>:
pte_get_ppn():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:83

// 从页表项中获取物理页号
PhysPageNum pte_get_ppn(PageTableEntry pte)
{
    80202df8:	7179                	addi	sp,sp,-48
    80202dfa:	f422                	sd	s0,40(sp)
    80202dfc:	1800                	addi	s0,sp,48
    80202dfe:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:85
    PhysPageNum tmp;
    tmp.num = pte.bits >> 10; // 页表项中物理页号的位置
    80202e02:	fd843783          	ld	a5,-40(s0)
    80202e06:	83a9                	srli	a5,a5,0xa
    80202e08:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:86
    return tmp;
    80202e0c:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:87
}
    80202e10:	853e                	mv	a0,a5
    80202e12:	7422                	ld	s0,40(sp)
    80202e14:	6145                	addi	sp,sp,48
    80202e16:	8082                	ret

0000000080202e18 <page_table_token>:
page_table_token():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:91

// 获取页表的SATP值
uint64_t page_table_token(PageTable *pt) 
{ 
    80202e18:	1101                	addi	sp,sp,-32
    80202e1a:	ec22                	sd	s0,24(sp)
    80202e1c:	1000                	addi	s0,sp,32
    80202e1e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:93
    // 根据RISC-V的页表格式设置SATP寄存器的值
    return ((8L << 60) | pt->root_ppn.num); 
    80202e22:	fe843783          	ld	a5,-24(s0)
    80202e26:	6398                	ld	a4,0(a5)
    80202e28:	57fd                	li	a5,-1
    80202e2a:	17fe                	slli	a5,a5,0x3f
    80202e2c:	8fd9                	or	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:94
}
    80202e2e:	853e                	mv	a0,a5
    80202e30:	6462                	ld	s0,24(sp)
    80202e32:	6105                	addi	sp,sp,32
    80202e34:	8082                	ret

0000000080202e36 <page_table_find_pte>:
page_table_find_pte():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:98

// 查找页表中给定虚拟页号对应的页表项，如果不存在则返回NULL
PageTableEntry* page_table_find_pte(PageTable *pt, VirtPageNum vpn) 
{
    80202e36:	7139                	addi	sp,sp,-64
    80202e38:	fc06                	sd	ra,56(sp)
    80202e3a:	f822                	sd	s0,48(sp)
    80202e3c:	0080                	addi	s0,sp,64
    80202e3e:	fca43423          	sd	a0,-56(s0)
    80202e42:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:100
    // 解析虚拟页号获取三级页表的索引数组
    uint64_t* indexes = decompose_vpn(vpn.num);
    80202e46:	fc043783          	ld	a5,-64(s0)
    80202e4a:	853e                	mv	a0,a5
    80202e4c:	777000ef          	jal	ra,80203dc2 <decompose_vpn>
    80202e50:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:102
    // 从根页表开始
    PhysPageNum current_ppn = pt->root_ppn;
    80202e54:	fc843783          	ld	a5,-56(s0)
    80202e58:	639c                	ld	a5,0(a5)
    80202e5a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:105
    PageTableEntry* current_pte;
    // 遍历三级页表
    for (int level = 0; level < 3; level++) 
    80202e5e:	fe042223          	sw	zero,-28(s0)
    80202e62:	a8a1                	j	80202eba <page_table_find_pte+0x84>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:108
    {
        // 获取当前级别的页表项地址
        current_pte = get_pte_address(current_ppn, indexes[level]);
    80202e64:	fe442783          	lw	a5,-28(s0)
    80202e68:	078e                	slli	a5,a5,0x3
    80202e6a:	fd843703          	ld	a4,-40(s0)
    80202e6e:	97ba                	add	a5,a5,a4
    80202e70:	639c                	ld	a5,0(a5)
    80202e72:	85be                	mv	a1,a5
    80202e74:	fd043503          	ld	a0,-48(s0)
    80202e78:	e79ff0ef          	jal	ra,80202cf0 <get_pte_address>
    80202e7c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:110
        // 检查页表项是否有效
        if (!pte_is_valid(*current_pte)) 
    80202e80:	fe843783          	ld	a5,-24(s0)
    80202e84:	6388                	ld	a0,0(a5)
    80202e86:	cb5ff0ef          	jal	ra,80202b3a <pte_is_valid>
    80202e8a:	87aa                	mv	a5,a0
    80202e8c:	e399                	bnez	a5,80202e92 <page_table_find_pte+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:113
        {
            // 无效则返回NULL
            return NULL;
    80202e8e:	4781                	li	a5,0
    80202e90:	a835                	j	80202ecc <page_table_find_pte+0x96>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:116
        }
        // 若不是最后一级，更新当前物理页号为下一级的物理页号
        if (level < 2) 
    80202e92:	fe442783          	lw	a5,-28(s0)
    80202e96:	0007871b          	sext.w	a4,a5
    80202e9a:	4785                	li	a5,1
    80202e9c:	00e7ca63          	blt	a5,a4,80202eb0 <page_table_find_pte+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:118
        {
            current_ppn = pte_get_ppn(*current_pte);
    80202ea0:	fe843783          	ld	a5,-24(s0)
    80202ea4:	6388                	ld	a0,0(a5)
    80202ea6:	f53ff0ef          	jal	ra,80202df8 <pte_get_ppn>
    80202eaa:	87aa                	mv	a5,a0
    80202eac:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:105 (discriminator 2)
    for (int level = 0; level < 3; level++) 
    80202eb0:	fe442783          	lw	a5,-28(s0)
    80202eb4:	2785                	addiw	a5,a5,1
    80202eb6:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:105 (discriminator 1)
    80202eba:	fe442783          	lw	a5,-28(s0)
    80202ebe:	0007871b          	sext.w	a4,a5
    80202ec2:	4789                	li	a5,2
    80202ec4:	fae7d0e3          	bge	a5,a4,80202e64 <page_table_find_pte+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:122
        }
    }
    // 返回找到的页表项
    return current_pte;
    80202ec8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:123 (discriminator 1)
}
    80202ecc:	853e                	mv	a0,a5
    80202ece:	70e2                	ld	ra,56(sp)
    80202ed0:	7442                	ld	s0,48(sp)
    80202ed2:	6121                	addi	sp,sp,64
    80202ed4:	8082                	ret

0000000080202ed6 <page_table_find_pte_create>:
page_table_find_pte_create():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:127

// 查找或创建页表中给定虚拟页号对应的页表项
PageTableEntry *page_table_find_pte_create(PageTable *pt, VirtPageNum vpn) 
{
    80202ed6:	715d                	addi	sp,sp,-80
    80202ed8:	e486                	sd	ra,72(sp)
    80202eda:	e0a2                	sd	s0,64(sp)
    80202edc:	0880                	addi	s0,sp,80
    80202ede:	faa43c23          	sd	a0,-72(s0)
    80202ee2:	fab43823          	sd	a1,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:130
  // 解析虚拟页号获取三级索引
  uint64_t* idxs;
  idxs = decompose_vpn(vpn.num);
    80202ee6:	fb043783          	ld	a5,-80(s0)
    80202eea:	853e                	mv	a0,a5
    80202eec:	6d7000ef          	jal	ra,80203dc2 <decompose_vpn>
    80202ef0:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:132
  // 从根页表的物理页号开始
  PhysPageNum ppn = pt->root_ppn;
    80202ef4:	fb843783          	ld	a5,-72(s0)
    80202ef8:	639c                	ld	a5,0(a5)
    80202efa:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:133
  PageTableEntry *result = NULL;
    80202efe:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134
  for (unsigned i = 0; i < 3; i++) 
    80202f02:	fe042223          	sw	zero,-28(s0)
    80202f06:	a855                	j	80202fba <page_table_find_pte_create+0xe4>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:137
  {
    // 根据当前物理页号和索引获取页表项地址
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    80202f08:	fc843503          	ld	a0,-56(s0)
    80202f0c:	d27ff0ef          	jal	ra,80202c32 <ppn_get_pte_array>
    80202f10:	86aa                	mv	a3,a0
    80202f12:	fe446783          	lwu	a5,-28(s0)
    80202f16:	078e                	slli	a5,a5,0x3
    80202f18:	fd843703          	ld	a4,-40(s0)
    80202f1c:	97ba                	add	a5,a5,a4
    80202f1e:	639c                	ld	a5,0(a5)
    80202f20:	078e                	slli	a5,a5,0x3
    80202f22:	97b6                	add	a5,a5,a3
    80202f24:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:139
    // 如果是最后一级页表项，则直接返回该页表项
    if (i == 2) 
    80202f28:	fe442783          	lw	a5,-28(s0)
    80202f2c:	0007871b          	sext.w	a4,a5
    80202f30:	4789                	li	a5,2
    80202f32:	00f71763          	bne	a4,a5,80202f40 <page_table_find_pte_create+0x6a>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:141
    {
      result = pte;
    80202f36:	fd043783          	ld	a5,-48(s0)
    80202f3a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:142
      break;
    80202f3e:	a069                	j	80202fc8 <page_table_find_pte_create+0xf2>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:146
    }
    // 如果页表项无效，则为其分配一个新的物理页，并将其设置为有效
    //!pte_is_valid
    printk("pte: addr : %d \n",pte);
    80202f40:	fd043583          	ld	a1,-48(s0)
    80202f44:	00003517          	auipc	a0,0x3
    80202f48:	1c450513          	addi	a0,a0,452 # 80206108 <rodata_start+0x108>
    80202f4c:	89ffe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:147
    if (!pte_is_valid(*pte)) 
    80202f50:	fd043783          	ld	a5,-48(s0)
    80202f54:	6388                	ld	a0,0(a5)
    80202f56:	be5ff0ef          	jal	ra,80202b3a <pte_is_valid>
    80202f5a:	87aa                	mv	a5,a0
    80202f5c:	e3b1                	bnez	a5,80202fa0 <page_table_find_pte_create+0xca>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:150
    {
      // 分配新的物理页
      PhysPageNum frame = StackFrameAllocator_alloc(&fram_allocator);
    80202f5e:	00817517          	auipc	a0,0x817
    80202f62:	0e250513          	addi	a0,a0,226 # 80a1a040 <fram_allocator>
    80202f66:	4c7000ef          	jal	ra,80203c2c <StackFrameAllocator_alloc>
    80202f6a:	87aa                	mv	a5,a0
    80202f6c:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:153
      //trace("frame alloc 0x%llx\n", frame);
      // 检查物理页分配是否成功
      if (!frame.num) 
    80202f70:	fc043783          	ld	a5,-64(s0)
    80202f74:	e399                	bnez	a5,80202f7a <page_table_find_pte_create+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:155
      {
        return NULL;
    80202f76:	4781                	li	a5,0
    80202f78:	a891                	j	80202fcc <page_table_find_pte_create+0xf6>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:158
      }
      // 将新分配的物理页设置为当前页表项指向的物理页，并标记为有效
      *pte = pte_new(frame.num, PTE_V);
    80202f7a:	fc043783          	ld	a5,-64(s0)
    80202f7e:	4585                	li	a1,1
    80202f80:	853e                	mv	a0,a5
    80202f82:	b3bff0ef          	jal	ra,80202abc <pte_new>
    80202f86:	872a                	mv	a4,a0
    80202f88:	fd043783          	ld	a5,-48(s0)
    80202f8c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:160
      // 将新分配的物理页加入到页表项向量中
      vector_add(&pt->frames, &frame);
    80202f8e:	fb843783          	ld	a5,-72(s0)
    80202f92:	07a1                	addi	a5,a5,8
    80202f94:	fc040713          	addi	a4,s0,-64
    80202f98:	85ba                	mv	a1,a4
    80202f9a:	853e                	mv	a0,a5
    80202f9c:	0c4020ef          	jal	ra,80205060 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:163 (discriminator 2)
    }
    // 更新当前物理页号为当前页表项指向的下一级物理页号，以便继续遍历
    ppn.num = pte_ppn(*pte);
    80202fa0:	fd043783          	ld	a5,-48(s0)
    80202fa4:	6388                	ld	a0,0(a5)
    80202fa6:	b5bff0ef          	jal	ra,80202b00 <pte_ppn>
    80202faa:	87aa                	mv	a5,a0
    80202fac:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) 
    80202fb0:	fe442783          	lw	a5,-28(s0)
    80202fb4:	2785                	addiw	a5,a5,1
    80202fb6:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134 (discriminator 1)
    80202fba:	fe442783          	lw	a5,-28(s0)
    80202fbe:	0007871b          	sext.w	a4,a5
    80202fc2:	4789                	li	a5,2
    80202fc4:	f4e7f2e3          	bgeu	a5,a4,80202f08 <page_table_find_pte_create+0x32>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:166
  }
  // 返回找到或创建的页表项
  return result;
    80202fc8:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:167 (discriminator 1)
}
    80202fcc:	853e                	mv	a0,a5
    80202fce:	60a6                	ld	ra,72(sp)
    80202fd0:	6406                	ld	s0,64(sp)
    80202fd2:	6161                	addi	sp,sp,80
    80202fd4:	8082                	ret

0000000080202fd6 <map_area_init>:
map_area_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:22
extern void bss_end();
extern void ekernel();
extern void strampoline(); // trap跳板位置
MemorySet KERNEL_SPACE;
void map_area_init(MapArea* ma, VirtAddr start_va, VirtAddr end_va, enum MapType mt, MapPermission mp)
{
    80202fd6:	7139                	addi	sp,sp,-64
    80202fd8:	fc06                	sd	ra,56(sp)
    80202fda:	f822                	sd	s0,48(sp)
    80202fdc:	f426                	sd	s1,40(sp)
    80202fde:	0080                	addi	s0,sp,64
    80202fe0:	fca43c23          	sd	a0,-40(s0)
    80202fe4:	fcb43823          	sd	a1,-48(s0)
    80202fe8:	fcc43423          	sd	a2,-56(s0)
    80202fec:	87b6                	mv	a5,a3
    80202fee:	fcf42223          	sw	a5,-60(s0)
    80202ff2:	87ba                	mv	a5,a4
    80202ff4:	fcf42023          	sw	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:23
    ma->vpn_range.start_vpn = virt_addr_to_page_num(start_va, 0);
    80202ff8:	fd843483          	ld	s1,-40(s0)
    80202ffc:	4581                	li	a1,0
    80202ffe:	fd043503          	ld	a0,-48(s0)
    80203002:	551000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203006:	e088                	sd	a0,0(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:24
    ma->vpn_range.size = virt_addr_to_page_num(end_va, 1).num - ma->vpn_range.start_vpn.num;
    80203008:	4585                	li	a1,1
    8020300a:	fc843503          	ld	a0,-56(s0)
    8020300e:	545000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203012:	87aa                	mv	a5,a0
    80203014:	873e                	mv	a4,a5
    80203016:	fd843783          	ld	a5,-40(s0)
    8020301a:	639c                	ld	a5,0(a5)
    8020301c:	8f1d                	sub	a4,a4,a5
    8020301e:	fd843783          	ld	a5,-40(s0)
    80203022:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:25
    ma->map_type = mt;
    80203024:	fd843783          	ld	a5,-40(s0)
    80203028:	fc442703          	lw	a4,-60(s0)
    8020302c:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:26
    ma->map_premission = mp;
    8020302e:	fd843783          	ld	a5,-40(s0)
    80203032:	fc042703          	lw	a4,-64(s0)
    80203036:	cbd8                	sw	a4,20(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:27
}
    80203038:	0001                	nop
    8020303a:	70e2                	ld	ra,56(sp)
    8020303c:	7442                	ld	s0,48(sp)
    8020303e:	74a2                	ld	s1,40(sp)
    80203040:	6121                	addi	sp,sp,64
    80203042:	8082                	ret

0000000080203044 <map_area_map>:
map_area_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:30

void map_area_map(MapArea* ma, PageTable* pt)
{
    80203044:	7139                	addi	sp,sp,-64
    80203046:	fc06                	sd	ra,56(sp)
    80203048:	f822                	sd	s0,48(sp)
    8020304a:	0080                	addi	s0,sp,64
    8020304c:	fca43423          	sd	a0,-56(s0)
    80203050:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32
    PhysPageNum target;
    for(int64_t i = 0; i < ma->vpn_range.size; i ++)
    80203054:	fe043423          	sd	zero,-24(s0)
    80203058:	a095                	j	802030bc <map_area_map+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:34
    {
        if (ma->map_type == Identical)
    8020305a:	fc843783          	ld	a5,-56(s0)
    8020305e:	4b9c                	lw	a5,16(a5)
    80203060:	eb91                	bnez	a5,80203074 <map_area_map+0x30>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:36
        {
            target.num = ma->vpn_range.start_vpn.num + i;
    80203062:	fc843783          	ld	a5,-56(s0)
    80203066:	6398                	ld	a4,0(a5)
    80203068:	fe843783          	ld	a5,-24(s0)
    8020306c:	97ba                	add	a5,a5,a4
    8020306e:	fef43023          	sd	a5,-32(s0)
    80203072:	a811                	j	80203086 <map_area_map+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:39
        } else 
        {
            target = StackFrameAllocator_alloc(&fram_allocator);
    80203074:	00817517          	auipc	a0,0x817
    80203078:	fcc50513          	addi	a0,a0,-52 # 80a1a040 <fram_allocator>
    8020307c:	3b1000ef          	jal	ra,80203c2c <StackFrameAllocator_alloc>
    80203080:	87aa                	mv	a5,a0
    80203082:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:42 (discriminator 2)
        }
        VirtPageNum vpn;
        vpn.num = ma->vpn_range.start_vpn.num+i;
    80203086:	fc843783          	ld	a5,-56(s0)
    8020308a:	6398                	ld	a4,0(a5)
    8020308c:	fe843783          	ld	a5,-24(s0)
    80203090:	97ba                	add	a5,a5,a4
    80203092:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:43 (discriminator 2)
        PageTable_map_ppn_2_vpn(pt, vpn, target, ma->map_premission);
    80203096:	fc843783          	ld	a5,-56(s0)
    8020309a:	4bdc                	lw	a5,20(a5)
    8020309c:	0ff7f793          	andi	a5,a5,255
    802030a0:	86be                	mv	a3,a5
    802030a2:	fe043603          	ld	a2,-32(s0)
    802030a6:	fd843583          	ld	a1,-40(s0)
    802030aa:	fc043503          	ld	a0,-64(s0)
    802030ae:	c85ff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32 (discriminator 2)
    for(int64_t i = 0; i < ma->vpn_range.size; i ++)
    802030b2:	fe843783          	ld	a5,-24(s0)
    802030b6:	0785                	addi	a5,a5,1
    802030b8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32 (discriminator 1)
    802030bc:	fc843783          	ld	a5,-56(s0)
    802030c0:	6798                	ld	a4,8(a5)
    802030c2:	fe843783          	ld	a5,-24(s0)
    802030c6:	f8e7eae3          	bltu	a5,a4,8020305a <map_area_map+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:45
    }
}
    802030ca:	0001                	nop
    802030cc:	0001                	nop
    802030ce:	70e2                	ld	ra,56(sp)
    802030d0:	7442                	ld	s0,48(sp)
    802030d2:	6121                	addi	sp,sp,64
    802030d4:	8082                	ret

00000000802030d6 <memory_set_init>:
memory_set_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:48

void memory_set_init(MemorySet* ms)
{
    802030d6:	1101                	addi	sp,sp,-32
    802030d8:	ec06                	sd	ra,24(sp)
    802030da:	e822                	sd	s0,16(sp)
    802030dc:	1000                	addi	s0,sp,32
    802030de:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:49
    ms->page_table = *PageTable_new();
    802030e2:	b71ff0ef          	jal	ra,80202c52 <PageTable_new>
    802030e6:	872a                	mv	a4,a0
    802030e8:	fe843783          	ld	a5,-24(s0)
    802030ec:	630c                	ld	a1,0(a4)
    802030ee:	6710                	ld	a2,8(a4)
    802030f0:	6b14                	ld	a3,16(a4)
    802030f2:	6f18                	ld	a4,24(a4)
    802030f4:	e38c                	sd	a1,0(a5)
    802030f6:	e790                	sd	a2,8(a5)
    802030f8:	eb94                	sd	a3,16(a5)
    802030fa:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:50
    vector_init(&ms->areas);
    802030fc:	fe843783          	ld	a5,-24(s0)
    80203100:	02078793          	addi	a5,a5,32 # 1020 <n+0x1000>
    80203104:	853e                	mv	a0,a5
    80203106:	6bb010ef          	jal	ra,80204fc0 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:51
    vector_resize(&ms->areas,sizeof(MapArea));
    8020310a:	fe843783          	ld	a5,-24(s0)
    8020310e:	02078793          	addi	a5,a5,32
    80203112:	45e1                	li	a1,24
    80203114:	853e                	mv	a0,a5
    80203116:	6ff010ef          	jal	ra,80205014 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:52
}
    8020311a:	0001                	nop
    8020311c:	60e2                	ld	ra,24(sp)
    8020311e:	6442                	ld	s0,16(sp)
    80203120:	6105                	addi	sp,sp,32
    80203122:	8082                	ret

0000000080203124 <memory_set_push>:
memory_set_push():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:55

void memory_set_push(MemorySet* ms, MapArea* ma)
{
    80203124:	1101                	addi	sp,sp,-32
    80203126:	ec06                	sd	ra,24(sp)
    80203128:	e822                	sd	s0,16(sp)
    8020312a:	1000                	addi	s0,sp,32
    8020312c:	fea43423          	sd	a0,-24(s0)
    80203130:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:56
    vector_add(&ms->areas, ma);
    80203134:	fe843783          	ld	a5,-24(s0)
    80203138:	02078793          	addi	a5,a5,32
    8020313c:	fe043583          	ld	a1,-32(s0)
    80203140:	853e                	mv	a0,a5
    80203142:	71f010ef          	jal	ra,80205060 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:57
    map_area_map(ma, &ms->page_table);
    80203146:	fe843783          	ld	a5,-24(s0)
    8020314a:	85be                	mv	a1,a5
    8020314c:	fe043503          	ld	a0,-32(s0)
    80203150:	ef5ff0ef          	jal	ra,80203044 <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:58
}
    80203154:	0001                	nop
    80203156:	60e2                	ld	ra,24(sp)
    80203158:	6442                	ld	s0,16(sp)
    8020315a:	6105                	addi	sp,sp,32
    8020315c:	8082                	ret

000000008020315e <memory_set_map_user_stack>:
memory_set_map_user_stack():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:61

void memory_set_map_user_stack(MemorySet *ms, VirtAddr user_stack_low_va)
{
    8020315e:	7139                	addi	sp,sp,-64
    80203160:	fc06                	sd	ra,56(sp)
    80203162:	f822                	sd	s0,48(sp)
    80203164:	f426                	sd	s1,40(sp)
    80203166:	0080                	addi	s0,sp,64
    80203168:	fca43423          	sd	a0,-56(s0)
    8020316c:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:62
    PhysPageNum user_stack_ppn = StackFrameAllocator_alloc(&fram_allocator);
    80203170:	00817517          	auipc	a0,0x817
    80203174:	ed050513          	addi	a0,a0,-304 # 80a1a040 <fram_allocator>
    80203178:	2b5000ef          	jal	ra,80203c2c <StackFrameAllocator_alloc>
    8020317c:	87aa                	mv	a5,a0
    8020317e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:63
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(user_stack_low_va,1),user_stack_ppn,PTE_R|PTE_W|PTE_U);
    80203182:	fc843483          	ld	s1,-56(s0)
    80203186:	4585                	li	a1,1
    80203188:	fc043503          	ld	a0,-64(s0)
    8020318c:	3c7000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203190:	87aa                	mv	a5,a0
    80203192:	46d9                	li	a3,22
    80203194:	fd843603          	ld	a2,-40(s0)
    80203198:	85be                	mv	a1,a5
    8020319a:	8526                	mv	a0,s1
    8020319c:	b97ff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:64
}
    802031a0:	0001                	nop
    802031a2:	70e2                	ld	ra,56(sp)
    802031a4:	7442                	ld	s0,48(sp)
    802031a6:	74a2                	ld	s1,40(sp)
    802031a8:	6121                	addi	sp,sp,64
    802031aa:	8082                	ret

00000000802031ac <memory_set_map_kernel_stack_kernel>:
memory_set_map_kernel_stack_kernel():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:67

void memory_set_map_kernel_stack_kernel(MemorySet *ms)
{
    802031ac:	7139                	addi	sp,sp,-64
    802031ae:	fc06                	sd	ra,56(sp)
    802031b0:	f822                	sd	s0,48(sp)
    802031b2:	f426                	sd	s1,40(sp)
    802031b4:	0080                	addi	s0,sp,64
    802031b6:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:68
    PhysPageNum kernel_stack = StackFrameAllocator_alloc(&fram_allocator);
    802031ba:	00817517          	auipc	a0,0x817
    802031be:	e8650513          	addi	a0,a0,-378 # 80a1a040 <fram_allocator>
    802031c2:	26b000ef          	jal	ra,80203c2c <StackFrameAllocator_alloc>
    802031c6:	87aa                	mv	a5,a0
    802031c8:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:70
    VirtAddr va;
    va.addr = TRAP_CONTEXT_FULL;
    802031cc:	77f9                	lui	a5,0xffffe
    802031ce:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:71
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,1),kernel_stack,(PTE_R|PTE_W));
    802031d2:	fc843483          	ld	s1,-56(s0)
    802031d6:	4585                	li	a1,1
    802031d8:	fd043503          	ld	a0,-48(s0)
    802031dc:	377000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    802031e0:	87aa                	mv	a5,a0
    802031e2:	4699                	li	a3,6
    802031e4:	fd843603          	ld	a2,-40(s0)
    802031e8:	85be                	mv	a1,a5
    802031ea:	8526                	mv	a0,s1
    802031ec:	b47ff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:72
}
    802031f0:	0001                	nop
    802031f2:	70e2                	ld	ra,56(sp)
    802031f4:	7442                	ld	s0,48(sp)
    802031f6:	74a2                	ld	s1,40(sp)
    802031f8:	6121                	addi	sp,sp,64
    802031fa:	8082                	ret

00000000802031fc <memory_set_map_trampoline>:
memory_set_map_trampoline():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:75

void memory_set_map_trampoline(MemorySet *ms)
{
    802031fc:	7139                	addi	sp,sp,-64
    802031fe:	fc06                	sd	ra,56(sp)
    80203200:	f822                	sd	s0,48(sp)
    80203202:	f426                	sd	s1,40(sp)
    80203204:	f04a                	sd	s2,32(sp)
    80203206:	0080                	addi	s0,sp,64
    80203208:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:77
    VirtAddr va;
    va.addr = TRAMPOLINE_FULL;
    8020320c:	77fd                	lui	a5,0xfffff
    8020320e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:79
    PhysAddr pha;
    pha.addr = (size_t)&strampoline;
    80203212:	ffffe797          	auipc	a5,0xffffe
    80203216:	dee78793          	addi	a5,a5,-530 # 80201000 <port_write>
    8020321a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:80
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,0),phys_addr_to_page_num(pha,1),PTE_R|PTE_X);
    8020321e:	fc843483          	ld	s1,-56(s0)
    80203222:	4581                	li	a1,0
    80203224:	fd843503          	ld	a0,-40(s0)
    80203228:	32b000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    8020322c:	892a                	mv	s2,a0
    8020322e:	4585                	li	a1,1
    80203230:	fd043503          	ld	a0,-48(s0)
    80203234:	2df000ef          	jal	ra,80203d12 <phys_addr_to_page_num>
    80203238:	87aa                	mv	a5,a0
    8020323a:	46a9                	li	a3,10
    8020323c:	863e                	mv	a2,a5
    8020323e:	85ca                	mv	a1,s2
    80203240:	8526                	mv	a0,s1
    80203242:	af1ff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:81
}
    80203246:	0001                	nop
    80203248:	70e2                	ld	ra,56(sp)
    8020324a:	7442                	ld	s0,48(sp)
    8020324c:	74a2                	ld	s1,40(sp)
    8020324e:	7902                	ld	s2,32(sp)
    80203250:	6121                	addi	sp,sp,64
    80203252:	8082                	ret

0000000080203254 <memory_set_kernel_new>:
memory_set_kernel_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:83

void memory_set_kernel_new(MemorySet* ms) {
    80203254:	715d                	addi	sp,sp,-80
    80203256:	e486                	sd	ra,72(sp)
    80203258:	e0a2                	sd	s0,64(sp)
    8020325a:	0880                	addi	s0,sp,80
    8020325c:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:85
    MapArea ma_tmp;
    printk("[mm/memory_set.c] text: 0x%x - 0x%x\n", (uint64_t)text_start, (uint64_t)text_end);
    80203260:	ffffd797          	auipc	a5,0xffffd
    80203264:	da078793          	addi	a5,a5,-608 # 80200000 <_start>
    80203268:	00003717          	auipc	a4,0x3
    8020326c:	d9870713          	addi	a4,a4,-616 # 80206000 <rodata_start>
    80203270:	863a                	mv	a2,a4
    80203272:	85be                	mv	a1,a5
    80203274:	00003517          	auipc	a0,0x3
    80203278:	eac50513          	addi	a0,a0,-340 # 80206120 <rodata_start+0x120>
    8020327c:	d6efe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:86
    printk("[mm/memory_set.c] rodata: 0x%x - 0x%x\n", (uint64_t)rodata_start, (uint64_t)rodata_end);
    80203280:	00003797          	auipc	a5,0x3
    80203284:	d8078793          	addi	a5,a5,-640 # 80206000 <rodata_start>
    80203288:	00004717          	auipc	a4,0x4
    8020328c:	d7870713          	addi	a4,a4,-648 # 80207000 <_num_app>
    80203290:	863a                	mv	a2,a4
    80203292:	85be                	mv	a1,a5
    80203294:	00003517          	auipc	a0,0x3
    80203298:	eb450513          	addi	a0,a0,-332 # 80206148 <rodata_start+0x148>
    8020329c:	d4efe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:87
    printk("[mm/memory_set.c] data: 0x%x - 0x%x\n", (uint64_t)data_start, (uint64_t)data_end);
    802032a0:	00004797          	auipc	a5,0x4
    802032a4:	d6078793          	addi	a5,a5,-672 # 80207000 <_num_app>
    802032a8:	00007717          	auipc	a4,0x7
    802032ac:	d5870713          	addi	a4,a4,-680 # 8020a000 <boot_stack_lower_bound>
    802032b0:	863a                	mv	a2,a4
    802032b2:	85be                	mv	a1,a5
    802032b4:	00003517          	auipc	a0,0x3
    802032b8:	ebc50513          	addi	a0,a0,-324 # 80206170 <rodata_start+0x170>
    802032bc:	d2efe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:88
    printk("[mm/memory_set.c] bss: 0x%x - 0x%x\n", (uint64_t)bss_start, (uint64_t)bss_end);
    802032c0:	00007797          	auipc	a5,0x7
    802032c4:	d4078793          	addi	a5,a5,-704 # 8020a000 <boot_stack_lower_bound>
    802032c8:	00868717          	auipc	a4,0x868
    802032cc:	d3870713          	addi	a4,a4,-712 # 80a6b000 <bss_end>
    802032d0:	863a                	mv	a2,a4
    802032d2:	85be                	mv	a1,a5
    802032d4:	00003517          	auipc	a0,0x3
    802032d8:	ec450513          	addi	a0,a0,-316 # 80206198 <rodata_start+0x198>
    802032dc:	d0efe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:89
    memory_set_new_bare(ms);
    802032e0:	fb843503          	ld	a0,-72(s0)
    802032e4:	288000ef          	jal	ra,8020356c <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:90
    memory_set_map_trampoline(ms);
    802032e8:	fb843503          	ld	a0,-72(s0)
    802032ec:	f11ff0ef          	jal	ra,802031fc <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:91
    memory_set_map_kernel_stack_kernel(ms);
    802032f0:	fb843503          	ld	a0,-72(s0)
    802032f4:	eb9ff0ef          	jal	ra,802031ac <memory_set_map_kernel_stack_kernel>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:93
    VirtAddr vads, vade;
    vads.addr = (uint64_t)text_start;
    802032f8:	ffffd797          	auipc	a5,0xffffd
    802032fc:	d0878793          	addi	a5,a5,-760 # 80200000 <_start>
    80203300:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:94
    vade.addr = (uint64_t)text_end;
    80203304:	00003797          	auipc	a5,0x3
    80203308:	cfc78793          	addi	a5,a5,-772 # 80206000 <rodata_start>
    8020330c:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:95
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_X);
    80203310:	fd840793          	addi	a5,s0,-40
    80203314:	4729                	li	a4,10
    80203316:	4681                	li	a3,0
    80203318:	fc843603          	ld	a2,-56(s0)
    8020331c:	fd043583          	ld	a1,-48(s0)
    80203320:	853e                	mv	a0,a5
    80203322:	cb5ff0ef          	jal	ra,80202fd6 <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:96
    memory_set_push(ms, &ma_tmp);
    80203326:	fd840793          	addi	a5,s0,-40
    8020332a:	85be                	mv	a1,a5
    8020332c:	fb843503          	ld	a0,-72(s0)
    80203330:	df5ff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:99

    // .rodata segment
    vads.addr = (uint64_t)rodata_start;
    80203334:	00003797          	auipc	a5,0x3
    80203338:	ccc78793          	addi	a5,a5,-820 # 80206000 <rodata_start>
    8020333c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:100
    vade.addr = (uint64_t)rodata_end;
    80203340:	00004797          	auipc	a5,0x4
    80203344:	cc078793          	addi	a5,a5,-832 # 80207000 <_num_app>
    80203348:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:101
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R);
    8020334c:	fd840793          	addi	a5,s0,-40
    80203350:	4709                	li	a4,2
    80203352:	4681                	li	a3,0
    80203354:	fc843603          	ld	a2,-56(s0)
    80203358:	fd043583          	ld	a1,-48(s0)
    8020335c:	853e                	mv	a0,a5
    8020335e:	c79ff0ef          	jal	ra,80202fd6 <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:102
    memory_set_push(ms, &ma_tmp);
    80203362:	fd840793          	addi	a5,s0,-40
    80203366:	85be                	mv	a1,a5
    80203368:	fb843503          	ld	a0,-72(s0)
    8020336c:	db9ff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:105

    // .data segment
    vads.addr = (uint64_t)data_start;
    80203370:	00004797          	auipc	a5,0x4
    80203374:	c9078793          	addi	a5,a5,-880 # 80207000 <_num_app>
    80203378:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:106
    vade.addr = (uint64_t)data_end;
    8020337c:	00007797          	auipc	a5,0x7
    80203380:	c8478793          	addi	a5,a5,-892 # 8020a000 <boot_stack_lower_bound>
    80203384:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:107
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    80203388:	fd840793          	addi	a5,s0,-40
    8020338c:	4719                	li	a4,6
    8020338e:	4681                	li	a3,0
    80203390:	fc843603          	ld	a2,-56(s0)
    80203394:	fd043583          	ld	a1,-48(s0)
    80203398:	853e                	mv	a0,a5
    8020339a:	c3dff0ef          	jal	ra,80202fd6 <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:108
    memory_set_push(ms, &ma_tmp);
    8020339e:	fd840793          	addi	a5,s0,-40
    802033a2:	85be                	mv	a1,a5
    802033a4:	fb843503          	ld	a0,-72(s0)
    802033a8:	d7dff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:111

    // .bss segment
    vads.addr = (uint64_t)bss_start;
    802033ac:	00007797          	auipc	a5,0x7
    802033b0:	c5478793          	addi	a5,a5,-940 # 8020a000 <boot_stack_lower_bound>
    802033b4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:112
    vade.addr = (uint64_t)bss_end;
    802033b8:	00868797          	auipc	a5,0x868
    802033bc:	c4878793          	addi	a5,a5,-952 # 80a6b000 <bss_end>
    802033c0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:113
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    802033c4:	fd840793          	addi	a5,s0,-40
    802033c8:	4719                	li	a4,6
    802033ca:	4681                	li	a3,0
    802033cc:	fc843603          	ld	a2,-56(s0)
    802033d0:	fd043583          	ld	a1,-48(s0)
    802033d4:	853e                	mv	a0,a5
    802033d6:	c01ff0ef          	jal	ra,80202fd6 <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:114
    memory_set_push(ms, &ma_tmp);
    802033da:	fd840793          	addi	a5,s0,-40
    802033de:	85be                	mv	a1,a5
    802033e0:	fb843503          	ld	a0,-72(s0)
    802033e4:	d41ff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:115
}
    802033e8:	0001                	nop
    802033ea:	60a6                	ld	ra,72(sp)
    802033ec:	6406                	ld	s0,64(sp)
    802033ee:	6161                	addi	sp,sp,80
    802033f0:	8082                	ret

00000000802033f2 <memory_set_activate>:
memory_set_activate():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:118

void memory_set_activate(MemorySet *memory_set)
{
    802033f2:	7179                	addi	sp,sp,-48
    802033f4:	f406                	sd	ra,40(sp)
    802033f6:	f022                	sd	s0,32(sp)
    802033f8:	1800                	addi	s0,sp,48
    802033fa:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:119
    uint64_t satp = page_table_token(&memory_set->page_table);
    802033fe:	fd843783          	ld	a5,-40(s0)
    80203402:	853e                	mv	a0,a5
    80203404:	a15ff0ef          	jal	ra,80202e18 <page_table_token>
    80203408:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:120
    WRITE_CSR(satp,satp);
    8020340c:	fe843783          	ld	a5,-24(s0)
    80203410:	18079073          	csrw	satp,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:121
    asm volatile("sfence.vma zero, zero");
    80203414:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:122
}
    80203418:	0001                	nop
    8020341a:	70a2                	ld	ra,40(sp)
    8020341c:	7402                	ld	s0,32(sp)
    8020341e:	6145                	addi	sp,sp,48
    80203420:	8082                	ret

0000000080203422 <memory_set_remap_test>:
memory_set_remap_test():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:125

void memory_set_remap_test()
{
    80203422:	711d                	addi	sp,sp,-96
    80203424:	ec86                	sd	ra,88(sp)
    80203426:	e8a2                	sd	s0,80(sp)
    80203428:	1080                	addi	s0,sp,96
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:127
    VirtAddr mid_text;
    mid_text.addr = (((uint64_t)&text_start + (uint64_t)&text_end) / 2);
    8020342a:	ffffd717          	auipc	a4,0xffffd
    8020342e:	bd670713          	addi	a4,a4,-1066 # 80200000 <_start>
    80203432:	00003797          	auipc	a5,0x3
    80203436:	bce78793          	addi	a5,a5,-1074 # 80206000 <rodata_start>
    8020343a:	97ba                	add	a5,a5,a4
    8020343c:	8385                	srli	a5,a5,0x1
    8020343e:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:129
    VirtAddr mid_rodata;
    mid_rodata.addr = (((uint64_t)&rodata_start + (uint64_t)&rodata_end) / 2);
    80203442:	00003717          	auipc	a4,0x3
    80203446:	bbe70713          	addi	a4,a4,-1090 # 80206000 <rodata_start>
    8020344a:	00004797          	auipc	a5,0x4
    8020344e:	bb678793          	addi	a5,a5,-1098 # 80207000 <_num_app>
    80203452:	97ba                	add	a5,a5,a4
    80203454:	8385                	srli	a5,a5,0x1
    80203456:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:131
    VirtAddr mid_data;
    mid_data.addr = (((uint64_t)&data_start + (uint64_t)&data_end) / 2);
    8020345a:	00004717          	auipc	a4,0x4
    8020345e:	ba670713          	addi	a4,a4,-1114 # 80207000 <_num_app>
    80203462:	00007797          	auipc	a5,0x7
    80203466:	b9e78793          	addi	a5,a5,-1122 # 8020a000 <boot_stack_lower_bound>
    8020346a:	97ba                	add	a5,a5,a4
    8020346c:	8385                	srli	a5,a5,0x1
    8020346e:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:133

    VirtPageNum text = virt_addr_to_page_num(mid_text,1);
    80203472:	4585                	li	a1,1
    80203474:	fd043503          	ld	a0,-48(s0)
    80203478:	0db000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    8020347c:	87aa                	mv	a5,a0
    8020347e:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:134
    VirtPageNum rodata = virt_addr_to_page_num(mid_rodata,1);
    80203482:	4585                	li	a1,1
    80203484:	fc843503          	ld	a0,-56(s0)
    80203488:	0cb000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    8020348c:	87aa                	mv	a5,a0
    8020348e:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:135
    VirtPageNum data = virt_addr_to_page_num(mid_data,1);
    80203492:	4585                	li	a1,1
    80203494:	fc043503          	ld	a0,-64(s0)
    80203498:	0bb000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    8020349c:	87aa                	mv	a5,a0
    8020349e:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:136
    PageTableEntry* p1 = page_table_find_pte(&(KERNEL_SPACE.page_table),text);
    802034a2:	fb843583          	ld	a1,-72(s0)
    802034a6:	00817517          	auipc	a0,0x817
    802034aa:	b6250513          	addi	a0,a0,-1182 # 80a1a008 <KERNEL_SPACE>
    802034ae:	989ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    802034b2:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:137
    PageTableEntry* p2 = page_table_find_pte(&(KERNEL_SPACE.page_table),rodata);
    802034b6:	fb043583          	ld	a1,-80(s0)
    802034ba:	00817517          	auipc	a0,0x817
    802034be:	b4e50513          	addi	a0,a0,-1202 # 80a1a008 <KERNEL_SPACE>
    802034c2:	975ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    802034c6:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:138
    PageTableEntry* p3 = page_table_find_pte(&(KERNEL_SPACE.page_table),data);
    802034ca:	fa843583          	ld	a1,-88(s0)
    802034ce:	00817517          	auipc	a0,0x817
    802034d2:	b3a50513          	addi	a0,a0,-1222 # 80a1a008 <KERNEL_SPACE>
    802034d6:	961ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    802034da:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:141

    // 检查text区域是否可执行且不可写
    ASSERT(pte_is_executable(*p1) && !pte_is_writable(*p1));
    802034de:	fe843783          	ld	a5,-24(s0)
    802034e2:	6388                	ld	a0,0(a5)
    802034e4:	ee6ff0ef          	jal	ra,80202bca <pte_is_executable>
    802034e8:	87aa                	mv	a5,a0
    802034ea:	cb81                	beqz	a5,802034fa <memory_set_remap_test+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:141 (discriminator 2)
    802034ec:	fe843783          	ld	a5,-24(s0)
    802034f0:	6388                	ld	a0,0(a5)
    802034f2:	ea8ff0ef          	jal	ra,80202b9a <pte_is_writable>
    802034f6:	87aa                	mv	a5,a0
    802034f8:	cb89                	beqz	a5,8020350a <memory_set_remap_test+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:141 (discriminator 3)
    802034fa:	08d00593          	li	a1,141
    802034fe:	00003517          	auipc	a0,0x3
    80203502:	cc250513          	addi	a0,a0,-830 # 802061c0 <rodata_start+0x1c0>
    80203506:	423000ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:144

    // 检查rodata区域是否可读且不可写
    ASSERT(pte_is_readable(*p2) && !pte_is_writable(*p2));
    8020350a:	fe043783          	ld	a5,-32(s0)
    8020350e:	6388                	ld	a0,0(a5)
    80203510:	e5aff0ef          	jal	ra,80202b6a <pte_is_readable>
    80203514:	87aa                	mv	a5,a0
    80203516:	cb81                	beqz	a5,80203526 <memory_set_remap_test+0x104>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:144 (discriminator 2)
    80203518:	fe043783          	ld	a5,-32(s0)
    8020351c:	6388                	ld	a0,0(a5)
    8020351e:	e7cff0ef          	jal	ra,80202b9a <pte_is_writable>
    80203522:	87aa                	mv	a5,a0
    80203524:	cb89                	beqz	a5,80203536 <memory_set_remap_test+0x114>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:144 (discriminator 3)
    80203526:	09000593          	li	a1,144
    8020352a:	00003517          	auipc	a0,0x3
    8020352e:	c9650513          	addi	a0,a0,-874 # 802061c0 <rodata_start+0x1c0>
    80203532:	3f7000ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:147

    // 检查data区域是否可读写
    ASSERT(pte_is_readable(*p3) && pte_is_writable(*p3));
    80203536:	fd843783          	ld	a5,-40(s0)
    8020353a:	6388                	ld	a0,0(a5)
    8020353c:	e2eff0ef          	jal	ra,80202b6a <pte_is_readable>
    80203540:	87aa                	mv	a5,a0
    80203542:	cb81                	beqz	a5,80203552 <memory_set_remap_test+0x130>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:147 (discriminator 2)
    80203544:	fd843783          	ld	a5,-40(s0)
    80203548:	6388                	ld	a0,0(a5)
    8020354a:	e50ff0ef          	jal	ra,80202b9a <pte_is_writable>
    8020354e:	87aa                	mv	a5,a0
    80203550:	eb89                	bnez	a5,80203562 <memory_set_remap_test+0x140>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:147 (discriminator 3)
    80203552:	09300593          	li	a1,147
    80203556:	00003517          	auipc	a0,0x3
    8020355a:	c6a50513          	addi	a0,a0,-918 # 802061c0 <rodata_start+0x1c0>
    8020355e:	3cb000ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:148
}
    80203562:	0001                	nop
    80203564:	60e6                	ld	ra,88(sp)
    80203566:	6446                	ld	s0,80(sp)
    80203568:	6125                	addi	sp,sp,96
    8020356a:	8082                	ret

000000008020356c <memory_set_new_bare>:
memory_set_new_bare():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:151

void memory_set_new_bare(MemorySet *memory_set) 
{
    8020356c:	1101                	addi	sp,sp,-32
    8020356e:	ec06                	sd	ra,24(sp)
    80203570:	e822                	sd	s0,16(sp)
    80203572:	1000                	addi	s0,sp,32
    80203574:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:152
    memory_set->page_table = *PageTable_new();
    80203578:	edaff0ef          	jal	ra,80202c52 <PageTable_new>
    8020357c:	872a                	mv	a4,a0
    8020357e:	fe843783          	ld	a5,-24(s0)
    80203582:	630c                	ld	a1,0(a4)
    80203584:	6710                	ld	a2,8(a4)
    80203586:	6b14                	ld	a3,16(a4)
    80203588:	6f18                	ld	a4,24(a4)
    8020358a:	e38c                	sd	a1,0(a5)
    8020358c:	e790                	sd	a2,8(a5)
    8020358e:	eb94                	sd	a3,16(a5)
    80203590:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:153
    vector_new(&memory_set->areas, sizeof(MapArea));
    80203592:	fe843783          	ld	a5,-24(s0)
    80203596:	02078793          	addi	a5,a5,32
    8020359a:	45e1                	li	a1,24
    8020359c:	853e                	mv	a0,a5
    8020359e:	461010ef          	jal	ra,802051fe <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:154
}
    802035a2:	0001                	nop
    802035a4:	60e2                	ld	ra,24(sp)
    802035a6:	6442                	ld	s0,16(sp)
    802035a8:	6105                	addi	sp,sp,32
    802035aa:	8082                	ret

00000000802035ac <ppn_get_bytes_array>:
ppn_get_bytes_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:159



uint8_t* ppn_get_bytes_array(PhysPageNum ppn) 
{
    802035ac:	7179                	addi	sp,sp,-48
    802035ae:	f406                	sd	ra,40(sp)
    802035b0:	f022                	sd	s0,32(sp)
    802035b2:	1800                	addi	s0,sp,48
    802035b4:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:160
  PhysAddr pa = phys_page_num_to_addr(ppn);
    802035b8:	fd843503          	ld	a0,-40(s0)
    802035bc:	7ee000ef          	jal	ra,80203daa <phys_page_num_to_addr>
    802035c0:	87aa                	mv	a5,a0
    802035c2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:161
  return (uint8_t *)pa.addr;
    802035c6:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:162
}
    802035ca:	853e                	mv	a0,a5
    802035cc:	70a2                	ld	ra,40(sp)
    802035ce:	7402                	ld	s0,32(sp)
    802035d0:	6145                	addi	sp,sp,48
    802035d2:	8082                	ret

00000000802035d4 <map_area_copy_data>:
map_area_copy_data():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:168



static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len) 
{
    802035d4:	711d                	addi	sp,sp,-96
    802035d6:	ec86                	sd	ra,88(sp)
    802035d8:	e8a2                	sd	s0,80(sp)
    802035da:	1080                	addi	s0,sp,96
    802035dc:	faa43c23          	sd	a0,-72(s0)
    802035e0:	fab43823          	sd	a1,-80(s0)
    802035e4:	fac43423          	sd	a2,-88(s0)
    802035e8:	fad43023          	sd	a3,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:169
  uint64_t start = 0;
    802035ec:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:170
  VirtPageNum current_vpn = map_area->vpn_range.start_vpn;
    802035f0:	fb843783          	ld	a5,-72(s0)
    802035f4:	639c                	ld	a5,0(a5)
    802035f6:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:173
  for (;;) {
    PhysPageNum tmp;
    tmp.num = pte_ppn(*page_table_find_pte(pt, current_vpn));
    802035fa:	fc843583          	ld	a1,-56(s0)
    802035fe:	fb043503          	ld	a0,-80(s0)
    80203602:	835ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    80203606:	87aa                	mv	a5,a0
    80203608:	6388                	ld	a0,0(a5)
    8020360a:	cf6ff0ef          	jal	ra,80202b00 <pte_ppn>
    8020360e:	87aa                	mv	a5,a0
    80203610:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:174
    uint8_t *src = &data[start];
    80203614:	fa843703          	ld	a4,-88(s0)
    80203618:	fe843783          	ld	a5,-24(s0)
    8020361c:	97ba                	add	a5,a5,a4
    8020361e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:175
    uint8_t *dst = ppn_get_bytes_array(tmp);
    80203622:	fc043503          	ld	a0,-64(s0)
    80203626:	f87ff0ef          	jal	ra,802035ac <ppn_get_bytes_array>
    8020362a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:176
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    8020362e:	fa043703          	ld	a4,-96(s0)
    80203632:	fe843783          	ld	a5,-24(s0)
    80203636:	40f707b3          	sub	a5,a4,a5
    8020363a:	6705                	lui	a4,0x1
    8020363c:	00f77363          	bgeu	a4,a5,80203642 <map_area_copy_data+0x6e>
    80203640:	6785                	lui	a5,0x1
    80203642:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:177
    memcpy(dst, src, cpy_len);
    80203646:	fd043783          	ld	a5,-48(s0)
    8020364a:	2781                	sext.w	a5,a5
    8020364c:	863e                	mv	a2,a5
    8020364e:	fe043583          	ld	a1,-32(s0)
    80203652:	fd843503          	ld	a0,-40(s0)
    80203656:	894ff0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:178
    start += PAGE_SIZE;
    8020365a:	fe843703          	ld	a4,-24(s0)
    8020365e:	6785                	lui	a5,0x1
    80203660:	97ba                	add	a5,a5,a4
    80203662:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:179
    if (start >= len) {
    80203666:	fe843703          	ld	a4,-24(s0)
    8020366a:	fa043783          	ld	a5,-96(s0)
    8020366e:	00f77863          	bgeu	a4,a5,8020367e <map_area_copy_data+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:182
      break;
    }
    current_vpn.num += 1;
    80203672:	fc843783          	ld	a5,-56(s0)
    80203676:	0785                	addi	a5,a5,1
    80203678:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:171
  for (;;) {
    8020367c:	bfbd                	j	802035fa <map_area_copy_data+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:184
  }
}
    8020367e:	0001                	nop
    80203680:	60e6                	ld	ra,88(sp)
    80203682:	6446                	ld	s0,80(sp)
    80203684:	6125                	addi	sp,sp,96
    80203686:	8082                	ret

0000000080203688 <memory_set_push_pro>:
memory_set_push_pro():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:189


void memory_set_push_pro(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len)
{
    80203688:	7179                	addi	sp,sp,-48
    8020368a:	f406                	sd	ra,40(sp)
    8020368c:	f022                	sd	s0,32(sp)
    8020368e:	1800                	addi	s0,sp,48
    80203690:	fea43423          	sd	a0,-24(s0)
    80203694:	feb43023          	sd	a1,-32(s0)
    80203698:	fcc43c23          	sd	a2,-40(s0)
    8020369c:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:190
    map_area_map(map_area, &memory_set->page_table);
    802036a0:	fe843783          	ld	a5,-24(s0)
    802036a4:	85be                	mv	a1,a5
    802036a6:	fe043503          	ld	a0,-32(s0)
    802036aa:	99bff0ef          	jal	ra,80203044 <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:191
    if (data && len >= 0) 
    802036ae:	fd843783          	ld	a5,-40(s0)
    802036b2:	cf81                	beqz	a5,802036ca <memory_set_push_pro+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:193
    {
        map_area_copy_data(map_area, &memory_set->page_table, data, len);
    802036b4:	fe843783          	ld	a5,-24(s0)
    802036b8:	fd043683          	ld	a3,-48(s0)
    802036bc:	fd843603          	ld	a2,-40(s0)
    802036c0:	85be                	mv	a1,a5
    802036c2:	fe043503          	ld	a0,-32(s0)
    802036c6:	f0fff0ef          	jal	ra,802035d4 <map_area_copy_data>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:195
    }
    vector_add(&memory_set->areas, map_area);
    802036ca:	fe843783          	ld	a5,-24(s0)
    802036ce:	02078793          	addi	a5,a5,32 # 1020 <n+0x1000>
    802036d2:	fe043583          	ld	a1,-32(s0)
    802036d6:	853e                	mv	a0,a5
    802036d8:	189010ef          	jal	ra,80205060 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:196
}
    802036dc:	0001                	nop
    802036de:	70a2                	ld	ra,40(sp)
    802036e0:	7402                	ld	s0,32(sp)
    802036e2:	6145                	addi	sp,sp,48
    802036e4:	8082                	ret

00000000802036e6 <memory_set_from_elf>:
memory_set_from_elf():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:201


void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point) {
    802036e6:	716d                	addi	sp,sp,-272
    802036e8:	e606                	sd	ra,264(sp)
    802036ea:	e222                	sd	s0,256(sp)
    802036ec:	fda6                	sd	s1,248(sp)
    802036ee:	0a00                	addi	s0,sp,272
    802036f0:	81010113          	addi	sp,sp,-2032 # 80219810 <boot_stack_lower_bound+0xf810>
    802036f4:	77fd                	lui	a5,0xfffff
    802036f6:	fe040493          	addi	s1,s0,-32
    802036fa:	97a6                	add	a5,a5,s1
    802036fc:	74a7b423          	sd	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203700:	77fd                	lui	a5,0xfffff
    80203702:	fe040513          	addi	a0,s0,-32
    80203706:	97aa                	add	a5,a5,a0
    80203708:	74b7b023          	sd	a1,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    8020370c:	77fd                	lui	a5,0xfffff
    8020370e:	fe040593          	addi	a1,s0,-32
    80203712:	97ae                	add	a5,a5,a1
    80203714:	72c7bc23          	sd	a2,1848(a5) # fffffffffffff738 <bss_end+0xffffffff7f594738>
    80203718:	77fd                	lui	a5,0xfffff
    8020371a:	fe040613          	addi	a2,s0,-32
    8020371e:	97b2                	add	a5,a5,a2
    80203720:	72d7b823          	sd	a3,1840(a5) # fffffffffffff730 <bss_end+0xffffffff7f594730>
    80203724:	77fd                	lui	a5,0xfffff
    80203726:	fe040693          	addi	a3,s0,-32
    8020372a:	97b6                	add	a5,a5,a3
    8020372c:	72e7b423          	sd	a4,1832(a5) # fffffffffffff728 <bss_end+0xffffffff7f594728>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:202
  memory_set_new_bare(memory_set);
    80203730:	77fd                	lui	a5,0xfffff
    80203732:	fe040713          	addi	a4,s0,-32
    80203736:	97ba                	add	a5,a5,a4
    80203738:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    8020373c:	e31ff0ef          	jal	ra,8020356c <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:205

  // map trampoline
  memory_set_map_trampoline(memory_set);
    80203740:	77fd                	lui	a5,0xfffff
    80203742:	fe040713          	addi	a4,s0,-32
    80203746:	97ba                	add	a5,a5,a4
    80203748:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    8020374c:	ab1ff0ef          	jal	ra,802031fc <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:209

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
    80203750:	77fd                	lui	a5,0xfffff
    80203752:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203756:	fe040713          	addi	a4,s0,-32
    8020375a:	00f706b3          	add	a3,a4,a5
    8020375e:	77fd                	lui	a5,0xfffff
    80203760:	fe040713          	addi	a4,s0,-32
    80203764:	973e                	add	a4,a4,a5
    80203766:	77fd                	lui	a5,0xfffff
    80203768:	fe040613          	addi	a2,s0,-32
    8020376c:	97b2                	add	a5,a5,a2
    8020376e:	8636                	mv	a2,a3
    80203770:	73873583          	ld	a1,1848(a4) # 1738 <n+0x1718>
    80203774:	7407b503          	ld	a0,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    80203778:	f58fe0ef          	jal	ra,80201ed0 <elf_load>
    8020377c:	87aa                	mv	a5,a0
    8020377e:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:210
  if (elf_load_ret != 0) {
    80203782:	fd442783          	lw	a5,-44(s0)
    80203786:	2781                	sext.w	a5,a5
    80203788:	cf99                	beqz	a5,802037a6 <memory_set_from_elf+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:211
    printk("Elf load error.\n");
    8020378a:	00003517          	auipc	a0,0x3
    8020378e:	a5e50513          	addi	a0,a0,-1442 # 802061e8 <rodata_start+0x1e8>
    80203792:	858fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:212
    ASSERT(0);
    80203796:	0d400593          	li	a1,212
    8020379a:	00003517          	auipc	a0,0x3
    8020379e:	a2650513          	addi	a0,a0,-1498 # 802061c0 <rodata_start+0x1c0>
    802037a2:	187000ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:215
  }

  size_t ph_count = elf_header_get_phnum(&elf);
    802037a6:	77fd                	lui	a5,0xfffff
    802037a8:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802037ac:	fe040713          	addi	a4,s0,-32
    802037b0:	97ba                	add	a5,a5,a4
    802037b2:	853e                	mv	a0,a5
    802037b4:	8edfe0ef          	jal	ra,802020a0 <elf_header_get_phnum>
    802037b8:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:221
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn;
  max_end_vpn.num=0;
    802037bc:	77fd                	lui	a5,0xfffff
    802037be:	fe040713          	addi	a4,s0,-32
    802037c2:	97ba                	add	a5,a5,a4
    802037c4:	7607bc23          	sd	zero,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:222
  for (size_t i = 0; i < ph_count; i++) {
    802037c8:	fc043c23          	sd	zero,-40(s0)
    802037cc:	a2fd                	j	802039ba <memory_set_from_elf+0x2d4>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:223
    t_elf_program *ph = &elf.programs[i];
    802037ce:	77fd                	lui	a5,0xfffff
    802037d0:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802037d4:	fe040713          	addi	a4,s0,-32
    802037d8:	973e                	add	a4,a4,a5
    802037da:	fd843783          	ld	a5,-40(s0)
    802037de:	04278793          	addi	a5,a5,66
    802037e2:	0792                	slli	a5,a5,0x4
    802037e4:	97ba                	add	a5,a5,a4
    802037e6:	07a1                	addi	a5,a5,8
    802037e8:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:224
    if (elf_program_get_type(&elf, ph) == PT_LOAD) {
    802037ec:	77fd                	lui	a5,0xfffff
    802037ee:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802037f2:	fe040713          	addi	a4,s0,-32
    802037f6:	97ba                	add	a5,a5,a4
    802037f8:	fc043583          	ld	a1,-64(s0)
    802037fc:	853e                	mv	a0,a5
    802037fe:	c24fe0ef          	jal	ra,80201c22 <elf_program_get_type>
    80203802:	87aa                	mv	a5,a0
    80203804:	2781                	sext.w	a5,a5
    80203806:	873e                	mv	a4,a5
    80203808:	4785                	li	a5,1
    8020380a:	1af71363          	bne	a4,a5,802039b0 <memory_set_from_elf+0x2ca>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:225
      start_va.addr = elf_program_get_vaddr(&elf, ph);
    8020380e:	77fd                	lui	a5,0xfffff
    80203810:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203814:	fe040713          	addi	a4,s0,-32
    80203818:	97ba                	add	a5,a5,a4
    8020381a:	fc043583          	ld	a1,-64(s0)
    8020381e:	853e                	mv	a0,a5
    80203820:	cdafe0ef          	jal	ra,80201cfa <elf_program_get_vaddr>
    80203824:	872a                	mv	a4,a0
    80203826:	77fd                	lui	a5,0xfffff
    80203828:	fe040693          	addi	a3,s0,-32
    8020382c:	97b6                	add	a5,a5,a3
    8020382e:	7ae7b023          	sd	a4,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:226
      end_va.addr = (start_va.addr + (uint64_t)elf_program_get_memsz(&elf, ph));
    80203832:	77fd                	lui	a5,0xfffff
    80203834:	fe040713          	addi	a4,s0,-32
    80203838:	97ba                	add	a5,a5,a4
    8020383a:	7a07b483          	ld	s1,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    8020383e:	77fd                	lui	a5,0xfffff
    80203840:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203844:	fe040713          	addi	a4,s0,-32
    80203848:	97ba                	add	a5,a5,a4
    8020384a:	fc043583          	ld	a1,-64(s0)
    8020384e:	853e                	mv	a0,a5
    80203850:	cf2fe0ef          	jal	ra,80201d42 <elf_program_get_memsz>
    80203854:	87aa                	mv	a5,a0
    80203856:	00f48733          	add	a4,s1,a5
    8020385a:	77fd                	lui	a5,0xfffff
    8020385c:	fe040693          	addi	a3,s0,-32
    80203860:	97b6                	add	a5,a5,a3
    80203862:	78e7bc23          	sd	a4,1944(a5) # fffffffffffff798 <bss_end+0xffffffff7f594798>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:227
      map_perm = MAP_PERM_U;
    80203866:	47c1                	li	a5,16
    80203868:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:228
      ph_flags = elf_program_get_flags(&elf, ph);
    8020386c:	77fd                	lui	a5,0xfffff
    8020386e:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203872:	fe040713          	addi	a4,s0,-32
    80203876:	97ba                	add	a5,a5,a4
    80203878:	fc043583          	ld	a1,-64(s0)
    8020387c:	853e                	mv	a0,a5
    8020387e:	c30fe0ef          	jal	ra,80201cae <elf_program_get_flags>
    80203882:	faa43823          	sd	a0,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:230
      if (ph_flags | PF_R) {
        map_perm |= MAP_PERM_R;
    80203886:	fbc42783          	lw	a5,-68(s0)
    8020388a:	0027e793          	ori	a5,a5,2
    8020388e:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:233
      }
      if (ph_flags | PF_W) {
        map_perm |= MAP_PERM_W;
    80203892:	fbc42783          	lw	a5,-68(s0)
    80203896:	0047e793          	ori	a5,a5,4
    8020389a:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:236
      }
      if (ph_flags | PF_X) {
        map_perm |= MAP_PERM_X;
    8020389e:	fbc42783          	lw	a5,-68(s0)
    802038a2:	0087e793          	ori	a5,a5,8
    802038a6:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:238
      }
      map_area.vpn_range.start_vpn = virt_addr_to_page_num(start_va,0);
    802038aa:	77fd                	lui	a5,0xfffff
    802038ac:	fe040713          	addi	a4,s0,-32
    802038b0:	00f704b3          	add	s1,a4,a5
    802038b4:	77fd                	lui	a5,0xfffff
    802038b6:	fe040713          	addi	a4,s0,-32
    802038ba:	97ba                	add	a5,a5,a4
    802038bc:	4581                	li	a1,0
    802038be:	7a07b503          	ld	a0,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    802038c2:	490000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    802038c6:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:239
      map_area.vpn_range.size = virt_addr_to_page_num(start_va,0).num-virt_addr_to_page_num(end_va,1).num+1;
    802038ca:	77fd                	lui	a5,0xfffff
    802038cc:	fe040713          	addi	a4,s0,-32
    802038d0:	97ba                	add	a5,a5,a4
    802038d2:	4581                	li	a1,0
    802038d4:	7a07b503          	ld	a0,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    802038d8:	47a000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    802038dc:	87aa                	mv	a5,a0
    802038de:	84be                	mv	s1,a5
    802038e0:	77fd                	lui	a5,0xfffff
    802038e2:	fe040713          	addi	a4,s0,-32
    802038e6:	97ba                	add	a5,a5,a4
    802038e8:	4585                	li	a1,1
    802038ea:	7987b503          	ld	a0,1944(a5) # fffffffffffff798 <bss_end+0xffffffff7f594798>
    802038ee:	464000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    802038f2:	87aa                	mv	a5,a0
    802038f4:	40f487b3          	sub	a5,s1,a5
    802038f8:	00178713          	addi	a4,a5,1
    802038fc:	77fd                	lui	a5,0xfffff
    802038fe:	fe040693          	addi	a3,s0,-32
    80203902:	97b6                	add	a5,a5,a3
    80203904:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:240
      map_area.map_type = MAP_FRAMED;
    80203908:	77fd                	lui	a5,0xfffff
    8020390a:	fe040713          	addi	a4,s0,-32
    8020390e:	97ba                	add	a5,a5,a4
    80203910:	4705                	li	a4,1
    80203912:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:241
      map_area.map_premission = map_perm;
    80203916:	77fd                	lui	a5,0xfffff
    80203918:	fe040713          	addi	a4,s0,-32
    8020391c:	97ba                	add	a5,a5,a4
    8020391e:	fbc42703          	lw	a4,-68(s0)
    80203922:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:242
      max_end_vpn.num = map_area.vpn_range.start_vpn.num + map_area.vpn_range.size-1;
    80203926:	77fd                	lui	a5,0xfffff
    80203928:	fe040713          	addi	a4,s0,-32
    8020392c:	97ba                	add	a5,a5,a4
    8020392e:	7807b703          	ld	a4,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203932:	77fd                	lui	a5,0xfffff
    80203934:	fe040693          	addi	a3,s0,-32
    80203938:	97b6                	add	a5,a5,a3
    8020393a:	7887b783          	ld	a5,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
    8020393e:	97ba                	add	a5,a5,a4
    80203940:	fff78713          	addi	a4,a5,-1
    80203944:	77fd                	lui	a5,0xfffff
    80203946:	fe040693          	addi	a3,s0,-32
    8020394a:	97b6                	add	a5,a5,a3
    8020394c:	76e7bc23          	sd	a4,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:244
      memory_set_push_pro(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
    80203950:	77fd                	lui	a5,0xfffff
    80203952:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203956:	fe040713          	addi	a4,s0,-32
    8020395a:	97ba                	add	a5,a5,a4
    8020395c:	fc043583          	ld	a1,-64(s0)
    80203960:	853e                	mv	a0,a5
    80203962:	b04fe0ef          	jal	ra,80201c66 <elf_program_get_offset>
    80203966:	872a                	mv	a4,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:243
      memory_set_push_pro(memory_set, &map_area,
    80203968:	77fd                	lui	a5,0xfffff
    8020396a:	fe040693          	addi	a3,s0,-32
    8020396e:	97b6                	add	a5,a5,a3
    80203970:	7407b783          	ld	a5,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    80203974:	00e784b3          	add	s1,a5,a4
    80203978:	77fd                	lui	a5,0xfffff
    8020397a:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    8020397e:	fe040713          	addi	a4,s0,-32
    80203982:	97ba                	add	a5,a5,a4
    80203984:	fc043583          	ld	a1,-64(s0)
    80203988:	853e                	mv	a0,a5
    8020398a:	c00fe0ef          	jal	ra,80201d8a <elf_program_get_filesz>
    8020398e:	86aa                	mv	a3,a0
    80203990:	77fd                	lui	a5,0xfffff
    80203992:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203996:	fe040713          	addi	a4,s0,-32
    8020399a:	973e                	add	a4,a4,a5
    8020399c:	77fd                	lui	a5,0xfffff
    8020399e:	fe040613          	addi	a2,s0,-32
    802039a2:	97b2                	add	a5,a5,a2
    802039a4:	8626                	mv	a2,s1
    802039a6:	85ba                	mv	a1,a4
    802039a8:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    802039ac:	cddff0ef          	jal	ra,80203688 <memory_set_push_pro>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:222 (discriminator 2)
  for (size_t i = 0; i < ph_count; i++) {
    802039b0:	fd843783          	ld	a5,-40(s0)
    802039b4:	0785                	addi	a5,a5,1
    802039b6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:222 (discriminator 1)
    802039ba:	fd843703          	ld	a4,-40(s0)
    802039be:	fc843783          	ld	a5,-56(s0)
    802039c2:	e0f766e3          	bltu	a4,a5,802037ce <memory_set_from_elf+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:250
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = virt_page_num_to_addr(max_end_vpn);
    802039c6:	77fd                	lui	a5,0xfffff
    802039c8:	fe040713          	addi	a4,s0,-32
    802039cc:	97ba                	add	a5,a5,a4
    802039ce:	7787b503          	ld	a0,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
    802039d2:	3c0000ef          	jal	ra,80203d92 <virt_page_num_to_addr>
    802039d6:	872a                	mv	a4,a0
    802039d8:	77fd                	lui	a5,0xfffff
    802039da:	fe040693          	addi	a3,s0,-32
    802039de:	97b6                	add	a5,a5,a3
    802039e0:	76e7b823          	sd	a4,1904(a5) # fffffffffffff770 <bss_end+0xffffffff7f594770>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:251
  VirtAddr user_stack_bottom = max_end_va;
    802039e4:	77fd                	lui	a5,0xfffff
    802039e6:	fe040713          	addi	a4,s0,-32
    802039ea:	97ba                	add	a5,a5,a4
    802039ec:	777d                	lui	a4,0xfffff
    802039ee:	fe040693          	addi	a3,s0,-32
    802039f2:	9736                	add	a4,a4,a3
    802039f4:	77073703          	ld	a4,1904(a4) # fffffffffffff770 <bss_end+0xffffffff7f594770>
    802039f8:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:253
  // guard page
  user_stack_bottom.addr += PAGE_SIZE;
    802039fc:	77fd                	lui	a5,0xfffff
    802039fe:	fe040713          	addi	a4,s0,-32
    80203a02:	97ba                	add	a5,a5,a4
    80203a04:	7687b703          	ld	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203a08:	6785                	lui	a5,0x1
    80203a0a:	973e                	add	a4,a4,a5
    80203a0c:	77fd                	lui	a5,0xfffff
    80203a0e:	fe040693          	addi	a3,s0,-32
    80203a12:	97b6                	add	a5,a5,a3
    80203a14:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:255
  VirtAddr user_stack_top;
  user_stack_top.addr = user_stack_bottom.addr + USER_STACK_SIZE;
    80203a18:	77fd                	lui	a5,0xfffff
    80203a1a:	fe040713          	addi	a4,s0,-32
    80203a1e:	97ba                	add	a5,a5,a4
    80203a20:	7687b703          	ld	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203a24:	6789                	lui	a5,0x2
    80203a26:	973e                	add	a4,a4,a5
    80203a28:	77fd                	lui	a5,0xfffff
    80203a2a:	fe040693          	addi	a3,s0,-32
    80203a2e:	97b6                	add	a5,a5,a3
    80203a30:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:256
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(user_stack_bottom,0);
    80203a34:	77fd                	lui	a5,0xfffff
    80203a36:	fe040713          	addi	a4,s0,-32
    80203a3a:	00f704b3          	add	s1,a4,a5
    80203a3e:	77fd                	lui	a5,0xfffff
    80203a40:	fe040713          	addi	a4,s0,-32
    80203a44:	97ba                	add	a5,a5,a4
    80203a46:	4581                	li	a1,0
    80203a48:	7687b503          	ld	a0,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203a4c:	306000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203a50:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:257
  map_area.vpn_range.size = virt_addr_to_page_num(user_stack_top,1).num - map_area.vpn_range.start_vpn.num+1;
    80203a54:	77fd                	lui	a5,0xfffff
    80203a56:	fe040713          	addi	a4,s0,-32
    80203a5a:	97ba                	add	a5,a5,a4
    80203a5c:	4585                	li	a1,1
    80203a5e:	7607b503          	ld	a0,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
    80203a62:	2f0000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203a66:	87aa                	mv	a5,a0
    80203a68:	873e                	mv	a4,a5
    80203a6a:	77fd                	lui	a5,0xfffff
    80203a6c:	fe040693          	addi	a3,s0,-32
    80203a70:	97b6                	add	a5,a5,a3
    80203a72:	7807b783          	ld	a5,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203a76:	40f707b3          	sub	a5,a4,a5
    80203a7a:	00178713          	addi	a4,a5,1
    80203a7e:	77fd                	lui	a5,0xfffff
    80203a80:	fe040693          	addi	a3,s0,-32
    80203a84:	97b6                	add	a5,a5,a3
    80203a86:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:258
  map_area.map_type = MAP_FRAMED;
    80203a8a:	77fd                	lui	a5,0xfffff
    80203a8c:	fe040713          	addi	a4,s0,-32
    80203a90:	97ba                	add	a5,a5,a4
    80203a92:	4705                	li	a4,1
    80203a94:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:259
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
    80203a98:	77fd                	lui	a5,0xfffff
    80203a9a:	fe040713          	addi	a4,s0,-32
    80203a9e:	97ba                	add	a5,a5,a4
    80203aa0:	4759                	li	a4,22
    80203aa2:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:260
  memory_set_push(memory_set, &map_area);
    80203aa6:	77fd                	lui	a5,0xfffff
    80203aa8:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203aac:	fe040713          	addi	a4,s0,-32
    80203ab0:	973e                	add	a4,a4,a5
    80203ab2:	77fd                	lui	a5,0xfffff
    80203ab4:	fe040693          	addi	a3,s0,-32
    80203ab8:	97b6                	add	a5,a5,a3
    80203aba:	85ba                	mv	a1,a4
    80203abc:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203ac0:	e64ff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:262
    VirtAddr t2;
    t2.addr = TRAP_CONTEXT;
    80203ac4:	77fd                	lui	a5,0xfffff
    80203ac6:	fe040713          	addi	a4,s0,-32
    80203aca:	97ba                	add	a5,a5,a4
    80203acc:	04000737          	lui	a4,0x4000
    80203ad0:	177d                	addi	a4,a4,-1
    80203ad2:	0736                	slli	a4,a4,0xd
    80203ad4:	74e7bc23          	sd	a4,1880(a5) # fffffffffffff758 <bss_end+0xffffffff7f594758>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:264
  // map TrapContext
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(t2,0);
    80203ad8:	77fd                	lui	a5,0xfffff
    80203ada:	fe040713          	addi	a4,s0,-32
    80203ade:	00f704b3          	add	s1,a4,a5
    80203ae2:	77fd                	lui	a5,0xfffff
    80203ae4:	fe040713          	addi	a4,s0,-32
    80203ae8:	97ba                	add	a5,a5,a4
    80203aea:	4581                	li	a1,0
    80203aec:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <bss_end+0xffffffff7f594758>
    80203af0:	262000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203af4:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:266
  VirtAddr t1;
  t1.addr = TRAMPOLINE;
    80203af8:	77fd                	lui	a5,0xfffff
    80203afa:	fe040713          	addi	a4,s0,-32
    80203afe:	97ba                	add	a5,a5,a4
    80203b00:	08000737          	lui	a4,0x8000
    80203b04:	177d                	addi	a4,a4,-1
    80203b06:	0732                	slli	a4,a4,0xc
    80203b08:	74e7b823          	sd	a4,1872(a5) # fffffffffffff750 <bss_end+0xffffffff7f594750>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:267
  map_area.vpn_range.size = virt_addr_to_page_num(t1,1).num - map_area.vpn_range.start_vpn.num + 1;
    80203b0c:	77fd                	lui	a5,0xfffff
    80203b0e:	fe040713          	addi	a4,s0,-32
    80203b12:	97ba                	add	a5,a5,a4
    80203b14:	4585                	li	a1,1
    80203b16:	7507b503          	ld	a0,1872(a5) # fffffffffffff750 <bss_end+0xffffffff7f594750>
    80203b1a:	238000ef          	jal	ra,80203d52 <virt_addr_to_page_num>
    80203b1e:	87aa                	mv	a5,a0
    80203b20:	873e                	mv	a4,a5
    80203b22:	77fd                	lui	a5,0xfffff
    80203b24:	fe040693          	addi	a3,s0,-32
    80203b28:	97b6                	add	a5,a5,a3
    80203b2a:	7807b783          	ld	a5,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203b2e:	40f707b3          	sub	a5,a4,a5
    80203b32:	00178713          	addi	a4,a5,1
    80203b36:	77fd                	lui	a5,0xfffff
    80203b38:	fe040693          	addi	a3,s0,-32
    80203b3c:	97b6                	add	a5,a5,a3
    80203b3e:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:268
  map_area.map_type = MAP_FRAMED;
    80203b42:	77fd                	lui	a5,0xfffff
    80203b44:	fe040713          	addi	a4,s0,-32
    80203b48:	97ba                	add	a5,a5,a4
    80203b4a:	4705                	li	a4,1
    80203b4c:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:269
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W;
    80203b50:	77fd                	lui	a5,0xfffff
    80203b52:	fe040713          	addi	a4,s0,-32
    80203b56:	97ba                	add	a5,a5,a4
    80203b58:	4719                	li	a4,6
    80203b5a:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:270
  memory_set_push(memory_set, &map_area);
    80203b5e:	77fd                	lui	a5,0xfffff
    80203b60:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203b64:	fe040713          	addi	a4,s0,-32
    80203b68:	973e                	add	a4,a4,a5
    80203b6a:	77fd                	lui	a5,0xfffff
    80203b6c:	fe040693          	addi	a3,s0,-32
    80203b70:	97b6                	add	a5,a5,a3
    80203b72:	85ba                	mv	a1,a4
    80203b74:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203b78:	dacff0ef          	jal	ra,80203124 <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:273

  // return
  *user_sp = (uint64_t)user_stack_top.addr;
    80203b7c:	77fd                	lui	a5,0xfffff
    80203b7e:	fe040713          	addi	a4,s0,-32
    80203b82:	97ba                	add	a5,a5,a4
    80203b84:	7607b703          	ld	a4,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
    80203b88:	77fd                	lui	a5,0xfffff
    80203b8a:	fe040693          	addi	a3,s0,-32
    80203b8e:	97b6                	add	a5,a5,a3
    80203b90:	7307b783          	ld	a5,1840(a5) # fffffffffffff730 <bss_end+0xffffffff7f594730>
    80203b94:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:274
  *entry_point = elf_header_get_entry(&elf);
    80203b96:	77fd                	lui	a5,0xfffff
    80203b98:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203b9c:	fe040713          	addi	a4,s0,-32
    80203ba0:	97ba                	add	a5,a5,a4
    80203ba2:	853e                	mv	a0,a5
    80203ba4:	f6ffd0ef          	jal	ra,80201b12 <elf_header_get_entry>
    80203ba8:	872a                	mv	a4,a0
    80203baa:	77fd                	lui	a5,0xfffff
    80203bac:	fe040693          	addi	a3,s0,-32
    80203bb0:	97b6                	add	a5,a5,a3
    80203bb2:	7287b783          	ld	a5,1832(a5) # fffffffffffff728 <bss_end+0xffffffff7f594728>
    80203bb6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:275
}
    80203bb8:	0001                	nop
    80203bba:	7f010113          	addi	sp,sp,2032
    80203bbe:	60b2                	ld	ra,264(sp)
    80203bc0:	6412                	ld	s0,256(sp)
    80203bc2:	74ee                	ld	s1,248(sp)
    80203bc4:	6151                	addi	sp,sp,272
    80203bc6:	8082                	ret

0000000080203bc8 <frame_allocator_init>:
frame_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:13
// @param allocator 分配器的指针
// @param start 可用物理页帧的起始页号
// @param end 可用物理页帧的结束页号（不包括此页号）
extern uint8_t ekernel;
void frame_allocator_init() 
{
    80203bc8:	1101                	addi	sp,sp,-32
    80203bca:	ec06                	sd	ra,24(sp)
    80203bcc:	e822                	sd	s0,16(sp)
    80203bce:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:15
  PhysAddr start_addr;
  start_addr.addr =(size_t)&ekernel; // Manually constructing PhysAddr
    80203bd0:	00867797          	auipc	a5,0x867
    80203bd4:	43078793          	addi	a5,a5,1072 # 80a6b000 <bss_end>
    80203bd8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:17
  PhysAddr end_addr;                 // Manually constructing PhysAddr
  end_addr.addr = (size_t)MEMORY_END;
    80203bdc:	10100793          	li	a5,257
    80203be0:	07de                	slli	a5,a5,0x17
    80203be2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:18
  fram_allocator.current = phys_addr_to_page_num(start_addr,0).num;
    80203be6:	4581                	li	a1,0
    80203be8:	fe843503          	ld	a0,-24(s0)
    80203bec:	126000ef          	jal	ra,80203d12 <phys_addr_to_page_num>
    80203bf0:	87aa                	mv	a5,a0
    80203bf2:	873e                	mv	a4,a5
    80203bf4:	00816797          	auipc	a5,0x816
    80203bf8:	44c78793          	addi	a5,a5,1100 # 80a1a040 <fram_allocator>
    80203bfc:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:19
  fram_allocator.end = phys_addr_to_page_num(end_addr,1).num;
    80203bfe:	4585                	li	a1,1
    80203c00:	fe043503          	ld	a0,-32(s0)
    80203c04:	10e000ef          	jal	ra,80203d12 <phys_addr_to_page_num>
    80203c08:	87aa                	mv	a5,a0
    80203c0a:	873e                	mv	a4,a5
    80203c0c:	00816797          	auipc	a5,0x816
    80203c10:	43478793          	addi	a5,a5,1076 # 80a1a040 <fram_allocator>
    80203c14:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:20
  vector_init(&fram_allocator.recycled);
    80203c16:	00816517          	auipc	a0,0x816
    80203c1a:	43a50513          	addi	a0,a0,1082 # 80a1a050 <fram_allocator+0x10>
    80203c1e:	3a2010ef          	jal	ra,80204fc0 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:21
}
    80203c22:	0001                	nop
    80203c24:	60e2                	ld	ra,24(sp)
    80203c26:	6442                	ld	s0,16(sp)
    80203c28:	6105                	addi	sp,sp,32
    80203c2a:	8082                	ret

0000000080203c2c <StackFrameAllocator_alloc>:
StackFrameAllocator_alloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:26

// 分配一个物理页帧
// @param allocator 分配器的指针
// @return 分配的物理页号，如果内存耗尽则返回特殊值(size_t)-1
PhysPageNum StackFrameAllocator_alloc(StackFrameAllocator* allocator) {
    80203c2c:	7139                	addi	sp,sp,-64
    80203c2e:	fc06                	sd	ra,56(sp)
    80203c30:	f822                	sd	s0,48(sp)
    80203c32:	0080                	addi	s0,sp,64
    80203c34:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:27
    if (vector_total(&allocator->recycled) > 0) {
    80203c38:	fc843783          	ld	a5,-56(s0)
    80203c3c:	07c1                	addi	a5,a5,16
    80203c3e:	853e                	mv	a0,a5
    80203c40:	3bc010ef          	jal	ra,80204ffc <vector_total>
    80203c44:	87aa                	mv	a5,a0
    80203c46:	c7a1                	beqz	a5,80203c8e <StackFrameAllocator_alloc+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:29
        // 如果回收向量中有页号，优先从回收向量中分配
        size_t index = vector_total(&allocator->recycled) - 1; // 获取最后一个元素的索引
    80203c48:	fc843783          	ld	a5,-56(s0)
    80203c4c:	07c1                	addi	a5,a5,16
    80203c4e:	853e                	mv	a0,a5
    80203c50:	3ac010ef          	jal	ra,80204ffc <vector_total>
    80203c54:	87aa                	mv	a5,a0
    80203c56:	17fd                	addi	a5,a5,-1
    80203c58:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:30
        void* item = vector_get(&allocator->recycled, index); // 获取并移除最后一个元素
    80203c5c:	fc843783          	ld	a5,-56(s0)
    80203c60:	07c1                	addi	a5,a5,16
    80203c62:	fe843583          	ld	a1,-24(s0)
    80203c66:	853e                	mv	a0,a5
    80203c68:	454010ef          	jal	ra,802050bc <vector_get>
    80203c6c:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:31
        PhysPageNum ppn = { (size_t)item }; // 将void*转换回物理页号
    80203c70:	fe043783          	ld	a5,-32(s0)
    80203c74:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:32
        vector_delete(&allocator->recycled, index); // 从向量中删除该元素
    80203c78:	fc843783          	ld	a5,-56(s0)
    80203c7c:	07c1                	addi	a5,a5,16
    80203c7e:	fe843583          	ld	a1,-24(s0)
    80203c82:	853e                	mv	a0,a5
    80203c84:	470010ef          	jal	ra,802050f4 <vector_delete>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:33
        return ppn;
    80203c88:	fd843783          	ld	a5,-40(s0)
    80203c8c:	a03d                	j	80203cba <StackFrameAllocator_alloc+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:34
    } else if (allocator->current < allocator->end) {
    80203c8e:	fc843783          	ld	a5,-56(s0)
    80203c92:	6398                	ld	a4,0(a5)
    80203c94:	fc843783          	ld	a5,-56(s0)
    80203c98:	679c                	ld	a5,8(a5)
    80203c9a:	00f77f63          	bgeu	a4,a5,80203cb8 <StackFrameAllocator_alloc+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:36
        // 如果回收向量为空，且当前还有未分配的页，则从当前可用的页号中分配
        PhysPageNum ppn = { allocator->current++ }; // 分配当前页号，并将current指向下一个页号
    80203c9e:	fc843783          	ld	a5,-56(s0)
    80203ca2:	639c                	ld	a5,0(a5)
    80203ca4:	00178693          	addi	a3,a5,1
    80203ca8:	fc843703          	ld	a4,-56(s0)
    80203cac:	e314                	sd	a3,0(a4)
    80203cae:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:37
        return ppn;
    80203cb2:	fd043783          	ld	a5,-48(s0)
    80203cb6:	a011                	j	80203cba <StackFrameAllocator_alloc+0x8e>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:40
    } else {
        // 如果没有可分配的页号，则返回一个特殊值表示内存耗尽
        return (PhysPageNum){ (size_t)-1 };
    80203cb8:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:42 (discriminator 1)
    }
}
    80203cba:	853e                	mv	a0,a5
    80203cbc:	70e2                	ld	ra,56(sp)
    80203cbe:	7442                	ld	s0,48(sp)
    80203cc0:	6121                	addi	sp,sp,64
    80203cc2:	8082                	ret

0000000080203cc4 <StackFrameAllocator_dealloc>:
StackFrameAllocator_dealloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:47

// 回收一个物理页帧
// @param allocator 分配器的指针
// @param ppn 要回收的物理页号
void StackFrameAllocator_dealloc(StackFrameAllocator* allocator, PhysPageNum ppn) {
    80203cc4:	1101                	addi	sp,sp,-32
    80203cc6:	ec06                	sd	ra,24(sp)
    80203cc8:	e822                	sd	s0,16(sp)
    80203cca:	1000                	addi	s0,sp,32
    80203ccc:	fea43423          	sd	a0,-24(s0)
    80203cd0:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:49
    // 将回收的物理页号添加到回收向量中，将物理页号转换为void*进行存储
    vector_add(&allocator->recycled, (void*)(uintptr_t)ppn.num);
    80203cd4:	fe843783          	ld	a5,-24(s0)
    80203cd8:	07c1                	addi	a5,a5,16
    80203cda:	fe043703          	ld	a4,-32(s0)
    80203cde:	85ba                	mv	a1,a4
    80203ce0:	853e                	mv	a0,a5
    80203ce2:	37e010ef          	jal	ra,80205060 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:50
}
    80203ce6:	0001                	nop
    80203ce8:	60e2                	ld	ra,24(sp)
    80203cea:	6442                	ld	s0,16(sp)
    80203cec:	6105                	addi	sp,sp,32
    80203cee:	8082                	ret

0000000080203cf0 <StackFrameAllocator_free>:
StackFrameAllocator_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:54

// 释放栈式物理页帧分配器使用的资源
// @param allocator 分配器的指针
void StackFrameAllocator_free(StackFrameAllocator* allocator) {
    80203cf0:	1101                	addi	sp,sp,-32
    80203cf2:	ec06                	sd	ra,24(sp)
    80203cf4:	e822                	sd	s0,16(sp)
    80203cf6:	1000                	addi	s0,sp,32
    80203cf8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:56
    // 释放存储回收页号的向量占用的内存
    vector_free(&allocator->recycled);
    80203cfc:	fe843783          	ld	a5,-24(s0)
    80203d00:	07c1                	addi	a5,a5,16
    80203d02:	853e                	mv	a0,a5
    80203d04:	4c0010ef          	jal	ra,802051c4 <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:57
}
    80203d08:	0001                	nop
    80203d0a:	60e2                	ld	ra,24(sp)
    80203d0c:	6442                	ld	s0,16(sp)
    80203d0e:	6105                	addi	sp,sp,32
    80203d10:	8082                	ret

0000000080203d12 <phys_addr_to_page_num>:
phys_addr_to_page_num():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:4
#include "address.h"

// 将物理地址转换为物理页号
PhysPageNum phys_addr_to_page_num(PhysAddr addr, AlignDirection direction) {
    80203d12:	7179                	addi	sp,sp,-48
    80203d14:	f422                	sd	s0,40(sp)
    80203d16:	1800                	addi	s0,sp,48
    80203d18:	fca43c23          	sd	a0,-40(s0)
    80203d1c:	87ae                	mv	a5,a1
    80203d1e:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:6
    size_t num;
    if (direction == ALIGN_DOWN) {
    80203d22:	fd442783          	lw	a5,-44(s0)
    80203d26:	2781                	sext.w	a5,a5
    80203d28:	e799                	bnez	a5,80203d36 <phys_addr_to_page_num+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:8
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    80203d2a:	fd843783          	ld	a5,-40(s0)
    80203d2e:	83b1                	srli	a5,a5,0xc
    80203d30:	fef43423          	sd	a5,-24(s0)
    80203d34:	a809                	j	80203d46 <phys_addr_to_page_num+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:11
    } else {
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    80203d36:	fd843703          	ld	a4,-40(s0)
    80203d3a:	6785                	lui	a5,0x1
    80203d3c:	17fd                	addi	a5,a5,-1
    80203d3e:	97ba                	add	a5,a5,a4
    80203d40:	83b1                	srli	a5,a5,0xc
    80203d42:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:13
    }
    return (PhysPageNum){.num = num};
    80203d46:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:14
}
    80203d4a:	853e                	mv	a0,a5
    80203d4c:	7422                	ld	s0,40(sp)
    80203d4e:	6145                	addi	sp,sp,48
    80203d50:	8082                	ret

0000000080203d52 <virt_addr_to_page_num>:
virt_addr_to_page_num():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:17

// 将虚拟地址转换为虚拟页号
VirtPageNum virt_addr_to_page_num(VirtAddr addr, AlignDirection direction) {
    80203d52:	7179                	addi	sp,sp,-48
    80203d54:	f422                	sd	s0,40(sp)
    80203d56:	1800                	addi	s0,sp,48
    80203d58:	fca43c23          	sd	a0,-40(s0)
    80203d5c:	87ae                	mv	a5,a1
    80203d5e:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:19
    size_t num;
    if (direction == ALIGN_DOWN) {
    80203d62:	fd442783          	lw	a5,-44(s0)
    80203d66:	2781                	sext.w	a5,a5
    80203d68:	e799                	bnez	a5,80203d76 <virt_addr_to_page_num+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:21
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    80203d6a:	fd843783          	ld	a5,-40(s0)
    80203d6e:	83b1                	srli	a5,a5,0xc
    80203d70:	fef43423          	sd	a5,-24(s0)
    80203d74:	a809                	j	80203d86 <virt_addr_to_page_num+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:24
    } else { // ALIGN_UP
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    80203d76:	fd843703          	ld	a4,-40(s0)
    80203d7a:	6785                	lui	a5,0x1
    80203d7c:	17fd                	addi	a5,a5,-1
    80203d7e:	97ba                	add	a5,a5,a4
    80203d80:	83b1                	srli	a5,a5,0xc
    80203d82:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:26
    }
    return (VirtPageNum){.num = num};
    80203d86:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:27
}
    80203d8a:	853e                	mv	a0,a5
    80203d8c:	7422                	ld	s0,40(sp)
    80203d8e:	6145                	addi	sp,sp,48
    80203d90:	8082                	ret

0000000080203d92 <virt_page_num_to_addr>:
virt_page_num_to_addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:30

// 将虚拟页号转换为虚拟地址
VirtAddr virt_page_num_to_addr(VirtPageNum vpn) {
    80203d92:	1101                	addi	sp,sp,-32
    80203d94:	ec22                	sd	s0,24(sp)
    80203d96:	1000                	addi	s0,sp,32
    80203d98:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:32
    // 计算页号对应的虚拟地址起始位置
    return (VirtAddr){.addr = vpn.num << PAGE_SIZE_BITS};
    80203d9c:	fe843783          	ld	a5,-24(s0)
    80203da0:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:33
}
    80203da2:	853e                	mv	a0,a5
    80203da4:	6462                	ld	s0,24(sp)
    80203da6:	6105                	addi	sp,sp,32
    80203da8:	8082                	ret

0000000080203daa <phys_page_num_to_addr>:
phys_page_num_to_addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:36

// 将物理页号转换为物理地址
PhysAddr phys_page_num_to_addr(PhysPageNum ppn) {
    80203daa:	1101                	addi	sp,sp,-32
    80203dac:	ec22                	sd	s0,24(sp)
    80203dae:	1000                	addi	s0,sp,32
    80203db0:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:38
    // 计算页号对应的物理地址起始位置
    return (PhysAddr){.addr = ppn.num << PAGE_SIZE_BITS};
    80203db4:	fe843783          	ld	a5,-24(s0)
    80203db8:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:39
}
    80203dba:	853e                	mv	a0,a5
    80203dbc:	6462                	ld	s0,24(sp)
    80203dbe:	6105                	addi	sp,sp,32
    80203dc0:	8082                	ret

0000000080203dc2 <decompose_vpn>:
decompose_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:43

// 解析虚拟页号，获取页内偏移及三级页表中各级的索引
uint64_t* decompose_vpn(uint64_t vpn) 
{
    80203dc2:	7139                	addi	sp,sp,-64
    80203dc4:	fc22                	sd	s0,56(sp)
    80203dc6:	0080                	addi	s0,sp,64
    80203dc8:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:46
    static uint64_t result[4];
    // 获取页内偏移
    uint64_t page_offset = vpn & OFFSET_MASK;
    80203dcc:	fc843703          	ld	a4,-56(s0)
    80203dd0:	6785                	lui	a5,0x1
    80203dd2:	17fd                	addi	a5,a5,-1
    80203dd4:	8ff9                	and	a5,a5,a4
    80203dd6:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:48
    // 移除偏移位，准备解析索引
    vpn >>= PAGE_SIZE_BITS;
    80203dda:	fc843783          	ld	a5,-56(s0)
    80203dde:	83b1                	srli	a5,a5,0xc
    80203de0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:50
    // 解析L3索引
    uint64_t l3 = vpn & INDEX_MASK;
    80203de4:	fc843783          	ld	a5,-56(s0)
    80203de8:	1ff7f793          	andi	a5,a5,511
    80203dec:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:51
    vpn >>= INDEX_BITS;
    80203df0:	fc843783          	ld	a5,-56(s0)
    80203df4:	83a5                	srli	a5,a5,0x9
    80203df6:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:53
    // 解析L2索引
    uint64_t l2 = vpn & INDEX_MASK;
    80203dfa:	fc843783          	ld	a5,-56(s0)
    80203dfe:	1ff7f793          	andi	a5,a5,511
    80203e02:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:54
    vpn >>= INDEX_BITS;
    80203e06:	fc843783          	ld	a5,-56(s0)
    80203e0a:	83a5                	srli	a5,a5,0x9
    80203e0c:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:56
    // 解析L1索引
    uint64_t l1 = vpn & INDEX_MASK;
    80203e10:	fc843783          	ld	a5,-56(s0)
    80203e14:	1ff7f793          	andi	a5,a5,511
    80203e18:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:57
    result[0] = l1;
    80203e1c:	00816797          	auipc	a5,0x816
    80203e20:	24c78793          	addi	a5,a5,588 # 80a1a068 <result.0>
    80203e24:	fd043703          	ld	a4,-48(s0)
    80203e28:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:58
    result[1] = l2;
    80203e2a:	00816797          	auipc	a5,0x816
    80203e2e:	23e78793          	addi	a5,a5,574 # 80a1a068 <result.0>
    80203e32:	fd843703          	ld	a4,-40(s0)
    80203e36:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:59
    result[2] = l3;
    80203e38:	00816797          	auipc	a5,0x816
    80203e3c:	23078793          	addi	a5,a5,560 # 80a1a068 <result.0>
    80203e40:	fe043703          	ld	a4,-32(s0)
    80203e44:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:60
    result[3] = page_offset;
    80203e46:	00816797          	auipc	a5,0x816
    80203e4a:	22278793          	addi	a5,a5,546 # 80a1a068 <result.0>
    80203e4e:	fe843703          	ld	a4,-24(s0)
    80203e52:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:61
    return result;
    80203e54:	00816797          	auipc	a5,0x816
    80203e58:	21478793          	addi	a5,a5,532 # 80a1a068 <result.0>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:62
}
    80203e5c:	853e                	mv	a0,a5
    80203e5e:	7462                	ld	s0,56(sp)
    80203e60:	6121                	addi	sp,sp,64
    80203e62:	8082                	ret

0000000080203e64 <print_str>:
print_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:3
#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    80203e64:	1101                	addi	sp,sp,-32
    80203e66:	ec06                	sd	ra,24(sp)
    80203e68:	e822                	sd	s0,16(sp)
    80203e6a:	1000                	addi	s0,sp,32
    80203e6c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) {
    80203e70:	a829                	j	80203e8a <print_str+0x26>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:5
        console_putchar((uint64_t)(*str));
    80203e72:	fe843783          	ld	a5,-24(s0)
    80203e76:	0007c783          	lbu	a5,0(a5)
    80203e7a:	853e                	mv	a0,a5
    80203e7c:	c18fe0ef          	jal	ra,80202294 <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:6
        str++;
    80203e80:	fe843783          	ld	a5,-24(s0)
    80203e84:	0785                	addi	a5,a5,1
    80203e86:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) {
    80203e8a:	fe843783          	ld	a5,-24(s0)
    80203e8e:	0007c783          	lbu	a5,0(a5)
    80203e92:	f3e5                	bnez	a5,80203e72 <print_str+0xe>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:8
    }
}
    80203e94:	0001                	nop
    80203e96:	0001                	nop
    80203e98:	60e2                	ld	ra,24(sp)
    80203e9a:	6442                	ld	s0,16(sp)
    80203e9c:	6105                	addi	sp,sp,32
    80203e9e:	8082                	ret

0000000080203ea0 <reverse_str>:
reverse_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:10

void reverse_str(char* str, int length) {
    80203ea0:	7179                	addi	sp,sp,-48
    80203ea2:	f422                	sd	s0,40(sp)
    80203ea4:	1800                	addi	s0,sp,48
    80203ea6:	fca43c23          	sd	a0,-40(s0)
    80203eaa:	87ae                	mv	a5,a1
    80203eac:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:11
    int start = 0;
    80203eb0:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:12
    int end = length - 1;
    80203eb4:	fd442783          	lw	a5,-44(s0)
    80203eb8:	37fd                	addiw	a5,a5,-1
    80203eba:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    while (start < end) {
    80203ebe:	a899                	j	80203f14 <reverse_str+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
        char temp = str[start];
    80203ec0:	fec42783          	lw	a5,-20(s0)
    80203ec4:	fd843703          	ld	a4,-40(s0)
    80203ec8:	97ba                	add	a5,a5,a4
    80203eca:	0007c783          	lbu	a5,0(a5)
    80203ece:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:15
        str[start] = str[end];
    80203ed2:	fe842783          	lw	a5,-24(s0)
    80203ed6:	fd843703          	ld	a4,-40(s0)
    80203eda:	973e                	add	a4,a4,a5
    80203edc:	fec42783          	lw	a5,-20(s0)
    80203ee0:	fd843683          	ld	a3,-40(s0)
    80203ee4:	97b6                	add	a5,a5,a3
    80203ee6:	00074703          	lbu	a4,0(a4) # 8000000 <n+0x7ffffe0>
    80203eea:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:16
        str[end] = temp;
    80203eee:	fe842783          	lw	a5,-24(s0)
    80203ef2:	fd843703          	ld	a4,-40(s0)
    80203ef6:	97ba                	add	a5,a5,a4
    80203ef8:	fe744703          	lbu	a4,-25(s0)
    80203efc:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:17
        start++;
    80203f00:	fec42783          	lw	a5,-20(s0)
    80203f04:	2785                	addiw	a5,a5,1
    80203f06:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:18
        end--;
    80203f0a:	fe842783          	lw	a5,-24(s0)
    80203f0e:	37fd                	addiw	a5,a5,-1
    80203f10:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    while (start < end) {
    80203f14:	fec42703          	lw	a4,-20(s0)
    80203f18:	fe842783          	lw	a5,-24(s0)
    80203f1c:	2701                	sext.w	a4,a4
    80203f1e:	2781                	sext.w	a5,a5
    80203f20:	faf740e3          	blt	a4,a5,80203ec0 <reverse_str+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:20
    }
}
    80203f24:	0001                	nop
    80203f26:	0001                	nop
    80203f28:	7422                	ld	s0,40(sp)
    80203f2a:	6145                	addi	sp,sp,48
    80203f2c:	8082                	ret

0000000080203f2e <print_uint32>:
print_uint32():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:22

void print_uint32(uint32_t value) {
    80203f2e:	7139                	addi	sp,sp,-64
    80203f30:	fc06                	sd	ra,56(sp)
    80203f32:	f822                	sd	s0,48(sp)
    80203f34:	0080                	addi	s0,sp,64
    80203f36:	87aa                	mv	a5,a0
    80203f38:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:24
    char buffer[12];
    int i = 0;
    80203f3c:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:25
    if (value == 0) {
    80203f40:	fcc42783          	lw	a5,-52(s0)
    80203f44:	2781                	sext.w	a5,a5
    80203f46:	e3ad                	bnez	a5,80203fa8 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:26
        buffer[i++] = '0';
    80203f48:	fec42783          	lw	a5,-20(s0)
    80203f4c:	0017871b          	addiw	a4,a5,1
    80203f50:	fee42623          	sw	a4,-20(s0)
    80203f54:	ff040713          	addi	a4,s0,-16
    80203f58:	97ba                	add	a5,a5,a4
    80203f5a:	03000713          	li	a4,48
    80203f5e:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:28
    }
    while (value != 0) {
    80203f62:	a099                	j	80203fa8 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
        int digit = value % 10;
    80203f64:	fcc42703          	lw	a4,-52(s0)
    80203f68:	47a9                	li	a5,10
    80203f6a:	02f777bb          	remuw	a5,a4,a5
    80203f6e:	2781                	sext.w	a5,a5
    80203f70:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:30
        buffer[i++] = digit + '0';
    80203f74:	fe842783          	lw	a5,-24(s0)
    80203f78:	0ff7f713          	andi	a4,a5,255
    80203f7c:	fec42783          	lw	a5,-20(s0)
    80203f80:	0017869b          	addiw	a3,a5,1
    80203f84:	fed42623          	sw	a3,-20(s0)
    80203f88:	0307071b          	addiw	a4,a4,48
    80203f8c:	0ff77713          	andi	a4,a4,255
    80203f90:	ff040693          	addi	a3,s0,-16
    80203f94:	97b6                	add	a5,a5,a3
    80203f96:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:31
        value /= 10;
    80203f9a:	fcc42703          	lw	a4,-52(s0)
    80203f9e:	47a9                	li	a5,10
    80203fa0:	02f757bb          	divuw	a5,a4,a5
    80203fa4:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:28
    while (value != 0) {
    80203fa8:	fcc42783          	lw	a5,-52(s0)
    80203fac:	2781                	sext.w	a5,a5
    80203fae:	fbdd                	bnez	a5,80203f64 <print_uint32+0x36>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:33
    }
    buffer[i] = '\0';
    80203fb0:	fec42783          	lw	a5,-20(s0)
    80203fb4:	ff040713          	addi	a4,s0,-16
    80203fb8:	97ba                	add	a5,a5,a4
    80203fba:	fe078423          	sb	zero,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:34
    reverse_str(buffer, i);
    80203fbe:	fec42703          	lw	a4,-20(s0)
    80203fc2:	fd840793          	addi	a5,s0,-40
    80203fc6:	85ba                	mv	a1,a4
    80203fc8:	853e                	mv	a0,a5
    80203fca:	ed7ff0ef          	jal	ra,80203ea0 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:35
    print_str(buffer);
    80203fce:	fd840793          	addi	a5,s0,-40
    80203fd2:	853e                	mv	a0,a5
    80203fd4:	e91ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:36
}
    80203fd8:	0001                	nop
    80203fda:	70e2                	ld	ra,56(sp)
    80203fdc:	7442                	ld	s0,48(sp)
    80203fde:	6121                	addi	sp,sp,64
    80203fe0:	8082                	ret

0000000080203fe2 <print_uint64>:
print_uint64():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:38

void print_uint64(uint64_t value) {
    80203fe2:	7139                	addi	sp,sp,-64
    80203fe4:	fc06                	sd	ra,56(sp)
    80203fe6:	f822                	sd	s0,48(sp)
    80203fe8:	0080                	addi	s0,sp,64
    80203fea:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:40
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    80203fee:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:41
    if (value == 0) {
    80203ff2:	fc843783          	ld	a5,-56(s0)
    80203ff6:	e3a5                	bnez	a5,80204056 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:42
        buffer[i++] = '0';
    80203ff8:	fec42783          	lw	a5,-20(s0)
    80203ffc:	0017871b          	addiw	a4,a5,1
    80204000:	fee42623          	sw	a4,-20(s0)
    80204004:	ff040713          	addi	a4,s0,-16
    80204008:	97ba                	add	a5,a5,a4
    8020400a:	03000713          	li	a4,48
    8020400e:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:44
    }
    while (value != 0) {
    80204012:	a091                	j	80204056 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:45
        int digit = value % 10;
    80204014:	fc843703          	ld	a4,-56(s0)
    80204018:	47a9                	li	a5,10
    8020401a:	02f777b3          	remu	a5,a4,a5
    8020401e:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:46
        buffer[i++] = digit + '0';
    80204022:	fe842783          	lw	a5,-24(s0)
    80204026:	0ff7f713          	andi	a4,a5,255
    8020402a:	fec42783          	lw	a5,-20(s0)
    8020402e:	0017869b          	addiw	a3,a5,1
    80204032:	fed42623          	sw	a3,-20(s0)
    80204036:	0307071b          	addiw	a4,a4,48
    8020403a:	0ff77713          	andi	a4,a4,255
    8020403e:	ff040693          	addi	a3,s0,-16
    80204042:	97b6                	add	a5,a5,a3
    80204044:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
        value /= 10;
    80204048:	fc843703          	ld	a4,-56(s0)
    8020404c:	47a9                	li	a5,10
    8020404e:	02f757b3          	divu	a5,a4,a5
    80204052:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:44
    while (value != 0) {
    80204056:	fc843783          	ld	a5,-56(s0)
    8020405a:	ffcd                	bnez	a5,80204014 <print_uint64+0x32>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:49
    }
    buffer[i] = '\0';
    8020405c:	fec42783          	lw	a5,-20(s0)
    80204060:	ff040713          	addi	a4,s0,-16
    80204064:	97ba                	add	a5,a5,a4
    80204066:	fe078023          	sb	zero,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:50
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    8020406a:	fec42703          	lw	a4,-20(s0)
    8020406e:	fd040793          	addi	a5,s0,-48
    80204072:	85ba                	mv	a1,a4
    80204074:	853e                	mv	a0,a5
    80204076:	e2bff0ef          	jal	ra,80203ea0 <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:51
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
    8020407a:	fd040793          	addi	a5,s0,-48
    8020407e:	853e                	mv	a0,a5
    80204080:	de5ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:52
}
    80204084:	0001                	nop
    80204086:	70e2                	ld	ra,56(sp)
    80204088:	7442                	ld	s0,48(sp)
    8020408a:	6121                	addi	sp,sp,64
    8020408c:	8082                	ret

000000008020408e <print_uint64_hex>:
print_uint64_hex():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:55

void print_uint64_hex(uint64_t value) 
{
    8020408e:	7179                	addi	sp,sp,-48
    80204090:	f406                	sd	ra,40(sp)
    80204092:	f022                	sd	s0,32(sp)
    80204094:	1800                	addi	s0,sp,48
    80204096:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:56
    print_str("0x"); // 打印十六进制前缀
    8020409a:	00002517          	auipc	a0,0x2
    8020409e:	16650513          	addi	a0,a0,358 # 80206200 <rodata_start+0x200>
    802040a2:	dc3ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57
    for (int i = 15; i >= 0; i--) 
    802040a6:	47bd                	li	a5,15
    802040a8:	fef42623          	sw	a5,-20(s0)
    802040ac:	a09d                	j	80204112 <print_uint64_hex+0x84>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:59
    {
        int digit = (value >> (i * 4)) & 0xF; // 获取每个十六进制位
    802040ae:	fec42783          	lw	a5,-20(s0)
    802040b2:	0027979b          	slliw	a5,a5,0x2
    802040b6:	2781                	sext.w	a5,a5
    802040b8:	873e                	mv	a4,a5
    802040ba:	fd843783          	ld	a5,-40(s0)
    802040be:	00e7d7b3          	srl	a5,a5,a4
    802040c2:	2781                	sext.w	a5,a5
    802040c4:	8bbd                	andi	a5,a5,15
    802040c6:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60
        char hex = digit < 10 ? '0' + digit : 'A' + digit - 10; // 转换为字符
    802040ca:	fe842783          	lw	a5,-24(s0)
    802040ce:	0007871b          	sext.w	a4,a5
    802040d2:	47a5                	li	a5,9
    802040d4:	00e7cb63          	blt	a5,a4,802040ea <print_uint64_hex+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 1)
    802040d8:	fe842783          	lw	a5,-24(s0)
    802040dc:	0ff7f793          	andi	a5,a5,255
    802040e0:	0307879b          	addiw	a5,a5,48
    802040e4:	0ff7f793          	andi	a5,a5,255
    802040e8:	a809                	j	802040fa <print_uint64_hex+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 2)
    802040ea:	fe842783          	lw	a5,-24(s0)
    802040ee:	0ff7f793          	andi	a5,a5,255
    802040f2:	0377879b          	addiw	a5,a5,55
    802040f6:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 4)
    802040fa:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 4)
        console_putchar((uint64_t)hex); // 输出字符
    802040fe:	fe744783          	lbu	a5,-25(s0)
    80204102:	853e                	mv	a0,a5
    80204104:	990fe0ef          	jal	ra,80202294 <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57 (discriminator 4)
    for (int i = 15; i >= 0; i--) 
    80204108:	fec42783          	lw	a5,-20(s0)
    8020410c:	37fd                	addiw	a5,a5,-1
    8020410e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57 (discriminator 2)
    80204112:	fec42783          	lw	a5,-20(s0)
    80204116:	2781                	sext.w	a5,a5
    80204118:	f807dbe3          	bgez	a5,802040ae <print_uint64_hex+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:63
    }
    8020411c:	0001                	nop
    8020411e:	0001                	nop
    80204120:	70a2                	ld	ra,40(sp)
    80204122:	7402                	ld	s0,32(sp)
    80204124:	6145                	addi	sp,sp,48
    80204126:	8082                	ret

0000000080204128 <panic>:
panic():
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:3
#include "console.h"
#include "sbi.h"
void panic(const char *file, int line) {
    80204128:	1101                	addi	sp,sp,-32
    8020412a:	ec06                	sd	ra,24(sp)
    8020412c:	e822                	sd	s0,16(sp)
    8020412e:	1000                	addi	s0,sp,32
    80204130:	fea43423          	sd	a0,-24(s0)
    80204134:	87ae                	mv	a5,a1
    80204136:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:4
    print_str("Panic! File: ");
    8020413a:	00002517          	auipc	a0,0x2
    8020413e:	0ce50513          	addi	a0,a0,206 # 80206208 <rodata_start+0x208>
    80204142:	d23ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:5
    print_str(file);
    80204146:	fe843503          	ld	a0,-24(s0)
    8020414a:	d1bff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:6
    print_str(", Line: ");
    8020414e:	00002517          	auipc	a0,0x2
    80204152:	0ca50513          	addi	a0,a0,202 # 80206218 <rodata_start+0x218>
    80204156:	d0fff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:7
    print_uint32(line);
    8020415a:	fe442783          	lw	a5,-28(s0)
    8020415e:	853e                	mv	a0,a5
    80204160:	dcfff0ef          	jal	ra,80203f2e <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:8
    print_str("\n");
    80204164:	00002517          	auipc	a0,0x2
    80204168:	0c450513          	addi	a0,a0,196 # 80206228 <rodata_start+0x228>
    8020416c:	cf9ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:9
    sbi_shutdown();
    80204170:	96afe0ef          	jal	ra,802022da <sbi_shutdown>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:10 (discriminator 1)
    while(1);
    80204174:	a001                	j	80204174 <panic+0x4c>

0000000080204176 <task_manager_init>:
task_manager_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:13
struct TaskManager task_manager;
extern void __switch(struct TaskContext*,struct TaskContext*);
extern uint64_t _num_app[];

void task_manager_init( void )
{
    80204176:	7129                	addi	sp,sp,-320
    80204178:	fe06                	sd	ra,312(sp)
    8020417a:	fa22                	sd	s0,304(sp)
    8020417c:	0280                	addi	s0,sp,320
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:16

    extern void __restore(uint64_t);
    print_str("[Test] __restore: ");
    8020417e:	00002517          	auipc	a0,0x2
    80204182:	0b250513          	addi	a0,a0,178 # 80206230 <rodata_start+0x230>
    80204186:	cdfff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:17
    print_uint64((uint64_t)__restore);
    8020418a:	00001797          	auipc	a5,0x1
    8020418e:	12e78793          	addi	a5,a5,302 # 802052b8 <__restore>
    80204192:	853e                	mv	a0,a5
    80204194:	e4fff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:18
    print_str("\n");
    80204198:	00002517          	auipc	a0,0x2
    8020419c:	0b050513          	addi	a0,a0,176 # 80206248 <rodata_start+0x248>
    802041a0:	cc5ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:19
    task_manager.num_task = MAX_APP_NUM;
    802041a4:	00816797          	auipc	a5,0x816
    802041a8:	ee478793          	addi	a5,a5,-284 # 80a1a088 <task_manager>
    802041ac:	4751                	li	a4,20
    802041ae:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:20
    task_manager.current_task = 0;
    802041b0:	00816797          	auipc	a5,0x816
    802041b4:	ed878793          	addi	a5,a5,-296 # 80a1a088 <task_manager>
    802041b8:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23

    // 初始化TCB
    for(uint64_t i = 0; i < app_manager.app_num; i ++)
    802041bc:	fe043423          	sd	zero,-24(s0)
    802041c0:	a8d1                	j	80204294 <task_manager_init+0x11e>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:27 (discriminator 3)
    {

        // 获取kernel_stack压入TrapContext后的地址
        uint64_t target_sp = get_kernel_stack_top(i) - sizeof(struct TrapContext);
    802041c2:	fe843503          	ld	a0,-24(s0)
    802041c6:	6c2000ef          	jal	ra,80204888 <get_kernel_stack_top>
    802041ca:	87aa                	mv	a5,a0
    802041cc:	ef078793          	addi	a5,a5,-272
    802041d0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:28 (discriminator 3)
        task_manager.tasks[i].task_status = Ready; // 设置app状态
    802041d4:	00816697          	auipc	a3,0x816
    802041d8:	eb468693          	addi	a3,a3,-332 # 80a1a088 <task_manager>
    802041dc:	fe843703          	ld	a4,-24(s0)
    802041e0:	87ba                	mv	a5,a4
    802041e2:	0792                	slli	a5,a5,0x4
    802041e4:	8f99                	sub	a5,a5,a4
    802041e6:	078e                	slli	a5,a5,0x3
    802041e8:	97b6                	add	a5,a5,a3
    802041ea:	4705                	li	a4,1
    802041ec:	08e7a023          	sw	a4,128(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:29 (discriminator 3)
        task_manager.tasks[i].task_cx.ra = (uint64_t)__restore; // 设置switch函数返回地址
    802041f0:	00001697          	auipc	a3,0x1
    802041f4:	0c868693          	addi	a3,a3,200 # 802052b8 <__restore>
    802041f8:	00816617          	auipc	a2,0x816
    802041fc:	e9060613          	addi	a2,a2,-368 # 80a1a088 <task_manager>
    80204200:	fe843703          	ld	a4,-24(s0)
    80204204:	87ba                	mv	a5,a4
    80204206:	0792                	slli	a5,a5,0x4
    80204208:	8f99                	sub	a5,a5,a4
    8020420a:	078e                	slli	a5,a5,0x3
    8020420c:	97b2                	add	a5,a5,a2
    8020420e:	eb94                	sd	a3,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:30 (discriminator 3)
        task_manager.tasks[i].task_cx.sp = target_sp; // 设置各自kernel_stack位置
    80204210:	00816697          	auipc	a3,0x816
    80204214:	e7868693          	addi	a3,a3,-392 # 80a1a088 <task_manager>
    80204218:	fe843703          	ld	a4,-24(s0)
    8020421c:	87ba                	mv	a5,a4
    8020421e:	0792                	slli	a5,a5,0x4
    80204220:	8f99                	sub	a5,a5,a4
    80204222:	078e                	slli	a5,a5,0x3
    80204224:	97b6                	add	a5,a5,a3
    80204226:	fe043703          	ld	a4,-32(s0)
    8020422a:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:33 (discriminator 3)

        /* 初始化kernel_stack */
        struct TrapContext tc = {
    8020422c:	ec840793          	addi	a5,s0,-312
    80204230:	11000713          	li	a4,272
    80204234:	863a                	mv	a2,a4
    80204236:	4581                	li	a1,0
    80204238:	853e                	mv	a0,a5
    8020423a:	cfefe0ef          	jal	ra,80202738 <memset>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:38 (discriminator 3)
            {0},
            0,
            0
        };
        tc.sepc = APP_BASE_ADDRESS + (APP_SIZE_LIMIT * i); // 设置app首次进入的地址
    8020423e:	fe843703          	ld	a4,-24(s0)
    80204242:	6791                	lui	a5,0x4
    80204244:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    80204248:	97ba                	add	a5,a5,a4
    8020424a:	07c6                	slli	a5,a5,0x11
    8020424c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:39 (discriminator 3)
        tc.sstatus = READ_CSR(sstatus) & (~SSTATUS_SPP); // 设置sstatus寄存器为内核状态
    80204250:	100027f3          	csrr	a5,sstatus
    80204254:	fcf43c23          	sd	a5,-40(s0)
    80204258:	fd843783          	ld	a5,-40(s0)
    8020425c:	eff7f793          	andi	a5,a5,-257
    80204260:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:40 (discriminator 3)
        tc.x[2] = (uint64_t)get_user_stack_top(i); // 保证sscratch指向user_stack
    80204264:	fe843503          	ld	a0,-24(s0)
    80204268:	64a000ef          	jal	ra,802048b2 <get_user_stack_top>
    8020426c:	87aa                	mv	a5,a0
    8020426e:	ecf43c23          	sd	a5,-296(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42 (discriminator 3)
        // 将TrapContext压入kernel_stack
        *(struct TrapContext *)target_sp = tc;
    80204272:	fe043783          	ld	a5,-32(s0)
    80204276:	86be                	mv	a3,a5
    80204278:	ec840793          	addi	a5,s0,-312
    8020427c:	11000713          	li	a4,272
    80204280:	863a                	mv	a2,a4
    80204282:	85be                	mv	a1,a5
    80204284:	8536                	mv	a0,a3
    80204286:	c64fe0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23 (discriminator 3)
    for(uint64_t i = 0; i < app_manager.app_num; i ++)
    8020428a:	fe843783          	ld	a5,-24(s0)
    8020428e:	0785                	addi	a5,a5,1
    80204290:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23 (discriminator 1)
    80204294:	00816797          	auipc	a5,0x816
    80204298:	7d478793          	addi	a5,a5,2004 # 80a1aa68 <app_manager>
    8020429c:	639c                	ld	a5,0(a5)
    8020429e:	fe843703          	ld	a4,-24(s0)
    802042a2:	f2f760e3          	bltu	a4,a5,802041c2 <task_manager_init+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:44
    }
}
    802042a6:	0001                	nop
    802042a8:	0001                	nop
    802042aa:	70f2                	ld	ra,312(sp)
    802042ac:	7452                	ld	s0,304(sp)
    802042ae:	6131                	addi	sp,sp,320
    802042b0:	8082                	ret

00000000802042b2 <run_next_task>:
run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:48


void run_next_task(uint64_t status) 
{
    802042b2:	7139                	addi	sp,sp,-64
    802042b4:	fc06                	sd	ra,56(sp)
    802042b6:	f822                	sd	s0,48(sp)
    802042b8:	0080                	addi	s0,sp,64
    802042ba:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51
    /* 寻找ready的task */
    uint64_t target_task_num;
    for (target_task_num = (task_manager.current_task + 1) % MAX_APP_NUM; target_task_num != task_manager.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    802042be:	00816797          	auipc	a5,0x816
    802042c2:	dca78793          	addi	a5,a5,-566 # 80a1a088 <task_manager>
    802042c6:	679c                	ld	a5,8(a5)
    802042c8:	00178713          	addi	a4,a5,1
    802042cc:	47d1                	li	a5,20
    802042ce:	02f777b3          	remu	a5,a4,a5
    802042d2:	fef43423          	sd	a5,-24(s0)
    802042d6:	a81d                	j	8020430c <run_next_task+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:52
        if (task_manager.tasks[target_task_num].task_status == Ready) {
    802042d8:	00816697          	auipc	a3,0x816
    802042dc:	db068693          	addi	a3,a3,-592 # 80a1a088 <task_manager>
    802042e0:	fe843703          	ld	a4,-24(s0)
    802042e4:	87ba                	mv	a5,a4
    802042e6:	0792                	slli	a5,a5,0x4
    802042e8:	8f99                	sub	a5,a5,a4
    802042ea:	078e                	slli	a5,a5,0x3
    802042ec:	97b6                	add	a5,a5,a3
    802042ee:	0807a783          	lw	a5,128(a5)
    802042f2:	873e                	mv	a4,a5
    802042f4:	4785                	li	a5,1
    802042f6:	02f70563          	beq	a4,a5,80204320 <run_next_task+0x6e>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51 (discriminator 2)
    for (target_task_num = (task_manager.current_task + 1) % MAX_APP_NUM; target_task_num != task_manager.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    802042fa:	fe843783          	ld	a5,-24(s0)
    802042fe:	00178713          	addi	a4,a5,1
    80204302:	47d1                	li	a5,20
    80204304:	02f777b3          	remu	a5,a4,a5
    80204308:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51 (discriminator 1)
    8020430c:	00816797          	auipc	a5,0x816
    80204310:	d7c78793          	addi	a5,a5,-644 # 80a1a088 <task_manager>
    80204314:	679c                	ld	a5,8(a5)
    80204316:	fe843703          	ld	a4,-24(s0)
    8020431a:	faf71fe3          	bne	a4,a5,802042d8 <run_next_task+0x26>
    8020431e:	a011                	j	80204322 <run_next_task+0x70>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:53
            break;
    80204320:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:57
        }
    }
    // 没有ready的任务
    if ((target_task_num == task_manager.current_task) && (task_manager.tasks[target_task_num].task_status != Ready)) {
    80204322:	00816797          	auipc	a5,0x816
    80204326:	d6678793          	addi	a5,a5,-666 # 80a1a088 <task_manager>
    8020432a:	679c                	ld	a5,8(a5)
    8020432c:	fe843703          	ld	a4,-24(s0)
    80204330:	02f71b63          	bne	a4,a5,80204366 <run_next_task+0xb4>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:57 (discriminator 1)
    80204334:	00816697          	auipc	a3,0x816
    80204338:	d5468693          	addi	a3,a3,-684 # 80a1a088 <task_manager>
    8020433c:	fe843703          	ld	a4,-24(s0)
    80204340:	87ba                	mv	a5,a4
    80204342:	0792                	slli	a5,a5,0x4
    80204344:	8f99                	sub	a5,a5,a4
    80204346:	078e                	slli	a5,a5,0x3
    80204348:	97b6                	add	a5,a5,a3
    8020434a:	0807a783          	lw	a5,128(a5)
    8020434e:	873e                	mv	a4,a5
    80204350:	4785                	li	a5,1
    80204352:	00f70a63          	beq	a4,a5,80204366 <run_next_task+0xb4>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:58 (discriminator 1)
        ASSERT(0);
    80204356:	03a00593          	li	a1,58
    8020435a:	00002517          	auipc	a0,0x2
    8020435e:	ef650513          	addi	a0,a0,-266 # 80206250 <rodata_start+0x250>
    80204362:	dc7ff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:61
    }

    struct TaskControlBlock* target_task_tcb = &task_manager.tasks[target_task_num];
    80204366:	fe843703          	ld	a4,-24(s0)
    8020436a:	87ba                	mv	a5,a4
    8020436c:	0792                	slli	a5,a5,0x4
    8020436e:	8f99                	sub	a5,a5,a4
    80204370:	078e                	slli	a5,a5,0x3
    80204372:	01078713          	addi	a4,a5,16
    80204376:	00816797          	auipc	a5,0x816
    8020437a:	d1278793          	addi	a5,a5,-750 # 80a1a088 <task_manager>
    8020437e:	97ba                	add	a5,a5,a4
    80204380:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:62
    struct TaskControlBlock* current_task_tcb = &task_manager.tasks[task_manager.current_task];
    80204384:	00816797          	auipc	a5,0x816
    80204388:	d0478793          	addi	a5,a5,-764 # 80a1a088 <task_manager>
    8020438c:	6798                	ld	a4,8(a5)
    8020438e:	87ba                	mv	a5,a4
    80204390:	0792                	slli	a5,a5,0x4
    80204392:	8f99                	sub	a5,a5,a4
    80204394:	078e                	slli	a5,a5,0x3
    80204396:	01078713          	addi	a4,a5,16
    8020439a:	00816797          	auipc	a5,0x816
    8020439e:	cee78793          	addi	a5,a5,-786 # 80a1a088 <task_manager>
    802043a2:	97ba                	add	a5,a5,a4
    802043a4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:65

    /* 改变状态 */
    current_task_tcb->task_status = status;
    802043a8:	fc843783          	ld	a5,-56(s0)
    802043ac:	0007871b          	sext.w	a4,a5
    802043b0:	fd843783          	ld	a5,-40(s0)
    802043b4:	dbb8                	sw	a4,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:66
    target_task_tcb->task_status = Running;
    802043b6:	fe043783          	ld	a5,-32(s0)
    802043ba:	4709                	li	a4,2
    802043bc:	dbb8                	sw	a4,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:67
    task_manager.current_task = target_task_num;
    802043be:	00816797          	auipc	a5,0x816
    802043c2:	cca78793          	addi	a5,a5,-822 # 80a1a088 <task_manager>
    802043c6:	fe843703          	ld	a4,-24(s0)
    802043ca:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:70

    /* 交换TaskContext */
    __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
    802043cc:	fd843783          	ld	a5,-40(s0)
    802043d0:	fe043703          	ld	a4,-32(s0)
    802043d4:	85ba                	mv	a1,a4
    802043d6:	853e                	mv	a0,a5
    802043d8:	73b000ef          	jal	ra,80205312 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:71
}
    802043dc:	0001                	nop
    802043de:	70e2                	ld	ra,56(sp)
    802043e0:	7442                	ld	s0,48(sp)
    802043e2:	6121                	addi	sp,sp,64
    802043e4:	8082                	ret

00000000802043e6 <run_first_task>:
run_first_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:75


void run_first_task(void) 
{
    802043e6:	1141                	addi	sp,sp,-16
    802043e8:	e406                	sd	ra,8(sp)
    802043ea:	e022                	sd	s0,0(sp)
    802043ec:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:77
    static struct TaskContext temp;
    task_manager.tasks[task_manager.current_task].task_status = Running;
    802043ee:	00816797          	auipc	a5,0x816
    802043f2:	c9a78793          	addi	a5,a5,-870 # 80a1a088 <task_manager>
    802043f6:	6798                	ld	a4,8(a5)
    802043f8:	00816697          	auipc	a3,0x816
    802043fc:	c9068693          	addi	a3,a3,-880 # 80a1a088 <task_manager>
    80204400:	87ba                	mv	a5,a4
    80204402:	0792                	slli	a5,a5,0x4
    80204404:	8f99                	sub	a5,a5,a4
    80204406:	078e                	slli	a5,a5,0x3
    80204408:	97b6                	add	a5,a5,a3
    8020440a:	4709                	li	a4,2
    8020440c:	08e7a023          	sw	a4,128(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:78
    print_str("[kernel] ready to run first app\n");
    80204410:	00002517          	auipc	a0,0x2
    80204414:	e6050513          	addi	a0,a0,-416 # 80206270 <rodata_start+0x270>
    80204418:	a4dff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:79
    __switch(&temp, &task_manager.tasks[task_manager.current_task].task_cx);
    8020441c:	00816797          	auipc	a5,0x816
    80204420:	c6c78793          	addi	a5,a5,-916 # 80a1a088 <task_manager>
    80204424:	6798                	ld	a4,8(a5)
    80204426:	87ba                	mv	a5,a4
    80204428:	0792                	slli	a5,a5,0x4
    8020442a:	8f99                	sub	a5,a5,a4
    8020442c:	078e                	slli	a5,a5,0x3
    8020442e:	01078713          	addi	a4,a5,16
    80204432:	00816797          	auipc	a5,0x816
    80204436:	c5678793          	addi	a5,a5,-938 # 80a1a088 <task_manager>
    8020443a:	97ba                	add	a5,a5,a4
    8020443c:	85be                	mv	a1,a5
    8020443e:	00816517          	auipc	a0,0x816
    80204442:	5ba50513          	addi	a0,a0,1466 # 80a1a9f8 <temp.0>
    80204446:	6cd000ef          	jal	ra,80205312 <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:80
    ASSERT(0);
    8020444a:	05000593          	li	a1,80
    8020444e:	00002517          	auipc	a0,0x2
    80204452:	e0250513          	addi	a0,a0,-510 # 80206250 <rodata_start+0x250>
    80204456:	cd3ff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:81
    8020445a:	0001                	nop
    8020445c:	60a2                	ld	ra,8(sp)
    8020445e:	6402                	ld	s0,0(sp)
    80204460:	0141                	addi	sp,sp,16
    80204462:	8082                	ret

0000000080204464 <init_appmanager>:
init_appmanager():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:13

struct AppManager app_manager;


void init_appmanager()
{
    80204464:	1101                	addi	sp,sp,-32
    80204466:	ec06                	sd	ra,24(sp)
    80204468:	e822                	sd	s0,16(sp)
    8020446a:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:14
    app_manager.app_num = _num_app[0];
    8020446c:	00003797          	auipc	a5,0x3
    80204470:	b9478793          	addi	a5,a5,-1132 # 80207000 <_num_app>
    80204474:	6398                	ld	a4,0(a5)
    80204476:	00816797          	auipc	a5,0x816
    8020447a:	5f278793          	addi	a5,a5,1522 # 80a1aa68 <app_manager>
    8020447e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80204480:	fe043423          	sd	zero,-24(s0)
    80204484:	a085                	j	802044e4 <init_appmanager+0x80>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:17 (discriminator 3)
    {
        app_manager.app_start[i] = _num_app[1 + i * 2];
    80204486:	fe843783          	ld	a5,-24(s0)
    8020448a:	0786                	slli	a5,a5,0x1
    8020448c:	0785                	addi	a5,a5,1
    8020448e:	00003717          	auipc	a4,0x3
    80204492:	b7270713          	addi	a4,a4,-1166 # 80207000 <_num_app>
    80204496:	078e                	slli	a5,a5,0x3
    80204498:	97ba                	add	a5,a5,a4
    8020449a:	6398                	ld	a4,0(a5)
    8020449c:	00816697          	auipc	a3,0x816
    802044a0:	5cc68693          	addi	a3,a3,1484 # 80a1aa68 <app_manager>
    802044a4:	fe843783          	ld	a5,-24(s0)
    802044a8:	0789                	addi	a5,a5,2
    802044aa:	078e                	slli	a5,a5,0x3
    802044ac:	97b6                	add	a5,a5,a3
    802044ae:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:18 (discriminator 3)
        app_manager.app_end[i] = _num_app[2 + i * 2];
    802044b0:	fe843783          	ld	a5,-24(s0)
    802044b4:	0785                	addi	a5,a5,1
    802044b6:	0786                	slli	a5,a5,0x1
    802044b8:	00003717          	auipc	a4,0x3
    802044bc:	b4870713          	addi	a4,a4,-1208 # 80207000 <_num_app>
    802044c0:	078e                	slli	a5,a5,0x3
    802044c2:	97ba                	add	a5,a5,a4
    802044c4:	6398                	ld	a4,0(a5)
    802044c6:	00816697          	auipc	a3,0x816
    802044ca:	5a268693          	addi	a3,a3,1442 # 80a1aa68 <app_manager>
    802044ce:	fe843783          	ld	a5,-24(s0)
    802044d2:	07d9                	addi	a5,a5,22
    802044d4:	078e                	slli	a5,a5,0x3
    802044d6:	97b6                	add	a5,a5,a3
    802044d8:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 3)
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    802044da:	fe843783          	ld	a5,-24(s0)
    802044de:	0785                	addi	a5,a5,1
    802044e0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 1)
    802044e4:	00816797          	auipc	a5,0x816
    802044e8:	58478793          	addi	a5,a5,1412 # 80a1aa68 <app_manager>
    802044ec:	639c                	ld	a5,0(a5)
    802044ee:	fe843703          	ld	a4,-24(s0)
    802044f2:	f8f76ae3          	bltu	a4,a5,80204486 <init_appmanager+0x22>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:20
    }
    app_manager.current_app = 0;
    802044f6:	00816797          	auipc	a5,0x816
    802044fa:	57278793          	addi	a5,a5,1394 # 80a1aa68 <app_manager>
    802044fe:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:21
    print_app_info(&app_manager);
    80204502:	00816517          	auipc	a0,0x816
    80204506:	56650513          	addi	a0,a0,1382 # 80a1aa68 <app_manager>
    8020450a:	00e000ef          	jal	ra,80204518 <print_app_info>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:22
}
    8020450e:	0001                	nop
    80204510:	60e2                	ld	ra,24(sp)
    80204512:	6442                	ld	s0,16(sp)
    80204514:	6105                	addi	sp,sp,32
    80204516:	8082                	ret

0000000080204518 <print_app_info>:
print_app_info():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:25


void print_app_info(struct AppManager *manager) {
    80204518:	7179                	addi	sp,sp,-48
    8020451a:	f406                	sd	ra,40(sp)
    8020451c:	f022                	sd	s0,32(sp)
    8020451e:	1800                	addi	s0,sp,48
    80204520:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:26
    print_str("Total applications: ");
    80204524:	00002517          	auipc	a0,0x2
    80204528:	d7450513          	addi	a0,a0,-652 # 80206298 <rodata_start+0x298>
    8020452c:	939ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:27
    print_uint64(manager->app_num);
    80204530:	fd843783          	ld	a5,-40(s0)
    80204534:	639c                	ld	a5,0(a5)
    80204536:	853e                	mv	a0,a5
    80204538:	aabff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:28
    print_str("\n");
    8020453c:	00002517          	auipc	a0,0x2
    80204540:	d7450513          	addi	a0,a0,-652 # 802062b0 <rodata_start+0x2b0>
    80204544:	921ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30

    for (uint64_t i = 0; i < manager->app_num; ++i) {
    80204548:	fe043423          	sd	zero,-24(s0)
    8020454c:	a885                	j	802045bc <print_app_info+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:31 (discriminator 3)
        print_str("App ");
    8020454e:	00002517          	auipc	a0,0x2
    80204552:	d6a50513          	addi	a0,a0,-662 # 802062b8 <rodata_start+0x2b8>
    80204556:	90fff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:32 (discriminator 3)
        print_uint64(i);
    8020455a:	fe843503          	ld	a0,-24(s0)
    8020455e:	a85ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:33 (discriminator 3)
        print_str(":\n  Start Address: ");
    80204562:	00002517          	auipc	a0,0x2
    80204566:	d5e50513          	addi	a0,a0,-674 # 802062c0 <rodata_start+0x2c0>
    8020456a:	8fbff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:34 (discriminator 3)
        print_uint64(manager->app_start[i]);
    8020456e:	fd843703          	ld	a4,-40(s0)
    80204572:	fe843783          	ld	a5,-24(s0)
    80204576:	0789                	addi	a5,a5,2
    80204578:	078e                	slli	a5,a5,0x3
    8020457a:	97ba                	add	a5,a5,a4
    8020457c:	639c                	ld	a5,0(a5)
    8020457e:	853e                	mv	a0,a5
    80204580:	a63ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:35 (discriminator 3)
        print_str("\n  End Address:   ");
    80204584:	00002517          	auipc	a0,0x2
    80204588:	d5450513          	addi	a0,a0,-684 # 802062d8 <rodata_start+0x2d8>
    8020458c:	8d9ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:36 (discriminator 3)
        print_uint64(manager->app_end[i]);
    80204590:	fd843703          	ld	a4,-40(s0)
    80204594:	fe843783          	ld	a5,-24(s0)
    80204598:	07d9                	addi	a5,a5,22
    8020459a:	078e                	slli	a5,a5,0x3
    8020459c:	97ba                	add	a5,a5,a4
    8020459e:	639c                	ld	a5,0(a5)
    802045a0:	853e                	mv	a0,a5
    802045a2:	a41ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:37 (discriminator 3)
        print_str("\n");
    802045a6:	00002517          	auipc	a0,0x2
    802045aa:	d0a50513          	addi	a0,a0,-758 # 802062b0 <rodata_start+0x2b0>
    802045ae:	8b7ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 3)
    for (uint64_t i = 0; i < manager->app_num; ++i) {
    802045b2:	fe843783          	ld	a5,-24(s0)
    802045b6:	0785                	addi	a5,a5,1
    802045b8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 1)
    802045bc:	fd843783          	ld	a5,-40(s0)
    802045c0:	639c                	ld	a5,0(a5)
    802045c2:	fe843703          	ld	a4,-24(s0)
    802045c6:	f8f764e3          	bltu	a4,a5,8020454e <print_app_info+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:39
    }
}
    802045ca:	0001                	nop
    802045cc:	0001                	nop
    802045ce:	70a2                	ld	ra,40(sp)
    802045d0:	7402                	ld	s0,32(sp)
    802045d2:	6145                	addi	sp,sp,48
    802045d4:	8082                	ret

00000000802045d6 <run_next_app>:
run_next_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:42

void run_next_app()
{
    802045d6:	db010113          	addi	sp,sp,-592
    802045da:	24113423          	sd	ra,584(sp)
    802045de:	24813023          	sd	s0,576(sp)
    802045e2:	22913c23          	sd	s1,568(sp)
    802045e6:	0c80                	addi	s0,sp,592
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:44
    //print_str("run_next_app");
    print_str("run_next_app : ");
    802045e8:	00002517          	auipc	a0,0x2
    802045ec:	d0850513          	addi	a0,a0,-760 # 802062f0 <rodata_start+0x2f0>
    802045f0:	875ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:45
    print_uint64(app_manager.current_app);
    802045f4:	00816797          	auipc	a5,0x816
    802045f8:	47478793          	addi	a5,a5,1140 # 80a1aa68 <app_manager>
    802045fc:	679c                	ld	a5,8(a5)
    802045fe:	853e                	mv	a0,a5
    80204600:	9e3ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:46
    print_str("\n");
    80204604:	00002517          	auipc	a0,0x2
    80204608:	cac50513          	addi	a0,a0,-852 # 802062b0 <rodata_start+0x2b0>
    8020460c:	859ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:47
    app_manager.current_app++;
    80204610:	00816797          	auipc	a5,0x816
    80204614:	45878793          	addi	a5,a5,1112 # 80a1aa68 <app_manager>
    80204618:	679c                	ld	a5,8(a5)
    8020461a:	00178713          	addi	a4,a5,1
    8020461e:	00816797          	auipc	a5,0x816
    80204622:	44a78793          	addi	a5,a5,1098 # 80a1aa68 <app_manager>
    80204626:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:48
    if(app_manager.current_app>=app_manager.app_num)
    80204628:	00816797          	auipc	a5,0x816
    8020462c:	44078793          	addi	a5,a5,1088 # 80a1aa68 <app_manager>
    80204630:	6798                	ld	a4,8(a5)
    80204632:	00816797          	auipc	a5,0x816
    80204636:	43678793          	addi	a5,a5,1078 # 80a1aa68 <app_manager>
    8020463a:	639c                	ld	a5,0(a5)
    8020463c:	02f76063          	bltu	a4,a5,8020465c <run_next_app+0x86>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:50
    {
        print_str("app execute over\n");
    80204640:	00002517          	auipc	a0,0x2
    80204644:	cc050513          	addi	a0,a0,-832 # 80206300 <rodata_start+0x300>
    80204648:	81dff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:51
        ASSERT(0);
    8020464c:	03300593          	li	a1,51
    80204650:	00002517          	auipc	a0,0x2
    80204654:	cc850513          	addi	a0,a0,-824 # 80206318 <rodata_start+0x318>
    80204658:	ad1ff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:53
    }
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    8020465c:	00816797          	auipc	a5,0x816
    80204660:	40c78793          	addi	a5,a5,1036 # 80a1aa68 <app_manager>
    80204664:	679c                	ld	a5,8(a5)
    80204666:	00816717          	auipc	a4,0x816
    8020466a:	40270713          	addi	a4,a4,1026 # 80a1aa68 <app_manager>
    8020466e:	0789                	addi	a5,a5,2
    80204670:	078e                	slli	a5,a5,0x3
    80204672:	97ba                	add	a5,a5,a4
    80204674:	639c                	ld	a5,0(a5)
    80204676:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:54
    asm volatile ("fence.i");
    8020467a:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:55
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    8020467e:	00816797          	auipc	a5,0x816
    80204682:	3ea78793          	addi	a5,a5,1002 # 80a1aa68 <app_manager>
    80204686:	679c                	ld	a5,8(a5)
    80204688:	853e                	mv	a0,a5
    8020468a:	228000ef          	jal	ra,802048b2 <get_user_stack_top>
    8020468e:	872a                	mv	a4,a0
    80204690:	ec040793          	addi	a5,s0,-320
    80204694:	863a                	mv	a2,a4
    80204696:	fd843583          	ld	a1,-40(s0)
    8020469a:	853e                	mv	a0,a5
    8020469c:	302000ef          	jal	ra,8020499e <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:56
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    802046a0:	00816797          	auipc	a5,0x816
    802046a4:	3c878793          	addi	a5,a5,968 # 80a1aa68 <app_manager>
    802046a8:	6784                	ld	s1,8(a5)
    802046aa:	db040793          	addi	a5,s0,-592
    802046ae:	ec040713          	addi	a4,s0,-320
    802046b2:	11000693          	li	a3,272
    802046b6:	8636                	mv	a2,a3
    802046b8:	85ba                	mv	a1,a4
    802046ba:	853e                	mv	a0,a5
    802046bc:	82efe0ef          	jal	ra,802026ea <memcpy>
    802046c0:	db040793          	addi	a5,s0,-592
    802046c4:	85a6                	mv	a1,s1
    802046c6:	853e                	mv	a0,a5
    802046c8:	214000ef          	jal	ra,802048dc <Kernelstack_push_TrapContext>
    802046cc:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:58
    //__restore(trapcontext);
    __restore((uint64_t)cx);
    802046d0:	fd043783          	ld	a5,-48(s0)
    802046d4:	853e                	mv	a0,a5
    802046d6:	3e3000ef          	jal	ra,802052b8 <__restore>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:59
}
    802046da:	0001                	nop
    802046dc:	24813083          	ld	ra,584(sp)
    802046e0:	24013403          	ld	s0,576(sp)
    802046e4:	23813483          	ld	s1,568(sp)
    802046e8:	25010113          	addi	sp,sp,592
    802046ec:	8082                	ret

00000000802046ee <run_first_app>:
run_first_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:62

void run_first_app()
{
    802046ee:	db010113          	addi	sp,sp,-592
    802046f2:	24113423          	sd	ra,584(sp)
    802046f6:	24813023          	sd	s0,576(sp)
    802046fa:	22913c23          	sd	s1,568(sp)
    802046fe:	0c80                	addi	s0,sp,592
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:63
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    80204700:	00816797          	auipc	a5,0x816
    80204704:	36878793          	addi	a5,a5,872 # 80a1aa68 <app_manager>
    80204708:	679c                	ld	a5,8(a5)
    8020470a:	00816717          	auipc	a4,0x816
    8020470e:	35e70713          	addi	a4,a4,862 # 80a1aa68 <app_manager>
    80204712:	0789                	addi	a5,a5,2
    80204714:	078e                	slli	a5,a5,0x3
    80204716:	97ba                	add	a5,a5,a4
    80204718:	639c                	ld	a5,0(a5)
    8020471a:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:64
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    8020471e:	00816797          	auipc	a5,0x816
    80204722:	34a78793          	addi	a5,a5,842 # 80a1aa68 <app_manager>
    80204726:	679c                	ld	a5,8(a5)
    80204728:	853e                	mv	a0,a5
    8020472a:	188000ef          	jal	ra,802048b2 <get_user_stack_top>
    8020472e:	872a                	mv	a4,a0
    80204730:	ec040793          	addi	a5,s0,-320
    80204734:	863a                	mv	a2,a4
    80204736:	fd843583          	ld	a1,-40(s0)
    8020473a:	853e                	mv	a0,a5
    8020473c:	262000ef          	jal	ra,8020499e <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:65
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    80204740:	00816797          	auipc	a5,0x816
    80204744:	32878793          	addi	a5,a5,808 # 80a1aa68 <app_manager>
    80204748:	6784                	ld	s1,8(a5)
    8020474a:	db040793          	addi	a5,s0,-592
    8020474e:	ec040713          	addi	a4,s0,-320
    80204752:	11000693          	li	a3,272
    80204756:	8636                	mv	a2,a3
    80204758:	85ba                	mv	a1,a4
    8020475a:	853e                	mv	a0,a5
    8020475c:	f8ffd0ef          	jal	ra,802026ea <memcpy>
    80204760:	db040793          	addi	a5,s0,-592
    80204764:	85a6                	mv	a1,s1
    80204766:	853e                	mv	a0,a5
    80204768:	174000ef          	jal	ra,802048dc <Kernelstack_push_TrapContext>
    8020476c:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:66
    __restore((uint64_t)cx);
    80204770:	fd043783          	ld	a5,-48(s0)
    80204774:	853e                	mv	a0,a5
    80204776:	343000ef          	jal	ra,802052b8 <__restore>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:67
}
    8020477a:	0001                	nop
    8020477c:	24813083          	ld	ra,584(sp)
    80204780:	24013403          	ld	s0,576(sp)
    80204784:	23813483          	ld	s1,568(sp)
    80204788:	25010113          	addi	sp,sp,592
    8020478c:	8082                	ret

000000008020478e <load_app_test>:
load_app_test():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:71


void load_app_test()
{
    8020478e:	715d                	addi	sp,sp,-80
    80204790:	e486                	sd	ra,72(sp)
    80204792:	e0a2                	sd	s0,64(sp)
    80204794:	0880                	addi	s0,sp,80
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:74
      // Assume _num_app and related variables are defined elsewhere in your project
    extern uint64_t _num_app[]; // Assuming this is an array holding app info
    uint64_t num_app = _num_app[0]; // First element holds the number of apps
    80204796:	00003797          	auipc	a5,0x3
    8020479a:	86a78793          	addi	a5,a5,-1942 # 80207000 <_num_app>
    8020479e:	639c                	ld	a5,0(a5)
    802047a0:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:75
    asm volatile("fence.i");
    802047a4:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76
    for (uint64_t i = 0; i < num_app; i++) {
    802047a8:	fe043423          	sd	zero,-24(s0)
    802047ac:	a0d1                	j	80204870 <load_app_test+0xe2>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:78 (discriminator 3)
        // Calculate the start and end addresses of the app in memory
        uint64_t app_start = _num_app[1 + i * 2];
    802047ae:	fe843783          	ld	a5,-24(s0)
    802047b2:	0786                	slli	a5,a5,0x1
    802047b4:	0785                	addi	a5,a5,1
    802047b6:	00003717          	auipc	a4,0x3
    802047ba:	84a70713          	addi	a4,a4,-1974 # 80207000 <_num_app>
    802047be:	078e                	slli	a5,a5,0x3
    802047c0:	97ba                	add	a5,a5,a4
    802047c2:	639c                	ld	a5,0(a5)
    802047c4:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:79 (discriminator 3)
        uint64_t app_end = _num_app[2 + i * 2];
    802047c8:	fe843783          	ld	a5,-24(s0)
    802047cc:	0785                	addi	a5,a5,1
    802047ce:	0786                	slli	a5,a5,0x1
    802047d0:	00003717          	auipc	a4,0x3
    802047d4:	83070713          	addi	a4,a4,-2000 # 80207000 <_num_app>
    802047d8:	078e                	slli	a5,a5,0x3
    802047da:	97ba                	add	a5,a5,a4
    802047dc:	639c                	ld	a5,0(a5)
    802047de:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:80 (discriminator 3)
        uint64_t app_size = app_end - app_start;
    802047e2:	fd043703          	ld	a4,-48(s0)
    802047e6:	fd843783          	ld	a5,-40(s0)
    802047ea:	40f707b3          	sub	a5,a4,a5
    802047ee:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:81 (discriminator 3)
        const void* src = (const void*)app_start;
    802047f2:	fd843783          	ld	a5,-40(s0)
    802047f6:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:82 (discriminator 3)
        void* dst = (void*)(APP_BASE_ADDRESS + 0x20000 * i);
    802047fa:	fe843703          	ld	a4,-24(s0)
    802047fe:	6791                	lui	a5,0x4
    80204800:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    80204804:	97ba                	add	a5,a5,a4
    80204806:	07c6                	slli	a5,a5,0x11
    80204808:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:84 (discriminator 3)

        print_str("[Test] Loading app from ");
    8020480c:	00002517          	auipc	a0,0x2
    80204810:	b2450513          	addi	a0,a0,-1244 # 80206330 <rodata_start+0x330>
    80204814:	e50ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:85 (discriminator 3)
        print_uint64(app_start);
    80204818:	fd843503          	ld	a0,-40(s0)
    8020481c:	fc6ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:86 (discriminator 3)
        print_str(" to ");
    80204820:	00002517          	auipc	a0,0x2
    80204824:	b3050513          	addi	a0,a0,-1232 # 80206350 <rodata_start+0x350>
    80204828:	e3cff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:87 (discriminator 3)
        print_uint64(app_end);
    8020482c:	fd043503          	ld	a0,-48(s0)
    80204830:	fb2ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:88 (discriminator 3)
        print_str("\n");
    80204834:	00002517          	auipc	a0,0x2
    80204838:	a7c50513          	addi	a0,a0,-1412 # 802062b0 <rodata_start+0x2b0>
    8020483c:	e28ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:91 (discriminator 3)

        // Clear the application area and copy the new app into place
        memset_t(dst, 0, 0x20000); // Ensure APP_MAX_SIZE covers the max possible app size
    80204840:	00020637          	lui	a2,0x20
    80204844:	4581                	li	a1,0
    80204846:	fb843503          	ld	a0,-72(s0)
    8020484a:	cd3fd0ef          	jal	ra,8020251c <memset_t>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:92 (discriminator 3)
        memcpy_t(dst, src, app_size);
    8020484e:	fc843783          	ld	a5,-56(s0)
    80204852:	2781                	sext.w	a5,a5
    80204854:	863e                	mv	a2,a5
    80204856:	fc043583          	ld	a1,-64(s0)
    8020485a:	fb843503          	ld	a0,-72(s0)
    8020485e:	afbfd0ef          	jal	ra,80202358 <memcpy_t>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:94 (discriminator 3)
        // Instruction synchronization barrier to ensure all instructions are executed correctly
        __asm__ volatile ("fence.i");
    80204862:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76 (discriminator 3)
    for (uint64_t i = 0; i < num_app; i++) {
    80204866:	fe843783          	ld	a5,-24(s0)
    8020486a:	0785                	addi	a5,a5,1
    8020486c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76 (discriminator 1)
    80204870:	fe843703          	ld	a4,-24(s0)
    80204874:	fe043783          	ld	a5,-32(s0)
    80204878:	f2f76be3          	bltu	a4,a5,802047ae <load_app_test+0x20>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:96
    }
    8020487c:	0001                	nop
    8020487e:	0001                	nop
    80204880:	60a6                	ld	ra,72(sp)
    80204882:	6406                	ld	s0,64(sp)
    80204884:	6161                	addi	sp,sp,80
    80204886:	8082                	ret

0000000080204888 <get_kernel_stack_top>:
get_kernel_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:13
uint8_t Trap_Stack[1024];
uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];


uint64_t get_kernel_stack_top( uint64_t app_id ) {
    80204888:	1101                	addi	sp,sp,-32
    8020488a:	ec22                	sd	s0,24(sp)
    8020488c:	1000                	addi	s0,sp,32
    8020488e:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:14
    return (uint64_t)(Kernelstack[app_id]) + KERNEL_STACK_SIZE;
    80204892:	fe843783          	ld	a5,-24(s0)
    80204896:	00d79713          	slli	a4,a5,0xd
    8020489a:	0083e797          	auipc	a5,0x83e
    8020489e:	71e78793          	addi	a5,a5,1822 # 80a42fb8 <Kernelstack>
    802048a2:	97ba                	add	a5,a5,a4
    802048a4:	873e                	mv	a4,a5
    802048a6:	6789                	lui	a5,0x2
    802048a8:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:15
}
    802048aa:	853e                	mv	a0,a5
    802048ac:	6462                	ld	s0,24(sp)
    802048ae:	6105                	addi	sp,sp,32
    802048b0:	8082                	ret

00000000802048b2 <get_user_stack_top>:
get_user_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:18


uint64_t get_user_stack_top( uint64_t app_id ) {
    802048b2:	1101                	addi	sp,sp,-32
    802048b4:	ec22                	sd	s0,24(sp)
    802048b6:	1000                	addi	s0,sp,32
    802048b8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:19
    return (uint64_t)(UserStack[app_id]) + USER_STACK_SIZE;
    802048bc:	fe843783          	ld	a5,-24(s0)
    802048c0:	00d79713          	slli	a4,a5,0xd
    802048c4:	00816797          	auipc	a5,0x816
    802048c8:	6f478793          	addi	a5,a5,1780 # 80a1afb8 <UserStack>
    802048cc:	97ba                	add	a5,a5,a4
    802048ce:	873e                	mv	a4,a5
    802048d0:	6789                	lui	a5,0x2
    802048d2:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:20
}
    802048d4:	853e                	mv	a0,a5
    802048d6:	6462                	ld	s0,24(sp)
    802048d8:	6105                	addi	sp,sp,32
    802048da:	8082                	ret

00000000802048dc <Kernelstack_push_TrapContext>:
Kernelstack_push_TrapContext():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:24


uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
{
    802048dc:	7179                	addi	sp,sp,-48
    802048de:	f406                	sd	ra,40(sp)
    802048e0:	f022                	sd	s0,32(sp)
    802048e2:	1800                	addi	s0,sp,48
    802048e4:	80aa                	mv	ra,a0
    802048e6:	fcb43c23          	sd	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:25
    uint8_t* stackTop = Kernelstack[task_id] + KERNEL_STACK_SIZE; // 指向栈顶
    802048ea:	fd843783          	ld	a5,-40(s0)
    802048ee:	00d79713          	slli	a4,a5,0xd
    802048f2:	0083e797          	auipc	a5,0x83e
    802048f6:	6c678793          	addi	a5,a5,1734 # 80a42fb8 <Kernelstack>
    802048fa:	973e                	add	a4,a4,a5
    802048fc:	6789                	lui	a5,0x2
    802048fe:	97ba                	add	a5,a5,a4
    80204900:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:26
    stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
    80204904:	fe843783          	ld	a5,-24(s0)
    80204908:	ef078793          	addi	a5,a5,-272 # 1ef0 <n+0x1ed0>
    8020490c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:27
    *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
    80204910:	fe843783          	ld	a5,-24(s0)
    80204914:	873e                	mv	a4,a5
    80204916:	8686                	mv	a3,ra
    80204918:	11000793          	li	a5,272
    8020491c:	863e                	mv	a2,a5
    8020491e:	85b6                	mv	a1,a3
    80204920:	853a                	mv	a0,a4
    80204922:	dc9fd0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:28
    return stackTop; // 返回新的栈顶地址
    80204926:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:29
    8020492a:	853e                	mv	a0,a5
    8020492c:	70a2                	ld	ra,40(sp)
    8020492e:	7402                	ld	s0,32(sp)
    80204930:	6145                	addi	sp,sp,48
    80204932:	8082                	ret

0000000080204934 <set_sstatus_spp_user>:
set_sstatus_spp_user():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:5
// TrapContext.c
#include "stdint.h"
#include "context.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    80204934:	7179                	addi	sp,sp,-48
    80204936:	f422                	sd	s0,40(sp)
    80204938:	1800                	addi	s0,sp,48
    8020493a:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:6
    uint64_t mask = 1UL << 8;
    8020493e:	10000793          	li	a5,256
    80204942:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:7
    *sstatus &= ~mask;
    80204946:	fd843783          	ld	a5,-40(s0)
    8020494a:	6398                	ld	a4,0(a5)
    8020494c:	fe843783          	ld	a5,-24(s0)
    80204950:	fff7c793          	not	a5,a5
    80204954:	8f7d                	and	a4,a4,a5
    80204956:	fd843783          	ld	a5,-40(s0)
    8020495a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:8
}
    8020495c:	0001                	nop
    8020495e:	7422                	ld	s0,40(sp)
    80204960:	6145                	addi	sp,sp,48
    80204962:	8082                	ret

0000000080204964 <read_sstatus>:
read_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:11

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    80204964:	1101                	addi	sp,sp,-32
    80204966:	ec22                	sd	s0,24(sp)
    80204968:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:12
    return READ_CSR(sstatus);
    8020496a:	100027f3          	csrr	a5,sstatus
    8020496e:	fef43423          	sd	a5,-24(s0)
    80204972:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:13
}
    80204976:	853e                	mv	a0,a5
    80204978:	6462                	ld	s0,24(sp)
    8020497a:	6105                	addi	sp,sp,32
    8020497c:	8082                	ret

000000008020497e <set_sp>:
set_sp():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:16

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    8020497e:	1101                	addi	sp,sp,-32
    80204980:	ec22                	sd	s0,24(sp)
    80204982:	1000                	addi	s0,sp,32
    80204984:	fea43423          	sd	a0,-24(s0)
    80204988:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:17
    ctx->x[2] = sp;
    8020498c:	fe843783          	ld	a5,-24(s0)
    80204990:	fe043703          	ld	a4,-32(s0)
    80204994:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:18
}
    80204996:	0001                	nop
    80204998:	6462                	ld	s0,24(sp)
    8020499a:	6105                	addi	sp,sp,32
    8020499c:	8082                	ret

000000008020499e <app_init_context>:
app_init_context():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:22

// 初始化应用程序上下文
struct TrapContext app_init_context(uint64_t entry, uint64_t sp) 
{
    8020499e:	714d                	addi	sp,sp,-336
    802049a0:	e686                	sd	ra,328(sp)
    802049a2:	e2a2                	sd	s0,320(sp)
    802049a4:	0a80                	addi	s0,sp,336
    802049a6:	eca43423          	sd	a0,-312(s0)
    802049aa:	ecb43023          	sd	a1,-320(s0)
    802049ae:	eac43c23          	sd	a2,-328(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:24
    struct TrapContext ctx;
    uint64_t sstatus = read_sstatus();
    802049b2:	fb3ff0ef          	jal	ra,80204964 <read_sstatus>
    802049b6:	87aa                	mv	a5,a0
    802049b8:	ecf43823          	sd	a5,-304(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:25
    set_sstatus_spp_user(&sstatus); // 设置为用户模式
    802049bc:	ed040793          	addi	a5,s0,-304
    802049c0:	853e                	mv	a0,a5
    802049c2:	f73ff0ef          	jal	ra,80204934 <set_sstatus_spp_user>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:26
    ctx.sstatus = sstatus;
    802049c6:	ed043783          	ld	a5,-304(s0)
    802049ca:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:27
    ctx.sepc = entry; // 设置入口地址
    802049ce:	ec043783          	ld	a5,-320(s0)
    802049d2:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:28
    set_sp(&ctx, sp); // 设置栈指针
    802049d6:	ed840793          	addi	a5,s0,-296
    802049da:	eb843583          	ld	a1,-328(s0)
    802049de:	853e                	mv	a0,a5
    802049e0:	f9fff0ef          	jal	ra,8020497e <set_sp>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30
    //初始化通用寄存器为0
    for(int i = 0; i < 32; i++)
    802049e4:	fe042623          	sw	zero,-20(s0)
    802049e8:	a831                	j	80204a04 <app_init_context+0x66>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:32 (discriminator 3)
    {
        ctx.x[i] = 0;
    802049ea:	fec42783          	lw	a5,-20(s0)
    802049ee:	078e                	slli	a5,a5,0x3
    802049f0:	ff040713          	addi	a4,s0,-16
    802049f4:	97ba                	add	a5,a5,a4
    802049f6:	ee07b423          	sd	zero,-280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30 (discriminator 3)
    for(int i = 0; i < 32; i++)
    802049fa:	fec42783          	lw	a5,-20(s0)
    802049fe:	2785                	addiw	a5,a5,1
    80204a00:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30 (discriminator 1)
    80204a04:	fec42783          	lw	a5,-20(s0)
    80204a08:	0007871b          	sext.w	a4,a5
    80204a0c:	47fd                	li	a5,31
    80204a0e:	fce7dee3          	bge	a5,a4,802049ea <app_init_context+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:34
    }
    return ctx;
    80204a12:	ec843783          	ld	a5,-312(s0)
    80204a16:	86be                	mv	a3,a5
    80204a18:	ed840793          	addi	a5,s0,-296
    80204a1c:	11000713          	li	a4,272
    80204a20:	863a                	mv	a2,a4
    80204a22:	85be                	mv	a1,a5
    80204a24:	8536                	mv	a0,a3
    80204a26:	cc5fd0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:35
}
    80204a2a:	ec843503          	ld	a0,-312(s0)
    80204a2e:	60b6                	ld	ra,328(sp)
    80204a30:	6416                	ld	s0,320(sp)
    80204a32:	6171                	addi	sp,sp,336
    80204a34:	8082                	ret

0000000080204a36 <print_sepc>:
print_sepc():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:15
#include "task.h"
extern void __alltraps(void);


void print_sepc()
{
    80204a36:	1101                	addi	sp,sp,-32
    80204a38:	ec06                	sd	ra,24(sp)
    80204a3a:	e822                	sd	s0,16(sp)
    80204a3c:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:16
    print_str("sepc : ");
    80204a3e:	00002517          	auipc	a0,0x2
    80204a42:	91a50513          	addi	a0,a0,-1766 # 80206358 <rodata_start+0x358>
    80204a46:	c1eff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:17
    print_uint64(READ_CSR(sepc));
    80204a4a:	141027f3          	csrr	a5,sepc
    80204a4e:	fef43423          	sd	a5,-24(s0)
    80204a52:	fe843783          	ld	a5,-24(s0)
    80204a56:	853e                	mv	a0,a5
    80204a58:	d8aff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:18
    print_str("\n");    
    80204a5c:	00002517          	auipc	a0,0x2
    80204a60:	90450513          	addi	a0,a0,-1788 # 80206360 <rodata_start+0x360>
    80204a64:	c00ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:19
}
    80204a68:	0001                	nop
    80204a6a:	60e2                	ld	ra,24(sp)
    80204a6c:	6442                	ld	s0,16(sp)
    80204a6e:	6105                	addi	sp,sp,32
    80204a70:	8082                	ret

0000000080204a72 <init_interrupt>:
init_interrupt():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:22

void init_interrupt()
{
    80204a72:	7139                	addi	sp,sp,-64
    80204a74:	fc22                	sd	s0,56(sp)
    80204a76:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:24
    //print_str("----init_interrupt----\n");
    uint64_t stvec_value = (uint64_t)(__alltraps);
    80204a78:	00000797          	auipc	a5,0x0
    80204a7c:	7e878793          	addi	a5,a5,2024 # 80205260 <__alltraps>
    80204a80:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:26
    // WRITE_CSR(stvec,stvec_value);
    asm volatile("csrw stvec, %0" :: "r"(stvec_value));
    80204a84:	fe843783          	ld	a5,-24(s0)
    80204a88:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:27
    uint64_t mask = 0x202; // 定义启用S模式时钟中断和软件中断的掩码
    80204a8c:	20200793          	li	a5,514
    80204a90:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:28
    WRITE_CSR(sie,mask);
    80204a94:	fe043783          	ld	a5,-32(s0)
    80204a98:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:29
    uint64_t sstatus = READ_CSR(sstatus);
    80204a9c:	100027f3          	csrr	a5,sstatus
    80204aa0:	fcf43c23          	sd	a5,-40(s0)
    80204aa4:	fd843783          	ld	a5,-40(s0)
    80204aa8:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:30
    sstatus |= SSTATUS_SIE_BIT;
    80204aac:	fd043783          	ld	a5,-48(s0)
    80204ab0:	0027e793          	ori	a5,a5,2
    80204ab4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:31
    WRITE_CSR(sstatus, sstatus);
    80204ab8:	fd043783          	ld	a5,-48(s0)
    80204abc:	10079073          	csrw	sstatus,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:32
    uint64_t sie = READ_CSR(sie);
    80204ac0:	104027f3          	csrr	a5,sie
    80204ac4:	fcf43423          	sd	a5,-56(s0)
    80204ac8:	fc843783          	ld	a5,-56(s0)
    80204acc:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:33
    sie |= SIE_SSIE_BIT | SIE_STIE_BIT | SIE_SEIE_BIT;
    80204ad0:	fc043783          	ld	a5,-64(s0)
    80204ad4:	2227e793          	ori	a5,a5,546
    80204ad8:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:34
    WRITE_CSR(sie, sie);
    80204adc:	fc043783          	ld	a5,-64(s0)
    80204ae0:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:35
    WRITE_CSR(sscratch,Trap_Stack);
    80204ae4:	00816797          	auipc	a5,0x816
    80204ae8:	0d478793          	addi	a5,a5,212 # 80a1abb8 <Trap_Stack>
    80204aec:	14079073          	csrw	sscratch,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:36
}
    80204af0:	0001                	nop
    80204af2:	7462                	ld	s0,56(sp)
    80204af4:	6121                	addi	sp,sp,64
    80204af6:	8082                	ret

0000000080204af8 <trap_handler>:
trap_handler():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:39

struct TrapContext* trap_handler(struct TrapContext* cx) 
{
    80204af8:	711d                	addi	sp,sp,-96
    80204afa:	ec86                	sd	ra,88(sp)
    80204afc:	e8a2                	sd	s0,80(sp)
    80204afe:	1080                	addi	s0,sp,96
    80204b00:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:41
    //print_str("trap_handler\n");
    uint64_t scause = READ_CSR(scause);
    80204b04:	142027f3          	csrr	a5,scause
    80204b08:	fcf43c23          	sd	a5,-40(s0)
    80204b0c:	fd843783          	ld	a5,-40(s0)
    80204b10:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:44
    //uint64_t stval = READ_CSR(stval);

    switch (scause)
    80204b14:	fd043703          	ld	a4,-48(s0)
    80204b18:	47bd                	li	a5,15
    80204b1a:	02e7e963          	bltu	a5,a4,80204b4c <trap_handler+0x54>
    80204b1e:	fd043703          	ld	a4,-48(s0)
    80204b22:	47bd                	li	a5,15
    80204b24:	1ee7e463          	bltu	a5,a4,80204d0c <trap_handler+0x214>
    80204b28:	fd043783          	ld	a5,-48(s0)
    80204b2c:	00279713          	slli	a4,a5,0x2
    80204b30:	00002797          	auipc	a5,0x2
    80204b34:	a3478793          	addi	a5,a5,-1484 # 80206564 <rodata_start+0x564>
    80204b38:	97ba                	add	a5,a5,a4
    80204b3a:	439c                	lw	a5,0(a5)
    80204b3c:	0007871b          	sext.w	a4,a5
    80204b40:	00002797          	auipc	a5,0x2
    80204b44:	a2478793          	addi	a5,a5,-1500 # 80206564 <rodata_start+0x564>
    80204b48:	97ba                	add	a5,a5,a4
    80204b4a:	8782                	jr	a5
    80204b4c:	fd043703          	ld	a4,-48(s0)
    80204b50:	57fd                	li	a5,-1
    80204b52:	17fe                	slli	a5,a5,0x3f
    80204b54:	0795                	addi	a5,a5,5
    80204b56:	1af70863          	beq	a4,a5,80204d06 <trap_handler+0x20e>
    80204b5a:	aa4d                	j	80204d0c <trap_handler+0x214>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:47
    {
        case 0x00: // 指令地址错位
            print_str("[kernel] Instruction Address Misaligned.\n");
    80204b5c:	00002517          	auipc	a0,0x2
    80204b60:	80c50513          	addi	a0,a0,-2036 # 80206368 <rodata_start+0x368>
    80204b64:	b00ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:48
            print_sepc();
    80204b68:	ecfff0ef          	jal	ra,80204a36 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:49
            run_next_task(3);
    80204b6c:	450d                	li	a0,3
    80204b6e:	f44ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:50
            break;
    80204b72:	aa55                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:52
        case 0x01: // 指令访问故障
            print_sepc();
    80204b74:	ec3ff0ef          	jal	ra,80204a36 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:53
            print_str("[kernel] Instruction Access Fault.\n");
    80204b78:	00002517          	auipc	a0,0x2
    80204b7c:	82050513          	addi	a0,a0,-2016 # 80206398 <rodata_start+0x398>
    80204b80:	ae4ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:54
            run_next_task(3);
    80204b84:	450d                	li	a0,3
    80204b86:	f2cff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:55
            break;
    80204b8a:	aa71                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:57
        case 0x02: // 非法指令
            print_str("kernel] Illegal Instruction.\n");
    80204b8c:	00002517          	auipc	a0,0x2
    80204b90:	83450513          	addi	a0,a0,-1996 # 802063c0 <rodata_start+0x3c0>
    80204b94:	ad0ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:58
            run_next_task(3);
    80204b98:	450d                	li	a0,3
    80204b9a:	f18ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:59
            break;
    80204b9e:	a261                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:61
        case 0x03: // 断点
            print_str("[kernel] Breakpoint.\n");
    80204ba0:	00002517          	auipc	a0,0x2
    80204ba4:	84050513          	addi	a0,a0,-1984 # 802063e0 <rodata_start+0x3e0>
    80204ba8:	abcff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:63
            // 特定的调试处理或直接运行下一个应用
            cx->sepc +=2;
    80204bac:	fa843783          	ld	a5,-88(s0)
    80204bb0:	1087b783          	ld	a5,264(a5)
    80204bb4:	00278713          	addi	a4,a5,2
    80204bb8:	fa843783          	ld	a5,-88(s0)
    80204bbc:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:65
            //run_next_app();
            break;
    80204bc0:	a29d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:67
        case 0x04: // 加载地址错位
            print_str("[kernel] Load Address Misaligned.\n");
    80204bc2:	00002517          	auipc	a0,0x2
    80204bc6:	83650513          	addi	a0,a0,-1994 # 802063f8 <rodata_start+0x3f8>
    80204bca:	a9aff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:68
            run_next_task(3);
    80204bce:	450d                	li	a0,3
    80204bd0:	ee2ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:69
            break;
    80204bd4:	aa89                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:71
        case 0x05: // 加载访问故障
            print_sepc();
    80204bd6:	e61ff0ef          	jal	ra,80204a36 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:72
            print_str("[kernel] Load Access Fault.\n");
    80204bda:	00002517          	auipc	a0,0x2
    80204bde:	84650513          	addi	a0,a0,-1978 # 80206420 <rodata_start+0x420>
    80204be2:	a82ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:73
            run_next_task(3);
    80204be6:	450d                	li	a0,3
    80204be8:	ecaff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:74
            break;
    80204bec:	aa2d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:76
        case 0x06: // 存储地址错位
            print_str("[kernel] Store/AMO Address Misaligned.\n");
    80204bee:	00002517          	auipc	a0,0x2
    80204bf2:	85250513          	addi	a0,a0,-1966 # 80206440 <rodata_start+0x440>
    80204bf6:	a6eff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:77
            run_next_task(3);
    80204bfa:	450d                	li	a0,3
    80204bfc:	eb6ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:78
            break;
    80204c00:	a21d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:80
        case 0x07: // 存储/AMO访问故障
            print_str("[kernel] Store/AMO Access Fault.\n");
    80204c02:	00002517          	auipc	a0,0x2
    80204c06:	86650513          	addi	a0,a0,-1946 # 80206468 <rodata_start+0x468>
    80204c0a:	a5aff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:81
            print_sepc(3);
    80204c0e:	450d                	li	a0,3
    80204c10:	e27ff0ef          	jal	ra,80204a36 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:82
            uint64_t cnt=10000000000;
    80204c14:	009507b7          	lui	a5,0x950
    80204c18:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80204c1c:	07aa                	slli	a5,a5,0xa
    80204c1e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:83
            while(cnt--){}
    80204c22:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:83 (discriminator 1)
    80204c24:	fe843783          	ld	a5,-24(s0)
    80204c28:	fff78713          	addi	a4,a5,-1
    80204c2c:	fee43423          	sd	a4,-24(s0)
    80204c30:	fbf5                	bnez	a5,80204c24 <trap_handler+0x12c>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:85
            //run_next_app();
            break;
    80204c32:	a8d5                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:87
        case 0x08: // 环境调用来自U模式
            cx->sepc += 4; // 跳过环境调用指令
    80204c34:	fa843783          	ld	a5,-88(s0)
    80204c38:	1087b783          	ld	a5,264(a5)
    80204c3c:	00478713          	addi	a4,a5,4
    80204c40:	fa843783          	ld	a5,-88(s0)
    80204c44:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:88
            uint64_t args[3] = {cx->x[10], cx->x[11], cx->x[12]};
    80204c48:	fa843783          	ld	a5,-88(s0)
    80204c4c:	6bbc                	ld	a5,80(a5)
    80204c4e:	faf43c23          	sd	a5,-72(s0)
    80204c52:	fa843783          	ld	a5,-88(s0)
    80204c56:	6fbc                	ld	a5,88(a5)
    80204c58:	fcf43023          	sd	a5,-64(s0)
    80204c5c:	fa843783          	ld	a5,-88(s0)
    80204c60:	73bc                	ld	a5,96(a5)
    80204c62:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:89
            cx->x[10] = syscall(cx->x[17], args); // 执行系统调用
    80204c66:	fa843783          	ld	a5,-88(s0)
    80204c6a:	67dc                	ld	a5,136(a5)
    80204c6c:	fb840713          	addi	a4,s0,-72
    80204c70:	85ba                	mv	a1,a4
    80204c72:	853e                	mv	a0,a5
    80204c74:	1de000ef          	jal	ra,80204e52 <syscall>
    80204c78:	87aa                	mv	a5,a0
    80204c7a:	873e                	mv	a4,a5
    80204c7c:	fa843783          	ld	a5,-88(s0)
    80204c80:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:90
            break;
    80204c82:	a055                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:92
        case 0x09: // 环境调用来自S模式
            print_str("[kernel] Environment Call from S-mode.\n");
    80204c84:	00002517          	auipc	a0,0x2
    80204c88:	80c50513          	addi	a0,a0,-2036 # 80206490 <rodata_start+0x490>
    80204c8c:	9d8ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:93
            uint64_t cnt1=10000000000;
    80204c90:	009507b7          	lui	a5,0x950
    80204c94:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80204c98:	07aa                	slli	a5,a5,0xa
    80204c9a:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:94
            while(cnt1--){}
    80204c9e:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:94 (discriminator 1)
    80204ca0:	fe043783          	ld	a5,-32(s0)
    80204ca4:	fff78713          	addi	a4,a5,-1
    80204ca8:	fee43023          	sd	a4,-32(s0)
    80204cac:	fbf5                	bnez	a5,80204ca0 <trap_handler+0x1a8>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:95
            run_next_task(3);
    80204cae:	450d                	li	a0,3
    80204cb0:	e02ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:96
            break;
    80204cb4:	a88d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:98
        case 0x0B: // 环境调用来自M模式
            print_str("[kernel] Environment Call from M-mode.\n");
    80204cb6:	00002517          	auipc	a0,0x2
    80204cba:	80250513          	addi	a0,a0,-2046 # 802064b8 <rodata_start+0x4b8>
    80204cbe:	9a6ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:100
            // 处理或运行下一个应用
            run_next_task(3);
    80204cc2:	450d                	li	a0,3
    80204cc4:	deeff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:101
            break;
    80204cc8:	a8b9                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:103
        case 0x0C: // 指令页面错误
            print_str("[kernel] Instruction Page Fault.\n");
    80204cca:	00002517          	auipc	a0,0x2
    80204cce:	81650513          	addi	a0,a0,-2026 # 802064e0 <rodata_start+0x4e0>
    80204cd2:	992ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:104
            run_next_task(3);
    80204cd6:	450d                	li	a0,3
    80204cd8:	ddaff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:105
            break;
    80204cdc:	a0a9                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:107
        case 0x0D: // 加载页面错误
            print_str("[kernel] Load Page Fault.\n");
    80204cde:	00002517          	auipc	a0,0x2
    80204ce2:	82a50513          	addi	a0,a0,-2006 # 80206508 <rodata_start+0x508>
    80204ce6:	97eff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:108
            run_next_task(3);
    80204cea:	450d                	li	a0,3
    80204cec:	dc6ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:109
            break;
    80204cf0:	a81d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:111
        case 0x0F: // 存储页面错误
            print_str("[kernel] Store/AMO Page Fault.\n");
    80204cf2:	00002517          	auipc	a0,0x2
    80204cf6:	83650513          	addi	a0,a0,-1994 # 80206528 <rodata_start+0x528>
    80204cfa:	96aff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:112
            run_next_task(3);
    80204cfe:	450d                	li	a0,3
    80204d00:	db2ff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:113
            break;
    80204d04:	a00d                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:116
        case 0x8000000000000005: 
            //print_str("intr_timer_handle\n");
            intr_timer_handle();
    80204d06:	268000ef          	jal	ra,80204f6e <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:117
            break;
    80204d0a:	a831                	j	80204d26 <trap_handler+0x22e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:119
        default:
            print_str("[kernel] Unsupported trap.\n");
    80204d0c:	00002517          	auipc	a0,0x2
    80204d10:	83c50513          	addi	a0,a0,-1988 # 80206548 <rodata_start+0x548>
    80204d14:	950ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:120
            print_uint64(scause);
    80204d18:	fd043503          	ld	a0,-48(s0)
    80204d1c:	ac6ff0ef          	jal	ra,80203fe2 <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:121
            exit(1);
    80204d20:	4505                	li	a0,1
    80204d22:	012000ef          	jal	ra,80204d34 <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:123
    }
    return cx;
    80204d26:	fa843783          	ld	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:124
    80204d2a:	853e                	mv	a0,a5
    80204d2c:	60e6                	ld	ra,88(sp)
    80204d2e:	6446                	ld	s0,80(sp)
    80204d30:	6125                	addi	sp,sp,96
    80204d32:	8082                	ret

0000000080204d34 <exit>:
exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:10
#include "debug.h"
#include "task.h"


int32_t exit(int32_t value)
{
    80204d34:	1101                	addi	sp,sp,-32
    80204d36:	ec06                	sd	ra,24(sp)
    80204d38:	e822                	sd	s0,16(sp)
    80204d3a:	1000                	addi	s0,sp,32
    80204d3c:	87aa                	mv	a5,a0
    80204d3e:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:11
    print_str("exit : ");
    80204d42:	00002517          	auipc	a0,0x2
    80204d46:	86650513          	addi	a0,a0,-1946 # 802065a8 <rodata_start+0x5a8>
    80204d4a:	91aff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:12
    print_uint32((uint32_t)value);
    80204d4e:	fec42783          	lw	a5,-20(s0)
    80204d52:	853e                	mv	a0,a5
    80204d54:	9daff0ef          	jal	ra,80203f2e <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:13
    print_str("\n");
    80204d58:	00002517          	auipc	a0,0x2
    80204d5c:	85850513          	addi	a0,a0,-1960 # 802065b0 <rodata_start+0x5b0>
    80204d60:	904ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:14
    return value;
    80204d64:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:15
}
    80204d68:	853e                	mv	a0,a5
    80204d6a:	60e2                	ld	ra,24(sp)
    80204d6c:	6442                	ld	s0,16(sp)
    80204d6e:	6105                	addi	sp,sp,32
    80204d70:	8082                	ret

0000000080204d72 <write>:
write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:18

int64_t write(uint64_t fd, const void *buf, uint64_t count)
{
    80204d72:	7179                	addi	sp,sp,-48
    80204d74:	f406                	sd	ra,40(sp)
    80204d76:	f022                	sd	s0,32(sp)
    80204d78:	1800                	addi	s0,sp,48
    80204d7a:	fea43423          	sd	a0,-24(s0)
    80204d7e:	feb43023          	sd	a1,-32(s0)
    80204d82:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:19
    if(fd==1)
    80204d86:	fe843703          	ld	a4,-24(s0)
    80204d8a:	4785                	li	a5,1
    80204d8c:	00f71d63          	bne	a4,a5,80204da6 <write+0x34>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:22
    {
        buf = (char*) buf;
        print_str(buf);
    80204d90:	fe043503          	ld	a0,-32(s0)
    80204d94:	8d0ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:23
        print_str("\n");
    80204d98:	00002517          	auipc	a0,0x2
    80204d9c:	81850513          	addi	a0,a0,-2024 # 802065b0 <rodata_start+0x5b0>
    80204da0:	8c4ff0ef          	jal	ra,80203e64 <print_str>
    80204da4:	a801                	j	80204db4 <write+0x42>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:26 (discriminator 1)
    }else 
    {
        ASSERT(0);
    80204da6:	45e9                	li	a1,26
    80204da8:	00002517          	auipc	a0,0x2
    80204dac:	81050513          	addi	a0,a0,-2032 # 802065b8 <rodata_start+0x5b8>
    80204db0:	b78ff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:28
    }
    return count;
    80204db4:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:29
}
    80204db8:	853e                	mv	a0,a5
    80204dba:	70a2                	ld	ra,40(sp)
    80204dbc:	7402                	ld	s0,32(sp)
    80204dbe:	6145                	addi	sp,sp,48
    80204dc0:	8082                	ret

0000000080204dc2 <yield>:
yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:32

int64_t yield()
{
    80204dc2:	1141                	addi	sp,sp,-16
    80204dc4:	e406                	sd	ra,8(sp)
    80204dc6:	e022                	sd	s0,0(sp)
    80204dc8:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:33
    print_str("\n-------yield------\n");
    80204dca:	00002517          	auipc	a0,0x2
    80204dce:	80e50513          	addi	a0,a0,-2034 # 802065d8 <rodata_start+0x5d8>
    80204dd2:	892ff0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:34
    run_next_task(1);
    80204dd6:	4505                	li	a0,1
    80204dd8:	cdaff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:35
    return 1;
    80204ddc:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:36
}
    80204dde:	853e                	mv	a0,a5
    80204de0:	60a2                	ld	ra,8(sp)
    80204de2:	6402                	ld	s0,0(sp)
    80204de4:	0141                	addi	sp,sp,16
    80204de6:	8082                	ret

0000000080204de8 <sys_write>:
sys_write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:39

int64_t sys_write(uint64_t fd, const void *buf, uint64_t count) 
{
    80204de8:	7179                	addi	sp,sp,-48
    80204dea:	f406                	sd	ra,40(sp)
    80204dec:	f022                	sd	s0,32(sp)
    80204dee:	1800                	addi	s0,sp,48
    80204df0:	fea43423          	sd	a0,-24(s0)
    80204df4:	feb43023          	sd	a1,-32(s0)
    80204df8:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:40
    return write(fd, buf, count); // 使用POSIX write
    80204dfc:	fd843603          	ld	a2,-40(s0)
    80204e00:	fe043583          	ld	a1,-32(s0)
    80204e04:	fe843503          	ld	a0,-24(s0)
    80204e08:	f6bff0ef          	jal	ra,80204d72 <write>
    80204e0c:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:41
}
    80204e0e:	853e                	mv	a0,a5
    80204e10:	70a2                	ld	ra,40(sp)
    80204e12:	7402                	ld	s0,32(sp)
    80204e14:	6145                	addi	sp,sp,48
    80204e16:	8082                	ret

0000000080204e18 <sys_exit>:
sys_exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:44

void sys_exit(int32_t status) 
{
    80204e18:	1101                	addi	sp,sp,-32
    80204e1a:	ec06                	sd	ra,24(sp)
    80204e1c:	e822                	sd	s0,16(sp)
    80204e1e:	1000                	addi	s0,sp,32
    80204e20:	87aa                	mv	a5,a0
    80204e22:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:45
    exit(status);
    80204e26:	fec42783          	lw	a5,-20(s0)
    80204e2a:	853e                	mv	a0,a5
    80204e2c:	f09ff0ef          	jal	ra,80204d34 <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:46
}
    80204e30:	0001                	nop
    80204e32:	60e2                	ld	ra,24(sp)
    80204e34:	6442                	ld	s0,16(sp)
    80204e36:	6105                	addi	sp,sp,32
    80204e38:	8082                	ret

0000000080204e3a <sys_yield>:
sys_yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:49

int64_t sys_yield()
{
    80204e3a:	1141                	addi	sp,sp,-16
    80204e3c:	e406                	sd	ra,8(sp)
    80204e3e:	e022                	sd	s0,0(sp)
    80204e40:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:50
    return yield();
    80204e42:	f81ff0ef          	jal	ra,80204dc2 <yield>
    80204e46:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:51
}
    80204e48:	853e                	mv	a0,a5
    80204e4a:	60a2                	ld	ra,8(sp)
    80204e4c:	6402                	ld	s0,0(sp)
    80204e4e:	0141                	addi	sp,sp,16
    80204e50:	8082                	ret

0000000080204e52 <syscall>:
syscall():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:55

// 系统调用处理函数
int64_t syscall(uint64_t syscall_id, uint64_t args[3]) 
{
    80204e52:	1101                	addi	sp,sp,-32
    80204e54:	ec06                	sd	ra,24(sp)
    80204e56:	e822                	sd	s0,16(sp)
    80204e58:	1000                	addi	s0,sp,32
    80204e5a:	fea43423          	sd	a0,-24(s0)
    80204e5e:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:56
    switch (syscall_id)
    80204e62:	fe843703          	ld	a4,-24(s0)
    80204e66:	07c00793          	li	a5,124
    80204e6a:	06f70163          	beq	a4,a5,80204ecc <syscall+0x7a>
    80204e6e:	fe843703          	ld	a4,-24(s0)
    80204e72:	07c00793          	li	a5,124
    80204e76:	04e7ef63          	bltu	a5,a4,80204ed4 <syscall+0x82>
    80204e7a:	fe843703          	ld	a4,-24(s0)
    80204e7e:	04000793          	li	a5,64
    80204e82:	00f70963          	beq	a4,a5,80204e94 <syscall+0x42>
    80204e86:	fe843703          	ld	a4,-24(s0)
    80204e8a:	05d00793          	li	a5,93
    80204e8e:	02f70663          	beq	a4,a5,80204eba <syscall+0x68>
    80204e92:	a089                	j	80204ed4 <syscall+0x82>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:60
    {
        case SYSCALL_WRITE:
            //print_str("------sys_write-----\n");
            return sys_write(args[0], (const void*)args[1], args[2]);
    80204e94:	fe043783          	ld	a5,-32(s0)
    80204e98:	6398                	ld	a4,0(a5)
    80204e9a:	fe043783          	ld	a5,-32(s0)
    80204e9e:	07a1                	addi	a5,a5,8
    80204ea0:	639c                	ld	a5,0(a5)
    80204ea2:	86be                	mv	a3,a5
    80204ea4:	fe043783          	ld	a5,-32(s0)
    80204ea8:	07c1                	addi	a5,a5,16
    80204eaa:	639c                	ld	a5,0(a5)
    80204eac:	863e                	mv	a2,a5
    80204eae:	85b6                	mv	a1,a3
    80204eb0:	853a                	mv	a0,a4
    80204eb2:	f37ff0ef          	jal	ra,80204de8 <sys_write>
    80204eb6:	87aa                	mv	a5,a0
    80204eb8:	a0a9                	j	80204f02 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:62
        case SYSCALL_EXIT:
            sys_exit((int)args[0]);
    80204eba:	fe043783          	ld	a5,-32(s0)
    80204ebe:	639c                	ld	a5,0(a5)
    80204ec0:	2781                	sext.w	a5,a5
    80204ec2:	853e                	mv	a0,a5
    80204ec4:	f55ff0ef          	jal	ra,80204e18 <sys_exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:63
            return 0;
    80204ec8:	4781                	li	a5,0
    80204eca:	a825                	j	80204f02 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:66
        case SYSCALL_YIELD:
            //print_str("----sys_yield----\n");
            return sys_yield();
    80204ecc:	f6fff0ef          	jal	ra,80204e3a <sys_yield>
    80204ed0:	87aa                	mv	a5,a0
    80204ed2:	a805                	j	80204f02 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:68
        default:
            print_str("unsupportable syscall_id\n");
    80204ed4:	00001517          	auipc	a0,0x1
    80204ed8:	71c50513          	addi	a0,a0,1820 # 802065f0 <rodata_start+0x5f0>
    80204edc:	f89fe0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:69
            ASSERT(0);
    80204ee0:	04500593          	li	a1,69
    80204ee4:	00001517          	auipc	a0,0x1
    80204ee8:	6d450513          	addi	a0,a0,1748 # 802065b8 <rodata_start+0x5b8>
    80204eec:	a3cff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:71
    }
    ASSERT(0);
    80204ef0:	04700593          	li	a1,71
    80204ef4:	00001517          	auipc	a0,0x1
    80204ef8:	6c450513          	addi	a0,a0,1732 # 802065b8 <rodata_start+0x5b8>
    80204efc:	a2cff0ef          	jal	ra,80204128 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:72
    return -1;
    80204f00:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:73
}
    80204f02:	853e                	mv	a0,a5
    80204f04:	60e2                	ld	ra,24(sp)
    80204f06:	6442                	ld	s0,16(sp)
    80204f08:	6105                	addi	sp,sp,32
    80204f0a:	8082                	ret

0000000080204f0c <read_time>:
read_time():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:5
#include "timer.h"
#include "sbi.h"
#include "task.h"
static inline uint64_t read_time(void) 
{
    80204f0c:	1101                	addi	sp,sp,-32
    80204f0e:	ec22                	sd	s0,24(sp)
    80204f10:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:7
    uint64_t time;
    __asm__ volatile ("csrr %0, time" : "=r"(time));
    80204f12:	c01027f3          	rdtime	a5
    80204f16:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:8
    return time;
    80204f1a:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:9
}
    80204f1e:	853e                	mv	a0,a5
    80204f20:	6462                	ld	s0,24(sp)
    80204f22:	6105                	addi	sp,sp,32
    80204f24:	8082                	ret

0000000080204f26 <clock_set_next_event>:
clock_set_next_event():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:12

void clock_set_next_event() 
{
    80204f26:	1141                	addi	sp,sp,-16
    80204f28:	e406                	sd	ra,8(sp)
    80204f2a:	e022                	sd	s0,0(sp)
    80204f2c:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:13
    sbi_set_timer(read_time() + TIMEBASE);
    80204f2e:	fdfff0ef          	jal	ra,80204f0c <read_time>
    80204f32:	872a                	mv	a4,a0
    80204f34:	67e1                	lui	a5,0x18
    80204f36:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    80204f3a:	97ba                	add	a5,a5,a4
    80204f3c:	853e                	mv	a0,a5
    80204f3e:	bbcfd0ef          	jal	ra,802022fa <sbi_set_timer>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:14
}
    80204f42:	0001                	nop
    80204f44:	60a2                	ld	ra,8(sp)
    80204f46:	6402                	ld	s0,0(sp)
    80204f48:	0141                	addi	sp,sp,16
    80204f4a:	8082                	ret

0000000080204f4c <timer_init>:
timer_init():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:18


void timer_init()
{
    80204f4c:	1141                	addi	sp,sp,-16
    80204f4e:	e406                	sd	ra,8(sp)
    80204f50:	e022                	sd	s0,0(sp)
    80204f52:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:19
    clock_set_next_event();
    80204f54:	fd3ff0ef          	jal	ra,80204f26 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:20
    print_str("----timer_init----\n");
    80204f58:	00001517          	auipc	a0,0x1
    80204f5c:	6b850513          	addi	a0,a0,1720 # 80206610 <rodata_start+0x610>
    80204f60:	f05fe0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:21
}
    80204f64:	0001                	nop
    80204f66:	60a2                	ld	ra,8(sp)
    80204f68:	6402                	ld	s0,0(sp)
    80204f6a:	0141                	addi	sp,sp,16
    80204f6c:	8082                	ret

0000000080204f6e <intr_timer_handle>:
intr_timer_handle():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:25


void intr_timer_handle()
{
    80204f6e:	1141                	addi	sp,sp,-16
    80204f70:	e406                	sd	ra,8(sp)
    80204f72:	e022                	sd	s0,0(sp)
    80204f74:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:26
    run_next_task(1);
    80204f76:	4505                	li	a0,1
    80204f78:	b3aff0ef          	jal	ra,802042b2 <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:27
    ticks++;
    80204f7c:	00866797          	auipc	a5,0x866
    80204f80:	04478793          	addi	a5,a5,68 # 80a6afc0 <ticks>
    80204f84:	639c                	ld	a5,0(a5)
    80204f86:	00178713          	addi	a4,a5,1
    80204f8a:	00866797          	auipc	a5,0x866
    80204f8e:	03678793          	addi	a5,a5,54 # 80a6afc0 <ticks>
    80204f92:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:28
    clock_set_next_event();
    80204f94:	f93ff0ef          	jal	ra,80204f26 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:29
    if(ticks % 10 == 0)
    80204f98:	00866797          	auipc	a5,0x866
    80204f9c:	02878793          	addi	a5,a5,40 # 80a6afc0 <ticks>
    80204fa0:	6398                	ld	a4,0(a5)
    80204fa2:	47a9                	li	a5,10
    80204fa4:	02f777b3          	remu	a5,a4,a5
    80204fa8:	e799                	bnez	a5,80204fb6 <intr_timer_handle+0x48>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:31
    {
        print_str("timer_interrupt\n");
    80204faa:	00001517          	auipc	a0,0x1
    80204fae:	67e50513          	addi	a0,a0,1662 # 80206628 <rodata_start+0x628>
    80204fb2:	eb3fe0ef          	jal	ra,80203e64 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:39
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
    80204fb6:	0001                	nop
    80204fb8:	60a2                	ld	ra,8(sp)
    80204fba:	6402                	ld	s0,0(sp)
    80204fbc:	0141                	addi	sp,sp,16
    80204fbe:	8082                	ret

0000000080204fc0 <vector_init>:
vector_init():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:3
#include "vector.h"
#include "stdint.h"
void vector_init(Vector *v) {
    80204fc0:	1101                	addi	sp,sp,-32
    80204fc2:	ec06                	sd	ra,24(sp)
    80204fc4:	e822                	sd	s0,16(sp)
    80204fc6:	1000                	addi	s0,sp,32
    80204fc8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:4
    v->capacity = 4;
    80204fcc:	fe843783          	ld	a5,-24(s0)
    80204fd0:	4711                	li	a4,4
    80204fd2:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:5
    v->total = 0;
    80204fd4:	fe843783          	ld	a5,-24(s0)
    80204fd8:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:6
    v->items = malloc(sizeof(void*) * v->capacity);
    80204fdc:	fe843783          	ld	a5,-24(s0)
    80204fe0:	679c                	ld	a5,8(a5)
    80204fe2:	078e                	slli	a5,a5,0x3
    80204fe4:	853e                	mv	a0,a5
    80204fe6:	899fd0ef          	jal	ra,8020287e <malloc>
    80204fea:	872a                	mv	a4,a0
    80204fec:	fe843783          	ld	a5,-24(s0)
    80204ff0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:7
}
    80204ff2:	0001                	nop
    80204ff4:	60e2                	ld	ra,24(sp)
    80204ff6:	6442                	ld	s0,16(sp)
    80204ff8:	6105                	addi	sp,sp,32
    80204ffa:	8082                	ret

0000000080204ffc <vector_total>:
vector_total():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:9

size_t vector_total(Vector *v) {
    80204ffc:	1101                	addi	sp,sp,-32
    80204ffe:	ec22                	sd	s0,24(sp)
    80205000:	1000                	addi	s0,sp,32
    80205002:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:10
    return v->total;
    80205006:	fe843783          	ld	a5,-24(s0)
    8020500a:	6b9c                	ld	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:11
}
    8020500c:	853e                	mv	a0,a5
    8020500e:	6462                	ld	s0,24(sp)
    80205010:	6105                	addi	sp,sp,32
    80205012:	8082                	ret

0000000080205014 <vector_resize>:
vector_resize():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:13

void vector_resize(Vector *v, size_t capacity) {
    80205014:	7179                	addi	sp,sp,-48
    80205016:	f406                	sd	ra,40(sp)
    80205018:	f022                	sd	s0,32(sp)
    8020501a:	1800                	addi	s0,sp,48
    8020501c:	fca43c23          	sd	a0,-40(s0)
    80205020:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:14
    void **items = realloc(v->items, sizeof(void*) * capacity);
    80205024:	fd843783          	ld	a5,-40(s0)
    80205028:	6398                	ld	a4,0(a5)
    8020502a:	fd043783          	ld	a5,-48(s0)
    8020502e:	078e                	slli	a5,a5,0x3
    80205030:	85be                	mv	a1,a5
    80205032:	853a                	mv	a0,a4
    80205034:	9bffd0ef          	jal	ra,802029f2 <realloc>
    80205038:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:15
    if (items) {
    8020503c:	fe843783          	ld	a5,-24(s0)
    80205040:	cb99                	beqz	a5,80205056 <vector_resize+0x42>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:16
        v->items = items;
    80205042:	fd843783          	ld	a5,-40(s0)
    80205046:	fe843703          	ld	a4,-24(s0)
    8020504a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:17
        v->capacity = capacity;
    8020504c:	fd843783          	ld	a5,-40(s0)
    80205050:	fd043703          	ld	a4,-48(s0)
    80205054:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:19
    }
}
    80205056:	0001                	nop
    80205058:	70a2                	ld	ra,40(sp)
    8020505a:	7402                	ld	s0,32(sp)
    8020505c:	6145                	addi	sp,sp,48
    8020505e:	8082                	ret

0000000080205060 <vector_add>:
vector_add():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:21

void vector_add(Vector *v, void *item) {
    80205060:	1101                	addi	sp,sp,-32
    80205062:	ec06                	sd	ra,24(sp)
    80205064:	e822                	sd	s0,16(sp)
    80205066:	1000                	addi	s0,sp,32
    80205068:	fea43423          	sd	a0,-24(s0)
    8020506c:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:22
    if (v->capacity == v->total) {
    80205070:	fe843783          	ld	a5,-24(s0)
    80205074:	6798                	ld	a4,8(a5)
    80205076:	fe843783          	ld	a5,-24(s0)
    8020507a:	6b9c                	ld	a5,16(a5)
    8020507c:	00f71b63          	bne	a4,a5,80205092 <vector_add+0x32>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:23
        vector_resize(v, v->capacity * 2);
    80205080:	fe843783          	ld	a5,-24(s0)
    80205084:	679c                	ld	a5,8(a5)
    80205086:	0786                	slli	a5,a5,0x1
    80205088:	85be                	mv	a1,a5
    8020508a:	fe843503          	ld	a0,-24(s0)
    8020508e:	f87ff0ef          	jal	ra,80205014 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:25
    }
    v->items[v->total++] = item;
    80205092:	fe843783          	ld	a5,-24(s0)
    80205096:	6398                	ld	a4,0(a5)
    80205098:	fe843783          	ld	a5,-24(s0)
    8020509c:	6b9c                	ld	a5,16(a5)
    8020509e:	00178613          	addi	a2,a5,1
    802050a2:	fe843683          	ld	a3,-24(s0)
    802050a6:	ea90                	sd	a2,16(a3)
    802050a8:	078e                	slli	a5,a5,0x3
    802050aa:	97ba                	add	a5,a5,a4
    802050ac:	fe043703          	ld	a4,-32(s0)
    802050b0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:26
}
    802050b2:	0001                	nop
    802050b4:	60e2                	ld	ra,24(sp)
    802050b6:	6442                	ld	s0,16(sp)
    802050b8:	6105                	addi	sp,sp,32
    802050ba:	8082                	ret

00000000802050bc <vector_get>:
vector_get():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:28

void *vector_get(Vector *v, size_t index) {
    802050bc:	1101                	addi	sp,sp,-32
    802050be:	ec22                	sd	s0,24(sp)
    802050c0:	1000                	addi	s0,sp,32
    802050c2:	fea43423          	sd	a0,-24(s0)
    802050c6:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:29
    if (index < v->total) {
    802050ca:	fe843783          	ld	a5,-24(s0)
    802050ce:	6b9c                	ld	a5,16(a5)
    802050d0:	fe043703          	ld	a4,-32(s0)
    802050d4:	00f77b63          	bgeu	a4,a5,802050ea <vector_get+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:30
        return v->items[index];
    802050d8:	fe843783          	ld	a5,-24(s0)
    802050dc:	6398                	ld	a4,0(a5)
    802050de:	fe043783          	ld	a5,-32(s0)
    802050e2:	078e                	slli	a5,a5,0x3
    802050e4:	97ba                	add	a5,a5,a4
    802050e6:	639c                	ld	a5,0(a5)
    802050e8:	a011                	j	802050ec <vector_get+0x30>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:32
    }
    return NULL;
    802050ea:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:33
}
    802050ec:	853e                	mv	a0,a5
    802050ee:	6462                	ld	s0,24(sp)
    802050f0:	6105                	addi	sp,sp,32
    802050f2:	8082                	ret

00000000802050f4 <vector_delete>:
vector_delete():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:35

void vector_delete(Vector *v, size_t index) {
    802050f4:	7179                	addi	sp,sp,-48
    802050f6:	f406                	sd	ra,40(sp)
    802050f8:	f022                	sd	s0,32(sp)
    802050fa:	1800                	addi	s0,sp,48
    802050fc:	fca43c23          	sd	a0,-40(s0)
    80205100:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:36
    if (index < v->total) {
    80205104:	fd843783          	ld	a5,-40(s0)
    80205108:	6b9c                	ld	a5,16(a5)
    8020510a:	fd043703          	ld	a4,-48(s0)
    8020510e:	0af77663          	bgeu	a4,a5,802051ba <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:37
        v->items[index] = NULL;
    80205112:	fd843783          	ld	a5,-40(s0)
    80205116:	6398                	ld	a4,0(a5)
    80205118:	fd043783          	ld	a5,-48(s0)
    8020511c:	078e                	slli	a5,a5,0x3
    8020511e:	97ba                	add	a5,a5,a4
    80205120:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38
        for (size_t i = index; i < v->total - 1; ++i) {
    80205124:	fd043783          	ld	a5,-48(s0)
    80205128:	fef43423          	sd	a5,-24(s0)
    8020512c:	a089                	j	8020516e <vector_delete+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:39 (discriminator 3)
            v->items[i] = v->items[i + 1];
    8020512e:	fd843783          	ld	a5,-40(s0)
    80205132:	6398                	ld	a4,0(a5)
    80205134:	fe843783          	ld	a5,-24(s0)
    80205138:	0785                	addi	a5,a5,1
    8020513a:	078e                	slli	a5,a5,0x3
    8020513c:	973e                	add	a4,a4,a5
    8020513e:	fd843783          	ld	a5,-40(s0)
    80205142:	6394                	ld	a3,0(a5)
    80205144:	fe843783          	ld	a5,-24(s0)
    80205148:	078e                	slli	a5,a5,0x3
    8020514a:	97b6                	add	a5,a5,a3
    8020514c:	6318                	ld	a4,0(a4)
    8020514e:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:40 (discriminator 3)
            v->items[i + 1] = NULL;
    80205150:	fd843783          	ld	a5,-40(s0)
    80205154:	6398                	ld	a4,0(a5)
    80205156:	fe843783          	ld	a5,-24(s0)
    8020515a:	0785                	addi	a5,a5,1
    8020515c:	078e                	slli	a5,a5,0x3
    8020515e:	97ba                	add	a5,a5,a4
    80205160:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38 (discriminator 3)
        for (size_t i = index; i < v->total - 1; ++i) {
    80205164:	fe843783          	ld	a5,-24(s0)
    80205168:	0785                	addi	a5,a5,1
    8020516a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38 (discriminator 1)
    8020516e:	fd843783          	ld	a5,-40(s0)
    80205172:	6b9c                	ld	a5,16(a5)
    80205174:	17fd                	addi	a5,a5,-1
    80205176:	fe843703          	ld	a4,-24(s0)
    8020517a:	faf76ae3          	bltu	a4,a5,8020512e <vector_delete+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:42
        }
        v->total--;
    8020517e:	fd843783          	ld	a5,-40(s0)
    80205182:	6b9c                	ld	a5,16(a5)
    80205184:	fff78713          	addi	a4,a5,-1
    80205188:	fd843783          	ld	a5,-40(s0)
    8020518c:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:43
        if (v->total > 0 && v->total == v->capacity / 4) {
    8020518e:	fd843783          	ld	a5,-40(s0)
    80205192:	6b9c                	ld	a5,16(a5)
    80205194:	c39d                	beqz	a5,802051ba <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:43 (discriminator 1)
    80205196:	fd843783          	ld	a5,-40(s0)
    8020519a:	6b98                	ld	a4,16(a5)
    8020519c:	fd843783          	ld	a5,-40(s0)
    802051a0:	679c                	ld	a5,8(a5)
    802051a2:	8389                	srli	a5,a5,0x2
    802051a4:	00f71b63          	bne	a4,a5,802051ba <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:44
            vector_resize(v, v->capacity / 2);
    802051a8:	fd843783          	ld	a5,-40(s0)
    802051ac:	679c                	ld	a5,8(a5)
    802051ae:	8385                	srli	a5,a5,0x1
    802051b0:	85be                	mv	a1,a5
    802051b2:	fd843503          	ld	a0,-40(s0)
    802051b6:	e5fff0ef          	jal	ra,80205014 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:47
        }
    }
}
    802051ba:	0001                	nop
    802051bc:	70a2                	ld	ra,40(sp)
    802051be:	7402                	ld	s0,32(sp)
    802051c0:	6145                	addi	sp,sp,48
    802051c2:	8082                	ret

00000000802051c4 <vector_free>:
vector_free():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:49

void vector_free(Vector *v) {
    802051c4:	1101                	addi	sp,sp,-32
    802051c6:	ec06                	sd	ra,24(sp)
    802051c8:	e822                	sd	s0,16(sp)
    802051ca:	1000                	addi	s0,sp,32
    802051cc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:50
    free(v->items);
    802051d0:	fe843783          	ld	a5,-24(s0)
    802051d4:	639c                	ld	a5,0(a5)
    802051d6:	853e                	mv	a0,a5
    802051d8:	f5afd0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:51
    v->items = NULL;
    802051dc:	fe843783          	ld	a5,-24(s0)
    802051e0:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:52
    v->capacity = 0;
    802051e4:	fe843783          	ld	a5,-24(s0)
    802051e8:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:53
    v->total = 0;
    802051ec:	fe843783          	ld	a5,-24(s0)
    802051f0:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:54
}
    802051f4:	0001                	nop
    802051f6:	60e2                	ld	ra,24(sp)
    802051f8:	6442                	ld	s0,16(sp)
    802051fa:	6105                	addi	sp,sp,32
    802051fc:	8082                	ret

00000000802051fe <vector_new>:
vector_new():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:58


void vector_new(Vector *v, size_t initial_capacity) 
{
    802051fe:	1101                	addi	sp,sp,-32
    80205200:	ec06                	sd	ra,24(sp)
    80205202:	e822                	sd	s0,16(sp)
    80205204:	1000                	addi	s0,sp,32
    80205206:	fea43423          	sd	a0,-24(s0)
    8020520a:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:59
    if (!v) return;
    8020520e:	fe843783          	ld	a5,-24(s0)
    80205212:	c3b1                	beqz	a5,80205256 <vector_new+0x58>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:60
    v->items = (void**)malloc(initial_capacity * sizeof(void*));
    80205214:	fe043783          	ld	a5,-32(s0)
    80205218:	078e                	slli	a5,a5,0x3
    8020521a:	853e                	mv	a0,a5
    8020521c:	e62fd0ef          	jal	ra,8020287e <malloc>
    80205220:	872a                	mv	a4,a0
    80205222:	fe843783          	ld	a5,-24(s0)
    80205226:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:61
    if (v->items == NULL) {
    80205228:	fe843783          	ld	a5,-24(s0)
    8020522c:	639c                	ld	a5,0(a5)
    8020522e:	eb91                	bnez	a5,80205242 <vector_new+0x44>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:63
        // 如果内存分配失败，则容量和总数设置为 0
        v->capacity = 0;
    80205230:	fe843783          	ld	a5,-24(s0)
    80205234:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:64
        v->total = 0;
    80205238:	fe843783          	ld	a5,-24(s0)
    8020523c:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:65
        return; // 可以在这里处理错误或者返回
    80205240:	a821                	j	80205258 <vector_new+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:69
    }

    // 初始化 Vector 结构体的其他成员
    v->capacity = initial_capacity;
    80205242:	fe843783          	ld	a5,-24(s0)
    80205246:	fe043703          	ld	a4,-32(s0)
    8020524a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:70
    v->total = 0; // 初始时，Vector 为空
    8020524c:	fe843783          	ld	a5,-24(s0)
    80205250:	0007b823          	sd	zero,16(a5)
    80205254:	a011                	j	80205258 <vector_new+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:59
    if (!v) return;
    80205256:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:71
    80205258:	60e2                	ld	ra,24(sp)
    8020525a:	6442                	ld	s0,16(sp)
    8020525c:	6105                	addi	sp,sp,32
    8020525e:	8082                	ret

0000000080205260 <__alltraps>:
__alltraps():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:13
    .align 2
    .section .text
    .globl __alltraps
    .globl __restore
__alltraps:
    csrrw sp, sscratch, sp
    80205260:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:16
    # now sp->kernel stack, sscratch->user stack
    # allocate a TrapContext on kernel stack
    addi sp, sp, -34*8
    80205264:	716d                	addi	sp,sp,-272
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:18
    # save general-purpose registers
    sd x1, 1*8(sp)
    80205266:	e406                	sd	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:20
    # skip sp(x2), we will save it later
    sd x3, 3*8(sp)
    80205268:	ec0e                	sd	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:27
    # save x5~x31
    .set n, 5
    .rept 27
        SAVE_GP %n
        .set n, n+1
    .endr
    8020526a:	f416                	sd	t0,40(sp)
    8020526c:	f81a                	sd	t1,48(sp)
    8020526e:	fc1e                	sd	t2,56(sp)
    80205270:	e0a2                	sd	s0,64(sp)
    80205272:	e4a6                	sd	s1,72(sp)
    80205274:	e8aa                	sd	a0,80(sp)
    80205276:	ecae                	sd	a1,88(sp)
    80205278:	f0b2                	sd	a2,96(sp)
    8020527a:	f4b6                	sd	a3,104(sp)
    8020527c:	f8ba                	sd	a4,112(sp)
    8020527e:	fcbe                	sd	a5,120(sp)
    80205280:	e142                	sd	a6,128(sp)
    80205282:	e546                	sd	a7,136(sp)
    80205284:	e94a                	sd	s2,144(sp)
    80205286:	ed4e                	sd	s3,152(sp)
    80205288:	f152                	sd	s4,160(sp)
    8020528a:	f556                	sd	s5,168(sp)
    8020528c:	f95a                	sd	s6,176(sp)
    8020528e:	fd5e                	sd	s7,184(sp)
    80205290:	e1e2                	sd	s8,192(sp)
    80205292:	e5e6                	sd	s9,200(sp)
    80205294:	e9ea                	sd	s10,208(sp)
    80205296:	edee                	sd	s11,216(sp)
    80205298:	f1f2                	sd	t3,224(sp)
    8020529a:	f5f6                	sd	t4,232(sp)
    8020529c:	f9fa                	sd	t5,240(sp)
    8020529e:	fdfe                	sd	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:29
    # we can use t0/t1/t2 freely, because they were saved on kernel stack
    csrr t0, sstatus
    802052a0:	100022f3          	csrr	t0,sstatus
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:30
    csrr t1, sepc
    802052a4:	14102373          	csrr	t1,sepc
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:31
    sd t0, 32*8(sp)
    802052a8:	e216                	sd	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:32
    sd t1, 33*8(sp)
    802052aa:	e61a                	sd	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:34
    # read user stack from sscratch and save it on the kernel stack
    csrr t2, sscratch
    802052ac:	140023f3          	csrr	t2,sscratch
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:35
    sd t2, 2*8(sp)
    802052b0:	e81e                	sd	t2,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:37
    # set input argument of trap_handler(cx: &mut TrapContext)
    mv a0, sp
    802052b2:	850a                	mv	a0,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:38
    call trap_handler
    802052b4:	845ff0ef          	jal	ra,80204af8 <trap_handler>

00000000802052b8 <__restore>:
__restore():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:44

__restore:
    # mv sp, a0 // 在此之前sp就已经指向正确的stack
    # now sp->kernel stack(after allocated), sscratch->user stack
    # restore sstatus/sepc
    ld t0, 32*8(sp)
    802052b8:	6292                	ld	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:45
    ld t1, 33*8(sp)
    802052ba:	6332                	ld	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:46
    ld t2, 2*8(sp)
    802052bc:	63c2                	ld	t2,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:47
    csrw sstatus, t0
    802052be:	10029073          	csrw	sstatus,t0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:48
    csrw sepc, t1
    802052c2:	14131073          	csrw	sepc,t1
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:49
    csrw sscratch, t2
    802052c6:	14039073          	csrw	sscratch,t2
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:51
    # restore general-purpuse registers except sp/tp
    ld x1, 1*8(sp)
    802052ca:	60a2                	ld	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:52
    ld x3, 3*8(sp)
    802052cc:	61e2                	ld	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:57
    .set n, 5
    .rept 27
        LOAD_GP %n
        .set n, n+1
    .endr
    802052ce:	72a2                	ld	t0,40(sp)
    802052d0:	7342                	ld	t1,48(sp)
    802052d2:	73e2                	ld	t2,56(sp)
    802052d4:	6406                	ld	s0,64(sp)
    802052d6:	64a6                	ld	s1,72(sp)
    802052d8:	6546                	ld	a0,80(sp)
    802052da:	65e6                	ld	a1,88(sp)
    802052dc:	7606                	ld	a2,96(sp)
    802052de:	76a6                	ld	a3,104(sp)
    802052e0:	7746                	ld	a4,112(sp)
    802052e2:	77e6                	ld	a5,120(sp)
    802052e4:	680a                	ld	a6,128(sp)
    802052e6:	68aa                	ld	a7,136(sp)
    802052e8:	694a                	ld	s2,144(sp)
    802052ea:	69ea                	ld	s3,152(sp)
    802052ec:	7a0a                	ld	s4,160(sp)
    802052ee:	7aaa                	ld	s5,168(sp)
    802052f0:	7b4a                	ld	s6,176(sp)
    802052f2:	7bea                	ld	s7,184(sp)
    802052f4:	6c0e                	ld	s8,192(sp)
    802052f6:	6cae                	ld	s9,200(sp)
    802052f8:	6d4e                	ld	s10,208(sp)
    802052fa:	6dee                	ld	s11,216(sp)
    802052fc:	7e0e                	ld	t3,224(sp)
    802052fe:	7eae                	ld	t4,232(sp)
    80205300:	7f4e                	ld	t5,240(sp)
    80205302:	7fee                	ld	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:59
    # release TrapContext on kernel stack
    addi sp, sp, 34*8
    80205304:	6151                	addi	sp,sp,272
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:61
    # now sp->kernel stack, sscratch->user stack
    csrrw sp, sscratch, sp
    80205306:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:62
    sret
    8020530a:	10200073          	sret
    8020530e:	0000                	unimp
	...

0000000080205312 <__switch>:
__switch():
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:16
    # __switch(
    #     current_task_cx_ptr: *mut TaskContext,
    #     next_task_cx_ptr: *const TaskContext
    # )
    # save kernel stack of current task
    sd sp, 8(a0)
    80205312:	00253423          	sd	sp,8(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:18
    # save ra & s0~s11 of current execution
    sd ra, 0(a0)
    80205316:	00153023          	sd	ra,0(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:23
    .set n, 0
    .rept 12
        SAVE_SN %n
        .set n, n + 1
    .endr
    8020531a:	e900                	sd	s0,16(a0)
    8020531c:	ed04                	sd	s1,24(a0)
    8020531e:	03253023          	sd	s2,32(a0)
    80205322:	03353423          	sd	s3,40(a0)
    80205326:	03453823          	sd	s4,48(a0)
    8020532a:	03553c23          	sd	s5,56(a0)
    8020532e:	05653023          	sd	s6,64(a0)
    80205332:	05753423          	sd	s7,72(a0)
    80205336:	05853823          	sd	s8,80(a0)
    8020533a:	05953c23          	sd	s9,88(a0)
    8020533e:	07a53023          	sd	s10,96(a0)
    80205342:	07b53423          	sd	s11,104(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:25
    # restore ra & s0~s11 of next execution
    ld ra, 0(a1)
    80205346:	0005b083          	ld	ra,0(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:30
    .set n, 0
    .rept 12
        LOAD_SN %n
        .set n, n + 1
    .endr
    8020534a:	6980                	ld	s0,16(a1)
    8020534c:	6d84                	ld	s1,24(a1)
    8020534e:	0205b903          	ld	s2,32(a1)
    80205352:	0285b983          	ld	s3,40(a1)
    80205356:	0305ba03          	ld	s4,48(a1)
    8020535a:	0385ba83          	ld	s5,56(a1)
    8020535e:	0405bb03          	ld	s6,64(a1)
    80205362:	0485bb83          	ld	s7,72(a1)
    80205366:	0505bc03          	ld	s8,80(a1)
    8020536a:	0585bc83          	ld	s9,88(a1)
    8020536e:	0605bd03          	ld	s10,96(a1)
    80205372:	0685bd83          	ld	s11,104(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:32
    # restore kernel stack of next task
    ld sp, 8(a1)
    80205376:	0085b103          	ld	sp,8(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:33
    ret
    8020537a:	8082                	ret
