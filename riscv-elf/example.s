
../riscv-elf/example.riscv：     文件格式 elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	addi	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	4c8000ef          	jal	ra,105c4 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11768 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	6f0000ef          	jal	ra,10804 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	6ec50513          	addi	a0,a0,1772 # 106ec <__libc_fini_array>
   10128:	6200006f          	j	10748 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00001197          	auipc	gp,0x1
   10134:	6f018193          	addi	gp,gp,1776 # 11820 <__global_pointer$>
   10138:	f6018513          	addi	a0,gp,-160 # 11780 <completed.1>
   1013c:	fa018613          	addi	a2,gp,-96 # 117c0 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	3a0000ef          	jal	ra,104e8 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	5fc50513          	addi	a0,a0,1532 # 10748 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	59450513          	addi	a0,a0,1428 # 106ec <__libc_fini_array>
   10160:	5e8000ef          	jal	ra,10748 <atexit>
   10164:	2e8000ef          	jal	ra,1044c <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	addi	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	10c000ef          	jal	ra,10280 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	addi	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11780 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00011537          	lui	a0,0x11
   1019c:	00050513          	mv	a0,a0
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11780 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	addi	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00011537          	lui	a0,0x11
   101cc:	f6818593          	addi	a1,gp,-152 # 11788 <object.0>
   101d0:	00050513          	mv	a0,a0
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <CAS>:
   101e0:	fb010113          	addi	sp,sp,-80
   101e4:	04113423          	sd	ra,72(sp)
   101e8:	04813023          	sd	s0,64(sp)
   101ec:	05010413          	addi	s0,sp,80
   101f0:	fca43423          	sd	a0,-56(s0)
   101f4:	fcb43023          	sd	a1,-64(s0)
   101f8:	fac43c23          	sd	a2,-72(s0)
   101fc:	fe042623          	sw	zero,-20(s0)
   10200:	fc843783          	ld	a5,-56(s0)
   10204:	fef43023          	sd	a5,-32(s0)
   10208:	06400793          	li	a5,100
   1020c:	fcf43c23          	sd	a5,-40(s0)
   10210:	fc843783          	ld	a5,-56(s0)
   10214:	1007b7af          	lr.d	a5,(a5)
   10218:	fcf43c23          	sd	a5,-40(s0)
   1021c:	fd843783          	ld	a5,-40(s0)
   10220:	0007879b          	sext.w	a5,a5
   10224:	00078513          	mv	a0,a5
   10228:	120000ef          	jal	ra,10348 <print_d>
   1022c:	fd843703          	ld	a4,-40(s0)
   10230:	fb843783          	ld	a5,-72(s0)
   10234:	00f70863          	beq	a4,a5,10244 <CAS+0x64>
   10238:	fe042623          	sw	zero,-20(s0)
   1023c:	fec42783          	lw	a5,-20(s0)
   10240:	02c0006f          	j	1026c <CAS+0x8c>
   10244:	fc843783          	ld	a5,-56(s0)
   10248:	fc043703          	ld	a4,-64(s0)
   1024c:	18e7b7af          	sc.d	a5,a4,(a5)
   10250:	fcf43823          	sd	a5,-48(s0)
   10254:	fd043783          	ld	a5,-48(s0)
   10258:	00078463          	beqz	a5,10260 <CAS+0x80>
   1025c:	fb5ff06f          	j	10210 <CAS+0x30>
   10260:	00100793          	li	a5,1
   10264:	fef42623          	sw	a5,-20(s0)
   10268:	fec42783          	lw	a5,-20(s0)
   1026c:	00078513          	mv	a0,a5
   10270:	04813083          	ld	ra,72(sp)
   10274:	04013403          	ld	s0,64(sp)
   10278:	05010113          	addi	sp,sp,80
   1027c:	00008067          	ret

