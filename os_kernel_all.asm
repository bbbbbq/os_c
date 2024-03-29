
obj/os_kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
    80200000:	0000a117          	auipc	sp,0xa
    80200004:	00010113          	mv	sp,sp
    80200008:	004000ef          	jal	ra,8020000c <main_os>

000000008020000c <main_os>:
    8020000c:	1141                	addi	sp,sp,-16
    8020000e:	e406                	sd	ra,8(sp)
    80200010:	e022                	sd	s0,0(sp)
    80200012:	0800                	addi	s0,sp,16
    80200014:	03100513          	li	a0,49
    80200018:	058000ef          	jal	ra,80200070 <console_putchar>
    8020001c:	00002517          	auipc	a0,0x2
    80200020:	fe450513          	addi	a0,a0,-28 # 80202000 <etext>
    80200024:	528000ef          	jal	ra,8020054c <print_str>
    80200028:	326010ef          	jal	ra,8020134e <init_interrupt>
    8020002c:	741000ef          	jal	ra,80200f6c <load_app_test>
    80200030:	02f000ef          	jal	ra,8020085e <task_manager_init>
    80200034:	293000ef          	jal	ra,80200ac6 <run_first_task>
    80200038:	9002                	ebreak
    8020003a:	a001                	j	8020003a <main_os+0x2e>

000000008020003c <sbi_call>:
    8020003c:	7179                	addi	sp,sp,-48
    8020003e:	f422                	sd	s0,40(sp)
    80200040:	1800                	addi	s0,sp,48
    80200042:	fea43423          	sd	a0,-24(s0)
    80200046:	feb43023          	sd	a1,-32(s0)
    8020004a:	fcc43c23          	sd	a2,-40(s0)
    8020004e:	fcd43823          	sd	a3,-48(s0)
    80200052:	fe043503          	ld	a0,-32(s0)
    80200056:	fd843583          	ld	a1,-40(s0)
    8020005a:	fd043603          	ld	a2,-48(s0)
    8020005e:	fe843883          	ld	a7,-24(s0)
    80200062:	00000073          	ecall
    80200066:	87aa                	mv	a5,a0
    80200068:	853e                	mv	a0,a5
    8020006a:	7422                	ld	s0,40(sp)
    8020006c:	6145                	addi	sp,sp,48
    8020006e:	8082                	ret

0000000080200070 <console_putchar>:
    80200070:	1101                	addi	sp,sp,-32
    80200072:	ec06                	sd	ra,24(sp)
    80200074:	e822                	sd	s0,16(sp)
    80200076:	1000                	addi	s0,sp,32
    80200078:	fea43423          	sd	a0,-24(s0)
    8020007c:	fe843783          	ld	a5,-24(s0)
    80200080:	4681                	li	a3,0
    80200082:	4601                	li	a2,0
    80200084:	85be                	mv	a1,a5
    80200086:	4505                	li	a0,1
    80200088:	fb5ff0ef          	jal	ra,8020003c <sbi_call>
    8020008c:	0001                	nop
    8020008e:	60e2                	ld	ra,24(sp)
    80200090:	6442                	ld	s0,16(sp)
    80200092:	6105                	addi	sp,sp,32
    80200094:	8082                	ret

0000000080200096 <console_getchar>:
    80200096:	1141                	addi	sp,sp,-16
    80200098:	e406                	sd	ra,8(sp)
    8020009a:	e022                	sd	s0,0(sp)
    8020009c:	0800                	addi	s0,sp,16
    8020009e:	4681                	li	a3,0
    802000a0:	4601                	li	a2,0
    802000a2:	4581                	li	a1,0
    802000a4:	4509                	li	a0,2
    802000a6:	f97ff0ef          	jal	ra,8020003c <sbi_call>
    802000aa:	87aa                	mv	a5,a0
    802000ac:	853e                	mv	a0,a5
    802000ae:	60a2                	ld	ra,8(sp)
    802000b0:	6402                	ld	s0,0(sp)
    802000b2:	0141                	addi	sp,sp,16
    802000b4:	8082                	ret

00000000802000b6 <sbi_shutdown>:
    802000b6:	1141                	addi	sp,sp,-16
    802000b8:	e406                	sd	ra,8(sp)
    802000ba:	e022                	sd	s0,0(sp)
    802000bc:	0800                	addi	s0,sp,16
    802000be:	4681                	li	a3,0
    802000c0:	4601                	li	a2,0
    802000c2:	4581                	li	a1,0
    802000c4:	4521                	li	a0,8
    802000c6:	f77ff0ef          	jal	ra,8020003c <sbi_call>
    802000ca:	87aa                	mv	a5,a0
    802000cc:	853e                	mv	a0,a5
    802000ce:	60a2                	ld	ra,8(sp)
    802000d0:	6402                	ld	s0,0(sp)
    802000d2:	0141                	addi	sp,sp,16
    802000d4:	8082                	ret

00000000802000d6 <sbi_set_timer>:
    802000d6:	1101                	addi	sp,sp,-32
    802000d8:	ec06                	sd	ra,24(sp)
    802000da:	e822                	sd	s0,16(sp)
    802000dc:	1000                	addi	s0,sp,32
    802000de:	fea43423          	sd	a0,-24(s0)
    802000e2:	fe843783          	ld	a5,-24(s0)
    802000e6:	4681                	li	a3,0
    802000e8:	4601                	li	a2,0
    802000ea:	85be                	mv	a1,a5
    802000ec:	4501                	li	a0,0
    802000ee:	f4fff0ef          	jal	ra,8020003c <sbi_call>
    802000f2:	87aa                	mv	a5,a0
    802000f4:	853e                	mv	a0,a5
    802000f6:	60e2                	ld	ra,24(sp)
    802000f8:	6442                	ld	s0,16(sp)
    802000fa:	6105                	addi	sp,sp,32
    802000fc:	8082                	ret

00000000802000fe <strlen_t>:
    802000fe:	7179                	addi	sp,sp,-48
    80200100:	f422                	sd	s0,40(sp)
    80200102:	1800                	addi	s0,sp,48
    80200104:	fca43c23          	sd	a0,-40(s0)
    80200108:	fe042623          	sw	zero,-20(s0)
    8020010c:	a031                	j	80200118 <strlen_t+0x1a>
    8020010e:	fec42783          	lw	a5,-20(s0)
    80200112:	2785                	addiw	a5,a5,1
    80200114:	fef42623          	sw	a5,-20(s0)
    80200118:	fec42783          	lw	a5,-20(s0)
    8020011c:	fd843703          	ld	a4,-40(s0)
    80200120:	97ba                	add	a5,a5,a4
    80200122:	0007c783          	lbu	a5,0(a5)
    80200126:	f7e5                	bnez	a5,8020010e <strlen_t+0x10>
    80200128:	fec42783          	lw	a5,-20(s0)
    8020012c:	853e                	mv	a0,a5
    8020012e:	7422                	ld	s0,40(sp)
    80200130:	6145                	addi	sp,sp,48
    80200132:	8082                	ret

0000000080200134 <memcpy_t>:
    80200134:	7179                	addi	sp,sp,-48
    80200136:	f422                	sd	s0,40(sp)
    80200138:	1800                	addi	s0,sp,48
    8020013a:	fea43423          	sd	a0,-24(s0)
    8020013e:	feb43023          	sd	a1,-32(s0)
    80200142:	87b2                	mv	a5,a2
    80200144:	fcf42e23          	sw	a5,-36(s0)
    80200148:	a035                	j	80200174 <memcpy_t+0x40>
    8020014a:	fe043703          	ld	a4,-32(s0)
    8020014e:	00170793          	addi	a5,a4,1
    80200152:	fef43023          	sd	a5,-32(s0)
    80200156:	fe843783          	ld	a5,-24(s0)
    8020015a:	00178693          	addi	a3,a5,1
    8020015e:	fed43423          	sd	a3,-24(s0)
    80200162:	00074703          	lbu	a4,0(a4)
    80200166:	00e78023          	sb	a4,0(a5)
    8020016a:	fdc42783          	lw	a5,-36(s0)
    8020016e:	37fd                	addiw	a5,a5,-1
    80200170:	fcf42e23          	sw	a5,-36(s0)
    80200174:	fdc42783          	lw	a5,-36(s0)
    80200178:	2781                	sext.w	a5,a5
    8020017a:	fbe1                	bnez	a5,8020014a <memcpy_t+0x16>
    8020017c:	0001                	nop
    8020017e:	0001                	nop
    80200180:	7422                	ld	s0,40(sp)
    80200182:	6145                	addi	sp,sp,48
    80200184:	8082                	ret

0000000080200186 <memcmp_t>:
    80200186:	7139                	addi	sp,sp,-64
    80200188:	fc22                	sd	s0,56(sp)
    8020018a:	0080                	addi	s0,sp,64
    8020018c:	fca43c23          	sd	a0,-40(s0)
    80200190:	fcb43823          	sd	a1,-48(s0)
    80200194:	87b2                	mv	a5,a2
    80200196:	fcf42623          	sw	a5,-52(s0)
    8020019a:	fe042623          	sw	zero,-20(s0)
    8020019e:	a8a1                	j	802001f6 <memcmp_t+0x70>
    802001a0:	fec42783          	lw	a5,-20(s0)
    802001a4:	fd843703          	ld	a4,-40(s0)
    802001a8:	97ba                	add	a5,a5,a4
    802001aa:	0007c683          	lbu	a3,0(a5)
    802001ae:	fec42783          	lw	a5,-20(s0)
    802001b2:	fd043703          	ld	a4,-48(s0)
    802001b6:	97ba                	add	a5,a5,a4
    802001b8:	0007c783          	lbu	a5,0(a5)
    802001bc:	8736                	mv	a4,a3
    802001be:	02f70763          	beq	a4,a5,802001ec <memcmp_t+0x66>
    802001c2:	fec42783          	lw	a5,-20(s0)
    802001c6:	fd843703          	ld	a4,-40(s0)
    802001ca:	97ba                	add	a5,a5,a4
    802001cc:	0007c783          	lbu	a5,0(a5)
    802001d0:	0007871b          	sext.w	a4,a5
    802001d4:	fec42783          	lw	a5,-20(s0)
    802001d8:	fd043683          	ld	a3,-48(s0)
    802001dc:	97b6                	add	a5,a5,a3
    802001de:	0007c783          	lbu	a5,0(a5)
    802001e2:	2781                	sext.w	a5,a5
    802001e4:	40f707bb          	subw	a5,a4,a5
    802001e8:	2781                	sext.w	a5,a5
    802001ea:	a831                	j	80200206 <memcmp_t+0x80>
    802001ec:	fec42783          	lw	a5,-20(s0)
    802001f0:	2785                	addiw	a5,a5,1
    802001f2:	fef42623          	sw	a5,-20(s0)
    802001f6:	fec42703          	lw	a4,-20(s0)
    802001fa:	fcc42783          	lw	a5,-52(s0)
    802001fe:	2781                	sext.w	a5,a5
    80200200:	faf760e3          	bltu	a4,a5,802001a0 <memcmp_t+0x1a>
    80200204:	4781                	li	a5,0
    80200206:	853e                	mv	a0,a5
    80200208:	7462                	ld	s0,56(sp)
    8020020a:	6121                	addi	sp,sp,64
    8020020c:	8082                	ret

000000008020020e <memmove_t>:
    8020020e:	715d                	addi	sp,sp,-80
    80200210:	e4a2                	sd	s0,72(sp)
    80200212:	0880                	addi	s0,sp,80
    80200214:	fca43423          	sd	a0,-56(s0)
    80200218:	fcb43023          	sd	a1,-64(s0)
    8020021c:	86b2                	mv	a3,a2
    8020021e:	fad42e23          	sw	a3,-68(s0)
    80200222:	868a                	mv	a3,sp
    80200224:	85b6                	mv	a1,a3
    80200226:	fbc42683          	lw	a3,-68(s0)
    8020022a:	02069613          	slli	a2,a3,0x20
    8020022e:	9201                	srli	a2,a2,0x20
    80200230:	167d                	addi	a2,a2,-1
    80200232:	fec43423          	sd	a2,-24(s0)
    80200236:	02069613          	slli	a2,a3,0x20
    8020023a:	9201                	srli	a2,a2,0x20
    8020023c:	8e32                	mv	t3,a2
    8020023e:	4e81                	li	t4,0
    80200240:	03de5613          	srli	a2,t3,0x3d
    80200244:	003e9893          	slli	a7,t4,0x3
    80200248:	011668b3          	or	a7,a2,a7
    8020024c:	003e1813          	slli	a6,t3,0x3
    80200250:	02069613          	slli	a2,a3,0x20
    80200254:	9201                	srli	a2,a2,0x20
    80200256:	8332                	mv	t1,a2
    80200258:	4381                	li	t2,0
    8020025a:	03d35613          	srli	a2,t1,0x3d
    8020025e:	00339793          	slli	a5,t2,0x3
    80200262:	8fd1                	or	a5,a5,a2
    80200264:	00331713          	slli	a4,t1,0x3
    80200268:	02069793          	slli	a5,a3,0x20
    8020026c:	9381                	srli	a5,a5,0x20
    8020026e:	07bd                	addi	a5,a5,15
    80200270:	8391                	srli	a5,a5,0x4
    80200272:	0792                	slli	a5,a5,0x4
    80200274:	40f10133          	sub	sp,sp,a5
    80200278:	878a                	mv	a5,sp
    8020027a:	00078793          	mv	a5,a5
    8020027e:	fef43023          	sd	a5,-32(s0)
    80200282:	fc042e23          	sw	zero,-36(s0)
    80200286:	a02d                	j	802002b0 <memmove_t+0xa2>
    80200288:	fc043783          	ld	a5,-64(s0)
    8020028c:	00178713          	addi	a4,a5,1
    80200290:	fce43023          	sd	a4,-64(s0)
    80200294:	0007c703          	lbu	a4,0(a5)
    80200298:	fe043683          	ld	a3,-32(s0)
    8020029c:	fdc42783          	lw	a5,-36(s0)
    802002a0:	97b6                	add	a5,a5,a3
    802002a2:	00e78023          	sb	a4,0(a5)
    802002a6:	fbc42783          	lw	a5,-68(s0)
    802002aa:	37fd                	addiw	a5,a5,-1
    802002ac:	faf42e23          	sw	a5,-68(s0)
    802002b0:	fbc42783          	lw	a5,-68(s0)
    802002b4:	2781                	sext.w	a5,a5
    802002b6:	fbe9                	bnez	a5,80200288 <memmove_t+0x7a>
    802002b8:	a02d                	j	802002e2 <memmove_t+0xd4>
    802002ba:	fc843783          	ld	a5,-56(s0)
    802002be:	00178713          	addi	a4,a5,1
    802002c2:	fce43423          	sd	a4,-56(s0)
    802002c6:	fe043683          	ld	a3,-32(s0)
    802002ca:	fdc42703          	lw	a4,-36(s0)
    802002ce:	9736                	add	a4,a4,a3
    802002d0:	00074703          	lbu	a4,0(a4)
    802002d4:	00e78023          	sb	a4,0(a5)
    802002d8:	fbc42783          	lw	a5,-68(s0)
    802002dc:	37fd                	addiw	a5,a5,-1
    802002de:	faf42e23          	sw	a5,-68(s0)
    802002e2:	fbc42783          	lw	a5,-68(s0)
    802002e6:	2781                	sext.w	a5,a5
    802002e8:	fbe9                	bnez	a5,802002ba <memmove_t+0xac>
    802002ea:	812e                	mv	sp,a1
    802002ec:	0001                	nop
    802002ee:	fb040113          	addi	sp,s0,-80
    802002f2:	6426                	ld	s0,72(sp)
    802002f4:	6161                	addi	sp,sp,80
    802002f6:	8082                	ret

00000000802002f8 <memset_t>:
    802002f8:	7179                	addi	sp,sp,-48
    802002fa:	f422                	sd	s0,40(sp)
    802002fc:	1800                	addi	s0,sp,48
    802002fe:	fca43c23          	sd	a0,-40(s0)
    80200302:	87ae                	mv	a5,a1
    80200304:	8732                	mv	a4,a2
    80200306:	fcf40ba3          	sb	a5,-41(s0)
    8020030a:	87ba                	mv	a5,a4
    8020030c:	fcf42823          	sw	a5,-48(s0)
    80200310:	fd843783          	ld	a5,-40(s0)
    80200314:	fef43423          	sd	a5,-24(s0)
    80200318:	a005                	j	80200338 <memset_t+0x40>
    8020031a:	fe843783          	ld	a5,-24(s0)
    8020031e:	00178713          	addi	a4,a5,1
    80200322:	fee43423          	sd	a4,-24(s0)
    80200326:	fd744703          	lbu	a4,-41(s0)
    8020032a:	00e78023          	sb	a4,0(a5)
    8020032e:	fd042783          	lw	a5,-48(s0)
    80200332:	37fd                	addiw	a5,a5,-1
    80200334:	fcf42823          	sw	a5,-48(s0)
    80200338:	fd042783          	lw	a5,-48(s0)
    8020033c:	2781                	sext.w	a5,a5
    8020033e:	fff1                	bnez	a5,8020031a <memset_t+0x22>
    80200340:	0001                	nop
    80200342:	0001                	nop
    80200344:	7422                	ld	s0,40(sp)
    80200346:	6145                	addi	sp,sp,48
    80200348:	8082                	ret

000000008020034a <bzero_t>:
    8020034a:	1101                	addi	sp,sp,-32
    8020034c:	ec06                	sd	ra,24(sp)
    8020034e:	e822                	sd	s0,16(sp)
    80200350:	1000                	addi	s0,sp,32
    80200352:	fea43423          	sd	a0,-24(s0)
    80200356:	87ae                	mv	a5,a1
    80200358:	fef42223          	sw	a5,-28(s0)
    8020035c:	fe442783          	lw	a5,-28(s0)
    80200360:	863e                	mv	a2,a5
    80200362:	4581                	li	a1,0
    80200364:	fe843503          	ld	a0,-24(s0)
    80200368:	f91ff0ef          	jal	ra,802002f8 <memset_t>
    8020036c:	0001                	nop
    8020036e:	60e2                	ld	ra,24(sp)
    80200370:	6442                	ld	s0,16(sp)
    80200372:	6105                	addi	sp,sp,32
    80200374:	8082                	ret

0000000080200376 <strcmp_t>:
    80200376:	1101                	addi	sp,sp,-32
    80200378:	ec22                	sd	s0,24(sp)
    8020037a:	1000                	addi	s0,sp,32
    8020037c:	fea43423          	sd	a0,-24(s0)
    80200380:	feb43023          	sd	a1,-32(s0)
    80200384:	a0a1                	j	802003cc <strcmp_t+0x56>
    80200386:	fe843783          	ld	a5,-24(s0)
    8020038a:	0007c703          	lbu	a4,0(a5)
    8020038e:	fe043783          	ld	a5,-32(s0)
    80200392:	0007c783          	lbu	a5,0(a5)
    80200396:	02f70163          	beq	a4,a5,802003b8 <strcmp_t+0x42>
    8020039a:	fe843783          	ld	a5,-24(s0)
    8020039e:	0007c783          	lbu	a5,0(a5)
    802003a2:	0007871b          	sext.w	a4,a5
    802003a6:	fe043783          	ld	a5,-32(s0)
    802003aa:	0007c783          	lbu	a5,0(a5)
    802003ae:	2781                	sext.w	a5,a5
    802003b0:	40f707bb          	subw	a5,a4,a5
    802003b4:	2781                	sext.w	a5,a5
    802003b6:	a099                	j	802003fc <strcmp_t+0x86>
    802003b8:	fe843783          	ld	a5,-24(s0)
    802003bc:	0785                	addi	a5,a5,1
    802003be:	fef43423          	sd	a5,-24(s0)
    802003c2:	fe043783          	ld	a5,-32(s0)
    802003c6:	0785                	addi	a5,a5,1
    802003c8:	fef43023          	sd	a5,-32(s0)
    802003cc:	fe843783          	ld	a5,-24(s0)
    802003d0:	0007c783          	lbu	a5,0(a5)
    802003d4:	c791                	beqz	a5,802003e0 <strcmp_t+0x6a>
    802003d6:	fe043783          	ld	a5,-32(s0)
    802003da:	0007c783          	lbu	a5,0(a5)
    802003de:	f7c5                	bnez	a5,80200386 <strcmp_t+0x10>
    802003e0:	fe843783          	ld	a5,-24(s0)
    802003e4:	0007c783          	lbu	a5,0(a5)
    802003e8:	0007871b          	sext.w	a4,a5
    802003ec:	fe043783          	ld	a5,-32(s0)
    802003f0:	0007c783          	lbu	a5,0(a5)
    802003f4:	2781                	sext.w	a5,a5
    802003f6:	40f707bb          	subw	a5,a4,a5
    802003fa:	2781                	sext.w	a5,a5
    802003fc:	853e                	mv	a0,a5
    802003fe:	6462                	ld	s0,24(sp)
    80200400:	6105                	addi	sp,sp,32
    80200402:	8082                	ret

0000000080200404 <strcpy_t>:
    80200404:	7179                	addi	sp,sp,-48
    80200406:	f422                	sd	s0,40(sp)
    80200408:	1800                	addi	s0,sp,48
    8020040a:	fca43c23          	sd	a0,-40(s0)
    8020040e:	fcb43823          	sd	a1,-48(s0)
    80200412:	fd843783          	ld	a5,-40(s0)
    80200416:	fef43423          	sd	a5,-24(s0)
    8020041a:	a00d                	j	8020043c <strcpy_t+0x38>
    8020041c:	fd043703          	ld	a4,-48(s0)
    80200420:	00170793          	addi	a5,a4,1
    80200424:	fcf43823          	sd	a5,-48(s0)
    80200428:	fd843783          	ld	a5,-40(s0)
    8020042c:	00178693          	addi	a3,a5,1
    80200430:	fcd43c23          	sd	a3,-40(s0)
    80200434:	00074703          	lbu	a4,0(a4)
    80200438:	00e78023          	sb	a4,0(a5)
    8020043c:	fd043783          	ld	a5,-48(s0)
    80200440:	0007c783          	lbu	a5,0(a5)
    80200444:	ffe1                	bnez	a5,8020041c <strcpy_t+0x18>
    80200446:	fd843783          	ld	a5,-40(s0)
    8020044a:	00078023          	sb	zero,0(a5)
    8020044e:	fe843783          	ld	a5,-24(s0)
    80200452:	853e                	mv	a0,a5
    80200454:	7422                	ld	s0,40(sp)
    80200456:	6145                	addi	sp,sp,48
    80200458:	8082                	ret

000000008020045a <strcat_t>:
    8020045a:	7179                	addi	sp,sp,-48
    8020045c:	f422                	sd	s0,40(sp)
    8020045e:	1800                	addi	s0,sp,48
    80200460:	fca43c23          	sd	a0,-40(s0)
    80200464:	fcb43823          	sd	a1,-48(s0)
    80200468:	fd843783          	ld	a5,-40(s0)
    8020046c:	fef43423          	sd	a5,-24(s0)
    80200470:	a031                	j	8020047c <strcat_t+0x22>
    80200472:	fd843783          	ld	a5,-40(s0)
    80200476:	0785                	addi	a5,a5,1
    80200478:	fcf43c23          	sd	a5,-40(s0)
    8020047c:	fd843783          	ld	a5,-40(s0)
    80200480:	0007c783          	lbu	a5,0(a5)
    80200484:	f7fd                	bnez	a5,80200472 <strcat_t+0x18>
    80200486:	a00d                	j	802004a8 <strcat_t+0x4e>
    80200488:	fd043703          	ld	a4,-48(s0)
    8020048c:	00170793          	addi	a5,a4,1
    80200490:	fcf43823          	sd	a5,-48(s0)
    80200494:	fd843783          	ld	a5,-40(s0)
    80200498:	00178693          	addi	a3,a5,1
    8020049c:	fcd43c23          	sd	a3,-40(s0)
    802004a0:	00074703          	lbu	a4,0(a4)
    802004a4:	00e78023          	sb	a4,0(a5)
    802004a8:	fd043783          	ld	a5,-48(s0)
    802004ac:	0007c783          	lbu	a5,0(a5)
    802004b0:	ffe1                	bnez	a5,80200488 <strcat_t+0x2e>
    802004b2:	fd843783          	ld	a5,-40(s0)
    802004b6:	00078023          	sb	zero,0(a5)
    802004ba:	fe843783          	ld	a5,-24(s0)
    802004be:	853e                	mv	a0,a5
    802004c0:	7422                	ld	s0,40(sp)
    802004c2:	6145                	addi	sp,sp,48
    802004c4:	8082                	ret

00000000802004c6 <memcpy>:
    802004c6:	7179                	addi	sp,sp,-48
    802004c8:	f422                	sd	s0,40(sp)
    802004ca:	1800                	addi	s0,sp,48
    802004cc:	fea43423          	sd	a0,-24(s0)
    802004d0:	feb43023          	sd	a1,-32(s0)
    802004d4:	87b2                	mv	a5,a2
    802004d6:	fcf42e23          	sw	a5,-36(s0)
    802004da:	a00d                	j	802004fc <memcpy+0x36>
    802004dc:	fe043703          	ld	a4,-32(s0)
    802004e0:	00170793          	addi	a5,a4,1
    802004e4:	fef43023          	sd	a5,-32(s0)
    802004e8:	fe843783          	ld	a5,-24(s0)
    802004ec:	00178693          	addi	a3,a5,1
    802004f0:	fed43423          	sd	a3,-24(s0)
    802004f4:	00074703          	lbu	a4,0(a4)
    802004f8:	00e78023          	sb	a4,0(a5)
    802004fc:	fdc42783          	lw	a5,-36(s0)
    80200500:	fff7871b          	addiw	a4,a5,-1
    80200504:	fce42e23          	sw	a4,-36(s0)
    80200508:	fbf1                	bnez	a5,802004dc <memcpy+0x16>
    8020050a:	0001                	nop
    8020050c:	0001                	nop
    8020050e:	7422                	ld	s0,40(sp)
    80200510:	6145                	addi	sp,sp,48
    80200512:	8082                	ret

0000000080200514 <memset>:
    80200514:	1101                	addi	sp,sp,-32
    80200516:	ec06                	sd	ra,24(sp)
    80200518:	e822                	sd	s0,16(sp)
    8020051a:	1000                	addi	s0,sp,32
    8020051c:	fea43423          	sd	a0,-24(s0)
    80200520:	87ae                	mv	a5,a1
    80200522:	8732                	mv	a4,a2
    80200524:	fef403a3          	sb	a5,-25(s0)
    80200528:	87ba                	mv	a5,a4
    8020052a:	fef42023          	sw	a5,-32(s0)
    8020052e:	fe042703          	lw	a4,-32(s0)
    80200532:	fe744783          	lbu	a5,-25(s0)
    80200536:	863a                	mv	a2,a4
    80200538:	85be                	mv	a1,a5
    8020053a:	fe843503          	ld	a0,-24(s0)
    8020053e:	dbbff0ef          	jal	ra,802002f8 <memset_t>
    80200542:	0001                	nop
    80200544:	60e2                	ld	ra,24(sp)
    80200546:	6442                	ld	s0,16(sp)
    80200548:	6105                	addi	sp,sp,32
    8020054a:	8082                	ret

000000008020054c <print_str>:
    8020054c:	1101                	addi	sp,sp,-32
    8020054e:	ec06                	sd	ra,24(sp)
    80200550:	e822                	sd	s0,16(sp)
    80200552:	1000                	addi	s0,sp,32
    80200554:	fea43423          	sd	a0,-24(s0)
    80200558:	a829                	j	80200572 <print_str+0x26>
    8020055a:	fe843783          	ld	a5,-24(s0)
    8020055e:	0007c783          	lbu	a5,0(a5)
    80200562:	853e                	mv	a0,a5
    80200564:	b0dff0ef          	jal	ra,80200070 <console_putchar>
    80200568:	fe843783          	ld	a5,-24(s0)
    8020056c:	0785                	addi	a5,a5,1
    8020056e:	fef43423          	sd	a5,-24(s0)
    80200572:	fe843783          	ld	a5,-24(s0)
    80200576:	0007c783          	lbu	a5,0(a5)
    8020057a:	f3e5                	bnez	a5,8020055a <print_str+0xe>
    8020057c:	0001                	nop
    8020057e:	0001                	nop
    80200580:	60e2                	ld	ra,24(sp)
    80200582:	6442                	ld	s0,16(sp)
    80200584:	6105                	addi	sp,sp,32
    80200586:	8082                	ret

0000000080200588 <reverse_str>:
    80200588:	7179                	addi	sp,sp,-48
    8020058a:	f422                	sd	s0,40(sp)
    8020058c:	1800                	addi	s0,sp,48
    8020058e:	fca43c23          	sd	a0,-40(s0)
    80200592:	87ae                	mv	a5,a1
    80200594:	fcf42a23          	sw	a5,-44(s0)
    80200598:	fe042623          	sw	zero,-20(s0)
    8020059c:	fd442783          	lw	a5,-44(s0)
    802005a0:	37fd                	addiw	a5,a5,-1
    802005a2:	fef42423          	sw	a5,-24(s0)
    802005a6:	a899                	j	802005fc <reverse_str+0x74>
    802005a8:	fec42783          	lw	a5,-20(s0)
    802005ac:	fd843703          	ld	a4,-40(s0)
    802005b0:	97ba                	add	a5,a5,a4
    802005b2:	0007c783          	lbu	a5,0(a5)
    802005b6:	fef403a3          	sb	a5,-25(s0)
    802005ba:	fe842783          	lw	a5,-24(s0)
    802005be:	fd843703          	ld	a4,-40(s0)
    802005c2:	973e                	add	a4,a4,a5
    802005c4:	fec42783          	lw	a5,-20(s0)
    802005c8:	fd843683          	ld	a3,-40(s0)
    802005cc:	97b6                	add	a5,a5,a3
    802005ce:	00074703          	lbu	a4,0(a4)
    802005d2:	00e78023          	sb	a4,0(a5)
    802005d6:	fe842783          	lw	a5,-24(s0)
    802005da:	fd843703          	ld	a4,-40(s0)
    802005de:	97ba                	add	a5,a5,a4
    802005e0:	fe744703          	lbu	a4,-25(s0)
    802005e4:	00e78023          	sb	a4,0(a5)
    802005e8:	fec42783          	lw	a5,-20(s0)
    802005ec:	2785                	addiw	a5,a5,1
    802005ee:	fef42623          	sw	a5,-20(s0)
    802005f2:	fe842783          	lw	a5,-24(s0)
    802005f6:	37fd                	addiw	a5,a5,-1
    802005f8:	fef42423          	sw	a5,-24(s0)
    802005fc:	fec42703          	lw	a4,-20(s0)
    80200600:	fe842783          	lw	a5,-24(s0)
    80200604:	2701                	sext.w	a4,a4
    80200606:	2781                	sext.w	a5,a5
    80200608:	faf740e3          	blt	a4,a5,802005a8 <reverse_str+0x20>
    8020060c:	0001                	nop
    8020060e:	0001                	nop
    80200610:	7422                	ld	s0,40(sp)
    80200612:	6145                	addi	sp,sp,48
    80200614:	8082                	ret

0000000080200616 <print_uint32>:
    80200616:	7139                	addi	sp,sp,-64
    80200618:	fc06                	sd	ra,56(sp)
    8020061a:	f822                	sd	s0,48(sp)
    8020061c:	0080                	addi	s0,sp,64
    8020061e:	87aa                	mv	a5,a0
    80200620:	fcf42623          	sw	a5,-52(s0)
    80200624:	fe042623          	sw	zero,-20(s0)
    80200628:	fcc42783          	lw	a5,-52(s0)
    8020062c:	2781                	sext.w	a5,a5
    8020062e:	e3ad                	bnez	a5,80200690 <print_uint32+0x7a>
    80200630:	fec42783          	lw	a5,-20(s0)
    80200634:	0017871b          	addiw	a4,a5,1
    80200638:	fee42623          	sw	a4,-20(s0)
    8020063c:	ff040713          	addi	a4,s0,-16
    80200640:	97ba                	add	a5,a5,a4
    80200642:	03000713          	li	a4,48
    80200646:	fee78423          	sb	a4,-24(a5)
    8020064a:	a099                	j	80200690 <print_uint32+0x7a>
    8020064c:	fcc42703          	lw	a4,-52(s0)
    80200650:	47a9                	li	a5,10
    80200652:	02f777bb          	remuw	a5,a4,a5
    80200656:	2781                	sext.w	a5,a5
    80200658:	fef42423          	sw	a5,-24(s0)
    8020065c:	fe842783          	lw	a5,-24(s0)
    80200660:	0ff7f713          	andi	a4,a5,255
    80200664:	fec42783          	lw	a5,-20(s0)
    80200668:	0017869b          	addiw	a3,a5,1
    8020066c:	fed42623          	sw	a3,-20(s0)
    80200670:	0307071b          	addiw	a4,a4,48
    80200674:	0ff77713          	andi	a4,a4,255
    80200678:	ff040693          	addi	a3,s0,-16
    8020067c:	97b6                	add	a5,a5,a3
    8020067e:	fee78423          	sb	a4,-24(a5)
    80200682:	fcc42703          	lw	a4,-52(s0)
    80200686:	47a9                	li	a5,10
    80200688:	02f757bb          	divuw	a5,a4,a5
    8020068c:	fcf42623          	sw	a5,-52(s0)
    80200690:	fcc42783          	lw	a5,-52(s0)
    80200694:	2781                	sext.w	a5,a5
    80200696:	fbdd                	bnez	a5,8020064c <print_uint32+0x36>
    80200698:	fec42783          	lw	a5,-20(s0)
    8020069c:	ff040713          	addi	a4,s0,-16
    802006a0:	97ba                	add	a5,a5,a4
    802006a2:	fe078423          	sb	zero,-24(a5)
    802006a6:	fec42703          	lw	a4,-20(s0)
    802006aa:	fd840793          	addi	a5,s0,-40
    802006ae:	85ba                	mv	a1,a4
    802006b0:	853e                	mv	a0,a5
    802006b2:	ed7ff0ef          	jal	ra,80200588 <reverse_str>
    802006b6:	fd840793          	addi	a5,s0,-40
    802006ba:	853e                	mv	a0,a5
    802006bc:	e91ff0ef          	jal	ra,8020054c <print_str>
    802006c0:	0001                	nop
    802006c2:	70e2                	ld	ra,56(sp)
    802006c4:	7442                	ld	s0,48(sp)
    802006c6:	6121                	addi	sp,sp,64
    802006c8:	8082                	ret

00000000802006ca <print_uint64>:
    802006ca:	7139                	addi	sp,sp,-64
    802006cc:	fc06                	sd	ra,56(sp)
    802006ce:	f822                	sd	s0,48(sp)
    802006d0:	0080                	addi	s0,sp,64
    802006d2:	fca43423          	sd	a0,-56(s0)
    802006d6:	fe042623          	sw	zero,-20(s0)
    802006da:	fc843783          	ld	a5,-56(s0)
    802006de:	e3a5                	bnez	a5,8020073e <print_uint64+0x74>
    802006e0:	fec42783          	lw	a5,-20(s0)
    802006e4:	0017871b          	addiw	a4,a5,1
    802006e8:	fee42623          	sw	a4,-20(s0)
    802006ec:	ff040713          	addi	a4,s0,-16
    802006f0:	97ba                	add	a5,a5,a4
    802006f2:	03000713          	li	a4,48
    802006f6:	fee78023          	sb	a4,-32(a5)
    802006fa:	a091                	j	8020073e <print_uint64+0x74>
    802006fc:	fc843703          	ld	a4,-56(s0)
    80200700:	47a9                	li	a5,10
    80200702:	02f777b3          	remu	a5,a4,a5
    80200706:	fef42423          	sw	a5,-24(s0)
    8020070a:	fe842783          	lw	a5,-24(s0)
    8020070e:	0ff7f713          	andi	a4,a5,255
    80200712:	fec42783          	lw	a5,-20(s0)
    80200716:	0017869b          	addiw	a3,a5,1
    8020071a:	fed42623          	sw	a3,-20(s0)
    8020071e:	0307071b          	addiw	a4,a4,48
    80200722:	0ff77713          	andi	a4,a4,255
    80200726:	ff040693          	addi	a3,s0,-16
    8020072a:	97b6                	add	a5,a5,a3
    8020072c:	fee78023          	sb	a4,-32(a5)
    80200730:	fc843703          	ld	a4,-56(s0)
    80200734:	47a9                	li	a5,10
    80200736:	02f757b3          	divu	a5,a4,a5
    8020073a:	fcf43423          	sd	a5,-56(s0)
    8020073e:	fc843783          	ld	a5,-56(s0)
    80200742:	ffcd                	bnez	a5,802006fc <print_uint64+0x32>
    80200744:	fec42783          	lw	a5,-20(s0)
    80200748:	ff040713          	addi	a4,s0,-16
    8020074c:	97ba                	add	a5,a5,a4
    8020074e:	fe078023          	sb	zero,-32(a5)
    80200752:	fec42703          	lw	a4,-20(s0)
    80200756:	fd040793          	addi	a5,s0,-48
    8020075a:	85ba                	mv	a1,a4
    8020075c:	853e                	mv	a0,a5
    8020075e:	e2bff0ef          	jal	ra,80200588 <reverse_str>
    80200762:	fd040793          	addi	a5,s0,-48
    80200766:	853e                	mv	a0,a5
    80200768:	de5ff0ef          	jal	ra,8020054c <print_str>
    8020076c:	0001                	nop
    8020076e:	70e2                	ld	ra,56(sp)
    80200770:	7442                	ld	s0,48(sp)
    80200772:	6121                	addi	sp,sp,64
    80200774:	8082                	ret

0000000080200776 <print_uint64_hex>:
    80200776:	7179                	addi	sp,sp,-48
    80200778:	f406                	sd	ra,40(sp)
    8020077a:	f022                	sd	s0,32(sp)
    8020077c:	1800                	addi	s0,sp,48
    8020077e:	fca43c23          	sd	a0,-40(s0)
    80200782:	00002517          	auipc	a0,0x2
    80200786:	88650513          	addi	a0,a0,-1914 # 80202008 <etext+0x8>
    8020078a:	dc3ff0ef          	jal	ra,8020054c <print_str>
    8020078e:	47bd                	li	a5,15
    80200790:	fef42623          	sw	a5,-20(s0)
    80200794:	a09d                	j	802007fa <print_uint64_hex+0x84>
    80200796:	fec42783          	lw	a5,-20(s0)
    8020079a:	0027979b          	slliw	a5,a5,0x2
    8020079e:	2781                	sext.w	a5,a5
    802007a0:	873e                	mv	a4,a5
    802007a2:	fd843783          	ld	a5,-40(s0)
    802007a6:	00e7d7b3          	srl	a5,a5,a4
    802007aa:	2781                	sext.w	a5,a5
    802007ac:	8bbd                	andi	a5,a5,15
    802007ae:	fef42423          	sw	a5,-24(s0)
    802007b2:	fe842783          	lw	a5,-24(s0)
    802007b6:	0007871b          	sext.w	a4,a5
    802007ba:	47a5                	li	a5,9
    802007bc:	00e7cb63          	blt	a5,a4,802007d2 <print_uint64_hex+0x5c>
    802007c0:	fe842783          	lw	a5,-24(s0)
    802007c4:	0ff7f793          	andi	a5,a5,255
    802007c8:	0307879b          	addiw	a5,a5,48
    802007cc:	0ff7f793          	andi	a5,a5,255
    802007d0:	a809                	j	802007e2 <print_uint64_hex+0x6c>
    802007d2:	fe842783          	lw	a5,-24(s0)
    802007d6:	0ff7f793          	andi	a5,a5,255
    802007da:	0377879b          	addiw	a5,a5,55
    802007de:	0ff7f793          	andi	a5,a5,255
    802007e2:	fef403a3          	sb	a5,-25(s0)
    802007e6:	fe744783          	lbu	a5,-25(s0)
    802007ea:	853e                	mv	a0,a5
    802007ec:	885ff0ef          	jal	ra,80200070 <console_putchar>
    802007f0:	fec42783          	lw	a5,-20(s0)
    802007f4:	37fd                	addiw	a5,a5,-1
    802007f6:	fef42623          	sw	a5,-20(s0)
    802007fa:	fec42783          	lw	a5,-20(s0)
    802007fe:	2781                	sext.w	a5,a5
    80200800:	f807dbe3          	bgez	a5,80200796 <print_uint64_hex+0x20>
    80200804:	0001                	nop
    80200806:	0001                	nop
    80200808:	70a2                	ld	ra,40(sp)
    8020080a:	7402                	ld	s0,32(sp)
    8020080c:	6145                	addi	sp,sp,48
    8020080e:	8082                	ret

0000000080200810 <panic>:
    80200810:	1101                	addi	sp,sp,-32
    80200812:	ec06                	sd	ra,24(sp)
    80200814:	e822                	sd	s0,16(sp)
    80200816:	1000                	addi	s0,sp,32
    80200818:	fea43423          	sd	a0,-24(s0)
    8020081c:	87ae                	mv	a5,a1
    8020081e:	fef42223          	sw	a5,-28(s0)
    80200822:	00001517          	auipc	a0,0x1
    80200826:	7ee50513          	addi	a0,a0,2030 # 80202010 <etext+0x10>
    8020082a:	d23ff0ef          	jal	ra,8020054c <print_str>
    8020082e:	fe843503          	ld	a0,-24(s0)
    80200832:	d1bff0ef          	jal	ra,8020054c <print_str>
    80200836:	00001517          	auipc	a0,0x1
    8020083a:	7ea50513          	addi	a0,a0,2026 # 80202020 <etext+0x20>
    8020083e:	d0fff0ef          	jal	ra,8020054c <print_str>
    80200842:	fe442783          	lw	a5,-28(s0)
    80200846:	853e                	mv	a0,a5
    80200848:	dcfff0ef          	jal	ra,80200616 <print_uint32>
    8020084c:	00001517          	auipc	a0,0x1
    80200850:	7e450513          	addi	a0,a0,2020 # 80202030 <etext+0x30>
    80200854:	cf9ff0ef          	jal	ra,8020054c <print_str>
    80200858:	85fff0ef          	jal	ra,802000b6 <sbi_shutdown>
    8020085c:	a001                	j	8020085c <panic+0x4c>

000000008020085e <task_manager_init>:
    8020085e:	7129                	addi	sp,sp,-320
    80200860:	fe06                	sd	ra,312(sp)
    80200862:	fa22                	sd	s0,304(sp)
    80200864:	0280                	addi	s0,sp,320
    80200866:	00001517          	auipc	a0,0x1
    8020086a:	7d250513          	addi	a0,a0,2002 # 80202038 <etext+0x38>
    8020086e:	cdfff0ef          	jal	ra,8020054c <print_str>
    80200872:	00001797          	auipc	a5,0x1
    80200876:	06a78793          	addi	a5,a5,106 # 802018dc <__restore>
    8020087a:	853e                	mv	a0,a5
    8020087c:	e4fff0ef          	jal	ra,802006ca <print_uint64>
    80200880:	00001517          	auipc	a0,0x1
    80200884:	7d050513          	addi	a0,a0,2000 # 80202050 <etext+0x50>
    80200888:	cc5ff0ef          	jal	ra,8020054c <print_str>
    8020088c:	00009797          	auipc	a5,0x9
    80200890:	77c78793          	addi	a5,a5,1916 # 8020a008 <task_manager>
    80200894:	4751                	li	a4,20
    80200896:	e398                	sd	a4,0(a5)
    80200898:	00009797          	auipc	a5,0x9
    8020089c:	77078793          	addi	a5,a5,1904 # 8020a008 <task_manager>
    802008a0:	0007b423          	sd	zero,8(a5)
    802008a4:	fe043423          	sd	zero,-24(s0)
    802008a8:	a8d1                	j	8020097c <task_manager_init+0x11e>
    802008aa:	fe843503          	ld	a0,-24(s0)
    802008ae:	009000ef          	jal	ra,802010b6 <get_kernel_stack_top>
    802008b2:	87aa                	mv	a5,a0
    802008b4:	ef078793          	addi	a5,a5,-272
    802008b8:	fef43023          	sd	a5,-32(s0)
    802008bc:	00009697          	auipc	a3,0x9
    802008c0:	74c68693          	addi	a3,a3,1868 # 8020a008 <task_manager>
    802008c4:	fe843703          	ld	a4,-24(s0)
    802008c8:	87ba                	mv	a5,a4
    802008ca:	0792                	slli	a5,a5,0x4
    802008cc:	8f99                	sub	a5,a5,a4
    802008ce:	078e                	slli	a5,a5,0x3
    802008d0:	97b6                	add	a5,a5,a3
    802008d2:	4705                	li	a4,1
    802008d4:	08e7a023          	sw	a4,128(a5)
    802008d8:	00001697          	auipc	a3,0x1
    802008dc:	00468693          	addi	a3,a3,4 # 802018dc <__restore>
    802008e0:	00009617          	auipc	a2,0x9
    802008e4:	72860613          	addi	a2,a2,1832 # 8020a008 <task_manager>
    802008e8:	fe843703          	ld	a4,-24(s0)
    802008ec:	87ba                	mv	a5,a4
    802008ee:	0792                	slli	a5,a5,0x4
    802008f0:	8f99                	sub	a5,a5,a4
    802008f2:	078e                	slli	a5,a5,0x3
    802008f4:	97b2                	add	a5,a5,a2
    802008f6:	eb94                	sd	a3,16(a5)
    802008f8:	00009697          	auipc	a3,0x9
    802008fc:	71068693          	addi	a3,a3,1808 # 8020a008 <task_manager>
    80200900:	fe843703          	ld	a4,-24(s0)
    80200904:	87ba                	mv	a5,a4
    80200906:	0792                	slli	a5,a5,0x4
    80200908:	8f99                	sub	a5,a5,a4
    8020090a:	078e                	slli	a5,a5,0x3
    8020090c:	97b6                	add	a5,a5,a3
    8020090e:	fe043703          	ld	a4,-32(s0)
    80200912:	ef98                	sd	a4,24(a5)
    80200914:	ec840793          	addi	a5,s0,-312
    80200918:	11000713          	li	a4,272
    8020091c:	863a                	mv	a2,a4
    8020091e:	4581                	li	a1,0
    80200920:	853e                	mv	a0,a5
    80200922:	bf3ff0ef          	jal	ra,80200514 <memset>
    80200926:	fe843703          	ld	a4,-24(s0)
    8020092a:	6791                	lui	a5,0x4
    8020092c:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    80200930:	97ba                	add	a5,a5,a4
    80200932:	07c6                	slli	a5,a5,0x11
    80200934:	fcf43823          	sd	a5,-48(s0)
    80200938:	100027f3          	csrr	a5,sstatus
    8020093c:	fcf43c23          	sd	a5,-40(s0)
    80200940:	fd843783          	ld	a5,-40(s0)
    80200944:	eff7f793          	andi	a5,a5,-257
    80200948:	fcf43423          	sd	a5,-56(s0)
    8020094c:	fe843503          	ld	a0,-24(s0)
    80200950:	790000ef          	jal	ra,802010e0 <get_user_stack_top>
    80200954:	87aa                	mv	a5,a0
    80200956:	ecf43c23          	sd	a5,-296(s0)
    8020095a:	fe043783          	ld	a5,-32(s0)
    8020095e:	86be                	mv	a3,a5
    80200960:	ec840793          	addi	a5,s0,-312
    80200964:	11000713          	li	a4,272
    80200968:	863a                	mv	a2,a4
    8020096a:	85be                	mv	a1,a5
    8020096c:	8536                	mv	a0,a3
    8020096e:	b59ff0ef          	jal	ra,802004c6 <memcpy>
    80200972:	fe843783          	ld	a5,-24(s0)
    80200976:	0785                	addi	a5,a5,1
    80200978:	fef43423          	sd	a5,-24(s0)
    8020097c:	fe843703          	ld	a4,-24(s0)
    80200980:	47cd                	li	a5,19
    80200982:	f2e7f4e3          	bgeu	a5,a4,802008aa <task_manager_init+0x4c>
    80200986:	0001                	nop
    80200988:	0001                	nop
    8020098a:	70f2                	ld	ra,312(sp)
    8020098c:	7452                	ld	s0,304(sp)
    8020098e:	6131                	addi	sp,sp,320
    80200990:	8082                	ret

0000000080200992 <run_next_task>:
    80200992:	7139                	addi	sp,sp,-64
    80200994:	fc06                	sd	ra,56(sp)
    80200996:	f822                	sd	s0,48(sp)
    80200998:	0080                	addi	s0,sp,64
    8020099a:	fca43423          	sd	a0,-56(s0)
    8020099e:	00009797          	auipc	a5,0x9
    802009a2:	66a78793          	addi	a5,a5,1642 # 8020a008 <task_manager>
    802009a6:	679c                	ld	a5,8(a5)
    802009a8:	00178713          	addi	a4,a5,1
    802009ac:	47d1                	li	a5,20
    802009ae:	02f777b3          	remu	a5,a4,a5
    802009b2:	fef43423          	sd	a5,-24(s0)
    802009b6:	a81d                	j	802009ec <run_next_task+0x5a>
    802009b8:	00009697          	auipc	a3,0x9
    802009bc:	65068693          	addi	a3,a3,1616 # 8020a008 <task_manager>
    802009c0:	fe843703          	ld	a4,-24(s0)
    802009c4:	87ba                	mv	a5,a4
    802009c6:	0792                	slli	a5,a5,0x4
    802009c8:	8f99                	sub	a5,a5,a4
    802009ca:	078e                	slli	a5,a5,0x3
    802009cc:	97b6                	add	a5,a5,a3
    802009ce:	0807a783          	lw	a5,128(a5)
    802009d2:	873e                	mv	a4,a5
    802009d4:	4785                	li	a5,1
    802009d6:	02f70563          	beq	a4,a5,80200a00 <run_next_task+0x6e>
    802009da:	fe843783          	ld	a5,-24(s0)
    802009de:	00178713          	addi	a4,a5,1
    802009e2:	47d1                	li	a5,20
    802009e4:	02f777b3          	remu	a5,a4,a5
    802009e8:	fef43423          	sd	a5,-24(s0)
    802009ec:	00009797          	auipc	a5,0x9
    802009f0:	61c78793          	addi	a5,a5,1564 # 8020a008 <task_manager>
    802009f4:	679c                	ld	a5,8(a5)
    802009f6:	fe843703          	ld	a4,-24(s0)
    802009fa:	faf71fe3          	bne	a4,a5,802009b8 <run_next_task+0x26>
    802009fe:	a011                	j	80200a02 <run_next_task+0x70>
    80200a00:	0001                	nop
    80200a02:	00009797          	auipc	a5,0x9
    80200a06:	60678793          	addi	a5,a5,1542 # 8020a008 <task_manager>
    80200a0a:	679c                	ld	a5,8(a5)
    80200a0c:	fe843703          	ld	a4,-24(s0)
    80200a10:	02f71b63          	bne	a4,a5,80200a46 <run_next_task+0xb4>
    80200a14:	00009697          	auipc	a3,0x9
    80200a18:	5f468693          	addi	a3,a3,1524 # 8020a008 <task_manager>
    80200a1c:	fe843703          	ld	a4,-24(s0)
    80200a20:	87ba                	mv	a5,a4
    80200a22:	0792                	slli	a5,a5,0x4
    80200a24:	8f99                	sub	a5,a5,a4
    80200a26:	078e                	slli	a5,a5,0x3
    80200a28:	97b6                	add	a5,a5,a3
    80200a2a:	0807a783          	lw	a5,128(a5)
    80200a2e:	873e                	mv	a4,a5
    80200a30:	4785                	li	a5,1
    80200a32:	00f70a63          	beq	a4,a5,80200a46 <run_next_task+0xb4>
    80200a36:	03900593          	li	a1,57
    80200a3a:	00001517          	auipc	a0,0x1
    80200a3e:	61e50513          	addi	a0,a0,1566 # 80202058 <etext+0x58>
    80200a42:	dcfff0ef          	jal	ra,80200810 <panic>
    80200a46:	fe843703          	ld	a4,-24(s0)
    80200a4a:	87ba                	mv	a5,a4
    80200a4c:	0792                	slli	a5,a5,0x4
    80200a4e:	8f99                	sub	a5,a5,a4
    80200a50:	078e                	slli	a5,a5,0x3
    80200a52:	01078713          	addi	a4,a5,16
    80200a56:	00009797          	auipc	a5,0x9
    80200a5a:	5b278793          	addi	a5,a5,1458 # 8020a008 <task_manager>
    80200a5e:	97ba                	add	a5,a5,a4
    80200a60:	fef43023          	sd	a5,-32(s0)
    80200a64:	00009797          	auipc	a5,0x9
    80200a68:	5a478793          	addi	a5,a5,1444 # 8020a008 <task_manager>
    80200a6c:	6798                	ld	a4,8(a5)
    80200a6e:	87ba                	mv	a5,a4
    80200a70:	0792                	slli	a5,a5,0x4
    80200a72:	8f99                	sub	a5,a5,a4
    80200a74:	078e                	slli	a5,a5,0x3
    80200a76:	01078713          	addi	a4,a5,16
    80200a7a:	00009797          	auipc	a5,0x9
    80200a7e:	58e78793          	addi	a5,a5,1422 # 8020a008 <task_manager>
    80200a82:	97ba                	add	a5,a5,a4
    80200a84:	fcf43c23          	sd	a5,-40(s0)
    80200a88:	fc843783          	ld	a5,-56(s0)
    80200a8c:	0007871b          	sext.w	a4,a5
    80200a90:	fd843783          	ld	a5,-40(s0)
    80200a94:	dbb8                	sw	a4,112(a5)
    80200a96:	fe043783          	ld	a5,-32(s0)
    80200a9a:	4709                	li	a4,2
    80200a9c:	dbb8                	sw	a4,112(a5)
    80200a9e:	00009797          	auipc	a5,0x9
    80200aa2:	56a78793          	addi	a5,a5,1386 # 8020a008 <task_manager>
    80200aa6:	fe843703          	ld	a4,-24(s0)
    80200aaa:	e798                	sd	a4,8(a5)
    80200aac:	fd843783          	ld	a5,-40(s0)
    80200ab0:	fe043703          	ld	a4,-32(s0)
    80200ab4:	85ba                	mv	a1,a4
    80200ab6:	853e                	mv	a0,a5
    80200ab8:	683000ef          	jal	ra,8020193a <__switch>
    80200abc:	0001                	nop
    80200abe:	70e2                	ld	ra,56(sp)
    80200ac0:	7442                	ld	s0,48(sp)
    80200ac2:	6121                	addi	sp,sp,64
    80200ac4:	8082                	ret

0000000080200ac6 <run_first_task>:
    80200ac6:	1141                	addi	sp,sp,-16
    80200ac8:	e406                	sd	ra,8(sp)
    80200aca:	e022                	sd	s0,0(sp)
    80200acc:	0800                	addi	s0,sp,16
    80200ace:	00009797          	auipc	a5,0x9
    80200ad2:	53a78793          	addi	a5,a5,1338 # 8020a008 <task_manager>
    80200ad6:	6798                	ld	a4,8(a5)
    80200ad8:	00009697          	auipc	a3,0x9
    80200adc:	53068693          	addi	a3,a3,1328 # 8020a008 <task_manager>
    80200ae0:	87ba                	mv	a5,a4
    80200ae2:	0792                	slli	a5,a5,0x4
    80200ae4:	8f99                	sub	a5,a5,a4
    80200ae6:	078e                	slli	a5,a5,0x3
    80200ae8:	97b6                	add	a5,a5,a3
    80200aea:	4709                	li	a4,2
    80200aec:	08e7a023          	sw	a4,128(a5)
    80200af0:	00001517          	auipc	a0,0x1
    80200af4:	58850513          	addi	a0,a0,1416 # 80202078 <etext+0x78>
    80200af8:	a55ff0ef          	jal	ra,8020054c <print_str>
    80200afc:	00009797          	auipc	a5,0x9
    80200b00:	50c78793          	addi	a5,a5,1292 # 8020a008 <task_manager>
    80200b04:	6798                	ld	a4,8(a5)
    80200b06:	87ba                	mv	a5,a4
    80200b08:	0792                	slli	a5,a5,0x4
    80200b0a:	8f99                	sub	a5,a5,a4
    80200b0c:	078e                	slli	a5,a5,0x3
    80200b0e:	01078713          	addi	a4,a5,16
    80200b12:	00009797          	auipc	a5,0x9
    80200b16:	4f678793          	addi	a5,a5,1270 # 8020a008 <task_manager>
    80200b1a:	97ba                	add	a5,a5,a4
    80200b1c:	85be                	mv	a1,a5
    80200b1e:	0000a517          	auipc	a0,0xa
    80200b22:	e5a50513          	addi	a0,a0,-422 # 8020a978 <temp.0>
    80200b26:	615000ef          	jal	ra,8020193a <__switch>
    80200b2a:	04f00593          	li	a1,79
    80200b2e:	00001517          	auipc	a0,0x1
    80200b32:	52a50513          	addi	a0,a0,1322 # 80202058 <etext+0x58>
    80200b36:	cdbff0ef          	jal	ra,80200810 <panic>
    80200b3a:	0001                	nop
    80200b3c:	60a2                	ld	ra,8(sp)
    80200b3e:	6402                	ld	s0,0(sp)
    80200b40:	0141                	addi	sp,sp,16
    80200b42:	8082                	ret

0000000080200b44 <init_appmanager>:
    80200b44:	1101                	addi	sp,sp,-32
    80200b46:	ec06                	sd	ra,24(sp)
    80200b48:	e822                	sd	s0,16(sp)
    80200b4a:	1000                	addi	s0,sp,32
    80200b4c:	00002797          	auipc	a5,0x2
    80200b50:	4b478793          	addi	a5,a5,1204 # 80203000 <_num_app>
    80200b54:	6398                	ld	a4,0(a5)
    80200b56:	0000a797          	auipc	a5,0xa
    80200b5a:	e9278793          	addi	a5,a5,-366 # 8020a9e8 <app_manager>
    80200b5e:	e398                	sd	a4,0(a5)
    80200b60:	fe043423          	sd	zero,-24(s0)
    80200b64:	a085                	j	80200bc4 <init_appmanager+0x80>
    80200b66:	fe843783          	ld	a5,-24(s0)
    80200b6a:	0786                	slli	a5,a5,0x1
    80200b6c:	0785                	addi	a5,a5,1
    80200b6e:	00002717          	auipc	a4,0x2
    80200b72:	49270713          	addi	a4,a4,1170 # 80203000 <_num_app>
    80200b76:	078e                	slli	a5,a5,0x3
    80200b78:	97ba                	add	a5,a5,a4
    80200b7a:	6398                	ld	a4,0(a5)
    80200b7c:	0000a697          	auipc	a3,0xa
    80200b80:	e6c68693          	addi	a3,a3,-404 # 8020a9e8 <app_manager>
    80200b84:	fe843783          	ld	a5,-24(s0)
    80200b88:	0789                	addi	a5,a5,2
    80200b8a:	078e                	slli	a5,a5,0x3
    80200b8c:	97b6                	add	a5,a5,a3
    80200b8e:	e398                	sd	a4,0(a5)
    80200b90:	fe843783          	ld	a5,-24(s0)
    80200b94:	0785                	addi	a5,a5,1
    80200b96:	0786                	slli	a5,a5,0x1
    80200b98:	00002717          	auipc	a4,0x2
    80200b9c:	46870713          	addi	a4,a4,1128 # 80203000 <_num_app>
    80200ba0:	078e                	slli	a5,a5,0x3
    80200ba2:	97ba                	add	a5,a5,a4
    80200ba4:	6398                	ld	a4,0(a5)
    80200ba6:	0000a697          	auipc	a3,0xa
    80200baa:	e4268693          	addi	a3,a3,-446 # 8020a9e8 <app_manager>
    80200bae:	fe843783          	ld	a5,-24(s0)
    80200bb2:	07d9                	addi	a5,a5,22
    80200bb4:	078e                	slli	a5,a5,0x3
    80200bb6:	97b6                	add	a5,a5,a3
    80200bb8:	e398                	sd	a4,0(a5)
    80200bba:	fe843783          	ld	a5,-24(s0)
    80200bbe:	0785                	addi	a5,a5,1
    80200bc0:	fef43423          	sd	a5,-24(s0)
    80200bc4:	0000a797          	auipc	a5,0xa
    80200bc8:	e2478793          	addi	a5,a5,-476 # 8020a9e8 <app_manager>
    80200bcc:	639c                	ld	a5,0(a5)
    80200bce:	fe843703          	ld	a4,-24(s0)
    80200bd2:	f8f76ae3          	bltu	a4,a5,80200b66 <init_appmanager+0x22>
    80200bd6:	0000a797          	auipc	a5,0xa
    80200bda:	e1278793          	addi	a5,a5,-494 # 8020a9e8 <app_manager>
    80200bde:	0007b423          	sd	zero,8(a5)
    80200be2:	0000a517          	auipc	a0,0xa
    80200be6:	e0650513          	addi	a0,a0,-506 # 8020a9e8 <app_manager>
    80200bea:	0fe000ef          	jal	ra,80200ce8 <print_app_info>
    80200bee:	0001                	nop
    80200bf0:	60e2                	ld	ra,24(sp)
    80200bf2:	6442                	ld	s0,16(sp)
    80200bf4:	6105                	addi	sp,sp,32
    80200bf6:	8082                	ret

0000000080200bf8 <load_app>:
    80200bf8:	7139                	addi	sp,sp,-64
    80200bfa:	fc06                	sd	ra,56(sp)
    80200bfc:	f822                	sd	s0,48(sp)
    80200bfe:	0080                	addi	s0,sp,64
    80200c00:	fca43423          	sd	a0,-56(s0)
    80200c04:	0000a797          	auipc	a5,0xa
    80200c08:	de478793          	addi	a5,a5,-540 # 8020a9e8 <app_manager>
    80200c0c:	639c                	ld	a5,0(a5)
    80200c0e:	fc843703          	ld	a4,-56(s0)
    80200c12:	00f76a63          	bltu	a4,a5,80200c26 <load_app+0x2e>
    80200c16:	45f1                	li	a1,28
    80200c18:	00001517          	auipc	a0,0x1
    80200c1c:	48850513          	addi	a0,a0,1160 # 802020a0 <etext+0xa0>
    80200c20:	bf1ff0ef          	jal	ra,80200810 <panic>
    80200c24:	a875                	j	80200ce0 <load_app+0xe8>
    80200c26:	00001517          	auipc	a0,0x1
    80200c2a:	49250513          	addi	a0,a0,1170 # 802020b8 <etext+0xb8>
    80200c2e:	91fff0ef          	jal	ra,8020054c <print_str>
    80200c32:	fc843503          	ld	a0,-56(s0)
    80200c36:	a95ff0ef          	jal	ra,802006ca <print_uint64>
    80200c3a:	00001517          	auipc	a0,0x1
    80200c3e:	49650513          	addi	a0,a0,1174 # 802020d0 <etext+0xd0>
    80200c42:	90bff0ef          	jal	ra,8020054c <print_str>
    80200c46:	00020637          	lui	a2,0x20
    80200c4a:	4581                	li	a1,0
    80200c4c:	20100793          	li	a5,513
    80200c50:	01679513          	slli	a0,a5,0x16
    80200c54:	ea4ff0ef          	jal	ra,802002f8 <memset_t>
    80200c58:	0000a797          	auipc	a5,0xa
    80200c5c:	d9078793          	addi	a5,a5,-624 # 8020a9e8 <app_manager>
    80200c60:	639c                	ld	a5,0(a5)
    80200c62:	17fd                	addi	a5,a5,-1
    80200c64:	fc843703          	ld	a4,-56(s0)
    80200c68:	02f77b63          	bgeu	a4,a5,80200c9e <load_app+0xa6>
    80200c6c:	0000a717          	auipc	a4,0xa
    80200c70:	d7c70713          	addi	a4,a4,-644 # 8020a9e8 <app_manager>
    80200c74:	fc843783          	ld	a5,-56(s0)
    80200c78:	0789                	addi	a5,a5,2
    80200c7a:	078e                	slli	a5,a5,0x3
    80200c7c:	97ba                	add	a5,a5,a4
    80200c7e:	6398                	ld	a4,0(a5)
    80200c80:	0000a697          	auipc	a3,0xa
    80200c84:	d6868693          	addi	a3,a3,-664 # 8020a9e8 <app_manager>
    80200c88:	fc843783          	ld	a5,-56(s0)
    80200c8c:	07d9                	addi	a5,a5,22
    80200c8e:	078e                	slli	a5,a5,0x3
    80200c90:	97b6                	add	a5,a5,a3
    80200c92:	639c                	ld	a5,0(a5)
    80200c94:	40f707b3          	sub	a5,a4,a5
    80200c98:	fef43423          	sd	a5,-24(s0)
    80200c9c:	a029                	j	80200ca6 <load_app+0xae>
    80200c9e:	000207b7          	lui	a5,0x20
    80200ca2:	fef43423          	sd	a5,-24(s0)
    80200ca6:	0000a717          	auipc	a4,0xa
    80200caa:	d4270713          	addi	a4,a4,-702 # 8020a9e8 <app_manager>
    80200cae:	fc843783          	ld	a5,-56(s0)
    80200cb2:	0789                	addi	a5,a5,2
    80200cb4:	078e                	slli	a5,a5,0x3
    80200cb6:	97ba                	add	a5,a5,a4
    80200cb8:	639c                	ld	a5,0(a5)
    80200cba:	fef43023          	sd	a5,-32(s0)
    80200cbe:	20100793          	li	a5,513
    80200cc2:	07da                	slli	a5,a5,0x16
    80200cc4:	fcf43c23          	sd	a5,-40(s0)
    80200cc8:	fe843783          	ld	a5,-24(s0)
    80200ccc:	2781                	sext.w	a5,a5
    80200cce:	863e                	mv	a2,a5
    80200cd0:	fe043583          	ld	a1,-32(s0)
    80200cd4:	fd843503          	ld	a0,-40(s0)
    80200cd8:	c5cff0ef          	jal	ra,80200134 <memcpy_t>
    80200cdc:	0000100f          	fence.i
    80200ce0:	70e2                	ld	ra,56(sp)
    80200ce2:	7442                	ld	s0,48(sp)
    80200ce4:	6121                	addi	sp,sp,64
    80200ce6:	8082                	ret

0000000080200ce8 <print_app_info>:
    80200ce8:	7179                	addi	sp,sp,-48
    80200cea:	f406                	sd	ra,40(sp)
    80200cec:	f022                	sd	s0,32(sp)
    80200cee:	1800                	addi	s0,sp,48
    80200cf0:	fca43c23          	sd	a0,-40(s0)
    80200cf4:	00001517          	auipc	a0,0x1
    80200cf8:	3e450513          	addi	a0,a0,996 # 802020d8 <etext+0xd8>
    80200cfc:	851ff0ef          	jal	ra,8020054c <print_str>
    80200d00:	fd843783          	ld	a5,-40(s0)
    80200d04:	639c                	ld	a5,0(a5)
    80200d06:	853e                	mv	a0,a5
    80200d08:	9c3ff0ef          	jal	ra,802006ca <print_uint64>
    80200d0c:	00001517          	auipc	a0,0x1
    80200d10:	3c450513          	addi	a0,a0,964 # 802020d0 <etext+0xd0>
    80200d14:	839ff0ef          	jal	ra,8020054c <print_str>
    80200d18:	fe043423          	sd	zero,-24(s0)
    80200d1c:	a885                	j	80200d8c <print_app_info+0xa4>
    80200d1e:	00001517          	auipc	a0,0x1
    80200d22:	3d250513          	addi	a0,a0,978 # 802020f0 <etext+0xf0>
    80200d26:	827ff0ef          	jal	ra,8020054c <print_str>
    80200d2a:	fe843503          	ld	a0,-24(s0)
    80200d2e:	99dff0ef          	jal	ra,802006ca <print_uint64>
    80200d32:	00001517          	auipc	a0,0x1
    80200d36:	3c650513          	addi	a0,a0,966 # 802020f8 <etext+0xf8>
    80200d3a:	813ff0ef          	jal	ra,8020054c <print_str>
    80200d3e:	fd843703          	ld	a4,-40(s0)
    80200d42:	fe843783          	ld	a5,-24(s0)
    80200d46:	0789                	addi	a5,a5,2
    80200d48:	078e                	slli	a5,a5,0x3
    80200d4a:	97ba                	add	a5,a5,a4
    80200d4c:	639c                	ld	a5,0(a5)
    80200d4e:	853e                	mv	a0,a5
    80200d50:	97bff0ef          	jal	ra,802006ca <print_uint64>
    80200d54:	00001517          	auipc	a0,0x1
    80200d58:	3bc50513          	addi	a0,a0,956 # 80202110 <etext+0x110>
    80200d5c:	ff0ff0ef          	jal	ra,8020054c <print_str>
    80200d60:	fd843703          	ld	a4,-40(s0)
    80200d64:	fe843783          	ld	a5,-24(s0)
    80200d68:	07d9                	addi	a5,a5,22
    80200d6a:	078e                	slli	a5,a5,0x3
    80200d6c:	97ba                	add	a5,a5,a4
    80200d6e:	639c                	ld	a5,0(a5)
    80200d70:	853e                	mv	a0,a5
    80200d72:	959ff0ef          	jal	ra,802006ca <print_uint64>
    80200d76:	00001517          	auipc	a0,0x1
    80200d7a:	35a50513          	addi	a0,a0,858 # 802020d0 <etext+0xd0>
    80200d7e:	fceff0ef          	jal	ra,8020054c <print_str>
    80200d82:	fe843783          	ld	a5,-24(s0)
    80200d86:	0785                	addi	a5,a5,1
    80200d88:	fef43423          	sd	a5,-24(s0)
    80200d8c:	fd843783          	ld	a5,-40(s0)
    80200d90:	639c                	ld	a5,0(a5)
    80200d92:	fe843703          	ld	a4,-24(s0)
    80200d96:	f8f764e3          	bltu	a4,a5,80200d1e <print_app_info+0x36>
    80200d9a:	0001                	nop
    80200d9c:	0001                	nop
    80200d9e:	70a2                	ld	ra,40(sp)
    80200da0:	7402                	ld	s0,32(sp)
    80200da2:	6145                	addi	sp,sp,48
    80200da4:	8082                	ret

0000000080200da6 <run_next_app>:
    80200da6:	db010113          	addi	sp,sp,-592 # 80209db0 <bootstack+0x3db0>
    80200daa:	24113423          	sd	ra,584(sp)
    80200dae:	24813023          	sd	s0,576(sp)
    80200db2:	22913c23          	sd	s1,568(sp)
    80200db6:	0c80                	addi	s0,sp,592
    80200db8:	00001517          	auipc	a0,0x1
    80200dbc:	37050513          	addi	a0,a0,880 # 80202128 <etext+0x128>
    80200dc0:	f8cff0ef          	jal	ra,8020054c <print_str>
    80200dc4:	0000a797          	auipc	a5,0xa
    80200dc8:	c2478793          	addi	a5,a5,-988 # 8020a9e8 <app_manager>
    80200dcc:	679c                	ld	a5,8(a5)
    80200dce:	853e                	mv	a0,a5
    80200dd0:	8fbff0ef          	jal	ra,802006ca <print_uint64>
    80200dd4:	00001517          	auipc	a0,0x1
    80200dd8:	2fc50513          	addi	a0,a0,764 # 802020d0 <etext+0xd0>
    80200ddc:	f70ff0ef          	jal	ra,8020054c <print_str>
    80200de0:	0000a797          	auipc	a5,0xa
    80200de4:	c0878793          	addi	a5,a5,-1016 # 8020a9e8 <app_manager>
    80200de8:	679c                	ld	a5,8(a5)
    80200dea:	00178713          	addi	a4,a5,1
    80200dee:	0000a797          	auipc	a5,0xa
    80200df2:	bfa78793          	addi	a5,a5,-1030 # 8020a9e8 <app_manager>
    80200df6:	e798                	sd	a4,8(a5)
    80200df8:	0000a797          	auipc	a5,0xa
    80200dfc:	bf078793          	addi	a5,a5,-1040 # 8020a9e8 <app_manager>
    80200e00:	6798                	ld	a4,8(a5)
    80200e02:	0000a797          	auipc	a5,0xa
    80200e06:	be678793          	addi	a5,a5,-1050 # 8020a9e8 <app_manager>
    80200e0a:	639c                	ld	a5,0(a5)
    80200e0c:	02f76063          	bltu	a4,a5,80200e2c <run_next_app+0x86>
    80200e10:	00001517          	auipc	a0,0x1
    80200e14:	32850513          	addi	a0,a0,808 # 80202138 <etext+0x138>
    80200e18:	f34ff0ef          	jal	ra,8020054c <print_str>
    80200e1c:	05200593          	li	a1,82
    80200e20:	00001517          	auipc	a0,0x1
    80200e24:	28050513          	addi	a0,a0,640 # 802020a0 <etext+0xa0>
    80200e28:	9e9ff0ef          	jal	ra,80200810 <panic>
    80200e2c:	0000a797          	auipc	a5,0xa
    80200e30:	bbc78793          	addi	a5,a5,-1092 # 8020a9e8 <app_manager>
    80200e34:	679c                	ld	a5,8(a5)
    80200e36:	0000a717          	auipc	a4,0xa
    80200e3a:	bb270713          	addi	a4,a4,-1102 # 8020a9e8 <app_manager>
    80200e3e:	0789                	addi	a5,a5,2
    80200e40:	078e                	slli	a5,a5,0x3
    80200e42:	97ba                	add	a5,a5,a4
    80200e44:	639c                	ld	a5,0(a5)
    80200e46:	fcf43c23          	sd	a5,-40(s0)
    80200e4a:	0000100f          	fence.i
    80200e4e:	0000a797          	auipc	a5,0xa
    80200e52:	b9a78793          	addi	a5,a5,-1126 # 8020a9e8 <app_manager>
    80200e56:	679c                	ld	a5,8(a5)
    80200e58:	853e                	mv	a0,a5
    80200e5a:	286000ef          	jal	ra,802010e0 <get_user_stack_top>
    80200e5e:	872a                	mv	a4,a0
    80200e60:	ec040793          	addi	a5,s0,-320
    80200e64:	863a                	mv	a2,a4
    80200e66:	fd843583          	ld	a1,-40(s0)
    80200e6a:	853e                	mv	a0,a5
    80200e6c:	40e000ef          	jal	ra,8020127a <app_init_context>
    80200e70:	0000a797          	auipc	a5,0xa
    80200e74:	b7878793          	addi	a5,a5,-1160 # 8020a9e8 <app_manager>
    80200e78:	6784                	ld	s1,8(a5)
    80200e7a:	db040793          	addi	a5,s0,-592
    80200e7e:	ec040713          	addi	a4,s0,-320
    80200e82:	11000693          	li	a3,272
    80200e86:	8636                	mv	a2,a3
    80200e88:	85ba                	mv	a1,a4
    80200e8a:	853e                	mv	a0,a5
    80200e8c:	e3aff0ef          	jal	ra,802004c6 <memcpy>
    80200e90:	db040793          	addi	a5,s0,-592
    80200e94:	85a6                	mv	a1,s1
    80200e96:	853e                	mv	a0,a5
    80200e98:	272000ef          	jal	ra,8020110a <Kernelstack_push_TrapContext>
    80200e9c:	fca43823          	sd	a0,-48(s0)
    80200ea0:	fd043783          	ld	a5,-48(s0)
    80200ea4:	853e                	mv	a0,a5
    80200ea6:	237000ef          	jal	ra,802018dc <__restore>
    80200eaa:	0001                	nop
    80200eac:	24813083          	ld	ra,584(sp)
    80200eb0:	24013403          	ld	s0,576(sp)
    80200eb4:	23813483          	ld	s1,568(sp)
    80200eb8:	25010113          	addi	sp,sp,592
    80200ebc:	8082                	ret

0000000080200ebe <run_first_app>:
    80200ebe:	db010113          	addi	sp,sp,-592
    80200ec2:	24113423          	sd	ra,584(sp)
    80200ec6:	24813023          	sd	s0,576(sp)
    80200eca:	22913c23          	sd	s1,568(sp)
    80200ece:	0c80                	addi	s0,sp,592
    80200ed0:	0000a797          	auipc	a5,0xa
    80200ed4:	b1878793          	addi	a5,a5,-1256 # 8020a9e8 <app_manager>
    80200ed8:	679c                	ld	a5,8(a5)
    80200eda:	0000a717          	auipc	a4,0xa
    80200ede:	b0e70713          	addi	a4,a4,-1266 # 8020a9e8 <app_manager>
    80200ee2:	0789                	addi	a5,a5,2
    80200ee4:	078e                	slli	a5,a5,0x3
    80200ee6:	97ba                	add	a5,a5,a4
    80200ee8:	639c                	ld	a5,0(a5)
    80200eea:	fcf43c23          	sd	a5,-40(s0)
    80200eee:	0000a797          	auipc	a5,0xa
    80200ef2:	afa78793          	addi	a5,a5,-1286 # 8020a9e8 <app_manager>
    80200ef6:	679c                	ld	a5,8(a5)
    80200ef8:	00d79713          	slli	a4,a5,0xd
    80200efc:	0000a797          	auipc	a5,0xa
    80200f00:	03c78793          	addi	a5,a5,60 # 8020af38 <UserStack>
    80200f04:	97ba                	add	a5,a5,a4
    80200f06:	853e                	mv	a0,a5
    80200f08:	1d8000ef          	jal	ra,802010e0 <get_user_stack_top>
    80200f0c:	872a                	mv	a4,a0
    80200f0e:	ec040793          	addi	a5,s0,-320
    80200f12:	863a                	mv	a2,a4
    80200f14:	fd843583          	ld	a1,-40(s0)
    80200f18:	853e                	mv	a0,a5
    80200f1a:	360000ef          	jal	ra,8020127a <app_init_context>
    80200f1e:	0000a797          	auipc	a5,0xa
    80200f22:	aca78793          	addi	a5,a5,-1334 # 8020a9e8 <app_manager>
    80200f26:	6784                	ld	s1,8(a5)
    80200f28:	db040793          	addi	a5,s0,-592
    80200f2c:	ec040713          	addi	a4,s0,-320
    80200f30:	11000693          	li	a3,272
    80200f34:	8636                	mv	a2,a3
    80200f36:	85ba                	mv	a1,a4
    80200f38:	853e                	mv	a0,a5
    80200f3a:	d8cff0ef          	jal	ra,802004c6 <memcpy>
    80200f3e:	db040793          	addi	a5,s0,-592
    80200f42:	85a6                	mv	a1,s1
    80200f44:	853e                	mv	a0,a5
    80200f46:	1c4000ef          	jal	ra,8020110a <Kernelstack_push_TrapContext>
    80200f4a:	fca43823          	sd	a0,-48(s0)
    80200f4e:	fd043783          	ld	a5,-48(s0)
    80200f52:	853e                	mv	a0,a5
    80200f54:	189000ef          	jal	ra,802018dc <__restore>
    80200f58:	0001                	nop
    80200f5a:	24813083          	ld	ra,584(sp)
    80200f5e:	24013403          	ld	s0,576(sp)
    80200f62:	23813483          	ld	s1,568(sp)
    80200f66:	25010113          	addi	sp,sp,592
    80200f6a:	8082                	ret

0000000080200f6c <load_app_test>:
    80200f6c:	715d                	addi	sp,sp,-80
    80200f6e:	e486                	sd	ra,72(sp)
    80200f70:	e0a2                	sd	s0,64(sp)
    80200f72:	0880                	addi	s0,sp,80
    80200f74:	00002797          	auipc	a5,0x2
    80200f78:	08c78793          	addi	a5,a5,140 # 80203000 <_num_app>
    80200f7c:	639c                	ld	a5,0(a5)
    80200f7e:	fef43023          	sd	a5,-32(s0)
    80200f82:	0000100f          	fence.i
    80200f86:	fe043423          	sd	zero,-24(s0)
    80200f8a:	a0d1                	j	8020104e <load_app_test+0xe2>
    80200f8c:	fe843783          	ld	a5,-24(s0)
    80200f90:	0786                	slli	a5,a5,0x1
    80200f92:	0785                	addi	a5,a5,1
    80200f94:	00002717          	auipc	a4,0x2
    80200f98:	06c70713          	addi	a4,a4,108 # 80203000 <_num_app>
    80200f9c:	078e                	slli	a5,a5,0x3
    80200f9e:	97ba                	add	a5,a5,a4
    80200fa0:	639c                	ld	a5,0(a5)
    80200fa2:	fcf43c23          	sd	a5,-40(s0)
    80200fa6:	fe843783          	ld	a5,-24(s0)
    80200faa:	0785                	addi	a5,a5,1
    80200fac:	0786                	slli	a5,a5,0x1
    80200fae:	00002717          	auipc	a4,0x2
    80200fb2:	05270713          	addi	a4,a4,82 # 80203000 <_num_app>
    80200fb6:	078e                	slli	a5,a5,0x3
    80200fb8:	97ba                	add	a5,a5,a4
    80200fba:	639c                	ld	a5,0(a5)
    80200fbc:	fcf43823          	sd	a5,-48(s0)
    80200fc0:	fd043703          	ld	a4,-48(s0)
    80200fc4:	fd843783          	ld	a5,-40(s0)
    80200fc8:	40f707b3          	sub	a5,a4,a5
    80200fcc:	fcf43423          	sd	a5,-56(s0)
    80200fd0:	fd843783          	ld	a5,-40(s0)
    80200fd4:	fcf43023          	sd	a5,-64(s0)
    80200fd8:	fe843703          	ld	a4,-24(s0)
    80200fdc:	6791                	lui	a5,0x4
    80200fde:	02078793          	addi	a5,a5,32 # 4020 <n+0x4000>
    80200fe2:	97ba                	add	a5,a5,a4
    80200fe4:	07c6                	slli	a5,a5,0x11
    80200fe6:	faf43c23          	sd	a5,-72(s0)
    80200fea:	00001517          	auipc	a0,0x1
    80200fee:	16650513          	addi	a0,a0,358 # 80202150 <etext+0x150>
    80200ff2:	d5aff0ef          	jal	ra,8020054c <print_str>
    80200ff6:	fd843503          	ld	a0,-40(s0)
    80200ffa:	ed0ff0ef          	jal	ra,802006ca <print_uint64>
    80200ffe:	00001517          	auipc	a0,0x1
    80201002:	17250513          	addi	a0,a0,370 # 80202170 <etext+0x170>
    80201006:	d46ff0ef          	jal	ra,8020054c <print_str>
    8020100a:	fd043503          	ld	a0,-48(s0)
    8020100e:	ebcff0ef          	jal	ra,802006ca <print_uint64>
    80201012:	00001517          	auipc	a0,0x1
    80201016:	0be50513          	addi	a0,a0,190 # 802020d0 <etext+0xd0>
    8020101a:	d32ff0ef          	jal	ra,8020054c <print_str>
    8020101e:	00020637          	lui	a2,0x20
    80201022:	4581                	li	a1,0
    80201024:	fb843503          	ld	a0,-72(s0)
    80201028:	ad0ff0ef          	jal	ra,802002f8 <memset_t>
    8020102c:	fc843783          	ld	a5,-56(s0)
    80201030:	2781                	sext.w	a5,a5
    80201032:	863e                	mv	a2,a5
    80201034:	fc043583          	ld	a1,-64(s0)
    80201038:	fb843503          	ld	a0,-72(s0)
    8020103c:	8f8ff0ef          	jal	ra,80200134 <memcpy_t>
    80201040:	0000100f          	fence.i
    80201044:	fe843783          	ld	a5,-24(s0)
    80201048:	0785                	addi	a5,a5,1
    8020104a:	fef43423          	sd	a5,-24(s0)
    8020104e:	fe843703          	ld	a4,-24(s0)
    80201052:	fe043783          	ld	a5,-32(s0)
    80201056:	f2f76be3          	bltu	a4,a5,80200f8c <load_app_test+0x20>
    8020105a:	0001                	nop
    8020105c:	0001                	nop
    8020105e:	60a6                	ld	ra,72(sp)
    80201060:	6406                	ld	s0,64(sp)
    80201062:	6161                	addi	sp,sp,80
    80201064:	8082                	ret

0000000080201066 <init_user_stack>:
    80201066:	1101                	addi	sp,sp,-32
    80201068:	ec06                	sd	ra,24(sp)
    8020106a:	e822                	sd	s0,16(sp)
    8020106c:	1000                	addi	s0,sp,32
    8020106e:	fea43423          	sd	a0,-24(s0)
    80201072:	fe843703          	ld	a4,-24(s0)
    80201076:	77f9                	lui	a5,0xffffe
    80201078:	97ba                	add	a5,a5,a4
    8020107a:	6609                	lui	a2,0x2
    8020107c:	4581                	li	a1,0
    8020107e:	853e                	mv	a0,a5
    80201080:	a78ff0ef          	jal	ra,802002f8 <memset_t>
    80201084:	0001                	nop
    80201086:	60e2                	ld	ra,24(sp)
    80201088:	6442                	ld	s0,16(sp)
    8020108a:	6105                	addi	sp,sp,32
    8020108c:	8082                	ret

000000008020108e <init_kernel_stack>:
    8020108e:	1101                	addi	sp,sp,-32
    80201090:	ec06                	sd	ra,24(sp)
    80201092:	e822                	sd	s0,16(sp)
    80201094:	1000                	addi	s0,sp,32
    80201096:	fea43423          	sd	a0,-24(s0)
    8020109a:	fe843703          	ld	a4,-24(s0)
    8020109e:	77f9                	lui	a5,0xffffe
    802010a0:	97ba                	add	a5,a5,a4
    802010a2:	6609                	lui	a2,0x2
    802010a4:	4581                	li	a1,0
    802010a6:	853e                	mv	a0,a5
    802010a8:	a50ff0ef          	jal	ra,802002f8 <memset_t>
    802010ac:	0001                	nop
    802010ae:	60e2                	ld	ra,24(sp)
    802010b0:	6442                	ld	s0,16(sp)
    802010b2:	6105                	addi	sp,sp,32
    802010b4:	8082                	ret

00000000802010b6 <get_kernel_stack_top>:
    802010b6:	1101                	addi	sp,sp,-32
    802010b8:	ec22                	sd	s0,24(sp)
    802010ba:	1000                	addi	s0,sp,32
    802010bc:	fea43423          	sd	a0,-24(s0)
    802010c0:	fe843783          	ld	a5,-24(s0)
    802010c4:	00d79713          	slli	a4,a5,0xd
    802010c8:	00032797          	auipc	a5,0x32
    802010cc:	e7078793          	addi	a5,a5,-400 # 80232f38 <Kernelstack>
    802010d0:	97ba                	add	a5,a5,a4
    802010d2:	873e                	mv	a4,a5
    802010d4:	6789                	lui	a5,0x2
    802010d6:	97ba                	add	a5,a5,a4
    802010d8:	853e                	mv	a0,a5
    802010da:	6462                	ld	s0,24(sp)
    802010dc:	6105                	addi	sp,sp,32
    802010de:	8082                	ret

00000000802010e0 <get_user_stack_top>:
    802010e0:	1101                	addi	sp,sp,-32
    802010e2:	ec22                	sd	s0,24(sp)
    802010e4:	1000                	addi	s0,sp,32
    802010e6:	fea43423          	sd	a0,-24(s0)
    802010ea:	fe843783          	ld	a5,-24(s0)
    802010ee:	00d79713          	slli	a4,a5,0xd
    802010f2:	0000a797          	auipc	a5,0xa
    802010f6:	e4678793          	addi	a5,a5,-442 # 8020af38 <UserStack>
    802010fa:	97ba                	add	a5,a5,a4
    802010fc:	873e                	mv	a4,a5
    802010fe:	6789                	lui	a5,0x2
    80201100:	97ba                	add	a5,a5,a4
    80201102:	853e                	mv	a0,a5
    80201104:	6462                	ld	s0,24(sp)
    80201106:	6105                	addi	sp,sp,32
    80201108:	8082                	ret

000000008020110a <Kernelstack_push_TrapContext>:
    8020110a:	7179                	addi	sp,sp,-48
    8020110c:	f406                	sd	ra,40(sp)
    8020110e:	f022                	sd	s0,32(sp)
    80201110:	1800                	addi	s0,sp,48
    80201112:	80aa                	mv	ra,a0
    80201114:	fcb43c23          	sd	a1,-40(s0)
    80201118:	fd843783          	ld	a5,-40(s0)
    8020111c:	00d79713          	slli	a4,a5,0xd
    80201120:	00032797          	auipc	a5,0x32
    80201124:	e1878793          	addi	a5,a5,-488 # 80232f38 <Kernelstack>
    80201128:	973e                	add	a4,a4,a5
    8020112a:	6789                	lui	a5,0x2
    8020112c:	97ba                	add	a5,a5,a4
    8020112e:	fef43423          	sd	a5,-24(s0)
    80201132:	fe843783          	ld	a5,-24(s0)
    80201136:	ef078793          	addi	a5,a5,-272 # 1ef0 <n+0x1ed0>
    8020113a:	fef43423          	sd	a5,-24(s0)
    8020113e:	fe843783          	ld	a5,-24(s0)
    80201142:	873e                	mv	a4,a5
    80201144:	8686                	mv	a3,ra
    80201146:	11000793          	li	a5,272
    8020114a:	863e                	mv	a2,a5
    8020114c:	85b6                	mv	a1,a3
    8020114e:	853a                	mv	a0,a4
    80201150:	b76ff0ef          	jal	ra,802004c6 <memcpy>
    80201154:	fe843783          	ld	a5,-24(s0)
    80201158:	853e                	mv	a0,a5
    8020115a:	70a2                	ld	ra,40(sp)
    8020115c:	7402                	ld	s0,32(sp)
    8020115e:	6145                	addi	sp,sp,48
    80201160:	8082                	ret

0000000080201162 <UserStack_push_TrapContext>:
    80201162:	7179                	addi	sp,sp,-48
    80201164:	f406                	sd	ra,40(sp)
    80201166:	f022                	sd	s0,32(sp)
    80201168:	1800                	addi	s0,sp,48
    8020116a:	80aa                	mv	ra,a0
    8020116c:	fcb43c23          	sd	a1,-40(s0)
    80201170:	fd843783          	ld	a5,-40(s0)
    80201174:	00d79713          	slli	a4,a5,0xd
    80201178:	0000a797          	auipc	a5,0xa
    8020117c:	dc078793          	addi	a5,a5,-576 # 8020af38 <UserStack>
    80201180:	973e                	add	a4,a4,a5
    80201182:	6789                	lui	a5,0x2
    80201184:	97ba                	add	a5,a5,a4
    80201186:	fef43423          	sd	a5,-24(s0)
    8020118a:	fe843783          	ld	a5,-24(s0)
    8020118e:	ef078793          	addi	a5,a5,-272 # 1ef0 <n+0x1ed0>
    80201192:	fef43423          	sd	a5,-24(s0)
    80201196:	fe843783          	ld	a5,-24(s0)
    8020119a:	873e                	mv	a4,a5
    8020119c:	8686                	mv	a3,ra
    8020119e:	11000793          	li	a5,272
    802011a2:	863e                	mv	a2,a5
    802011a4:	85b6                	mv	a1,a3
    802011a6:	853a                	mv	a0,a4
    802011a8:	b1eff0ef          	jal	ra,802004c6 <memcpy>
    802011ac:	fe843783          	ld	a5,-24(s0)
    802011b0:	853e                	mv	a0,a5
    802011b2:	70a2                	ld	ra,40(sp)
    802011b4:	7402                	ld	s0,32(sp)
    802011b6:	6145                	addi	sp,sp,48
    802011b8:	8082                	ret

00000000802011ba <init_app_cx>:
    802011ba:	714d                	addi	sp,sp,-336
    802011bc:	e686                	sd	ra,328(sp)
    802011be:	e2a2                	sd	s0,320(sp)
    802011c0:	fe26                	sd	s1,312(sp)
    802011c2:	0a80                	addi	s0,sp,336
    802011c4:	eaa43c23          	sd	a0,-328(s0)
    802011c8:	0000a717          	auipc	a4,0xa
    802011cc:	82070713          	addi	a4,a4,-2016 # 8020a9e8 <app_manager>
    802011d0:	eb843783          	ld	a5,-328(s0)
    802011d4:	0789                	addi	a5,a5,2
    802011d6:	078e                	slli	a5,a5,0x3
    802011d8:	97ba                	add	a5,a5,a4
    802011da:	6384                	ld	s1,0(a5)
    802011dc:	eb843503          	ld	a0,-328(s0)
    802011e0:	f01ff0ef          	jal	ra,802010e0 <get_user_stack_top>
    802011e4:	872a                	mv	a4,a0
    802011e6:	ec840793          	addi	a5,s0,-312
    802011ea:	863a                	mv	a2,a4
    802011ec:	85a6                	mv	a1,s1
    802011ee:	853e                	mv	a0,a5
    802011f0:	08a000ef          	jal	ra,8020127a <app_init_context>
    802011f4:	eb843503          	ld	a0,-328(s0)
    802011f8:	ebfff0ef          	jal	ra,802010b6 <get_kernel_stack_top>
    802011fc:	fca43c23          	sd	a0,-40(s0)
    80201200:	fd843783          	ld	a5,-40(s0)
    80201204:	853e                	mv	a0,a5
    80201206:	60b6                	ld	ra,328(sp)
    80201208:	6416                	ld	s0,320(sp)
    8020120a:	74f2                	ld	s1,312(sp)
    8020120c:	6171                	addi	sp,sp,336
    8020120e:	8082                	ret

0000000080201210 <set_sstatus_spp_user>:
    80201210:	7179                	addi	sp,sp,-48
    80201212:	f422                	sd	s0,40(sp)
    80201214:	1800                	addi	s0,sp,48
    80201216:	fca43c23          	sd	a0,-40(s0)
    8020121a:	10000793          	li	a5,256
    8020121e:	fef43423          	sd	a5,-24(s0)
    80201222:	fd843783          	ld	a5,-40(s0)
    80201226:	6398                	ld	a4,0(a5)
    80201228:	fe843783          	ld	a5,-24(s0)
    8020122c:	fff7c793          	not	a5,a5
    80201230:	8f7d                	and	a4,a4,a5
    80201232:	fd843783          	ld	a5,-40(s0)
    80201236:	e398                	sd	a4,0(a5)
    80201238:	0001                	nop
    8020123a:	7422                	ld	s0,40(sp)
    8020123c:	6145                	addi	sp,sp,48
    8020123e:	8082                	ret

0000000080201240 <read_sstatus>:
    80201240:	1101                	addi	sp,sp,-32
    80201242:	ec22                	sd	s0,24(sp)
    80201244:	1000                	addi	s0,sp,32
    80201246:	100027f3          	csrr	a5,sstatus
    8020124a:	fef43423          	sd	a5,-24(s0)
    8020124e:	fe843783          	ld	a5,-24(s0)
    80201252:	853e                	mv	a0,a5
    80201254:	6462                	ld	s0,24(sp)
    80201256:	6105                	addi	sp,sp,32
    80201258:	8082                	ret

000000008020125a <set_sp>:
    8020125a:	1101                	addi	sp,sp,-32
    8020125c:	ec22                	sd	s0,24(sp)
    8020125e:	1000                	addi	s0,sp,32
    80201260:	fea43423          	sd	a0,-24(s0)
    80201264:	feb43023          	sd	a1,-32(s0)
    80201268:	fe843783          	ld	a5,-24(s0)
    8020126c:	fe043703          	ld	a4,-32(s0)
    80201270:	eb98                	sd	a4,16(a5)
    80201272:	0001                	nop
    80201274:	6462                	ld	s0,24(sp)
    80201276:	6105                	addi	sp,sp,32
    80201278:	8082                	ret

000000008020127a <app_init_context>:
    8020127a:	714d                	addi	sp,sp,-336
    8020127c:	e686                	sd	ra,328(sp)
    8020127e:	e2a2                	sd	s0,320(sp)
    80201280:	0a80                	addi	s0,sp,336
    80201282:	eca43423          	sd	a0,-312(s0)
    80201286:	ecb43023          	sd	a1,-320(s0)
    8020128a:	eac43c23          	sd	a2,-328(s0)
    8020128e:	fb3ff0ef          	jal	ra,80201240 <read_sstatus>
    80201292:	87aa                	mv	a5,a0
    80201294:	ecf43823          	sd	a5,-304(s0)
    80201298:	ed040793          	addi	a5,s0,-304
    8020129c:	853e                	mv	a0,a5
    8020129e:	f73ff0ef          	jal	ra,80201210 <set_sstatus_spp_user>
    802012a2:	ed043783          	ld	a5,-304(s0)
    802012a6:	fcf43c23          	sd	a5,-40(s0)
    802012aa:	ec043783          	ld	a5,-320(s0)
    802012ae:	fef43023          	sd	a5,-32(s0)
    802012b2:	ed840793          	addi	a5,s0,-296
    802012b6:	eb843583          	ld	a1,-328(s0)
    802012ba:	853e                	mv	a0,a5
    802012bc:	f9fff0ef          	jal	ra,8020125a <set_sp>
    802012c0:	fe042623          	sw	zero,-20(s0)
    802012c4:	a831                	j	802012e0 <app_init_context+0x66>
    802012c6:	fec42783          	lw	a5,-20(s0)
    802012ca:	078e                	slli	a5,a5,0x3
    802012cc:	ff040713          	addi	a4,s0,-16
    802012d0:	97ba                	add	a5,a5,a4
    802012d2:	ee07b423          	sd	zero,-280(a5)
    802012d6:	fec42783          	lw	a5,-20(s0)
    802012da:	2785                	addiw	a5,a5,1
    802012dc:	fef42623          	sw	a5,-20(s0)
    802012e0:	fec42783          	lw	a5,-20(s0)
    802012e4:	0007871b          	sext.w	a4,a5
    802012e8:	47fd                	li	a5,31
    802012ea:	fce7dee3          	bge	a5,a4,802012c6 <app_init_context+0x4c>
    802012ee:	ec843783          	ld	a5,-312(s0)
    802012f2:	86be                	mv	a3,a5
    802012f4:	ed840793          	addi	a5,s0,-296
    802012f8:	11000713          	li	a4,272
    802012fc:	863a                	mv	a2,a4
    802012fe:	85be                	mv	a1,a5
    80201300:	8536                	mv	a0,a3
    80201302:	9c4ff0ef          	jal	ra,802004c6 <memcpy>
    80201306:	ec843503          	ld	a0,-312(s0)
    8020130a:	60b6                	ld	ra,328(sp)
    8020130c:	6416                	ld	s0,320(sp)
    8020130e:	6171                	addi	sp,sp,336
    80201310:	8082                	ret

0000000080201312 <print_sepc>:
    80201312:	1101                	addi	sp,sp,-32
    80201314:	ec06                	sd	ra,24(sp)
    80201316:	e822                	sd	s0,16(sp)
    80201318:	1000                	addi	s0,sp,32
    8020131a:	00001517          	auipc	a0,0x1
    8020131e:	e5e50513          	addi	a0,a0,-418 # 80202178 <etext+0x178>
    80201322:	a2aff0ef          	jal	ra,8020054c <print_str>
    80201326:	141027f3          	csrr	a5,sepc
    8020132a:	fef43423          	sd	a5,-24(s0)
    8020132e:	fe843783          	ld	a5,-24(s0)
    80201332:	853e                	mv	a0,a5
    80201334:	b96ff0ef          	jal	ra,802006ca <print_uint64>
    80201338:	00001517          	auipc	a0,0x1
    8020133c:	e4850513          	addi	a0,a0,-440 # 80202180 <etext+0x180>
    80201340:	a0cff0ef          	jal	ra,8020054c <print_str>
    80201344:	0001                	nop
    80201346:	60e2                	ld	ra,24(sp)
    80201348:	6442                	ld	s0,16(sp)
    8020134a:	6105                	addi	sp,sp,32
    8020134c:	8082                	ret

000000008020134e <init_interrupt>:
    8020134e:	7139                	addi	sp,sp,-64
    80201350:	fc06                	sd	ra,56(sp)
    80201352:	f822                	sd	s0,48(sp)
    80201354:	0080                	addi	s0,sp,64
    80201356:	00001517          	auipc	a0,0x1
    8020135a:	e3250513          	addi	a0,a0,-462 # 80202188 <etext+0x188>
    8020135e:	9eeff0ef          	jal	ra,8020054c <print_str>
    80201362:	00000797          	auipc	a5,0x0
    80201366:	52278793          	addi	a5,a5,1314 # 80201884 <__alltraps>
    8020136a:	fef43423          	sd	a5,-24(s0)
    8020136e:	fe843783          	ld	a5,-24(s0)
    80201372:	10579073          	csrw	stvec,a5
    80201376:	20200793          	li	a5,514
    8020137a:	fef43023          	sd	a5,-32(s0)
    8020137e:	fe043783          	ld	a5,-32(s0)
    80201382:	10479073          	csrw	sie,a5
    80201386:	100027f3          	csrr	a5,sstatus
    8020138a:	fcf43c23          	sd	a5,-40(s0)
    8020138e:	fd843783          	ld	a5,-40(s0)
    80201392:	fcf43823          	sd	a5,-48(s0)
    80201396:	fd043783          	ld	a5,-48(s0)
    8020139a:	0027e793          	ori	a5,a5,2
    8020139e:	fcf43823          	sd	a5,-48(s0)
    802013a2:	fd043783          	ld	a5,-48(s0)
    802013a6:	10079073          	csrw	sstatus,a5
    802013aa:	104027f3          	csrr	a5,sie
    802013ae:	fcf43423          	sd	a5,-56(s0)
    802013b2:	fc843783          	ld	a5,-56(s0)
    802013b6:	fcf43023          	sd	a5,-64(s0)
    802013ba:	fc043783          	ld	a5,-64(s0)
    802013be:	2227e793          	ori	a5,a5,546
    802013c2:	fcf43023          	sd	a5,-64(s0)
    802013c6:	fc043783          	ld	a5,-64(s0)
    802013ca:	10479073          	csrw	sie,a5
    802013ce:	00009797          	auipc	a5,0x9
    802013d2:	76a78793          	addi	a5,a5,1898 # 8020ab38 <Trap_Stack>
    802013d6:	14079073          	csrw	sscratch,a5
    802013da:	0001                	nop
    802013dc:	70e2                	ld	ra,56(sp)
    802013de:	7442                	ld	s0,48(sp)
    802013e0:	6121                	addi	sp,sp,64
    802013e2:	8082                	ret

00000000802013e4 <trap_handler>:
    802013e4:	711d                	addi	sp,sp,-96
    802013e6:	ec86                	sd	ra,88(sp)
    802013e8:	e8a2                	sd	s0,80(sp)
    802013ea:	1080                	addi	s0,sp,96
    802013ec:	faa43423          	sd	a0,-88(s0)
    802013f0:	142027f3          	csrr	a5,scause
    802013f4:	fcf43c23          	sd	a5,-40(s0)
    802013f8:	fd843783          	ld	a5,-40(s0)
    802013fc:	fcf43823          	sd	a5,-48(s0)
    80201400:	fd043703          	ld	a4,-48(s0)
    80201404:	47bd                	li	a5,15
    80201406:	02e7e963          	bltu	a5,a4,80201438 <trap_handler+0x54>
    8020140a:	fd043703          	ld	a4,-48(s0)
    8020140e:	47bd                	li	a5,15
    80201410:	1ee7e263          	bltu	a5,a4,802015f4 <trap_handler+0x210>
    80201414:	fd043783          	ld	a5,-48(s0)
    80201418:	00279713          	slli	a4,a5,0x2
    8020141c:	00001797          	auipc	a5,0x1
    80201420:	f8078793          	addi	a5,a5,-128 # 8020239c <etext+0x39c>
    80201424:	97ba                	add	a5,a5,a4
    80201426:	439c                	lw	a5,0(a5)
    80201428:	0007871b          	sext.w	a4,a5
    8020142c:	00001797          	auipc	a5,0x1
    80201430:	f7078793          	addi	a5,a5,-144 # 8020239c <etext+0x39c>
    80201434:	97ba                	add	a5,a5,a4
    80201436:	8782                	jr	a5
    80201438:	fd043703          	ld	a4,-48(s0)
    8020143c:	57fd                	li	a5,-1
    8020143e:	17fe                	slli	a5,a5,0x3f
    80201440:	0795                	addi	a5,a5,5
    80201442:	1af70663          	beq	a4,a5,802015ee <trap_handler+0x20a>
    80201446:	a27d                	j	802015f4 <trap_handler+0x210>
    80201448:	00001517          	auipc	a0,0x1
    8020144c:	d5850513          	addi	a0,a0,-680 # 802021a0 <etext+0x1a0>
    80201450:	8fcff0ef          	jal	ra,8020054c <print_str>
    80201454:	ebfff0ef          	jal	ra,80201312 <print_sepc>
    80201458:	450d                	li	a0,3
    8020145a:	d38ff0ef          	jal	ra,80200992 <run_next_task>
    8020145e:	aa45                	j	8020160e <trap_handler+0x22a>
    80201460:	eb3ff0ef          	jal	ra,80201312 <print_sepc>
    80201464:	00001517          	auipc	a0,0x1
    80201468:	d6c50513          	addi	a0,a0,-660 # 802021d0 <etext+0x1d0>
    8020146c:	8e0ff0ef          	jal	ra,8020054c <print_str>
    80201470:	450d                	li	a0,3
    80201472:	d20ff0ef          	jal	ra,80200992 <run_next_task>
    80201476:	aa61                	j	8020160e <trap_handler+0x22a>
    80201478:	00001517          	auipc	a0,0x1
    8020147c:	d8050513          	addi	a0,a0,-640 # 802021f8 <etext+0x1f8>
    80201480:	8ccff0ef          	jal	ra,8020054c <print_str>
    80201484:	450d                	li	a0,3
    80201486:	d0cff0ef          	jal	ra,80200992 <run_next_task>
    8020148a:	a251                	j	8020160e <trap_handler+0x22a>
    8020148c:	00001517          	auipc	a0,0x1
    80201490:	d8c50513          	addi	a0,a0,-628 # 80202218 <etext+0x218>
    80201494:	8b8ff0ef          	jal	ra,8020054c <print_str>
    80201498:	fa843783          	ld	a5,-88(s0)
    8020149c:	1087b783          	ld	a5,264(a5)
    802014a0:	00278713          	addi	a4,a5,2
    802014a4:	fa843783          	ld	a5,-88(s0)
    802014a8:	10e7b423          	sd	a4,264(a5)
    802014ac:	a28d                	j	8020160e <trap_handler+0x22a>
    802014ae:	00001517          	auipc	a0,0x1
    802014b2:	d8250513          	addi	a0,a0,-638 # 80202230 <etext+0x230>
    802014b6:	896ff0ef          	jal	ra,8020054c <print_str>
    802014ba:	450d                	li	a0,3
    802014bc:	cd6ff0ef          	jal	ra,80200992 <run_next_task>
    802014c0:	a2b9                	j	8020160e <trap_handler+0x22a>
    802014c2:	00001517          	auipc	a0,0x1
    802014c6:	d9650513          	addi	a0,a0,-618 # 80202258 <etext+0x258>
    802014ca:	882ff0ef          	jal	ra,8020054c <print_str>
    802014ce:	450d                	li	a0,3
    802014d0:	cc2ff0ef          	jal	ra,80200992 <run_next_task>
    802014d4:	aa2d                	j	8020160e <trap_handler+0x22a>
    802014d6:	00001517          	auipc	a0,0x1
    802014da:	da250513          	addi	a0,a0,-606 # 80202278 <etext+0x278>
    802014de:	86eff0ef          	jal	ra,8020054c <print_str>
    802014e2:	450d                	li	a0,3
    802014e4:	caeff0ef          	jal	ra,80200992 <run_next_task>
    802014e8:	a21d                	j	8020160e <trap_handler+0x22a>
    802014ea:	00001517          	auipc	a0,0x1
    802014ee:	db650513          	addi	a0,a0,-586 # 802022a0 <etext+0x2a0>
    802014f2:	85aff0ef          	jal	ra,8020054c <print_str>
    802014f6:	450d                	li	a0,3
    802014f8:	e1bff0ef          	jal	ra,80201312 <print_sepc>
    802014fc:	009507b7          	lui	a5,0x950
    80201500:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80201504:	07aa                	slli	a5,a5,0xa
    80201506:	fef43423          	sd	a5,-24(s0)
    8020150a:	0001                	nop
    8020150c:	fe843783          	ld	a5,-24(s0)
    80201510:	fff78713          	addi	a4,a5,-1
    80201514:	fee43423          	sd	a4,-24(s0)
    80201518:	fbf5                	bnez	a5,8020150c <trap_handler+0x128>
    8020151a:	a8d5                	j	8020160e <trap_handler+0x22a>
    8020151c:	fa843783          	ld	a5,-88(s0)
    80201520:	1087b783          	ld	a5,264(a5)
    80201524:	00478713          	addi	a4,a5,4
    80201528:	fa843783          	ld	a5,-88(s0)
    8020152c:	10e7b423          	sd	a4,264(a5)
    80201530:	fa843783          	ld	a5,-88(s0)
    80201534:	6bbc                	ld	a5,80(a5)
    80201536:	faf43c23          	sd	a5,-72(s0)
    8020153a:	fa843783          	ld	a5,-88(s0)
    8020153e:	6fbc                	ld	a5,88(a5)
    80201540:	fcf43023          	sd	a5,-64(s0)
    80201544:	fa843783          	ld	a5,-88(s0)
    80201548:	73bc                	ld	a5,96(a5)
    8020154a:	fcf43423          	sd	a5,-56(s0)
    8020154e:	fa843783          	ld	a5,-88(s0)
    80201552:	67dc                	ld	a5,136(a5)
    80201554:	fb840713          	addi	a4,s0,-72
    80201558:	85ba                	mv	a1,a4
    8020155a:	853e                	mv	a0,a5
    8020155c:	1de000ef          	jal	ra,8020173a <syscall>
    80201560:	87aa                	mv	a5,a0
    80201562:	873e                	mv	a4,a5
    80201564:	fa843783          	ld	a5,-88(s0)
    80201568:	ebb8                	sd	a4,80(a5)
    8020156a:	a055                	j	8020160e <trap_handler+0x22a>
    8020156c:	00001517          	auipc	a0,0x1
    80201570:	d5c50513          	addi	a0,a0,-676 # 802022c8 <etext+0x2c8>
    80201574:	fd9fe0ef          	jal	ra,8020054c <print_str>
    80201578:	009507b7          	lui	a5,0x950
    8020157c:	2f978793          	addi	a5,a5,761 # 9502f9 <n+0x9502d9>
    80201580:	07aa                	slli	a5,a5,0xa
    80201582:	fef43023          	sd	a5,-32(s0)
    80201586:	0001                	nop
    80201588:	fe043783          	ld	a5,-32(s0)
    8020158c:	fff78713          	addi	a4,a5,-1
    80201590:	fee43023          	sd	a4,-32(s0)
    80201594:	fbf5                	bnez	a5,80201588 <trap_handler+0x1a4>
    80201596:	450d                	li	a0,3
    80201598:	bfaff0ef          	jal	ra,80200992 <run_next_task>
    8020159c:	a88d                	j	8020160e <trap_handler+0x22a>
    8020159e:	00001517          	auipc	a0,0x1
    802015a2:	d5250513          	addi	a0,a0,-686 # 802022f0 <etext+0x2f0>
    802015a6:	fa7fe0ef          	jal	ra,8020054c <print_str>
    802015aa:	450d                	li	a0,3
    802015ac:	be6ff0ef          	jal	ra,80200992 <run_next_task>
    802015b0:	a8b9                	j	8020160e <trap_handler+0x22a>
    802015b2:	00001517          	auipc	a0,0x1
    802015b6:	d6650513          	addi	a0,a0,-666 # 80202318 <etext+0x318>
    802015ba:	f93fe0ef          	jal	ra,8020054c <print_str>
    802015be:	450d                	li	a0,3
    802015c0:	bd2ff0ef          	jal	ra,80200992 <run_next_task>
    802015c4:	a0a9                	j	8020160e <trap_handler+0x22a>
    802015c6:	00001517          	auipc	a0,0x1
    802015ca:	d7a50513          	addi	a0,a0,-646 # 80202340 <etext+0x340>
    802015ce:	f7ffe0ef          	jal	ra,8020054c <print_str>
    802015d2:	450d                	li	a0,3
    802015d4:	bbeff0ef          	jal	ra,80200992 <run_next_task>
    802015d8:	a81d                	j	8020160e <trap_handler+0x22a>
    802015da:	00001517          	auipc	a0,0x1
    802015de:	d8650513          	addi	a0,a0,-634 # 80202360 <etext+0x360>
    802015e2:	f6bfe0ef          	jal	ra,8020054c <print_str>
    802015e6:	450d                	li	a0,3
    802015e8:	baaff0ef          	jal	ra,80200992 <run_next_task>
    802015ec:	a00d                	j	8020160e <trap_handler+0x22a>
    802015ee:	268000ef          	jal	ra,80201856 <intr_timer_handle>
    802015f2:	a831                	j	8020160e <trap_handler+0x22a>
    802015f4:	00001517          	auipc	a0,0x1
    802015f8:	d8c50513          	addi	a0,a0,-628 # 80202380 <etext+0x380>
    802015fc:	f51fe0ef          	jal	ra,8020054c <print_str>
    80201600:	fd043503          	ld	a0,-48(s0)
    80201604:	8c6ff0ef          	jal	ra,802006ca <print_uint64>
    80201608:	4505                	li	a0,1
    8020160a:	012000ef          	jal	ra,8020161c <exit>
    8020160e:	fa843783          	ld	a5,-88(s0)
    80201612:	853e                	mv	a0,a5
    80201614:	60e6                	ld	ra,88(sp)
    80201616:	6446                	ld	s0,80(sp)
    80201618:	6125                	addi	sp,sp,96
    8020161a:	8082                	ret

000000008020161c <exit>:
    8020161c:	1101                	addi	sp,sp,-32
    8020161e:	ec06                	sd	ra,24(sp)
    80201620:	e822                	sd	s0,16(sp)
    80201622:	1000                	addi	s0,sp,32
    80201624:	87aa                	mv	a5,a0
    80201626:	fef42623          	sw	a5,-20(s0)
    8020162a:	00001517          	auipc	a0,0x1
    8020162e:	db650513          	addi	a0,a0,-586 # 802023e0 <etext+0x3e0>
    80201632:	f1bfe0ef          	jal	ra,8020054c <print_str>
    80201636:	fec42783          	lw	a5,-20(s0)
    8020163a:	853e                	mv	a0,a5
    8020163c:	fdbfe0ef          	jal	ra,80200616 <print_uint32>
    80201640:	00001517          	auipc	a0,0x1
    80201644:	da850513          	addi	a0,a0,-600 # 802023e8 <etext+0x3e8>
    80201648:	f05fe0ef          	jal	ra,8020054c <print_str>
    8020164c:	fec42783          	lw	a5,-20(s0)
    80201650:	853e                	mv	a0,a5
    80201652:	60e2                	ld	ra,24(sp)
    80201654:	6442                	ld	s0,16(sp)
    80201656:	6105                	addi	sp,sp,32
    80201658:	8082                	ret

000000008020165a <write>:
    8020165a:	7179                	addi	sp,sp,-48
    8020165c:	f406                	sd	ra,40(sp)
    8020165e:	f022                	sd	s0,32(sp)
    80201660:	1800                	addi	s0,sp,48
    80201662:	fea43423          	sd	a0,-24(s0)
    80201666:	feb43023          	sd	a1,-32(s0)
    8020166a:	fcc43c23          	sd	a2,-40(s0)
    8020166e:	fe843703          	ld	a4,-24(s0)
    80201672:	4785                	li	a5,1
    80201674:	00f71d63          	bne	a4,a5,8020168e <write+0x34>
    80201678:	fe043503          	ld	a0,-32(s0)
    8020167c:	ed1fe0ef          	jal	ra,8020054c <print_str>
    80201680:	00001517          	auipc	a0,0x1
    80201684:	d6850513          	addi	a0,a0,-664 # 802023e8 <etext+0x3e8>
    80201688:	ec5fe0ef          	jal	ra,8020054c <print_str>
    8020168c:	a801                	j	8020169c <write+0x42>
    8020168e:	45e9                	li	a1,26
    80201690:	00001517          	auipc	a0,0x1
    80201694:	d6050513          	addi	a0,a0,-672 # 802023f0 <etext+0x3f0>
    80201698:	978ff0ef          	jal	ra,80200810 <panic>
    8020169c:	fd843783          	ld	a5,-40(s0)
    802016a0:	853e                	mv	a0,a5
    802016a2:	70a2                	ld	ra,40(sp)
    802016a4:	7402                	ld	s0,32(sp)
    802016a6:	6145                	addi	sp,sp,48
    802016a8:	8082                	ret

00000000802016aa <yield>:
    802016aa:	1141                	addi	sp,sp,-16
    802016ac:	e406                	sd	ra,8(sp)
    802016ae:	e022                	sd	s0,0(sp)
    802016b0:	0800                	addi	s0,sp,16
    802016b2:	00001517          	auipc	a0,0x1
    802016b6:	d5e50513          	addi	a0,a0,-674 # 80202410 <etext+0x410>
    802016ba:	e93fe0ef          	jal	ra,8020054c <print_str>
    802016be:	4509                	li	a0,2
    802016c0:	ad2ff0ef          	jal	ra,80200992 <run_next_task>
    802016c4:	4785                	li	a5,1
    802016c6:	853e                	mv	a0,a5
    802016c8:	60a2                	ld	ra,8(sp)
    802016ca:	6402                	ld	s0,0(sp)
    802016cc:	0141                	addi	sp,sp,16
    802016ce:	8082                	ret

00000000802016d0 <sys_write>:
    802016d0:	7179                	addi	sp,sp,-48
    802016d2:	f406                	sd	ra,40(sp)
    802016d4:	f022                	sd	s0,32(sp)
    802016d6:	1800                	addi	s0,sp,48
    802016d8:	fea43423          	sd	a0,-24(s0)
    802016dc:	feb43023          	sd	a1,-32(s0)
    802016e0:	fcc43c23          	sd	a2,-40(s0)
    802016e4:	fd843603          	ld	a2,-40(s0)
    802016e8:	fe043583          	ld	a1,-32(s0)
    802016ec:	fe843503          	ld	a0,-24(s0)
    802016f0:	f6bff0ef          	jal	ra,8020165a <write>
    802016f4:	87aa                	mv	a5,a0
    802016f6:	853e                	mv	a0,a5
    802016f8:	70a2                	ld	ra,40(sp)
    802016fa:	7402                	ld	s0,32(sp)
    802016fc:	6145                	addi	sp,sp,48
    802016fe:	8082                	ret

0000000080201700 <sys_exit>:
    80201700:	1101                	addi	sp,sp,-32
    80201702:	ec06                	sd	ra,24(sp)
    80201704:	e822                	sd	s0,16(sp)
    80201706:	1000                	addi	s0,sp,32
    80201708:	87aa                	mv	a5,a0
    8020170a:	fef42623          	sw	a5,-20(s0)
    8020170e:	fec42783          	lw	a5,-20(s0)
    80201712:	853e                	mv	a0,a5
    80201714:	f09ff0ef          	jal	ra,8020161c <exit>
    80201718:	0001                	nop
    8020171a:	60e2                	ld	ra,24(sp)
    8020171c:	6442                	ld	s0,16(sp)
    8020171e:	6105                	addi	sp,sp,32
    80201720:	8082                	ret

0000000080201722 <sys_yield>:
    80201722:	1141                	addi	sp,sp,-16
    80201724:	e406                	sd	ra,8(sp)
    80201726:	e022                	sd	s0,0(sp)
    80201728:	0800                	addi	s0,sp,16
    8020172a:	f81ff0ef          	jal	ra,802016aa <yield>
    8020172e:	87aa                	mv	a5,a0
    80201730:	853e                	mv	a0,a5
    80201732:	60a2                	ld	ra,8(sp)
    80201734:	6402                	ld	s0,0(sp)
    80201736:	0141                	addi	sp,sp,16
    80201738:	8082                	ret

000000008020173a <syscall>:
    8020173a:	1101                	addi	sp,sp,-32
    8020173c:	ec06                	sd	ra,24(sp)
    8020173e:	e822                	sd	s0,16(sp)
    80201740:	1000                	addi	s0,sp,32
    80201742:	fea43423          	sd	a0,-24(s0)
    80201746:	feb43023          	sd	a1,-32(s0)
    8020174a:	fe843703          	ld	a4,-24(s0)
    8020174e:	07c00793          	li	a5,124
    80201752:	06f70163          	beq	a4,a5,802017b4 <syscall+0x7a>
    80201756:	fe843703          	ld	a4,-24(s0)
    8020175a:	07c00793          	li	a5,124
    8020175e:	04e7ef63          	bltu	a5,a4,802017bc <syscall+0x82>
    80201762:	fe843703          	ld	a4,-24(s0)
    80201766:	04000793          	li	a5,64
    8020176a:	00f70963          	beq	a4,a5,8020177c <syscall+0x42>
    8020176e:	fe843703          	ld	a4,-24(s0)
    80201772:	05d00793          	li	a5,93
    80201776:	02f70663          	beq	a4,a5,802017a2 <syscall+0x68>
    8020177a:	a089                	j	802017bc <syscall+0x82>
    8020177c:	fe043783          	ld	a5,-32(s0)
    80201780:	6398                	ld	a4,0(a5)
    80201782:	fe043783          	ld	a5,-32(s0)
    80201786:	07a1                	addi	a5,a5,8
    80201788:	639c                	ld	a5,0(a5)
    8020178a:	86be                	mv	a3,a5
    8020178c:	fe043783          	ld	a5,-32(s0)
    80201790:	07c1                	addi	a5,a5,16
    80201792:	639c                	ld	a5,0(a5)
    80201794:	863e                	mv	a2,a5
    80201796:	85b6                	mv	a1,a3
    80201798:	853a                	mv	a0,a4
    8020179a:	f37ff0ef          	jal	ra,802016d0 <sys_write>
    8020179e:	87aa                	mv	a5,a0
    802017a0:	a0a9                	j	802017ea <syscall+0xb0>
    802017a2:	fe043783          	ld	a5,-32(s0)
    802017a6:	639c                	ld	a5,0(a5)
    802017a8:	2781                	sext.w	a5,a5
    802017aa:	853e                	mv	a0,a5
    802017ac:	f55ff0ef          	jal	ra,80201700 <sys_exit>
    802017b0:	4781                	li	a5,0
    802017b2:	a825                	j	802017ea <syscall+0xb0>
    802017b4:	f6fff0ef          	jal	ra,80201722 <sys_yield>
    802017b8:	87aa                	mv	a5,a0
    802017ba:	a805                	j	802017ea <syscall+0xb0>
    802017bc:	00001517          	auipc	a0,0x1
    802017c0:	c6c50513          	addi	a0,a0,-916 # 80202428 <etext+0x428>
    802017c4:	d89fe0ef          	jal	ra,8020054c <print_str>
    802017c8:	04500593          	li	a1,69
    802017cc:	00001517          	auipc	a0,0x1
    802017d0:	c2450513          	addi	a0,a0,-988 # 802023f0 <etext+0x3f0>
    802017d4:	83cff0ef          	jal	ra,80200810 <panic>
    802017d8:	04700593          	li	a1,71
    802017dc:	00001517          	auipc	a0,0x1
    802017e0:	c1450513          	addi	a0,a0,-1004 # 802023f0 <etext+0x3f0>
    802017e4:	82cff0ef          	jal	ra,80200810 <panic>
    802017e8:	57fd                	li	a5,-1
    802017ea:	853e                	mv	a0,a5
    802017ec:	60e2                	ld	ra,24(sp)
    802017ee:	6442                	ld	s0,16(sp)
    802017f0:	6105                	addi	sp,sp,32
    802017f2:	8082                	ret

00000000802017f4 <read_time>:
    802017f4:	1101                	addi	sp,sp,-32
    802017f6:	ec22                	sd	s0,24(sp)
    802017f8:	1000                	addi	s0,sp,32
    802017fa:	c01027f3          	rdtime	a5
    802017fe:	fef43423          	sd	a5,-24(s0)
    80201802:	fe843783          	ld	a5,-24(s0)
    80201806:	853e                	mv	a0,a5
    80201808:	6462                	ld	s0,24(sp)
    8020180a:	6105                	addi	sp,sp,32
    8020180c:	8082                	ret

000000008020180e <clock_set_next_event>:
    8020180e:	1141                	addi	sp,sp,-16
    80201810:	e406                	sd	ra,8(sp)
    80201812:	e022                	sd	s0,0(sp)
    80201814:	0800                	addi	s0,sp,16
    80201816:	fdfff0ef          	jal	ra,802017f4 <read_time>
    8020181a:	872a                	mv	a4,a0
    8020181c:	67e1                	lui	a5,0x18
    8020181e:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    80201822:	97ba                	add	a5,a5,a4
    80201824:	853e                	mv	a0,a5
    80201826:	8b1fe0ef          	jal	ra,802000d6 <sbi_set_timer>
    8020182a:	0001                	nop
    8020182c:	60a2                	ld	ra,8(sp)
    8020182e:	6402                	ld	s0,0(sp)
    80201830:	0141                	addi	sp,sp,16
    80201832:	8082                	ret

0000000080201834 <timer_init>:
    80201834:	1141                	addi	sp,sp,-16
    80201836:	e406                	sd	ra,8(sp)
    80201838:	e022                	sd	s0,0(sp)
    8020183a:	0800                	addi	s0,sp,16
    8020183c:	fd3ff0ef          	jal	ra,8020180e <clock_set_next_event>
    80201840:	00001517          	auipc	a0,0x1
    80201844:	c0850513          	addi	a0,a0,-1016 # 80202448 <etext+0x448>
    80201848:	d05fe0ef          	jal	ra,8020054c <print_str>
    8020184c:	0001                	nop
    8020184e:	60a2                	ld	ra,8(sp)
    80201850:	6402                	ld	s0,0(sp)
    80201852:	0141                	addi	sp,sp,16
    80201854:	8082                	ret

0000000080201856 <intr_timer_handle>:
    80201856:	1141                	addi	sp,sp,-16
    80201858:	e406                	sd	ra,8(sp)
    8020185a:	e022                	sd	s0,0(sp)
    8020185c:	0800                	addi	s0,sp,16
    8020185e:	00059797          	auipc	a5,0x59
    80201862:	6e278793          	addi	a5,a5,1762 # 8025af40 <ticks>
    80201866:	639c                	ld	a5,0(a5)
    80201868:	00178713          	addi	a4,a5,1
    8020186c:	00059797          	auipc	a5,0x59
    80201870:	6d478793          	addi	a5,a5,1748 # 8025af40 <ticks>
    80201874:	e398                	sd	a4,0(a5)
    80201876:	f99ff0ef          	jal	ra,8020180e <clock_set_next_event>
    8020187a:	0001                	nop
    8020187c:	60a2                	ld	ra,8(sp)
    8020187e:	6402                	ld	s0,0(sp)
    80201880:	0141                	addi	sp,sp,16
    80201882:	8082                	ret

0000000080201884 <__alltraps>:
    80201884:	14011173          	csrrw	sp,sscratch,sp
    80201888:	716d                	addi	sp,sp,-272
    8020188a:	e406                	sd	ra,8(sp)
    8020188c:	ec0e                	sd	gp,24(sp)
    8020188e:	f416                	sd	t0,40(sp)
    80201890:	f81a                	sd	t1,48(sp)
    80201892:	fc1e                	sd	t2,56(sp)
    80201894:	e0a2                	sd	s0,64(sp)
    80201896:	e4a6                	sd	s1,72(sp)
    80201898:	e8aa                	sd	a0,80(sp)
    8020189a:	ecae                	sd	a1,88(sp)
    8020189c:	f0b2                	sd	a2,96(sp)
    8020189e:	f4b6                	sd	a3,104(sp)
    802018a0:	f8ba                	sd	a4,112(sp)
    802018a2:	fcbe                	sd	a5,120(sp)
    802018a4:	e142                	sd	a6,128(sp)
    802018a6:	e546                	sd	a7,136(sp)
    802018a8:	e94a                	sd	s2,144(sp)
    802018aa:	ed4e                	sd	s3,152(sp)
    802018ac:	f152                	sd	s4,160(sp)
    802018ae:	f556                	sd	s5,168(sp)
    802018b0:	f95a                	sd	s6,176(sp)
    802018b2:	fd5e                	sd	s7,184(sp)
    802018b4:	e1e2                	sd	s8,192(sp)
    802018b6:	e5e6                	sd	s9,200(sp)
    802018b8:	e9ea                	sd	s10,208(sp)
    802018ba:	edee                	sd	s11,216(sp)
    802018bc:	f1f2                	sd	t3,224(sp)
    802018be:	f5f6                	sd	t4,232(sp)
    802018c0:	f9fa                	sd	t5,240(sp)
    802018c2:	fdfe                	sd	t6,248(sp)
    802018c4:	100022f3          	csrr	t0,sstatus
    802018c8:	14102373          	csrr	t1,sepc
    802018cc:	e216                	sd	t0,256(sp)
    802018ce:	e61a                	sd	t1,264(sp)
    802018d0:	140023f3          	csrr	t2,sscratch
    802018d4:	e81e                	sd	t2,16(sp)
    802018d6:	850a                	mv	a0,sp
    802018d8:	b0dff0ef          	jal	ra,802013e4 <trap_handler>

00000000802018dc <__restore>:
    802018dc:	812a                	mv	sp,a0
    802018de:	6292                	ld	t0,256(sp)
    802018e0:	6332                	ld	t1,264(sp)
    802018e2:	63c2                	ld	t2,16(sp)
    802018e4:	10029073          	csrw	sstatus,t0
    802018e8:	14131073          	csrw	sepc,t1
    802018ec:	14039073          	csrw	sscratch,t2
    802018f0:	60a2                	ld	ra,8(sp)
    802018f2:	61e2                	ld	gp,24(sp)
    802018f4:	72a2                	ld	t0,40(sp)
    802018f6:	7342                	ld	t1,48(sp)
    802018f8:	73e2                	ld	t2,56(sp)
    802018fa:	6406                	ld	s0,64(sp)
    802018fc:	64a6                	ld	s1,72(sp)
    802018fe:	6546                	ld	a0,80(sp)
    80201900:	65e6                	ld	a1,88(sp)
    80201902:	7606                	ld	a2,96(sp)
    80201904:	76a6                	ld	a3,104(sp)
    80201906:	7746                	ld	a4,112(sp)
    80201908:	77e6                	ld	a5,120(sp)
    8020190a:	680a                	ld	a6,128(sp)
    8020190c:	68aa                	ld	a7,136(sp)
    8020190e:	694a                	ld	s2,144(sp)
    80201910:	69ea                	ld	s3,152(sp)
    80201912:	7a0a                	ld	s4,160(sp)
    80201914:	7aaa                	ld	s5,168(sp)
    80201916:	7b4a                	ld	s6,176(sp)
    80201918:	7bea                	ld	s7,184(sp)
    8020191a:	6c0e                	ld	s8,192(sp)
    8020191c:	6cae                	ld	s9,200(sp)
    8020191e:	6d4e                	ld	s10,208(sp)
    80201920:	6dee                	ld	s11,216(sp)
    80201922:	7e0e                	ld	t3,224(sp)
    80201924:	7eae                	ld	t4,232(sp)
    80201926:	7f4e                	ld	t5,240(sp)
    80201928:	7fee                	ld	t6,248(sp)
    8020192a:	6151                	addi	sp,sp,272
    8020192c:	14011173          	csrrw	sp,sscratch,sp
    80201930:	10200073          	sret
    80201934:	0000                	unimp
    80201936:	0000                	unimp
	...

000000008020193a <__switch>:
    8020193a:	00253423          	sd	sp,8(a0)
    8020193e:	00153023          	sd	ra,0(a0)
    80201942:	e900                	sd	s0,16(a0)
    80201944:	ed04                	sd	s1,24(a0)
    80201946:	03253023          	sd	s2,32(a0)
    8020194a:	03353423          	sd	s3,40(a0)
    8020194e:	03453823          	sd	s4,48(a0)
    80201952:	03553c23          	sd	s5,56(a0)
    80201956:	05653023          	sd	s6,64(a0)
    8020195a:	05753423          	sd	s7,72(a0)
    8020195e:	05853823          	sd	s8,80(a0)
    80201962:	05953c23          	sd	s9,88(a0)
    80201966:	07a53023          	sd	s10,96(a0)
    8020196a:	07b53423          	sd	s11,104(a0)
    8020196e:	0005b083          	ld	ra,0(a1)
    80201972:	6980                	ld	s0,16(a1)
    80201974:	6d84                	ld	s1,24(a1)
    80201976:	0205b903          	ld	s2,32(a1)
    8020197a:	0285b983          	ld	s3,40(a1)
    8020197e:	0305ba03          	ld	s4,48(a1)
    80201982:	0385ba83          	ld	s5,56(a1)
    80201986:	0405bb03          	ld	s6,64(a1)
    8020198a:	0485bb83          	ld	s7,72(a1)
    8020198e:	0505bc03          	ld	s8,80(a1)
    80201992:	0585bc83          	ld	s9,88(a1)
    80201996:	0605bd03          	ld	s10,96(a1)
    8020199a:	0685bd83          	ld	s11,104(a1)
    8020199e:	0085b103          	ld	sp,8(a1)
    802019a2:	8082                	ret
	...

Disassembly of section .rodata:

0000000080202000 <srodata>:
    80202000:	3231                	addiw	tp,tp,-20
    80202002:	33323133          	0x33323133
    80202006:	000a                	c.slli	zero,0x2
    80202008:	7830                	ld	a2,112(s0)
    8020200a:	0000                	unimp
    8020200c:	0000                	unimp
    8020200e:	0000                	unimp
    80202010:	6150                	ld	a2,128(a0)
    80202012:	696e                	ld	s2,216(sp)
    80202014:	46202163          	0x46202163
    80202018:	6c69                	lui	s8,0x1a
    8020201a:	3a65                	addiw	s4,s4,-7
    8020201c:	0020                	addi	s0,sp,8
    8020201e:	0000                	unimp
    80202020:	202c                	fld	fa1,64(s0)
    80202022:	694c                	ld	a1,144(a0)
    80202024:	656e                	ld	a0,216(sp)
    80202026:	203a                	fld	ft0,392(sp)
	...
    80202030:	000a                	c.slli	zero,0x2
    80202032:	0000                	unimp
    80202034:	0000                	unimp
    80202036:	0000                	unimp
    80202038:	7365545b          	0x7365545b
    8020203c:	5d74                	lw	a3,124(a0)
    8020203e:	5f20                	lw	s0,120(a4)
    80202040:	725f 7365 6f74      	0x6f747365725f
    80202046:	6572                	ld	a0,280(sp)
    80202048:	203a                	fld	ft0,392(sp)
    8020204a:	0000                	unimp
    8020204c:	0000                	unimp
    8020204e:	0000                	unimp
    80202050:	000a                	c.slli	zero,0x2
    80202052:	0000                	unimp
    80202054:	0000                	unimp
    80202056:	0000                	unimp
    80202058:	6e72656b          	0x6e72656b
    8020205c:	6c65                	lui	s8,0x19
    8020205e:	7461622f          	0x7461622f
    80202062:	742f6863          	bltu	t5,sp,802027b2 <srodata+0x7b2>
    80202066:	7361                	lui	t1,0xffff8
    80202068:	61742f6b          	0x61742f6b
    8020206c:	632e6b73          	csrrsi	s6,0x632,28
	...
    80202078:	72656b5b          	0x72656b5b
    8020207c:	656e                	ld	a0,216(sp)
    8020207e:	5d6c                	lw	a1,124(a0)
    80202080:	7220                	ld	s0,96(a2)
    80202082:	6165                	addi	sp,sp,112
    80202084:	7964                	ld	s1,240(a0)
    80202086:	7420                	ld	s0,104(s0)
    80202088:	7572206f          	j	80224fde <UserStack+0x1a0a6>
    8020208c:	206e                	fld	ft0,216(sp)
    8020208e:	6966                	ld	s2,88(sp)
    80202090:	7372                	ld	t1,312(sp)
    80202092:	2074                	fld	fa3,192(s0)
    80202094:	7061                	c.lui	zero,0xffff8
    80202096:	0a70                	addi	a2,sp,284
	...
    802020a0:	6e72656b          	0x6e72656b
    802020a4:	6c65                	lui	s8,0x19
    802020a6:	7461622f          	0x7461622f
    802020aa:	622f6863          	bltu	t5,sp,802026da <srodata+0x6da>
    802020ae:	7461                	lui	s0,0xffff8
    802020b0:	632e6863          	bltu	t3,s2,802026e0 <srodata+0x6e0>
    802020b4:	0000                	unimp
    802020b6:	0000                	unimp
    802020b8:	72656b5b          	0x72656b5b
    802020bc:	656e                	ld	a0,216(sp)
    802020be:	5d6c                	lw	a1,124(a0)
    802020c0:	4c20                	lw	s0,88(s0)
    802020c2:	6964616f          	jal	sp,80248758 <Kernelstack+0x15820>
    802020c6:	676e                	ld	a4,216(sp)
    802020c8:	6120                	ld	s0,64(a0)
    802020ca:	7070                	ld	a2,224(s0)
    802020cc:	005f 0000 000a      	0xa0000005f
    802020d2:	0000                	unimp
    802020d4:	0000                	unimp
    802020d6:	0000                	unimp
    802020d8:	6f54                	ld	a3,152(a4)
    802020da:	6174                	ld	a3,192(a0)
    802020dc:	206c                	fld	fa1,192(s0)
    802020de:	7061                	c.lui	zero,0xffff8
    802020e0:	6c70                	ld	a2,216(s0)
    802020e2:	6369                	lui	t1,0x1a
    802020e4:	7461                	lui	s0,0xffff8
    802020e6:	6f69                	lui	t5,0x1a
    802020e8:	736e                	ld	t1,248(sp)
    802020ea:	203a                	fld	ft0,392(sp)
    802020ec:	0000                	unimp
    802020ee:	0000                	unimp
    802020f0:	7041                	c.lui	zero,0xffff0
    802020f2:	2070                	fld	fa2,192(s0)
    802020f4:	0000                	unimp
    802020f6:	0000                	unimp
    802020f8:	0a3a                	slli	s4,s4,0xe
    802020fa:	2020                	fld	fs0,64(s0)
    802020fc:	72617453          	0x72617453
    80202100:	2074                	fld	fa3,192(s0)
    80202102:	6441                	lui	s0,0x10
    80202104:	7264                	ld	s1,224(a2)
    80202106:	7365                	lui	t1,0xffff9
    80202108:	00203a73          	csrrc	s4,frm,zero
    8020210c:	0000                	unimp
    8020210e:	0000                	unimp
    80202110:	200a                	fld	ft0,128(sp)
    80202112:	4520                	lw	s0,72(a0)
    80202114:	646e                	ld	s0,216(sp)
    80202116:	4120                	lw	s0,64(a0)
    80202118:	6464                	ld	s1,200(s0)
    8020211a:	6572                	ld	a0,280(sp)
    8020211c:	203a7373          	csrrci	t1,0x203,20
    80202120:	2020                	fld	fs0,64(s0)
    80202122:	0000                	unimp
    80202124:	0000                	unimp
    80202126:	0000                	unimp
    80202128:	7572                	ld	a0,312(sp)
    8020212a:	5f6e                	lw	t5,248(sp)
    8020212c:	656e                	ld	a0,216(sp)
    8020212e:	7478                	ld	a4,232(s0)
    80202130:	615f 7070 3a20      	0x3a207070615f
    80202136:	0020                	addi	s0,sp,8
    80202138:	7061                	c.lui	zero,0xffff8
    8020213a:	2070                	fld	fa2,192(s0)
    8020213c:	7865                	lui	a6,0xffff9
    8020213e:	6365                	lui	t1,0x19
    80202140:	7475                	lui	s0,0xffffd
    80202142:	2065                	0x2065
    80202144:	7265766f          	jal	a2,8025986a <Kernelstack+0x26932>
    80202148:	000a                	c.slli	zero,0x2
    8020214a:	0000                	unimp
    8020214c:	0000                	unimp
    8020214e:	0000                	unimp
    80202150:	7365545b          	0x7365545b
    80202154:	5d74                	lw	a3,124(a0)
    80202156:	4c20                	lw	s0,88(s0)
    80202158:	6964616f          	jal	sp,802487ee <Kernelstack+0x158b6>
    8020215c:	676e                	ld	a4,216(sp)
    8020215e:	6120                	ld	s0,64(a0)
    80202160:	7070                	ld	a2,224(s0)
    80202162:	6620                	ld	s0,72(a2)
    80202164:	6f72                	ld	t5,280(sp)
    80202166:	206d                	0x206d
	...
    80202170:	7420                	ld	s0,104(s0)
    80202172:	0000206f          	j	80204172 <app_1_start+0x1ea>
    80202176:	0000                	unimp
    80202178:	63706573          	csrrsi	a0,0x637,0
    8020217c:	3a20                	fld	fs0,112(a2)
    8020217e:	0020                	addi	s0,sp,8
    80202180:	000a                	c.slli	zero,0x2
    80202182:	0000                	unimp
    80202184:	0000                	unimp
    80202186:	0000                	unimp
    80202188:	2d2d                	addiw	s10,s10,11
    8020218a:	2d2d                	addiw	s10,s10,11
    8020218c:	6e69                	lui	t3,0x1a
    8020218e:	7469                	lui	s0,0xffffa
    80202190:	695f 746e 7265      	0x7265746e695f
    80202196:	7572                	ld	a0,312(sp)
    80202198:	7470                	ld	a2,232(s0)
    8020219a:	2d2d                	addiw	s10,s10,11
    8020219c:	2d2d                	addiw	s10,s10,11
    8020219e:	000a                	c.slli	zero,0x2
    802021a0:	72656b5b          	0x72656b5b
    802021a4:	656e                	ld	a0,216(sp)
    802021a6:	5d6c                	lw	a1,124(a0)
    802021a8:	4920                	lw	s0,80(a0)
    802021aa:	736e                	ld	t1,248(sp)
    802021ac:	7274                	ld	a3,224(a2)
    802021ae:	6375                	lui	t1,0x1d
    802021b0:	6974                	ld	a3,208(a0)
    802021b2:	41206e6f          	jal	t3,802085c4 <bootstack+0x25c4>
    802021b6:	6464                	ld	s1,200(s0)
    802021b8:	6572                	ld	a0,280(sp)
    802021ba:	4d207373          	csrrci	t1,0x4d2,0
    802021be:	7369                	lui	t1,0xffffa
    802021c0:	6c61                	lui	s8,0x18
    802021c2:	6769                	lui	a4,0x1a
    802021c4:	656e                	ld	a0,216(sp)
    802021c6:	2e64                	fld	fs1,216(a2)
    802021c8:	000a                	c.slli	zero,0x2
    802021ca:	0000                	unimp
    802021cc:	0000                	unimp
    802021ce:	0000                	unimp
    802021d0:	72656b5b          	0x72656b5b
    802021d4:	656e                	ld	a0,216(sp)
    802021d6:	5d6c                	lw	a1,124(a0)
    802021d8:	4920                	lw	s0,80(a0)
    802021da:	736e                	ld	t1,248(sp)
    802021dc:	7274                	ld	a3,224(a2)
    802021de:	6375                	lui	t1,0x1d
    802021e0:	6974                	ld	a3,208(a0)
    802021e2:	41206e6f          	jal	t3,802085f4 <bootstack+0x25f4>
    802021e6:	73656363          	bltu	a0,s6,8020290c <srodata+0x90c>
    802021ea:	61462073          	csrs	0x614,a2
    802021ee:	6c75                	lui	s8,0x1d
    802021f0:	2e74                	fld	fa3,216(a2)
    802021f2:	000a                	c.slli	zero,0x2
    802021f4:	0000                	unimp
    802021f6:	0000                	unimp
    802021f8:	6e72656b          	0x6e72656b
    802021fc:	6c65                	lui	s8,0x19
    802021fe:	205d                	0x205d
    80202200:	6c49                	lui	s8,0x12
    80202202:	656c                	ld	a1,200(a0)
    80202204:	206c6167          	0x206c6167
    80202208:	6e49                	lui	t3,0x12
    8020220a:	75727473          	csrrci	s0,0x757,4
    8020220e:	6f697463          	bgeu	s2,s6,802028f6 <srodata+0x8f6>
    80202212:	2e6e                	fld	ft8,216(sp)
    80202214:	000a                	c.slli	zero,0x2
    80202216:	0000                	unimp
    80202218:	72656b5b          	0x72656b5b
    8020221c:	656e                	ld	a0,216(sp)
    8020221e:	5d6c                	lw	a1,124(a0)
    80202220:	4220                	lw	s0,64(a2)
    80202222:	6572                	ld	a0,280(sp)
    80202224:	6b61                	lui	s6,0x18
    80202226:	6f70                	ld	a2,216(a4)
    80202228:	6e69                	lui	t3,0x1a
    8020222a:	2e74                	fld	fa3,216(a2)
    8020222c:	000a                	c.slli	zero,0x2
    8020222e:	0000                	unimp
    80202230:	72656b5b          	0x72656b5b
    80202234:	656e                	ld	a0,216(sp)
    80202236:	5d6c                	lw	a1,124(a0)
    80202238:	4c20                	lw	s0,88(s0)
    8020223a:	2064616f          	jal	sp,80248440 <Kernelstack+0x15508>
    8020223e:	6441                	lui	s0,0x10
    80202240:	7264                	ld	s1,224(a2)
    80202242:	7365                	lui	t1,0xffff9
    80202244:	694d2073          	csrs	0x694,s10
    80202248:	696c6173          	csrrsi	sp,0x696,24
    8020224c:	64656e67          	0x64656e67
    80202250:	0a2e                	slli	s4,s4,0xb
    80202252:	0000                	unimp
    80202254:	0000                	unimp
    80202256:	0000                	unimp
    80202258:	72656b5b          	0x72656b5b
    8020225c:	656e                	ld	a0,216(sp)
    8020225e:	5d6c                	lw	a1,124(a0)
    80202260:	4c20                	lw	s0,88(s0)
    80202262:	2064616f          	jal	sp,80248468 <Kernelstack+0x15530>
    80202266:	6341                	lui	t1,0x10
    80202268:	73736563          	bltu	t1,s7,80202992 <srodata+0x992>
    8020226c:	4620                	lw	s0,72(a2)
    8020226e:	7561                	lui	a0,0xffff8
    80202270:	746c                	ld	a1,232(s0)
    80202272:	0a2e                	slli	s4,s4,0xb
    80202274:	0000                	unimp
    80202276:	0000                	unimp
    80202278:	72656b5b          	0x72656b5b
    8020227c:	656e                	ld	a0,216(sp)
    8020227e:	5d6c                	lw	a1,124(a0)
    80202280:	5320                	lw	s0,96(a4)
    80202282:	6f74                	ld	a3,216(a4)
    80202284:	6572                	ld	a0,280(sp)
    80202286:	4f4d412f          	0x4f4d412f
    8020228a:	4120                	lw	s0,64(a0)
    8020228c:	6464                	ld	s1,200(s0)
    8020228e:	6572                	ld	a0,280(sp)
    80202290:	4d207373          	csrrci	t1,0x4d2,0
    80202294:	7369                	lui	t1,0xffffa
    80202296:	6c61                	lui	s8,0x18
    80202298:	6769                	lui	a4,0x1a
    8020229a:	656e                	ld	a0,216(sp)
    8020229c:	2e64                	fld	fs1,216(a2)
    8020229e:	000a                	c.slli	zero,0x2
    802022a0:	72656b5b          	0x72656b5b
    802022a4:	656e                	ld	a0,216(sp)
    802022a6:	5d6c                	lw	a1,124(a0)
    802022a8:	5320                	lw	s0,96(a4)
    802022aa:	6f74                	ld	a3,216(a4)
    802022ac:	6572                	ld	a0,280(sp)
    802022ae:	4f4d412f          	0x4f4d412f
    802022b2:	4120                	lw	s0,64(a0)
    802022b4:	73656363          	bltu	a0,s6,802029da <srodata+0x9da>
    802022b8:	61462073          	csrs	0x614,a2
    802022bc:	6c75                	lui	s8,0x1d
    802022be:	2e74                	fld	fa3,216(a2)
    802022c0:	000a                	c.slli	zero,0x2
    802022c2:	0000                	unimp
    802022c4:	0000                	unimp
    802022c6:	0000                	unimp
    802022c8:	72656b5b          	0x72656b5b
    802022cc:	656e                	ld	a0,216(sp)
    802022ce:	5d6c                	lw	a1,124(a0)
    802022d0:	4520                	lw	s0,72(a0)
    802022d2:	766e                	ld	a2,248(sp)
    802022d4:	7269                	lui	tp,0xffffa
    802022d6:	656d6e6f          	jal	t3,802d892c <ebss+0x7d9e4>
    802022da:	746e                	ld	s0,248(sp)
    802022dc:	4320                	lw	s0,64(a4)
    802022de:	6c61                	lui	s8,0x18
    802022e0:	206c                	fld	fa1,192(s0)
    802022e2:	7266                	ld	tp,120(sp)
    802022e4:	53206d6f          	jal	s10,80208816 <bootstack+0x2816>
    802022e8:	6d2d                	lui	s10,0xb
    802022ea:	2e65646f          	jal	s0,802585d0 <Kernelstack+0x25698>
    802022ee:	000a                	c.slli	zero,0x2
    802022f0:	72656b5b          	0x72656b5b
    802022f4:	656e                	ld	a0,216(sp)
    802022f6:	5d6c                	lw	a1,124(a0)
    802022f8:	4520                	lw	s0,72(a0)
    802022fa:	766e                	ld	a2,248(sp)
    802022fc:	7269                	lui	tp,0xffffa
    802022fe:	656d6e6f          	jal	t3,802d8954 <ebss+0x7da0c>
    80202302:	746e                	ld	s0,248(sp)
    80202304:	4320                	lw	s0,64(a4)
    80202306:	6c61                	lui	s8,0x18
    80202308:	206c                	fld	fa1,192(s0)
    8020230a:	7266                	ld	tp,120(sp)
    8020230c:	4d206d6f          	jal	s10,802087de <bootstack+0x27de>
    80202310:	6d2d                	lui	s10,0xb
    80202312:	2e65646f          	jal	s0,802585f8 <Kernelstack+0x256c0>
    80202316:	000a                	c.slli	zero,0x2
    80202318:	72656b5b          	0x72656b5b
    8020231c:	656e                	ld	a0,216(sp)
    8020231e:	5d6c                	lw	a1,124(a0)
    80202320:	4920                	lw	s0,80(a0)
    80202322:	736e                	ld	t1,248(sp)
    80202324:	7274                	ld	a3,224(a2)
    80202326:	6375                	lui	t1,0x1d
    80202328:	6974                	ld	a3,208(a0)
    8020232a:	50206e6f          	jal	t3,8020882c <bootstack+0x282c>
    8020232e:	6761                	lui	a4,0x18
    80202330:	2065                	0x2065
    80202332:	6146                	ld	sp,80(sp)
    80202334:	6c75                	lui	s8,0x1d
    80202336:	2e74                	fld	fa3,216(a2)
    80202338:	000a                	c.slli	zero,0x2
    8020233a:	0000                	unimp
    8020233c:	0000                	unimp
    8020233e:	0000                	unimp
    80202340:	72656b5b          	0x72656b5b
    80202344:	656e                	ld	a0,216(sp)
    80202346:	5d6c                	lw	a1,124(a0)
    80202348:	4c20                	lw	s0,88(s0)
    8020234a:	2064616f          	jal	sp,80248550 <Kernelstack+0x15618>
    8020234e:	6150                	ld	a2,128(a0)
    80202350:	46206567          	0x46206567
    80202354:	7561                	lui	a0,0xffff8
    80202356:	746c                	ld	a1,232(s0)
    80202358:	0a2e                	slli	s4,s4,0xb
    8020235a:	0000                	unimp
    8020235c:	0000                	unimp
    8020235e:	0000                	unimp
    80202360:	72656b5b          	0x72656b5b
    80202364:	656e                	ld	a0,216(sp)
    80202366:	5d6c                	lw	a1,124(a0)
    80202368:	5320                	lw	s0,96(a4)
    8020236a:	6f74                	ld	a3,216(a4)
    8020236c:	6572                	ld	a0,280(sp)
    8020236e:	4f4d412f          	0x4f4d412f
    80202372:	5020                	lw	s0,96(s0)
    80202374:	6761                	lui	a4,0x18
    80202376:	2065                	0x2065
    80202378:	6146                	ld	sp,80(sp)
    8020237a:	6c75                	lui	s8,0x1d
    8020237c:	2e74                	fld	fa3,216(a2)
    8020237e:	000a                	c.slli	zero,0x2
    80202380:	72656b5b          	0x72656b5b
    80202384:	656e                	ld	a0,216(sp)
    80202386:	5d6c                	lw	a1,124(a0)
    80202388:	5520                	lw	s0,104(a0)
    8020238a:	736e                	ld	t1,248(sp)
    8020238c:	7075                	c.lui	zero,0xffffd
    8020238e:	6f70                	ld	a2,216(a4)
    80202390:	7472                	ld	s0,312(sp)
    80202392:	6465                	lui	s0,0x19
    80202394:	7420                	ld	s0,104(s0)
    80202396:	6172                	ld	sp,280(sp)
    80202398:	2e70                	fld	fa2,216(a2)
    8020239a:	000a                	c.slli	zero,0x2
    8020239c:	f0ac                	sd	a1,96(s1)
    8020239e:	ffff                	0xffff
    802023a0:	f0c4                	sd	s1,160(s1)
    802023a2:	ffff                	0xffff
    802023a4:	f0dc                	sd	a5,160(s1)
    802023a6:	ffff                	0xffff
    802023a8:	f0f0                	sd	a2,224(s1)
    802023aa:	ffff                	0xffff
    802023ac:	f112                	sd	tp,160(sp)
    802023ae:	ffff                	0xffff
    802023b0:	f126                	sd	s1,160(sp)
    802023b2:	ffff                	0xffff
    802023b4:	f13a                	sd	a4,160(sp)
    802023b6:	ffff                	0xffff
    802023b8:	f14e                	sd	s3,160(sp)
    802023ba:	ffff                	0xffff
    802023bc:	f180                	sd	s0,32(a1)
    802023be:	ffff                	0xffff
    802023c0:	f1d0                	sd	a2,160(a1)
    802023c2:	ffff                	0xffff
    802023c4:	f258                	sd	a4,160(a2)
    802023c6:	ffff                	0xffff
    802023c8:	f202                	sd	zero,288(sp)
    802023ca:	ffff                	0xffff
    802023cc:	f216                	sd	t0,288(sp)
    802023ce:	ffff                	0xffff
    802023d0:	f22a                	sd	a0,288(sp)
    802023d2:	ffff                	0xffff
    802023d4:	f258                	sd	a4,160(a2)
    802023d6:	ffff                	0xffff
    802023d8:	f23e                	sd	a5,288(sp)
    802023da:	ffff                	0xffff
    802023dc:	0000                	unimp
    802023de:	0000                	unimp
    802023e0:	7865                	lui	a6,0xffff9
    802023e2:	7469                	lui	s0,0xffffa
    802023e4:	3a20                	fld	fs0,112(a2)
    802023e6:	0020                	addi	s0,sp,8
    802023e8:	000a                	c.slli	zero,0x2
    802023ea:	0000                	unimp
    802023ec:	0000                	unimp
    802023ee:	0000                	unimp
    802023f0:	6e72656b          	0x6e72656b
    802023f4:	6c65                	lui	s8,0x19
    802023f6:	6172742f          	0x6172742f
    802023fa:	2f70                	fld	fa2,216(a4)
    802023fc:	63737973          	csrrci	s2,0x637,6
    80202400:	6c61                	lui	s8,0x18
    80202402:	2f6c                	fld	fa1,216(a4)
    80202404:	63737973          	csrrci	s2,0x637,6
    80202408:	6c61                	lui	s8,0x18
    8020240a:	2e6c                	fld	fa1,216(a2)
    8020240c:	00000063          	beqz	zero,8020240c <srodata+0x40c>
    80202410:	2d0a                	fld	fs10,128(sp)
    80202412:	2d2d                	addiw	s10,s10,11
    80202414:	2d2d                	addiw	s10,s10,11
    80202416:	2d2d                	addiw	s10,s10,11
    80202418:	6979                	lui	s2,0x1e
    8020241a:	6c65                	lui	s8,0x19
    8020241c:	2d64                	fld	fs1,216(a0)
    8020241e:	2d2d                	addiw	s10,s10,11
    80202420:	2d2d                	addiw	s10,s10,11
    80202422:	0a2d                	addi	s4,s4,11
    80202424:	0000                	unimp
    80202426:	0000                	unimp
    80202428:	6e75                	lui	t3,0x1d
    8020242a:	70707573          	csrrci	a0,0x707,0
    8020242e:	6174726f          	jal	tp,8024a244 <Kernelstack+0x1730c>
    80202432:	6c62                	ld	s8,24(sp)
    80202434:	2065                	0x2065
    80202436:	63737973          	csrrci	s2,0x637,6
    8020243a:	6c61                	lui	s8,0x18
    8020243c:	5f6c                	lw	a1,124(a4)
    8020243e:	6469                	lui	s0,0x1a
    80202440:	000a                	c.slli	zero,0x2
    80202442:	0000                	unimp
    80202444:	0000                	unimp
    80202446:	0000                	unimp
    80202448:	2d2d                	addiw	s10,s10,11
    8020244a:	2d2d                	addiw	s10,s10,11
    8020244c:	6974                	ld	a3,208(a0)
    8020244e:	656d                	lui	a0,0x1b
    80202450:	5f72                	lw	t5,60(sp)
    80202452:	6e69                	lui	t3,0x1a
    80202454:	7469                	lui	s0,0xffffa
    80202456:	2d2d                	addiw	s10,s10,11
    80202458:	2d2d                	addiw	s10,s10,11
    8020245a:	000a                	c.slli	zero,0x2
	...

Disassembly of section .data:

0000000080203000 <_num_app>:
    80203000:	00000003          	lb	zero,0(zero) # 0 <n-0xc>
    80203004:	0000                	unimp
    80203006:	0000                	unimp
    80203008:	3040                	fld	fs0,160(s0)
    8020300a:	8020                	0x8020
    8020300c:	0000                	unimp
    8020300e:	0000                	unimp
    80203010:	3f81                	addiw	t6,t6,-32
    80203012:	8020                	0x8020
    80203014:	0000                	unimp
    80203016:	0000                	unimp
    80203018:	3f88                	fld	fa0,56(a5)
    8020301a:	8020                	0x8020
    8020301c:	0000                	unimp
    8020301e:	0000                	unimp
    80203020:	4ec9                	li	t4,18
    80203022:	8020                	0x8020
    80203024:	0000                	unimp
    80203026:	0000                	unimp
    80203028:	4ed0                	lw	a2,28(a3)
    8020302a:	8020                	0x8020
    8020302c:	0000                	unimp
    8020302e:	0000                	unimp
    80203030:	5e11                	li	t3,-28
    80203032:	8020                	0x8020
    80203034:	0000                	unimp
	...

0000000080203038 <_app_names>:
    80203038:	3230                	fld	fa2,96(a2)
    8020303a:	0074                	addi	a3,sp,12
    8020303c:	0000                	unimp
	...

0000000080203040 <app_0_start>:
    80203040:	00011117          	auipc	sp,0x11
    80203044:	f4110113          	addi	sp,sp,-191 # 80213f81 <UserStack+0x9049>
    80203048:	0040006f          	j	8020304c <app_0_start+0xc>
    8020304c:	1141                	addi	sp,sp,-16
    8020304e:	e406                	sd	ra,8(sp)
    80203050:	e022                	sd	s0,0(sp)
    80203052:	0800                	addi	s0,sp,16
    80203054:	00001517          	auipc	a0,0x1
    80203058:	e3c50513          	addi	a0,a0,-452 # 80203e90 <app_0_start+0xe50>
    8020305c:	0b5000ef          	jal	ra,80203910 <app_0_start+0x8d0>
    80203060:	00001517          	auipc	a0,0x1
    80203064:	e4850513          	addi	a0,a0,-440 # 80203ea8 <app_0_start+0xe68>
    80203068:	0a9000ef          	jal	ra,80203910 <app_0_start+0x8d0>
    8020306c:	5a3000ef          	jal	ra,80203e0e <app_0_start+0xdce>
    80203070:	87aa                	mv	a5,a0
    80203072:	2781                	sext.w	a5,a5
    80203074:	853e                	mv	a0,a5
    80203076:	080000ef          	jal	ra,802030f6 <app_0_start+0xb6>
    8020307a:	0001                	nop
    8020307c:	60a2                	ld	ra,8(sp)
    8020307e:	6402                	ld	s0,0(sp)
    80203080:	0141                	addi	sp,sp,16
    80203082:	8082                	ret
    80203084:	7179                	addi	sp,sp,-48
    80203086:	f422                	sd	s0,40(sp)
    80203088:	1800                	addi	s0,sp,48
    8020308a:	fea43423          	sd	a0,-24(s0) # ffffffffffff9fe8 <ebss+0xffffffff7fd9f0a0>
    8020308e:	feb43023          	sd	a1,-32(s0)
    80203092:	fcc43c23          	sd	a2,-40(s0)
    80203096:	fcd43823          	sd	a3,-48(s0)
    8020309a:	fe043503          	ld	a0,-32(s0)
    8020309e:	fd843583          	ld	a1,-40(s0)
    802030a2:	fd043603          	ld	a2,-48(s0)
    802030a6:	fe843883          	ld	a7,-24(s0)
    802030aa:	00000073          	ecall
    802030ae:	87aa                	mv	a5,a0
    802030b0:	853e                	mv	a0,a5
    802030b2:	7422                	ld	s0,40(sp)
    802030b4:	6145                	addi	sp,sp,48
    802030b6:	8082                	ret
    802030b8:	7179                	addi	sp,sp,-48
    802030ba:	f406                	sd	ra,40(sp)
    802030bc:	f022                	sd	s0,32(sp)
    802030be:	ec26                	sd	s1,24(sp)
    802030c0:	1800                	addi	s0,sp,48
    802030c2:	fca43c23          	sd	a0,-40(s0)
    802030c6:	fcb43823          	sd	a1,-48(s0)
    802030ca:	fd043483          	ld	s1,-48(s0)
    802030ce:	fd043503          	ld	a0,-48(s0)
    802030d2:	175000ef          	jal	ra,80203a46 <app_0_start+0xa06>
    802030d6:	87aa                	mv	a5,a0
    802030d8:	86be                	mv	a3,a5
    802030da:	8626                	mv	a2,s1
    802030dc:	fd843583          	ld	a1,-40(s0)
    802030e0:	04000513          	li	a0,64
    802030e4:	fa1ff0ef          	jal	ra,80203084 <app_0_start+0x44>
    802030e8:	87aa                	mv	a5,a0
    802030ea:	853e                	mv	a0,a5
    802030ec:	70a2                	ld	ra,40(sp)
    802030ee:	7402                	ld	s0,32(sp)
    802030f0:	64e2                	ld	s1,24(sp)
    802030f2:	6145                	addi	sp,sp,48
    802030f4:	8082                	ret
    802030f6:	1101                	addi	sp,sp,-32
    802030f8:	ec06                	sd	ra,24(sp)
    802030fa:	e822                	sd	s0,16(sp)
    802030fc:	1000                	addi	s0,sp,32
    802030fe:	87aa                	mv	a5,a0
    80203100:	fef42623          	sw	a5,-20(s0)
    80203104:	fec42783          	lw	a5,-20(s0)
    80203108:	4681                	li	a3,0
    8020310a:	4601                	li	a2,0
    8020310c:	85be                	mv	a1,a5
    8020310e:	05d00513          	li	a0,93
    80203112:	f73ff0ef          	jal	ra,80203084 <app_0_start+0x44>
    80203116:	0001                	nop
    80203118:	60e2                	ld	ra,24(sp)
    8020311a:	6442                	ld	s0,16(sp)
    8020311c:	6105                	addi	sp,sp,32
    8020311e:	8082                	ret
    80203120:	1141                	addi	sp,sp,-16
    80203122:	e406                	sd	ra,8(sp)
    80203124:	e022                	sd	s0,0(sp)
    80203126:	0800                	addi	s0,sp,16
    80203128:	4681                	li	a3,0
    8020312a:	4601                	li	a2,0
    8020312c:	4581                	li	a1,0
    8020312e:	07c00513          	li	a0,124
    80203132:	f53ff0ef          	jal	ra,80203084 <app_0_start+0x44>
    80203136:	0001                	nop
    80203138:	60a2                	ld	ra,8(sp)
    8020313a:	6402                	ld	s0,0(sp)
    8020313c:	0141                	addi	sp,sp,16
    8020313e:	8082                	ret
    80203140:	1101                	addi	sp,sp,-32
    80203142:	ec06                	sd	ra,24(sp)
    80203144:	e822                	sd	s0,16(sp)
    80203146:	1000                	addi	s0,sp,32
    80203148:	fea43423          	sd	a0,-24(s0)
    8020314c:	fe843583          	ld	a1,-24(s0)
    80203150:	4505                	li	a0,1
    80203152:	f67ff0ef          	jal	ra,802030b8 <app_0_start+0x78>
    80203156:	0001                	nop
    80203158:	60e2                	ld	ra,24(sp)
    8020315a:	6442                	ld	s0,16(sp)
    8020315c:	6105                	addi	sp,sp,32
    8020315e:	8082                	ret
    80203160:	7179                	addi	sp,sp,-48
    80203162:	f422                	sd	s0,40(sp)
    80203164:	1800                	addi	s0,sp,48
    80203166:	fca43c23          	sd	a0,-40(s0)
    8020316a:	fe042623          	sw	zero,-20(s0)
    8020316e:	a031                	j	8020317a <app_0_start+0x13a>
    80203170:	fec42783          	lw	a5,-20(s0)
    80203174:	2785                	addiw	a5,a5,1
    80203176:	fef42623          	sw	a5,-20(s0)
    8020317a:	fec46783          	lwu	a5,-20(s0)
    8020317e:	fd843703          	ld	a4,-40(s0)
    80203182:	97ba                	add	a5,a5,a4
    80203184:	0007c783          	lbu	a5,0(a5)
    80203188:	f7e5                	bnez	a5,80203170 <app_0_start+0x130>
    8020318a:	fec42783          	lw	a5,-20(s0)
    8020318e:	853e                	mv	a0,a5
    80203190:	7422                	ld	s0,40(sp)
    80203192:	6145                	addi	sp,sp,48
    80203194:	8082                	ret
    80203196:	715d                	addi	sp,sp,-80
    80203198:	e4a2                	sd	s0,72(sp)
    8020319a:	0880                	addi	s0,sp,80
    8020319c:	fca43423          	sd	a0,-56(s0)
    802031a0:	fae43823          	sd	a4,-80(s0)
    802031a4:	873e                	mv	a4,a5
    802031a6:	87ae                	mv	a5,a1
    802031a8:	fcf42223          	sw	a5,-60(s0)
    802031ac:	87b2                	mv	a5,a2
    802031ae:	fcf42023          	sw	a5,-64(s0)
    802031b2:	87b6                	mv	a5,a3
    802031b4:	faf42e23          	sw	a5,-68(s0)
    802031b8:	87ba                	mv	a5,a4
    802031ba:	faf42c23          	sw	a5,-72(s0)
    802031be:	fb043783          	ld	a5,-80(s0)
    802031c2:	fef43423          	sd	a5,-24(s0)
    802031c6:	fe042223          	sw	zero,-28(s0)
    802031ca:	fc442783          	lw	a5,-60(s0)
    802031ce:	0007871b          	sext.w	a4,a5
    802031d2:	47c1                	li	a5,16
    802031d4:	00e7f463          	bgeu	a5,a4,802031dc <app_0_start+0x19c>
    802031d8:	4781                	li	a5,0
    802031da:	aae9                	j	802033b4 <app_0_start+0x374>
    802031dc:	fc843783          	ld	a5,-56(s0)
    802031e0:	0007df63          	bgez	a5,802031fe <app_0_start+0x1be>
    802031e4:	fbc42783          	lw	a5,-68(s0)
    802031e8:	2781                	sext.w	a5,a5
    802031ea:	eb91                	bnez	a5,802031fe <app_0_start+0x1be>
    802031ec:	4785                	li	a5,1
    802031ee:	fef42223          	sw	a5,-28(s0)
    802031f2:	fc843783          	ld	a5,-56(s0)
    802031f6:	40f007b3          	neg	a5,a5
    802031fa:	fcf43423          	sd	a5,-56(s0)
    802031fe:	fc042e23          	sw	zero,-36(s0)
    80203202:	fbc42783          	lw	a5,-68(s0)
    80203206:	2781                	sext.w	a5,a5
    80203208:	cb91                	beqz	a5,8020321c <app_0_start+0x1dc>
    8020320a:	fc843703          	ld	a4,-56(s0)
    8020320e:	fc446783          	lwu	a5,-60(s0)
    80203212:	02f777b3          	remu	a5,a4,a5
    80203216:	fcf42e23          	sw	a5,-36(s0)
    8020321a:	a809                	j	8020322c <app_0_start+0x1ec>
    8020321c:	fc446783          	lwu	a5,-60(s0)
    80203220:	fc843703          	ld	a4,-56(s0)
    80203224:	02f767b3          	rem	a5,a4,a5
    80203228:	fcf42e23          	sw	a5,-36(s0)
    8020322c:	fdc42783          	lw	a5,-36(s0)
    80203230:	0007871b          	sext.w	a4,a5
    80203234:	47a5                	li	a5,9
    80203236:	00e7cb63          	blt	a5,a4,8020324c <app_0_start+0x20c>
    8020323a:	fdc42783          	lw	a5,-36(s0)
    8020323e:	0ff7f793          	andi	a5,a5,255
    80203242:	0307879b          	addiw	a5,a5,48
    80203246:	0ff7f713          	andi	a4,a5,255
    8020324a:	a025                	j	80203272 <app_0_start+0x232>
    8020324c:	fc042783          	lw	a5,-64(s0)
    80203250:	2781                	sext.w	a5,a5
    80203252:	c781                	beqz	a5,8020325a <app_0_start+0x21a>
    80203254:	04100793          	li	a5,65
    80203258:	a019                	j	8020325e <app_0_start+0x21e>
    8020325a:	06100793          	li	a5,97
    8020325e:	fdc42703          	lw	a4,-36(s0)
    80203262:	0ff77713          	andi	a4,a4,255
    80203266:	9fb9                	addw	a5,a5,a4
    80203268:	0ff7f793          	andi	a5,a5,255
    8020326c:	37d9                	addiw	a5,a5,-10
    8020326e:	0ff7f713          	andi	a4,a5,255
    80203272:	fe843783          	ld	a5,-24(s0)
    80203276:	00178693          	addi	a3,a5,1
    8020327a:	fed43423          	sd	a3,-24(s0)
    8020327e:	00e78023          	sb	a4,0(a5)
    80203282:	fbc42783          	lw	a5,-68(s0)
    80203286:	2781                	sext.w	a5,a5
    80203288:	cb91                	beqz	a5,8020329c <app_0_start+0x25c>
    8020328a:	fc843703          	ld	a4,-56(s0)
    8020328e:	fc446783          	lwu	a5,-60(s0)
    80203292:	02f757b3          	divu	a5,a4,a5
    80203296:	fcf43423          	sd	a5,-56(s0)
    8020329a:	a809                	j	802032ac <app_0_start+0x26c>
    8020329c:	fc446783          	lwu	a5,-60(s0)
    802032a0:	fc843703          	ld	a4,-56(s0)
    802032a4:	02f747b3          	div	a5,a4,a5
    802032a8:	fcf43423          	sd	a5,-56(s0)
    802032ac:	fc843783          	ld	a5,-56(s0)
    802032b0:	f7b9                	bnez	a5,802031fe <app_0_start+0x1be>
    802032b2:	fe843703          	ld	a4,-24(s0)
    802032b6:	fb043783          	ld	a5,-80(s0)
    802032ba:	40f707b3          	sub	a5,a4,a5
    802032be:	fef42023          	sw	a5,-32(s0)
    802032c2:	a005                	j	802032e2 <app_0_start+0x2a2>
    802032c4:	fe843783          	ld	a5,-24(s0)
    802032c8:	00178713          	addi	a4,a5,1
    802032cc:	fee43423          	sd	a4,-24(s0)
    802032d0:	03000713          	li	a4,48
    802032d4:	00e78023          	sb	a4,0(a5)
    802032d8:	fe042783          	lw	a5,-32(s0)
    802032dc:	2785                	addiw	a5,a5,1
    802032de:	fef42023          	sw	a5,-32(s0)
    802032e2:	fe042703          	lw	a4,-32(s0)
    802032e6:	fb842783          	lw	a5,-72(s0)
    802032ea:	2701                	sext.w	a4,a4
    802032ec:	2781                	sext.w	a5,a5
    802032ee:	fcf76be3          	bltu	a4,a5,802032c4 <app_0_start+0x284>
    802032f2:	fe442783          	lw	a5,-28(s0)
    802032f6:	2781                	sext.w	a5,a5
    802032f8:	cb99                	beqz	a5,8020330e <app_0_start+0x2ce>
    802032fa:	fe843783          	ld	a5,-24(s0)
    802032fe:	00178713          	addi	a4,a5,1
    80203302:	fee43423          	sd	a4,-24(s0)
    80203306:	02d00713          	li	a4,45
    8020330a:	00e78023          	sb	a4,0(a5)
    8020330e:	fe843783          	ld	a5,-24(s0)
    80203312:	00078023          	sb	zero,0(a5)
    80203316:	fe843703          	ld	a4,-24(s0)
    8020331a:	fb043783          	ld	a5,-80(s0)
    8020331e:	40f707b3          	sub	a5,a4,a5
    80203322:	fcf42c23          	sw	a5,-40(s0)
    80203326:	fe042023          	sw	zero,-32(s0)
    8020332a:	a885                	j	8020339a <app_0_start+0x35a>
    8020332c:	fe046783          	lwu	a5,-32(s0)
    80203330:	fb043703          	ld	a4,-80(s0)
    80203334:	97ba                	add	a5,a5,a4
    80203336:	0007c783          	lbu	a5,0(a5)
    8020333a:	fcf40ba3          	sb	a5,-41(s0)
    8020333e:	fd842703          	lw	a4,-40(s0)
    80203342:	fe042783          	lw	a5,-32(s0)
    80203346:	40f707bb          	subw	a5,a4,a5
    8020334a:	2781                	sext.w	a5,a5
    8020334c:	37fd                	addiw	a5,a5,-1
    8020334e:	2781                	sext.w	a5,a5
    80203350:	1782                	slli	a5,a5,0x20
    80203352:	9381                	srli	a5,a5,0x20
    80203354:	fb043703          	ld	a4,-80(s0)
    80203358:	973e                	add	a4,a4,a5
    8020335a:	fe046783          	lwu	a5,-32(s0)
    8020335e:	fb043683          	ld	a3,-80(s0)
    80203362:	97b6                	add	a5,a5,a3
    80203364:	00074703          	lbu	a4,0(a4) # 18000 <n+0x17fe0>
    80203368:	00e78023          	sb	a4,0(a5)
    8020336c:	fd842703          	lw	a4,-40(s0)
    80203370:	fe042783          	lw	a5,-32(s0)
    80203374:	40f707bb          	subw	a5,a4,a5
    80203378:	2781                	sext.w	a5,a5
    8020337a:	37fd                	addiw	a5,a5,-1
    8020337c:	2781                	sext.w	a5,a5
    8020337e:	1782                	slli	a5,a5,0x20
    80203380:	9381                	srli	a5,a5,0x20
    80203382:	fb043703          	ld	a4,-80(s0)
    80203386:	97ba                	add	a5,a5,a4
    80203388:	fd744703          	lbu	a4,-41(s0)
    8020338c:	00e78023          	sb	a4,0(a5)
    80203390:	fe042783          	lw	a5,-32(s0)
    80203394:	2785                	addiw	a5,a5,1
    80203396:	fef42023          	sw	a5,-32(s0)
    8020339a:	fd842783          	lw	a5,-40(s0)
    8020339e:	0017d79b          	srliw	a5,a5,0x1
    802033a2:	0007871b          	sext.w	a4,a5
    802033a6:	fe042783          	lw	a5,-32(s0)
    802033aa:	2781                	sext.w	a5,a5
    802033ac:	f8e7e0e3          	bltu	a5,a4,8020332c <app_0_start+0x2ec>
    802033b0:	fd842783          	lw	a5,-40(s0)
    802033b4:	853e                	mv	a0,a5
    802033b6:	6426                	ld	s0,72(sp)
    802033b8:	6161                	addi	sp,sp,80
    802033ba:	8082                	ret
    802033bc:	1101                	addi	sp,sp,-32
    802033be:	ec22                	sd	s0,24(sp)
    802033c0:	1000                	addi	s0,sp,32
    802033c2:	87aa                	mv	a5,a0
    802033c4:	feb43023          	sd	a1,-32(s0)
    802033c8:	fef42623          	sw	a5,-20(s0)
    802033cc:	fe043783          	ld	a5,-32(s0)
    802033d0:	6798                	ld	a4,8(a5)
    802033d2:	fe043783          	ld	a5,-32(s0)
    802033d6:	639c                	ld	a5,0(a5)
    802033d8:	40f707b3          	sub	a5,a4,a5
    802033dc:	2781                	sext.w	a5,a5
    802033de:	2785                	addiw	a5,a5,1
    802033e0:	0007871b          	sext.w	a4,a5
    802033e4:	fe043783          	ld	a5,-32(s0)
    802033e8:	4b9c                	lw	a5,16(a5)
    802033ea:	00f76463          	bltu	a4,a5,802033f2 <app_0_start+0x3b2>
    802033ee:	4781                	li	a5,0
    802033f0:	a02d                	j	8020341a <app_0_start+0x3da>
    802033f2:	fe043783          	ld	a5,-32(s0)
    802033f6:	679c                	ld	a5,8(a5)
    802033f8:	00178693          	addi	a3,a5,1
    802033fc:	fe043703          	ld	a4,-32(s0)
    80203400:	e714                	sd	a3,8(a4)
    80203402:	fec42703          	lw	a4,-20(s0)
    80203406:	0ff77713          	andi	a4,a4,255
    8020340a:	00e78023          	sb	a4,0(a5)
    8020340e:	fe043783          	ld	a5,-32(s0)
    80203412:	679c                	ld	a5,8(a5)
    80203414:	00078023          	sb	zero,0(a5)
    80203418:	4785                	li	a5,1
    8020341a:	853e                	mv	a0,a5
    8020341c:	6462                	ld	s0,24(sp)
    8020341e:	6105                	addi	sp,sp,32
    80203420:	8082                	ret
    80203422:	7139                	addi	sp,sp,-64
    80203424:	fc22                	sd	s0,56(sp)
    80203426:	0080                	addi	s0,sp,64
    80203428:	fca43c23          	sd	a0,-40(s0)
    8020342c:	87ae                	mv	a5,a1
    8020342e:	fcc43423          	sd	a2,-56(s0)
    80203432:	fcf42a23          	sw	a5,-44(s0)
    80203436:	fc843783          	ld	a5,-56(s0)
    8020343a:	4b9c                	lw	a5,16(a5)
    8020343c:	02079713          	slli	a4,a5,0x20
    80203440:	9301                	srli	a4,a4,0x20
    80203442:	fc843783          	ld	a5,-56(s0)
    80203446:	6794                	ld	a3,8(a5)
    80203448:	fc843783          	ld	a5,-56(s0)
    8020344c:	639c                	ld	a5,0(a5)
    8020344e:	40f687b3          	sub	a5,a3,a5
    80203452:	8f1d                	sub	a4,a4,a5
    80203454:	fd446783          	lwu	a5,-44(s0)
    80203458:	02e7c463          	blt	a5,a4,80203480 <app_0_start+0x440>
    8020345c:	fc843783          	ld	a5,-56(s0)
    80203460:	4b98                	lw	a4,16(a5)
    80203462:	fc843783          	ld	a5,-56(s0)
    80203466:	6794                	ld	a3,8(a5)
    80203468:	fc843783          	ld	a5,-56(s0)
    8020346c:	639c                	ld	a5,0(a5)
    8020346e:	40f687b3          	sub	a5,a3,a5
    80203472:	2781                	sext.w	a5,a5
    80203474:	40f707bb          	subw	a5,a4,a5
    80203478:	2781                	sext.w	a5,a5
    8020347a:	37fd                	addiw	a5,a5,-1
    8020347c:	fcf42a23          	sw	a5,-44(s0)
    80203480:	fe042623          	sw	zero,-20(s0)
    80203484:	a03d                	j	802034b2 <app_0_start+0x472>
    80203486:	fec46783          	lwu	a5,-20(s0)
    8020348a:	fd843703          	ld	a4,-40(s0)
    8020348e:	973e                	add	a4,a4,a5
    80203490:	fc843783          	ld	a5,-56(s0)
    80203494:	679c                	ld	a5,8(a5)
    80203496:	00178613          	addi	a2,a5,1
    8020349a:	fc843683          	ld	a3,-56(s0)
    8020349e:	e690                	sd	a2,8(a3)
    802034a0:	00074703          	lbu	a4,0(a4)
    802034a4:	00e78023          	sb	a4,0(a5)
    802034a8:	fec42783          	lw	a5,-20(s0)
    802034ac:	2785                	addiw	a5,a5,1
    802034ae:	fef42623          	sw	a5,-20(s0)
    802034b2:	fec42703          	lw	a4,-20(s0)
    802034b6:	fd442783          	lw	a5,-44(s0)
    802034ba:	2701                	sext.w	a4,a4
    802034bc:	2781                	sext.w	a5,a5
    802034be:	fcf764e3          	bltu	a4,a5,80203486 <app_0_start+0x446>
    802034c2:	fc843783          	ld	a5,-56(s0)
    802034c6:	679c                	ld	a5,8(a5)
    802034c8:	00078023          	sb	zero,0(a5)
    802034cc:	fd442783          	lw	a5,-44(s0)
    802034d0:	853e                	mv	a0,a5
    802034d2:	7462                	ld	s0,56(sp)
    802034d4:	6121                	addi	sp,sp,64
    802034d6:	8082                	ret
    802034d8:	7119                	addi	sp,sp,-128
    802034da:	fc86                	sd	ra,120(sp)
    802034dc:	f8a2                	sd	s0,112(sp)
    802034de:	0100                	addi	s0,sp,128
    802034e0:	f8a43c23          	sd	a0,-104(s0)
    802034e4:	87ae                	mv	a5,a1
    802034e6:	f8c43423          	sd	a2,-120(s0)
    802034ea:	f8d43023          	sd	a3,-128(s0)
    802034ee:	f8f42a23          	sw	a5,-108(s0)
    802034f2:	f9843783          	ld	a5,-104(s0)
    802034f6:	fcf43023          	sd	a5,-64(s0)
    802034fa:	f9843783          	ld	a5,-104(s0)
    802034fe:	fcf43423          	sd	a5,-56(s0)
    80203502:	f9442783          	lw	a5,-108(s0)
    80203506:	fcf42823          	sw	a5,-48(s0)
    8020350a:	a4f9                	j	802037d8 <app_0_start+0x798>
    8020350c:	fc843703          	ld	a4,-56(s0)
    80203510:	fc043783          	ld	a5,-64(s0)
    80203514:	40f707b3          	sub	a5,a4,a5
    80203518:	2781                	sext.w	a5,a5
    8020351a:	2785                	addiw	a5,a5,1
    8020351c:	0007871b          	sext.w	a4,a5
    80203520:	fd042783          	lw	a5,-48(s0)
    80203524:	2cf77b63          	bgeu	a4,a5,802037fa <app_0_start+0x7ba>
    80203528:	fef44783          	lbu	a5,-17(s0)
    8020352c:	0ff7f713          	andi	a4,a5,255
    80203530:	02500793          	li	a5,37
    80203534:	00f70c63          	beq	a4,a5,8020354c <app_0_start+0x50c>
    80203538:	fef44783          	lbu	a5,-17(s0)
    8020353c:	2781                	sext.w	a5,a5
    8020353e:	fc040713          	addi	a4,s0,-64
    80203542:	85ba                	mv	a1,a4
    80203544:	853e                	mv	a0,a5
    80203546:	e77ff0ef          	jal	ra,802033bc <app_0_start+0x37c>
    8020354a:	a479                	j	802037d8 <app_0_start+0x798>
    8020354c:	fe040723          	sb	zero,-18(s0)
    80203550:	fe042423          	sw	zero,-24(s0)
    80203554:	f8843783          	ld	a5,-120(s0)
    80203558:	00178713          	addi	a4,a5,1
    8020355c:	f8e43423          	sd	a4,-120(s0)
    80203560:	0007c783          	lbu	a5,0(a5)
    80203564:	fef407a3          	sb	a5,-17(s0)
    80203568:	fef44783          	lbu	a5,-17(s0)
    8020356c:	0ff7f713          	andi	a4,a5,255
    80203570:	03000793          	li	a5,48
    80203574:	06f71b63          	bne	a4,a5,802035ea <app_0_start+0x5aa>
    80203578:	a891                	j	802035cc <app_0_start+0x58c>
    8020357a:	fef44783          	lbu	a5,-17(s0)
    8020357e:	0ff7f793          	andi	a5,a5,255
    80203582:	26078e63          	beqz	a5,802037fe <app_0_start+0x7be>
    80203586:	fef44783          	lbu	a5,-17(s0)
    8020358a:	0ff7f713          	andi	a4,a5,255
    8020358e:	02f00793          	li	a5,47
    80203592:	04e7fc63          	bgeu	a5,a4,802035ea <app_0_start+0x5aa>
    80203596:	fef44783          	lbu	a5,-17(s0)
    8020359a:	0ff7f713          	andi	a4,a5,255
    8020359e:	03900793          	li	a5,57
    802035a2:	04e7e463          	bltu	a5,a4,802035ea <app_0_start+0x5aa>
    802035a6:	fee44703          	lbu	a4,-18(s0)
    802035aa:	87ba                	mv	a5,a4
    802035ac:	0027979b          	slliw	a5,a5,0x2
    802035b0:	9fb9                	addw	a5,a5,a4
    802035b2:	0017979b          	slliw	a5,a5,0x1
    802035b6:	0ff7f793          	andi	a5,a5,255
    802035ba:	fef44703          	lbu	a4,-17(s0)
    802035be:	9fb9                	addw	a5,a5,a4
    802035c0:	0ff7f793          	andi	a5,a5,255
    802035c4:	fd07879b          	addiw	a5,a5,-48
    802035c8:	fef40723          	sb	a5,-18(s0)
    802035cc:	f8843783          	ld	a5,-120(s0)
    802035d0:	00178713          	addi	a4,a5,1
    802035d4:	f8e43423          	sd	a4,-120(s0)
    802035d8:	0007c783          	lbu	a5,0(a5)
    802035dc:	fef407a3          	sb	a5,-17(s0)
    802035e0:	fef44783          	lbu	a5,-17(s0)
    802035e4:	0ff7f793          	andi	a5,a5,255
    802035e8:	fbc9                	bnez	a5,8020357a <app_0_start+0x53a>
    802035ea:	fef44783          	lbu	a5,-17(s0)
    802035ee:	0ff7f713          	andi	a4,a5,255
    802035f2:	06c00793          	li	a5,108
    802035f6:	00f71f63          	bne	a4,a5,80203614 <app_0_start+0x5d4>
    802035fa:	4785                	li	a5,1
    802035fc:	fef42423          	sw	a5,-24(s0)
    80203600:	f8843783          	ld	a5,-120(s0)
    80203604:	00178713          	addi	a4,a5,1
    80203608:	f8e43423          	sd	a4,-120(s0)
    8020360c:	0007c783          	lbu	a5,0(a5)
    80203610:	fef407a3          	sb	a5,-17(s0)
    80203614:	fef44783          	lbu	a5,-17(s0)
    80203618:	2781                	sext.w	a5,a5
    8020361a:	1e078463          	beqz	a5,80203802 <app_0_start+0x7c2>
    8020361e:	873e                	mv	a4,a5
    80203620:	1a074263          	bltz	a4,802037c4 <app_0_start+0x784>
    80203624:	86be                	mv	a3,a5
    80203626:	07800713          	li	a4,120
    8020362a:	18d74d63          	blt	a4,a3,802037c4 <app_0_start+0x784>
    8020362e:	86be                	mv	a3,a5
    80203630:	05800713          	li	a4,88
    80203634:	18e6c863          	blt	a3,a4,802037c4 <app_0_start+0x784>
    80203638:	fa87869b          	addiw	a3,a5,-88
    8020363c:	0006871b          	sext.w	a4,a3
    80203640:	02000793          	li	a5,32
    80203644:	18e7e063          	bltu	a5,a4,802037c4 <app_0_start+0x784>
    80203648:	02069793          	slli	a5,a3,0x20
    8020364c:	9381                	srli	a5,a5,0x20
    8020364e:	00279713          	slli	a4,a5,0x2
    80203652:	00001797          	auipc	a5,0x1
    80203656:	87678793          	addi	a5,a5,-1930 # 80203ec8 <app_0_start+0xe88>
    8020365a:	97ba                	add	a5,a5,a4
    8020365c:	439c                	lw	a5,0(a5)
    8020365e:	0007871b          	sext.w	a4,a5
    80203662:	00001797          	auipc	a5,0x1
    80203666:	86678793          	addi	a5,a5,-1946 # 80203ec8 <app_0_start+0xe88>
    8020366a:	97ba                	add	a5,a5,a4
    8020366c:	8782                	jr	a5
    8020366e:	4785                	li	a5,1
    80203670:	fef42423          	sw	a5,-24(s0)
    80203674:	a295                	j	802037d8 <app_0_start+0x798>
    80203676:	fe842783          	lw	a5,-24(s0)
    8020367a:	2781                	sext.w	a5,a5
    8020367c:	ef81                	bnez	a5,80203694 <app_0_start+0x654>
    8020367e:	f8043783          	ld	a5,-128(s0)
    80203682:	00878713          	addi	a4,a5,8
    80203686:	f8e43023          	sd	a4,-128(s0)
    8020368a:	439c                	lw	a5,0(a5)
    8020368c:	02079513          	slli	a0,a5,0x20
    80203690:	9101                	srli	a0,a0,0x20
    80203692:	a809                	j	802036a4 <app_0_start+0x664>
    80203694:	f8043783          	ld	a5,-128(s0)
    80203698:	00878713          	addi	a4,a5,8
    8020369c:	f8e43023          	sd	a4,-128(s0)
    802036a0:	639c                	ld	a5,0(a5)
    802036a2:	853e                	mv	a0,a5
    802036a4:	fef44783          	lbu	a5,-17(s0)
    802036a8:	0007871b          	sext.w	a4,a5
    802036ac:	07500793          	li	a5,117
    802036b0:	40f707b3          	sub	a5,a4,a5
    802036b4:	0017b793          	seqz	a5,a5
    802036b8:	0ff7f793          	andi	a5,a5,255
    802036bc:	0007869b          	sext.w	a3,a5
    802036c0:	fee44783          	lbu	a5,-18(s0)
    802036c4:	2781                	sext.w	a5,a5
    802036c6:	fa840713          	addi	a4,s0,-88
    802036ca:	4601                	li	a2,0
    802036cc:	45a9                	li	a1,10
    802036ce:	ac9ff0ef          	jal	ra,80203196 <app_0_start+0x156>
    802036d2:	87aa                	mv	a5,a0
    802036d4:	fcf42e23          	sw	a5,-36(s0)
    802036d8:	fc040693          	addi	a3,s0,-64
    802036dc:	fdc42703          	lw	a4,-36(s0)
    802036e0:	fa840793          	addi	a5,s0,-88
    802036e4:	8636                	mv	a2,a3
    802036e6:	85ba                	mv	a1,a4
    802036e8:	853e                	mv	a0,a5
    802036ea:	d39ff0ef          	jal	ra,80203422 <app_0_start+0x3e2>
    802036ee:	fe042423          	sw	zero,-24(s0)
    802036f2:	a0dd                	j	802037d8 <app_0_start+0x798>
    802036f4:	fe842783          	lw	a5,-24(s0)
    802036f8:	2781                	sext.w	a5,a5
    802036fa:	ef81                	bnez	a5,80203712 <app_0_start+0x6d2>
    802036fc:	f8043783          	ld	a5,-128(s0)
    80203700:	00878713          	addi	a4,a5,8
    80203704:	f8e43023          	sd	a4,-128(s0)
    80203708:	439c                	lw	a5,0(a5)
    8020370a:	02079513          	slli	a0,a5,0x20
    8020370e:	9101                	srli	a0,a0,0x20
    80203710:	a809                	j	80203722 <app_0_start+0x6e2>
    80203712:	f8043783          	ld	a5,-128(s0)
    80203716:	00878713          	addi	a4,a5,8
    8020371a:	f8e43023          	sd	a4,-128(s0)
    8020371e:	639c                	ld	a5,0(a5)
    80203720:	853e                	mv	a0,a5
    80203722:	fef44783          	lbu	a5,-17(s0)
    80203726:	0007871b          	sext.w	a4,a5
    8020372a:	05800793          	li	a5,88
    8020372e:	40f707b3          	sub	a5,a4,a5
    80203732:	0017b793          	seqz	a5,a5
    80203736:	0ff7f793          	andi	a5,a5,255
    8020373a:	0007861b          	sext.w	a2,a5
    8020373e:	fee44783          	lbu	a5,-18(s0)
    80203742:	2781                	sext.w	a5,a5
    80203744:	fa840713          	addi	a4,s0,-88
    80203748:	4685                	li	a3,1
    8020374a:	45c1                	li	a1,16
    8020374c:	a4bff0ef          	jal	ra,80203196 <app_0_start+0x156>
    80203750:	87aa                	mv	a5,a0
    80203752:	fcf42e23          	sw	a5,-36(s0)
    80203756:	fc040693          	addi	a3,s0,-64
    8020375a:	fdc42703          	lw	a4,-36(s0)
    8020375e:	fa840793          	addi	a5,s0,-88
    80203762:	8636                	mv	a2,a3
    80203764:	85ba                	mv	a1,a4
    80203766:	853e                	mv	a0,a5
    80203768:	cbbff0ef          	jal	ra,80203422 <app_0_start+0x3e2>
    8020376c:	fe042423          	sw	zero,-24(s0)
    80203770:	a0a5                	j	802037d8 <app_0_start+0x798>
    80203772:	f8043783          	ld	a5,-128(s0)
    80203776:	00878713          	addi	a4,a5,8
    8020377a:	f8e43023          	sd	a4,-128(s0)
    8020377e:	439c                	lw	a5,0(a5)
    80203780:	0ff7f793          	andi	a5,a5,255
    80203784:	2781                	sext.w	a5,a5
    80203786:	fc040713          	addi	a4,s0,-64
    8020378a:	85ba                	mv	a1,a4
    8020378c:	853e                	mv	a0,a5
    8020378e:	c2fff0ef          	jal	ra,802033bc <app_0_start+0x37c>
    80203792:	a099                	j	802037d8 <app_0_start+0x798>
    80203794:	f8043783          	ld	a5,-128(s0)
    80203798:	00878713          	addi	a4,a5,8
    8020379c:	f8e43023          	sd	a4,-128(s0)
    802037a0:	639c                	ld	a5,0(a5)
    802037a2:	fef43023          	sd	a5,-32(s0)
    802037a6:	fe043503          	ld	a0,-32(s0)
    802037aa:	9b7ff0ef          	jal	ra,80203160 <app_0_start+0x120>
    802037ae:	87aa                	mv	a5,a0
    802037b0:	2781                	sext.w	a5,a5
    802037b2:	fc040713          	addi	a4,s0,-64
    802037b6:	863a                	mv	a2,a4
    802037b8:	85be                	mv	a1,a5
    802037ba:	fe043503          	ld	a0,-32(s0)
    802037be:	c65ff0ef          	jal	ra,80203422 <app_0_start+0x3e2>
    802037c2:	a819                	j	802037d8 <app_0_start+0x798>
    802037c4:	fef44783          	lbu	a5,-17(s0)
    802037c8:	2781                	sext.w	a5,a5
    802037ca:	fc040713          	addi	a4,s0,-64
    802037ce:	85ba                	mv	a1,a4
    802037d0:	853e                	mv	a0,a5
    802037d2:	bebff0ef          	jal	ra,802033bc <app_0_start+0x37c>
    802037d6:	0001                	nop
    802037d8:	f8843783          	ld	a5,-120(s0)
    802037dc:	00178713          	addi	a4,a5,1
    802037e0:	f8e43423          	sd	a4,-120(s0)
    802037e4:	0007c783          	lbu	a5,0(a5)
    802037e8:	fef407a3          	sb	a5,-17(s0)
    802037ec:	fef44783          	lbu	a5,-17(s0)
    802037f0:	0ff7f793          	andi	a5,a5,255
    802037f4:	d0079ce3          	bnez	a5,8020350c <app_0_start+0x4cc>
    802037f8:	a031                	j	80203804 <app_0_start+0x7c4>
    802037fa:	0001                	nop
    802037fc:	a021                	j	80203804 <app_0_start+0x7c4>
    802037fe:	0001                	nop
    80203800:	a011                	j	80203804 <app_0_start+0x7c4>
    80203802:	0001                	nop
    80203804:	fc843703          	ld	a4,-56(s0)
    80203808:	fc043783          	ld	a5,-64(s0)
    8020380c:	40f707b3          	sub	a5,a4,a5
    80203810:	2781                	sext.w	a5,a5
    80203812:	853e                	mv	a0,a5
    80203814:	70e6                	ld	ra,120(sp)
    80203816:	7446                	ld	s0,112(sp)
    80203818:	6109                	addi	sp,sp,128
    8020381a:	8082                	ret
    8020381c:	7129                	addi	sp,sp,-320
    8020381e:	fe06                	sd	ra,312(sp)
    80203820:	fa22                	sd	s0,304(sp)
    80203822:	0280                	addi	s0,sp,320
    80203824:	eca43c23          	sd	a0,-296(s0)
    80203828:	ecb43823          	sd	a1,-304(s0)
    8020382c:	ecc43423          	sd	a2,-312(s0)
    80203830:	ed043783          	ld	a5,-304(s0)
    80203834:	fef43023          	sd	a5,-32(s0)
    80203838:	fe043703          	ld	a4,-32(s0)
    8020383c:	ee040793          	addi	a5,s0,-288
    80203840:	86ba                	mv	a3,a4
    80203842:	ed843603          	ld	a2,-296(s0)
    80203846:	10000593          	li	a1,256
    8020384a:	853e                	mv	a0,a5
    8020384c:	c8dff0ef          	jal	ra,802034d8 <app_0_start+0x498>
    80203850:	87aa                	mv	a5,a0
    80203852:	fef42623          	sw	a5,-20(s0)
    80203856:	fec42783          	lw	a5,-20(s0)
    8020385a:	ff040713          	addi	a4,s0,-16
    8020385e:	97ba                	add	a5,a5,a4
    80203860:	ee078823          	sb	zero,-272(a5)
    80203864:	ee040793          	addi	a5,s0,-288
    80203868:	ec843703          	ld	a4,-312(s0)
    8020386c:	853e                	mv	a0,a5
    8020386e:	9702                	jalr	a4
    80203870:	fec42783          	lw	a5,-20(s0)
    80203874:	853e                	mv	a0,a5
    80203876:	70f2                	ld	ra,312(sp)
    80203878:	7452                	ld	s0,304(sp)
    8020387a:	6131                	addi	sp,sp,320
    8020387c:	8082                	ret
    8020387e:	7129                	addi	sp,sp,-320
    80203880:	fe06                	sd	ra,312(sp)
    80203882:	fa22                	sd	s0,304(sp)
    80203884:	0280                	addi	s0,sp,320
    80203886:	eca43c23          	sd	a0,-296(s0)
    8020388a:	ecb43823          	sd	a1,-304(s0)
    8020388e:	ecc43423          	sd	a2,-312(s0)
    80203892:	ed043783          	ld	a5,-304(s0)
    80203896:	fef43023          	sd	a5,-32(s0)
    8020389a:	fe043703          	ld	a4,-32(s0)
    8020389e:	ee040793          	addi	a5,s0,-288
    802038a2:	86ba                	mv	a3,a4
    802038a4:	ed843603          	ld	a2,-296(s0)
    802038a8:	10000593          	li	a1,256
    802038ac:	853e                	mv	a0,a5
    802038ae:	c2bff0ef          	jal	ra,802034d8 <app_0_start+0x498>
    802038b2:	87aa                	mv	a5,a0
    802038b4:	fef42623          	sw	a5,-20(s0)
    802038b8:	fec42783          	lw	a5,-20(s0)
    802038bc:	ff040713          	addi	a4,s0,-16
    802038c0:	97ba                	add	a5,a5,a4
    802038c2:	ee078823          	sb	zero,-272(a5)
    802038c6:	ee040793          	addi	a5,s0,-288
    802038ca:	ec843703          	ld	a4,-312(s0)
    802038ce:	853e                	mv	a0,a5
    802038d0:	9702                	jalr	a4
    802038d2:	fec42783          	lw	a5,-20(s0)
    802038d6:	853e                	mv	a0,a5
    802038d8:	70f2                	ld	ra,312(sp)
    802038da:	7452                	ld	s0,304(sp)
    802038dc:	6131                	addi	sp,sp,320
    802038de:	8082                	ret
    802038e0:	1101                	addi	sp,sp,-32
    802038e2:	ec06                	sd	ra,24(sp)
    802038e4:	e822                	sd	s0,16(sp)
    802038e6:	1000                	addi	s0,sp,32
    802038e8:	fea43423          	sd	a0,-24(s0)
    802038ec:	feb43023          	sd	a1,-32(s0)
    802038f0:	00000617          	auipc	a2,0x0
    802038f4:	85060613          	addi	a2,a2,-1968 # 80203140 <app_0_start+0x100>
    802038f8:	fe043583          	ld	a1,-32(s0)
    802038fc:	fe843503          	ld	a0,-24(s0)
    80203900:	f1dff0ef          	jal	ra,8020381c <app_0_start+0x7dc>
    80203904:	87aa                	mv	a5,a0
    80203906:	853e                	mv	a0,a5
    80203908:	60e2                	ld	ra,24(sp)
    8020390a:	6442                	ld	s0,16(sp)
    8020390c:	6105                	addi	sp,sp,32
    8020390e:	8082                	ret
    80203910:	7159                	addi	sp,sp,-112
    80203912:	f406                	sd	ra,40(sp)
    80203914:	f022                	sd	s0,32(sp)
    80203916:	1800                	addi	s0,sp,48
    80203918:	fca43c23          	sd	a0,-40(s0)
    8020391c:	e40c                	sd	a1,8(s0)
    8020391e:	e810                	sd	a2,16(s0)
    80203920:	ec14                	sd	a3,24(s0)
    80203922:	f018                	sd	a4,32(s0)
    80203924:	f41c                	sd	a5,40(s0)
    80203926:	03043823          	sd	a6,48(s0)
    8020392a:	03143c23          	sd	a7,56(s0)
    8020392e:	fe042623          	sw	zero,-20(s0)
    80203932:	04040793          	addi	a5,s0,64
    80203936:	fcf43823          	sd	a5,-48(s0)
    8020393a:	fd043783          	ld	a5,-48(s0)
    8020393e:	fc878793          	addi	a5,a5,-56
    80203942:	fef43023          	sd	a5,-32(s0)
    80203946:	fe043783          	ld	a5,-32(s0)
    8020394a:	85be                	mv	a1,a5
    8020394c:	fd843503          	ld	a0,-40(s0)
    80203950:	f91ff0ef          	jal	ra,802038e0 <app_0_start+0x8a0>
    80203954:	87aa                	mv	a5,a0
    80203956:	fef42623          	sw	a5,-20(s0)
    8020395a:	fec42783          	lw	a5,-20(s0)
    8020395e:	853e                	mv	a0,a5
    80203960:	70a2                	ld	ra,40(sp)
    80203962:	7402                	ld	s0,32(sp)
    80203964:	6165                	addi	sp,sp,112
    80203966:	8082                	ret
    80203968:	7129                	addi	sp,sp,-320
    8020396a:	fe06                	sd	ra,312(sp)
    8020396c:	fa22                	sd	s0,304(sp)
    8020396e:	0280                	addi	s0,sp,320
    80203970:	eca43c23          	sd	a0,-296(s0)
    80203974:	ecb43823          	sd	a1,-304(s0)
    80203978:	ecc43423          	sd	a2,-312(s0)
    8020397c:	ed043783          	ld	a5,-304(s0)
    80203980:	fef43023          	sd	a5,-32(s0)
    80203984:	fe043703          	ld	a4,-32(s0)
    80203988:	ee040793          	addi	a5,s0,-288
    8020398c:	86ba                	mv	a3,a4
    8020398e:	ed843603          	ld	a2,-296(s0)
    80203992:	10000593          	li	a1,256
    80203996:	853e                	mv	a0,a5
    80203998:	b41ff0ef          	jal	ra,802034d8 <app_0_start+0x498>
    8020399c:	87aa                	mv	a5,a0
    8020399e:	fef42623          	sw	a5,-20(s0)
    802039a2:	fec42783          	lw	a5,-20(s0)
    802039a6:	ff040713          	addi	a4,s0,-16
    802039aa:	97ba                	add	a5,a5,a4
    802039ac:	ee078823          	sb	zero,-272(a5)
    802039b0:	fec42783          	lw	a5,-20(s0)
    802039b4:	853e                	mv	a0,a5
    802039b6:	70f2                	ld	ra,312(sp)
    802039b8:	7452                	ld	s0,304(sp)
    802039ba:	6131                	addi	sp,sp,320
    802039bc:	8082                	ret
    802039be:	1101                	addi	sp,sp,-32
    802039c0:	ec06                	sd	ra,24(sp)
    802039c2:	e822                	sd	s0,16(sp)
    802039c4:	1000                	addi	s0,sp,32
    802039c6:	fea43423          	sd	a0,-24(s0)
    802039ca:	feb43023          	sd	a1,-32(s0)
    802039ce:	fffff617          	auipc	a2,0xfffff
    802039d2:	77260613          	addi	a2,a2,1906 # 80203140 <app_0_start+0x100>
    802039d6:	fe043583          	ld	a1,-32(s0)
    802039da:	fe843503          	ld	a0,-24(s0)
    802039de:	f8bff0ef          	jal	ra,80203968 <app_0_start+0x928>
    802039e2:	87aa                	mv	a5,a0
    802039e4:	853e                	mv	a0,a5
    802039e6:	60e2                	ld	ra,24(sp)
    802039e8:	6442                	ld	s0,16(sp)
    802039ea:	6105                	addi	sp,sp,32
    802039ec:	8082                	ret
    802039ee:	7159                	addi	sp,sp,-112
    802039f0:	f406                	sd	ra,40(sp)
    802039f2:	f022                	sd	s0,32(sp)
    802039f4:	1800                	addi	s0,sp,48
    802039f6:	fca43c23          	sd	a0,-40(s0)
    802039fa:	e40c                	sd	a1,8(s0)
    802039fc:	e810                	sd	a2,16(s0)
    802039fe:	ec14                	sd	a3,24(s0)
    80203a00:	f018                	sd	a4,32(s0)
    80203a02:	f41c                	sd	a5,40(s0)
    80203a04:	03043823          	sd	a6,48(s0)
    80203a08:	03143c23          	sd	a7,56(s0)
    80203a0c:	fe042623          	sw	zero,-20(s0)
    80203a10:	04040793          	addi	a5,s0,64
    80203a14:	fcf43823          	sd	a5,-48(s0)
    80203a18:	fd043783          	ld	a5,-48(s0)
    80203a1c:	fc878793          	addi	a5,a5,-56
    80203a20:	fef43023          	sd	a5,-32(s0)
    80203a24:	fe043783          	ld	a5,-32(s0)
    80203a28:	85be                	mv	a1,a5
    80203a2a:	fd843503          	ld	a0,-40(s0)
    80203a2e:	f91ff0ef          	jal	ra,802039be <app_0_start+0x97e>
    80203a32:	87aa                	mv	a5,a0
    80203a34:	fef42623          	sw	a5,-20(s0)
    80203a38:	fec42783          	lw	a5,-20(s0)
    80203a3c:	853e                	mv	a0,a5
    80203a3e:	70a2                	ld	ra,40(sp)
    80203a40:	7402                	ld	s0,32(sp)
    80203a42:	6165                	addi	sp,sp,112
    80203a44:	8082                	ret
    80203a46:	7179                	addi	sp,sp,-48
    80203a48:	f422                	sd	s0,40(sp)
    80203a4a:	1800                	addi	s0,sp,48
    80203a4c:	fca43c23          	sd	a0,-40(s0)
    80203a50:	fe042623          	sw	zero,-20(s0)
    80203a54:	a031                	j	80203a60 <app_0_start+0xa20>
    80203a56:	fec42783          	lw	a5,-20(s0)
    80203a5a:	2785                	addiw	a5,a5,1
    80203a5c:	fef42623          	sw	a5,-20(s0)
    80203a60:	fec42783          	lw	a5,-20(s0)
    80203a64:	fd843703          	ld	a4,-40(s0)
    80203a68:	97ba                	add	a5,a5,a4
    80203a6a:	0007c783          	lbu	a5,0(a5)
    80203a6e:	f7e5                	bnez	a5,80203a56 <app_0_start+0xa16>
    80203a70:	fec42783          	lw	a5,-20(s0)
    80203a74:	853e                	mv	a0,a5
    80203a76:	7422                	ld	s0,40(sp)
    80203a78:	6145                	addi	sp,sp,48
    80203a7a:	8082                	ret
    80203a7c:	7179                	addi	sp,sp,-48
    80203a7e:	f422                	sd	s0,40(sp)
    80203a80:	1800                	addi	s0,sp,48
    80203a82:	fea43423          	sd	a0,-24(s0)
    80203a86:	feb43023          	sd	a1,-32(s0)
    80203a8a:	87b2                	mv	a5,a2
    80203a8c:	fcf42e23          	sw	a5,-36(s0)
    80203a90:	a035                	j	80203abc <app_0_start+0xa7c>
    80203a92:	fe043703          	ld	a4,-32(s0)
    80203a96:	00170793          	addi	a5,a4,1
    80203a9a:	fef43023          	sd	a5,-32(s0)
    80203a9e:	fe843783          	ld	a5,-24(s0)
    80203aa2:	00178693          	addi	a3,a5,1
    80203aa6:	fed43423          	sd	a3,-24(s0)
    80203aaa:	00074703          	lbu	a4,0(a4)
    80203aae:	00e78023          	sb	a4,0(a5)
    80203ab2:	fdc42783          	lw	a5,-36(s0)
    80203ab6:	37fd                	addiw	a5,a5,-1
    80203ab8:	fcf42e23          	sw	a5,-36(s0)
    80203abc:	fdc42783          	lw	a5,-36(s0)
    80203ac0:	2781                	sext.w	a5,a5
    80203ac2:	fbe1                	bnez	a5,80203a92 <app_0_start+0xa52>
    80203ac4:	0001                	nop
    80203ac6:	0001                	nop
    80203ac8:	7422                	ld	s0,40(sp)
    80203aca:	6145                	addi	sp,sp,48
    80203acc:	8082                	ret
    80203ace:	7139                	addi	sp,sp,-64
    80203ad0:	fc22                	sd	s0,56(sp)
    80203ad2:	0080                	addi	s0,sp,64
    80203ad4:	fca43c23          	sd	a0,-40(s0)
    80203ad8:	fcb43823          	sd	a1,-48(s0)
    80203adc:	87b2                	mv	a5,a2
    80203ade:	fcf42623          	sw	a5,-52(s0)
    80203ae2:	fe042623          	sw	zero,-20(s0)
    80203ae6:	a8a1                	j	80203b3e <app_0_start+0xafe>
    80203ae8:	fec42783          	lw	a5,-20(s0)
    80203aec:	fd843703          	ld	a4,-40(s0)
    80203af0:	97ba                	add	a5,a5,a4
    80203af2:	0007c683          	lbu	a3,0(a5)
    80203af6:	fec42783          	lw	a5,-20(s0)
    80203afa:	fd043703          	ld	a4,-48(s0)
    80203afe:	97ba                	add	a5,a5,a4
    80203b00:	0007c783          	lbu	a5,0(a5)
    80203b04:	8736                	mv	a4,a3
    80203b06:	02f70763          	beq	a4,a5,80203b34 <app_0_start+0xaf4>
    80203b0a:	fec42783          	lw	a5,-20(s0)
    80203b0e:	fd843703          	ld	a4,-40(s0)
    80203b12:	97ba                	add	a5,a5,a4
    80203b14:	0007c783          	lbu	a5,0(a5)
    80203b18:	0007871b          	sext.w	a4,a5
    80203b1c:	fec42783          	lw	a5,-20(s0)
    80203b20:	fd043683          	ld	a3,-48(s0)
    80203b24:	97b6                	add	a5,a5,a3
    80203b26:	0007c783          	lbu	a5,0(a5)
    80203b2a:	2781                	sext.w	a5,a5
    80203b2c:	40f707bb          	subw	a5,a4,a5
    80203b30:	2781                	sext.w	a5,a5
    80203b32:	a831                	j	80203b4e <app_0_start+0xb0e>
    80203b34:	fec42783          	lw	a5,-20(s0)
    80203b38:	2785                	addiw	a5,a5,1
    80203b3a:	fef42623          	sw	a5,-20(s0)
    80203b3e:	fec42703          	lw	a4,-20(s0)
    80203b42:	fcc42783          	lw	a5,-52(s0)
    80203b46:	2781                	sext.w	a5,a5
    80203b48:	faf760e3          	bltu	a4,a5,80203ae8 <app_0_start+0xaa8>
    80203b4c:	4781                	li	a5,0
    80203b4e:	853e                	mv	a0,a5
    80203b50:	7462                	ld	s0,56(sp)
    80203b52:	6121                	addi	sp,sp,64
    80203b54:	8082                	ret
    80203b56:	715d                	addi	sp,sp,-80
    80203b58:	e4a2                	sd	s0,72(sp)
    80203b5a:	0880                	addi	s0,sp,80
    80203b5c:	fca43423          	sd	a0,-56(s0)
    80203b60:	fcb43023          	sd	a1,-64(s0)
    80203b64:	86b2                	mv	a3,a2
    80203b66:	fad42e23          	sw	a3,-68(s0)
    80203b6a:	868a                	mv	a3,sp
    80203b6c:	85b6                	mv	a1,a3
    80203b6e:	fbc42683          	lw	a3,-68(s0)
    80203b72:	02069613          	slli	a2,a3,0x20
    80203b76:	9201                	srli	a2,a2,0x20
    80203b78:	167d                	addi	a2,a2,-1
    80203b7a:	fec43423          	sd	a2,-24(s0)
    80203b7e:	02069613          	slli	a2,a3,0x20
    80203b82:	9201                	srli	a2,a2,0x20
    80203b84:	8e32                	mv	t3,a2
    80203b86:	4e81                	li	t4,0
    80203b88:	03de5613          	srli	a2,t3,0x3d
    80203b8c:	003e9893          	slli	a7,t4,0x3
    80203b90:	011668b3          	or	a7,a2,a7
    80203b94:	003e1813          	slli	a6,t3,0x3
    80203b98:	02069613          	slli	a2,a3,0x20
    80203b9c:	9201                	srli	a2,a2,0x20
    80203b9e:	8332                	mv	t1,a2
    80203ba0:	4381                	li	t2,0
    80203ba2:	03d35613          	srli	a2,t1,0x3d
    80203ba6:	00339793          	slli	a5,t2,0x3
    80203baa:	8fd1                	or	a5,a5,a2
    80203bac:	00331713          	slli	a4,t1,0x3
    80203bb0:	02069793          	slli	a5,a3,0x20
    80203bb4:	9381                	srli	a5,a5,0x20
    80203bb6:	07bd                	addi	a5,a5,15
    80203bb8:	8391                	srli	a5,a5,0x4
    80203bba:	0792                	slli	a5,a5,0x4
    80203bbc:	40f10133          	sub	sp,sp,a5
    80203bc0:	878a                	mv	a5,sp
    80203bc2:	00078793          	mv	a5,a5
    80203bc6:	fef43023          	sd	a5,-32(s0)
    80203bca:	fc042e23          	sw	zero,-36(s0)
    80203bce:	a02d                	j	80203bf8 <app_0_start+0xbb8>
    80203bd0:	fc043783          	ld	a5,-64(s0)
    80203bd4:	00178713          	addi	a4,a5,1
    80203bd8:	fce43023          	sd	a4,-64(s0)
    80203bdc:	0007c703          	lbu	a4,0(a5)
    80203be0:	fe043683          	ld	a3,-32(s0)
    80203be4:	fdc42783          	lw	a5,-36(s0)
    80203be8:	97b6                	add	a5,a5,a3
    80203bea:	00e78023          	sb	a4,0(a5)
    80203bee:	fbc42783          	lw	a5,-68(s0)
    80203bf2:	37fd                	addiw	a5,a5,-1
    80203bf4:	faf42e23          	sw	a5,-68(s0)
    80203bf8:	fbc42783          	lw	a5,-68(s0)
    80203bfc:	2781                	sext.w	a5,a5
    80203bfe:	fbe9                	bnez	a5,80203bd0 <app_0_start+0xb90>
    80203c00:	a02d                	j	80203c2a <app_0_start+0xbea>
    80203c02:	fc843783          	ld	a5,-56(s0)
    80203c06:	00178713          	addi	a4,a5,1
    80203c0a:	fce43423          	sd	a4,-56(s0)
    80203c0e:	fe043683          	ld	a3,-32(s0)
    80203c12:	fdc42703          	lw	a4,-36(s0)
    80203c16:	9736                	add	a4,a4,a3
    80203c18:	00074703          	lbu	a4,0(a4)
    80203c1c:	00e78023          	sb	a4,0(a5)
    80203c20:	fbc42783          	lw	a5,-68(s0)
    80203c24:	37fd                	addiw	a5,a5,-1
    80203c26:	faf42e23          	sw	a5,-68(s0)
    80203c2a:	fbc42783          	lw	a5,-68(s0)
    80203c2e:	2781                	sext.w	a5,a5
    80203c30:	fbe9                	bnez	a5,80203c02 <app_0_start+0xbc2>
    80203c32:	812e                	mv	sp,a1
    80203c34:	0001                	nop
    80203c36:	fb040113          	addi	sp,s0,-80
    80203c3a:	6426                	ld	s0,72(sp)
    80203c3c:	6161                	addi	sp,sp,80
    80203c3e:	8082                	ret
    80203c40:	7179                	addi	sp,sp,-48
    80203c42:	f422                	sd	s0,40(sp)
    80203c44:	1800                	addi	s0,sp,48
    80203c46:	fca43c23          	sd	a0,-40(s0)
    80203c4a:	87ae                	mv	a5,a1
    80203c4c:	8732                	mv	a4,a2
    80203c4e:	fcf40ba3          	sb	a5,-41(s0)
    80203c52:	87ba                	mv	a5,a4
    80203c54:	fcf42823          	sw	a5,-48(s0)
    80203c58:	fd843783          	ld	a5,-40(s0)
    80203c5c:	fef43423          	sd	a5,-24(s0)
    80203c60:	a005                	j	80203c80 <app_0_start+0xc40>
    80203c62:	fe843783          	ld	a5,-24(s0)
    80203c66:	00178713          	addi	a4,a5,1
    80203c6a:	fee43423          	sd	a4,-24(s0)
    80203c6e:	fd744703          	lbu	a4,-41(s0)
    80203c72:	00e78023          	sb	a4,0(a5)
    80203c76:	fd042783          	lw	a5,-48(s0)
    80203c7a:	37fd                	addiw	a5,a5,-1
    80203c7c:	fcf42823          	sw	a5,-48(s0)
    80203c80:	fd042783          	lw	a5,-48(s0)
    80203c84:	2781                	sext.w	a5,a5
    80203c86:	fff1                	bnez	a5,80203c62 <app_0_start+0xc22>
    80203c88:	0001                	nop
    80203c8a:	0001                	nop
    80203c8c:	7422                	ld	s0,40(sp)
    80203c8e:	6145                	addi	sp,sp,48
    80203c90:	8082                	ret
    80203c92:	1101                	addi	sp,sp,-32
    80203c94:	ec06                	sd	ra,24(sp)
    80203c96:	e822                	sd	s0,16(sp)
    80203c98:	1000                	addi	s0,sp,32
    80203c9a:	fea43423          	sd	a0,-24(s0)
    80203c9e:	87ae                	mv	a5,a1
    80203ca0:	fef42223          	sw	a5,-28(s0)
    80203ca4:	fe442783          	lw	a5,-28(s0)
    80203ca8:	863e                	mv	a2,a5
    80203caa:	4581                	li	a1,0
    80203cac:	fe843503          	ld	a0,-24(s0)
    80203cb0:	f91ff0ef          	jal	ra,80203c40 <app_0_start+0xc00>
    80203cb4:	0001                	nop
    80203cb6:	60e2                	ld	ra,24(sp)
    80203cb8:	6442                	ld	s0,16(sp)
    80203cba:	6105                	addi	sp,sp,32
    80203cbc:	8082                	ret
    80203cbe:	1101                	addi	sp,sp,-32
    80203cc0:	ec22                	sd	s0,24(sp)
    80203cc2:	1000                	addi	s0,sp,32
    80203cc4:	fea43423          	sd	a0,-24(s0)
    80203cc8:	feb43023          	sd	a1,-32(s0)
    80203ccc:	a0a1                	j	80203d14 <app_0_start+0xcd4>
    80203cce:	fe843783          	ld	a5,-24(s0)
    80203cd2:	0007c703          	lbu	a4,0(a5)
    80203cd6:	fe043783          	ld	a5,-32(s0)
    80203cda:	0007c783          	lbu	a5,0(a5)
    80203cde:	02f70163          	beq	a4,a5,80203d00 <app_0_start+0xcc0>
    80203ce2:	fe843783          	ld	a5,-24(s0)
    80203ce6:	0007c783          	lbu	a5,0(a5)
    80203cea:	0007871b          	sext.w	a4,a5
    80203cee:	fe043783          	ld	a5,-32(s0)
    80203cf2:	0007c783          	lbu	a5,0(a5)
    80203cf6:	2781                	sext.w	a5,a5
    80203cf8:	40f707bb          	subw	a5,a4,a5
    80203cfc:	2781                	sext.w	a5,a5
    80203cfe:	a099                	j	80203d44 <app_0_start+0xd04>
    80203d00:	fe843783          	ld	a5,-24(s0)
    80203d04:	0785                	addi	a5,a5,1
    80203d06:	fef43423          	sd	a5,-24(s0)
    80203d0a:	fe043783          	ld	a5,-32(s0)
    80203d0e:	0785                	addi	a5,a5,1
    80203d10:	fef43023          	sd	a5,-32(s0)
    80203d14:	fe843783          	ld	a5,-24(s0)
    80203d18:	0007c783          	lbu	a5,0(a5)
    80203d1c:	c791                	beqz	a5,80203d28 <app_0_start+0xce8>
    80203d1e:	fe043783          	ld	a5,-32(s0)
    80203d22:	0007c783          	lbu	a5,0(a5)
    80203d26:	f7c5                	bnez	a5,80203cce <app_0_start+0xc8e>
    80203d28:	fe843783          	ld	a5,-24(s0)
    80203d2c:	0007c783          	lbu	a5,0(a5)
    80203d30:	0007871b          	sext.w	a4,a5
    80203d34:	fe043783          	ld	a5,-32(s0)
    80203d38:	0007c783          	lbu	a5,0(a5)
    80203d3c:	2781                	sext.w	a5,a5
    80203d3e:	40f707bb          	subw	a5,a4,a5
    80203d42:	2781                	sext.w	a5,a5
    80203d44:	853e                	mv	a0,a5
    80203d46:	6462                	ld	s0,24(sp)
    80203d48:	6105                	addi	sp,sp,32
    80203d4a:	8082                	ret
    80203d4c:	7179                	addi	sp,sp,-48
    80203d4e:	f422                	sd	s0,40(sp)
    80203d50:	1800                	addi	s0,sp,48
    80203d52:	fca43c23          	sd	a0,-40(s0)
    80203d56:	fcb43823          	sd	a1,-48(s0)
    80203d5a:	fd843783          	ld	a5,-40(s0)
    80203d5e:	fef43423          	sd	a5,-24(s0)
    80203d62:	a00d                	j	80203d84 <app_0_start+0xd44>
    80203d64:	fd043703          	ld	a4,-48(s0)
    80203d68:	00170793          	addi	a5,a4,1
    80203d6c:	fcf43823          	sd	a5,-48(s0)
    80203d70:	fd843783          	ld	a5,-40(s0)
    80203d74:	00178693          	addi	a3,a5,1
    80203d78:	fcd43c23          	sd	a3,-40(s0)
    80203d7c:	00074703          	lbu	a4,0(a4)
    80203d80:	00e78023          	sb	a4,0(a5)
    80203d84:	fd043783          	ld	a5,-48(s0)
    80203d88:	0007c783          	lbu	a5,0(a5)
    80203d8c:	ffe1                	bnez	a5,80203d64 <app_0_start+0xd24>
    80203d8e:	fd843783          	ld	a5,-40(s0)
    80203d92:	00078023          	sb	zero,0(a5)
    80203d96:	fe843783          	ld	a5,-24(s0)
    80203d9a:	853e                	mv	a0,a5
    80203d9c:	7422                	ld	s0,40(sp)
    80203d9e:	6145                	addi	sp,sp,48
    80203da0:	8082                	ret
    80203da2:	7179                	addi	sp,sp,-48
    80203da4:	f422                	sd	s0,40(sp)
    80203da6:	1800                	addi	s0,sp,48
    80203da8:	fca43c23          	sd	a0,-40(s0)
    80203dac:	fcb43823          	sd	a1,-48(s0)
    80203db0:	fd843783          	ld	a5,-40(s0)
    80203db4:	fef43423          	sd	a5,-24(s0)
    80203db8:	a031                	j	80203dc4 <app_0_start+0xd84>
    80203dba:	fd843783          	ld	a5,-40(s0)
    80203dbe:	0785                	addi	a5,a5,1
    80203dc0:	fcf43c23          	sd	a5,-40(s0)
    80203dc4:	fd843783          	ld	a5,-40(s0)
    80203dc8:	0007c783          	lbu	a5,0(a5)
    80203dcc:	f7fd                	bnez	a5,80203dba <app_0_start+0xd7a>
    80203dce:	a00d                	j	80203df0 <app_0_start+0xdb0>
    80203dd0:	fd043703          	ld	a4,-48(s0)
    80203dd4:	00170793          	addi	a5,a4,1
    80203dd8:	fcf43823          	sd	a5,-48(s0)
    80203ddc:	fd843783          	ld	a5,-40(s0)
    80203de0:	00178693          	addi	a3,a5,1
    80203de4:	fcd43c23          	sd	a3,-40(s0)
    80203de8:	00074703          	lbu	a4,0(a4)
    80203dec:	00e78023          	sb	a4,0(a5)
    80203df0:	fd043783          	ld	a5,-48(s0)
    80203df4:	0007c783          	lbu	a5,0(a5)
    80203df8:	ffe1                	bnez	a5,80203dd0 <app_0_start+0xd90>
    80203dfa:	fd843783          	ld	a5,-40(s0)
    80203dfe:	00078023          	sb	zero,0(a5)
    80203e02:	fe843783          	ld	a5,-24(s0)
    80203e06:	853e                	mv	a0,a5
    80203e08:	7422                	ld	s0,40(sp)
    80203e0a:	6145                	addi	sp,sp,48
    80203e0c:	8082                	ret
    80203e0e:	1101                	addi	sp,sp,-32
    80203e10:	ec06                	sd	ra,24(sp)
    80203e12:	e822                	sd	s0,16(sp)
    80203e14:	1000                	addi	s0,sp,32
    80203e16:	00000517          	auipc	a0,0x0
    80203e1a:	13a50513          	addi	a0,a0,314 # 80203f50 <app_0_start+0xf10>
    80203e1e:	af3ff0ef          	jal	ra,80203910 <app_0_start+0x8d0>
    80203e22:	afeff0ef          	jal	ra,80203120 <app_0_start+0xe0>
    80203e26:	00000517          	auipc	a0,0x0
    80203e2a:	13a50513          	addi	a0,a0,314 # 80203f60 <app_0_start+0xf20>
    80203e2e:	ae3ff0ef          	jal	ra,80203910 <app_0_start+0x8d0>
    80203e32:	fe043423          	sd	zero,-24(s0)
    80203e36:	a835                	j	80203e72 <app_0_start+0xe32>
    80203e38:	fe843703          	ld	a4,-24(s0)
    80203e3c:	009897b7          	lui	a5,0x989
    80203e40:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80203e44:	02f777b3          	remu	a5,a4,a5
    80203e48:	e385                	bnez	a5,80203e68 <app_0_start+0xe28>
    80203e4a:	fe843703          	ld	a4,-24(s0)
    80203e4e:	009897b7          	lui	a5,0x989
    80203e52:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80203e56:	02f757b3          	divu	a5,a4,a5
    80203e5a:	85be                	mv	a1,a5
    80203e5c:	00000517          	auipc	a0,0x0
    80203e60:	11c50513          	addi	a0,a0,284 # 80203f78 <app_0_start+0xf38>
    80203e64:	aadff0ef          	jal	ra,80203910 <app_0_start+0x8d0>
    80203e68:	fe843783          	ld	a5,-24(s0)
    80203e6c:	0785                	addi	a5,a5,1
    80203e6e:	fef43423          	sd	a5,-24(s0)
    80203e72:	fe843703          	ld	a4,-24(s0)
    80203e76:	05f5e7b7          	lui	a5,0x5f5e
    80203e7a:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <n+0x5f5e0df>
    80203e7e:	fae7fde3          	bgeu	a5,a4,80203e38 <app_0_start+0xdf8>
    80203e82:	4781                	li	a5,0
    80203e84:	853e                	mv	a0,a5
    80203e86:	60e2                	ld	ra,24(sp)
    80203e88:	6442                	ld	s0,16(sp)
    80203e8a:	6105                	addi	sp,sp,32
    80203e8c:	8082                	ret
    80203e8e:	0000                	unimp
    80203e90:	6573755b          	0x6573755b
    80203e94:	5f72                	lw	t5,60(sp)
    80203e96:	696c                	ld	a1,208(a0)
    80203e98:	5d62                	lw	s10,56(sp)
    80203e9a:	6920                	ld	s0,80(a0)
    80203e9c:	696e                	ld	s2,216(sp)
    80203e9e:	2074                	fld	fa3,192(s0)
    80203ea0:	000a6b6f          	jal	s6,802a9ea0 <ebss+0x4ef58>
    80203ea4:	0000                	unimp
    80203ea6:	0000                	unimp
    80203ea8:	6573755b          	0x6573755b
    80203eac:	5f72                	lw	t5,60(sp)
    80203eae:	696c                	ld	a1,208(a0)
    80203eb0:	5d62                	lw	s10,56(sp)
    80203eb2:	7320                	ld	s0,96(a4)
    80203eb4:	6365                	lui	t1,0x19
    80203eb6:	20646e6f          	jal	t3,8024a0bc <Kernelstack+0x17184>
    80203eba:	7270                	ld	a2,224(a2)
    80203ebc:	6e69                	lui	t3,0x1a
    80203ebe:	2074                	fld	fa3,192(s0)
    80203ec0:	6574                	ld	a3,200(a0)
    80203ec2:	0a2e7473          	csrrci	s0,0xa2,28
    80203ec6:	0000                	unimp
    80203ec8:	f82c                	sd	a1,112(s0)
    80203eca:	ffff                	0xffff
    80203ecc:	f8fc                	sd	a5,240(s1)
    80203ece:	ffff                	0xffff
    80203ed0:	f8fc                	sd	a5,240(s1)
    80203ed2:	ffff                	0xffff
    80203ed4:	f8fc                	sd	a5,240(s1)
    80203ed6:	ffff                	0xffff
    80203ed8:	f8fc                	sd	a5,240(s1)
    80203eda:	ffff                	0xffff
    80203edc:	f8fc                	sd	a5,240(s1)
    80203ede:	ffff                	0xffff
    80203ee0:	f8fc                	sd	a5,240(s1)
    80203ee2:	ffff                	0xffff
    80203ee4:	f8fc                	sd	a5,240(s1)
    80203ee6:	ffff                	0xffff
    80203ee8:	f8fc                	sd	a5,240(s1)
    80203eea:	ffff                	0xffff
    80203eec:	f8fc                	sd	a5,240(s1)
    80203eee:	ffff                	0xffff
    80203ef0:	f8fc                	sd	a5,240(s1)
    80203ef2:	ffff                	0xffff
    80203ef4:	f8aa                	sd	a0,112(sp)
    80203ef6:	ffff                	0xffff
    80203ef8:	f7ae                	sd	a1,488(sp)
    80203efa:	ffff                	0xffff
    80203efc:	f8fc                	sd	a5,240(s1)
    80203efe:	ffff                	0xffff
    80203f00:	f8fc                	sd	a5,240(s1)
    80203f02:	ffff                	0xffff
    80203f04:	f8fc                	sd	a5,240(s1)
    80203f06:	ffff                	0xffff
    80203f08:	f8fc                	sd	a5,240(s1)
    80203f0a:	ffff                	0xffff
    80203f0c:	f8fc                	sd	a5,240(s1)
    80203f0e:	ffff                	0xffff
    80203f10:	f8fc                	sd	a5,240(s1)
    80203f12:	ffff                	0xffff
    80203f14:	f8fc                	sd	a5,240(s1)
    80203f16:	ffff                	0xffff
    80203f18:	f7a6                	sd	s1,488(sp)
    80203f1a:	ffff                	0xffff
    80203f1c:	f8fc                	sd	a5,240(s1)
    80203f1e:	ffff                	0xffff
    80203f20:	f8fc                	sd	a5,240(s1)
    80203f22:	ffff                	0xffff
    80203f24:	f8fc                	sd	a5,240(s1)
    80203f26:	ffff                	0xffff
    80203f28:	f8fc                	sd	a5,240(s1)
    80203f2a:	ffff                	0xffff
    80203f2c:	f8fc                	sd	a5,240(s1)
    80203f2e:	ffff                	0xffff
    80203f30:	f8fc                	sd	a5,240(s1)
    80203f32:	ffff                	0xffff
    80203f34:	f8cc                	sd	a1,176(s1)
    80203f36:	ffff                	0xffff
    80203f38:	f8fc                	sd	a5,240(s1)
    80203f3a:	ffff                	0xffff
    80203f3c:	f7ae                	sd	a1,488(sp)
    80203f3e:	ffff                	0xffff
    80203f40:	f8fc                	sd	a5,240(s1)
    80203f42:	ffff                	0xffff
    80203f44:	f8fc                	sd	a5,240(s1)
    80203f46:	ffff                	0xffff
    80203f48:	f82c                	sd	a1,112(s0)
    80203f4a:	ffff                	0xffff
    80203f4c:	0000                	unimp
    80203f4e:	0000                	unimp
    80203f50:	3230                	fld	fa2,96(a2)
    80203f52:	2074                	fld	fa3,192(s0)
    80203f54:	6979                	lui	s2,0x1e
    80203f56:	6c65                	lui	s8,0x19
    80203f58:	0a64                	addi	s1,sp,284
    80203f5a:	0000                	unimp
    80203f5c:	0000                	unimp
    80203f5e:	0000                	unimp
    80203f60:	3230                	fld	fa2,96(a2)
    80203f62:	2074                	fld	fa3,192(s0)
    80203f64:	6979                	lui	s2,0x1e
    80203f66:	6c65                	lui	s8,0x19
    80203f68:	2064                	fld	fs1,192(s0)
    80203f6a:	63637573          	csrrci	a0,0x636,6
    80203f6e:	7365                	lui	t1,0xffff9
    80203f70:	00000a73          	0xa73
    80203f74:	0000                	unimp
    80203f76:	0000                	unimp
    80203f78:	3230                	fld	fa2,96(a2)
    80203f7a:	3a74                	fld	fa3,240(a2)
    80203f7c:	2520                	fld	fs0,72(a0)
    80203f7e:	0a64                	addi	s1,sp,284
	...

0000000080203f81 <app_0_end>:
    80203f81:	3030                	fld	fa2,96(s0)
    80203f83:	0074                	addi	a3,sp,12
    80203f85:	0000                	unimp
	...

0000000080203f88 <app_1_start>:
    80203f88:	00011117          	auipc	sp,0x11
    80203f8c:	f4110113          	addi	sp,sp,-191 # 80214ec9 <UserStack+0x9f91>
    80203f90:	0040006f          	j	80203f94 <app_1_start+0xc>
    80203f94:	1141                	addi	sp,sp,-16
    80203f96:	e406                	sd	ra,8(sp)
    80203f98:	e022                	sd	s0,0(sp)
    80203f9a:	0800                	addi	s0,sp,16
    80203f9c:	00001517          	auipc	a0,0x1
    80203fa0:	e3c50513          	addi	a0,a0,-452 # 80204dd8 <app_1_start+0xe50>
    80203fa4:	0b5000ef          	jal	ra,80204858 <app_1_start+0x8d0>
    80203fa8:	00001517          	auipc	a0,0x1
    80203fac:	e4850513          	addi	a0,a0,-440 # 80204df0 <app_1_start+0xe68>
    80203fb0:	0a9000ef          	jal	ra,80204858 <app_1_start+0x8d0>
    80203fb4:	5a3000ef          	jal	ra,80204d56 <app_1_start+0xdce>
    80203fb8:	87aa                	mv	a5,a0
    80203fba:	2781                	sext.w	a5,a5
    80203fbc:	853e                	mv	a0,a5
    80203fbe:	080000ef          	jal	ra,8020403e <app_1_start+0xb6>
    80203fc2:	0001                	nop
    80203fc4:	60a2                	ld	ra,8(sp)
    80203fc6:	6402                	ld	s0,0(sp)
    80203fc8:	0141                	addi	sp,sp,16
    80203fca:	8082                	ret
    80203fcc:	7179                	addi	sp,sp,-48
    80203fce:	f422                	sd	s0,40(sp)
    80203fd0:	1800                	addi	s0,sp,48
    80203fd2:	fea43423          	sd	a0,-24(s0)
    80203fd6:	feb43023          	sd	a1,-32(s0)
    80203fda:	fcc43c23          	sd	a2,-40(s0)
    80203fde:	fcd43823          	sd	a3,-48(s0)
    80203fe2:	fe043503          	ld	a0,-32(s0)
    80203fe6:	fd843583          	ld	a1,-40(s0)
    80203fea:	fd043603          	ld	a2,-48(s0)
    80203fee:	fe843883          	ld	a7,-24(s0)
    80203ff2:	00000073          	ecall
    80203ff6:	87aa                	mv	a5,a0
    80203ff8:	853e                	mv	a0,a5
    80203ffa:	7422                	ld	s0,40(sp)
    80203ffc:	6145                	addi	sp,sp,48
    80203ffe:	8082                	ret
    80204000:	7179                	addi	sp,sp,-48
    80204002:	f406                	sd	ra,40(sp)
    80204004:	f022                	sd	s0,32(sp)
    80204006:	ec26                	sd	s1,24(sp)
    80204008:	1800                	addi	s0,sp,48
    8020400a:	fca43c23          	sd	a0,-40(s0)
    8020400e:	fcb43823          	sd	a1,-48(s0)
    80204012:	fd043483          	ld	s1,-48(s0)
    80204016:	fd043503          	ld	a0,-48(s0)
    8020401a:	175000ef          	jal	ra,8020498e <app_1_start+0xa06>
    8020401e:	87aa                	mv	a5,a0
    80204020:	86be                	mv	a3,a5
    80204022:	8626                	mv	a2,s1
    80204024:	fd843583          	ld	a1,-40(s0)
    80204028:	04000513          	li	a0,64
    8020402c:	fa1ff0ef          	jal	ra,80203fcc <app_1_start+0x44>
    80204030:	87aa                	mv	a5,a0
    80204032:	853e                	mv	a0,a5
    80204034:	70a2                	ld	ra,40(sp)
    80204036:	7402                	ld	s0,32(sp)
    80204038:	64e2                	ld	s1,24(sp)
    8020403a:	6145                	addi	sp,sp,48
    8020403c:	8082                	ret
    8020403e:	1101                	addi	sp,sp,-32
    80204040:	ec06                	sd	ra,24(sp)
    80204042:	e822                	sd	s0,16(sp)
    80204044:	1000                	addi	s0,sp,32
    80204046:	87aa                	mv	a5,a0
    80204048:	fef42623          	sw	a5,-20(s0)
    8020404c:	fec42783          	lw	a5,-20(s0)
    80204050:	4681                	li	a3,0
    80204052:	4601                	li	a2,0
    80204054:	85be                	mv	a1,a5
    80204056:	05d00513          	li	a0,93
    8020405a:	f73ff0ef          	jal	ra,80203fcc <app_1_start+0x44>
    8020405e:	0001                	nop
    80204060:	60e2                	ld	ra,24(sp)
    80204062:	6442                	ld	s0,16(sp)
    80204064:	6105                	addi	sp,sp,32
    80204066:	8082                	ret
    80204068:	1141                	addi	sp,sp,-16
    8020406a:	e406                	sd	ra,8(sp)
    8020406c:	e022                	sd	s0,0(sp)
    8020406e:	0800                	addi	s0,sp,16
    80204070:	4681                	li	a3,0
    80204072:	4601                	li	a2,0
    80204074:	4581                	li	a1,0
    80204076:	07c00513          	li	a0,124
    8020407a:	f53ff0ef          	jal	ra,80203fcc <app_1_start+0x44>
    8020407e:	0001                	nop
    80204080:	60a2                	ld	ra,8(sp)
    80204082:	6402                	ld	s0,0(sp)
    80204084:	0141                	addi	sp,sp,16
    80204086:	8082                	ret
    80204088:	1101                	addi	sp,sp,-32
    8020408a:	ec06                	sd	ra,24(sp)
    8020408c:	e822                	sd	s0,16(sp)
    8020408e:	1000                	addi	s0,sp,32
    80204090:	fea43423          	sd	a0,-24(s0)
    80204094:	fe843583          	ld	a1,-24(s0)
    80204098:	4505                	li	a0,1
    8020409a:	f67ff0ef          	jal	ra,80204000 <app_1_start+0x78>
    8020409e:	0001                	nop
    802040a0:	60e2                	ld	ra,24(sp)
    802040a2:	6442                	ld	s0,16(sp)
    802040a4:	6105                	addi	sp,sp,32
    802040a6:	8082                	ret
    802040a8:	7179                	addi	sp,sp,-48
    802040aa:	f422                	sd	s0,40(sp)
    802040ac:	1800                	addi	s0,sp,48
    802040ae:	fca43c23          	sd	a0,-40(s0)
    802040b2:	fe042623          	sw	zero,-20(s0)
    802040b6:	a031                	j	802040c2 <app_1_start+0x13a>
    802040b8:	fec42783          	lw	a5,-20(s0)
    802040bc:	2785                	addiw	a5,a5,1
    802040be:	fef42623          	sw	a5,-20(s0)
    802040c2:	fec46783          	lwu	a5,-20(s0)
    802040c6:	fd843703          	ld	a4,-40(s0)
    802040ca:	97ba                	add	a5,a5,a4
    802040cc:	0007c783          	lbu	a5,0(a5)
    802040d0:	f7e5                	bnez	a5,802040b8 <app_1_start+0x130>
    802040d2:	fec42783          	lw	a5,-20(s0)
    802040d6:	853e                	mv	a0,a5
    802040d8:	7422                	ld	s0,40(sp)
    802040da:	6145                	addi	sp,sp,48
    802040dc:	8082                	ret
    802040de:	715d                	addi	sp,sp,-80
    802040e0:	e4a2                	sd	s0,72(sp)
    802040e2:	0880                	addi	s0,sp,80
    802040e4:	fca43423          	sd	a0,-56(s0)
    802040e8:	fae43823          	sd	a4,-80(s0)
    802040ec:	873e                	mv	a4,a5
    802040ee:	87ae                	mv	a5,a1
    802040f0:	fcf42223          	sw	a5,-60(s0)
    802040f4:	87b2                	mv	a5,a2
    802040f6:	fcf42023          	sw	a5,-64(s0)
    802040fa:	87b6                	mv	a5,a3
    802040fc:	faf42e23          	sw	a5,-68(s0)
    80204100:	87ba                	mv	a5,a4
    80204102:	faf42c23          	sw	a5,-72(s0)
    80204106:	fb043783          	ld	a5,-80(s0)
    8020410a:	fef43423          	sd	a5,-24(s0)
    8020410e:	fe042223          	sw	zero,-28(s0)
    80204112:	fc442783          	lw	a5,-60(s0)
    80204116:	0007871b          	sext.w	a4,a5
    8020411a:	47c1                	li	a5,16
    8020411c:	00e7f463          	bgeu	a5,a4,80204124 <app_1_start+0x19c>
    80204120:	4781                	li	a5,0
    80204122:	aae9                	j	802042fc <app_1_start+0x374>
    80204124:	fc843783          	ld	a5,-56(s0)
    80204128:	0007df63          	bgez	a5,80204146 <app_1_start+0x1be>
    8020412c:	fbc42783          	lw	a5,-68(s0)
    80204130:	2781                	sext.w	a5,a5
    80204132:	eb91                	bnez	a5,80204146 <app_1_start+0x1be>
    80204134:	4785                	li	a5,1
    80204136:	fef42223          	sw	a5,-28(s0)
    8020413a:	fc843783          	ld	a5,-56(s0)
    8020413e:	40f007b3          	neg	a5,a5
    80204142:	fcf43423          	sd	a5,-56(s0)
    80204146:	fc042e23          	sw	zero,-36(s0)
    8020414a:	fbc42783          	lw	a5,-68(s0)
    8020414e:	2781                	sext.w	a5,a5
    80204150:	cb91                	beqz	a5,80204164 <app_1_start+0x1dc>
    80204152:	fc843703          	ld	a4,-56(s0)
    80204156:	fc446783          	lwu	a5,-60(s0)
    8020415a:	02f777b3          	remu	a5,a4,a5
    8020415e:	fcf42e23          	sw	a5,-36(s0)
    80204162:	a809                	j	80204174 <app_1_start+0x1ec>
    80204164:	fc446783          	lwu	a5,-60(s0)
    80204168:	fc843703          	ld	a4,-56(s0)
    8020416c:	02f767b3          	rem	a5,a4,a5
    80204170:	fcf42e23          	sw	a5,-36(s0)
    80204174:	fdc42783          	lw	a5,-36(s0)
    80204178:	0007871b          	sext.w	a4,a5
    8020417c:	47a5                	li	a5,9
    8020417e:	00e7cb63          	blt	a5,a4,80204194 <app_1_start+0x20c>
    80204182:	fdc42783          	lw	a5,-36(s0)
    80204186:	0ff7f793          	andi	a5,a5,255
    8020418a:	0307879b          	addiw	a5,a5,48
    8020418e:	0ff7f713          	andi	a4,a5,255
    80204192:	a025                	j	802041ba <app_1_start+0x232>
    80204194:	fc042783          	lw	a5,-64(s0)
    80204198:	2781                	sext.w	a5,a5
    8020419a:	c781                	beqz	a5,802041a2 <app_1_start+0x21a>
    8020419c:	04100793          	li	a5,65
    802041a0:	a019                	j	802041a6 <app_1_start+0x21e>
    802041a2:	06100793          	li	a5,97
    802041a6:	fdc42703          	lw	a4,-36(s0)
    802041aa:	0ff77713          	andi	a4,a4,255
    802041ae:	9fb9                	addw	a5,a5,a4
    802041b0:	0ff7f793          	andi	a5,a5,255
    802041b4:	37d9                	addiw	a5,a5,-10
    802041b6:	0ff7f713          	andi	a4,a5,255
    802041ba:	fe843783          	ld	a5,-24(s0)
    802041be:	00178693          	addi	a3,a5,1
    802041c2:	fed43423          	sd	a3,-24(s0)
    802041c6:	00e78023          	sb	a4,0(a5)
    802041ca:	fbc42783          	lw	a5,-68(s0)
    802041ce:	2781                	sext.w	a5,a5
    802041d0:	cb91                	beqz	a5,802041e4 <app_1_start+0x25c>
    802041d2:	fc843703          	ld	a4,-56(s0)
    802041d6:	fc446783          	lwu	a5,-60(s0)
    802041da:	02f757b3          	divu	a5,a4,a5
    802041de:	fcf43423          	sd	a5,-56(s0)
    802041e2:	a809                	j	802041f4 <app_1_start+0x26c>
    802041e4:	fc446783          	lwu	a5,-60(s0)
    802041e8:	fc843703          	ld	a4,-56(s0)
    802041ec:	02f747b3          	div	a5,a4,a5
    802041f0:	fcf43423          	sd	a5,-56(s0)
    802041f4:	fc843783          	ld	a5,-56(s0)
    802041f8:	f7b9                	bnez	a5,80204146 <app_1_start+0x1be>
    802041fa:	fe843703          	ld	a4,-24(s0)
    802041fe:	fb043783          	ld	a5,-80(s0)
    80204202:	40f707b3          	sub	a5,a4,a5
    80204206:	fef42023          	sw	a5,-32(s0)
    8020420a:	a005                	j	8020422a <app_1_start+0x2a2>
    8020420c:	fe843783          	ld	a5,-24(s0)
    80204210:	00178713          	addi	a4,a5,1
    80204214:	fee43423          	sd	a4,-24(s0)
    80204218:	03000713          	li	a4,48
    8020421c:	00e78023          	sb	a4,0(a5)
    80204220:	fe042783          	lw	a5,-32(s0)
    80204224:	2785                	addiw	a5,a5,1
    80204226:	fef42023          	sw	a5,-32(s0)
    8020422a:	fe042703          	lw	a4,-32(s0)
    8020422e:	fb842783          	lw	a5,-72(s0)
    80204232:	2701                	sext.w	a4,a4
    80204234:	2781                	sext.w	a5,a5
    80204236:	fcf76be3          	bltu	a4,a5,8020420c <app_1_start+0x284>
    8020423a:	fe442783          	lw	a5,-28(s0)
    8020423e:	2781                	sext.w	a5,a5
    80204240:	cb99                	beqz	a5,80204256 <app_1_start+0x2ce>
    80204242:	fe843783          	ld	a5,-24(s0)
    80204246:	00178713          	addi	a4,a5,1
    8020424a:	fee43423          	sd	a4,-24(s0)
    8020424e:	02d00713          	li	a4,45
    80204252:	00e78023          	sb	a4,0(a5)
    80204256:	fe843783          	ld	a5,-24(s0)
    8020425a:	00078023          	sb	zero,0(a5)
    8020425e:	fe843703          	ld	a4,-24(s0)
    80204262:	fb043783          	ld	a5,-80(s0)
    80204266:	40f707b3          	sub	a5,a4,a5
    8020426a:	fcf42c23          	sw	a5,-40(s0)
    8020426e:	fe042023          	sw	zero,-32(s0)
    80204272:	a885                	j	802042e2 <app_1_start+0x35a>
    80204274:	fe046783          	lwu	a5,-32(s0)
    80204278:	fb043703          	ld	a4,-80(s0)
    8020427c:	97ba                	add	a5,a5,a4
    8020427e:	0007c783          	lbu	a5,0(a5)
    80204282:	fcf40ba3          	sb	a5,-41(s0)
    80204286:	fd842703          	lw	a4,-40(s0)
    8020428a:	fe042783          	lw	a5,-32(s0)
    8020428e:	40f707bb          	subw	a5,a4,a5
    80204292:	2781                	sext.w	a5,a5
    80204294:	37fd                	addiw	a5,a5,-1
    80204296:	2781                	sext.w	a5,a5
    80204298:	1782                	slli	a5,a5,0x20
    8020429a:	9381                	srli	a5,a5,0x20
    8020429c:	fb043703          	ld	a4,-80(s0)
    802042a0:	973e                	add	a4,a4,a5
    802042a2:	fe046783          	lwu	a5,-32(s0)
    802042a6:	fb043683          	ld	a3,-80(s0)
    802042aa:	97b6                	add	a5,a5,a3
    802042ac:	00074703          	lbu	a4,0(a4)
    802042b0:	00e78023          	sb	a4,0(a5)
    802042b4:	fd842703          	lw	a4,-40(s0)
    802042b8:	fe042783          	lw	a5,-32(s0)
    802042bc:	40f707bb          	subw	a5,a4,a5
    802042c0:	2781                	sext.w	a5,a5
    802042c2:	37fd                	addiw	a5,a5,-1
    802042c4:	2781                	sext.w	a5,a5
    802042c6:	1782                	slli	a5,a5,0x20
    802042c8:	9381                	srli	a5,a5,0x20
    802042ca:	fb043703          	ld	a4,-80(s0)
    802042ce:	97ba                	add	a5,a5,a4
    802042d0:	fd744703          	lbu	a4,-41(s0)
    802042d4:	00e78023          	sb	a4,0(a5)
    802042d8:	fe042783          	lw	a5,-32(s0)
    802042dc:	2785                	addiw	a5,a5,1
    802042de:	fef42023          	sw	a5,-32(s0)
    802042e2:	fd842783          	lw	a5,-40(s0)
    802042e6:	0017d79b          	srliw	a5,a5,0x1
    802042ea:	0007871b          	sext.w	a4,a5
    802042ee:	fe042783          	lw	a5,-32(s0)
    802042f2:	2781                	sext.w	a5,a5
    802042f4:	f8e7e0e3          	bltu	a5,a4,80204274 <app_1_start+0x2ec>
    802042f8:	fd842783          	lw	a5,-40(s0)
    802042fc:	853e                	mv	a0,a5
    802042fe:	6426                	ld	s0,72(sp)
    80204300:	6161                	addi	sp,sp,80
    80204302:	8082                	ret
    80204304:	1101                	addi	sp,sp,-32
    80204306:	ec22                	sd	s0,24(sp)
    80204308:	1000                	addi	s0,sp,32
    8020430a:	87aa                	mv	a5,a0
    8020430c:	feb43023          	sd	a1,-32(s0)
    80204310:	fef42623          	sw	a5,-20(s0)
    80204314:	fe043783          	ld	a5,-32(s0)
    80204318:	6798                	ld	a4,8(a5)
    8020431a:	fe043783          	ld	a5,-32(s0)
    8020431e:	639c                	ld	a5,0(a5)
    80204320:	40f707b3          	sub	a5,a4,a5
    80204324:	2781                	sext.w	a5,a5
    80204326:	2785                	addiw	a5,a5,1
    80204328:	0007871b          	sext.w	a4,a5
    8020432c:	fe043783          	ld	a5,-32(s0)
    80204330:	4b9c                	lw	a5,16(a5)
    80204332:	00f76463          	bltu	a4,a5,8020433a <app_1_start+0x3b2>
    80204336:	4781                	li	a5,0
    80204338:	a02d                	j	80204362 <app_1_start+0x3da>
    8020433a:	fe043783          	ld	a5,-32(s0)
    8020433e:	679c                	ld	a5,8(a5)
    80204340:	00178693          	addi	a3,a5,1
    80204344:	fe043703          	ld	a4,-32(s0)
    80204348:	e714                	sd	a3,8(a4)
    8020434a:	fec42703          	lw	a4,-20(s0)
    8020434e:	0ff77713          	andi	a4,a4,255
    80204352:	00e78023          	sb	a4,0(a5)
    80204356:	fe043783          	ld	a5,-32(s0)
    8020435a:	679c                	ld	a5,8(a5)
    8020435c:	00078023          	sb	zero,0(a5)
    80204360:	4785                	li	a5,1
    80204362:	853e                	mv	a0,a5
    80204364:	6462                	ld	s0,24(sp)
    80204366:	6105                	addi	sp,sp,32
    80204368:	8082                	ret
    8020436a:	7139                	addi	sp,sp,-64
    8020436c:	fc22                	sd	s0,56(sp)
    8020436e:	0080                	addi	s0,sp,64
    80204370:	fca43c23          	sd	a0,-40(s0)
    80204374:	87ae                	mv	a5,a1
    80204376:	fcc43423          	sd	a2,-56(s0)
    8020437a:	fcf42a23          	sw	a5,-44(s0)
    8020437e:	fc843783          	ld	a5,-56(s0)
    80204382:	4b9c                	lw	a5,16(a5)
    80204384:	02079713          	slli	a4,a5,0x20
    80204388:	9301                	srli	a4,a4,0x20
    8020438a:	fc843783          	ld	a5,-56(s0)
    8020438e:	6794                	ld	a3,8(a5)
    80204390:	fc843783          	ld	a5,-56(s0)
    80204394:	639c                	ld	a5,0(a5)
    80204396:	40f687b3          	sub	a5,a3,a5
    8020439a:	8f1d                	sub	a4,a4,a5
    8020439c:	fd446783          	lwu	a5,-44(s0)
    802043a0:	02e7c463          	blt	a5,a4,802043c8 <app_1_start+0x440>
    802043a4:	fc843783          	ld	a5,-56(s0)
    802043a8:	4b98                	lw	a4,16(a5)
    802043aa:	fc843783          	ld	a5,-56(s0)
    802043ae:	6794                	ld	a3,8(a5)
    802043b0:	fc843783          	ld	a5,-56(s0)
    802043b4:	639c                	ld	a5,0(a5)
    802043b6:	40f687b3          	sub	a5,a3,a5
    802043ba:	2781                	sext.w	a5,a5
    802043bc:	40f707bb          	subw	a5,a4,a5
    802043c0:	2781                	sext.w	a5,a5
    802043c2:	37fd                	addiw	a5,a5,-1
    802043c4:	fcf42a23          	sw	a5,-44(s0)
    802043c8:	fe042623          	sw	zero,-20(s0)
    802043cc:	a03d                	j	802043fa <app_1_start+0x472>
    802043ce:	fec46783          	lwu	a5,-20(s0)
    802043d2:	fd843703          	ld	a4,-40(s0)
    802043d6:	973e                	add	a4,a4,a5
    802043d8:	fc843783          	ld	a5,-56(s0)
    802043dc:	679c                	ld	a5,8(a5)
    802043de:	00178613          	addi	a2,a5,1
    802043e2:	fc843683          	ld	a3,-56(s0)
    802043e6:	e690                	sd	a2,8(a3)
    802043e8:	00074703          	lbu	a4,0(a4)
    802043ec:	00e78023          	sb	a4,0(a5)
    802043f0:	fec42783          	lw	a5,-20(s0)
    802043f4:	2785                	addiw	a5,a5,1
    802043f6:	fef42623          	sw	a5,-20(s0)
    802043fa:	fec42703          	lw	a4,-20(s0)
    802043fe:	fd442783          	lw	a5,-44(s0)
    80204402:	2701                	sext.w	a4,a4
    80204404:	2781                	sext.w	a5,a5
    80204406:	fcf764e3          	bltu	a4,a5,802043ce <app_1_start+0x446>
    8020440a:	fc843783          	ld	a5,-56(s0)
    8020440e:	679c                	ld	a5,8(a5)
    80204410:	00078023          	sb	zero,0(a5)
    80204414:	fd442783          	lw	a5,-44(s0)
    80204418:	853e                	mv	a0,a5
    8020441a:	7462                	ld	s0,56(sp)
    8020441c:	6121                	addi	sp,sp,64
    8020441e:	8082                	ret
    80204420:	7119                	addi	sp,sp,-128
    80204422:	fc86                	sd	ra,120(sp)
    80204424:	f8a2                	sd	s0,112(sp)
    80204426:	0100                	addi	s0,sp,128
    80204428:	f8a43c23          	sd	a0,-104(s0)
    8020442c:	87ae                	mv	a5,a1
    8020442e:	f8c43423          	sd	a2,-120(s0)
    80204432:	f8d43023          	sd	a3,-128(s0)
    80204436:	f8f42a23          	sw	a5,-108(s0)
    8020443a:	f9843783          	ld	a5,-104(s0)
    8020443e:	fcf43023          	sd	a5,-64(s0)
    80204442:	f9843783          	ld	a5,-104(s0)
    80204446:	fcf43423          	sd	a5,-56(s0)
    8020444a:	f9442783          	lw	a5,-108(s0)
    8020444e:	fcf42823          	sw	a5,-48(s0)
    80204452:	a4f9                	j	80204720 <app_1_start+0x798>
    80204454:	fc843703          	ld	a4,-56(s0)
    80204458:	fc043783          	ld	a5,-64(s0)
    8020445c:	40f707b3          	sub	a5,a4,a5
    80204460:	2781                	sext.w	a5,a5
    80204462:	2785                	addiw	a5,a5,1
    80204464:	0007871b          	sext.w	a4,a5
    80204468:	fd042783          	lw	a5,-48(s0)
    8020446c:	2cf77b63          	bgeu	a4,a5,80204742 <app_1_start+0x7ba>
    80204470:	fef44783          	lbu	a5,-17(s0)
    80204474:	0ff7f713          	andi	a4,a5,255
    80204478:	02500793          	li	a5,37
    8020447c:	00f70c63          	beq	a4,a5,80204494 <app_1_start+0x50c>
    80204480:	fef44783          	lbu	a5,-17(s0)
    80204484:	2781                	sext.w	a5,a5
    80204486:	fc040713          	addi	a4,s0,-64
    8020448a:	85ba                	mv	a1,a4
    8020448c:	853e                	mv	a0,a5
    8020448e:	e77ff0ef          	jal	ra,80204304 <app_1_start+0x37c>
    80204492:	a479                	j	80204720 <app_1_start+0x798>
    80204494:	fe040723          	sb	zero,-18(s0)
    80204498:	fe042423          	sw	zero,-24(s0)
    8020449c:	f8843783          	ld	a5,-120(s0)
    802044a0:	00178713          	addi	a4,a5,1
    802044a4:	f8e43423          	sd	a4,-120(s0)
    802044a8:	0007c783          	lbu	a5,0(a5)
    802044ac:	fef407a3          	sb	a5,-17(s0)
    802044b0:	fef44783          	lbu	a5,-17(s0)
    802044b4:	0ff7f713          	andi	a4,a5,255
    802044b8:	03000793          	li	a5,48
    802044bc:	06f71b63          	bne	a4,a5,80204532 <app_1_start+0x5aa>
    802044c0:	a891                	j	80204514 <app_1_start+0x58c>
    802044c2:	fef44783          	lbu	a5,-17(s0)
    802044c6:	0ff7f793          	andi	a5,a5,255
    802044ca:	26078e63          	beqz	a5,80204746 <app_1_start+0x7be>
    802044ce:	fef44783          	lbu	a5,-17(s0)
    802044d2:	0ff7f713          	andi	a4,a5,255
    802044d6:	02f00793          	li	a5,47
    802044da:	04e7fc63          	bgeu	a5,a4,80204532 <app_1_start+0x5aa>
    802044de:	fef44783          	lbu	a5,-17(s0)
    802044e2:	0ff7f713          	andi	a4,a5,255
    802044e6:	03900793          	li	a5,57
    802044ea:	04e7e463          	bltu	a5,a4,80204532 <app_1_start+0x5aa>
    802044ee:	fee44703          	lbu	a4,-18(s0)
    802044f2:	87ba                	mv	a5,a4
    802044f4:	0027979b          	slliw	a5,a5,0x2
    802044f8:	9fb9                	addw	a5,a5,a4
    802044fa:	0017979b          	slliw	a5,a5,0x1
    802044fe:	0ff7f793          	andi	a5,a5,255
    80204502:	fef44703          	lbu	a4,-17(s0)
    80204506:	9fb9                	addw	a5,a5,a4
    80204508:	0ff7f793          	andi	a5,a5,255
    8020450c:	fd07879b          	addiw	a5,a5,-48
    80204510:	fef40723          	sb	a5,-18(s0)
    80204514:	f8843783          	ld	a5,-120(s0)
    80204518:	00178713          	addi	a4,a5,1
    8020451c:	f8e43423          	sd	a4,-120(s0)
    80204520:	0007c783          	lbu	a5,0(a5)
    80204524:	fef407a3          	sb	a5,-17(s0)
    80204528:	fef44783          	lbu	a5,-17(s0)
    8020452c:	0ff7f793          	andi	a5,a5,255
    80204530:	fbc9                	bnez	a5,802044c2 <app_1_start+0x53a>
    80204532:	fef44783          	lbu	a5,-17(s0)
    80204536:	0ff7f713          	andi	a4,a5,255
    8020453a:	06c00793          	li	a5,108
    8020453e:	00f71f63          	bne	a4,a5,8020455c <app_1_start+0x5d4>
    80204542:	4785                	li	a5,1
    80204544:	fef42423          	sw	a5,-24(s0)
    80204548:	f8843783          	ld	a5,-120(s0)
    8020454c:	00178713          	addi	a4,a5,1
    80204550:	f8e43423          	sd	a4,-120(s0)
    80204554:	0007c783          	lbu	a5,0(a5)
    80204558:	fef407a3          	sb	a5,-17(s0)
    8020455c:	fef44783          	lbu	a5,-17(s0)
    80204560:	2781                	sext.w	a5,a5
    80204562:	1e078463          	beqz	a5,8020474a <app_1_start+0x7c2>
    80204566:	873e                	mv	a4,a5
    80204568:	1a074263          	bltz	a4,8020470c <app_1_start+0x784>
    8020456c:	86be                	mv	a3,a5
    8020456e:	07800713          	li	a4,120
    80204572:	18d74d63          	blt	a4,a3,8020470c <app_1_start+0x784>
    80204576:	86be                	mv	a3,a5
    80204578:	05800713          	li	a4,88
    8020457c:	18e6c863          	blt	a3,a4,8020470c <app_1_start+0x784>
    80204580:	fa87869b          	addiw	a3,a5,-88
    80204584:	0006871b          	sext.w	a4,a3
    80204588:	02000793          	li	a5,32
    8020458c:	18e7e063          	bltu	a5,a4,8020470c <app_1_start+0x784>
    80204590:	02069793          	slli	a5,a3,0x20
    80204594:	9381                	srli	a5,a5,0x20
    80204596:	00279713          	slli	a4,a5,0x2
    8020459a:	00001797          	auipc	a5,0x1
    8020459e:	87678793          	addi	a5,a5,-1930 # 80204e10 <app_1_start+0xe88>
    802045a2:	97ba                	add	a5,a5,a4
    802045a4:	439c                	lw	a5,0(a5)
    802045a6:	0007871b          	sext.w	a4,a5
    802045aa:	00001797          	auipc	a5,0x1
    802045ae:	86678793          	addi	a5,a5,-1946 # 80204e10 <app_1_start+0xe88>
    802045b2:	97ba                	add	a5,a5,a4
    802045b4:	8782                	jr	a5
    802045b6:	4785                	li	a5,1
    802045b8:	fef42423          	sw	a5,-24(s0)
    802045bc:	a295                	j	80204720 <app_1_start+0x798>
    802045be:	fe842783          	lw	a5,-24(s0)
    802045c2:	2781                	sext.w	a5,a5
    802045c4:	ef81                	bnez	a5,802045dc <app_1_start+0x654>
    802045c6:	f8043783          	ld	a5,-128(s0)
    802045ca:	00878713          	addi	a4,a5,8
    802045ce:	f8e43023          	sd	a4,-128(s0)
    802045d2:	439c                	lw	a5,0(a5)
    802045d4:	02079513          	slli	a0,a5,0x20
    802045d8:	9101                	srli	a0,a0,0x20
    802045da:	a809                	j	802045ec <app_1_start+0x664>
    802045dc:	f8043783          	ld	a5,-128(s0)
    802045e0:	00878713          	addi	a4,a5,8
    802045e4:	f8e43023          	sd	a4,-128(s0)
    802045e8:	639c                	ld	a5,0(a5)
    802045ea:	853e                	mv	a0,a5
    802045ec:	fef44783          	lbu	a5,-17(s0)
    802045f0:	0007871b          	sext.w	a4,a5
    802045f4:	07500793          	li	a5,117
    802045f8:	40f707b3          	sub	a5,a4,a5
    802045fc:	0017b793          	seqz	a5,a5
    80204600:	0ff7f793          	andi	a5,a5,255
    80204604:	0007869b          	sext.w	a3,a5
    80204608:	fee44783          	lbu	a5,-18(s0)
    8020460c:	2781                	sext.w	a5,a5
    8020460e:	fa840713          	addi	a4,s0,-88
    80204612:	4601                	li	a2,0
    80204614:	45a9                	li	a1,10
    80204616:	ac9ff0ef          	jal	ra,802040de <app_1_start+0x156>
    8020461a:	87aa                	mv	a5,a0
    8020461c:	fcf42e23          	sw	a5,-36(s0)
    80204620:	fc040693          	addi	a3,s0,-64
    80204624:	fdc42703          	lw	a4,-36(s0)
    80204628:	fa840793          	addi	a5,s0,-88
    8020462c:	8636                	mv	a2,a3
    8020462e:	85ba                	mv	a1,a4
    80204630:	853e                	mv	a0,a5
    80204632:	d39ff0ef          	jal	ra,8020436a <app_1_start+0x3e2>
    80204636:	fe042423          	sw	zero,-24(s0)
    8020463a:	a0dd                	j	80204720 <app_1_start+0x798>
    8020463c:	fe842783          	lw	a5,-24(s0)
    80204640:	2781                	sext.w	a5,a5
    80204642:	ef81                	bnez	a5,8020465a <app_1_start+0x6d2>
    80204644:	f8043783          	ld	a5,-128(s0)
    80204648:	00878713          	addi	a4,a5,8
    8020464c:	f8e43023          	sd	a4,-128(s0)
    80204650:	439c                	lw	a5,0(a5)
    80204652:	02079513          	slli	a0,a5,0x20
    80204656:	9101                	srli	a0,a0,0x20
    80204658:	a809                	j	8020466a <app_1_start+0x6e2>
    8020465a:	f8043783          	ld	a5,-128(s0)
    8020465e:	00878713          	addi	a4,a5,8
    80204662:	f8e43023          	sd	a4,-128(s0)
    80204666:	639c                	ld	a5,0(a5)
    80204668:	853e                	mv	a0,a5
    8020466a:	fef44783          	lbu	a5,-17(s0)
    8020466e:	0007871b          	sext.w	a4,a5
    80204672:	05800793          	li	a5,88
    80204676:	40f707b3          	sub	a5,a4,a5
    8020467a:	0017b793          	seqz	a5,a5
    8020467e:	0ff7f793          	andi	a5,a5,255
    80204682:	0007861b          	sext.w	a2,a5
    80204686:	fee44783          	lbu	a5,-18(s0)
    8020468a:	2781                	sext.w	a5,a5
    8020468c:	fa840713          	addi	a4,s0,-88
    80204690:	4685                	li	a3,1
    80204692:	45c1                	li	a1,16
    80204694:	a4bff0ef          	jal	ra,802040de <app_1_start+0x156>
    80204698:	87aa                	mv	a5,a0
    8020469a:	fcf42e23          	sw	a5,-36(s0)
    8020469e:	fc040693          	addi	a3,s0,-64
    802046a2:	fdc42703          	lw	a4,-36(s0)
    802046a6:	fa840793          	addi	a5,s0,-88
    802046aa:	8636                	mv	a2,a3
    802046ac:	85ba                	mv	a1,a4
    802046ae:	853e                	mv	a0,a5
    802046b0:	cbbff0ef          	jal	ra,8020436a <app_1_start+0x3e2>
    802046b4:	fe042423          	sw	zero,-24(s0)
    802046b8:	a0a5                	j	80204720 <app_1_start+0x798>
    802046ba:	f8043783          	ld	a5,-128(s0)
    802046be:	00878713          	addi	a4,a5,8
    802046c2:	f8e43023          	sd	a4,-128(s0)
    802046c6:	439c                	lw	a5,0(a5)
    802046c8:	0ff7f793          	andi	a5,a5,255
    802046cc:	2781                	sext.w	a5,a5
    802046ce:	fc040713          	addi	a4,s0,-64
    802046d2:	85ba                	mv	a1,a4
    802046d4:	853e                	mv	a0,a5
    802046d6:	c2fff0ef          	jal	ra,80204304 <app_1_start+0x37c>
    802046da:	a099                	j	80204720 <app_1_start+0x798>
    802046dc:	f8043783          	ld	a5,-128(s0)
    802046e0:	00878713          	addi	a4,a5,8
    802046e4:	f8e43023          	sd	a4,-128(s0)
    802046e8:	639c                	ld	a5,0(a5)
    802046ea:	fef43023          	sd	a5,-32(s0)
    802046ee:	fe043503          	ld	a0,-32(s0)
    802046f2:	9b7ff0ef          	jal	ra,802040a8 <app_1_start+0x120>
    802046f6:	87aa                	mv	a5,a0
    802046f8:	2781                	sext.w	a5,a5
    802046fa:	fc040713          	addi	a4,s0,-64
    802046fe:	863a                	mv	a2,a4
    80204700:	85be                	mv	a1,a5
    80204702:	fe043503          	ld	a0,-32(s0)
    80204706:	c65ff0ef          	jal	ra,8020436a <app_1_start+0x3e2>
    8020470a:	a819                	j	80204720 <app_1_start+0x798>
    8020470c:	fef44783          	lbu	a5,-17(s0)
    80204710:	2781                	sext.w	a5,a5
    80204712:	fc040713          	addi	a4,s0,-64
    80204716:	85ba                	mv	a1,a4
    80204718:	853e                	mv	a0,a5
    8020471a:	bebff0ef          	jal	ra,80204304 <app_1_start+0x37c>
    8020471e:	0001                	nop
    80204720:	f8843783          	ld	a5,-120(s0)
    80204724:	00178713          	addi	a4,a5,1
    80204728:	f8e43423          	sd	a4,-120(s0)
    8020472c:	0007c783          	lbu	a5,0(a5)
    80204730:	fef407a3          	sb	a5,-17(s0)
    80204734:	fef44783          	lbu	a5,-17(s0)
    80204738:	0ff7f793          	andi	a5,a5,255
    8020473c:	d0079ce3          	bnez	a5,80204454 <app_1_start+0x4cc>
    80204740:	a031                	j	8020474c <app_1_start+0x7c4>
    80204742:	0001                	nop
    80204744:	a021                	j	8020474c <app_1_start+0x7c4>
    80204746:	0001                	nop
    80204748:	a011                	j	8020474c <app_1_start+0x7c4>
    8020474a:	0001                	nop
    8020474c:	fc843703          	ld	a4,-56(s0)
    80204750:	fc043783          	ld	a5,-64(s0)
    80204754:	40f707b3          	sub	a5,a4,a5
    80204758:	2781                	sext.w	a5,a5
    8020475a:	853e                	mv	a0,a5
    8020475c:	70e6                	ld	ra,120(sp)
    8020475e:	7446                	ld	s0,112(sp)
    80204760:	6109                	addi	sp,sp,128
    80204762:	8082                	ret
    80204764:	7129                	addi	sp,sp,-320
    80204766:	fe06                	sd	ra,312(sp)
    80204768:	fa22                	sd	s0,304(sp)
    8020476a:	0280                	addi	s0,sp,320
    8020476c:	eca43c23          	sd	a0,-296(s0)
    80204770:	ecb43823          	sd	a1,-304(s0)
    80204774:	ecc43423          	sd	a2,-312(s0)
    80204778:	ed043783          	ld	a5,-304(s0)
    8020477c:	fef43023          	sd	a5,-32(s0)
    80204780:	fe043703          	ld	a4,-32(s0)
    80204784:	ee040793          	addi	a5,s0,-288
    80204788:	86ba                	mv	a3,a4
    8020478a:	ed843603          	ld	a2,-296(s0)
    8020478e:	10000593          	li	a1,256
    80204792:	853e                	mv	a0,a5
    80204794:	c8dff0ef          	jal	ra,80204420 <app_1_start+0x498>
    80204798:	87aa                	mv	a5,a0
    8020479a:	fef42623          	sw	a5,-20(s0)
    8020479e:	fec42783          	lw	a5,-20(s0)
    802047a2:	ff040713          	addi	a4,s0,-16
    802047a6:	97ba                	add	a5,a5,a4
    802047a8:	ee078823          	sb	zero,-272(a5)
    802047ac:	ee040793          	addi	a5,s0,-288
    802047b0:	ec843703          	ld	a4,-312(s0)
    802047b4:	853e                	mv	a0,a5
    802047b6:	9702                	jalr	a4
    802047b8:	fec42783          	lw	a5,-20(s0)
    802047bc:	853e                	mv	a0,a5
    802047be:	70f2                	ld	ra,312(sp)
    802047c0:	7452                	ld	s0,304(sp)
    802047c2:	6131                	addi	sp,sp,320
    802047c4:	8082                	ret
    802047c6:	7129                	addi	sp,sp,-320
    802047c8:	fe06                	sd	ra,312(sp)
    802047ca:	fa22                	sd	s0,304(sp)
    802047cc:	0280                	addi	s0,sp,320
    802047ce:	eca43c23          	sd	a0,-296(s0)
    802047d2:	ecb43823          	sd	a1,-304(s0)
    802047d6:	ecc43423          	sd	a2,-312(s0)
    802047da:	ed043783          	ld	a5,-304(s0)
    802047de:	fef43023          	sd	a5,-32(s0)
    802047e2:	fe043703          	ld	a4,-32(s0)
    802047e6:	ee040793          	addi	a5,s0,-288
    802047ea:	86ba                	mv	a3,a4
    802047ec:	ed843603          	ld	a2,-296(s0)
    802047f0:	10000593          	li	a1,256
    802047f4:	853e                	mv	a0,a5
    802047f6:	c2bff0ef          	jal	ra,80204420 <app_1_start+0x498>
    802047fa:	87aa                	mv	a5,a0
    802047fc:	fef42623          	sw	a5,-20(s0)
    80204800:	fec42783          	lw	a5,-20(s0)
    80204804:	ff040713          	addi	a4,s0,-16
    80204808:	97ba                	add	a5,a5,a4
    8020480a:	ee078823          	sb	zero,-272(a5)
    8020480e:	ee040793          	addi	a5,s0,-288
    80204812:	ec843703          	ld	a4,-312(s0)
    80204816:	853e                	mv	a0,a5
    80204818:	9702                	jalr	a4
    8020481a:	fec42783          	lw	a5,-20(s0)
    8020481e:	853e                	mv	a0,a5
    80204820:	70f2                	ld	ra,312(sp)
    80204822:	7452                	ld	s0,304(sp)
    80204824:	6131                	addi	sp,sp,320
    80204826:	8082                	ret
    80204828:	1101                	addi	sp,sp,-32
    8020482a:	ec06                	sd	ra,24(sp)
    8020482c:	e822                	sd	s0,16(sp)
    8020482e:	1000                	addi	s0,sp,32
    80204830:	fea43423          	sd	a0,-24(s0)
    80204834:	feb43023          	sd	a1,-32(s0)
    80204838:	00000617          	auipc	a2,0x0
    8020483c:	85060613          	addi	a2,a2,-1968 # 80204088 <app_1_start+0x100>
    80204840:	fe043583          	ld	a1,-32(s0)
    80204844:	fe843503          	ld	a0,-24(s0)
    80204848:	f1dff0ef          	jal	ra,80204764 <app_1_start+0x7dc>
    8020484c:	87aa                	mv	a5,a0
    8020484e:	853e                	mv	a0,a5
    80204850:	60e2                	ld	ra,24(sp)
    80204852:	6442                	ld	s0,16(sp)
    80204854:	6105                	addi	sp,sp,32
    80204856:	8082                	ret
    80204858:	7159                	addi	sp,sp,-112
    8020485a:	f406                	sd	ra,40(sp)
    8020485c:	f022                	sd	s0,32(sp)
    8020485e:	1800                	addi	s0,sp,48
    80204860:	fca43c23          	sd	a0,-40(s0)
    80204864:	e40c                	sd	a1,8(s0)
    80204866:	e810                	sd	a2,16(s0)
    80204868:	ec14                	sd	a3,24(s0)
    8020486a:	f018                	sd	a4,32(s0)
    8020486c:	f41c                	sd	a5,40(s0)
    8020486e:	03043823          	sd	a6,48(s0)
    80204872:	03143c23          	sd	a7,56(s0)
    80204876:	fe042623          	sw	zero,-20(s0)
    8020487a:	04040793          	addi	a5,s0,64
    8020487e:	fcf43823          	sd	a5,-48(s0)
    80204882:	fd043783          	ld	a5,-48(s0)
    80204886:	fc878793          	addi	a5,a5,-56
    8020488a:	fef43023          	sd	a5,-32(s0)
    8020488e:	fe043783          	ld	a5,-32(s0)
    80204892:	85be                	mv	a1,a5
    80204894:	fd843503          	ld	a0,-40(s0)
    80204898:	f91ff0ef          	jal	ra,80204828 <app_1_start+0x8a0>
    8020489c:	87aa                	mv	a5,a0
    8020489e:	fef42623          	sw	a5,-20(s0)
    802048a2:	fec42783          	lw	a5,-20(s0)
    802048a6:	853e                	mv	a0,a5
    802048a8:	70a2                	ld	ra,40(sp)
    802048aa:	7402                	ld	s0,32(sp)
    802048ac:	6165                	addi	sp,sp,112
    802048ae:	8082                	ret
    802048b0:	7129                	addi	sp,sp,-320
    802048b2:	fe06                	sd	ra,312(sp)
    802048b4:	fa22                	sd	s0,304(sp)
    802048b6:	0280                	addi	s0,sp,320
    802048b8:	eca43c23          	sd	a0,-296(s0)
    802048bc:	ecb43823          	sd	a1,-304(s0)
    802048c0:	ecc43423          	sd	a2,-312(s0)
    802048c4:	ed043783          	ld	a5,-304(s0)
    802048c8:	fef43023          	sd	a5,-32(s0)
    802048cc:	fe043703          	ld	a4,-32(s0)
    802048d0:	ee040793          	addi	a5,s0,-288
    802048d4:	86ba                	mv	a3,a4
    802048d6:	ed843603          	ld	a2,-296(s0)
    802048da:	10000593          	li	a1,256
    802048de:	853e                	mv	a0,a5
    802048e0:	b41ff0ef          	jal	ra,80204420 <app_1_start+0x498>
    802048e4:	87aa                	mv	a5,a0
    802048e6:	fef42623          	sw	a5,-20(s0)
    802048ea:	fec42783          	lw	a5,-20(s0)
    802048ee:	ff040713          	addi	a4,s0,-16
    802048f2:	97ba                	add	a5,a5,a4
    802048f4:	ee078823          	sb	zero,-272(a5)
    802048f8:	fec42783          	lw	a5,-20(s0)
    802048fc:	853e                	mv	a0,a5
    802048fe:	70f2                	ld	ra,312(sp)
    80204900:	7452                	ld	s0,304(sp)
    80204902:	6131                	addi	sp,sp,320
    80204904:	8082                	ret
    80204906:	1101                	addi	sp,sp,-32
    80204908:	ec06                	sd	ra,24(sp)
    8020490a:	e822                	sd	s0,16(sp)
    8020490c:	1000                	addi	s0,sp,32
    8020490e:	fea43423          	sd	a0,-24(s0)
    80204912:	feb43023          	sd	a1,-32(s0)
    80204916:	fffff617          	auipc	a2,0xfffff
    8020491a:	77260613          	addi	a2,a2,1906 # 80204088 <app_1_start+0x100>
    8020491e:	fe043583          	ld	a1,-32(s0)
    80204922:	fe843503          	ld	a0,-24(s0)
    80204926:	f8bff0ef          	jal	ra,802048b0 <app_1_start+0x928>
    8020492a:	87aa                	mv	a5,a0
    8020492c:	853e                	mv	a0,a5
    8020492e:	60e2                	ld	ra,24(sp)
    80204930:	6442                	ld	s0,16(sp)
    80204932:	6105                	addi	sp,sp,32
    80204934:	8082                	ret
    80204936:	7159                	addi	sp,sp,-112
    80204938:	f406                	sd	ra,40(sp)
    8020493a:	f022                	sd	s0,32(sp)
    8020493c:	1800                	addi	s0,sp,48
    8020493e:	fca43c23          	sd	a0,-40(s0)
    80204942:	e40c                	sd	a1,8(s0)
    80204944:	e810                	sd	a2,16(s0)
    80204946:	ec14                	sd	a3,24(s0)
    80204948:	f018                	sd	a4,32(s0)
    8020494a:	f41c                	sd	a5,40(s0)
    8020494c:	03043823          	sd	a6,48(s0)
    80204950:	03143c23          	sd	a7,56(s0)
    80204954:	fe042623          	sw	zero,-20(s0)
    80204958:	04040793          	addi	a5,s0,64
    8020495c:	fcf43823          	sd	a5,-48(s0)
    80204960:	fd043783          	ld	a5,-48(s0)
    80204964:	fc878793          	addi	a5,a5,-56
    80204968:	fef43023          	sd	a5,-32(s0)
    8020496c:	fe043783          	ld	a5,-32(s0)
    80204970:	85be                	mv	a1,a5
    80204972:	fd843503          	ld	a0,-40(s0)
    80204976:	f91ff0ef          	jal	ra,80204906 <app_1_start+0x97e>
    8020497a:	87aa                	mv	a5,a0
    8020497c:	fef42623          	sw	a5,-20(s0)
    80204980:	fec42783          	lw	a5,-20(s0)
    80204984:	853e                	mv	a0,a5
    80204986:	70a2                	ld	ra,40(sp)
    80204988:	7402                	ld	s0,32(sp)
    8020498a:	6165                	addi	sp,sp,112
    8020498c:	8082                	ret
    8020498e:	7179                	addi	sp,sp,-48
    80204990:	f422                	sd	s0,40(sp)
    80204992:	1800                	addi	s0,sp,48
    80204994:	fca43c23          	sd	a0,-40(s0)
    80204998:	fe042623          	sw	zero,-20(s0)
    8020499c:	a031                	j	802049a8 <app_1_start+0xa20>
    8020499e:	fec42783          	lw	a5,-20(s0)
    802049a2:	2785                	addiw	a5,a5,1
    802049a4:	fef42623          	sw	a5,-20(s0)
    802049a8:	fec42783          	lw	a5,-20(s0)
    802049ac:	fd843703          	ld	a4,-40(s0)
    802049b0:	97ba                	add	a5,a5,a4
    802049b2:	0007c783          	lbu	a5,0(a5)
    802049b6:	f7e5                	bnez	a5,8020499e <app_1_start+0xa16>
    802049b8:	fec42783          	lw	a5,-20(s0)
    802049bc:	853e                	mv	a0,a5
    802049be:	7422                	ld	s0,40(sp)
    802049c0:	6145                	addi	sp,sp,48
    802049c2:	8082                	ret
    802049c4:	7179                	addi	sp,sp,-48
    802049c6:	f422                	sd	s0,40(sp)
    802049c8:	1800                	addi	s0,sp,48
    802049ca:	fea43423          	sd	a0,-24(s0)
    802049ce:	feb43023          	sd	a1,-32(s0)
    802049d2:	87b2                	mv	a5,a2
    802049d4:	fcf42e23          	sw	a5,-36(s0)
    802049d8:	a035                	j	80204a04 <app_1_start+0xa7c>
    802049da:	fe043703          	ld	a4,-32(s0)
    802049de:	00170793          	addi	a5,a4,1
    802049e2:	fef43023          	sd	a5,-32(s0)
    802049e6:	fe843783          	ld	a5,-24(s0)
    802049ea:	00178693          	addi	a3,a5,1
    802049ee:	fed43423          	sd	a3,-24(s0)
    802049f2:	00074703          	lbu	a4,0(a4)
    802049f6:	00e78023          	sb	a4,0(a5)
    802049fa:	fdc42783          	lw	a5,-36(s0)
    802049fe:	37fd                	addiw	a5,a5,-1
    80204a00:	fcf42e23          	sw	a5,-36(s0)
    80204a04:	fdc42783          	lw	a5,-36(s0)
    80204a08:	2781                	sext.w	a5,a5
    80204a0a:	fbe1                	bnez	a5,802049da <app_1_start+0xa52>
    80204a0c:	0001                	nop
    80204a0e:	0001                	nop
    80204a10:	7422                	ld	s0,40(sp)
    80204a12:	6145                	addi	sp,sp,48
    80204a14:	8082                	ret
    80204a16:	7139                	addi	sp,sp,-64
    80204a18:	fc22                	sd	s0,56(sp)
    80204a1a:	0080                	addi	s0,sp,64
    80204a1c:	fca43c23          	sd	a0,-40(s0)
    80204a20:	fcb43823          	sd	a1,-48(s0)
    80204a24:	87b2                	mv	a5,a2
    80204a26:	fcf42623          	sw	a5,-52(s0)
    80204a2a:	fe042623          	sw	zero,-20(s0)
    80204a2e:	a8a1                	j	80204a86 <app_1_start+0xafe>
    80204a30:	fec42783          	lw	a5,-20(s0)
    80204a34:	fd843703          	ld	a4,-40(s0)
    80204a38:	97ba                	add	a5,a5,a4
    80204a3a:	0007c683          	lbu	a3,0(a5)
    80204a3e:	fec42783          	lw	a5,-20(s0)
    80204a42:	fd043703          	ld	a4,-48(s0)
    80204a46:	97ba                	add	a5,a5,a4
    80204a48:	0007c783          	lbu	a5,0(a5)
    80204a4c:	8736                	mv	a4,a3
    80204a4e:	02f70763          	beq	a4,a5,80204a7c <app_1_start+0xaf4>
    80204a52:	fec42783          	lw	a5,-20(s0)
    80204a56:	fd843703          	ld	a4,-40(s0)
    80204a5a:	97ba                	add	a5,a5,a4
    80204a5c:	0007c783          	lbu	a5,0(a5)
    80204a60:	0007871b          	sext.w	a4,a5
    80204a64:	fec42783          	lw	a5,-20(s0)
    80204a68:	fd043683          	ld	a3,-48(s0)
    80204a6c:	97b6                	add	a5,a5,a3
    80204a6e:	0007c783          	lbu	a5,0(a5)
    80204a72:	2781                	sext.w	a5,a5
    80204a74:	40f707bb          	subw	a5,a4,a5
    80204a78:	2781                	sext.w	a5,a5
    80204a7a:	a831                	j	80204a96 <app_1_start+0xb0e>
    80204a7c:	fec42783          	lw	a5,-20(s0)
    80204a80:	2785                	addiw	a5,a5,1
    80204a82:	fef42623          	sw	a5,-20(s0)
    80204a86:	fec42703          	lw	a4,-20(s0)
    80204a8a:	fcc42783          	lw	a5,-52(s0)
    80204a8e:	2781                	sext.w	a5,a5
    80204a90:	faf760e3          	bltu	a4,a5,80204a30 <app_1_start+0xaa8>
    80204a94:	4781                	li	a5,0
    80204a96:	853e                	mv	a0,a5
    80204a98:	7462                	ld	s0,56(sp)
    80204a9a:	6121                	addi	sp,sp,64
    80204a9c:	8082                	ret
    80204a9e:	715d                	addi	sp,sp,-80
    80204aa0:	e4a2                	sd	s0,72(sp)
    80204aa2:	0880                	addi	s0,sp,80
    80204aa4:	fca43423          	sd	a0,-56(s0)
    80204aa8:	fcb43023          	sd	a1,-64(s0)
    80204aac:	86b2                	mv	a3,a2
    80204aae:	fad42e23          	sw	a3,-68(s0)
    80204ab2:	868a                	mv	a3,sp
    80204ab4:	85b6                	mv	a1,a3
    80204ab6:	fbc42683          	lw	a3,-68(s0)
    80204aba:	02069613          	slli	a2,a3,0x20
    80204abe:	9201                	srli	a2,a2,0x20
    80204ac0:	167d                	addi	a2,a2,-1
    80204ac2:	fec43423          	sd	a2,-24(s0)
    80204ac6:	02069613          	slli	a2,a3,0x20
    80204aca:	9201                	srli	a2,a2,0x20
    80204acc:	8e32                	mv	t3,a2
    80204ace:	4e81                	li	t4,0
    80204ad0:	03de5613          	srli	a2,t3,0x3d
    80204ad4:	003e9893          	slli	a7,t4,0x3
    80204ad8:	011668b3          	or	a7,a2,a7
    80204adc:	003e1813          	slli	a6,t3,0x3
    80204ae0:	02069613          	slli	a2,a3,0x20
    80204ae4:	9201                	srli	a2,a2,0x20
    80204ae6:	8332                	mv	t1,a2
    80204ae8:	4381                	li	t2,0
    80204aea:	03d35613          	srli	a2,t1,0x3d
    80204aee:	00339793          	slli	a5,t2,0x3
    80204af2:	8fd1                	or	a5,a5,a2
    80204af4:	00331713          	slli	a4,t1,0x3
    80204af8:	02069793          	slli	a5,a3,0x20
    80204afc:	9381                	srli	a5,a5,0x20
    80204afe:	07bd                	addi	a5,a5,15
    80204b00:	8391                	srli	a5,a5,0x4
    80204b02:	0792                	slli	a5,a5,0x4
    80204b04:	40f10133          	sub	sp,sp,a5
    80204b08:	878a                	mv	a5,sp
    80204b0a:	00078793          	mv	a5,a5
    80204b0e:	fef43023          	sd	a5,-32(s0)
    80204b12:	fc042e23          	sw	zero,-36(s0)
    80204b16:	a02d                	j	80204b40 <app_1_start+0xbb8>
    80204b18:	fc043783          	ld	a5,-64(s0)
    80204b1c:	00178713          	addi	a4,a5,1
    80204b20:	fce43023          	sd	a4,-64(s0)
    80204b24:	0007c703          	lbu	a4,0(a5)
    80204b28:	fe043683          	ld	a3,-32(s0)
    80204b2c:	fdc42783          	lw	a5,-36(s0)
    80204b30:	97b6                	add	a5,a5,a3
    80204b32:	00e78023          	sb	a4,0(a5)
    80204b36:	fbc42783          	lw	a5,-68(s0)
    80204b3a:	37fd                	addiw	a5,a5,-1
    80204b3c:	faf42e23          	sw	a5,-68(s0)
    80204b40:	fbc42783          	lw	a5,-68(s0)
    80204b44:	2781                	sext.w	a5,a5
    80204b46:	fbe9                	bnez	a5,80204b18 <app_1_start+0xb90>
    80204b48:	a02d                	j	80204b72 <app_1_start+0xbea>
    80204b4a:	fc843783          	ld	a5,-56(s0)
    80204b4e:	00178713          	addi	a4,a5,1
    80204b52:	fce43423          	sd	a4,-56(s0)
    80204b56:	fe043683          	ld	a3,-32(s0)
    80204b5a:	fdc42703          	lw	a4,-36(s0)
    80204b5e:	9736                	add	a4,a4,a3
    80204b60:	00074703          	lbu	a4,0(a4)
    80204b64:	00e78023          	sb	a4,0(a5)
    80204b68:	fbc42783          	lw	a5,-68(s0)
    80204b6c:	37fd                	addiw	a5,a5,-1
    80204b6e:	faf42e23          	sw	a5,-68(s0)
    80204b72:	fbc42783          	lw	a5,-68(s0)
    80204b76:	2781                	sext.w	a5,a5
    80204b78:	fbe9                	bnez	a5,80204b4a <app_1_start+0xbc2>
    80204b7a:	812e                	mv	sp,a1
    80204b7c:	0001                	nop
    80204b7e:	fb040113          	addi	sp,s0,-80
    80204b82:	6426                	ld	s0,72(sp)
    80204b84:	6161                	addi	sp,sp,80
    80204b86:	8082                	ret
    80204b88:	7179                	addi	sp,sp,-48
    80204b8a:	f422                	sd	s0,40(sp)
    80204b8c:	1800                	addi	s0,sp,48
    80204b8e:	fca43c23          	sd	a0,-40(s0)
    80204b92:	87ae                	mv	a5,a1
    80204b94:	8732                	mv	a4,a2
    80204b96:	fcf40ba3          	sb	a5,-41(s0)
    80204b9a:	87ba                	mv	a5,a4
    80204b9c:	fcf42823          	sw	a5,-48(s0)
    80204ba0:	fd843783          	ld	a5,-40(s0)
    80204ba4:	fef43423          	sd	a5,-24(s0)
    80204ba8:	a005                	j	80204bc8 <app_1_start+0xc40>
    80204baa:	fe843783          	ld	a5,-24(s0)
    80204bae:	00178713          	addi	a4,a5,1
    80204bb2:	fee43423          	sd	a4,-24(s0)
    80204bb6:	fd744703          	lbu	a4,-41(s0)
    80204bba:	00e78023          	sb	a4,0(a5)
    80204bbe:	fd042783          	lw	a5,-48(s0)
    80204bc2:	37fd                	addiw	a5,a5,-1
    80204bc4:	fcf42823          	sw	a5,-48(s0)
    80204bc8:	fd042783          	lw	a5,-48(s0)
    80204bcc:	2781                	sext.w	a5,a5
    80204bce:	fff1                	bnez	a5,80204baa <app_1_start+0xc22>
    80204bd0:	0001                	nop
    80204bd2:	0001                	nop
    80204bd4:	7422                	ld	s0,40(sp)
    80204bd6:	6145                	addi	sp,sp,48
    80204bd8:	8082                	ret
    80204bda:	1101                	addi	sp,sp,-32
    80204bdc:	ec06                	sd	ra,24(sp)
    80204bde:	e822                	sd	s0,16(sp)
    80204be0:	1000                	addi	s0,sp,32
    80204be2:	fea43423          	sd	a0,-24(s0)
    80204be6:	87ae                	mv	a5,a1
    80204be8:	fef42223          	sw	a5,-28(s0)
    80204bec:	fe442783          	lw	a5,-28(s0)
    80204bf0:	863e                	mv	a2,a5
    80204bf2:	4581                	li	a1,0
    80204bf4:	fe843503          	ld	a0,-24(s0)
    80204bf8:	f91ff0ef          	jal	ra,80204b88 <app_1_start+0xc00>
    80204bfc:	0001                	nop
    80204bfe:	60e2                	ld	ra,24(sp)
    80204c00:	6442                	ld	s0,16(sp)
    80204c02:	6105                	addi	sp,sp,32
    80204c04:	8082                	ret
    80204c06:	1101                	addi	sp,sp,-32
    80204c08:	ec22                	sd	s0,24(sp)
    80204c0a:	1000                	addi	s0,sp,32
    80204c0c:	fea43423          	sd	a0,-24(s0)
    80204c10:	feb43023          	sd	a1,-32(s0)
    80204c14:	a0a1                	j	80204c5c <app_1_start+0xcd4>
    80204c16:	fe843783          	ld	a5,-24(s0)
    80204c1a:	0007c703          	lbu	a4,0(a5)
    80204c1e:	fe043783          	ld	a5,-32(s0)
    80204c22:	0007c783          	lbu	a5,0(a5)
    80204c26:	02f70163          	beq	a4,a5,80204c48 <app_1_start+0xcc0>
    80204c2a:	fe843783          	ld	a5,-24(s0)
    80204c2e:	0007c783          	lbu	a5,0(a5)
    80204c32:	0007871b          	sext.w	a4,a5
    80204c36:	fe043783          	ld	a5,-32(s0)
    80204c3a:	0007c783          	lbu	a5,0(a5)
    80204c3e:	2781                	sext.w	a5,a5
    80204c40:	40f707bb          	subw	a5,a4,a5
    80204c44:	2781                	sext.w	a5,a5
    80204c46:	a099                	j	80204c8c <app_1_start+0xd04>
    80204c48:	fe843783          	ld	a5,-24(s0)
    80204c4c:	0785                	addi	a5,a5,1
    80204c4e:	fef43423          	sd	a5,-24(s0)
    80204c52:	fe043783          	ld	a5,-32(s0)
    80204c56:	0785                	addi	a5,a5,1
    80204c58:	fef43023          	sd	a5,-32(s0)
    80204c5c:	fe843783          	ld	a5,-24(s0)
    80204c60:	0007c783          	lbu	a5,0(a5)
    80204c64:	c791                	beqz	a5,80204c70 <app_1_start+0xce8>
    80204c66:	fe043783          	ld	a5,-32(s0)
    80204c6a:	0007c783          	lbu	a5,0(a5)
    80204c6e:	f7c5                	bnez	a5,80204c16 <app_1_start+0xc8e>
    80204c70:	fe843783          	ld	a5,-24(s0)
    80204c74:	0007c783          	lbu	a5,0(a5)
    80204c78:	0007871b          	sext.w	a4,a5
    80204c7c:	fe043783          	ld	a5,-32(s0)
    80204c80:	0007c783          	lbu	a5,0(a5)
    80204c84:	2781                	sext.w	a5,a5
    80204c86:	40f707bb          	subw	a5,a4,a5
    80204c8a:	2781                	sext.w	a5,a5
    80204c8c:	853e                	mv	a0,a5
    80204c8e:	6462                	ld	s0,24(sp)
    80204c90:	6105                	addi	sp,sp,32
    80204c92:	8082                	ret
    80204c94:	7179                	addi	sp,sp,-48
    80204c96:	f422                	sd	s0,40(sp)
    80204c98:	1800                	addi	s0,sp,48
    80204c9a:	fca43c23          	sd	a0,-40(s0)
    80204c9e:	fcb43823          	sd	a1,-48(s0)
    80204ca2:	fd843783          	ld	a5,-40(s0)
    80204ca6:	fef43423          	sd	a5,-24(s0)
    80204caa:	a00d                	j	80204ccc <app_1_start+0xd44>
    80204cac:	fd043703          	ld	a4,-48(s0)
    80204cb0:	00170793          	addi	a5,a4,1
    80204cb4:	fcf43823          	sd	a5,-48(s0)
    80204cb8:	fd843783          	ld	a5,-40(s0)
    80204cbc:	00178693          	addi	a3,a5,1
    80204cc0:	fcd43c23          	sd	a3,-40(s0)
    80204cc4:	00074703          	lbu	a4,0(a4)
    80204cc8:	00e78023          	sb	a4,0(a5)
    80204ccc:	fd043783          	ld	a5,-48(s0)
    80204cd0:	0007c783          	lbu	a5,0(a5)
    80204cd4:	ffe1                	bnez	a5,80204cac <app_1_start+0xd24>
    80204cd6:	fd843783          	ld	a5,-40(s0)
    80204cda:	00078023          	sb	zero,0(a5)
    80204cde:	fe843783          	ld	a5,-24(s0)
    80204ce2:	853e                	mv	a0,a5
    80204ce4:	7422                	ld	s0,40(sp)
    80204ce6:	6145                	addi	sp,sp,48
    80204ce8:	8082                	ret
    80204cea:	7179                	addi	sp,sp,-48
    80204cec:	f422                	sd	s0,40(sp)
    80204cee:	1800                	addi	s0,sp,48
    80204cf0:	fca43c23          	sd	a0,-40(s0)
    80204cf4:	fcb43823          	sd	a1,-48(s0)
    80204cf8:	fd843783          	ld	a5,-40(s0)
    80204cfc:	fef43423          	sd	a5,-24(s0)
    80204d00:	a031                	j	80204d0c <app_1_start+0xd84>
    80204d02:	fd843783          	ld	a5,-40(s0)
    80204d06:	0785                	addi	a5,a5,1
    80204d08:	fcf43c23          	sd	a5,-40(s0)
    80204d0c:	fd843783          	ld	a5,-40(s0)
    80204d10:	0007c783          	lbu	a5,0(a5)
    80204d14:	f7fd                	bnez	a5,80204d02 <app_1_start+0xd7a>
    80204d16:	a00d                	j	80204d38 <app_1_start+0xdb0>
    80204d18:	fd043703          	ld	a4,-48(s0)
    80204d1c:	00170793          	addi	a5,a4,1
    80204d20:	fcf43823          	sd	a5,-48(s0)
    80204d24:	fd843783          	ld	a5,-40(s0)
    80204d28:	00178693          	addi	a3,a5,1
    80204d2c:	fcd43c23          	sd	a3,-40(s0)
    80204d30:	00074703          	lbu	a4,0(a4)
    80204d34:	00e78023          	sb	a4,0(a5)
    80204d38:	fd043783          	ld	a5,-48(s0)
    80204d3c:	0007c783          	lbu	a5,0(a5)
    80204d40:	ffe1                	bnez	a5,80204d18 <app_1_start+0xd90>
    80204d42:	fd843783          	ld	a5,-40(s0)
    80204d46:	00078023          	sb	zero,0(a5)
    80204d4a:	fe843783          	ld	a5,-24(s0)
    80204d4e:	853e                	mv	a0,a5
    80204d50:	7422                	ld	s0,40(sp)
    80204d52:	6145                	addi	sp,sp,48
    80204d54:	8082                	ret
    80204d56:	1101                	addi	sp,sp,-32
    80204d58:	ec06                	sd	ra,24(sp)
    80204d5a:	e822                	sd	s0,16(sp)
    80204d5c:	1000                	addi	s0,sp,32
    80204d5e:	00000517          	auipc	a0,0x0
    80204d62:	13a50513          	addi	a0,a0,314 # 80204e98 <app_1_start+0xf10>
    80204d66:	af3ff0ef          	jal	ra,80204858 <app_1_start+0x8d0>
    80204d6a:	afeff0ef          	jal	ra,80204068 <app_1_start+0xe0>
    80204d6e:	00000517          	auipc	a0,0x0
    80204d72:	13a50513          	addi	a0,a0,314 # 80204ea8 <app_1_start+0xf20>
    80204d76:	ae3ff0ef          	jal	ra,80204858 <app_1_start+0x8d0>
    80204d7a:	fe043423          	sd	zero,-24(s0)
    80204d7e:	a835                	j	80204dba <app_1_start+0xe32>
    80204d80:	fe843703          	ld	a4,-24(s0)
    80204d84:	009897b7          	lui	a5,0x989
    80204d88:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80204d8c:	02f777b3          	remu	a5,a4,a5
    80204d90:	e385                	bnez	a5,80204db0 <app_1_start+0xe28>
    80204d92:	fe843703          	ld	a4,-24(s0)
    80204d96:	009897b7          	lui	a5,0x989
    80204d9a:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80204d9e:	02f757b3          	divu	a5,a4,a5
    80204da2:	85be                	mv	a1,a5
    80204da4:	00000517          	auipc	a0,0x0
    80204da8:	11c50513          	addi	a0,a0,284 # 80204ec0 <app_1_start+0xf38>
    80204dac:	aadff0ef          	jal	ra,80204858 <app_1_start+0x8d0>
    80204db0:	fe843783          	ld	a5,-24(s0)
    80204db4:	0785                	addi	a5,a5,1
    80204db6:	fef43423          	sd	a5,-24(s0)
    80204dba:	fe843703          	ld	a4,-24(s0)
    80204dbe:	05f5e7b7          	lui	a5,0x5f5e
    80204dc2:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <n+0x5f5e0df>
    80204dc6:	fae7fde3          	bgeu	a5,a4,80204d80 <app_1_start+0xdf8>
    80204dca:	4781                	li	a5,0
    80204dcc:	853e                	mv	a0,a5
    80204dce:	60e2                	ld	ra,24(sp)
    80204dd0:	6442                	ld	s0,16(sp)
    80204dd2:	6105                	addi	sp,sp,32
    80204dd4:	8082                	ret
    80204dd6:	0000                	unimp
    80204dd8:	6573755b          	0x6573755b
    80204ddc:	5f72                	lw	t5,60(sp)
    80204dde:	696c                	ld	a1,208(a0)
    80204de0:	5d62                	lw	s10,56(sp)
    80204de2:	6920                	ld	s0,80(a0)
    80204de4:	696e                	ld	s2,216(sp)
    80204de6:	2074                	fld	fa3,192(s0)
    80204de8:	000a6b6f          	jal	s6,802aade8 <ebss+0x4fea0>
    80204dec:	0000                	unimp
    80204dee:	0000                	unimp
    80204df0:	6573755b          	0x6573755b
    80204df4:	5f72                	lw	t5,60(sp)
    80204df6:	696c                	ld	a1,208(a0)
    80204df8:	5d62                	lw	s10,56(sp)
    80204dfa:	7320                	ld	s0,96(a4)
    80204dfc:	6365                	lui	t1,0x19
    80204dfe:	20646e6f          	jal	t3,8024b004 <Kernelstack+0x180cc>
    80204e02:	7270                	ld	a2,224(a2)
    80204e04:	6e69                	lui	t3,0x1a
    80204e06:	2074                	fld	fa3,192(s0)
    80204e08:	6574                	ld	a3,200(a0)
    80204e0a:	0a2e7473          	csrrci	s0,0xa2,28
    80204e0e:	0000                	unimp
    80204e10:	f82c                	sd	a1,112(s0)
    80204e12:	ffff                	0xffff
    80204e14:	f8fc                	sd	a5,240(s1)
    80204e16:	ffff                	0xffff
    80204e18:	f8fc                	sd	a5,240(s1)
    80204e1a:	ffff                	0xffff
    80204e1c:	f8fc                	sd	a5,240(s1)
    80204e1e:	ffff                	0xffff
    80204e20:	f8fc                	sd	a5,240(s1)
    80204e22:	ffff                	0xffff
    80204e24:	f8fc                	sd	a5,240(s1)
    80204e26:	ffff                	0xffff
    80204e28:	f8fc                	sd	a5,240(s1)
    80204e2a:	ffff                	0xffff
    80204e2c:	f8fc                	sd	a5,240(s1)
    80204e2e:	ffff                	0xffff
    80204e30:	f8fc                	sd	a5,240(s1)
    80204e32:	ffff                	0xffff
    80204e34:	f8fc                	sd	a5,240(s1)
    80204e36:	ffff                	0xffff
    80204e38:	f8fc                	sd	a5,240(s1)
    80204e3a:	ffff                	0xffff
    80204e3c:	f8aa                	sd	a0,112(sp)
    80204e3e:	ffff                	0xffff
    80204e40:	f7ae                	sd	a1,488(sp)
    80204e42:	ffff                	0xffff
    80204e44:	f8fc                	sd	a5,240(s1)
    80204e46:	ffff                	0xffff
    80204e48:	f8fc                	sd	a5,240(s1)
    80204e4a:	ffff                	0xffff
    80204e4c:	f8fc                	sd	a5,240(s1)
    80204e4e:	ffff                	0xffff
    80204e50:	f8fc                	sd	a5,240(s1)
    80204e52:	ffff                	0xffff
    80204e54:	f8fc                	sd	a5,240(s1)
    80204e56:	ffff                	0xffff
    80204e58:	f8fc                	sd	a5,240(s1)
    80204e5a:	ffff                	0xffff
    80204e5c:	f8fc                	sd	a5,240(s1)
    80204e5e:	ffff                	0xffff
    80204e60:	f7a6                	sd	s1,488(sp)
    80204e62:	ffff                	0xffff
    80204e64:	f8fc                	sd	a5,240(s1)
    80204e66:	ffff                	0xffff
    80204e68:	f8fc                	sd	a5,240(s1)
    80204e6a:	ffff                	0xffff
    80204e6c:	f8fc                	sd	a5,240(s1)
    80204e6e:	ffff                	0xffff
    80204e70:	f8fc                	sd	a5,240(s1)
    80204e72:	ffff                	0xffff
    80204e74:	f8fc                	sd	a5,240(s1)
    80204e76:	ffff                	0xffff
    80204e78:	f8fc                	sd	a5,240(s1)
    80204e7a:	ffff                	0xffff
    80204e7c:	f8cc                	sd	a1,176(s1)
    80204e7e:	ffff                	0xffff
    80204e80:	f8fc                	sd	a5,240(s1)
    80204e82:	ffff                	0xffff
    80204e84:	f7ae                	sd	a1,488(sp)
    80204e86:	ffff                	0xffff
    80204e88:	f8fc                	sd	a5,240(s1)
    80204e8a:	ffff                	0xffff
    80204e8c:	f8fc                	sd	a5,240(s1)
    80204e8e:	ffff                	0xffff
    80204e90:	f82c                	sd	a1,112(s0)
    80204e92:	ffff                	0xffff
    80204e94:	0000                	unimp
    80204e96:	0000                	unimp
    80204e98:	3030                	fld	fa2,96(s0)
    80204e9a:	2074                	fld	fa3,192(s0)
    80204e9c:	6979                	lui	s2,0x1e
    80204e9e:	6c65                	lui	s8,0x19
    80204ea0:	0a64                	addi	s1,sp,284
    80204ea2:	0000                	unimp
    80204ea4:	0000                	unimp
    80204ea6:	0000                	unimp
    80204ea8:	3030                	fld	fa2,96(s0)
    80204eaa:	2074                	fld	fa3,192(s0)
    80204eac:	6979                	lui	s2,0x1e
    80204eae:	6c65                	lui	s8,0x19
    80204eb0:	2064                	fld	fs1,192(s0)
    80204eb2:	63637573          	csrrci	a0,0x636,6
    80204eb6:	7365                	lui	t1,0xffff9
    80204eb8:	00000a73          	0xa73
    80204ebc:	0000                	unimp
    80204ebe:	0000                	unimp
    80204ec0:	3030                	fld	fa2,96(s0)
    80204ec2:	3a74                	fld	fa3,240(a2)
    80204ec4:	2520                	fld	fs0,72(a0)
    80204ec6:	0a64                	addi	s1,sp,284
	...

0000000080204ec9 <app_1_end>:
    80204ec9:	3130                	fld	fa2,96(a0)
    80204ecb:	0074                	addi	a3,sp,12
    80204ecd:	0000                	unimp
	...

0000000080204ed0 <app_2_start>:
    80204ed0:	00011117          	auipc	sp,0x11
    80204ed4:	f4110113          	addi	sp,sp,-191 # 80215e11 <UserStack+0xaed9>
    80204ed8:	0040006f          	j	80204edc <app_2_start+0xc>
    80204edc:	1141                	addi	sp,sp,-16
    80204ede:	e406                	sd	ra,8(sp)
    80204ee0:	e022                	sd	s0,0(sp)
    80204ee2:	0800                	addi	s0,sp,16
    80204ee4:	00001517          	auipc	a0,0x1
    80204ee8:	e3c50513          	addi	a0,a0,-452 # 80205d20 <app_2_start+0xe50>
    80204eec:	0b5000ef          	jal	ra,802057a0 <app_2_start+0x8d0>
    80204ef0:	00001517          	auipc	a0,0x1
    80204ef4:	e4850513          	addi	a0,a0,-440 # 80205d38 <app_2_start+0xe68>
    80204ef8:	0a9000ef          	jal	ra,802057a0 <app_2_start+0x8d0>
    80204efc:	5a3000ef          	jal	ra,80205c9e <app_2_start+0xdce>
    80204f00:	87aa                	mv	a5,a0
    80204f02:	2781                	sext.w	a5,a5
    80204f04:	853e                	mv	a0,a5
    80204f06:	080000ef          	jal	ra,80204f86 <app_2_start+0xb6>
    80204f0a:	0001                	nop
    80204f0c:	60a2                	ld	ra,8(sp)
    80204f0e:	6402                	ld	s0,0(sp)
    80204f10:	0141                	addi	sp,sp,16
    80204f12:	8082                	ret
    80204f14:	7179                	addi	sp,sp,-48
    80204f16:	f422                	sd	s0,40(sp)
    80204f18:	1800                	addi	s0,sp,48
    80204f1a:	fea43423          	sd	a0,-24(s0)
    80204f1e:	feb43023          	sd	a1,-32(s0)
    80204f22:	fcc43c23          	sd	a2,-40(s0)
    80204f26:	fcd43823          	sd	a3,-48(s0)
    80204f2a:	fe043503          	ld	a0,-32(s0)
    80204f2e:	fd843583          	ld	a1,-40(s0)
    80204f32:	fd043603          	ld	a2,-48(s0)
    80204f36:	fe843883          	ld	a7,-24(s0)
    80204f3a:	00000073          	ecall
    80204f3e:	87aa                	mv	a5,a0
    80204f40:	853e                	mv	a0,a5
    80204f42:	7422                	ld	s0,40(sp)
    80204f44:	6145                	addi	sp,sp,48
    80204f46:	8082                	ret
    80204f48:	7179                	addi	sp,sp,-48
    80204f4a:	f406                	sd	ra,40(sp)
    80204f4c:	f022                	sd	s0,32(sp)
    80204f4e:	ec26                	sd	s1,24(sp)
    80204f50:	1800                	addi	s0,sp,48
    80204f52:	fca43c23          	sd	a0,-40(s0)
    80204f56:	fcb43823          	sd	a1,-48(s0)
    80204f5a:	fd043483          	ld	s1,-48(s0)
    80204f5e:	fd043503          	ld	a0,-48(s0)
    80204f62:	175000ef          	jal	ra,802058d6 <app_2_start+0xa06>
    80204f66:	87aa                	mv	a5,a0
    80204f68:	86be                	mv	a3,a5
    80204f6a:	8626                	mv	a2,s1
    80204f6c:	fd843583          	ld	a1,-40(s0)
    80204f70:	04000513          	li	a0,64
    80204f74:	fa1ff0ef          	jal	ra,80204f14 <app_2_start+0x44>
    80204f78:	87aa                	mv	a5,a0
    80204f7a:	853e                	mv	a0,a5
    80204f7c:	70a2                	ld	ra,40(sp)
    80204f7e:	7402                	ld	s0,32(sp)
    80204f80:	64e2                	ld	s1,24(sp)
    80204f82:	6145                	addi	sp,sp,48
    80204f84:	8082                	ret
    80204f86:	1101                	addi	sp,sp,-32
    80204f88:	ec06                	sd	ra,24(sp)
    80204f8a:	e822                	sd	s0,16(sp)
    80204f8c:	1000                	addi	s0,sp,32
    80204f8e:	87aa                	mv	a5,a0
    80204f90:	fef42623          	sw	a5,-20(s0)
    80204f94:	fec42783          	lw	a5,-20(s0)
    80204f98:	4681                	li	a3,0
    80204f9a:	4601                	li	a2,0
    80204f9c:	85be                	mv	a1,a5
    80204f9e:	05d00513          	li	a0,93
    80204fa2:	f73ff0ef          	jal	ra,80204f14 <app_2_start+0x44>
    80204fa6:	0001                	nop
    80204fa8:	60e2                	ld	ra,24(sp)
    80204faa:	6442                	ld	s0,16(sp)
    80204fac:	6105                	addi	sp,sp,32
    80204fae:	8082                	ret
    80204fb0:	1141                	addi	sp,sp,-16
    80204fb2:	e406                	sd	ra,8(sp)
    80204fb4:	e022                	sd	s0,0(sp)
    80204fb6:	0800                	addi	s0,sp,16
    80204fb8:	4681                	li	a3,0
    80204fba:	4601                	li	a2,0
    80204fbc:	4581                	li	a1,0
    80204fbe:	07c00513          	li	a0,124
    80204fc2:	f53ff0ef          	jal	ra,80204f14 <app_2_start+0x44>
    80204fc6:	0001                	nop
    80204fc8:	60a2                	ld	ra,8(sp)
    80204fca:	6402                	ld	s0,0(sp)
    80204fcc:	0141                	addi	sp,sp,16
    80204fce:	8082                	ret
    80204fd0:	1101                	addi	sp,sp,-32
    80204fd2:	ec06                	sd	ra,24(sp)
    80204fd4:	e822                	sd	s0,16(sp)
    80204fd6:	1000                	addi	s0,sp,32
    80204fd8:	fea43423          	sd	a0,-24(s0)
    80204fdc:	fe843583          	ld	a1,-24(s0)
    80204fe0:	4505                	li	a0,1
    80204fe2:	f67ff0ef          	jal	ra,80204f48 <app_2_start+0x78>
    80204fe6:	0001                	nop
    80204fe8:	60e2                	ld	ra,24(sp)
    80204fea:	6442                	ld	s0,16(sp)
    80204fec:	6105                	addi	sp,sp,32
    80204fee:	8082                	ret
    80204ff0:	7179                	addi	sp,sp,-48
    80204ff2:	f422                	sd	s0,40(sp)
    80204ff4:	1800                	addi	s0,sp,48
    80204ff6:	fca43c23          	sd	a0,-40(s0)
    80204ffa:	fe042623          	sw	zero,-20(s0)
    80204ffe:	a031                	j	8020500a <app_2_start+0x13a>
    80205000:	fec42783          	lw	a5,-20(s0)
    80205004:	2785                	addiw	a5,a5,1
    80205006:	fef42623          	sw	a5,-20(s0)
    8020500a:	fec46783          	lwu	a5,-20(s0)
    8020500e:	fd843703          	ld	a4,-40(s0)
    80205012:	97ba                	add	a5,a5,a4
    80205014:	0007c783          	lbu	a5,0(a5)
    80205018:	f7e5                	bnez	a5,80205000 <app_2_start+0x130>
    8020501a:	fec42783          	lw	a5,-20(s0)
    8020501e:	853e                	mv	a0,a5
    80205020:	7422                	ld	s0,40(sp)
    80205022:	6145                	addi	sp,sp,48
    80205024:	8082                	ret
    80205026:	715d                	addi	sp,sp,-80
    80205028:	e4a2                	sd	s0,72(sp)
    8020502a:	0880                	addi	s0,sp,80
    8020502c:	fca43423          	sd	a0,-56(s0)
    80205030:	fae43823          	sd	a4,-80(s0)
    80205034:	873e                	mv	a4,a5
    80205036:	87ae                	mv	a5,a1
    80205038:	fcf42223          	sw	a5,-60(s0)
    8020503c:	87b2                	mv	a5,a2
    8020503e:	fcf42023          	sw	a5,-64(s0)
    80205042:	87b6                	mv	a5,a3
    80205044:	faf42e23          	sw	a5,-68(s0)
    80205048:	87ba                	mv	a5,a4
    8020504a:	faf42c23          	sw	a5,-72(s0)
    8020504e:	fb043783          	ld	a5,-80(s0)
    80205052:	fef43423          	sd	a5,-24(s0)
    80205056:	fe042223          	sw	zero,-28(s0)
    8020505a:	fc442783          	lw	a5,-60(s0)
    8020505e:	0007871b          	sext.w	a4,a5
    80205062:	47c1                	li	a5,16
    80205064:	00e7f463          	bgeu	a5,a4,8020506c <app_2_start+0x19c>
    80205068:	4781                	li	a5,0
    8020506a:	aae9                	j	80205244 <app_2_start+0x374>
    8020506c:	fc843783          	ld	a5,-56(s0)
    80205070:	0007df63          	bgez	a5,8020508e <app_2_start+0x1be>
    80205074:	fbc42783          	lw	a5,-68(s0)
    80205078:	2781                	sext.w	a5,a5
    8020507a:	eb91                	bnez	a5,8020508e <app_2_start+0x1be>
    8020507c:	4785                	li	a5,1
    8020507e:	fef42223          	sw	a5,-28(s0)
    80205082:	fc843783          	ld	a5,-56(s0)
    80205086:	40f007b3          	neg	a5,a5
    8020508a:	fcf43423          	sd	a5,-56(s0)
    8020508e:	fc042e23          	sw	zero,-36(s0)
    80205092:	fbc42783          	lw	a5,-68(s0)
    80205096:	2781                	sext.w	a5,a5
    80205098:	cb91                	beqz	a5,802050ac <app_2_start+0x1dc>
    8020509a:	fc843703          	ld	a4,-56(s0)
    8020509e:	fc446783          	lwu	a5,-60(s0)
    802050a2:	02f777b3          	remu	a5,a4,a5
    802050a6:	fcf42e23          	sw	a5,-36(s0)
    802050aa:	a809                	j	802050bc <app_2_start+0x1ec>
    802050ac:	fc446783          	lwu	a5,-60(s0)
    802050b0:	fc843703          	ld	a4,-56(s0)
    802050b4:	02f767b3          	rem	a5,a4,a5
    802050b8:	fcf42e23          	sw	a5,-36(s0)
    802050bc:	fdc42783          	lw	a5,-36(s0)
    802050c0:	0007871b          	sext.w	a4,a5
    802050c4:	47a5                	li	a5,9
    802050c6:	00e7cb63          	blt	a5,a4,802050dc <app_2_start+0x20c>
    802050ca:	fdc42783          	lw	a5,-36(s0)
    802050ce:	0ff7f793          	andi	a5,a5,255
    802050d2:	0307879b          	addiw	a5,a5,48
    802050d6:	0ff7f713          	andi	a4,a5,255
    802050da:	a025                	j	80205102 <app_2_start+0x232>
    802050dc:	fc042783          	lw	a5,-64(s0)
    802050e0:	2781                	sext.w	a5,a5
    802050e2:	c781                	beqz	a5,802050ea <app_2_start+0x21a>
    802050e4:	04100793          	li	a5,65
    802050e8:	a019                	j	802050ee <app_2_start+0x21e>
    802050ea:	06100793          	li	a5,97
    802050ee:	fdc42703          	lw	a4,-36(s0)
    802050f2:	0ff77713          	andi	a4,a4,255
    802050f6:	9fb9                	addw	a5,a5,a4
    802050f8:	0ff7f793          	andi	a5,a5,255
    802050fc:	37d9                	addiw	a5,a5,-10
    802050fe:	0ff7f713          	andi	a4,a5,255
    80205102:	fe843783          	ld	a5,-24(s0)
    80205106:	00178693          	addi	a3,a5,1
    8020510a:	fed43423          	sd	a3,-24(s0)
    8020510e:	00e78023          	sb	a4,0(a5)
    80205112:	fbc42783          	lw	a5,-68(s0)
    80205116:	2781                	sext.w	a5,a5
    80205118:	cb91                	beqz	a5,8020512c <app_2_start+0x25c>
    8020511a:	fc843703          	ld	a4,-56(s0)
    8020511e:	fc446783          	lwu	a5,-60(s0)
    80205122:	02f757b3          	divu	a5,a4,a5
    80205126:	fcf43423          	sd	a5,-56(s0)
    8020512a:	a809                	j	8020513c <app_2_start+0x26c>
    8020512c:	fc446783          	lwu	a5,-60(s0)
    80205130:	fc843703          	ld	a4,-56(s0)
    80205134:	02f747b3          	div	a5,a4,a5
    80205138:	fcf43423          	sd	a5,-56(s0)
    8020513c:	fc843783          	ld	a5,-56(s0)
    80205140:	f7b9                	bnez	a5,8020508e <app_2_start+0x1be>
    80205142:	fe843703          	ld	a4,-24(s0)
    80205146:	fb043783          	ld	a5,-80(s0)
    8020514a:	40f707b3          	sub	a5,a4,a5
    8020514e:	fef42023          	sw	a5,-32(s0)
    80205152:	a005                	j	80205172 <app_2_start+0x2a2>
    80205154:	fe843783          	ld	a5,-24(s0)
    80205158:	00178713          	addi	a4,a5,1
    8020515c:	fee43423          	sd	a4,-24(s0)
    80205160:	03000713          	li	a4,48
    80205164:	00e78023          	sb	a4,0(a5)
    80205168:	fe042783          	lw	a5,-32(s0)
    8020516c:	2785                	addiw	a5,a5,1
    8020516e:	fef42023          	sw	a5,-32(s0)
    80205172:	fe042703          	lw	a4,-32(s0)
    80205176:	fb842783          	lw	a5,-72(s0)
    8020517a:	2701                	sext.w	a4,a4
    8020517c:	2781                	sext.w	a5,a5
    8020517e:	fcf76be3          	bltu	a4,a5,80205154 <app_2_start+0x284>
    80205182:	fe442783          	lw	a5,-28(s0)
    80205186:	2781                	sext.w	a5,a5
    80205188:	cb99                	beqz	a5,8020519e <app_2_start+0x2ce>
    8020518a:	fe843783          	ld	a5,-24(s0)
    8020518e:	00178713          	addi	a4,a5,1
    80205192:	fee43423          	sd	a4,-24(s0)
    80205196:	02d00713          	li	a4,45
    8020519a:	00e78023          	sb	a4,0(a5)
    8020519e:	fe843783          	ld	a5,-24(s0)
    802051a2:	00078023          	sb	zero,0(a5)
    802051a6:	fe843703          	ld	a4,-24(s0)
    802051aa:	fb043783          	ld	a5,-80(s0)
    802051ae:	40f707b3          	sub	a5,a4,a5
    802051b2:	fcf42c23          	sw	a5,-40(s0)
    802051b6:	fe042023          	sw	zero,-32(s0)
    802051ba:	a885                	j	8020522a <app_2_start+0x35a>
    802051bc:	fe046783          	lwu	a5,-32(s0)
    802051c0:	fb043703          	ld	a4,-80(s0)
    802051c4:	97ba                	add	a5,a5,a4
    802051c6:	0007c783          	lbu	a5,0(a5)
    802051ca:	fcf40ba3          	sb	a5,-41(s0)
    802051ce:	fd842703          	lw	a4,-40(s0)
    802051d2:	fe042783          	lw	a5,-32(s0)
    802051d6:	40f707bb          	subw	a5,a4,a5
    802051da:	2781                	sext.w	a5,a5
    802051dc:	37fd                	addiw	a5,a5,-1
    802051de:	2781                	sext.w	a5,a5
    802051e0:	1782                	slli	a5,a5,0x20
    802051e2:	9381                	srli	a5,a5,0x20
    802051e4:	fb043703          	ld	a4,-80(s0)
    802051e8:	973e                	add	a4,a4,a5
    802051ea:	fe046783          	lwu	a5,-32(s0)
    802051ee:	fb043683          	ld	a3,-80(s0)
    802051f2:	97b6                	add	a5,a5,a3
    802051f4:	00074703          	lbu	a4,0(a4)
    802051f8:	00e78023          	sb	a4,0(a5)
    802051fc:	fd842703          	lw	a4,-40(s0)
    80205200:	fe042783          	lw	a5,-32(s0)
    80205204:	40f707bb          	subw	a5,a4,a5
    80205208:	2781                	sext.w	a5,a5
    8020520a:	37fd                	addiw	a5,a5,-1
    8020520c:	2781                	sext.w	a5,a5
    8020520e:	1782                	slli	a5,a5,0x20
    80205210:	9381                	srli	a5,a5,0x20
    80205212:	fb043703          	ld	a4,-80(s0)
    80205216:	97ba                	add	a5,a5,a4
    80205218:	fd744703          	lbu	a4,-41(s0)
    8020521c:	00e78023          	sb	a4,0(a5)
    80205220:	fe042783          	lw	a5,-32(s0)
    80205224:	2785                	addiw	a5,a5,1
    80205226:	fef42023          	sw	a5,-32(s0)
    8020522a:	fd842783          	lw	a5,-40(s0)
    8020522e:	0017d79b          	srliw	a5,a5,0x1
    80205232:	0007871b          	sext.w	a4,a5
    80205236:	fe042783          	lw	a5,-32(s0)
    8020523a:	2781                	sext.w	a5,a5
    8020523c:	f8e7e0e3          	bltu	a5,a4,802051bc <app_2_start+0x2ec>
    80205240:	fd842783          	lw	a5,-40(s0)
    80205244:	853e                	mv	a0,a5
    80205246:	6426                	ld	s0,72(sp)
    80205248:	6161                	addi	sp,sp,80
    8020524a:	8082                	ret
    8020524c:	1101                	addi	sp,sp,-32
    8020524e:	ec22                	sd	s0,24(sp)
    80205250:	1000                	addi	s0,sp,32
    80205252:	87aa                	mv	a5,a0
    80205254:	feb43023          	sd	a1,-32(s0)
    80205258:	fef42623          	sw	a5,-20(s0)
    8020525c:	fe043783          	ld	a5,-32(s0)
    80205260:	6798                	ld	a4,8(a5)
    80205262:	fe043783          	ld	a5,-32(s0)
    80205266:	639c                	ld	a5,0(a5)
    80205268:	40f707b3          	sub	a5,a4,a5
    8020526c:	2781                	sext.w	a5,a5
    8020526e:	2785                	addiw	a5,a5,1
    80205270:	0007871b          	sext.w	a4,a5
    80205274:	fe043783          	ld	a5,-32(s0)
    80205278:	4b9c                	lw	a5,16(a5)
    8020527a:	00f76463          	bltu	a4,a5,80205282 <app_2_start+0x3b2>
    8020527e:	4781                	li	a5,0
    80205280:	a02d                	j	802052aa <app_2_start+0x3da>
    80205282:	fe043783          	ld	a5,-32(s0)
    80205286:	679c                	ld	a5,8(a5)
    80205288:	00178693          	addi	a3,a5,1
    8020528c:	fe043703          	ld	a4,-32(s0)
    80205290:	e714                	sd	a3,8(a4)
    80205292:	fec42703          	lw	a4,-20(s0)
    80205296:	0ff77713          	andi	a4,a4,255
    8020529a:	00e78023          	sb	a4,0(a5)
    8020529e:	fe043783          	ld	a5,-32(s0)
    802052a2:	679c                	ld	a5,8(a5)
    802052a4:	00078023          	sb	zero,0(a5)
    802052a8:	4785                	li	a5,1
    802052aa:	853e                	mv	a0,a5
    802052ac:	6462                	ld	s0,24(sp)
    802052ae:	6105                	addi	sp,sp,32
    802052b0:	8082                	ret
    802052b2:	7139                	addi	sp,sp,-64
    802052b4:	fc22                	sd	s0,56(sp)
    802052b6:	0080                	addi	s0,sp,64
    802052b8:	fca43c23          	sd	a0,-40(s0)
    802052bc:	87ae                	mv	a5,a1
    802052be:	fcc43423          	sd	a2,-56(s0)
    802052c2:	fcf42a23          	sw	a5,-44(s0)
    802052c6:	fc843783          	ld	a5,-56(s0)
    802052ca:	4b9c                	lw	a5,16(a5)
    802052cc:	02079713          	slli	a4,a5,0x20
    802052d0:	9301                	srli	a4,a4,0x20
    802052d2:	fc843783          	ld	a5,-56(s0)
    802052d6:	6794                	ld	a3,8(a5)
    802052d8:	fc843783          	ld	a5,-56(s0)
    802052dc:	639c                	ld	a5,0(a5)
    802052de:	40f687b3          	sub	a5,a3,a5
    802052e2:	8f1d                	sub	a4,a4,a5
    802052e4:	fd446783          	lwu	a5,-44(s0)
    802052e8:	02e7c463          	blt	a5,a4,80205310 <app_2_start+0x440>
    802052ec:	fc843783          	ld	a5,-56(s0)
    802052f0:	4b98                	lw	a4,16(a5)
    802052f2:	fc843783          	ld	a5,-56(s0)
    802052f6:	6794                	ld	a3,8(a5)
    802052f8:	fc843783          	ld	a5,-56(s0)
    802052fc:	639c                	ld	a5,0(a5)
    802052fe:	40f687b3          	sub	a5,a3,a5
    80205302:	2781                	sext.w	a5,a5
    80205304:	40f707bb          	subw	a5,a4,a5
    80205308:	2781                	sext.w	a5,a5
    8020530a:	37fd                	addiw	a5,a5,-1
    8020530c:	fcf42a23          	sw	a5,-44(s0)
    80205310:	fe042623          	sw	zero,-20(s0)
    80205314:	a03d                	j	80205342 <app_2_start+0x472>
    80205316:	fec46783          	lwu	a5,-20(s0)
    8020531a:	fd843703          	ld	a4,-40(s0)
    8020531e:	973e                	add	a4,a4,a5
    80205320:	fc843783          	ld	a5,-56(s0)
    80205324:	679c                	ld	a5,8(a5)
    80205326:	00178613          	addi	a2,a5,1
    8020532a:	fc843683          	ld	a3,-56(s0)
    8020532e:	e690                	sd	a2,8(a3)
    80205330:	00074703          	lbu	a4,0(a4)
    80205334:	00e78023          	sb	a4,0(a5)
    80205338:	fec42783          	lw	a5,-20(s0)
    8020533c:	2785                	addiw	a5,a5,1
    8020533e:	fef42623          	sw	a5,-20(s0)
    80205342:	fec42703          	lw	a4,-20(s0)
    80205346:	fd442783          	lw	a5,-44(s0)
    8020534a:	2701                	sext.w	a4,a4
    8020534c:	2781                	sext.w	a5,a5
    8020534e:	fcf764e3          	bltu	a4,a5,80205316 <app_2_start+0x446>
    80205352:	fc843783          	ld	a5,-56(s0)
    80205356:	679c                	ld	a5,8(a5)
    80205358:	00078023          	sb	zero,0(a5)
    8020535c:	fd442783          	lw	a5,-44(s0)
    80205360:	853e                	mv	a0,a5
    80205362:	7462                	ld	s0,56(sp)
    80205364:	6121                	addi	sp,sp,64
    80205366:	8082                	ret
    80205368:	7119                	addi	sp,sp,-128
    8020536a:	fc86                	sd	ra,120(sp)
    8020536c:	f8a2                	sd	s0,112(sp)
    8020536e:	0100                	addi	s0,sp,128
    80205370:	f8a43c23          	sd	a0,-104(s0)
    80205374:	87ae                	mv	a5,a1
    80205376:	f8c43423          	sd	a2,-120(s0)
    8020537a:	f8d43023          	sd	a3,-128(s0)
    8020537e:	f8f42a23          	sw	a5,-108(s0)
    80205382:	f9843783          	ld	a5,-104(s0)
    80205386:	fcf43023          	sd	a5,-64(s0)
    8020538a:	f9843783          	ld	a5,-104(s0)
    8020538e:	fcf43423          	sd	a5,-56(s0)
    80205392:	f9442783          	lw	a5,-108(s0)
    80205396:	fcf42823          	sw	a5,-48(s0)
    8020539a:	a4f9                	j	80205668 <app_2_start+0x798>
    8020539c:	fc843703          	ld	a4,-56(s0)
    802053a0:	fc043783          	ld	a5,-64(s0)
    802053a4:	40f707b3          	sub	a5,a4,a5
    802053a8:	2781                	sext.w	a5,a5
    802053aa:	2785                	addiw	a5,a5,1
    802053ac:	0007871b          	sext.w	a4,a5
    802053b0:	fd042783          	lw	a5,-48(s0)
    802053b4:	2cf77b63          	bgeu	a4,a5,8020568a <app_2_start+0x7ba>
    802053b8:	fef44783          	lbu	a5,-17(s0)
    802053bc:	0ff7f713          	andi	a4,a5,255
    802053c0:	02500793          	li	a5,37
    802053c4:	00f70c63          	beq	a4,a5,802053dc <app_2_start+0x50c>
    802053c8:	fef44783          	lbu	a5,-17(s0)
    802053cc:	2781                	sext.w	a5,a5
    802053ce:	fc040713          	addi	a4,s0,-64
    802053d2:	85ba                	mv	a1,a4
    802053d4:	853e                	mv	a0,a5
    802053d6:	e77ff0ef          	jal	ra,8020524c <app_2_start+0x37c>
    802053da:	a479                	j	80205668 <app_2_start+0x798>
    802053dc:	fe040723          	sb	zero,-18(s0)
    802053e0:	fe042423          	sw	zero,-24(s0)
    802053e4:	f8843783          	ld	a5,-120(s0)
    802053e8:	00178713          	addi	a4,a5,1
    802053ec:	f8e43423          	sd	a4,-120(s0)
    802053f0:	0007c783          	lbu	a5,0(a5)
    802053f4:	fef407a3          	sb	a5,-17(s0)
    802053f8:	fef44783          	lbu	a5,-17(s0)
    802053fc:	0ff7f713          	andi	a4,a5,255
    80205400:	03000793          	li	a5,48
    80205404:	06f71b63          	bne	a4,a5,8020547a <app_2_start+0x5aa>
    80205408:	a891                	j	8020545c <app_2_start+0x58c>
    8020540a:	fef44783          	lbu	a5,-17(s0)
    8020540e:	0ff7f793          	andi	a5,a5,255
    80205412:	26078e63          	beqz	a5,8020568e <app_2_start+0x7be>
    80205416:	fef44783          	lbu	a5,-17(s0)
    8020541a:	0ff7f713          	andi	a4,a5,255
    8020541e:	02f00793          	li	a5,47
    80205422:	04e7fc63          	bgeu	a5,a4,8020547a <app_2_start+0x5aa>
    80205426:	fef44783          	lbu	a5,-17(s0)
    8020542a:	0ff7f713          	andi	a4,a5,255
    8020542e:	03900793          	li	a5,57
    80205432:	04e7e463          	bltu	a5,a4,8020547a <app_2_start+0x5aa>
    80205436:	fee44703          	lbu	a4,-18(s0)
    8020543a:	87ba                	mv	a5,a4
    8020543c:	0027979b          	slliw	a5,a5,0x2
    80205440:	9fb9                	addw	a5,a5,a4
    80205442:	0017979b          	slliw	a5,a5,0x1
    80205446:	0ff7f793          	andi	a5,a5,255
    8020544a:	fef44703          	lbu	a4,-17(s0)
    8020544e:	9fb9                	addw	a5,a5,a4
    80205450:	0ff7f793          	andi	a5,a5,255
    80205454:	fd07879b          	addiw	a5,a5,-48
    80205458:	fef40723          	sb	a5,-18(s0)
    8020545c:	f8843783          	ld	a5,-120(s0)
    80205460:	00178713          	addi	a4,a5,1
    80205464:	f8e43423          	sd	a4,-120(s0)
    80205468:	0007c783          	lbu	a5,0(a5)
    8020546c:	fef407a3          	sb	a5,-17(s0)
    80205470:	fef44783          	lbu	a5,-17(s0)
    80205474:	0ff7f793          	andi	a5,a5,255
    80205478:	fbc9                	bnez	a5,8020540a <app_2_start+0x53a>
    8020547a:	fef44783          	lbu	a5,-17(s0)
    8020547e:	0ff7f713          	andi	a4,a5,255
    80205482:	06c00793          	li	a5,108
    80205486:	00f71f63          	bne	a4,a5,802054a4 <app_2_start+0x5d4>
    8020548a:	4785                	li	a5,1
    8020548c:	fef42423          	sw	a5,-24(s0)
    80205490:	f8843783          	ld	a5,-120(s0)
    80205494:	00178713          	addi	a4,a5,1
    80205498:	f8e43423          	sd	a4,-120(s0)
    8020549c:	0007c783          	lbu	a5,0(a5)
    802054a0:	fef407a3          	sb	a5,-17(s0)
    802054a4:	fef44783          	lbu	a5,-17(s0)
    802054a8:	2781                	sext.w	a5,a5
    802054aa:	1e078463          	beqz	a5,80205692 <app_2_start+0x7c2>
    802054ae:	873e                	mv	a4,a5
    802054b0:	1a074263          	bltz	a4,80205654 <app_2_start+0x784>
    802054b4:	86be                	mv	a3,a5
    802054b6:	07800713          	li	a4,120
    802054ba:	18d74d63          	blt	a4,a3,80205654 <app_2_start+0x784>
    802054be:	86be                	mv	a3,a5
    802054c0:	05800713          	li	a4,88
    802054c4:	18e6c863          	blt	a3,a4,80205654 <app_2_start+0x784>
    802054c8:	fa87869b          	addiw	a3,a5,-88
    802054cc:	0006871b          	sext.w	a4,a3
    802054d0:	02000793          	li	a5,32
    802054d4:	18e7e063          	bltu	a5,a4,80205654 <app_2_start+0x784>
    802054d8:	02069793          	slli	a5,a3,0x20
    802054dc:	9381                	srli	a5,a5,0x20
    802054de:	00279713          	slli	a4,a5,0x2
    802054e2:	00001797          	auipc	a5,0x1
    802054e6:	87678793          	addi	a5,a5,-1930 # 80205d58 <app_2_start+0xe88>
    802054ea:	97ba                	add	a5,a5,a4
    802054ec:	439c                	lw	a5,0(a5)
    802054ee:	0007871b          	sext.w	a4,a5
    802054f2:	00001797          	auipc	a5,0x1
    802054f6:	86678793          	addi	a5,a5,-1946 # 80205d58 <app_2_start+0xe88>
    802054fa:	97ba                	add	a5,a5,a4
    802054fc:	8782                	jr	a5
    802054fe:	4785                	li	a5,1
    80205500:	fef42423          	sw	a5,-24(s0)
    80205504:	a295                	j	80205668 <app_2_start+0x798>
    80205506:	fe842783          	lw	a5,-24(s0)
    8020550a:	2781                	sext.w	a5,a5
    8020550c:	ef81                	bnez	a5,80205524 <app_2_start+0x654>
    8020550e:	f8043783          	ld	a5,-128(s0)
    80205512:	00878713          	addi	a4,a5,8
    80205516:	f8e43023          	sd	a4,-128(s0)
    8020551a:	439c                	lw	a5,0(a5)
    8020551c:	02079513          	slli	a0,a5,0x20
    80205520:	9101                	srli	a0,a0,0x20
    80205522:	a809                	j	80205534 <app_2_start+0x664>
    80205524:	f8043783          	ld	a5,-128(s0)
    80205528:	00878713          	addi	a4,a5,8
    8020552c:	f8e43023          	sd	a4,-128(s0)
    80205530:	639c                	ld	a5,0(a5)
    80205532:	853e                	mv	a0,a5
    80205534:	fef44783          	lbu	a5,-17(s0)
    80205538:	0007871b          	sext.w	a4,a5
    8020553c:	07500793          	li	a5,117
    80205540:	40f707b3          	sub	a5,a4,a5
    80205544:	0017b793          	seqz	a5,a5
    80205548:	0ff7f793          	andi	a5,a5,255
    8020554c:	0007869b          	sext.w	a3,a5
    80205550:	fee44783          	lbu	a5,-18(s0)
    80205554:	2781                	sext.w	a5,a5
    80205556:	fa840713          	addi	a4,s0,-88
    8020555a:	4601                	li	a2,0
    8020555c:	45a9                	li	a1,10
    8020555e:	ac9ff0ef          	jal	ra,80205026 <app_2_start+0x156>
    80205562:	87aa                	mv	a5,a0
    80205564:	fcf42e23          	sw	a5,-36(s0)
    80205568:	fc040693          	addi	a3,s0,-64
    8020556c:	fdc42703          	lw	a4,-36(s0)
    80205570:	fa840793          	addi	a5,s0,-88
    80205574:	8636                	mv	a2,a3
    80205576:	85ba                	mv	a1,a4
    80205578:	853e                	mv	a0,a5
    8020557a:	d39ff0ef          	jal	ra,802052b2 <app_2_start+0x3e2>
    8020557e:	fe042423          	sw	zero,-24(s0)
    80205582:	a0dd                	j	80205668 <app_2_start+0x798>
    80205584:	fe842783          	lw	a5,-24(s0)
    80205588:	2781                	sext.w	a5,a5
    8020558a:	ef81                	bnez	a5,802055a2 <app_2_start+0x6d2>
    8020558c:	f8043783          	ld	a5,-128(s0)
    80205590:	00878713          	addi	a4,a5,8
    80205594:	f8e43023          	sd	a4,-128(s0)
    80205598:	439c                	lw	a5,0(a5)
    8020559a:	02079513          	slli	a0,a5,0x20
    8020559e:	9101                	srli	a0,a0,0x20
    802055a0:	a809                	j	802055b2 <app_2_start+0x6e2>
    802055a2:	f8043783          	ld	a5,-128(s0)
    802055a6:	00878713          	addi	a4,a5,8
    802055aa:	f8e43023          	sd	a4,-128(s0)
    802055ae:	639c                	ld	a5,0(a5)
    802055b0:	853e                	mv	a0,a5
    802055b2:	fef44783          	lbu	a5,-17(s0)
    802055b6:	0007871b          	sext.w	a4,a5
    802055ba:	05800793          	li	a5,88
    802055be:	40f707b3          	sub	a5,a4,a5
    802055c2:	0017b793          	seqz	a5,a5
    802055c6:	0ff7f793          	andi	a5,a5,255
    802055ca:	0007861b          	sext.w	a2,a5
    802055ce:	fee44783          	lbu	a5,-18(s0)
    802055d2:	2781                	sext.w	a5,a5
    802055d4:	fa840713          	addi	a4,s0,-88
    802055d8:	4685                	li	a3,1
    802055da:	45c1                	li	a1,16
    802055dc:	a4bff0ef          	jal	ra,80205026 <app_2_start+0x156>
    802055e0:	87aa                	mv	a5,a0
    802055e2:	fcf42e23          	sw	a5,-36(s0)
    802055e6:	fc040693          	addi	a3,s0,-64
    802055ea:	fdc42703          	lw	a4,-36(s0)
    802055ee:	fa840793          	addi	a5,s0,-88
    802055f2:	8636                	mv	a2,a3
    802055f4:	85ba                	mv	a1,a4
    802055f6:	853e                	mv	a0,a5
    802055f8:	cbbff0ef          	jal	ra,802052b2 <app_2_start+0x3e2>
    802055fc:	fe042423          	sw	zero,-24(s0)
    80205600:	a0a5                	j	80205668 <app_2_start+0x798>
    80205602:	f8043783          	ld	a5,-128(s0)
    80205606:	00878713          	addi	a4,a5,8
    8020560a:	f8e43023          	sd	a4,-128(s0)
    8020560e:	439c                	lw	a5,0(a5)
    80205610:	0ff7f793          	andi	a5,a5,255
    80205614:	2781                	sext.w	a5,a5
    80205616:	fc040713          	addi	a4,s0,-64
    8020561a:	85ba                	mv	a1,a4
    8020561c:	853e                	mv	a0,a5
    8020561e:	c2fff0ef          	jal	ra,8020524c <app_2_start+0x37c>
    80205622:	a099                	j	80205668 <app_2_start+0x798>
    80205624:	f8043783          	ld	a5,-128(s0)
    80205628:	00878713          	addi	a4,a5,8
    8020562c:	f8e43023          	sd	a4,-128(s0)
    80205630:	639c                	ld	a5,0(a5)
    80205632:	fef43023          	sd	a5,-32(s0)
    80205636:	fe043503          	ld	a0,-32(s0)
    8020563a:	9b7ff0ef          	jal	ra,80204ff0 <app_2_start+0x120>
    8020563e:	87aa                	mv	a5,a0
    80205640:	2781                	sext.w	a5,a5
    80205642:	fc040713          	addi	a4,s0,-64
    80205646:	863a                	mv	a2,a4
    80205648:	85be                	mv	a1,a5
    8020564a:	fe043503          	ld	a0,-32(s0)
    8020564e:	c65ff0ef          	jal	ra,802052b2 <app_2_start+0x3e2>
    80205652:	a819                	j	80205668 <app_2_start+0x798>
    80205654:	fef44783          	lbu	a5,-17(s0)
    80205658:	2781                	sext.w	a5,a5
    8020565a:	fc040713          	addi	a4,s0,-64
    8020565e:	85ba                	mv	a1,a4
    80205660:	853e                	mv	a0,a5
    80205662:	bebff0ef          	jal	ra,8020524c <app_2_start+0x37c>
    80205666:	0001                	nop
    80205668:	f8843783          	ld	a5,-120(s0)
    8020566c:	00178713          	addi	a4,a5,1
    80205670:	f8e43423          	sd	a4,-120(s0)
    80205674:	0007c783          	lbu	a5,0(a5)
    80205678:	fef407a3          	sb	a5,-17(s0)
    8020567c:	fef44783          	lbu	a5,-17(s0)
    80205680:	0ff7f793          	andi	a5,a5,255
    80205684:	d0079ce3          	bnez	a5,8020539c <app_2_start+0x4cc>
    80205688:	a031                	j	80205694 <app_2_start+0x7c4>
    8020568a:	0001                	nop
    8020568c:	a021                	j	80205694 <app_2_start+0x7c4>
    8020568e:	0001                	nop
    80205690:	a011                	j	80205694 <app_2_start+0x7c4>
    80205692:	0001                	nop
    80205694:	fc843703          	ld	a4,-56(s0)
    80205698:	fc043783          	ld	a5,-64(s0)
    8020569c:	40f707b3          	sub	a5,a4,a5
    802056a0:	2781                	sext.w	a5,a5
    802056a2:	853e                	mv	a0,a5
    802056a4:	70e6                	ld	ra,120(sp)
    802056a6:	7446                	ld	s0,112(sp)
    802056a8:	6109                	addi	sp,sp,128
    802056aa:	8082                	ret
    802056ac:	7129                	addi	sp,sp,-320
    802056ae:	fe06                	sd	ra,312(sp)
    802056b0:	fa22                	sd	s0,304(sp)
    802056b2:	0280                	addi	s0,sp,320
    802056b4:	eca43c23          	sd	a0,-296(s0)
    802056b8:	ecb43823          	sd	a1,-304(s0)
    802056bc:	ecc43423          	sd	a2,-312(s0)
    802056c0:	ed043783          	ld	a5,-304(s0)
    802056c4:	fef43023          	sd	a5,-32(s0)
    802056c8:	fe043703          	ld	a4,-32(s0)
    802056cc:	ee040793          	addi	a5,s0,-288
    802056d0:	86ba                	mv	a3,a4
    802056d2:	ed843603          	ld	a2,-296(s0)
    802056d6:	10000593          	li	a1,256
    802056da:	853e                	mv	a0,a5
    802056dc:	c8dff0ef          	jal	ra,80205368 <app_2_start+0x498>
    802056e0:	87aa                	mv	a5,a0
    802056e2:	fef42623          	sw	a5,-20(s0)
    802056e6:	fec42783          	lw	a5,-20(s0)
    802056ea:	ff040713          	addi	a4,s0,-16
    802056ee:	97ba                	add	a5,a5,a4
    802056f0:	ee078823          	sb	zero,-272(a5)
    802056f4:	ee040793          	addi	a5,s0,-288
    802056f8:	ec843703          	ld	a4,-312(s0)
    802056fc:	853e                	mv	a0,a5
    802056fe:	9702                	jalr	a4
    80205700:	fec42783          	lw	a5,-20(s0)
    80205704:	853e                	mv	a0,a5
    80205706:	70f2                	ld	ra,312(sp)
    80205708:	7452                	ld	s0,304(sp)
    8020570a:	6131                	addi	sp,sp,320
    8020570c:	8082                	ret
    8020570e:	7129                	addi	sp,sp,-320
    80205710:	fe06                	sd	ra,312(sp)
    80205712:	fa22                	sd	s0,304(sp)
    80205714:	0280                	addi	s0,sp,320
    80205716:	eca43c23          	sd	a0,-296(s0)
    8020571a:	ecb43823          	sd	a1,-304(s0)
    8020571e:	ecc43423          	sd	a2,-312(s0)
    80205722:	ed043783          	ld	a5,-304(s0)
    80205726:	fef43023          	sd	a5,-32(s0)
    8020572a:	fe043703          	ld	a4,-32(s0)
    8020572e:	ee040793          	addi	a5,s0,-288
    80205732:	86ba                	mv	a3,a4
    80205734:	ed843603          	ld	a2,-296(s0)
    80205738:	10000593          	li	a1,256
    8020573c:	853e                	mv	a0,a5
    8020573e:	c2bff0ef          	jal	ra,80205368 <app_2_start+0x498>
    80205742:	87aa                	mv	a5,a0
    80205744:	fef42623          	sw	a5,-20(s0)
    80205748:	fec42783          	lw	a5,-20(s0)
    8020574c:	ff040713          	addi	a4,s0,-16
    80205750:	97ba                	add	a5,a5,a4
    80205752:	ee078823          	sb	zero,-272(a5)
    80205756:	ee040793          	addi	a5,s0,-288
    8020575a:	ec843703          	ld	a4,-312(s0)
    8020575e:	853e                	mv	a0,a5
    80205760:	9702                	jalr	a4
    80205762:	fec42783          	lw	a5,-20(s0)
    80205766:	853e                	mv	a0,a5
    80205768:	70f2                	ld	ra,312(sp)
    8020576a:	7452                	ld	s0,304(sp)
    8020576c:	6131                	addi	sp,sp,320
    8020576e:	8082                	ret
    80205770:	1101                	addi	sp,sp,-32
    80205772:	ec06                	sd	ra,24(sp)
    80205774:	e822                	sd	s0,16(sp)
    80205776:	1000                	addi	s0,sp,32
    80205778:	fea43423          	sd	a0,-24(s0)
    8020577c:	feb43023          	sd	a1,-32(s0)
    80205780:	00000617          	auipc	a2,0x0
    80205784:	85060613          	addi	a2,a2,-1968 # 80204fd0 <app_2_start+0x100>
    80205788:	fe043583          	ld	a1,-32(s0)
    8020578c:	fe843503          	ld	a0,-24(s0)
    80205790:	f1dff0ef          	jal	ra,802056ac <app_2_start+0x7dc>
    80205794:	87aa                	mv	a5,a0
    80205796:	853e                	mv	a0,a5
    80205798:	60e2                	ld	ra,24(sp)
    8020579a:	6442                	ld	s0,16(sp)
    8020579c:	6105                	addi	sp,sp,32
    8020579e:	8082                	ret
    802057a0:	7159                	addi	sp,sp,-112
    802057a2:	f406                	sd	ra,40(sp)
    802057a4:	f022                	sd	s0,32(sp)
    802057a6:	1800                	addi	s0,sp,48
    802057a8:	fca43c23          	sd	a0,-40(s0)
    802057ac:	e40c                	sd	a1,8(s0)
    802057ae:	e810                	sd	a2,16(s0)
    802057b0:	ec14                	sd	a3,24(s0)
    802057b2:	f018                	sd	a4,32(s0)
    802057b4:	f41c                	sd	a5,40(s0)
    802057b6:	03043823          	sd	a6,48(s0)
    802057ba:	03143c23          	sd	a7,56(s0)
    802057be:	fe042623          	sw	zero,-20(s0)
    802057c2:	04040793          	addi	a5,s0,64
    802057c6:	fcf43823          	sd	a5,-48(s0)
    802057ca:	fd043783          	ld	a5,-48(s0)
    802057ce:	fc878793          	addi	a5,a5,-56
    802057d2:	fef43023          	sd	a5,-32(s0)
    802057d6:	fe043783          	ld	a5,-32(s0)
    802057da:	85be                	mv	a1,a5
    802057dc:	fd843503          	ld	a0,-40(s0)
    802057e0:	f91ff0ef          	jal	ra,80205770 <app_2_start+0x8a0>
    802057e4:	87aa                	mv	a5,a0
    802057e6:	fef42623          	sw	a5,-20(s0)
    802057ea:	fec42783          	lw	a5,-20(s0)
    802057ee:	853e                	mv	a0,a5
    802057f0:	70a2                	ld	ra,40(sp)
    802057f2:	7402                	ld	s0,32(sp)
    802057f4:	6165                	addi	sp,sp,112
    802057f6:	8082                	ret
    802057f8:	7129                	addi	sp,sp,-320
    802057fa:	fe06                	sd	ra,312(sp)
    802057fc:	fa22                	sd	s0,304(sp)
    802057fe:	0280                	addi	s0,sp,320
    80205800:	eca43c23          	sd	a0,-296(s0)
    80205804:	ecb43823          	sd	a1,-304(s0)
    80205808:	ecc43423          	sd	a2,-312(s0)
    8020580c:	ed043783          	ld	a5,-304(s0)
    80205810:	fef43023          	sd	a5,-32(s0)
    80205814:	fe043703          	ld	a4,-32(s0)
    80205818:	ee040793          	addi	a5,s0,-288
    8020581c:	86ba                	mv	a3,a4
    8020581e:	ed843603          	ld	a2,-296(s0)
    80205822:	10000593          	li	a1,256
    80205826:	853e                	mv	a0,a5
    80205828:	b41ff0ef          	jal	ra,80205368 <app_2_start+0x498>
    8020582c:	87aa                	mv	a5,a0
    8020582e:	fef42623          	sw	a5,-20(s0)
    80205832:	fec42783          	lw	a5,-20(s0)
    80205836:	ff040713          	addi	a4,s0,-16
    8020583a:	97ba                	add	a5,a5,a4
    8020583c:	ee078823          	sb	zero,-272(a5)
    80205840:	fec42783          	lw	a5,-20(s0)
    80205844:	853e                	mv	a0,a5
    80205846:	70f2                	ld	ra,312(sp)
    80205848:	7452                	ld	s0,304(sp)
    8020584a:	6131                	addi	sp,sp,320
    8020584c:	8082                	ret
    8020584e:	1101                	addi	sp,sp,-32
    80205850:	ec06                	sd	ra,24(sp)
    80205852:	e822                	sd	s0,16(sp)
    80205854:	1000                	addi	s0,sp,32
    80205856:	fea43423          	sd	a0,-24(s0)
    8020585a:	feb43023          	sd	a1,-32(s0)
    8020585e:	fffff617          	auipc	a2,0xfffff
    80205862:	77260613          	addi	a2,a2,1906 # 80204fd0 <app_2_start+0x100>
    80205866:	fe043583          	ld	a1,-32(s0)
    8020586a:	fe843503          	ld	a0,-24(s0)
    8020586e:	f8bff0ef          	jal	ra,802057f8 <app_2_start+0x928>
    80205872:	87aa                	mv	a5,a0
    80205874:	853e                	mv	a0,a5
    80205876:	60e2                	ld	ra,24(sp)
    80205878:	6442                	ld	s0,16(sp)
    8020587a:	6105                	addi	sp,sp,32
    8020587c:	8082                	ret
    8020587e:	7159                	addi	sp,sp,-112
    80205880:	f406                	sd	ra,40(sp)
    80205882:	f022                	sd	s0,32(sp)
    80205884:	1800                	addi	s0,sp,48
    80205886:	fca43c23          	sd	a0,-40(s0)
    8020588a:	e40c                	sd	a1,8(s0)
    8020588c:	e810                	sd	a2,16(s0)
    8020588e:	ec14                	sd	a3,24(s0)
    80205890:	f018                	sd	a4,32(s0)
    80205892:	f41c                	sd	a5,40(s0)
    80205894:	03043823          	sd	a6,48(s0)
    80205898:	03143c23          	sd	a7,56(s0)
    8020589c:	fe042623          	sw	zero,-20(s0)
    802058a0:	04040793          	addi	a5,s0,64
    802058a4:	fcf43823          	sd	a5,-48(s0)
    802058a8:	fd043783          	ld	a5,-48(s0)
    802058ac:	fc878793          	addi	a5,a5,-56
    802058b0:	fef43023          	sd	a5,-32(s0)
    802058b4:	fe043783          	ld	a5,-32(s0)
    802058b8:	85be                	mv	a1,a5
    802058ba:	fd843503          	ld	a0,-40(s0)
    802058be:	f91ff0ef          	jal	ra,8020584e <app_2_start+0x97e>
    802058c2:	87aa                	mv	a5,a0
    802058c4:	fef42623          	sw	a5,-20(s0)
    802058c8:	fec42783          	lw	a5,-20(s0)
    802058cc:	853e                	mv	a0,a5
    802058ce:	70a2                	ld	ra,40(sp)
    802058d0:	7402                	ld	s0,32(sp)
    802058d2:	6165                	addi	sp,sp,112
    802058d4:	8082                	ret
    802058d6:	7179                	addi	sp,sp,-48
    802058d8:	f422                	sd	s0,40(sp)
    802058da:	1800                	addi	s0,sp,48
    802058dc:	fca43c23          	sd	a0,-40(s0)
    802058e0:	fe042623          	sw	zero,-20(s0)
    802058e4:	a031                	j	802058f0 <app_2_start+0xa20>
    802058e6:	fec42783          	lw	a5,-20(s0)
    802058ea:	2785                	addiw	a5,a5,1
    802058ec:	fef42623          	sw	a5,-20(s0)
    802058f0:	fec42783          	lw	a5,-20(s0)
    802058f4:	fd843703          	ld	a4,-40(s0)
    802058f8:	97ba                	add	a5,a5,a4
    802058fa:	0007c783          	lbu	a5,0(a5)
    802058fe:	f7e5                	bnez	a5,802058e6 <app_2_start+0xa16>
    80205900:	fec42783          	lw	a5,-20(s0)
    80205904:	853e                	mv	a0,a5
    80205906:	7422                	ld	s0,40(sp)
    80205908:	6145                	addi	sp,sp,48
    8020590a:	8082                	ret
    8020590c:	7179                	addi	sp,sp,-48
    8020590e:	f422                	sd	s0,40(sp)
    80205910:	1800                	addi	s0,sp,48
    80205912:	fea43423          	sd	a0,-24(s0)
    80205916:	feb43023          	sd	a1,-32(s0)
    8020591a:	87b2                	mv	a5,a2
    8020591c:	fcf42e23          	sw	a5,-36(s0)
    80205920:	a035                	j	8020594c <app_2_start+0xa7c>
    80205922:	fe043703          	ld	a4,-32(s0)
    80205926:	00170793          	addi	a5,a4,1
    8020592a:	fef43023          	sd	a5,-32(s0)
    8020592e:	fe843783          	ld	a5,-24(s0)
    80205932:	00178693          	addi	a3,a5,1
    80205936:	fed43423          	sd	a3,-24(s0)
    8020593a:	00074703          	lbu	a4,0(a4)
    8020593e:	00e78023          	sb	a4,0(a5)
    80205942:	fdc42783          	lw	a5,-36(s0)
    80205946:	37fd                	addiw	a5,a5,-1
    80205948:	fcf42e23          	sw	a5,-36(s0)
    8020594c:	fdc42783          	lw	a5,-36(s0)
    80205950:	2781                	sext.w	a5,a5
    80205952:	fbe1                	bnez	a5,80205922 <app_2_start+0xa52>
    80205954:	0001                	nop
    80205956:	0001                	nop
    80205958:	7422                	ld	s0,40(sp)
    8020595a:	6145                	addi	sp,sp,48
    8020595c:	8082                	ret
    8020595e:	7139                	addi	sp,sp,-64
    80205960:	fc22                	sd	s0,56(sp)
    80205962:	0080                	addi	s0,sp,64
    80205964:	fca43c23          	sd	a0,-40(s0)
    80205968:	fcb43823          	sd	a1,-48(s0)
    8020596c:	87b2                	mv	a5,a2
    8020596e:	fcf42623          	sw	a5,-52(s0)
    80205972:	fe042623          	sw	zero,-20(s0)
    80205976:	a8a1                	j	802059ce <app_2_start+0xafe>
    80205978:	fec42783          	lw	a5,-20(s0)
    8020597c:	fd843703          	ld	a4,-40(s0)
    80205980:	97ba                	add	a5,a5,a4
    80205982:	0007c683          	lbu	a3,0(a5)
    80205986:	fec42783          	lw	a5,-20(s0)
    8020598a:	fd043703          	ld	a4,-48(s0)
    8020598e:	97ba                	add	a5,a5,a4
    80205990:	0007c783          	lbu	a5,0(a5)
    80205994:	8736                	mv	a4,a3
    80205996:	02f70763          	beq	a4,a5,802059c4 <app_2_start+0xaf4>
    8020599a:	fec42783          	lw	a5,-20(s0)
    8020599e:	fd843703          	ld	a4,-40(s0)
    802059a2:	97ba                	add	a5,a5,a4
    802059a4:	0007c783          	lbu	a5,0(a5)
    802059a8:	0007871b          	sext.w	a4,a5
    802059ac:	fec42783          	lw	a5,-20(s0)
    802059b0:	fd043683          	ld	a3,-48(s0)
    802059b4:	97b6                	add	a5,a5,a3
    802059b6:	0007c783          	lbu	a5,0(a5)
    802059ba:	2781                	sext.w	a5,a5
    802059bc:	40f707bb          	subw	a5,a4,a5
    802059c0:	2781                	sext.w	a5,a5
    802059c2:	a831                	j	802059de <app_2_start+0xb0e>
    802059c4:	fec42783          	lw	a5,-20(s0)
    802059c8:	2785                	addiw	a5,a5,1
    802059ca:	fef42623          	sw	a5,-20(s0)
    802059ce:	fec42703          	lw	a4,-20(s0)
    802059d2:	fcc42783          	lw	a5,-52(s0)
    802059d6:	2781                	sext.w	a5,a5
    802059d8:	faf760e3          	bltu	a4,a5,80205978 <app_2_start+0xaa8>
    802059dc:	4781                	li	a5,0
    802059de:	853e                	mv	a0,a5
    802059e0:	7462                	ld	s0,56(sp)
    802059e2:	6121                	addi	sp,sp,64
    802059e4:	8082                	ret
    802059e6:	715d                	addi	sp,sp,-80
    802059e8:	e4a2                	sd	s0,72(sp)
    802059ea:	0880                	addi	s0,sp,80
    802059ec:	fca43423          	sd	a0,-56(s0)
    802059f0:	fcb43023          	sd	a1,-64(s0)
    802059f4:	86b2                	mv	a3,a2
    802059f6:	fad42e23          	sw	a3,-68(s0)
    802059fa:	868a                	mv	a3,sp
    802059fc:	85b6                	mv	a1,a3
    802059fe:	fbc42683          	lw	a3,-68(s0)
    80205a02:	02069613          	slli	a2,a3,0x20
    80205a06:	9201                	srli	a2,a2,0x20
    80205a08:	167d                	addi	a2,a2,-1
    80205a0a:	fec43423          	sd	a2,-24(s0)
    80205a0e:	02069613          	slli	a2,a3,0x20
    80205a12:	9201                	srli	a2,a2,0x20
    80205a14:	8e32                	mv	t3,a2
    80205a16:	4e81                	li	t4,0
    80205a18:	03de5613          	srli	a2,t3,0x3d
    80205a1c:	003e9893          	slli	a7,t4,0x3
    80205a20:	011668b3          	or	a7,a2,a7
    80205a24:	003e1813          	slli	a6,t3,0x3
    80205a28:	02069613          	slli	a2,a3,0x20
    80205a2c:	9201                	srli	a2,a2,0x20
    80205a2e:	8332                	mv	t1,a2
    80205a30:	4381                	li	t2,0
    80205a32:	03d35613          	srli	a2,t1,0x3d
    80205a36:	00339793          	slli	a5,t2,0x3
    80205a3a:	8fd1                	or	a5,a5,a2
    80205a3c:	00331713          	slli	a4,t1,0x3
    80205a40:	02069793          	slli	a5,a3,0x20
    80205a44:	9381                	srli	a5,a5,0x20
    80205a46:	07bd                	addi	a5,a5,15
    80205a48:	8391                	srli	a5,a5,0x4
    80205a4a:	0792                	slli	a5,a5,0x4
    80205a4c:	40f10133          	sub	sp,sp,a5
    80205a50:	878a                	mv	a5,sp
    80205a52:	00078793          	mv	a5,a5
    80205a56:	fef43023          	sd	a5,-32(s0)
    80205a5a:	fc042e23          	sw	zero,-36(s0)
    80205a5e:	a02d                	j	80205a88 <app_2_start+0xbb8>
    80205a60:	fc043783          	ld	a5,-64(s0)
    80205a64:	00178713          	addi	a4,a5,1
    80205a68:	fce43023          	sd	a4,-64(s0)
    80205a6c:	0007c703          	lbu	a4,0(a5)
    80205a70:	fe043683          	ld	a3,-32(s0)
    80205a74:	fdc42783          	lw	a5,-36(s0)
    80205a78:	97b6                	add	a5,a5,a3
    80205a7a:	00e78023          	sb	a4,0(a5)
    80205a7e:	fbc42783          	lw	a5,-68(s0)
    80205a82:	37fd                	addiw	a5,a5,-1
    80205a84:	faf42e23          	sw	a5,-68(s0)
    80205a88:	fbc42783          	lw	a5,-68(s0)
    80205a8c:	2781                	sext.w	a5,a5
    80205a8e:	fbe9                	bnez	a5,80205a60 <app_2_start+0xb90>
    80205a90:	a02d                	j	80205aba <app_2_start+0xbea>
    80205a92:	fc843783          	ld	a5,-56(s0)
    80205a96:	00178713          	addi	a4,a5,1
    80205a9a:	fce43423          	sd	a4,-56(s0)
    80205a9e:	fe043683          	ld	a3,-32(s0)
    80205aa2:	fdc42703          	lw	a4,-36(s0)
    80205aa6:	9736                	add	a4,a4,a3
    80205aa8:	00074703          	lbu	a4,0(a4)
    80205aac:	00e78023          	sb	a4,0(a5)
    80205ab0:	fbc42783          	lw	a5,-68(s0)
    80205ab4:	37fd                	addiw	a5,a5,-1
    80205ab6:	faf42e23          	sw	a5,-68(s0)
    80205aba:	fbc42783          	lw	a5,-68(s0)
    80205abe:	2781                	sext.w	a5,a5
    80205ac0:	fbe9                	bnez	a5,80205a92 <app_2_start+0xbc2>
    80205ac2:	812e                	mv	sp,a1
    80205ac4:	0001                	nop
    80205ac6:	fb040113          	addi	sp,s0,-80
    80205aca:	6426                	ld	s0,72(sp)
    80205acc:	6161                	addi	sp,sp,80
    80205ace:	8082                	ret
    80205ad0:	7179                	addi	sp,sp,-48
    80205ad2:	f422                	sd	s0,40(sp)
    80205ad4:	1800                	addi	s0,sp,48
    80205ad6:	fca43c23          	sd	a0,-40(s0)
    80205ada:	87ae                	mv	a5,a1
    80205adc:	8732                	mv	a4,a2
    80205ade:	fcf40ba3          	sb	a5,-41(s0)
    80205ae2:	87ba                	mv	a5,a4
    80205ae4:	fcf42823          	sw	a5,-48(s0)
    80205ae8:	fd843783          	ld	a5,-40(s0)
    80205aec:	fef43423          	sd	a5,-24(s0)
    80205af0:	a005                	j	80205b10 <app_2_start+0xc40>
    80205af2:	fe843783          	ld	a5,-24(s0)
    80205af6:	00178713          	addi	a4,a5,1
    80205afa:	fee43423          	sd	a4,-24(s0)
    80205afe:	fd744703          	lbu	a4,-41(s0)
    80205b02:	00e78023          	sb	a4,0(a5)
    80205b06:	fd042783          	lw	a5,-48(s0)
    80205b0a:	37fd                	addiw	a5,a5,-1
    80205b0c:	fcf42823          	sw	a5,-48(s0)
    80205b10:	fd042783          	lw	a5,-48(s0)
    80205b14:	2781                	sext.w	a5,a5
    80205b16:	fff1                	bnez	a5,80205af2 <app_2_start+0xc22>
    80205b18:	0001                	nop
    80205b1a:	0001                	nop
    80205b1c:	7422                	ld	s0,40(sp)
    80205b1e:	6145                	addi	sp,sp,48
    80205b20:	8082                	ret
    80205b22:	1101                	addi	sp,sp,-32
    80205b24:	ec06                	sd	ra,24(sp)
    80205b26:	e822                	sd	s0,16(sp)
    80205b28:	1000                	addi	s0,sp,32
    80205b2a:	fea43423          	sd	a0,-24(s0)
    80205b2e:	87ae                	mv	a5,a1
    80205b30:	fef42223          	sw	a5,-28(s0)
    80205b34:	fe442783          	lw	a5,-28(s0)
    80205b38:	863e                	mv	a2,a5
    80205b3a:	4581                	li	a1,0
    80205b3c:	fe843503          	ld	a0,-24(s0)
    80205b40:	f91ff0ef          	jal	ra,80205ad0 <app_2_start+0xc00>
    80205b44:	0001                	nop
    80205b46:	60e2                	ld	ra,24(sp)
    80205b48:	6442                	ld	s0,16(sp)
    80205b4a:	6105                	addi	sp,sp,32
    80205b4c:	8082                	ret
    80205b4e:	1101                	addi	sp,sp,-32
    80205b50:	ec22                	sd	s0,24(sp)
    80205b52:	1000                	addi	s0,sp,32
    80205b54:	fea43423          	sd	a0,-24(s0)
    80205b58:	feb43023          	sd	a1,-32(s0)
    80205b5c:	a0a1                	j	80205ba4 <app_2_start+0xcd4>
    80205b5e:	fe843783          	ld	a5,-24(s0)
    80205b62:	0007c703          	lbu	a4,0(a5)
    80205b66:	fe043783          	ld	a5,-32(s0)
    80205b6a:	0007c783          	lbu	a5,0(a5)
    80205b6e:	02f70163          	beq	a4,a5,80205b90 <app_2_start+0xcc0>
    80205b72:	fe843783          	ld	a5,-24(s0)
    80205b76:	0007c783          	lbu	a5,0(a5)
    80205b7a:	0007871b          	sext.w	a4,a5
    80205b7e:	fe043783          	ld	a5,-32(s0)
    80205b82:	0007c783          	lbu	a5,0(a5)
    80205b86:	2781                	sext.w	a5,a5
    80205b88:	40f707bb          	subw	a5,a4,a5
    80205b8c:	2781                	sext.w	a5,a5
    80205b8e:	a099                	j	80205bd4 <app_2_start+0xd04>
    80205b90:	fe843783          	ld	a5,-24(s0)
    80205b94:	0785                	addi	a5,a5,1
    80205b96:	fef43423          	sd	a5,-24(s0)
    80205b9a:	fe043783          	ld	a5,-32(s0)
    80205b9e:	0785                	addi	a5,a5,1
    80205ba0:	fef43023          	sd	a5,-32(s0)
    80205ba4:	fe843783          	ld	a5,-24(s0)
    80205ba8:	0007c783          	lbu	a5,0(a5)
    80205bac:	c791                	beqz	a5,80205bb8 <app_2_start+0xce8>
    80205bae:	fe043783          	ld	a5,-32(s0)
    80205bb2:	0007c783          	lbu	a5,0(a5)
    80205bb6:	f7c5                	bnez	a5,80205b5e <app_2_start+0xc8e>
    80205bb8:	fe843783          	ld	a5,-24(s0)
    80205bbc:	0007c783          	lbu	a5,0(a5)
    80205bc0:	0007871b          	sext.w	a4,a5
    80205bc4:	fe043783          	ld	a5,-32(s0)
    80205bc8:	0007c783          	lbu	a5,0(a5)
    80205bcc:	2781                	sext.w	a5,a5
    80205bce:	40f707bb          	subw	a5,a4,a5
    80205bd2:	2781                	sext.w	a5,a5
    80205bd4:	853e                	mv	a0,a5
    80205bd6:	6462                	ld	s0,24(sp)
    80205bd8:	6105                	addi	sp,sp,32
    80205bda:	8082                	ret
    80205bdc:	7179                	addi	sp,sp,-48
    80205bde:	f422                	sd	s0,40(sp)
    80205be0:	1800                	addi	s0,sp,48
    80205be2:	fca43c23          	sd	a0,-40(s0)
    80205be6:	fcb43823          	sd	a1,-48(s0)
    80205bea:	fd843783          	ld	a5,-40(s0)
    80205bee:	fef43423          	sd	a5,-24(s0)
    80205bf2:	a00d                	j	80205c14 <app_2_start+0xd44>
    80205bf4:	fd043703          	ld	a4,-48(s0)
    80205bf8:	00170793          	addi	a5,a4,1
    80205bfc:	fcf43823          	sd	a5,-48(s0)
    80205c00:	fd843783          	ld	a5,-40(s0)
    80205c04:	00178693          	addi	a3,a5,1
    80205c08:	fcd43c23          	sd	a3,-40(s0)
    80205c0c:	00074703          	lbu	a4,0(a4)
    80205c10:	00e78023          	sb	a4,0(a5)
    80205c14:	fd043783          	ld	a5,-48(s0)
    80205c18:	0007c783          	lbu	a5,0(a5)
    80205c1c:	ffe1                	bnez	a5,80205bf4 <app_2_start+0xd24>
    80205c1e:	fd843783          	ld	a5,-40(s0)
    80205c22:	00078023          	sb	zero,0(a5)
    80205c26:	fe843783          	ld	a5,-24(s0)
    80205c2a:	853e                	mv	a0,a5
    80205c2c:	7422                	ld	s0,40(sp)
    80205c2e:	6145                	addi	sp,sp,48
    80205c30:	8082                	ret
    80205c32:	7179                	addi	sp,sp,-48
    80205c34:	f422                	sd	s0,40(sp)
    80205c36:	1800                	addi	s0,sp,48
    80205c38:	fca43c23          	sd	a0,-40(s0)
    80205c3c:	fcb43823          	sd	a1,-48(s0)
    80205c40:	fd843783          	ld	a5,-40(s0)
    80205c44:	fef43423          	sd	a5,-24(s0)
    80205c48:	a031                	j	80205c54 <app_2_start+0xd84>
    80205c4a:	fd843783          	ld	a5,-40(s0)
    80205c4e:	0785                	addi	a5,a5,1
    80205c50:	fcf43c23          	sd	a5,-40(s0)
    80205c54:	fd843783          	ld	a5,-40(s0)
    80205c58:	0007c783          	lbu	a5,0(a5)
    80205c5c:	f7fd                	bnez	a5,80205c4a <app_2_start+0xd7a>
    80205c5e:	a00d                	j	80205c80 <app_2_start+0xdb0>
    80205c60:	fd043703          	ld	a4,-48(s0)
    80205c64:	00170793          	addi	a5,a4,1
    80205c68:	fcf43823          	sd	a5,-48(s0)
    80205c6c:	fd843783          	ld	a5,-40(s0)
    80205c70:	00178693          	addi	a3,a5,1
    80205c74:	fcd43c23          	sd	a3,-40(s0)
    80205c78:	00074703          	lbu	a4,0(a4)
    80205c7c:	00e78023          	sb	a4,0(a5)
    80205c80:	fd043783          	ld	a5,-48(s0)
    80205c84:	0007c783          	lbu	a5,0(a5)
    80205c88:	ffe1                	bnez	a5,80205c60 <app_2_start+0xd90>
    80205c8a:	fd843783          	ld	a5,-40(s0)
    80205c8e:	00078023          	sb	zero,0(a5)
    80205c92:	fe843783          	ld	a5,-24(s0)
    80205c96:	853e                	mv	a0,a5
    80205c98:	7422                	ld	s0,40(sp)
    80205c9a:	6145                	addi	sp,sp,48
    80205c9c:	8082                	ret
    80205c9e:	1101                	addi	sp,sp,-32
    80205ca0:	ec06                	sd	ra,24(sp)
    80205ca2:	e822                	sd	s0,16(sp)
    80205ca4:	1000                	addi	s0,sp,32
    80205ca6:	00000517          	auipc	a0,0x0
    80205caa:	13a50513          	addi	a0,a0,314 # 80205de0 <app_2_start+0xf10>
    80205cae:	af3ff0ef          	jal	ra,802057a0 <app_2_start+0x8d0>
    80205cb2:	afeff0ef          	jal	ra,80204fb0 <app_2_start+0xe0>
    80205cb6:	00000517          	auipc	a0,0x0
    80205cba:	13a50513          	addi	a0,a0,314 # 80205df0 <app_2_start+0xf20>
    80205cbe:	ae3ff0ef          	jal	ra,802057a0 <app_2_start+0x8d0>
    80205cc2:	fe043423          	sd	zero,-24(s0)
    80205cc6:	a835                	j	80205d02 <app_2_start+0xe32>
    80205cc8:	fe843703          	ld	a4,-24(s0)
    80205ccc:	009897b7          	lui	a5,0x989
    80205cd0:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80205cd4:	02f777b3          	remu	a5,a4,a5
    80205cd8:	e385                	bnez	a5,80205cf8 <app_2_start+0xe28>
    80205cda:	fe843703          	ld	a4,-24(s0)
    80205cde:	009897b7          	lui	a5,0x989
    80205ce2:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
    80205ce6:	02f757b3          	divu	a5,a4,a5
    80205cea:	85be                	mv	a1,a5
    80205cec:	00000517          	auipc	a0,0x0
    80205cf0:	11c50513          	addi	a0,a0,284 # 80205e08 <app_2_start+0xf38>
    80205cf4:	aadff0ef          	jal	ra,802057a0 <app_2_start+0x8d0>
    80205cf8:	fe843783          	ld	a5,-24(s0)
    80205cfc:	0785                	addi	a5,a5,1
    80205cfe:	fef43423          	sd	a5,-24(s0)
    80205d02:	fe843703          	ld	a4,-24(s0)
    80205d06:	05f5e7b7          	lui	a5,0x5f5e
    80205d0a:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <n+0x5f5e0df>
    80205d0e:	fae7fde3          	bgeu	a5,a4,80205cc8 <app_2_start+0xdf8>
    80205d12:	4781                	li	a5,0
    80205d14:	853e                	mv	a0,a5
    80205d16:	60e2                	ld	ra,24(sp)
    80205d18:	6442                	ld	s0,16(sp)
    80205d1a:	6105                	addi	sp,sp,32
    80205d1c:	8082                	ret
    80205d1e:	0000                	unimp
    80205d20:	6573755b          	0x6573755b
    80205d24:	5f72                	lw	t5,60(sp)
    80205d26:	696c                	ld	a1,208(a0)
    80205d28:	5d62                	lw	s10,56(sp)
    80205d2a:	6920                	ld	s0,80(a0)
    80205d2c:	696e                	ld	s2,216(sp)
    80205d2e:	2074                	fld	fa3,192(s0)
    80205d30:	000a6b6f          	jal	s6,802abd30 <ebss+0x50de8>
    80205d34:	0000                	unimp
    80205d36:	0000                	unimp
    80205d38:	6573755b          	0x6573755b
    80205d3c:	5f72                	lw	t5,60(sp)
    80205d3e:	696c                	ld	a1,208(a0)
    80205d40:	5d62                	lw	s10,56(sp)
    80205d42:	7320                	ld	s0,96(a4)
    80205d44:	6365                	lui	t1,0x19
    80205d46:	20646e6f          	jal	t3,8024bf4c <Kernelstack+0x19014>
    80205d4a:	7270                	ld	a2,224(a2)
    80205d4c:	6e69                	lui	t3,0x1a
    80205d4e:	2074                	fld	fa3,192(s0)
    80205d50:	6574                	ld	a3,200(a0)
    80205d52:	0a2e7473          	csrrci	s0,0xa2,28
    80205d56:	0000                	unimp
    80205d58:	f82c                	sd	a1,112(s0)
    80205d5a:	ffff                	0xffff
    80205d5c:	f8fc                	sd	a5,240(s1)
    80205d5e:	ffff                	0xffff
    80205d60:	f8fc                	sd	a5,240(s1)
    80205d62:	ffff                	0xffff
    80205d64:	f8fc                	sd	a5,240(s1)
    80205d66:	ffff                	0xffff
    80205d68:	f8fc                	sd	a5,240(s1)
    80205d6a:	ffff                	0xffff
    80205d6c:	f8fc                	sd	a5,240(s1)
    80205d6e:	ffff                	0xffff
    80205d70:	f8fc                	sd	a5,240(s1)
    80205d72:	ffff                	0xffff
    80205d74:	f8fc                	sd	a5,240(s1)
    80205d76:	ffff                	0xffff
    80205d78:	f8fc                	sd	a5,240(s1)
    80205d7a:	ffff                	0xffff
    80205d7c:	f8fc                	sd	a5,240(s1)
    80205d7e:	ffff                	0xffff
    80205d80:	f8fc                	sd	a5,240(s1)
    80205d82:	ffff                	0xffff
    80205d84:	f8aa                	sd	a0,112(sp)
    80205d86:	ffff                	0xffff
    80205d88:	f7ae                	sd	a1,488(sp)
    80205d8a:	ffff                	0xffff
    80205d8c:	f8fc                	sd	a5,240(s1)
    80205d8e:	ffff                	0xffff
    80205d90:	f8fc                	sd	a5,240(s1)
    80205d92:	ffff                	0xffff
    80205d94:	f8fc                	sd	a5,240(s1)
    80205d96:	ffff                	0xffff
    80205d98:	f8fc                	sd	a5,240(s1)
    80205d9a:	ffff                	0xffff
    80205d9c:	f8fc                	sd	a5,240(s1)
    80205d9e:	ffff                	0xffff
    80205da0:	f8fc                	sd	a5,240(s1)
    80205da2:	ffff                	0xffff
    80205da4:	f8fc                	sd	a5,240(s1)
    80205da6:	ffff                	0xffff
    80205da8:	f7a6                	sd	s1,488(sp)
    80205daa:	ffff                	0xffff
    80205dac:	f8fc                	sd	a5,240(s1)
    80205dae:	ffff                	0xffff
    80205db0:	f8fc                	sd	a5,240(s1)
    80205db2:	ffff                	0xffff
    80205db4:	f8fc                	sd	a5,240(s1)
    80205db6:	ffff                	0xffff
    80205db8:	f8fc                	sd	a5,240(s1)
    80205dba:	ffff                	0xffff
    80205dbc:	f8fc                	sd	a5,240(s1)
    80205dbe:	ffff                	0xffff
    80205dc0:	f8fc                	sd	a5,240(s1)
    80205dc2:	ffff                	0xffff
    80205dc4:	f8cc                	sd	a1,176(s1)
    80205dc6:	ffff                	0xffff
    80205dc8:	f8fc                	sd	a5,240(s1)
    80205dca:	ffff                	0xffff
    80205dcc:	f7ae                	sd	a1,488(sp)
    80205dce:	ffff                	0xffff
    80205dd0:	f8fc                	sd	a5,240(s1)
    80205dd2:	ffff                	0xffff
    80205dd4:	f8fc                	sd	a5,240(s1)
    80205dd6:	ffff                	0xffff
    80205dd8:	f82c                	sd	a1,112(s0)
    80205dda:	ffff                	0xffff
    80205ddc:	0000                	unimp
    80205dde:	0000                	unimp
    80205de0:	3130                	fld	fa2,96(a0)
    80205de2:	2074                	fld	fa3,192(s0)
    80205de4:	6979                	lui	s2,0x1e
    80205de6:	6c65                	lui	s8,0x19
    80205de8:	0a64                	addi	s1,sp,284
    80205dea:	0000                	unimp
    80205dec:	0000                	unimp
    80205dee:	0000                	unimp
    80205df0:	3130                	fld	fa2,96(a0)
    80205df2:	2074                	fld	fa3,192(s0)
    80205df4:	6979                	lui	s2,0x1e
    80205df6:	6c65                	lui	s8,0x19
    80205df8:	2064                	fld	fs1,192(s0)
    80205dfa:	63637573          	csrrci	a0,0x636,6
    80205dfe:	7365                	lui	t1,0xffff9
    80205e00:	00000a73          	0xa73
    80205e04:	0000                	unimp
    80205e06:	0000                	unimp
    80205e08:	3130                	fld	fa2,96(a0)
    80205e0a:	3a74                	fld	fa3,240(a2)
    80205e0c:	2520                	fld	fs0,72(a0)
    80205e0e:	0a64                	addi	s1,sp,284
	...

Disassembly of section .stack:

0000000080206000 <bootstack>:
	...

Disassembly of section .bss:

000000008020a000 <ticks>:
	...

000000008020a008 <task_manager>:
	...

000000008020a978 <temp.0>:
	...

000000008020a9e8 <app_manager>:
	...

000000008020ab38 <Trap_Stack>:
	...

000000008020af38 <UserStack>:
	...

0000000080232f38 <Kernelstack>:
	...

000000008025af38 <ticks>:
	...

000000008025af40 <ticks>:
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
       0:	00a2                	slli	ra,ra,0x8
       2:	0000                	unimp
       4:	0004                	0x4
       6:	0000                	unimp
       8:	0000                	unimp
       a:	0108                	addi	a0,sp,128
       c:	0000008b          	0x8b
      10:	340c                	fld	fa1,40(s0)
      12:	0000                	unimp
      14:	5900                	lw	s0,48(a0)
      16:	0000                	unimp
      18:	0c00                	addi	s0,sp,528
      1a:	2000                	fld	fs0,0(s0)
      1c:	0080                	addi	s0,sp,64
      1e:	0000                	unimp
      20:	3000                	fld	fs0,32(s0)
	...
      2a:	0000                	unimp
      2c:	0200                	addi	s0,sp,256
      2e:	0601                	addi	a2,a2,0
      30:	0044                	addi	s1,sp,4
      32:	0000                	unimp
      34:	0202                	c.slli64	tp
      36:	2205                	addiw	tp,tp,1
      38:	0000                	unimp
      3a:	0300                	addi	s0,sp,384
      3c:	0504                	addi	s1,sp,640
      3e:	6e69                	lui	t3,0x1a
      40:	0074                	addi	a3,sp,12
      42:	0802                	c.slli64	a6
      44:	5005                	c.li	zero,-31
      46:	0000                	unimp
      48:	0200                	addi	s0,sp,256
      4a:	0801                	addi	a6,a6,0
      4c:	0042                	c.slli	zero,0x10
      4e:	0000                	unimp
      50:	0202                	c.slli64	tp
      52:	00000f07          	0xf07
      56:	0200                	addi	s0,sp,256
      58:	0704                	addi	s1,sp,896
      5a:	007e                	c.slli	zero,0x1f
      5c:	0000                	unimp
      5e:	0604                	addi	s1,sp,768
      60:	0000                	unimp
      62:	0200                	addi	s0,sp,256
      64:	1b0e                	slli	s6,s6,0x23
      66:	006a                	c.slli	zero,0x1a
      68:	0000                	unimp
      6a:	0802                	c.slli64	a6
      6c:	00007907          	0x7907
      70:	0500                	addi	s0,sp,640
      72:	0000                	unimp
      74:	0000                	unimp
      76:	5e110503          	lb	a0,1505(sp)
      7a:	0000                	unimp
      7c:	0900                	addi	s0,sp,144
      7e:	20a00003          	lb	zero,522(zero) # 20a <n+0x1ea>
      82:	0080                	addi	s0,sp,64
      84:	0000                	unimp
      86:	0600                	addi	s0,sp,768
      88:	002c                	addi	a1,sp,8
      8a:	0000                	unimp
      8c:	0a01                	addi	s4,s4,0
      8e:	3b05                	addiw	s6,s6,-31
      90:	0000                	unimp
      92:	0c00                	addi	s0,sp,528
      94:	2000                	fld	fs0,0(s0)
      96:	0080                	addi	s0,sp,64
      98:	0000                	unimp
      9a:	3000                	fld	fs0,32(s0)
      9c:	0000                	unimp
      9e:	0000                	unimp
      a0:	0000                	unimp
      a2:	0100                	addi	s0,sp,128
      a4:	009c                	addi	a5,sp,64
      a6:	0198                	addi	a4,sp,192
      a8:	0000                	unimp
      aa:	0004                	0x4
      ac:	0064                	addi	s1,sp,12
      ae:	0000                	unimp
      b0:	0108                	addi	a0,sp,128
      b2:	0000008b          	0x8b
      b6:	d40c                	sw	a1,40(s0)
      b8:	0000                	unimp
      ba:	5900                	lw	s0,48(a0)
      bc:	0000                	unimp
      be:	3c00                	fld	fs0,56(s0)
      c0:	2000                	fld	fs0,0(s0)
      c2:	0080                	addi	s0,sp,64
      c4:	0000                	unimp
      c6:	c200                	sw	s0,0(a2)
      c8:	0000                	unimp
      ca:	0000                	unimp
      cc:	0000                	unimp
      ce:	b300                	fsd	fs0,32(a4)
      d0:	0000                	unimp
      d2:	0200                	addi	s0,sp,256
      d4:	0601                	addi	a2,a2,0
      d6:	0044                	addi	s1,sp,4
      d8:	0000                	unimp
      da:	0202                	c.slli64	tp
      dc:	2205                	addiw	tp,tp,1
      de:	0000                	unimp
      e0:	0300                	addi	s0,sp,384
      e2:	0504                	addi	s1,sp,640
      e4:	6e69                	lui	t3,0x1a
      e6:	0074                	addi	a3,sp,12
      e8:	0802                	c.slli64	a6
      ea:	5005                	c.li	zero,-31
      ec:	0000                	unimp
      ee:	0200                	addi	s0,sp,256
      f0:	0801                	addi	a6,a6,0
      f2:	0042                	c.slli	zero,0x10
      f4:	0000                	unimp
      f6:	0202                	c.slli64	tp
      f8:	00000f07          	0xf07
      fc:	0200                	addi	s0,sp,256
      fe:	0704                	addi	s1,sp,896
     100:	007e                	c.slli	zero,0x1f
     102:	0000                	unimp
     104:	0604                	addi	s1,sp,768
     106:	0000                	unimp
     108:	0200                	addi	s0,sp,256
     10a:	1b0e                	slli	s6,s6,0x23
     10c:	006a                	c.slli	zero,0x1a
     10e:	0000                	unimp
     110:	0802                	c.slli64	a6
     112:	00007907          	0x7907
     116:	0500                	addi	s0,sp,640
     118:	0104                	addi	s1,sp,128
     11a:	0000                	unimp
     11c:	2a01                	sext.w	s4,s4
     11e:	5e0a                	lw	t3,160(sp)
     120:	0000                	unimp
     122:	d600                	sw	s0,40(a2)
     124:	2000                	fld	fs0,0(s0)
     126:	0080                	addi	s0,sp,64
     128:	0000                	unimp
     12a:	2800                	fld	fs0,16(s0)
     12c:	0000                	unimp
     12e:	0000                	unimp
     130:	0000                	unimp
     132:	0100                	addi	s0,sp,128
     134:	a39c                	fsd	fa5,0(a5)
     136:	0000                	unimp
     138:	0600                	addi	s0,sp,768
     13a:	00f2                	slli	ra,ra,0x1c
     13c:	0000                	unimp
     13e:	2a01                	sext.w	s4,s4
     140:	5e21                	li	t3,-24
     142:	0000                	unimp
     144:	0200                	addi	s0,sp,256
     146:	6891                	lui	a7,0x4
     148:	0700                	addi	s0,sp,896
     14a:	00e5                	addi	ra,ra,25
     14c:	0000                	unimp
     14e:	2601                	sext.w	a2,a2
     150:	5e0a                	lw	t3,160(sp)
     152:	0000                	unimp
     154:	b600                	fsd	fs0,40(a2)
     156:	2000                	fld	fs0,0(s0)
     158:	0080                	addi	s0,sp,64
     15a:	0000                	unimp
     15c:	2000                	fld	fs0,0(s0)
     15e:	0000                	unimp
     160:	0000                	unimp
     162:	0000                	unimp
     164:	0100                	addi	s0,sp,128
     166:	079c                	addi	a5,sp,960
     168:	00000117          	auipc	sp,0x0
     16c:	2201                	sext.w	tp,tp
     16e:	5e0a                	lw	t3,160(sp)
     170:	0000                	unimp
     172:	9600                	0x9600
     174:	2000                	fld	fs0,0(s0)
     176:	0080                	addi	s0,sp,64
     178:	0000                	unimp
     17a:	2000                	fld	fs0,0(s0)
     17c:	0000                	unimp
     17e:	0000                	unimp
     180:	0000                	unimp
     182:	0100                	addi	s0,sp,128
     184:	089c                	addi	a5,sp,80
     186:	00000127          	0x127
     18a:	1e01                	addi	t3,t3,-32
     18c:	7006                	0x7006
     18e:	2000                	fld	fs0,0(s0)
     190:	0080                	addi	s0,sp,64
     192:	0000                	unimp
     194:	2600                	fld	fs0,8(a2)
     196:	0000                	unimp
     198:	0000                	unimp
     19a:	0000                	unimp
     19c:	0100                	addi	s0,sp,128
     19e:	0c9c                	addi	a5,sp,592
     1a0:	0001                	nop
     1a2:	0900                	addi	s0,sp,144
     1a4:	01006863          	bltu	zero,a6,1b4 <n+0x194>
     1a8:	1f1e                	slli	t5,t5,0x27
     1aa:	005e                	c.slli	zero,0x17
     1ac:	0000                	unimp
     1ae:	9102                	jalr	sp
     1b0:	0068                	addi	a0,sp,12
     1b2:	370a                	fld	fa4,160(sp)
     1b4:	0001                	nop
     1b6:	0100                	addi	s0,sp,128
     1b8:	1810                	addi	a2,sp,48
     1ba:	005e                	c.slli	zero,0x17
     1bc:	0000                	unimp
     1be:	003c                	addi	a5,sp,8
     1c0:	8020                	0x8020
     1c2:	0000                	unimp
     1c4:	0000                	unimp
     1c6:	0034                	addi	a3,sp,8
     1c8:	0000                	unimp
     1ca:	0000                	unimp
     1cc:	0000                	unimp
     1ce:	9c01                	subw	s0,s0,s0
     1d0:	fe06                	sd	ra,312(sp)
     1d2:	0000                	unimp
     1d4:	0100                	addi	s0,sp,128
     1d6:	2610                	fld	fa2,8(a2)
     1d8:	0042                	c.slli	zero,0x10
     1da:	0000                	unimp
     1dc:	9102                	jalr	sp
     1de:	0668                	addi	a0,sp,780
     1e0:	0140                	addi	s0,sp,132
     1e2:	0000                	unimp
     1e4:	1001                	c.nop	-32
     1e6:	4232                	lw	tp,12(sp)
     1e8:	0000                	unimp
     1ea:	0200                	addi	s0,sp,256
     1ec:	6091                	lui	ra,0x4
     1ee:	1206                	slli	tp,tp,0x21
     1f0:	0001                	nop
     1f2:	0100                	addi	s0,sp,128
     1f4:	3d10                	fld	fa2,56(a0)
     1f6:	0042                	c.slli	zero,0x10
     1f8:	0000                	unimp
     1fa:	9102                	jalr	sp
     1fc:	0658                	addi	a4,sp,772
     1fe:	0145                	addi	sp,sp,17
     200:	0000                	unimp
     202:	1001                	c.nop	-32
     204:	4248                	lw	a0,4(a2)
     206:	0000                	unimp
     208:	0200                	addi	s0,sp,256
     20a:	5091                	li	ra,-28
     20c:	0030610b          	0x30610b
     210:	1101                	addi	sp,sp,-32
     212:	00004213          	xori	tp,zero,0
     216:	0100                	addi	s0,sp,128
     218:	0b5a                	slli	s6,s6,0x16
     21a:	3161                	addiw	sp,sp,-8
     21c:	0100                	addi	s0,sp,128
     21e:	1312                	slli	t1,t1,0x24
     220:	0042                	c.slli	zero,0x10
     222:	0000                	unimp
     224:	5b01                	li	s6,-32
     226:	0032610b          	0x32610b
     22a:	1301                	addi	t1,t1,-32
     22c:	00004213          	xori	tp,zero,0
     230:	0100                	addi	s0,sp,128
     232:	0b5c                	addi	a5,sp,404
     234:	3761                	addiw	a4,a4,-8
     236:	0100                	addi	s0,sp,128
     238:	1314                	addi	a3,sp,416
     23a:	0042                	c.slli	zero,0x10
     23c:	0000                	unimp
     23e:	6101                	0x6101
     240:	0000                	unimp
     242:	045f 0000 0004      	0x40000045f
     248:	0140                	addi	s0,sp,132
     24a:	0000                	unimp
     24c:	0108                	addi	a0,sp,128
     24e:	0000008b          	0x8b
     252:	660c                	ld	a1,8(a2)
     254:	0001                	nop
     256:	5900                	lw	s0,48(a0)
     258:	0000                	unimp
     25a:	fe00                	sd	s0,56(a2)
     25c:	2000                	fld	fs0,0(s0)
     25e:	0080                	addi	s0,sp,64
     260:	0000                	unimp
     262:	4e00                	lw	s0,24(a2)
     264:	0004                	0x4
     266:	0000                	unimp
     268:	0000                	unimp
     26a:	a400                	fsd	fs0,8(s0)
     26c:	0001                	nop
     26e:	0200                	addi	s0,sp,256
     270:	0601                	addi	a2,a2,0
     272:	0044                	addi	s1,sp,4
     274:	0000                	unimp
     276:	0202                	c.slli64	tp
     278:	2205                	addiw	tp,tp,1
     27a:	0000                	unimp
     27c:	0300                	addi	s0,sp,384
     27e:	01d4                	addi	a3,sp,196
     280:	0000                	unimp
     282:	0702                	c.slli64	a4
     284:	470d                	li	a4,3
     286:	0000                	unimp
     288:	0400                	addi	s0,sp,512
     28a:	0504                	addi	s1,sp,640
     28c:	6e69                	lui	t3,0x1a
     28e:	0074                	addi	a3,sp,12
     290:	0802                	c.slli64	a6
     292:	5005                	c.li	zero,-31
     294:	0000                	unimp
     296:	0300                	addi	s0,sp,384
     298:	01bc                	addi	a5,sp,200
     29a:	0000                	unimp
     29c:	0b02                	c.slli64	s6
     29e:	00006117          	auipc	sp,0x6
     2a2:	0200                	addi	s0,sp,256
     2a4:	0801                	addi	a6,a6,0
     2a6:	0042                	c.slli	zero,0x10
     2a8:	0000                	unimp
     2aa:	0202                	c.slli64	tp
     2ac:	00000f07          	0xf07
     2b0:	0300                	addi	s0,sp,384
     2b2:	000001d3          	fadd.s	ft3,ft0,ft0,rne
     2b6:	0d02                	c.slli64	s10
     2b8:	7b16                	ld	s6,352(sp)
     2ba:	0000                	unimp
     2bc:	0200                	addi	s0,sp,256
     2be:	0704                	addi	s1,sp,896
     2c0:	007e                	c.slli	zero,0x1f
     2c2:	0000                	unimp
     2c4:	0802                	c.slli64	a6
     2c6:	00007907          	0x7907
     2ca:	0500                	addi	s0,sp,640
     2cc:	3875                	addiw	a6,a6,-3
     2ce:	0300                	addi	s0,sp,384
     2d0:	00551107          	0x551107
     2d4:	0000                	unimp
     2d6:	8906                	mv	s2,ra
     2d8:	0000                	unimp
     2da:	0500                	addi	s0,sp,640
     2dc:	3375                	addiw	t1,t1,-3
     2de:	0032                	c.slli	zero,0xc
     2e0:	6f120803          	lb	a6,1777(tp) # ffffffffffffa6f1 <ebss+0xffffffff7fd9f7a9>
     2e4:	0000                	unimp
     2e6:	0500                	addi	s0,sp,640
     2e8:	3369                	addiw	t1,t1,-6
     2ea:	0032                	c.slli	zero,0xc
     2ec:	3b110903          	lb	s2,945(sp) # 664f <n+0x662f>
     2f0:	0000                	unimp
     2f2:	0700                	addi	s0,sp,896
     2f4:	000001ab          	0x1ab
     2f8:	6301                	0x6301
     2fa:	1406                	slli	s0,s0,0x21
     2fc:	2005                	0x2005
     2fe:	0080                	addi	s0,sp,64
     300:	0000                	unimp
     302:	3800                	fld	fs0,48(s0)
     304:	0000                	unimp
     306:	0000                	unimp
     308:	0000                	unimp
     30a:	0100                	addi	s0,sp,128
     30c:	fd9c                	sd	a5,56(a1)
     30e:	0000                	unimp
     310:	0800                	addi	s0,sp,16
     312:	0000018f          	0x18f
     316:	6301                	0x6301
     318:	0000fd13          	andi	s10,ra,0
     31c:	0200                	addi	s0,sp,256
     31e:	6891                	lui	a7,0x4
     320:	7609                	lui	a2,0xfffe2
     322:	6c61                	lui	s8,0x18
     324:	0100                	addi	s0,sp,128
     326:	00891c63          	bne	s2,s0,33e <n+0x31e>
     32a:	0000                	unimp
     32c:	9102                	jalr	sp
     32e:	656c0967          	jalr	s2,1622(s8) # 18656 <n+0x18636>
     332:	006e                	c.slli	zero,0x1b
     334:	6301                	0x6301
     336:	9925                	andi	a0,a0,-23
     338:	0000                	unimp
     33a:	0200                	addi	s0,sp,256
     33c:	6091                	lui	ra,0x4
     33e:	0a00                	addi	s0,sp,272
     340:	0b08                	addi	a0,sp,400
     342:	01c4                	addi	s1,sp,196
     344:	0000                	unimp
     346:	5c01                	li	s8,-32
     348:	c606                	sw	ra,12(sp)
     34a:	2004                	fld	fs1,0(s0)
     34c:	0080                	addi	s0,sp,64
     34e:	0000                	unimp
     350:	4e00                	lw	s0,24(a2)
     352:	0000                	unimp
     354:	0000                	unimp
     356:	0000                	unimp
     358:	0100                	addi	s0,sp,128
     35a:	4b9c                	lw	a5,16(a5)
     35c:	0001                	nop
     35e:	0800                	addi	s0,sp,16
     360:	0000018f          	0x18f
     364:	5c01                	li	s8,-32
     366:	4b11                	li	s6,4
     368:	0001                	nop
     36a:	0200                	addi	s0,sp,256
     36c:	6891                	lui	a7,0x4
     36e:	7309                	lui	t1,0xfffe2
     370:	6372                	ld	t1,280(sp)
     372:	0100                	addi	s0,sp,128
     374:	215c                	fld	fa5,128(a0)
     376:	0151                	addi	sp,sp,20
     378:	0000                	unimp
     37a:	9102                	jalr	sp
     37c:	0960                	addi	s0,sp,156
     37e:	656c                	ld	a1,200(a0)
     380:	006e                	c.slli	zero,0x1b
     382:	5c01                	li	s8,-32
     384:	992a                	add	s2,s2,a0
     386:	0000                	unimp
     388:	0200                	addi	s0,sp,256
     38a:	5c91                	li	s9,-28
     38c:	0c00                	addi	s0,sp,528
     38e:	8908                	0x8908
     390:	0000                	unimp
     392:	0c00                	addi	s0,sp,528
     394:	9408                	0x9408
     396:	0000                	unimp
     398:	0d00                	addi	s0,sp,656
     39a:	0194                	addi	a3,sp,192
     39c:	0000                	unimp
     39e:	4e01                	li	t3,0
     3a0:	0001a707          	flw	fa4,0(gp)
     3a4:	5a00                	lw	s0,48(a2)
     3a6:	2004                	fld	fs1,0(s0)
     3a8:	0080                	addi	s0,sp,64
     3aa:	0000                	unimp
     3ac:	6c00                	ld	s0,24(s0)
     3ae:	0000                	unimp
     3b0:	0000                	unimp
     3b2:	0000                	unimp
     3b4:	0100                	addi	s0,sp,128
     3b6:	a79c                	fsd	fa5,8(a5)
     3b8:	0001                	nop
     3ba:	0800                	addi	s0,sp,16
     3bc:	0000018f          	0x18f
     3c0:	4e01                	li	t3,0
     3c2:	a716                	fsd	ft5,392(sp)
     3c4:	0001                	nop
     3c6:	0200                	addi	s0,sp,256
     3c8:	5891                	li	a7,-28
     3ca:	7309                	lui	t1,0xfffe2
     3cc:	6372                	ld	t1,280(sp)
     3ce:	0100                	addi	s0,sp,128
     3d0:	284e                	fld	fa6,208(sp)
     3d2:	01b9                	addi	gp,gp,14
     3d4:	0000                	unimp
     3d6:	9102                	jalr	sp
     3d8:	0e50                	addi	a2,sp,788
     3da:	6d74                	ld	a3,216(a0)
     3dc:	0070                	addi	a2,sp,12
     3de:	5001                	c.li	zero,-32
     3e0:	0001a70b          	0x1a70b
     3e4:	0200                	addi	s0,sp,256
     3e6:	6891                	lui	a7,0x4
     3e8:	0c00                	addi	s0,sp,528
     3ea:	ad08                	fsd	fa0,24(a0)
     3ec:	0001                	nop
     3ee:	0200                	addi	s0,sp,256
     3f0:	0801                	addi	a6,a6,0
     3f2:	0000004b          	fnmsub.s	ft0,ft0,ft0,ft0,rne
     3f6:	ad06                	fsd	ft1,152(sp)
     3f8:	0001                	nop
     3fa:	0c00                	addi	s0,sp,528
     3fc:	b408                	fsd	fa0,40(s0)
     3fe:	0001                	nop
     400:	0d00                	addi	s0,sp,656
     402:	01dc                	addi	a5,sp,196
     404:	0000                	unimp
     406:	4101                	li	sp,0
     408:	0001a707          	flw	fa4,0(gp)
     40c:	0400                	addi	s0,sp,512
     40e:	2004                	fld	fs1,0(s0)
     410:	0080                	addi	s0,sp,64
     412:	0000                	unimp
     414:	5600                	lw	s0,40(a2)
     416:	0000                	unimp
     418:	0000                	unimp
     41a:	0000                	unimp
     41c:	0100                	addi	s0,sp,128
     41e:	0f9c                	addi	a5,sp,976
     420:	0002                	c.slli64	zero
     422:	0800                	addi	s0,sp,16
     424:	0000018f          	0x18f
     428:	4101                	li	sp,0
     42a:	a716                	fsd	ft5,392(sp)
     42c:	0001                	nop
     42e:	0200                	addi	s0,sp,256
     430:	5891                	li	a7,-28
     432:	7309                	lui	t1,0xfffe2
     434:	6372                	ld	t1,280(sp)
     436:	0100                	addi	s0,sp,128
     438:	2841                	addiw	a6,a6,16
     43a:	01b9                	addi	gp,gp,14
     43c:	0000                	unimp
     43e:	9102                	jalr	sp
     440:	0e50                	addi	a2,sp,788
     442:	6d74                	ld	a3,216(a0)
     444:	0070                	addi	a2,sp,12
     446:	4301                	li	t1,0
     448:	0001a70b          	0x1a70b
     44c:	0200                	addi	s0,sp,256
     44e:	6891                	lui	a7,0x4
     450:	0d00                	addi	s0,sp,656
     452:	0186                	slli	gp,gp,0x1
     454:	0000                	unimp
     456:	3501                	addiw	a0,a0,-32
     458:	4705                	li	a4,1
     45a:	0000                	unimp
     45c:	7600                	ld	s0,40(a2)
     45e:	00802003          	lw	zero,8(zero) # 8 <n-0x4>
     462:	0000                	unimp
     464:	8e00                	0x8e00
     466:	0000                	unimp
     468:	0000                	unimp
     46a:	0000                	unimp
     46c:	0100                	addi	s0,sp,128
     46e:	509c                	lw	a5,32(s1)
     470:	0002                	c.slli64	zero
     472:	0800                	addi	s0,sp,16
     474:	01b2                	slli	gp,gp,0xc
     476:	0000                	unimp
     478:	3501                	addiw	a0,a0,-32
     47a:	b91a                	fsd	ft6,176(sp)
     47c:	0001                	nop
     47e:	0200                	addi	s0,sp,256
     480:	6891                	lui	a7,0x4
     482:	b708                	fsd	fa0,40(a4)
     484:	0001                	nop
     486:	0100                	addi	s0,sp,128
     488:	2c35                	addiw	s8,s8,13
     48a:	01b9                	addi	gp,gp,14
     48c:	0000                	unimp
     48e:	9102                	jalr	sp
     490:	0060                	addi	s0,sp,12
     492:	0001cb07          	flq	fs6,0(gp)
     496:	0100                	addi	s0,sp,128
     498:	034a0633          	mul	a2,s4,s4
     49c:	8020                	0x8020
     49e:	0000                	unimp
     4a0:	0000                	unimp
     4a2:	002c                	addi	a1,sp,8
     4a4:	0000                	unimp
     4a6:	0000                	unimp
     4a8:	0000                	unimp
     4aa:	9c01                	subw	s0,s0,s0
     4ac:	028d                	addi	t0,t0,3
     4ae:	0000                	unimp
     4b0:	8f08                	0x8f08
     4b2:	0001                	nop
     4b4:	0100                	addi	s0,sp,128
     4b6:	00fd1433          	sll	s0,s10,a5
     4ba:	0000                	unimp
     4bc:	9102                	jalr	sp
     4be:	0968                	addi	a0,sp,156
     4c0:	656c                	ld	a1,200(a0)
     4c2:	006e                	c.slli	zero,0x1b
     4c4:	3301                	addiw	t1,t1,-32
     4c6:	991e                	add	s2,s2,t2
     4c8:	0000                	unimp
     4ca:	0200                	addi	s0,sp,256
     4cc:	6491                	lui	s1,0x4
     4ce:	0b00                	addi	s0,sp,400
     4d0:	00000153          	fadd.s	ft2,ft0,ft0,rne
     4d4:	2a01                	sext.w	s4,s4
     4d6:	f806                	sd	ra,48(sp)
     4d8:	2002                	fld	ft0,0(sp)
     4da:	0080                	addi	s0,sp,64
     4dc:	0000                	unimp
     4de:	5200                	lw	s0,32(a2)
     4e0:	0000                	unimp
     4e2:	0000                	unimp
     4e4:	0000                	unimp
     4e6:	0100                	addi	s0,sp,128
     4e8:	e89c                	sd	a5,16(s1)
     4ea:	0002                	c.slli64	zero
     4ec:	0800                	addi	s0,sp,16
     4ee:	0000018f          	0x18f
     4f2:	2a01                	sext.w	s4,s4
     4f4:	fd15                	bnez	a0,430 <n+0x410>
     4f6:	0000                	unimp
     4f8:	0200                	addi	s0,sp,256
     4fa:	5891                	li	a7,-28
     4fc:	7609                	lui	a2,0xfffe2
     4fe:	6c61                	lui	s8,0x18
     500:	0100                	addi	s0,sp,128
     502:	1e2a                	slli	t3,t3,0x2a
     504:	0089                	addi	ra,ra,2
     506:	0000                	unimp
     508:	9102                	jalr	sp
     50a:	656c0957          	0x656c0957
     50e:	006e                	c.slli	zero,0x1b
     510:	2a01                	sext.w	s4,s4
     512:	00009927          	0x9927
     516:	0200                	addi	s0,sp,256
     518:	5091                	li	ra,-28
     51a:	640e                	ld	s0,192(sp)
     51c:	01007473          	csrrci	s0,0x10,0
     520:	092c                	addi	a1,sp,152
     522:	0000014b          	fnmsub.s	ft2,ft0,ft0,ft0,rne
     526:	9102                	jalr	sp
     528:	0068                	addi	a0,sp,12
     52a:	00015c0b          	0x15c0b
     52e:	0100                	addi	s0,sp,128
     530:	061e                	slli	a2,a2,0x7
     532:	020e                	slli	tp,tp,0x3
     534:	8020                	0x8020
     536:	0000                	unimp
     538:	0000                	unimp
     53a:	00ea                	slli	ra,ra,0x1a
     53c:	0000                	unimp
     53e:	0000                	unimp
     540:	0000                	unimp
     542:	9c01                	subw	s0,s0,s0
     544:	0352                	slli	t1,t1,0x14
     546:	0000                	unimp
     548:	8f08                	0x8f08
     54a:	0001                	nop
     54c:	0100                	addi	s0,sp,128
     54e:	141e                	slli	s0,s0,0x27
     550:	0000014b          	fnmsub.s	ft2,ft0,ft0,ft0,rne
     554:	9102                	jalr	sp
     556:	0948                	addi	a0,sp,148
     558:	00637273          	csrrci	tp,0x6,6
     55c:	1e01                	addi	t3,t3,-32
     55e:	5124                	lw	s1,96(a0)
     560:	0001                	nop
     562:	0200                	addi	s0,sp,256
     564:	4091                	li	ra,4
     566:	6c09                	lui	s8,0x2
     568:	6e65                	lui	t3,0x19
     56a:	0100                	addi	s0,sp,128
     56c:	2d1e                	fld	fs10,448(sp)
     56e:	0099                	addi	ra,ra,6
     570:	0000                	unimp
     572:	7fbc9103          	lh	sp,2043(s9)
     576:	00019d0f          	0x19d0f
     57a:	0100                	addi	s0,sp,128
     57c:	0820                	addi	s0,sp,24
     57e:	0352                	slli	t1,t1,0x14
     580:	0000                	unimp
     582:	06609103          	lh	sp,102(ra) # 4066 <n+0x4046>
     586:	690e                	ld	s2,192(sp)
     588:	0100                	addi	s0,sp,128
     58a:	0921                	addi	s2,s2,8
     58c:	00a5                	addi	ra,ra,9
     58e:	0000                	unimp
     590:	9102                	jalr	sp
     592:	005c                	addi	a5,sp,4
     594:	8910                	0x8910
     596:	0000                	unimp
     598:	6500                	ld	s0,8(a0)
     59a:	11000003          	lb	zero,272(zero) # 110 <n+0xf0>
     59e:	0082                	c.slli64	ra
     5a0:	0000                	unimp
     5a2:	06689103          	lh	sp,102(a7) # 4066 <n+0x4046>
     5a6:	0d00                	addi	s0,sp,656
     5a8:	01a2                	slli	gp,gp,0x8
     5aa:	0000                	unimp
     5ac:	1401                	addi	s0,s0,-32
     5ae:	4705                	li	a4,1
     5b0:	0000                	unimp
     5b2:	8600                	0x8600
     5b4:	2001                	0x2001
     5b6:	0080                	addi	s0,sp,64
     5b8:	0000                	unimp
     5ba:	8800                	0x8800
     5bc:	0000                	unimp
     5be:	0000                	unimp
     5c0:	0000                	unimp
     5c2:	0100                	addi	s0,sp,128
     5c4:	d49c                	sw	a5,40(s1)
     5c6:	08000003          	lb	zero,128(zero) # 80 <n+0x60>
     5ca:	01e5                	addi	gp,gp,25
     5cc:	0000                	unimp
     5ce:	1401                	addi	s0,s0,-32
     5d0:	d41a                	sw	t1,40(sp)
     5d2:	02000003          	lb	zero,32(zero) # 20 <n>
     5d6:	5891                	li	a7,-28
     5d8:	ea08                	sd	a0,16(a2)
     5da:	0001                	nop
     5dc:	0100                	addi	s0,sp,128
     5de:	2c14                	fld	fa3,24(s0)
     5e0:	03d4                	addi	a3,sp,452
     5e2:	0000                	unimp
     5e4:	9102                	jalr	sp
     5e6:	0950                	addi	a2,sp,148
     5e8:	756e                	ld	a0,248(sp)
     5ea:	006d                	c.nop	27
     5ec:	1401                	addi	s0,s0,-32
     5ee:	9936                	add	s2,s2,a3
     5f0:	0000                	unimp
     5f2:	0200                	addi	s0,sp,256
     5f4:	4c91                	li	s9,4
     5f6:	9a12                	add	s4,s4,tp
     5f8:	2001                	0x2001
     5fa:	0080                	addi	s0,sp,64
     5fc:	0000                	unimp
     5fe:	6a00                	ld	s0,16(a2)
     600:	0000                	unimp
     602:	0000                	unimp
     604:	0000                	unimp
     606:	0e00                	addi	s0,sp,784
     608:	0069                	c.nop	26
     60a:	1601                	addi	a2,a2,-32
     60c:	470e                	lw	a4,192(sp)
     60e:	0000                	unimp
     610:	0200                	addi	s0,sp,256
     612:	6c91                	lui	s9,0x4
     614:	0000                	unimp
     616:	080c                	addi	a1,sp,16
     618:	03da                	slli	t2,t2,0x16
     61a:	0000                	unimp
     61c:	017d0b13          	addi	s6,s10,23 # b017 <n+0xaff7>
     620:	0000                	unimp
     622:	0d01                	addi	s10,s10,0
     624:	3406                	fld	fs0,96(sp)
     626:	2001                	0x2001
     628:	0080                	addi	s0,sp,64
     62a:	0000                	unimp
     62c:	5200                	lw	s0,32(a2)
     62e:	0000                	unimp
     630:	0000                	unimp
     632:	0000                	unimp
     634:	0100                	addi	s0,sp,128
     636:	279c                	fld	fa5,8(a5)
     638:	0004                	0x4
     63a:	0800                	addi	s0,sp,16
     63c:	0000018f          	0x18f
     640:	0d01                	addi	s10,s10,0
     642:	00014b13          	xori	s6,sp,0
     646:	0200                	addi	s0,sp,256
     648:	6891                	lui	a7,0x4
     64a:	7309                	lui	t1,0xfffe2
     64c:	6372                	ld	t1,280(sp)
     64e:	0100                	addi	s0,sp,128
     650:	230d                	addiw	t1,t1,3
     652:	0151                	addi	sp,sp,20
     654:	0000                	unimp
     656:	9102                	jalr	sp
     658:	0960                	addi	s0,sp,156
     65a:	656c                	ld	a1,200(a0)
     65c:	006e                	c.slli	zero,0x1b
     65e:	0d01                	addi	s10,s10,0
     660:	992c                	0x992c
     662:	0000                	unimp
     664:	0200                	addi	s0,sp,256
     666:	5c91                	li	s9,-28
     668:	1400                	addi	s0,sp,544
     66a:	014a                	slli	sp,sp,0x12
     66c:	0000                	unimp
     66e:	0501                	addi	a0,a0,0
     670:	4705                	li	a4,1
     672:	0000                	unimp
     674:	fe00                	sd	s0,56(a2)
     676:	2000                	fld	fs0,0(s0)
     678:	0080                	addi	s0,sp,64
     67a:	0000                	unimp
     67c:	3600                	fld	fs0,40(a2)
     67e:	0000                	unimp
     680:	0000                	unimp
     682:	0000                	unimp
     684:	0100                	addi	s0,sp,128
     686:	099c                	addi	a5,sp,208
     688:	00637273          	csrrci	tp,0x6,6
     68c:	0501                	addi	a0,a0,0
     68e:	b91a                	fsd	ft6,176(sp)
     690:	0001                	nop
     692:	0200                	addi	s0,sp,256
     694:	5891                	li	a7,-28
     696:	690e                	ld	s2,192(sp)
     698:	0100                	addi	s0,sp,128
     69a:	00470907          	0x470907
     69e:	0000                	unimp
     6a0:	9102                	jalr	sp
     6a2:	006c                	addi	a1,sp,12
     6a4:	af00                	fsd	fs0,24(a4)
     6a6:	0002                	c.slli64	zero
     6a8:	0400                	addi	s0,sp,512
     6aa:	7500                	ld	s0,40(a0)
     6ac:	0002                	c.slli64	zero
     6ae:	0800                	addi	s0,sp,16
     6b0:	8b01                	andi	a4,a4,0
     6b2:	0000                	unimp
     6b4:	0c00                	addi	s0,sp,528
     6b6:	000001ef          	jal	gp,6b6 <n+0x696>
     6ba:	0059                	c.nop	22
     6bc:	0000                	unimp
     6be:	054c                	addi	a1,sp,644
     6c0:	8020                	0x8020
     6c2:	0000                	unimp
     6c4:	0000                	unimp
     6c6:	02c4                	addi	s1,sp,324
     6c8:	0000                	unimp
     6ca:	0000                	unimp
     6cc:	0000                	unimp
     6ce:	0619                	addi	a2,a2,6
     6d0:	0000                	unimp
     6d2:	0102                	c.slli64	sp
     6d4:	4406                	lw	s0,64(sp)
     6d6:	0000                	unimp
     6d8:	0200                	addi	s0,sp,256
     6da:	0502                	c.slli64	a0
     6dc:	0022                	c.slli	zero,0x8
     6de:	0000                	unimp
     6e0:	69050403          	lb	s0,1680(a0)
     6e4:	746e                	ld	s0,248(sp)
     6e6:	0200                	addi	s0,sp,256
     6e8:	0508                	addi	a0,sp,640
     6ea:	0050                	addi	a2,sp,4
     6ec:	0000                	unimp
     6ee:	0102                	c.slli64	sp
     6f0:	4208                	lw	a0,0(a2)
     6f2:	0000                	unimp
     6f4:	0200                	addi	s0,sp,256
     6f6:	0702                	c.slli64	a4
     6f8:	0000000f          	fence	unknown,unknown
     6fc:	d304                	sw	s1,32(a4)
     6fe:	0001                	nop
     700:	0200                	addi	s0,sp,256
     702:	160d                	addi	a2,a2,-29
     704:	00000063          	beqz	zero,704 <n+0x6e4>
     708:	0402                	c.slli64	s0
     70a:	00007e07          	0x7e07
     70e:	0400                	addi	s0,sp,512
     710:	0006                	c.slli	zero,0x1
     712:	0000                	unimp
     714:	0e02                	c.slli64	t3
     716:	0000761b          	0x761b
     71a:	0200                	addi	s0,sp,256
     71c:	0708                	addi	a0,sp,896
     71e:	0079                	c.nop	30
     720:	0000                	unimp
     722:	3305                	addiw	t1,t1,-31
     724:	0002                	c.slli64	zero
     726:	0100                	addi	s0,sp,128
     728:	0636                	slli	a2,a2,0xd
     72a:	0776                	slli	a4,a4,0x1d
     72c:	8020                	0x8020
     72e:	0000                	unimp
     730:	0000                	unimp
     732:	009a                	slli	ra,ra,0x6
     734:	0000                	unimp
     736:	0000                	unimp
     738:	0000                	unimp
     73a:	9c01                	subw	s0,s0,s0
     73c:	00fa                	slli	ra,ra,0x1e
     73e:	0000                	unimp
     740:	1006                	c.slli	zero,0x21
     742:	0006                	c.slli	zero,0x1
     744:	0100                	addi	s0,sp,128
     746:	2036                	fld	ft0,328(sp)
     748:	006a                	c.slli	zero,0x1a
     74a:	0000                	unimp
     74c:	9102                	jalr	sp
     74e:	0758                	addi	a4,sp,900
     750:	078e                	slli	a5,a5,0x3
     752:	8020                	0x8020
     754:	0000                	unimp
     756:	0000                	unimp
     758:	0076                	c.slli	zero,0x1d
     75a:	0000                	unimp
     75c:	0000                	unimp
     75e:	0000                	unimp
     760:	6908                	ld	a0,16(a0)
     762:	0100                	addi	s0,sp,128
     764:	0e39                	addi	t3,t3,14
     766:	0000003b          	addw	zero,zero,zero
     76a:	9102                	jalr	sp
     76c:	076c                	addi	a1,sp,908
     76e:	0796                	slli	a5,a5,0x5
     770:	8020                	0x8020
     772:	0000                	unimp
     774:	0000                	unimp
     776:	005a                	c.slli	zero,0x16
     778:	0000                	unimp
     77a:	0000                	unimp
     77c:	0000                	unimp
     77e:	5009                	c.li	zero,-30
     780:	0002                	c.slli64	zero
     782:	0100                	addi	s0,sp,128
     784:	003b0d3b          	addw	s10,s6,gp
     788:	0000                	unimp
     78a:	9102                	jalr	sp
     78c:	0868                	addi	a0,sp,28
     78e:	6568                	ld	a0,200(a0)
     790:	0078                	addi	a4,sp,12
     792:	3c01                	addiw	s8,s8,-32
     794:	fa0e                	sd	gp,304(sp)
     796:	0000                	unimp
     798:	0200                	addi	s0,sp,256
     79a:	6791                	lui	a5,0x4
     79c:	0000                	unimp
     79e:	0200                	addi	s0,sp,256
     7a0:	0801                	addi	a6,a6,0
     7a2:	0000004b          	fnmsub.s	ft0,ft0,ft0,ft0,rne
     7a6:	fa0a                	sd	sp,304(sp)
     7a8:	0000                	unimp
     7aa:	0500                	addi	s0,sp,640
     7ac:	0219                	addi	tp,tp,6
     7ae:	0000                	unimp
     7b0:	2601                	sext.w	a2,a2
     7b2:	ca06                	sw	ra,20(sp)
     7b4:	2006                	fld	ft0,64(sp)
     7b6:	0080                	addi	s0,sp,64
     7b8:	0000                	unimp
     7ba:	ac00                	fsd	fs0,24(s0)
     7bc:	0000                	unimp
     7be:	0000                	unimp
     7c0:	0000                	unimp
     7c2:	0100                	addi	s0,sp,128
     7c4:	719c                	ld	a5,32(a1)
     7c6:	0001                	nop
     7c8:	0600                	addi	s0,sp,768
     7ca:	0610                	addi	a2,sp,768
     7cc:	0000                	unimp
     7ce:	2601                	sext.w	a2,a2
     7d0:	6a1c                	ld	a5,16(a2)
     7d2:	0000                	unimp
     7d4:	0200                	addi	s0,sp,256
     7d6:	4891                	li	a7,4
     7d8:	5609                	li	a2,-30
     7da:	0002                	c.slli64	zero
     7dc:	0100                	addi	s0,sp,128
     7de:	01710a27          	0x1710a27
     7e2:	0000                	unimp
     7e4:	9102                	jalr	sp
     7e6:	0850                	addi	a2,sp,20
     7e8:	0069                	c.nop	26
     7ea:	2801                	sext.w	a6,a6
     7ec:	3b09                	addiw	s6,s6,-30
     7ee:	0000                	unimp
     7f0:	0200                	addi	s0,sp,256
     7f2:	6c91                	lui	s9,0x4
     7f4:	2006fc07          	0x2006fc07
     7f8:	0080                	addi	s0,sp,64
     7fa:	0000                	unimp
     7fc:	4200                	lw	s0,0(a2)
     7fe:	0000                	unimp
     800:	0000                	unimp
     802:	0000                	unimp
     804:	0900                	addi	s0,sp,144
     806:	0250                	addi	a2,sp,260
     808:	0000                	unimp
     80a:	2d01                	sext.w	s10,s10
     80c:	3b0d                	addiw	s6,s6,-29
     80e:	0000                	unimp
     810:	0200                	addi	s0,sp,256
     812:	6891                	lui	a7,0x4
     814:	0000                	unimp
     816:	0000fa0b          	0xfa0b
     81a:	8100                	0x8100
     81c:	0001                	nop
     81e:	0c00                	addi	s0,sp,528
     820:	0076                	c.slli	zero,0x1d
     822:	0000                	unimp
     824:	0014                	0x14
     826:	2605                	addiw	a2,a2,1
     828:	0002                	c.slli64	zero
     82a:	0100                	addi	s0,sp,128
     82c:	0616                	slli	a2,a2,0x5
     82e:	0616                	slli	a2,a2,0x5
     830:	8020                	0x8020
     832:	0000                	unimp
     834:	0000                	unimp
     836:	00b4                	addi	a3,sp,72
     838:	0000                	unimp
     83a:	0000                	unimp
     83c:	0000                	unimp
     83e:	9c01                	subw	s0,s0,s0
     840:	01ec                	addi	a1,sp,204
     842:	0000                	unimp
     844:	1006                	c.slli	zero,0x21
     846:	0006                	c.slli	zero,0x1
     848:	0100                	addi	s0,sp,128
     84a:	1c16                	slli	s8,s8,0x25
     84c:	00000057          	0x57
     850:	9102                	jalr	sp
     852:	094c                	addi	a1,sp,148
     854:	0256                	slli	tp,tp,0x15
     856:	0000                	unimp
     858:	1701                	addi	a4,a4,-32
     85a:	ec0a                	sd	sp,24(sp)
     85c:	0001                	nop
     85e:	0200                	addi	s0,sp,256
     860:	5891                	li	a7,-28
     862:	6908                	ld	a0,16(a0)
     864:	0100                	addi	s0,sp,128
     866:	0918                	addi	a4,sp,144
     868:	0000003b          	addw	zero,zero,zero
     86c:	9102                	jalr	sp
     86e:	076c                	addi	a1,sp,908
     870:	064c                	addi	a1,sp,772
     872:	8020                	0x8020
     874:	0000                	unimp
     876:	0000                	unimp
     878:	0044                	addi	s1,sp,4
     87a:	0000                	unimp
     87c:	0000                	unimp
     87e:	0000                	unimp
     880:	5009                	c.li	zero,-30
     882:	0002                	c.slli64	zero
     884:	0100                	addi	s0,sp,128
     886:	0d1d                	addi	s10,s10,7
     888:	0000003b          	addw	zero,zero,zero
     88c:	9102                	jalr	sp
     88e:	0068                	addi	a0,sp,12
     890:	0b00                	addi	s0,sp,400
     892:	00fa                	slli	ra,ra,0x1e
     894:	0000                	unimp
     896:	01fc                	addi	a5,sp,204
     898:	0000                	unimp
     89a:	760c                	ld	a1,40(a2)
     89c:	0000                	unimp
     89e:	0b00                	addi	s0,sp,400
     8a0:	0d00                	addi	s0,sp,656
     8a2:	0244                	addi	s1,sp,260
     8a4:	0000                	unimp
     8a6:	0a01                	addi	s4,s4,0
     8a8:	8806                	mv	a6,ra
     8aa:	2005                	0x2005
     8ac:	0080                	addi	s0,sp,64
     8ae:	0000                	unimp
     8b0:	8e00                	0x8e00
     8b2:	0000                	unimp
     8b4:	0000                	unimp
     8b6:	0000                	unimp
     8b8:	0100                	addi	s0,sp,128
     8ba:	789c                	ld	a5,48(s1)
     8bc:	0002                	c.slli64	zero
     8be:	0e00                	addi	s0,sp,784
     8c0:	00727473          	csrrci	s0,0x7,4
     8c4:	0a01                	addi	s4,s4,0
     8c6:	7818                	ld	a4,48(s0)
     8c8:	0002                	c.slli64	zero
     8ca:	0200                	addi	s0,sp,256
     8cc:	5891                	li	a7,-28
     8ce:	0806                	slli	a6,a6,0x1
     8d0:	0002                	c.slli64	zero
     8d2:	0100                	addi	s0,sp,128
     8d4:	210a                	fld	ft2,128(sp)
     8d6:	0000003b          	addw	zero,zero,zero
     8da:	9102                	jalr	sp
     8dc:	0954                	addi	a3,sp,148
     8de:	000003f3          	0x3f3
     8e2:	0b01                	addi	s6,s6,0
     8e4:	3b09                	addiw	s6,s6,-30
     8e6:	0000                	unimp
     8e8:	0200                	addi	s0,sp,256
     8ea:	6c91                	lui	s9,0x4
     8ec:	6508                	ld	a0,8(a0)
     8ee:	646e                	ld	s0,216(sp)
     8f0:	0100                	addi	s0,sp,128
     8f2:	090c                	addi	a1,sp,144
     8f4:	0000003b          	addw	zero,zero,zero
     8f8:	9102                	jalr	sp
     8fa:	0768                	addi	a0,sp,908
     8fc:	05a8                	addi	a0,sp,712
     8fe:	8020                	0x8020
     900:	0000                	unimp
     902:	0000                	unimp
     904:	0054                	addi	a3,sp,4
     906:	0000                	unimp
     908:	0000                	unimp
     90a:	0000                	unimp
     90c:	9d09                	subw	a0,a0,a0
     90e:	0001                	nop
     910:	0100                	addi	s0,sp,128
     912:	0e0e                	slli	t3,t3,0x3
     914:	00fa                	slli	ra,ra,0x1e
     916:	0000                	unimp
     918:	9102                	jalr	sp
     91a:	0f000067          	jr	240(zero) # 0 <n-0xc>
     91e:	fa08                	sd	a0,48(a2)
     920:	0000                	unimp
     922:	0500                	addi	s0,sp,640
     924:	0000020f          	0x20f
     928:	0301                	addi	t1,t1,0
     92a:	4c06                	lw	s8,64(sp)
     92c:	2005                	0x2005
     92e:	0080                	addi	s0,sp,64
     930:	0000                	unimp
     932:	3c00                	fld	fs0,56(s0)
     934:	0000                	unimp
     936:	0000                	unimp
     938:	0000                	unimp
     93a:	0100                	addi	s0,sp,128
     93c:	ac9c                	fsd	fa5,24(s1)
     93e:	0002                	c.slli64	zero
     940:	0e00                	addi	s0,sp,784
     942:	00727473          	csrrci	s0,0x7,4
     946:	0301                	addi	t1,t1,0
     948:	ac1c                	fsd	fa5,24(s0)
     94a:	0002                	c.slli64	zero
     94c:	0200                	addi	s0,sp,256
     94e:	6891                	lui	a7,0x4
     950:	0f00                	addi	s0,sp,912
     952:	0108                	addi	a0,sp,128
     954:	0001                	nop
     956:	0000                	unimp
     958:	00b1                	addi	ra,ra,12
     95a:	0000                	unimp
     95c:	0004                	0x4
     95e:	0355                	addi	t1,t1,21
     960:	0000                	unimp
     962:	0108                	addi	a0,sp,128
     964:	0000008b          	0x8b
     968:	6d0c                	ld	a1,24(a0)
     96a:	0002                	c.slli64	zero
     96c:	5900                	lw	s0,48(a0)
     96e:	0000                	unimp
     970:	1000                	addi	s0,sp,32
     972:	2008                	fld	fa0,0(s0)
     974:	0080                	addi	s0,sp,64
     976:	0000                	unimp
     978:	4e00                	lw	s0,24(a2)
     97a:	0000                	unimp
     97c:	0000                	unimp
     97e:	0000                	unimp
     980:	fe00                	sd	s0,56(a2)
     982:	0008                	0x8
     984:	0200                	addi	s0,sp,256
     986:	0601                	addi	a2,a2,0
     988:	0044                	addi	s1,sp,4
     98a:	0000                	unimp
     98c:	0202                	c.slli64	tp
     98e:	2205                	addiw	tp,tp,1
     990:	0000                	unimp
     992:	0300                	addi	s0,sp,384
     994:	0504                	addi	s1,sp,640
     996:	6e69                	lui	t3,0x1a
     998:	0074                	addi	a3,sp,12
     99a:	0802                	c.slli64	a6
     99c:	5005                	c.li	zero,-31
     99e:	0000                	unimp
     9a0:	0200                	addi	s0,sp,256
     9a2:	0801                	addi	a6,a6,0
     9a4:	0042                	c.slli	zero,0x10
     9a6:	0000                	unimp
     9a8:	0202                	c.slli64	tp
     9aa:	00000f07          	0xf07
     9ae:	0200                	addi	s0,sp,256
     9b0:	0704                	addi	s1,sp,896
     9b2:	007e                	c.slli	zero,0x1f
     9b4:	0000                	unimp
     9b6:	0802                	c.slli64	a6
     9b8:	00007907          	0x7907
     9bc:	0400                	addi	s0,sp,512
     9be:	0262                	slli	tp,tp,0x18
     9c0:	0000                	unimp
     9c2:	0301                	addi	t1,t1,0
     9c4:	1006                	c.slli	zero,0x21
     9c6:	2008                	fld	fa0,0(s0)
     9c8:	0080                	addi	s0,sp,64
     9ca:	0000                	unimp
     9cc:	4e00                	lw	s0,24(a2)
     9ce:	0000                	unimp
     9d0:	0000                	unimp
     9d2:	0000                	unimp
     9d4:	0100                	addi	s0,sp,128
     9d6:	a29c                	fsd	fa5,0(a3)
     9d8:	0000                	unimp
     9da:	0500                	addi	s0,sp,640
     9dc:	0268                	addi	a0,sp,268
     9de:	0000                	unimp
     9e0:	0301                	addi	t1,t1,0
     9e2:	a218                	fsd	fa4,0(a2)
     9e4:	0000                	unimp
     9e6:	0200                	addi	s0,sp,256
     9e8:	6891                	lui	a7,0x4
     9ea:	5d05                	li	s10,-31
     9ec:	0002                	c.slli64	zero
     9ee:	0100                	addi	s0,sp,128
     9f0:	003b2203          	lw	tp,3(s6) # 18003 <n+0x17fe3>
     9f4:	0000                	unimp
     9f6:	9102                	jalr	sp
     9f8:	0064                	addi	s1,sp,12
     9fa:	0806                	slli	a6,a6,0x1
     9fc:	000000af          	0xaf
     a00:	0102                	c.slli64	sp
     a02:	4b08                	lw	a0,16(a4)
     a04:	0000                	unimp
     a06:	0700                	addi	s0,sp,896
     a08:	00a8                	addi	a0,sp,72
     a0a:	0000                	unimp
     a0c:	df00                	sw	s0,56(a4)
     a0e:	0002                	c.slli64	zero
     a10:	0400                	addi	s0,sp,512
     a12:	bc00                	fsd	fs0,56(s0)
     a14:	08000003          	lb	zero,128(zero) # 80 <n+0x60>
     a18:	8b01                	andi	a4,a4,0
     a1a:	0000                	unimp
     a1c:	0c00                	addi	s0,sp,528
     a1e:	0319                	addi	t1,t1,6
     a20:	0000                	unimp
     a22:	0059                	c.nop	22
     a24:	0000                	unimp
     a26:	085e                	slli	a6,a6,0x17
     a28:	8020                	0x8020
     a2a:	0000                	unimp
     a2c:	0000                	unimp
     a2e:	02e6                	slli	t0,t0,0x19
     a30:	0000                	unimp
     a32:	0000                	unimp
     a34:	0000                	unimp
     a36:	0979                	addi	s2,s2,30
     a38:	0000                	unimp
     a3a:	0102                	c.slli64	sp
     a3c:	4406                	lw	s0,64(sp)
     a3e:	0000                	unimp
     a40:	0200                	addi	s0,sp,256
     a42:	0502                	c.slli64	a0
     a44:	0022                	c.slli	zero,0x8
     a46:	0000                	unimp
     a48:	69050403          	lb	s0,1680(a0)
     a4c:	746e                	ld	s0,248(sp)
     a4e:	0200                	addi	s0,sp,256
     a50:	0508                	addi	a0,sp,640
     a52:	0050                	addi	a2,sp,4
     a54:	0000                	unimp
     a56:	0102                	c.slli64	sp
     a58:	4208                	lw	a0,0(a2)
     a5a:	0000                	unimp
     a5c:	0200                	addi	s0,sp,256
     a5e:	0702                	c.slli64	a4
     a60:	0000000f          	fence	unknown,unknown
     a64:	0402                	c.slli64	s0
     a66:	00007e07          	0x7e07
     a6a:	0400                	addi	s0,sp,512
     a6c:	0006                	c.slli	zero,0x1
     a6e:	0000                	unimp
     a70:	0e04                	addi	s1,sp,784
     a72:	00006a1b          	0x6a1b
     a76:	0200                	addi	s0,sp,256
     a78:	0708                	addi	a0,sp,896
     a7a:	0079                	c.nop	30
     a7c:	0000                	unimp
     a7e:	0305                	addi	t1,t1,1
     a80:	0005                	c.nop	1
     a82:	1000                	addi	s0,sp,32
     a84:	0201                	addi	tp,tp,0
     a86:	0804                	addi	s1,sp,16
     a88:	000000a7          	0xa7
     a8c:	7806                	ld	a6,96(sp)
     a8e:	0200                	addi	s0,sp,256
     a90:	0e06                	slli	t3,t3,0x1
     a92:	000000a7          	0xa7
     a96:	0700                	addi	s0,sp,896
     a98:	05b1                	addi	a1,a1,12
     a9a:	0000                	unimp
     a9c:	0702                	c.slli64	a4
     a9e:	5e0e                	lw	t3,224(sp)
     aa0:	0000                	unimp
     aa2:	0000                	unimp
     aa4:	0701                	addi	a4,a4,0
     aa6:	000005d7          	0x5d7
     aaa:	0802                	c.slli64	a6
     aac:	5e0e                	lw	t3,224(sp)
     aae:	0000                	unimp
     ab0:	0800                	addi	s0,sp,16
     ab2:	0001                	nop
     ab4:	5e08                	lw	a0,56(a2)
     ab6:	0000                	unimp
     ab8:	b700                	fsd	fs0,40(a4)
     aba:	0000                	unimp
     abc:	0900                	addi	s0,sp,144
     abe:	006a                	c.slli	zero,0x1a
     ac0:	0000                	unimp
     ac2:	001f b50a 0002      	0x2b50a001f
     ac8:	0700                	addi	s0,sp,896
     aca:	5704                	lw	s1,40(a4)
     acc:	0000                	unimp
     ace:	0300                	addi	s0,sp,384
     ad0:	0606                	slli	a2,a2,0x1
     ad2:	00e2                	slli	ra,ra,0x18
     ad4:	0000                	unimp
     ad6:	0003380b          	0x3380b
     ada:	0000                	unimp
     adc:	0003040b          	0x3040b
     ae0:	0100                	addi	s0,sp,128
     ae2:	00035c0b          	0x35c0b
     ae6:	0200                	addi	s0,sp,256
     ae8:	0003550b          	0x3550b
     aec:	0300                	addi	s0,sp,384
     aee:	0c00                	addi	s0,sp,528
     af0:	038a                	slli	t2,t2,0x2
     af2:	0000                	unimp
     af4:	0370                	addi	a2,sp,396
     af6:	080e                	slli	a6,a6,0x3
     af8:	00000113          	li	sp,0
     afc:	7206                	ld	tp,96(sp)
     afe:	0061                	c.nop	24
     b00:	5e0e1003          	lh	zero,1504(t3) # 1a5e0 <n+0x1a5c0>
     b04:	0000                	unimp
     b06:	0000                	unimp
     b08:	7306                	ld	t1,96(sp)
     b0a:	0070                	addi	a2,sp,12
     b0c:	5e0e1103          	lh	sp,1504(t3)
     b10:	0000                	unimp
     b12:	0800                	addi	s0,sp,16
     b14:	7806                	ld	a6,96(sp)
     b16:	0300                	addi	s0,sp,384
     b18:	0e12                	slli	t3,t3,0x4
     b1a:	00000113          	li	sp,0
     b1e:	0010                	0x10
     b20:	5e08                	lw	a0,56(a2)
     b22:	0000                	unimp
     b24:	2300                	fld	fs0,0(a4)
     b26:	0001                	nop
     b28:	0900                	addi	s0,sp,144
     b2a:	006a                	c.slli	zero,0x1a
     b2c:	0000                	unimp
     b2e:	790c000b          	0x790c000b
     b32:	78000003          	lb	zero,1920(zero) # 780 <n+0x760>
     b36:	4b081503          	lh	a0,1200(a6) # ffffffffffff94b0 <ebss+0xffffffff7fd9e568>
     b3a:	0001                	nop
     b3c:	0d00                	addi	s0,sp,656
     b3e:	0364                	addi	s1,sp,396
     b40:	0000                	unimp
     b42:	e2181703          	lh	a4,-479(a6)
     b46:	0000                	unimp
     b48:	0000                	unimp
     b4a:	490d                	li	s2,3
     b4c:	03000003          	lb	zero,48(zero) # 30 <n+0x10>
     b50:	1518                	addi	a4,sp,672
     b52:	000000b7          	lui	ra,0x0
     b56:	0070                	addi	a2,sp,12
     b58:	9605                	srai	a2,a2,0x21
     b5a:	70000003          	lb	zero,1792(zero) # 700 <n+0x6e0>
     b5e:	0309                	addi	t1,t1,2
     b60:	0181081b          	addiw	a6,sp,24
     b64:	0000                	unimp
     b66:	c60d                	beqz	a2,b90 <n+0xb70>
     b68:	0002                	c.slli64	zero
     b6a:	0300                	addi	s0,sp,384
     b6c:	0e1d                	addi	t3,t3,7
     b6e:	005e                	c.slli	zero,0x17
     b70:	0000                	unimp
     b72:	0d00                	addi	s0,sp,656
     b74:	02ed                	addi	t0,t0,27
     b76:	0000                	unimp
     b78:	5e0e1e03          	lh	t3,1504(t3)
     b7c:	0000                	unimp
     b7e:	0800                	addi	s0,sp,16
     b80:	320d                	addiw	tp,tp,-29
     b82:	03000003          	lb	zero,48(zero) # 30 <n+0x10>
     b86:	1d1f 0181 0000      	0x1811d1f
     b8c:	0010                	0x10
     b8e:	2308                	fld	fa0,0(a4)
     b90:	0001                	nop
     b92:	9100                	0x9100
     b94:	0001                	nop
     b96:	0900                	addi	s0,sp,144
     b98:	006a                	c.slli	zero,0x1a
     b9a:	0000                	unimp
     b9c:	6c0e0013          	addi	zero,t3,1728
     ba0:	03000003          	lb	zero,48(zero) # 30 <n+0x10>
     ba4:	1b22                	slli	s6,s6,0x28
     ba6:	0000014b          	fnmsub.s	ft2,ft0,ft0,ft0,rne
     baa:	0001910f          	0x1910f
     bae:	0100                	addi	s0,sp,128
     bb0:	1408                	addi	a0,sp,544
     bb2:	0309                	addi	t1,t1,2
     bb4:	a008                	fsd	fa0,0(s0)
     bb6:	8020                	0x8020
     bb8:	0000                	unimp
     bba:	0000                	unimp
     bbc:	0a10                	addi	a2,sp,272
     bbe:	01000003          	lb	zero,16(zero) # 10 <n+0x4>
     bc2:	0649                	addi	a2,a2,18
     bc4:	0ac6                	slli	s5,s5,0x11
     bc6:	8020                	0x8020
     bc8:	0000                	unimp
     bca:	0000                	unimp
     bcc:	007e                	c.slli	zero,0x1f
     bce:	0000                	unimp
     bd0:	0000                	unimp
     bd2:	0000                	unimp
     bd4:	9c01                	subw	s0,s0,s0
     bd6:	01e4                	addi	s1,sp,204
     bd8:	0000                	unimp
     bda:	9d11                	subw	a0,a0,a2
     bdc:	0001                	nop
     bde:	0100                	addi	s0,sp,128
     be0:	00e21f4b          	fnmsub.s	ft10,ft4,fa4,ft0,rtz
     be4:	0000                	unimp
     be6:	0309                	addi	t1,t1,2
     be8:	a978                	fsd	fa4,208(a0)
     bea:	8020                	0x8020
     bec:	0000                	unimp
     bee:	0000                	unimp
     bf0:	1000                	addi	s0,sp,32
     bf2:	02df 0000 2e01      	0x2e01000002df
     bf8:	9206                	add	tp,tp,ra
     bfa:	2009                	0x2009
     bfc:	0080                	addi	s0,sp,64
     bfe:	0000                	unimp
     c00:	3400                	fld	fs0,40(s0)
     c02:	0001                	nop
     c04:	0000                	unimp
     c06:	0000                	unimp
     c08:	0100                	addi	s0,sp,128
     c0a:	3f9c                	fld	fa5,56(a5)
     c0c:	0002                	c.slli64	zero
     c0e:	1200                	addi	s0,sp,288
     c10:	034e                	slli	t1,t1,0x13
     c12:	0000                	unimp
     c14:	2e01                	sext.w	t3,t3
     c16:	5e1d                	li	t3,-25
     c18:	0000                	unimp
     c1a:	0200                	addi	s0,sp,256
     c1c:	4891                	li	a7,4
     c1e:	cf11                	beqz	a4,c3a <n+0xc1a>
     c20:	0002                	c.slli64	zero
     c22:	0100                	addi	s0,sp,128
     c24:	0e31                	addi	t3,t3,12
     c26:	005e                	c.slli	zero,0x17
     c28:	0000                	unimp
     c2a:	9102                	jalr	sp
     c2c:	1168                	addi	a0,sp,172
     c2e:	0282                	c.slli64	t0
     c30:	0000                	unimp
     c32:	3c01                	addiw	s8,s8,-32
     c34:	3f1e                	fld	ft10,480(sp)
     c36:	0002                	c.slli64	zero
     c38:	0200                	addi	s0,sp,256
     c3a:	6091                	lui	ra,0x4
     c3c:	9211                	srli	a2,a2,0x24
     c3e:	0002                	c.slli64	zero
     c40:	0100                	addi	s0,sp,128
     c42:	1e3d                	addi	t3,t3,-17
     c44:	0000023f 00589102 	0x5891020000023f
     c4c:	01230813          	addi	a6,t1,18 # fffffffffffe2012 <ebss+0xffffffff7fd870ca>
     c50:	0000                	unimp
     c52:	a314                	fsd	fa3,0(a4)
     c54:	0002                	c.slli64	zero
     c56:	0100                	addi	s0,sp,128
     c58:	060c                	addi	a1,sp,768
     c5a:	085e                	slli	a6,a6,0x17
     c5c:	8020                	0x8020
     c5e:	0000                	unimp
     c60:	0000                	unimp
     c62:	0134                	addi	a3,sp,136
     c64:	0000                	unimp
     c66:	0000                	unimp
     c68:	0000                	unimp
     c6a:	9c01                	subw	s0,s0,s0
     c6c:	fa15                	bnez	a2,ba0 <n+0xb80>
     c6e:	0002                	c.slli64	zero
     c70:	0100                	addi	s0,sp,128
     c72:	110e                	slli	sp,sp,0x23
     c74:	0271                	addi	tp,tp,28
     c76:	0000                	unimp
     c78:	5e16                	lw	t3,100(sp)
     c7a:	0000                	unimp
     c7c:	0000                	unimp
     c7e:	2008a417          	auipc	s0,0x2008a
     c82:	0080                	addi	s0,sp,64
     c84:	0000                	unimp
     c86:	e200                	sd	s0,0(a2)
     c88:	0000                	unimp
     c8a:	0000                	unimp
     c8c:	0000                	unimp
     c8e:	1800                	addi	s0,sp,48
     c90:	0069                	c.nop	26
     c92:	1601                	addi	a2,a2,-32
     c94:	5e12                	lw	t3,36(sp)
     c96:	0000                	unimp
     c98:	0200                	addi	s0,sp,256
     c9a:	6891                	lui	a7,0x4
     c9c:	2008aa17          	auipc	s4,0x2008a
     ca0:	0080                	addi	s0,sp,64
     ca2:	0000                	unimp
     ca4:	c800                	sw	s0,16(s0)
     ca6:	0000                	unimp
     ca8:	0000                	unimp
     caa:	0000                	unimp
     cac:	1100                	addi	s0,sp,160
     cae:	0000033f 5e121a01 	0x5e121a010000033f
     cb6:	0000                	unimp
     cb8:	0200                	addi	s0,sp,256
     cba:	6091                	lui	ra,0x4
     cbc:	7418                	ld	a4,40(s0)
     cbe:	20010063          	beqz	sp,ebe <n+0xe9e>
     cc2:	711c                	ld	a5,32(a0)
     cc4:	0000                	unimp
     cc6:	0300                	addi	s0,sp,384
     cc8:	c891                	beqz	s1,cdc <n+0xcbc>
     cca:	177d                	addi	a4,a4,-1
     ccc:	0938                	addi	a4,sp,152
     cce:	8020                	0x8020
     cd0:	0000                	unimp
     cd2:	0000                	unimp
     cd4:	000c                	0xc
     cd6:	0000                	unimp
     cd8:	0000                	unimp
     cda:	0000                	unimp
     cdc:	c011                	beqz	s0,ce0 <n+0xcc0>
     cde:	0002                	c.slli64	zero
     ce0:	0100                	addi	s0,sp,128
     ce2:	1626                	slli	a2,a2,0x29
     ce4:	006a                	c.slli	zero,0x1a
     ce6:	0000                	unimp
     ce8:	9102                	jalr	sp
     cea:	0058                	addi	a4,sp,4
     cec:	0000                	unimp
     cee:	0000                	unimp
     cf0:	03bd                	addi	t2,t2,15
     cf2:	0000                	unimp
     cf4:	0004                	0x4
     cf6:	00000533          	add	a0,zero,zero
     cfa:	0108                	addi	a0,sp,128
     cfc:	0000008b          	0x8b
     d00:	b30c                	fsd	fa1,32(a4)
     d02:	59000003          	lb	zero,1424(zero) # 590 <n+0x570>
     d06:	0000                	unimp
     d08:	4400                	lw	s0,8(s0)
     d0a:	0080200b          	0x80200b
     d0e:	0000                	unimp
     d10:	2200                	fld	fs0,0(a2)
     d12:	0005                	c.nop	1
     d14:	0000                	unimp
     d16:	0000                	unimp
     d18:	4000                	lw	s0,0(s0)
     d1a:	000c                	0xc
     d1c:	0200                	addi	s0,sp,256
     d1e:	0601                	addi	a2,a2,0
     d20:	0044                	addi	s1,sp,4
     d22:	0000                	unimp
     d24:	0202                	c.slli64	tp
     d26:	2205                	addiw	tp,tp,1
     d28:	0000                	unimp
     d2a:	0300                	addi	s0,sp,384
     d2c:	0504                	addi	s1,sp,640
     d2e:	6e69                	lui	t3,0x1a
     d30:	0074                	addi	a3,sp,12
     d32:	0802                	c.slli64	a6
     d34:	5005                	c.li	zero,-31
     d36:	0000                	unimp
     d38:	0400                	addi	s0,sp,512
     d3a:	01bc                	addi	a5,sp,200
     d3c:	0000                	unimp
     d3e:	0b02                	c.slli64	s6
     d40:	00005517          	auipc	a0,0x5
     d44:	0200                	addi	s0,sp,256
     d46:	0801                	addi	a6,a6,0
     d48:	0042                	c.slli	zero,0x10
     d4a:	0000                	unimp
     d4c:	0202                	c.slli64	tp
     d4e:	00000f07          	0xf07
     d52:	0200                	addi	s0,sp,256
     d54:	0704                	addi	s1,sp,896
     d56:	007e                	c.slli	zero,0x1f
     d58:	0000                	unimp
     d5a:	0604                	addi	s1,sp,768
     d5c:	0000                	unimp
     d5e:	0200                	addi	s0,sp,256
     d60:	1b0e                	slli	s6,s6,0x23
     d62:	0076                	c.slli	zero,0x1d
     d64:	0000                	unimp
     d66:	0802                	c.slli64	a6
     d68:	00007907          	0x7907
     d6c:	0400                	addi	s0,sp,512
     d6e:	03a9                	addi	t2,t2,10
     d70:	0000                	unimp
     d72:	1202                	slli	tp,tp,0x20
     d74:	0000761b          	0x761b
     d78:	0500                	addi	s0,sp,640
     d7a:	00000503          	lb	a0,0(zero) # 0 <n-0xc>
     d7e:	0110                	addi	a2,sp,128
     d80:	bf080403          	lb	s0,-1040(a6)
     d84:	0000                	unimp
     d86:	0600                	addi	s0,sp,768
     d88:	0078                	addi	a4,sp,12
     d8a:	bf0e0603          	lb	a2,-1040(t3) # 19bf0 <n+0x19bd0>
     d8e:	0000                	unimp
     d90:	0000                	unimp
     d92:	0005b107          	fld	ft2,0(a1)
     d96:	0300                	addi	s0,sp,384
     d98:	006a0e07          	0x6a0e07
     d9c:	0000                	unimp
     d9e:	0100                	addi	s0,sp,128
     da0:	0005d707          	0x5d707
     da4:	0300                	addi	s0,sp,384
     da6:	0e08                	addi	a0,sp,784
     da8:	006a                	c.slli	zero,0x1a
     daa:	0000                	unimp
     dac:	0108                	addi	a0,sp,128
     dae:	0800                	addi	s0,sp,16
     db0:	006a                	c.slli	zero,0x1a
     db2:	0000                	unimp
     db4:	000000cf          	fnmadd.s	ft1,ft0,ft0,ft0,rne
     db8:	7609                	lui	a2,0xfffe2
     dba:	0000                	unimp
     dbc:	1f00                	addi	s0,sp,944
     dbe:	0500                	addi	s0,sp,640
     dc0:	0401                	addi	s0,s0,0
     dc2:	0000                	unimp
     dc4:	0150                	addi	a2,sp,132
     dc6:	0904                	addi	s1,sp,144
     dc8:	1208                	addi	a0,sp,288
     dca:	0001                	nop
     dcc:	0a00                	addi	s0,sp,272
     dce:	0000044f          	fnmadd.s	fs0,ft0,ft0,ft0,rne
     dd2:	0b04                	addi	s1,sp,400
     dd4:	6a0e                	ld	s4,192(sp)
     dd6:	0000                	unimp
     dd8:	0000                	unimp
     dda:	7d0a                	ld	s10,160(sp)
     ddc:	0004                	0x4
     dde:	0400                	addi	s0,sp,512
     de0:	0e0c                	addi	a1,sp,784
     de2:	006a                	c.slli	zero,0x1a
     de4:	0000                	unimp
     de6:	0a08                	addi	a0,sp,272
     de8:	000003ef          	jal	t2,de8 <n+0xdc8>
     dec:	0d04                	addi	s1,sp,656
     dee:	0001120f          	0x1120f
     df2:	1000                	addi	s0,sp,32
     df4:	f90a                	sd	sp,176(sp)
     df6:	04000003          	lb	zero,64(zero) # 40 <n+0x20>
     dfa:	0f0e                	slli	t5,t5,0x3
     dfc:	0112                	slli	sp,sp,0x4
     dfe:	0000                	unimp
     e00:	00b0                	addi	a2,sp,72
     e02:	7d08                	ld	a0,56(a0)
     e04:	0000                	unimp
     e06:	2200                	fld	fs0,0(a2)
     e08:	0001                	nop
     e0a:	0900                	addi	s0,sp,144
     e0c:	0076                	c.slli	zero,0x1d
     e0e:	0000                	unimp
     e10:	570b0013          	addi	zero,s6,1392
     e14:	0004                	0x4
     e16:	0400                	addi	s0,sp,512
     e18:	1a10                	addi	a2,sp,304
     e1a:	000000cf          	fnmadd.s	ft1,ft0,ft0,ft0,rne
     e1e:	6a08                	ld	a0,16(a2)
     e20:	0000                	unimp
     e22:	3900                	fld	fs0,48(a0)
     e24:	0001                	nop
     e26:	0c00                	addi	s0,sp,528
     e28:	0b00                	addi	s0,sp,400
     e2a:	0000042f          	0x42f
     e2e:	1104                	addi	s1,sp,160
     e30:	2e11                	addiw	t3,t3,4
     e32:	0001                	nop
     e34:	0800                	addi	s0,sp,16
     e36:	0049                	c.nop	18
     e38:	0000                	unimp
     e3a:	015c                	addi	a5,sp,132
     e3c:	0000                	unimp
     e3e:	7609                	lui	a2,0xfffe2
     e40:	0000                	unimp
     e42:	1300                	addi	s0,sp,416
     e44:	760d                	lui	a2,0xfffe3
     e46:	0000                	unimp
     e48:	ff00                	sd	s0,56(a4)
     e4a:	001f 1c0b 0004      	0x41c0b001f
     e50:	0500                	addi	s0,sp,640
     e52:	01451007          	0x1451007
     e56:	0000                	unimp
     e58:	220e                	fld	ft4,192(sp)
     e5a:	0001                	nop
     e5c:	0100                	addi	s0,sp,128
     e5e:	1309                	addi	t1,t1,-30
     e60:	0309                	addi	t1,t1,2
     e62:	a9e8                	fsd	fa0,208(a1)
     e64:	8020                	0x8020
     e66:	0000                	unimp
     e68:	0000                	unimp
     e6a:	0003e10f          	0x3e10f
     e6e:	0100                	addi	s0,sp,128
     e70:	0665                	addi	a2,a2,25
     e72:	0f6c                	addi	a1,sp,924
     e74:	8020                	0x8020
     e76:	0000                	unimp
     e78:	0000                	unimp
     e7a:	00fa                	slli	ra,ra,0x1e
     e7c:	0000                	unimp
     e7e:	0000                	unimp
     e80:	0000                	unimp
     e82:	9c01                	subw	s0,s0,s0
     e84:	0231                	addi	tp,tp,12
     e86:	0000                	unimp
     e88:	00042f0b          	0x42f0b
     e8c:	0100                	addi	s0,sp,128
     e8e:	1568                	addi	a0,sp,684
     e90:	012e                	slli	sp,sp,0xb
     e92:	0000                	unimp
     e94:	3010                	fld	fa2,32(s0)
     e96:	0004                	0x4
     e98:	0100                	addi	s0,sp,128
     e9a:	0e69                	addi	t3,t3,26
     e9c:	006a                	c.slli	zero,0x1a
     e9e:	0000                	unimp
     ea0:	9102                	jalr	sp
     ea2:	1160                	addi	s0,sp,172
     ea4:	0f86                	slli	t6,t6,0x1
     ea6:	8020                	0x8020
     ea8:	0000                	unimp
     eaa:	0000                	unimp
     eac:	00d4                	addi	a3,sp,68
     eae:	0000                	unimp
     eb0:	0000                	unimp
     eb2:	0000                	unimp
     eb4:	6912                	ld	s2,256(sp)
     eb6:	0100                	addi	s0,sp,128
     eb8:	006a136b          	0x6a136b
     ebc:	0000                	unimp
     ebe:	9102                	jalr	sp
     ec0:	1168                	addi	a0,sp,172
     ec2:	0f8c                	addi	a1,sp,976
     ec4:	8020                	0x8020
     ec6:	0000                	unimp
     ec8:	0000                	unimp
     eca:	00b8                	addi	a4,sp,72
     ecc:	0000                	unimp
     ece:	0000                	unimp
     ed0:	0000                	unimp
     ed2:	ef10                	sd	a2,24(a4)
     ed4:	01000003          	lb	zero,16(zero) # 10 <n+0x4>
     ed8:	126d                	addi	tp,tp,-5
     eda:	006a                	c.slli	zero,0x1a
     edc:	0000                	unimp
     ede:	9102                	jalr	sp
     ee0:	1058                	addi	a4,sp,36
     ee2:	03f9                	addi	t2,t2,30
     ee4:	0000                	unimp
     ee6:	6e01                	0x6e01
     ee8:	6a12                	ld	s4,256(sp)
     eea:	0000                	unimp
     eec:	0200                	addi	s0,sp,256
     eee:	5091                	li	ra,-28
     ef0:	2610                	fld	fa2,8(a2)
     ef2:	0004                	0x4
     ef4:	0100                	addi	s0,sp,128
     ef6:	006a126f          	jal	tp,a1efc <n+0xa1edc>
     efa:	0000                	unimp
     efc:	9102                	jalr	sp
     efe:	1248                	addi	a0,sp,292
     f00:	00637273          	csrrci	tp,0x6,6
     f04:	7001                	c.lui	zero,0xfffe0
     f06:	3115                	addiw	sp,sp,-27
     f08:	0002                	c.slli64	zero
     f0a:	0200                	addi	s0,sp,256
     f0c:	4091                	li	ra,4
     f0e:	6412                	ld	s0,256(sp)
     f10:	01007473          	csrrci	s0,0x10,0
     f14:	0f71                	addi	t5,t5,28
     f16:	0238                	addi	a4,sp,264
     f18:	0000                	unimp
     f1a:	7fb89103          	lh	sp,2043(a7) # 47fb <n+0x47db>
     f1e:	0000                	unimp
     f20:	1300                	addi	s0,sp,416
     f22:	3708                	fld	fa0,40(a4)
     f24:	0002                	c.slli64	zero
     f26:	1400                	addi	s0,sp,544
     f28:	0815                	addi	a6,a6,5
     f2a:	0004410f          	0x4410f
     f2e:	0100                	addi	s0,sp,128
     f30:	065c                	addi	a5,sp,772
     f32:	0ebe                	slli	t4,t4,0xf
     f34:	8020                	0x8020
     f36:	0000                	unimp
     f38:	0000                	unimp
     f3a:	00ae                	slli	ra,ra,0xb
     f3c:	0000                	unimp
     f3e:	0000                	unimp
     f40:	0000                	unimp
     f42:	9c01                	subw	s0,s0,s0
     f44:	0286                	slli	t0,t0,0x1
     f46:	0000                	unimp
     f48:	6310                	ld	a2,0(a4)
     f4a:	0004                	0x4
     f4c:	0100                	addi	s0,sp,128
     f4e:	0f5e                	slli	t5,t5,0x17
     f50:	007d                	c.nop	31
     f52:	0000                	unimp
     f54:	9102                	jalr	sp
     f56:	1058                	addi	a4,sp,36
     f58:	03c8                	addi	a0,sp,452
     f5a:	0000                	unimp
     f5c:	5f01                	li	t5,-32
     f5e:	8918                	0x8918
     f60:	0000                	unimp
     f62:	0300                	addi	s0,sp,384
     f64:	c091                	beqz	s1,f68 <n+0xf48>
     f66:	127d                	addi	tp,tp,-1
     f68:	01007863          	bgeu	zero,a6,f78 <n+0xf58>
     f6c:	0e60                	addi	s0,sp,796
     f6e:	0286                	slli	t0,t0,0x1
     f70:	0000                	unimp
     f72:	9102                	jalr	sp
     f74:	0050                	addi	a2,sp,4
     f76:	00490813          	addi	a6,s2,4 # 1e004 <n+0x1dfe4>
     f7a:	0000                	unimp
     f7c:	0003d40f          	0x3d40f
     f80:	0100                	addi	s0,sp,128
     f82:	0648                	addi	a0,sp,772
     f84:	0da6                	slli	s11,s11,0x9
     f86:	8020                	0x8020
     f88:	0000                	unimp
     f8a:	0000                	unimp
     f8c:	0118                	addi	a4,sp,128
     f8e:	0000                	unimp
     f90:	0000                	unimp
     f92:	0000                	unimp
     f94:	9c01                	subw	s0,s0,s0
     f96:	02d8                	addi	a4,sp,324
     f98:	0000                	unimp
     f9a:	6310                	ld	a2,0(a4)
     f9c:	0004                	0x4
     f9e:	0100                	addi	s0,sp,128
     fa0:	0f54                	addi	a3,sp,916
     fa2:	007d                	c.nop	31
     fa4:	0000                	unimp
     fa6:	9102                	jalr	sp
     fa8:	1058                	addi	a4,sp,36
     faa:	03c8                	addi	a0,sp,452
     fac:	0000                	unimp
     fae:	5601                	li	a2,-32
     fb0:	8918                	0x8918
     fb2:	0000                	unimp
     fb4:	0300                	addi	s0,sp,384
     fb6:	c091                	beqz	s1,fba <n+0xf9a>
     fb8:	127d                	addi	tp,tp,-1
     fba:	01007863          	bgeu	zero,a6,fca <n+0xfaa>
     fbe:	02860e57          	0x2860e57
     fc2:	0000                	unimp
     fc4:	9102                	jalr	sp
     fc6:	0050                	addi	a2,sp,4
     fc8:	6e16                	ld	t3,320(sp)
     fca:	0004                	0x4
     fcc:	0100                	addi	s0,sp,128
     fce:	0638                	addi	a4,sp,776
     fd0:	0ce8                	addi	a0,sp,604
     fd2:	8020                	0x8020
     fd4:	0000                	unimp
     fd6:	0000                	unimp
     fd8:	00be                	slli	ra,ra,0xf
     fda:	0000                	unimp
     fdc:	0000                	unimp
     fde:	0000                	unimp
     fe0:	9c01                	subw	s0,s0,s0
     fe2:	0325                	addi	t1,t1,9
     fe4:	0000                	unimp
     fe6:	00037117          	auipc	sp,0x37
     fea:	0100                	addi	s0,sp,128
     fec:	2838                	fld	fa4,80(s0)
     fee:	0325                	addi	t1,t1,9
     ff0:	0000                	unimp
     ff2:	9102                	jalr	sp
     ff4:	1158                	addi	a4,sp,164
     ff6:	0d18                	addi	a4,sp,656
     ff8:	8020                	0x8020
     ffa:	0000                	unimp
     ffc:	0000                	unimp
     ffe:	0082                	c.slli64	ra
    1000:	0000                	unimp
    1002:	0000                	unimp
    1004:	0000                	unimp
    1006:	6912                	ld	s2,256(sp)
    1008:	0100                	addi	s0,sp,128
    100a:	133d                	addi	t1,t1,-17
    100c:	006a                	c.slli	zero,0x1a
    100e:	0000                	unimp
    1010:	9102                	jalr	sp
    1012:	0068                	addi	a0,sp,12
    1014:	1300                	addi	s0,sp,416
    1016:	cf08                	sw	a0,24(a4)
    1018:	0000                	unimp
    101a:	1600                	addi	s0,sp,800
    101c:	0438                	addi	a4,sp,520
    101e:	0000                	unimp
    1020:	1801                	addi	a6,a6,-32
    1022:	f806                	sd	ra,48(sp)
    1024:	0080200b          	0x80200b
    1028:	0000                	unimp
    102a:	f000                	sd	s0,32(s0)
    102c:	0000                	unimp
    102e:	0000                	unimp
    1030:	0000                	unimp
    1032:	0100                	addi	s0,sp,128
    1034:	869c                	0x869c
    1036:	17000003          	lb	zero,368(zero) # 170 <n+0x150>
    103a:	03a2                	slli	t2,t2,0x8
    103c:	0000                	unimp
    103e:	1801                	addi	a6,a6,-32
    1040:	6a18                	ld	a4,16(a2)
    1042:	0000                	unimp
    1044:	0200                	addi	s0,sp,256
    1046:	4891                	li	a7,4
    1048:	2610                	fld	fa2,8(a2)
    104a:	0004                	0x4
    104c:	0100                	addi	s0,sp,128
    104e:	0f26                	slli	t5,t5,0x9
    1050:	007d                	c.nop	31
    1052:	0000                	unimp
    1054:	9102                	jalr	sp
    1056:	1268                	addi	a0,sp,300
    1058:	00637273          	csrrci	tp,0x6,6
    105c:	2f01                	sext.w	t5,t5
    105e:	3111                	addiw	sp,sp,-28
    1060:	0002                	c.slli64	zero
    1062:	0200                	addi	s0,sp,256
    1064:	6091                	lui	ra,0x4
    1066:	6412                	ld	s0,256(sp)
    1068:	01007473          	csrrci	s0,0x10,0
    106c:	0b30                	addi	a2,sp,408
    106e:	0238                	addi	a4,sp,264
    1070:	0000                	unimp
    1072:	9102                	jalr	sp
    1074:	0058                	addi	a4,sp,4
    1076:	0c18                	addi	a4,sp,528
    1078:	0004                	0x4
    107a:	0100                	addi	s0,sp,128
    107c:	060c                	addi	a1,sp,768
    107e:	0b44                	addi	s1,sp,404
    1080:	8020                	0x8020
    1082:	0000                	unimp
    1084:	0000                	unimp
    1086:	00b4                	addi	a3,sp,72
    1088:	0000                	unimp
    108a:	0000                	unimp
    108c:	0000                	unimp
    108e:	9c01                	subw	s0,s0,s0
    1090:	6011                	c.lui	zero,0x4
    1092:	0080200b          	0x80200b
    1096:	0000                	unimp
    1098:	7600                	ld	s0,40(a2)
    109a:	0000                	unimp
    109c:	0000                	unimp
    109e:	0000                	unimp
    10a0:	1200                	addi	s0,sp,288
    10a2:	0069                	c.nop	26
    10a4:	0f01                	addi	t5,t5,0
    10a6:	00006a13          	ori	s4,zero,0
    10aa:	0200                	addi	s0,sp,256
    10ac:	6891                	lui	a7,0x4
    10ae:	0000                	unimp
    10b0:	6b00                	ld	s0,16(a4)
    10b2:	04000003          	lb	zero,64(zero) # 40 <n+0x20>
    10b6:	9100                	0x9100
    10b8:	0006                	c.slli	zero,0x1
    10ba:	0800                	addi	s0,sp,16
    10bc:	8b01                	andi	a4,a4,0
    10be:	0000                	unimp
    10c0:	0c00                	addi	s0,sp,528
    10c2:	052e                	slli	a0,a0,0xb
    10c4:	0000                	unimp
    10c6:	0059                	c.nop	22
    10c8:	0000                	unimp
    10ca:	1066                	c.slli	zero,0x39
    10cc:	8020                	0x8020
    10ce:	0000                	unimp
    10d0:	0000                	unimp
    10d2:	01aa                	slli	gp,gp,0xa
    10d4:	0000                	unimp
    10d6:	0000                	unimp
    10d8:	0000                	unimp
    10da:	10ca                	slli	ra,ra,0x32
    10dc:	0000                	unimp
    10de:	0102                	c.slli64	sp
    10e0:	4406                	lw	s0,64(sp)
    10e2:	0000                	unimp
    10e4:	0200                	addi	s0,sp,256
    10e6:	0502                	c.slli64	a0
    10e8:	0022                	c.slli	zero,0x8
    10ea:	0000                	unimp
    10ec:	69050403          	lb	s0,1680(a0) # 63d0 <n+0x63b0>
    10f0:	746e                	ld	s0,248(sp)
    10f2:	0200                	addi	s0,sp,256
    10f4:	0508                	addi	a0,sp,640
    10f6:	0050                	addi	a2,sp,4
    10f8:	0000                	unimp
    10fa:	bc04                	fsd	fs1,56(s0)
    10fc:	0001                	nop
    10fe:	0200                	addi	s0,sp,256
    1100:	0055170b          	0x55170b
    1104:	0000                	unimp
    1106:	0102                	c.slli64	sp
    1108:	4208                	lw	a0,0(a2)
    110a:	0000                	unimp
    110c:	0200                	addi	s0,sp,256
    110e:	0702                	c.slli64	a4
    1110:	0000000f          	fence	unknown,unknown
    1114:	d304                	sw	s1,32(a4)
    1116:	0001                	nop
    1118:	0200                	addi	s0,sp,256
    111a:	160d                	addi	a2,a2,-29
    111c:	0000006f          	j	111c <n+0x10fc>
    1120:	0402                	c.slli64	s0
    1122:	00007e07          	0x7e07
    1126:	0400                	addi	s0,sp,512
    1128:	0006                	c.slli	zero,0x1
    112a:	0000                	unimp
    112c:	0e02                	c.slli64	t3
    112e:	0000821b          	sext.w	tp,ra
    1132:	0200                	addi	s0,sp,256
    1134:	0708                	addi	a0,sp,896
    1136:	0079                	c.nop	30
    1138:	0000                	unimp
    113a:	a904                	fsd	fs1,16(a0)
    113c:	02000003          	lb	zero,32(zero) # 20 <n>
    1140:	1b12                	slli	s6,s6,0x24
    1142:	0082                	c.slli64	ra
    1144:	0000                	unimp
    1146:	0305                	addi	t1,t1,1
    1148:	0005                	c.nop	1
    114a:	1000                	addi	s0,sp,32
    114c:	0301                	addi	t1,t1,0
    114e:	0804                	addi	s1,sp,16
    1150:	000000cb          	fnmsub.s	ft1,ft0,ft0,ft0,rne
    1154:	7806                	ld	a6,96(sp)
    1156:	0300                	addi	s0,sp,384
    1158:	0e06                	slli	t3,t3,0x1
    115a:	000000cb          	fnmsub.s	ft1,ft0,ft0,ft0,rne
    115e:	0700                	addi	s0,sp,896
    1160:	05b1                	addi	a1,a1,12
    1162:	0000                	unimp
    1164:	760e0703          	lb	a4,1888(t3)
    1168:	0000                	unimp
    116a:	0000                	unimp
    116c:	0701                	addi	a4,a4,0
    116e:	000005d7          	0x5d7
    1172:	760e0803          	lb	a6,1888(t3)
    1176:	0000                	unimp
    1178:	0800                	addi	s0,sp,16
    117a:	0001                	nop
    117c:	7608                	ld	a0,40(a2)
    117e:	0000                	unimp
    1180:	db00                	sw	s0,48(a4)
    1182:	0000                	unimp
    1184:	0900                	addi	s0,sp,144
    1186:	0082                	c.slli64	ra
    1188:	0000                	unimp
    118a:	001f 0105 0004      	0x40105001f
    1190:	5000                	lw	s0,32(s0)
    1192:	0401                	addi	s0,s0,0
    1194:	0809                	addi	a6,a6,2
    1196:	011e                	slli	sp,sp,0x7
    1198:	0000                	unimp
    119a:	4f0a                	lw	t5,128(sp)
    119c:	0004                	0x4
    119e:	0400                	addi	s0,sp,512
    11a0:	00760e0b          	0x760e0b
    11a4:	0000                	unimp
    11a6:	0a00                	addi	s0,sp,272
    11a8:	047d                	addi	s0,s0,31
    11aa:	0000                	unimp
    11ac:	0c04                	addi	s1,sp,528
    11ae:	760e                	ld	a2,224(sp)
    11b0:	0000                	unimp
    11b2:	0800                	addi	s0,sp,16
    11b4:	ef0a                	sd	sp,408(sp)
    11b6:	04000003          	lb	zero,64(zero) # 40 <n+0x20>
    11ba:	0f0d                	addi	t5,t5,3
    11bc:	011e                	slli	sp,sp,0x7
    11be:	0000                	unimp
    11c0:	0a10                	addi	a2,sp,272
    11c2:	03f9                	addi	t2,t2,30
    11c4:	0000                	unimp
    11c6:	0e04                	addi	s1,sp,784
    11c8:	00011e0f          	0x11e0f
    11cc:	b000                	fsd	fs0,32(s0)
    11ce:	0800                	addi	s0,sp,16
    11d0:	0089                	addi	ra,ra,2
    11d2:	0000                	unimp
    11d4:	012e                	slli	sp,sp,0xb
    11d6:	0000                	unimp
    11d8:	8209                	srli	a2,a2,0x2
    11da:	0000                	unimp
    11dc:	1300                	addi	s0,sp,416
    11de:	0b00                	addi	s0,sp,400
    11e0:	00000457          	0x457
    11e4:	1004                	addi	s1,sp,32
    11e6:	db1a                	sw	t1,180(sp)
    11e8:	0000                	unimp
    11ea:	0800                	addi	s0,sp,16
    11ec:	0049                	c.nop	18
    11ee:	0000                	unimp
    11f0:	0151                	addi	sp,sp,20
    11f2:	0000                	unimp
    11f4:	8209                	srli	a2,a2,0x2
    11f6:	0000                	unimp
    11f8:	1300                	addi	s0,sp,416
    11fa:	820c                	0x820c
    11fc:	0000                	unimp
    11fe:	ff00                	sd	s0,56(a4)
    1200:	001f 1c0b 0004      	0x41c0b001f
    1206:	0500                	addi	s0,sp,640
    1208:	013a1007          	0x13a1007
    120c:	0000                	unimp
    120e:	0005490b          	0x5490b
    1212:	0500                	addi	s0,sp,640
    1214:	1008                	addi	a0,sp,32
    1216:	013a                	slli	sp,sp,0xe
    1218:	0000                	unimp
    121a:	4908                	lw	a0,16(a0)
    121c:	0000                	unimp
    121e:	7a00                	ld	s0,48(a2)
    1220:	0001                	nop
    1222:	0c00                	addi	s0,sp,528
    1224:	0082                	c.slli64	ra
    1226:	0000                	unimp
    1228:	03ff                	0x3ff
    122a:	0b00                	addi	s0,sp,400
    122c:	04ae                	slli	s1,s1,0xb
    122e:	0000                	unimp
    1230:	0905                	addi	s2,s2,1
    1232:	6910                	ld	a2,16(a0)
    1234:	0001                	nop
    1236:	0d00                	addi	s0,sp,656
    1238:	017a                	slli	sp,sp,0x1e
    123a:	0000                	unimp
    123c:	0801                	addi	a6,a6,0
    123e:	0909                	addi	s2,s2,2
    1240:	20ab3803          	ld	a6,522(s6)
    1244:	0080                	addi	s0,sp,64
    1246:	0000                	unimp
    1248:	0d00                	addi	s0,sp,656
    124a:	0151                	addi	sp,sp,20
    124c:	0000                	unimp
    124e:	0901                	addi	s2,s2,0
    1250:	0909                	addi	s2,s2,2
    1252:	20af3803          	ld	a6,522(t5) # 1a20a <n+0x1a1ea>
    1256:	0080                	addi	s0,sp,64
    1258:	0000                	unimp
    125a:	0d00                	addi	s0,sp,656
    125c:	015d                	addi	sp,sp,23
    125e:	0000                	unimp
    1260:	0a01                	addi	s4,s4,0
    1262:	0909                	addi	s2,s2,2
    1264:	232f3803          	ld	a6,562(t5)
    1268:	0080                	addi	s0,sp,64
    126a:	0000                	unimp
    126c:	0e00                	addi	s0,sp,784
    126e:	0522                	slli	a0,a0,0x8
    1270:	0000                	unimp
    1272:	3201                	addiw	tp,tp,-32
    1274:	760a                	ld	a2,160(sp)
    1276:	0000                	unimp
    1278:	ba00                	fsd	fs0,48(a2)
    127a:	2011                	0x2011
    127c:	0080                	addi	s0,sp,64
    127e:	0000                	unimp
    1280:	5600                	lw	s0,40(a2)
    1282:	0000                	unimp
    1284:	0000                	unimp
    1286:	0000                	unimp
    1288:	0100                	addi	s0,sp,128
    128a:	0c9c                	addi	a5,sp,592
    128c:	0002                	c.slli64	zero
    128e:	0f00                	addi	s0,sp,912
    1290:	6469                	lui	s0,0x1a
    1292:	0100                	addi	s0,sp,128
    1294:	1f32                	slli	t5,t5,0x2c
    1296:	0076                	c.slli	zero,0x1d
    1298:	0000                	unimp
    129a:	7db89103          	lh	sp,2011(a7) # 47db <n+0x47bb>
    129e:	9e10                	0x9e10
    12a0:	0004                	0x4
    12a2:	0100                	addi	s0,sp,128
    12a4:	1834                	addi	a3,sp,56
    12a6:	0095                	addi	ra,ra,5
    12a8:	0000                	unimp
    12aa:	7dc89103          	lh	sp,2012(a7)
    12ae:	7311                	lui	t1,0xfffe4
    12b0:	0070                	addi	a2,sp,12
    12b2:	3501                	addiw	a0,a0,-32
    12b4:	760e                	ld	a2,224(sp)
    12b6:	0000                	unimp
    12b8:	0200                	addi	s0,sp,256
    12ba:	5891                	li	a7,-28
    12bc:	0e00                	addi	s0,sp,784
    12be:	04f4                	addi	a3,sp,588
    12c0:	0000                	unimp
    12c2:	2901                	sext.w	s2,s2
    12c4:	5c0a                	lw	s8,160(sp)
    12c6:	0002                	c.slli64	zero
    12c8:	6200                	ld	s0,0(a2)
    12ca:	2011                	0x2011
    12cc:	0080                	addi	s0,sp,64
    12ce:	0000                	unimp
    12d0:	5800                	lw	s0,48(s0)
    12d2:	0000                	unimp
    12d4:	0000                	unimp
    12d6:	0000                	unimp
    12d8:	0100                	addi	s0,sp,128
    12da:	5c9c                	lw	a5,56(s1)
    12dc:	0002                	c.slli64	zero
    12de:	1200                	addi	s0,sp,288
    12e0:	04b9                	addi	s1,s1,14
    12e2:	0000                	unimp
    12e4:	2901                	sext.w	s2,s2
    12e6:	9538                	0x9538
    12e8:	0000                	unimp
    12ea:	0200                	addi	s0,sp,256
    12ec:	0071                	c.nop	28
    12ee:	5512                	lw	a0,36(sp)
    12f0:	0005                	c.nop	1
    12f2:	0100                	addi	s0,sp,128
    12f4:	4d29                	li	s10,10
    12f6:	0076                	c.slli	zero,0x1d
    12f8:	0000                	unimp
    12fa:	9102                	jalr	sp
    12fc:	1058                	addi	a4,sp,36
    12fe:	04a5                	addi	s1,s1,9
    1300:	0000                	unimp
    1302:	2b01                	sext.w	s6,s6
    1304:	5c0e                	lw	s8,224(sp)
    1306:	0002                	c.slli64	zero
    1308:	0200                	addi	s0,sp,256
    130a:	6891                	lui	a7,0x4
    130c:	1300                	addi	s0,sp,416
    130e:	4908                	lw	a0,16(a0)
    1310:	0000                	unimp
    1312:	0e00                	addi	s0,sp,784
    1314:	04c5                	addi	s1,s1,17
    1316:	0000                	unimp
    1318:	2101                	sext.w	sp,sp
    131a:	5c0a                	lw	s8,160(sp)
    131c:	0002                	c.slli64	zero
    131e:	0a00                	addi	s0,sp,272
    1320:	2011                	0x2011
    1322:	0080                	addi	s0,sp,64
    1324:	0000                	unimp
    1326:	5800                	lw	s0,48(s0)
    1328:	0000                	unimp
    132a:	0000                	unimp
    132c:	0000                	unimp
    132e:	0100                	addi	s0,sp,128
    1330:	b29c                	fsd	fa5,32(a3)
    1332:	0002                	c.slli64	zero
    1334:	1200                	addi	s0,sp,288
    1336:	04b9                	addi	s1,s1,14
    1338:	0000                	unimp
    133a:	2101                	sext.w	sp,sp
    133c:	953a                	add	a0,a0,a4
    133e:	0000                	unimp
    1340:	0200                	addi	s0,sp,256
    1342:	0071                	c.nop	28
    1344:	5512                	lw	a0,36(sp)
    1346:	0005                	c.nop	1
    1348:	0100                	addi	s0,sp,128
    134a:	4f21                	li	t5,8
    134c:	0076                	c.slli	zero,0x1d
    134e:	0000                	unimp
    1350:	9102                	jalr	sp
    1352:	1058                	addi	a4,sp,36
    1354:	04a5                	addi	s1,s1,9
    1356:	0000                	unimp
    1358:	2301                	sext.w	t1,t1
    135a:	5c0e                	lw	s8,224(sp)
    135c:	0002                	c.slli64	zero
    135e:	0200                	addi	s0,sp,256
    1360:	6891                	lui	a7,0x4
    1362:	1400                	addi	s0,sp,544
    1364:	0000050f          	0x50f
    1368:	1c01                	addi	s8,s8,-32
    136a:	760a                	ld	a2,160(sp)
    136c:	0000                	unimp
    136e:	e000                	sd	s0,0(s0)
    1370:	2010                	fld	fa2,0(s0)
    1372:	0080                	addi	s0,sp,64
    1374:	0000                	unimp
    1376:	2a00                	fld	fs0,16(a2)
    1378:	0000                	unimp
    137a:	0000                	unimp
    137c:	0000                	unimp
    137e:	0100                	addi	s0,sp,128
    1380:	e49c                	sd	a5,8(s1)
    1382:	0002                	c.slli64	zero
    1384:	1200                	addi	s0,sp,288
    1386:	03a2                	slli	t2,t2,0x8
    1388:	0000                	unimp
    138a:	1c01                	addi	s8,s8,-32
    138c:	00007627          	0x7627
    1390:	0200                	addi	s0,sp,256
    1392:	6891                	lui	a7,0x4
    1394:	1400                	addi	s0,sp,544
    1396:	0489                	addi	s1,s1,2
    1398:	0000                	unimp
    139a:	1701                	addi	a4,a4,-32
    139c:	760a                	ld	a2,160(sp)
    139e:	0000                	unimp
    13a0:	b600                	fsd	fs0,40(a2)
    13a2:	2010                	fld	fa2,0(s0)
    13a4:	0080                	addi	s0,sp,64
    13a6:	0000                	unimp
    13a8:	2a00                	fld	fs0,16(a2)
    13aa:	0000                	unimp
    13ac:	0000                	unimp
    13ae:	0000                	unimp
    13b0:	0100                	addi	s0,sp,128
    13b2:	169c                	addi	a5,sp,864
    13b4:	12000003          	lb	zero,288(zero) # 120 <n+0x100>
    13b8:	03a2                	slli	t2,t2,0x8
    13ba:	0000                	unimp
    13bc:	1701                	addi	a4,a4,-32
    13be:	7629                	lui	a2,0xfffea
    13c0:	0000                	unimp
    13c2:	0200                	addi	s0,sp,256
    13c4:	6891                	lui	a7,0x4
    13c6:	1500                	addi	s0,sp,672
    13c8:	04e2                	slli	s1,s1,0x18
    13ca:	0000                	unimp
    13cc:	1101                	addi	sp,sp,-32
    13ce:	8e06                	mv	t3,ra
    13d0:	2010                	fld	fa2,0(s0)
    13d2:	0080                	addi	s0,sp,64
    13d4:	0000                	unimp
    13d6:	2800                	fld	fs0,16(s0)
    13d8:	0000                	unimp
    13da:	0000                	unimp
    13dc:	0000                	unimp
    13de:	0100                	addi	s0,sp,128
    13e0:	449c                	lw	a5,8(s1)
    13e2:	12000003          	lb	zero,288(zero) # 120 <n+0x100>
    13e6:	04ee                	slli	s1,s1,0x1b
    13e8:	0000                	unimp
    13ea:	1101                	addi	sp,sp,-32
    13ec:	5c21                	li	s8,-24
    13ee:	0002                	c.slli64	zero
    13f0:	0200                	addi	s0,sp,256
    13f2:	6891                	lui	a7,0x4
    13f4:	1600                	addi	s0,sp,800
    13f6:	055d                	addi	a0,a0,23
    13f8:	0000                	unimp
    13fa:	0c01                	addi	s8,s8,0
    13fc:	6606                	ld	a2,64(sp)
    13fe:	2010                	fld	fa2,0(s0)
    1400:	0080                	addi	s0,sp,64
    1402:	0000                	unimp
    1404:	2800                	fld	fs0,16(s0)
    1406:	0000                	unimp
    1408:	0000                	unimp
    140a:	0000                	unimp
    140c:	0100                	addi	s0,sp,128
    140e:	129c                	addi	a5,sp,352
    1410:	04ee                	slli	s1,s1,0x1b
    1412:	0000                	unimp
    1414:	0c01                	addi	s8,s8,0
    1416:	5c1f 0002 0200      	0x20000025c1f
    141c:	6891                	lui	a7,0x4
    141e:	0000                	unimp
    1420:	01fe                	slli	gp,gp,0x1f
    1422:	0000                	unimp
    1424:	0004                	0x4
    1426:	080a                	slli	a6,a6,0x2
    1428:	0000                	unimp
    142a:	0108                	addi	a0,sp,128
    142c:	0000008b          	0x8b
    1430:	6d0c                	ld	a1,24(a0)
    1432:	0005                	c.nop	1
    1434:	5900                	lw	s0,48(a0)
    1436:	0000                	unimp
    1438:	1000                	addi	s0,sp,32
    143a:	2012                	fld	ft0,256(sp)
    143c:	0080                	addi	s0,sp,64
    143e:	0000                	unimp
    1440:	0200                	addi	s0,sp,256
    1442:	0001                	nop
    1444:	0000                	unimp
    1446:	0000                	unimp
    1448:	9e00                	0x9e00
    144a:	0012                	c.slli	zero,0x4
    144c:	0200                	addi	s0,sp,256
    144e:	0601                	addi	a2,a2,0
    1450:	0044                	addi	s1,sp,4
    1452:	0000                	unimp
    1454:	0202                	c.slli64	tp
    1456:	2205                	addiw	tp,tp,1
    1458:	0000                	unimp
    145a:	0300                	addi	s0,sp,384
    145c:	0504                	addi	s1,sp,640
    145e:	6e69                	lui	t3,0x1a
    1460:	0074                	addi	a3,sp,12
    1462:	0802                	c.slli64	a6
    1464:	5005                	c.li	zero,-31
    1466:	0000                	unimp
    1468:	0200                	addi	s0,sp,256
    146a:	0801                	addi	a6,a6,0
    146c:	0042                	c.slli	zero,0x10
    146e:	0000                	unimp
    1470:	0202                	c.slli64	tp
    1472:	00000f07          	0xf07
    1476:	0200                	addi	s0,sp,256
    1478:	0704                	addi	s1,sp,896
    147a:	007e                	c.slli	zero,0x1f
    147c:	0000                	unimp
    147e:	0604                	addi	s1,sp,768
    1480:	0000                	unimp
    1482:	0300                	addi	s0,sp,384
    1484:	1b0e                	slli	s6,s6,0x23
    1486:	006a                	c.slli	zero,0x1a
    1488:	0000                	unimp
    148a:	0802                	c.slli64	a6
    148c:	00007907          	0x7907
    1490:	0500                	addi	s0,sp,640
    1492:	00000503          	lb	a0,0(zero) # 0 <n-0xc>
    1496:	0110                	addi	a2,sp,128
    1498:	0402                	c.slli64	s0
    149a:	a708                	fsd	fa0,8(a4)
    149c:	0000                	unimp
    149e:	0600                	addi	s0,sp,768
    14a0:	0078                	addi	a4,sp,12
    14a2:	0602                	c.slli64	a2
    14a4:	a70e                	fsd	ft3,392(sp)
    14a6:	0000                	unimp
    14a8:	0000                	unimp
    14aa:	0005b107          	fld	ft2,0(a1)
    14ae:	0200                	addi	s0,sp,256
    14b0:	005e0e07          	0x5e0e07
    14b4:	0000                	unimp
    14b6:	0100                	addi	s0,sp,128
    14b8:	0005d707          	0x5d707
    14bc:	0200                	addi	s0,sp,256
    14be:	0e08                	addi	a0,sp,784
    14c0:	005e                	c.slli	zero,0x17
    14c2:	0000                	unimp
    14c4:	0108                	addi	a0,sp,128
    14c6:	0800                	addi	s0,sp,16
    14c8:	005e                	c.slli	zero,0x17
    14ca:	0000                	unimp
    14cc:	000000b7          	lui	ra,0x0
    14d0:	6a09                	lui	s4,0x2
    14d2:	0000                	unimp
    14d4:	1f00                	addi	s0,sp,944
    14d6:	0a00                	addi	s0,sp,272
    14d8:	05b9                	addi	a1,a1,14
    14da:	0000                	unimp
    14dc:	1501                	addi	a0,a0,-32
    14de:	7114                	ld	a3,32(a0)
    14e0:	0000                	unimp
    14e2:	7a00                	ld	s0,48(a2)
    14e4:	2012                	fld	ft0,256(sp)
    14e6:	0080                	addi	s0,sp,64
    14e8:	0000                	unimp
    14ea:	9800                	0x9800
    14ec:	0000                	unimp
    14ee:	0000                	unimp
    14f0:	0000                	unimp
    14f2:	0100                	addi	s0,sp,128
    14f4:	389c                	fld	fa5,48(s1)
    14f6:	0001                	nop
    14f8:	0b00                	addi	s0,sp,400
    14fa:	058c                	addi	a1,sp,704
    14fc:	0000                	unimp
    14fe:	1501                	addi	a0,a0,-32
    1500:	5e2e                	lw	t3,232(sp)
    1502:	0000                	unimp
    1504:	0300                	addi	s0,sp,384
    1506:	c091                	beqz	s1,150a <n+0x14ea>
    1508:	0c7d                	addi	s8,s8,31
    150a:	01007073          	csrci	0x10,0
    150e:	3e15                	addiw	t3,t3,-27
    1510:	005e                	c.slli	zero,0x17
    1512:	0000                	unimp
    1514:	7db89103          	lh	sp,2011(a7) # 47db <n+0x47bb>
    1518:	630d                	lui	t1,0x3
    151a:	7874                	ld	a3,240(s0)
    151c:	0100                	addi	s0,sp,128
    151e:	00711817          	auipc	a6,0x711
    1522:	0000                	unimp
    1524:	7dd89103          	lh	sp,2013(a7)
    1528:	b10e                	fsd	ft3,160(sp)
    152a:	0005                	c.nop	1
    152c:	0100                	addi	s0,sp,128
    152e:	0e18                	addi	a4,sp,784
    1530:	005e                	c.slli	zero,0x17
    1532:	0000                	unimp
    1534:	7dd09103          	lh	sp,2013(ra) # 7dd <n+0x7bd>
    1538:	2012c00f          	0x2012c00f
    153c:	0080                	addi	s0,sp,64
    153e:	0000                	unimp
    1540:	2e00                	fld	fs0,24(a2)
    1542:	0000                	unimp
    1544:	0000                	unimp
    1546:	0000                	unimp
    1548:	0d00                	addi	s0,sp,656
    154a:	0069                	c.nop	26
    154c:	1e01                	addi	t3,t3,-32
    154e:	3b0d                	addiw	s6,s6,-29
    1550:	0000                	unimp
    1552:	0200                	addi	s0,sp,256
    1554:	6c91                	lui	s9,0x4
    1556:	0000                	unimp
    1558:	ca10                	sw	a2,16(a2)
    155a:	0005                	c.nop	1
    155c:	0100                	addi	s0,sp,128
    155e:	0610                	addi	a2,sp,768
    1560:	125a                	slli	tp,tp,0x36
    1562:	8020                	0x8020
    1564:	0000                	unimp
    1566:	0000                	unimp
    1568:	0020                	addi	s0,sp,8
    156a:	0000                	unimp
    156c:	0000                	unimp
    156e:	0000                	unimp
    1570:	9c01                	subw	s0,s0,s0
    1572:	0174                	addi	a3,sp,140
    1574:	0000                	unimp
    1576:	630c                	ld	a1,0(a4)
    1578:	7874                	ld	a3,240(s0)
    157a:	0100                	addi	s0,sp,128
    157c:	2110                	fld	fa2,0(a0)
    157e:	0174                	addi	a3,sp,140
    1580:	0000                	unimp
    1582:	9102                	jalr	sp
    1584:	0c68                	addi	a0,sp,540
    1586:	01007073          	csrci	0x10,0
    158a:	2f10                	fld	fa2,24(a4)
    158c:	005e                	c.slli	zero,0x17
    158e:	0000                	unimp
    1590:	9102                	jalr	sp
    1592:	0060                	addi	s0,sp,12
    1594:	0811                	addi	a6,a6,4
    1596:	0071                	c.nop	28
    1598:	0000                	unimp
    159a:	ac12                	fsd	ft4,24(sp)
    159c:	0005                	c.nop	1
    159e:	0100                	addi	s0,sp,128
    15a0:	005e0a0b          	0x5e0a0b
    15a4:	0000                	unimp
    15a6:	1240                	addi	s0,sp,292
    15a8:	8020                	0x8020
    15aa:	0000                	unimp
    15ac:	0000                	unimp
    15ae:	001a                	c.slli	zero,0x6
    15b0:	0000                	unimp
    15b2:	0000                	unimp
    15b4:	0000                	unimp
    15b6:	9c01                	subw	s0,s0,s0
    15b8:	01be                	slli	gp,gp,0xf
    15ba:	0000                	unimp
    15bc:	2012460f          	0x2012460f
    15c0:	0080                	addi	s0,sp,64
    15c2:	0000                	unimp
    15c4:	0c00                	addi	s0,sp,528
    15c6:	0000                	unimp
    15c8:	0000                	unimp
    15ca:	0000                	unimp
    15cc:	0e00                	addi	s0,sp,784
    15ce:	02c0                	addi	s0,sp,324
    15d0:	0000                	unimp
    15d2:	0c01                	addi	s8,s8,0
    15d4:	6a0c                	ld	a1,16(a2)
    15d6:	0000                	unimp
    15d8:	0200                	addi	s0,sp,256
    15da:	6891                	lui	a7,0x4
    15dc:	0000                	unimp
    15de:	9210                	0x9210
    15e0:	0005                	c.nop	1
    15e2:	0100                	addi	s0,sp,128
    15e4:	0604                	addi	s1,sp,768
    15e6:	1210                	addi	a2,sp,288
    15e8:	8020                	0x8020
    15ea:	0000                	unimp
    15ec:	0000                	unimp
    15ee:	0030                	addi	a2,sp,8
    15f0:	0000                	unimp
    15f2:	0000                	unimp
    15f4:	0000                	unimp
    15f6:	9c01                	subw	s0,s0,s0
    15f8:	000001fb          	0x1fb
    15fc:	0005b10b          	0x5b10b
    1600:	0100                	addi	s0,sp,128
    1602:	2504                	fld	fs1,8(a0)
    1604:	000001fb          	0x1fb
    1608:	9102                	jalr	sp
    160a:	0e58                	addi	a4,sp,788
    160c:	000005a7          	0x5a7
    1610:	0601                	addi	a2,a2,0
    1612:	5e0e                	lw	t3,224(sp)
    1614:	0000                	unimp
    1616:	0200                	addi	s0,sp,256
    1618:	6891                	lui	a7,0x4
    161a:	1100                	addi	s0,sp,160
    161c:	5e08                	lw	a0,56(a2)
    161e:	0000                	unimp
    1620:	0000                	unimp
    1622:	028c                	addi	a1,sp,320
    1624:	0000                	unimp
    1626:	0004                	0x4
    1628:	0936                	slli	s2,s2,0xd
    162a:	0000                	unimp
    162c:	0108                	addi	a0,sp,128
    162e:	0000008b          	0x8b
    1632:	f70c                	sd	a1,40(a4)
    1634:	0005                	c.nop	1
    1636:	5900                	lw	s0,48(a0)
    1638:	0000                	unimp
    163a:	1200                	addi	s0,sp,288
    163c:	00802013          	slti	zero,zero,8
    1640:	0000                	unimp
    1642:	0a00                	addi	s0,sp,272
    1644:	00000003          	lb	zero,0(zero) # 0 <n-0xc>
    1648:	0000                	unimp
    164a:	e800                	sd	s0,16(s0)
    164c:	02000013          	li	zero,32
    1650:	0601                	addi	a2,a2,0
    1652:	0044                	addi	s1,sp,4
    1654:	0000                	unimp
    1656:	0202                	c.slli64	tp
    1658:	2205                	addiw	tp,tp,1
    165a:	0000                	unimp
    165c:	0300                	addi	s0,sp,384
    165e:	0504                	addi	s1,sp,640
    1660:	6e69                	lui	t3,0x1a
    1662:	0074                	addi	a3,sp,12
    1664:	0802                	c.slli64	a6
    1666:	5005                	c.li	zero,-31
    1668:	0000                	unimp
    166a:	0400                	addi	s0,sp,512
    166c:	01bc                	addi	a5,sp,200
    166e:	0000                	unimp
    1670:	0b02                	c.slli64	s6
    1672:	00005517          	auipc	a0,0x5
    1676:	0200                	addi	s0,sp,256
    1678:	0801                	addi	a6,a6,0
    167a:	0042                	c.slli	zero,0x10
    167c:	0000                	unimp
    167e:	0202                	c.slli64	tp
    1680:	00000f07          	0xf07
    1684:	0200                	addi	s0,sp,256
    1686:	0704                	addi	s1,sp,896
    1688:	007e                	c.slli	zero,0x1f
    168a:	0000                	unimp
    168c:	0604                	addi	s1,sp,768
    168e:	0000                	unimp
    1690:	0200                	addi	s0,sp,256
    1692:	1b0e                	slli	s6,s6,0x23
    1694:	0076                	c.slli	zero,0x1d
    1696:	0000                	unimp
    1698:	0802                	c.slli64	a6
    169a:	00007907          	0x7907
    169e:	0500                	addi	s0,sp,640
    16a0:	00000503          	lb	a0,0(zero) # 0 <n-0xc>
    16a4:	0110                	addi	a2,sp,128
    16a6:	b3080403          	lb	s0,-1232(a6) # 71204e <n+0x71202e>
    16aa:	0000                	unimp
    16ac:	0600                	addi	s0,sp,768
    16ae:	0078                	addi	a4,sp,12
    16b0:	b30e0603          	lb	a2,-1232(t3) # 19b30 <n+0x19b10>
    16b4:	0000                	unimp
    16b6:	0000                	unimp
    16b8:	0005b107          	fld	ft2,0(a1)
    16bc:	0300                	addi	s0,sp,384
    16be:	006a0e07          	0x6a0e07
    16c2:	0000                	unimp
    16c4:	0100                	addi	s0,sp,128
    16c6:	0005d707          	0x5d707
    16ca:	0300                	addi	s0,sp,384
    16cc:	0e08                	addi	a0,sp,784
    16ce:	006a                	c.slli	zero,0x1a
    16d0:	0000                	unimp
    16d2:	0108                	addi	a0,sp,128
    16d4:	0800                	addi	s0,sp,16
    16d6:	006a                	c.slli	zero,0x1a
    16d8:	0000                	unimp
    16da:	000000c3          	fmadd.s	ft1,ft0,ft0,ft0,rne
    16de:	7609                	lui	a2,0xfffe2
    16e0:	0000                	unimp
    16e2:	1f00                	addi	s0,sp,944
    16e4:	0a00                	addi	s0,sp,272
    16e6:	0000                	unimp
    16e8:	0000                	unimp
    16ea:	0504                	addi	s1,sp,640
    16ec:	6a11                	lui	s4,0x4
    16ee:	0000                	unimp
    16f0:	0900                	addi	s0,sp,144
    16f2:	25af3803          	ld	a6,602(t5)
    16f6:	0080                	addi	s0,sp,64
    16f8:	0000                	unimp
    16fa:	0800                	addi	s0,sp,16
    16fc:	0049                	c.nop	18
    16fe:	0000                	unimp
    1700:	00ea                	slli	ra,ra,0x1a
    1702:	0000                	unimp
    1704:	0000760b          	0x760b
    1708:	ff00                	sd	s0,56(a4)
    170a:	ae0c0003          	lb	zero,-1312(s8) # 1ae0 <n+0x1ac0>
    170e:	0004                	0x4
    1710:	0500                	addi	s0,sp,640
    1712:	1009                	c.nop	-30
    1714:	00d9                	addi	ra,ra,22
    1716:	0000                	unimp
    1718:	1b0d                	addi	s6,s6,-29
    171a:	0006                	c.slli	zero,0x1
    171c:	0100                	addi	s0,sp,128
    171e:	1526                	slli	a0,a0,0x29
    1720:	019c                	addi	a5,sp,192
    1722:	0000                	unimp
    1724:	13e4                	addi	s1,sp,492
    1726:	8020                	0x8020
    1728:	0000                	unimp
    172a:	0000                	unimp
    172c:	0238                	addi	a4,sp,264
    172e:	0000                	unimp
    1730:	0000                	unimp
    1732:	0000                	unimp
    1734:	9c01                	subw	s0,s0,s0
    1736:	019c                	addi	a5,sp,192
    1738:	0000                	unimp
    173a:	630e                	ld	t1,192(sp)
    173c:	0078                	addi	a4,sp,12
    173e:	2601                	sext.w	a2,a2
    1740:	9c36                	add	s8,s8,a3
    1742:	0001                	nop
    1744:	0300                	addi	s0,sp,384
    1746:	a891                	j	179a <n+0x177a>
    1748:	0a7f                	0xa7f
    174a:	05f0                	addi	a2,sp,716
    174c:	0000                	unimp
    174e:	2901                	sext.w	s2,s2
    1750:	6a0e                	ld	s4,192(sp)
    1752:	0000                	unimp
    1754:	0200                	addi	s0,sp,256
    1756:	5091                	li	ra,-28
    1758:	2013f00f          	0x2013f00f
    175c:	0080                	addi	s0,sp,64
    175e:	0000                	unimp
    1760:	0c00                	addi	s0,sp,528
    1762:	0000                	unimp
    1764:	0000                	unimp
    1766:	0000                	unimp
    1768:	5b00                	lw	s0,48(a4)
    176a:	0001                	nop
    176c:	0a00                	addi	s0,sp,272
    176e:	02c0                	addi	s0,sp,324
    1770:	0000                	unimp
    1772:	2901                	sext.w	s2,s2
    1774:	00007617          	auipc	a2,0x7
    1778:	0200                	addi	s0,sp,256
    177a:	5891                	li	a7,-28
    177c:	1000                	addi	s0,sp,32
    177e:	1448                	addi	a0,sp,548
    1780:	8020                	0x8020
    1782:	0000                	unimp
    1784:	0000                	unimp
    1786:	01c6                	slli	gp,gp,0x11
    1788:	0000                	unimp
    178a:	0000                	unimp
    178c:	0000                	unimp
    178e:	6311                	lui	t1,0x4
    1790:	746e                	ld	s0,248(sp)
    1792:	0100                	addi	s0,sp,128
    1794:	1651                	addi	a2,a2,-12
    1796:	006a                	c.slli	zero,0x1a
    1798:	0000                	unimp
    179a:	9102                	jalr	sp
    179c:	0a68                	addi	a0,sp,284
    179e:	0616                	slli	a2,a2,0x5
    17a0:	0000                	unimp
    17a2:	5701                	li	a4,-32
    17a4:	a216                	fsd	ft5,256(sp)
    17a6:	0001                	nop
    17a8:	0300                	addi	s0,sp,384
    17aa:	b891                	j	ffe <n+0xfde>
    17ac:	0a7f                	0xa7f
    17ae:	000005eb          	0x5eb
    17b2:	6101                	0x6101
    17b4:	6a16                	ld	s4,320(sp)
    17b6:	0000                	unimp
    17b8:	0200                	addi	s0,sp,256
    17ba:	6091                	lui	ra,0x4
    17bc:	0000                	unimp
    17be:	0812                	slli	a6,a6,0x4
    17c0:	007d                	c.nop	31
    17c2:	0000                	unimp
    17c4:	6a08                	ld	a0,16(a2)
    17c6:	0000                	unimp
    17c8:	b200                	fsd	fs0,32(a2)
    17ca:	0001                	nop
    17cc:	0900                	addi	s0,sp,144
    17ce:	0076                	c.slli	zero,0x1d
    17d0:	0000                	unimp
    17d2:	0002                	c.slli64	zero
    17d4:	0005dc13          	srli	s8,a1,0x0
    17d8:	0100                	addi	s0,sp,128
    17da:	0615                	addi	a2,a2,5
    17dc:	134e                	slli	t1,t1,0x33
    17de:	8020                	0x8020
    17e0:	0000                	unimp
    17e2:	0000                	unimp
    17e4:	0096                	slli	ra,ra,0x5
    17e6:	0000                	unimp
    17e8:	0000                	unimp
    17ea:	0000                	unimp
    17ec:	9c01                	subw	s0,s0,s0
    17ee:	00000253          	fadd.s	ft4,ft0,ft0,rne
    17f2:	0a0a                	slli	s4,s4,0x2
    17f4:	0006                	c.slli	zero,0x1
    17f6:	0100                	addi	s0,sp,128
    17f8:	0e18                	addi	a4,sp,784
    17fa:	006a                	c.slli	zero,0x1a
    17fc:	0000                	unimp
    17fe:	9102                	jalr	sp
    1800:	0a68                	addi	a0,sp,284
    1802:	000005a7          	0x5a7
    1806:	1b01                	addi	s6,s6,-32
    1808:	6a0e                	ld	s4,192(sp)
    180a:	0000                	unimp
    180c:	0200                	addi	s0,sp,256
    180e:	6091                	lui	ra,0x4
    1810:	b10a                	fsd	ft2,160(sp)
    1812:	0005                	c.nop	1
    1814:	0100                	addi	s0,sp,128
    1816:	0e1d                	addi	t3,t3,7
    1818:	006a                	c.slli	zero,0x1a
    181a:	0000                	unimp
    181c:	9102                	jalr	sp
    181e:	1150                	addi	a2,sp,164
    1820:	00656973          	csrrsi	s2,0x6,10
    1824:	2001                	0x2001
    1826:	6a0e                	ld	s4,192(sp)
    1828:	0000                	unimp
    182a:	0200                	addi	s0,sp,256
    182c:	4091                	li	ra,4
    182e:	2013860f          	0x2013860f
    1832:	0080                	addi	s0,sp,64
    1834:	0000                	unimp
    1836:	0c00                	addi	s0,sp,528
    1838:	0000                	unimp
    183a:	0000                	unimp
    183c:	0000                	unimp
    183e:	3100                	fld	fs0,32(a0)
    1840:	0002                	c.slli64	zero
    1842:	0a00                	addi	s0,sp,272
    1844:	02c0                	addi	s0,sp,324
    1846:	0000                	unimp
    1848:	1d01                	addi	s10,s10,-32
    184a:	7618                	ld	a4,40(a2)
    184c:	0000                	unimp
    184e:	0200                	addi	s0,sp,256
    1850:	5891                	li	a7,-28
    1852:	1000                	addi	s0,sp,32
    1854:	13aa                	slli	t2,t2,0x2a
    1856:	8020                	0x8020
    1858:	0000                	unimp
    185a:	0000                	unimp
    185c:	000c                	0xc
    185e:	0000                	unimp
    1860:	0000                	unimp
    1862:	0000                	unimp
    1864:	c00a                	sw	sp,0(sp)
    1866:	0002                	c.slli64	zero
    1868:	0100                	addi	s0,sp,128
    186a:	1420                	addi	s0,sp,552
    186c:	0076                	c.slli	zero,0x1d
    186e:	0000                	unimp
    1870:	9102                	jalr	sp
    1872:	0048                	addi	a0,sp,4
    1874:	1400                	addi	s0,sp,544
    1876:	05d1                	addi	a1,a1,20
    1878:	0000                	unimp
    187a:	0e01                	addi	t3,t3,0
    187c:	1206                	slli	tp,tp,0x21
    187e:	00802013          	slti	zero,zero,8
    1882:	0000                	unimp
    1884:	3c00                	fld	fs0,56(s0)
    1886:	0000                	unimp
    1888:	0000                	unimp
    188a:	0000                	unimp
    188c:	0100                	addi	s0,sp,128
    188e:	109c                	addi	a5,sp,96
    1890:	1326                	slli	t1,t1,0x29
    1892:	8020                	0x8020
    1894:	0000                	unimp
    1896:	0000                	unimp
    1898:	000c                	0xc
    189a:	0000                	unimp
    189c:	0000                	unimp
    189e:	0000                	unimp
    18a0:	c00a                	sw	sp,0(sp)
    18a2:	0002                	c.slli64	zero
    18a4:	0100                	addi	s0,sp,128
    18a6:	1211                	addi	tp,tp,-28
    18a8:	0076                	c.slli	zero,0x1d
    18aa:	0000                	unimp
    18ac:	9102                	jalr	sp
    18ae:	0068                	addi	a0,sp,12
    18b0:	0000                	unimp
    18b2:	0216                	slli	tp,tp,0x5
    18b4:	0000                	unimp
    18b6:	0004                	0x4
    18b8:	0a70                	addi	a2,sp,284
    18ba:	0000                	unimp
    18bc:	0108                	addi	a0,sp,128
    18be:	0000008b          	0x8b
    18c2:	4a0c                	lw	a1,16(a2)
    18c4:	0006                	c.slli	zero,0x1
    18c6:	5900                	lw	s0,48(a0)
    18c8:	0000                	unimp
    18ca:	1c00                	addi	s0,sp,560
    18cc:	2016                	fld	ft0,320(sp)
    18ce:	0080                	addi	s0,sp,64
    18d0:	0000                	unimp
    18d2:	d800                	sw	s0,48(s0)
    18d4:	0001                	nop
    18d6:	0000                	unimp
    18d8:	0000                	unimp
    18da:	3600                	fld	fs0,40(a2)
    18dc:	02000017          	auipc	zero,0x2000
    18e0:	0601                	addi	a2,a2,0
    18e2:	0044                	addi	s1,sp,4
    18e4:	0000                	unimp
    18e6:	0202                	c.slli64	tp
    18e8:	2205                	addiw	tp,tp,1
    18ea:	0000                	unimp
    18ec:	0300                	addi	s0,sp,384
    18ee:	01d4                	addi	a3,sp,196
    18f0:	0000                	unimp
    18f2:	0702                	c.slli64	a4
    18f4:	470d                	li	a4,3
    18f6:	0000                	unimp
    18f8:	0400                	addi	s0,sp,512
    18fa:	0504                	addi	s1,sp,640
    18fc:	6e69                	lui	t3,0x1a
    18fe:	0074                	addi	a3,sp,12
    1900:	00000703          	lb	a4,0(zero) # 0 <n-0xc>
    1904:	0200                	addi	s0,sp,256
    1906:	1208                	addi	a0,sp,288
    1908:	005a                	c.slli	zero,0x16
    190a:	0000                	unimp
    190c:	0802                	c.slli64	a6
    190e:	5005                	c.li	zero,-31
    1910:	0000                	unimp
    1912:	0200                	addi	s0,sp,256
    1914:	0801                	addi	a6,a6,0
    1916:	0042                	c.slli	zero,0x10
    1918:	0000                	unimp
    191a:	0202                	c.slli64	tp
    191c:	00000f07          	0xf07
    1920:	0300                	addi	s0,sp,384
    1922:	000001d3          	fadd.s	ft3,ft0,ft0,rne
    1926:	0d02                	c.slli64	s10
    1928:	7b16                	ld	s6,352(sp)
    192a:	0000                	unimp
    192c:	0200                	addi	s0,sp,256
    192e:	0704                	addi	s1,sp,896
    1930:	007e                	c.slli	zero,0x1f
    1932:	0000                	unimp
    1934:	00000603          	lb	a2,0(zero) # 0 <n-0xc>
    1938:	0200                	addi	s0,sp,256
    193a:	1b0e                	slli	s6,s6,0x23
    193c:	008e                	slli	ra,ra,0x3
    193e:	0000                	unimp
    1940:	0802                	c.slli64	a6
    1942:	00007907          	0x7907
    1946:	0500                	addi	s0,sp,640
    1948:	0628                	addi	a0,sp,776
    194a:	0000                	unimp
    194c:	3601                	addiw	a2,a2,-32
    194e:	4e09                	li	t3,2
    1950:	0000                	unimp
    1952:	3a00                	fld	fs0,48(a2)
    1954:	00802017          	auipc	zero,0x802
    1958:	0000                	unimp
    195a:	ba00                	fsd	fs0,48(a2)
    195c:	0000                	unimp
    195e:	0000                	unimp
    1960:	0000                	unimp
    1962:	0100                	addi	s0,sp,128
    1964:	d69c                	sw	a5,40(a3)
    1966:	0000                	unimp
    1968:	0600                	addi	s0,sp,768
    196a:	0671                	addi	a2,a2,28
    196c:	0000                	unimp
    196e:	3601                	addiw	a2,a2,-32
    1970:	821a                	mv	tp,t1
    1972:	0000                	unimp
    1974:	0200                	addi	s0,sp,256
    1976:	6891                	lui	a7,0x4
    1978:	1606                	slli	a2,a2,0x21
    197a:	0006                	c.slli	zero,0x1
    197c:	0100                	addi	s0,sp,128
    197e:	2f36                	fld	ft10,328(sp)
    1980:	00d6                	slli	ra,ra,0x15
    1982:	0000                	unimp
    1984:	9102                	jalr	sp
    1986:	0060                	addi	s0,sp,12
    1988:	00820807          	0x820807
    198c:	0000                	unimp
    198e:	3608                	fld	fa0,40(a2)
    1990:	0006                	c.slli	zero,0x1
    1992:	0100                	addi	s0,sp,128
    1994:	0930                	addi	a2,sp,152
    1996:	004e                	c.slli	zero,0x13
    1998:	0000                	unimp
    199a:	1722                	slli	a4,a4,0x28
    199c:	8020                	0x8020
    199e:	0000                	unimp
    19a0:	0000                	unimp
    19a2:	0018                	0x18
    19a4:	0000                	unimp
    19a6:	0000                	unimp
    19a8:	0000                	unimp
    19aa:	9c01                	subw	s0,s0,s0
    19ac:	6809                	lui	a6,0x2
    19ae:	0006                	c.slli	zero,0x1
    19b0:	0100                	addi	s0,sp,128
    19b2:	1700062b          	0x1700062b
    19b6:	8020                	0x8020
    19b8:	0000                	unimp
    19ba:	0000                	unimp
    19bc:	0022                	c.slli	zero,0x8
    19be:	0000                	unimp
    19c0:	0000                	unimp
    19c2:	0000                	unimp
    19c4:	9c01                	subw	s0,s0,s0
    19c6:	0128                	addi	a0,sp,136
    19c8:	0000                	unimp
    19ca:	4e06                	lw	t3,64(sp)
    19cc:	01000003          	lb	zero,16(zero) # 10 <n+0x4>
    19d0:	003b172b          	0x3b172b
    19d4:	0000                	unimp
    19d6:	9102                	jalr	sp
    19d8:	006c                	addi	a1,sp,12
    19da:	4005                	c.li	zero,1
    19dc:	0006                	c.slli	zero,0x1
    19de:	0100                	addi	s0,sp,128
    19e0:	0926                	slli	s2,s2,0x9
    19e2:	004e                	c.slli	zero,0x13
    19e4:	0000                	unimp
    19e6:	16d0                	addi	a2,sp,868
    19e8:	8020                	0x8020
    19ea:	0000                	unimp
    19ec:	0000                	unimp
    19ee:	0030                	addi	a2,sp,8
    19f0:	0000                	unimp
    19f2:	0000                	unimp
    19f4:	0000                	unimp
    19f6:	9c01                	subw	s0,s0,s0
    19f8:	00000177          	0x177
    19fc:	660a                	ld	a2,128(sp)
    19fe:	0064                	addi	s1,sp,12
    1a00:	2601                	sext.w	a2,a2
    1a02:	821c                	0x821c
    1a04:	0000                	unimp
    1a06:	0200                	addi	s0,sp,256
    1a08:	6891                	lui	a7,0x4
    1a0a:	620a                	ld	tp,128(sp)
    1a0c:	6675                	lui	a2,0x1d
    1a0e:	0100                	addi	s0,sp,128
    1a10:	2c26                	fld	fs8,72(sp)
    1a12:	00000177          	0x177
    1a16:	9102                	jalr	sp
    1a18:	0660                	addi	s0,sp,780
    1a1a:	0630                	addi	a2,sp,776
    1a1c:	0000                	unimp
    1a1e:	2601                	sext.w	a2,a2
    1a20:	823a                	mv	tp,a4
    1a22:	0000                	unimp
    1a24:	0200                	addi	s0,sp,256
    1a26:	5891                	li	a7,-28
    1a28:	0700                	addi	s0,sp,896
    1a2a:	7d08                	ld	a0,56(a0)
    1a2c:	0001                	nop
    1a2e:	0b00                	addi	s0,sp,400
    1a30:	3a08                	fld	fa0,48(a2)
    1a32:	0006                	c.slli	zero,0x1
    1a34:	0100                	addi	s0,sp,128
    1a36:	091f 004e 0000      	0x4e091f
    1a3c:	16aa                	slli	a3,a3,0x2a
    1a3e:	8020                	0x8020
    1a40:	0000                	unimp
    1a42:	0000                	unimp
    1a44:	0026                	c.slli	zero,0x9
    1a46:	0000                	unimp
    1a48:	0000                	unimp
    1a4a:	0000                	unimp
    1a4c:	9c01                	subw	s0,s0,s0
    1a4e:	4405                	li	s0,1
    1a50:	0006                	c.slli	zero,0x1
    1a52:	0100                	addi	s0,sp,128
    1a54:	0911                	addi	s2,s2,4
    1a56:	004e                	c.slli	zero,0x13
    1a58:	0000                	unimp
    1a5a:	165a                	slli	a2,a2,0x36
    1a5c:	8020                	0x8020
    1a5e:	0000                	unimp
    1a60:	0000                	unimp
    1a62:	0050                	addi	a2,sp,4
    1a64:	0000                	unimp
    1a66:	0000                	unimp
    1a68:	0000                	unimp
    1a6a:	9c01                	subw	s0,s0,s0
    1a6c:	000001eb          	0x1eb
    1a70:	660a                	ld	a2,128(sp)
    1a72:	0064                	addi	s1,sp,12
    1a74:	1101                	addi	sp,sp,-32
    1a76:	8218                	0x8218
    1a78:	0000                	unimp
    1a7a:	0200                	addi	s0,sp,256
    1a7c:	6891                	lui	a7,0x4
    1a7e:	620a                	ld	tp,128(sp)
    1a80:	6675                	lui	a2,0x1d
    1a82:	0100                	addi	s0,sp,128
    1a84:	2811                	addiw	a6,a6,4
    1a86:	00000177          	0x177
    1a8a:	9102                	jalr	sp
    1a8c:	0660                	addi	s0,sp,780
    1a8e:	0630                	addi	a2,sp,776
    1a90:	0000                	unimp
    1a92:	1101                	addi	sp,sp,-32
    1a94:	8236                	mv	tp,a3
    1a96:	0000                	unimp
    1a98:	0200                	addi	s0,sp,256
    1a9a:	5891                	li	a7,-28
    1a9c:	0c00                	addi	s0,sp,528
    1a9e:	066c                	addi	a1,sp,780
    1aa0:	0000                	unimp
    1aa2:	0901                	addi	s2,s2,0
    1aa4:	3b09                	addiw	s6,s6,-30
    1aa6:	0000                	unimp
    1aa8:	1c00                	addi	s0,sp,560
    1aaa:	2016                	fld	ft0,320(sp)
    1aac:	0080                	addi	s0,sp,64
    1aae:	0000                	unimp
    1ab0:	3e00                	fld	fs0,56(a2)
    1ab2:	0000                	unimp
    1ab4:	0000                	unimp
    1ab6:	0000                	unimp
    1ab8:	0100                	addi	s0,sp,128
    1aba:	069c                	addi	a5,sp,832
    1abc:	0610                	addi	a2,sp,768
    1abe:	0000                	unimp
    1ac0:	0901                	addi	s2,s2,0
    1ac2:	3b16                	fld	fs6,352(sp)
    1ac4:	0000                	unimp
    1ac6:	0200                	addi	s0,sp,256
    1ac8:	6c91                	lui	s9,0x4
    1aca:	0000                	unimp
    1acc:	0100                	addi	s0,sp,128
    1ace:	0000                	unimp
    1ad0:	0004                	0x4
    1ad2:	0b49                	addi	s6,s6,18
    1ad4:	0000                	unimp
    1ad6:	0108                	addi	a0,sp,128
    1ad8:	0000008b          	0x8b
    1adc:	910c                	0x910c
    1ade:	0006                	c.slli	zero,0x1
    1ae0:	5900                	lw	s0,48(a0)
    1ae2:	0000                	unimp
    1ae4:	f400                	sd	s0,40(s0)
    1ae6:	00802017          	auipc	zero,0x802
    1aea:	0000                	unimp
    1aec:	9000                	0x9000
    1aee:	0000                	unimp
    1af0:	0000                	unimp
    1af2:	0000                	unimp
    1af4:	de00                	sw	s0,56(a2)
    1af6:	0018                	0x18
    1af8:	0200                	addi	s0,sp,256
    1afa:	0601                	addi	a2,a2,0
    1afc:	0044                	addi	s1,sp,4
    1afe:	0000                	unimp
    1b00:	0202                	c.slli64	tp
    1b02:	2205                	addiw	tp,tp,1
    1b04:	0000                	unimp
    1b06:	0300                	addi	s0,sp,384
    1b08:	0504                	addi	s1,sp,640
    1b0a:	6e69                	lui	t3,0x1a
    1b0c:	0074                	addi	a3,sp,12
    1b0e:	0802                	c.slli64	a6
    1b10:	5005                	c.li	zero,-31
    1b12:	0000                	unimp
    1b14:	0200                	addi	s0,sp,256
    1b16:	0801                	addi	a6,a6,0
    1b18:	0042                	c.slli	zero,0x10
    1b1a:	0000                	unimp
    1b1c:	0202                	c.slli64	tp
    1b1e:	00000f07          	0xf07
    1b22:	0200                	addi	s0,sp,256
    1b24:	0704                	addi	s1,sp,896
    1b26:	007e                	c.slli	zero,0x1f
    1b28:	0000                	unimp
    1b2a:	0604                	addi	s1,sp,768
    1b2c:	0000                	unimp
    1b2e:	0300                	addi	s0,sp,384
    1b30:	1b0e                	slli	s6,s6,0x23
    1b32:	006a                	c.slli	zero,0x1a
    1b34:	0000                	unimp
    1b36:	0802                	c.slli64	a6
    1b38:	00007907          	0x7907
    1b3c:	0500                	addi	s0,sp,640
    1b3e:	0000                	unimp
    1b40:	0000                	unimp
    1b42:	0502                	c.slli64	a0
    1b44:	5e11                	li	t3,-28
    1b46:	0000                	unimp
    1b48:	0900                	addi	s0,sp,144
    1b4a:	25af4003          	lbu	zero,602(t5)
    1b4e:	0080                	addi	s0,sp,64
    1b50:	0000                	unimp
    1b52:	0600                	addi	s0,sp,768
    1b54:	000006ab          	0x6ab
    1b58:	1901                	addi	s2,s2,-32
    1b5a:	5606                	lw	a2,96(sp)
    1b5c:	2018                	fld	fa4,0(s0)
    1b5e:	0080                	addi	s0,sp,64
    1b60:	0000                	unimp
    1b62:	2e00                	fld	fs0,24(a2)
    1b64:	0000                	unimp
    1b66:	0000                	unimp
    1b68:	0000                	unimp
    1b6a:	0100                	addi	s0,sp,128
    1b6c:	069c                	addi	a5,sp,832
    1b6e:	067c                	addi	a5,sp,780
    1b70:	0000                	unimp
    1b72:	1201                	addi	tp,tp,-32
    1b74:	3406                	fld	fs0,96(sp)
    1b76:	2018                	fld	fa4,0(s0)
    1b78:	0080                	addi	s0,sp,64
    1b7a:	0000                	unimp
    1b7c:	2200                	fld	fs0,0(a2)
    1b7e:	0000                	unimp
    1b80:	0000                	unimp
    1b82:	0000                	unimp
    1b84:	0100                	addi	s0,sp,128
    1b86:	069c                	addi	a5,sp,832
    1b88:	06bd                	addi	a3,a3,15
    1b8a:	0000                	unimp
    1b8c:	0c01                	addi	s8,s8,0
    1b8e:	0e06                	slli	t3,t3,0x1
    1b90:	2018                	fld	fa4,0(s0)
    1b92:	0080                	addi	s0,sp,64
    1b94:	0000                	unimp
    1b96:	2600                	fld	fs0,8(a2)
    1b98:	0000                	unimp
    1b9a:	0000                	unimp
    1b9c:	0000                	unimp
    1b9e:	0100                	addi	s0,sp,128
    1ba0:	079c                	addi	a5,sp,960
    1ba2:	00000687          	0x687
    1ba6:	0501                	addi	a0,a0,0
    1ba8:	5e18                	lw	a4,56(a2)
    1baa:	0000                	unimp
    1bac:	f400                	sd	s0,40(s0)
    1bae:	00802017          	auipc	zero,0x802
    1bb2:	0000                	unimp
    1bb4:	1a00                	addi	s0,sp,304
    1bb6:	0000                	unimp
    1bb8:	0000                	unimp
    1bba:	0000                	unimp
    1bbc:	0100                	addi	s0,sp,128
    1bbe:	059c                	addi	a5,sp,704
    1bc0:	068c                	addi	a1,sp,832
    1bc2:	0000                	unimp
    1bc4:	0701                	addi	a4,a4,0
    1bc6:	5e0e                	lw	t3,224(sp)
    1bc8:	0000                	unimp
    1bca:	0200                	addi	s0,sp,256
    1bcc:	6891                	lui	a7,0x4
    1bce:	0000                	unimp
    1bd0:	002a                	c.slli	zero,0xa
    1bd2:	0000                	unimp
    1bd4:	0002                	c.slli64	zero
    1bd6:	0bc5                	addi	s7,s7,17
    1bd8:	0000                	unimp
    1bda:	0108                	addi	a0,sp,128
    1bdc:	19c1                	addi	s3,s3,-16
    1bde:	0000                	unimp
    1be0:	0000                	unimp
    1be2:	8020                	0x8020
    1be4:	0000                	unimp
    1be6:	0000                	unimp
    1be8:	000c                	0xc
    1bea:	8020                	0x8020
    1bec:	0000                	unimp
    1bee:	0000                	unimp
    1bf0:	06d2                	slli	a3,a3,0x14
    1bf2:	0000                	unimp
    1bf4:	0059                	c.nop	22
    1bf6:	0000                	unimp
    1bf8:	000006e7          	jalr	a3,zero # 0 <n-0xc>
    1bfc:	8001                	c.srli64	s0
    1bfe:	002a                	c.slli	zero,0xa
    1c00:	0000                	unimp
    1c02:	0002                	c.slli64	zero
    1c04:	0bd9                	addi	s7,s7,22
    1c06:	0000                	unimp
    1c08:	0108                	addi	a0,sp,128
    1c0a:	1a0e                	slli	s4,s4,0x23
    1c0c:	0000                	unimp
    1c0e:	1884                	addi	s1,sp,112
    1c10:	8020                	0x8020
    1c12:	0000                	unimp
    1c14:	0000                	unimp
    1c16:	1934                	addi	a3,sp,184
    1c18:	8020                	0x8020
    1c1a:	0000                	unimp
    1c1c:	0000                	unimp
    1c1e:	06f5                	addi	a3,a3,29
    1c20:	0000                	unimp
    1c22:	0059                	c.nop	22
    1c24:	0000                	unimp
    1c26:	000006e7          	jalr	a3,zero # 0 <n-0xc>
    1c2a:	8001                	c.srli64	s0
    1c2c:	002a                	c.slli	zero,0xa
    1c2e:	0000                	unimp
    1c30:	0002                	c.slli64	zero
    1c32:	0bed                	addi	s7,s7,27
    1c34:	0000                	unimp
    1c36:	0108                	addi	a0,sp,128
    1c38:	1aec                	addi	a1,sp,380
    1c3a:	0000                	unimp
    1c3c:	193a                	slli	s2,s2,0x2e
    1c3e:	8020                	0x8020
    1c40:	0000                	unimp
    1c42:	0000                	unimp
    1c44:	19a4                	addi	s1,sp,248
    1c46:	8020                	0x8020
    1c48:	0000                	unimp
    1c4a:	0000                	unimp
    1c4c:	0709                	addi	a4,a4,2
    1c4e:	0000                	unimp
    1c50:	0059                	c.nop	22
    1c52:	0000                	unimp
    1c54:	000006e7          	jalr	a3,zero # 0 <n-0xc>
    1c58:	8001                	c.srli64	s0

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	1101                	addi	sp,sp,-32
   2:	2501                	sext.w	a0,a0
   4:	130e                	slli	t1,t1,0x23
   6:	1b0e030b          	0x1b0e030b
   a:	110e                	slli	sp,sp,0x23
   c:	1201                	addi	tp,tp,-32
   e:	00171007          	0x171007
  12:	0200                	addi	s0,sp,256
  14:	0024                	addi	s1,sp,8
  16:	0b3e0b0b          	0xb3e0b0b
  1a:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
  1e:	0b002403          	lw	s0,176(zero) # b0 <n+0x90>
  22:	030b3e0b          	0x30b3e0b
  26:	0008                	0x8
  28:	0400                	addi	s0,sp,512
  2a:	0016                	c.slli	zero,0x5
  2c:	0b3a0e03          	lb	t3,179(s4) # 40b3 <n+0x4093>
  30:	0b390b3b          	0xb390b3b
  34:	1349                	addi	t1,t1,-14
  36:	0000                	unimp
  38:	3405                	addiw	s0,s0,-31
  3a:	0300                	addi	s0,sp,384
  3c:	3a0e                	fld	fs4,224(sp)
  3e:	390b3b0b          	0x390b3b0b
  42:	0213490b          	0x213490b
  46:	0018                	0x18
  48:	0600                	addi	s0,sp,768
  4a:	002e                	c.slli	zero,0xb
  4c:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
  54:	0b39                	addi	s6,s6,14
  56:	1349                	addi	t1,t1,-14
  58:	0111                	addi	sp,sp,4
  5a:	0712                	slli	a4,a4,0x4
  5c:	1840                	addi	s0,sp,52
  5e:	4296                	lw	t0,68(sp)
  60:	0019                	c.nop	6
  62:	0000                	unimp
  64:	1101                	addi	sp,sp,-32
  66:	2501                	sext.w	a0,a0
  68:	130e                	slli	t1,t1,0x23
  6a:	1b0e030b          	0x1b0e030b
  6e:	110e                	slli	sp,sp,0x23
  70:	1201                	addi	tp,tp,-32
  72:	00171007          	0x171007
  76:	0200                	addi	s0,sp,256
  78:	0024                	addi	s1,sp,8
  7a:	0b3e0b0b          	0xb3e0b0b
  7e:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
  82:	0b002403          	lw	s0,176(zero) # b0 <n+0x90>
  86:	030b3e0b          	0x30b3e0b
  8a:	0008                	0x8
  8c:	0400                	addi	s0,sp,512
  8e:	0016                	c.slli	zero,0x5
  90:	0b3a0e03          	lb	t3,179(s4)
  94:	0b390b3b          	0xb390b3b
  98:	1349                	addi	t1,t1,-14
  9a:	0000                	unimp
  9c:	2e05                	addiw	t3,t3,1
  9e:	3f01                	addiw	t5,t5,-32
  a0:	0319                	addi	t1,t1,6
  a2:	3a0e                	fld	fs4,224(sp)
  a4:	390b3b0b          	0x390b3b0b
  a8:	4919270b          	0x4919270b
  ac:	12011113          	0x12011113
  b0:	96184007          	flq	ft0,-1695(a6) # 1961 <n+0x1941>
  b4:	1942                	slli	s2,s2,0x30
  b6:	1301                	addi	t1,t1,-32
  b8:	0000                	unimp
  ba:	0506                	slli	a0,a0,0x1
  bc:	0300                	addi	s0,sp,384
  be:	3a0e                	fld	fs4,224(sp)
  c0:	390b3b0b          	0x390b3b0b
  c4:	0213490b          	0x213490b
  c8:	0018                	0x18
  ca:	0700                	addi	s0,sp,896
  cc:	002e                	c.slli	zero,0xb
  ce:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
  d6:	0b39                	addi	s6,s6,14
  d8:	13491927          	0x13491927
  dc:	0111                	addi	sp,sp,4
  de:	0712                	slli	a4,a4,0x4
  e0:	1840                	addi	s0,sp,52
  e2:	4296                	lw	t0,68(sp)
  e4:	0019                	c.nop	6
  e6:	0800                	addi	s0,sp,16
  e8:	012e                	slli	sp,sp,0xb
  ea:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
  f2:	0b39                	addi	s6,s6,14
  f4:	01111927          	0x1111927
  f8:	0712                	slli	a4,a4,0x4
  fa:	1840                	addi	s0,sp,52
  fc:	4296                	lw	t0,68(sp)
  fe:	0119                	addi	sp,sp,6
 100:	09000013          	li	zero,144
 104:	0005                	c.nop	1
 106:	0b3a0803          	lb	a6,179(s4)
 10a:	0b390b3b          	0xb390b3b
 10e:	1349                	addi	t1,t1,-14
 110:	1802                	slli	a6,a6,0x20
 112:	0000                	unimp
 114:	2e0a                	fld	ft8,128(sp)
 116:	0301                	addi	t1,t1,0
 118:	3a0e                	fld	fs4,224(sp)
 11a:	390b3b0b          	0x390b3b0b
 11e:	4919270b          	0x4919270b
 122:	12011113          	0x12011113
 126:	97184007          	flq	ft0,-1679(a6)
 12a:	1942                	slli	s2,s2,0x30
 12c:	0000                	unimp
 12e:	0300340b          	0x300340b
 132:	3a08                	fld	fa0,48(a2)
 134:	390b3b0b          	0x390b3b0b
 138:	0213490b          	0x213490b
 13c:	0018                	0x18
 13e:	0000                	unimp
 140:	1101                	addi	sp,sp,-32
 142:	2501                	sext.w	a0,a0
 144:	130e                	slli	t1,t1,0x23
 146:	1b0e030b          	0x1b0e030b
 14a:	110e                	slli	sp,sp,0x23
 14c:	1201                	addi	tp,tp,-32
 14e:	00171007          	0x171007
 152:	0200                	addi	s0,sp,256
 154:	0024                	addi	s1,sp,8
 156:	0b3e0b0b          	0xb3e0b0b
 15a:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
 15e:	03001603          	lh	a2,48(zero) # 30 <n+0x10>
 162:	3a0e                	fld	fs4,224(sp)
 164:	390b3b0b          	0x390b3b0b
 168:	0013490b          	0x13490b
 16c:	0400                	addi	s0,sp,512
 16e:	0024                	addi	s1,sp,8
 170:	0b3e0b0b          	0xb3e0b0b
 174:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 178:	1605                	addi	a2,a2,-31
 17a:	0300                	addi	s0,sp,384
 17c:	3a08                	fld	fa0,48(a2)
 17e:	390b3b0b          	0x390b3b0b
 182:	0013490b          	0x13490b
 186:	0600                	addi	s0,sp,768
 188:	0026                	c.slli	zero,0x9
 18a:	1349                	addi	t1,t1,-14
 18c:	0000                	unimp
 18e:	3f012e07          	flw	ft8,1008(sp) # 383d6 <n+0x383b6>
 192:	0319                	addi	t1,t1,6
 194:	3a0e                	fld	fs4,224(sp)
 196:	390b3b0b          	0x390b3b0b
 19a:	1119270b          	0x1119270b
 19e:	1201                	addi	tp,tp,-32
 1a0:	96184007          	flq	ft0,-1695(a6)
 1a4:	1942                	slli	s2,s2,0x30
 1a6:	1301                	addi	t1,t1,-32
 1a8:	0000                	unimp
 1aa:	0508                	addi	a0,sp,640
 1ac:	0300                	addi	s0,sp,384
 1ae:	3a0e                	fld	fs4,224(sp)
 1b0:	390b3b0b          	0x390b3b0b
 1b4:	0213490b          	0x213490b
 1b8:	0018                	0x18
 1ba:	0900                	addi	s0,sp,144
 1bc:	0005                	c.nop	1
 1be:	0b3a0803          	lb	a6,179(s4)
 1c2:	0b390b3b          	0xb390b3b
 1c6:	1349                	addi	t1,t1,-14
 1c8:	1802                	slli	a6,a6,0x20
 1ca:	0000                	unimp
 1cc:	0f0a                	slli	t5,t5,0x2
 1ce:	0b00                	addi	s0,sp,400
 1d0:	0b00000b          	0xb00000b
 1d4:	012e                	slli	sp,sp,0xb
 1d6:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 1de:	0b39                	addi	s6,s6,14
 1e0:	01111927          	0x1111927
 1e4:	0712                	slli	a4,a4,0x4
 1e6:	1840                	addi	s0,sp,52
 1e8:	01194297          	auipc	t0,0x1194
 1ec:	0c000013          	li	zero,192
 1f0:	0b0b000f          	0xb0b000f
 1f4:	1349                	addi	t1,t1,-14
 1f6:	0000                	unimp
 1f8:	2e0d                	addiw	t3,t3,3
 1fa:	3f01                	addiw	t5,t5,-32
 1fc:	0319                	addi	t1,t1,6
 1fe:	3a0e                	fld	fs4,224(sp)
 200:	390b3b0b          	0x390b3b0b
 204:	4919270b          	0x4919270b
 208:	12011113          	0x12011113
 20c:	97184007          	flq	ft0,-1679(a6)
 210:	1942                	slli	s2,s2,0x30
 212:	1301                	addi	t1,t1,-32
 214:	0000                	unimp
 216:	340e                	fld	fs0,224(sp)
 218:	0300                	addi	s0,sp,384
 21a:	3a08                	fld	fa0,48(a2)
 21c:	390b3b0b          	0x390b3b0b
 220:	0213490b          	0x213490b
 224:	0018                	0x18
 226:	0f00                	addi	s0,sp,912
 228:	0034                	addi	a3,sp,8
 22a:	0b3a0e03          	lb	t3,179(s4)
 22e:	0b390b3b          	0xb390b3b
 232:	1349                	addi	t1,t1,-14
 234:	1802                	slli	a6,a6,0x20
 236:	0000                	unimp
 238:	0110                	addi	a2,sp,128
 23a:	4901                	li	s2,0
 23c:	00130113          	addi	sp,t1,1 # 4001 <n+0x3fe1>
 240:	1100                	addi	s0,sp,160
 242:	0021                	c.nop	8
 244:	1349                	addi	t1,t1,-14
 246:	0000182f          	0x182f
 24a:	0b12                	slli	s6,s6,0x4
 24c:	1101                	addi	sp,sp,-32
 24e:	1201                	addi	tp,tp,-32
 250:	13000007          	0x13000007
 254:	0026                	c.slli	zero,0x9
 256:	0000                	unimp
 258:	2e14                	fld	fa3,24(a2)
 25a:	3f01                	addiw	t5,t5,-32
 25c:	0319                	addi	t1,t1,6
 25e:	3a0e                	fld	fs4,224(sp)
 260:	390b3b0b          	0x390b3b0b
 264:	4919270b          	0x4919270b
 268:	12011113          	0x12011113
 26c:	97184007          	flq	ft0,-1679(a6)
 270:	1942                	slli	s2,s2,0x30
 272:	0000                	unimp
 274:	0100                	addi	s0,sp,128
 276:	0111                	addi	sp,sp,4
 278:	0e25                	addi	t3,t3,9
 27a:	0e030b13          	addi	s6,t1,224
 27e:	01110e1b          	addiw	t3,sp,17
 282:	0712                	slli	a4,a4,0x4
 284:	1710                	addi	a2,sp,928
 286:	0000                	unimp
 288:	2402                	fld	fs0,0(sp)
 28a:	0b00                	addi	s0,sp,400
 28c:	030b3e0b          	0x30b3e0b
 290:	000e                	c.slli	zero,0x3
 292:	0300                	addi	s0,sp,384
 294:	0024                	addi	s1,sp,8
 296:	0b3e0b0b          	0xb3e0b0b
 29a:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 29e:	1604                	addi	s1,sp,800
 2a0:	0300                	addi	s0,sp,384
 2a2:	3a0e                	fld	fs4,224(sp)
 2a4:	390b3b0b          	0x390b3b0b
 2a8:	0013490b          	0x13490b
 2ac:	0500                	addi	s0,sp,640
 2ae:	012e                	slli	sp,sp,0xb
 2b0:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 2b8:	0b39                	addi	s6,s6,14
 2ba:	01111927          	0x1111927
 2be:	0712                	slli	a4,a4,0x4
 2c0:	1840                	addi	s0,sp,52
 2c2:	4296                	lw	t0,68(sp)
 2c4:	0119                	addi	sp,sp,6
 2c6:	06000013          	li	zero,96
 2ca:	0005                	c.nop	1
 2cc:	0b3a0e03          	lb	t3,179(s4)
 2d0:	0b390b3b          	0xb390b3b
 2d4:	1349                	addi	t1,t1,-14
 2d6:	1802                	slli	a6,a6,0x20
 2d8:	0000                	unimp
 2da:	11010b07          	0x11010b07
 2de:	1201                	addi	tp,tp,-32
 2e0:	08000007          	0x8000007
 2e4:	0034                	addi	a3,sp,8
 2e6:	0b3a0803          	lb	a6,179(s4)
 2ea:	0b390b3b          	0xb390b3b
 2ee:	1349                	addi	t1,t1,-14
 2f0:	1802                	slli	a6,a6,0x20
 2f2:	0000                	unimp
 2f4:	3409                	addiw	s0,s0,-30
 2f6:	0300                	addi	s0,sp,384
 2f8:	3a0e                	fld	fs4,224(sp)
 2fa:	390b3b0b          	0x390b3b0b
 2fe:	0213490b          	0x213490b
 302:	0018                	0x18
 304:	0a00                	addi	s0,sp,272
 306:	0026                	c.slli	zero,0x9
 308:	1349                	addi	t1,t1,-14
 30a:	0000                	unimp
 30c:	4901010b          	0x4901010b
 310:	00130113          	addi	sp,t1,1
 314:	0c00                	addi	s0,sp,528
 316:	0021                	c.nop	8
 318:	1349                	addi	t1,t1,-14
 31a:	00000b2f          	0xb2f
 31e:	2e0d                	addiw	t3,t3,3
 320:	3f01                	addiw	t5,t5,-32
 322:	0319                	addi	t1,t1,6
 324:	3a0e                	fld	fs4,224(sp)
 326:	390b3b0b          	0x390b3b0b
 32a:	1119270b          	0x1119270b
 32e:	1201                	addi	tp,tp,-32
 330:	97184007          	flq	ft0,-1679(a6)
 334:	1942                	slli	s2,s2,0x30
 336:	1301                	addi	t1,t1,-32
 338:	0000                	unimp
 33a:	050e                	slli	a0,a0,0x3
 33c:	0300                	addi	s0,sp,384
 33e:	3a08                	fld	fa0,48(a2)
 340:	390b3b0b          	0x390b3b0b
 344:	0213490b          	0x213490b
 348:	0018                	0x18
 34a:	0f00                	addi	s0,sp,912
 34c:	0b0b000f          	0xb0b000f
 350:	1349                	addi	t1,t1,-14
 352:	0000                	unimp
 354:	0100                	addi	s0,sp,128
 356:	0111                	addi	sp,sp,4
 358:	0e25                	addi	t3,t3,9
 35a:	0e030b13          	addi	s6,t1,224
 35e:	01110e1b          	addiw	t3,sp,17
 362:	0712                	slli	a4,a4,0x4
 364:	1710                	addi	a2,sp,928
 366:	0000                	unimp
 368:	2402                	fld	fs0,0(sp)
 36a:	0b00                	addi	s0,sp,400
 36c:	030b3e0b          	0x30b3e0b
 370:	000e                	c.slli	zero,0x3
 372:	0300                	addi	s0,sp,384
 374:	0024                	addi	s1,sp,8
 376:	0b3e0b0b          	0xb3e0b0b
 37a:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 37e:	2e04                	fld	fs1,24(a2)
 380:	3f01                	addiw	t5,t5,-32
 382:	0319                	addi	t1,t1,6
 384:	3a0e                	fld	fs4,224(sp)
 386:	390b3b0b          	0x390b3b0b
 38a:	1119270b          	0x1119270b
 38e:	1201                	addi	tp,tp,-32
 390:	96184007          	flq	ft0,-1695(a6)
 394:	1942                	slli	s2,s2,0x30
 396:	1301                	addi	t1,t1,-32
 398:	0000                	unimp
 39a:	0505                	addi	a0,a0,1
 39c:	0300                	addi	s0,sp,384
 39e:	3a0e                	fld	fs4,224(sp)
 3a0:	390b3b0b          	0x390b3b0b
 3a4:	0213490b          	0x213490b
 3a8:	0018                	0x18
 3aa:	0600                	addi	s0,sp,768
 3ac:	0b0b000f          	0xb0b000f
 3b0:	1349                	addi	t1,t1,-14
 3b2:	0000                	unimp
 3b4:	49002607          	flw	fa2,1168(zero) # 490 <n+0x470>
 3b8:	00000013          	nop
 3bc:	1101                	addi	sp,sp,-32
 3be:	2501                	sext.w	a0,a0
 3c0:	130e                	slli	t1,t1,0x23
 3c2:	1b0e030b          	0x1b0e030b
 3c6:	110e                	slli	sp,sp,0x23
 3c8:	1201                	addi	tp,tp,-32
 3ca:	00171007          	0x171007
 3ce:	0200                	addi	s0,sp,256
 3d0:	0024                	addi	s1,sp,8
 3d2:	0b3e0b0b          	0xb3e0b0b
 3d6:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
 3da:	0b002403          	lw	s0,176(zero) # b0 <n+0x90>
 3de:	030b3e0b          	0x30b3e0b
 3e2:	0008                	0x8
 3e4:	0400                	addi	s0,sp,512
 3e6:	0016                	c.slli	zero,0x5
 3e8:	0b3a0e03          	lb	t3,179(s4)
 3ec:	0b390b3b          	0xb390b3b
 3f0:	1349                	addi	t1,t1,-14
 3f2:	0000                	unimp
 3f4:	1305                	addi	t1,t1,-31
 3f6:	0301                	addi	t1,t1,0
 3f8:	0b0e                	slli	s6,s6,0x3
 3fa:	3a05                	addiw	s4,s4,-31
 3fc:	390b3b0b          	0x390b3b0b
 400:	0013010b          	0x13010b
 404:	0600                	addi	s0,sp,768
 406:	000d                	c.nop	3
 408:	0b3a0803          	lb	a6,179(s4)
 40c:	0b390b3b          	0xb390b3b
 410:	1349                	addi	t1,t1,-14
 412:	0b38                	addi	a4,sp,408
 414:	0000                	unimp
 416:	03000d07          	0x3000d07
 41a:	3a0e                	fld	fs4,224(sp)
 41c:	390b3b0b          	0x390b3b0b
 420:	3813490b          	0x3813490b
 424:	0005                	c.nop	1
 426:	0800                	addi	s0,sp,16
 428:	0101                	addi	sp,sp,0
 42a:	1349                	addi	t1,t1,-14
 42c:	1301                	addi	t1,t1,-32
 42e:	0000                	unimp
 430:	2109                	addiw	sp,sp,2
 432:	4900                	lw	s0,16(a0)
 434:	000b2f13          	slti	t5,s6,0
 438:	0a00                	addi	s0,sp,272
 43a:	0104                	addi	s1,sp,128
 43c:	0b3e0e03          	lb	t3,179(t3) # 1a0b3 <n+0x1a093>
 440:	13490b0b          	0x13490b0b
 444:	0b3a                	slli	s6,s6,0xe
 446:	0b390b3b          	0xb390b3b
 44a:	1301                	addi	t1,t1,-32
 44c:	0000                	unimp
 44e:	0300280b          	0x300280b
 452:	1c0e                	slli	s8,s8,0x23
 454:	0c00000b          	0xc00000b
 458:	0e030113          	addi	sp,t1,224
 45c:	0b3a0b0b          	0xb3a0b0b
 460:	0b390b3b          	0xb390b3b
 464:	1301                	addi	t1,t1,-32
 466:	0000                	unimp
 468:	0d0d                	addi	s10,s10,3
 46a:	0300                	addi	s0,sp,384
 46c:	3a0e                	fld	fs4,224(sp)
 46e:	390b3b0b          	0x390b3b0b
 472:	3813490b          	0x3813490b
 476:	0e00000b          	0xe00000b
 47a:	0034                	addi	a3,sp,8
 47c:	0b3a0e03          	lb	t3,179(s4)
 480:	0b390b3b          	0xb390b3b
 484:	1349                	addi	t1,t1,-14
 486:	193c193f 340f0000 	0x340f0000193c193f
 48e:	4700                	lw	s0,8(a4)
 490:	3b0b3a13          	sltiu	s4,s6,944
 494:	020b390b          	0x20b390b
 498:	0018                	0x18
 49a:	1000                	addi	s0,sp,32
 49c:	012e                	slli	sp,sp,0xb
 49e:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 4a6:	0b39                	addi	s6,s6,14
 4a8:	01111927          	0x1111927
 4ac:	0712                	slli	a4,a4,0x4
 4ae:	1840                	addi	s0,sp,52
 4b0:	4296                	lw	t0,68(sp)
 4b2:	0119                	addi	sp,sp,6
 4b4:	11000013          	li	zero,272
 4b8:	0034                	addi	a3,sp,8
 4ba:	0b3a0e03          	lb	t3,179(s4)
 4be:	0b390b3b          	0xb390b3b
 4c2:	1349                	addi	t1,t1,-14
 4c4:	1802                	slli	a6,a6,0x20
 4c6:	0000                	unimp
 4c8:	0512                	slli	a0,a0,0x4
 4ca:	0300                	addi	s0,sp,384
 4cc:	3a0e                	fld	fs4,224(sp)
 4ce:	390b3b0b          	0x390b3b0b
 4d2:	0213490b          	0x213490b
 4d6:	0018                	0x18
 4d8:	1300                	addi	s0,sp,416
 4da:	0b0b000f          	0xb0b000f
 4de:	1349                	addi	t1,t1,-14
 4e0:	0000                	unimp
 4e2:	2e14                	fld	fa3,24(a2)
 4e4:	3f01                	addiw	t5,t5,-32
 4e6:	0319                	addi	t1,t1,6
 4e8:	3a0e                	fld	fs4,224(sp)
 4ea:	390b3b0b          	0x390b3b0b
 4ee:	1119270b          	0x1119270b
 4f2:	1201                	addi	tp,tp,-32
 4f4:	96184007          	flq	ft0,-1695(a6)
 4f8:	1942                	slli	s2,s2,0x30
 4fa:	0000                	unimp
 4fc:	2e15                	addiw	t3,t3,5
 4fe:	3f01                	addiw	t5,t5,-32
 500:	0319                	addi	t1,t1,6
 502:	3a0e                	fld	fs4,224(sp)
 504:	390b3b0b          	0x390b3b0b
 508:	3c19270b          	0x3c19270b
 50c:	0119                	addi	sp,sp,6
 50e:	16000013          	li	zero,352
 512:	0005                	c.nop	1
 514:	1349                	addi	t1,t1,-14
 516:	0000                	unimp
 518:	11010b17          	auipc	s6,0x11010
 51c:	1201                	addi	tp,tp,-32
 51e:	18000007          	0x18000007
 522:	0034                	addi	a3,sp,8
 524:	0b3a0803          	lb	a6,179(s4)
 528:	0b390b3b          	0xb390b3b
 52c:	1349                	addi	t1,t1,-14
 52e:	1802                	slli	a6,a6,0x20
 530:	0000                	unimp
 532:	0100                	addi	s0,sp,128
 534:	0111                	addi	sp,sp,4
 536:	0e25                	addi	t3,t3,9
 538:	0e030b13          	addi	s6,t1,224
 53c:	01110e1b          	addiw	t3,sp,17
 540:	0712                	slli	a4,a4,0x4
 542:	1710                	addi	a2,sp,928
 544:	0000                	unimp
 546:	2402                	fld	fs0,0(sp)
 548:	0b00                	addi	s0,sp,400
 54a:	030b3e0b          	0x30b3e0b
 54e:	000e                	c.slli	zero,0x3
 550:	0300                	addi	s0,sp,384
 552:	0024                	addi	s1,sp,8
 554:	0b3e0b0b          	0xb3e0b0b
 558:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 55c:	1604                	addi	s1,sp,800
 55e:	0300                	addi	s0,sp,384
 560:	3a0e                	fld	fs4,224(sp)
 562:	390b3b0b          	0x390b3b0b
 566:	0013490b          	0x13490b
 56a:	0500                	addi	s0,sp,640
 56c:	0e030113          	addi	sp,t1,224
 570:	0b3a050b          	0xb3a050b
 574:	0b390b3b          	0xb390b3b
 578:	1301                	addi	t1,t1,-32
 57a:	0000                	unimp
 57c:	0d06                	slli	s10,s10,0x1
 57e:	0300                	addi	s0,sp,384
 580:	3a08                	fld	fa0,48(a2)
 582:	390b3b0b          	0x390b3b0b
 586:	3813490b          	0x3813490b
 58a:	0700000b          	0x700000b
 58e:	000d                	c.nop	3
 590:	0b3a0e03          	lb	t3,179(s4)
 594:	0b390b3b          	0xb390b3b
 598:	1349                	addi	t1,t1,-14
 59a:	0538                	addi	a4,sp,648
 59c:	0000                	unimp
 59e:	0108                	addi	a0,sp,128
 5a0:	4901                	li	s2,0
 5a2:	00130113          	addi	sp,t1,1
 5a6:	0900                	addi	s0,sp,144
 5a8:	0021                	c.nop	8
 5aa:	1349                	addi	t1,t1,-14
 5ac:	00000b2f          	0xb2f
 5b0:	0d0a                	slli	s10,s10,0x2
 5b2:	0300                	addi	s0,sp,384
 5b4:	3a0e                	fld	fs4,224(sp)
 5b6:	390b3b0b          	0x390b3b0b
 5ba:	3813490b          	0x3813490b
 5be:	0b00000b          	0xb00000b
 5c2:	0034                	addi	a3,sp,8
 5c4:	0b3a0e03          	lb	t3,179(s4)
 5c8:	0b390b3b          	0xb390b3b
 5cc:	1349                	addi	t1,t1,-14
 5ce:	193c193f 210c0000 	0x210c0000193c193f
 5d6:	0000                	unimp
 5d8:	0d00                	addi	s0,sp,656
 5da:	0021                	c.nop	8
 5dc:	1349                	addi	t1,t1,-14
 5de:	0000052f          	0x52f
 5e2:	340e                	fld	fs0,224(sp)
 5e4:	4700                	lw	s0,8(a4)
 5e6:	3b0b3a13          	sltiu	s4,s6,944
 5ea:	020b390b          	0x20b390b
 5ee:	0018                	0x18
 5f0:	0f00                	addi	s0,sp,912
 5f2:	012e                	slli	sp,sp,0xb
 5f4:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 5fc:	0b39                	addi	s6,s6,14
 5fe:	0111                	addi	sp,sp,4
 600:	0712                	slli	a4,a4,0x4
 602:	1840                	addi	s0,sp,52
 604:	4296                	lw	t0,68(sp)
 606:	0119                	addi	sp,sp,6
 608:	10000013          	li	zero,256
 60c:	0034                	addi	a3,sp,8
 60e:	0b3a0e03          	lb	t3,179(s4)
 612:	0b390b3b          	0xb390b3b
 616:	1349                	addi	t1,t1,-14
 618:	1802                	slli	a6,a6,0x20
 61a:	0000                	unimp
 61c:	0b11                	addi	s6,s6,4
 61e:	1101                	addi	sp,sp,-32
 620:	1201                	addi	tp,tp,-32
 622:	12000007          	0x12000007
 626:	0034                	addi	a3,sp,8
 628:	0b3a0803          	lb	a6,179(s4)
 62c:	0b390b3b          	0xb390b3b
 630:	1349                	addi	t1,t1,-14
 632:	1802                	slli	a6,a6,0x20
 634:	0000                	unimp
 636:	0b000f13          	li	t5,176
 63a:	0013490b          	0x13490b
 63e:	1400                	addi	s0,sp,544
 640:	0026                	c.slli	zero,0x9
 642:	0000                	unimp
 644:	0f15                	addi	t5,t5,5
 646:	0b00                	addi	s0,sp,400
 648:	1600000b          	0x1600000b
 64c:	012e                	slli	sp,sp,0xb
 64e:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 656:	0b39                	addi	s6,s6,14
 658:	01111927          	0x1111927
 65c:	0712                	slli	a4,a4,0x4
 65e:	1840                	addi	s0,sp,52
 660:	4296                	lw	t0,68(sp)
 662:	0119                	addi	sp,sp,6
 664:	17000013          	li	zero,368
 668:	0005                	c.nop	1
 66a:	0b3a0e03          	lb	t3,179(s4)
 66e:	0b390b3b          	0xb390b3b
 672:	1349                	addi	t1,t1,-14
 674:	1802                	slli	a6,a6,0x20
 676:	0000                	unimp
 678:	2e18                	fld	fa4,24(a2)
 67a:	3f01                	addiw	t5,t5,-32
 67c:	0319                	addi	t1,t1,6
 67e:	3a0e                	fld	fs4,224(sp)
 680:	390b3b0b          	0x390b3b0b
 684:	1201110b          	0x1201110b
 688:	96184007          	flq	ft0,-1695(a6)
 68c:	1942                	slli	s2,s2,0x30
 68e:	0000                	unimp
 690:	0100                	addi	s0,sp,128
 692:	0111                	addi	sp,sp,4
 694:	0e25                	addi	t3,t3,9
 696:	0e030b13          	addi	s6,t1,224
 69a:	01110e1b          	addiw	t3,sp,17
 69e:	0712                	slli	a4,a4,0x4
 6a0:	1710                	addi	a2,sp,928
 6a2:	0000                	unimp
 6a4:	2402                	fld	fs0,0(sp)
 6a6:	0b00                	addi	s0,sp,400
 6a8:	030b3e0b          	0x30b3e0b
 6ac:	000e                	c.slli	zero,0x3
 6ae:	0300                	addi	s0,sp,384
 6b0:	0024                	addi	s1,sp,8
 6b2:	0b3e0b0b          	0xb3e0b0b
 6b6:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 6ba:	1604                	addi	s1,sp,800
 6bc:	0300                	addi	s0,sp,384
 6be:	3a0e                	fld	fs4,224(sp)
 6c0:	390b3b0b          	0x390b3b0b
 6c4:	0013490b          	0x13490b
 6c8:	0500                	addi	s0,sp,640
 6ca:	0e030113          	addi	sp,t1,224
 6ce:	0b3a050b          	0xb3a050b
 6d2:	0b390b3b          	0xb390b3b
 6d6:	1301                	addi	t1,t1,-32
 6d8:	0000                	unimp
 6da:	0d06                	slli	s10,s10,0x1
 6dc:	0300                	addi	s0,sp,384
 6de:	3a08                	fld	fa0,48(a2)
 6e0:	390b3b0b          	0x390b3b0b
 6e4:	3813490b          	0x3813490b
 6e8:	0700000b          	0x700000b
 6ec:	000d                	c.nop	3
 6ee:	0b3a0e03          	lb	t3,179(s4)
 6f2:	0b390b3b          	0xb390b3b
 6f6:	1349                	addi	t1,t1,-14
 6f8:	0538                	addi	a4,sp,648
 6fa:	0000                	unimp
 6fc:	0108                	addi	a0,sp,128
 6fe:	4901                	li	s2,0
 700:	00130113          	addi	sp,t1,1
 704:	0900                	addi	s0,sp,144
 706:	0021                	c.nop	8
 708:	1349                	addi	t1,t1,-14
 70a:	00000b2f          	0xb2f
 70e:	0d0a                	slli	s10,s10,0x2
 710:	0300                	addi	s0,sp,384
 712:	3a0e                	fld	fs4,224(sp)
 714:	390b3b0b          	0x390b3b0b
 718:	3813490b          	0x3813490b
 71c:	0b00000b          	0xb00000b
 720:	0034                	addi	a3,sp,8
 722:	0b3a0e03          	lb	t3,179(s4)
 726:	0b390b3b          	0xb390b3b
 72a:	1349                	addi	t1,t1,-14
 72c:	193c193f 210c0000 	0x210c0000193c193f
 734:	4900                	lw	s0,16(a0)
 736:	00052f13          	slti	t5,a0,0
 73a:	0d00                	addi	s0,sp,656
 73c:	0034                	addi	a3,sp,8
 73e:	0b3a1347          	fmsub.d	ft6,fs4,fs3,ft1,rtz
 742:	0b390b3b          	0xb390b3b
 746:	1802                	slli	a6,a6,0x20
 748:	0000                	unimp
 74a:	2e0e                	fld	ft8,192(sp)
 74c:	3f01                	addiw	t5,t5,-32
 74e:	0319                	addi	t1,t1,6
 750:	3a0e                	fld	fs4,224(sp)
 752:	390b3b0b          	0x390b3b0b
 756:	4919270b          	0x4919270b
 75a:	12011113          	0x12011113
 75e:	96184007          	flq	ft0,-1695(a6)
 762:	1942                	slli	s2,s2,0x30
 764:	1301                	addi	t1,t1,-32
 766:	0000                	unimp
 768:	0300050f          	0x300050f
 76c:	3a08                	fld	fa0,48(a2)
 76e:	390b3b0b          	0x390b3b0b
 772:	0213490b          	0x213490b
 776:	0018                	0x18
 778:	1000                	addi	s0,sp,32
 77a:	0034                	addi	a3,sp,8
 77c:	0b3a0e03          	lb	t3,179(s4)
 780:	0b390b3b          	0xb390b3b
 784:	1349                	addi	t1,t1,-14
 786:	1802                	slli	a6,a6,0x20
 788:	0000                	unimp
 78a:	3411                	addiw	s0,s0,-28
 78c:	0300                	addi	s0,sp,384
 78e:	3a08                	fld	fa0,48(a2)
 790:	390b3b0b          	0x390b3b0b
 794:	0213490b          	0x213490b
 798:	0018                	0x18
 79a:	1200                	addi	s0,sp,288
 79c:	0005                	c.nop	1
 79e:	0b3a0e03          	lb	t3,179(s4)
 7a2:	0b390b3b          	0xb390b3b
 7a6:	1349                	addi	t1,t1,-14
 7a8:	1802                	slli	a6,a6,0x20
 7aa:	0000                	unimp
 7ac:	0b000f13          	li	t5,176
 7b0:	0013490b          	0x13490b
 7b4:	1400                	addi	s0,sp,544
 7b6:	012e                	slli	sp,sp,0xb
 7b8:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 7c0:	0b39                	addi	s6,s6,14
 7c2:	13491927          	0x13491927
 7c6:	0111                	addi	sp,sp,4
 7c8:	0712                	slli	a4,a4,0x4
 7ca:	1840                	addi	s0,sp,52
 7cc:	01194297          	auipc	t0,0x1194
 7d0:	15000013          	li	zero,336
 7d4:	012e                	slli	sp,sp,0xb
 7d6:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 7de:	0b39                	addi	s6,s6,14
 7e0:	01111927          	0x1111927
 7e4:	0712                	slli	a4,a4,0x4
 7e6:	1840                	addi	s0,sp,52
 7e8:	4296                	lw	t0,68(sp)
 7ea:	0119                	addi	sp,sp,6
 7ec:	16000013          	li	zero,352
 7f0:	012e                	slli	sp,sp,0xb
 7f2:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 7fa:	0b39                	addi	s6,s6,14
 7fc:	01111927          	0x1111927
 800:	0712                	slli	a4,a4,0x4
 802:	1840                	addi	s0,sp,52
 804:	4296                	lw	t0,68(sp)
 806:	0019                	c.nop	6
 808:	0000                	unimp
 80a:	1101                	addi	sp,sp,-32
 80c:	2501                	sext.w	a0,a0
 80e:	130e                	slli	t1,t1,0x23
 810:	1b0e030b          	0x1b0e030b
 814:	110e                	slli	sp,sp,0x23
 816:	1201                	addi	tp,tp,-32
 818:	00171007          	0x171007
 81c:	0200                	addi	s0,sp,256
 81e:	0024                	addi	s1,sp,8
 820:	0b3e0b0b          	0xb3e0b0b
 824:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
 828:	0b002403          	lw	s0,176(zero) # b0 <n+0x90>
 82c:	030b3e0b          	0x30b3e0b
 830:	0008                	0x8
 832:	0400                	addi	s0,sp,512
 834:	0016                	c.slli	zero,0x5
 836:	0b3a0e03          	lb	t3,179(s4)
 83a:	0b390b3b          	0xb390b3b
 83e:	1349                	addi	t1,t1,-14
 840:	0000                	unimp
 842:	1305                	addi	t1,t1,-31
 844:	0301                	addi	t1,t1,0
 846:	0b0e                	slli	s6,s6,0x3
 848:	3a05                	addiw	s4,s4,-31
 84a:	390b3b0b          	0x390b3b0b
 84e:	0013010b          	0x13010b
 852:	0600                	addi	s0,sp,768
 854:	000d                	c.nop	3
 856:	0b3a0803          	lb	a6,179(s4)
 85a:	0b390b3b          	0xb390b3b
 85e:	1349                	addi	t1,t1,-14
 860:	0b38                	addi	a4,sp,408
 862:	0000                	unimp
 864:	03000d07          	0x3000d07
 868:	3a0e                	fld	fs4,224(sp)
 86a:	390b3b0b          	0x390b3b0b
 86e:	3813490b          	0x3813490b
 872:	0005                	c.nop	1
 874:	0800                	addi	s0,sp,16
 876:	0101                	addi	sp,sp,0
 878:	1349                	addi	t1,t1,-14
 87a:	1301                	addi	t1,t1,-32
 87c:	0000                	unimp
 87e:	2109                	addiw	sp,sp,2
 880:	4900                	lw	s0,16(a0)
 882:	000b2f13          	slti	t5,s6,0
 886:	0a00                	addi	s0,sp,272
 888:	012e                	slli	sp,sp,0xb
 88a:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 892:	0b39                	addi	s6,s6,14
 894:	13491927          	0x13491927
 898:	0111                	addi	sp,sp,4
 89a:	0712                	slli	a4,a4,0x4
 89c:	1840                	addi	s0,sp,52
 89e:	4296                	lw	t0,68(sp)
 8a0:	0119                	addi	sp,sp,6
 8a2:	0b000013          	li	zero,176
 8a6:	0005                	c.nop	1
 8a8:	0b3a0e03          	lb	t3,179(s4)
 8ac:	0b390b3b          	0xb390b3b
 8b0:	1349                	addi	t1,t1,-14
 8b2:	1802                	slli	a6,a6,0x20
 8b4:	0000                	unimp
 8b6:	050c                	addi	a1,sp,640
 8b8:	0300                	addi	s0,sp,384
 8ba:	3a08                	fld	fa0,48(a2)
 8bc:	390b3b0b          	0x390b3b0b
 8c0:	0213490b          	0x213490b
 8c4:	0018                	0x18
 8c6:	0d00                	addi	s0,sp,656
 8c8:	0034                	addi	a3,sp,8
 8ca:	0b3a0803          	lb	a6,179(s4)
 8ce:	0b390b3b          	0xb390b3b
 8d2:	1349                	addi	t1,t1,-14
 8d4:	1802                	slli	a6,a6,0x20
 8d6:	0000                	unimp
 8d8:	340e                	fld	fs0,224(sp)
 8da:	0300                	addi	s0,sp,384
 8dc:	3a0e                	fld	fs4,224(sp)
 8de:	390b3b0b          	0x390b3b0b
 8e2:	0213490b          	0x213490b
 8e6:	0018                	0x18
 8e8:	0f00                	addi	s0,sp,912
 8ea:	0111010b          	0x111010b
 8ee:	0712                	slli	a4,a4,0x4
 8f0:	0000                	unimp
 8f2:	2e10                	fld	fa2,24(a2)
 8f4:	3f01                	addiw	t5,t5,-32
 8f6:	0319                	addi	t1,t1,6
 8f8:	3a0e                	fld	fs4,224(sp)
 8fa:	390b3b0b          	0x390b3b0b
 8fe:	1119270b          	0x1119270b
 902:	1201                	addi	tp,tp,-32
 904:	97184007          	flq	ft0,-1679(a6)
 908:	1942                	slli	s2,s2,0x30
 90a:	1301                	addi	t1,t1,-32
 90c:	0000                	unimp
 90e:	0f11                	addi	t5,t5,4
 910:	0b00                	addi	s0,sp,400
 912:	0013490b          	0x13490b
 916:	1200                	addi	s0,sp,288
 918:	012e                	slli	sp,sp,0xb
 91a:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 922:	0b39                	addi	s6,s6,14
 924:	13491927          	0x13491927
 928:	0111                	addi	sp,sp,4
 92a:	0712                	slli	a4,a4,0x4
 92c:	1840                	addi	s0,sp,52
 92e:	01194297          	auipc	t0,0x1194
 932:	00000013          	nop
 936:	1101                	addi	sp,sp,-32
 938:	2501                	sext.w	a0,a0
 93a:	130e                	slli	t1,t1,0x23
 93c:	1b0e030b          	0x1b0e030b
 940:	110e                	slli	sp,sp,0x23
 942:	1201                	addi	tp,tp,-32
 944:	00171007          	0x171007
 948:	0200                	addi	s0,sp,256
 94a:	0024                	addi	s1,sp,8
 94c:	0b3e0b0b          	0xb3e0b0b
 950:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
 954:	0b002403          	lw	s0,176(zero) # b0 <n+0x90>
 958:	030b3e0b          	0x30b3e0b
 95c:	0008                	0x8
 95e:	0400                	addi	s0,sp,512
 960:	0016                	c.slli	zero,0x5
 962:	0b3a0e03          	lb	t3,179(s4)
 966:	0b390b3b          	0xb390b3b
 96a:	1349                	addi	t1,t1,-14
 96c:	0000                	unimp
 96e:	1305                	addi	t1,t1,-31
 970:	0301                	addi	t1,t1,0
 972:	0b0e                	slli	s6,s6,0x3
 974:	3a05                	addiw	s4,s4,-31
 976:	390b3b0b          	0x390b3b0b
 97a:	0013010b          	0x13010b
 97e:	0600                	addi	s0,sp,768
 980:	000d                	c.nop	3
 982:	0b3a0803          	lb	a6,179(s4)
 986:	0b390b3b          	0xb390b3b
 98a:	1349                	addi	t1,t1,-14
 98c:	0b38                	addi	a4,sp,408
 98e:	0000                	unimp
 990:	03000d07          	0x3000d07
 994:	3a0e                	fld	fs4,224(sp)
 996:	390b3b0b          	0x390b3b0b
 99a:	3813490b          	0x3813490b
 99e:	0005                	c.nop	1
 9a0:	0800                	addi	s0,sp,16
 9a2:	0101                	addi	sp,sp,0
 9a4:	1349                	addi	t1,t1,-14
 9a6:	1301                	addi	t1,t1,-32
 9a8:	0000                	unimp
 9aa:	2109                	addiw	sp,sp,2
 9ac:	4900                	lw	s0,16(a0)
 9ae:	000b2f13          	slti	t5,s6,0
 9b2:	0a00                	addi	s0,sp,272
 9b4:	0034                	addi	a3,sp,8
 9b6:	0b3a0e03          	lb	t3,179(s4)
 9ba:	0b390b3b          	0xb390b3b
 9be:	1349                	addi	t1,t1,-14
 9c0:	1802                	slli	a6,a6,0x20
 9c2:	0000                	unimp
 9c4:	4900210b          	0x4900210b
 9c8:	00052f13          	slti	t5,a0,0
 9cc:	0c00                	addi	s0,sp,528
 9ce:	0034                	addi	a3,sp,8
 9d0:	0b3a0e03          	lb	t3,179(s4)
 9d4:	0b390b3b          	0xb390b3b
 9d8:	1349                	addi	t1,t1,-14
 9da:	193c193f 2e0d0000 	0x2e0d0000193c193f
 9e2:	3f01                	addiw	t5,t5,-32
 9e4:	0319                	addi	t1,t1,6
 9e6:	3a0e                	fld	fs4,224(sp)
 9e8:	390b3b0b          	0x390b3b0b
 9ec:	4919270b          	0x4919270b
 9f0:	12011113          	0x12011113
 9f4:	96184007          	flq	ft0,-1695(a6)
 9f8:	1942                	slli	s2,s2,0x30
 9fa:	1301                	addi	t1,t1,-32
 9fc:	0000                	unimp
 9fe:	050e                	slli	a0,a0,0x3
 a00:	0300                	addi	s0,sp,384
 a02:	3a08                	fld	fa0,48(a2)
 a04:	390b3b0b          	0x390b3b0b
 a08:	0213490b          	0x213490b
 a0c:	0018                	0x18
 a0e:	0f00                	addi	s0,sp,912
 a10:	0111010b          	0x111010b
 a14:	0712                	slli	a4,a4,0x4
 a16:	1301                	addi	t1,t1,-32
 a18:	0000                	unimp
 a1a:	0b10                	addi	a2,sp,400
 a1c:	1101                	addi	sp,sp,-32
 a1e:	1201                	addi	tp,tp,-32
 a20:	11000007          	0x11000007
 a24:	0034                	addi	a3,sp,8
 a26:	0b3a0803          	lb	a6,179(s4)
 a2a:	0b390b3b          	0xb390b3b
 a2e:	1349                	addi	t1,t1,-14
 a30:	1802                	slli	a6,a6,0x20
 a32:	0000                	unimp
 a34:	0f12                	slli	t5,t5,0x4
 a36:	0b00                	addi	s0,sp,400
 a38:	0013490b          	0x13490b
 a3c:	1300                	addi	s0,sp,416
 a3e:	012e                	slli	sp,sp,0xb
 a40:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 a48:	0b39                	addi	s6,s6,14
 a4a:	0111                	addi	sp,sp,4
 a4c:	0712                	slli	a4,a4,0x4
 a4e:	1840                	addi	s0,sp,52
 a50:	4296                	lw	t0,68(sp)
 a52:	0119                	addi	sp,sp,6
 a54:	14000013          	li	zero,320
 a58:	012e                	slli	sp,sp,0xb
 a5a:	0e03193f 0b3b0b3a 	0xb3b0b3a0e03193f
 a62:	0b39                	addi	s6,s6,14
 a64:	0111                	addi	sp,sp,4
 a66:	0712                	slli	a4,a4,0x4
 a68:	1840                	addi	s0,sp,52
 a6a:	4296                	lw	t0,68(sp)
 a6c:	0019                	c.nop	6
 a6e:	0000                	unimp
 a70:	1101                	addi	sp,sp,-32
 a72:	2501                	sext.w	a0,a0
 a74:	130e                	slli	t1,t1,0x23
 a76:	1b0e030b          	0x1b0e030b
 a7a:	110e                	slli	sp,sp,0x23
 a7c:	1201                	addi	tp,tp,-32
 a7e:	00171007          	0x171007
 a82:	0200                	addi	s0,sp,256
 a84:	0024                	addi	s1,sp,8
 a86:	0b3e0b0b          	0xb3e0b0b
 a8a:	00000e03          	lb	t3,0(zero) # 0 <n-0xc>
 a8e:	03001603          	lh	a2,48(zero) # 30 <n+0x10>
 a92:	3a0e                	fld	fs4,224(sp)
 a94:	390b3b0b          	0x390b3b0b
 a98:	0013490b          	0x13490b
 a9c:	0400                	addi	s0,sp,512
 a9e:	0024                	addi	s1,sp,8
 aa0:	0b3e0b0b          	0xb3e0b0b
 aa4:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 aa8:	2e05                	addiw	t3,t3,1
 aaa:	3f01                	addiw	t5,t5,-32
 aac:	0319                	addi	t1,t1,6
 aae:	3a0e                	fld	fs4,224(sp)
 ab0:	390b3b0b          	0x390b3b0b
 ab4:	4919270b          	0x4919270b
 ab8:	12011113          	0x12011113
 abc:	96184007          	flq	ft0,-1695(a6)
 ac0:	1942                	slli	s2,s2,0x30
 ac2:	1301                	addi	t1,t1,-32
 ac4:	0000                	unimp
 ac6:	0506                	slli	a0,a0,0x1
 ac8:	0300                	addi	s0,sp,384
 aca:	3a0e                	fld	fs4,224(sp)
 acc:	390b3b0b          	0x390b3b0b
 ad0:	0213490b          	0x213490b
 ad4:	0018                	0x18
 ad6:	0700                	addi	s0,sp,896
 ad8:	0b0b000f          	0xb0b000f
 adc:	1349                	addi	t1,t1,-14
 ade:	0000                	unimp
 ae0:	2e08                	fld	fa0,24(a2)
 ae2:	3f00                	fld	fs0,56(a4)
 ae4:	0319                	addi	t1,t1,6
 ae6:	3a0e                	fld	fs4,224(sp)
 ae8:	390b3b0b          	0x390b3b0b
 aec:	1113490b          	0x1113490b
 af0:	1201                	addi	tp,tp,-32
 af2:	96184007          	flq	ft0,-1695(a6)
 af6:	1942                	slli	s2,s2,0x30
 af8:	0000                	unimp
 afa:	2e09                	addiw	t3,t3,2
 afc:	3f01                	addiw	t5,t5,-32
 afe:	0319                	addi	t1,t1,6
 b00:	3a0e                	fld	fs4,224(sp)
 b02:	390b3b0b          	0x390b3b0b
 b06:	1119270b          	0x1119270b
 b0a:	1201                	addi	tp,tp,-32
 b0c:	96184007          	flq	ft0,-1695(a6)
 b10:	1942                	slli	s2,s2,0x30
 b12:	1301                	addi	t1,t1,-32
 b14:	0000                	unimp
 b16:	050a                	slli	a0,a0,0x2
 b18:	0300                	addi	s0,sp,384
 b1a:	3a08                	fld	fa0,48(a2)
 b1c:	390b3b0b          	0x390b3b0b
 b20:	0213490b          	0x213490b
 b24:	0018                	0x18
 b26:	0b00                	addi	s0,sp,400
 b28:	0026                	c.slli	zero,0x9
 b2a:	0000                	unimp
 b2c:	2e0c                	fld	fa1,24(a2)
 b2e:	3f01                	addiw	t5,t5,-32
 b30:	0319                	addi	t1,t1,6
 b32:	3a0e                	fld	fs4,224(sp)
 b34:	390b3b0b          	0x390b3b0b
 b38:	4919270b          	0x4919270b
 b3c:	12011113          	0x12011113
 b40:	96184007          	flq	ft0,-1695(a6)
 b44:	1942                	slli	s2,s2,0x30
 b46:	0000                	unimp
 b48:	0100                	addi	s0,sp,128
 b4a:	0111                	addi	sp,sp,4
 b4c:	0e25                	addi	t3,t3,9
 b4e:	0e030b13          	addi	s6,t1,224
 b52:	01110e1b          	addiw	t3,sp,17
 b56:	0712                	slli	a4,a4,0x4
 b58:	1710                	addi	a2,sp,928
 b5a:	0000                	unimp
 b5c:	2402                	fld	fs0,0(sp)
 b5e:	0b00                	addi	s0,sp,400
 b60:	030b3e0b          	0x30b3e0b
 b64:	000e                	c.slli	zero,0x3
 b66:	0300                	addi	s0,sp,384
 b68:	0024                	addi	s1,sp,8
 b6a:	0b3e0b0b          	0xb3e0b0b
 b6e:	00000803          	lb	a6,0(zero) # 0 <n-0xc>
 b72:	1604                	addi	s1,sp,800
 b74:	0300                	addi	s0,sp,384
 b76:	3a0e                	fld	fs4,224(sp)
 b78:	390b3b0b          	0x390b3b0b
 b7c:	0013490b          	0x13490b
 b80:	0500                	addi	s0,sp,640
 b82:	0034                	addi	a3,sp,8
 b84:	0b3a0e03          	lb	t3,179(s4)
 b88:	0b390b3b          	0xb390b3b
 b8c:	1349                	addi	t1,t1,-14
 b8e:	1802                	slli	a6,a6,0x20
 b90:	0000                	unimp
 b92:	2e06                	fld	ft8,64(sp)
 b94:	3f00                	fld	fs0,56(a4)
 b96:	0319                	addi	t1,t1,6
 b98:	3a0e                	fld	fs4,224(sp)
 b9a:	390b3b0b          	0x390b3b0b
 b9e:	1201110b          	0x1201110b
 ba2:	96184007          	flq	ft0,-1695(a6)
 ba6:	1942                	slli	s2,s2,0x30
 ba8:	0000                	unimp
 baa:	03012e07          	flw	ft8,48(sp)
 bae:	3a0e                	fld	fs4,224(sp)
 bb0:	390b3b0b          	0x390b3b0b
 bb4:	4919270b          	0x4919270b
 bb8:	12011113          	0x12011113
 bbc:	97184007          	flq	ft0,-1679(a6)
 bc0:	1942                	slli	s2,s2,0x30
 bc2:	0000                	unimp
 bc4:	0100                	addi	s0,sp,128
 bc6:	0011                	c.nop	4
 bc8:	0610                	addi	a2,sp,768
 bca:	0111                	addi	sp,sp,4
 bcc:	0112                	slli	sp,sp,0x4
 bce:	0e1b0e03          	lb	t3,225(s6) # 110105f9 <n+0x110105d9>
 bd2:	0e25                	addi	t3,t3,9
 bd4:	00000513          	li	a0,0
 bd8:	0100                	addi	s0,sp,128
 bda:	0011                	c.nop	4
 bdc:	0610                	addi	a2,sp,768
 bde:	0111                	addi	sp,sp,4
 be0:	0112                	slli	sp,sp,0x4
 be2:	0e1b0e03          	lb	t3,225(s6)
 be6:	0e25                	addi	t3,t3,9
 be8:	00000513          	li	a0,0
 bec:	0100                	addi	s0,sp,128
 bee:	0011                	c.nop	4
 bf0:	0610                	addi	a2,sp,768
 bf2:	0111                	addi	sp,sp,4
 bf4:	0112                	slli	sp,sp,0x4
 bf6:	0e1b0e03          	lb	t3,225(s6)
 bfa:	0e25                	addi	t3,t3,9
 bfc:	00000513          	li	a0,0
	...

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	002c                	addi	a1,sp,8
   2:	0000                	unimp
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0008                	0x8
   c:	0000                	unimp
   e:	0000                	unimp
  10:	000c                	0xc
  12:	8020                	0x8020
  14:	0000                	unimp
  16:	0000                	unimp
  18:	0030                	addi	a2,sp,8
	...
  2e:	0000                	unimp
  30:	002c                	addi	a1,sp,8
  32:	0000                	unimp
  34:	0002                	c.slli64	zero
  36:	00a6                	slli	ra,ra,0x9
  38:	0000                	unimp
  3a:	0008                	0x8
  3c:	0000                	unimp
  3e:	0000                	unimp
  40:	003c                	addi	a5,sp,8
  42:	8020                	0x8020
  44:	0000                	unimp
  46:	0000                	unimp
  48:	00c2                	slli	ra,ra,0x10
	...
  5e:	0000                	unimp
  60:	002c                	addi	a1,sp,8
  62:	0000                	unimp
  64:	0002                	c.slli64	zero
  66:	0242                	slli	tp,tp,0x10
  68:	0000                	unimp
  6a:	0008                	0x8
  6c:	0000                	unimp
  6e:	0000                	unimp
  70:	00fe                	slli	ra,ra,0x1f
  72:	8020                	0x8020
  74:	0000                	unimp
  76:	0000                	unimp
  78:	044e                	slli	s0,s0,0x13
	...
  8e:	0000                	unimp
  90:	002c                	addi	a1,sp,8
  92:	0000                	unimp
  94:	0002                	c.slli64	zero
  96:	06a5                	addi	a3,a3,9
  98:	0000                	unimp
  9a:	0008                	0x8
  9c:	0000                	unimp
  9e:	0000                	unimp
  a0:	054c                	addi	a1,sp,644
  a2:	8020                	0x8020
  a4:	0000                	unimp
  a6:	0000                	unimp
  a8:	02c4                	addi	s1,sp,324
	...
  be:	0000                	unimp
  c0:	002c                	addi	a1,sp,8
  c2:	0000                	unimp
  c4:	0002                	c.slli64	zero
  c6:	0958                	addi	a4,sp,148
  c8:	0000                	unimp
  ca:	0008                	0x8
  cc:	0000                	unimp
  ce:	0000                	unimp
  d0:	0810                	addi	a2,sp,16
  d2:	8020                	0x8020
  d4:	0000                	unimp
  d6:	0000                	unimp
  d8:	004e                	c.slli	zero,0x13
	...
  ee:	0000                	unimp
  f0:	002c                	addi	a1,sp,8
  f2:	0000                	unimp
  f4:	0002                	c.slli64	zero
  f6:	0a0d                	addi	s4,s4,3
  f8:	0000                	unimp
  fa:	0008                	0x8
  fc:	0000                	unimp
  fe:	0000                	unimp
 100:	085e                	slli	a6,a6,0x17
 102:	8020                	0x8020
 104:	0000                	unimp
 106:	0000                	unimp
 108:	02e6                	slli	t0,t0,0x19
	...
 11e:	0000                	unimp
 120:	002c                	addi	a1,sp,8
 122:	0000                	unimp
 124:	0002                	c.slli64	zero
 126:	0cf0                	addi	a2,sp,604
 128:	0000                	unimp
 12a:	0008                	0x8
 12c:	0000                	unimp
 12e:	0000                	unimp
 130:	0b44                	addi	s1,sp,404
 132:	8020                	0x8020
 134:	0000                	unimp
 136:	0000                	unimp
 138:	0522                	slli	a0,a0,0x8
	...
 14e:	0000                	unimp
 150:	002c                	addi	a1,sp,8
 152:	0000                	unimp
 154:	0002                	c.slli64	zero
 156:	10b1                	addi	ra,ra,-20
 158:	0000                	unimp
 15a:	0008                	0x8
 15c:	0000                	unimp
 15e:	0000                	unimp
 160:	1066                	c.slli	zero,0x39
 162:	8020                	0x8020
 164:	0000                	unimp
 166:	0000                	unimp
 168:	01aa                	slli	gp,gp,0xa
	...
 17e:	0000                	unimp
 180:	002c                	addi	a1,sp,8
 182:	0000                	unimp
 184:	0002                	c.slli64	zero
 186:	1420                	addi	s0,sp,552
 188:	0000                	unimp
 18a:	0008                	0x8
 18c:	0000                	unimp
 18e:	0000                	unimp
 190:	1210                	addi	a2,sp,288
 192:	8020                	0x8020
 194:	0000                	unimp
 196:	0000                	unimp
 198:	0102                	c.slli64	sp
	...
 1ae:	0000                	unimp
 1b0:	002c                	addi	a1,sp,8
 1b2:	0000                	unimp
 1b4:	0002                	c.slli64	zero
 1b6:	1622                	slli	a2,a2,0x28
 1b8:	0000                	unimp
 1ba:	0008                	0x8
 1bc:	0000                	unimp
 1be:	0000                	unimp
 1c0:	1312                	slli	t1,t1,0x24
 1c2:	8020                	0x8020
 1c4:	0000                	unimp
 1c6:	0000                	unimp
 1c8:	030a                	slli	t1,t1,0x2
	...
 1de:	0000                	unimp
 1e0:	002c                	addi	a1,sp,8
 1e2:	0000                	unimp
 1e4:	0002                	c.slli64	zero
 1e6:	18b2                	slli	a7,a7,0x2c
 1e8:	0000                	unimp
 1ea:	0008                	0x8
 1ec:	0000                	unimp
 1ee:	0000                	unimp
 1f0:	161c                	addi	a5,sp,800
 1f2:	8020                	0x8020
 1f4:	0000                	unimp
 1f6:	0000                	unimp
 1f8:	01d8                	addi	a4,sp,196
	...
 20e:	0000                	unimp
 210:	002c                	addi	a1,sp,8
 212:	0000                	unimp
 214:	0002                	c.slli64	zero
 216:	1acc                	addi	a1,sp,372
 218:	0000                	unimp
 21a:	0008                	0x8
 21c:	0000                	unimp
 21e:	0000                	unimp
 220:	17f4                	addi	a3,sp,1004
 222:	8020                	0x8020
 224:	0000                	unimp
 226:	0000                	unimp
 228:	0090                	addi	a2,sp,64
	...
 23e:	0000                	unimp
 240:	002c                	addi	a1,sp,8
 242:	0000                	unimp
 244:	0002                	c.slli64	zero
 246:	1bd0                	addi	a2,sp,500
 248:	0000                	unimp
 24a:	0008                	0x8
 24c:	0000                	unimp
 24e:	0000                	unimp
 250:	0000                	unimp
 252:	8020                	0x8020
 254:	0000                	unimp
 256:	0000                	unimp
 258:	000c                	0xc
	...
 26e:	0000                	unimp
 270:	002c                	addi	a1,sp,8
 272:	0000                	unimp
 274:	0002                	c.slli64	zero
 276:	1bfe                	slli	s7,s7,0x3f
 278:	0000                	unimp
 27a:	0008                	0x8
 27c:	0000                	unimp
 27e:	0000                	unimp
 280:	1884                	addi	s1,sp,112
 282:	8020                	0x8020
 284:	0000                	unimp
 286:	0000                	unimp
 288:	00b0                	addi	a2,sp,72
	...
 29e:	0000                	unimp
 2a0:	002c                	addi	a1,sp,8
 2a2:	0000                	unimp
 2a4:	0002                	c.slli64	zero
 2a6:	1c2c                	addi	a1,sp,568
 2a8:	0000                	unimp
 2aa:	0008                	0x8
 2ac:	0000                	unimp
 2ae:	0000                	unimp
 2b0:	193a                	slli	s2,s2,0x2e
 2b2:	8020                	0x8020
 2b4:	0000                	unimp
 2b6:	0000                	unimp
 2b8:	006a                	c.slli	zero,0x1a
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
       0:	000000af          	0xaf
       4:	005b0003          	lb	zero,5(s6)
       8:	0000                	unimp
       a:	0101                	addi	sp,sp,0
       c:	000d0efb          	0xd0efb
      10:	0101                	addi	sp,sp,0
      12:	0101                	addi	sp,sp,0
      14:	0000                	unimp
      16:	0100                	addi	s0,sp,128
      18:	0000                	unimp
      1a:	6b01                	0x6b01
      1c:	7265                	lui	tp,0xffff9
      1e:	656e                	ld	a0,216(sp)
      20:	006c                	addi	a1,sp,12
      22:	6e72656b          	0x6e72656b
      26:	6c65                	lui	s8,0x19
      28:	6f6c672f          	0x6f6c672f
      2c:	6c62                	ld	s8,24(sp)
      2e:	0065                	c.nop	25
      30:	6e72656b          	0x6e72656b
      34:	6c65                	lui	s8,0x19
      36:	6172742f          	0x6172742f
      3a:	2f70                	fld	fa2,216(a4)
      3c:	6974                	ld	a3,208(a0)
      3e:	656d                	lui	a0,0x1b
      40:	0072                	c.slli	zero,0x1c
      42:	6d00                	ld	s0,24(a0)
      44:	6961                	lui	s2,0x18
      46:	2e6e                	fld	ft8,216(sp)
      48:	00010063          	beqz	sp,48 <n+0x28>
      4c:	7300                	ld	s0,32(a4)
      4e:	6474                	ld	a3,200(s0)
      50:	6e69                	lui	t3,0x1a
      52:	2e74                	fld	fa3,216(a2)
      54:	0068                	addi	a0,sp,12
      56:	0002                	c.slli64	zero
      58:	7400                	ld	s0,40(s0)
      5a:	6d69                	lui	s10,0x1a
      5c:	7265                	lui	tp,0xffff9
      5e:	682e                	ld	a6,200(sp)
      60:	0300                	addi	s0,sp,384
      62:	0000                	unimp
      64:	0500                	addi	s0,sp,640
      66:	0001                	nop
      68:	0209                	addi	tp,tp,2
      6a:	000c                	0xc
      6c:	8020                	0x8020
      6e:	0000                	unimp
      70:	0000                	unimp
      72:	05010a03          	lb	s4,80(sp)
      76:	0305                	addi	t1,t1,1
      78:	0901                	addi	s2,s2,0
      7a:	0008                	0x8
      7c:	0301                	addi	t1,t1,0
      7e:	0901                	addi	s2,s2,0
      80:	0008                	0x8
      82:	0301                	addi	t1,t1,0
      84:	0901                	addi	s2,s2,0
      86:	000c                	0xc
      88:	0301                	addi	t1,t1,0
      8a:	0901                	addi	s2,s2,0
      8c:	0004                	0x4
      8e:	0301                	addi	t1,t1,0
      90:	0905                	addi	s2,s2,1
      92:	0004                	0x4
      94:	0301                	addi	t1,t1,0
      96:	0902                	c.slli64	s2
      98:	0004                	0x4
      9a:	0301                	addi	t1,t1,0
      9c:	0901                	addi	s2,s2,0
      9e:	0004                	0x4
      a0:	0501                	addi	a0,a0,0
      a2:	000a                	c.slli	zero,0x2
      a4:	0402                	c.slli64	s0
      a6:	0301                	addi	t1,t1,0
      a8:	0904                	addi	s1,sp,144
      aa:	0002                	c.slli64	zero
      ac:	0901                	addi	s2,s2,0
      ae:	0002                	c.slli64	zero
      b0:	0100                	addi	s0,sp,128
      b2:	ed01                	bnez	a0,ca <n+0xaa>
      b4:	0000                	unimp
      b6:	0300                	addi	s0,sp,384
      b8:	4100                	lw	s0,0(a0)
      ba:	0000                	unimp
      bc:	0100                	addi	s0,sp,128
      be:	fb01                	bnez	a4,ffffffffffffffce <ebss+0xffffffff7fda5086>
      c0:	0d0e                	slli	s10,s10,0x3
      c2:	0100                	addi	s0,sp,128
      c4:	0101                	addi	sp,sp,0
      c6:	0001                	nop
      c8:	0000                	unimp
      ca:	0001                	nop
      cc:	0100                	addi	s0,sp,128
      ce:	6e72656b          	0x6e72656b
      d2:	6c65                	lui	s8,0x19
      d4:	6962732f          	0x6962732f
      d8:	6b00                	ld	s0,16(a4)
      da:	7265                	lui	tp,0xffff9
      dc:	656e                	ld	a0,216(sp)
      de:	2f6c                	fld	fa1,216(a4)
      e0:	626f6c67          	0x626f6c67
      e4:	656c                	ld	a1,200(a0)
      e6:	0000                	unimp
      e8:	2e696273          	csrrsi	tp,0x2e6,18
      ec:	00010063          	beqz	sp,ec <n+0xcc>
      f0:	7300                	ld	s0,32(a4)
      f2:	6474                	ld	a3,200(s0)
      f4:	6e69                	lui	t3,0x1a
      f6:	2e74                	fld	fa3,216(a2)
      f8:	0068                	addi	a0,sp,12
      fa:	0002                	c.slli64	zero
      fc:	0000                	unimp
      fe:	4e05                	li	t3,1
     100:	0900                	addi	s0,sp,144
     102:	3c02                	fld	fs8,32(sp)
     104:	2000                	fld	fs0,0(s0)
     106:	0080                	addi	s0,sp,64
     108:	0000                	unimp
     10a:	0300                	addi	s0,sp,384
     10c:	1305010f          	0x1305010f
     110:	16090103          	lb	sp,352(s2) # 18160 <n+0x18140>
     114:	0100                	addi	s0,sp,128
     116:	04090103          	lb	sp,64(s2)
     11a:	0100                	addi	s0,sp,128
     11c:	04090103          	lb	sp,64(s2)
     120:	0100                	addi	s0,sp,128
     122:	04090103          	lb	sp,64(s2)
     126:	0100                	addi	s0,sp,128
     128:	0505                	addi	a0,a0,1
     12a:	04090203          	lb	tp,64(s2)
     12e:	0100                	addi	s0,sp,128
     130:	0c05                	addi	s8,s8,1
     132:	04090503          	lb	a0,64(s2)
     136:	0100                	addi	s0,sp,128
     138:	0105                	addi	sp,sp,1
     13a:	02090103          	lb	sp,32(s2)
     13e:	0100                	addi	s0,sp,128
     140:	2305                	addiw	t1,t1,1
     142:	08090203          	lb	tp,128(s2)
     146:	0100                	addi	s0,sp,128
     148:	0505                	addi	a0,a0,1
     14a:	0c090103          	lb	sp,192(s2)
     14e:	0100                	addi	s0,sp,128
     150:	0105                	addi	sp,sp,1
     152:	10090103          	lb	sp,256(s2)
     156:	0100                	addi	s0,sp,128
     158:	2005                	0x2005
     15a:	0a090203          	lb	tp,160(s2)
     15e:	0100                	addi	s0,sp,128
     160:	0c05                	addi	s8,s8,1
     162:	08090103          	lb	sp,128(s2)
     166:	0100                	addi	s0,sp,128
     168:	0105                	addi	sp,sp,1
     16a:	0e090103          	lb	sp,224(s2)
     16e:	0100                	addi	s0,sp,128
     170:	1d05                	addi	s10,s10,-31
     172:	0a090203          	lb	tp,160(s2)
     176:	0100                	addi	s0,sp,128
     178:	0c05                	addi	s8,s8,1
     17a:	08090103          	lb	sp,128(s2)
     17e:	0100                	addi	s0,sp,128
     180:	0105                	addi	sp,sp,1
     182:	0e090103          	lb	sp,224(s2)
     186:	0100                	addi	s0,sp,128
     188:	0a090303          	lb	t1,160(s2)
     18c:	0100                	addi	s0,sp,128
     18e:	0c05                	addi	s8,s8,1
     190:	0c090103          	lb	sp,192(s2)
     194:	0100                	addi	s0,sp,128
     196:	0105                	addi	sp,sp,1
     198:	12090103          	lb	sp,288(s2)
     19c:	0100                	addi	s0,sp,128
     19e:	0a09                	addi	s4,s4,2
     1a0:	0000                	unimp
     1a2:	0101                	addi	sp,sp,0
     1a4:	0471                	addi	s0,s0,28
     1a6:	0000                	unimp
     1a8:	00530003          	lb	zero,5(t1)
     1ac:	0000                	unimp
     1ae:	0101                	addi	sp,sp,0
     1b0:	000d0efb          	0xd0efb
     1b4:	0101                	addi	sp,sp,0
     1b6:	0101                	addi	sp,sp,0
     1b8:	0000                	unimp
     1ba:	0100                	addi	s0,sp,128
     1bc:	0000                	unimp
     1be:	6b01                	0x6b01
     1c0:	7265                	lui	tp,0xffff9
     1c2:	656e                	ld	a0,216(sp)
     1c4:	2f6c                	fld	fa1,216(a4)
     1c6:	69727473          	csrrci	s0,0x697,4
     1ca:	676e                	ld	a4,216(sp)
     1cc:	6b00                	ld	s0,16(a4)
     1ce:	7265                	lui	tp,0xffff9
     1d0:	656e                	ld	a0,216(sp)
     1d2:	2f6c                	fld	fa1,216(a4)
     1d4:	626f6c67          	0x626f6c67
     1d8:	656c                	ld	a1,200(a0)
     1da:	0000                	unimp
     1dc:	69727473          	csrrci	s0,0x697,4
     1e0:	676e                	ld	a4,216(sp)
     1e2:	632e                	ld	t1,200(sp)
     1e4:	0100                	addi	s0,sp,128
     1e6:	0000                	unimp
     1e8:	69647473          	csrrci	s0,0x696,8
     1ec:	746e                	ld	s0,248(sp)
     1ee:	682e                	ld	a6,200(sp)
     1f0:	0200                	addi	s0,sp,256
     1f2:	0000                	unimp
     1f4:	69727473          	csrrci	s0,0x697,4
     1f8:	676e                	ld	a4,216(sp)
     1fa:	682e                	ld	a6,200(sp)
     1fc:	0100                	addi	s0,sp,128
     1fe:	0000                	unimp
     200:	0500                	addi	s0,sp,640
     202:	0001                	nop
     204:	0209                	addi	tp,tp,2
     206:	00fe                	slli	ra,ra,0x1f
     208:	8020                	0x8020
     20a:	0000                	unimp
     20c:	0000                	unimp
     20e:	030c0517          	auipc	a0,0x30c0
     212:	0902                	c.slli64	s2
     214:	000a                	c.slli	zero,0x2
     216:	0501                	addi	a0,a0,0
     218:	0305                	addi	t1,t1,1
     21a:	0900                	addi	s0,sp,144
     21c:	0004                	0x4
     21e:	0501                	addi	a0,a0,0
     220:	0022                	c.slli	zero,0x8
     222:	0402                	c.slli64	s0
     224:	09000303          	lb	t1,144(zero) # 90 <n+0x70>
     228:	0002                	c.slli64	zero
     22a:	0501                	addi	a0,a0,0
     22c:	0014                	0x14
     22e:	0402                	c.slli64	s0
     230:	0301                	addi	t1,t1,0
     232:	0900                	addi	s0,sp,144
     234:	000a                	c.slli	zero,0x2
     236:	0501                	addi	a0,a0,0
     238:	0005                	c.nop	1
     23a:	0402                	c.slli64	s0
     23c:	0301                	addi	t1,t1,0
     23e:	0900                	addi	s0,sp,144
     240:	000e                	c.slli	zero,0x3
     242:	0501                	addi	a0,a0,0
     244:	030c                	addi	a1,sp,384
     246:	0902                	c.slli64	s2
     248:	0002                	c.slli64	zero
     24a:	0501                	addi	a0,a0,0
     24c:	0301                	addi	t1,t1,0
     24e:	0901                	addi	s2,s2,0
     250:	0004                	0x4
     252:	0301                	addi	t1,t1,0
     254:	00080903          	lb	s2,0(a6)
     258:	0501                	addi	a0,a0,0
     25a:	0305                	addi	t1,t1,1
     25c:	0901                	addi	s2,s2,0
     25e:	0014                	0x14
     260:	0501                	addi	a0,a0,0
     262:	04020017          	auipc	zero,0x4020
     266:	0302                	c.slli64	t1
     268:	0901                	addi	s2,s2,0
     26a:	0002                	c.slli64	zero
     26c:	0501                	addi	a0,a0,0
     26e:	000e                	c.slli	zero,0x3
     270:	0402                	c.slli64	s0
     272:	0302                	c.slli64	t1
     274:	0900                	addi	s0,sp,144
     276:	000c                	0xc
     278:	0501                	addi	a0,a0,0
     27a:	04020013          	addi	zero,tp,64 # ffffffffffff9040 <ebss+0xffffffff7fd9e0f8>
     27e:	0302                	c.slli64	t1
     280:	0900                	addi	s0,sp,144
     282:	000c                	0xc
     284:	0501                	addi	a0,a0,0
     286:	0011                	c.nop	4
     288:	0402                	c.slli64	s0
     28a:	0302                	c.slli64	t1
     28c:	0900                	addi	s0,sp,144
     28e:	0004                	0x4
     290:	0501                	addi	a0,a0,0
     292:	0019                	c.nop	6
     294:	0402                	c.slli64	s0
     296:	0302                	c.slli64	t1
     298:	097f                	0x97f
     29a:	0004                	0x4
     29c:	0501                	addi	a0,a0,0
     29e:	0005                	c.nop	1
     2a0:	0402                	c.slli64	s0
     2a2:	0301                	addi	t1,t1,0
     2a4:	0900                	addi	s0,sp,144
     2a6:	000a                	c.slli	zero,0x2
     2a8:	0501                	addi	a0,a0,0
     2aa:	0301                	addi	t1,t1,0
     2ac:	00080903          	lb	s2,0(a6)
     2b0:	0301                	addi	t1,t1,0
     2b2:	000a0903          	lb	s2,0(s4)
     2b6:	0501                	addi	a0,a0,0
     2b8:	030e                	slli	t1,t1,0x3
     2ba:	0901                	addi	s2,s2,0
     2bc:	0014                	0x14
     2be:	0501                	addi	a0,a0,0
     2c0:	0305                	addi	t1,t1,1
     2c2:	0900                	addi	s0,sp,144
     2c4:	0004                	0x4
     2c6:	0501                	addi	a0,a0,0
     2c8:	031a                	slli	t1,t1,0x6
     2ca:	0901                	addi	s2,s2,0
     2cc:	0002                	c.slli64	zero
     2ce:	0501                	addi	a0,a0,0
     2d0:	032e                	slli	t1,t1,0xb
     2d2:	0900                	addi	s0,sp,144
     2d4:	000e                	c.slli	zero,0x3
     2d6:	0501                	addi	a0,a0,0
     2d8:	030c                	addi	a1,sp,384
     2da:	0900                	addi	s0,sp,144
     2dc:	000e                	c.slli	zero,0x3
     2de:	0501                	addi	a0,a0,0
     2e0:	0321                	addi	t1,t1,8
     2e2:	0901                	addi	s2,s2,0
     2e4:	0006                	c.slli	zero,0x1
     2e6:	0501                	addi	a0,a0,0
     2e8:	0334                	addi	a3,sp,392
     2ea:	0900                	addi	s0,sp,144
     2ec:	0012                	c.slli	zero,0x4
     2ee:	0501                	addi	a0,a0,0
     2f0:	0325                	addi	t1,t1,9
     2f2:	0900                	addi	s0,sp,144
     2f4:	0010                	0x10
     2f6:	0501                	addi	a0,a0,0
     2f8:	001e                	c.slli	zero,0x7
     2fa:	0402                	c.slli64	s0
     2fc:	0302                	c.slli64	t1
     2fe:	097e                	slli	s2,s2,0x1f
     300:	0008                	0x8
     302:	0501                	addi	a0,a0,0
     304:	04020017          	auipc	zero,0x4020
     308:	0301                	addi	t1,t1,0
     30a:	0900                	addi	s0,sp,144
     30c:	000a                	c.slli	zero,0x2
     30e:	0501                	addi	a0,a0,0
     310:	0005                	c.nop	1
     312:	0402                	c.slli64	s0
     314:	0301                	addi	t1,t1,0
     316:	0900                	addi	s0,sp,144
     318:	0004                	0x4
     31a:	0501                	addi	a0,a0,0
     31c:	030c                	addi	a1,sp,384
     31e:	0905                	addi	s2,s2,1
     320:	000a                	c.slli	zero,0x2
     322:	0501                	addi	a0,a0,0
     324:	0301                	addi	t1,t1,0
     326:	0901                	addi	s2,s2,0
     328:	0002                	c.slli64	zero
     32a:	0301                	addi	t1,t1,0
     32c:	00080903          	lb	s2,0(a6)
     330:	0301                	addi	t1,t1,0
     332:	0900                	addi	s0,sp,144
     334:	0014                	0x14
     336:	0501                	addi	a0,a0,0
     338:	0305                	addi	t1,t1,1
     33a:	0901                	addi	s2,s2,0
     33c:	0004                	0x4
     33e:	0501                	addi	a0,a0,0
     340:	0308                	addi	a0,sp,384
     342:	0900                	addi	s0,sp,144
     344:	0004                	0x4
     346:	0501                	addi	a0,a0,0
     348:	030c                	addi	a1,sp,384
     34a:	0902                	c.slli64	s2
     34c:	0058                	addi	a4,sp,4
     34e:	0501                	addi	a0,a0,0
     350:	0305                	addi	t1,t1,1
     352:	0900                	addi	s0,sp,144
     354:	0004                	0x4
     356:	0501                	addi	a0,a0,0
     358:	04020017          	auipc	zero,0x4020
     35c:	09010303          	lb	t1,144(sp)
     360:	0002                	c.slli64	zero
     362:	0501                	addi	a0,a0,0
     364:	04020013          	addi	zero,tp,64 # 40 <n+0x20>
     368:	09000303          	lb	t1,144(zero) # 90 <n+0x70>
     36c:	000c                	0xc
     36e:	0501                	addi	a0,a0,0
     370:	0011                	c.nop	4
     372:	0402                	c.slli64	s0
     374:	09000303          	lb	t1,144(zero) # 90 <n+0x70>
     378:	0004                	0x4
     37a:	0501                	addi	a0,a0,0
     37c:	001e                	c.slli	zero,0x7
     37e:	0402                	c.slli64	s0
     380:	097f0303          	lb	t1,151(t5)
     384:	000e                	c.slli	zero,0x3
     386:	0501                	addi	a0,a0,0
     388:	0005                	c.nop	1
     38a:	0402                	c.slli64	s0
     38c:	0301                	addi	t1,t1,0
     38e:	0900                	addi	s0,sp,144
     390:	000a                	c.slli	zero,0x2
     392:	0301                	addi	t1,t1,0
     394:	00080903          	lb	s2,0(a6)
     398:	0501                	addi	a0,a0,0
     39a:	000e                	c.slli	zero,0x3
     39c:	0402                	c.slli64	s0
     39e:	0302                	c.slli64	t1
     3a0:	0901                	addi	s2,s2,0
     3a2:	0002                	c.slli64	zero
     3a4:	0501                	addi	a0,a0,0
     3a6:	04020017          	auipc	zero,0x4020
     3aa:	0302                	c.slli64	t1
     3ac:	0900                	addi	s0,sp,144
     3ae:	000c                	0xc
     3b0:	0501                	addi	a0,a0,0
     3b2:	0011                	c.nop	4
     3b4:	0402                	c.slli64	s0
     3b6:	0302                	c.slli64	t1
     3b8:	0900                	addi	s0,sp,144
     3ba:	000e                	c.slli	zero,0x3
     3bc:	0501                	addi	a0,a0,0
     3be:	0019                	c.nop	6
     3c0:	0402                	c.slli64	s0
     3c2:	0302                	c.slli64	t1
     3c4:	097f                	0x97f
     3c6:	0004                	0x4
     3c8:	0501                	addi	a0,a0,0
     3ca:	0005                	c.nop	1
     3cc:	0402                	c.slli64	s0
     3ce:	0301                	addi	t1,t1,0
     3d0:	0900                	addi	s0,sp,144
     3d2:	000a                	c.slli	zero,0x2
     3d4:	0501                	addi	a0,a0,0
     3d6:	0301                	addi	t1,t1,0
     3d8:	000a0903          	lb	s2,0(s4)
     3dc:	0301                	addi	t1,t1,0
     3de:	000c0903          	lb	s2,0(s8) # 19000 <n+0x18fe0>
     3e2:	0501                	addi	a0,a0,0
     3e4:	0309                	addi	t1,t1,2
     3e6:	0901                	addi	s2,s2,0
     3e8:	0018                	0x18
     3ea:	0501                	addi	a0,a0,0
     3ec:	0305                	addi	t1,t1,1
     3ee:	0902                	c.slli64	s2
     3f0:	0008                	0x8
     3f2:	0501                	addi	a0,a0,0
     3f4:	000d                	c.nop	3
     3f6:	0402                	c.slli64	s0
     3f8:	0302                	c.slli64	t1
     3fa:	0901                	addi	s2,s2,0
     3fc:	0002                	c.slli64	zero
     3fe:	0501                	addi	a0,a0,0
     400:	0010                	0x10
     402:	0402                	c.slli64	s0
     404:	0302                	c.slli64	t1
     406:	0900                	addi	s0,sp,144
     408:	000c                	0xc
     40a:	0501                	addi	a0,a0,0
     40c:	0019                	c.nop	6
     40e:	0402                	c.slli64	s0
     410:	0302                	c.slli64	t1
     412:	097f                	0x97f
     414:	0008                	0x8
     416:	0501                	addi	a0,a0,0
     418:	0005                	c.nop	1
     41a:	0402                	c.slli64	s0
     41c:	0301                	addi	t1,t1,0
     41e:	0900                	addi	s0,sp,144
     420:	000a                	c.slli	zero,0x2
     422:	0501                	addi	a0,a0,0
     424:	0301                	addi	t1,t1,0
     426:	00080903          	lb	s2,0(a6)
     42a:	0501                	addi	a0,a0,0
     42c:	09020323          	sb	a6,134(tp) # 86 <n+0x66>
     430:	000a                	c.slli	zero,0x2
     432:	0501                	addi	a0,a0,0
     434:	0325                	addi	t1,t1,9
     436:	0900                	addi	s0,sp,144
     438:	0012                	c.slli	zero,0x4
     43a:	0501                	addi	a0,a0,0
     43c:	033d                	addi	t1,t1,15
     43e:	0900                	addi	s0,sp,144
     440:	0010                	0x10
     442:	0501                	addi	a0,a0,0
     444:	0301                	addi	t1,t1,0
     446:	000a0903          	lb	s2,0(s4)
     44a:	0501                	addi	a0,a0,0
     44c:	0901030b          	0x901030b
     450:	000e                	c.slli	zero,0x3
     452:	0501                	addi	a0,a0,0
     454:	030d                	addi	t1,t1,3
     456:	0901                	addi	s2,s2,0
     458:	0002                	c.slli64	zero
     45a:	0501                	addi	a0,a0,0
     45c:	0316                	slli	t1,t1,0x5
     45e:	0900                	addi	s0,sp,144
     460:	0008                	0x8
     462:	0501                	addi	a0,a0,0
     464:	030c                	addi	a1,sp,384
     466:	0900                	addi	s0,sp,144
     468:	0008                	0x8
     46a:	0501                	addi	a0,a0,0
     46c:	0315                	addi	t1,t1,5
     46e:	0901                	addi	s2,s2,0
     470:	0004                	0x4
     472:	0501                	addi	a0,a0,0
     474:	031f 0900 000c      	0xc0900031f
     47a:	0501                	addi	a0,a0,0
     47c:	031c                	addi	a5,sp,384
     47e:	0900                	addi	s0,sp,144
     480:	000a                	c.slli	zero,0x2
     482:	0501                	addi	a0,a0,0
     484:	0309                	addi	t1,t1,2
     486:	0902                	c.slli64	s2
     488:	0008                	0x8
     48a:	0301                	addi	t1,t1,0
     48c:	0901                	addi	s2,s2,0
     48e:	000a                	c.slli	zero,0x2
     490:	0501                	addi	a0,a0,0
     492:	030c                	addi	a1,sp,384
     494:	000a097b          	0xa097b
     498:	0501                	addi	a0,a0,0
     49a:	0900030b          	0x900030b
     49e:	0008                	0x8
     4a0:	0501                	addi	a0,a0,0
     4a2:	0015                	c.nop	5
     4a4:	0402                	c.slli64	s0
     4a6:	0301                	addi	t1,t1,0
     4a8:	0900                	addi	s0,sp,144
     4aa:	0002                	c.slli64	zero
     4ac:	0501                	addi	a0,a0,0
     4ae:	0012                	c.slli	zero,0x4
     4b0:	0402                	c.slli64	s0
     4b2:	0301                	addi	t1,t1,0
     4b4:	0900                	addi	s0,sp,144
     4b6:	0008                	0x8
     4b8:	0501                	addi	a0,a0,0
     4ba:	030d                	addi	t1,t1,3
     4bc:	00020907          	0x20907
     4c0:	0501                	addi	a0,a0,0
     4c2:	09000317          	auipc	t1,0x9000
     4c6:	000c                	0xc
     4c8:	0501                	addi	a0,a0,0
     4ca:	0314                	addi	a3,sp,384
     4cc:	0900                	addi	s0,sp,144
     4ce:	000a                	c.slli	zero,0x2
     4d0:	0501                	addi	a0,a0,0
     4d2:	0301                	addi	t1,t1,0
     4d4:	0901                	addi	s2,s2,0
     4d6:	0006                	c.slli	zero,0x1
     4d8:	0301                	addi	t1,t1,0
     4da:	00080903          	lb	s2,0(a6)
     4de:	0501                	addi	a0,a0,0
     4e0:	0901030b          	0x901030b
     4e4:	000e                	c.slli	zero,0x3
     4e6:	0301                	addi	t1,t1,0
     4e8:	0902                	c.slli64	s2
     4ea:	0008                	0x8
     4ec:	0501                	addi	a0,a0,0
     4ee:	09010317          	auipc	t1,0x9010
     4f2:	0002                	c.slli64	zero
     4f4:	0501                	addi	a0,a0,0
     4f6:	030e                	slli	t1,t1,0x3
     4f8:	0900                	addi	s0,sp,144
     4fa:	000c                	0xc
     4fc:	0501                	addi	a0,a0,0
     4fe:	09000313          	li	t1,144
     502:	000c                	0xc
     504:	0501                	addi	a0,a0,0
     506:	0311                	addi	t1,t1,4
     508:	0900                	addi	s0,sp,144
     50a:	0004                	0x4
     50c:	0501                	addi	a0,a0,0
     50e:	030c                	addi	a1,sp,384
     510:	097f                	0x97f
     512:	0004                	0x4
     514:	0501                	addi	a0,a0,0
     516:	0900030b          	0x900030b
     51a:	0008                	0x8
     51c:	0301                	addi	t1,t1,0
     51e:	0904                	addi	s1,sp,144
     520:	0002                	c.slli64	zero
     522:	0501                	addi	a0,a0,0
     524:	030c                	addi	a1,sp,384
     526:	0902                	c.slli64	s2
     528:	0008                	0x8
     52a:	0501                	addi	a0,a0,0
     52c:	0301                	addi	t1,t1,0
     52e:	0901                	addi	s2,s2,0
     530:	0004                	0x4
     532:	0301                	addi	t1,t1,0
     534:	00080903          	lb	s2,0(a6)
     538:	0501                	addi	a0,a0,0
     53a:	0901030b          	0x901030b
     53e:	000e                	c.slli	zero,0x3
     540:	0301                	addi	t1,t1,0
     542:	0902                	c.slli64	s2
     544:	0008                	0x8
     546:	0501                	addi	a0,a0,0
     548:	0021                	c.nop	8
     54a:	0402                	c.slli64	s0
     54c:	0302                	c.slli64	t1
     54e:	0900                	addi	s0,sp,144
     550:	0002                	c.slli64	zero
     552:	0501                	addi	a0,a0,0
     554:	000c                	0xc
     556:	0402                	c.slli64	s0
     558:	0301                	addi	t1,t1,0
     55a:	0900                	addi	s0,sp,144
     55c:	000a                	c.slli	zero,0x2
     55e:	0501                	addi	a0,a0,0
     560:	0402000b          	0x402000b
     564:	0301                	addi	t1,t1,0
     566:	0900                	addi	s0,sp,144
     568:	0008                	0x8
     56a:	0301                	addi	t1,t1,0
     56c:	0901                	addi	s2,s2,0
     56e:	0002                	c.slli64	zero
     570:	0501                	addi	a0,a0,0
     572:	09010317          	auipc	t1,0x9010
     576:	0002                	c.slli64	zero
     578:	0501                	addi	a0,a0,0
     57a:	030e                	slli	t1,t1,0x3
     57c:	0900                	addi	s0,sp,144
     57e:	000c                	0xc
     580:	0501                	addi	a0,a0,0
     582:	09000313          	li	t1,144
     586:	000c                	0xc
     588:	0501                	addi	a0,a0,0
     58a:	0311                	addi	t1,t1,4
     58c:	0900                	addi	s0,sp,144
     58e:	0004                	0x4
     590:	0501                	addi	a0,a0,0
     592:	030c                	addi	a1,sp,384
     594:	097f                	0x97f
     596:	0004                	0x4
     598:	0501                	addi	a0,a0,0
     59a:	0900030b          	0x900030b
     59e:	0008                	0x8
     5a0:	0301                	addi	t1,t1,0
     5a2:	0904                	addi	s1,sp,144
     5a4:	0002                	c.slli64	zero
     5a6:	0501                	addi	a0,a0,0
     5a8:	030c                	addi	a1,sp,384
     5aa:	0902                	c.slli64	s2
     5ac:	0008                	0x8
     5ae:	0501                	addi	a0,a0,0
     5b0:	0301                	addi	t1,t1,0
     5b2:	0901                	addi	s2,s2,0
     5b4:	0004                	0x4
     5b6:	0301                	addi	t1,t1,0
     5b8:	00080903          	lb	s2,0(a6)
     5bc:	0501                	addi	a0,a0,0
     5be:	0901030b          	0x901030b
     5c2:	0014                	0x14
     5c4:	0501                	addi	a0,a0,0
     5c6:	09010317          	auipc	t1,0x9010
     5ca:	0002                	c.slli64	zero
     5cc:	0501                	addi	a0,a0,0
     5ce:	030e                	slli	t1,t1,0x3
     5d0:	0900                	addi	s0,sp,144
     5d2:	000c                	0xc
     5d4:	0501                	addi	a0,a0,0
     5d6:	09000313          	li	t1,144
     5da:	000c                	0xc
     5dc:	0501                	addi	a0,a0,0
     5de:	0311                	addi	t1,t1,4
     5e0:	0900                	addi	s0,sp,144
     5e2:	0004                	0x4
     5e4:	0501                	addi	a0,a0,0
     5e6:	097f030f          	0x97f030f
     5ea:	0004                	0x4
     5ec:	0501                	addi	a0,a0,0
     5ee:	0900030b          	0x900030b
     5f2:	000c                	0xc
     5f4:	0501                	addi	a0,a0,0
     5f6:	0301                	addi	t1,t1,0
     5f8:	00020903          	lb	s2,0(tp) # 0 <n-0xc>
     5fc:	0301                	addi	t1,t1,0
     5fe:	000a0903          	lb	s2,0(s4)
     602:	0501                	addi	a0,a0,0
     604:	0305                	addi	t1,t1,1
     606:	0901                	addi	s2,s2,0
     608:	001a                	c.slli	zero,0x6
     60a:	0501                	addi	a0,a0,0
     60c:	0301                	addi	t1,t1,0
     60e:	0901                	addi	s2,s2,0
     610:	0014                	0x14
     612:	0901                	addi	s2,s2,0
     614:	000a                	c.slli	zero,0x2
     616:	0100                	addi	s0,sp,128
     618:	e101                	bnez	a0,618 <n+0x5f8>
     61a:	0002                	c.slli64	zero
     61c:	0300                	addi	s0,sp,384
     61e:	4900                	lw	s0,16(a0)
     620:	0000                	unimp
     622:	0100                	addi	s0,sp,128
     624:	fb01                	bnez	a4,534 <n+0x514>
     626:	0d0e                	slli	s10,s10,0x3
     628:	0100                	addi	s0,sp,128
     62a:	0101                	addi	sp,sp,0
     62c:	0001                	nop
     62e:	0000                	unimp
     630:	0001                	nop
     632:	0100                	addi	s0,sp,128
     634:	6e72656b          	0x6e72656b
     638:	6c65                	lui	s8,0x19
     63a:	6e6f632f          	0x6e6f632f
     63e:	656c6f73          	csrrsi	t5,0x656,24
     642:	6b00                	ld	s0,16(a4)
     644:	7265                	lui	tp,0xffff9
     646:	656e                	ld	a0,216(sp)
     648:	2f6c                	fld	fa1,216(a4)
     64a:	626f6c67          	0x626f6c67
     64e:	656c                	ld	a1,200(a0)
     650:	0000                	unimp
     652:	736e6f63          	bltu	t3,s6,d90 <n+0xd70>
     656:	2e656c6f          	jal	s8,5693c <n+0x5691c>
     65a:	00010063          	beqz	sp,65a <n+0x63a>
     65e:	7300                	ld	s0,32(a4)
     660:	6474                	ld	a3,200(s0)
     662:	6e69                	lui	t3,0x1a
     664:	2e74                	fld	fa3,216(a2)
     666:	0068                	addi	a0,sp,12
     668:	0002                	c.slli64	zero
     66a:	0000                	unimp
     66c:	2105                	addiw	sp,sp,1
     66e:	0900                	addi	s0,sp,144
     670:	4c02                	lw	s8,0(sp)
     672:	2005                	0x2005
     674:	0080                	addi	s0,sp,64
     676:	0000                	unimp
     678:	1400                	addi	s0,sp,544
     67a:	0b05                	addi	s6,s6,1
     67c:	0c090103          	lb	sp,192(s2)
     680:	0100                	addi	s0,sp,128
     682:	2405                	addiw	s0,s0,1
     684:	02090103          	lb	sp,32(s2)
     688:	0100                	addi	s0,sp,128
     68a:	0905                	addi	s2,s2,1
     68c:	08090003          	lb	zero,128(s2)
     690:	0100                	addi	s0,sp,128
     692:	0c05                	addi	s8,s8,1
     694:	06090103          	lb	sp,96(s2)
     698:	0100                	addi	s0,sp,128
     69a:	0a097e03          	0xa097e03
     69e:	0100                	addi	s0,sp,128
     6a0:	0b05                	addi	s6,s6,1
     6a2:	08090003          	lb	zero,128(s2)
     6a6:	0100                	addi	s0,sp,128
     6a8:	0105                	addi	sp,sp,1
     6aa:	02090403          	lb	s0,32(s2)
     6ae:	0100                	addi	s0,sp,128
     6b0:	2905                	addiw	s2,s2,1
     6b2:	0c090203          	lb	tp,192(s2)
     6b6:	0100                	addi	s0,sp,128
     6b8:	0905                	addi	s2,s2,1
     6ba:	10090103          	lb	sp,256(s2)
     6be:	0100                	addi	s0,sp,128
     6c0:	04090103          	lb	sp,64(s2)
     6c4:	0100                	addi	s0,sp,128
     6c6:	0b05                	addi	s6,s6,1
     6c8:	0a090103          	lb	sp,160(s2)
     6cc:	0100                	addi	s0,sp,128
     6ce:	1805                	addi	a6,a6,-31
     6d0:	02090103          	lb	sp,32(s2)
     6d4:	0100                	addi	s0,sp,128
     6d6:	0e05                	addi	t3,t3,1
     6d8:	0a090003          	lb	zero,160(s2)
     6dc:	0100                	addi	s0,sp,128
     6de:	1905                	addi	s2,s2,-31
     6e0:	08090103          	lb	sp,128(s2)
     6e4:	0100                	addi	s0,sp,128
     6e6:	0c05                	addi	s8,s8,1
     6e8:	0a090003          	lb	zero,160(s2)
     6ec:	0100                	addi	s0,sp,128
     6ee:	1905                	addi	s2,s2,-31
     6f0:	0a090003          	lb	zero,160(s2)
     6f4:	0100                	addi	s0,sp,128
     6f6:	1405                	addi	s0,s0,-31
     6f8:	04090003          	lb	zero,64(s2)
     6fc:	0100                	addi	s0,sp,128
     6fe:	0c05                	addi	s8,s8,1
     700:	04090103          	lb	sp,64(s2)
     704:	0100                	addi	s0,sp,128
     706:	1205                	addi	tp,tp,-31
     708:	0a090003          	lb	zero,160(s2)
     70c:	0100                	addi	s0,sp,128
     70e:	0e05                	addi	t3,t3,1
     710:	08090103          	lb	sp,128(s2)
     714:	0100                	addi	s0,sp,128
     716:	0c05                	addi	s8,s8,1
     718:	0a090103          	lb	sp,160(s2)
     71c:	0100                	addi	s0,sp,128
     71e:	0b05                	addi	s6,s6,1
     720:	0a097b03          	0xa097b03
     724:	0100                	addi	s0,sp,128
     726:	0105                	addi	sp,sp,1
     728:	10090703          	lb	a4,256(s2)
     72c:	0100                	addi	s0,sp,128
     72e:	2305                	addiw	t1,t1,1
     730:	0a090203          	lb	tp,160(s2)
     734:	0100                	addi	s0,sp,128
     736:	0905                	addi	s2,s2,1
     738:	0e090203          	lb	tp,224(s2)
     73c:	0100                	addi	s0,sp,128
     73e:	0805                	addi	a6,a6,1
     740:	04090103          	lb	sp,64(s2)
     744:	0100                	addi	s0,sp,128
     746:	1105                	addi	sp,sp,-31
     748:	08090103          	lb	sp,128(s2)
     74c:	0100                	addi	s0,sp,128
     74e:	1505                	addi	a0,a0,-31
     750:	0c090003          	lb	zero,192(s2)
     754:	0100                	addi	s0,sp,128
     756:	0b05                	addi	s6,s6,1
     758:	0e090203          	lb	tp,224(s2)
     75c:	0100                	addi	s0,sp,128
     75e:	1b05                	addi	s6,s6,-31
     760:	02090103          	lb	sp,32(s2)
     764:	0100                	addi	s0,sp,128
     766:	0d05                	addi	s10,s10,1
     768:	0c090003          	lb	zero,192(s2)
     76c:	0100                	addi	s0,sp,128
     76e:	1d05                	addi	s10,s10,-31
     770:	04090103          	lb	sp,64(s2)
     774:	0100                	addi	s0,sp,128
     776:	1105                	addi	sp,sp,-31
     778:	08090003          	lb	zero,128(s2)
     77c:	0100                	addi	s0,sp,128
     77e:	1d05                	addi	s10,s10,-31
     780:	0c090003          	lb	zero,192(s2)
     784:	0100                	addi	s0,sp,128
     786:	1505                	addi	a0,a0,-31
     788:	08090003          	lb	zero,128(s2)
     78c:	0100                	addi	s0,sp,128
     78e:	0f05                	addi	t5,t5,1
     790:	0a090103          	lb	sp,160(s2)
     794:	0100                	addi	s0,sp,128
     796:	0b05                	addi	s6,s6,1
     798:	0e097d03          	0xe097d03
     79c:	0100                	addi	s0,sp,128
     79e:	0f05                	addi	t5,t5,1
     7a0:	08090503          	lb	a0,128(s2)
     7a4:	0100                	addi	s0,sp,128
     7a6:	0505                	addi	a0,a0,1
     7a8:	0e090103          	lb	sp,224(s2)
     7ac:	0100                	addi	s0,sp,128
     7ae:	10090103          	lb	sp,256(s2)
     7b2:	0100                	addi	s0,sp,128
     7b4:	0105                	addi	sp,sp,1
     7b6:	0a090103          	lb	sp,160(s2)
     7ba:	0100                	addi	s0,sp,128
     7bc:	2305                	addiw	t1,t1,1
     7be:	0a090203          	lb	tp,160(s2)
     7c2:	0100                	addi	s0,sp,128
     7c4:	0905                	addi	s2,s2,1
     7c6:	0c090203          	lb	tp,192(s2)
     7ca:	0100                	addi	s0,sp,128
     7cc:	0805                	addi	a6,a6,1
     7ce:	04090103          	lb	sp,64(s2)
     7d2:	0100                	addi	s0,sp,128
     7d4:	1105                	addi	sp,sp,-31
     7d6:	06090103          	lb	sp,96(s2)
     7da:	0100                	addi	s0,sp,128
     7dc:	1505                	addi	a0,a0,-31
     7de:	0c090003          	lb	zero,192(s2)
     7e2:	0100                	addi	s0,sp,128
     7e4:	0b05                	addi	s6,s6,1
     7e6:	0e090203          	lb	tp,224(s2)
     7ea:	0100                	addi	s0,sp,128
     7ec:	1b05                	addi	s6,s6,-31
     7ee:	02090103          	lb	sp,32(s2)
     7f2:	0100                	addi	s0,sp,128
     7f4:	0d05                	addi	s10,s10,1
     7f6:	0a090003          	lb	zero,160(s2)
     7fa:	0100                	addi	s0,sp,128
     7fc:	1d05                	addi	s10,s10,-31
     7fe:	04090103          	lb	sp,64(s2)
     802:	0100                	addi	s0,sp,128
     804:	1105                	addi	sp,sp,-31
     806:	08090003          	lb	zero,128(s2)
     80a:	0100                	addi	s0,sp,128
     80c:	1d05                	addi	s10,s10,-31
     80e:	0c090003          	lb	zero,192(s2)
     812:	0100                	addi	s0,sp,128
     814:	1505                	addi	a0,a0,-31
     816:	08090003          	lb	zero,128(s2)
     81a:	0100                	addi	s0,sp,128
     81c:	0f05                	addi	t5,t5,1
     81e:	0a090103          	lb	sp,160(s2)
     822:	0100                	addi	s0,sp,128
     824:	0b05                	addi	s6,s6,1
     826:	0e097d03          	0xe097d03
     82a:	0100                	addi	s0,sp,128
     82c:	0f05                	addi	t5,t5,1
     82e:	06090503          	lb	a0,96(s2)
     832:	0100                	addi	s0,sp,128
     834:	0505                	addi	a0,a0,1
     836:	0e090103          	lb	sp,224(s2)
     83a:	0100                	addi	s0,sp,128
     83c:	10090103          	lb	sp,256(s2)
     840:	0100                	addi	s0,sp,128
     842:	0105                	addi	sp,sp,1
     844:	0a090103          	lb	sp,160(s2)
     848:	0100                	addi	s0,sp,128
     84a:	0a090303          	lb	t1,160(s2)
     84e:	0100                	addi	s0,sp,128
     850:	0505                	addi	a0,a0,1
     852:	0c090103          	lb	sp,192(s2)
     856:	0100                	addi	s0,sp,128
     858:	0e05                	addi	t3,t3,1
     85a:	0c090103          	lb	sp,192(s2)
     85e:	0100                	addi	s0,sp,128
     860:	0505                	addi	a0,a0,1
     862:	06090003          	lb	zero,96(s2)
     866:	0100                	addi	s0,sp,128
     868:	2205                	addiw	tp,tp,1
     86a:	02090203          	lb	tp,32(s2)
     86e:	0100                	addi	s0,sp,128
     870:	1c05                	addi	s8,s8,-31
     872:	0a090003          	lb	zero,160(s2)
     876:	0100                	addi	s0,sp,128
     878:	2805                	addiw	a6,a6,1
     87a:	0a090003          	lb	zero,160(s2)
     87e:	0100                	addi	s0,sp,128
     880:	0d05                	addi	s10,s10,1
     882:	02090003          	lb	zero,32(s2)
     886:	0100                	addi	s0,sp,128
     888:	0e05                	addi	t3,t3,1
     88a:	06090103          	lb	sp,96(s2)
     88e:	0100                	addi	s0,sp,128
     890:	2505                	addiw	a0,a0,1
     892:	0200                	addi	s0,sp,256
     894:	0104                	addi	s1,sp,128
     896:	0e090003          	lb	zero,224(s2)
     89a:	0100                	addi	s0,sp,128
     89c:	0e05                	addi	t3,t3,1
     89e:	0200                	addi	s0,sp,256
     8a0:	0104                	addi	s1,sp,128
     8a2:	08090003          	lb	zero,128(s2)
     8a6:	0100                	addi	s0,sp,128
     8a8:	3b05                	addiw	s6,s6,-31
     8aa:	0200                	addi	s0,sp,256
     8ac:	0204                	addi	s1,sp,256
     8ae:	0a090003          	lb	zero,160(s2)
     8b2:	0100                	addi	s0,sp,128
     8b4:	0e05                	addi	t3,t3,1
     8b6:	0200                	addi	s0,sp,256
     8b8:	0204                	addi	s1,sp,256
     8ba:	08090003          	lb	zero,128(s2)
     8be:	0100                	addi	s0,sp,128
     8c0:	0200                	addi	s0,sp,256
     8c2:	0404                	addi	s1,sp,512
     8c4:	0306                	slli	t1,t1,0x1
     8c6:	0900                	addi	s0,sp,144
     8c8:	0008                	0x8
     8ca:	0501                	addi	a0,a0,0
     8cc:	0009                	c.nop	2
     8ce:	0402                	c.slli64	s0
     8d0:	0604                	addi	s1,sp,768
     8d2:	04090103          	lb	sp,64(s2)
     8d6:	0100                	addi	s0,sp,128
     8d8:	1f05                	addi	t5,t5,-31
     8da:	0200                	addi	s0,sp,256
     8dc:	0404                	addi	s1,sp,512
     8de:	0a097c03          	0xa097c03
     8e2:	0100                	addi	s0,sp,128
     8e4:	0505                	addi	a0,a0,1
     8e6:	0200                	addi	s0,sp,256
     8e8:	0204                	addi	s1,sp,256
     8ea:	0a090003          	lb	zero,160(s2)
     8ee:	0100                	addi	s0,sp,128
     8f0:	0105                	addi	sp,sp,1
     8f2:	0a090603          	lb	a2,160(s2)
     8f6:	0100                	addi	s0,sp,128
     8f8:	0c09                	addi	s8,s8,2
     8fa:	0000                	unimp
     8fc:	0101                	addi	sp,sp,0
     8fe:	00000077          	0x77
     902:	002b0003          	lb	zero,2(s6)
     906:	0000                	unimp
     908:	0101                	addi	sp,sp,0
     90a:	000d0efb          	0xd0efb
     90e:	0101                	addi	sp,sp,0
     910:	0101                	addi	sp,sp,0
     912:	0000                	unimp
     914:	0100                	addi	s0,sp,128
     916:	0000                	unimp
     918:	6b01                	0x6b01
     91a:	7265                	lui	tp,0xffff9
     91c:	656e                	ld	a0,216(sp)
     91e:	2f6c                	fld	fa1,216(a4)
     920:	6564                	ld	s1,200(a0)
     922:	7562                	ld	a0,56(sp)
     924:	64000067          	jr	1600(zero) # 0 <n-0xc>
     928:	6265                	lui	tp,0x19
     92a:	6775                	lui	a4,0x1d
     92c:	632e                	ld	t1,200(sp)
     92e:	0100                	addi	s0,sp,128
     930:	0000                	unimp
     932:	0500                	addi	s0,sp,640
     934:	0028                	addi	a0,sp,8
     936:	0209                	addi	tp,tp,2
     938:	0810                	addi	a2,sp,16
     93a:	8020                	0x8020
     93c:	0000                	unimp
     93e:	0000                	unimp
     940:	0514                	addi	a3,sp,640
     942:	0305                	addi	t1,t1,1
     944:	0901                	addi	s2,s2,0
     946:	0012                	c.slli	zero,0x4
     948:	0301                	addi	t1,t1,0
     94a:	0901                	addi	s2,s2,0
     94c:	000c                	0xc
     94e:	0301                	addi	t1,t1,0
     950:	0901                	addi	s2,s2,0
     952:	0008                	0x8
     954:	0301                	addi	t1,t1,0
     956:	0901                	addi	s2,s2,0
     958:	000c                	0xc
     95a:	0301                	addi	t1,t1,0
     95c:	0901                	addi	s2,s2,0
     95e:	000a                	c.slli	zero,0x2
     960:	0301                	addi	t1,t1,0
     962:	0901                	addi	s2,s2,0
     964:	000c                	0xc
     966:	0501                	addi	a0,a0,0
     968:	000a                	c.slli	zero,0x2
     96a:	0402                	c.slli64	s0
     96c:	0301                	addi	t1,t1,0
     96e:	0901                	addi	s2,s2,0
     970:	0004                	0x4
     972:	0901                	addi	s2,s2,0
     974:	0002                	c.slli64	zero
     976:	0100                	addi	s0,sp,128
     978:	c301                	beqz	a4,978 <n+0x958>
     97a:	0002                	c.slli64	zero
     97c:	0300                	addi	s0,sp,384
     97e:	7500                	ld	s0,40(a0)
     980:	0000                	unimp
     982:	0100                	addi	s0,sp,128
     984:	fb01                	bnez	a4,894 <n+0x874>
     986:	0d0e                	slli	s10,s10,0x3
     988:	0100                	addi	s0,sp,128
     98a:	0101                	addi	sp,sp,0
     98c:	0001                	nop
     98e:	0000                	unimp
     990:	0001                	nop
     992:	0100                	addi	s0,sp,128
     994:	6e72656b          	0x6e72656b
     998:	6c65                	lui	s8,0x19
     99a:	7461622f          	0x7461622f
     99e:	742f6863          	bltu	t5,sp,10ee <n+0x10ce>
     9a2:	7361                	lui	t1,0xffff8
     9a4:	656b006b          	0x656b006b
     9a8:	6e72                	ld	t3,280(sp)
     9aa:	6c65                	lui	s8,0x19
     9ac:	7461622f          	0x7461622f
     9b0:	632f6863          	bltu	t5,s2,fe0 <n+0xfc0>
     9b4:	65746e6f          	jal	t3,4780a <n+0x477ea>
     9b8:	7478                	ld	a4,232(s0)
     9ba:	6b00                	ld	s0,16(a4)
     9bc:	7265                	lui	tp,0xffff9
     9be:	656e                	ld	a0,216(sp)
     9c0:	2f6c                	fld	fa1,216(a4)
     9c2:	626f6c67          	0x626f6c67
     9c6:	656c                	ld	a1,200(a0)
     9c8:	0000                	unimp
     9ca:	6174                	ld	a3,192(a0)
     9cc:	632e6b73          	csrrsi	s6,0x632,28
     9d0:	0100                	addi	s0,sp,128
     9d2:	0000                	unimp
     9d4:	746e6f63          	bltu	t3,t1,1132 <n+0x1112>
     9d8:	7865                	lui	a6,0xffff9
     9da:	2e74                	fld	fa3,216(a2)
     9dc:	0068                	addi	a0,sp,12
     9de:	0002                	c.slli64	zero
     9e0:	7400                	ld	s0,40(s0)
     9e2:	7361                	lui	t1,0xffff8
     9e4:	00682e6b          	0x682e6b
     9e8:	0001                	nop
     9ea:	7300                	ld	s0,32(a4)
     9ec:	6474                	ld	a3,200(s0)
     9ee:	6e69                	lui	t3,0x1a
     9f0:	2e74                	fld	fa3,216(a2)
     9f2:	0068                	addi	a0,sp,12
     9f4:	00000003          	lb	zero,0(zero) # 0 <n-0xc>
     9f8:	1f05                	addi	t5,t5,-31
     9fa:	0900                	addi	s0,sp,144
     9fc:	5e02                	lw	t3,32(sp)
     9fe:	2008                	fld	fa0,0(s0)
     a00:	0080                	addi	s0,sp,64
     a02:	0000                	unimp
     a04:	0300                	addi	s0,sp,384
     a06:	0505010b          	0x505010b
     a0a:	08090303          	lb	t1,128(s2)
     a0e:	0100                	addi	s0,sp,128
     a10:	0c090103          	lb	sp,192(s2)
     a14:	0100                	addi	s0,sp,128
     a16:	0e090103          	lb	sp,224(s2)
     a1a:	0100                	addi	s0,sp,128
     a1c:	1b05                	addi	s6,s6,-31
     a1e:	0c090103          	lb	sp,192(s2)
     a22:	0100                	addi	s0,sp,128
     a24:	1f05                	addi	t5,t5,-31
     a26:	0c090103          	lb	sp,192(s2)
     a2a:	0100                	addi	s0,sp,128
     a2c:	1205                	addi	tp,tp,-31
     a2e:	0c090303          	lb	t1,192(s2)
     a32:	0100                	addi	s0,sp,128
     a34:	0505                	addi	a0,a0,1
     a36:	04090003          	lb	zero,64(s2)
     a3a:	0100                	addi	s0,sp,128
     a3c:	1e05                	addi	t3,t3,-31
     a3e:	0200                	addi	s0,sp,256
     a40:	0304                	addi	s1,sp,384
     a42:	02090403          	lb	s0,32(s2)
     a46:	0100                	addi	s0,sp,128
     a48:	1205                	addi	tp,tp,-31
     a4a:	0200                	addi	s0,sp,256
     a4c:	0304                	addi	s1,sp,384
     a4e:	0a090003          	lb	zero,160(s2)
     a52:	0100                	addi	s0,sp,128
     a54:	2b05                	addiw	s6,s6,1
     a56:	0200                	addi	s0,sp,256
     a58:	0304                	addi	s1,sp,384
     a5a:	08090103          	lb	sp,128(s2)
     a5e:	0100                	addi	s0,sp,128
     a60:	2c05                	addiw	s8,s8,1
     a62:	0200                	addi	s0,sp,256
     a64:	0304                	addi	s1,sp,384
     a66:	1c090103          	lb	sp,448(s2)
     a6a:	0100                	addi	s0,sp,128
     a6c:	2a05                	addiw	s4,s4,1
     a6e:	0200                	addi	s0,sp,256
     a70:	0304                	addi	s1,sp,384
     a72:	08090003          	lb	zero,128(s2)
     a76:	0100                	addi	s0,sp,128
     a78:	0200                	addi	s0,sp,256
     a7a:	0304                	addi	s1,sp,384
     a7c:	18090103          	lb	sp,384(s2)
     a80:	0100                	addi	s0,sp,128
     a82:	1c05                	addi	s8,s8,-31
     a84:	0200                	addi	s0,sp,256
     a86:	0304                	addi	s1,sp,384
     a88:	1c090303          	lb	t1,448(s2)
     a8c:	0100                	addi	s0,sp,128
     a8e:	2405                	addiw	s0,s0,1
     a90:	0200                	addi	s0,sp,256
     a92:	0304                	addi	s1,sp,384
     a94:	12090503          	lb	a0,288(s2)
     a98:	0100                	addi	s0,sp,128
     a9a:	1105                	addi	sp,sp,-31
     a9c:	0200                	addi	s0,sp,256
     a9e:	0304                	addi	s1,sp,384
     aa0:	0e090003          	lb	zero,224(s2)
     aa4:	0100                	addi	s0,sp,128
     aa6:	1605                	addi	a2,a2,-31
     aa8:	0200                	addi	s0,sp,256
     aaa:	0304                	addi	s1,sp,384
     aac:	04090103          	lb	sp,64(s2)
     ab0:	0100                	addi	s0,sp,128
     ab2:	2805                	addiw	a6,a6,1
     ab4:	0200                	addi	s0,sp,256
     ab6:	0304                	addi	s1,sp,384
     ab8:	0c090003          	lb	zero,192(s2)
     abc:	0100                	addi	s0,sp,128
     abe:	1405                	addi	s0,s0,-31
     ac0:	0200                	addi	s0,sp,256
     ac2:	0304                	addi	s1,sp,384
     ac4:	04090003          	lb	zero,64(s2)
     ac8:	0100                	addi	s0,sp,128
     aca:	1d05                	addi	s10,s10,-31
     acc:	0200                	addi	s0,sp,256
     ace:	0304                	addi	s1,sp,384
     ad0:	04090103          	lb	sp,64(s2)
     ad4:	0100                	addi	s0,sp,128
     ad6:	1105                	addi	sp,sp,-31
     ad8:	0200                	addi	s0,sp,256
     ada:	0304                	addi	s1,sp,384
     adc:	0a090003          	lb	zero,160(s2)
     ae0:	0100                	addi	s0,sp,128
     ae2:	0a05                	addi	s4,s4,1
     ae4:	0200                	addi	s0,sp,256
     ae6:	0304                	addi	s1,sp,384
     ae8:	04090203          	lb	tp,64(s2)
     aec:	0100                	addi	s0,sp,128
     aee:	2a05                	addiw	s4,s4,1
     af0:	0200                	addi	s0,sp,256
     af2:	0304                	addi	s1,sp,384
     af4:	04090003          	lb	zero,64(s2)
     af8:	0100                	addi	s0,sp,128
     afa:	2c05                	addiw	s8,s8,1
     afc:	0200                	addi	s0,sp,256
     afe:	0304                	addi	s1,sp,384
     b00:	14096d03          	lwu	s10,320(s2)
     b04:	0100                	addi	s0,sp,128
     b06:	0505                	addi	a0,a0,1
     b08:	0200                	addi	s0,sp,256
     b0a:	0104                	addi	s1,sp,128
     b0c:	0a090003          	lb	zero,160(s2)
     b10:	0100                	addi	s0,sp,128
     b12:	0105                	addi	sp,sp,1
     b14:	0a091503          	lh	a0,160(s2)
     b18:	0100                	addi	s0,sp,128
     b1a:	0c090403          	lb	s0,192(s2)
     b1e:	0100                	addi	s0,sp,128
     b20:	2905                	addiw	s2,s2,1
     b22:	0c090303          	lb	t1,192(s2)
     b26:	0100                	addi	s0,sp,128
     b28:	3705                	addiw	a4,a4,-31
     b2a:	0a090003          	lb	zero,160(s2)
     b2e:	0100                	addi	s0,sp,128
     b30:	1a05                	addi	s4,s4,-31
     b32:	04090003          	lb	zero,64(s2)
     b36:	0100                	addi	s0,sp,128
     b38:	0505                	addi	a0,a0,1
     b3a:	0a090003          	lb	zero,160(s2)
     b3e:	0100                	addi	s0,sp,128
     b40:	3005                	0x3005
     b42:	02090103          	lb	sp,32(s2)
     b46:	0100                	addi	s0,sp,128
     b48:	0c05                	addi	s8,s8,1
     b4a:	1a090003          	lb	zero,416(s2)
     b4e:	0100                	addi	s0,sp,128
     b50:	9c05                	subw	s0,s0,s1
     b52:	0001                	nop
     b54:	0402                	c.slli64	s0
     b56:	0302                	c.slli64	t1
     b58:	097f                	0x97f
     b5a:	0008                	0x8
     b5c:	0501                	addi	a0,a0,0
     b5e:	0189                	addi	gp,gp,2
     b60:	0200                	addi	s0,sp,256
     b62:	0204                	addi	s1,sp,256
     b64:	08090003          	lb	zero,128(s2)
     b68:	0100                	addi	s0,sp,128
     b6a:	6a05                	lui	s4,0x1
     b6c:	0200                	addi	s0,sp,256
     b6e:	0104                	addi	s1,sp,128
     b70:	0a090003          	lb	zero,160(s2)
     b74:	0100                	addi	s0,sp,128
     b76:	0505                	addi	a0,a0,1
     b78:	0200                	addi	s0,sp,256
     b7a:	0104                	addi	s1,sp,128
     b7c:	0a090003          	lb	zero,160(s2)
     b80:	0100                	addi	s0,sp,128
     b82:	0d05                	addi	s10,s10,1
     b84:	0a090203          	lb	tp,160(s2)
     b88:	0100                	addi	s0,sp,128
     b8a:	2905                	addiw	s2,s2,1
     b8c:	02090403          	lb	s0,32(s2)
     b90:	0100                	addi	s0,sp,128
     b92:	0805                	addi	a6,a6,1
     b94:	0a090003          	lb	zero,160(s2)
     b98:	0100                	addi	s0,sp,128
     b9a:	5f05                	li	t5,-31
     b9c:	0200                	addi	s0,sp,256
     b9e:	0104                	addi	s1,sp,128
     ba0:	08090003          	lb	zero,128(s2)
     ba4:	0100                	addi	s0,sp,128
     ba6:	3805                	addiw	a6,a6,-31
     ba8:	0200                	addi	s0,sp,256
     baa:	0104                	addi	s1,sp,128
     bac:	1a090003          	lb	zero,416(s2)
     bb0:	0100                	addi	s0,sp,128
     bb2:	0905                	addi	s2,s2,1
     bb4:	0200                	addi	s0,sp,256
     bb6:	0104                	addi	s1,sp,128
     bb8:	08090103          	lb	sp,128(s2)
     bbc:	0100                	addi	s0,sp,128
     bbe:	1e05                	addi	t3,t3,-31
     bc0:	10090303          	lb	t1,256(s2)
     bc4:	0100                	addi	s0,sp,128
     bc6:	5105                	li	sp,-31
     bc8:	1e090103          	lb	sp,480(s2)
     bcc:	0100                	addi	s0,sp,128
     bce:	1e05                	addi	t3,t3,-31
     bd0:	0a090003          	lb	zero,160(s2)
     bd4:	0100                	addi	s0,sp,128
     bd6:	2305                	addiw	t1,t1,1
     bd8:	1a090303          	lb	t1,416(s2)
     bdc:	0100                	addi	s0,sp,128
     bde:	2205                	addiw	tp,tp,1
     be0:	0e090103          	lb	sp,224(s2)
     be4:	0100                	addi	s0,sp,128
     be6:	1f05                	addi	t5,t5,-31
     be8:	08090103          	lb	sp,128(s2)
     bec:	0100                	addi	s0,sp,128
     bee:	0505                	addi	a0,a0,1
     bf0:	0e090303          	lb	t1,224(s2)
     bf4:	0100                	addi	s0,sp,128
     bf6:	0105                	addi	sp,sp,1
     bf8:	10090103          	lb	sp,256(s2)
     bfc:	0100                	addi	s0,sp,128
     bfe:	0a090403          	lb	s0,160(s2)
     c02:	0100                	addi	s0,sp,128
     c04:	2405                	addiw	s0,s0,1
     c06:	08090203          	lb	tp,128(s2)
     c0a:	0100                	addi	s0,sp,128
     c0c:	3f05                	addiw	t5,t5,-31
     c0e:	0a090003          	lb	zero,160(s2)
     c12:	0100                	addi	s0,sp,128
     c14:	0505                	addi	a0,a0,1
     c16:	18090103          	lb	sp,384(s2)
     c1a:	0100                	addi	s0,sp,128
     c1c:	3505                	addiw	a0,a0,-31
     c1e:	0c090103          	lb	sp,192(s2)
     c22:	0100                	addi	s0,sp,128
     c24:	0505                	addi	a0,a0,1
     c26:	0a090003          	lb	zero,160(s2)
     c2a:	0100                	addi	s0,sp,128
     c2c:	24090103          	lb	sp,576(s2)
     c30:	0100                	addi	s0,sp,128
     c32:	0105                	addi	sp,sp,1
     c34:	10090103          	lb	sp,256(s2)
     c38:	0100                	addi	s0,sp,128
     c3a:	0a09                	addi	s4,s4,2
     c3c:	0000                	unimp
     c3e:	0101                	addi	sp,sp,0
     c40:	0486                	slli	s1,s1,0x1
     c42:	0000                	unimp
     c44:	00900003          	lb	zero,9(zero) # 9 <n-0x3>
     c48:	0000                	unimp
     c4a:	0101                	addi	sp,sp,0
     c4c:	000d0efb          	0xd0efb
     c50:	0101                	addi	sp,sp,0
     c52:	0101                	addi	sp,sp,0
     c54:	0000                	unimp
     c56:	0100                	addi	s0,sp,128
     c58:	0000                	unimp
     c5a:	6b01                	0x6b01
     c5c:	7265                	lui	tp,0xffff9
     c5e:	656e                	ld	a0,216(sp)
     c60:	2f6c                	fld	fa1,216(a4)
     c62:	6162                	ld	sp,24(sp)
     c64:	6374                	ld	a3,192(a4)
     c66:	0068                	addi	a0,sp,12
     c68:	6e72656b          	0x6e72656b
     c6c:	6c65                	lui	s8,0x19
     c6e:	6f6c672f          	0x6f6c672f
     c72:	6c62                	ld	s8,24(sp)
     c74:	0065                	c.nop	25
     c76:	6e72656b          	0x6e72656b
     c7a:	6c65                	lui	s8,0x19
     c7c:	7461622f          	0x7461622f
     c80:	632f6863          	bltu	t5,s2,12b0 <n+0x1290>
     c84:	65746e6f          	jal	t3,47ada <n+0x47aba>
     c88:	7478                	ld	a4,232(s0)
     c8a:	6b00                	ld	s0,16(a4)
     c8c:	7265                	lui	tp,0xffff9
     c8e:	656e                	ld	a0,216(sp)
     c90:	2f6c                	fld	fa1,216(a4)
     c92:	6162                	ld	sp,24(sp)
     c94:	6374                	ld	a3,192(a4)
     c96:	2f68                	fld	fa0,216(a4)
     c98:	63617473          	csrrci	s0,0x636,2
     c9c:	6200006b          	0x6200006b
     ca0:	7461                	lui	s0,0xffff8
     ca2:	632e6863          	bltu	t3,s2,12d2 <n+0x12b2>
     ca6:	0100                	addi	s0,sp,128
     ca8:	0000                	unimp
     caa:	69647473          	csrrci	s0,0x696,8
     cae:	746e                	ld	s0,248(sp)
     cb0:	682e                	ld	a6,200(sp)
     cb2:	0200                	addi	s0,sp,256
     cb4:	0000                	unimp
     cb6:	746e6f63          	bltu	t3,t1,1414 <n+0x13f4>
     cba:	7865                	lui	a6,0xffff9
     cbc:	2e74                	fld	fa3,216(a2)
     cbe:	0068                	addi	a0,sp,12
     cc0:	62000003          	lb	zero,1568(zero) # 620 <n+0x600>
     cc4:	7461                	lui	s0,0xffff8
     cc6:	682e6863          	bltu	t3,sp,1356 <n+0x1336>
     cca:	0100                	addi	s0,sp,128
     ccc:	0000                	unimp
     cce:	63617473          	csrrci	s0,0x636,2
     cd2:	00682e6b          	0x682e6b
     cd6:	0004                	0x4
     cd8:	0000                	unimp
     cda:	0105                	addi	sp,sp,1
     cdc:	0900                	addi	s0,sp,144
     cde:	4402                	lw	s0,0(sp)
     ce0:	0080200b          	0x80200b
     ce4:	0000                	unimp
     ce6:	0300                	addi	s0,sp,384
     ce8:	010c                	addi	a1,sp,128
     cea:	2305                	addiw	t1,t1,1
     cec:	08090103          	lb	sp,128(s2)
     cf0:	0100                	addi	s0,sp,128
     cf2:	1905                	addi	s2,s2,-31
     cf4:	0a090003          	lb	zero,160(s2)
     cf8:	0100                	addi	s0,sp,128
     cfa:	1305                	addi	t1,t1,-31
     cfc:	0a090103          	lb	sp,160(s2)
     d00:	0100                	addi	s0,sp,128
     d02:	0505                	addi	a0,a0,1
     d04:	04090003          	lb	zero,64(s2)
     d08:	0100                	addi	s0,sp,128
     d0a:	3305                	addiw	t1,t1,-31
     d0c:	0200                	addi	s0,sp,256
     d0e:	0304                	addi	s1,sp,384
     d10:	02090203          	lb	tp,32(s2)
     d14:	0100                	addi	s0,sp,128
     d16:	2f05                	addiw	t5,t5,1
     d18:	0200                	addi	s0,sp,256
     d1a:	0304                	addi	s1,sp,384
     d1c:	06090003          	lb	zero,96(s2)
     d20:	0100                	addi	s0,sp,128
     d22:	2c05                	addiw	s8,s8,1
     d24:	0200                	addi	s0,sp,256
     d26:	0304                	addi	s1,sp,384
     d28:	02090003          	lb	zero,32(s2)
     d2c:	0100                	addi	s0,sp,128
     d2e:	2205                	addiw	tp,tp,1
     d30:	0200                	addi	s0,sp,256
     d32:	0304                	addi	s1,sp,384
     d34:	0e090003          	lb	zero,224(s2)
     d38:	0100                	addi	s0,sp,128
     d3a:	2d05                	addiw	s10,s10,1
     d3c:	0200                	addi	s0,sp,256
     d3e:	0304                	addi	s1,sp,384
     d40:	14090103          	lb	sp,320(s2)
     d44:	0100                	addi	s0,sp,128
     d46:	2a05                	addiw	s4,s4,1
     d48:	0200                	addi	s0,sp,256
     d4a:	0304                	addi	s1,sp,384
     d4c:	08090003          	lb	zero,128(s2)
     d50:	0100                	addi	s0,sp,128
     d52:	2005                	0x2005
     d54:	0200                	addi	s0,sp,256
     d56:	0304                	addi	s1,sp,384
     d58:	0e090003          	lb	zero,224(s2)
     d5c:	0100                	addi	s0,sp,128
     d5e:	3405                	addiw	s0,s0,-31
     d60:	0200                	addi	s0,sp,256
     d62:	0304                	addi	s1,sp,384
     d64:	14097d03          	0x14097d03
     d68:	0100                	addi	s0,sp,128
     d6a:	2905                	addiw	s2,s2,1
     d6c:	0200                	addi	s0,sp,256
     d6e:	0104                	addi	s1,sp,128
     d70:	0a090003          	lb	zero,160(s2)
     d74:	0100                	addi	s0,sp,128
     d76:	0505                	addi	a0,a0,1
     d78:	0200                	addi	s0,sp,256
     d7a:	0104                	addi	s1,sp,128
     d7c:	0a090003          	lb	zero,160(s2)
     d80:	0100                	addi	s0,sp,128
     d82:	1d05                	addi	s10,s10,-31
     d84:	08090503          	lb	a0,128(s2)
     d88:	0100                	addi	s0,sp,128
     d8a:	0505                	addi	a0,a0,1
     d8c:	0c090103          	lb	sp,192(s2)
     d90:	0100                	addi	s0,sp,128
     d92:	0105                	addi	sp,sp,1
     d94:	0c090103          	lb	sp,192(s2)
     d98:	0100                	addi	s0,sp,128
     d9a:	0a090303          	lb	t1,160(s2)
     d9e:	0100                	addi	s0,sp,128
     da0:	1e05                	addi	t3,t3,-31
     da2:	0c090103          	lb	sp,192(s2)
     da6:	0100                	addi	s0,sp,128
     da8:	0805                	addi	a6,a6,1
     daa:	0a090003          	lb	zero,160(s2)
     dae:	0100                	addi	s0,sp,128
     db0:	0905                	addi	s2,s2,1
     db2:	0200                	addi	s0,sp,256
     db4:	0104                	addi	s1,sp,128
     db6:	08090203          	lb	tp,128(s2)
     dba:	0100                	addi	s0,sp,128
     dbc:	0200                	addi	s0,sp,256
     dbe:	0104                	addi	s1,sp,128
     dc0:	0e090103          	lb	sp,224(s2)
     dc4:	0100                	addi	s0,sp,128
     dc6:	0505                	addi	a0,a0,1
     dc8:	02090203          	lb	tp,32(s2)
     dcc:	0100                	addi	s0,sp,128
     dce:	0c090103          	lb	sp,192(s2)
     dd2:	0100                	addi	s0,sp,128
     dd4:	08090103          	lb	sp,128(s2)
     dd8:	0100                	addi	s0,sp,128
     dda:	0c090203          	lb	tp,192(s2)
     dde:	0100                	addi	s0,sp,128
     de0:	1d05                	addi	s10,s10,-31
     de2:	12090403          	lb	s0,288(s2)
     de6:	0100                	addi	s0,sp,128
     de8:	2605                	addiw	a2,a2,1
     dea:	0a090003          	lb	zero,160(s2)
     dee:	0100                	addi	s0,sp,128
     df0:	0805                	addi	a6,a6,1
     df2:	02090003          	lb	zero,32(s2)
     df6:	0100                	addi	s0,sp,128
     df8:	2905                	addiw	s2,s2,1
     dfa:	08090203          	lb	tp,128(s2)
     dfe:	0100                	addi	s0,sp,128
     e00:	4705                	li	a4,1
     e02:	14090003          	lb	zero,320(s2)
     e06:	0100                	addi	s0,sp,128
     e08:	1205                	addi	tp,tp,-31
     e0a:	14090003          	lb	zero,320(s2)
     e0e:	0100                	addi	s0,sp,128
     e10:	0a090303          	lb	t1,160(s2)
     e14:	0100                	addi	s0,sp,128
     e16:	3905                	addiw	s2,s2,-31
     e18:	08090303          	lb	t1,128(s2)
     e1c:	0100                	addi	s0,sp,128
     e1e:	1105                	addi	sp,sp,-31
     e20:	14090003          	lb	zero,320(s2)
     e24:	0100                	addi	s0,sp,128
     e26:	0b05                	addi	s6,s6,1
     e28:	04090103          	lb	sp,64(s2)
     e2c:	0100                	addi	s0,sp,128
     e2e:	0505                	addi	a0,a0,1
     e30:	0a090203          	lb	tp,160(s2)
     e34:	0100                	addi	s0,sp,128
     e36:	14090103          	lb	sp,320(s2)
     e3a:	0100                	addi	s0,sp,128
     e3c:	0105                	addi	sp,sp,1
     e3e:	04090103          	lb	sp,64(s2)
     e42:	0100                	addi	s0,sp,128
     e44:	3105                	addiw	sp,sp,-31
     e46:	08090403          	lb	s0,128(s2)
     e4a:	0100                	addi	s0,sp,128
     e4c:	0505                	addi	a0,a0,1
     e4e:	0c090103          	lb	sp,192(s2)
     e52:	0100                	addi	s0,sp,128
     e54:	0c090103          	lb	sp,192(s2)
     e58:	0100                	addi	s0,sp,128
     e5a:	0c090103          	lb	sp,192(s2)
     e5e:	0100                	addi	s0,sp,128
     e60:	1305                	addi	t1,t1,-31
     e62:	0c090203          	lb	tp,192(s2)
     e66:	0100                	addi	s0,sp,128
     e68:	0505                	addi	a0,a0,1
     e6a:	04090003          	lb	zero,64(s2)
     e6e:	0100                	addi	s0,sp,128
     e70:	0905                	addi	s2,s2,1
     e72:	0200                	addi	s0,sp,256
     e74:	0304                	addi	s1,sp,384
     e76:	02090103          	lb	sp,32(s2)
     e7a:	0100                	addi	s0,sp,128
     e7c:	0200                	addi	s0,sp,256
     e7e:	0304                	addi	s1,sp,384
     e80:	0c090103          	lb	sp,192(s2)
     e84:	0100                	addi	s0,sp,128
     e86:	0200                	addi	s0,sp,256
     e88:	0304                	addi	s1,sp,384
     e8a:	08090103          	lb	sp,128(s2)
     e8e:	0100                	addi	s0,sp,128
     e90:	0200                	addi	s0,sp,256
     e92:	0304                	addi	s1,sp,384
     e94:	0c090103          	lb	sp,192(s2)
     e98:	0100                	addi	s0,sp,128
     e9a:	0200                	addi	s0,sp,256
     e9c:	0304                	addi	s1,sp,384
     e9e:	16090103          	lb	sp,352(s2)
     ea2:	0100                	addi	s0,sp,128
     ea4:	0200                	addi	s0,sp,256
     ea6:	0304                	addi	s1,sp,384
     ea8:	0c090103          	lb	sp,192(s2)
     eac:	0100                	addi	s0,sp,128
     eae:	0200                	addi	s0,sp,256
     eb0:	0304                	addi	s1,sp,384
     eb2:	16090103          	lb	sp,352(s2)
     eb6:	0100                	addi	s0,sp,128
     eb8:	3005                	0x3005
     eba:	0200                	addi	s0,sp,256
     ebc:	0304                	addi	s1,sp,384
     ebe:	0c097903          	0xc097903
     ec2:	0100                	addi	s0,sp,128
     ec4:	2505                	addiw	a0,a0,1
     ec6:	0200                	addi	s0,sp,256
     ec8:	0104                	addi	s1,sp,128
     eca:	0a090003          	lb	zero,160(s2)
     ece:	0100                	addi	s0,sp,128
     ed0:	0505                	addi	a0,a0,1
     ed2:	0200                	addi	s0,sp,256
     ed4:	0104                	addi	s1,sp,128
     ed6:	06090003          	lb	zero,96(s2)
     eda:	0100                	addi	s0,sp,128
     edc:	0105                	addi	sp,sp,1
     ede:	08090903          	lb	s2,128(s2)
     ee2:	0100                	addi	s0,sp,128
     ee4:	0c090303          	lb	t1,192(s2)
     ee8:	0100                	addi	s0,sp,128
     eea:	0505                	addi	a0,a0,1
     eec:	12090203          	lb	tp,288(s2)
     ef0:	0100                	addi	s0,sp,128
     ef2:	0c090103          	lb	sp,192(s2)
     ef6:	0100                	addi	s0,sp,128
     ef8:	10090103          	lb	sp,256(s2)
     efc:	0100                	addi	s0,sp,128
     efe:	1005                	c.nop	-31
     f00:	0c090103          	lb	sp,192(s2)
     f04:	0100                	addi	s0,sp,128
     f06:	1c05                	addi	s8,s8,-31
     f08:	0a090003          	lb	zero,160(s2)
     f0c:	0100                	addi	s0,sp,128
     f0e:	1305                	addi	t1,t1,-31
     f10:	0e090103          	lb	sp,224(s2)
     f14:	0100                	addi	s0,sp,128
     f16:	2c05                	addiw	s8,s8,1
     f18:	0a090003          	lb	zero,160(s2)
     f1c:	0100                	addi	s0,sp,128
     f1e:	0705                	addi	a4,a4,1
     f20:	0a090003          	lb	zero,160(s2)
     f24:	0100                	addi	s0,sp,128
     f26:	0905                	addi	s2,s2,1
     f28:	04090203          	lb	tp,64(s2)
     f2c:	0100                	addi	s0,sp,128
     f2e:	0c090103          	lb	sp,192(s2)
     f32:	0100                	addi	s0,sp,128
     f34:	3b05                	addiw	s6,s6,-31
     f36:	10090203          	lb	tp,256(s2)
     f3a:	0100                	addi	s0,sp,128
     f3c:	0f05                	addi	t5,t5,1
     f3e:	0a090003          	lb	zero,160(s2)
     f42:	0100                	addi	s0,sp,128
     f44:	0505                	addi	a0,a0,1
     f46:	14090103          	lb	sp,320(s2)
     f4a:	0100                	addi	s0,sp,128
     f4c:	4c05                	li	s8,1
     f4e:	04090103          	lb	sp,64(s2)
     f52:	0100                	addi	s0,sp,128
     f54:	2605                	addiw	a2,a2,1
     f56:	12090003          	lb	zero,288(s2)
     f5a:	0100                	addi	s0,sp,128
     f5c:	1305                	addi	t1,t1,-31
     f5e:	10090103          	lb	sp,256(s2)
     f62:	0100                	addi	s0,sp,128
     f64:	0505                	addi	a0,a0,1
     f66:	30090203          	lb	tp,768(s2)
     f6a:	0100                	addi	s0,sp,128
     f6c:	0105                	addi	sp,sp,1
     f6e:	0a090103          	lb	sp,160(s2)
     f72:	0100                	addi	s0,sp,128
     f74:	14090303          	lb	t1,320(s2)
     f78:	0100                	addi	s0,sp,128
     f7a:	3b05                	addiw	s6,s6,-31
     f7c:	12090103          	lb	sp,288(s2)
     f80:	0100                	addi	s0,sp,128
     f82:	0f05                	addi	t5,t5,1
     f84:	0a090003          	lb	zero,160(s2)
     f88:	0100                	addi	s0,sp,128
     f8a:	7405                	lui	s0,0xfffe1
     f8c:	14090103          	lb	sp,320(s2)
     f90:	0100                	addi	s0,sp,128
     f92:	6805                	lui	a6,0x1
     f94:	0a090003          	lb	zero,160(s2)
     f98:	0100                	addi	s0,sp,128
     f9a:	4c05                	li	s8,1
     f9c:	0e090003          	lb	zero,224(s2)
     fa0:	0100                	addi	s0,sp,128
     fa2:	2605                	addiw	a2,a2,1
     fa4:	08090003          	lb	zero,128(s2)
     fa8:	0100                	addi	s0,sp,128
     faa:	1305                	addi	t1,t1,-31
     fac:	10090103          	lb	sp,256(s2)
     fb0:	0100                	addi	s0,sp,128
     fb2:	0505                	addi	a0,a0,1
     fb4:	30090103          	lb	sp,768(s2)
     fb8:	0100                	addi	s0,sp,128
     fba:	0105                	addi	sp,sp,1
     fbc:	0a090103          	lb	sp,160(s2)
     fc0:	0100                	addi	s0,sp,128
     fc2:	14090403          	lb	s0,320(s2)
     fc6:	0100                	addi	s0,sp,128
     fc8:	0e05                	addi	t3,t3,1
     fca:	08090303          	lb	t1,128(s2)
     fce:	0100                	addi	s0,sp,128
     fd0:	0505                	addi	a0,a0,1
     fd2:	0e090103          	lb	sp,224(s2)
     fd6:	0100                	addi	s0,sp,128
     fd8:	1305                	addi	t1,t1,-31
     fda:	04090103          	lb	sp,64(s2)
     fde:	0100                	addi	s0,sp,128
     fe0:	0505                	addi	a0,a0,1
     fe2:	04090003          	lb	zero,64(s2)
     fe6:	0100                	addi	s0,sp,128
     fe8:	2d05                	addiw	s10,s10,1
     fea:	0200                	addi	s0,sp,256
     fec:	0304                	addi	s1,sp,384
     fee:	02090203          	lb	tp,32(s2)
     ff2:	0100                	addi	s0,sp,128
     ff4:	2905                	addiw	s2,s2,1
     ff6:	0200                	addi	s0,sp,256
     ff8:	0304                	addi	s1,sp,384
     ffa:	06090003          	lb	zero,96(s2)
     ffe:	0100                	addi	s0,sp,128
    1000:	1205                	addi	tp,tp,-31
    1002:	0200                	addi	s0,sp,256
    1004:	0304                	addi	s1,sp,384
    1006:	02090003          	lb	zero,32(s2)
    100a:	0100                	addi	s0,sp,128
    100c:	2705                	addiw	a4,a4,1
    100e:	0200                	addi	s0,sp,256
    1010:	0304                	addi	s1,sp,384
    1012:	12090103          	lb	sp,288(s2)
    1016:	0100                	addi	s0,sp,128
    1018:	1205                	addi	tp,tp,-31
    101a:	0200                	addi	s0,sp,256
    101c:	0304                	addi	s1,sp,384
    101e:	08090003          	lb	zero,128(s2)
    1022:	0100                	addi	s0,sp,128
    1024:	0200                	addi	s0,sp,256
    1026:	0304                	addi	s1,sp,384
    1028:	12090103          	lb	sp,288(s2)
    102c:	0100                	addi	s0,sp,128
    102e:	1505                	addi	a0,a0,-31
    1030:	0200                	addi	s0,sp,256
    1032:	0304                	addi	s1,sp,384
    1034:	10090103          	lb	sp,256(s2)
    1038:	0100                	addi	s0,sp,128
    103a:	2e05                	addiw	t3,t3,1
    103c:	0200                	addi	s0,sp,256
    103e:	0304                	addi	s1,sp,384
    1040:	08090103          	lb	sp,128(s2)
    1044:	0100                	addi	s0,sp,128
    1046:	0f05                	addi	t5,t5,1
    1048:	0200                	addi	s0,sp,256
    104a:	0304                	addi	s1,sp,384
    104c:	0e090003          	lb	zero,224(s2)
    1050:	0100                	addi	s0,sp,128
    1052:	0905                	addi	s2,s2,1
    1054:	0200                	addi	s0,sp,256
    1056:	0304                	addi	s1,sp,384
    1058:	04090203          	lb	tp,64(s2)
    105c:	0100                	addi	s0,sp,128
    105e:	0200                	addi	s0,sp,256
    1060:	0304                	addi	s1,sp,384
    1062:	0c090103          	lb	sp,192(s2)
    1066:	0100                	addi	s0,sp,128
    1068:	0200                	addi	s0,sp,256
    106a:	0304                	addi	s1,sp,384
    106c:	08090103          	lb	sp,128(s2)
    1070:	0100                	addi	s0,sp,128
    1072:	0200                	addi	s0,sp,256
    1074:	0304                	addi	s1,sp,384
    1076:	0c090103          	lb	sp,192(s2)
    107a:	0100                	addi	s0,sp,128
    107c:	0200                	addi	s0,sp,256
    107e:	0304                	addi	s1,sp,384
    1080:	08090103          	lb	sp,128(s2)
    1084:	0100                	addi	s0,sp,128
    1086:	0200                	addi	s0,sp,256
    1088:	0304                	addi	s1,sp,384
    108a:	0c090303          	lb	t1,192(s2)
    108e:	0100                	addi	s0,sp,128
    1090:	0200                	addi	s0,sp,256
    1092:	0304                	addi	s1,sp,384
    1094:	0e090103          	lb	sp,224(s2)
    1098:	0100                	addi	s0,sp,128
    109a:	0200                	addi	s0,sp,256
    109c:	0304                	addi	s1,sp,384
    109e:	14090203          	lb	tp,320(s2)
    10a2:	0100                	addi	s0,sp,128
    10a4:	2805                	addiw	a6,a6,1
    10a6:	0200                	addi	s0,sp,256
    10a8:	0304                	addi	s1,sp,384
    10aa:	04096e03          	lwu	t3,64(s2)
    10ae:	0100                	addi	s0,sp,128
    10b0:	0505                	addi	a0,a0,1
    10b2:	0200                	addi	s0,sp,256
    10b4:	0104                	addi	s1,sp,128
    10b6:	0a090003          	lb	zero,160(s2)
    10ba:	0100                	addi	s0,sp,128
    10bc:	0105                	addi	sp,sp,1
    10be:	0c091403          	lh	s0,192(s2)
    10c2:	0100                	addi	s0,sp,128
    10c4:	0c09                	addi	s8,s8,2
    10c6:	0000                	unimp
    10c8:	0101                	addi	sp,sp,0
    10ca:	01d0                	addi	a2,sp,196
    10cc:	0000                	unimp
    10ce:	00900003          	lb	zero,9(zero) # 9 <n-0x3>
    10d2:	0000                	unimp
    10d4:	0101                	addi	sp,sp,0
    10d6:	000d0efb          	0xd0efb
    10da:	0101                	addi	sp,sp,0
    10dc:	0101                	addi	sp,sp,0
    10de:	0000                	unimp
    10e0:	0100                	addi	s0,sp,128
    10e2:	0000                	unimp
    10e4:	6b01                	0x6b01
    10e6:	7265                	lui	tp,0xffff9
    10e8:	656e                	ld	a0,216(sp)
    10ea:	2f6c                	fld	fa1,216(a4)
    10ec:	6162                	ld	sp,24(sp)
    10ee:	6374                	ld	a3,192(a4)
    10f0:	2f68                	fld	fa0,216(a4)
    10f2:	63617473          	csrrci	s0,0x636,2
    10f6:	656b006b          	0x656b006b
    10fa:	6e72                	ld	t3,280(sp)
    10fc:	6c65                	lui	s8,0x19
    10fe:	6f6c672f          	0x6f6c672f
    1102:	6c62                	ld	s8,24(sp)
    1104:	0065                	c.nop	25
    1106:	6e72656b          	0x6e72656b
    110a:	6c65                	lui	s8,0x19
    110c:	7461622f          	0x7461622f
    1110:	632f6863          	bltu	t5,s2,1740 <n+0x1720>
    1114:	65746e6f          	jal	t3,47f6a <n+0x47f4a>
    1118:	7478                	ld	a4,232(s0)
    111a:	6b00                	ld	s0,16(a4)
    111c:	7265                	lui	tp,0xffff9
    111e:	656e                	ld	a0,216(sp)
    1120:	2f6c                	fld	fa1,216(a4)
    1122:	6162                	ld	sp,24(sp)
    1124:	6374                	ld	a3,192(a4)
    1126:	0068                	addi	a0,sp,12
    1128:	7300                	ld	s0,32(a4)
    112a:	6174                	ld	a3,192(a0)
    112c:	632e6b63          	bltu	t3,s2,1762 <n+0x1742>
    1130:	0100                	addi	s0,sp,128
    1132:	0000                	unimp
    1134:	69647473          	csrrci	s0,0x696,8
    1138:	746e                	ld	s0,248(sp)
    113a:	682e                	ld	a6,200(sp)
    113c:	0200                	addi	s0,sp,256
    113e:	0000                	unimp
    1140:	746e6f63          	bltu	t3,t1,189e <n+0x187e>
    1144:	7865                	lui	a6,0xffff9
    1146:	2e74                	fld	fa3,216(a2)
    1148:	0068                	addi	a0,sp,12
    114a:	62000003          	lb	zero,1568(zero) # 620 <n+0x600>
    114e:	7461                	lui	s0,0xffff8
    1150:	682e6863          	bltu	t3,sp,17e0 <n+0x17c0>
    1154:	0400                	addi	s0,sp,512
    1156:	0000                	unimp
    1158:	63617473          	csrrci	s0,0x636,2
    115c:	00682e6b          	0x682e6b
    1160:	0001                	nop
    1162:	0000                	unimp
    1164:	0105                	addi	sp,sp,1
    1166:	0900                	addi	s0,sp,144
    1168:	6602                	ld	a2,0(sp)
    116a:	2010                	fld	fa2,0(s0)
    116c:	0080                	addi	s0,sp,64
    116e:	0000                	unimp
    1170:	0300                	addi	s0,sp,384
    1172:	010c                	addi	a1,sp,128
    1174:	1405                	addi	s0,s0,-31
    1176:	0c090103          	lb	sp,192(s2)
    117a:	0100                	addi	s0,sp,128
    117c:	0505                	addi	a0,a0,1
    117e:	08090003          	lb	zero,128(s2)
    1182:	0100                	addi	s0,sp,128
    1184:	0105                	addi	sp,sp,1
    1186:	0a090103          	lb	sp,160(s2)
    118a:	0100                	addi	s0,sp,128
    118c:	0a090303          	lb	t1,160(s2)
    1190:	0100                	addi	s0,sp,128
    1192:	1405                	addi	s0,s0,-31
    1194:	0c090103          	lb	sp,192(s2)
    1198:	0100                	addi	s0,sp,128
    119a:	0505                	addi	a0,a0,1
    119c:	08090003          	lb	zero,128(s2)
    11a0:	0100                	addi	s0,sp,128
    11a2:	0105                	addi	sp,sp,1
    11a4:	0a090103          	lb	sp,160(s2)
    11a8:	0100                	addi	s0,sp,128
    11aa:	3205                	addiw	tp,tp,-31
    11ac:	0a090303          	lb	t1,160(s2)
    11b0:	0100                	addi	s0,sp,128
    11b2:	1605                	addi	a2,a2,-31
    11b4:	0a090103          	lb	sp,160(s2)
    11b8:	0100                	addi	s0,sp,128
    11ba:	0c05                	addi	s8,s8,1
    11bc:	12090003          	lb	zero,288(s2)
    11c0:	0100                	addi	s0,sp,128
    11c2:	2c05                	addiw	s8,s8,1
    11c4:	02090003          	lb	zero,32(s2)
    11c8:	0100                	addi	s0,sp,128
    11ca:	0105                	addi	sp,sp,1
    11cc:	04090103          	lb	sp,64(s2)
    11d0:	0100                	addi	s0,sp,128
    11d2:	3005                	0x3005
    11d4:	08090303          	lb	t1,128(s2)
    11d8:	0100                	addi	s0,sp,128
    11da:	1605                	addi	a2,a2,-31
    11dc:	0a090103          	lb	sp,160(s2)
    11e0:	0100                	addi	s0,sp,128
    11e2:	0c05                	addi	s8,s8,1
    11e4:	12090003          	lb	zero,288(s2)
    11e8:	0100                	addi	s0,sp,128
    11ea:	2a05                	addiw	s4,s4,1
    11ec:	02090003          	lb	zero,32(s2)
    11f0:	0100                	addi	s0,sp,128
    11f2:	0105                	addi	sp,sp,1
    11f4:	04090103          	lb	sp,64(s2)
    11f8:	0100                	addi	s0,sp,128
    11fa:	08090403          	lb	s0,128(s2)
    11fe:	0100                	addi	s0,sp,128
    1200:	1905                	addi	s2,s2,-31
    1202:	0e090103          	lb	sp,224(s2)
    1206:	0100                	addi	s0,sp,128
    1208:	0e05                	addi	t3,t3,1
    120a:	12090003          	lb	zero,288(s2)
    120e:	0100                	addi	s0,sp,128
    1210:	08090103          	lb	sp,128(s2)
    1214:	0100                	addi	s0,sp,128
    1216:	2605                	addiw	a2,a2,1
    1218:	0c090103          	lb	sp,192(s2)
    121c:	0100                	addi	s0,sp,128
    121e:	0c05                	addi	s8,s8,1
    1220:	16090103          	lb	sp,352(s2)
    1224:	0100                	addi	s0,sp,128
    1226:	0105                	addi	sp,sp,1
    1228:	04090103          	lb	sp,64(s2)
    122c:	0100                	addi	s0,sp,128
    122e:	0a090303          	lb	t1,160(s2)
    1232:	0100                	addi	s0,sp,128
    1234:	1905                	addi	s2,s2,-31
    1236:	0e090103          	lb	sp,224(s2)
    123a:	0100                	addi	s0,sp,128
    123c:	0e05                	addi	t3,t3,1
    123e:	12090003          	lb	zero,288(s2)
    1242:	0100                	addi	s0,sp,128
    1244:	08090103          	lb	sp,128(s2)
    1248:	0100                	addi	s0,sp,128
    124a:	2605                	addiw	a2,a2,1
    124c:	0c090103          	lb	sp,192(s2)
    1250:	0100                	addi	s0,sp,128
    1252:	0c05                	addi	s8,s8,1
    1254:	16090103          	lb	sp,352(s2)
    1258:	0100                	addi	s0,sp,128
    125a:	0105                	addi	sp,sp,1
    125c:	04090103          	lb	sp,64(s2)
    1260:	0100                	addi	s0,sp,128
    1262:	0a090403          	lb	s0,160(s2)
    1266:	0100                	addi	s0,sp,128
    1268:	2105                	addiw	sp,sp,1
    126a:	0e090103          	lb	sp,224(s2)
    126e:	0100                	addi	s0,sp,128
    1270:	5605                	li	a2,-31
    1272:	14090003          	lb	zero,320(s2)
    1276:	0100                	addi	s0,sp,128
    1278:	2105                	addiw	sp,sp,1
    127a:	0a090003          	lb	zero,160(s2)
    127e:	0100                	addi	s0,sp,128
    1280:	1d05                	addi	s10,s10,-31
    1282:	0e090103          	lb	sp,224(s2)
    1286:	0100                	addi	s0,sp,128
    1288:	0c05                	addi	s8,s8,1
    128a:	0c090103          	lb	sp,192(s2)
    128e:	0100                	addi	s0,sp,128
    1290:	0105                	addi	sp,sp,1
    1292:	04090103          	lb	sp,64(s2)
    1296:	0100                	addi	s0,sp,128
    1298:	0c09                	addi	s8,s8,2
    129a:	0000                	unimp
    129c:	0101                	addi	sp,sp,0
    129e:	0146                	slli	sp,sp,0x11
    12a0:	0000                	unimp
    12a2:	005c0003          	lb	zero,5(s8) # 19005 <n+0x18fe5>
    12a6:	0000                	unimp
    12a8:	0101                	addi	sp,sp,0
    12aa:	000d0efb          	0xd0efb
    12ae:	0101                	addi	sp,sp,0
    12b0:	0101                	addi	sp,sp,0
    12b2:	0000                	unimp
    12b4:	0100                	addi	s0,sp,128
    12b6:	0000                	unimp
    12b8:	6b01                	0x6b01
    12ba:	7265                	lui	tp,0xffff9
    12bc:	656e                	ld	a0,216(sp)
    12be:	2f6c                	fld	fa1,216(a4)
    12c0:	6162                	ld	sp,24(sp)
    12c2:	6374                	ld	a3,192(a4)
    12c4:	2f68                	fld	fa0,216(a4)
    12c6:	746e6f63          	bltu	t3,t1,1a24 <n+0x1a04>
    12ca:	7865                	lui	a6,0xffff9
    12cc:	0074                	addi	a3,sp,12
    12ce:	6e72656b          	0x6e72656b
    12d2:	6c65                	lui	s8,0x19
    12d4:	6f6c672f          	0x6f6c672f
    12d8:	6c62                	ld	s8,24(sp)
    12da:	0065                	c.nop	25
    12dc:	6300                	ld	s0,0(a4)
    12de:	65746e6f          	jal	t3,48134 <n+0x48114>
    12e2:	7478                	ld	a4,232(s0)
    12e4:	632e                	ld	t1,200(sp)
    12e6:	0100                	addi	s0,sp,128
    12e8:	0000                	unimp
    12ea:	746e6f63          	bltu	t3,t1,1a48 <n+0x1a28>
    12ee:	7865                	lui	a6,0xffff9
    12f0:	2e74                	fld	fa3,216(a2)
    12f2:	0068                	addi	a0,sp,12
    12f4:	0001                	nop
    12f6:	7300                	ld	s0,32(a4)
    12f8:	6474                	ld	a3,200(s0)
    12fa:	6e69                	lui	t3,0x1a
    12fc:	2e74                	fld	fa3,216(a2)
    12fe:	0068                	addi	a0,sp,12
    1300:	0002                	c.slli64	zero
    1302:	0000                	unimp
    1304:	0105                	addi	sp,sp,1
    1306:	0900                	addi	s0,sp,144
    1308:	1002                	c.slli	zero,0x20
    130a:	2012                	fld	ft0,256(sp)
    130c:	0080                	addi	s0,sp,64
    130e:	0000                	unimp
    1310:	1600                	addi	s0,sp,800
    1312:	0e05                	addi	t3,t3,1
    1314:	0a090103          	lb	sp,160(s2)
    1318:	0100                	addi	s0,sp,128
    131a:	08090103          	lb	sp,128(s2)
    131e:	0100                	addi	s0,sp,128
    1320:	1105                	addi	sp,sp,-31
    1322:	06090003          	lb	zero,96(s2)
    1326:	0100                	addi	s0,sp,128
    1328:	0e05                	addi	t3,t3,1
    132a:	08090003          	lb	zero,128(s2)
    132e:	0100                	addi	s0,sp,128
    1330:	0105                	addi	sp,sp,1
    1332:	08090103          	lb	sp,128(s2)
    1336:	0100                	addi	s0,sp,128
    1338:	1d05                	addi	s10,s10,-31
    133a:	08090303          	lb	t1,128(s2)
    133e:	0100                	addi	s0,sp,128
    1340:	0c05                	addi	s8,s8,1
    1342:	06090103          	lb	sp,96(s2)
    1346:	0100                	addi	s0,sp,128
    1348:	0105                	addi	sp,sp,1
    134a:	0c090103          	lb	sp,192(s2)
    134e:	0100                	addi	s0,sp,128
    1350:	3305                	addiw	t1,t1,-31
    1352:	08090303          	lb	t1,128(s2)
    1356:	0100                	addi	s0,sp,128
    1358:	0f05                	addi	t5,t5,1
    135a:	0e090103          	lb	sp,224(s2)
    135e:	0100                	addi	s0,sp,128
    1360:	0105                	addi	sp,sp,1
    1362:	0a090103          	lb	sp,160(s2)
    1366:	0100                	addi	s0,sp,128
    1368:	08090403          	lb	s0,128(s2)
    136c:	0100                	addi	s0,sp,128
    136e:	1805                	addi	a6,a6,-31
    1370:	14090203          	lb	tp,320(s2)
    1374:	0100                	addi	s0,sp,128
    1376:	0e05                	addi	t3,t3,1
    1378:	06090003          	lb	zero,96(s2)
    137c:	0100                	addi	s0,sp,128
    137e:	0505                	addi	a0,a0,1
    1380:	04090103          	lb	sp,64(s2)
    1384:	0100                	addi	s0,sp,128
    1386:	1105                	addi	sp,sp,-31
    1388:	0a090103          	lb	sp,160(s2)
    138c:	0100                	addi	s0,sp,128
    138e:	0e05                	addi	t3,t3,1
    1390:	08090103          	lb	sp,128(s2)
    1394:	0100                	addi	s0,sp,128
    1396:	0505                	addi	a0,a0,1
    1398:	08090103          	lb	sp,128(s2)
    139c:	0100                	addi	s0,sp,128
    139e:	0d05                	addi	s10,s10,1
    13a0:	0e090203          	lb	tp,224(s2)
    13a4:	0100                	addi	s0,sp,128
    13a6:	0505                	addi	a0,a0,1
    13a8:	04090003          	lb	zero,64(s2)
    13ac:	0100                	addi	s0,sp,128
    13ae:	1205                	addi	tp,tp,-31
    13b0:	0200                	addi	s0,sp,256
    13b2:	0304                	addi	s1,sp,384
    13b4:	02090203          	lb	tp,32(s2)
    13b8:	0100                	addi	s0,sp,128
    13ba:	1d05                	addi	s10,s10,-31
    13bc:	0200                	addi	s0,sp,256
    13be:	0304                	addi	s1,sp,384
    13c0:	10097e03          	0x10097e03
    13c4:	0100                	addi	s0,sp,128
    13c6:	0505                	addi	a0,a0,1
    13c8:	0200                	addi	s0,sp,256
    13ca:	0104                	addi	s1,sp,128
    13cc:	0a090003          	lb	zero,160(s2)
    13d0:	0100                	addi	s0,sp,128
    13d2:	0c05                	addi	s8,s8,1
    13d4:	0e090403          	lb	s0,224(s2)
    13d8:	0100                	addi	s0,sp,128
    13da:	0105                	addi	sp,sp,1
    13dc:	18090103          	lb	sp,384(s2)
    13e0:	0100                	addi	s0,sp,128
    13e2:	0c09                	addi	s8,s8,2
    13e4:	0000                	unimp
    13e6:	0101                	addi	sp,sp,0
    13e8:	034a                	slli	t1,t1,0x12
    13ea:	0000                	unimp
    13ec:	00a00003          	lb	zero,10(zero) # a <n-0x2>
    13f0:	0000                	unimp
    13f2:	0101                	addi	sp,sp,0
    13f4:	000d0efb          	0xd0efb
    13f8:	0101                	addi	sp,sp,0
    13fa:	0101                	addi	sp,sp,0
    13fc:	0000                	unimp
    13fe:	0100                	addi	s0,sp,128
    1400:	0000                	unimp
    1402:	6b01                	0x6b01
    1404:	7265                	lui	tp,0xffff9
    1406:	656e                	ld	a0,216(sp)
    1408:	2f6c                	fld	fa1,216(a4)
    140a:	7274                	ld	a3,224(a2)
    140c:	7061                	c.lui	zero,0xffff8
    140e:	6b00                	ld	s0,16(a4)
    1410:	7265                	lui	tp,0xffff9
    1412:	656e                	ld	a0,216(sp)
    1414:	2f6c                	fld	fa1,216(a4)
    1416:	626f6c67          	0x626f6c67
    141a:	656c                	ld	a1,200(a0)
    141c:	6b00                	ld	s0,16(a4)
    141e:	7265                	lui	tp,0xffff9
    1420:	656e                	ld	a0,216(sp)
    1422:	2f6c                	fld	fa1,216(a4)
    1424:	6162                	ld	sp,24(sp)
    1426:	6374                	ld	a3,192(a4)
    1428:	2f68                	fld	fa0,216(a4)
    142a:	746e6f63          	bltu	t3,t1,1b88 <n+0x1b68>
    142e:	7865                	lui	a6,0xffff9
    1430:	0074                	addi	a3,sp,12
    1432:	6e72656b          	0x6e72656b
    1436:	6c65                	lui	s8,0x19
    1438:	6172742f          	0x6172742f
    143c:	2f70                	fld	fa2,216(a4)
    143e:	6974                	ld	a3,208(a0)
    1440:	656d                	lui	a0,0x1b
    1442:	0072                	c.slli	zero,0x1c
    1444:	6e72656b          	0x6e72656b
    1448:	6c65                	lui	s8,0x19
    144a:	7461622f          	0x7461622f
    144e:	732f6863          	bltu	t5,s2,1b7e <n+0x1b5e>
    1452:	6174                	ld	a3,192(a0)
    1454:	00006b63          	bltu	zero,zero,146a <n+0x144a>
    1458:	7274                	ld	a3,224(a2)
    145a:	7061                	c.lui	zero,0xffff8
    145c:	632e                	ld	t1,200(sp)
    145e:	0100                	addi	s0,sp,128
    1460:	0000                	unimp
    1462:	69647473          	csrrci	s0,0x696,8
    1466:	746e                	ld	s0,248(sp)
    1468:	682e                	ld	a6,200(sp)
    146a:	0200                	addi	s0,sp,256
    146c:	0000                	unimp
    146e:	746e6f63          	bltu	t3,t1,1bcc <n+0x1bac>
    1472:	7865                	lui	a6,0xffff9
    1474:	2e74                	fld	fa3,216(a2)
    1476:	0068                	addi	a0,sp,12
    1478:	74000003          	lb	zero,1856(zero) # 740 <n+0x720>
    147c:	6d69                	lui	s10,0x1a
    147e:	7265                	lui	tp,0xffff9
    1480:	682e                	ld	a6,200(sp)
    1482:	0400                	addi	s0,sp,512
    1484:	0000                	unimp
    1486:	63617473          	csrrci	s0,0x636,2
    148a:	00682e6b          	0x682e6b
    148e:	0005                	c.nop	1
    1490:	0000                	unimp
    1492:	0105                	addi	sp,sp,1
    1494:	0900                	addi	s0,sp,144
    1496:	1202                	slli	tp,tp,0x20
    1498:	00802013          	slti	zero,zero,8
    149c:	0000                	unimp
    149e:	0300                	addi	s0,sp,384
    14a0:	010e                	slli	sp,sp,0x3
    14a2:	0505                	addi	a0,a0,1
    14a4:	08090103          	lb	sp,128(s2)
    14a8:	0100                	addi	s0,sp,128
    14aa:	1205                	addi	tp,tp,-31
    14ac:	0c090103          	lb	sp,192(s2)
    14b0:	0100                	addi	s0,sp,128
    14b2:	0505                	addi	a0,a0,1
    14b4:	0c090003          	lb	zero,192(s2)
    14b8:	0100                	addi	s0,sp,128
    14ba:	06090103          	lb	sp,96(s2)
    14be:	0100                	addi	s0,sp,128
    14c0:	0105                	addi	sp,sp,1
    14c2:	0c090103          	lb	sp,192(s2)
    14c6:	0100                	addi	s0,sp,128
    14c8:	0a090303          	lb	t1,160(s2)
    14cc:	0100                	addi	s0,sp,128
    14ce:	0505                	addi	a0,a0,1
    14d0:	08090103          	lb	sp,128(s2)
    14d4:	0100                	addi	s0,sp,128
    14d6:	0e05                	addi	t3,t3,1
    14d8:	0c090103          	lb	sp,192(s2)
    14dc:	0100                	addi	s0,sp,128
    14de:	0505                	addi	a0,a0,1
    14e0:	0c090203          	lb	tp,192(s2)
    14e4:	0100                	addi	s0,sp,128
    14e6:	0e05                	addi	t3,t3,1
    14e8:	08090103          	lb	sp,128(s2)
    14ec:	0100                	addi	s0,sp,128
    14ee:	0505                	addi	a0,a0,1
    14f0:	08090103          	lb	sp,128(s2)
    14f4:	0100                	addi	s0,sp,128
    14f6:	1805                	addi	a6,a6,-31
    14f8:	08090103          	lb	sp,128(s2)
    14fc:	0100                	addi	s0,sp,128
    14fe:	0e05                	addi	t3,t3,1
    1500:	0c090003          	lb	zero,192(s2)
    1504:	0100                	addi	s0,sp,128
    1506:	0d05                	addi	s10,s10,1
    1508:	04090103          	lb	sp,64(s2)
    150c:	0100                	addi	s0,sp,128
    150e:	0505                	addi	a0,a0,1
    1510:	0c090103          	lb	sp,192(s2)
    1514:	0100                	addi	s0,sp,128
    1516:	1405                	addi	s0,s0,-31
    1518:	08090103          	lb	sp,128(s2)
    151c:	0100                	addi	s0,sp,128
    151e:	0e05                	addi	t3,t3,1
    1520:	0c090003          	lb	zero,192(s2)
    1524:	0100                	addi	s0,sp,128
    1526:	0905                	addi	s2,s2,1
    1528:	04090103          	lb	sp,64(s2)
    152c:	0100                	addi	s0,sp,128
    152e:	0505                	addi	a0,a0,1
    1530:	0c090103          	lb	sp,192(s2)
    1534:	0100                	addi	s0,sp,128
    1536:	08090103          	lb	sp,128(s2)
    153a:	0100                	addi	s0,sp,128
    153c:	0105                	addi	sp,sp,1
    153e:	0c090103          	lb	sp,192(s2)
    1542:	0100                	addi	s0,sp,128
    1544:	0a090303          	lb	t1,160(s2)
    1548:	0100                	addi	s0,sp,128
    154a:	1705                	addi	a4,a4,-31
    154c:	0c090203          	lb	tp,192(s2)
    1550:	0100                	addi	s0,sp,128
    1552:	0e05                	addi	t3,t3,1
    1554:	0c090003          	lb	zero,192(s2)
    1558:	0100                	addi	s0,sp,128
    155a:	0505                	addi	a0,a0,1
    155c:	04090303          	lb	t1,64(s2)
    1560:	0100                	addi	s0,sp,128
    1562:	0d05                	addi	s10,s10,1
    1564:	48090303          	lb	t1,1152(s2)
    1568:	0100                	addi	s0,sp,128
    156a:	0c090103          	lb	sp,192(s2)
    156e:	0100                	addi	s0,sp,128
    1570:	04090103          	lb	sp,64(s2)
    1574:	0100                	addi	s0,sp,128
    1576:	06090103          	lb	sp,96(s2)
    157a:	0100                	addi	s0,sp,128
    157c:	02090203          	lb	tp,32(s2)
    1580:	0100                	addi	s0,sp,128
    1582:	04090103          	lb	sp,64(s2)
    1586:	0100                	addi	s0,sp,128
    1588:	0c090103          	lb	sp,192(s2)
    158c:	0100                	addi	s0,sp,128
    158e:	06090103          	lb	sp,96(s2)
    1592:	0100                	addi	s0,sp,128
    1594:	02090203          	lb	tp,32(s2)
    1598:	0100                	addi	s0,sp,128
    159a:	0c090103          	lb	sp,192(s2)
    159e:	0100                	addi	s0,sp,128
    15a0:	06090103          	lb	sp,96(s2)
    15a4:	0100                	addi	s0,sp,128
    15a6:	02090203          	lb	tp,32(s2)
    15aa:	0100                	addi	s0,sp,128
    15ac:	1605                	addi	a2,a2,-31
    15ae:	0c090203          	lb	tp,192(s2)
    15b2:	0100                	addi	s0,sp,128
    15b4:	0d05                	addi	s10,s10,1
    15b6:	14090203          	lb	tp,320(s2)
    15ba:	0100                	addi	s0,sp,128
    15bc:	02090203          	lb	tp,32(s2)
    15c0:	0100                	addi	s0,sp,128
    15c2:	0c090103          	lb	sp,192(s2)
    15c6:	0100                	addi	s0,sp,128
    15c8:	06090103          	lb	sp,96(s2)
    15cc:	0100                	addi	s0,sp,128
    15ce:	02090203          	lb	tp,32(s2)
    15d2:	0100                	addi	s0,sp,128
    15d4:	0c090103          	lb	sp,192(s2)
    15d8:	0100                	addi	s0,sp,128
    15da:	06090103          	lb	sp,96(s2)
    15de:	0100                	addi	s0,sp,128
    15e0:	02090203          	lb	tp,32(s2)
    15e4:	0100                	addi	s0,sp,128
    15e6:	0c090103          	lb	sp,192(s2)
    15ea:	0100                	addi	s0,sp,128
    15ec:	06090103          	lb	sp,96(s2)
    15f0:	0100                	addi	s0,sp,128
    15f2:	02090203          	lb	tp,32(s2)
    15f6:	0100                	addi	s0,sp,128
    15f8:	0c090103          	lb	sp,192(s2)
    15fc:	0100                	addi	s0,sp,128
    15fe:	1605                	addi	a2,a2,-31
    1600:	06090103          	lb	sp,96(s2)
    1604:	0100                	addi	s0,sp,128
    1606:	1205                	addi	tp,tp,-31
    1608:	0e090103          	lb	sp,224(s2)
    160c:	0100                	addi	s0,sp,128
    160e:	1605                	addi	a2,a2,-31
    1610:	0200                	addi	s0,sp,256
    1612:	0104                	addi	s1,sp,128
    1614:	02090003          	lb	zero,32(s2)
    1618:	0100                	addi	s0,sp,128
    161a:	1205                	addi	tp,tp,-31
    161c:	0200                	addi	s0,sp,256
    161e:	0104                	addi	s1,sp,128
    1620:	0c090003          	lb	zero,192(s2)
    1624:	0100                	addi	s0,sp,128
    1626:	0d05                	addi	s10,s10,1
    1628:	02090203          	lb	tp,32(s2)
    162c:	0100                	addi	s0,sp,128
    162e:	1605                	addi	a2,a2,-31
    1630:	02090203          	lb	tp,32(s2)
    1634:	0100                	addi	s0,sp,128
    1636:	2605                	addiw	a2,a2,1
    1638:	14090103          	lb	sp,320(s2)
    163c:	0100                	addi	s0,sp,128
    163e:	1605                	addi	a2,a2,-31
    1640:	06090003          	lb	zero,96(s2)
    1644:	0100                	addi	s0,sp,128
    1646:	3105                	addiw	sp,sp,-31
    1648:	04090003          	lb	zero,64(s2)
    164c:	0100                	addi	s0,sp,128
    164e:	1605                	addi	a2,a2,-31
    1650:	06090003          	lb	zero,96(s2)
    1654:	0100                	addi	s0,sp,128
    1656:	3c05                	addiw	s8,s8,-31
    1658:	04090003          	lb	zero,64(s2)
    165c:	0100                	addi	s0,sp,128
    165e:	1605                	addi	a2,a2,-31
    1660:	06090003          	lb	zero,96(s2)
    1664:	0100                	addi	s0,sp,128
    1666:	1905                	addi	s2,s2,-31
    1668:	04090103          	lb	sp,64(s2)
    166c:	0100                	addi	s0,sp,128
    166e:	1705                	addi	a4,a4,-31
    1670:	16090003          	lb	zero,352(s2)
    1674:	0100                	addi	s0,sp,128
    1676:	0d05                	addi	s10,s10,1
    1678:	06090603          	lb	a2,96(s2)
    167c:	0100                	addi	s0,sp,128
    167e:	02090203          	lb	tp,32(s2)
    1682:	0100                	addi	s0,sp,128
    1684:	1605                	addi	a2,a2,-31
    1686:	0c090103          	lb	sp,192(s2)
    168a:	0100                	addi	s0,sp,128
    168c:	1205                	addi	tp,tp,-31
    168e:	0e090103          	lb	sp,224(s2)
    1692:	0100                	addi	s0,sp,128
    1694:	1705                	addi	a4,a4,-31
    1696:	0200                	addi	s0,sp,256
    1698:	0104                	addi	s1,sp,128
    169a:	02090003          	lb	zero,32(s2)
    169e:	0100                	addi	s0,sp,128
    16a0:	1205                	addi	tp,tp,-31
    16a2:	0200                	addi	s0,sp,256
    16a4:	0104                	addi	s1,sp,128
    16a6:	0c090003          	lb	zero,192(s2)
    16aa:	0100                	addi	s0,sp,128
    16ac:	0d05                	addi	s10,s10,1
    16ae:	02090103          	lb	sp,32(s2)
    16b2:	0100                	addi	s0,sp,128
    16b4:	06090103          	lb	sp,96(s2)
    16b8:	0100                	addi	s0,sp,128
    16ba:	02090203          	lb	tp,32(s2)
    16be:	0100                	addi	s0,sp,128
    16c0:	0c090203          	lb	tp,192(s2)
    16c4:	0100                	addi	s0,sp,128
    16c6:	06090103          	lb	sp,96(s2)
    16ca:	0100                	addi	s0,sp,128
    16cc:	02090203          	lb	tp,32(s2)
    16d0:	0100                	addi	s0,sp,128
    16d2:	0c090103          	lb	sp,192(s2)
    16d6:	0100                	addi	s0,sp,128
    16d8:	06090103          	lb	sp,96(s2)
    16dc:	0100                	addi	s0,sp,128
    16de:	02090203          	lb	tp,32(s2)
    16e2:	0100                	addi	s0,sp,128
    16e4:	0c090103          	lb	sp,192(s2)
    16e8:	0100                	addi	s0,sp,128
    16ea:	06090103          	lb	sp,96(s2)
    16ee:	0100                	addi	s0,sp,128
    16f0:	02090203          	lb	tp,32(s2)
    16f4:	0100                	addi	s0,sp,128
    16f6:	0c090103          	lb	sp,192(s2)
    16fa:	0100                	addi	s0,sp,128
    16fc:	06090103          	lb	sp,96(s2)
    1700:	0100                	addi	s0,sp,128
    1702:	02090303          	lb	t1,32(s2)
    1706:	0100                	addi	s0,sp,128
    1708:	04090103          	lb	sp,64(s2)
    170c:	0100                	addi	s0,sp,128
    170e:	02090203          	lb	tp,32(s2)
    1712:	0100                	addi	s0,sp,128
    1714:	0c090103          	lb	sp,192(s2)
    1718:	0100                	addi	s0,sp,128
    171a:	08090103          	lb	sp,128(s2)
    171e:	0100                	addi	s0,sp,128
    1720:	0c05                	addi	s8,s8,1
    1722:	06090203          	lb	tp,96(s2)
    1726:	0100                	addi	s0,sp,128
    1728:	0105                	addi	sp,sp,1
    172a:	04090103          	lb	sp,64(s2)
    172e:	0100                	addi	s0,sp,128
    1730:	0a09                	addi	s4,s4,2
    1732:	0000                	unimp
    1734:	0101                	addi	sp,sp,0
    1736:	01a4                	addi	s1,sp,200
    1738:	0000                	unimp
    173a:	004e0003          	lb	zero,4(t3) # 1a004 <n+0x19fe4>
    173e:	0000                	unimp
    1740:	0101                	addi	sp,sp,0
    1742:	000d0efb          	0xd0efb
    1746:	0101                	addi	sp,sp,0
    1748:	0101                	addi	sp,sp,0
    174a:	0000                	unimp
    174c:	0100                	addi	s0,sp,128
    174e:	0000                	unimp
    1750:	6b01                	0x6b01
    1752:	7265                	lui	tp,0xffff9
    1754:	656e                	ld	a0,216(sp)
    1756:	2f6c                	fld	fa1,216(a4)
    1758:	7274                	ld	a3,224(a2)
    175a:	7061                	c.lui	zero,0xffff8
    175c:	7379732f          	0x7379732f
    1760:	6c6c6163          	bltu	s8,t1,1e22 <n+0x1e02>
    1764:	6b00                	ld	s0,16(a4)
    1766:	7265                	lui	tp,0xffff9
    1768:	656e                	ld	a0,216(sp)
    176a:	2f6c                	fld	fa1,216(a4)
    176c:	626f6c67          	0x626f6c67
    1770:	656c                	ld	a1,200(a0)
    1772:	0000                	unimp
    1774:	63737973          	csrrci	s2,0x637,6
    1778:	6c61                	lui	s8,0x18
    177a:	2e6c                	fld	fa1,216(a2)
    177c:	00010063          	beqz	sp,177c <n+0x175c>
    1780:	7300                	ld	s0,32(a4)
    1782:	6474                	ld	a3,200(s0)
    1784:	6e69                	lui	t3,0x1a
    1786:	2e74                	fld	fa3,216(a2)
    1788:	0068                	addi	a0,sp,12
    178a:	0002                	c.slli64	zero
    178c:	0000                	unimp
    178e:	0105                	addi	sp,sp,1
    1790:	0900                	addi	s0,sp,144
    1792:	1c02                	slli	s8,s8,0x20
    1794:	2016                	fld	ft0,320(sp)
    1796:	0080                	addi	s0,sp,64
    1798:	0000                	unimp
    179a:	0300                	addi	s0,sp,384
    179c:	0109                	addi	sp,sp,2
    179e:	0505                	addi	a0,a0,1
    17a0:	0e090103          	lb	sp,224(s2)
    17a4:	0100                	addi	s0,sp,128
    17a6:	0c090103          	lb	sp,192(s2)
    17aa:	0100                	addi	s0,sp,128
    17ac:	0a090103          	lb	sp,160(s2)
    17b0:	0100                	addi	s0,sp,128
    17b2:	0c05                	addi	s8,s8,1
    17b4:	0c090103          	lb	sp,192(s2)
    17b8:	0100                	addi	s0,sp,128
    17ba:	0105                	addi	sp,sp,1
    17bc:	04090103          	lb	sp,64(s2)
    17c0:	0100                	addi	s0,sp,128
    17c2:	0a090303          	lb	t1,160(s2)
    17c6:	0100                	addi	s0,sp,128
    17c8:	0705                	addi	a4,a4,1
    17ca:	14090103          	lb	sp,320(s2)
    17ce:	0100                	addi	s0,sp,128
    17d0:	0905                	addi	s2,s2,1
    17d2:	0a090303          	lb	t1,160(s2)
    17d6:	0100                	addi	s0,sp,128
    17d8:	08090103          	lb	sp,128(s2)
    17dc:	0100                	addi	s0,sp,128
    17de:	0200                	addi	s0,sp,256
    17e0:	0104                	addi	s1,sp,128
    17e2:	0e090303          	lb	t1,224(s2)
    17e6:	0100                	addi	s0,sp,128
    17e8:	0c05                	addi	s8,s8,1
    17ea:	0e090203          	lb	tp,224(s2)
    17ee:	0100                	addi	s0,sp,128
    17f0:	0105                	addi	sp,sp,1
    17f2:	04090103          	lb	sp,64(s2)
    17f6:	0100                	addi	s0,sp,128
    17f8:	0a090303          	lb	t1,160(s2)
    17fc:	0100                	addi	s0,sp,128
    17fe:	0505                	addi	a0,a0,1
    1800:	08090103          	lb	sp,128(s2)
    1804:	0100                	addi	s0,sp,128
    1806:	0c090103          	lb	sp,192(s2)
    180a:	0100                	addi	s0,sp,128
    180c:	0c05                	addi	s8,s8,1
    180e:	06090103          	lb	sp,96(s2)
    1812:	0100                	addi	s0,sp,128
    1814:	0105                	addi	sp,sp,1
    1816:	02090103          	lb	sp,32(s2)
    181a:	0100                	addi	s0,sp,128
    181c:	0a090303          	lb	t1,160(s2)
    1820:	0100                	addi	s0,sp,128
    1822:	0c05                	addi	s8,s8,1
    1824:	14090103          	lb	sp,320(s2)
    1828:	0100                	addi	s0,sp,128
    182a:	0105                	addi	sp,sp,1
    182c:	12090103          	lb	sp,288(s2)
    1830:	0100                	addi	s0,sp,128
    1832:	0a090303          	lb	t1,160(s2)
    1836:	0100                	addi	s0,sp,128
    1838:	0505                	addi	a0,a0,1
    183a:	0e090103          	lb	sp,224(s2)
    183e:	0100                	addi	s0,sp,128
    1840:	0105                	addi	sp,sp,1
    1842:	0a090103          	lb	sp,160(s2)
    1846:	0100                	addi	s0,sp,128
    1848:	0a090303          	lb	t1,160(s2)
    184c:	0100                	addi	s0,sp,128
    184e:	0c05                	addi	s8,s8,1
    1850:	08090103          	lb	sp,128(s2)
    1854:	0100                	addi	s0,sp,128
    1856:	0105                	addi	sp,sp,1
    1858:	06090103          	lb	sp,96(s2)
    185c:	0100                	addi	s0,sp,128
    185e:	0a090403          	lb	s0,160(s2)
    1862:	0100                	addi	s0,sp,128
    1864:	0505                	addi	a0,a0,1
    1866:	10090103          	lb	sp,256(s2)
    186a:	0100                	addi	s0,sp,128
    186c:	1405                	addi	s0,s0,-31
    186e:	32090403          	lb	s0,800(s2)
    1872:	0100                	addi	s0,sp,128
    1874:	3805                	addiw	a6,a6,-31
    1876:	06090003          	lb	zero,96(s2)
    187a:	0100                	addi	s0,sp,128
    187c:	1405                	addi	s0,s0,-31
    187e:	08090003          	lb	zero,128(s2)
    1882:	0100                	addi	s0,sp,128
    1884:	4105                	li	sp,1
    1886:	02090003          	lb	zero,32(s2)
    188a:	0100                	addi	s0,sp,128
    188c:	1405                	addi	s0,s0,-31
    188e:	06090003          	lb	zero,96(s2)
    1892:	0100                	addi	s0,sp,128
    1894:	1f05                	addi	t5,t5,-31
    1896:	10090203          	lb	tp,256(s2)
    189a:	0100                	addi	s0,sp,128
    189c:	0d05                	addi	s10,s10,1
    189e:	06090003          	lb	zero,96(s2)
    18a2:	0100                	addi	s0,sp,128
    18a4:	1405                	addi	s0,s0,-31
    18a6:	08090103          	lb	sp,128(s2)
    18aa:	0100                	addi	s0,sp,128
    18ac:	04090303          	lb	t1,64(s2)
    18b0:	0100                	addi	s0,sp,128
    18b2:	0d05                	addi	s10,s10,1
    18b4:	08090203          	lb	tp,128(s2)
    18b8:	0100                	addi	s0,sp,128
    18ba:	0c090103          	lb	sp,192(s2)
    18be:	0100                	addi	s0,sp,128
    18c0:	0505                	addi	a0,a0,1
    18c2:	10090203          	lb	tp,256(s2)
    18c6:	0100                	addi	s0,sp,128
    18c8:	0c05                	addi	s8,s8,1
    18ca:	10090103          	lb	sp,256(s2)
    18ce:	0100                	addi	s0,sp,128
    18d0:	0105                	addi	sp,sp,1
    18d2:	02090103          	lb	sp,32(s2)
    18d6:	0100                	addi	s0,sp,128
    18d8:	0a09                	addi	s4,s4,2
    18da:	0000                	unimp
    18dc:	0101                	addi	sp,sp,0
    18de:	00df 0000 0003      	0x3000000df
    18e4:	0055                	c.nop	21
    18e6:	0000                	unimp
    18e8:	0101                	addi	sp,sp,0
    18ea:	000d0efb          	0xd0efb
    18ee:	0101                	addi	sp,sp,0
    18f0:	0101                	addi	sp,sp,0
    18f2:	0000                	unimp
    18f4:	0100                	addi	s0,sp,128
    18f6:	0000                	unimp
    18f8:	6b01                	0x6b01
    18fa:	7265                	lui	tp,0xffff9
    18fc:	656e                	ld	a0,216(sp)
    18fe:	2f6c                	fld	fa1,216(a4)
    1900:	7274                	ld	a3,224(a2)
    1902:	7061                	c.lui	zero,0xffff8
    1904:	6d69742f          	0x6d69742f
    1908:	7265                	lui	tp,0xffff9
    190a:	6b00                	ld	s0,16(a4)
    190c:	7265                	lui	tp,0xffff9
    190e:	656e                	ld	a0,216(sp)
    1910:	2f6c                	fld	fa1,216(a4)
    1912:	626f6c67          	0x626f6c67
    1916:	656c                	ld	a1,200(a0)
    1918:	0000                	unimp
    191a:	6974                	ld	a3,208(a0)
    191c:	656d                	lui	a0,0x1b
    191e:	2e72                	fld	ft8,280(sp)
    1920:	00010063          	beqz	sp,1920 <n+0x1900>
    1924:	7400                	ld	s0,40(s0)
    1926:	6d69                	lui	s10,0x1a
    1928:	7265                	lui	tp,0xffff9
    192a:	682e                	ld	a6,200(sp)
    192c:	0100                	addi	s0,sp,128
    192e:	0000                	unimp
    1930:	69647473          	csrrci	s0,0x696,8
    1934:	746e                	ld	s0,248(sp)
    1936:	682e                	ld	a6,200(sp)
    1938:	0200                	addi	s0,sp,256
    193a:	0000                	unimp
    193c:	0500                	addi	s0,sp,640
    193e:	0001                	nop
    1940:	0209                	addi	tp,tp,2
    1942:	17f4                	addi	a3,sp,1004
    1944:	8020                	0x8020
    1946:	0000                	unimp
    1948:	0000                	unimp
    194a:	03050517          	auipc	a0,0x3050
    194e:	0902                	c.slli64	s2
    1950:	0006                	c.slli	zero,0x1
    1952:	0501                	addi	a0,a0,0
    1954:	030c                	addi	a1,sp,384
    1956:	0901                	addi	s2,s2,0
    1958:	0008                	0x8
    195a:	0501                	addi	a0,a0,0
    195c:	0301                	addi	t1,t1,0
    195e:	0901                	addi	s2,s2,0
    1960:	0004                	0x4
    1962:	0301                	addi	t1,t1,0
    1964:	00080903          	lb	s2,0(a6) # ffffffffffff9000 <ebss+0xffffffff7fd9e0b8>
    1968:	0501                	addi	a0,a0,0
    196a:	09010313          	addi	t1,sp,144
    196e:	0008                	0x8
    1970:	0501                	addi	a0,a0,0
    1972:	0305                	addi	t1,t1,1
    1974:	0900                	addi	s0,sp,144
    1976:	0006                	c.slli	zero,0x1
    1978:	0501                	addi	a0,a0,0
    197a:	0301                	addi	t1,t1,0
    197c:	0901                	addi	s2,s2,0
    197e:	000e                	c.slli	zero,0x3
    1980:	0301                	addi	t1,t1,0
    1982:	0904                	addi	s1,sp,144
    1984:	000a                	c.slli	zero,0x2
    1986:	0501                	addi	a0,a0,0
    1988:	0305                	addi	t1,t1,1
    198a:	0901                	addi	s2,s2,0
    198c:	0008                	0x8
    198e:	0301                	addi	t1,t1,0
    1990:	0901                	addi	s2,s2,0
    1992:	0004                	0x4
    1994:	0501                	addi	a0,a0,0
    1996:	0301                	addi	t1,t1,0
    1998:	0901                	addi	s2,s2,0
    199a:	000c                	0xc
    199c:	0301                	addi	t1,t1,0
    199e:	0904                	addi	s1,sp,144
    19a0:	000a                	c.slli	zero,0x2
    19a2:	0501                	addi	a0,a0,0
    19a4:	030a                	slli	t1,t1,0x2
    19a6:	0901                	addi	s2,s2,0
    19a8:	0008                	0x8
    19aa:	0501                	addi	a0,a0,0
    19ac:	0305                	addi	t1,t1,1
    19ae:	0901                	addi	s2,s2,0
    19b0:	0018                	0x18
    19b2:	0501                	addi	a0,a0,0
    19b4:	0301                	addi	t1,t1,0
    19b6:	0004090b          	0x4090b
    19ba:	0901                	addi	s2,s2,0
    19bc:	000a                	c.slli	zero,0x2
    19be:	0100                	addi	s0,sp,128
    19c0:	4901                	li	s2,0
    19c2:	0000                	unimp
    19c4:	0300                	addi	s0,sp,384
    19c6:	2b00                	fld	fs0,16(a4)
    19c8:	0000                	unimp
    19ca:	0100                	addi	s0,sp,128
    19cc:	fb01                	bnez	a4,18dc <n+0x18bc>
    19ce:	0d0e                	slli	s10,s10,0x3
    19d0:	0100                	addi	s0,sp,128
    19d2:	0101                	addi	sp,sp,0
    19d4:	0001                	nop
    19d6:	0000                	unimp
    19d8:	0001                	nop
    19da:	0100                	addi	s0,sp,128
    19dc:	6e72656b          	0x6e72656b
    19e0:	6c65                	lui	s8,0x19
    19e2:	6d73612f          	0x6d73612f
    19e6:	0000                	unimp
    19e8:	6e65                	lui	t3,0x19
    19ea:	7274                	ld	a3,224(a2)
    19ec:	2e79                	addiw	t3,t3,30
    19ee:	7361                	lui	t1,0xffff8
    19f0:	006d                	c.nop	27
    19f2:	0001                	nop
    19f4:	0000                	unimp
    19f6:	0900                	addi	s0,sp,144
    19f8:	0002                	c.slli64	zero
    19fa:	2000                	fld	fs0,0(s0)
    19fc:	0080                	addi	s0,sp,64
    19fe:	0000                	unimp
    1a00:	1500                	addi	s0,sp,672
    1a02:	08090103          	lb	sp,128(s2)
    1a06:	0100                	addi	s0,sp,128
    1a08:	0409                	addi	s0,s0,2
    1a0a:	0000                	unimp
    1a0c:	0101                	addi	sp,sp,0
    1a0e:	00da                	slli	ra,ra,0x16
    1a10:	0000                	unimp
    1a12:	002a0003          	lb	zero,2(s4) # 1002 <n+0xfe2>
    1a16:	0000                	unimp
    1a18:	0101                	addi	sp,sp,0
    1a1a:	000d0efb          	0xd0efb
    1a1e:	0101                	addi	sp,sp,0
    1a20:	0101                	addi	sp,sp,0
    1a22:	0000                	unimp
    1a24:	0100                	addi	s0,sp,128
    1a26:	0000                	unimp
    1a28:	6b01                	0x6b01
    1a2a:	7265                	lui	tp,0xffff9
    1a2c:	656e                	ld	a0,216(sp)
    1a2e:	2f6c                	fld	fa1,216(a4)
    1a30:	7361                	lui	t1,0xffff8
    1a32:	006d                	c.nop	27
    1a34:	7400                	ld	s0,40(s0)
    1a36:	6172                	ld	sp,280(sp)
    1a38:	2e70                	fld	fa2,216(a2)
    1a3a:	7361                	lui	t1,0xffff8
    1a3c:	006d                	c.nop	27
    1a3e:	0001                	nop
    1a40:	0000                	unimp
    1a42:	0900                	addi	s0,sp,144
    1a44:	8402                	jr	s0
    1a46:	2018                	fld	fa4,0(s0)
    1a48:	0080                	addi	s0,sp,64
    1a4a:	0000                	unimp
    1a4c:	0300                	addi	s0,sp,384
    1a4e:	010c                	addi	a1,sp,128
    1a50:	04090303          	lb	t1,64(s2)
    1a54:	0100                	addi	s0,sp,128
    1a56:	02090203          	lb	tp,32(s2)
    1a5a:	0100                	addi	s0,sp,128
    1a5c:	02090203          	lb	tp,32(s2)
    1a60:	0100                	addi	s0,sp,128
    1a62:	02090703          	lb	a4,32(s2)
    1a66:	0100                	addi	s0,sp,128
    1a68:	36090203          	lb	tp,864(s2)
    1a6c:	0100                	addi	s0,sp,128
    1a6e:	04090103          	lb	sp,64(s2)
    1a72:	0100                	addi	s0,sp,128
    1a74:	04090103          	lb	sp,64(s2)
    1a78:	0100                	addi	s0,sp,128
    1a7a:	02090103          	lb	sp,32(s2)
    1a7e:	0100                	addi	s0,sp,128
    1a80:	02090203          	lb	tp,32(s2)
    1a84:	0100                	addi	s0,sp,128
    1a86:	04090103          	lb	sp,64(s2)
    1a8a:	0100                	addi	s0,sp,128
    1a8c:	02090203          	lb	tp,32(s2)
    1a90:	0100                	addi	s0,sp,128
    1a92:	02090103          	lb	sp,32(s2)
    1a96:	0100                	addi	s0,sp,128
    1a98:	04090503          	lb	a0,64(s2)
    1a9c:	0100                	addi	s0,sp,128
    1a9e:	02090303          	lb	t1,32(s2)
    1aa2:	0100                	addi	s0,sp,128
    1aa4:	02090103          	lb	sp,32(s2)
    1aa8:	0100                	addi	s0,sp,128
    1aaa:	02090103          	lb	sp,32(s2)
    1aae:	0100                	addi	s0,sp,128
    1ab0:	02090103          	lb	sp,32(s2)
    1ab4:	0100                	addi	s0,sp,128
    1ab6:	04090103          	lb	sp,64(s2)
    1aba:	0100                	addi	s0,sp,128
    1abc:	04090103          	lb	sp,64(s2)
    1ac0:	0100                	addi	s0,sp,128
    1ac2:	04090203          	lb	tp,64(s2)
    1ac6:	0100                	addi	s0,sp,128
    1ac8:	02090103          	lb	sp,32(s2)
    1acc:	0100                	addi	s0,sp,128
    1ace:	02090503          	lb	a0,32(s2)
    1ad2:	0100                	addi	s0,sp,128
    1ad4:	36090203          	lb	tp,864(s2)
    1ad8:	0100                	addi	s0,sp,128
    1ada:	02090203          	lb	tp,32(s2)
    1ade:	0100                	addi	s0,sp,128
    1ae0:	04090103          	lb	sp,64(s2)
    1ae4:	0100                	addi	s0,sp,128
    1ae6:	0409                	addi	s0,s0,2
    1ae8:	0000                	unimp
    1aea:	0101                	addi	sp,sp,0
    1aec:	006a                	c.slli	zero,0x1a
    1aee:	0000                	unimp
    1af0:	002c0003          	lb	zero,2(s8) # 19002 <n+0x18fe2>
    1af4:	0000                	unimp
    1af6:	0101                	addi	sp,sp,0
    1af8:	000d0efb          	0xd0efb
    1afc:	0101                	addi	sp,sp,0
    1afe:	0101                	addi	sp,sp,0
    1b00:	0000                	unimp
    1b02:	0100                	addi	s0,sp,128
    1b04:	0000                	unimp
    1b06:	6b01                	0x6b01
    1b08:	7265                	lui	tp,0xffff9
    1b0a:	656e                	ld	a0,216(sp)
    1b0c:	2f6c                	fld	fa1,216(a4)
    1b0e:	7361                	lui	t1,0xffff8
    1b10:	006d                	c.nop	27
    1b12:	7300                	ld	s0,32(a4)
    1b14:	63746977          	0x63746977
    1b18:	2e68                	fld	fa0,216(a2)
    1b1a:	7361                	lui	t1,0xffff8
    1b1c:	006d                	c.nop	27
    1b1e:	0001                	nop
    1b20:	0000                	unimp
    1b22:	0900                	addi	s0,sp,144
    1b24:	3a02                	fld	fs4,32(sp)
    1b26:	2019                	0x2019
    1b28:	0080                	addi	s0,sp,64
    1b2a:	0000                	unimp
    1b2c:	0300                	addi	s0,sp,384
    1b2e:	0203010f          	0x203010f
    1b32:	0409                	addi	s0,s0,2
    1b34:	0100                	addi	s0,sp,128
    1b36:	04090503          	lb	a0,64(s2)
    1b3a:	0100                	addi	s0,sp,128
    1b3c:	2c090203          	lb	tp,704(s2)
    1b40:	0100                	addi	s0,sp,128
    1b42:	04090503          	lb	a0,64(s2)
    1b46:	0100                	addi	s0,sp,128
    1b48:	2c090203          	lb	tp,704(s2)
    1b4c:	0100                	addi	s0,sp,128
    1b4e:	04090103          	lb	sp,64(s2)
    1b52:	0100                	addi	s0,sp,128
    1b54:	0209                	addi	tp,tp,2
    1b56:	0000                	unimp
    1b58:	0101                	addi	sp,sp,0

Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	6974                	ld	a3,208(a0)
   2:	00736b63          	bltu	t1,t2,18 <n+0xc>
   6:	6975                	lui	s2,0x1d
   8:	746e                	ld	s0,248(sp)
   a:	3436                	fld	fs0,360(sp)
   c:	745f 7300 6f68      	0x6f687300745f
  12:	7472                	ld	s0,312(sp)
  14:	7520                	ld	s0,104(a0)
  16:	736e                	ld	t1,248(sp)
  18:	6769                	lui	a4,0x1a
  1a:	656e                	ld	a0,216(sp)
  1c:	2064                	fld	fs1,192(s0)
  1e:	6e69                	lui	t3,0x1a
  20:	0074                	addi	a3,sp,12
  22:	726f6873          	csrrsi	a6,0x726,30
  26:	2074                	fld	fa3,192(s0)
  28:	6e69                	lui	t3,0x1a
  2a:	0074                	addi	a3,sp,12
  2c:	616d                	addi	sp,sp,240
  2e:	6e69                	lui	t3,0x1a
  30:	6f5f 0073 656b      	0x656b00736f5f
  36:	6e72                	ld	t3,280(sp)
  38:	6c65                	lui	s8,0x19
  3a:	69616d2f          	0x69616d2f
  3e:	2e6e                	fld	ft8,216(sp)
  40:	6e750063          	beq	a0,t2,720 <n+0x700>
  44:	6e676973          	csrrsi	s2,0x6e6,14
  48:	6465                	lui	s0,0x19
  4a:	6320                	ld	s0,64(a4)
  4c:	6168                	ld	a0,192(a0)
  4e:	0072                	c.slli	zero,0x1c
  50:	6f6c                	ld	a1,216(a4)
  52:	676e                	ld	a4,216(sp)
  54:	6920                	ld	s0,80(a0)
  56:	746e                	ld	s0,248(sp)
  58:	2f00                	fld	fs0,24(a4)
  5a:	6f68                	ld	a0,216(a4)
  5c:	656d                	lui	a0,0x1b
  5e:	6961632f          	0x6961632f
  62:	62756f67          	0x62756f67
  66:	6e65                	lui	t3,0x19
  68:	2f696163          	bltu	s2,s6,34a <n+0x32a>
  6c:	6544                	ld	s1,136(a0)
  6e:	6f746b73          	csrrsi	s6,0x6f7,8
  72:	2f70                	fld	fa2,216(a4)
  74:	635f736f          	jal	t1,f7ea8 <n+0xf7e88>
  78:	6c00                	ld	s0,24(s0)
  7a:	20676e6f          	jal	t3,76280 <n+0x76260>
  7e:	6e75                	lui	t3,0x1d
  80:	6e676973          	csrrsi	s2,0x6e6,14
  84:	6465                	lui	s0,0x19
  86:	6920                	ld	s0,80(a0)
  88:	746e                	ld	s0,248(sp)
  8a:	4700                	lw	s0,8(a4)
  8c:	554e                	lw	a0,240(sp)
  8e:	4320                	lw	s0,64(a4)
  90:	3731                	addiw	a4,a4,-20
  92:	3120                	fld	fs0,96(a0)
  94:	2e30                	fld	fa2,88(a2)
  96:	2e32                	fld	ft8,264(sp)
  98:	2030                	fld	fa2,64(s0)
  9a:	6d2d                	lui	s10,0xb
  9c:	7261                	lui	tp,0xffff8
  9e:	723d6863          	bltu	s10,gp,7ce <n+0x7ae>
  a2:	3676                	fld	fa2,376(sp)
  a4:	6734                	ld	a3,72(a4)
  a6:	6d2d2063          	0x6d2d2063
  aa:	6261                	lui	tp,0x18
  ac:	3d69                	addiw	s10,s10,-6
  ae:	706c                	ld	a1,224(s0)
  b0:	3436                	fld	fs0,360(sp)
  b2:	2064                	fld	fs1,192(s0)
  b4:	6d2d                	lui	s10,0xb
  b6:	646f6d63          	bltu	t5,t1,710 <n+0x6f0>
  ba:	6c65                	lui	s8,0x19
  bc:	6d3d                	lui	s10,0xf
  be:	6465                	lui	s0,0x19
  c0:	6e61                	lui	t3,0x18
  c2:	2079                	0x2079
  c4:	672d                	lui	a4,0xb
  c6:	2d20                	fld	fs0,88(a0)
  c8:	6e66                	ld	t3,88(sp)
  ca:	75622d6f          	jal	s10,22820 <n+0x22800>
  ce:	6c69                	lui	s8,0x1a
  d0:	6974                	ld	a3,208(a0)
  d2:	006e                	c.slli	zero,0x1b
  d4:	6e72656b          	0x6e72656b
  d8:	6c65                	lui	s8,0x19
  da:	6962732f          	0x6962732f
  de:	6962732f          	0x6962732f
  e2:	632e                	ld	t1,200(sp)
  e4:	7300                	ld	s0,32(a4)
  e6:	6962                	ld	s2,24(sp)
  e8:	735f 7568 6474      	0x64747568735f
  ee:	006e776f          	jal	a4,e70f4 <n+0xe70d4>
  f2:	6d697473          	csrrci	s0,0x6d6,18
  f6:	5f65                	li	t5,-7
  f8:	6176                	ld	sp,344(sp)
  fa:	756c                	ld	a1,232(a0)
  fc:	0065                	c.nop	25
  fe:	63696877          	0x63696877
 102:	0068                	addi	a0,sp,12
 104:	5f696273          	csrrsi	tp,0x5f6,18
 108:	5f746573          	csrrsi	a0,0x5f7,8
 10c:	6974                	ld	a3,208(a0)
 10e:	656d                	lui	a0,0x1b
 110:	0072                	c.slli	zero,0x1c
 112:	7261                	lui	tp,0xffff8
 114:	63003167          	0x63003167
 118:	6f736e6f          	jal	t3,3700e <n+0x36fee>
 11c:	656c                	ld	a1,200(a0)
 11e:	675f 7465 6863      	0x68637465675f
 124:	7261                	lui	tp,0xffff8
 126:	6300                	ld	s0,0(a4)
 128:	6f736e6f          	jal	t3,3701e <n+0x36ffe>
 12c:	656c                	ld	a1,200(a0)
 12e:	705f 7475 6863      	0x68637475705f
 134:	7261                	lui	tp,0xffff8
 136:	7300                	ld	s0,32(a4)
 138:	6962                	ld	s2,24(sp)
 13a:	635f 6c61 006c      	0x6c6c61635f
 140:	7261                	lui	tp,0xffff8
 142:	61003067          	0x61003067
 146:	6772                	ld	a4,280(sp)
 148:	0032                	c.slli	zero,0xc
 14a:	6c727473          	csrrci	s0,0x6c7,4
 14e:	6e65                	lui	t3,0x19
 150:	745f 6d00 6d65      	0x6d656d00745f
 156:	5f746573          	csrrsi	a0,0x5f7,8
 15a:	0074                	addi	a3,sp,12
 15c:	656d                	lui	a0,0x1b
 15e:	6d6d                	lui	s10,0x1b
 160:	5f65766f          	jal	a2,57756 <n+0x57736>
 164:	0074                	addi	a3,sp,12
 166:	6e72656b          	0x6e72656b
 16a:	6c65                	lui	s8,0x19
 16c:	7274732f          	0x7274732f
 170:	6e69                	lui	t3,0x1a
 172:	74732f67          	0x74732f67
 176:	6972                	ld	s2,280(sp)
 178:	676e                	ld	a4,216(sp)
 17a:	632e                	ld	t1,200(sp)
 17c:	6d00                	ld	s0,24(a0)
 17e:	6d65                	lui	s10,0x19
 180:	5f797063          	bgeu	s2,s7,760 <n+0x740>
 184:	0074                	addi	a3,sp,12
 186:	63727473          	csrrci	s0,0x637,4
 18a:	706d                	c.lui	zero,0xffffb
 18c:	745f 6400 7365      	0x73656400745f
 192:	0074                	addi	a3,sp,12
 194:	63727473          	csrrci	s0,0x637,4
 198:	7461                	lui	s0,0xffff8
 19a:	745f 7400 6d65      	0x6d657400745f
 1a0:	0070                	addi	a2,sp,12
 1a2:	656d                	lui	a0,0x1b
 1a4:	636d                	lui	t1,0x1b
 1a6:	706d                	c.lui	zero,0xffffb
 1a8:	745f 6d00 6d65      	0x6d656d00745f
 1ae:	00746573          	csrrsi	a0,0x7,8
 1b2:	31727473          	csrrci	s0,0x317,4
 1b6:	7300                	ld	s0,32(a4)
 1b8:	7274                	ld	a3,224(a2)
 1ba:	0032                	c.slli	zero,0xc
 1bc:	6975                	lui	s2,0x1d
 1be:	746e                	ld	s0,248(sp)
 1c0:	5f38                	lw	a4,120(a4)
 1c2:	0074                	addi	a3,sp,12
 1c4:	656d                	lui	a0,0x1b
 1c6:	636d                	lui	t1,0x1b
 1c8:	7970                	ld	a2,240(a0)
 1ca:	6200                	ld	s0,0(a2)
 1cc:	657a                	ld	a0,408(sp)
 1ce:	6f72                	ld	t5,280(sp)
 1d0:	745f 7500 6e69      	0x6e697500745f
 1d6:	3374                	fld	fa3,224(a4)
 1d8:	5f32                	lw	t5,44(sp)
 1da:	0074                	addi	a3,sp,12
 1dc:	63727473          	csrrci	s0,0x637,4
 1e0:	7970                	ld	a2,240(a0)
 1e2:	745f 7000 7274      	0x72747000745f
 1e8:	0031                	c.nop	12
 1ea:	7470                	ld	a2,232(s0)
 1ec:	3272                	fld	ft4,312(sp)
 1ee:	6b00                	ld	s0,16(a4)
 1f0:	7265                	lui	tp,0xffff9
 1f2:	656e                	ld	a0,216(sp)
 1f4:	2f6c                	fld	fa1,216(a4)
 1f6:	736e6f63          	bltu	t3,s6,934 <n+0x914>
 1fa:	2f656c6f          	jal	s8,564f0 <n+0x564d0>
 1fe:	736e6f63          	bltu	t3,s6,93c <n+0x91c>
 202:	2e656c6f          	jal	s8,564e8 <n+0x564c8>
 206:	656c0063          	beq	s8,s6,846 <n+0x826>
 20a:	676e                	ld	a4,216(sp)
 20c:	6874                	ld	a3,208(s0)
 20e:	7000                	ld	s0,32(s0)
 210:	6972                	ld	s2,280(sp)
 212:	746e                	ld	s0,248(sp)
 214:	735f 7274 7000      	0x70007274735f
 21a:	6972                	ld	s2,280(sp)
 21c:	746e                	ld	s0,248(sp)
 21e:	755f 6e69 3674      	0x36746e69755f
 224:	0034                	addi	a3,sp,8
 226:	7270                	ld	a2,224(a2)
 228:	6e69                	lui	t3,0x1a
 22a:	5f74                	lw	a3,124(a4)
 22c:	6975                	lui	s2,0x1d
 22e:	746e                	ld	s0,248(sp)
 230:	70003233          	0x70003233
 234:	6972                	ld	s2,280(sp)
 236:	746e                	ld	s0,248(sp)
 238:	755f 6e69 3674      	0x36746e69755f
 23e:	5f34                	lw	a3,120(a4)
 240:	6568                	ld	a0,200(a0)
 242:	0078                	addi	a4,sp,12
 244:	6572                	ld	a0,280(sp)
 246:	6576                	ld	a0,344(sp)
 248:	7372                	ld	t1,312(sp)
 24a:	5f65                	li	t5,-7
 24c:	00727473          	csrrci	s0,0x7,4
 250:	6964                	ld	s1,208(a0)
 252:	00746967          	0x746967
 256:	7562                	ld	a0,56(sp)
 258:	6666                	ld	a2,88(sp)
 25a:	7265                	lui	tp,0xffff9
 25c:	6c00                	ld	s0,24(s0)
 25e:	6e69                	lui	t3,0x1a
 260:	0065                	c.nop	25
 262:	6170                	ld	a2,192(a0)
 264:	696e                	ld	s2,216(sp)
 266:	69660063          	beq	a2,s6,8e6 <n+0x8c6>
 26a:	656c                	ld	a1,200(a0)
 26c:	6b00                	ld	s0,16(a4)
 26e:	7265                	lui	tp,0xffff9
 270:	656e                	ld	a0,216(sp)
 272:	2f6c                	fld	fa1,216(a4)
 274:	6564                	ld	s1,200(a0)
 276:	7562                	ld	a0,56(sp)
 278:	65642f67          	0x65642f67
 27c:	7562                	ld	a0,56(sp)
 27e:	00632e67          	0x632e67
 282:	6174                	ld	a3,192(a0)
 284:	6772                	ld	a4,280(sp)
 286:	7465                	lui	s0,0xffff9
 288:	745f 7361 5f6b      	0x5f6b7361745f
 28e:	6374                	ld	a3,192(a4)
 290:	0062                	c.slli	zero,0x18
 292:	72727563          	bgeu	tp,t2,9bc <n+0x99c>
 296:	6e65                	lui	t3,0x19
 298:	5f74                	lw	a3,124(a4)
 29a:	6174                	ld	a3,192(a0)
 29c:	745f6b73          	csrrsi	s6,0x745,30
 2a0:	74006263          	bltu	zero,zero,9e4 <n+0x9c4>
 2a4:	7361                	lui	t1,0xffff8
 2a6:	616d5f6b          	0x616d5f6b
 2aa:	616e                	ld	sp,216(sp)
 2ac:	5f726567          	0x5f726567
 2b0:	6e69                	lui	t3,0x1a
 2b2:	7469                	lui	s0,0xffffa
 2b4:	5400                	lw	s0,40(s0)
 2b6:	7361                	lui	t1,0xffff8
 2b8:	6174536b          	0x6174536b
 2bc:	7574                	ld	a3,232(a0)
 2be:	5f5f0073          	0x5f5f0073
 2c2:	6176                	ld	sp,344(sp)
 2c4:	006c                	addi	a1,sp,12
 2c6:	756e                	ld	a0,248(sp)
 2c8:	5f6d                	li	t5,-5
 2ca:	6174                	ld	a3,192(a0)
 2cc:	74006b73          	csrrsi	s6,0x740,0
 2d0:	7261                	lui	tp,0xffff8
 2d2:	5f746567          	0x5f746567
 2d6:	6174                	ld	a3,192(a0)
 2d8:	6e5f6b73          	csrrsi	s6,0x6e5,30
 2dc:	6d75                	lui	s10,0x1d
 2de:	7200                	ld	s0,32(a2)
 2e0:	6e75                	lui	t3,0x1d
 2e2:	6e5f 7865 5f74      	0x5f7478656e5f
 2e8:	6174                	ld	a3,192(a0)
 2ea:	63006b73          	csrrsi	s6,0x630,0
 2ee:	7275                	lui	tp,0xffffd
 2f0:	6572                	ld	a0,280(sp)
 2f2:	746e                	ld	s0,248(sp)
 2f4:	745f 7361 006b      	0x6b7361745f
 2fa:	5f5f 6572 7473      	0x747365725f5f
 300:	0065726f          	jal	tp,57306 <n+0x572e6>
 304:	6552                	ld	a0,272(sp)
 306:	6461                	lui	s0,0x18
 308:	0079                	c.nop	30
 30a:	7572                	ld	a0,312(sp)
 30c:	5f6e                	lw	t5,248(sp)
 30e:	6966                	ld	s2,88(sp)
 310:	7372                	ld	t1,312(sp)
 312:	5f74                	lw	a3,124(a4)
 314:	6174                	ld	a3,192(a0)
 316:	6b006b73          	csrrsi	s6,0x6b0,0
 31a:	7265                	lui	tp,0xffff9
 31c:	656e                	ld	a0,216(sp)
 31e:	2f6c                	fld	fa1,216(a4)
 320:	6162                	ld	sp,24(sp)
 322:	6374                	ld	a3,192(a4)
 324:	2f68                	fld	fa0,216(a4)
 326:	6174                	ld	a3,192(a0)
 328:	742f6b73          	csrrsi	s6,0x742,30
 32c:	7361                	lui	t1,0xffff8
 32e:	00632e6b          	0x632e6b
 332:	6174                	ld	a3,192(a0)
 334:	00736b73          	csrrsi	s6,0x7,6
 338:	6e55                	lui	t3,0x15
 33a:	6e49                	lui	t3,0x12
 33c:	7469                	lui	s0,0xffffa
 33e:	7400                	ld	s0,40(s0)
 340:	7261                	lui	tp,0xffff8
 342:	5f746567          	0x5f746567
 346:	74007073          	csrci	0x740,0
 34a:	7361                	lui	t1,0xffff8
 34c:	74735f6b          	0x74735f6b
 350:	7461                	lui	s0,0xffff8
 352:	7375                	lui	t1,0xffffd
 354:	4500                	lw	s0,8(a0)
 356:	6978                	ld	a4,208(a0)
 358:	6574                	ld	a3,200(a0)
 35a:	0064                	addi	s1,sp,12
 35c:	7552                	ld	a0,304(sp)
 35e:	6e6e                	ld	t3,216(sp)
 360:	6e69                	lui	t3,0x1a
 362:	61740067          	jr	1559(s0) # ffffffffffff8617 <ebss+0xffffffff7fd9d6cf>
 366:	635f6b73          	csrrsi	s6,0x635,30
 36a:	0078                	addi	a4,sp,12
 36c:	6174                	ld	a3,192(a0)
 36e:	6d5f6b73          	csrrsi	s6,0x6d5,30
 372:	6e61                	lui	t3,0x18
 374:	6761                	lui	a4,0x18
 376:	7265                	lui	tp,0xffff9
 378:	5400                	lw	s0,40(s0)
 37a:	7361                	lui	t1,0xffff8
 37c:	6e6f436b          	0x6e6f436b
 380:	7274                	ld	a3,224(a2)
 382:	6c426c6f          	jal	s8,26a46 <n+0x26a26>
 386:	006b636f          	jal	t1,b638c <n+0xb636c>
 38a:	6154                	ld	a3,128(a0)
 38c:	6f436b73          	csrrsi	s6,0x6f4,6
 390:	746e                	ld	s0,248(sp)
 392:	7865                	lui	a6,0xffff9
 394:	0074                	addi	a3,sp,12
 396:	6154                	ld	a3,128(a0)
 398:	614d6b73          	csrrsi	s6,0x614,26
 39c:	616e                	ld	sp,216(sp)
 39e:	00726567          	0x726567
 3a2:	7061                	c.lui	zero,0xffff8
 3a4:	5f70                	lw	a2,124(a4)
 3a6:	6469                	lui	s0,0x1a
 3a8:	7500                	ld	s0,40(a0)
 3aa:	6e69                	lui	t3,0x1a
 3ac:	7074                	ld	a3,224(s0)
 3ae:	7274                	ld	a3,224(a2)
 3b0:	745f 6b00 7265      	0x72656b00745f
 3b6:	656e                	ld	a0,216(sp)
 3b8:	2f6c                	fld	fa1,216(a4)
 3ba:	6162                	ld	sp,24(sp)
 3bc:	6374                	ld	a3,192(a4)
 3be:	2f68                	fld	fa0,216(a4)
 3c0:	6162                	ld	sp,24(sp)
 3c2:	6374                	ld	a3,192(a4)
 3c4:	2e68                	fld	fa0,216(a2)
 3c6:	72740063          	beq	s0,t2,ae6 <n+0xac6>
 3ca:	7061                	c.lui	zero,0xffff8
 3cc:	746e6f63          	bltu	t3,t1,b2a <n+0xb0a>
 3d0:	7865                	lui	a6,0xffff9
 3d2:	0074                	addi	a3,sp,12
 3d4:	7572                	ld	a0,312(sp)
 3d6:	5f6e                	lw	t5,248(sp)
 3d8:	656e                	ld	a0,216(sp)
 3da:	7478                	ld	a4,232(s0)
 3dc:	615f 7070 6c00      	0x6c007070615f
 3e2:	5f64616f          	jal	sp,469d8 <n+0x469b8>
 3e6:	7061                	c.lui	zero,0xffff8
 3e8:	5f70                	lw	a2,124(a4)
 3ea:	6574                	ld	a3,200(a0)
 3ec:	61007473          	csrrci	s0,0x610,0
 3f0:	7070                	ld	a2,224(s0)
 3f2:	735f 6174 7472      	0x74726174735f
 3f8:	6100                	ld	s0,0(a0)
 3fa:	7070                	ld	a2,224(s0)
 3fc:	655f 646e 4100      	0x4100646e655f
 402:	7070                	ld	a2,224(s0)
 404:	614d                	addi	sp,sp,176
 406:	616e                	ld	sp,216(sp)
 408:	00726567          	0x726567
 40c:	6e69                	lui	t3,0x1a
 40e:	7469                	lui	s0,0xffffa
 410:	615f 7070 616d      	0x616d7070615f
 416:	616e                	ld	sp,216(sp)
 418:	00726567          	0x726567
 41c:	7355                	lui	t1,0xffff5
 41e:	7265                	lui	tp,0xffff9
 420:	63617453          	0x63617453
 424:	7061006b          	0x7061006b
 428:	5f70                	lw	a2,124(a4)
 42a:	657a6973          	csrrsi	s2,0x657,20
 42e:	5f00                	lw	s0,56(a4)
 430:	756e                	ld	a0,248(sp)
 432:	5f6d                	li	t5,-5
 434:	7061                	c.lui	zero,0xffff8
 436:	0070                	addi	a2,sp,12
 438:	6f6c                	ld	a1,216(a4)
 43a:	6461                	lui	s0,0x18
 43c:	615f 7070 7200      	0x72007070615f
 442:	6e75                	lui	t3,0x1d
 444:	665f 7269 7473      	0x74737269665f
 44a:	615f 7070 6100      	0x61007070615f
 450:	7070                	ld	a2,224(s0)
 452:	6e5f 6d75 6100      	0x61006d756e5f
 458:	7070                	ld	a2,224(s0)
 45a:	6d5f 6e61 6761      	0x67616e616d5f
 460:	7265                	lui	tp,0xffff9
 462:	7300                	ld	s0,32(a4)
 464:	6174                	ld	a3,192(a0)
 466:	7472                	ld	s0,312(sp)
 468:	615f 6464 0072      	0x726464615f
 46e:	7270                	ld	a2,224(a2)
 470:	6e69                	lui	t3,0x1a
 472:	5f74                	lw	a3,124(a4)
 474:	7061                	c.lui	zero,0xffff8
 476:	5f70                	lw	a2,124(a4)
 478:	6e69                	lui	t3,0x1a
 47a:	6f66                	ld	t5,88(sp)
 47c:	6300                	ld	s0,0(a4)
 47e:	7275                	lui	tp,0xffffd
 480:	6572                	ld	a0,280(sp)
 482:	746e                	ld	s0,248(sp)
 484:	615f 7070 6700      	0x67007070615f
 48a:	7465                	lui	s0,0xffff9
 48c:	6b5f 7265 656e      	0x656e72656b5f
 492:	5f6c                	lw	a1,124(a4)
 494:	63617473          	csrrci	s0,0x636,2
 498:	6f745f6b          	0x6f745f6b
 49c:	0070                	addi	a2,sp,12
 49e:	6d74                	ld	a3,216(a0)
 4a0:	5f70                	lw	a2,124(a4)
 4a2:	73007863          	bgeu	zero,a6,bd2 <n+0xbb2>
 4a6:	6174                	ld	a3,192(a0)
 4a8:	6f546b63          	bltu	s0,s5,b9e <n+0xb7e>
 4ac:	0070                	addi	a2,sp,12
 4ae:	7254                	ld	a3,160(a2)
 4b0:	7061                	c.lui	zero,0xffff8
 4b2:	535f 6174 6b63      	0x6b636174535f
 4b8:	7400                	ld	s0,40(s0)
 4ba:	6172                	ld	sp,280(sp)
 4bc:	4370                	lw	a2,68(a4)
 4be:	65746e6f          	jal	t3,47314 <n+0x472f4>
 4c2:	7478                	ld	a4,232(s0)
 4c4:	4b00                	lw	s0,16(a4)
 4c6:	7265                	lui	tp,0xffff9
 4c8:	656e                	ld	a0,216(sp)
 4ca:	736c                	ld	a1,224(a4)
 4cc:	6174                	ld	a3,192(a0)
 4ce:	705f6b63          	bltu	t5,t0,be4 <n+0xbc4>
 4d2:	7375                	lui	t1,0xffffd
 4d4:	5f68                	lw	a0,124(a4)
 4d6:	7254                	ld	a3,160(a2)
 4d8:	7061                	c.lui	zero,0xffff8
 4da:	746e6f43          	0x746e6f43
 4de:	7865                	lui	a6,0xffff9
 4e0:	0074                	addi	a3,sp,12
 4e2:	6e69                	lui	t3,0x1a
 4e4:	7469                	lui	s0,0xffffa
 4e6:	6b5f 7265 656e      	0x656e72656b5f
 4ec:	5f6c                	lw	a1,124(a4)
 4ee:	63617473          	csrrci	s0,0x636,2
 4f2:	7355006b          	0x7355006b
 4f6:	7265                	lui	tp,0xffff9
 4f8:	63617453          	0x63617453
 4fc:	75705f6b          	0x75705f6b
 500:	545f6873          	csrrsi	a6,0x545,30
 504:	6172                	ld	sp,280(sp)
 506:	4370                	lw	a2,68(a4)
 508:	65746e6f          	jal	t3,4735e <n+0x4733e>
 50c:	7478                	ld	a4,232(s0)
 50e:	6700                	ld	s0,8(a4)
 510:	7465                	lui	s0,0xffff9
 512:	755f 6573 5f72      	0x5f726573755f
 518:	63617473          	csrrci	s0,0x636,2
 51c:	6f745f6b          	0x6f745f6b
 520:	0070                	addi	a2,sp,12
 522:	6e69                	lui	t3,0x1a
 524:	7469                	lui	s0,0xffffa
 526:	615f 7070 635f      	0x635f7070615f
 52c:	0078                	addi	a4,sp,12
 52e:	6e72656b          	0x6e72656b
 532:	6c65                	lui	s8,0x19
 534:	7461622f          	0x7461622f
 538:	732f6863          	bltu	t5,s2,c68 <n+0xc48>
 53c:	6174                	ld	a3,192(a0)
 53e:	732f6b63          	bltu	t5,s2,c74 <n+0xc54>
 542:	6174                	ld	a3,192(a0)
 544:	632e6b63          	bltu	t3,s2,b7a <n+0xb5a>
 548:	4b00                	lw	s0,16(a4)
 54a:	7265                	lui	tp,0xffff9
 54c:	656e                	ld	a0,216(sp)
 54e:	736c                	ld	a1,224(a4)
 550:	6174                	ld	a3,192(a0)
 552:	74006b63          	bltu	zero,zero,ca8 <n+0xc88>
 556:	7361                	lui	t1,0xffff8
 558:	64695f6b          	0x64695f6b
 55c:	6900                	ld	s0,16(a0)
 55e:	696e                	ld	s2,216(sp)
 560:	5f74                	lw	a3,124(a4)
 562:	7375                	lui	t1,0xffffd
 564:	7265                	lui	tp,0xffff9
 566:	735f 6174 6b63      	0x6b636174735f
 56c:	6b00                	ld	s0,16(a4)
 56e:	7265                	lui	tp,0xffff9
 570:	656e                	ld	a0,216(sp)
 572:	2f6c                	fld	fa1,216(a4)
 574:	6162                	ld	sp,24(sp)
 576:	6374                	ld	a3,192(a4)
 578:	2f68                	fld	fa0,216(a4)
 57a:	746e6f63          	bltu	t3,t1,cd8 <n+0xcb8>
 57e:	7865                	lui	a6,0xffff9
 580:	2f74                	fld	fa3,216(a4)
 582:	746e6f63          	bltu	t3,t1,ce0 <n+0xcc0>
 586:	7865                	lui	a6,0xffff9
 588:	2e74                	fld	fa3,216(a2)
 58a:	6e650063          	beq	a0,t1,c6a <n+0xc4a>
 58e:	7274                	ld	a3,224(a2)
 590:	0079                	c.nop	30
 592:	5f746573          	csrrsi	a0,0x5f7,8
 596:	61747373          	csrrci	t1,0x617,8
 59a:	7574                	ld	a3,232(a0)
 59c:	70735f73          	csrrwi	t5,0x707,6
 5a0:	5f70                	lw	a2,124(a4)
 5a2:	7375                	lui	t1,0xffffd
 5a4:	7265                	lui	tp,0xffff9
 5a6:	6d00                	ld	s0,24(a0)
 5a8:	7361                	lui	t1,0xffff8
 5aa:	6572006b          	0x6572006b
 5ae:	6461                	lui	s0,0x18
 5b0:	735f 7473 7461      	0x74617473735f
 5b6:	7375                	lui	t1,0xffffd
 5b8:	6100                	ld	s0,0(a0)
 5ba:	7070                	ld	a2,224(s0)
 5bc:	695f 696e 5f74      	0x5f74696e695f
 5c2:	746e6f63          	bltu	t3,t1,d20 <n+0xd00>
 5c6:	7865                	lui	a6,0xffff9
 5c8:	0074                	addi	a3,sp,12
 5ca:	5f746573          	csrrsi	a0,0x5f7,8
 5ce:	70007073          	csrci	0x700,0
 5d2:	6972                	ld	s2,280(sp)
 5d4:	746e                	ld	s0,248(sp)
 5d6:	735f 7065 0063      	0x637065735f
 5dc:	6e69                	lui	t3,0x1a
 5de:	7469                	lui	s0,0xffffa
 5e0:	695f 746e 7265      	0x7265746e695f
 5e6:	7572                	ld	a0,312(sp)
 5e8:	7470                	ld	a2,232(s0)
 5ea:	6300                	ld	s0,0(a4)
 5ec:	746e                	ld	s0,248(sp)
 5ee:	0031                	c.nop	12
 5f0:	75616373          	csrrsi	t1,0x756,2
 5f4:	6b006573          	csrrsi	a0,0x6b0,0
 5f8:	7265                	lui	tp,0xffff9
 5fa:	656e                	ld	a0,216(sp)
 5fc:	2f6c                	fld	fa1,216(a4)
 5fe:	7274                	ld	a3,224(a2)
 600:	7061                	c.lui	zero,0xffff8
 602:	6172742f          	0x6172742f
 606:	2e70                	fld	fa2,216(a2)
 608:	74730063          	beq	t1,t2,d48 <n+0xd28>
 60c:	6576                	ld	a0,344(sp)
 60e:	61765f63          	bge	a2,s7,c2c <n+0xc0c>
 612:	756c                	ld	a1,232(a0)
 614:	0065                	c.nop	25
 616:	7261                	lui	tp,0xffff8
 618:	74007367          	0x74007367
 61c:	6172                	ld	sp,280(sp)
 61e:	5f70                	lw	a2,124(a4)
 620:	6168                	ld	a0,192(a0)
 622:	646e                	ld	s0,216(sp)
 624:	656c                	ld	a1,200(a0)
 626:	0072                	c.slli	zero,0x1c
 628:	63737973          	csrrci	s2,0x637,6
 62c:	6c61                	lui	s8,0x18
 62e:	006c                	addi	a1,sp,12
 630:	6e756f63          	bltu	a0,t2,d2e <n+0xd0e>
 634:	0074                	addi	a3,sp,12
 636:	5f737973          	csrrci	s2,0x5f7,6
 63a:	6979                	lui	s2,0x1e
 63c:	6c65                	lui	s8,0x19
 63e:	0064                	addi	s1,sp,12
 640:	5f737973          	csrrci	s2,0x5f7,6
 644:	74697277          	0x74697277
 648:	0065                	c.nop	25
 64a:	6e72656b          	0x6e72656b
 64e:	6c65                	lui	s8,0x19
 650:	6172742f          	0x6172742f
 654:	2f70                	fld	fa2,216(a4)
 656:	63737973          	csrrci	s2,0x637,6
 65a:	6c61                	lui	s8,0x18
 65c:	2f6c                	fld	fa1,216(a4)
 65e:	63737973          	csrrci	s2,0x637,6
 662:	6c61                	lui	s8,0x18
 664:	2e6c                	fld	fa1,216(a2)
 666:	79730063          	beq	t1,s7,de6 <n+0xdc6>
 66a:	78655f73          	csrrwi	t5,0x786,10
 66e:	7469                	lui	s0,0xffffa
 670:	7300                	ld	s0,32(a4)
 672:	7379                	lui	t1,0xffffe
 674:	6c6c6163          	bltu	s8,t1,d36 <n+0xd16>
 678:	695f 0064 6974      	0x69740064695f
 67e:	656d                	lui	a0,0x1b
 680:	5f72                	lw	t5,60(sp)
 682:	6e69                	lui	t3,0x1a
 684:	7469                	lui	s0,0xffffa
 686:	7200                	ld	s0,32(a2)
 688:	6165                	addi	sp,sp,112
 68a:	5f64                	lw	s1,124(a4)
 68c:	6974                	ld	a3,208(a0)
 68e:	656d                	lui	a0,0x1b
 690:	6b00                	ld	s0,16(a4)
 692:	7265                	lui	tp,0xffff9
 694:	656e                	ld	a0,216(sp)
 696:	2f6c                	fld	fa1,216(a4)
 698:	7274                	ld	a3,224(a2)
 69a:	7061                	c.lui	zero,0xffff8
 69c:	6d69742f          	0x6d69742f
 6a0:	7265                	lui	tp,0xffff9
 6a2:	6d69742f          	0x6d69742f
 6a6:	7265                	lui	tp,0xffff9
 6a8:	632e                	ld	t1,200(sp)
 6aa:	6900                	ld	s0,16(a0)
 6ac:	746e                	ld	s0,248(sp)
 6ae:	5f72                	lw	t5,60(sp)
 6b0:	6974                	ld	a3,208(a0)
 6b2:	656d                	lui	a0,0x1b
 6b4:	5f72                	lw	t5,60(sp)
 6b6:	6168                	ld	a0,192(a0)
 6b8:	646e                	ld	s0,216(sp)
 6ba:	656c                	ld	a1,200(a0)
 6bc:	6300                	ld	s0,0(a4)
 6be:	6f6c                	ld	a1,216(a4)
 6c0:	735f6b63          	bltu	t5,s5,df6 <n+0xdd6>
 6c4:	7465                	lui	s0,0xffff9
 6c6:	6e5f 7865 5f74      	0x5f7478656e5f
 6cc:	7665                	lui	a2,0xffff9
 6ce:	6e65                	lui	t3,0x19
 6d0:	0074                	addi	a3,sp,12
 6d2:	6e72656b          	0x6e72656b
 6d6:	6c65                	lui	s8,0x19
 6d8:	6d73612f          	0x6d73612f
 6dc:	746e652f          	0x746e652f
 6e0:	7972                	ld	s2,312(sp)
 6e2:	612e                	ld	sp,200(sp)
 6e4:	47006d73          	csrrsi	s10,0x470,0
 6e8:	554e                	lw	a0,240(sp)
 6ea:	4120                	lw	s0,64(a0)
 6ec:	2e322053          	0x2e322053
 6f0:	312e3533          	0x312e3533
 6f4:	6b00                	ld	s0,16(a4)
 6f6:	7265                	lui	tp,0xffff9
 6f8:	656e                	ld	a0,216(sp)
 6fa:	2f6c                	fld	fa1,216(a4)
 6fc:	7361                	lui	t1,0xffff8
 6fe:	2f6d                	addiw	t5,t5,27
 700:	7274                	ld	a3,224(a2)
 702:	7061                	c.lui	zero,0xffff8
 704:	612e                	ld	sp,200(sp)
 706:	6b006d73          	csrrsi	s10,0x6b0,0
 70a:	7265                	lui	tp,0xffff9
 70c:	656e                	ld	a0,216(sp)
 70e:	2f6c                	fld	fa1,216(a4)
 710:	7361                	lui	t1,0xffff8
 712:	2f6d                	addiw	t5,t5,27
 714:	74697773          	csrrci	a4,0x746,18
 718:	612e6863          	bltu	t3,s2,d28 <n+0xd08>
 71c:	          	csrrsi	s10,ustatus,0

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	2029                	0x2029
   8:	3031                	0x3031
   a:	322e                	fld	ft4,232(sp)
   c:	302e                	fld	ft0,232(sp)
	...

Disassembly of section .riscv.attributes:

0000000000000000 <.riscv.attributes>:
   0:	3841                	addiw	a6,a6,-16
   2:	0000                	unimp
   4:	7200                	ld	s0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <n+0x8>
   c:	002e                	c.slli	zero,0xb
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3676                	fld	fa2,376(sp)
  16:	6934                	ld	a3,80(a0)
  18:	7032                	0x7032
  1a:	5f30                	lw	a2,120(a4)
  1c:	326d                	addiw	tp,tp,-5
  1e:	3070                	fld	fa2,224(s0)
  20:	615f 7032 5f30      	0x5f307032615f
  26:	3266                	fld	ft4,120(sp)
  28:	3070                	fld	fa2,224(s0)
  2a:	645f 7032 5f30      	0x5f307032645f
  30:	30703263          	0x30703263
  34:	0800                	addi	s0,sp,16
  36:	0a01                	addi	s4,s4,0
  38:	0b              	Address 0x0000000000000038 is out of bounds.


Disassembly of section .debug_frame:

0000000000000000 <.debug_frame>:
   0:	000c                	0xc
   2:	0000                	unimp
   4:	ffff                	0xffff
   6:	ffff                	0xffff
   8:	7c010003          	lb	zero,1984(sp)
   c:	0d01                	addi	s10,s10,0
   e:	0002                	c.slli64	zero
  10:	0024                	addi	s1,sp,8
  12:	0000                	unimp
  14:	0000                	unimp
  16:	0000                	unimp
  18:	000c                	0xc
  1a:	8020                	0x8020
  1c:	0000                	unimp
  1e:	0000                	unimp
  20:	0030                	addi	a2,sp,8
  22:	0000                	unimp
  24:	0000                	unimp
  26:	0000                	unimp
  28:	0e42                	slli	t3,t3,0x10
  2a:	4410                	lw	a2,8(s0)
  2c:	0281                	addi	t0,t0,0
  2e:	0488                	addi	a0,sp,576
  30:	0c42                	slli	s8,s8,0x10
  32:	0008                	0x8
  34:	0000                	unimp
  36:	0000                	unimp
  38:	000c                	0xc
  3a:	0000                	unimp
  3c:	ffff                	0xffff
  3e:	ffff                	0xffff
  40:	7c010003          	lb	zero,1984(sp)
  44:	0d01                	addi	s10,s10,0
  46:	0002                	c.slli64	zero
  48:	002c                	addi	a1,sp,8
  4a:	0000                	unimp
  4c:	0038                	addi	a4,sp,8
  4e:	0000                	unimp
  50:	003c                	addi	a5,sp,8
  52:	8020                	0x8020
  54:	0000                	unimp
  56:	0000                	unimp
  58:	0034                	addi	a3,sp,8
  5a:	0000                	unimp
  5c:	0000                	unimp
  5e:	0000                	unimp
  60:	0e42                	slli	t3,t3,0x10
  62:	4230                	lw	a2,64(a2)
  64:	0288                	addi	a0,sp,320
  66:	0c42                	slli	s8,s8,0x10
  68:	0008                	0x8
  6a:	c86a                	sw	s10,16(sp)
  6c:	020c                	addi	a1,sp,256
  6e:	4230                	lw	a2,64(a2)
  70:	000e                	c.slli	zero,0x3
  72:	0000                	unimp
  74:	0000                	unimp
  76:	0000                	unimp
  78:	002c                	addi	a1,sp,8
  7a:	0000                	unimp
  7c:	0038                	addi	a4,sp,8
  7e:	0000                	unimp
  80:	0070                	addi	a2,sp,12
  82:	8020                	0x8020
  84:	0000                	unimp
  86:	0000                	unimp
  88:	0026                	c.slli	zero,0x9
  8a:	0000                	unimp
  8c:	0000                	unimp
  8e:	0000                	unimp
  90:	0e42                	slli	t3,t3,0x10
  92:	4420                	lw	s0,72(s0)
  94:	0281                	addi	t0,t0,0
  96:	0488                	addi	a0,sp,576
  98:	0c42                	slli	s8,s8,0x10
  9a:	0008                	0x8
  9c:	c158                	sw	a4,4(a0)
  9e:	c842                	sw	a6,16(sp)
  a0:	020c                	addi	a1,sp,256
  a2:	4220                	lw	s0,64(a2)
  a4:	000e                	c.slli	zero,0x3
  a6:	0000                	unimp
  a8:	002c                	addi	a1,sp,8
  aa:	0000                	unimp
  ac:	0038                	addi	a4,sp,8
  ae:	0000                	unimp
  b0:	0096                	slli	ra,ra,0x5
  b2:	8020                	0x8020
  b4:	0000                	unimp
  b6:	0000                	unimp
  b8:	0020                	addi	s0,sp,8
  ba:	0000                	unimp
  bc:	0000                	unimp
  be:	0000                	unimp
  c0:	0e42                	slli	t3,t3,0x10
  c2:	4410                	lw	a2,8(s0)
  c4:	0281                	addi	t0,t0,0
  c6:	0488                	addi	a0,sp,576
  c8:	0c42                	slli	s8,s8,0x10
  ca:	0008                	0x8
  cc:	c152                	sw	s4,128(sp)
  ce:	c842                	sw	a6,16(sp)
  d0:	020c                	addi	a1,sp,256
  d2:	4210                	lw	a2,0(a2)
  d4:	000e                	c.slli	zero,0x3
  d6:	0000                	unimp
  d8:	002c                	addi	a1,sp,8
  da:	0000                	unimp
  dc:	0038                	addi	a4,sp,8
  de:	0000                	unimp
  e0:	00b6                	slli	ra,ra,0xd
  e2:	8020                	0x8020
  e4:	0000                	unimp
  e6:	0000                	unimp
  e8:	0020                	addi	s0,sp,8
  ea:	0000                	unimp
  ec:	0000                	unimp
  ee:	0000                	unimp
  f0:	0e42                	slli	t3,t3,0x10
  f2:	4410                	lw	a2,8(s0)
  f4:	0281                	addi	t0,t0,0
  f6:	0488                	addi	a0,sp,576
  f8:	0c42                	slli	s8,s8,0x10
  fa:	0008                	0x8
  fc:	c152                	sw	s4,128(sp)
  fe:	c842                	sw	a6,16(sp)
 100:	020c                	addi	a1,sp,256
 102:	4210                	lw	a2,0(a2)
 104:	000e                	c.slli	zero,0x3
 106:	0000                	unimp
 108:	002c                	addi	a1,sp,8
 10a:	0000                	unimp
 10c:	0038                	addi	a4,sp,8
 10e:	0000                	unimp
 110:	00d6                	slli	ra,ra,0x15
 112:	8020                	0x8020
 114:	0000                	unimp
 116:	0000                	unimp
 118:	0028                	addi	a0,sp,8
 11a:	0000                	unimp
 11c:	0000                	unimp
 11e:	0000                	unimp
 120:	0e42                	slli	t3,t3,0x10
 122:	4420                	lw	s0,72(s0)
 124:	0281                	addi	t0,t0,0
 126:	0488                	addi	a0,sp,576
 128:	0c42                	slli	s8,s8,0x10
 12a:	0008                	0x8
 12c:	c15a                	sw	s6,128(sp)
 12e:	c842                	sw	a6,16(sp)
 130:	020c                	addi	a1,sp,256
 132:	4220                	lw	s0,64(a2)
 134:	000e                	c.slli	zero,0x3
 136:	0000                	unimp
 138:	000c                	0xc
 13a:	0000                	unimp
 13c:	ffff                	0xffff
 13e:	ffff                	0xffff
 140:	7c010003          	lb	zero,1984(sp)
 144:	0d01                	addi	s10,s10,0
 146:	0002                	c.slli64	zero
 148:	002c                	addi	a1,sp,8
 14a:	0000                	unimp
 14c:	0138                	addi	a4,sp,136
 14e:	0000                	unimp
 150:	00fe                	slli	ra,ra,0x1f
 152:	8020                	0x8020
 154:	0000                	unimp
 156:	0000                	unimp
 158:	0036                	c.slli	zero,0xd
 15a:	0000                	unimp
 15c:	0000                	unimp
 15e:	0000                	unimp
 160:	0e42                	slli	t3,t3,0x10
 162:	4230                	lw	a2,64(a2)
 164:	0288                	addi	a0,sp,320
 166:	0c42                	slli	s8,s8,0x10
 168:	0008                	0x8
 16a:	c86c                	sw	a1,84(s0)
 16c:	020c                	addi	a1,sp,256
 16e:	4230                	lw	a2,64(a2)
 170:	000e                	c.slli	zero,0x3
 172:	0000                	unimp
 174:	0000                	unimp
 176:	0000                	unimp
 178:	002c                	addi	a1,sp,8
 17a:	0000                	unimp
 17c:	0138                	addi	a4,sp,136
 17e:	0000                	unimp
 180:	0134                	addi	a3,sp,136
 182:	8020                	0x8020
 184:	0000                	unimp
 186:	0000                	unimp
 188:	0052                	c.slli	zero,0x14
 18a:	0000                	unimp
 18c:	0000                	unimp
 18e:	0000                	unimp
 190:	0e42                	slli	t3,t3,0x10
 192:	4230                	lw	a2,64(a2)
 194:	0288                	addi	a0,sp,320
 196:	0c42                	slli	s8,s8,0x10
 198:	0008                	0x8
 19a:	4802                	lw	a6,0(sp)
 19c:	0cc8                	addi	a0,sp,596
 19e:	3002                	fld	ft0,32(sp)
 1a0:	0e42                	slli	t3,t3,0x10
 1a2:	0000                	unimp
 1a4:	0000                	unimp
 1a6:	0000                	unimp
 1a8:	002c                	addi	a1,sp,8
 1aa:	0000                	unimp
 1ac:	0138                	addi	a4,sp,136
 1ae:	0000                	unimp
 1b0:	0186                	slli	gp,gp,0x1
 1b2:	8020                	0x8020
 1b4:	0000                	unimp
 1b6:	0000                	unimp
 1b8:	0088                	addi	a0,sp,64
 1ba:	0000                	unimp
 1bc:	0000                	unimp
 1be:	0000                	unimp
 1c0:	0e42                	slli	t3,t3,0x10
 1c2:	4240                	lw	s0,4(a2)
 1c4:	0288                	addi	a0,sp,320
 1c6:	0c42                	slli	s8,s8,0x10
 1c8:	0008                	0x8
 1ca:	7e02                	ld	t3,32(sp)
 1cc:	0cc8                	addi	a0,sp,596
 1ce:	4002                	0x4002
 1d0:	0e42                	slli	t3,t3,0x10
 1d2:	0000                	unimp
 1d4:	0000                	unimp
 1d6:	0000                	unimp
 1d8:	002c                	addi	a1,sp,8
 1da:	0000                	unimp
 1dc:	0138                	addi	a4,sp,136
 1de:	0000                	unimp
 1e0:	020e                	slli	tp,tp,0x3
 1e2:	8020                	0x8020
 1e4:	0000                	unimp
 1e6:	0000                	unimp
 1e8:	00ea                	slli	ra,ra,0x1a
 1ea:	0000                	unimp
 1ec:	0000                	unimp
 1ee:	0000                	unimp
 1f0:	0e42                	slli	t3,t3,0x10
 1f2:	4250                	lw	a2,4(a2)
 1f4:	0288                	addi	a0,sp,320
 1f6:	0c42                	slli	s8,s8,0x10
 1f8:	0008                	0x8
 1fa:	de02                	sw	zero,60(sp)
 1fc:	020c                	addi	a1,sp,256
 1fe:	4250                	lw	a2,4(a2)
 200:	42c8                	lw	a0,4(a3)
 202:	000e                	c.slli	zero,0x3
 204:	0000                	unimp
 206:	0000                	unimp
 208:	002c                	addi	a1,sp,8
 20a:	0000                	unimp
 20c:	0138                	addi	a4,sp,136
 20e:	0000                	unimp
 210:	02f8                	addi	a4,sp,332
 212:	8020                	0x8020
 214:	0000                	unimp
 216:	0000                	unimp
 218:	0052                	c.slli	zero,0x14
 21a:	0000                	unimp
 21c:	0000                	unimp
 21e:	0000                	unimp
 220:	0e42                	slli	t3,t3,0x10
 222:	4230                	lw	a2,64(a2)
 224:	0288                	addi	a0,sp,320
 226:	0c42                	slli	s8,s8,0x10
 228:	0008                	0x8
 22a:	4802                	lw	a6,0(sp)
 22c:	0cc8                	addi	a0,sp,596
 22e:	3002                	fld	ft0,32(sp)
 230:	0e42                	slli	t3,t3,0x10
 232:	0000                	unimp
 234:	0000                	unimp
 236:	0000                	unimp
 238:	002c                	addi	a1,sp,8
 23a:	0000                	unimp
 23c:	0138                	addi	a4,sp,136
 23e:	0000                	unimp
 240:	034a                	slli	t1,t1,0x12
 242:	8020                	0x8020
 244:	0000                	unimp
 246:	0000                	unimp
 248:	002c                	addi	a1,sp,8
 24a:	0000                	unimp
 24c:	0000                	unimp
 24e:	0000                	unimp
 250:	0e42                	slli	t3,t3,0x10
 252:	4420                	lw	s0,72(s0)
 254:	0281                	addi	t0,t0,0
 256:	0488                	addi	a0,sp,576
 258:	0c42                	slli	s8,s8,0x10
 25a:	0008                	0x8
 25c:	c15e                	sw	s7,128(sp)
 25e:	c842                	sw	a6,16(sp)
 260:	020c                	addi	a1,sp,256
 262:	4220                	lw	s0,64(a2)
 264:	000e                	c.slli	zero,0x3
 266:	0000                	unimp
 268:	002c                	addi	a1,sp,8
 26a:	0000                	unimp
 26c:	0138                	addi	a4,sp,136
 26e:	0000                	unimp
 270:	0376                	slli	t1,t1,0x1d
 272:	8020                	0x8020
 274:	0000                	unimp
 276:	0000                	unimp
 278:	008e                	slli	ra,ra,0x3
 27a:	0000                	unimp
 27c:	0000                	unimp
 27e:	0000                	unimp
 280:	0e42                	slli	t3,t3,0x10
 282:	4220                	lw	s0,64(a2)
 284:	0288                	addi	a0,sp,320
 286:	0c42                	slli	s8,s8,0x10
 288:	0008                	0x8
 28a:	8402                	jr	s0
 28c:	0cc8                	addi	a0,sp,596
 28e:	2002                	fld	ft0,0(sp)
 290:	0e42                	slli	t3,t3,0x10
 292:	0000                	unimp
 294:	0000                	unimp
 296:	0000                	unimp
 298:	002c                	addi	a1,sp,8
 29a:	0000                	unimp
 29c:	0138                	addi	a4,sp,136
 29e:	0000                	unimp
 2a0:	0404                	addi	s1,sp,512
 2a2:	8020                	0x8020
 2a4:	0000                	unimp
 2a6:	0000                	unimp
 2a8:	0056                	c.slli	zero,0x15
 2aa:	0000                	unimp
 2ac:	0000                	unimp
 2ae:	0000                	unimp
 2b0:	0e42                	slli	t3,t3,0x10
 2b2:	4230                	lw	a2,64(a2)
 2b4:	0288                	addi	a0,sp,320
 2b6:	0c42                	slli	s8,s8,0x10
 2b8:	0008                	0x8
 2ba:	4c02                	lw	s8,0(sp)
 2bc:	0cc8                	addi	a0,sp,596
 2be:	3002                	fld	ft0,32(sp)
 2c0:	0e42                	slli	t3,t3,0x10
 2c2:	0000                	unimp
 2c4:	0000                	unimp
 2c6:	0000                	unimp
 2c8:	002c                	addi	a1,sp,8
 2ca:	0000                	unimp
 2cc:	0138                	addi	a4,sp,136
 2ce:	0000                	unimp
 2d0:	045a                	slli	s0,s0,0x16
 2d2:	8020                	0x8020
 2d4:	0000                	unimp
 2d6:	0000                	unimp
 2d8:	006c                	addi	a1,sp,12
 2da:	0000                	unimp
 2dc:	0000                	unimp
 2de:	0000                	unimp
 2e0:	0e42                	slli	t3,t3,0x10
 2e2:	4230                	lw	a2,64(a2)
 2e4:	0288                	addi	a0,sp,320
 2e6:	0c42                	slli	s8,s8,0x10
 2e8:	0008                	0x8
 2ea:	6202                	ld	tp,0(sp)
 2ec:	0cc8                	addi	a0,sp,596
 2ee:	3002                	fld	ft0,32(sp)
 2f0:	0e42                	slli	t3,t3,0x10
 2f2:	0000                	unimp
 2f4:	0000                	unimp
 2f6:	0000                	unimp
 2f8:	002c                	addi	a1,sp,8
 2fa:	0000                	unimp
 2fc:	0138                	addi	a4,sp,136
 2fe:	0000                	unimp
 300:	04c6                	slli	s1,s1,0x11
 302:	8020                	0x8020
 304:	0000                	unimp
 306:	0000                	unimp
 308:	004e                	c.slli	zero,0x13
 30a:	0000                	unimp
 30c:	0000                	unimp
 30e:	0000                	unimp
 310:	0e42                	slli	t3,t3,0x10
 312:	4230                	lw	a2,64(a2)
 314:	0288                	addi	a0,sp,320
 316:	0c42                	slli	s8,s8,0x10
 318:	0008                	0x8
 31a:	4402                	lw	s0,0(sp)
 31c:	0cc8                	addi	a0,sp,596
 31e:	3002                	fld	ft0,32(sp)
 320:	0e42                	slli	t3,t3,0x10
 322:	0000                	unimp
 324:	0000                	unimp
 326:	0000                	unimp
 328:	002c                	addi	a1,sp,8
 32a:	0000                	unimp
 32c:	0138                	addi	a4,sp,136
 32e:	0000                	unimp
 330:	0514                	addi	a3,sp,640
 332:	8020                	0x8020
 334:	0000                	unimp
 336:	0000                	unimp
 338:	0038                	addi	a4,sp,8
 33a:	0000                	unimp
 33c:	0000                	unimp
 33e:	0000                	unimp
 340:	0e42                	slli	t3,t3,0x10
 342:	4420                	lw	s0,72(s0)
 344:	0281                	addi	t0,t0,0
 346:	0488                	addi	a0,sp,576
 348:	0c42                	slli	s8,s8,0x10
 34a:	0008                	0x8
 34c:	c16a                	sw	s10,128(sp)
 34e:	c842                	sw	a6,16(sp)
 350:	020c                	addi	a1,sp,256
 352:	4220                	lw	s0,64(a2)
 354:	000e                	c.slli	zero,0x3
 356:	0000                	unimp
 358:	000c                	0xc
 35a:	0000                	unimp
 35c:	ffff                	0xffff
 35e:	ffff                	0xffff
 360:	7c010003          	lb	zero,1984(sp)
 364:	0d01                	addi	s10,s10,0
 366:	0002                	c.slli64	zero
 368:	002c                	addi	a1,sp,8
 36a:	0000                	unimp
 36c:	0358                	addi	a4,sp,388
 36e:	0000                	unimp
 370:	054c                	addi	a1,sp,644
 372:	8020                	0x8020
 374:	0000                	unimp
 376:	0000                	unimp
 378:	003c                	addi	a5,sp,8
 37a:	0000                	unimp
 37c:	0000                	unimp
 37e:	0000                	unimp
 380:	0e42                	slli	t3,t3,0x10
 382:	4420                	lw	s0,72(s0)
 384:	0281                	addi	t0,t0,0
 386:	0488                	addi	a0,sp,576
 388:	0c42                	slli	s8,s8,0x10
 38a:	0008                	0x8
 38c:	c16e                	sw	s11,128(sp)
 38e:	c842                	sw	a6,16(sp)
 390:	020c                	addi	a1,sp,256
 392:	4220                	lw	s0,64(a2)
 394:	000e                	c.slli	zero,0x3
 396:	0000                	unimp
 398:	002c                	addi	a1,sp,8
 39a:	0000                	unimp
 39c:	0358                	addi	a4,sp,388
 39e:	0000                	unimp
 3a0:	0588                	addi	a0,sp,704
 3a2:	8020                	0x8020
 3a4:	0000                	unimp
 3a6:	0000                	unimp
 3a8:	008e                	slli	ra,ra,0x3
 3aa:	0000                	unimp
 3ac:	0000                	unimp
 3ae:	0000                	unimp
 3b0:	0e42                	slli	t3,t3,0x10
 3b2:	4230                	lw	a2,64(a2)
 3b4:	0288                	addi	a0,sp,320
 3b6:	0c42                	slli	s8,s8,0x10
 3b8:	0008                	0x8
 3ba:	8402                	jr	s0
 3bc:	0cc8                	addi	a0,sp,596
 3be:	3002                	fld	ft0,32(sp)
 3c0:	0e42                	slli	t3,t3,0x10
 3c2:	0000                	unimp
 3c4:	0000                	unimp
 3c6:	0000                	unimp
 3c8:	002c                	addi	a1,sp,8
 3ca:	0000                	unimp
 3cc:	0358                	addi	a4,sp,388
 3ce:	0000                	unimp
 3d0:	0616                	slli	a2,a2,0x5
 3d2:	8020                	0x8020
 3d4:	0000                	unimp
 3d6:	0000                	unimp
 3d8:	00b4                	addi	a3,sp,72
 3da:	0000                	unimp
 3dc:	0000                	unimp
 3de:	0000                	unimp
 3e0:	0e42                	slli	t3,t3,0x10
 3e2:	4440                	lw	s0,12(s0)
 3e4:	0281                	addi	t0,t0,0
 3e6:	0488                	addi	a0,sp,576
 3e8:	0c42                	slli	s8,s8,0x10
 3ea:	0008                	0x8
 3ec:	a602                	fsd	ft0,264(sp)
 3ee:	42c1                	li	t0,16
 3f0:	0cc8                	addi	a0,sp,596
 3f2:	4002                	0x4002
 3f4:	0e42                	slli	t3,t3,0x10
 3f6:	0000                	unimp
 3f8:	002c                	addi	a1,sp,8
 3fa:	0000                	unimp
 3fc:	0358                	addi	a4,sp,388
 3fe:	0000                	unimp
 400:	06ca                	slli	a3,a3,0x12
 402:	8020                	0x8020
 404:	0000                	unimp
 406:	0000                	unimp
 408:	00ac                	addi	a1,sp,72
 40a:	0000                	unimp
 40c:	0000                	unimp
 40e:	0000                	unimp
 410:	0e42                	slli	t3,t3,0x10
 412:	4440                	lw	s0,12(s0)
 414:	0281                	addi	t0,t0,0
 416:	0488                	addi	a0,sp,576
 418:	0c42                	slli	s8,s8,0x10
 41a:	0008                	0x8
 41c:	9e02                	jalr	t3
 41e:	42c1                	li	t0,16
 420:	0cc8                	addi	a0,sp,596
 422:	4002                	0x4002
 424:	0e42                	slli	t3,t3,0x10
 426:	0000                	unimp
 428:	002c                	addi	a1,sp,8
 42a:	0000                	unimp
 42c:	0358                	addi	a4,sp,388
 42e:	0000                	unimp
 430:	0776                	slli	a4,a4,0x1d
 432:	8020                	0x8020
 434:	0000                	unimp
 436:	0000                	unimp
 438:	009a                	slli	ra,ra,0x6
 43a:	0000                	unimp
 43c:	0000                	unimp
 43e:	0000                	unimp
 440:	0e42                	slli	t3,t3,0x10
 442:	4430                	lw	a2,72(s0)
 444:	0281                	addi	t0,t0,0
 446:	0488                	addi	a0,sp,576
 448:	0c42                	slli	s8,s8,0x10
 44a:	0008                	0x8
 44c:	8c02                	jr	s8
 44e:	42c1                	li	t0,16
 450:	0cc8                	addi	a0,sp,596
 452:	3002                	fld	ft0,32(sp)
 454:	0e42                	slli	t3,t3,0x10
 456:	0000                	unimp
 458:	000c                	0xc
 45a:	0000                	unimp
 45c:	ffff                	0xffff
 45e:	ffff                	0xffff
 460:	7c010003          	lb	zero,1984(sp)
 464:	0d01                	addi	s10,s10,0
 466:	0002                	c.slli64	zero
 468:	0024                	addi	s1,sp,8
 46a:	0000                	unimp
 46c:	0458                	addi	a4,sp,516
 46e:	0000                	unimp
 470:	0810                	addi	a2,sp,16
 472:	8020                	0x8020
 474:	0000                	unimp
 476:	0000                	unimp
 478:	004e                	c.slli	zero,0x13
 47a:	0000                	unimp
 47c:	0000                	unimp
 47e:	0000                	unimp
 480:	0e42                	slli	t3,t3,0x10
 482:	4420                	lw	s0,72(s0)
 484:	0281                	addi	t0,t0,0
 486:	0488                	addi	a0,sp,576
 488:	0c42                	slli	s8,s8,0x10
 48a:	0008                	0x8
 48c:	0000                	unimp
 48e:	0000                	unimp
 490:	000c                	0xc
 492:	0000                	unimp
 494:	ffff                	0xffff
 496:	ffff                	0xffff
 498:	7c010003          	lb	zero,1984(sp)
 49c:	0d01                	addi	s10,s10,0
 49e:	0002                	c.slli64	zero
 4a0:	0034                	addi	a3,sp,8
 4a2:	0000                	unimp
 4a4:	0490                	addi	a2,sp,576
 4a6:	0000                	unimp
 4a8:	085e                	slli	a6,a6,0x17
 4aa:	8020                	0x8020
 4ac:	0000                	unimp
 4ae:	0000                	unimp
 4b0:	0134                	addi	a3,sp,136
 4b2:	0000                	unimp
 4b4:	0000                	unimp
 4b6:	0000                	unimp
 4b8:	0e42                	slli	t3,t3,0x10
 4ba:	02c0                	addi	s0,sp,324
 4bc:	8144                	0x8144
 4be:	8802                	jr	a6
 4c0:	4204                	lw	s1,0(a2)
 4c2:	080c                	addi	a1,sp,16
 4c4:	0300                	addi	s0,sp,384
 4c6:	0126                	slli	sp,sp,0x9
 4c8:	42c1                	li	t0,16
 4ca:	0cc8                	addi	a0,sp,596
 4cc:	c002                	sw	zero,0(sp)
 4ce:	4202                	lw	tp,0(sp)
 4d0:	000e                	c.slli	zero,0x3
 4d2:	0000                	unimp
 4d4:	0000                	unimp
 4d6:	0000                	unimp
 4d8:	002c                	addi	a1,sp,8
 4da:	0000                	unimp
 4dc:	0490                	addi	a2,sp,576
 4de:	0000                	unimp
 4e0:	0992                	slli	s3,s3,0x4
 4e2:	8020                	0x8020
 4e4:	0000                	unimp
 4e6:	0000                	unimp
 4e8:	0134                	addi	a3,sp,136
 4ea:	0000                	unimp
 4ec:	0000                	unimp
 4ee:	0000                	unimp
 4f0:	0e42                	slli	t3,t3,0x10
 4f2:	4440                	lw	s0,12(s0)
 4f4:	0281                	addi	t0,t0,0
 4f6:	0488                	addi	a0,sp,576
 4f8:	0c42                	slli	s8,s8,0x10
 4fa:	0008                	0x8
 4fc:	c1012603          	lw	a2,-1008(sp)
 500:	c842                	sw	a6,16(sp)
 502:	020c                	addi	a1,sp,256
 504:	4240                	lw	s0,4(a2)
 506:	000e                	c.slli	zero,0x3
 508:	002c                	addi	a1,sp,8
 50a:	0000                	unimp
 50c:	0490                	addi	a2,sp,576
 50e:	0000                	unimp
 510:	0ac6                	slli	s5,s5,0x11
 512:	8020                	0x8020
 514:	0000                	unimp
 516:	0000                	unimp
 518:	007e                	c.slli	zero,0x1f
 51a:	0000                	unimp
 51c:	0000                	unimp
 51e:	0000                	unimp
 520:	0e42                	slli	t3,t3,0x10
 522:	4410                	lw	a2,8(s0)
 524:	0281                	addi	t0,t0,0
 526:	0488                	addi	a0,sp,576
 528:	0c42                	slli	s8,s8,0x10
 52a:	0008                	0x8
 52c:	7002                	0x7002
 52e:	42c1                	li	t0,16
 530:	0cc8                	addi	a0,sp,596
 532:	1002                	c.slli	zero,0x20
 534:	0e42                	slli	t3,t3,0x10
 536:	0000                	unimp
 538:	000c                	0xc
 53a:	0000                	unimp
 53c:	ffff                	0xffff
 53e:	ffff                	0xffff
 540:	7c010003          	lb	zero,1984(sp)
 544:	0d01                	addi	s10,s10,0
 546:	0002                	c.slli64	zero
 548:	002c                	addi	a1,sp,8
 54a:	0000                	unimp
 54c:	0538                	addi	a4,sp,648
 54e:	0000                	unimp
 550:	0b44                	addi	s1,sp,404
 552:	8020                	0x8020
 554:	0000                	unimp
 556:	0000                	unimp
 558:	00b4                	addi	a3,sp,72
 55a:	0000                	unimp
 55c:	0000                	unimp
 55e:	0000                	unimp
 560:	0e42                	slli	t3,t3,0x10
 562:	4420                	lw	s0,72(s0)
 564:	0281                	addi	t0,t0,0
 566:	0488                	addi	a0,sp,576
 568:	0c42                	slli	s8,s8,0x10
 56a:	0008                	0x8
 56c:	a602                	fsd	ft0,264(sp)
 56e:	42c1                	li	t0,16
 570:	0cc8                	addi	a0,sp,596
 572:	2002                	fld	ft0,0(sp)
 574:	0e42                	slli	t3,t3,0x10
 576:	0000                	unimp
 578:	002c                	addi	a1,sp,8
 57a:	0000                	unimp
 57c:	0538                	addi	a4,sp,648
 57e:	0000                	unimp
 580:	0bf8                	addi	a4,sp,476
 582:	8020                	0x8020
 584:	0000                	unimp
 586:	0000                	unimp
 588:	00f0                	addi	a2,sp,76
 58a:	0000                	unimp
 58c:	0000                	unimp
 58e:	0000                	unimp
 590:	0e42                	slli	t3,t3,0x10
 592:	4440                	lw	s0,12(s0)
 594:	0281                	addi	t0,t0,0
 596:	0488                	addi	a0,sp,576
 598:	0c42                	slli	s8,s8,0x10
 59a:	0008                	0x8
 59c:	e202                	sd	zero,256(sp)
 59e:	42c1                	li	t0,16
 5a0:	0cc8                	addi	a0,sp,596
 5a2:	4002                	0x4002
 5a4:	0e42                	slli	t3,t3,0x10
 5a6:	0000                	unimp
 5a8:	002c                	addi	a1,sp,8
 5aa:	0000                	unimp
 5ac:	0538                	addi	a4,sp,648
 5ae:	0000                	unimp
 5b0:	0ce8                	addi	a0,sp,604
 5b2:	8020                	0x8020
 5b4:	0000                	unimp
 5b6:	0000                	unimp
 5b8:	00be                	slli	ra,ra,0xf
 5ba:	0000                	unimp
 5bc:	0000                	unimp
 5be:	0000                	unimp
 5c0:	0e42                	slli	t3,t3,0x10
 5c2:	4430                	lw	a2,72(s0)
 5c4:	0281                	addi	t0,t0,0
 5c6:	0488                	addi	a0,sp,576
 5c8:	0c42                	slli	s8,s8,0x10
 5ca:	0008                	0x8
 5cc:	b002                	fsd	ft0,32(sp)
 5ce:	42c1                	li	t0,16
 5d0:	0cc8                	addi	a0,sp,596
 5d2:	3002                	fld	ft0,32(sp)
 5d4:	0e42                	slli	t3,t3,0x10
 5d6:	0000                	unimp
 5d8:	0034                	addi	a3,sp,8
 5da:	0000                	unimp
 5dc:	0538                	addi	a4,sp,648
 5de:	0000                	unimp
 5e0:	0da6                	slli	s11,s11,0x9
 5e2:	8020                	0x8020
 5e4:	0000                	unimp
 5e6:	0000                	unimp
 5e8:	0118                	addi	a4,sp,128
 5ea:	0000                	unimp
 5ec:	0000                	unimp
 5ee:	0000                	unimp
 5f0:	0e44                	addi	s1,sp,788
 5f2:	04d0                	addi	a2,sp,580
 5f4:	814c                	0x814c
 5f6:	8802                	jr	a6
 5f8:	8904                	0x8904
 5fa:	4206                	lw	tp,64(sp)
 5fc:	080c                	addi	a1,sp,16
 5fe:	0300                	addi	s0,sp,384
 600:	00f8                	addi	a4,sp,76
 602:	44c1                	li	s1,16
 604:	0cc8                	addi	a0,sp,596
 606:	d002                	sw	zero,32(sp)
 608:	4404                	lw	s1,8(s0)
 60a:	44c9                	li	s1,18
 60c:	000e                	c.slli	zero,0x3
 60e:	0000                	unimp
 610:	0034                	addi	a3,sp,8
 612:	0000                	unimp
 614:	0538                	addi	a4,sp,648
 616:	0000                	unimp
 618:	0ebe                	slli	t4,t4,0xf
 61a:	8020                	0x8020
 61c:	0000                	unimp
 61e:	0000                	unimp
 620:	00ae                	slli	ra,ra,0xb
 622:	0000                	unimp
 624:	0000                	unimp
 626:	0000                	unimp
 628:	0e44                	addi	s1,sp,788
 62a:	04d0                	addi	a2,sp,580
 62c:	814c                	0x814c
 62e:	8802                	jr	a6
 630:	8904                	0x8904
 632:	4206                	lw	tp,64(sp)
 634:	080c                	addi	a1,sp,16
 636:	0200                	addi	s0,sp,256
 638:	c18e                	sw	gp,192(sp)
 63a:	c844                	sw	s1,20(s0)
 63c:	020c                	addi	a1,sp,256
 63e:	04d0                	addi	a2,sp,580
 640:	c944                	sw	s1,20(a0)
 642:	0e44                	addi	s1,sp,788
 644:	0000                	unimp
 646:	0000                	unimp
 648:	002c                	addi	a1,sp,8
 64a:	0000                	unimp
 64c:	0538                	addi	a4,sp,648
 64e:	0000                	unimp
 650:	0f6c                	addi	a1,sp,924
 652:	8020                	0x8020
 654:	0000                	unimp
 656:	0000                	unimp
 658:	00fa                	slli	ra,ra,0x1e
 65a:	0000                	unimp
 65c:	0000                	unimp
 65e:	0000                	unimp
 660:	0e42                	slli	t3,t3,0x10
 662:	4450                	lw	a2,12(s0)
 664:	0281                	addi	t0,t0,0
 666:	0488                	addi	a0,sp,576
 668:	0c42                	slli	s8,s8,0x10
 66a:	0008                	0x8
 66c:	c100ec03          	lwu	s8,-1008(ra) # 3c10 <n+0x3bf0>
 670:	c842                	sw	a6,16(sp)
 672:	020c                	addi	a1,sp,256
 674:	4250                	lw	a2,4(a2)
 676:	000e                	c.slli	zero,0x3
 678:	000c                	0xc
 67a:	0000                	unimp
 67c:	ffff                	0xffff
 67e:	ffff                	0xffff
 680:	7c010003          	lb	zero,1984(sp)
 684:	0d01                	addi	s10,s10,0
 686:	0002                	c.slli64	zero
 688:	002c                	addi	a1,sp,8
 68a:	0000                	unimp
 68c:	0678                	addi	a4,sp,780
 68e:	0000                	unimp
 690:	1066                	c.slli	zero,0x39
 692:	8020                	0x8020
 694:	0000                	unimp
 696:	0000                	unimp
 698:	0028                	addi	a0,sp,8
 69a:	0000                	unimp
 69c:	0000                	unimp
 69e:	0000                	unimp
 6a0:	0e42                	slli	t3,t3,0x10
 6a2:	4420                	lw	s0,72(s0)
 6a4:	0281                	addi	t0,t0,0
 6a6:	0488                	addi	a0,sp,576
 6a8:	0c42                	slli	s8,s8,0x10
 6aa:	0008                	0x8
 6ac:	c15a                	sw	s6,128(sp)
 6ae:	c842                	sw	a6,16(sp)
 6b0:	020c                	addi	a1,sp,256
 6b2:	4220                	lw	s0,64(a2)
 6b4:	000e                	c.slli	zero,0x3
 6b6:	0000                	unimp
 6b8:	002c                	addi	a1,sp,8
 6ba:	0000                	unimp
 6bc:	0678                	addi	a4,sp,780
 6be:	0000                	unimp
 6c0:	108e                	slli	ra,ra,0x23
 6c2:	8020                	0x8020
 6c4:	0000                	unimp
 6c6:	0000                	unimp
 6c8:	0028                	addi	a0,sp,8
 6ca:	0000                	unimp
 6cc:	0000                	unimp
 6ce:	0000                	unimp
 6d0:	0e42                	slli	t3,t3,0x10
 6d2:	4420                	lw	s0,72(s0)
 6d4:	0281                	addi	t0,t0,0
 6d6:	0488                	addi	a0,sp,576
 6d8:	0c42                	slli	s8,s8,0x10
 6da:	0008                	0x8
 6dc:	c15a                	sw	s6,128(sp)
 6de:	c842                	sw	a6,16(sp)
 6e0:	020c                	addi	a1,sp,256
 6e2:	4220                	lw	s0,64(a2)
 6e4:	000e                	c.slli	zero,0x3
 6e6:	0000                	unimp
 6e8:	002c                	addi	a1,sp,8
 6ea:	0000                	unimp
 6ec:	0678                	addi	a4,sp,780
 6ee:	0000                	unimp
 6f0:	10b6                	slli	ra,ra,0x2d
 6f2:	8020                	0x8020
 6f4:	0000                	unimp
 6f6:	0000                	unimp
 6f8:	002a                	c.slli	zero,0xa
 6fa:	0000                	unimp
 6fc:	0000                	unimp
 6fe:	0000                	unimp
 700:	0e42                	slli	t3,t3,0x10
 702:	4220                	lw	s0,64(a2)
 704:	0288                	addi	a0,sp,320
 706:	0c42                	slli	s8,s8,0x10
 708:	0008                	0x8
 70a:	c860                	sw	s0,84(s0)
 70c:	020c                	addi	a1,sp,256
 70e:	4220                	lw	s0,64(a2)
 710:	000e                	c.slli	zero,0x3
 712:	0000                	unimp
 714:	0000                	unimp
 716:	0000                	unimp
 718:	002c                	addi	a1,sp,8
 71a:	0000                	unimp
 71c:	0678                	addi	a4,sp,780
 71e:	0000                	unimp
 720:	10e0                	addi	s0,sp,108
 722:	8020                	0x8020
 724:	0000                	unimp
 726:	0000                	unimp
 728:	002a                	c.slli	zero,0xa
 72a:	0000                	unimp
 72c:	0000                	unimp
 72e:	0000                	unimp
 730:	0e42                	slli	t3,t3,0x10
 732:	4220                	lw	s0,64(a2)
 734:	0288                	addi	a0,sp,320
 736:	0c42                	slli	s8,s8,0x10
 738:	0008                	0x8
 73a:	c860                	sw	s0,84(s0)
 73c:	020c                	addi	a1,sp,256
 73e:	4220                	lw	s0,64(a2)
 740:	000e                	c.slli	zero,0x3
 742:	0000                	unimp
 744:	0000                	unimp
 746:	0000                	unimp
 748:	002c                	addi	a1,sp,8
 74a:	0000                	unimp
 74c:	0678                	addi	a4,sp,780
 74e:	0000                	unimp
 750:	110a                	slli	sp,sp,0x22
 752:	8020                	0x8020
 754:	0000                	unimp
 756:	0000                	unimp
 758:	0058                	addi	a4,sp,4
 75a:	0000                	unimp
 75c:	0000                	unimp
 75e:	0000                	unimp
 760:	0e42                	slli	t3,t3,0x10
 762:	4430                	lw	a2,72(s0)
 764:	0281                	addi	t0,t0,0
 766:	0488                	addi	a0,sp,576
 768:	0c42                	slli	s8,s8,0x10
 76a:	0008                	0x8
 76c:	4a02                	lw	s4,0(sp)
 76e:	42c1                	li	t0,16
 770:	0cc8                	addi	a0,sp,596
 772:	3002                	fld	ft0,32(sp)
 774:	0e42                	slli	t3,t3,0x10
 776:	0000                	unimp
 778:	002c                	addi	a1,sp,8
 77a:	0000                	unimp
 77c:	0678                	addi	a4,sp,780
 77e:	0000                	unimp
 780:	1162                	slli	sp,sp,0x38
 782:	8020                	0x8020
 784:	0000                	unimp
 786:	0000                	unimp
 788:	0058                	addi	a4,sp,4
 78a:	0000                	unimp
 78c:	0000                	unimp
 78e:	0000                	unimp
 790:	0e42                	slli	t3,t3,0x10
 792:	4430                	lw	a2,72(s0)
 794:	0281                	addi	t0,t0,0
 796:	0488                	addi	a0,sp,576
 798:	0c42                	slli	s8,s8,0x10
 79a:	0008                	0x8
 79c:	4a02                	lw	s4,0(sp)
 79e:	42c1                	li	t0,16
 7a0:	0cc8                	addi	a0,sp,596
 7a2:	3002                	fld	ft0,32(sp)
 7a4:	0e42                	slli	t3,t3,0x10
 7a6:	0000                	unimp
 7a8:	0034                	addi	a3,sp,8
 7aa:	0000                	unimp
 7ac:	0678                	addi	a4,sp,780
 7ae:	0000                	unimp
 7b0:	11ba                	slli	gp,gp,0x2e
 7b2:	8020                	0x8020
 7b4:	0000                	unimp
 7b6:	0000                	unimp
 7b8:	0056                	c.slli	zero,0x15
 7ba:	0000                	unimp
 7bc:	0000                	unimp
 7be:	0000                	unimp
 7c0:	0e42                	slli	t3,t3,0x10
 7c2:	02d0                	addi	a2,sp,324
 7c4:	8146                	mv	sp,a7
 7c6:	8802                	jr	a6
 7c8:	8904                	0x8904
 7ca:	4206                	lw	tp,64(sp)
 7cc:	080c                	addi	a1,sp,16
 7ce:	0200                	addi	s0,sp,256
 7d0:	c144                	sw	s1,4(a0)
 7d2:	c842                	sw	a6,16(sp)
 7d4:	020c                	addi	a1,sp,256
 7d6:	02d0                	addi	a2,sp,324
 7d8:	c942                	sw	a6,144(sp)
 7da:	0e42                	slli	t3,t3,0x10
 7dc:	0000                	unimp
 7de:	0000                	unimp
 7e0:	000c                	0xc
 7e2:	0000                	unimp
 7e4:	ffff                	0xffff
 7e6:	ffff                	0xffff
 7e8:	7c010003          	lb	zero,1984(sp)
 7ec:	0d01                	addi	s10,s10,0
 7ee:	0002                	c.slli64	zero
 7f0:	002c                	addi	a1,sp,8
 7f2:	0000                	unimp
 7f4:	07e0                	addi	s0,sp,972
 7f6:	0000                	unimp
 7f8:	1210                	addi	a2,sp,288
 7fa:	8020                	0x8020
 7fc:	0000                	unimp
 7fe:	0000                	unimp
 800:	0030                	addi	a2,sp,8
 802:	0000                	unimp
 804:	0000                	unimp
 806:	0000                	unimp
 808:	0e42                	slli	t3,t3,0x10
 80a:	4230                	lw	a2,64(a2)
 80c:	0288                	addi	a0,sp,320
 80e:	0c42                	slli	s8,s8,0x10
 810:	0008                	0x8
 812:	c866                	sw	s9,16(sp)
 814:	020c                	addi	a1,sp,256
 816:	4230                	lw	a2,64(a2)
 818:	000e                	c.slli	zero,0x3
 81a:	0000                	unimp
 81c:	0000                	unimp
 81e:	0000                	unimp
 820:	002c                	addi	a1,sp,8
 822:	0000                	unimp
 824:	07e0                	addi	s0,sp,972
 826:	0000                	unimp
 828:	1240                	addi	s0,sp,292
 82a:	8020                	0x8020
 82c:	0000                	unimp
 82e:	0000                	unimp
 830:	001a                	c.slli	zero,0x6
 832:	0000                	unimp
 834:	0000                	unimp
 836:	0000                	unimp
 838:	0e42                	slli	t3,t3,0x10
 83a:	4220                	lw	s0,64(a2)
 83c:	0288                	addi	a0,sp,320
 83e:	0c42                	slli	s8,s8,0x10
 840:	0008                	0x8
 842:	c850                	sw	a2,20(s0)
 844:	020c                	addi	a1,sp,256
 846:	4220                	lw	s0,64(a2)
 848:	000e                	c.slli	zero,0x3
 84a:	0000                	unimp
 84c:	0000                	unimp
 84e:	0000                	unimp
 850:	002c                	addi	a1,sp,8
 852:	0000                	unimp
 854:	07e0                	addi	s0,sp,972
 856:	0000                	unimp
 858:	125a                	slli	tp,tp,0x36
 85a:	8020                	0x8020
 85c:	0000                	unimp
 85e:	0000                	unimp
 860:	0020                	addi	s0,sp,8
 862:	0000                	unimp
 864:	0000                	unimp
 866:	0000                	unimp
 868:	0e42                	slli	t3,t3,0x10
 86a:	4220                	lw	s0,64(a2)
 86c:	0288                	addi	a0,sp,320
 86e:	0c42                	slli	s8,s8,0x10
 870:	0008                	0x8
 872:	c856                	sw	s5,16(sp)
 874:	020c                	addi	a1,sp,256
 876:	4220                	lw	s0,64(a2)
 878:	000e                	c.slli	zero,0x3
 87a:	0000                	unimp
 87c:	0000                	unimp
 87e:	0000                	unimp
 880:	0034                	addi	a3,sp,8
 882:	0000                	unimp
 884:	07e0                	addi	s0,sp,972
 886:	0000                	unimp
 888:	127a                	slli	tp,tp,0x3e
 88a:	8020                	0x8020
 88c:	0000                	unimp
 88e:	0000                	unimp
 890:	0098                	addi	a4,sp,64
 892:	0000                	unimp
 894:	0000                	unimp
 896:	0000                	unimp
 898:	0e42                	slli	t3,t3,0x10
 89a:	02d0                	addi	a2,sp,324
 89c:	8144                	0x8144
 89e:	8802                	jr	a6
 8a0:	4204                	lw	s1,0(a2)
 8a2:	080c                	addi	a1,sp,16
 8a4:	0200                	addi	s0,sp,256
 8a6:	c18a                	sw	sp,192(sp)
 8a8:	c842                	sw	a6,16(sp)
 8aa:	020c                	addi	a1,sp,256
 8ac:	02d0                	addi	a2,sp,324
 8ae:	0e42                	slli	t3,t3,0x10
	...
 8b8:	000c                	0xc
 8ba:	0000                	unimp
 8bc:	ffff                	0xffff
 8be:	ffff                	0xffff
 8c0:	7c010003          	lb	zero,1984(sp)
 8c4:	0d01                	addi	s10,s10,0
 8c6:	0002                	c.slli64	zero
 8c8:	002c                	addi	a1,sp,8
 8ca:	0000                	unimp
 8cc:	08b8                	addi	a4,sp,88
 8ce:	0000                	unimp
 8d0:	1312                	slli	t1,t1,0x24
 8d2:	8020                	0x8020
 8d4:	0000                	unimp
 8d6:	0000                	unimp
 8d8:	003c                	addi	a5,sp,8
 8da:	0000                	unimp
 8dc:	0000                	unimp
 8de:	0000                	unimp
 8e0:	0e42                	slli	t3,t3,0x10
 8e2:	4420                	lw	s0,72(s0)
 8e4:	0281                	addi	t0,t0,0
 8e6:	0488                	addi	a0,sp,576
 8e8:	0c42                	slli	s8,s8,0x10
 8ea:	0008                	0x8
 8ec:	c16e                	sw	s11,128(sp)
 8ee:	c842                	sw	a6,16(sp)
 8f0:	020c                	addi	a1,sp,256
 8f2:	4220                	lw	s0,64(a2)
 8f4:	000e                	c.slli	zero,0x3
 8f6:	0000                	unimp
 8f8:	002c                	addi	a1,sp,8
 8fa:	0000                	unimp
 8fc:	08b8                	addi	a4,sp,88
 8fe:	0000                	unimp
 900:	134e                	slli	t1,t1,0x33
 902:	8020                	0x8020
 904:	0000                	unimp
 906:	0000                	unimp
 908:	0096                	slli	ra,ra,0x5
 90a:	0000                	unimp
 90c:	0000                	unimp
 90e:	0000                	unimp
 910:	0e42                	slli	t3,t3,0x10
 912:	4440                	lw	s0,12(s0)
 914:	0281                	addi	t0,t0,0
 916:	0488                	addi	a0,sp,576
 918:	0c42                	slli	s8,s8,0x10
 91a:	0008                	0x8
 91c:	8802                	jr	a6
 91e:	42c1                	li	t0,16
 920:	0cc8                	addi	a0,sp,596
 922:	4002                	0x4002
 924:	0e42                	slli	t3,t3,0x10
 926:	0000                	unimp
 928:	002c                	addi	a1,sp,8
 92a:	0000                	unimp
 92c:	08b8                	addi	a4,sp,88
 92e:	0000                	unimp
 930:	13e4                	addi	s1,sp,492
 932:	8020                	0x8020
 934:	0000                	unimp
 936:	0000                	unimp
 938:	0238                	addi	a4,sp,264
 93a:	0000                	unimp
 93c:	0000                	unimp
 93e:	0000                	unimp
 940:	0e42                	slli	t3,t3,0x10
 942:	4460                	lw	s0,76(s0)
 944:	0281                	addi	t0,t0,0
 946:	0488                	addi	a0,sp,576
 948:	0c42                	slli	s8,s8,0x10
 94a:	0008                	0x8
 94c:	c1022a03          	lw	s4,-1008(tp) # fffffffffffe0c10 <ebss+0xffffffff7fd85cc8>
 950:	c842                	sw	a6,16(sp)
 952:	020c                	addi	a1,sp,256
 954:	4260                	lw	s0,68(a2)
 956:	000e                	c.slli	zero,0x3
 958:	000c                	0xc
 95a:	0000                	unimp
 95c:	ffff                	0xffff
 95e:	ffff                	0xffff
 960:	7c010003          	lb	zero,1984(sp)
 964:	0d01                	addi	s10,s10,0
 966:	0002                	c.slli64	zero
 968:	002c                	addi	a1,sp,8
 96a:	0000                	unimp
 96c:	0958                	addi	a4,sp,148
 96e:	0000                	unimp
 970:	161c                	addi	a5,sp,800
 972:	8020                	0x8020
 974:	0000                	unimp
 976:	0000                	unimp
 978:	003e                	c.slli	zero,0xf
 97a:	0000                	unimp
 97c:	0000                	unimp
 97e:	0000                	unimp
 980:	0e42                	slli	t3,t3,0x10
 982:	4420                	lw	s0,72(s0)
 984:	0281                	addi	t0,t0,0
 986:	0488                	addi	a0,sp,576
 988:	0c42                	slli	s8,s8,0x10
 98a:	0008                	0x8
 98c:	c170                	sw	a2,68(a0)
 98e:	c842                	sw	a6,16(sp)
 990:	020c                	addi	a1,sp,256
 992:	4220                	lw	s0,64(a2)
 994:	000e                	c.slli	zero,0x3
 996:	0000                	unimp
 998:	002c                	addi	a1,sp,8
 99a:	0000                	unimp
 99c:	0958                	addi	a4,sp,148
 99e:	0000                	unimp
 9a0:	165a                	slli	a2,a2,0x36
 9a2:	8020                	0x8020
 9a4:	0000                	unimp
 9a6:	0000                	unimp
 9a8:	0050                	addi	a2,sp,4
 9aa:	0000                	unimp
 9ac:	0000                	unimp
 9ae:	0000                	unimp
 9b0:	0e42                	slli	t3,t3,0x10
 9b2:	4430                	lw	a2,72(s0)
 9b4:	0281                	addi	t0,t0,0
 9b6:	0488                	addi	a0,sp,576
 9b8:	0c42                	slli	s8,s8,0x10
 9ba:	0008                	0x8
 9bc:	4202                	lw	tp,0(sp)
 9be:	42c1                	li	t0,16
 9c0:	0cc8                	addi	a0,sp,596
 9c2:	3002                	fld	ft0,32(sp)
 9c4:	0e42                	slli	t3,t3,0x10
 9c6:	0000                	unimp
 9c8:	002c                	addi	a1,sp,8
 9ca:	0000                	unimp
 9cc:	0958                	addi	a4,sp,148
 9ce:	0000                	unimp
 9d0:	16aa                	slli	a3,a3,0x2a
 9d2:	8020                	0x8020
 9d4:	0000                	unimp
 9d6:	0000                	unimp
 9d8:	0026                	c.slli	zero,0x9
 9da:	0000                	unimp
 9dc:	0000                	unimp
 9de:	0000                	unimp
 9e0:	0e42                	slli	t3,t3,0x10
 9e2:	4410                	lw	a2,8(s0)
 9e4:	0281                	addi	t0,t0,0
 9e6:	0488                	addi	a0,sp,576
 9e8:	0c42                	slli	s8,s8,0x10
 9ea:	0008                	0x8
 9ec:	c158                	sw	a4,4(a0)
 9ee:	c842                	sw	a6,16(sp)
 9f0:	020c                	addi	a1,sp,256
 9f2:	4210                	lw	a2,0(a2)
 9f4:	000e                	c.slli	zero,0x3
 9f6:	0000                	unimp
 9f8:	002c                	addi	a1,sp,8
 9fa:	0000                	unimp
 9fc:	0958                	addi	a4,sp,148
 9fe:	0000                	unimp
 a00:	16d0                	addi	a2,sp,868
 a02:	8020                	0x8020
 a04:	0000                	unimp
 a06:	0000                	unimp
 a08:	0030                	addi	a2,sp,8
 a0a:	0000                	unimp
 a0c:	0000                	unimp
 a0e:	0000                	unimp
 a10:	0e42                	slli	t3,t3,0x10
 a12:	4430                	lw	a2,72(s0)
 a14:	0281                	addi	t0,t0,0
 a16:	0488                	addi	a0,sp,576
 a18:	0c42                	slli	s8,s8,0x10
 a1a:	0008                	0x8
 a1c:	c162                	sw	s8,128(sp)
 a1e:	c842                	sw	a6,16(sp)
 a20:	020c                	addi	a1,sp,256
 a22:	4230                	lw	a2,64(a2)
 a24:	000e                	c.slli	zero,0x3
 a26:	0000                	unimp
 a28:	002c                	addi	a1,sp,8
 a2a:	0000                	unimp
 a2c:	0958                	addi	a4,sp,148
 a2e:	0000                	unimp
 a30:	1700                	addi	s0,sp,928
 a32:	8020                	0x8020
 a34:	0000                	unimp
 a36:	0000                	unimp
 a38:	0022                	c.slli	zero,0x8
 a3a:	0000                	unimp
 a3c:	0000                	unimp
 a3e:	0000                	unimp
 a40:	0e42                	slli	t3,t3,0x10
 a42:	4420                	lw	s0,72(s0)
 a44:	0281                	addi	t0,t0,0
 a46:	0488                	addi	a0,sp,576
 a48:	0c42                	slli	s8,s8,0x10
 a4a:	0008                	0x8
 a4c:	c154                	sw	a3,4(a0)
 a4e:	c842                	sw	a6,16(sp)
 a50:	020c                	addi	a1,sp,256
 a52:	4220                	lw	s0,64(a2)
 a54:	000e                	c.slli	zero,0x3
 a56:	0000                	unimp
 a58:	002c                	addi	a1,sp,8
 a5a:	0000                	unimp
 a5c:	0958                	addi	a4,sp,148
 a5e:	0000                	unimp
 a60:	1722                	slli	a4,a4,0x28
 a62:	8020                	0x8020
 a64:	0000                	unimp
 a66:	0000                	unimp
 a68:	0018                	0x18
 a6a:	0000                	unimp
 a6c:	0000                	unimp
 a6e:	0000                	unimp
 a70:	0e42                	slli	t3,t3,0x10
 a72:	4410                	lw	a2,8(s0)
 a74:	0281                	addi	t0,t0,0
 a76:	0488                	addi	a0,sp,576
 a78:	0c42                	slli	s8,s8,0x10
 a7a:	0008                	0x8
 a7c:	c14a                	sw	s2,128(sp)
 a7e:	c842                	sw	a6,16(sp)
 a80:	020c                	addi	a1,sp,256
 a82:	4210                	lw	a2,0(a2)
 a84:	000e                	c.slli	zero,0x3
 a86:	0000                	unimp
 a88:	002c                	addi	a1,sp,8
 a8a:	0000                	unimp
 a8c:	0958                	addi	a4,sp,148
 a8e:	0000                	unimp
 a90:	173a                	slli	a4,a4,0x2e
 a92:	8020                	0x8020
 a94:	0000                	unimp
 a96:	0000                	unimp
 a98:	00ba                	slli	ra,ra,0xe
 a9a:	0000                	unimp
 a9c:	0000                	unimp
 a9e:	0000                	unimp
 aa0:	0e42                	slli	t3,t3,0x10
 aa2:	4420                	lw	s0,72(s0)
 aa4:	0281                	addi	t0,t0,0
 aa6:	0488                	addi	a0,sp,576
 aa8:	0c42                	slli	s8,s8,0x10
 aaa:	0008                	0x8
 aac:	ac02                	fsd	ft0,24(sp)
 aae:	42c1                	li	t0,16
 ab0:	0cc8                	addi	a0,sp,596
 ab2:	2002                	fld	ft0,0(sp)
 ab4:	0e42                	slli	t3,t3,0x10
 ab6:	0000                	unimp
 ab8:	000c                	0xc
 aba:	0000                	unimp
 abc:	ffff                	0xffff
 abe:	ffff                	0xffff
 ac0:	7c010003          	lb	zero,1984(sp)
 ac4:	0d01                	addi	s10,s10,0
 ac6:	0002                	c.slli64	zero
 ac8:	002c                	addi	a1,sp,8
 aca:	0000                	unimp
 acc:	0ab8                	addi	a4,sp,344
 ace:	0000                	unimp
 ad0:	17f4                	addi	a3,sp,1004
 ad2:	8020                	0x8020
 ad4:	0000                	unimp
 ad6:	0000                	unimp
 ad8:	001a                	c.slli	zero,0x6
 ada:	0000                	unimp
 adc:	0000                	unimp
 ade:	0000                	unimp
 ae0:	0e42                	slli	t3,t3,0x10
 ae2:	4220                	lw	s0,64(a2)
 ae4:	0288                	addi	a0,sp,320
 ae6:	0c42                	slli	s8,s8,0x10
 ae8:	0008                	0x8
 aea:	c850                	sw	a2,20(s0)
 aec:	020c                	addi	a1,sp,256
 aee:	4220                	lw	s0,64(a2)
 af0:	000e                	c.slli	zero,0x3
 af2:	0000                	unimp
 af4:	0000                	unimp
 af6:	0000                	unimp
 af8:	002c                	addi	a1,sp,8
 afa:	0000                	unimp
 afc:	0ab8                	addi	a4,sp,344
 afe:	0000                	unimp
 b00:	180e                	slli	a6,a6,0x23
 b02:	8020                	0x8020
 b04:	0000                	unimp
 b06:	0000                	unimp
 b08:	0026                	c.slli	zero,0x9
 b0a:	0000                	unimp
 b0c:	0000                	unimp
 b0e:	0000                	unimp
 b10:	0e42                	slli	t3,t3,0x10
 b12:	4410                	lw	a2,8(s0)
 b14:	0281                	addi	t0,t0,0
 b16:	0488                	addi	a0,sp,576
 b18:	0c42                	slli	s8,s8,0x10
 b1a:	0008                	0x8
 b1c:	c158                	sw	a4,4(a0)
 b1e:	c842                	sw	a6,16(sp)
 b20:	020c                	addi	a1,sp,256
 b22:	4210                	lw	a2,0(a2)
 b24:	000e                	c.slli	zero,0x3
 b26:	0000                	unimp
 b28:	002c                	addi	a1,sp,8
 b2a:	0000                	unimp
 b2c:	0ab8                	addi	a4,sp,344
 b2e:	0000                	unimp
 b30:	1834                	addi	a3,sp,56
 b32:	8020                	0x8020
 b34:	0000                	unimp
 b36:	0000                	unimp
 b38:	0022                	c.slli	zero,0x8
 b3a:	0000                	unimp
 b3c:	0000                	unimp
 b3e:	0000                	unimp
 b40:	0e42                	slli	t3,t3,0x10
 b42:	4410                	lw	a2,8(s0)
 b44:	0281                	addi	t0,t0,0
 b46:	0488                	addi	a0,sp,576
 b48:	0c42                	slli	s8,s8,0x10
 b4a:	0008                	0x8
 b4c:	c154                	sw	a3,4(a0)
 b4e:	c842                	sw	a6,16(sp)
 b50:	020c                	addi	a1,sp,256
 b52:	4210                	lw	a2,0(a2)
 b54:	000e                	c.slli	zero,0x3
 b56:	0000                	unimp
 b58:	002c                	addi	a1,sp,8
 b5a:	0000                	unimp
 b5c:	0ab8                	addi	a4,sp,344
 b5e:	0000                	unimp
 b60:	1856                	slli	a6,a6,0x35
 b62:	8020                	0x8020
 b64:	0000                	unimp
 b66:	0000                	unimp
 b68:	002e                	c.slli	zero,0xb
 b6a:	0000                	unimp
 b6c:	0000                	unimp
 b6e:	0000                	unimp
 b70:	0e42                	slli	t3,t3,0x10
 b72:	4410                	lw	a2,8(s0)
 b74:	0281                	addi	t0,t0,0
 b76:	0488                	addi	a0,sp,576
 b78:	0c42                	slli	s8,s8,0x10
 b7a:	0008                	0x8
 b7c:	c160                	sw	s0,68(a0)
 b7e:	c842                	sw	a6,16(sp)
 b80:	020c                	addi	a1,sp,256
 b82:	4210                	lw	a2,0(a2)
 b84:	000e                	c.slli	zero,0x3
	...
