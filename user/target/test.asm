
00t.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080400000 <_start>:
_start():
    80400000:	00011117          	auipc	sp,0x11
    80400004:	eb210113          	addi	sp,sp,-334 # 80410eb2 <boot_stack_top>
    80400008:	0040006f          	j	8040000c <lib_main>

000000008040000c <lib_main>:
lib_main():
    8040000c:	1141                	addi	sp,sp,-16
    8040000e:	e406                	sd	ra,8(sp)
    80400010:	e022                	sd	s0,0(sp)
    80400012:	0800                	addi	s0,sp,16
    80400014:	5a3000ef          	jal	ra,80400db6 <main>
    80400018:	87aa                	mv	a5,a0
    8040001a:	2781                	sext.w	a5,a5
    8040001c:	853e                	mv	a0,a5
    8040001e:	080000ef          	jal	ra,8040009e <sys_exit>
    80400022:	0001                	nop
    80400024:	60a2                	ld	ra,8(sp)
    80400026:	6402                	ld	s0,0(sp)
    80400028:	0141                	addi	sp,sp,16
    8040002a:	8082                	ret

000000008040002c <syscall>:
syscall():
    8040002c:	7179                	addi	sp,sp,-48
    8040002e:	f422                	sd	s0,40(sp)
    80400030:	1800                	addi	s0,sp,48
    80400032:	fea43423          	sd	a0,-24(s0)
    80400036:	feb43023          	sd	a1,-32(s0)
    8040003a:	fcc43c23          	sd	a2,-40(s0)
    8040003e:	fcd43823          	sd	a3,-48(s0)
    80400042:	fe043503          	ld	a0,-32(s0)
    80400046:	fd843583          	ld	a1,-40(s0)
    8040004a:	fd043603          	ld	a2,-48(s0)
    8040004e:	fe843883          	ld	a7,-24(s0)
    80400052:	00000073          	ecall
    80400056:	87aa                	mv	a5,a0
    80400058:	853e                	mv	a0,a5
    8040005a:	7422                	ld	s0,40(sp)
    8040005c:	6145                	addi	sp,sp,48
    8040005e:	8082                	ret

0000000080400060 <sys_write>:
sys_write():
    80400060:	7179                	addi	sp,sp,-48
    80400062:	f406                	sd	ra,40(sp)
    80400064:	f022                	sd	s0,32(sp)
    80400066:	ec26                	sd	s1,24(sp)
    80400068:	1800                	addi	s0,sp,48
    8040006a:	fca43c23          	sd	a0,-40(s0)
    8040006e:	fcb43823          	sd	a1,-48(s0)
    80400072:	fd043483          	ld	s1,-48(s0)
    80400076:	fd043503          	ld	a0,-48(s0)
    8040007a:	175000ef          	jal	ra,804009ee <strlen>
    8040007e:	87aa                	mv	a5,a0
    80400080:	86be                	mv	a3,a5
    80400082:	8626                	mv	a2,s1
    80400084:	fd843583          	ld	a1,-40(s0)
    80400088:	04000513          	li	a0,64
    8040008c:	fa1ff0ef          	jal	ra,8040002c <syscall>
    80400090:	87aa                	mv	a5,a0
    80400092:	853e                	mv	a0,a5
    80400094:	70a2                	ld	ra,40(sp)
    80400096:	7402                	ld	s0,32(sp)
    80400098:	64e2                	ld	s1,24(sp)
    8040009a:	6145                	addi	sp,sp,48
    8040009c:	8082                	ret

000000008040009e <sys_exit>:
sys_exit():
    8040009e:	1101                	addi	sp,sp,-32
    804000a0:	ec06                	sd	ra,24(sp)
    804000a2:	e822                	sd	s0,16(sp)
    804000a4:	1000                	addi	s0,sp,32
    804000a6:	87aa                	mv	a5,a0
    804000a8:	fef42623          	sw	a5,-20(s0)
    804000ac:	fec42783          	lw	a5,-20(s0)
    804000b0:	4681                	li	a3,0
    804000b2:	4601                	li	a2,0
    804000b4:	85be                	mv	a1,a5
    804000b6:	05d00513          	li	a0,93
    804000ba:	f73ff0ef          	jal	ra,8040002c <syscall>
    804000be:	0001                	nop
    804000c0:	60e2                	ld	ra,24(sp)
    804000c2:	6442                	ld	s0,16(sp)
    804000c4:	6105                	addi	sp,sp,32
    804000c6:	8082                	ret

00000000804000c8 <sys_yield>:
sys_yield():
    804000c8:	1141                	addi	sp,sp,-16
    804000ca:	e406                	sd	ra,8(sp)
    804000cc:	e022                	sd	s0,0(sp)
    804000ce:	0800                	addi	s0,sp,16
    804000d0:	4681                	li	a3,0
    804000d2:	4601                	li	a2,0
    804000d4:	4581                	li	a1,0
    804000d6:	07c00513          	li	a0,124
    804000da:	f53ff0ef          	jal	ra,8040002c <syscall>
    804000de:	0001                	nop
    804000e0:	60a2                	ld	ra,8(sp)
    804000e2:	6402                	ld	s0,0(sp)
    804000e4:	0141                	addi	sp,sp,16
    804000e6:	8082                	ret

00000000804000e8 <port_write>:
port_write():
    804000e8:	1101                	addi	sp,sp,-32
    804000ea:	ec06                	sd	ra,24(sp)
    804000ec:	e822                	sd	s0,16(sp)
    804000ee:	1000                	addi	s0,sp,32
    804000f0:	fea43423          	sd	a0,-24(s0)
    804000f4:	fe843583          	ld	a1,-24(s0)
    804000f8:	4505                	li	a0,1
    804000fa:	f67ff0ef          	jal	ra,80400060 <sys_write>
    804000fe:	0001                	nop
    80400100:	60e2                	ld	ra,24(sp)
    80400102:	6442                	ld	s0,16(sp)
    80400104:	6105                	addi	sp,sp,32
    80400106:	8082                	ret

0000000080400108 <mini_strlen>:
mini_strlen():
    80400108:	7179                	addi	sp,sp,-48
    8040010a:	f422                	sd	s0,40(sp)
    8040010c:	1800                	addi	s0,sp,48
    8040010e:	fca43c23          	sd	a0,-40(s0)
    80400112:	fe042623          	sw	zero,-20(s0)
    80400116:	a031                	j	80400122 <mini_strlen+0x1a>
    80400118:	fec42783          	lw	a5,-20(s0)
    8040011c:	2785                	addiw	a5,a5,1
    8040011e:	fef42623          	sw	a5,-20(s0)
    80400122:	fec46783          	lwu	a5,-20(s0)
    80400126:	fd843703          	ld	a4,-40(s0)
    8040012a:	97ba                	add	a5,a5,a4
    8040012c:	0007c783          	lbu	a5,0(a5)
    80400130:	f7e5                	bnez	a5,80400118 <mini_strlen+0x10>
    80400132:	fec42783          	lw	a5,-20(s0)
    80400136:	853e                	mv	a0,a5
    80400138:	7422                	ld	s0,40(sp)
    8040013a:	6145                	addi	sp,sp,48
    8040013c:	8082                	ret