0000000000010280 <main>:
   10280:	fe010113          	addi	sp,sp,-32
   10284:	00113c23          	sd	ra,24(sp)
   10288:	00813823          	sd	s0,16(sp)
   1028c:	02010413          	addi	s0,sp,32
   10290:	00100713          	li	a4,1
   10294:	f8e1bc23          	sd	a4,-104(gp) # 117b8 <dst>
   10298:	fe042623          	sw	zero,-20(s0)
   1029c:	0800006f          	j	1031c <main+0x9c>
   102a0:	fec42783          	lw	a5,-20(s0)
   102a4:	00078613          	mv	a2,a5
   102a8:	0d300593          	li	a1,211
   102ac:	f9818513          	addi	a0,gp,-104 # 117b8 <dst>
   102b0:	f31ff0ef          	jal	ra,101e0 <CAS>
   102b4:	00050793          	mv	a5,a0
   102b8:	fef42423          	sw	a5,-24(s0)
   102bc:	fe842783          	lw	a5,-24(s0)
   102c0:	0007879b          	sext.w	a5,a5
   102c4:	00078a63          	beqz	a5,102d8 <main+0x58>
   102c8:	000117b7          	lui	a5,0x11
   102cc:	84078513          	addi	a0,a5,-1984 # 10840 <__errno+0xc>
   102d0:	0a4000ef          	jal	ra,10374 <print_s>
   102d4:	0100006f          	j	102e4 <main+0x64>
   102d8:	000117b7          	lui	a5,0x11
   102dc:	85078513          	addi	a0,a5,-1968 # 10850 <__errno+0x1c>
   102e0:	094000ef          	jal	ra,10374 <print_s>
   102e4:	fe842783          	lw	a5,-24(s0)
   102e8:	00078513          	mv	a0,a5
   102ec:	05c000ef          	jal	ra,10348 <print_d>
   102f0:	00a00513          	li	a0,10
   102f4:	0a8000ef          	jal	ra,1039c <print_c>
   102f8:	f981b783          	ld	a5,-104(gp) # 117b8 <dst>
   102fc:	0007879b          	sext.w	a5,a5
   10300:	00078513          	mv	a0,a5
   10304:	044000ef          	jal	ra,10348 <print_d>
   10308:	00a00513          	li	a0,10
   1030c:	090000ef          	jal	ra,1039c <print_c>
   10310:	fec42783          	lw	a5,-20(s0)
   10314:	0017879b          	addiw	a5,a5,1
   10318:	fef42623          	sw	a5,-20(s0)
   1031c:	fec42783          	lw	a5,-20(s0)
   10320:	0007871b          	sext.w	a4,a5
   10324:	00100793          	li	a5,1
   10328:	f6e7dce3          	bge	a5,a4,102a0 <main+0x20>
   1032c:	09c000ef          	jal	ra,103c8 <exit_proc>
   10330:	00000793          	li	a5,0
   10334:	00078513          	mv	a0,a5
   10338:	01813083          	ld	ra,24(sp)
   1033c:	01013403          	ld	s0,16(sp)
   10340:	02010113          	addi	sp,sp,32
   10344:	00008067          	ret

0000000000010348 <print_d>:
   10348:	fe010113          	addi	sp,sp,-32
   1034c:	00813c23          	sd	s0,24(sp)
   10350:	02010413          	addi	s0,sp,32
   10354:	00050793          	mv	a5,a0
   10358:	fef42623          	sw	a5,-20(s0)
   1035c:	00200893          	li	a7,2
   10360:	00000073          	ecall
   10364:	00000013          	nop
   10368:	01813403          	ld	s0,24(sp)
   1036c:	02010113          	addi	sp,sp,32
   10370:	00008067          	ret

0000000000010374 <print_s>:
   10374:	fe010113          	addi	sp,sp,-32
   10378:	00813c23          	sd	s0,24(sp)
   1037c:	02010413          	addi	s0,sp,32
   10380:	fea43423          	sd	a0,-24(s0)
   10384:	00000893          	li	a7,0
   10388:	00000073          	ecall
   1038c:	00000013          	nop
   10390:	01813403          	ld	s0,24(sp)
   10394:	02010113          	addi	sp,sp,32
   10398:	00008067          	ret

000000000001039c <print_c>:
   1039c:	fe010113          	addi	sp,sp,-32
   103a0:	00813c23          	sd	s0,24(sp)
   103a4:	02010413          	addi	s0,sp,32
   103a8:	00050793          	mv	a5,a0
   103ac:	fef407a3          	sb	a5,-17(s0)
   103b0:	00100893          	li	a7,1
   103b4:	00000073          	ecall
   103b8:	00000013          	nop
   103bc:	01813403          	ld	s0,24(sp)
   103c0:	02010113          	addi	sp,sp,32
   103c4:	00008067          	ret

