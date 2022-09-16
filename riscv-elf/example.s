
../riscv-elf/example.riscv：     文件格式 elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	addi	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	4d4000ef          	jal	ra,105d0 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11768 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	6fc000ef          	jal	ra,10810 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	6f850513          	addi	a0,a0,1784 # 106f8 <__libc_fini_array>
   10128:	62c0006f          	j	10754 <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00001197          	auipc	gp,0x1
   10134:	6f018193          	addi	gp,gp,1776 # 11820 <__global_pointer$>
   10138:	f6018513          	addi	a0,gp,-160 # 11780 <completed.1>
   1013c:	fa018613          	addi	a2,gp,-96 # 117c0 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	3ac000ef          	jal	ra,104f4 <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	60850513          	addi	a0,a0,1544 # 10754 <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	5a050513          	addi	a0,a0,1440 # 106f8 <__libc_fini_array>
   10160:	5f4000ef          	jal	ra,10754 <atexit>
   10164:	2f4000ef          	jal	ra,10458 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	addi	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	118000ef          	jal	ra,1028c <main>
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
   101e0:	fa010113          	addi	sp,sp,-96
   101e4:	04813c23          	sd	s0,88(sp)
   101e8:	06010413          	addi	s0,sp,96
   101ec:	faa43c23          	sd	a0,-72(s0)
   101f0:	fab43823          	sd	a1,-80(s0)
   101f4:	fac43423          	sd	a2,-88(s0)
   101f8:	fe042623          	sw	zero,-20(s0)
   101fc:	fc043423          	sd	zero,-56(s0)
   10200:	00100793          	li	a5,1
   10204:	fef43023          	sd	a5,-32(s0)
   10208:	06400793          	li	a5,100
   1020c:	fcf43c23          	sd	a5,-40(s0)
   10210:	fc840793          	addi	a5,s0,-56
   10214:	fcf43823          	sd	a5,-48(s0)

0000000000010218 <retry>:
   10218:	fb843703          	ld	a4,-72(s0)
   1021c:	100737af          	lr.d	a5,(a4)
   10220:	fcf43c23          	sd	a5,-40(s0)
   10224:	fd843783          	ld	a5,-40(s0)
   10228:	0007b783          	ld	a5,0(a5)
   1022c:	fa843703          	ld	a4,-88(s0)
   10230:	00f70863          	beq	a4,a5,10240 <retry+0x28>
   10234:	fe042623          	sw	zero,-20(s0)
   10238:	fec42783          	lw	a5,-20(s0)
   1023c:	0400006f          	j	1027c <final+0xc>
   10240:	fb043683          	ld	a3,-80(s0)
   10244:	fd043603          	ld	a2,-48(s0)
   10248:	18d637af          	sc.d	a5,a3,(a2)
   1024c:	00000013          	nop
   10250:	00000013          	nop
   10254:	00000013          	nop
   10258:	00000013          	nop
   1025c:	00000013          	nop
   10260:	00000013          	nop
   10264:	00078663          	beqz	a5,10270 <final>
   10268:	fb1ff06f          	j	10218 <retry>
   1026c:	fce43423          	sd	a4,-56(s0)

0000000000010270 <final>:
   10270:	00100793          	li	a5,1
   10274:	fef42623          	sw	a5,-20(s0)
   10278:	fec42783          	lw	a5,-20(s0)
   1027c:	00078513          	mv	a0,a5
   10280:	05813403          	ld	s0,88(sp)
   10284:	06010113          	addi	sp,sp,96
   10288:	00008067          	ret