000000008040013e <mini_itoa>:
mini_itoa():
    8040013e:	715d                	addi	sp,sp,-80
    80400140:	e4a2                	sd	s0,72(sp)
    80400142:	0880                	addi	s0,sp,80
    80400144:	fca43423          	sd	a0,-56(s0)
    80400148:	fae43823          	sd	a4,-80(s0)
    8040014c:	873e                	mv	a4,a5
    8040014e:	87ae                	mv	a5,a1
    80400150:	fcf42223          	sw	a5,-60(s0)
    80400154:	87b2                	mv	a5,a2
    80400156:	fcf42023          	sw	a5,-64(s0)
    8040015a:	87b6                	mv	a5,a3
    8040015c:	faf42e23          	sw	a5,-68(s0)
    80400160:	87ba                	mv	a5,a4
    80400162:	faf42c23          	sw	a5,-72(s0)
    80400166:	fb043783          	ld	a5,-80(s0)
    8040016a:	fef43423          	sd	a5,-24(s0)
    8040016e:	fe042223          	sw	zero,-28(s0)
    80400172:	fc442783          	lw	a5,-60(s0)
    80400176:	0007871b          	sext.w	a4,a5
    8040017a:	47c1                	li	a5,16
    8040017c:	00e7f463          	bgeu	a5,a4,80400184 <mini_itoa+0x46>
    80400180:	4781                	li	a5,0
    80400182:	aae9                	j	8040035c <mini_itoa+0x21e>
    80400184:	fc843783          	ld	a5,-56(s0)
    80400188:	0007df63          	bgez	a5,804001a6 <mini_itoa+0x68>
    8040018c:	fbc42783          	lw	a5,-68(s0)
    80400190:	2781                	sext.w	a5,a5
    80400192:	eb91                	bnez	a5,804001a6 <mini_itoa+0x68>
    80400194:	4785                	li	a5,1
    80400196:	fef42223          	sw	a5,-28(s0)
    8040019a:	fc843783          	ld	a5,-56(s0)
    8040019e:	40f007b3          	neg	a5,a5
    804001a2:	fcf43423          	sd	a5,-56(s0)
    804001a6:	fc042e23          	sw	zero,-36(s0)
    804001aa:	fbc42783          	lw	a5,-68(s0)
    804001ae:	2781                	sext.w	a5,a5
    804001b0:	cb91                	beqz	a5,804001c4 <mini_itoa+0x86>
    804001b2:	fc843703          	ld	a4,-56(s0)
    804001b6:	fc446783          	lwu	a5,-60(s0)
    804001ba:	02f777b3          	remu	a5,a4,a5
    804001be:	fcf42e23          	sw	a5,-36(s0)
    804001c2:	a809                	j	804001d4 <mini_itoa+0x96>
    804001c4:	fc446783          	lwu	a5,-60(s0)
    804001c8:	fc843703          	ld	a4,-56(s0)
    804001cc:	02f767b3          	rem	a5,a4,a5
    804001d0:	fcf42e23          	sw	a5,-36(s0)
    804001d4:	fdc42783          	lw	a5,-36(s0)
    804001d8:	0007871b          	sext.w	a4,a5
    804001dc:	47a5                	li	a5,9
    804001de:	00e7cb63          	blt	a5,a4,804001f4 <mini_itoa+0xb6>
    804001e2:	fdc42783          	lw	a5,-36(s0)
    804001e6:	0ff7f793          	andi	a5,a5,255
    804001ea:	0307879b          	addiw	a5,a5,48
    804001ee:	0ff7f713          	andi	a4,a5,255
    804001f2:	a025                	j	8040021a <mini_itoa+0xdc>
    804001f4:	fc042783          	lw	a5,-64(s0)
    804001f8:	2781                	sext.w	a5,a5
    804001fa:	c781                	beqz	a5,80400202 <mini_itoa+0xc4>
    804001fc:	04100793          	li	a5,65
    80400200:	a019                	j	80400206 <mini_itoa+0xc8>
    80400202:	06100793          	li	a5,97
    80400206:	fdc42703          	lw	a4,-36(s0)
    8040020a:	0ff77713          	andi	a4,a4,255
    8040020e:	9fb9                	addw	a5,a5,a4
    80400210:	0ff7f793          	andi	a5,a5,255
    80400214:	37d9                	addiw	a5,a5,-10
    80400216:	0ff7f713          	andi	a4,a5,255
    8040021a:	fe843783          	ld	a5,-24(s0)
    8040021e:	00178693          	addi	a3,a5,1
    80400222:	fed43423          	sd	a3,-24(s0)
    80400226:	00e78023          	sb	a4,0(a5)
    8040022a:	fbc42783          	lw	a5,-68(s0)
    8040022e:	2781                	sext.w	a5,a5
    80400230:	cb91                	beqz	a5,80400244 <mini_itoa+0x106>
    80400232:	fc843703          	ld	a4,-56(s0)
    80400236:	fc446783          	lwu	a5,-60(s0)
    8040023a:	02f757b3          	divu	a5,a4,a5
    8040023e:	fcf43423          	sd	a5,-56(s0)
    80400242:	a809                	j	80400254 <mini_itoa+0x116>
    80400244:	fc446783          	lwu	a5,-60(s0)
    80400248:	fc843703          	ld	a4,-56(s0)
    8040024c:	02f747b3          	div	a5,a4,a5
    80400250:	fcf43423          	sd	a5,-56(s0)
    80400254:	fc843783          	ld	a5,-56(s0)
    80400258:	f7b9                	bnez	a5,804001a6 <mini_itoa+0x68>
    8040025a:	fe843703          	ld	a4,-24(s0)
    8040025e:	fb043783          	ld	a5,-80(s0)
    80400262:	40f707b3          	sub	a5,a4,a5
    80400266:	fef42023          	sw	a5,-32(s0)
    8040026a:	a005                	j	8040028a <mini_itoa+0x14c>
    8040026c:	fe843783          	ld	a5,-24(s0)
    80400270:	00178713          	addi	a4,a5,1
    80400274:	fee43423          	sd	a4,-24(s0)
    80400278:	03000713          	li	a4,48
    8040027c:	00e78023          	sb	a4,0(a5)
    80400280:	fe042783          	lw	a5,-32(s0)
    80400284:	2785                	addiw	a5,a5,1
    80400286:	fef42023          	sw	a5,-32(s0)
    8040028a:	fe042703          	lw	a4,-32(s0)
    8040028e:	fb842783          	lw	a5,-72(s0)
    80400292:	2701                	sext.w	a4,a4
    80400294:	2781                	sext.w	a5,a5
    80400296:	fcf76be3          	bltu	a4,a5,8040026c <mini_itoa+0x12e>
    8040029a:	fe442783          	lw	a5,-28(s0)
    8040029e:	2781                	sext.w	a5,a5
    804002a0:	cb99                	beqz	a5,804002b6 <mini_itoa+0x178>
    804002a2:	fe843783          	ld	a5,-24(s0)
    804002a6:	00178713          	addi	a4,a5,1
    804002aa:	fee43423          	sd	a4,-24(s0)
    804002ae:	02d00713          	li	a4,45
    804002b2:	00e78023          	sb	a4,0(a5)
    804002b6:	fe843783          	ld	a5,-24(s0)
    804002ba:	00078023          	sb	zero,0(a5)
    804002be:	fe843703          	ld	a4,-24(s0)
    804002c2:	fb043783          	ld	a5,-80(s0)
    804002c6:	40f707b3          	sub	a5,a4,a5
    804002ca:	fcf42c23          	sw	a5,-40(s0)
    804002ce:	fe042023          	sw	zero,-32(s0)
    804002d2:	a885                	j	80400342 <mini_itoa+0x204>
    804002d4:	fe046783          	lwu	a5,-32(s0)
    804002d8:	fb043703          	ld	a4,-80(s0)
    804002dc:	97ba                	add	a5,a5,a4
    804002de:	0007c783          	lbu	a5,0(a5)
    804002e2:	fcf40ba3          	sb	a5,-41(s0)
    804002e6:	fd842703          	lw	a4,-40(s0)
    804002ea:	fe042783          	lw	a5,-32(s0)
    804002ee:	40f707bb          	subw	a5,a4,a5
    804002f2:	2781                	sext.w	a5,a5
    804002f4:	37fd                	addiw	a5,a5,-1
    804002f6:	2781                	sext.w	a5,a5
    804002f8:	1782                	slli	a5,a5,0x20
    804002fa:	9381                	srli	a5,a5,0x20
    804002fc:	fb043703          	ld	a4,-80(s0)
    80400300:	973e                	add	a4,a4,a5
    80400302:	fe046783          	lwu	a5,-32(s0)
    80400306:	fb043683          	ld	a3,-80(s0)
    8040030a:	97b6                	add	a5,a5,a3
    8040030c:	00074703          	lbu	a4,0(a4)
    80400310:	00e78023          	sb	a4,0(a5)
    80400314:	fd842703          	lw	a4,-40(s0)
    80400318:	fe042783          	lw	a5,-32(s0)
    8040031c:	40f707bb          	subw	a5,a4,a5
    80400320:	2781                	sext.w	a5,a5
    80400322:	37fd                	addiw	a5,a5,-1
    80400324:	2781                	sext.w	a5,a5
    80400326:	1782                	slli	a5,a5,0x20
    80400328:	9381                	srli	a5,a5,0x20
    8040032a:	fb043703          	ld	a4,-80(s0)
    8040032e:	97ba                	add	a5,a5,a4
    80400330:	fd744703          	lbu	a4,-41(s0)
    80400334:	00e78023          	sb	a4,0(a5)
    80400338:	fe042783          	lw	a5,-32(s0)
    8040033c:	2785                	addiw	a5,a5,1
    8040033e:	fef42023          	sw	a5,-32(s0)
    80400342:	fd842783          	lw	a5,-40(s0)
    80400346:	0017d79b          	srliw	a5,a5,0x1
    8040034a:	0007871b          	sext.w	a4,a5
    8040034e:	fe042783          	lw	a5,-32(s0)
    80400352:	2781                	sext.w	a5,a5
    80400354:	f8e7e0e3          	bltu	a5,a4,804002d4 <mini_itoa+0x196>
    80400358:	fd842783          	lw	a5,-40(s0)
    8040035c:	853e                	mv	a0,a5
    8040035e:	6426                	ld	s0,72(sp)
    80400360:	6161                	addi	sp,sp,80
    80400362:	8082                	ret