00000000000103c8 <exit_proc>:
   103c8:	ff010113          	addi	sp,sp,-16
   103cc:	00813423          	sd	s0,8(sp)
   103d0:	01010413          	addi	s0,sp,16
   103d4:	00300893          	li	a7,3
   103d8:	00000073          	ecall
   103dc:	00000013          	nop
   103e0:	00813403          	ld	s0,8(sp)
   103e4:	01010113          	addi	sp,sp,16
   103e8:	00008067          	ret

00000000000103ec <read_char>:
   103ec:	fe010113          	addi	sp,sp,-32
   103f0:	00813c23          	sd	s0,24(sp)
   103f4:	02010413          	addi	s0,sp,32
   103f8:	00400893          	li	a7,4
   103fc:	00000073          	ecall
   10400:	00050793          	mv	a5,a0
   10404:	fef407a3          	sb	a5,-17(s0)
   10408:	fef44783          	lbu	a5,-17(s0)
   1040c:	00078513          	mv	a0,a5
   10410:	01813403          	ld	s0,24(sp)
   10414:	02010113          	addi	sp,sp,32
   10418:	00008067          	ret

000000000001041c <read_num>:
   1041c:	fe010113          	addi	sp,sp,-32
   10420:	00813c23          	sd	s0,24(sp)
   10424:	02010413          	addi	s0,sp,32
   10428:	00500893          	li	a7,5
   1042c:	00000073          	ecall
   10430:	00050793          	mv	a5,a0
   10434:	fef43423          	sd	a5,-24(s0)
   10438:	fe843783          	ld	a5,-24(s0)
   1043c:	00078513          	mv	a0,a5
   10440:	01813403          	ld	s0,24(sp)
   10444:	02010113          	addi	sp,sp,32
   10448:	00008067          	ret

000000000001044c <__libc_init_array>:
   1044c:	fe010113          	addi	sp,sp,-32
   10450:	00813823          	sd	s0,16(sp)
   10454:	000117b7          	lui	a5,0x11
   10458:	00011437          	lui	s0,0x11
   1045c:	01213023          	sd	s2,0(sp)
   10460:	00478793          	addi	a5,a5,4 # 11004 <__preinit_array_end>
   10464:	00440713          	addi	a4,s0,4 # 11004 <__preinit_array_end>
   10468:	00113c23          	sd	ra,24(sp)
   1046c:	00913423          	sd	s1,8(sp)
   10470:	40e78933          	sub	s2,a5,a4
   10474:	02e78263          	beq	a5,a4,10498 <__libc_init_array+0x4c>
   10478:	40395913          	srai	s2,s2,0x3
   1047c:	00440413          	addi	s0,s0,4
   10480:	00000493          	li	s1,0
   10484:	00043783          	ld	a5,0(s0)
   10488:	00148493          	addi	s1,s1,1
   1048c:	00840413          	addi	s0,s0,8
   10490:	000780e7          	jalr	a5
   10494:	ff24e8e3          	bltu	s1,s2,10484 <__libc_init_array+0x38>
   10498:	00011437          	lui	s0,0x11
   1049c:	000117b7          	lui	a5,0x11
   104a0:	01878793          	addi	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   104a4:	00840713          	addi	a4,s0,8 # 11008 <__init_array_start>
   104a8:	40e78933          	sub	s2,a5,a4
   104ac:	40395913          	srai	s2,s2,0x3
   104b0:	02e78063          	beq	a5,a4,104d0 <__libc_init_array+0x84>
   104b4:	00840413          	addi	s0,s0,8
   104b8:	00000493          	li	s1,0
   104bc:	00043783          	ld	a5,0(s0)
   104c0:	00148493          	addi	s1,s1,1
   104c4:	00840413          	addi	s0,s0,8
   104c8:	000780e7          	jalr	a5
   104cc:	ff24e8e3          	bltu	s1,s2,104bc <__libc_init_array+0x70>
   104d0:	01813083          	ld	ra,24(sp)
   104d4:	01013403          	ld	s0,16(sp)
   104d8:	00813483          	ld	s1,8(sp)
   104dc:	00013903          	ld	s2,0(sp)
   104e0:	02010113          	addi	sp,sp,32
   104e4:	00008067          	ret