000000000001028c <main>:
   1028c:	fe010113          	addi	sp,sp,-32
   10290:	00113c23          	sd	ra,24(sp)
   10294:	00813823          	sd	s0,16(sp)
   10298:	02010413          	addi	s0,sp,32
   1029c:	00100713          	li	a4,1
   102a0:	f8e1bc23          	sd	a4,-104(gp) # 117b8 <dst>
   102a4:	fe042623          	sw	zero,-20(s0)
   102a8:	0800006f          	j	10328 <main+0x9c>
   102ac:	fec42783          	lw	a5,-20(s0)
   102b0:	00078613          	mv	a2,a5
   102b4:	0d300593          	li	a1,211
   102b8:	f9818513          	addi	a0,gp,-104 # 117b8 <dst>
   102bc:	f25ff0ef          	jal	ra,101e0 <CAS>
   102c0:	00050793          	mv	a5,a0
   102c4:	fef42423          	sw	a5,-24(s0)
   102c8:	fe842783          	lw	a5,-24(s0)
   102cc:	0007879b          	sext.w	a5,a5
   102d0:	00078a63          	beqz	a5,102e4 <main+0x58>
   102d4:	000117b7          	lui	a5,0x11
   102d8:	84878513          	addi	a0,a5,-1976 # 10848 <__errno+0x8>
   102dc:	0a4000ef          	jal	ra,10380 <print_s>
   102e0:	0100006f          	j	102f0 <main+0x64>
   102e4:	000117b7          	lui	a5,0x11
   102e8:	85878513          	addi	a0,a5,-1960 # 10858 <__errno+0x18>
   102ec:	094000ef          	jal	ra,10380 <print_s>
   102f0:	fe842783          	lw	a5,-24(s0)
   102f4:	00078513          	mv	a0,a5
   102f8:	05c000ef          	jal	ra,10354 <print_d>
   102fc:	00a00513          	li	a0,10
   10300:	0a8000ef          	jal	ra,103a8 <print_c>
   10304:	f981b783          	ld	a5,-104(gp) # 117b8 <dst>
   10308:	0007879b          	sext.w	a5,a5
   1030c:	00078513          	mv	a0,a5
   10310:	044000ef          	jal	ra,10354 <print_d>
   10314:	00a00513          	li	a0,10
   10318:	090000ef          	jal	ra,103a8 <print_c>
   1031c:	fec42783          	lw	a5,-20(s0)
   10320:	0017879b          	addiw	a5,a5,1
   10324:	fef42623          	sw	a5,-20(s0)
   10328:	fec42783          	lw	a5,-20(s0)
   1032c:	0007871b          	sext.w	a4,a5
   10330:	00200793          	li	a5,2
   10334:	f6e7dce3          	bge	a5,a4,102ac <main+0x20>
   10338:	09c000ef          	jal	ra,103d4 <exit_proc>
   1033c:	00000793          	li	a5,0
   10340:	00078513          	mv	a0,a5
   10344:	01813083          	ld	ra,24(sp)
   10348:	01013403          	ld	s0,16(sp)
   1034c:	02010113          	addi	sp,sp,32
   10350:	00008067          	ret

0000000000010354 <print_d>:
   10354:	fe010113          	addi	sp,sp,-32
   10358:	00813c23          	sd	s0,24(sp)
   1035c:	02010413          	addi	s0,sp,32
   10360:	00050793          	mv	a5,a0
   10364:	fef42623          	sw	a5,-20(s0)
   10368:	00200893          	li	a7,2
   1036c:	00000073          	ecall
   10370:	00000013          	nop
   10374:	01813403          	ld	s0,24(sp)
   10378:	02010113          	addi	sp,sp,32
   1037c:	00008067          	ret

0000000000010380 <print_s>:
   10380:	fe010113          	addi	sp,sp,-32
   10384:	00813c23          	sd	s0,24(sp)
   10388:	02010413          	addi	s0,sp,32
   1038c:	fea43423          	sd	a0,-24(s0)
   10390:	00000893          	li	a7,0
   10394:	00000073          	ecall
   10398:	00000013          	nop
   1039c:	01813403          	ld	s0,24(sp)
   103a0:	02010113          	addi	sp,sp,32
   103a4:	00008067          	ret

00000000000103a8 <print_c>:
   103a8:	fe010113          	addi	sp,sp,-32
   103ac:	00813c23          	sd	s0,24(sp)
   103b0:	02010413          	addi	s0,sp,32
   103b4:	00050793          	mv	a5,a0
   103b8:	fef407a3          	sb	a5,-17(s0)
   103bc:	00100893          	li	a7,1
   103c0:	00000073          	ecall
   103c4:	00000013          	nop
   103c8:	01813403          	ld	s0,24(sp)
   103cc:	02010113          	addi	sp,sp,32
   103d0:	00008067          	ret

00000000000103d4 <exit_proc>:
   103d4:	ff010113          	addi	sp,sp,-16
   103d8:	00813423          	sd	s0,8(sp)
   103dc:	01010413          	addi	s0,sp,16
   103e0:	00300893          	li	a7,3
   103e4:	00000073          	ecall
   103e8:	00000013          	nop
   103ec:	00813403          	ld	s0,8(sp)
   103f0:	01010113          	addi	sp,sp,16
   103f4:	00008067          	ret