0000000080400364 <_putc>:
_putc():
    80400364:	1101                	addi	sp,sp,-32
    80400366:	ec22                	sd	s0,24(sp)
    80400368:	1000                	addi	s0,sp,32
    8040036a:	87aa                	mv	a5,a0
    8040036c:	feb43023          	sd	a1,-32(s0)
    80400370:	fef42623          	sw	a5,-20(s0)
    80400374:	fe043783          	ld	a5,-32(s0)
    80400378:	6798                	ld	a4,8(a5)
    8040037a:	fe043783          	ld	a5,-32(s0)
    8040037e:	639c                	ld	a5,0(a5)
    80400380:	40f707b3          	sub	a5,a4,a5
    80400384:	2781                	sext.w	a5,a5
    80400386:	2785                	addiw	a5,a5,1
    80400388:	0007871b          	sext.w	a4,a5
    8040038c:	fe043783          	ld	a5,-32(s0)
    80400390:	4b9c                	lw	a5,16(a5)
    80400392:	00f76463          	bltu	a4,a5,8040039a <_putc+0x36>
    80400396:	4781                	li	a5,0
    80400398:	a02d                	j	804003c2 <_putc+0x5e>
    8040039a:	fe043783          	ld	a5,-32(s0)
    8040039e:	679c                	ld	a5,8(a5)
    804003a0:	00178693          	addi	a3,a5,1
    804003a4:	fe043703          	ld	a4,-32(s0)
    804003a8:	e714                	sd	a3,8(a4)
    804003aa:	fec42703          	lw	a4,-20(s0)
    804003ae:	0ff77713          	andi	a4,a4,255
    804003b2:	00e78023          	sb	a4,0(a5)
    804003b6:	fe043783          	ld	a5,-32(s0)
    804003ba:	679c                	ld	a5,8(a5)
    804003bc:	00078023          	sb	zero,0(a5)
    804003c0:	4785                	li	a5,1
    804003c2:	853e                	mv	a0,a5
    804003c4:	6462                	ld	s0,24(sp)
    804003c6:	6105                	addi	sp,sp,32
    804003c8:	8082                	ret

00000000804003ca <_puts>:
_puts():
    804003ca:	7139                	addi	sp,sp,-64
    804003cc:	fc22                	sd	s0,56(sp)
    804003ce:	0080                	addi	s0,sp,64
    804003d0:	fca43c23          	sd	a0,-40(s0)
    804003d4:	87ae                	mv	a5,a1
    804003d6:	fcc43423          	sd	a2,-56(s0)
    804003da:	fcf42a23          	sw	a5,-44(s0)
    804003de:	fc843783          	ld	a5,-56(s0)
    804003e2:	4b9c                	lw	a5,16(a5)
    804003e4:	02079713          	slli	a4,a5,0x20
    804003e8:	9301                	srli	a4,a4,0x20
    804003ea:	fc843783          	ld	a5,-56(s0)
    804003ee:	6794                	ld	a3,8(a5)
    804003f0:	fc843783          	ld	a5,-56(s0)
    804003f4:	639c                	ld	a5,0(a5)
    804003f6:	40f687b3          	sub	a5,a3,a5
    804003fa:	8f1d                	sub	a4,a4,a5
    804003fc:	fd446783          	lwu	a5,-44(s0)
    80400400:	02e7c463          	blt	a5,a4,80400428 <_puts+0x5e>
    80400404:	fc843783          	ld	a5,-56(s0)
    80400408:	4b98                	lw	a4,16(a5)
    8040040a:	fc843783          	ld	a5,-56(s0)
    8040040e:	6794                	ld	a3,8(a5)
    80400410:	fc843783          	ld	a5,-56(s0)
    80400414:	639c                	ld	a5,0(a5)
    80400416:	40f687b3          	sub	a5,a3,a5
    8040041a:	2781                	sext.w	a5,a5
    8040041c:	40f707bb          	subw	a5,a4,a5
    80400420:	2781                	sext.w	a5,a5
    80400422:	37fd                	addiw	a5,a5,-1
    80400424:	fcf42a23          	sw	a5,-44(s0)
    80400428:	fe042623          	sw	zero,-20(s0)
    8040042c:	a03d                	j	8040045a <_puts+0x90>
    8040042e:	fec46783          	lwu	a5,-20(s0)
    80400432:	fd843703          	ld	a4,-40(s0)
    80400436:	973e                	add	a4,a4,a5
    80400438:	fc843783          	ld	a5,-56(s0)
    8040043c:	679c                	ld	a5,8(a5)
    8040043e:	00178613          	addi	a2,a5,1
    80400442:	fc843683          	ld	a3,-56(s0)
    80400446:	e690                	sd	a2,8(a3)
    80400448:	00074703          	lbu	a4,0(a4)
    8040044c:	00e78023          	sb	a4,0(a5)
    80400450:	fec42783          	lw	a5,-20(s0)
    80400454:	2785                	addiw	a5,a5,1
    80400456:	fef42623          	sw	a5,-20(s0)
    8040045a:	fec42703          	lw	a4,-20(s0)
    8040045e:	fd442783          	lw	a5,-44(s0)
    80400462:	2701                	sext.w	a4,a4
    80400464:	2781                	sext.w	a5,a5
    80400466:	fcf764e3          	bltu	a4,a5,8040042e <_puts+0x64>
    8040046a:	fc843783          	ld	a5,-56(s0)
    8040046e:	679c                	ld	a5,8(a5)
    80400470:	00078023          	sb	zero,0(a5)
    80400474:	fd442783          	lw	a5,-44(s0)
    80400478:	853e                	mv	a0,a5
    8040047a:	7462                	ld	s0,56(sp)
    8040047c:	6121                	addi	sp,sp,64
    8040047e:	8082                	ret