00000000000104e8 <memset>:
   104e8:	00f00313          	li	t1,15
   104ec:	00050713          	mv	a4,a0
   104f0:	02c37a63          	bgeu	t1,a2,10524 <memset+0x3c>
   104f4:	00f77793          	andi	a5,a4,15
   104f8:	0a079063          	bnez	a5,10598 <memset+0xb0>
   104fc:	06059e63          	bnez	a1,10578 <memset+0x90>
   10500:	ff067693          	andi	a3,a2,-16
   10504:	00f67613          	andi	a2,a2,15
   10508:	00e686b3          	add	a3,a3,a4
   1050c:	00b73023          	sd	a1,0(a4)
   10510:	00b73423          	sd	a1,8(a4)
   10514:	01070713          	addi	a4,a4,16
   10518:	fed76ae3          	bltu	a4,a3,1050c <memset+0x24>
   1051c:	00061463          	bnez	a2,10524 <memset+0x3c>
   10520:	00008067          	ret
   10524:	40c306b3          	sub	a3,t1,a2
   10528:	00269693          	slli	a3,a3,0x2
   1052c:	00000297          	auipc	t0,0x0
   10530:	005686b3          	add	a3,a3,t0
   10534:	00c68067          	jr	12(a3)
   10538:	00b70723          	sb	a1,14(a4)
   1053c:	00b706a3          	sb	a1,13(a4)
   10540:	00b70623          	sb	a1,12(a4)
   10544:	00b705a3          	sb	a1,11(a4)
   10548:	00b70523          	sb	a1,10(a4)
   1054c:	00b704a3          	sb	a1,9(a4)
   10550:	00b70423          	sb	a1,8(a4)
   10554:	00b703a3          	sb	a1,7(a4)
   10558:	00b70323          	sb	a1,6(a4)
   1055c:	00b702a3          	sb	a1,5(a4)
   10560:	00b70223          	sb	a1,4(a4)
   10564:	00b701a3          	sb	a1,3(a4)
   10568:	00b70123          	sb	a1,2(a4)
   1056c:	00b700a3          	sb	a1,1(a4)
   10570:	00b70023          	sb	a1,0(a4)
   10574:	00008067          	ret
   10578:	0ff5f593          	zext.b	a1,a1
   1057c:	00859693          	slli	a3,a1,0x8
   10580:	00d5e5b3          	or	a1,a1,a3
   10584:	01059693          	slli	a3,a1,0x10
   10588:	00d5e5b3          	or	a1,a1,a3
   1058c:	02059693          	slli	a3,a1,0x20
   10590:	00d5e5b3          	or	a1,a1,a3
   10594:	f6dff06f          	j	10500 <memset+0x18>
   10598:	00279693          	slli	a3,a5,0x2
   1059c:	00000297          	auipc	t0,0x0
   105a0:	005686b3          	add	a3,a3,t0
   105a4:	00008293          	mv	t0,ra
   105a8:	f98680e7          	jalr	-104(a3)
   105ac:	00028093          	mv	ra,t0
   105b0:	ff078793          	addi	a5,a5,-16
   105b4:	40f70733          	sub	a4,a4,a5
   105b8:	00f60633          	add	a2,a2,a5
   105bc:	f6c374e3          	bgeu	t1,a2,10524 <memset+0x3c>
   105c0:	f3dff06f          	j	104fc <memset+0x14>