00000000000103f8 <read_char>:
   103f8:	fe010113          	addi	sp,sp,-32
   103fc:	00813c23          	sd	s0,24(sp)
   10400:	02010413          	addi	s0,sp,32
   10404:	00400893          	li	a7,4
   10408:	00000073          	ecall
   1040c:	00050793          	mv	a5,a0
   10410:	fef407a3          	sb	a5,-17(s0)
   10414:	fef44783          	lbu	a5,-17(s0)
   10418:	00078513          	mv	a0,a5
   1041c:	01813403          	ld	s0,24(sp)
   10420:	02010113          	addi	sp,sp,32
   10424:	00008067          	ret

0000000000010428 <read_num>:
   10428:	fe010113          	addi	sp,sp,-32
   1042c:	00813c23          	sd	s0,24(sp)
   10430:	02010413          	addi	s0,sp,32
   10434:	00500893          	li	a7,5
   10438:	00000073          	ecall
   1043c:	00050793          	mv	a5,a0
   10440:	fef43423          	sd	a5,-24(s0)
   10444:	fe843783          	ld	a5,-24(s0)
   10448:	00078513          	mv	a0,a5
   1044c:	01813403          	ld	s0,24(sp)
   10450:	02010113          	addi	sp,sp,32
   10454:	00008067          	ret

0000000000010458 <__libc_init_array>:
   10458:	fe010113          	addi	sp,sp,-32
   1045c:	00813823          	sd	s0,16(sp)
   10460:	000117b7          	lui	a5,0x11
   10464:	00011437          	lui	s0,0x11
   10468:	01213023          	sd	s2,0(sp)
   1046c:	00478793          	addi	a5,a5,4 # 11004 <__preinit_array_end>
   10470:	00440713          	addi	a4,s0,4 # 11004 <__preinit_array_end>
   10474:	00113c23          	sd	ra,24(sp)
   10478:	00913423          	sd	s1,8(sp)
   1047c:	40e78933          	sub	s2,a5,a4
   10480:	02e78263          	beq	a5,a4,104a4 <__libc_init_array+0x4c>
   10484:	40395913          	srai	s2,s2,0x3
   10488:	00440413          	addi	s0,s0,4
   1048c:	00000493          	li	s1,0
   10490:	00043783          	ld	a5,0(s0)
   10494:	00148493          	addi	s1,s1,1
   10498:	00840413          	addi	s0,s0,8
   1049c:	000780e7          	jalr	a5
   104a0:	ff24e8e3          	bltu	s1,s2,10490 <__libc_init_array+0x38>
   104a4:	00011437          	lui	s0,0x11
   104a8:	000117b7          	lui	a5,0x11
   104ac:	01878793          	addi	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   104b0:	00840713          	addi	a4,s0,8 # 11008 <__init_array_start>
   104b4:	40e78933          	sub	s2,a5,a4
   104b8:	40395913          	srai	s2,s2,0x3
   104bc:	02e78063          	beq	a5,a4,104dc <__libc_init_array+0x84>
   104c0:	00840413          	addi	s0,s0,8
   104c4:	00000493          	li	s1,0
   104c8:	00043783          	ld	a5,0(s0)
   104cc:	00148493          	addi	s1,s1,1
   104d0:	00840413          	addi	s0,s0,8
   104d4:	000780e7          	jalr	a5
   104d8:	ff24e8e3          	bltu	s1,s2,104c8 <__libc_init_array+0x70>
   104dc:	01813083          	ld	ra,24(sp)
   104e0:	01013403          	ld	s0,16(sp)
   104e4:	00813483          	ld	s1,8(sp)
   104e8:	00013903          	ld	s2,0(sp)
   104ec:	02010113          	addi	sp,sp,32
   104f0:	00008067          	ret