0000000080400480 <mini_vsnprintf>:
mini_vsnprintf():
    80400480:	7119                	addi	sp,sp,-128
    80400482:	fc86                	sd	ra,120(sp)
    80400484:	f8a2                	sd	s0,112(sp)
    80400486:	0100                	addi	s0,sp,128
    80400488:	f8a43c23          	sd	a0,-104(s0)
    8040048c:	87ae                	mv	a5,a1
    8040048e:	f8c43423          	sd	a2,-120(s0)
    80400492:	f8d43023          	sd	a3,-128(s0)
    80400496:	f8f42a23          	sw	a5,-108(s0)
    8040049a:	f9843783          	ld	a5,-104(s0)
    8040049e:	fcf43023          	sd	a5,-64(s0)
    804004a2:	f9843783          	ld	a5,-104(s0)
    804004a6:	fcf43423          	sd	a5,-56(s0)
    804004aa:	f9442783          	lw	a5,-108(s0)
    804004ae:	fcf42823          	sw	a5,-48(s0)
    804004b2:	a4f9                	j	80400780 <mini_vsnprintf+0x300>
    804004b4:	fc843703          	ld	a4,-56(s0)
    804004b8:	fc043783          	ld	a5,-64(s0)
    804004bc:	40f707b3          	sub	a5,a4,a5
    804004c0:	2781                	sext.w	a5,a5
    804004c2:	2785                	addiw	a5,a5,1
    804004c4:	0007871b          	sext.w	a4,a5
    804004c8:	fd042783          	lw	a5,-48(s0)
    804004cc:	2cf77b63          	bgeu	a4,a5,804007a2 <mini_vsnprintf+0x322>
    804004d0:	fef44783          	lbu	a5,-17(s0)
    804004d4:	0ff7f713          	andi	a4,a5,255
    804004d8:	02500793          	li	a5,37
    804004dc:	00f70c63          	beq	a4,a5,804004f4 <mini_vsnprintf+0x74>
    804004e0:	fef44783          	lbu	a5,-17(s0)
    804004e4:	2781                	sext.w	a5,a5
    804004e6:	fc040713          	addi	a4,s0,-64
    804004ea:	85ba                	mv	a1,a4
    804004ec:	853e                	mv	a0,a5
    804004ee:	e77ff0ef          	jal	ra,80400364 <_putc>
    804004f2:	a479                	j	80400780 <mini_vsnprintf+0x300>
    804004f4:	fe040723          	sb	zero,-18(s0)
    804004f8:	fe042423          	sw	zero,-24(s0)
    804004fc:	f8843783          	ld	a5,-120(s0)
    80400500:	00178713          	addi	a4,a5,1
    80400504:	f8e43423          	sd	a4,-120(s0)
    80400508:	0007c783          	lbu	a5,0(a5)
    8040050c:	fef407a3          	sb	a5,-17(s0)
    80400510:	fef44783          	lbu	a5,-17(s0)
    80400514:	0ff7f713          	andi	a4,a5,255
    80400518:	03000793          	li	a5,48
    8040051c:	06f71b63          	bne	a4,a5,80400592 <mini_vsnprintf+0x112>
    80400520:	a891                	j	80400574 <mini_vsnprintf+0xf4>
    80400522:	fef44783          	lbu	a5,-17(s0)
    80400526:	0ff7f793          	andi	a5,a5,255
    8040052a:	26078e63          	beqz	a5,804007a6 <mini_vsnprintf+0x326>
    8040052e:	fef44783          	lbu	a5,-17(s0)
    80400532:	0ff7f713          	andi	a4,a5,255
    80400536:	02f00793          	li	a5,47
    8040053a:	04e7fc63          	bgeu	a5,a4,80400592 <mini_vsnprintf+0x112>
    8040053e:	fef44783          	lbu	a5,-17(s0)
    80400542:	0ff7f713          	andi	a4,a5,255
    80400546:	03900793          	li	a5,57
    8040054a:	04e7e463          	bltu	a5,a4,80400592 <mini_vsnprintf+0x112>
    8040054e:	fee44703          	lbu	a4,-18(s0)
    80400552:	87ba                	mv	a5,a4
    80400554:	0027979b          	slliw	a5,a5,0x2
    80400558:	9fb9                	addw	a5,a5,a4
    8040055a:	0017979b          	slliw	a5,a5,0x1
    8040055e:	0ff7f793          	andi	a5,a5,255
    80400562:	fef44703          	lbu	a4,-17(s0)
    80400566:	9fb9                	addw	a5,a5,a4
    80400568:	0ff7f793          	andi	a5,a5,255
    8040056c:	fd07879b          	addiw	a5,a5,-48
    80400570:	fef40723          	sb	a5,-18(s0)
    80400574:	f8843783          	ld	a5,-120(s0)
    80400578:	00178713          	addi	a4,a5,1
    8040057c:	f8e43423          	sd	a4,-120(s0)
    80400580:	0007c783          	lbu	a5,0(a5)
    80400584:	fef407a3          	sb	a5,-17(s0)
    80400588:	fef44783          	lbu	a5,-17(s0)
    8040058c:	0ff7f793          	andi	a5,a5,255
    80400590:	fbc9                	bnez	a5,80400522 <mini_vsnprintf+0xa2>
    80400592:	fef44783          	lbu	a5,-17(s0)
    80400596:	0ff7f713          	andi	a4,a5,255
    8040059a:	06c00793          	li	a5,108
    8040059e:	00f71f63          	bne	a4,a5,804005bc <mini_vsnprintf+0x13c>
    804005a2:	4785                	li	a5,1
    804005a4:	fef42423          	sw	a5,-24(s0)
    804005a8:	f8843783          	ld	a5,-120(s0)
    804005ac:	00178713          	addi	a4,a5,1
    804005b0:	f8e43423          	sd	a4,-120(s0)
    804005b4:	0007c783          	lbu	a5,0(a5)
    804005b8:	fef407a3          	sb	a5,-17(s0)
    804005bc:	fef44783          	lbu	a5,-17(s0)
    804005c0:	2781                	sext.w	a5,a5
    804005c2:	1e078463          	beqz	a5,804007aa <mini_vsnprintf+0x32a>
    804005c6:	873e                	mv	a4,a5
    804005c8:	1a074263          	bltz	a4,8040076c <mini_vsnprintf+0x2ec>
    804005cc:	86be                	mv	a3,a5
    804005ce:	07800713          	li	a4,120
    804005d2:	18d74d63          	blt	a4,a3,8040076c <mini_vsnprintf+0x2ec>
    804005d6:	86be                	mv	a3,a5
    804005d8:	05800713          	li	a4,88
    804005dc:	18e6c863          	blt	a3,a4,8040076c <mini_vsnprintf+0x2ec>
    804005e0:	fa87869b          	addiw	a3,a5,-88
    804005e4:	0006871b          	sext.w	a4,a3
    804005e8:	02000793          	li	a5,32
    804005ec:	18e7e063          	bltu	a5,a4,8040076c <mini_vsnprintf+0x2ec>
    804005f0:	02069793          	slli	a5,a3,0x20
    804005f4:	9381                	srli	a5,a5,0x20
    804005f6:	00279713          	slli	a4,a5,0x2
    804005fa:	00001797          	auipc	a5,0x1
    804005fe:	81e78793          	addi	a5,a5,-2018 # 80400e18 <main+0x62>
    80400602:	97ba                	add	a5,a5,a4
    80400604:	439c                	lw	a5,0(a5)
    80400606:	0007871b          	sext.w	a4,a5
    8040060a:	00001797          	auipc	a5,0x1
    8040060e:	80e78793          	addi	a5,a5,-2034 # 80400e18 <main+0x62>
    80400612:	97ba                	add	a5,a5,a4
    80400614:	8782                	jr	a5
    80400616:	4785                	li	a5,1
    80400618:	fef42423          	sw	a5,-24(s0)
    8040061c:	a295                	j	80400780 <mini_vsnprintf+0x300>
    8040061e:	fe842783          	lw	a5,-24(s0)
    80400622:	2781                	sext.w	a5,a5
    80400624:	ef81                	bnez	a5,8040063c <mini_vsnprintf+0x1bc>
    80400626:	f8043783          	ld	a5,-128(s0)
    8040062a:	00878713          	addi	a4,a5,8
    8040062e:	f8e43023          	sd	a4,-128(s0)
    80400632:	439c                	lw	a5,0(a5)
    80400634:	02079513          	slli	a0,a5,0x20
    80400638:	9101                	srli	a0,a0,0x20
    8040063a:	a809                	j	8040064c <mini_vsnprintf+0x1cc>
    8040063c:	f8043783          	ld	a5,-128(s0)
    80400640:	00878713          	addi	a4,a5,8
    80400644:	f8e43023          	sd	a4,-128(s0)
    80400648:	639c                	ld	a5,0(a5)
    8040064a:	853e                	mv	a0,a5
    8040064c:	fef44783          	lbu	a5,-17(s0)
    80400650:	0007871b          	sext.w	a4,a5
    80400654:	07500793          	li	a5,117
    80400658:	40f707b3          	sub	a5,a4,a5
    8040065c:	0017b793          	seqz	a5,a5
    80400660:	0ff7f793          	andi	a5,a5,255
    80400664:	0007869b          	sext.w	a3,a5
    80400668:	fee44783          	lbu	a5,-18(s0)
    8040066c:	2781                	sext.w	a5,a5
    8040066e:	fa840713          	addi	a4,s0,-88
    80400672:	4601                	li	a2,0
    80400674:	45a9                	li	a1,10
    80400676:	ac9ff0ef          	jal	ra,8040013e <mini_itoa>
    8040067a:	87aa                	mv	a5,a0
    8040067c:	fcf42e23          	sw	a5,-36(s0)
    80400680:	fc040693          	addi	a3,s0,-64
    80400684:	fdc42703          	lw	a4,-36(s0)
    80400688:	fa840793          	addi	a5,s0,-88
    8040068c:	8636                	mv	a2,a3
    8040068e:	85ba                	mv	a1,a4
    80400690:	853e                	mv	a0,a5
    80400692:	d39ff0ef          	jal	ra,804003ca <_puts>
    80400696:	fe042423          	sw	zero,-24(s0)
    8040069a:	a0dd                	j	80400780 <mini_vsnprintf+0x300>
    8040069c:	fe842783          	lw	a5,-24(s0)
    804006a0:	2781                	sext.w	a5,a5
    804006a2:	ef81                	bnez	a5,804006ba <mini_vsnprintf+0x23a>
    804006a4:	f8043783          	ld	a5,-128(s0)
    804006a8:	00878713          	addi	a4,a5,8
    804006ac:	f8e43023          	sd	a4,-128(s0)
    804006b0:	439c                	lw	a5,0(a5)
    804006b2:	02079513          	slli	a0,a5,0x20
    804006b6:	9101                	srli	a0,a0,0x20
    804006b8:	a809                	j	804006ca <mini_vsnprintf+0x24a>
    804006ba:	f8043783          	ld	a5,-128(s0)
    804006be:	00878713          	addi	a4,a5,8
    804006c2:	f8e43023          	sd	a4,-128(s0)
    804006c6:	639c                	ld	a5,0(a5)
    804006c8:	853e                	mv	a0,a5
    804006ca:	fef44783          	lbu	a5,-17(s0)
    804006ce:	0007871b          	sext.w	a4,a5
    804006d2:	05800793          	li	a5,88
    804006d6:	40f707b3          	sub	a5,a4,a5
    804006da:	0017b793          	seqz	a5,a5
    804006de:	0ff7f793          	andi	a5,a5,255
    804006e2:	0007861b          	sext.w	a2,a5
    804006e6:	fee44783          	lbu	a5,-18(s0)
    804006ea:	2781                	sext.w	a5,a5
    804006ec:	fa840713          	addi	a4,s0,-88
    804006f0:	4685                	li	a3,1
    804006f2:	45c1                	li	a1,16
    804006f4:	a4bff0ef          	jal	ra,8040013e <mini_itoa>
    804006f8:	87aa                	mv	a5,a0
    804006fa:	fcf42e23          	sw	a5,-36(s0)
    804006fe:	fc040693          	addi	a3,s0,-64
    80400702:	fdc42703          	lw	a4,-36(s0)
    80400706:	fa840793          	addi	a5,s0,-88
    8040070a:	8636                	mv	a2,a3
    8040070c:	85ba                	mv	a1,a4
    8040070e:	853e                	mv	a0,a5
    80400710:	cbbff0ef          	jal	ra,804003ca <_puts>
    80400714:	fe042423          	sw	zero,-24(s0)
    80400718:	a0a5                	j	80400780 <mini_vsnprintf+0x300>
    8040071a:	f8043783          	ld	a5,-128(s0)
    8040071e:	00878713          	addi	a4,a5,8
    80400722:	f8e43023          	sd	a4,-128(s0)
    80400726:	439c                	lw	a5,0(a5)
    80400728:	0ff7f793          	andi	a5,a5,255
    8040072c:	2781                	sext.w	a5,a5
    8040072e:	fc040713          	addi	a4,s0,-64
    80400732:	85ba                	mv	a1,a4
    80400734:	853e                	mv	a0,a5
    80400736:	c2fff0ef          	jal	ra,80400364 <_putc>
    8040073a:	a099                	j	80400780 <mini_vsnprintf+0x300>
    8040073c:	f8043783          	ld	a5,-128(s0)
    80400740:	00878713          	addi	a4,a5,8
    80400744:	f8e43023          	sd	a4,-128(s0)
    80400748:	639c                	ld	a5,0(a5)
    8040074a:	fef43023          	sd	a5,-32(s0)
    8040074e:	fe043503          	ld	a0,-32(s0)
    80400752:	9b7ff0ef          	jal	ra,80400108 <mini_strlen>
    80400756:	87aa                	mv	a5,a0
    80400758:	2781                	sext.w	a5,a5
    8040075a:	fc040713          	addi	a4,s0,-64
    8040075e:	863a                	mv	a2,a4
    80400760:	85be                	mv	a1,a5
    80400762:	fe043503          	ld	a0,-32(s0)
    80400766:	c65ff0ef          	jal	ra,804003ca <_puts>
    8040076a:	a819                	j	80400780 <mini_vsnprintf+0x300>
    8040076c:	fef44783          	lbu	a5,-17(s0)
    80400770:	2781                	sext.w	a5,a5
    80400772:	fc040713          	addi	a4,s0,-64
    80400776:	85ba                	mv	a1,a4
    80400778:	853e                	mv	a0,a5
    8040077a:	bebff0ef          	jal	ra,80400364 <_putc>
    8040077e:	0001                	nop
    80400780:	f8843783          	ld	a5,-120(s0)
    80400784:	00178713          	addi	a4,a5,1
    80400788:	f8e43423          	sd	a4,-120(s0)
    8040078c:	0007c783          	lbu	a5,0(a5)
    80400790:	fef407a3          	sb	a5,-17(s0)
    80400794:	fef44783          	lbu	a5,-17(s0)
    80400798:	0ff7f793          	andi	a5,a5,255
    8040079c:	d0079ce3          	bnez	a5,804004b4 <mini_vsnprintf+0x34>
    804007a0:	a031                	j	804007ac <mini_vsnprintf+0x32c>
    804007a2:	0001                	nop
    804007a4:	a021                	j	804007ac <mini_vsnprintf+0x32c>
    804007a6:	0001                	nop
    804007a8:	a011                	j	804007ac <mini_vsnprintf+0x32c>
    804007aa:	0001                	nop
    804007ac:	fc843703          	ld	a4,-56(s0)
    804007b0:	fc043783          	ld	a5,-64(s0)
    804007b4:	40f707b3          	sub	a5,a4,a5
    804007b8:	2781                	sext.w	a5,a5
    804007ba:	853e                	mv	a0,a5
    804007bc:	70e6                	ld	ra,120(sp)
    804007be:	7446                	ld	s0,112(sp)
    804007c0:	6109                	addi	sp,sp,128
    804007c2:	8082                	ret