00000000000105c4 <__call_exitprocs>:
   105c4:	fb010113          	addi	sp,sp,-80
   105c8:	03413023          	sd	s4,32(sp)
   105cc:	f481ba03          	ld	s4,-184(gp) # 11768 <_global_impure_ptr>
   105d0:	03213823          	sd	s2,48(sp)
   105d4:	04113423          	sd	ra,72(sp)
   105d8:	1f8a3903          	ld	s2,504(s4)
   105dc:	04813023          	sd	s0,64(sp)
   105e0:	02913c23          	sd	s1,56(sp)
   105e4:	03313423          	sd	s3,40(sp)
   105e8:	01513c23          	sd	s5,24(sp)
   105ec:	01613823          	sd	s6,16(sp)
   105f0:	01713423          	sd	s7,8(sp)
   105f4:	01813023          	sd	s8,0(sp)
   105f8:	04090063          	beqz	s2,10638 <__call_exitprocs+0x74>
   105fc:	00050b13          	mv	s6,a0
   10600:	00058b93          	mv	s7,a1
   10604:	00100a93          	li	s5,1
   10608:	fff00993          	li	s3,-1
   1060c:	00892483          	lw	s1,8(s2)
   10610:	fff4841b          	addiw	s0,s1,-1
   10614:	02044263          	bltz	s0,10638 <__call_exitprocs+0x74>
   10618:	00349493          	slli	s1,s1,0x3
   1061c:	009904b3          	add	s1,s2,s1
   10620:	040b8463          	beqz	s7,10668 <__call_exitprocs+0xa4>
   10624:	2084b783          	ld	a5,520(s1)
   10628:	05778063          	beq	a5,s7,10668 <__call_exitprocs+0xa4>
   1062c:	fff4041b          	addiw	s0,s0,-1
   10630:	ff848493          	addi	s1,s1,-8
   10634:	ff3416e3          	bne	s0,s3,10620 <__call_exitprocs+0x5c>
   10638:	04813083          	ld	ra,72(sp)
   1063c:	04013403          	ld	s0,64(sp)
   10640:	03813483          	ld	s1,56(sp)
   10644:	03013903          	ld	s2,48(sp)
   10648:	02813983          	ld	s3,40(sp)
   1064c:	02013a03          	ld	s4,32(sp)
   10650:	01813a83          	ld	s5,24(sp)
   10654:	01013b03          	ld	s6,16(sp)
   10658:	00813b83          	ld	s7,8(sp)
   1065c:	00013c03          	ld	s8,0(sp)
   10660:	05010113          	addi	sp,sp,80
   10664:	00008067          	ret
   10668:	00892783          	lw	a5,8(s2)
   1066c:	0084b703          	ld	a4,8(s1)
   10670:	fff7879b          	addiw	a5,a5,-1
   10674:	06878263          	beq	a5,s0,106d8 <__call_exitprocs+0x114>
   10678:	0004b423          	sd	zero,8(s1)
   1067c:	fa0708e3          	beqz	a4,1062c <__call_exitprocs+0x68>
   10680:	31092783          	lw	a5,784(s2)
   10684:	008a96bb          	sllw	a3,s5,s0
   10688:	00892c03          	lw	s8,8(s2)
   1068c:	00d7f7b3          	and	a5,a5,a3
   10690:	0007879b          	sext.w	a5,a5
   10694:	02079263          	bnez	a5,106b8 <__call_exitprocs+0xf4>
   10698:	000700e7          	jalr	a4
   1069c:	00892703          	lw	a4,8(s2)
   106a0:	1f8a3783          	ld	a5,504(s4)
   106a4:	01871463          	bne	a4,s8,106ac <__call_exitprocs+0xe8>
   106a8:	f92782e3          	beq	a5,s2,1062c <__call_exitprocs+0x68>
   106ac:	f80786e3          	beqz	a5,10638 <__call_exitprocs+0x74>
   106b0:	00078913          	mv	s2,a5
   106b4:	f59ff06f          	j	1060c <__call_exitprocs+0x48>
   106b8:	31492783          	lw	a5,788(s2)
   106bc:	1084b583          	ld	a1,264(s1)
   106c0:	00d7f7b3          	and	a5,a5,a3
   106c4:	0007879b          	sext.w	a5,a5
   106c8:	00079c63          	bnez	a5,106e0 <__call_exitprocs+0x11c>
   106cc:	000b0513          	mv	a0,s6
   106d0:	000700e7          	jalr	a4
   106d4:	fc9ff06f          	j	1069c <__call_exitprocs+0xd8>
   106d8:	00892423          	sw	s0,8(s2)
   106dc:	fa1ff06f          	j	1067c <__call_exitprocs+0xb8>
   106e0:	00058513          	mv	a0,a1
   106e4:	000700e7          	jalr	a4
   106e8:	fb5ff06f          	j	1069c <__call_exitprocs+0xd8>

00000000000106ec <__libc_fini_array>:
   106ec:	fe010113          	addi	sp,sp,-32
   106f0:	00813823          	sd	s0,16(sp)
   106f4:	000117b7          	lui	a5,0x11
   106f8:	00011437          	lui	s0,0x11
   106fc:	01878793          	addi	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   10700:	02040413          	addi	s0,s0,32 # 11020 <impure_data>
   10704:	40f40433          	sub	s0,s0,a5
   10708:	00913423          	sd	s1,8(sp)
   1070c:	00113c23          	sd	ra,24(sp)
   10710:	40345493          	srai	s1,s0,0x3
   10714:	02048063          	beqz	s1,10734 <__libc_fini_array+0x48>
   10718:	ff840413          	addi	s0,s0,-8
   1071c:	00f40433          	add	s0,s0,a5
   10720:	00043783          	ld	a5,0(s0)
   10724:	fff48493          	addi	s1,s1,-1
   10728:	ff840413          	addi	s0,s0,-8
   1072c:	000780e7          	jalr	a5
   10730:	fe0498e3          	bnez	s1,10720 <__libc_fini_array+0x34>
   10734:	01813083          	ld	ra,24(sp)
   10738:	01013403          	ld	s0,16(sp)
   1073c:	00813483          	ld	s1,8(sp)
   10740:	02010113          	addi	sp,sp,32
   10744:	00008067          	ret

