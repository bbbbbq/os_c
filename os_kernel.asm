
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
/home/caigoubencai/Desktop/os_c/kernel/main.c:14
#include "timer.h"
#include "kernel_heap.h"
#include "mem.h"
#include "fram_allocator.h"
int main_os()
{
    80201920:	1141                	addi	sp,sp,-16
    80201922:	e406                	sd	ra,8(sp)
    80201924:	e022                	sd	s0,0(sp)
    80201926:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/main.c:15
    printk("123%d\n",123);
    80201928:	07b00593          	li	a1,123
    8020192c:	00004517          	auipc	a0,0x4
    80201930:	75c50513          	addi	a0,a0,1884 # 80206088 <rodata_start+0x88>
    80201934:	eb7ff0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/main.c:18
    // console_putchar('1');
    // print_str("123123\n");
    init_interrupt();
    80201938:	196030ef          	jal	ra,80204ace <init_interrupt>
/home/caigoubencai/Desktop/os_c/kernel/main.c:19
    load_app_test();
    8020193c:	6af020ef          	jal	ra,802047ea <load_app_test>
/home/caigoubencai/Desktop/os_c/kernel/main.c:23
    //timer_init();
    // init_appmanager();
    // run_first_app();
    init_appmanager();
    80201940:	381020ef          	jal	ra,802044c0 <init_appmanager>
/home/caigoubencai/Desktop/os_c/kernel/main.c:25
    // init_appmanager();
    task_manager_init();
    80201944:	08f020ef          	jal	ra,802041d2 <task_manager_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:26
    frame_allocator_init();
    80201948:	2dc020ef          	jal	ra,80203c24 <frame_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:30
    //printk("123%d\n",12);
    // PhysPageNum tmp =  StackFrameAllocator_alloc(&fram_allocator); 
    // printk("tmp: %d\n",tmp.num);
    mm_init();
    8020194c:	6e3000ef          	jal	ra,8020282e <mm_init>
/home/caigoubencai/Desktop/os_c/kernel/main.c:31
    ASSERT(0);
    80201950:	45fd                	li	a1,31
    80201952:	00004517          	auipc	a0,0x4
    80201956:	73e50513          	addi	a0,a0,1854 # 80206090 <rodata_start+0x90>
    8020195a:	02b020ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/main.c:32 (discriminator 1)
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
    80202814:	2a9000ef          	jal	ra,802032bc <memory_set_kernel_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:9
  memory_set_activate(&KERNEL_SPACE);
    80202818:	00817517          	auipc	a0,0x817
    8020281c:	7f050513          	addi	a0,a0,2032 # 80a1a008 <KERNEL_SPACE>
    80202820:	43b000ef          	jal	ra,8020345a <memory_set_activate>
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
    8020283a:	3ea010ef          	jal	ra,80203c24 <frame_allocator_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:16
    memory_set_kernel_init();
    8020283e:	fc7ff0ef          	jal	ra,80202804 <memory_set_kernel_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/mem.c:17
    memory_set_remap_test();
    80202842:	449000ef          	jal	ra,8020348a <memory_set_remap_test>
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
    8020297c:	544010ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:69
        print_uint64(header->size); // 打印内存块大小
    80202980:	fe843783          	ld	a5,-24(s0)
    80202984:	639c                	ld	a5,0(a5)
    80202986:	853e                	mv	a0,a5
    80202988:	6b6010ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:70
        print_str(", Free: ");
    8020298c:	00003517          	auipc	a0,0x3
    80202990:	72c50513          	addi	a0,a0,1836 # 802060b8 <rodata_start+0xb8>
    80202994:	52c010ef          	jal	ra,80203ec0 <print_str>
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
    802029b4:	50c010ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/memory/kernel_heap/kernel_heap.c:72 (discriminator 4)
        print_str("\n");
    802029b8:	00003517          	auipc	a0,0x3
    802029bc:	72050513          	addi	a0,a0,1824 # 802060d8 <rodata_start+0xd8>
    802029c0:	500010ef          	jal	ra,80203ec0 <print_str>
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
    return (((pte.bits) >> 10) & ((1L << 44) - 1)); // 从位域中提取物理页号
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
    80202c78:	00e010ef          	jal	ra,80203c86 <StackFrameAllocator_alloc>
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
    80202ca6:	3fc020ef          	jal	ra,802050a2 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:31
    vector_resize(&pt->frames, sizeof(PhysPageNum));
    80202caa:	fe843783          	ld	a5,-24(s0)
    80202cae:	07a1                	addi	a5,a5,8
    80202cb0:	45a1                	li	a1,8
    80202cb2:	853e                	mv	a0,a5
    80202cb4:	442020ef          	jal	ra,802050f6 <vector_resize>
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
    80202cda:	5cc020ef          	jal	ra,802052a6 <vector_free>
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
    80202d12:	0f4010ef          	jal	ra,80203e06 <phys_page_num_to_addr>
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
    80202d76:	40e010ef          	jal	ra,80204184 <panic>
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
    80202dde:	3a6010ef          	jal	ra,80204184 <panic>
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
    80202e4c:	7d3000ef          	jal	ra,80203e1e <decompose_vpn>
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
  vpn_indexes(vpn,idxs);
    80202ee6:	fd843583          	ld	a1,-40(s0)
    80202eea:	fb043503          	ld	a0,-80(s0)
    80202eee:	0ec000ef          	jal	ra,80202fda <vpn_indexes>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:132
  // 从根页表的物理页号开始
  PhysPageNum ppn = pt->root_ppn;
    80202ef2:	fb843783          	ld	a5,-72(s0)
    80202ef6:	639c                	ld	a5,0(a5)
    80202ef8:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:133
  PageTableEntry *result = NULL;
    80202efc:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134
  for (unsigned i = 0; i < 3; i++) 
    80202f00:	fe042223          	sw	zero,-28(s0)
    80202f04:	a86d                	j	80202fbe <page_table_find_pte_create+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:137
  {
    // 根据当前物理页号和索引获取页表项地址
    PageTableEntry *pte = ppn_get_pte_array(ppn) + idxs[i];
    80202f06:	fc843503          	ld	a0,-56(s0)
    80202f0a:	d29ff0ef          	jal	ra,80202c32 <ppn_get_pte_array>
    80202f0e:	86aa                	mv	a3,a0
    80202f10:	fe446783          	lwu	a5,-28(s0)
    80202f14:	078e                	slli	a5,a5,0x3
    80202f16:	fd843703          	ld	a4,-40(s0)
    80202f1a:	97ba                	add	a5,a5,a4
    80202f1c:	639c                	ld	a5,0(a5)
    80202f1e:	078e                	slli	a5,a5,0x3
    80202f20:	97b6                	add	a5,a5,a3
    80202f22:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:139
    // 如果是最后一级页表项，则直接返回该页表项
    if (i == 2) 
    80202f26:	fe442783          	lw	a5,-28(s0)
    80202f2a:	0007871b          	sext.w	a4,a5
    80202f2e:	4789                	li	a5,2
    80202f30:	00f71763          	bne	a4,a5,80202f3e <page_table_find_pte_create+0x68>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:141
    {
      result = pte;
    80202f34:	fd043783          	ld	a5,-48(s0)
    80202f38:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:142
      break;
    80202f3c:	a841                	j	80202fcc <page_table_find_pte_create+0xf6>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:145
    }

    printk("pte: addr : %d \n",pte);
    80202f3e:	fd043583          	ld	a1,-48(s0)
    80202f42:	00003517          	auipc	a0,0x3
    80202f46:	1c650513          	addi	a0,a0,454 # 80206108 <rodata_start+0x108>
    80202f4a:	8a1fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:146
    if (!pte_is_valid(*pte)) 
    80202f4e:	fd043783          	ld	a5,-48(s0)
    80202f52:	6388                	ld	a0,0(a5)
    80202f54:	be7ff0ef          	jal	ra,80202b3a <pte_is_valid>
    80202f58:	87aa                	mv	a5,a0
    80202f5a:	e7a9                	bnez	a5,80202fa4 <page_table_find_pte_create+0xce>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:149
    {
      // 分配新的物理页
      PhysPageNum frame = StackFrameAllocator_alloc(&fram_allocator);
    80202f5c:	00817517          	auipc	a0,0x817
    80202f60:	0e450513          	addi	a0,a0,228 # 80a1a040 <fram_allocator>
    80202f64:	523000ef          	jal	ra,80203c86 <StackFrameAllocator_alloc>
    80202f68:	87aa                	mv	a5,a0
    80202f6a:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:152
      //trace("frame alloc 0x%llx\n", frame);
      // 检查物理页分配是否成功 
      if (frame.num == 0x80000000 ) 
    80202f6e:	fc043703          	ld	a4,-64(s0)
    80202f72:	4785                	li	a5,1
    80202f74:	07fe                	slli	a5,a5,0x1f
    80202f76:	00f71463          	bne	a4,a5,80202f7e <page_table_find_pte_create+0xa8>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:154
      {
        return NULL;
    80202f7a:	4781                	li	a5,0
    80202f7c:	a891                	j	80202fd0 <page_table_find_pte_create+0xfa>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:157
      }
      // 将新分配的物理页设置为当前页表项指向的物理页，并标记为有效
      *pte = pte_new(frame.num, PTE_V);
    80202f7e:	fc043783          	ld	a5,-64(s0)
    80202f82:	4585                	li	a1,1
    80202f84:	853e                	mv	a0,a5
    80202f86:	b37ff0ef          	jal	ra,80202abc <pte_new>
    80202f8a:	872a                	mv	a4,a0
    80202f8c:	fd043783          	ld	a5,-48(s0)
    80202f90:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:159
      // 将新分配的物理页加入到页表项向量中
      vector_add(&pt->frames, &frame);
    80202f92:	fb843783          	ld	a5,-72(s0)
    80202f96:	07a1                	addi	a5,a5,8
    80202f98:	fc040713          	addi	a4,s0,-64
    80202f9c:	85ba                	mv	a1,a4
    80202f9e:	853e                	mv	a0,a5
    80202fa0:	1a2020ef          	jal	ra,80205142 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:162 (discriminator 2)
    }
    // 更新当前物理页号为当前页表项指向的下一级物理页号，以便继续遍历
        ppn.num = pte_ppn(*pte);
    80202fa4:	fd043783          	ld	a5,-48(s0)
    80202fa8:	6388                	ld	a0,0(a5)
    80202faa:	b57ff0ef          	jal	ra,80202b00 <pte_ppn>
    80202fae:	87aa                	mv	a5,a0
    80202fb0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134 (discriminator 2)
  for (unsigned i = 0; i < 3; i++) 
    80202fb4:	fe442783          	lw	a5,-28(s0)
    80202fb8:	2785                	addiw	a5,a5,1
    80202fba:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:134 (discriminator 1)
    80202fbe:	fe442783          	lw	a5,-28(s0)
    80202fc2:	0007871b          	sext.w	a4,a5
    80202fc6:	4789                	li	a5,2
    80202fc8:	f2e7ffe3          	bgeu	a5,a4,80202f06 <page_table_find_pte_create+0x30>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:165
  }
  // 返回找到或创建的页表项
  return result;
    80202fcc:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:166 (discriminator 1)
}
    80202fd0:	853e                	mv	a0,a5
    80202fd2:	60a6                	ld	ra,72(sp)
    80202fd4:	6406                	ld	s0,64(sp)
    80202fd6:	6161                	addi	sp,sp,80
    80202fd8:	8082                	ret

0000000080202fda <vpn_indexes>:
vpn_indexes():
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:169

void vpn_indexes(VirtPageNum vpn, uint64_t *idx) 
{
    80202fda:	7179                	addi	sp,sp,-48
    80202fdc:	f422                	sd	s0,40(sp)
    80202fde:	1800                	addi	s0,sp,48
    80202fe0:	fca43c23          	sd	a0,-40(s0)
    80202fe4:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:170
  for (int i = 2; i >= 0; i--) 
    80202fe8:	4789                	li	a5,2
    80202fea:	fef42623          	sw	a5,-20(s0)
    80202fee:	a035                	j	8020301a <vpn_indexes+0x40>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:172 (discriminator 3)
  {
    idx[i] = vpn.num & 0x1ff;
    80202ff0:	fd843703          	ld	a4,-40(s0)
    80202ff4:	fec42783          	lw	a5,-20(s0)
    80202ff8:	078e                	slli	a5,a5,0x3
    80202ffa:	fd043683          	ld	a3,-48(s0)
    80202ffe:	97b6                	add	a5,a5,a3
    80203000:	1ff77713          	andi	a4,a4,511
    80203004:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:173 (discriminator 3)
    vpn.num >>= 9;
    80203006:	fd843783          	ld	a5,-40(s0)
    8020300a:	83a5                	srli	a5,a5,0x9
    8020300c:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:170 (discriminator 3)
  for (int i = 2; i >= 0; i--) 
    80203010:	fec42783          	lw	a5,-20(s0)
    80203014:	37fd                	addiw	a5,a5,-1
    80203016:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:170 (discriminator 1)
    8020301a:	fec42783          	lw	a5,-20(s0)
    8020301e:	2781                	sext.w	a5,a5
    80203020:	fc07d8e3          	bgez	a5,80202ff0 <vpn_indexes+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/pagetable/pagetable.c:175
  }
    80203024:	0001                	nop
    80203026:	0001                	nop
    80203028:	7422                	ld	s0,40(sp)
    8020302a:	6145                	addi	sp,sp,48
    8020302c:	8082                	ret

000000008020302e <map_area_init>:
map_area_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:22
extern void bss_end();
extern void ekernel();
extern void strampoline(); // trap跳板位置
MemorySet KERNEL_SPACE;
void map_area_init(MapArea* ma, VirtAddr start_va, VirtAddr end_va, enum MapType mt, MapPermission mp)
{
    8020302e:	7139                	addi	sp,sp,-64
    80203030:	fc06                	sd	ra,56(sp)
    80203032:	f822                	sd	s0,48(sp)
    80203034:	f426                	sd	s1,40(sp)
    80203036:	0080                	addi	s0,sp,64
    80203038:	fca43c23          	sd	a0,-40(s0)
    8020303c:	fcb43823          	sd	a1,-48(s0)
    80203040:	fcc43423          	sd	a2,-56(s0)
    80203044:	87b6                	mv	a5,a3
    80203046:	fcf42223          	sw	a5,-60(s0)
    8020304a:	87ba                	mv	a5,a4
    8020304c:	fcf42023          	sw	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:23
    ma->vpn_range.start_vpn = virt_addr_to_page_num(start_va, 0);
    80203050:	fd843483          	ld	s1,-40(s0)
    80203054:	4581                	li	a1,0
    80203056:	fd043503          	ld	a0,-48(s0)
    8020305a:	555000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    8020305e:	e088                	sd	a0,0(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:24
    ma->vpn_range.size = virt_addr_to_page_num(end_va, 1).num - ma->vpn_range.start_vpn.num;
    80203060:	4585                	li	a1,1
    80203062:	fc843503          	ld	a0,-56(s0)
    80203066:	549000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    8020306a:	87aa                	mv	a5,a0
    8020306c:	873e                	mv	a4,a5
    8020306e:	fd843783          	ld	a5,-40(s0)
    80203072:	639c                	ld	a5,0(a5)
    80203074:	8f1d                	sub	a4,a4,a5
    80203076:	fd843783          	ld	a5,-40(s0)
    8020307a:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:25
    ma->map_type = mt;
    8020307c:	fd843783          	ld	a5,-40(s0)
    80203080:	fc442703          	lw	a4,-60(s0)
    80203084:	cb98                	sw	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:26
    ma->map_premission = mp;
    80203086:	fd843783          	ld	a5,-40(s0)
    8020308a:	fc042703          	lw	a4,-64(s0)
    8020308e:	cbd8                	sw	a4,20(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:27
}
    80203090:	0001                	nop
    80203092:	70e2                	ld	ra,56(sp)
    80203094:	7442                	ld	s0,48(sp)
    80203096:	74a2                	ld	s1,40(sp)
    80203098:	6121                	addi	sp,sp,64
    8020309a:	8082                	ret

000000008020309c <map_area_map>:
map_area_map():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:30

void map_area_map(MapArea* ma, PageTable* pt)
{
    8020309c:	7139                	addi	sp,sp,-64
    8020309e:	fc06                	sd	ra,56(sp)
    802030a0:	f822                	sd	s0,48(sp)
    802030a2:	0080                	addi	s0,sp,64
    802030a4:	fca43423          	sd	a0,-56(s0)
    802030a8:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32
    PhysPageNum target;
    for(int64_t i = 0; i < ma->vpn_range.size; i ++)
    802030ac:	fe043423          	sd	zero,-24(s0)
    802030b0:	a095                	j	80203114 <map_area_map+0x78>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:34
    {
        if (ma->map_type == Identical)
    802030b2:	fc843783          	ld	a5,-56(s0)
    802030b6:	4b9c                	lw	a5,16(a5)
    802030b8:	eb91                	bnez	a5,802030cc <map_area_map+0x30>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:36
        {
            target.num = ma->vpn_range.start_vpn.num + i;
    802030ba:	fc843783          	ld	a5,-56(s0)
    802030be:	6398                	ld	a4,0(a5)
    802030c0:	fe843783          	ld	a5,-24(s0)
    802030c4:	97ba                	add	a5,a5,a4
    802030c6:	fef43023          	sd	a5,-32(s0)
    802030ca:	a811                	j	802030de <map_area_map+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:39
        } else 
        {
            target = StackFrameAllocator_alloc(&fram_allocator);
    802030cc:	00817517          	auipc	a0,0x817
    802030d0:	f7450513          	addi	a0,a0,-140 # 80a1a040 <fram_allocator>
    802030d4:	3b3000ef          	jal	ra,80203c86 <StackFrameAllocator_alloc>
    802030d8:	87aa                	mv	a5,a0
    802030da:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:42 (discriminator 2)
        }
        VirtPageNum vpn;
        vpn.num = ma->vpn_range.start_vpn.num+i;
    802030de:	fc843783          	ld	a5,-56(s0)
    802030e2:	6398                	ld	a4,0(a5)
    802030e4:	fe843783          	ld	a5,-24(s0)
    802030e8:	97ba                	add	a5,a5,a4
    802030ea:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:43 (discriminator 2)
        PageTable_map_ppn_2_vpn(pt, vpn, target, ma->map_premission);
    802030ee:	fc843783          	ld	a5,-56(s0)
    802030f2:	4bdc                	lw	a5,20(a5)
    802030f4:	0ff7f793          	andi	a5,a5,255
    802030f8:	86be                	mv	a3,a5
    802030fa:	fe043603          	ld	a2,-32(s0)
    802030fe:	fd843583          	ld	a1,-40(s0)
    80203102:	fc043503          	ld	a0,-64(s0)
    80203106:	c2dff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32 (discriminator 2)
    for(int64_t i = 0; i < ma->vpn_range.size; i ++)
    8020310a:	fe843783          	ld	a5,-24(s0)
    8020310e:	0785                	addi	a5,a5,1
    80203110:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:32 (discriminator 1)
    80203114:	fc843783          	ld	a5,-56(s0)
    80203118:	6798                	ld	a4,8(a5)
    8020311a:	fe843783          	ld	a5,-24(s0)
    8020311e:	f8e7eae3          	bltu	a5,a4,802030b2 <map_area_map+0x16>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:45
    }
}
    80203122:	0001                	nop
    80203124:	0001                	nop
    80203126:	70e2                	ld	ra,56(sp)
    80203128:	7442                	ld	s0,48(sp)
    8020312a:	6121                	addi	sp,sp,64
    8020312c:	8082                	ret

000000008020312e <memory_set_init>:
memory_set_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:48

void memory_set_init(MemorySet* ms)
{
    8020312e:	1101                	addi	sp,sp,-32
    80203130:	ec06                	sd	ra,24(sp)
    80203132:	e822                	sd	s0,16(sp)
    80203134:	1000                	addi	s0,sp,32
    80203136:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:49
    ms->page_table = *PageTable_new();
    8020313a:	b19ff0ef          	jal	ra,80202c52 <PageTable_new>
    8020313e:	872a                	mv	a4,a0
    80203140:	fe843783          	ld	a5,-24(s0)
    80203144:	630c                	ld	a1,0(a4)
    80203146:	6710                	ld	a2,8(a4)
    80203148:	6b14                	ld	a3,16(a4)
    8020314a:	6f18                	ld	a4,24(a4)
    8020314c:	e38c                	sd	a1,0(a5)
    8020314e:	e790                	sd	a2,8(a5)
    80203150:	eb94                	sd	a3,16(a5)
    80203152:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:50
    vector_init(&ms->areas);
    80203154:	fe843783          	ld	a5,-24(s0)
    80203158:	02078793          	addi	a5,a5,32 # 1020 <n+0x1000>
    8020315c:	853e                	mv	a0,a5
    8020315e:	745010ef          	jal	ra,802050a2 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:51
    vector_resize(&ms->areas,sizeof(MapArea));
    80203162:	fe843783          	ld	a5,-24(s0)
    80203166:	02078793          	addi	a5,a5,32
    8020316a:	45e1                	li	a1,24
    8020316c:	853e                	mv	a0,a5
    8020316e:	789010ef          	jal	ra,802050f6 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:52
}
    80203172:	0001                	nop
    80203174:	60e2                	ld	ra,24(sp)
    80203176:	6442                	ld	s0,16(sp)
    80203178:	6105                	addi	sp,sp,32
    8020317a:	8082                	ret

000000008020317c <memory_set_push>:
memory_set_push():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:55

void memory_set_push(MemorySet* ms, MapArea* ma)
{
    8020317c:	1101                	addi	sp,sp,-32
    8020317e:	ec06                	sd	ra,24(sp)
    80203180:	e822                	sd	s0,16(sp)
    80203182:	1000                	addi	s0,sp,32
    80203184:	fea43423          	sd	a0,-24(s0)
    80203188:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:56
    vector_add(&ms->areas, ma);
    8020318c:	fe843783          	ld	a5,-24(s0)
    80203190:	02078793          	addi	a5,a5,32
    80203194:	fe043583          	ld	a1,-32(s0)
    80203198:	853e                	mv	a0,a5
    8020319a:	7a9010ef          	jal	ra,80205142 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:57
    map_area_map(ma, &ms->page_table);
    8020319e:	fe843783          	ld	a5,-24(s0)
    802031a2:	85be                	mv	a1,a5
    802031a4:	fe043503          	ld	a0,-32(s0)
    802031a8:	ef5ff0ef          	jal	ra,8020309c <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:58
}
    802031ac:	0001                	nop
    802031ae:	60e2                	ld	ra,24(sp)
    802031b0:	6442                	ld	s0,16(sp)
    802031b2:	6105                	addi	sp,sp,32
    802031b4:	8082                	ret

00000000802031b6 <memory_set_map_user_stack>:
memory_set_map_user_stack():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:61

void memory_set_map_user_stack(MemorySet *ms, VirtAddr user_stack_low_va)
{
    802031b6:	7139                	addi	sp,sp,-64
    802031b8:	fc06                	sd	ra,56(sp)
    802031ba:	f822                	sd	s0,48(sp)
    802031bc:	f426                	sd	s1,40(sp)
    802031be:	0080                	addi	s0,sp,64
    802031c0:	fca43423          	sd	a0,-56(s0)
    802031c4:	fcb43023          	sd	a1,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:62
    PhysPageNum user_stack_ppn = StackFrameAllocator_alloc(&fram_allocator);
    802031c8:	00817517          	auipc	a0,0x817
    802031cc:	e7850513          	addi	a0,a0,-392 # 80a1a040 <fram_allocator>
    802031d0:	2b7000ef          	jal	ra,80203c86 <StackFrameAllocator_alloc>
    802031d4:	87aa                	mv	a5,a0
    802031d6:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:63
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(user_stack_low_va,1),user_stack_ppn,PTE_R|PTE_W|PTE_U);
    802031da:	fc843483          	ld	s1,-56(s0)
    802031de:	4585                	li	a1,1
    802031e0:	fc043503          	ld	a0,-64(s0)
    802031e4:	3cb000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    802031e8:	87aa                	mv	a5,a0
    802031ea:	46d9                	li	a3,22
    802031ec:	fd843603          	ld	a2,-40(s0)
    802031f0:	85be                	mv	a1,a5
    802031f2:	8526                	mv	a0,s1
    802031f4:	b3fff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:64
}
    802031f8:	0001                	nop
    802031fa:	70e2                	ld	ra,56(sp)
    802031fc:	7442                	ld	s0,48(sp)
    802031fe:	74a2                	ld	s1,40(sp)
    80203200:	6121                	addi	sp,sp,64
    80203202:	8082                	ret

0000000080203204 <memory_set_map_kernel_stack_kernel>:
memory_set_map_kernel_stack_kernel():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:67

void memory_set_map_kernel_stack_kernel(MemorySet *ms)
{
    80203204:	7139                	addi	sp,sp,-64
    80203206:	fc06                	sd	ra,56(sp)
    80203208:	f822                	sd	s0,48(sp)
    8020320a:	f426                	sd	s1,40(sp)
    8020320c:	0080                	addi	s0,sp,64
    8020320e:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:68
    PhysPageNum kernel_stack = StackFrameAllocator_alloc(&fram_allocator);
    80203212:	00817517          	auipc	a0,0x817
    80203216:	e2e50513          	addi	a0,a0,-466 # 80a1a040 <fram_allocator>
    8020321a:	26d000ef          	jal	ra,80203c86 <StackFrameAllocator_alloc>
    8020321e:	87aa                	mv	a5,a0
    80203220:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:70
    VirtAddr va;
    va.addr = TRAP_CONTEXT_FULL;
    80203224:	77f9                	lui	a5,0xffffe
    80203226:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:71
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,1),kernel_stack,(PTE_R|PTE_W));
    8020322a:	fc843483          	ld	s1,-56(s0)
    8020322e:	4585                	li	a1,1
    80203230:	fd043503          	ld	a0,-48(s0)
    80203234:	37b000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203238:	87aa                	mv	a5,a0
    8020323a:	4699                	li	a3,6
    8020323c:	fd843603          	ld	a2,-40(s0)
    80203240:	85be                	mv	a1,a5
    80203242:	8526                	mv	a0,s1
    80203244:	aefff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:72
}
    80203248:	0001                	nop
    8020324a:	70e2                	ld	ra,56(sp)
    8020324c:	7442                	ld	s0,48(sp)
    8020324e:	74a2                	ld	s1,40(sp)
    80203250:	6121                	addi	sp,sp,64
    80203252:	8082                	ret

0000000080203254 <memory_set_map_trampoline>:
memory_set_map_trampoline():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:75

void memory_set_map_trampoline(MemorySet *ms)
{
    80203254:	715d                	addi	sp,sp,-80
    80203256:	e486                	sd	ra,72(sp)
    80203258:	e0a2                	sd	s0,64(sp)
    8020325a:	fc26                	sd	s1,56(sp)
    8020325c:	f84a                	sd	s2,48(sp)
    8020325e:	0880                	addi	s0,sp,80
    80203260:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:77
    VirtAddr va;
    va.addr = TRAMPOLINE;
    80203264:	77fd                	lui	a5,0xfffff
    80203266:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:79
    PhysAddr pha;
    pha.addr = (size_t)&strampoline;
    8020326a:	ffffe797          	auipc	a5,0xffffe
    8020326e:	d9678793          	addi	a5,a5,-618 # 80201000 <port_write>
    80203272:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:80
    VirtPageNum tmp = virt_addr_to_page_num(va,1);
    80203276:	4585                	li	a1,1
    80203278:	fd843503          	ld	a0,-40(s0)
    8020327c:	333000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203280:	87aa                	mv	a5,a0
    80203282:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:81
    PageTable_map_ppn_2_vpn(&ms->page_table,virt_addr_to_page_num(va,0),phys_addr_to_page_num(pha,1),PTE_R|PTE_X);
    80203286:	fb843483          	ld	s1,-72(s0)
    8020328a:	4581                	li	a1,0
    8020328c:	fd843503          	ld	a0,-40(s0)
    80203290:	31f000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203294:	892a                	mv	s2,a0
    80203296:	4585                	li	a1,1
    80203298:	fd043503          	ld	a0,-48(s0)
    8020329c:	2d3000ef          	jal	ra,80203d6e <phys_addr_to_page_num>
    802032a0:	87aa                	mv	a5,a0
    802032a2:	46a9                	li	a3,10
    802032a4:	863e                	mv	a2,a5
    802032a6:	85ca                	mv	a1,s2
    802032a8:	8526                	mv	a0,s1
    802032aa:	a89ff0ef          	jal	ra,80202d32 <PageTable_map_ppn_2_vpn>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:82
}
    802032ae:	0001                	nop
    802032b0:	60a6                	ld	ra,72(sp)
    802032b2:	6406                	ld	s0,64(sp)
    802032b4:	74e2                	ld	s1,56(sp)
    802032b6:	7942                	ld	s2,48(sp)
    802032b8:	6161                	addi	sp,sp,80
    802032ba:	8082                	ret