00000000804007c4 <_vprintk>:
_vprintk():
    804007c4:	7129                	addi	sp,sp,-320
    804007c6:	fe06                	sd	ra,312(sp)
    804007c8:	fa22                	sd	s0,304(sp)
    804007ca:	0280                	addi	s0,sp,320
    804007cc:	eca43c23          	sd	a0,-296(s0)
    804007d0:	ecb43823          	sd	a1,-304(s0)
    804007d4:	ecc43423          	sd	a2,-312(s0)
    804007d8:	ed043783          	ld	a5,-304(s0)
    804007dc:	fef43023          	sd	a5,-32(s0)
    804007e0:	fe043703          	ld	a4,-32(s0)
    804007e4:	ee040793          	addi	a5,s0,-288
    804007e8:	86ba                	mv	a3,a4
    804007ea:	ed843603          	ld	a2,-296(s0)
    804007ee:	10000593          	li	a1,256
    804007f2:	853e                	mv	a0,a5
    804007f4:	c8dff0ef          	jal	ra,80400480 <mini_vsnprintf>
    804007f8:	87aa                	mv	a5,a0
    804007fa:	fef42623          	sw	a5,-20(s0)
    804007fe:	fec42783          	lw	a5,-20(s0)
    80400802:	ff040713          	addi	a4,s0,-16
    80400806:	97ba                	add	a5,a5,a4
    80400808:	ee078823          	sb	zero,-272(a5)
    8040080c:	ee040793          	addi	a5,s0,-288
    80400810:	ec843703          	ld	a4,-312(s0)
    80400814:	853e                	mv	a0,a5
    80400816:	9702                	jalr	a4
    80400818:	fec42783          	lw	a5,-20(s0)
    8040081c:	853e                	mv	a0,a5
    8040081e:	70f2                	ld	ra,312(sp)
    80400820:	7452                	ld	s0,304(sp)
    80400822:	6131                	addi	sp,sp,320
    80400824:	8082                	ret

0000000080400826 <_vprints>:
_vprints():
    80400826:	7129                	addi	sp,sp,-320
    80400828:	fe06                	sd	ra,312(sp)
    8040082a:	fa22                	sd	s0,304(sp)
    8040082c:	0280                	addi	s0,sp,320
    8040082e:	eca43c23          	sd	a0,-296(s0)
    80400832:	ecb43823          	sd	a1,-304(s0)
    80400836:	ecc43423          	sd	a2,-312(s0)
    8040083a:	ed043783          	ld	a5,-304(s0)
    8040083e:	fef43023          	sd	a5,-32(s0)
    80400842:	fe043703          	ld	a4,-32(s0)
    80400846:	ee040793          	addi	a5,s0,-288
    8040084a:	86ba                	mv	a3,a4
    8040084c:	ed843603          	ld	a2,-296(s0)
    80400850:	10000593          	li	a1,256
    80400854:	853e                	mv	a0,a5
    80400856:	c2bff0ef          	jal	ra,80400480 <mini_vsnprintf>
    8040085a:	87aa                	mv	a5,a0
    8040085c:	fef42623          	sw	a5,-20(s0)
    80400860:	fec42783          	lw	a5,-20(s0)
    80400864:	ff040713          	addi	a4,s0,-16
    80400868:	97ba                	add	a5,a5,a4
    8040086a:	ee078823          	sb	zero,-272(a5)
    8040086e:	ee040793          	addi	a5,s0,-288
    80400872:	ec843703          	ld	a4,-312(s0)
    80400876:	853e                	mv	a0,a5
    80400878:	9702                	jalr	a4
    8040087a:	fec42783          	lw	a5,-20(s0)
    8040087e:	853e                	mv	a0,a5
    80400880:	70f2                	ld	ra,312(sp)
    80400882:	7452                	ld	s0,304(sp)
    80400884:	6131                	addi	sp,sp,320
    80400886:	8082                	ret

0000000080400888 <vprintk>:
vprintk():
    80400888:	1101                	addi	sp,sp,-32
    8040088a:	ec06                	sd	ra,24(sp)
    8040088c:	e822                	sd	s0,16(sp)
    8040088e:	1000                	addi	s0,sp,32
    80400890:	fea43423          	sd	a0,-24(s0)
    80400894:	feb43023          	sd	a1,-32(s0)
    80400898:	00000617          	auipc	a2,0x0
    8040089c:	85060613          	addi	a2,a2,-1968 # 804000e8 <port_write>
    804008a0:	fe043583          	ld	a1,-32(s0)
    804008a4:	fe843503          	ld	a0,-24(s0)
    804008a8:	f1dff0ef          	jal	ra,804007c4 <_vprintk>
    804008ac:	87aa                	mv	a5,a0
    804008ae:	853e                	mv	a0,a5
    804008b0:	60e2                	ld	ra,24(sp)
    804008b2:	6442                	ld	s0,16(sp)
    804008b4:	6105                	addi	sp,sp,32
    804008b6:	8082                	ret

00000000804008b8 <printf>:
printf():
    804008b8:	7159                	addi	sp,sp,-112
    804008ba:	f406                	sd	ra,40(sp)
    804008bc:	f022                	sd	s0,32(sp)
    804008be:	1800                	addi	s0,sp,48
    804008c0:	fca43c23          	sd	a0,-40(s0)
    804008c4:	e40c                	sd	a1,8(s0)
    804008c6:	e810                	sd	a2,16(s0)
    804008c8:	ec14                	sd	a3,24(s0)
    804008ca:	f018                	sd	a4,32(s0)
    804008cc:	f41c                	sd	a5,40(s0)
    804008ce:	03043823          	sd	a6,48(s0)
    804008d2:	03143c23          	sd	a7,56(s0)
    804008d6:	fe042623          	sw	zero,-20(s0)
    804008da:	04040793          	addi	a5,s0,64
    804008de:	fcf43823          	sd	a5,-48(s0)
    804008e2:	fd043783          	ld	a5,-48(s0)
    804008e6:	fc878793          	addi	a5,a5,-56
    804008ea:	fef43023          	sd	a5,-32(s0)
    804008ee:	fe043783          	ld	a5,-32(s0)
    804008f2:	85be                	mv	a1,a5
    804008f4:	fd843503          	ld	a0,-40(s0)
    804008f8:	f91ff0ef          	jal	ra,80400888 <vprintk>
    804008fc:	87aa                	mv	a5,a0
    804008fe:	fef42623          	sw	a5,-20(s0)
    80400902:	fec42783          	lw	a5,-20(s0)
    80400906:	853e                	mv	a0,a5
    80400908:	70a2                	ld	ra,40(sp)
    8040090a:	7402                	ld	s0,32(sp)
    8040090c:	6165                	addi	sp,sp,112
    8040090e:	8082                	ret