0000000000010748 <atexit>:
   10748:	00050593          	mv	a1,a0
   1074c:	00000693          	li	a3,0
   10750:	00000613          	li	a2,0
   10754:	00000513          	li	a0,0
   10758:	0040006f          	j	1075c <__register_exitproc>

000000000001075c <__register_exitproc>:
   1075c:	f481b703          	ld	a4,-184(gp) # 11768 <_global_impure_ptr>
   10760:	1f873783          	ld	a5,504(a4)
   10764:	06078063          	beqz	a5,107c4 <__register_exitproc+0x68>
   10768:	0087a703          	lw	a4,8(a5)
   1076c:	01f00813          	li	a6,31
   10770:	08e84663          	blt	a6,a4,107fc <__register_exitproc+0xa0>
   10774:	02050863          	beqz	a0,107a4 <__register_exitproc+0x48>
   10778:	00371813          	slli	a6,a4,0x3
   1077c:	01078833          	add	a6,a5,a6
   10780:	10c83823          	sd	a2,272(a6)
   10784:	3107a883          	lw	a7,784(a5)
   10788:	00100613          	li	a2,1
   1078c:	00e6163b          	sllw	a2,a2,a4
   10790:	00c8e8b3          	or	a7,a7,a2
   10794:	3117a823          	sw	a7,784(a5)
   10798:	20d83823          	sd	a3,528(a6)
   1079c:	00200693          	li	a3,2
   107a0:	02d50863          	beq	a0,a3,107d0 <__register_exitproc+0x74>
   107a4:	00270693          	addi	a3,a4,2
   107a8:	00369693          	slli	a3,a3,0x3
   107ac:	0017071b          	addiw	a4,a4,1
   107b0:	00e7a423          	sw	a4,8(a5)
   107b4:	00d787b3          	add	a5,a5,a3
   107b8:	00b7b023          	sd	a1,0(a5)
   107bc:	00000513          	li	a0,0
   107c0:	00008067          	ret
   107c4:	20070793          	addi	a5,a4,512
   107c8:	1ef73c23          	sd	a5,504(a4)
   107cc:	f9dff06f          	j	10768 <__register_exitproc+0xc>
   107d0:	3147a683          	lw	a3,788(a5)
   107d4:	00000513          	li	a0,0
   107d8:	00c6e6b3          	or	a3,a3,a2
   107dc:	30d7aa23          	sw	a3,788(a5)
   107e0:	00270693          	addi	a3,a4,2
   107e4:	00369693          	slli	a3,a3,0x3
   107e8:	0017071b          	addiw	a4,a4,1
   107ec:	00e7a423          	sw	a4,8(a5)
   107f0:	00d787b3          	add	a5,a5,a3
   107f4:	00b7b023          	sd	a1,0(a5)
   107f8:	00008067          	ret
   107fc:	fff00513          	li	a0,-1
   10800:	00008067          	ret

0000000000010804 <_exit>:
   10804:	05d00893          	li	a7,93
   10808:	00000073          	ecall
   1080c:	00054463          	bltz	a0,10814 <_exit+0x10>
   10810:	0000006f          	j	10810 <_exit+0xc>
   10814:	ff010113          	addi	sp,sp,-16
   10818:	00813023          	sd	s0,0(sp)
   1081c:	00050413          	mv	s0,a0
   10820:	00113423          	sd	ra,8(sp)
   10824:	4080043b          	negw	s0,s0
   10828:	00c000ef          	jal	ra,10834 <__errno>
   1082c:	00852023          	sw	s0,0(a0) # 11000 <__FRAME_END__>
   10830:	0000006f          	j	10830 <_exit+0x2c>

0000000000010834 <__errno>:
   10834:	f581b503          	ld	a0,-168(gp) # 11778 <_impure_ptr>
   10838:	00008067          	ret

Disassembly of section .rodata:

0000000000010840 <.rodata>:
   10840:	20534143          	.4byte	0x20534143
   10844:	43435553          	.4byte	0x43435553
   10848:	5345                	.2byte	0x5345
   1084a:	00000a53          	.4byte	0xa53
   1084e:	0000                	.2byte	0x0
   10850:	20534143          	.4byte	0x20534143
   10854:	4146                	.2byte	0x4146
   10856:	4c49                	.2byte	0x4c49
   10858:	000a                	.2byte	0xa

Disassembly of section .eh_frame:

0000000000011000 <__FRAME_END__>:
   11000:	0000                	.2byte	0x0
	...

Disassembly of section .init_array:

0000000000011008 <__init_array_start>:
   11008:	0118                	.2byte	0x118
   1100a:	0001                	.2byte	0x1
   1100c:	0000                	.2byte	0x0
	...

0000000000011010 <__frame_dummy_init_array_entry>:
   11010:	01c0                	.2byte	0x1c0
   11012:	0001                	.2byte	0x1
   11014:	0000                	.2byte	0x0
	...

Disassembly of section .fini_array:

0000000000011018 <__do_global_dtors_aux_fini_array_entry>:
   11018:	017c                	.2byte	0x17c
   1101a:	0001                	.2byte	0x1
   1101c:	0000                	.2byte	0x0
	...

Disassembly of section .data:

0000000000011020 <impure_data>:
	...
   11028:	1558                	.2byte	0x1558
   1102a:	0001                	.2byte	0x1
   1102c:	0000                	.2byte	0x0
   1102e:	0000                	.2byte	0x0
   11030:	1608                	.2byte	0x1608
   11032:	0001                	.2byte	0x1
   11034:	0000                	.2byte	0x0
   11036:	0000                	.2byte	0x0
   11038:	16b8                	.2byte	0x16b8
   1103a:	0001                	.2byte	0x1
	...
   11108:	0001                	.2byte	0x1
   1110a:	0000                	.2byte	0x0
   1110c:	0000                	.2byte	0x0
   1110e:	0000                	.2byte	0x0
   11110:	330e                	.2byte	0x330e
   11112:	abcd                	.2byte	0xabcd
   11114:	1234                	.2byte	0x1234
   11116:	e66d                	.2byte	0xe66d
   11118:	deec                	.2byte	0xdeec
   1111a:	0005                	.2byte	0x5
   1111c:	0000000b          	.4byte	0xb
	...

Disassembly of section .sdata:

0000000000011768 <_global_impure_ptr>:
   11768:	1020                	.2byte	0x1020
   1176a:	0001                	.2byte	0x1
   1176c:	0000                	.2byte	0x0
	...

0000000000011770 <__dso_handle>:
	...

0000000000011778 <_impure_ptr>:
   11778:	1020                	.2byte	0x1020
   1177a:	0001                	.2byte	0x1
   1177c:	0000                	.2byte	0x0
	...

Disassembly of section .bss:

0000000000011780 <completed.1>:
	...

0000000000011788 <object.0>:
	...

00000000000117b8 <dst>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347          	.4byte	0x3a434347
   4:	2820                	.2byte	0x2820
   6:	2029                	.2byte	0x2029
   8:	3231                	.2byte	0x3231
   a:	312e                	.2byte	0x312e
   c:	302e                	.2byte	0x302e
   e:	4700                	.2byte	0x4700
  10:	203a4343          	.4byte	0x203a4343
  14:	4728                	.2byte	0x4728
  16:	554e                	.2byte	0x554e
  18:	2029                	.2byte	0x2029
  1a:	3231                	.2byte	0x3231
  1c:	312e                	.2byte	0x312e
  1e:	302e                	.2byte	0x302e
	...

Disassembly of section .riscv.attributes:

0000000000000000 <.riscv.attributes>:
   0:	2041                	.2byte	0x2041
   2:	0000                	.2byte	0x0
   4:	7200                	.2byte	0x7200
   6:	7369                	.2byte	0x7369
   8:	01007663          	bgeu	zero,a6,14 <exit-0x100d4>
   c:	0016                	.2byte	0x16
   e:	0000                	.2byte	0x0
  10:	1004                	.2byte	0x1004
  12:	7205                	.2byte	0x7205
  14:	3676                	.2byte	0x3676
  16:	6934                	.2byte	0x6934
  18:	7032                	.2byte	0x7032
  1a:	5f30                	.2byte	0x5f30
  1c:	3261                	.2byte	0x3261
  1e:	3070                	.2byte	0x3070
	...