00000000802032bc <memory_set_kernel_new>:
memory_set_kernel_new():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:84

void memory_set_kernel_new(MemorySet* ms) {
    802032bc:	715d                	addi	sp,sp,-80
    802032be:	e486                	sd	ra,72(sp)
    802032c0:	e0a2                	sd	s0,64(sp)
    802032c2:	0880                	addi	s0,sp,80
    802032c4:	faa43c23          	sd	a0,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:86
    MapArea ma_tmp;
    printk("[mm/memory_set.c] text: 0x%x - 0x%x\n", (uint64_t)text_start, (uint64_t)text_end);
    802032c8:	ffffd797          	auipc	a5,0xffffd
    802032cc:	d3878793          	addi	a5,a5,-712 # 80200000 <_start>
    802032d0:	00003717          	auipc	a4,0x3
    802032d4:	d3070713          	addi	a4,a4,-720 # 80206000 <rodata_start>
    802032d8:	863a                	mv	a2,a4
    802032da:	85be                	mv	a1,a5
    802032dc:	00003517          	auipc	a0,0x3
    802032e0:	e4450513          	addi	a0,a0,-444 # 80206120 <rodata_start+0x120>
    802032e4:	d06fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:87
    printk("[mm/memory_set.c] rodata: 0x%x - 0x%x\n", (uint64_t)rodata_start, (uint64_t)rodata_end);
    802032e8:	00003797          	auipc	a5,0x3
    802032ec:	d1878793          	addi	a5,a5,-744 # 80206000 <rodata_start>
    802032f0:	00004717          	auipc	a4,0x4
    802032f4:	d1070713          	addi	a4,a4,-752 # 80207000 <_num_app>
    802032f8:	863a                	mv	a2,a4
    802032fa:	85be                	mv	a1,a5
    802032fc:	00003517          	auipc	a0,0x3
    80203300:	e4c50513          	addi	a0,a0,-436 # 80206148 <rodata_start+0x148>
    80203304:	ce6fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:88
    printk("[mm/memory_set.c] data: 0x%x - 0x%x\n", (uint64_t)data_start, (uint64_t)data_end);
    80203308:	00004797          	auipc	a5,0x4
    8020330c:	cf878793          	addi	a5,a5,-776 # 80207000 <_num_app>
    80203310:	00007717          	auipc	a4,0x7
    80203314:	cf070713          	addi	a4,a4,-784 # 8020a000 <boot_stack_lower_bound>
    80203318:	863a                	mv	a2,a4
    8020331a:	85be                	mv	a1,a5
    8020331c:	00003517          	auipc	a0,0x3
    80203320:	e5450513          	addi	a0,a0,-428 # 80206170 <rodata_start+0x170>
    80203324:	cc6fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:89
    printk("[mm/memory_set.c] bss: 0x%x - 0x%x\n", (uint64_t)bss_start, (uint64_t)bss_end);
    80203328:	00007797          	auipc	a5,0x7
    8020332c:	cd878793          	addi	a5,a5,-808 # 8020a000 <boot_stack_lower_bound>
    80203330:	00868717          	auipc	a4,0x868
    80203334:	cd070713          	addi	a4,a4,-816 # 80a6b000 <bss_end>
    80203338:	863a                	mv	a2,a4
    8020333a:	85be                	mv	a1,a5
    8020333c:	00003517          	auipc	a0,0x3
    80203340:	e5c50513          	addi	a0,a0,-420 # 80206198 <rodata_start+0x198>
    80203344:	ca6fe0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:90
    memory_set_new_bare(ms);
    80203348:	fb843503          	ld	a0,-72(s0)
    8020334c:	288000ef          	jal	ra,802035d4 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:91
    memory_set_map_trampoline(ms);
    80203350:	fb843503          	ld	a0,-72(s0)
    80203354:	f01ff0ef          	jal	ra,80203254 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:92
    memory_set_map_kernel_stack_kernel(ms);
    80203358:	fb843503          	ld	a0,-72(s0)
    8020335c:	ea9ff0ef          	jal	ra,80203204 <memory_set_map_kernel_stack_kernel>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:94
    VirtAddr vads, vade;
    vads.addr = (uint64_t)text_start;
    80203360:	ffffd797          	auipc	a5,0xffffd
    80203364:	ca078793          	addi	a5,a5,-864 # 80200000 <_start>
    80203368:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:95
    vade.addr = (uint64_t)text_end;
    8020336c:	00003797          	auipc	a5,0x3
    80203370:	c9478793          	addi	a5,a5,-876 # 80206000 <rodata_start>
    80203374:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:96
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_X);
    80203378:	fd840793          	addi	a5,s0,-40
    8020337c:	4729                	li	a4,10
    8020337e:	4681                	li	a3,0
    80203380:	fc843603          	ld	a2,-56(s0)
    80203384:	fd043583          	ld	a1,-48(s0)
    80203388:	853e                	mv	a0,a5
    8020338a:	ca5ff0ef          	jal	ra,8020302e <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:97
    memory_set_push(ms, &ma_tmp);
    8020338e:	fd840793          	addi	a5,s0,-40
    80203392:	85be                	mv	a1,a5
    80203394:	fb843503          	ld	a0,-72(s0)
    80203398:	de5ff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:100

    // .rodata segment
    vads.addr = (uint64_t)rodata_start;
    8020339c:	00003797          	auipc	a5,0x3
    802033a0:	c6478793          	addi	a5,a5,-924 # 80206000 <rodata_start>
    802033a4:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:101
    vade.addr = (uint64_t)rodata_end;
    802033a8:	00004797          	auipc	a5,0x4
    802033ac:	c5878793          	addi	a5,a5,-936 # 80207000 <_num_app>
    802033b0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:102
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R);
    802033b4:	fd840793          	addi	a5,s0,-40
    802033b8:	4709                	li	a4,2
    802033ba:	4681                	li	a3,0
    802033bc:	fc843603          	ld	a2,-56(s0)
    802033c0:	fd043583          	ld	a1,-48(s0)
    802033c4:	853e                	mv	a0,a5
    802033c6:	c69ff0ef          	jal	ra,8020302e <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:103
    memory_set_push(ms, &ma_tmp);
    802033ca:	fd840793          	addi	a5,s0,-40
    802033ce:	85be                	mv	a1,a5
    802033d0:	fb843503          	ld	a0,-72(s0)
    802033d4:	da9ff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:106

    // .data segment
    vads.addr = (uint64_t)data_start;
    802033d8:	00004797          	auipc	a5,0x4
    802033dc:	c2878793          	addi	a5,a5,-984 # 80207000 <_num_app>
    802033e0:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:107
    vade.addr = (uint64_t)data_end;
    802033e4:	00007797          	auipc	a5,0x7
    802033e8:	c1c78793          	addi	a5,a5,-996 # 8020a000 <boot_stack_lower_bound>
    802033ec:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:108
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    802033f0:	fd840793          	addi	a5,s0,-40
    802033f4:	4719                	li	a4,6
    802033f6:	4681                	li	a3,0
    802033f8:	fc843603          	ld	a2,-56(s0)
    802033fc:	fd043583          	ld	a1,-48(s0)
    80203400:	853e                	mv	a0,a5
    80203402:	c2dff0ef          	jal	ra,8020302e <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:109
    memory_set_push(ms, &ma_tmp);
    80203406:	fd840793          	addi	a5,s0,-40
    8020340a:	85be                	mv	a1,a5
    8020340c:	fb843503          	ld	a0,-72(s0)
    80203410:	d6dff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:112

    // .bss segment
    vads.addr = (uint64_t)bss_start;
    80203414:	00007797          	auipc	a5,0x7
    80203418:	bec78793          	addi	a5,a5,-1044 # 8020a000 <boot_stack_lower_bound>
    8020341c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:113
    vade.addr = (uint64_t)bss_end;
    80203420:	00868797          	auipc	a5,0x868
    80203424:	be078793          	addi	a5,a5,-1056 # 80a6b000 <bss_end>
    80203428:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:114
    map_area_init(&ma_tmp, vads, vade, MAP_IDENTICAL, MAP_PERM_R | MAP_PERM_W);
    8020342c:	fd840793          	addi	a5,s0,-40
    80203430:	4719                	li	a4,6
    80203432:	4681                	li	a3,0
    80203434:	fc843603          	ld	a2,-56(s0)
    80203438:	fd043583          	ld	a1,-48(s0)
    8020343c:	853e                	mv	a0,a5
    8020343e:	bf1ff0ef          	jal	ra,8020302e <map_area_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:115
    memory_set_push(ms, &ma_tmp);
    80203442:	fd840793          	addi	a5,s0,-40
    80203446:	85be                	mv	a1,a5
    80203448:	fb843503          	ld	a0,-72(s0)
    8020344c:	d31ff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:116
}
    80203450:	0001                	nop
    80203452:	60a6                	ld	ra,72(sp)
    80203454:	6406                	ld	s0,64(sp)
    80203456:	6161                	addi	sp,sp,80
    80203458:	8082                	ret

000000008020345a <memory_set_activate>:
memory_set_activate():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:119

void memory_set_activate(MemorySet *memory_set)
{
    8020345a:	7179                	addi	sp,sp,-48
    8020345c:	f406                	sd	ra,40(sp)
    8020345e:	f022                	sd	s0,32(sp)
    80203460:	1800                	addi	s0,sp,48
    80203462:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:120
    uint64_t satp = page_table_token(&memory_set->page_table);
    80203466:	fd843783          	ld	a5,-40(s0)
    8020346a:	853e                	mv	a0,a5
    8020346c:	9adff0ef          	jal	ra,80202e18 <page_table_token>
    80203470:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:121
    WRITE_CSR(satp,satp);
    80203474:	fe843783          	ld	a5,-24(s0)
    80203478:	18079073          	csrw	satp,a5
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:122
    asm volatile("sfence.vma zero, zero");
    8020347c:	12000073          	sfence.vma
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:123
}
    80203480:	0001                	nop
    80203482:	70a2                	ld	ra,40(sp)
    80203484:	7402                	ld	s0,32(sp)
    80203486:	6145                	addi	sp,sp,48
    80203488:	8082                	ret

000000008020348a <memory_set_remap_test>:
memory_set_remap_test():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:126

void memory_set_remap_test()
{
    8020348a:	711d                	addi	sp,sp,-96
    8020348c:	ec86                	sd	ra,88(sp)
    8020348e:	e8a2                	sd	s0,80(sp)
    80203490:	1080                	addi	s0,sp,96
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:128
    VirtAddr mid_text;
    mid_text.addr = (((uint64_t)&text_start + (uint64_t)&text_end) / 2);
    80203492:	ffffd717          	auipc	a4,0xffffd
    80203496:	b6e70713          	addi	a4,a4,-1170 # 80200000 <_start>
    8020349a:	00003797          	auipc	a5,0x3
    8020349e:	b6678793          	addi	a5,a5,-1178 # 80206000 <rodata_start>
    802034a2:	97ba                	add	a5,a5,a4
    802034a4:	8385                	srli	a5,a5,0x1
    802034a6:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:130
    VirtAddr mid_rodata;
    mid_rodata.addr = (((uint64_t)&rodata_start + (uint64_t)&rodata_end) / 2);
    802034aa:	00003717          	auipc	a4,0x3
    802034ae:	b5670713          	addi	a4,a4,-1194 # 80206000 <rodata_start>
    802034b2:	00004797          	auipc	a5,0x4
    802034b6:	b4e78793          	addi	a5,a5,-1202 # 80207000 <_num_app>
    802034ba:	97ba                	add	a5,a5,a4
    802034bc:	8385                	srli	a5,a5,0x1
    802034be:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:132
    VirtAddr mid_data;
    mid_data.addr = (((uint64_t)&data_start + (uint64_t)&data_end) / 2);
    802034c2:	00004717          	auipc	a4,0x4
    802034c6:	b3e70713          	addi	a4,a4,-1218 # 80207000 <_num_app>
    802034ca:	00007797          	auipc	a5,0x7
    802034ce:	b3678793          	addi	a5,a5,-1226 # 8020a000 <boot_stack_lower_bound>
    802034d2:	97ba                	add	a5,a5,a4
    802034d4:	8385                	srli	a5,a5,0x1
    802034d6:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:134

    VirtPageNum text = virt_addr_to_page_num(mid_text,1);
    802034da:	4585                	li	a1,1
    802034dc:	fd043503          	ld	a0,-48(s0)
    802034e0:	0cf000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    802034e4:	87aa                	mv	a5,a0
    802034e6:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:135
    VirtPageNum rodata = virt_addr_to_page_num(mid_rodata,1);
    802034ea:	4585                	li	a1,1
    802034ec:	fc843503          	ld	a0,-56(s0)
    802034f0:	0bf000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    802034f4:	87aa                	mv	a5,a0
    802034f6:	faf43823          	sd	a5,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:136
    VirtPageNum data = virt_addr_to_page_num(mid_data,1);
    802034fa:	4585                	li	a1,1
    802034fc:	fc043503          	ld	a0,-64(s0)
    80203500:	0af000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203504:	87aa                	mv	a5,a0
    80203506:	faf43423          	sd	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:137
    PageTableEntry* p1 = page_table_find_pte(&(KERNEL_SPACE.page_table),text);
    8020350a:	fb843583          	ld	a1,-72(s0)
    8020350e:	00817517          	auipc	a0,0x817
    80203512:	afa50513          	addi	a0,a0,-1286 # 80a1a008 <KERNEL_SPACE>
    80203516:	921ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    8020351a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:138
    PageTableEntry* p2 = page_table_find_pte(&(KERNEL_SPACE.page_table),rodata);
    8020351e:	fb043583          	ld	a1,-80(s0)
    80203522:	00817517          	auipc	a0,0x817
    80203526:	ae650513          	addi	a0,a0,-1306 # 80a1a008 <KERNEL_SPACE>
    8020352a:	90dff0ef          	jal	ra,80202e36 <page_table_find_pte>
    8020352e:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:139
    PageTableEntry* p3 = page_table_find_pte(&(KERNEL_SPACE.page_table),data);
    80203532:	fa843583          	ld	a1,-88(s0)
    80203536:	00817517          	auipc	a0,0x817
    8020353a:	ad250513          	addi	a0,a0,-1326 # 80a1a008 <KERNEL_SPACE>
    8020353e:	8f9ff0ef          	jal	ra,80202e36 <page_table_find_pte>
    80203542:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:142

    // 检查text区域是否可执行且不可写
    ASSERT(pte_is_executable(*p1) && !pte_is_writable(*p1));
    80203546:	fe843783          	ld	a5,-24(s0)
    8020354a:	6388                	ld	a0,0(a5)
    8020354c:	e7eff0ef          	jal	ra,80202bca <pte_is_executable>
    80203550:	87aa                	mv	a5,a0
    80203552:	cb81                	beqz	a5,80203562 <memory_set_remap_test+0xd8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:142 (discriminator 2)
    80203554:	fe843783          	ld	a5,-24(s0)
    80203558:	6388                	ld	a0,0(a5)
    8020355a:	e40ff0ef          	jal	ra,80202b9a <pte_is_writable>
    8020355e:	87aa                	mv	a5,a0
    80203560:	cb89                	beqz	a5,80203572 <memory_set_remap_test+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:142 (discriminator 3)
    80203562:	08e00593          	li	a1,142
    80203566:	00003517          	auipc	a0,0x3
    8020356a:	c5a50513          	addi	a0,a0,-934 # 802061c0 <rodata_start+0x1c0>
    8020356e:	417000ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:145

    // 检查rodata区域是否可读且不可写
    ASSERT(pte_is_readable(*p2) && !pte_is_writable(*p2));
    80203572:	fe043783          	ld	a5,-32(s0)
    80203576:	6388                	ld	a0,0(a5)
    80203578:	df2ff0ef          	jal	ra,80202b6a <pte_is_readable>
    8020357c:	87aa                	mv	a5,a0
    8020357e:	cb81                	beqz	a5,8020358e <memory_set_remap_test+0x104>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:145 (discriminator 2)
    80203580:	fe043783          	ld	a5,-32(s0)
    80203584:	6388                	ld	a0,0(a5)
    80203586:	e14ff0ef          	jal	ra,80202b9a <pte_is_writable>
    8020358a:	87aa                	mv	a5,a0
    8020358c:	cb89                	beqz	a5,8020359e <memory_set_remap_test+0x114>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:145 (discriminator 3)
    8020358e:	09100593          	li	a1,145
    80203592:	00003517          	auipc	a0,0x3
    80203596:	c2e50513          	addi	a0,a0,-978 # 802061c0 <rodata_start+0x1c0>
    8020359a:	3eb000ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:148

    // 检查data区域是否可读写
    ASSERT(pte_is_readable(*p3) && pte_is_writable(*p3));
    8020359e:	fd843783          	ld	a5,-40(s0)
    802035a2:	6388                	ld	a0,0(a5)
    802035a4:	dc6ff0ef          	jal	ra,80202b6a <pte_is_readable>
    802035a8:	87aa                	mv	a5,a0
    802035aa:	cb81                	beqz	a5,802035ba <memory_set_remap_test+0x130>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:148 (discriminator 2)
    802035ac:	fd843783          	ld	a5,-40(s0)
    802035b0:	6388                	ld	a0,0(a5)
    802035b2:	de8ff0ef          	jal	ra,80202b9a <pte_is_writable>
    802035b6:	87aa                	mv	a5,a0
    802035b8:	eb89                	bnez	a5,802035ca <memory_set_remap_test+0x140>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:148 (discriminator 3)
    802035ba:	09400593          	li	a1,148
    802035be:	00003517          	auipc	a0,0x3
    802035c2:	c0250513          	addi	a0,a0,-1022 # 802061c0 <rodata_start+0x1c0>
    802035c6:	3bf000ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:149
}
    802035ca:	0001                	nop
    802035cc:	60e6                	ld	ra,88(sp)
    802035ce:	6446                	ld	s0,80(sp)
    802035d0:	6125                	addi	sp,sp,96
    802035d2:	8082                	ret

00000000802035d4 <memory_set_new_bare>:
memory_set_new_bare():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:152

void memory_set_new_bare(MemorySet *memory_set) 
{
    802035d4:	1101                	addi	sp,sp,-32
    802035d6:	ec06                	sd	ra,24(sp)
    802035d8:	e822                	sd	s0,16(sp)
    802035da:	1000                	addi	s0,sp,32
    802035dc:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:153
    memory_set->page_table = *PageTable_new();
    802035e0:	e72ff0ef          	jal	ra,80202c52 <PageTable_new>
    802035e4:	872a                	mv	a4,a0
    802035e6:	fe843783          	ld	a5,-24(s0)
    802035ea:	630c                	ld	a1,0(a4)
    802035ec:	6710                	ld	a2,8(a4)
    802035ee:	6b14                	ld	a3,16(a4)
    802035f0:	6f18                	ld	a4,24(a4)
    802035f2:	e38c                	sd	a1,0(a5)
    802035f4:	e790                	sd	a2,8(a5)
    802035f6:	eb94                	sd	a3,16(a5)
    802035f8:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:154
    vector_new(&memory_set->areas, sizeof(MapArea));
    802035fa:	fe843783          	ld	a5,-24(s0)
    802035fe:	02078793          	addi	a5,a5,32
    80203602:	45e1                	li	a1,24
    80203604:	853e                	mv	a0,a5
    80203606:	4db010ef          	jal	ra,802052e0 <vector_new>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:155
}
    8020360a:	0001                	nop
    8020360c:	60e2                	ld	ra,24(sp)
    8020360e:	6442                	ld	s0,16(sp)
    80203610:	6105                	addi	sp,sp,32
    80203612:	8082                	ret

0000000080203614 <ppn_get_bytes_array>:
ppn_get_bytes_array():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:160



uint8_t* ppn_get_bytes_array(PhysPageNum ppn) 
{
    80203614:	7179                	addi	sp,sp,-48
    80203616:	f406                	sd	ra,40(sp)
    80203618:	f022                	sd	s0,32(sp)
    8020361a:	1800                	addi	s0,sp,48
    8020361c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:161
  PhysAddr pa = phys_page_num_to_addr(ppn);
    80203620:	fd843503          	ld	a0,-40(s0)
    80203624:	7e2000ef          	jal	ra,80203e06 <phys_page_num_to_addr>
    80203628:	87aa                	mv	a5,a0
    8020362a:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:162
  return (uint8_t *)pa.addr;
    8020362e:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:163
}
    80203632:	853e                	mv	a0,a5
    80203634:	70a2                	ld	ra,40(sp)
    80203636:	7402                	ld	s0,32(sp)
    80203638:	6145                	addi	sp,sp,48
    8020363a:	8082                	ret

000000008020363c <map_area_copy_data>:
map_area_copy_data():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:169