00000000000104f4 <memset>:
   104f4:	00f00313          	li	t1,15
   104f8:	00050713          	mv	a4,a0
   104fc:	02c37a63          	bgeu	t1,a2,10530 <memset+0x3c>
   10500:	00f77793          	andi	a5,a4,15
   10504:	0a079063          	bnez	a5,105a4 <memset+0xb0>
   10508:	06059e63          	bnez	a1,10584 <memset+0x90>
   1050c:	ff067693          	andi	a3,a2,-16
   10510:	00f67613          	andi	a2,a2,15
   10514:	00e686b3          	add	a3,a3,a4
   10518:	00b73023          	sd	a1,0(a4)
   1051c:	00b73423          	sd	a1,8(a4)
   10520:	01070713          	addi	a4,a4,16
   10524:	fed76ae3          	bltu	a4,a3,10518 <memset+0x24>
   10528:	00061463          	bnez	a2,10530 <memset+0x3c>
   1052c:	00008067          	ret
   10530:	40c306b3          	sub	a3,t1,a2
   10534:	00269693          	slli	a3,a3,0x2
   10538:	00000297          	auipc	t0,0x0
   1053c:	005686b3          	add	a3,a3,t0
   10540:	00c68067          	jr	12(a3)
   10544:	00b70723          	sb	a1,14(a4)
   10548:	00b706a3          	sb	a1,13(a4)
   1054c:	00b70623          	sb	a1,12(a4)
   10550:	00b705a3          	sb	a1,11(a4)
   10554:	00b70523          	sb	a1,10(a4)
   10558:	00b704a3          	sb	a1,9(a4)
   1055c:	00b70423          	sb	a1,8(a4)
   10560:	00b703a3          	sb	a1,7(a4)
   10564:	00b70323          	sb	a1,6(a4)
   10568:	00b702a3          	sb	a1,5(a4)
   1056c:	00b70223          	sb	a1,4(a4)
   10570:	00b701a3          	sb	a1,3(a4)
   10574:	00b70123          	sb	a1,2(a4)
   10578:	00b700a3          	sb	a1,1(a4)
   1057c:	00b70023          	sb	a1,0(a4)
   10580:	00008067          	ret
   10584:	0ff5f593          	zext.b	a1,a1
   10588:	00859693          	slli	a3,a1,0x8
   1058c:	00d5e5b3          	or	a1,a1,a3
   10590:	01059693          	slli	a3,a1,0x10
   10594:	00d5e5b3          	or	a1,a1,a3
   10598:	02059693          	slli	a3,a1,0x20
   1059c:	00d5e5b3          	or	a1,a1,a3
   105a0:	f6dff06f          	j	1050c <memset+0x18>
   105a4:	00279693          	slli	a3,a5,0x2
   105a8:	00000297          	auipc	t0,0x0
   105ac:	005686b3          	add	a3,a3,t0
   105b0:	00008293          	mv	t0,ra
   105b4:	f98680e7          	jalr	-104(a3)
   105b8:	00028093          	mv	ra,t0
   105bc:	ff078793          	addi	a5,a5,-16
   105c0:	40f70733          	sub	a4,a4,a5
   105c4:	00f60633          	add	a2,a2,a5
   105c8:	f6c374e3          	bgeu	t1,a2,10530 <memset+0x3c>
   105cc:	f3dff06f          	j	10508 <memset+0x14>