0000000080400910 <_vprintk_port>:
_vprintk_port():
    80400910:	7129                	addi	sp,sp,-320
    80400912:	fe06                	sd	ra,312(sp)
    80400914:	fa22                	sd	s0,304(sp)
    80400916:	0280                	addi	s0,sp,320
    80400918:	eca43c23          	sd	a0,-296(s0)
    8040091c:	ecb43823          	sd	a1,-304(s0)
    80400920:	ecc43423          	sd	a2,-312(s0)
    80400924:	ed043783          	ld	a5,-304(s0)
    80400928:	fef43023          	sd	a5,-32(s0)
    8040092c:	fe043703          	ld	a4,-32(s0)
    80400930:	ee040793          	addi	a5,s0,-288
    80400934:	86ba                	mv	a3,a4
    80400936:	ed843603          	ld	a2,-296(s0)
    8040093a:	10000593          	li	a1,256
    8040093e:	853e                	mv	a0,a5
    80400940:	b41ff0ef          	jal	ra,80400480 <mini_vsnprintf>
    80400944:	87aa                	mv	a5,a0
    80400946:	fef42623          	sw	a5,-20(s0)
    8040094a:	fec42783          	lw	a5,-20(s0)
    8040094e:	ff040713          	addi	a4,s0,-16
    80400952:	97ba                	add	a5,a5,a4
    80400954:	ee078823          	sb	zero,-272(a5)
    80400958:	fec42783          	lw	a5,-20(s0)
    8040095c:	853e                	mv	a0,a5
    8040095e:	70f2                	ld	ra,312(sp)
    80400960:	7452                	ld	s0,304(sp)
    80400962:	6131                	addi	sp,sp,320
    80400964:	8082                	ret

0000000080400966 <vprintk_port>:
vprintk_port():
    80400966:	1101                	addi	sp,sp,-32
    80400968:	ec06                	sd	ra,24(sp)
    8040096a:	e822                	sd	s0,16(sp)
    8040096c:	1000                	addi	s0,sp,32
    8040096e:	fea43423          	sd	a0,-24(s0)
    80400972:	feb43023          	sd	a1,-32(s0)
    80400976:	fffff617          	auipc	a2,0xfffff
    8040097a:	77260613          	addi	a2,a2,1906 # 804000e8 <port_write>
    8040097e:	fe043583          	ld	a1,-32(s0)
    80400982:	fe843503          	ld	a0,-24(s0)
    80400986:	f8bff0ef          	jal	ra,80400910 <_vprintk_port>
    8040098a:	87aa                	mv	a5,a0
    8040098c:	853e                	mv	a0,a5
    8040098e:	60e2                	ld	ra,24(sp)
    80400990:	6442                	ld	s0,16(sp)
    80400992:	6105                	addi	sp,sp,32
    80400994:	8082                	ret

0000000080400996 <printk_port>:
printk_port():
    80400996:	7159                	addi	sp,sp,-112
    80400998:	f406                	sd	ra,40(sp)
    8040099a:	f022                	sd	s0,32(sp)
    8040099c:	1800                	addi	s0,sp,48
    8040099e:	fca43c23          	sd	a0,-40(s0)
    804009a2:	e40c                	sd	a1,8(s0)
    804009a4:	e810                	sd	a2,16(s0)
    804009a6:	ec14                	sd	a3,24(s0)
    804009a8:	f018                	sd	a4,32(s0)
    804009aa:	f41c                	sd	a5,40(s0)
    804009ac:	03043823          	sd	a6,48(s0)
    804009b0:	03143c23          	sd	a7,56(s0)
    804009b4:	fe042623          	sw	zero,-20(s0)
    804009b8:	04040793          	addi	a5,s0,64
    804009bc:	fcf43823          	sd	a5,-48(s0)
    804009c0:	fd043783          	ld	a5,-48(s0)
    804009c4:	fc878793          	addi	a5,a5,-56
    804009c8:	fef43023          	sd	a5,-32(s0)
    804009cc:	fe043783          	ld	a5,-32(s0)
    804009d0:	85be                	mv	a1,a5
    804009d2:	fd843503          	ld	a0,-40(s0)
    804009d6:	f91ff0ef          	jal	ra,80400966 <vprintk_port>
    804009da:	87aa                	mv	a5,a0
    804009dc:	fef42623          	sw	a5,-20(s0)
    804009e0:	fec42783          	lw	a5,-20(s0)
    804009e4:	853e                	mv	a0,a5
    804009e6:	70a2                	ld	ra,40(sp)
    804009e8:	7402                	ld	s0,32(sp)
    804009ea:	6165                	addi	sp,sp,112
    804009ec:	8082                	ret

00000000804009ee <strlen>:
strlen():
    804009ee:	7179                	addi	sp,sp,-48
    804009f0:	f422                	sd	s0,40(sp)
    804009f2:	1800                	addi	s0,sp,48
    804009f4:	fca43c23          	sd	a0,-40(s0)
    804009f8:	fe042623          	sw	zero,-20(s0)
    804009fc:	a031                	j	80400a08 <strlen+0x1a>
    804009fe:	fec42783          	lw	a5,-20(s0)
    80400a02:	2785                	addiw	a5,a5,1
    80400a04:	fef42623          	sw	a5,-20(s0)
    80400a08:	fec42783          	lw	a5,-20(s0)
    80400a0c:	fd843703          	ld	a4,-40(s0)
    80400a10:	97ba                	add	a5,a5,a4
    80400a12:	0007c783          	lbu	a5,0(a5)
    80400a16:	f7e5                	bnez	a5,804009fe <strlen+0x10>
    80400a18:	fec42783          	lw	a5,-20(s0)
    80400a1c:	853e                	mv	a0,a5
    80400a1e:	7422                	ld	s0,40(sp)
    80400a20:	6145                	addi	sp,sp,48
    80400a22:	8082                	ret

0000000080400a24 <memcpy>:
memcpy():
    80400a24:	7179                	addi	sp,sp,-48
    80400a26:	f422                	sd	s0,40(sp)
    80400a28:	1800                	addi	s0,sp,48
    80400a2a:	fea43423          	sd	a0,-24(s0)
    80400a2e:	feb43023          	sd	a1,-32(s0)
    80400a32:	87b2                	mv	a5,a2
    80400a34:	fcf42e23          	sw	a5,-36(s0)
    80400a38:	a035                	j	80400a64 <memcpy+0x40>
    80400a3a:	fe043703          	ld	a4,-32(s0)
    80400a3e:	00170793          	addi	a5,a4,1
    80400a42:	fef43023          	sd	a5,-32(s0)
    80400a46:	fe843783          	ld	a5,-24(s0)
    80400a4a:	00178693          	addi	a3,a5,1
    80400a4e:	fed43423          	sd	a3,-24(s0)
    80400a52:	00074703          	lbu	a4,0(a4)
    80400a56:	00e78023          	sb	a4,0(a5)
    80400a5a:	fdc42783          	lw	a5,-36(s0)
    80400a5e:	37fd                	addiw	a5,a5,-1
    80400a60:	fcf42e23          	sw	a5,-36(s0)
    80400a64:	fdc42783          	lw	a5,-36(s0)
    80400a68:	2781                	sext.w	a5,a5
    80400a6a:	fbe1                	bnez	a5,80400a3a <memcpy+0x16>
    80400a6c:	0001                	nop
    80400a6e:	0001                	nop
    80400a70:	7422                	ld	s0,40(sp)
    80400a72:	6145                	addi	sp,sp,48
    80400a74:	8082                	ret