static void map_area_copy_data(MapArea *map_area, PageTable *pt, uint8_t *data,
                               uint64_t len) 
{
    8020363c:	711d                	addi	sp,sp,-96
    8020363e:	ec86                	sd	ra,88(sp)
    80203640:	e8a2                	sd	s0,80(sp)
    80203642:	1080                	addi	s0,sp,96
    80203644:	faa43c23          	sd	a0,-72(s0)
    80203648:	fab43823          	sd	a1,-80(s0)
    8020364c:	fac43423          	sd	a2,-88(s0)
    80203650:	fad43023          	sd	a3,-96(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:170
  uint64_t start = 0;
    80203654:	fe043423          	sd	zero,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:171
  VirtPageNum current_vpn = map_area->vpn_range.start_vpn;
    80203658:	fb843783          	ld	a5,-72(s0)
    8020365c:	639c                	ld	a5,0(a5)
    8020365e:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:174
  for (;;) {
    PhysPageNum tmp;
    tmp.num = pte_ppn(*page_table_find_pte(pt, current_vpn));
    80203662:	fc843583          	ld	a1,-56(s0)
    80203666:	fb043503          	ld	a0,-80(s0)
    8020366a:	fccff0ef          	jal	ra,80202e36 <page_table_find_pte>
    8020366e:	87aa                	mv	a5,a0
    80203670:	6388                	ld	a0,0(a5)
    80203672:	c8eff0ef          	jal	ra,80202b00 <pte_ppn>
    80203676:	87aa                	mv	a5,a0
    80203678:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:175
    uint8_t *src = &data[start];
    8020367c:	fa843703          	ld	a4,-88(s0)
    80203680:	fe843783          	ld	a5,-24(s0)
    80203684:	97ba                	add	a5,a5,a4
    80203686:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:176
    uint8_t *dst = ppn_get_bytes_array(tmp);
    8020368a:	fc043503          	ld	a0,-64(s0)
    8020368e:	f87ff0ef          	jal	ra,80203614 <ppn_get_bytes_array>
    80203692:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:177
    uint64_t cpy_len = (len - start >= PAGE_SIZE) ? PAGE_SIZE : (len - start);
    80203696:	fa043703          	ld	a4,-96(s0)
    8020369a:	fe843783          	ld	a5,-24(s0)
    8020369e:	40f707b3          	sub	a5,a4,a5
    802036a2:	6705                	lui	a4,0x1
    802036a4:	00f77363          	bgeu	a4,a5,802036aa <map_area_copy_data+0x6e>
    802036a8:	6785                	lui	a5,0x1
    802036aa:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:178
    memcpy(dst, src, cpy_len);
    802036ae:	fd043783          	ld	a5,-48(s0)
    802036b2:	2781                	sext.w	a5,a5
    802036b4:	863e                	mv	a2,a5
    802036b6:	fe043583          	ld	a1,-32(s0)
    802036ba:	fd843503          	ld	a0,-40(s0)
    802036be:	82cff0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:179
    start += PAGE_SIZE;
    802036c2:	fe843703          	ld	a4,-24(s0)
    802036c6:	6785                	lui	a5,0x1
    802036c8:	97ba                	add	a5,a5,a4
    802036ca:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:180
    if (start >= len) {
    802036ce:	fe843703          	ld	a4,-24(s0)
    802036d2:	fa043783          	ld	a5,-96(s0)
    802036d6:	00f77863          	bgeu	a4,a5,802036e6 <map_area_copy_data+0xaa>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:183
      break;
    }
    current_vpn.num += 1;
    802036da:	fc843783          	ld	a5,-56(s0)
    802036de:	0785                	addi	a5,a5,1
    802036e0:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:172
  for (;;) {
    802036e4:	bfbd                	j	80203662 <map_area_copy_data+0x26>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:185
  }
}
    802036e6:	0001                	nop
    802036e8:	60e6                	ld	ra,88(sp)
    802036ea:	6446                	ld	s0,80(sp)
    802036ec:	6125                	addi	sp,sp,96
    802036ee:	8082                	ret

00000000802036f0 <memory_set_push_pro>:
memory_set_push_pro():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:190


void memory_set_push_pro(MemorySet *memory_set, MapArea *map_area,
                            uint8_t *data, uint64_t len)
{
    802036f0:	7179                	addi	sp,sp,-48
    802036f2:	f406                	sd	ra,40(sp)
    802036f4:	f022                	sd	s0,32(sp)
    802036f6:	1800                	addi	s0,sp,48
    802036f8:	fea43423          	sd	a0,-24(s0)
    802036fc:	feb43023          	sd	a1,-32(s0)
    80203700:	fcc43c23          	sd	a2,-40(s0)
    80203704:	fcd43823          	sd	a3,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:191
    map_area_map(map_area, &memory_set->page_table);
    80203708:	fe843783          	ld	a5,-24(s0)
    8020370c:	85be                	mv	a1,a5
    8020370e:	fe043503          	ld	a0,-32(s0)
    80203712:	98bff0ef          	jal	ra,8020309c <map_area_map>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:192
    if (data && len >= 0) 
    80203716:	fd843783          	ld	a5,-40(s0)
    8020371a:	cf81                	beqz	a5,80203732 <memory_set_push_pro+0x42>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:194
    {
        map_area_copy_data(map_area, &memory_set->page_table, data, len);
    8020371c:	fe843783          	ld	a5,-24(s0)
    80203720:	fd043683          	ld	a3,-48(s0)
    80203724:	fd843603          	ld	a2,-40(s0)
    80203728:	85be                	mv	a1,a5
    8020372a:	fe043503          	ld	a0,-32(s0)
    8020372e:	f0fff0ef          	jal	ra,8020363c <map_area_copy_data>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:196
    }
    vector_add(&memory_set->areas, map_area);
    80203732:	fe843783          	ld	a5,-24(s0)
    80203736:	02078793          	addi	a5,a5,32 # 1020 <n+0x1000>
    8020373a:	fe043583          	ld	a1,-32(s0)
    8020373e:	853e                	mv	a0,a5
    80203740:	203010ef          	jal	ra,80205142 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:197
}
    80203744:	0001                	nop
    80203746:	70a2                	ld	ra,40(sp)
    80203748:	7402                	ld	s0,32(sp)
    8020374a:	6145                	addi	sp,sp,48
    8020374c:	8082                	ret

000000008020374e <memory_set_from_elf>:
memory_set_from_elf():
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:202


void memory_set_from_elf(MemorySet *memory_set, uint8_t *elf_data,
                         size_t elf_size, uint64_t *user_sp,
                         uint64_t *entry_point) {
    8020374e:	716d                	addi	sp,sp,-272
    80203750:	e606                	sd	ra,264(sp)
    80203752:	e222                	sd	s0,256(sp)
    80203754:	fda6                	sd	s1,248(sp)
    80203756:	0a00                	addi	s0,sp,272
    80203758:	81010113          	addi	sp,sp,-2032 # 80219810 <boot_stack_lower_bound+0xf810>
    8020375c:	77fd                	lui	a5,0xfffff
    8020375e:	fe040493          	addi	s1,s0,-32
    80203762:	97a6                	add	a5,a5,s1
    80203764:	74a7b423          	sd	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203768:	77fd                	lui	a5,0xfffff
    8020376a:	fe040513          	addi	a0,s0,-32
    8020376e:	97aa                	add	a5,a5,a0
    80203770:	74b7b023          	sd	a1,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    80203774:	77fd                	lui	a5,0xfffff
    80203776:	fe040593          	addi	a1,s0,-32
    8020377a:	97ae                	add	a5,a5,a1
    8020377c:	72c7bc23          	sd	a2,1848(a5) # fffffffffffff738 <bss_end+0xffffffff7f594738>
    80203780:	77fd                	lui	a5,0xfffff
    80203782:	fe040613          	addi	a2,s0,-32
    80203786:	97b2                	add	a5,a5,a2
    80203788:	72d7b823          	sd	a3,1840(a5) # fffffffffffff730 <bss_end+0xffffffff7f594730>
    8020378c:	77fd                	lui	a5,0xfffff
    8020378e:	fe040693          	addi	a3,s0,-32
    80203792:	97b6                	add	a5,a5,a3
    80203794:	72e7b423          	sd	a4,1832(a5) # fffffffffffff728 <bss_end+0xffffffff7f594728>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:203
  memory_set_new_bare(memory_set);
    80203798:	77fd                	lui	a5,0xfffff
    8020379a:	fe040713          	addi	a4,s0,-32
    8020379e:	97ba                	add	a5,a5,a4
    802037a0:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    802037a4:	e31ff0ef          	jal	ra,802035d4 <memory_set_new_bare>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:206

  // map trampoline
  memory_set_map_trampoline(memory_set);
    802037a8:	77fd                	lui	a5,0xfffff
    802037aa:	fe040713          	addi	a4,s0,-32
    802037ae:	97ba                	add	a5,a5,a4
    802037b0:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    802037b4:	aa1ff0ef          	jal	ra,80203254 <memory_set_map_trampoline>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:210

  // map progam headers of elf, with U flag
  t_elf elf;
  int elf_load_ret = elf_load(elf_data, elf_size, &elf);
    802037b8:	77fd                	lui	a5,0xfffff
    802037ba:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802037be:	fe040713          	addi	a4,s0,-32
    802037c2:	00f706b3          	add	a3,a4,a5
    802037c6:	77fd                	lui	a5,0xfffff
    802037c8:	fe040713          	addi	a4,s0,-32
    802037cc:	973e                	add	a4,a4,a5
    802037ce:	77fd                	lui	a5,0xfffff
    802037d0:	fe040613          	addi	a2,s0,-32
    802037d4:	97b2                	add	a5,a5,a2
    802037d6:	8636                	mv	a2,a3
    802037d8:	73873583          	ld	a1,1848(a4) # 1738 <n+0x1718>
    802037dc:	7407b503          	ld	a0,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    802037e0:	ef0fe0ef          	jal	ra,80201ed0 <elf_load>
    802037e4:	87aa                	mv	a5,a0
    802037e6:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:211
  if (elf_load_ret != 0) {
    802037ea:	fd442783          	lw	a5,-44(s0)
    802037ee:	2781                	sext.w	a5,a5
    802037f0:	cf99                	beqz	a5,8020380e <memory_set_from_elf+0xc0>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:212
    printk("Elf load error.\n");
    802037f2:	00003517          	auipc	a0,0x3
    802037f6:	9f650513          	addi	a0,a0,-1546 # 802061e8 <rodata_start+0x1e8>
    802037fa:	ff1fd0ef          	jal	ra,802017ea <printk>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:213
    ASSERT(0);
    802037fe:	0d500593          	li	a1,213
    80203802:	00003517          	auipc	a0,0x3
    80203806:	9be50513          	addi	a0,a0,-1602 # 802061c0 <rodata_start+0x1c0>
    8020380a:	17b000ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:216
  }

  size_t ph_count = elf_header_get_phnum(&elf);
    8020380e:	77fd                	lui	a5,0xfffff
    80203810:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203814:	fe040713          	addi	a4,s0,-32
    80203818:	97ba                	add	a5,a5,a4
    8020381a:	853e                	mv	a0,a5
    8020381c:	885fe0ef          	jal	ra,802020a0 <elf_header_get_phnum>
    80203820:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:222
  VirtAddr start_va, end_va;
  MapPermission map_perm;
  uint64_t ph_flags;
  MapArea map_area;
  VirtPageNum max_end_vpn;
  max_end_vpn.num=0;
    80203824:	77fd                	lui	a5,0xfffff
    80203826:	fe040713          	addi	a4,s0,-32
    8020382a:	97ba                	add	a5,a5,a4
    8020382c:	7607bc23          	sd	zero,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:223
  for (size_t i = 0; i < ph_count; i++) {
    80203830:	fc043c23          	sd	zero,-40(s0)
    80203834:	a2fd                	j	80203a22 <memory_set_from_elf+0x2d4>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:224
    t_elf_program *ph = &elf.programs[i];
    80203836:	77fd                	lui	a5,0xfffff
    80203838:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    8020383c:	fe040713          	addi	a4,s0,-32
    80203840:	973e                	add	a4,a4,a5
    80203842:	fd843783          	ld	a5,-40(s0)
    80203846:	04278793          	addi	a5,a5,66
    8020384a:	0792                	slli	a5,a5,0x4
    8020384c:	97ba                	add	a5,a5,a4
    8020384e:	07a1                	addi	a5,a5,8
    80203850:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:225
    if (elf_program_get_type(&elf, ph) == PT_LOAD) {
    80203854:	77fd                	lui	a5,0xfffff
    80203856:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    8020385a:	fe040713          	addi	a4,s0,-32
    8020385e:	97ba                	add	a5,a5,a4
    80203860:	fc043583          	ld	a1,-64(s0)
    80203864:	853e                	mv	a0,a5
    80203866:	bbcfe0ef          	jal	ra,80201c22 <elf_program_get_type>
    8020386a:	87aa                	mv	a5,a0
    8020386c:	2781                	sext.w	a5,a5
    8020386e:	873e                	mv	a4,a5
    80203870:	4785                	li	a5,1
    80203872:	1af71363          	bne	a4,a5,80203a18 <memory_set_from_elf+0x2ca>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:226
      start_va.addr = elf_program_get_vaddr(&elf, ph);
    80203876:	77fd                	lui	a5,0xfffff
    80203878:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    8020387c:	fe040713          	addi	a4,s0,-32
    80203880:	97ba                	add	a5,a5,a4
    80203882:	fc043583          	ld	a1,-64(s0)
    80203886:	853e                	mv	a0,a5
    80203888:	c72fe0ef          	jal	ra,80201cfa <elf_program_get_vaddr>
    8020388c:	872a                	mv	a4,a0
    8020388e:	77fd                	lui	a5,0xfffff
    80203890:	fe040693          	addi	a3,s0,-32
    80203894:	97b6                	add	a5,a5,a3
    80203896:	7ae7b023          	sd	a4,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:227
      end_va.addr = (start_va.addr + (uint64_t)elf_program_get_memsz(&elf, ph));
    8020389a:	77fd                	lui	a5,0xfffff
    8020389c:	fe040713          	addi	a4,s0,-32
    802038a0:	97ba                	add	a5,a5,a4
    802038a2:	7a07b483          	ld	s1,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    802038a6:	77fd                	lui	a5,0xfffff
    802038a8:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802038ac:	fe040713          	addi	a4,s0,-32
    802038b0:	97ba                	add	a5,a5,a4
    802038b2:	fc043583          	ld	a1,-64(s0)
    802038b6:	853e                	mv	a0,a5
    802038b8:	c8afe0ef          	jal	ra,80201d42 <elf_program_get_memsz>
    802038bc:	87aa                	mv	a5,a0
    802038be:	00f48733          	add	a4,s1,a5
    802038c2:	77fd                	lui	a5,0xfffff
    802038c4:	fe040693          	addi	a3,s0,-32
    802038c8:	97b6                	add	a5,a5,a3
    802038ca:	78e7bc23          	sd	a4,1944(a5) # fffffffffffff798 <bss_end+0xffffffff7f594798>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:228
      map_perm = MAP_PERM_U;
    802038ce:	47c1                	li	a5,16
    802038d0:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:229
      ph_flags = elf_program_get_flags(&elf, ph);
    802038d4:	77fd                	lui	a5,0xfffff
    802038d6:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802038da:	fe040713          	addi	a4,s0,-32
    802038de:	97ba                	add	a5,a5,a4
    802038e0:	fc043583          	ld	a1,-64(s0)
    802038e4:	853e                	mv	a0,a5
    802038e6:	bc8fe0ef          	jal	ra,80201cae <elf_program_get_flags>
    802038ea:	faa43823          	sd	a0,-80(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:231
      if (ph_flags | PF_R) {
        map_perm |= MAP_PERM_R;
    802038ee:	fbc42783          	lw	a5,-68(s0)
    802038f2:	0027e793          	ori	a5,a5,2
    802038f6:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:234
      }
      if (ph_flags | PF_W) {
        map_perm |= MAP_PERM_W;
    802038fa:	fbc42783          	lw	a5,-68(s0)
    802038fe:	0047e793          	ori	a5,a5,4
    80203902:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:237
      }
      if (ph_flags | PF_X) {
        map_perm |= MAP_PERM_X;
    80203906:	fbc42783          	lw	a5,-68(s0)
    8020390a:	0087e793          	ori	a5,a5,8
    8020390e:	faf42e23          	sw	a5,-68(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:239
      }
      map_area.vpn_range.start_vpn = virt_addr_to_page_num(start_va,0);
    80203912:	77fd                	lui	a5,0xfffff
    80203914:	fe040713          	addi	a4,s0,-32
    80203918:	00f704b3          	add	s1,a4,a5
    8020391c:	77fd                	lui	a5,0xfffff
    8020391e:	fe040713          	addi	a4,s0,-32
    80203922:	97ba                	add	a5,a5,a4
    80203924:	4581                	li	a1,0
    80203926:	7a07b503          	ld	a0,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    8020392a:	484000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    8020392e:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:240
      map_area.vpn_range.size = virt_addr_to_page_num(start_va,0).num-virt_addr_to_page_num(end_va,1).num+1;
    80203932:	77fd                	lui	a5,0xfffff
    80203934:	fe040713          	addi	a4,s0,-32
    80203938:	97ba                	add	a5,a5,a4
    8020393a:	4581                	li	a1,0
    8020393c:	7a07b503          	ld	a0,1952(a5) # fffffffffffff7a0 <bss_end+0xffffffff7f5947a0>
    80203940:	46e000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203944:	87aa                	mv	a5,a0
    80203946:	84be                	mv	s1,a5
    80203948:	77fd                	lui	a5,0xfffff
    8020394a:	fe040713          	addi	a4,s0,-32
    8020394e:	97ba                	add	a5,a5,a4
    80203950:	4585                	li	a1,1
    80203952:	7987b503          	ld	a0,1944(a5) # fffffffffffff798 <bss_end+0xffffffff7f594798>
    80203956:	458000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    8020395a:	87aa                	mv	a5,a0
    8020395c:	40f487b3          	sub	a5,s1,a5
    80203960:	00178713          	addi	a4,a5,1
    80203964:	77fd                	lui	a5,0xfffff
    80203966:	fe040693          	addi	a3,s0,-32
    8020396a:	97b6                	add	a5,a5,a3
    8020396c:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:241
      map_area.map_type = MAP_FRAMED;
    80203970:	77fd                	lui	a5,0xfffff
    80203972:	fe040713          	addi	a4,s0,-32
    80203976:	97ba                	add	a5,a5,a4
    80203978:	4705                	li	a4,1
    8020397a:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:242
      map_area.map_premission = map_perm;
    8020397e:	77fd                	lui	a5,0xfffff
    80203980:	fe040713          	addi	a4,s0,-32
    80203984:	97ba                	add	a5,a5,a4
    80203986:	fbc42703          	lw	a4,-68(s0)
    8020398a:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:243
      max_end_vpn.num = map_area.vpn_range.start_vpn.num + map_area.vpn_range.size-1;
    8020398e:	77fd                	lui	a5,0xfffff
    80203990:	fe040713          	addi	a4,s0,-32
    80203994:	97ba                	add	a5,a5,a4
    80203996:	7807b703          	ld	a4,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    8020399a:	77fd                	lui	a5,0xfffff
    8020399c:	fe040693          	addi	a3,s0,-32
    802039a0:	97b6                	add	a5,a5,a3
    802039a2:	7887b783          	ld	a5,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
    802039a6:	97ba                	add	a5,a5,a4
    802039a8:	fff78713          	addi	a4,a5,-1
    802039ac:	77fd                	lui	a5,0xfffff
    802039ae:	fe040693          	addi	a3,s0,-32
    802039b2:	97b6                	add	a5,a5,a3
    802039b4:	76e7bc23          	sd	a4,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:245
      memory_set_push_pro(memory_set, &map_area,
                      elf_data + elf_program_get_offset(&elf, ph),
    802039b8:	77fd                	lui	a5,0xfffff
    802039ba:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802039be:	fe040713          	addi	a4,s0,-32
    802039c2:	97ba                	add	a5,a5,a4
    802039c4:	fc043583          	ld	a1,-64(s0)
    802039c8:	853e                	mv	a0,a5
    802039ca:	a9cfe0ef          	jal	ra,80201c66 <elf_program_get_offset>
    802039ce:	872a                	mv	a4,a0
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:244
      memory_set_push_pro(memory_set, &map_area,
    802039d0:	77fd                	lui	a5,0xfffff
    802039d2:	fe040693          	addi	a3,s0,-32
    802039d6:	97b6                	add	a5,a5,a3
    802039d8:	7407b783          	ld	a5,1856(a5) # fffffffffffff740 <bss_end+0xffffffff7f594740>
    802039dc:	00e784b3          	add	s1,a5,a4
    802039e0:	77fd                	lui	a5,0xfffff
    802039e2:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    802039e6:	fe040713          	addi	a4,s0,-32
    802039ea:	97ba                	add	a5,a5,a4
    802039ec:	fc043583          	ld	a1,-64(s0)
    802039f0:	853e                	mv	a0,a5
    802039f2:	b98fe0ef          	jal	ra,80201d8a <elf_program_get_filesz>
    802039f6:	86aa                	mv	a3,a0
    802039f8:	77fd                	lui	a5,0xfffff
    802039fa:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    802039fe:	fe040713          	addi	a4,s0,-32
    80203a02:	973e                	add	a4,a4,a5
    80203a04:	77fd                	lui	a5,0xfffff
    80203a06:	fe040613          	addi	a2,s0,-32
    80203a0a:	97b2                	add	a5,a5,a2
    80203a0c:	8626                	mv	a2,s1
    80203a0e:	85ba                	mv	a1,a4
    80203a10:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203a14:	cddff0ef          	jal	ra,802036f0 <memory_set_push_pro>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:223 (discriminator 2)
  for (size_t i = 0; i < ph_count; i++) {
    80203a18:	fd843783          	ld	a5,-40(s0)
    80203a1c:	0785                	addi	a5,a5,1
    80203a1e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:223 (discriminator 1)
    80203a22:	fd843703          	ld	a4,-40(s0)
    80203a26:	fc843783          	ld	a5,-56(s0)
    80203a2a:	e0f766e3          	bltu	a4,a5,80203836 <memory_set_from_elf+0xe8>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:251
                      elf_program_get_filesz(&elf, ph));
    }
  }

  // map user stack with U flags
  VirtAddr max_end_va = virt_page_num_to_addr(max_end_vpn);
    80203a2e:	77fd                	lui	a5,0xfffff
    80203a30:	fe040713          	addi	a4,s0,-32
    80203a34:	97ba                	add	a5,a5,a4
    80203a36:	7787b503          	ld	a0,1912(a5) # fffffffffffff778 <bss_end+0xffffffff7f594778>
    80203a3a:	3b4000ef          	jal	ra,80203dee <virt_page_num_to_addr>
    80203a3e:	872a                	mv	a4,a0
    80203a40:	77fd                	lui	a5,0xfffff
    80203a42:	fe040693          	addi	a3,s0,-32
    80203a46:	97b6                	add	a5,a5,a3
    80203a48:	76e7b823          	sd	a4,1904(a5) # fffffffffffff770 <bss_end+0xffffffff7f594770>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:252
  VirtAddr user_stack_bottom = max_end_va;
    80203a4c:	77fd                	lui	a5,0xfffff
    80203a4e:	fe040713          	addi	a4,s0,-32
    80203a52:	97ba                	add	a5,a5,a4
    80203a54:	777d                	lui	a4,0xfffff
    80203a56:	fe040693          	addi	a3,s0,-32
    80203a5a:	9736                	add	a4,a4,a3
    80203a5c:	77073703          	ld	a4,1904(a4) # fffffffffffff770 <bss_end+0xffffffff7f594770>
    80203a60:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:254
  // guard page
  user_stack_bottom.addr += PAGE_SIZE;
    80203a64:	77fd                	lui	a5,0xfffff
    80203a66:	fe040713          	addi	a4,s0,-32
    80203a6a:	97ba                	add	a5,a5,a4
    80203a6c:	7687b703          	ld	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203a70:	6785                	lui	a5,0x1
    80203a72:	973e                	add	a4,a4,a5
    80203a74:	77fd                	lui	a5,0xfffff
    80203a76:	fe040693          	addi	a3,s0,-32
    80203a7a:	97b6                	add	a5,a5,a3
    80203a7c:	76e7b423          	sd	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:256
  VirtAddr user_stack_top;
  user_stack_top.addr = user_stack_bottom.addr + USER_STACK_SIZE;
    80203a80:	77fd                	lui	a5,0xfffff
    80203a82:	fe040713          	addi	a4,s0,-32
    80203a86:	97ba                	add	a5,a5,a4
    80203a88:	7687b703          	ld	a4,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203a8c:	6789                	lui	a5,0x2
    80203a8e:	973e                	add	a4,a4,a5
    80203a90:	77fd                	lui	a5,0xfffff
    80203a92:	fe040693          	addi	a3,s0,-32
    80203a96:	97b6                	add	a5,a5,a3
    80203a98:	76e7b023          	sd	a4,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:257
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(user_stack_bottom,0);
    80203a9c:	77fd                	lui	a5,0xfffff
    80203a9e:	fe040713          	addi	a4,s0,-32
    80203aa2:	00f704b3          	add	s1,a4,a5
    80203aa6:	77fd                	lui	a5,0xfffff
    80203aa8:	fe040713          	addi	a4,s0,-32
    80203aac:	97ba                	add	a5,a5,a4
    80203aae:	4581                	li	a1,0
    80203ab0:	7687b503          	ld	a0,1896(a5) # fffffffffffff768 <bss_end+0xffffffff7f594768>
    80203ab4:	2fa000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203ab8:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:258
  map_area.vpn_range.size = virt_addr_to_page_num(user_stack_top,1).num - map_area.vpn_range.start_vpn.num+1;
    80203abc:	77fd                	lui	a5,0xfffff
    80203abe:	fe040713          	addi	a4,s0,-32
    80203ac2:	97ba                	add	a5,a5,a4
    80203ac4:	4585                	li	a1,1
    80203ac6:	7607b503          	ld	a0,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
    80203aca:	2e4000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203ace:	87aa                	mv	a5,a0
    80203ad0:	873e                	mv	a4,a5
    80203ad2:	77fd                	lui	a5,0xfffff
    80203ad4:	fe040693          	addi	a3,s0,-32
    80203ad8:	97b6                	add	a5,a5,a3
    80203ada:	7807b783          	ld	a5,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203ade:	40f707b3          	sub	a5,a4,a5
    80203ae2:	00178713          	addi	a4,a5,1
    80203ae6:	77fd                	lui	a5,0xfffff
    80203ae8:	fe040693          	addi	a3,s0,-32
    80203aec:	97b6                	add	a5,a5,a3
    80203aee:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:259
  map_area.map_type = MAP_FRAMED;
    80203af2:	77fd                	lui	a5,0xfffff
    80203af4:	fe040713          	addi	a4,s0,-32
    80203af8:	97ba                	add	a5,a5,a4
    80203afa:	4705                	li	a4,1
    80203afc:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:260
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W | MAP_PERM_U;
    80203b00:	77fd                	lui	a5,0xfffff
    80203b02:	fe040713          	addi	a4,s0,-32
    80203b06:	97ba                	add	a5,a5,a4
    80203b08:	4759                	li	a4,22
    80203b0a:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:261
  memory_set_push(memory_set, &map_area);
    80203b0e:	77fd                	lui	a5,0xfffff
    80203b10:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203b14:	fe040713          	addi	a4,s0,-32
    80203b18:	973e                	add	a4,a4,a5
    80203b1a:	77fd                	lui	a5,0xfffff
    80203b1c:	fe040693          	addi	a3,s0,-32
    80203b20:	97b6                	add	a5,a5,a3
    80203b22:	85ba                	mv	a1,a4
    80203b24:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203b28:	e54ff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:263
    VirtAddr t2;
    t2.addr = TRAP_CONTEXT;
    80203b2c:	77fd                	lui	a5,0xfffff
    80203b2e:	fe040713          	addi	a4,s0,-32
    80203b32:	97ba                	add	a5,a5,a4
    80203b34:	7779                	lui	a4,0xffffe
    80203b36:	74e7bc23          	sd	a4,1880(a5) # fffffffffffff758 <bss_end+0xffffffff7f594758>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:265
  // map TrapContext
  map_area.vpn_range.start_vpn = virt_addr_to_page_num(t2,0);
    80203b3a:	77fd                	lui	a5,0xfffff
    80203b3c:	fe040713          	addi	a4,s0,-32
    80203b40:	00f704b3          	add	s1,a4,a5
    80203b44:	77fd                	lui	a5,0xfffff
    80203b46:	fe040713          	addi	a4,s0,-32
    80203b4a:	97ba                	add	a5,a5,a4
    80203b4c:	4581                	li	a1,0
    80203b4e:	7587b503          	ld	a0,1880(a5) # fffffffffffff758 <bss_end+0xffffffff7f594758>
    80203b52:	25c000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203b56:	78a4b023          	sd	a0,1920(s1)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:267
  VirtAddr t1;
  t1.addr = TRAMPOLINE;
    80203b5a:	77fd                	lui	a5,0xfffff
    80203b5c:	fe040713          	addi	a4,s0,-32
    80203b60:	97ba                	add	a5,a5,a4
    80203b62:	777d                	lui	a4,0xfffff
    80203b64:	74e7b823          	sd	a4,1872(a5) # fffffffffffff750 <bss_end+0xffffffff7f594750>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:268
  map_area.vpn_range.size = virt_addr_to_page_num(t1,1).num - map_area.vpn_range.start_vpn.num + 1;
    80203b68:	77fd                	lui	a5,0xfffff
    80203b6a:	fe040713          	addi	a4,s0,-32
    80203b6e:	97ba                	add	a5,a5,a4
    80203b70:	4585                	li	a1,1
    80203b72:	7507b503          	ld	a0,1872(a5) # fffffffffffff750 <bss_end+0xffffffff7f594750>
    80203b76:	238000ef          	jal	ra,80203dae <virt_addr_to_page_num>
    80203b7a:	87aa                	mv	a5,a0
    80203b7c:	873e                	mv	a4,a5
    80203b7e:	77fd                	lui	a5,0xfffff
    80203b80:	fe040693          	addi	a3,s0,-32
    80203b84:	97b6                	add	a5,a5,a3
    80203b86:	7807b783          	ld	a5,1920(a5) # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203b8a:	40f707b3          	sub	a5,a4,a5
    80203b8e:	00178713          	addi	a4,a5,1
    80203b92:	77fd                	lui	a5,0xfffff
    80203b94:	fe040693          	addi	a3,s0,-32
    80203b98:	97b6                	add	a5,a5,a3
    80203b9a:	78e7b423          	sd	a4,1928(a5) # fffffffffffff788 <bss_end+0xffffffff7f594788>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:269
  map_area.map_type = MAP_FRAMED;
    80203b9e:	77fd                	lui	a5,0xfffff
    80203ba0:	fe040713          	addi	a4,s0,-32
    80203ba4:	97ba                	add	a5,a5,a4
    80203ba6:	4705                	li	a4,1
    80203ba8:	78e7a823          	sw	a4,1936(a5) # fffffffffffff790 <bss_end+0xffffffff7f594790>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:270
  map_area.map_premission = MAP_PERM_R | MAP_PERM_W;
    80203bac:	77fd                	lui	a5,0xfffff
    80203bae:	fe040713          	addi	a4,s0,-32
    80203bb2:	97ba                	add	a5,a5,a4
    80203bb4:	4719                	li	a4,6
    80203bb6:	78e7aa23          	sw	a4,1940(a5) # fffffffffffff794 <bss_end+0xffffffff7f594794>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:271
  memory_set_push(memory_set, &map_area);
    80203bba:	77fd                	lui	a5,0xfffff
    80203bbc:	78078793          	addi	a5,a5,1920 # fffffffffffff780 <bss_end+0xffffffff7f594780>
    80203bc0:	fe040713          	addi	a4,s0,-32
    80203bc4:	973e                	add	a4,a4,a5
    80203bc6:	77fd                	lui	a5,0xfffff
    80203bc8:	fe040693          	addi	a3,s0,-32
    80203bcc:	97b6                	add	a5,a5,a3
    80203bce:	85ba                	mv	a1,a4
    80203bd0:	7487b503          	ld	a0,1864(a5) # fffffffffffff748 <bss_end+0xffffffff7f594748>
    80203bd4:	da8ff0ef          	jal	ra,8020317c <memory_set_push>
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:274

  // return
  *user_sp = (uint64_t)user_stack_top.addr;
    80203bd8:	77fd                	lui	a5,0xfffff
    80203bda:	fe040713          	addi	a4,s0,-32
    80203bde:	97ba                	add	a5,a5,a4
    80203be0:	7607b703          	ld	a4,1888(a5) # fffffffffffff760 <bss_end+0xffffffff7f594760>
    80203be4:	77fd                	lui	a5,0xfffff
    80203be6:	fe040693          	addi	a3,s0,-32
    80203bea:	97b6                	add	a5,a5,a3
    80203bec:	7307b783          	ld	a5,1840(a5) # fffffffffffff730 <bss_end+0xffffffff7f594730>
    80203bf0:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:275
  *entry_point = elf_header_get_entry(&elf);
    80203bf2:	77fd                	lui	a5,0xfffff
    80203bf4:	7a878793          	addi	a5,a5,1960 # fffffffffffff7a8 <bss_end+0xffffffff7f5947a8>
    80203bf8:	fe040713          	addi	a4,s0,-32
    80203bfc:	97ba                	add	a5,a5,a4
    80203bfe:	853e                	mv	a0,a5
    80203c00:	f13fd0ef          	jal	ra,80201b12 <elf_header_get_entry>
    80203c04:	872a                	mv	a4,a0
    80203c06:	77fd                	lui	a5,0xfffff
    80203c08:	fe040693          	addi	a3,s0,-32
    80203c0c:	97b6                	add	a5,a5,a3
    80203c0e:	7287b783          	ld	a5,1832(a5) # fffffffffffff728 <bss_end+0xffffffff7f594728>
    80203c12:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/task_memory/task_memory.c:276
}
    80203c14:	0001                	nop
    80203c16:	7f010113          	addi	sp,sp,2032
    80203c1a:	60b2                	ld	ra,264(sp)
    80203c1c:	6412                	ld	s0,256(sp)
    80203c1e:	74ee                	ld	s1,248(sp)
    80203c20:	6151                	addi	sp,sp,272
    80203c22:	8082                	ret

0000000080203c24 <frame_allocator_init>:
frame_allocator_init():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:13
// @param allocator 分配器的指针
// @param start 可用物理页帧的起始页号
// @param end 可用物理页帧的结束页号（不包括此页号）
extern uint8_t ekernel;
void frame_allocator_init() 
{
    80203c24:	1101                	addi	sp,sp,-32
    80203c26:	ec06                	sd	ra,24(sp)
    80203c28:	e822                	sd	s0,16(sp)
    80203c2a:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:15
  PhysAddr start_addr;
  start_addr.addr = &ekernel; // Manually constructing PhysAddr
    80203c2c:	00867797          	auipc	a5,0x867
    80203c30:	3d478793          	addi	a5,a5,980 # 80a6b000 <bss_end>
    80203c34:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:17
  PhysAddr end_addr;                 // Manually constructing PhysAddr
  end_addr.addr = (size_t)MEMORY_END;
    80203c38:	47c5                	li	a5,17
    80203c3a:	07ee                	slli	a5,a5,0x1b
    80203c3c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:18
  fram_allocator.current = phys_addr_to_page_num(start_addr,0).num;
    80203c40:	4581                	li	a1,0
    80203c42:	fe843503          	ld	a0,-24(s0)
    80203c46:	128000ef          	jal	ra,80203d6e <phys_addr_to_page_num>
    80203c4a:	87aa                	mv	a5,a0
    80203c4c:	873e                	mv	a4,a5
    80203c4e:	00816797          	auipc	a5,0x816
    80203c52:	3f278793          	addi	a5,a5,1010 # 80a1a040 <fram_allocator>
    80203c56:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:19
  fram_allocator.end = phys_addr_to_page_num(end_addr,1).num;
    80203c58:	4585                	li	a1,1
    80203c5a:	fe043503          	ld	a0,-32(s0)
    80203c5e:	110000ef          	jal	ra,80203d6e <phys_addr_to_page_num>
    80203c62:	87aa                	mv	a5,a0
    80203c64:	873e                	mv	a4,a5
    80203c66:	00816797          	auipc	a5,0x816
    80203c6a:	3da78793          	addi	a5,a5,986 # 80a1a040 <fram_allocator>
    80203c6e:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:20
  vector_init(&fram_allocator.recycled);
    80203c70:	00816517          	auipc	a0,0x816
    80203c74:	3e050513          	addi	a0,a0,992 # 80a1a050 <fram_allocator+0x10>
    80203c78:	42a010ef          	jal	ra,802050a2 <vector_init>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:21
}
    80203c7c:	0001                	nop
    80203c7e:	60e2                	ld	ra,24(sp)
    80203c80:	6442                	ld	s0,16(sp)
    80203c82:	6105                	addi	sp,sp,32
    80203c84:	8082                	ret

0000000080203c86 <StackFrameAllocator_alloc>:
StackFrameAllocator_alloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:27

// 分配一个物理页帧
// @param allocator 分配器的指针
// @return 分配的物理页号，如果内存耗尽则返回特殊值(size_t)-1
PhysPageNum StackFrameAllocator_alloc(StackFrameAllocator* allocator) 
{
    80203c86:	7139                	addi	sp,sp,-64
    80203c88:	fc06                	sd	ra,56(sp)
    80203c8a:	f822                	sd	s0,48(sp)
    80203c8c:	0080                	addi	s0,sp,64
    80203c8e:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:28
    if (vector_total(&allocator->recycled) > 0) {
    80203c92:	fc843783          	ld	a5,-56(s0)
    80203c96:	07c1                	addi	a5,a5,16
    80203c98:	853e                	mv	a0,a5
    80203c9a:	444010ef          	jal	ra,802050de <vector_total>
    80203c9e:	87aa                	mv	a5,a0
    80203ca0:	c7a1                	beqz	a5,80203ce8 <StackFrameAllocator_alloc+0x62>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:30
        // 如果回收向量中有页号，优先从回收向量中分配
        size_t index = vector_total(&allocator->recycled) - 1; // 获取最后一个元素的索引
    80203ca2:	fc843783          	ld	a5,-56(s0)
    80203ca6:	07c1                	addi	a5,a5,16
    80203ca8:	853e                	mv	a0,a5
    80203caa:	434010ef          	jal	ra,802050de <vector_total>
    80203cae:	87aa                	mv	a5,a0
    80203cb0:	17fd                	addi	a5,a5,-1
    80203cb2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:31
        void* item = vector_get(&allocator->recycled, index); // 获取并移除最后一个元素
    80203cb6:	fc843783          	ld	a5,-56(s0)
    80203cba:	07c1                	addi	a5,a5,16
    80203cbc:	fe843583          	ld	a1,-24(s0)
    80203cc0:	853e                	mv	a0,a5
    80203cc2:	4dc010ef          	jal	ra,8020519e <vector_get>
    80203cc6:	fea43023          	sd	a0,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:32
        PhysPageNum ppn = { (size_t)item }; // 将void*转换回物理页号
    80203cca:	fe043783          	ld	a5,-32(s0)
    80203cce:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:33
        vector_delete(&allocator->recycled, index); // 从向量中删除该元素
    80203cd2:	fc843783          	ld	a5,-56(s0)
    80203cd6:	07c1                	addi	a5,a5,16
    80203cd8:	fe843583          	ld	a1,-24(s0)
    80203cdc:	853e                	mv	a0,a5
    80203cde:	4f8010ef          	jal	ra,802051d6 <vector_delete>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:34
        return ppn;
    80203ce2:	fd843783          	ld	a5,-40(s0)
    80203ce6:	a805                	j	80203d16 <StackFrameAllocator_alloc+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:35
    } else if (allocator->current < allocator->end) {
    80203ce8:	fc843783          	ld	a5,-56(s0)
    80203cec:	6398                	ld	a4,0(a5)
    80203cee:	fc843783          	ld	a5,-56(s0)
    80203cf2:	679c                	ld	a5,8(a5)
    80203cf4:	00f77f63          	bgeu	a4,a5,80203d12 <StackFrameAllocator_alloc+0x8c>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:37
        // 如果回收向量为空，且当前还有未分配的页，则从当前可用的页号中分配
        PhysPageNum ppn = { allocator->current++ }; // 分配当前页号，并将current指向下一个页号
    80203cf8:	fc843783          	ld	a5,-56(s0)
    80203cfc:	639c                	ld	a5,0(a5)
    80203cfe:	00178693          	addi	a3,a5,1
    80203d02:	fc843703          	ld	a4,-56(s0)
    80203d06:	e314                	sd	a3,0(a4)
    80203d08:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:38
        return ppn;
    80203d0c:	fd043783          	ld	a5,-48(s0)
    80203d10:	a019                	j	80203d16 <StackFrameAllocator_alloc+0x90>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:41
    } else {
        // 如果没有可分配的页号，则返回一个特殊值表示内存耗尽
        return (PhysPageNum){ 0x80000000 };
    80203d12:	4785                	li	a5,1
    80203d14:	07fe                	slli	a5,a5,0x1f
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:43 (discriminator 1)
    }
}
    80203d16:	853e                	mv	a0,a5
    80203d18:	70e2                	ld	ra,56(sp)
    80203d1a:	7442                	ld	s0,48(sp)
    80203d1c:	6121                	addi	sp,sp,64
    80203d1e:	8082                	ret

0000000080203d20 <StackFrameAllocator_dealloc>:
StackFrameAllocator_dealloc():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:48

// 回收一个物理页帧
// @param allocator 分配器的指针
// @param ppn 要回收的物理页号
void StackFrameAllocator_dealloc(StackFrameAllocator* allocator, PhysPageNum ppn) {
    80203d20:	1101                	addi	sp,sp,-32
    80203d22:	ec06                	sd	ra,24(sp)
    80203d24:	e822                	sd	s0,16(sp)
    80203d26:	1000                	addi	s0,sp,32
    80203d28:	fea43423          	sd	a0,-24(s0)
    80203d2c:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:50
    // 将回收的物理页号添加到回收向量中，将物理页号转换为void*进行存储
    vector_add(&allocator->recycled, (void*)(uintptr_t)ppn.num);
    80203d30:	fe843783          	ld	a5,-24(s0)
    80203d34:	07c1                	addi	a5,a5,16
    80203d36:	fe043703          	ld	a4,-32(s0)
    80203d3a:	85ba                	mv	a1,a4
    80203d3c:	853e                	mv	a0,a5
    80203d3e:	404010ef          	jal	ra,80205142 <vector_add>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:51
}
    80203d42:	0001                	nop
    80203d44:	60e2                	ld	ra,24(sp)
    80203d46:	6442                	ld	s0,16(sp)
    80203d48:	6105                	addi	sp,sp,32
    80203d4a:	8082                	ret

0000000080203d4c <StackFrameAllocator_free>:
StackFrameAllocator_free():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:55

// 释放栈式物理页帧分配器使用的资源
// @param allocator 分配器的指针
void StackFrameAllocator_free(StackFrameAllocator* allocator) {
    80203d4c:	1101                	addi	sp,sp,-32
    80203d4e:	ec06                	sd	ra,24(sp)
    80203d50:	e822                	sd	s0,16(sp)
    80203d52:	1000                	addi	s0,sp,32
    80203d54:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:57
    // 释放存储回收页号的向量占用的内存
    vector_free(&allocator->recycled);
    80203d58:	fe843783          	ld	a5,-24(s0)
    80203d5c:	07c1                	addi	a5,a5,16
    80203d5e:	853e                	mv	a0,a5
    80203d60:	546010ef          	jal	ra,802052a6 <vector_free>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/fram_allocator/fram_allocator.c:58
}
    80203d64:	0001                	nop
    80203d66:	60e2                	ld	ra,24(sp)
    80203d68:	6442                	ld	s0,16(sp)
    80203d6a:	6105                	addi	sp,sp,32
    80203d6c:	8082                	ret

0000000080203d6e <phys_addr_to_page_num>:
phys_addr_to_page_num():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:4
#include "address.h"

// 将物理地址转换为物理页号
PhysPageNum phys_addr_to_page_num(PhysAddr addr, AlignDirection direction) {
    80203d6e:	7179                	addi	sp,sp,-48
    80203d70:	f422                	sd	s0,40(sp)
    80203d72:	1800                	addi	s0,sp,48
    80203d74:	fca43c23          	sd	a0,-40(s0)
    80203d78:	87ae                	mv	a5,a1
    80203d7a:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:6
    size_t num;
    if (direction == ALIGN_DOWN) {
    80203d7e:	fd442783          	lw	a5,-44(s0)
    80203d82:	2781                	sext.w	a5,a5
    80203d84:	e799                	bnez	a5,80203d92 <phys_addr_to_page_num+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:8
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    80203d86:	fd843783          	ld	a5,-40(s0)
    80203d8a:	83b1                	srli	a5,a5,0xc
    80203d8c:	fef43423          	sd	a5,-24(s0)
    80203d90:	a809                	j	80203da2 <phys_addr_to_page_num+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:11
    } else {
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    80203d92:	fd843703          	ld	a4,-40(s0)
    80203d96:	6785                	lui	a5,0x1
    80203d98:	17fd                	addi	a5,a5,-1
    80203d9a:	97ba                	add	a5,a5,a4
    80203d9c:	83b1                	srli	a5,a5,0xc
    80203d9e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:13
    }
    return (PhysPageNum){.num = num};
    80203da2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:14
}
    80203da6:	853e                	mv	a0,a5
    80203da8:	7422                	ld	s0,40(sp)
    80203daa:	6145                	addi	sp,sp,48
    80203dac:	8082                	ret

0000000080203dae <virt_addr_to_page_num>:
virt_addr_to_page_num():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:17

// 将虚拟地址转换为虚拟页号
VirtPageNum virt_addr_to_page_num(VirtAddr addr, AlignDirection direction) {
    80203dae:	7179                	addi	sp,sp,-48
    80203db0:	f422                	sd	s0,40(sp)
    80203db2:	1800                	addi	s0,sp,48
    80203db4:	fca43c23          	sd	a0,-40(s0)
    80203db8:	87ae                	mv	a5,a1
    80203dba:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:19
    size_t num;
    if (direction == ALIGN_DOWN) {
    80203dbe:	fd442783          	lw	a5,-44(s0)
    80203dc2:	2781                	sext.w	a5,a5
    80203dc4:	e799                	bnez	a5,80203dd2 <virt_addr_to_page_num+0x24>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:21
        // 向下对齐到页边界
        num = addr.addr >> PAGE_SIZE_BITS;
    80203dc6:	fd843783          	ld	a5,-40(s0)
    80203dca:	83b1                	srli	a5,a5,0xc
    80203dcc:	fef43423          	sd	a5,-24(s0)
    80203dd0:	a809                	j	80203de2 <virt_addr_to_page_num+0x34>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:24
    } else { // ALIGN_UP
        // 向上对齐到下一个页边界
        num = (addr.addr + PAGE_SIZE - 1) >> PAGE_SIZE_BITS;
    80203dd2:	fd843703          	ld	a4,-40(s0)
    80203dd6:	6785                	lui	a5,0x1
    80203dd8:	17fd                	addi	a5,a5,-1
    80203dda:	97ba                	add	a5,a5,a4
    80203ddc:	83b1                	srli	a5,a5,0xc
    80203dde:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:26
    }
    return (VirtPageNum){.num = num};
    80203de2:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:27
}
    80203de6:	853e                	mv	a0,a5
    80203de8:	7422                	ld	s0,40(sp)
    80203dea:	6145                	addi	sp,sp,48
    80203dec:	8082                	ret

0000000080203dee <virt_page_num_to_addr>:
virt_page_num_to_addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:30

// 将虚拟页号转换为虚拟地址
VirtAddr virt_page_num_to_addr(VirtPageNum vpn) {
    80203dee:	1101                	addi	sp,sp,-32
    80203df0:	ec22                	sd	s0,24(sp)
    80203df2:	1000                	addi	s0,sp,32
    80203df4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:32
    // 计算页号对应的虚拟地址起始位置
    return (VirtAddr){.addr = vpn.num << PAGE_SIZE_BITS};
    80203df8:	fe843783          	ld	a5,-24(s0)
    80203dfc:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:33
}
    80203dfe:	853e                	mv	a0,a5
    80203e00:	6462                	ld	s0,24(sp)
    80203e02:	6105                	addi	sp,sp,32
    80203e04:	8082                	ret

0000000080203e06 <phys_page_num_to_addr>:
phys_page_num_to_addr():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:36

// 将物理页号转换为物理地址
PhysAddr phys_page_num_to_addr(PhysPageNum ppn) {
    80203e06:	1101                	addi	sp,sp,-32
    80203e08:	ec22                	sd	s0,24(sp)
    80203e0a:	1000                	addi	s0,sp,32
    80203e0c:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:38
    // 计算页号对应的物理地址起始位置
    return (PhysAddr){.addr = ppn.num << PAGE_SIZE_BITS};
    80203e10:	fe843783          	ld	a5,-24(s0)
    80203e14:	07b2                	slli	a5,a5,0xc
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:39
}
    80203e16:	853e                	mv	a0,a5
    80203e18:	6462                	ld	s0,24(sp)
    80203e1a:	6105                	addi	sp,sp,32
    80203e1c:	8082                	ret

0000000080203e1e <decompose_vpn>:
decompose_vpn():
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:42

// 解析虚拟页号，获取页内偏移及三级页表中各级的索引
uint64_t* decompose_vpn(uint64_t vpn) {
    80203e1e:	7139                	addi	sp,sp,-64
    80203e20:	fc22                	sd	s0,56(sp)
    80203e22:	0080                	addi	s0,sp,64
    80203e24:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:45
    static uint64_t result[4];
    // 获取页内偏移
    uint64_t page_offset = vpn & OFFSET_MASK;
    80203e28:	fc843703          	ld	a4,-56(s0)
    80203e2c:	6785                	lui	a5,0x1
    80203e2e:	17fd                	addi	a5,a5,-1
    80203e30:	8ff9                	and	a5,a5,a4
    80203e32:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:47
    // 移除偏移位，准备解析索引
    vpn >>= PAGE_SIZE_BITS;
    80203e36:	fc843783          	ld	a5,-56(s0)
    80203e3a:	83b1                	srli	a5,a5,0xc
    80203e3c:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:49
    // 解析L3索引
    uint64_t l3 = vpn & INDEX_MASK;
    80203e40:	fc843783          	ld	a5,-56(s0)
    80203e44:	1ff7f793          	andi	a5,a5,511
    80203e48:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:50
    vpn >>= INDEX_BITS;
    80203e4c:	fc843783          	ld	a5,-56(s0)
    80203e50:	83a5                	srli	a5,a5,0x9
    80203e52:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:52
    // 解析L2索引
    uint64_t l2 = vpn & INDEX_MASK;
    80203e56:	fc843783          	ld	a5,-56(s0)
    80203e5a:	1ff7f793          	andi	a5,a5,511
    80203e5e:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:53
    vpn >>= INDEX_BITS;
    80203e62:	fc843783          	ld	a5,-56(s0)
    80203e66:	83a5                	srli	a5,a5,0x9
    80203e68:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:55
    // 解析L1索引
    uint64_t l1 = vpn & INDEX_MASK;
    80203e6c:	fc843783          	ld	a5,-56(s0)
    80203e70:	1ff7f793          	andi	a5,a5,511
    80203e74:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:56
    result[0] = l1;
    80203e78:	00816797          	auipc	a5,0x816
    80203e7c:	1f078793          	addi	a5,a5,496 # 80a1a068 <result.0>
    80203e80:	fd043703          	ld	a4,-48(s0)
    80203e84:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:57
    result[1] = l2;
    80203e86:	00816797          	auipc	a5,0x816
    80203e8a:	1e278793          	addi	a5,a5,482 # 80a1a068 <result.0>
    80203e8e:	fd843703          	ld	a4,-40(s0)
    80203e92:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:58
    result[2] = l3;
    80203e94:	00816797          	auipc	a5,0x816
    80203e98:	1d478793          	addi	a5,a5,468 # 80a1a068 <result.0>
    80203e9c:	fe043703          	ld	a4,-32(s0)
    80203ea0:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:59
    result[3] = page_offset;
    80203ea2:	00816797          	auipc	a5,0x816
    80203ea6:	1c678793          	addi	a5,a5,454 # 80a1a068 <result.0>
    80203eaa:	fe843703          	ld	a4,-24(s0)
    80203eae:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:60
    return result;
    80203eb0:	00816797          	auipc	a5,0x816
    80203eb4:	1b878793          	addi	a5,a5,440 # 80a1a068 <result.0>
/home/caigoubencai/Desktop/os_c/kernel/memory/address/address.c:61
}
    80203eb8:	853e                	mv	a0,a5
    80203eba:	7462                	ld	s0,56(sp)
    80203ebc:	6121                	addi	sp,sp,64
    80203ebe:	8082                	ret

0000000080203ec0 <print_str>:
print_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:3
#include "console.h"
#include "sbi.h"
void print_str(const char* str) {
    80203ec0:	1101                	addi	sp,sp,-32
    80203ec2:	ec06                	sd	ra,24(sp)
    80203ec4:	e822                	sd	s0,16(sp)
    80203ec6:	1000                	addi	s0,sp,32
    80203ec8:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) {
    80203ecc:	a829                	j	80203ee6 <print_str+0x26>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:5
        console_putchar((uint64_t)(*str));
    80203ece:	fe843783          	ld	a5,-24(s0)
    80203ed2:	0007c783          	lbu	a5,0(a5)
    80203ed6:	853e                	mv	a0,a5
    80203ed8:	bbcfe0ef          	jal	ra,80202294 <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:6
        str++;
    80203edc:	fe843783          	ld	a5,-24(s0)
    80203ee0:	0785                	addi	a5,a5,1
    80203ee2:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:4
    while (*str) {
    80203ee6:	fe843783          	ld	a5,-24(s0)
    80203eea:	0007c783          	lbu	a5,0(a5)
    80203eee:	f3e5                	bnez	a5,80203ece <print_str+0xe>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:8
    }
}
    80203ef0:	0001                	nop
    80203ef2:	0001                	nop
    80203ef4:	60e2                	ld	ra,24(sp)
    80203ef6:	6442                	ld	s0,16(sp)
    80203ef8:	6105                	addi	sp,sp,32
    80203efa:	8082                	ret

0000000080203efc <reverse_str>:
reverse_str():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:10

void reverse_str(char* str, int length) {
    80203efc:	7179                	addi	sp,sp,-48
    80203efe:	f422                	sd	s0,40(sp)
    80203f00:	1800                	addi	s0,sp,48
    80203f02:	fca43c23          	sd	a0,-40(s0)
    80203f06:	87ae                	mv	a5,a1
    80203f08:	fcf42a23          	sw	a5,-44(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:11
    int start = 0;
    80203f0c:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:12
    int end = length - 1;
    80203f10:	fd442783          	lw	a5,-44(s0)
    80203f14:	37fd                	addiw	a5,a5,-1
    80203f16:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    while (start < end) {
    80203f1a:	a899                	j	80203f70 <reverse_str+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:14
        char temp = str[start];
    80203f1c:	fec42783          	lw	a5,-20(s0)
    80203f20:	fd843703          	ld	a4,-40(s0)
    80203f24:	97ba                	add	a5,a5,a4
    80203f26:	0007c783          	lbu	a5,0(a5)
    80203f2a:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:15
        str[start] = str[end];
    80203f2e:	fe842783          	lw	a5,-24(s0)
    80203f32:	fd843703          	ld	a4,-40(s0)
    80203f36:	973e                	add	a4,a4,a5
    80203f38:	fec42783          	lw	a5,-20(s0)
    80203f3c:	fd843683          	ld	a3,-40(s0)
    80203f40:	97b6                	add	a5,a5,a3
    80203f42:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <bss_end+0xffffffff7f594000>
    80203f46:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:16
        str[end] = temp;
    80203f4a:	fe842783          	lw	a5,-24(s0)
    80203f4e:	fd843703          	ld	a4,-40(s0)
    80203f52:	97ba                	add	a5,a5,a4
    80203f54:	fe744703          	lbu	a4,-25(s0)
    80203f58:	00e78023          	sb	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:17
        start++;
    80203f5c:	fec42783          	lw	a5,-20(s0)
    80203f60:	2785                	addiw	a5,a5,1
    80203f62:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:18
        end--;
    80203f66:	fe842783          	lw	a5,-24(s0)
    80203f6a:	37fd                	addiw	a5,a5,-1
    80203f6c:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:13
    while (start < end) {
    80203f70:	fec42703          	lw	a4,-20(s0)
    80203f74:	fe842783          	lw	a5,-24(s0)
    80203f78:	2701                	sext.w	a4,a4
    80203f7a:	2781                	sext.w	a5,a5
    80203f7c:	faf740e3          	blt	a4,a5,80203f1c <reverse_str+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:20
    }
}
    80203f80:	0001                	nop
    80203f82:	0001                	nop
    80203f84:	7422                	ld	s0,40(sp)
    80203f86:	6145                	addi	sp,sp,48
    80203f88:	8082                	ret

0000000080203f8a <print_uint32>:
print_uint32():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:22

void print_uint32(uint32_t value) {
    80203f8a:	7139                	addi	sp,sp,-64
    80203f8c:	fc06                	sd	ra,56(sp)
    80203f8e:	f822                	sd	s0,48(sp)
    80203f90:	0080                	addi	s0,sp,64
    80203f92:	87aa                	mv	a5,a0
    80203f94:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:24
    char buffer[12];
    int i = 0;
    80203f98:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:25
    if (value == 0) {
    80203f9c:	fcc42783          	lw	a5,-52(s0)
    80203fa0:	2781                	sext.w	a5,a5
    80203fa2:	e3ad                	bnez	a5,80204004 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:26
        buffer[i++] = '0';
    80203fa4:	fec42783          	lw	a5,-20(s0)
    80203fa8:	0017871b          	addiw	a4,a5,1
    80203fac:	fee42623          	sw	a4,-20(s0)
    80203fb0:	ff040713          	addi	a4,s0,-16
    80203fb4:	97ba                	add	a5,a5,a4
    80203fb6:	03000713          	li	a4,48
    80203fba:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:28
    }
    while (value != 0) {
    80203fbe:	a099                	j	80204004 <print_uint32+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:29
        int digit = value % 10;
    80203fc0:	fcc42703          	lw	a4,-52(s0)
    80203fc4:	47a9                	li	a5,10
    80203fc6:	02f777bb          	remuw	a5,a4,a5
    80203fca:	2781                	sext.w	a5,a5
    80203fcc:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:30
        buffer[i++] = digit + '0';
    80203fd0:	fe842783          	lw	a5,-24(s0)
    80203fd4:	0ff7f713          	andi	a4,a5,255
    80203fd8:	fec42783          	lw	a5,-20(s0)
    80203fdc:	0017869b          	addiw	a3,a5,1
    80203fe0:	fed42623          	sw	a3,-20(s0)
    80203fe4:	0307071b          	addiw	a4,a4,48
    80203fe8:	0ff77713          	andi	a4,a4,255
    80203fec:	ff040693          	addi	a3,s0,-16
    80203ff0:	97b6                	add	a5,a5,a3
    80203ff2:	fee78423          	sb	a4,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:31
        value /= 10;
    80203ff6:	fcc42703          	lw	a4,-52(s0)
    80203ffa:	47a9                	li	a5,10
    80203ffc:	02f757bb          	divuw	a5,a4,a5
    80204000:	fcf42623          	sw	a5,-52(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:28
    while (value != 0) {
    80204004:	fcc42783          	lw	a5,-52(s0)
    80204008:	2781                	sext.w	a5,a5
    8020400a:	fbdd                	bnez	a5,80203fc0 <print_uint32+0x36>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:33
    }
    buffer[i] = '\0';
    8020400c:	fec42783          	lw	a5,-20(s0)
    80204010:	ff040713          	addi	a4,s0,-16
    80204014:	97ba                	add	a5,a5,a4
    80204016:	fe078423          	sb	zero,-24(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:34
    reverse_str(buffer, i);
    8020401a:	fec42703          	lw	a4,-20(s0)
    8020401e:	fd840793          	addi	a5,s0,-40
    80204022:	85ba                	mv	a1,a4
    80204024:	853e                	mv	a0,a5
    80204026:	ed7ff0ef          	jal	ra,80203efc <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:35
    print_str(buffer);
    8020402a:	fd840793          	addi	a5,s0,-40
    8020402e:	853e                	mv	a0,a5
    80204030:	e91ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:36
}
    80204034:	0001                	nop
    80204036:	70e2                	ld	ra,56(sp)
    80204038:	7442                	ld	s0,48(sp)
    8020403a:	6121                	addi	sp,sp,64
    8020403c:	8082                	ret

000000008020403e <print_uint64>:
print_uint64():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:38

void print_uint64(uint64_t value) {
    8020403e:	7139                	addi	sp,sp,-64
    80204040:	fc06                	sd	ra,56(sp)
    80204042:	f822                	sd	s0,48(sp)
    80204044:	0080                	addi	s0,sp,64
    80204046:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:40
    char buffer[21]; // uint64_t的最大值需要20个字符加上一个终止符
    int i = 0;
    8020404a:	fe042623          	sw	zero,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:41
    if (value == 0) {
    8020404e:	fc843783          	ld	a5,-56(s0)
    80204052:	e3a5                	bnez	a5,802040b2 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:42
        buffer[i++] = '0';
    80204054:	fec42783          	lw	a5,-20(s0)
    80204058:	0017871b          	addiw	a4,a5,1
    8020405c:	fee42623          	sw	a4,-20(s0)
    80204060:	ff040713          	addi	a4,s0,-16
    80204064:	97ba                	add	a5,a5,a4
    80204066:	03000713          	li	a4,48
    8020406a:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:44
    }
    while (value != 0) {
    8020406e:	a091                	j	802040b2 <print_uint64+0x74>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:45
        int digit = value % 10;
    80204070:	fc843703          	ld	a4,-56(s0)
    80204074:	47a9                	li	a5,10
    80204076:	02f777b3          	remu	a5,a4,a5
    8020407a:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:46
        buffer[i++] = digit + '0';
    8020407e:	fe842783          	lw	a5,-24(s0)
    80204082:	0ff7f713          	andi	a4,a5,255
    80204086:	fec42783          	lw	a5,-20(s0)
    8020408a:	0017869b          	addiw	a3,a5,1
    8020408e:	fed42623          	sw	a3,-20(s0)
    80204092:	0307071b          	addiw	a4,a4,48
    80204096:	0ff77713          	andi	a4,a4,255
    8020409a:	ff040693          	addi	a3,s0,-16
    8020409e:	97b6                	add	a5,a5,a3
    802040a0:	fee78023          	sb	a4,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:47
        value /= 10;
    802040a4:	fc843703          	ld	a4,-56(s0)
    802040a8:	47a9                	li	a5,10
    802040aa:	02f757b3          	divu	a5,a4,a5
    802040ae:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:44
    while (value != 0) {
    802040b2:	fc843783          	ld	a5,-56(s0)
    802040b6:	ffcd                	bnez	a5,80204070 <print_uint64+0x32>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:49
    }
    buffer[i] = '\0';
    802040b8:	fec42783          	lw	a5,-20(s0)
    802040bc:	ff040713          	addi	a4,s0,-16
    802040c0:	97ba                	add	a5,a5,a4
    802040c2:	fe078023          	sb	zero,-32(a5)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:50
    reverse_str(buffer, i); // 假设reverse_str函数已经实现
    802040c6:	fec42703          	lw	a4,-20(s0)
    802040ca:	fd040793          	addi	a5,s0,-48
    802040ce:	85ba                	mv	a1,a4
    802040d0:	853e                	mv	a0,a5
    802040d2:	e2bff0ef          	jal	ra,80203efc <reverse_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:51
    print_str(buffer); // 假设print_str函数已经实现，用于打印字符串
    802040d6:	fd040793          	addi	a5,s0,-48
    802040da:	853e                	mv	a0,a5
    802040dc:	de5ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:52
}
    802040e0:	0001                	nop
    802040e2:	70e2                	ld	ra,56(sp)
    802040e4:	7442                	ld	s0,48(sp)
    802040e6:	6121                	addi	sp,sp,64
    802040e8:	8082                	ret

00000000802040ea <print_uint64_hex>:
print_uint64_hex():
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:55

void print_uint64_hex(uint64_t value) 
{
    802040ea:	7179                	addi	sp,sp,-48
    802040ec:	f406                	sd	ra,40(sp)
    802040ee:	f022                	sd	s0,32(sp)
    802040f0:	1800                	addi	s0,sp,48
    802040f2:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:56
    print_str("0x"); // 打印十六进制前缀
    802040f6:	00002517          	auipc	a0,0x2
    802040fa:	10a50513          	addi	a0,a0,266 # 80206200 <rodata_start+0x200>
    802040fe:	dc3ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57
    for (int i = 15; i >= 0; i--) 
    80204102:	47bd                	li	a5,15
    80204104:	fef42623          	sw	a5,-20(s0)
    80204108:	a09d                	j	8020416e <print_uint64_hex+0x84>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:59
    {
        int digit = (value >> (i * 4)) & 0xF; // 获取每个十六进制位
    8020410a:	fec42783          	lw	a5,-20(s0)
    8020410e:	0027979b          	slliw	a5,a5,0x2
    80204112:	2781                	sext.w	a5,a5
    80204114:	873e                	mv	a4,a5
    80204116:	fd843783          	ld	a5,-40(s0)
    8020411a:	00e7d7b3          	srl	a5,a5,a4
    8020411e:	2781                	sext.w	a5,a5
    80204120:	8bbd                	andi	a5,a5,15
    80204122:	fef42423          	sw	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60
        char hex = digit < 10 ? '0' + digit : 'A' + digit - 10; // 转换为字符
    80204126:	fe842783          	lw	a5,-24(s0)
    8020412a:	0007871b          	sext.w	a4,a5
    8020412e:	47a5                	li	a5,9
    80204130:	00e7cb63          	blt	a5,a4,80204146 <print_uint64_hex+0x5c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 1)
    80204134:	fe842783          	lw	a5,-24(s0)
    80204138:	0ff7f793          	andi	a5,a5,255
    8020413c:	0307879b          	addiw	a5,a5,48
    80204140:	0ff7f793          	andi	a5,a5,255
    80204144:	a809                	j	80204156 <print_uint64_hex+0x6c>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 2)
    80204146:	fe842783          	lw	a5,-24(s0)
    8020414a:	0ff7f793          	andi	a5,a5,255
    8020414e:	0377879b          	addiw	a5,a5,55
    80204152:	0ff7f793          	andi	a5,a5,255
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:60 (discriminator 4)
    80204156:	fef403a3          	sb	a5,-25(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:61 (discriminator 4)
        console_putchar((uint64_t)hex); // 输出字符
    8020415a:	fe744783          	lbu	a5,-25(s0)
    8020415e:	853e                	mv	a0,a5
    80204160:	934fe0ef          	jal	ra,80202294 <console_putchar>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57 (discriminator 4)
    for (int i = 15; i >= 0; i--) 
    80204164:	fec42783          	lw	a5,-20(s0)
    80204168:	37fd                	addiw	a5,a5,-1
    8020416a:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:57 (discriminator 2)
    8020416e:	fec42783          	lw	a5,-20(s0)
    80204172:	2781                	sext.w	a5,a5
    80204174:	f807dbe3          	bgez	a5,8020410a <print_uint64_hex+0x20>
/home/caigoubencai/Desktop/os_c/kernel/console/console.c:63
    }
    80204178:	0001                	nop
    8020417a:	0001                	nop
    8020417c:	70a2                	ld	ra,40(sp)
    8020417e:	7402                	ld	s0,32(sp)
    80204180:	6145                	addi	sp,sp,48
    80204182:	8082                	ret

0000000080204184 <panic>:
panic():
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:3
#include "console.h"
#include "sbi.h"
void panic(const char *file, int line) {
    80204184:	1101                	addi	sp,sp,-32
    80204186:	ec06                	sd	ra,24(sp)
    80204188:	e822                	sd	s0,16(sp)
    8020418a:	1000                	addi	s0,sp,32
    8020418c:	fea43423          	sd	a0,-24(s0)
    80204190:	87ae                	mv	a5,a1
    80204192:	fef42223          	sw	a5,-28(s0)
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:4
    print_str("Panic! File: ");
    80204196:	00002517          	auipc	a0,0x2
    8020419a:	07250513          	addi	a0,a0,114 # 80206208 <rodata_start+0x208>
    8020419e:	d23ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:5
    print_str(file);
    802041a2:	fe843503          	ld	a0,-24(s0)
    802041a6:	d1bff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:6
    print_str(", Line: ");
    802041aa:	00002517          	auipc	a0,0x2
    802041ae:	06e50513          	addi	a0,a0,110 # 80206218 <rodata_start+0x218>
    802041b2:	d0fff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:7
    print_uint32(line);
    802041b6:	fe442783          	lw	a5,-28(s0)
    802041ba:	853e                	mv	a0,a5
    802041bc:	dcfff0ef          	jal	ra,80203f8a <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:8
    print_str("\n");
    802041c0:	00002517          	auipc	a0,0x2
    802041c4:	06850513          	addi	a0,a0,104 # 80206228 <rodata_start+0x228>
    802041c8:	cf9ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:9
    sbi_shutdown();
    802041cc:	90efe0ef          	jal	ra,802022da <sbi_shutdown>
/home/caigoubencai/Desktop/os_c/kernel/debug/debug.c:10 (discriminator 1)
    while(1);
    802041d0:	a001                	j	802041d0 <panic+0x4c>

00000000802041d2 <task_manager_init>:
task_manager_init():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:13
struct TaskManager task_manager;
extern void __switch(struct TaskContext*,struct TaskContext*);
extern uint64_t _num_app[];

void task_manager_init( void )
{
    802041d2:	7129                	addi	sp,sp,-320
    802041d4:	fe06                	sd	ra,312(sp)
    802041d6:	fa22                	sd	s0,304(sp)
    802041d8:	0280                	addi	s0,sp,320
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:16

    extern void __restore(uint64_t);
    print_str("[Test] __restore: ");
    802041da:	00002517          	auipc	a0,0x2
    802041de:	05650513          	addi	a0,a0,86 # 80206230 <rodata_start+0x230>
    802041e2:	cdfff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:17
    print_uint64((uint64_t)__restore);
    802041e6:	00001797          	auipc	a5,0x1
    802041ea:	1b678793          	addi	a5,a5,438 # 8020539c <__restore>
    802041ee:	853e                	mv	a0,a5
    802041f0:	e4fff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:18
    print_str("\n");
    802041f4:	00002517          	auipc	a0,0x2
    802041f8:	05450513          	addi	a0,a0,84 # 80206248 <rodata_start+0x248>
    802041fc:	cc5ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:19
    task_manager.num_task = MAX_APP_NUM;
    80204200:	00816797          	auipc	a5,0x816
    80204204:	e8878793          	addi	a5,a5,-376 # 80a1a088 <task_manager>
    80204208:	4751                	li	a4,20
    8020420a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:20
    task_manager.current_task = 0;
    8020420c:	00816797          	auipc	a5,0x816
    80204210:	e7c78793          	addi	a5,a5,-388 # 80a1a088 <task_manager>
    80204214:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23

    // 初始化TCB
    for(uint64_t i = 0; i < app_manager.app_num; i ++)
    80204218:	fe043423          	sd	zero,-24(s0)
    8020421c:	a8d1                	j	802042f0 <task_manager_init+0x11e>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:27 (discriminator 3)
    {

        // 获取kernel_stack压入TrapContext后的地址
        uint64_t target_sp = get_kernel_stack_top(i) - sizeof(struct TrapContext);
    8020421e:	fe843503          	ld	a0,-24(s0)
    80204222:	6c2000ef          	jal	ra,802048e4 <get_kernel_stack_top>
    80204226:	87aa                	mv	a5,a0
    80204228:	ef078793          	addi	a5,a5,-272
    8020422c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:28 (discriminator 3)
        task_manager.tasks[i].task_status = Ready; // 设置app状态
    80204230:	00816697          	auipc	a3,0x816
    80204234:	e5868693          	addi	a3,a3,-424 # 80a1a088 <task_manager>
    80204238:	fe843703          	ld	a4,-24(s0)
    8020423c:	87ba                	mv	a5,a4
    8020423e:	0792                	slli	a5,a5,0x4
    80204240:	8f99                	sub	a5,a5,a4
    80204242:	078e                	slli	a5,a5,0x3
    80204244:	97b6                	add	a5,a5,a3
    80204246:	4705                	li	a4,1
    80204248:	08e7a023          	sw	a4,128(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:29 (discriminator 3)
        task_manager.tasks[i].task_cx.ra = (uint64_t)__restore; // 设置switch函数返回地址
    8020424c:	00001697          	auipc	a3,0x1
    80204250:	15068693          	addi	a3,a3,336 # 8020539c <__restore>
    80204254:	00816617          	auipc	a2,0x816
    80204258:	e3460613          	addi	a2,a2,-460 # 80a1a088 <task_manager>
    8020425c:	fe843703          	ld	a4,-24(s0)
    80204260:	87ba                	mv	a5,a4
    80204262:	0792                	slli	a5,a5,0x4
    80204264:	8f99                	sub	a5,a5,a4
    80204266:	078e                	slli	a5,a5,0x3
    80204268:	97b2                	add	a5,a5,a2
    8020426a:	eb94                	sd	a3,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:30 (discriminator 3)
        task_manager.tasks[i].task_cx.sp = target_sp; // 设置各自kernel_stack位置
    8020426c:	00816697          	auipc	a3,0x816
    80204270:	e1c68693          	addi	a3,a3,-484 # 80a1a088 <task_manager>
    80204274:	fe843703          	ld	a4,-24(s0)
    80204278:	87ba                	mv	a5,a4
    8020427a:	0792                	slli	a5,a5,0x4
    8020427c:	8f99                	sub	a5,a5,a4
    8020427e:	078e                	slli	a5,a5,0x3
    80204280:	97b6                	add	a5,a5,a3
    80204282:	fe043703          	ld	a4,-32(s0)
    80204286:	ef98                	sd	a4,24(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:33 (discriminator 3)

        /* 初始化kernel_stack */
        struct TrapContext tc = {
    80204288:	ec840793          	addi	a5,s0,-312
    8020428c:	11000713          	li	a4,272
    80204290:	863a                	mv	a2,a4
    80204292:	4581                	li	a1,0
    80204294:	853e                	mv	a0,a5
    80204296:	ca2fe0ef          	jal	ra,80202738 <memset>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:38 (discriminator 3)
            {0},
            0,
            0
        };
        tc.sepc = APP_BASE_ADDRESS + (APP_SIZE_LIMIT * i); // 设置app首次进入的地址
    8020429a:	fe843703          	ld	a4,-24(s0)
    8020429e:	6791                	lui	a5,0x4
    802042a0:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    802042a4:	97ba                	add	a5,a5,a4
    802042a6:	07c6                	slli	a5,a5,0x11
    802042a8:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:39 (discriminator 3)
        tc.sstatus = READ_CSR(sstatus) & (~SSTATUS_SPP); // 设置sstatus寄存器为内核状态
    802042ac:	100027f3          	csrr	a5,sstatus
    802042b0:	fcf43c23          	sd	a5,-40(s0)
    802042b4:	fd843783          	ld	a5,-40(s0)
    802042b8:	eff7f793          	andi	a5,a5,-257
    802042bc:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:40 (discriminator 3)
        tc.x[2] = (uint64_t)get_user_stack_top(i); // 保证sscratch指向user_stack
    802042c0:	fe843503          	ld	a0,-24(s0)
    802042c4:	64a000ef          	jal	ra,8020490e <get_user_stack_top>
    802042c8:	87aa                	mv	a5,a0
    802042ca:	ecf43c23          	sd	a5,-296(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:42 (discriminator 3)
        // 将TrapContext压入kernel_stack
        *(struct TrapContext *)target_sp = tc;
    802042ce:	fe043783          	ld	a5,-32(s0)
    802042d2:	86be                	mv	a3,a5
    802042d4:	ec840793          	addi	a5,s0,-312
    802042d8:	11000713          	li	a4,272
    802042dc:	863a                	mv	a2,a4
    802042de:	85be                	mv	a1,a5
    802042e0:	8536                	mv	a0,a3
    802042e2:	c08fe0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23 (discriminator 3)
    for(uint64_t i = 0; i < app_manager.app_num; i ++)
    802042e6:	fe843783          	ld	a5,-24(s0)
    802042ea:	0785                	addi	a5,a5,1
    802042ec:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:23 (discriminator 1)
    802042f0:	00816797          	auipc	a5,0x816
    802042f4:	77878793          	addi	a5,a5,1912 # 80a1aa68 <app_manager>
    802042f8:	639c                	ld	a5,0(a5)
    802042fa:	fe843703          	ld	a4,-24(s0)
    802042fe:	f2f760e3          	bltu	a4,a5,8020421e <task_manager_init+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:44
    }
}
    80204302:	0001                	nop
    80204304:	0001                	nop
    80204306:	70f2                	ld	ra,312(sp)
    80204308:	7452                	ld	s0,304(sp)
    8020430a:	6131                	addi	sp,sp,320
    8020430c:	8082                	ret

000000008020430e <run_next_task>:
run_next_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:48


void run_next_task(uint64_t status) 
{
    8020430e:	7139                	addi	sp,sp,-64
    80204310:	fc06                	sd	ra,56(sp)
    80204312:	f822                	sd	s0,48(sp)
    80204314:	0080                	addi	s0,sp,64
    80204316:	fca43423          	sd	a0,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51
    /* 寻找ready的task */
    uint64_t target_task_num;
    for (target_task_num = (task_manager.current_task + 1) % MAX_APP_NUM; target_task_num != task_manager.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    8020431a:	00816797          	auipc	a5,0x816
    8020431e:	d6e78793          	addi	a5,a5,-658 # 80a1a088 <task_manager>
    80204322:	679c                	ld	a5,8(a5)
    80204324:	00178713          	addi	a4,a5,1
    80204328:	47d1                	li	a5,20
    8020432a:	02f777b3          	remu	a5,a4,a5
    8020432e:	fef43423          	sd	a5,-24(s0)
    80204332:	a81d                	j	80204368 <run_next_task+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:52
        if (task_manager.tasks[target_task_num].task_status == Ready) {
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
    80204352:	02f70563          	beq	a4,a5,8020437c <run_next_task+0x6e>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51 (discriminator 2)
    for (target_task_num = (task_manager.current_task + 1) % MAX_APP_NUM; target_task_num != task_manager.current_task; target_task_num = (target_task_num + 1) % MAX_APP_NUM) {
    80204356:	fe843783          	ld	a5,-24(s0)
    8020435a:	00178713          	addi	a4,a5,1
    8020435e:	47d1                	li	a5,20
    80204360:	02f777b3          	remu	a5,a4,a5
    80204364:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:51 (discriminator 1)
    80204368:	00816797          	auipc	a5,0x816
    8020436c:	d2078793          	addi	a5,a5,-736 # 80a1a088 <task_manager>
    80204370:	679c                	ld	a5,8(a5)
    80204372:	fe843703          	ld	a4,-24(s0)
    80204376:	faf71fe3          	bne	a4,a5,80204334 <run_next_task+0x26>
    8020437a:	a011                	j	8020437e <run_next_task+0x70>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:53
            break;
    8020437c:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:57
        }
    }
    // 没有ready的任务
    if ((target_task_num == task_manager.current_task) && (task_manager.tasks[target_task_num].task_status != Ready)) {
    8020437e:	00816797          	auipc	a5,0x816
    80204382:	d0a78793          	addi	a5,a5,-758 # 80a1a088 <task_manager>
    80204386:	679c                	ld	a5,8(a5)
    80204388:	fe843703          	ld	a4,-24(s0)
    8020438c:	02f71b63          	bne	a4,a5,802043c2 <run_next_task+0xb4>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:57 (discriminator 1)
    80204390:	00816697          	auipc	a3,0x816
    80204394:	cf868693          	addi	a3,a3,-776 # 80a1a088 <task_manager>
    80204398:	fe843703          	ld	a4,-24(s0)
    8020439c:	87ba                	mv	a5,a4
    8020439e:	0792                	slli	a5,a5,0x4
    802043a0:	8f99                	sub	a5,a5,a4
    802043a2:	078e                	slli	a5,a5,0x3
    802043a4:	97b6                	add	a5,a5,a3
    802043a6:	0807a783          	lw	a5,128(a5)
    802043aa:	873e                	mv	a4,a5
    802043ac:	4785                	li	a5,1
    802043ae:	00f70a63          	beq	a4,a5,802043c2 <run_next_task+0xb4>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:58 (discriminator 1)
        ASSERT(0);
    802043b2:	03a00593          	li	a1,58
    802043b6:	00002517          	auipc	a0,0x2
    802043ba:	e9a50513          	addi	a0,a0,-358 # 80206250 <rodata_start+0x250>
    802043be:	dc7ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:61
    }

    struct TaskControlBlock* target_task_tcb = &task_manager.tasks[target_task_num];
    802043c2:	fe843703          	ld	a4,-24(s0)
    802043c6:	87ba                	mv	a5,a4
    802043c8:	0792                	slli	a5,a5,0x4
    802043ca:	8f99                	sub	a5,a5,a4
    802043cc:	078e                	slli	a5,a5,0x3
    802043ce:	01078713          	addi	a4,a5,16
    802043d2:	00816797          	auipc	a5,0x816
    802043d6:	cb678793          	addi	a5,a5,-842 # 80a1a088 <task_manager>
    802043da:	97ba                	add	a5,a5,a4
    802043dc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:62
    struct TaskControlBlock* current_task_tcb = &task_manager.tasks[task_manager.current_task];
    802043e0:	00816797          	auipc	a5,0x816
    802043e4:	ca878793          	addi	a5,a5,-856 # 80a1a088 <task_manager>
    802043e8:	6798                	ld	a4,8(a5)
    802043ea:	87ba                	mv	a5,a4
    802043ec:	0792                	slli	a5,a5,0x4
    802043ee:	8f99                	sub	a5,a5,a4
    802043f0:	078e                	slli	a5,a5,0x3
    802043f2:	01078713          	addi	a4,a5,16
    802043f6:	00816797          	auipc	a5,0x816
    802043fa:	c9278793          	addi	a5,a5,-878 # 80a1a088 <task_manager>
    802043fe:	97ba                	add	a5,a5,a4
    80204400:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:65

    /* 改变状态 */
    current_task_tcb->task_status = status;
    80204404:	fc843783          	ld	a5,-56(s0)
    80204408:	0007871b          	sext.w	a4,a5
    8020440c:	fd843783          	ld	a5,-40(s0)
    80204410:	dbb8                	sw	a4,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:66
    target_task_tcb->task_status = Running;
    80204412:	fe043783          	ld	a5,-32(s0)
    80204416:	4709                	li	a4,2
    80204418:	dbb8                	sw	a4,112(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:67
    task_manager.current_task = target_task_num;
    8020441a:	00816797          	auipc	a5,0x816
    8020441e:	c6e78793          	addi	a5,a5,-914 # 80a1a088 <task_manager>
    80204422:	fe843703          	ld	a4,-24(s0)
    80204426:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:70

    /* 交换TaskContext */
    __switch(&(current_task_tcb->task_cx), &(target_task_tcb->task_cx));
    80204428:	fd843783          	ld	a5,-40(s0)
    8020442c:	fe043703          	ld	a4,-32(s0)
    80204430:	85ba                	mv	a1,a4
    80204432:	853e                	mv	a0,a5
    80204434:	7c7000ef          	jal	ra,802053fa <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:71
}
    80204438:	0001                	nop
    8020443a:	70e2                	ld	ra,56(sp)
    8020443c:	7442                	ld	s0,48(sp)
    8020443e:	6121                	addi	sp,sp,64
    80204440:	8082                	ret

0000000080204442 <run_first_task>:
run_first_task():
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:75


void run_first_task(void) 
{
    80204442:	1141                	addi	sp,sp,-16
    80204444:	e406                	sd	ra,8(sp)
    80204446:	e022                	sd	s0,0(sp)
    80204448:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:77
    static struct TaskContext temp;
    task_manager.tasks[task_manager.current_task].task_status = Running;
    8020444a:	00816797          	auipc	a5,0x816
    8020444e:	c3e78793          	addi	a5,a5,-962 # 80a1a088 <task_manager>
    80204452:	6798                	ld	a4,8(a5)
    80204454:	00816697          	auipc	a3,0x816
    80204458:	c3468693          	addi	a3,a3,-972 # 80a1a088 <task_manager>
    8020445c:	87ba                	mv	a5,a4
    8020445e:	0792                	slli	a5,a5,0x4
    80204460:	8f99                	sub	a5,a5,a4
    80204462:	078e                	slli	a5,a5,0x3
    80204464:	97b6                	add	a5,a5,a3
    80204466:	4709                	li	a4,2
    80204468:	08e7a023          	sw	a4,128(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:78
    print_str("[kernel] ready to run first app\n");
    8020446c:	00002517          	auipc	a0,0x2
    80204470:	e0450513          	addi	a0,a0,-508 # 80206270 <rodata_start+0x270>
    80204474:	a4dff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:79
    __switch(&temp, &task_manager.tasks[task_manager.current_task].task_cx);
    80204478:	00816797          	auipc	a5,0x816
    8020447c:	c1078793          	addi	a5,a5,-1008 # 80a1a088 <task_manager>
    80204480:	6798                	ld	a4,8(a5)
    80204482:	87ba                	mv	a5,a4
    80204484:	0792                	slli	a5,a5,0x4
    80204486:	8f99                	sub	a5,a5,a4
    80204488:	078e                	slli	a5,a5,0x3
    8020448a:	01078713          	addi	a4,a5,16
    8020448e:	00816797          	auipc	a5,0x816
    80204492:	bfa78793          	addi	a5,a5,-1030 # 80a1a088 <task_manager>
    80204496:	97ba                	add	a5,a5,a4
    80204498:	85be                	mv	a1,a5
    8020449a:	00816517          	auipc	a0,0x816
    8020449e:	55e50513          	addi	a0,a0,1374 # 80a1a9f8 <temp.0>
    802044a2:	759000ef          	jal	ra,802053fa <__switch>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:80
    ASSERT(0);
    802044a6:	05000593          	li	a1,80
    802044aa:	00002517          	auipc	a0,0x2
    802044ae:	da650513          	addi	a0,a0,-602 # 80206250 <rodata_start+0x250>
    802044b2:	cd3ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/task/task.c:81
    802044b6:	0001                	nop
    802044b8:	60a2                	ld	ra,8(sp)
    802044ba:	6402                	ld	s0,0(sp)
    802044bc:	0141                	addi	sp,sp,16
    802044be:	8082                	ret

00000000802044c0 <init_appmanager>:
init_appmanager():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:13

struct AppManager app_manager;


void init_appmanager()
{
    802044c0:	1101                	addi	sp,sp,-32
    802044c2:	ec06                	sd	ra,24(sp)
    802044c4:	e822                	sd	s0,16(sp)
    802044c6:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:14
    app_manager.app_num = _num_app[0];
    802044c8:	00003797          	auipc	a5,0x3
    802044cc:	b3878793          	addi	a5,a5,-1224 # 80207000 <_num_app>
    802044d0:	6398                	ld	a4,0(a5)
    802044d2:	00816797          	auipc	a5,0x816
    802044d6:	59678793          	addi	a5,a5,1430 # 80a1aa68 <app_manager>
    802044da:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    802044dc:	fe043423          	sd	zero,-24(s0)
    802044e0:	a085                	j	80204540 <init_appmanager+0x80>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:17 (discriminator 3)
    {
        app_manager.app_start[i] = _num_app[1 + i * 2];
    802044e2:	fe843783          	ld	a5,-24(s0)
    802044e6:	0786                	slli	a5,a5,0x1
    802044e8:	0785                	addi	a5,a5,1
    802044ea:	00003717          	auipc	a4,0x3
    802044ee:	b1670713          	addi	a4,a4,-1258 # 80207000 <_num_app>
    802044f2:	078e                	slli	a5,a5,0x3
    802044f4:	97ba                	add	a5,a5,a4
    802044f6:	6398                	ld	a4,0(a5)
    802044f8:	00816697          	auipc	a3,0x816
    802044fc:	57068693          	addi	a3,a3,1392 # 80a1aa68 <app_manager>
    80204500:	fe843783          	ld	a5,-24(s0)
    80204504:	0789                	addi	a5,a5,2
    80204506:	078e                	slli	a5,a5,0x3
    80204508:	97b6                	add	a5,a5,a3
    8020450a:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:18 (discriminator 3)
        app_manager.app_end[i] = _num_app[2 + i * 2];
    8020450c:	fe843783          	ld	a5,-24(s0)
    80204510:	0785                	addi	a5,a5,1
    80204512:	0786                	slli	a5,a5,0x1
    80204514:	00003717          	auipc	a4,0x3
    80204518:	aec70713          	addi	a4,a4,-1300 # 80207000 <_num_app>
    8020451c:	078e                	slli	a5,a5,0x3
    8020451e:	97ba                	add	a5,a5,a4
    80204520:	6398                	ld	a4,0(a5)
    80204522:	00816697          	auipc	a3,0x816
    80204526:	54668693          	addi	a3,a3,1350 # 80a1aa68 <app_manager>
    8020452a:	fe843783          	ld	a5,-24(s0)
    8020452e:	07d9                	addi	a5,a5,22
    80204530:	078e                	slli	a5,a5,0x3
    80204532:	97b6                	add	a5,a5,a3
    80204534:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 3)
    for (uint64_t i = 0; i < app_manager.app_num; i++) 
    80204536:	fe843783          	ld	a5,-24(s0)
    8020453a:	0785                	addi	a5,a5,1
    8020453c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:15 (discriminator 1)
    80204540:	00816797          	auipc	a5,0x816
    80204544:	52878793          	addi	a5,a5,1320 # 80a1aa68 <app_manager>
    80204548:	639c                	ld	a5,0(a5)
    8020454a:	fe843703          	ld	a4,-24(s0)
    8020454e:	f8f76ae3          	bltu	a4,a5,802044e2 <init_appmanager+0x22>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:20
    }
    app_manager.current_app = 0;
    80204552:	00816797          	auipc	a5,0x816
    80204556:	51678793          	addi	a5,a5,1302 # 80a1aa68 <app_manager>
    8020455a:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:21
    print_app_info(&app_manager);
    8020455e:	00816517          	auipc	a0,0x816
    80204562:	50a50513          	addi	a0,a0,1290 # 80a1aa68 <app_manager>
    80204566:	00e000ef          	jal	ra,80204574 <print_app_info>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:22
}
    8020456a:	0001                	nop
    8020456c:	60e2                	ld	ra,24(sp)
    8020456e:	6442                	ld	s0,16(sp)
    80204570:	6105                	addi	sp,sp,32
    80204572:	8082                	ret

0000000080204574 <print_app_info>:
print_app_info():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:25


void print_app_info(struct AppManager *manager) {
    80204574:	7179                	addi	sp,sp,-48
    80204576:	f406                	sd	ra,40(sp)
    80204578:	f022                	sd	s0,32(sp)
    8020457a:	1800                	addi	s0,sp,48
    8020457c:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:26
    print_str("Total applications: ");
    80204580:	00002517          	auipc	a0,0x2
    80204584:	d1850513          	addi	a0,a0,-744 # 80206298 <rodata_start+0x298>
    80204588:	939ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:27
    print_uint64(manager->app_num);
    8020458c:	fd843783          	ld	a5,-40(s0)
    80204590:	639c                	ld	a5,0(a5)
    80204592:	853e                	mv	a0,a5
    80204594:	aabff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:28
    print_str("\n");
    80204598:	00002517          	auipc	a0,0x2
    8020459c:	d1850513          	addi	a0,a0,-744 # 802062b0 <rodata_start+0x2b0>
    802045a0:	921ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30

    for (uint64_t i = 0; i < manager->app_num; ++i) {
    802045a4:	fe043423          	sd	zero,-24(s0)
    802045a8:	a885                	j	80204618 <print_app_info+0xa4>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:31 (discriminator 3)
        print_str("App ");
    802045aa:	00002517          	auipc	a0,0x2
    802045ae:	d0e50513          	addi	a0,a0,-754 # 802062b8 <rodata_start+0x2b8>
    802045b2:	90fff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:32 (discriminator 3)
        print_uint64(i);
    802045b6:	fe843503          	ld	a0,-24(s0)
    802045ba:	a85ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:33 (discriminator 3)
        print_str(":\n  Start Address: ");
    802045be:	00002517          	auipc	a0,0x2
    802045c2:	d0250513          	addi	a0,a0,-766 # 802062c0 <rodata_start+0x2c0>
    802045c6:	8fbff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:34 (discriminator 3)
        print_uint64(manager->app_start[i]);
    802045ca:	fd843703          	ld	a4,-40(s0)
    802045ce:	fe843783          	ld	a5,-24(s0)
    802045d2:	0789                	addi	a5,a5,2
    802045d4:	078e                	slli	a5,a5,0x3
    802045d6:	97ba                	add	a5,a5,a4
    802045d8:	639c                	ld	a5,0(a5)
    802045da:	853e                	mv	a0,a5
    802045dc:	a63ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:35 (discriminator 3)
        print_str("\n  End Address:   ");
    802045e0:	00002517          	auipc	a0,0x2
    802045e4:	cf850513          	addi	a0,a0,-776 # 802062d8 <rodata_start+0x2d8>
    802045e8:	8d9ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:36 (discriminator 3)
        print_uint64(manager->app_end[i]);
    802045ec:	fd843703          	ld	a4,-40(s0)
    802045f0:	fe843783          	ld	a5,-24(s0)
    802045f4:	07d9                	addi	a5,a5,22
    802045f6:	078e                	slli	a5,a5,0x3
    802045f8:	97ba                	add	a5,a5,a4
    802045fa:	639c                	ld	a5,0(a5)
    802045fc:	853e                	mv	a0,a5
    802045fe:	a41ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:37 (discriminator 3)
        print_str("\n");
    80204602:	00002517          	auipc	a0,0x2
    80204606:	cae50513          	addi	a0,a0,-850 # 802062b0 <rodata_start+0x2b0>
    8020460a:	8b7ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 3)
    for (uint64_t i = 0; i < manager->app_num; ++i) {
    8020460e:	fe843783          	ld	a5,-24(s0)
    80204612:	0785                	addi	a5,a5,1
    80204614:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:30 (discriminator 1)
    80204618:	fd843783          	ld	a5,-40(s0)
    8020461c:	639c                	ld	a5,0(a5)
    8020461e:	fe843703          	ld	a4,-24(s0)
    80204622:	f8f764e3          	bltu	a4,a5,802045aa <print_app_info+0x36>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:39
    }
}
    80204626:	0001                	nop
    80204628:	0001                	nop
    8020462a:	70a2                	ld	ra,40(sp)
    8020462c:	7402                	ld	s0,32(sp)
    8020462e:	6145                	addi	sp,sp,48
    80204630:	8082                	ret

0000000080204632 <run_next_app>:
run_next_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:42

void run_next_app()
{
    80204632:	db010113          	addi	sp,sp,-592
    80204636:	24113423          	sd	ra,584(sp)
    8020463a:	24813023          	sd	s0,576(sp)
    8020463e:	22913c23          	sd	s1,568(sp)
    80204642:	0c80                	addi	s0,sp,592
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:44
    //print_str("run_next_app");
    print_str("run_next_app : ");
    80204644:	00002517          	auipc	a0,0x2
    80204648:	cac50513          	addi	a0,a0,-852 # 802062f0 <rodata_start+0x2f0>
    8020464c:	875ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:45
    print_uint64(app_manager.current_app);
    80204650:	00816797          	auipc	a5,0x816
    80204654:	41878793          	addi	a5,a5,1048 # 80a1aa68 <app_manager>
    80204658:	679c                	ld	a5,8(a5)
    8020465a:	853e                	mv	a0,a5
    8020465c:	9e3ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:46
    print_str("\n");
    80204660:	00002517          	auipc	a0,0x2
    80204664:	c5050513          	addi	a0,a0,-944 # 802062b0 <rodata_start+0x2b0>
    80204668:	859ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:47
    app_manager.current_app++;
    8020466c:	00816797          	auipc	a5,0x816
    80204670:	3fc78793          	addi	a5,a5,1020 # 80a1aa68 <app_manager>
    80204674:	679c                	ld	a5,8(a5)
    80204676:	00178713          	addi	a4,a5,1
    8020467a:	00816797          	auipc	a5,0x816
    8020467e:	3ee78793          	addi	a5,a5,1006 # 80a1aa68 <app_manager>
    80204682:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:48
    if(app_manager.current_app>=app_manager.app_num)
    80204684:	00816797          	auipc	a5,0x816
    80204688:	3e478793          	addi	a5,a5,996 # 80a1aa68 <app_manager>
    8020468c:	6798                	ld	a4,8(a5)
    8020468e:	00816797          	auipc	a5,0x816
    80204692:	3da78793          	addi	a5,a5,986 # 80a1aa68 <app_manager>
    80204696:	639c                	ld	a5,0(a5)
    80204698:	02f76063          	bltu	a4,a5,802046b8 <run_next_app+0x86>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:50
    {
        print_str("app execute over\n");
    8020469c:	00002517          	auipc	a0,0x2
    802046a0:	c6450513          	addi	a0,a0,-924 # 80206300 <rodata_start+0x300>
    802046a4:	81dff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:51
        ASSERT(0);
    802046a8:	03300593          	li	a1,51
    802046ac:	00002517          	auipc	a0,0x2
    802046b0:	c6c50513          	addi	a0,a0,-916 # 80206318 <rodata_start+0x318>
    802046b4:	ad1ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:53
    }
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    802046b8:	00816797          	auipc	a5,0x816
    802046bc:	3b078793          	addi	a5,a5,944 # 80a1aa68 <app_manager>
    802046c0:	679c                	ld	a5,8(a5)
    802046c2:	00816717          	auipc	a4,0x816
    802046c6:	3a670713          	addi	a4,a4,934 # 80a1aa68 <app_manager>
    802046ca:	0789                	addi	a5,a5,2
    802046cc:	078e                	slli	a5,a5,0x3
    802046ce:	97ba                	add	a5,a5,a4
    802046d0:	639c                	ld	a5,0(a5)
    802046d2:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:54
    asm volatile ("fence.i");
    802046d6:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:55
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    802046da:	00816797          	auipc	a5,0x816
    802046de:	38e78793          	addi	a5,a5,910 # 80a1aa68 <app_manager>
    802046e2:	679c                	ld	a5,8(a5)
    802046e4:	853e                	mv	a0,a5
    802046e6:	228000ef          	jal	ra,8020490e <get_user_stack_top>
    802046ea:	872a                	mv	a4,a0
    802046ec:	ec040793          	addi	a5,s0,-320
    802046f0:	863a                	mv	a2,a4
    802046f2:	fd843583          	ld	a1,-40(s0)
    802046f6:	853e                	mv	a0,a5
    802046f8:	302000ef          	jal	ra,802049fa <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:56
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    802046fc:	00816797          	auipc	a5,0x816
    80204700:	36c78793          	addi	a5,a5,876 # 80a1aa68 <app_manager>
    80204704:	6784                	ld	s1,8(a5)
    80204706:	db040793          	addi	a5,s0,-592
    8020470a:	ec040713          	addi	a4,s0,-320
    8020470e:	11000693          	li	a3,272
    80204712:	8636                	mv	a2,a3
    80204714:	85ba                	mv	a1,a4
    80204716:	853e                	mv	a0,a5
    80204718:	fd3fd0ef          	jal	ra,802026ea <memcpy>
    8020471c:	db040793          	addi	a5,s0,-592
    80204720:	85a6                	mv	a1,s1
    80204722:	853e                	mv	a0,a5
    80204724:	214000ef          	jal	ra,80204938 <Kernelstack_push_TrapContext>
    80204728:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:58
    //__restore(trapcontext);
    __restore((uint64_t)cx);
    8020472c:	fd043783          	ld	a5,-48(s0)
    80204730:	853e                	mv	a0,a5
    80204732:	46b000ef          	jal	ra,8020539c <__restore>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:59
}
    80204736:	0001                	nop
    80204738:	24813083          	ld	ra,584(sp)
    8020473c:	24013403          	ld	s0,576(sp)
    80204740:	23813483          	ld	s1,568(sp)
    80204744:	25010113          	addi	sp,sp,592
    80204748:	8082                	ret

000000008020474a <run_first_app>:
run_first_app():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:62

void run_first_app()
{
    8020474a:	db010113          	addi	sp,sp,-592
    8020474e:	24113423          	sd	ra,584(sp)
    80204752:	24813023          	sd	s0,576(sp)
    80204756:	22913c23          	sd	s1,568(sp)
    8020475a:	0c80                	addi	s0,sp,592
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:63
    uintptr_t start_addr=app_manager.app_start[app_manager.current_app];
    8020475c:	00816797          	auipc	a5,0x816
    80204760:	30c78793          	addi	a5,a5,780 # 80a1aa68 <app_manager>
    80204764:	679c                	ld	a5,8(a5)
    80204766:	00816717          	auipc	a4,0x816
    8020476a:	30270713          	addi	a4,a4,770 # 80a1aa68 <app_manager>
    8020476e:	0789                	addi	a5,a5,2
    80204770:	078e                	slli	a5,a5,0x3
    80204772:	97ba                	add	a5,a5,a4
    80204774:	639c                	ld	a5,0(a5)
    80204776:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:64
    struct TrapContext trapcontext = app_init_context(start_addr,(uint64_t)get_user_stack_top(app_manager.current_app));
    8020477a:	00816797          	auipc	a5,0x816
    8020477e:	2ee78793          	addi	a5,a5,750 # 80a1aa68 <app_manager>
    80204782:	679c                	ld	a5,8(a5)
    80204784:	853e                	mv	a0,a5
    80204786:	188000ef          	jal	ra,8020490e <get_user_stack_top>
    8020478a:	872a                	mv	a4,a0
    8020478c:	ec040793          	addi	a5,s0,-320
    80204790:	863a                	mv	a2,a4
    80204792:	fd843583          	ld	a1,-40(s0)
    80204796:	853e                	mv	a0,a5
    80204798:	262000ef          	jal	ra,802049fa <app_init_context>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:65
    uint8_t* cx = Kernelstack_push_TrapContext(trapcontext,app_manager.current_app);
    8020479c:	00816797          	auipc	a5,0x816
    802047a0:	2cc78793          	addi	a5,a5,716 # 80a1aa68 <app_manager>
    802047a4:	6784                	ld	s1,8(a5)
    802047a6:	db040793          	addi	a5,s0,-592
    802047aa:	ec040713          	addi	a4,s0,-320
    802047ae:	11000693          	li	a3,272
    802047b2:	8636                	mv	a2,a3
    802047b4:	85ba                	mv	a1,a4
    802047b6:	853e                	mv	a0,a5
    802047b8:	f33fd0ef          	jal	ra,802026ea <memcpy>
    802047bc:	db040793          	addi	a5,s0,-592
    802047c0:	85a6                	mv	a1,s1
    802047c2:	853e                	mv	a0,a5
    802047c4:	174000ef          	jal	ra,80204938 <Kernelstack_push_TrapContext>
    802047c8:	fca43823          	sd	a0,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:66
    __restore((uint64_t)cx);
    802047cc:	fd043783          	ld	a5,-48(s0)
    802047d0:	853e                	mv	a0,a5
    802047d2:	3cb000ef          	jal	ra,8020539c <__restore>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:67
}
    802047d6:	0001                	nop
    802047d8:	24813083          	ld	ra,584(sp)
    802047dc:	24013403          	ld	s0,576(sp)
    802047e0:	23813483          	ld	s1,568(sp)
    802047e4:	25010113          	addi	sp,sp,592
    802047e8:	8082                	ret

00000000802047ea <load_app_test>:
load_app_test():
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:71


void load_app_test()
{
    802047ea:	715d                	addi	sp,sp,-80
    802047ec:	e486                	sd	ra,72(sp)
    802047ee:	e0a2                	sd	s0,64(sp)
    802047f0:	0880                	addi	s0,sp,80
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:74
      // Assume _num_app and related variables are defined elsewhere in your project
    extern uint64_t _num_app[]; // Assuming this is an array holding app info
    uint64_t num_app = _num_app[0]; // First element holds the number of apps
    802047f2:	00003797          	auipc	a5,0x3
    802047f6:	80e78793          	addi	a5,a5,-2034 # 80207000 <_num_app>
    802047fa:	639c                	ld	a5,0(a5)
    802047fc:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:75
    asm volatile("fence.i");
    80204800:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76
    for (uint64_t i = 0; i < num_app; i++) {
    80204804:	fe043423          	sd	zero,-24(s0)
    80204808:	a0d1                	j	802048cc <load_app_test+0xe2>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:78 (discriminator 3)
        // Calculate the start and end addresses of the app in memory
        uint64_t app_start = _num_app[1 + i * 2];
    8020480a:	fe843783          	ld	a5,-24(s0)
    8020480e:	0786                	slli	a5,a5,0x1
    80204810:	0785                	addi	a5,a5,1
    80204812:	00002717          	auipc	a4,0x2
    80204816:	7ee70713          	addi	a4,a4,2030 # 80207000 <_num_app>
    8020481a:	078e                	slli	a5,a5,0x3
    8020481c:	97ba                	add	a5,a5,a4
    8020481e:	639c                	ld	a5,0(a5)
    80204820:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:79 (discriminator 3)
        uint64_t app_end = _num_app[2 + i * 2];
    80204824:	fe843783          	ld	a5,-24(s0)
    80204828:	0785                	addi	a5,a5,1
    8020482a:	0786                	slli	a5,a5,0x1
    8020482c:	00002717          	auipc	a4,0x2
    80204830:	7d470713          	addi	a4,a4,2004 # 80207000 <_num_app>
    80204834:	078e                	slli	a5,a5,0x3
    80204836:	97ba                	add	a5,a5,a4
    80204838:	639c                	ld	a5,0(a5)
    8020483a:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:80 (discriminator 3)
        uint64_t app_size = app_end - app_start;
    8020483e:	fd043703          	ld	a4,-48(s0)
    80204842:	fd843783          	ld	a5,-40(s0)
    80204846:	40f707b3          	sub	a5,a4,a5
    8020484a:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:81 (discriminator 3)
        const void* src = (const void*)app_start;
    8020484e:	fd843783          	ld	a5,-40(s0)
    80204852:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:82 (discriminator 3)
        void* dst = (void*)(APP_BASE_ADDRESS + 0x20000 * i);
    80204856:	fe843703          	ld	a4,-24(s0)
    8020485a:	6791                	lui	a5,0x4
    8020485c:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    80204860:	97ba                	add	a5,a5,a4
    80204862:	07c6                	slli	a5,a5,0x11
    80204864:	faf43c23          	sd	a5,-72(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:84 (discriminator 3)

        print_str("[Test] Loading app from ");
    80204868:	00002517          	auipc	a0,0x2
    8020486c:	ac850513          	addi	a0,a0,-1336 # 80206330 <rodata_start+0x330>
    80204870:	e50ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:85 (discriminator 3)
        print_uint64(app_start);
    80204874:	fd843503          	ld	a0,-40(s0)
    80204878:	fc6ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:86 (discriminator 3)
        print_str(" to ");
    8020487c:	00002517          	auipc	a0,0x2
    80204880:	ad450513          	addi	a0,a0,-1324 # 80206350 <rodata_start+0x350>
    80204884:	e3cff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:87 (discriminator 3)
        print_uint64(app_end);
    80204888:	fd043503          	ld	a0,-48(s0)
    8020488c:	fb2ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:88 (discriminator 3)
        print_str("\n");
    80204890:	00002517          	auipc	a0,0x2
    80204894:	a2050513          	addi	a0,a0,-1504 # 802062b0 <rodata_start+0x2b0>
    80204898:	e28ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:91 (discriminator 3)

        // Clear the application area and copy the new app into place
        memset_t(dst, 0, 0x20000); // Ensure APP_MAX_SIZE covers the max possible app size
    8020489c:	00020637          	lui	a2,0x20
    802048a0:	4581                	li	a1,0
    802048a2:	fb843503          	ld	a0,-72(s0)
    802048a6:	c77fd0ef          	jal	ra,8020251c <memset_t>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:92 (discriminator 3)
        memcpy_t(dst, src, app_size);
    802048aa:	fc843783          	ld	a5,-56(s0)
    802048ae:	2781                	sext.w	a5,a5
    802048b0:	863e                	mv	a2,a5
    802048b2:	fc043583          	ld	a1,-64(s0)
    802048b6:	fb843503          	ld	a0,-72(s0)
    802048ba:	a9ffd0ef          	jal	ra,80202358 <memcpy_t>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:94 (discriminator 3)
        // Instruction synchronization barrier to ensure all instructions are executed correctly
        __asm__ volatile ("fence.i");
    802048be:	0000100f          	fence.i
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76 (discriminator 3)
    for (uint64_t i = 0; i < num_app; i++) {
    802048c2:	fe843783          	ld	a5,-24(s0)
    802048c6:	0785                	addi	a5,a5,1
    802048c8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:76 (discriminator 1)
    802048cc:	fe843703          	ld	a4,-24(s0)
    802048d0:	fe043783          	ld	a5,-32(s0)
    802048d4:	f2f76be3          	bltu	a4,a5,8020480a <load_app_test+0x20>
/home/caigoubencai/Desktop/os_c/kernel/batch/batch.c:96
    }
    802048d8:	0001                	nop
    802048da:	0001                	nop
    802048dc:	60a6                	ld	ra,72(sp)
    802048de:	6406                	ld	s0,64(sp)
    802048e0:	6161                	addi	sp,sp,80
    802048e2:	8082                	ret

00000000802048e4 <get_kernel_stack_top>:
get_kernel_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:13
uint8_t Trap_Stack[1024];
uint8_t UserStack[MAX_APP_NUM][USER_STACK_SIZE];
uint8_t Kernelstack[MAX_APP_NUM][KERNEL_STACK_SIZE];


uint64_t get_kernel_stack_top( uint64_t app_id ) {
    802048e4:	1101                	addi	sp,sp,-32
    802048e6:	ec22                	sd	s0,24(sp)
    802048e8:	1000                	addi	s0,sp,32
    802048ea:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:14
    return (uint64_t)(Kernelstack[app_id]) + KERNEL_STACK_SIZE;
    802048ee:	fe843783          	ld	a5,-24(s0)
    802048f2:	00d79713          	slli	a4,a5,0xd
    802048f6:	0083e797          	auipc	a5,0x83e
    802048fa:	6c278793          	addi	a5,a5,1730 # 80a42fb8 <Kernelstack>
    802048fe:	97ba                	add	a5,a5,a4
    80204900:	873e                	mv	a4,a5
    80204902:	6789                	lui	a5,0x2
    80204904:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:15
}
    80204906:	853e                	mv	a0,a5
    80204908:	6462                	ld	s0,24(sp)
    8020490a:	6105                	addi	sp,sp,32
    8020490c:	8082                	ret

000000008020490e <get_user_stack_top>:
get_user_stack_top():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:18


uint64_t get_user_stack_top( uint64_t app_id ) {
    8020490e:	1101                	addi	sp,sp,-32
    80204910:	ec22                	sd	s0,24(sp)
    80204912:	1000                	addi	s0,sp,32
    80204914:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:19
    return (uint64_t)(UserStack[app_id]) + USER_STACK_SIZE;
    80204918:	fe843783          	ld	a5,-24(s0)
    8020491c:	00d79713          	slli	a4,a5,0xd
    80204920:	00816797          	auipc	a5,0x816
    80204924:	69878793          	addi	a5,a5,1688 # 80a1afb8 <UserStack>
    80204928:	97ba                	add	a5,a5,a4
    8020492a:	873e                	mv	a4,a5
    8020492c:	6789                	lui	a5,0x2
    8020492e:	97ba                	add	a5,a5,a4
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:20
}
    80204930:	853e                	mv	a0,a5
    80204932:	6462                	ld	s0,24(sp)
    80204934:	6105                	addi	sp,sp,32
    80204936:	8082                	ret

0000000080204938 <Kernelstack_push_TrapContext>:
Kernelstack_push_TrapContext():
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:24


uint8_t* Kernelstack_push_TrapContext(struct TrapContext trapContext,uint64_t task_id) 
{
    80204938:	7179                	addi	sp,sp,-48
    8020493a:	f406                	sd	ra,40(sp)
    8020493c:	f022                	sd	s0,32(sp)
    8020493e:	1800                	addi	s0,sp,48
    80204940:	80aa                	mv	ra,a0
    80204942:	fcb43c23          	sd	a1,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:25
    uint8_t* stackTop = Kernelstack[task_id] + KERNEL_STACK_SIZE; // 指向栈顶
    80204946:	fd843783          	ld	a5,-40(s0)
    8020494a:	00d79713          	slli	a4,a5,0xd
    8020494e:	0083e797          	auipc	a5,0x83e
    80204952:	66a78793          	addi	a5,a5,1642 # 80a42fb8 <Kernelstack>
    80204956:	973e                	add	a4,a4,a5
    80204958:	6789                	lui	a5,0x2
    8020495a:	97ba                	add	a5,a5,a4
    8020495c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:26
    stackTop -= sizeof(struct TrapContext); // 为TrapContext腾出空间
    80204960:	fe843783          	ld	a5,-24(s0)
    80204964:	ef078793          	addi	a5,a5,-272 # 1ef0 <n+0x1ed0>
    80204968:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:27
    *((struct TrapContext*)stackTop) = trapContext; // 复制TrapContext到栈顶
    8020496c:	fe843783          	ld	a5,-24(s0)
    80204970:	873e                	mv	a4,a5
    80204972:	8686                	mv	a3,ra
    80204974:	11000793          	li	a5,272
    80204978:	863e                	mv	a2,a5
    8020497a:	85b6                	mv	a1,a3
    8020497c:	853a                	mv	a0,a4
    8020497e:	d6dfd0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:28
    return stackTop; // 返回新的栈顶地址
    80204982:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/stack/stack.c:29
    80204986:	853e                	mv	a0,a5
    80204988:	70a2                	ld	ra,40(sp)
    8020498a:	7402                	ld	s0,32(sp)
    8020498c:	6145                	addi	sp,sp,48
    8020498e:	8082                	ret

0000000080204990 <set_sstatus_spp_user>:
set_sstatus_spp_user():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:5
// TrapContext.c
#include "stdint.h"
#include "context.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    80204990:	7179                	addi	sp,sp,-48
    80204992:	f422                	sd	s0,40(sp)
    80204994:	1800                	addi	s0,sp,48
    80204996:	fca43c23          	sd	a0,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:6
    uint64_t mask = 1UL << 8;
    8020499a:	10000793          	li	a5,256
    8020499e:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:7
    *sstatus &= ~mask;
    802049a2:	fd843783          	ld	a5,-40(s0)
    802049a6:	6398                	ld	a4,0(a5)
    802049a8:	fe843783          	ld	a5,-24(s0)
    802049ac:	fff7c793          	not	a5,a5
    802049b0:	8f7d                	and	a4,a4,a5
    802049b2:	fd843783          	ld	a5,-40(s0)
    802049b6:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:8
}
    802049b8:	0001                	nop
    802049ba:	7422                	ld	s0,40(sp)
    802049bc:	6145                	addi	sp,sp,48
    802049be:	8082                	ret

00000000802049c0 <read_sstatus>:
read_sstatus():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:11

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    802049c0:	1101                	addi	sp,sp,-32
    802049c2:	ec22                	sd	s0,24(sp)
    802049c4:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:12
    return READ_CSR(sstatus);
    802049c6:	100027f3          	csrr	a5,sstatus
    802049ca:	fef43423          	sd	a5,-24(s0)
    802049ce:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:13
}
    802049d2:	853e                	mv	a0,a5
    802049d4:	6462                	ld	s0,24(sp)
    802049d6:	6105                	addi	sp,sp,32
    802049d8:	8082                	ret

00000000802049da <set_sp>:
set_sp():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:16

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    802049da:	1101                	addi	sp,sp,-32
    802049dc:	ec22                	sd	s0,24(sp)
    802049de:	1000                	addi	s0,sp,32
    802049e0:	fea43423          	sd	a0,-24(s0)
    802049e4:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:17
    ctx->x[2] = sp;
    802049e8:	fe843783          	ld	a5,-24(s0)
    802049ec:	fe043703          	ld	a4,-32(s0)
    802049f0:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:18
}
    802049f2:	0001                	nop
    802049f4:	6462                	ld	s0,24(sp)
    802049f6:	6105                	addi	sp,sp,32
    802049f8:	8082                	ret

00000000802049fa <app_init_context>:
app_init_context():
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:22

// 初始化应用程序上下文
struct TrapContext app_init_context(uint64_t entry, uint64_t sp) 
{
    802049fa:	714d                	addi	sp,sp,-336
    802049fc:	e686                	sd	ra,328(sp)
    802049fe:	e2a2                	sd	s0,320(sp)
    80204a00:	0a80                	addi	s0,sp,336
    80204a02:	eca43423          	sd	a0,-312(s0)
    80204a06:	ecb43023          	sd	a1,-320(s0)
    80204a0a:	eac43c23          	sd	a2,-328(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:24
    struct TrapContext ctx;
    uint64_t sstatus = read_sstatus();
    80204a0e:	fb3ff0ef          	jal	ra,802049c0 <read_sstatus>
    80204a12:	87aa                	mv	a5,a0
    80204a14:	ecf43823          	sd	a5,-304(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:25
    set_sstatus_spp_user(&sstatus); // 设置为用户模式
    80204a18:	ed040793          	addi	a5,s0,-304
    80204a1c:	853e                	mv	a0,a5
    80204a1e:	f73ff0ef          	jal	ra,80204990 <set_sstatus_spp_user>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:26
    ctx.sstatus = sstatus;
    80204a22:	ed043783          	ld	a5,-304(s0)
    80204a26:	fcf43c23          	sd	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:27
    ctx.sepc = entry; // 设置入口地址
    80204a2a:	ec043783          	ld	a5,-320(s0)
    80204a2e:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:28
    set_sp(&ctx, sp); // 设置栈指针
    80204a32:	ed840793          	addi	a5,s0,-296
    80204a36:	eb843583          	ld	a1,-328(s0)
    80204a3a:	853e                	mv	a0,a5
    80204a3c:	f9fff0ef          	jal	ra,802049da <set_sp>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30
    //初始化通用寄存器为0
    for(int i = 0; i < 32; i++)
    80204a40:	fe042623          	sw	zero,-20(s0)
    80204a44:	a831                	j	80204a60 <app_init_context+0x66>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:32 (discriminator 3)
    {
        ctx.x[i] = 0;
    80204a46:	fec42783          	lw	a5,-20(s0)
    80204a4a:	078e                	slli	a5,a5,0x3
    80204a4c:	ff040713          	addi	a4,s0,-16
    80204a50:	97ba                	add	a5,a5,a4
    80204a52:	ee07b423          	sd	zero,-280(a5)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30 (discriminator 3)
    for(int i = 0; i < 32; i++)
    80204a56:	fec42783          	lw	a5,-20(s0)
    80204a5a:	2785                	addiw	a5,a5,1
    80204a5c:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:30 (discriminator 1)
    80204a60:	fec42783          	lw	a5,-20(s0)
    80204a64:	0007871b          	sext.w	a4,a5
    80204a68:	47fd                	li	a5,31
    80204a6a:	fce7dee3          	bge	a5,a4,80204a46 <app_init_context+0x4c>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:34
    }
    return ctx;
    80204a6e:	ec843783          	ld	a5,-312(s0)
    80204a72:	86be                	mv	a3,a5
    80204a74:	ed840793          	addi	a5,s0,-296
    80204a78:	11000713          	li	a4,272
    80204a7c:	863a                	mv	a2,a4
    80204a7e:	85be                	mv	a1,a5
    80204a80:	8536                	mv	a0,a3
    80204a82:	c69fd0ef          	jal	ra,802026ea <memcpy>
/home/caigoubencai/Desktop/os_c/kernel/batch/context/context.c:35
}
    80204a86:	ec843503          	ld	a0,-312(s0)
    80204a8a:	60b6                	ld	ra,328(sp)
    80204a8c:	6416                	ld	s0,320(sp)
    80204a8e:	6171                	addi	sp,sp,336
    80204a90:	8082                	ret

0000000080204a92 <print_sepc>:
print_sepc():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:15
#include "task.h"
extern void __alltraps(void);


void print_sepc()
{
    80204a92:	1101                	addi	sp,sp,-32
    80204a94:	ec06                	sd	ra,24(sp)
    80204a96:	e822                	sd	s0,16(sp)
    80204a98:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:16
    print_str("sepc : ");
    80204a9a:	00002517          	auipc	a0,0x2
    80204a9e:	8be50513          	addi	a0,a0,-1858 # 80206358 <rodata_start+0x358>
    80204aa2:	c1eff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:17
    print_uint64(READ_CSR(sepc));
    80204aa6:	141027f3          	csrr	a5,sepc
    80204aaa:	fef43423          	sd	a5,-24(s0)
    80204aae:	fe843783          	ld	a5,-24(s0)
    80204ab2:	853e                	mv	a0,a5
    80204ab4:	d8aff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:18
    print_str("\n");    
    80204ab8:	00002517          	auipc	a0,0x2
    80204abc:	8a850513          	addi	a0,a0,-1880 # 80206360 <rodata_start+0x360>
    80204ac0:	c00ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:19
}
    80204ac4:	0001                	nop
    80204ac6:	60e2                	ld	ra,24(sp)
    80204ac8:	6442                	ld	s0,16(sp)
    80204aca:	6105                	addi	sp,sp,32
    80204acc:	8082                	ret

0000000080204ace <init_interrupt>:
init_interrupt():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:22

void init_interrupt()
{
    80204ace:	7139                	addi	sp,sp,-64
    80204ad0:	fc22                	sd	s0,56(sp)
    80204ad2:	0080                	addi	s0,sp,64
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:24
    //print_str("----init_interrupt----\n");
    uint64_t stvec_value = (uint64_t)(__alltraps);
    80204ad4:	00001797          	auipc	a5,0x1
    80204ad8:	87078793          	addi	a5,a5,-1936 # 80205344 <__alltraps>
    80204adc:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:26
    // WRITE_CSR(stvec,stvec_value);
    asm volatile("csrw stvec, %0" :: "r"(stvec_value));
    80204ae0:	fe843783          	ld	a5,-24(s0)
    80204ae4:	10579073          	csrw	stvec,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:27
    uint64_t mask = 0x202; // 定义启用S模式时钟中断和软件中断的掩码
    80204ae8:	20200793          	li	a5,514
    80204aec:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:28
    WRITE_CSR(sie,mask);
    80204af0:	fe043783          	ld	a5,-32(s0)
    80204af4:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:29
    uint64_t sstatus = READ_CSR(sstatus);
    80204af8:	100027f3          	csrr	a5,sstatus
    80204afc:	fcf43c23          	sd	a5,-40(s0)
    80204b00:	fd843783          	ld	a5,-40(s0)
    80204b04:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:30
    sstatus |= SSTATUS_SIE_BIT;
    80204b08:	fd043783          	ld	a5,-48(s0)
    80204b0c:	0027e793          	ori	a5,a5,2
    80204b10:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:31
    WRITE_CSR(sstatus, sstatus);
    80204b14:	fd043783          	ld	a5,-48(s0)
    80204b18:	10079073          	csrw	sstatus,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:32
    uint64_t sie = READ_CSR(sie);
    80204b1c:	104027f3          	csrr	a5,sie
    80204b20:	fcf43423          	sd	a5,-56(s0)
    80204b24:	fc843783          	ld	a5,-56(s0)
    80204b28:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:33
    sie |= SIE_SSIE_BIT | SIE_STIE_BIT | SIE_SEIE_BIT;
    80204b2c:	fc043783          	ld	a5,-64(s0)
    80204b30:	2227e793          	ori	a5,a5,546
    80204b34:	fcf43023          	sd	a5,-64(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:34
    WRITE_CSR(sie, sie);
    80204b38:	fc043783          	ld	a5,-64(s0)
    80204b3c:	10479073          	csrw	sie,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:35
    WRITE_CSR(sscratch,Trap_Stack);
    80204b40:	00816797          	auipc	a5,0x816
    80204b44:	07878793          	addi	a5,a5,120 # 80a1abb8 <Trap_Stack>
    80204b48:	14079073          	csrw	sscratch,a5
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:36
}
    80204b4c:	0001                	nop
    80204b4e:	7462                	ld	s0,56(sp)
    80204b50:	6121                	addi	sp,sp,64
    80204b52:	8082                	ret

0000000080204b54 <trap_handler>:
trap_handler():
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:39

struct TrapContext* trap_handler(struct TrapContext* cx) 
{
    80204b54:	711d                	addi	sp,sp,-96
    80204b56:	ec86                	sd	ra,88(sp)
    80204b58:	e8a2                	sd	s0,80(sp)
    80204b5a:	1080                	addi	s0,sp,96
    80204b5c:	faa43423          	sd	a0,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:41
    //print_str("trap_handler\n");
    uint64_t scause = READ_CSR(scause);
    80204b60:	142027f3          	csrr	a5,scause
    80204b64:	fcf43c23          	sd	a5,-40(s0)
    80204b68:	fd843783          	ld	a5,-40(s0)
    80204b6c:	fcf43823          	sd	a5,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:44
    //uint64_t stval = READ_CSR(stval);

    switch (scause)
    80204b70:	fd043703          	ld	a4,-48(s0)
    80204b74:	47bd                	li	a5,15
    80204b76:	02e7e963          	bltu	a5,a4,80204ba8 <trap_handler+0x54>
    80204b7a:	fd043703          	ld	a4,-48(s0)
    80204b7e:	47bd                	li	a5,15
    80204b80:	26e7e763          	bltu	a5,a4,80204dee <trap_handler+0x29a>
    80204b84:	fd043783          	ld	a5,-48(s0)
    80204b88:	00279713          	slli	a4,a5,0x2
    80204b8c:	00002797          	auipc	a5,0x2
    80204b90:	9f078793          	addi	a5,a5,-1552 # 8020657c <rodata_start+0x57c>
    80204b94:	97ba                	add	a5,a5,a4
    80204b96:	439c                	lw	a5,0(a5)
    80204b98:	0007871b          	sext.w	a4,a5
    80204b9c:	00002797          	auipc	a5,0x2
    80204ba0:	9e078793          	addi	a5,a5,-1568 # 8020657c <rodata_start+0x57c>
    80204ba4:	97ba                	add	a5,a5,a4
    80204ba6:	8782                	jr	a5
    80204ba8:	fd043703          	ld	a4,-48(s0)
    80204bac:	57fd                	li	a5,-1
    80204bae:	17fe                	slli	a5,a5,0x3f
    80204bb0:	0795                	addi	a5,a5,5
    80204bb2:	22f70b63          	beq	a4,a5,80204de8 <trap_handler+0x294>
    80204bb6:	ac25                	j	80204dee <trap_handler+0x29a>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:47
    {
        case 0x00: // 指令地址错位
            print_str("[kernel] Instruction Address Misaligned.\n");
    80204bb8:	00001517          	auipc	a0,0x1
    80204bbc:	7b050513          	addi	a0,a0,1968 # 80206368 <rodata_start+0x368>
    80204bc0:	b00ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:48
            print_sepc();
    80204bc4:	ecfff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:49
            run_next_task(3);
    80204bc8:	450d                	li	a0,3
    80204bca:	f44ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:50
            break;
    80204bce:	ac2d                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:52
        case 0x01: // 指令访问故障
            print_sepc();
    80204bd0:	ec3ff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:53
            print_str("[kernel] Instruction Access Fault.\n");
    80204bd4:	00001517          	auipc	a0,0x1
    80204bd8:	7c450513          	addi	a0,a0,1988 # 80206398 <rodata_start+0x398>
    80204bdc:	ae4ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:54
            run_next_task(3);
    80204be0:	450d                	li	a0,3
    80204be2:	f2cff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:55
            break;
    80204be6:	a40d                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:57
        case 0x02: // 非法指令
            print_sepc();
    80204be8:	eabff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:58
            print_str("kernel] Illegal Instruction.\n");
    80204bec:	00001517          	auipc	a0,0x1
    80204bf0:	7d450513          	addi	a0,a0,2004 # 802063c0 <rodata_start+0x3c0>
    80204bf4:	accff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:59
            ASSERT(0);
    80204bf8:	03b00593          	li	a1,59
    80204bfc:	00001517          	auipc	a0,0x1
    80204c00:	7e450513          	addi	a0,a0,2020 # 802063e0 <rodata_start+0x3e0>
    80204c04:	d80ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:60
            run_next_task(3);
    80204c08:	450d                	li	a0,3
    80204c0a:	f04ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:61
            break;
    80204c0e:	aaed                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:63
        case 0x03: // 断点
            print_str("[kernel] Breakpoint.\n");
    80204c10:	00001517          	auipc	a0,0x1
    80204c14:	7e850513          	addi	a0,a0,2024 # 802063f8 <rodata_start+0x3f8>
    80204c18:	aa8ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:65
            // 特定的调试处理或直接运行下一个应用
            ASSERT(0);
    80204c1c:	04100593          	li	a1,65
    80204c20:	00001517          	auipc	a0,0x1
    80204c24:	7c050513          	addi	a0,a0,1984 # 802063e0 <rodata_start+0x3e0>
    80204c28:	d5cff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:66
            cx->sepc +=2;
    80204c2c:	fa843783          	ld	a5,-88(s0)
    80204c30:	1087b783          	ld	a5,264(a5)
    80204c34:	00278713          	addi	a4,a5,2
    80204c38:	fa843783          	ld	a5,-88(s0)
    80204c3c:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:67
            ASSERT(0);
    80204c40:	04300593          	li	a1,67
    80204c44:	00001517          	auipc	a0,0x1
    80204c48:	79c50513          	addi	a0,a0,1948 # 802063e0 <rodata_start+0x3e0>
    80204c4c:	d38ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:69
            //run_next_app();
            break;
    80204c50:	aa65                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:71
        case 0x04: // 加载地址错位
            print_str("[kernel] Load Address Misaligned.\n");
    80204c52:	00001517          	auipc	a0,0x1
    80204c56:	7be50513          	addi	a0,a0,1982 # 80206410 <rodata_start+0x410>
    80204c5a:	a66ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:72
            ASSERT(0);
    80204c5e:	04800593          	li	a1,72
    80204c62:	00001517          	auipc	a0,0x1
    80204c66:	77e50513          	addi	a0,a0,1918 # 802063e0 <rodata_start+0x3e0>
    80204c6a:	d1aff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:73
            run_next_task(3);
    80204c6e:	450d                	li	a0,3
    80204c70:	e9eff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:74
            break;
    80204c74:	aa51                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:76
        case 0x05: // 加载访问故障
            print_sepc();
    80204c76:	e1dff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:77
            print_str("[kernel] Load Access Fault.\n");
    80204c7a:	00001517          	auipc	a0,0x1
    80204c7e:	7be50513          	addi	a0,a0,1982 # 80206438 <rodata_start+0x438>
    80204c82:	a3eff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:78
            ASSERT(0);
    80204c86:	04e00593          	li	a1,78
    80204c8a:	00001517          	auipc	a0,0x1
    80204c8e:	75650513          	addi	a0,a0,1878 # 802063e0 <rodata_start+0x3e0>
    80204c92:	cf2ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:79
            run_next_task(3);
    80204c96:	450d                	li	a0,3
    80204c98:	e76ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:80
            break;
    80204c9c:	a2b5                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:82
        case 0x06: // 存储地址错位
            print_sepc();
    80204c9e:	df5ff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:83
            print_str("[kernel] Store/AMO Address Misaligned.\n");
    80204ca2:	00001517          	auipc	a0,0x1
    80204ca6:	7b650513          	addi	a0,a0,1974 # 80206458 <rodata_start+0x458>
    80204caa:	a16ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:84
            ASSERT(0);
    80204cae:	05400593          	li	a1,84
    80204cb2:	00001517          	auipc	a0,0x1
    80204cb6:	72e50513          	addi	a0,a0,1838 # 802063e0 <rodata_start+0x3e0>
    80204cba:	ccaff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:85
            run_next_task(3);
    80204cbe:	450d                	li	a0,3
    80204cc0:	e4eff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:86
            break;
    80204cc4:	a291                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:88
        case 0x07: // 存储/AMO访问故障
            print_str("[kernel] Store/AMO Access Fault.\n");
    80204cc6:	00001517          	auipc	a0,0x1
    80204cca:	7ba50513          	addi	a0,a0,1978 # 80206480 <rodata_start+0x480>
    80204cce:	9f2ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:89
            print_sepc();
    80204cd2:	dc1ff0ef          	jal	ra,80204a92 <print_sepc>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:90
            ASSERT(0);
    80204cd6:	05a00593          	li	a1,90
    80204cda:	00001517          	auipc	a0,0x1
    80204cde:	70650513          	addi	a0,a0,1798 # 802063e0 <rodata_start+0x3e0>
    80204ce2:	ca2ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:91
            uint64_t cnt=10000000000;
    80204ce6:	009507b7          	lui	a5,0x950
    80204cea:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80204cee:	07aa                	slli	a5,a5,0xa
    80204cf0:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:92
            while(cnt--){}
    80204cf4:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:92 (discriminator 1)
    80204cf6:	fe843783          	ld	a5,-24(s0)
    80204cfa:	fff78713          	addi	a4,a5,-1
    80204cfe:	fee43423          	sd	a4,-24(s0)
    80204d02:	fbf5                	bnez	a5,80204cf6 <trap_handler+0x1a2>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:94
            //run_next_app();
            break;
    80204d04:	a211                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:96
        case 0x08: // 环境调用来自U模式
            cx->sepc += 4; // 跳过环境调用指令
    80204d06:	fa843783          	ld	a5,-88(s0)
    80204d0a:	1087b783          	ld	a5,264(a5)
    80204d0e:	00478713          	addi	a4,a5,4
    80204d12:	fa843783          	ld	a5,-88(s0)
    80204d16:	10e7b423          	sd	a4,264(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:97
            uint64_t args[3] = {cx->x[10], cx->x[11], cx->x[12]};
    80204d1a:	fa843783          	ld	a5,-88(s0)
    80204d1e:	6bbc                	ld	a5,80(a5)
    80204d20:	faf43c23          	sd	a5,-72(s0)
    80204d24:	fa843783          	ld	a5,-88(s0)
    80204d28:	6fbc                	ld	a5,88(a5)
    80204d2a:	fcf43023          	sd	a5,-64(s0)
    80204d2e:	fa843783          	ld	a5,-88(s0)
    80204d32:	73bc                	ld	a5,96(a5)
    80204d34:	fcf43423          	sd	a5,-56(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:98
            cx->x[10] = syscall(cx->x[17], args); // 执行系统调用
    80204d38:	fa843783          	ld	a5,-88(s0)
    80204d3c:	67dc                	ld	a5,136(a5)
    80204d3e:	fb840713          	addi	a4,s0,-72
    80204d42:	85ba                	mv	a1,a4
    80204d44:	853e                	mv	a0,a5
    80204d46:	1ee000ef          	jal	ra,80204f34 <syscall>
    80204d4a:	87aa                	mv	a5,a0
    80204d4c:	873e                	mv	a4,a5
    80204d4e:	fa843783          	ld	a5,-88(s0)
    80204d52:	ebb8                	sd	a4,80(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:99
            break;
    80204d54:	a855                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:101
        case 0x09: // 环境调用来自S模式
            print_str("[kernel] Environment Call from S-mode.\n");
    80204d56:	00001517          	auipc	a0,0x1
    80204d5a:	75250513          	addi	a0,a0,1874 # 802064a8 <rodata_start+0x4a8>
    80204d5e:	962ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:102
            uint64_t cnt1=10000000000;
    80204d62:	009507b7          	lui	a5,0x950
    80204d66:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80204d6a:	07aa                	slli	a5,a5,0xa
    80204d6c:	fef43023          	sd	a5,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:103
            while(cnt1--){}
    80204d70:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:103 (discriminator 1)
    80204d72:	fe043783          	ld	a5,-32(s0)
    80204d76:	fff78713          	addi	a4,a5,-1
    80204d7a:	fee43023          	sd	a4,-32(s0)
    80204d7e:	fbf5                	bnez	a5,80204d72 <trap_handler+0x21e>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:104 (discriminator 1)
            ASSERT(0);
    80204d80:	06800593          	li	a1,104
    80204d84:	00001517          	auipc	a0,0x1
    80204d88:	65c50513          	addi	a0,a0,1628 # 802063e0 <rodata_start+0x3e0>
    80204d8c:	bf8ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:105 (discriminator 1)
            run_next_task(3);
    80204d90:	450d                	li	a0,3
    80204d92:	d7cff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:106 (discriminator 1)
            break;
    80204d96:	a88d                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:108
        case 0x0B: // 环境调用来自M模式
            print_str("[kernel] Environment Call from M-mode.\n");
    80204d98:	00001517          	auipc	a0,0x1
    80204d9c:	73850513          	addi	a0,a0,1848 # 802064d0 <rodata_start+0x4d0>
    80204da0:	920ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:110
            // 处理或运行下一个应用
            run_next_task(3);
    80204da4:	450d                	li	a0,3
    80204da6:	d68ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:111
            break;
    80204daa:	a8b9                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:113
        case 0x0C: // 指令页面错误
            print_str("[kernel] Instruction Page Fault.\n");
    80204dac:	00001517          	auipc	a0,0x1
    80204db0:	74c50513          	addi	a0,a0,1868 # 802064f8 <rodata_start+0x4f8>
    80204db4:	90cff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:114
            run_next_task(3);
    80204db8:	450d                	li	a0,3
    80204dba:	d54ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:115
            break;
    80204dbe:	a0a9                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:117
        case 0x0D: // 加载页面错误
            print_str("[kernel] Load Page Fault.\n");
    80204dc0:	00001517          	auipc	a0,0x1
    80204dc4:	76050513          	addi	a0,a0,1888 # 80206520 <rodata_start+0x520>
    80204dc8:	8f8ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:118
            run_next_task(3);
    80204dcc:	450d                	li	a0,3
    80204dce:	d40ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:119
            break;
    80204dd2:	a81d                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:121
        case 0x0F: // 存储页面错误
            print_str("[kernel] Store/AMO Page Fault.\n");
    80204dd4:	00001517          	auipc	a0,0x1
    80204dd8:	76c50513          	addi	a0,a0,1900 # 80206540 <rodata_start+0x540>
    80204ddc:	8e4ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:122
            run_next_task(3);
    80204de0:	450d                	li	a0,3
    80204de2:	d2cff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:123
            break;
    80204de6:	a00d                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:126
        case 0x8000000000000005: 
            //print_str("intr_timer_handle\n");
            intr_timer_handle();
    80204de8:	268000ef          	jal	ra,80205050 <intr_timer_handle>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:127
            break;
    80204dec:	a831                	j	80204e08 <trap_handler+0x2b4>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:129
        default:
            print_str("[kernel] Unsupported trap.\n");
    80204dee:	00001517          	auipc	a0,0x1
    80204df2:	77250513          	addi	a0,a0,1906 # 80206560 <rodata_start+0x560>
    80204df6:	8caff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:130
            print_uint64(scause);
    80204dfa:	fd043503          	ld	a0,-48(s0)
    80204dfe:	a40ff0ef          	jal	ra,8020403e <print_uint64>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:131
            exit(1);
    80204e02:	4505                	li	a0,1
    80204e04:	012000ef          	jal	ra,80204e16 <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:133
    }
    return cx;
    80204e08:	fa843783          	ld	a5,-88(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/trap.c:134
    80204e0c:	853e                	mv	a0,a5
    80204e0e:	60e6                	ld	ra,88(sp)
    80204e10:	6446                	ld	s0,80(sp)
    80204e12:	6125                	addi	sp,sp,96
    80204e14:	8082                	ret

0000000080204e16 <exit>:
exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:10
#include "debug.h"
#include "task.h"


int32_t exit(int32_t value)
{
    80204e16:	1101                	addi	sp,sp,-32
    80204e18:	ec06                	sd	ra,24(sp)
    80204e1a:	e822                	sd	s0,16(sp)
    80204e1c:	1000                	addi	s0,sp,32
    80204e1e:	87aa                	mv	a5,a0
    80204e20:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:11
    print_str("exit : ");
    80204e24:	00001517          	auipc	a0,0x1
    80204e28:	79c50513          	addi	a0,a0,1948 # 802065c0 <rodata_start+0x5c0>
    80204e2c:	894ff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:12
    print_uint32((uint32_t)value);
    80204e30:	fec42783          	lw	a5,-20(s0)
    80204e34:	853e                	mv	a0,a5
    80204e36:	954ff0ef          	jal	ra,80203f8a <print_uint32>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:13
    print_str("\n");
    80204e3a:	00001517          	auipc	a0,0x1
    80204e3e:	78e50513          	addi	a0,a0,1934 # 802065c8 <rodata_start+0x5c8>
    80204e42:	87eff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:14
    return value;
    80204e46:	fec42783          	lw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:15
}
    80204e4a:	853e                	mv	a0,a5
    80204e4c:	60e2                	ld	ra,24(sp)
    80204e4e:	6442                	ld	s0,16(sp)
    80204e50:	6105                	addi	sp,sp,32
    80204e52:	8082                	ret

0000000080204e54 <write>:
write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:18

int64_t write(uint64_t fd, const void *buf, uint64_t count)
{
    80204e54:	7179                	addi	sp,sp,-48
    80204e56:	f406                	sd	ra,40(sp)
    80204e58:	f022                	sd	s0,32(sp)
    80204e5a:	1800                	addi	s0,sp,48
    80204e5c:	fea43423          	sd	a0,-24(s0)
    80204e60:	feb43023          	sd	a1,-32(s0)
    80204e64:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:19
    if(fd==1)
    80204e68:	fe843703          	ld	a4,-24(s0)
    80204e6c:	4785                	li	a5,1
    80204e6e:	00f71d63          	bne	a4,a5,80204e88 <write+0x34>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:22
    {
        buf = (char*) buf;
        print_str(buf);
    80204e72:	fe043503          	ld	a0,-32(s0)
    80204e76:	84aff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:23
        print_str("\n");
    80204e7a:	00001517          	auipc	a0,0x1
    80204e7e:	74e50513          	addi	a0,a0,1870 # 802065c8 <rodata_start+0x5c8>
    80204e82:	83eff0ef          	jal	ra,80203ec0 <print_str>
    80204e86:	a801                	j	80204e96 <write+0x42>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:26 (discriminator 1)
    }else 
    {
        ASSERT(0);
    80204e88:	45e9                	li	a1,26
    80204e8a:	00001517          	auipc	a0,0x1
    80204e8e:	74650513          	addi	a0,a0,1862 # 802065d0 <rodata_start+0x5d0>
    80204e92:	af2ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:28
    }
    return count;
    80204e96:	fd843783          	ld	a5,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:29
}
    80204e9a:	853e                	mv	a0,a5
    80204e9c:	70a2                	ld	ra,40(sp)
    80204e9e:	7402                	ld	s0,32(sp)
    80204ea0:	6145                	addi	sp,sp,48
    80204ea2:	8082                	ret

0000000080204ea4 <yield>:
yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:32

int64_t yield()
{
    80204ea4:	1141                	addi	sp,sp,-16
    80204ea6:	e406                	sd	ra,8(sp)
    80204ea8:	e022                	sd	s0,0(sp)
    80204eaa:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:33
    print_str("\n-------yield------\n");
    80204eac:	00001517          	auipc	a0,0x1
    80204eb0:	74450513          	addi	a0,a0,1860 # 802065f0 <rodata_start+0x5f0>
    80204eb4:	80cff0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:34
    run_next_task(1);
    80204eb8:	4505                	li	a0,1
    80204eba:	c54ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:35
    return 1;
    80204ebe:	4785                	li	a5,1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:36
}
    80204ec0:	853e                	mv	a0,a5
    80204ec2:	60a2                	ld	ra,8(sp)
    80204ec4:	6402                	ld	s0,0(sp)
    80204ec6:	0141                	addi	sp,sp,16
    80204ec8:	8082                	ret

0000000080204eca <sys_write>:
sys_write():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:39

int64_t sys_write(uint64_t fd, const void *buf, uint64_t count) 
{
    80204eca:	7179                	addi	sp,sp,-48
    80204ecc:	f406                	sd	ra,40(sp)
    80204ece:	f022                	sd	s0,32(sp)
    80204ed0:	1800                	addi	s0,sp,48
    80204ed2:	fea43423          	sd	a0,-24(s0)
    80204ed6:	feb43023          	sd	a1,-32(s0)
    80204eda:	fcc43c23          	sd	a2,-40(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:40
    return write(fd, buf, count); // 使用POSIX write
    80204ede:	fd843603          	ld	a2,-40(s0)
    80204ee2:	fe043583          	ld	a1,-32(s0)
    80204ee6:	fe843503          	ld	a0,-24(s0)
    80204eea:	f6bff0ef          	jal	ra,80204e54 <write>
    80204eee:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:41
}
    80204ef0:	853e                	mv	a0,a5
    80204ef2:	70a2                	ld	ra,40(sp)
    80204ef4:	7402                	ld	s0,32(sp)
    80204ef6:	6145                	addi	sp,sp,48
    80204ef8:	8082                	ret

0000000080204efa <sys_exit>:
sys_exit():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:44

void sys_exit(int32_t status) 
{
    80204efa:	1101                	addi	sp,sp,-32
    80204efc:	ec06                	sd	ra,24(sp)
    80204efe:	e822                	sd	s0,16(sp)
    80204f00:	1000                	addi	s0,sp,32
    80204f02:	87aa                	mv	a5,a0
    80204f04:	fef42623          	sw	a5,-20(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:45
    exit(status);
    80204f08:	fec42783          	lw	a5,-20(s0)
    80204f0c:	853e                	mv	a0,a5
    80204f0e:	f09ff0ef          	jal	ra,80204e16 <exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:46
}
    80204f12:	0001                	nop
    80204f14:	60e2                	ld	ra,24(sp)
    80204f16:	6442                	ld	s0,16(sp)
    80204f18:	6105                	addi	sp,sp,32
    80204f1a:	8082                	ret

0000000080204f1c <sys_yield>:
sys_yield():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:49

int64_t sys_yield()
{
    80204f1c:	1141                	addi	sp,sp,-16
    80204f1e:	e406                	sd	ra,8(sp)
    80204f20:	e022                	sd	s0,0(sp)
    80204f22:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:50
    return yield();
    80204f24:	f81ff0ef          	jal	ra,80204ea4 <yield>
    80204f28:	87aa                	mv	a5,a0
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:51
}
    80204f2a:	853e                	mv	a0,a5
    80204f2c:	60a2                	ld	ra,8(sp)
    80204f2e:	6402                	ld	s0,0(sp)
    80204f30:	0141                	addi	sp,sp,16
    80204f32:	8082                	ret

0000000080204f34 <syscall>:
syscall():
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:55

// 系统调用处理函数
int64_t syscall(uint64_t syscall_id, uint64_t args[3]) 
{
    80204f34:	1101                	addi	sp,sp,-32
    80204f36:	ec06                	sd	ra,24(sp)
    80204f38:	e822                	sd	s0,16(sp)
    80204f3a:	1000                	addi	s0,sp,32
    80204f3c:	fea43423          	sd	a0,-24(s0)
    80204f40:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:56
    switch (syscall_id)
    80204f44:	fe843703          	ld	a4,-24(s0)
    80204f48:	07c00793          	li	a5,124
    80204f4c:	06f70163          	beq	a4,a5,80204fae <syscall+0x7a>
    80204f50:	fe843703          	ld	a4,-24(s0)
    80204f54:	07c00793          	li	a5,124
    80204f58:	04e7ef63          	bltu	a5,a4,80204fb6 <syscall+0x82>
    80204f5c:	fe843703          	ld	a4,-24(s0)
    80204f60:	04000793          	li	a5,64
    80204f64:	00f70963          	beq	a4,a5,80204f76 <syscall+0x42>
    80204f68:	fe843703          	ld	a4,-24(s0)
    80204f6c:	05d00793          	li	a5,93
    80204f70:	02f70663          	beq	a4,a5,80204f9c <syscall+0x68>
    80204f74:	a089                	j	80204fb6 <syscall+0x82>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:60
    {
        case SYSCALL_WRITE:
            //print_str("------sys_write-----\n");
            return sys_write(args[0], (const void*)args[1], args[2]);
    80204f76:	fe043783          	ld	a5,-32(s0)
    80204f7a:	6398                	ld	a4,0(a5)
    80204f7c:	fe043783          	ld	a5,-32(s0)
    80204f80:	07a1                	addi	a5,a5,8
    80204f82:	639c                	ld	a5,0(a5)
    80204f84:	86be                	mv	a3,a5
    80204f86:	fe043783          	ld	a5,-32(s0)
    80204f8a:	07c1                	addi	a5,a5,16
    80204f8c:	639c                	ld	a5,0(a5)
    80204f8e:	863e                	mv	a2,a5
    80204f90:	85b6                	mv	a1,a3
    80204f92:	853a                	mv	a0,a4
    80204f94:	f37ff0ef          	jal	ra,80204eca <sys_write>
    80204f98:	87aa                	mv	a5,a0
    80204f9a:	a0a9                	j	80204fe4 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:62
        case SYSCALL_EXIT:
            sys_exit((int)args[0]);
    80204f9c:	fe043783          	ld	a5,-32(s0)
    80204fa0:	639c                	ld	a5,0(a5)
    80204fa2:	2781                	sext.w	a5,a5
    80204fa4:	853e                	mv	a0,a5
    80204fa6:	f55ff0ef          	jal	ra,80204efa <sys_exit>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:63
            return 0;
    80204faa:	4781                	li	a5,0
    80204fac:	a825                	j	80204fe4 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:66
        case SYSCALL_YIELD:
            //print_str("----sys_yield----\n");
            return sys_yield();
    80204fae:	f6fff0ef          	jal	ra,80204f1c <sys_yield>
    80204fb2:	87aa                	mv	a5,a0
    80204fb4:	a805                	j	80204fe4 <syscall+0xb0>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:68
        default:
            print_str("unsupportable syscall_id\n");
    80204fb6:	00001517          	auipc	a0,0x1
    80204fba:	65250513          	addi	a0,a0,1618 # 80206608 <rodata_start+0x608>
    80204fbe:	f03fe0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:69
            ASSERT(0);
    80204fc2:	04500593          	li	a1,69
    80204fc6:	00001517          	auipc	a0,0x1
    80204fca:	60a50513          	addi	a0,a0,1546 # 802065d0 <rodata_start+0x5d0>
    80204fce:	9b6ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:71
    }
    ASSERT(0);
    80204fd2:	04700593          	li	a1,71
    80204fd6:	00001517          	auipc	a0,0x1
    80204fda:	5fa50513          	addi	a0,a0,1530 # 802065d0 <rodata_start+0x5d0>
    80204fde:	9a6ff0ef          	jal	ra,80204184 <panic>
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:72
    return -1;
    80204fe2:	57fd                	li	a5,-1
/home/caigoubencai/Desktop/os_c/kernel/trap/syscall/syscall.c:73
}
    80204fe4:	853e                	mv	a0,a5
    80204fe6:	60e2                	ld	ra,24(sp)
    80204fe8:	6442                	ld	s0,16(sp)
    80204fea:	6105                	addi	sp,sp,32
    80204fec:	8082                	ret

0000000080204fee <read_time>:
read_time():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:5
#include "timer.h"
#include "sbi.h"
#include "task.h"
static inline uint64_t read_time(void) 
{
    80204fee:	1101                	addi	sp,sp,-32
    80204ff0:	ec22                	sd	s0,24(sp)
    80204ff2:	1000                	addi	s0,sp,32
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:7
    uint64_t time;
    __asm__ volatile ("csrr %0, time" : "=r"(time));
    80204ff4:	c01027f3          	rdtime	a5
    80204ff8:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:8
    return time;
    80204ffc:	fe843783          	ld	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:9
}
    80205000:	853e                	mv	a0,a5
    80205002:	6462                	ld	s0,24(sp)
    80205004:	6105                	addi	sp,sp,32
    80205006:	8082                	ret

0000000080205008 <clock_set_next_event>:
clock_set_next_event():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:12

void clock_set_next_event() 
{
    80205008:	1141                	addi	sp,sp,-16
    8020500a:	e406                	sd	ra,8(sp)
    8020500c:	e022                	sd	s0,0(sp)
    8020500e:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:13
    sbi_set_timer(read_time() + TIMEBASE);
    80205010:	fdfff0ef          	jal	ra,80204fee <read_time>
    80205014:	872a                	mv	a4,a0
    80205016:	67e1                	lui	a5,0x18
    80205018:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    8020501c:	97ba                	add	a5,a5,a4
    8020501e:	853e                	mv	a0,a5
    80205020:	adafd0ef          	jal	ra,802022fa <sbi_set_timer>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:14
}
    80205024:	0001                	nop
    80205026:	60a2                	ld	ra,8(sp)
    80205028:	6402                	ld	s0,0(sp)
    8020502a:	0141                	addi	sp,sp,16
    8020502c:	8082                	ret

000000008020502e <timer_init>:
timer_init():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:18


void timer_init()
{
    8020502e:	1141                	addi	sp,sp,-16
    80205030:	e406                	sd	ra,8(sp)
    80205032:	e022                	sd	s0,0(sp)
    80205034:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:19
    clock_set_next_event();
    80205036:	fd3ff0ef          	jal	ra,80205008 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:20
    print_str("----timer_init----\n");
    8020503a:	00001517          	auipc	a0,0x1
    8020503e:	5ee50513          	addi	a0,a0,1518 # 80206628 <rodata_start+0x628>
    80205042:	e7ffe0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:21
}
    80205046:	0001                	nop
    80205048:	60a2                	ld	ra,8(sp)
    8020504a:	6402                	ld	s0,0(sp)
    8020504c:	0141                	addi	sp,sp,16
    8020504e:	8082                	ret

0000000080205050 <intr_timer_handle>:
intr_timer_handle():
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:25


void intr_timer_handle()
{
    80205050:	1141                	addi	sp,sp,-16
    80205052:	e406                	sd	ra,8(sp)
    80205054:	e022                	sd	s0,0(sp)
    80205056:	0800                	addi	s0,sp,16
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:26
    run_next_task(1);
    80205058:	4505                	li	a0,1
    8020505a:	ab4ff0ef          	jal	ra,8020430e <run_next_task>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:27
    ticks++;
    8020505e:	00866797          	auipc	a5,0x866
    80205062:	f6278793          	addi	a5,a5,-158 # 80a6afc0 <ticks>
    80205066:	639c                	ld	a5,0(a5)
    80205068:	00178713          	addi	a4,a5,1
    8020506c:	00866797          	auipc	a5,0x866
    80205070:	f5478793          	addi	a5,a5,-172 # 80a6afc0 <ticks>
    80205074:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:28
    clock_set_next_event();
    80205076:	f93ff0ef          	jal	ra,80205008 <clock_set_next_event>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:29
    if(ticks % 10 == 0)
    8020507a:	00866797          	auipc	a5,0x866
    8020507e:	f4678793          	addi	a5,a5,-186 # 80a6afc0 <ticks>
    80205082:	6398                	ld	a4,0(a5)
    80205084:	47a9                	li	a5,10
    80205086:	02f777b3          	remu	a5,a4,a5
    8020508a:	e799                	bnez	a5,80205098 <intr_timer_handle+0x48>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:31
    {
        print_str("timer_interrupt\n");
    8020508c:	00001517          	auipc	a0,0x1
    80205090:	5b450513          	addi	a0,a0,1460 # 80206640 <rodata_start+0x640>
    80205094:	e2dfe0ef          	jal	ra,80203ec0 <print_str>
/home/caigoubencai/Desktop/os_c/kernel/trap/timer/timer.c:39
    // {
    //     print_str("timer interrupt: ");
    //     print_uint32(ticks);
    //     print_str("\n");
    // }else if(ticks==200) ticks=0;
    80205098:	0001                	nop
    8020509a:	60a2                	ld	ra,8(sp)
    8020509c:	6402                	ld	s0,0(sp)
    8020509e:	0141                	addi	sp,sp,16
    802050a0:	8082                	ret

00000000802050a2 <vector_init>:
vector_init():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:3
#include "vector.h"
#include "stdint.h"
void vector_init(Vector *v) {
    802050a2:	1101                	addi	sp,sp,-32
    802050a4:	ec06                	sd	ra,24(sp)
    802050a6:	e822                	sd	s0,16(sp)
    802050a8:	1000                	addi	s0,sp,32
    802050aa:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:4
    v->capacity = 4;
    802050ae:	fe843783          	ld	a5,-24(s0)
    802050b2:	4711                	li	a4,4
    802050b4:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:5
    v->total = 0;
    802050b6:	fe843783          	ld	a5,-24(s0)
    802050ba:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:6
    v->items = malloc(sizeof(void*) * v->capacity);
    802050be:	fe843783          	ld	a5,-24(s0)
    802050c2:	679c                	ld	a5,8(a5)
    802050c4:	078e                	slli	a5,a5,0x3
    802050c6:	853e                	mv	a0,a5
    802050c8:	fb6fd0ef          	jal	ra,8020287e <malloc>
    802050cc:	872a                	mv	a4,a0
    802050ce:	fe843783          	ld	a5,-24(s0)
    802050d2:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:7
}
    802050d4:	0001                	nop
    802050d6:	60e2                	ld	ra,24(sp)
    802050d8:	6442                	ld	s0,16(sp)
    802050da:	6105                	addi	sp,sp,32
    802050dc:	8082                	ret

00000000802050de <vector_total>:
vector_total():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:9

size_t vector_total(Vector *v) {
    802050de:	1101                	addi	sp,sp,-32
    802050e0:	ec22                	sd	s0,24(sp)
    802050e2:	1000                	addi	s0,sp,32
    802050e4:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:10
    return v->total;
    802050e8:	fe843783          	ld	a5,-24(s0)
    802050ec:	6b9c                	ld	a5,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:11
}
    802050ee:	853e                	mv	a0,a5
    802050f0:	6462                	ld	s0,24(sp)
    802050f2:	6105                	addi	sp,sp,32
    802050f4:	8082                	ret

00000000802050f6 <vector_resize>:
vector_resize():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:13

void vector_resize(Vector *v, size_t capacity) {
    802050f6:	7179                	addi	sp,sp,-48
    802050f8:	f406                	sd	ra,40(sp)
    802050fa:	f022                	sd	s0,32(sp)
    802050fc:	1800                	addi	s0,sp,48
    802050fe:	fca43c23          	sd	a0,-40(s0)
    80205102:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:14
    void **items = realloc(v->items, sizeof(void*) * capacity);
    80205106:	fd843783          	ld	a5,-40(s0)
    8020510a:	6398                	ld	a4,0(a5)
    8020510c:	fd043783          	ld	a5,-48(s0)
    80205110:	078e                	slli	a5,a5,0x3
    80205112:	85be                	mv	a1,a5
    80205114:	853a                	mv	a0,a4
    80205116:	8ddfd0ef          	jal	ra,802029f2 <realloc>
    8020511a:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:15
    if (items) {
    8020511e:	fe843783          	ld	a5,-24(s0)
    80205122:	cb99                	beqz	a5,80205138 <vector_resize+0x42>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:16
        v->items = items;
    80205124:	fd843783          	ld	a5,-40(s0)
    80205128:	fe843703          	ld	a4,-24(s0)
    8020512c:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:17
        v->capacity = capacity;
    8020512e:	fd843783          	ld	a5,-40(s0)
    80205132:	fd043703          	ld	a4,-48(s0)
    80205136:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:19
    }
}
    80205138:	0001                	nop
    8020513a:	70a2                	ld	ra,40(sp)
    8020513c:	7402                	ld	s0,32(sp)
    8020513e:	6145                	addi	sp,sp,48
    80205140:	8082                	ret

0000000080205142 <vector_add>:
vector_add():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:21

void vector_add(Vector *v, void *item) {
    80205142:	1101                	addi	sp,sp,-32
    80205144:	ec06                	sd	ra,24(sp)
    80205146:	e822                	sd	s0,16(sp)
    80205148:	1000                	addi	s0,sp,32
    8020514a:	fea43423          	sd	a0,-24(s0)
    8020514e:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:22
    if (v->capacity == v->total) {
    80205152:	fe843783          	ld	a5,-24(s0)
    80205156:	6798                	ld	a4,8(a5)
    80205158:	fe843783          	ld	a5,-24(s0)
    8020515c:	6b9c                	ld	a5,16(a5)
    8020515e:	00f71b63          	bne	a4,a5,80205174 <vector_add+0x32>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:23
        vector_resize(v, v->capacity * 2);
    80205162:	fe843783          	ld	a5,-24(s0)
    80205166:	679c                	ld	a5,8(a5)
    80205168:	0786                	slli	a5,a5,0x1
    8020516a:	85be                	mv	a1,a5
    8020516c:	fe843503          	ld	a0,-24(s0)
    80205170:	f87ff0ef          	jal	ra,802050f6 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:25
    }
    v->items[v->total++] = item;
    80205174:	fe843783          	ld	a5,-24(s0)
    80205178:	6398                	ld	a4,0(a5)
    8020517a:	fe843783          	ld	a5,-24(s0)
    8020517e:	6b9c                	ld	a5,16(a5)
    80205180:	00178613          	addi	a2,a5,1
    80205184:	fe843683          	ld	a3,-24(s0)
    80205188:	ea90                	sd	a2,16(a3)
    8020518a:	078e                	slli	a5,a5,0x3
    8020518c:	97ba                	add	a5,a5,a4
    8020518e:	fe043703          	ld	a4,-32(s0)
    80205192:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:26
}
    80205194:	0001                	nop
    80205196:	60e2                	ld	ra,24(sp)
    80205198:	6442                	ld	s0,16(sp)
    8020519a:	6105                	addi	sp,sp,32
    8020519c:	8082                	ret

000000008020519e <vector_get>:
vector_get():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:28

void *vector_get(Vector *v, size_t index) {
    8020519e:	1101                	addi	sp,sp,-32
    802051a0:	ec22                	sd	s0,24(sp)
    802051a2:	1000                	addi	s0,sp,32
    802051a4:	fea43423          	sd	a0,-24(s0)
    802051a8:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:29
    if (index < v->total) {
    802051ac:	fe843783          	ld	a5,-24(s0)
    802051b0:	6b9c                	ld	a5,16(a5)
    802051b2:	fe043703          	ld	a4,-32(s0)
    802051b6:	00f77b63          	bgeu	a4,a5,802051cc <vector_get+0x2e>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:30
        return v->items[index];
    802051ba:	fe843783          	ld	a5,-24(s0)
    802051be:	6398                	ld	a4,0(a5)
    802051c0:	fe043783          	ld	a5,-32(s0)
    802051c4:	078e                	slli	a5,a5,0x3
    802051c6:	97ba                	add	a5,a5,a4
    802051c8:	639c                	ld	a5,0(a5)
    802051ca:	a011                	j	802051ce <vector_get+0x30>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:32
    }
    return NULL;
    802051cc:	4781                	li	a5,0
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:33
}
    802051ce:	853e                	mv	a0,a5
    802051d0:	6462                	ld	s0,24(sp)
    802051d2:	6105                	addi	sp,sp,32
    802051d4:	8082                	ret

00000000802051d6 <vector_delete>:
vector_delete():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:35

void vector_delete(Vector *v, size_t index) {
    802051d6:	7179                	addi	sp,sp,-48
    802051d8:	f406                	sd	ra,40(sp)
    802051da:	f022                	sd	s0,32(sp)
    802051dc:	1800                	addi	s0,sp,48
    802051de:	fca43c23          	sd	a0,-40(s0)
    802051e2:	fcb43823          	sd	a1,-48(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:36
    if (index < v->total) {
    802051e6:	fd843783          	ld	a5,-40(s0)
    802051ea:	6b9c                	ld	a5,16(a5)
    802051ec:	fd043703          	ld	a4,-48(s0)
    802051f0:	0af77663          	bgeu	a4,a5,8020529c <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:37
        v->items[index] = NULL;
    802051f4:	fd843783          	ld	a5,-40(s0)
    802051f8:	6398                	ld	a4,0(a5)
    802051fa:	fd043783          	ld	a5,-48(s0)
    802051fe:	078e                	slli	a5,a5,0x3
    80205200:	97ba                	add	a5,a5,a4
    80205202:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38
        for (size_t i = index; i < v->total - 1; ++i) {
    80205206:	fd043783          	ld	a5,-48(s0)
    8020520a:	fef43423          	sd	a5,-24(s0)
    8020520e:	a089                	j	80205250 <vector_delete+0x7a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:39 (discriminator 3)
            v->items[i] = v->items[i + 1];
    80205210:	fd843783          	ld	a5,-40(s0)
    80205214:	6398                	ld	a4,0(a5)
    80205216:	fe843783          	ld	a5,-24(s0)
    8020521a:	0785                	addi	a5,a5,1
    8020521c:	078e                	slli	a5,a5,0x3
    8020521e:	973e                	add	a4,a4,a5
    80205220:	fd843783          	ld	a5,-40(s0)
    80205224:	6394                	ld	a3,0(a5)
    80205226:	fe843783          	ld	a5,-24(s0)
    8020522a:	078e                	slli	a5,a5,0x3
    8020522c:	97b6                	add	a5,a5,a3
    8020522e:	6318                	ld	a4,0(a4)
    80205230:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:40 (discriminator 3)
            v->items[i + 1] = NULL;
    80205232:	fd843783          	ld	a5,-40(s0)
    80205236:	6398                	ld	a4,0(a5)
    80205238:	fe843783          	ld	a5,-24(s0)
    8020523c:	0785                	addi	a5,a5,1
    8020523e:	078e                	slli	a5,a5,0x3
    80205240:	97ba                	add	a5,a5,a4
    80205242:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38 (discriminator 3)
        for (size_t i = index; i < v->total - 1; ++i) {
    80205246:	fe843783          	ld	a5,-24(s0)
    8020524a:	0785                	addi	a5,a5,1
    8020524c:	fef43423          	sd	a5,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:38 (discriminator 1)
    80205250:	fd843783          	ld	a5,-40(s0)
    80205254:	6b9c                	ld	a5,16(a5)
    80205256:	17fd                	addi	a5,a5,-1
    80205258:	fe843703          	ld	a4,-24(s0)
    8020525c:	faf76ae3          	bltu	a4,a5,80205210 <vector_delete+0x3a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:42
        }
        v->total--;
    80205260:	fd843783          	ld	a5,-40(s0)
    80205264:	6b9c                	ld	a5,16(a5)
    80205266:	fff78713          	addi	a4,a5,-1
    8020526a:	fd843783          	ld	a5,-40(s0)
    8020526e:	eb98                	sd	a4,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:43
        if (v->total > 0 && v->total == v->capacity / 4) {
    80205270:	fd843783          	ld	a5,-40(s0)
    80205274:	6b9c                	ld	a5,16(a5)
    80205276:	c39d                	beqz	a5,8020529c <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:43 (discriminator 1)
    80205278:	fd843783          	ld	a5,-40(s0)
    8020527c:	6b98                	ld	a4,16(a5)
    8020527e:	fd843783          	ld	a5,-40(s0)
    80205282:	679c                	ld	a5,8(a5)
    80205284:	8389                	srli	a5,a5,0x2
    80205286:	00f71b63          	bne	a4,a5,8020529c <vector_delete+0xc6>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:44
            vector_resize(v, v->capacity / 2);
    8020528a:	fd843783          	ld	a5,-40(s0)
    8020528e:	679c                	ld	a5,8(a5)
    80205290:	8385                	srli	a5,a5,0x1
    80205292:	85be                	mv	a1,a5
    80205294:	fd843503          	ld	a0,-40(s0)
    80205298:	e5fff0ef          	jal	ra,802050f6 <vector_resize>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:47
        }
    }
}
    8020529c:	0001                	nop
    8020529e:	70a2                	ld	ra,40(sp)
    802052a0:	7402                	ld	s0,32(sp)
    802052a2:	6145                	addi	sp,sp,48
    802052a4:	8082                	ret

00000000802052a6 <vector_free>:
vector_free():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:49

void vector_free(Vector *v) {
    802052a6:	1101                	addi	sp,sp,-32
    802052a8:	ec06                	sd	ra,24(sp)
    802052aa:	e822                	sd	s0,16(sp)
    802052ac:	1000                	addi	s0,sp,32
    802052ae:	fea43423          	sd	a0,-24(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:50
    free(v->items);
    802052b2:	fe843783          	ld	a5,-24(s0)
    802052b6:	639c                	ld	a5,0(a5)
    802052b8:	853e                	mv	a0,a5
    802052ba:	e78fd0ef          	jal	ra,80202932 <free>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:51
    v->items = NULL;
    802052be:	fe843783          	ld	a5,-24(s0)
    802052c2:	0007b023          	sd	zero,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:52
    v->capacity = 0;
    802052c6:	fe843783          	ld	a5,-24(s0)
    802052ca:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:53
    v->total = 0;
    802052ce:	fe843783          	ld	a5,-24(s0)
    802052d2:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:54
}
    802052d6:	0001                	nop
    802052d8:	60e2                	ld	ra,24(sp)
    802052da:	6442                	ld	s0,16(sp)
    802052dc:	6105                	addi	sp,sp,32
    802052de:	8082                	ret

00000000802052e0 <vector_new>:
vector_new():
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:58


void vector_new(Vector *v, size_t initial_capacity) 
{
    802052e0:	1101                	addi	sp,sp,-32
    802052e2:	ec06                	sd	ra,24(sp)
    802052e4:	e822                	sd	s0,16(sp)
    802052e6:	1000                	addi	s0,sp,32
    802052e8:	fea43423          	sd	a0,-24(s0)
    802052ec:	feb43023          	sd	a1,-32(s0)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:59
    if (!v) return;
    802052f0:	fe843783          	ld	a5,-24(s0)
    802052f4:	c3b1                	beqz	a5,80205338 <vector_new+0x58>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:60
    v->items = (void**)malloc(initial_capacity * sizeof(void*));
    802052f6:	fe043783          	ld	a5,-32(s0)
    802052fa:	078e                	slli	a5,a5,0x3
    802052fc:	853e                	mv	a0,a5
    802052fe:	d80fd0ef          	jal	ra,8020287e <malloc>
    80205302:	872a                	mv	a4,a0
    80205304:	fe843783          	ld	a5,-24(s0)
    80205308:	e398                	sd	a4,0(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:61
    if (v->items == NULL) {
    8020530a:	fe843783          	ld	a5,-24(s0)
    8020530e:	639c                	ld	a5,0(a5)
    80205310:	eb91                	bnez	a5,80205324 <vector_new+0x44>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:63
        // 如果内存分配失败，则容量和总数设置为 0
        v->capacity = 0;
    80205312:	fe843783          	ld	a5,-24(s0)
    80205316:	0007b423          	sd	zero,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:64
        v->total = 0;
    8020531a:	fe843783          	ld	a5,-24(s0)
    8020531e:	0007b823          	sd	zero,16(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:65
        return; // 可以在这里处理错误或者返回
    80205322:	a821                	j	8020533a <vector_new+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:69
    }

    // 初始化 Vector 结构体的其他成员
    v->capacity = initial_capacity;
    80205324:	fe843783          	ld	a5,-24(s0)
    80205328:	fe043703          	ld	a4,-32(s0)
    8020532c:	e798                	sd	a4,8(a5)
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:70
    v->total = 0; // 初始时，Vector 为空
    8020532e:	fe843783          	ld	a5,-24(s0)
    80205332:	0007b823          	sd	zero,16(a5)
    80205336:	a011                	j	8020533a <vector_new+0x5a>
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:59
    if (!v) return;
    80205338:	0001                	nop
/home/caigoubencai/Desktop/os_c/kernel/data_structure/vector.c:71
    8020533a:	60e2                	ld	ra,24(sp)
    8020533c:	6442                	ld	s0,16(sp)
    8020533e:	6105                	addi	sp,sp,32
    80205340:	8082                	ret
	...

0000000080205344 <__alltraps>:
__alltraps():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:13
    .align 2
    .section .text
    .globl __alltraps
    .globl __restore
__alltraps:
    csrrw sp, sscratch, sp
    80205344:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:16
    # now sp->kernel stack, sscratch->user stack
    # allocate a TrapContext on kernel stack
    addi sp, sp, -34*8
    80205348:	716d                	addi	sp,sp,-272
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:18
    # save general-purpose registers
    sd x1, 1*8(sp)
    8020534a:	e406                	sd	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:20
    # skip sp(x2), we will save it later
    sd x3, 3*8(sp)
    8020534c:	ec0e                	sd	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:27
    # save x5~x31
    .set n, 5
    .rept 27
        SAVE_GP %n
        .set n, n+1
    .endr
    8020534e:	f416                	sd	t0,40(sp)
    80205350:	f81a                	sd	t1,48(sp)
    80205352:	fc1e                	sd	t2,56(sp)
    80205354:	e0a2                	sd	s0,64(sp)
    80205356:	e4a6                	sd	s1,72(sp)
    80205358:	e8aa                	sd	a0,80(sp)
    8020535a:	ecae                	sd	a1,88(sp)
    8020535c:	f0b2                	sd	a2,96(sp)
    8020535e:	f4b6                	sd	a3,104(sp)
    80205360:	f8ba                	sd	a4,112(sp)
    80205362:	fcbe                	sd	a5,120(sp)
    80205364:	e142                	sd	a6,128(sp)
    80205366:	e546                	sd	a7,136(sp)
    80205368:	e94a                	sd	s2,144(sp)
    8020536a:	ed4e                	sd	s3,152(sp)
    8020536c:	f152                	sd	s4,160(sp)
    8020536e:	f556                	sd	s5,168(sp)
    80205370:	f95a                	sd	s6,176(sp)
    80205372:	fd5e                	sd	s7,184(sp)
    80205374:	e1e2                	sd	s8,192(sp)
    80205376:	e5e6                	sd	s9,200(sp)
    80205378:	e9ea                	sd	s10,208(sp)
    8020537a:	edee                	sd	s11,216(sp)
    8020537c:	f1f2                	sd	t3,224(sp)
    8020537e:	f5f6                	sd	t4,232(sp)
    80205380:	f9fa                	sd	t5,240(sp)
    80205382:	fdfe                	sd	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:29
    # we can use t0/t1/t2 freely, because they were saved on kernel stack
    csrr t0, sstatus
    80205384:	100022f3          	csrr	t0,sstatus
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:30
    csrr t1, sepc
    80205388:	14102373          	csrr	t1,sepc
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:31
    sd t0, 32*8(sp)
    8020538c:	e216                	sd	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:32
    sd t1, 33*8(sp)
    8020538e:	e61a                	sd	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:34
    # read user stack from sscratch and save it on the kernel stack
    csrr t2, sscratch
    80205390:	140023f3          	csrr	t2,sscratch
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:35
    sd t2, 2*8(sp)
    80205394:	e81e                	sd	t2,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:37
    # set input argument of trap_handler(cx: &mut TrapContext)
    mv a0, sp
    80205396:	850a                	mv	a0,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:38
    call trap_handler
    80205398:	fbcff0ef          	jal	ra,80204b54 <trap_handler>

000000008020539c <__restore>:
__restore():
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:44

__restore:
    # mv sp, a0 // 在此之前sp就已经指向正确的stack
    # now sp->kernel stack(after allocated), sscratch->user stack
    # restore sstatus/sepc
    ld t0, 32*8(sp)
    8020539c:	6292                	ld	t0,256(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:45
    ld t1, 33*8(sp)
    8020539e:	6332                	ld	t1,264(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:46
    ld t2, 2*8(sp)
    802053a0:	63c2                	ld	t2,16(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:47
    csrw sstatus, t0
    802053a2:	10029073          	csrw	sstatus,t0
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:48
    csrw sepc, t1
    802053a6:	14131073          	csrw	sepc,t1
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:49
    csrw sscratch, t2
    802053aa:	14039073          	csrw	sscratch,t2
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:51
    # restore general-purpuse registers except sp/tp
    ld x1, 1*8(sp)
    802053ae:	60a2                	ld	ra,8(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:52
    ld x3, 3*8(sp)
    802053b0:	61e2                	ld	gp,24(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:57
    .set n, 5
    .rept 27
        LOAD_GP %n
        .set n, n+1
    .endr
    802053b2:	72a2                	ld	t0,40(sp)
    802053b4:	7342                	ld	t1,48(sp)
    802053b6:	73e2                	ld	t2,56(sp)
    802053b8:	6406                	ld	s0,64(sp)
    802053ba:	64a6                	ld	s1,72(sp)
    802053bc:	6546                	ld	a0,80(sp)
    802053be:	65e6                	ld	a1,88(sp)
    802053c0:	7606                	ld	a2,96(sp)
    802053c2:	76a6                	ld	a3,104(sp)
    802053c4:	7746                	ld	a4,112(sp)
    802053c6:	77e6                	ld	a5,120(sp)
    802053c8:	680a                	ld	a6,128(sp)
    802053ca:	68aa                	ld	a7,136(sp)
    802053cc:	694a                	ld	s2,144(sp)
    802053ce:	69ea                	ld	s3,152(sp)
    802053d0:	7a0a                	ld	s4,160(sp)
    802053d2:	7aaa                	ld	s5,168(sp)
    802053d4:	7b4a                	ld	s6,176(sp)
    802053d6:	7bea                	ld	s7,184(sp)
    802053d8:	6c0e                	ld	s8,192(sp)
    802053da:	6cae                	ld	s9,200(sp)
    802053dc:	6d4e                	ld	s10,208(sp)
    802053de:	6dee                	ld	s11,216(sp)
    802053e0:	7e0e                	ld	t3,224(sp)
    802053e2:	7eae                	ld	t4,232(sp)
    802053e4:	7f4e                	ld	t5,240(sp)
    802053e6:	7fee                	ld	t6,248(sp)
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:59
    # release TrapContext on kernel stack
    addi sp, sp, 34*8
    802053e8:	6151                	addi	sp,sp,272
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:61
    # now sp->kernel stack, sscratch->user stack
    csrrw sp, sscratch, sp
    802053ea:	14011173          	csrrw	sp,sscratch,sp
/home/caigoubencai/Desktop/os_c/kernel/asm/trap.asm:62
    sret
    802053ee:	10200073          	sret
	...

00000000802053fa <__switch>:
__switch():
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:16
    # __switch(
    #     current_task_cx_ptr: *mut TaskContext,
    #     next_task_cx_ptr: *const TaskContext
    # )
    # save kernel stack of current task
    sd sp, 8(a0)
    802053fa:	00253423          	sd	sp,8(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:18
    # save ra & s0~s11 of current execution
    sd ra, 0(a0)
    802053fe:	00153023          	sd	ra,0(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:23
    .set n, 0
    .rept 12
        SAVE_SN %n
        .set n, n + 1
    .endr
    80205402:	e900                	sd	s0,16(a0)
    80205404:	ed04                	sd	s1,24(a0)
    80205406:	03253023          	sd	s2,32(a0)
    8020540a:	03353423          	sd	s3,40(a0)
    8020540e:	03453823          	sd	s4,48(a0)
    80205412:	03553c23          	sd	s5,56(a0)
    80205416:	05653023          	sd	s6,64(a0)
    8020541a:	05753423          	sd	s7,72(a0)
    8020541e:	05853823          	sd	s8,80(a0)
    80205422:	05953c23          	sd	s9,88(a0)
    80205426:	07a53023          	sd	s10,96(a0)
    8020542a:	07b53423          	sd	s11,104(a0)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:25
    # restore ra & s0~s11 of next execution
    ld ra, 0(a1)
    8020542e:	0005b083          	ld	ra,0(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:30
    .set n, 0
    .rept 12
        LOAD_SN %n
        .set n, n + 1
    .endr
    80205432:	6980                	ld	s0,16(a1)
    80205434:	6d84                	ld	s1,24(a1)
    80205436:	0205b903          	ld	s2,32(a1)
    8020543a:	0285b983          	ld	s3,40(a1)
    8020543e:	0305ba03          	ld	s4,48(a1)
    80205442:	0385ba83          	ld	s5,56(a1)
    80205446:	0405bb03          	ld	s6,64(a1)
    8020544a:	0485bb83          	ld	s7,72(a1)
    8020544e:	0505bc03          	ld	s8,80(a1)
    80205452:	0585bc83          	ld	s9,88(a1)
    80205456:	0605bd03          	ld	s10,96(a1)
    8020545a:	0685bd83          	ld	s11,104(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:32
    # restore kernel stack of next task
    ld sp, 8(a1)
    8020545e:	0085b103          	ld	sp,8(a1)
/home/caigoubencai/Desktop/os_c/kernel/asm/switch.asm:33
    ret
    80205462:	8082                	ret