00000000000105d0 <__call_exitprocs>:
   105d0:	fb010113          	addi	sp,sp,-80
   105d4:	03413023          	sd	s4,32(sp)
   105d8:	f481ba03          	ld	s4,-184(gp) # 11768 <_global_impure_ptr>
   105dc:	03213823          	sd	s2,48(sp)
   105e0:	04113423          	sd	ra,72(sp)
   105e4:	1f8a3903          	ld	s2,504(s4)
   105e8:	04813023          	sd	s0,64(sp)
   105ec:	02913c23          	sd	s1,56(sp)
   105f0:	03313423          	sd	s3,40(sp)
   105f4:	01513c23          	sd	s5,24(sp)
   105f8:	01613823          	sd	s6,16(sp)
   105fc:	01713423          	sd	s7,8(sp)
   10600:	01813023          	sd	s8,0(sp)
   10604:	04090063          	beqz	s2,10644 <__call_exitprocs+0x74>
   10608:	00050b13          	mv	s6,a0
   1060c:	00058b93          	mv	s7,a1
   10610:	00100a93          	li	s5,1
   10614:	fff00993          	li	s3,-1
   10618:	00892483          	lw	s1,8(s2)
   1061c:	fff4841b          	addiw	s0,s1,-1
   10620:	02044263          	bltz	s0,10644 <__call_exitprocs+0x74>
   10624:	00349493          	slli	s1,s1,0x3
   10628:	009904b3          	add	s1,s2,s1
   1062c:	040b8463          	beqz	s7,10674 <__call_exitprocs+0xa4>
   10630:	2084b783          	ld	a5,520(s1)
   10634:	05778063          	beq	a5,s7,10674 <__call_exitprocs+0xa4>
   10638:	fff4041b          	addiw	s0,s0,-1
   1063c:	ff848493          	addi	s1,s1,-8
   10640:	ff3416e3          	bne	s0,s3,1062c <__call_exitprocs+0x5c>
   10644:	04813083          	ld	ra,72(sp)
   10648:	04013403          	ld	s0,64(sp)
   1064c:	03813483          	ld	s1,56(sp)
   10650:	03013903          	ld	s2,48(sp)
   10654:	02813983          	ld	s3,40(sp)
   10658:	02013a03          	ld	s4,32(sp)
   1065c:	01813a83          	ld	s5,24(sp)
   10660:	01013b03          	ld	s6,16(sp)
   10664:	00813b83          	ld	s7,8(sp)
   10668:	00013c03          	ld	s8,0(sp)
   1066c:	05010113          	addi	sp,sp,80
   10670:	00008067          	ret
   10674:	00892783          	lw	a5,8(s2)
   10678:	0084b703          	ld	a4,8(s1)
   1067c:	fff7879b          	addiw	a5,a5,-1
   10680:	06878263          	beq	a5,s0,106e4 <__call_exitprocs+0x114>
   10684:	0004b423          	sd	zero,8(s1)
   10688:	fa0708e3          	beqz	a4,10638 <__call_exitprocs+0x68>
   1068c:	31092783          	lw	a5,784(s2)
   10690:	008a96bb          	sllw	a3,s5,s0
   10694:	00892c03          	lw	s8,8(s2)
   10698:	00d7f7b3          	and	a5,a5,a3
   1069c:	0007879b          	sext.w	a5,a5
   106a0:	02079263          	bnez	a5,106c4 <__call_exitprocs+0xf4>
   106a4:	000700e7          	jalr	a4
   106a8:	00892703          	lw	a4,8(s2)
   106ac:	1f8a3783          	ld	a5,504(s4)
   106b0:	01871463          	bne	a4,s8,106b8 <__call_exitprocs+0xe8>
   106b4:	f92782e3          	beq	a5,s2,10638 <__call_exitprocs+0x68>
   106b8:	f80786e3          	beqz	a5,10644 <__call_exitprocs+0x74>
   106bc:	00078913          	mv	s2,a5
   106c0:	f59ff06f          	j	10618 <__call_exitprocs+0x48>
   106c4:	31492783          	lw	a5,788(s2)
   106c8:	1084b583          	ld	a1,264(s1)
   106cc:	00d7f7b3          	and	a5,a5,a3
   106d0:	0007879b          	sext.w	a5,a5
   106d4:	00079c63          	bnez	a5,106ec <__call_exitprocs+0x11c>
   106d8:	000b0513          	mv	a0,s6
   106dc:	000700e7          	jalr	a4
   106e0:	fc9ff06f          	j	106a8 <__call_exitprocs+0xd8>
   106e4:	00892423          	sw	s0,8(s2)
   106e8:	fa1ff06f          	j	10688 <__call_exitprocs+0xb8>
   106ec:	00058513          	mv	a0,a1
   106f0:	000700e7          	jalr	a4
   106f4:	fb5ff06f          	j	106a8 <__call_exitprocs+0xd8>

00000000000106f8 <__libc_fini_array>:
   106f8:	fe010113          	addi	sp,sp,-32
   106fc:	00813823          	sd	s0,16(sp)
   10700:	000117b7          	lui	a5,0x11
   10704:	00011437          	lui	s0,0x11
   10708:	01878793          	addi	a5,a5,24 # 11018 <__do_global_dtors_aux_fini_array_entry>
   1070c:	02040413          	addi	s0,s0,32 # 11020 <impure_data>
   10710:	40f40433          	sub	s0,s0,a5
   10714:	00913423          	sd	s1,8(sp)
   10718:	00113c23          	sd	ra,24(sp)
   1071c:	40345493          	srai	s1,s0,0x3
   10720:	02048063          	beqz	s1,10740 <__libc_fini_array+0x48>
   10724:	ff840413          	addi	s0,s0,-8
   10728:	00f40433          	add	s0,s0,a5
   1072c:	00043783          	ld	a5,0(s0)
   10730:	fff48493          	addi	s1,s1,-1
   10734:	ff840413          	addi	s0,s0,-8
   10738:	000780e7          	jalr	a5
   1073c:	fe0498e3          	bnez	s1,1072c <__libc_fini_array+0x34>
   10740:	01813083          	ld	ra,24(sp)
   10744:	01013403          	ld	s0,16(sp)
   10748:	00813483          	ld	s1,8(sp)
   1074c:	02010113          	addi	sp,sp,32
   10750:	00008067          	ret