0000000080400a76 <memcmp>:
memcmp():
    80400a76:	7139                	addi	sp,sp,-64
    80400a78:	fc22                	sd	s0,56(sp)
    80400a7a:	0080                	addi	s0,sp,64
    80400a7c:	fca43c23          	sd	a0,-40(s0)
    80400a80:	fcb43823          	sd	a1,-48(s0)
    80400a84:	87b2                	mv	a5,a2
    80400a86:	fcf42623          	sw	a5,-52(s0)
    80400a8a:	fe042623          	sw	zero,-20(s0)
    80400a8e:	a8a1                	j	80400ae6 <memcmp+0x70>
    80400a90:	fec42783          	lw	a5,-20(s0)
    80400a94:	fd843703          	ld	a4,-40(s0)
    80400a98:	97ba                	add	a5,a5,a4
    80400a9a:	0007c683          	lbu	a3,0(a5)
    80400a9e:	fec42783          	lw	a5,-20(s0)
    80400aa2:	fd043703          	ld	a4,-48(s0)
    80400aa6:	97ba                	add	a5,a5,a4
    80400aa8:	0007c783          	lbu	a5,0(a5)
    80400aac:	8736                	mv	a4,a3
    80400aae:	02f70763          	beq	a4,a5,80400adc <memcmp+0x66>
    80400ab2:	fec42783          	lw	a5,-20(s0)
    80400ab6:	fd843703          	ld	a4,-40(s0)
    80400aba:	97ba                	add	a5,a5,a4
    80400abc:	0007c783          	lbu	a5,0(a5)
    80400ac0:	0007871b          	sext.w	a4,a5
    80400ac4:	fec42783          	lw	a5,-20(s0)
    80400ac8:	fd043683          	ld	a3,-48(s0)
    80400acc:	97b6                	add	a5,a5,a3
    80400ace:	0007c783          	lbu	a5,0(a5)
    80400ad2:	2781                	sext.w	a5,a5
    80400ad4:	40f707bb          	subw	a5,a4,a5
    80400ad8:	2781                	sext.w	a5,a5
    80400ada:	a831                	j	80400af6 <memcmp+0x80>
    80400adc:	fec42783          	lw	a5,-20(s0)
    80400ae0:	2785                	addiw	a5,a5,1
    80400ae2:	fef42623          	sw	a5,-20(s0)
    80400ae6:	fec42703          	lw	a4,-20(s0)
    80400aea:	fcc42783          	lw	a5,-52(s0)
    80400aee:	2781                	sext.w	a5,a5
    80400af0:	faf760e3          	bltu	a4,a5,80400a90 <memcmp+0x1a>
    80400af4:	4781                	li	a5,0
    80400af6:	853e                	mv	a0,a5
    80400af8:	7462                	ld	s0,56(sp)
    80400afa:	6121                	addi	sp,sp,64
    80400afc:	8082                	ret

0000000080400afe <memmove>:
memmove():
    80400afe:	715d                	addi	sp,sp,-80
    80400b00:	e4a2                	sd	s0,72(sp)
    80400b02:	0880                	addi	s0,sp,80
    80400b04:	fca43423          	sd	a0,-56(s0)
    80400b08:	fcb43023          	sd	a1,-64(s0)
    80400b0c:	86b2                	mv	a3,a2
    80400b0e:	fad42e23          	sw	a3,-68(s0)
    80400b12:	868a                	mv	a3,sp
    80400b14:	85b6                	mv	a1,a3
    80400b16:	fbc42683          	lw	a3,-68(s0)
    80400b1a:	02069613          	slli	a2,a3,0x20
    80400b1e:	9201                	srli	a2,a2,0x20
    80400b20:	167d                	addi	a2,a2,-1
    80400b22:	fec43423          	sd	a2,-24(s0)
    80400b26:	02069613          	slli	a2,a3,0x20
    80400b2a:	9201                	srli	a2,a2,0x20
    80400b2c:	8e32                	mv	t3,a2
    80400b2e:	4e81                	li	t4,0
    80400b30:	03de5613          	srli	a2,t3,0x3d
    80400b34:	003e9893          	slli	a7,t4,0x3
    80400b38:	011668b3          	or	a7,a2,a7
    80400b3c:	003e1813          	slli	a6,t3,0x3
    80400b40:	02069613          	slli	a2,a3,0x20
    80400b44:	9201                	srli	a2,a2,0x20
    80400b46:	8332                	mv	t1,a2
    80400b48:	4381                	li	t2,0
    80400b4a:	03d35613          	srli	a2,t1,0x3d
    80400b4e:	00339793          	slli	a5,t2,0x3
    80400b52:	8fd1                	or	a5,a5,a2
    80400b54:	00331713          	slli	a4,t1,0x3
    80400b58:	02069793          	slli	a5,a3,0x20
    80400b5c:	9381                	srli	a5,a5,0x20
    80400b5e:	07bd                	addi	a5,a5,15
    80400b60:	8391                	srli	a5,a5,0x4
    80400b62:	0792                	slli	a5,a5,0x4
    80400b64:	40f10133          	sub	sp,sp,a5
    80400b68:	878a                	mv	a5,sp
    80400b6a:	00078793          	mv	a5,a5
    80400b6e:	fef43023          	sd	a5,-32(s0)
    80400b72:	fc042e23          	sw	zero,-36(s0)
    80400b76:	a02d                	j	80400ba0 <memmove+0xa2>
    80400b78:	fc043783          	ld	a5,-64(s0)
    80400b7c:	00178713          	addi	a4,a5,1
    80400b80:	fce43023          	sd	a4,-64(s0)
    80400b84:	0007c703          	lbu	a4,0(a5)
    80400b88:	fe043683          	ld	a3,-32(s0)
    80400b8c:	fdc42783          	lw	a5,-36(s0)
    80400b90:	97b6                	add	a5,a5,a3
    80400b92:	00e78023          	sb	a4,0(a5)
    80400b96:	fbc42783          	lw	a5,-68(s0)
    80400b9a:	37fd                	addiw	a5,a5,-1
    80400b9c:	faf42e23          	sw	a5,-68(s0)
    80400ba0:	fbc42783          	lw	a5,-68(s0)
    80400ba4:	2781                	sext.w	a5,a5
    80400ba6:	fbe9                	bnez	a5,80400b78 <memmove+0x7a>
    80400ba8:	a02d                	j	80400bd2 <memmove+0xd4>
    80400baa:	fc843783          	ld	a5,-56(s0)
    80400bae:	00178713          	addi	a4,a5,1
    80400bb2:	fce43423          	sd	a4,-56(s0)
    80400bb6:	fe043683          	ld	a3,-32(s0)
    80400bba:	fdc42703          	lw	a4,-36(s0)
    80400bbe:	9736                	add	a4,a4,a3
    80400bc0:	00074703          	lbu	a4,0(a4)
    80400bc4:	00e78023          	sb	a4,0(a5)
    80400bc8:	fbc42783          	lw	a5,-68(s0)
    80400bcc:	37fd                	addiw	a5,a5,-1
    80400bce:	faf42e23          	sw	a5,-68(s0)
    80400bd2:	fbc42783          	lw	a5,-68(s0)
    80400bd6:	2781                	sext.w	a5,a5
    80400bd8:	fbe9                	bnez	a5,80400baa <memmove+0xac>
    80400bda:	812e                	mv	sp,a1
    80400bdc:	0001                	nop
    80400bde:	fb040113          	addi	sp,s0,-80
    80400be2:	6426                	ld	s0,72(sp)
    80400be4:	6161                	addi	sp,sp,80
    80400be6:	8082                	ret

0000000080400be8 <memset>:
memset():
    80400be8:	7179                	addi	sp,sp,-48
    80400bea:	f422                	sd	s0,40(sp)
    80400bec:	1800                	addi	s0,sp,48
    80400bee:	fca43c23          	sd	a0,-40(s0)
    80400bf2:	87ae                	mv	a5,a1
    80400bf4:	8732                	mv	a4,a2
    80400bf6:	fcf40ba3          	sb	a5,-41(s0)
    80400bfa:	87ba                	mv	a5,a4
    80400bfc:	fcf42823          	sw	a5,-48(s0)
    80400c00:	fd843783          	ld	a5,-40(s0)
    80400c04:	fef43423          	sd	a5,-24(s0)
    80400c08:	a005                	j	80400c28 <memset+0x40>
    80400c0a:	fe843783          	ld	a5,-24(s0)
    80400c0e:	00178713          	addi	a4,a5,1
    80400c12:	fee43423          	sd	a4,-24(s0)
    80400c16:	fd744703          	lbu	a4,-41(s0)
    80400c1a:	00e78023          	sb	a4,0(a5)
    80400c1e:	fd042783          	lw	a5,-48(s0)
    80400c22:	37fd                	addiw	a5,a5,-1
    80400c24:	fcf42823          	sw	a5,-48(s0)
    80400c28:	fd042783          	lw	a5,-48(s0)
    80400c2c:	2781                	sext.w	a5,a5
    80400c2e:	fff1                	bnez	a5,80400c0a <memset+0x22>
    80400c30:	0001                	nop
    80400c32:	0001                	nop
    80400c34:	7422                	ld	s0,40(sp)
    80400c36:	6145                	addi	sp,sp,48
    80400c38:	8082                	ret

0000000080400c3a <bzero>:
bzero():
    80400c3a:	1101                	addi	sp,sp,-32
    80400c3c:	ec06                	sd	ra,24(sp)
    80400c3e:	e822                	sd	s0,16(sp)
    80400c40:	1000                	addi	s0,sp,32
    80400c42:	fea43423          	sd	a0,-24(s0)
    80400c46:	87ae                	mv	a5,a1
    80400c48:	fef42223          	sw	a5,-28(s0)
    80400c4c:	fe442783          	lw	a5,-28(s0)
    80400c50:	863e                	mv	a2,a5
    80400c52:	4581                	li	a1,0
    80400c54:	fe843503          	ld	a0,-24(s0)
    80400c58:	f91ff0ef          	jal	ra,80400be8 <memset>
    80400c5c:	0001                	nop
    80400c5e:	60e2                	ld	ra,24(sp)
    80400c60:	6442                	ld	s0,16(sp)
    80400c62:	6105                	addi	sp,sp,32
    80400c64:	8082                	ret

0000000080400c66 <strcmp>:
strcmp():
    80400c66:	1101                	addi	sp,sp,-32
    80400c68:	ec22                	sd	s0,24(sp)
    80400c6a:	1000                	addi	s0,sp,32
    80400c6c:	fea43423          	sd	a0,-24(s0)
    80400c70:	feb43023          	sd	a1,-32(s0)
    80400c74:	a0a1                	j	80400cbc <strcmp+0x56>
    80400c76:	fe843783          	ld	a5,-24(s0)
    80400c7a:	0007c703          	lbu	a4,0(a5)
    80400c7e:	fe043783          	ld	a5,-32(s0)
    80400c82:	0007c783          	lbu	a5,0(a5)
    80400c86:	02f70163          	beq	a4,a5,80400ca8 <strcmp+0x42>
    80400c8a:	fe843783          	ld	a5,-24(s0)
    80400c8e:	0007c783          	lbu	a5,0(a5)
    80400c92:	0007871b          	sext.w	a4,a5
    80400c96:	fe043783          	ld	a5,-32(s0)
    80400c9a:	0007c783          	lbu	a5,0(a5)
    80400c9e:	2781                	sext.w	a5,a5
    80400ca0:	40f707bb          	subw	a5,a4,a5
    80400ca4:	2781                	sext.w	a5,a5
    80400ca6:	a099                	j	80400cec <strcmp+0x86>
    80400ca8:	fe843783          	ld	a5,-24(s0)
    80400cac:	0785                	addi	a5,a5,1
    80400cae:	fef43423          	sd	a5,-24(s0)
    80400cb2:	fe043783          	ld	a5,-32(s0)
    80400cb6:	0785                	addi	a5,a5,1
    80400cb8:	fef43023          	sd	a5,-32(s0)
    80400cbc:	fe843783          	ld	a5,-24(s0)
    80400cc0:	0007c783          	lbu	a5,0(a5)
    80400cc4:	c791                	beqz	a5,80400cd0 <strcmp+0x6a>
    80400cc6:	fe043783          	ld	a5,-32(s0)
    80400cca:	0007c783          	lbu	a5,0(a5)
    80400cce:	f7c5                	bnez	a5,80400c76 <strcmp+0x10>
    80400cd0:	fe843783          	ld	a5,-24(s0)
    80400cd4:	0007c783          	lbu	a5,0(a5)
    80400cd8:	0007871b          	sext.w	a4,a5
    80400cdc:	fe043783          	ld	a5,-32(s0)
    80400ce0:	0007c783          	lbu	a5,0(a5)
    80400ce4:	2781                	sext.w	a5,a5
    80400ce6:	40f707bb          	subw	a5,a4,a5
    80400cea:	2781                	sext.w	a5,a5
    80400cec:	853e                	mv	a0,a5
    80400cee:	6462                	ld	s0,24(sp)
    80400cf0:	6105                	addi	sp,sp,32
    80400cf2:	8082                	ret

0000000080400cf4 <strcpy>:
strcpy():
    80400cf4:	7179                	addi	sp,sp,-48
    80400cf6:	f422                	sd	s0,40(sp)
    80400cf8:	1800                	addi	s0,sp,48
    80400cfa:	fca43c23          	sd	a0,-40(s0)
    80400cfe:	fcb43823          	sd	a1,-48(s0)
    80400d02:	fd843783          	ld	a5,-40(s0)
    80400d06:	fef43423          	sd	a5,-24(s0)
    80400d0a:	a00d                	j	80400d2c <strcpy+0x38>
    80400d0c:	fd043703          	ld	a4,-48(s0)
    80400d10:	00170793          	addi	a5,a4,1
    80400d14:	fcf43823          	sd	a5,-48(s0)
    80400d18:	fd843783          	ld	a5,-40(s0)
    80400d1c:	00178693          	addi	a3,a5,1
    80400d20:	fcd43c23          	sd	a3,-40(s0)
    80400d24:	00074703          	lbu	a4,0(a4)
    80400d28:	00e78023          	sb	a4,0(a5)
    80400d2c:	fd043783          	ld	a5,-48(s0)
    80400d30:	0007c783          	lbu	a5,0(a5)
    80400d34:	ffe1                	bnez	a5,80400d0c <strcpy+0x18>
    80400d36:	fd843783          	ld	a5,-40(s0)
    80400d3a:	00078023          	sb	zero,0(a5)
    80400d3e:	fe843783          	ld	a5,-24(s0)
    80400d42:	853e                	mv	a0,a5
    80400d44:	7422                	ld	s0,40(sp)
    80400d46:	6145                	addi	sp,sp,48
    80400d48:	8082                	ret

0000000080400d4a <strcat>:
strcat():
    80400d4a:	7179                	addi	sp,sp,-48
    80400d4c:	f422                	sd	s0,40(sp)
    80400d4e:	1800                	addi	s0,sp,48
    80400d50:	fca43c23          	sd	a0,-40(s0)
    80400d54:	fcb43823          	sd	a1,-48(s0)
    80400d58:	fd843783          	ld	a5,-40(s0)
    80400d5c:	fef43423          	sd	a5,-24(s0)
    80400d60:	a031                	j	80400d6c <strcat+0x22>
    80400d62:	fd843783          	ld	a5,-40(s0)
    80400d66:	0785                	addi	a5,a5,1
    80400d68:	fcf43c23          	sd	a5,-40(s0)
    80400d6c:	fd843783          	ld	a5,-40(s0)
    80400d70:	0007c783          	lbu	a5,0(a5)
    80400d74:	f7fd                	bnez	a5,80400d62 <strcat+0x18>
    80400d76:	a00d                	j	80400d98 <strcat+0x4e>
    80400d78:	fd043703          	ld	a4,-48(s0)
    80400d7c:	00170793          	addi	a5,a4,1
    80400d80:	fcf43823          	sd	a5,-48(s0)
    80400d84:	fd843783          	ld	a5,-40(s0)
    80400d88:	00178693          	addi	a3,a5,1
    80400d8c:	fcd43c23          	sd	a3,-40(s0)
    80400d90:	00074703          	lbu	a4,0(a4)
    80400d94:	00e78023          	sb	a4,0(a5)
    80400d98:	fd043783          	ld	a5,-48(s0)
    80400d9c:	0007c783          	lbu	a5,0(a5)
    80400da0:	ffe1                	bnez	a5,80400d78 <strcat+0x2e>
    80400da2:	fd843783          	ld	a5,-40(s0)
    80400da6:	00078023          	sb	zero,0(a5)
    80400daa:	fe843783          	ld	a5,-24(s0)
    80400dae:	853e                	mv	a0,a5
    80400db0:	7422                	ld	s0,40(sp)
    80400db2:	6145                	addi	sp,sp,48
    80400db4:	8082                	ret

0000000080400db6 <main>:
main():
    80400db6:	1101                	addi	sp,sp,-32
    80400db8:	ec06                	sd	ra,24(sp)
    80400dba:	e822                	sd	s0,16(sp)
    80400dbc:	1000                	addi	s0,sp,32
    80400dbe:	00000517          	auipc	a0,0x0
    80400dc2:	0e250513          	addi	a0,a0,226 # 80400ea0 <main+0xea>
    80400dc6:	af3ff0ef          	jal	ra,804008b8 <printf>
    80400dca:	fe042623          	sw	zero,-20(s0)
    80400dce:	fe042423          	sw	zero,-24(s0)
    80400dd2:	a01d                	j	80400df8 <main+0x42>
    80400dd4:	fec42783          	lw	a5,-20(s0)
    80400dd8:	0017871b          	addiw	a4,a5,1
    80400ddc:	fee42623          	sw	a4,-20(s0)
    80400de0:	85be                	mv	a1,a5
    80400de2:	00000517          	auipc	a0,0x0
    80400de6:	0c650513          	addi	a0,a0,198 # 80400ea8 <main+0xf2>
    80400dea:	acfff0ef          	jal	ra,804008b8 <printf>
    80400dee:	fe842783          	lw	a5,-24(s0)
    80400df2:	2785                	addiw	a5,a5,1
    80400df4:	fef42423          	sw	a5,-24(s0)
    80400df8:	fe842783          	lw	a5,-24(s0)
    80400dfc:	0007871b          	sext.w	a4,a5
    80400e00:	47cd                	li	a5,19
    80400e02:	fce7d9e3          	bge	a5,a4,80400dd4 <main+0x1e>
    80400e06:	0001                	nop
    80400e08:	853e                	mv	a0,a5
    80400e0a:	60e2                	ld	ra,24(sp)
    80400e0c:	6442                	ld	s0,16(sp)
    80400e0e:	6105                	addi	sp,sp,32
    80400e10:	8082                	ret