0000000000010754 <atexit>:
   10754:	00050593          	mv	a1,a0
   10758:	00000693          	li	a3,0
   1075c:	00000613          	li	a2,0
   10760:	00000513          	li	a0,0
   10764:	0040006f          	j	10768 <__register_exitproc>

0000000000010768 <__register_exitproc>:
   10768:	f481b703          	ld	a4,-184(gp) # 11768 <_global_impure_ptr>
   1076c:	1f873783          	ld	a5,504(a4)
   10770:	06078063          	beqz	a5,107d0 <__register_exitproc+0x68>
   10774:	0087a703          	lw	a4,8(a5)
   10778:	01f00813          	li	a6,31
   1077c:	08e84663          	blt	a6,a4,10808 <__register_exitproc+0xa0>
   10780:	02050863          	beqz	a0,107b0 <__register_exitproc+0x48>
   10784:	00371813          	slli	a6,a4,0x3
   10788:	01078833          	add	a6,a5,a6
   1078c:	10c83823          	sd	a2,272(a6)
   10790:	3107a883          	lw	a7,784(a5)
   10794:	00100613          	li	a2,1
   10798:	00e6163b          	sllw	a2,a2,a4
   1079c:	00c8e8b3          	or	a7,a7,a2
   107a0:	3117a823          	sw	a7,784(a5)
   107a4:	20d83823          	sd	a3,528(a6)
   107a8:	00200693          	li	a3,2
   107ac:	02d50863          	beq	a0,a3,107dc <__register_exitproc+0x74>
   107b0:	00270693          	addi	a3,a4,2
   107b4:	00369693          	slli	a3,a3,0x3
   107b8:	0017071b          	addiw	a4,a4,1
   107bc:	00e7a423          	sw	a4,8(a5)
   107c0:	00d787b3          	add	a5,a5,a3
   107c4:	00b7b023          	sd	a1,0(a5)
   107c8:	00000513          	li	a0,0
   107cc:	00008067          	ret
   107d0:	20070793          	addi	a5,a4,512
   107d4:	1ef73c23          	sd	a5,504(a4)
   107d8:	f9dff06f          	j	10774 <__register_exitproc+0xc>
   107dc:	3147a683          	lw	a3,788(a5)
   107e0:	00000513          	li	a0,0
   107e4:	00c6e6b3          	or	a3,a3,a2
   107e8:	30d7aa23          	sw	a3,788(a5)
   107ec:	00270693          	addi	a3,a4,2
   107f0:	00369693          	slli	a3,a3,0x3
   107f4:	0017071b          	addiw	a4,a4,1
   107f8:	00e7a423          	sw	a4,8(a5)
   107fc:	00d787b3          	add	a5,a5,a3
   10800:	00b7b023          	sd	a1,0(a5)
   10804:	00008067          	ret
   10808:	fff00513          	li	a0,-1
   1080c:	00008067          	ret

0000000000010810 <_exit>:
   10810:	05d00893          	li	a7,93
   10814:	00000073          	ecall
   10818:	00054463          	bltz	a0,10820 <_exit+0x10>
   1081c:	0000006f          	j	1081c <_exit+0xc>
   10820:	ff010113          	addi	sp,sp,-16
   10824:	00813023          	sd	s0,0(sp)
   10828:	00050413          	mv	s0,a0
   1082c:	00113423          	sd	ra,8(sp)
   10830:	4080043b          	negw	s0,s0
   10834:	00c000ef          	jal	ra,10840 <__errno>
   10838:	00852023          	sw	s0,0(a0) # 11000 <__FRAME_END__>
   1083c:	0000006f          	j	1083c <_exit+0x2c>

0000000000010840 <__errno>:
   10840:	f581b503          	ld	a0,-168(gp) # 11778 <_impure_ptr>
   10844:	00008067          	ret

Disassembly of section .rodata:

0000000000010848 <.rodata>:
   10848:	20534143          	.4byte	0x20534143
   1084c:	43435553          	.4byte	0x43435553
   10850:	5345                	.2byte	0x5345
   10852:	00000a53          	.4byte	0xa53
   10856:	0000                	.2byte	0x0
   10858:	20534143          	.4byte	0x20534143
   1085c:	4146                	.2byte	0x4146
   1085e:	4c49                	.2byte	0x4c49
   10860:	000a                	.2byte	0xa

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
