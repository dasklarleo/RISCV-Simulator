
../riscv-elf/example.riscv：     文件格式 elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <exit>:
   100e8:	ff010113          	addi	sp,sp,-16
   100ec:	00000593          	li	a1,0
   100f0:	00813023          	sd	s0,0(sp)
   100f4:	00113423          	sd	ra,8(sp)
   100f8:	00050413          	mv	s0,a0
   100fc:	4ac000ef          	jal	ra,105a8 <__call_exitprocs>
   10100:	f481b503          	ld	a0,-184(gp) # 11fa0 <_global_impure_ptr>
   10104:	05853783          	ld	a5,88(a0)
   10108:	00078463          	beqz	a5,10110 <exit+0x28>
   1010c:	000780e7          	jalr	a5
   10110:	00040513          	mv	a0,s0
   10114:	6d4000ef          	jal	ra,107e8 <_exit>

0000000000010118 <register_fini>:
   10118:	00000793          	li	a5,0
   1011c:	00078863          	beqz	a5,1012c <register_fini+0x14>
   10120:	00010537          	lui	a0,0x10
   10124:	6d050513          	addi	a0,a0,1744 # 106d0 <__libc_fini_array>
   10128:	6040006f          	j	1072c <atexit>
   1012c:	00008067          	ret

0000000000010130 <_start>:
   10130:	00002197          	auipc	gp,0x2
   10134:	f2818193          	addi	gp,gp,-216 # 12058 <__global_pointer$>
   10138:	f6018513          	addi	a0,gp,-160 # 11fb8 <completed.1>
   1013c:	fa018613          	addi	a2,gp,-96 # 11ff8 <__BSS_END__>
   10140:	40a60633          	sub	a2,a2,a0
   10144:	00000593          	li	a1,0
   10148:	384000ef          	jal	ra,104cc <memset>
   1014c:	00000517          	auipc	a0,0x0
   10150:	5e050513          	addi	a0,a0,1504 # 1072c <atexit>
   10154:	00050863          	beqz	a0,10164 <_start+0x34>
   10158:	00000517          	auipc	a0,0x0
   1015c:	57850513          	addi	a0,a0,1400 # 106d0 <__libc_fini_array>
   10160:	5cc000ef          	jal	ra,1072c <atexit>
   10164:	2cc000ef          	jal	ra,10430 <__libc_init_array>
   10168:	00012503          	lw	a0,0(sp)
   1016c:	00810593          	addi	a1,sp,8
   10170:	00000613          	li	a2,0
   10174:	0f0000ef          	jal	ra,10264 <main>
   10178:	f71ff06f          	j	100e8 <exit>

000000000001017c <__do_global_dtors_aux>:
   1017c:	ff010113          	addi	sp,sp,-16
   10180:	00813023          	sd	s0,0(sp)
   10184:	f601c783          	lbu	a5,-160(gp) # 11fb8 <completed.1>
   10188:	00113423          	sd	ra,8(sp)
   1018c:	02079263          	bnez	a5,101b0 <__do_global_dtors_aux+0x34>
   10190:	00000793          	li	a5,0
   10194:	00078a63          	beqz	a5,101a8 <__do_global_dtors_aux+0x2c>
   10198:	00012537          	lui	a0,0x12
   1019c:	83c50513          	addi	a0,a0,-1988 # 1183c <__FRAME_END__>
   101a0:	00000097          	auipc	ra,0x0
   101a4:	000000e7          	jalr	zero # 0 <exit-0x100e8>
   101a8:	00100793          	li	a5,1
   101ac:	f6f18023          	sb	a5,-160(gp) # 11fb8 <completed.1>
   101b0:	00813083          	ld	ra,8(sp)
   101b4:	00013403          	ld	s0,0(sp)
   101b8:	01010113          	addi	sp,sp,16
   101bc:	00008067          	ret

00000000000101c0 <frame_dummy>:
   101c0:	00000793          	li	a5,0
   101c4:	00078c63          	beqz	a5,101dc <frame_dummy+0x1c>
   101c8:	00012537          	lui	a0,0x12
   101cc:	f6818593          	addi	a1,gp,-152 # 11fc0 <object.0>
   101d0:	83c50513          	addi	a0,a0,-1988 # 1183c <__FRAME_END__>
   101d4:	00000317          	auipc	t1,0x0
   101d8:	00000067          	jr	zero # 0 <exit-0x100e8>
   101dc:	00008067          	ret

00000000000101e0 <CAS>:
   101e0:	fb010113          	addi	sp,sp,-80
   101e4:	04813423          	sd	s0,72(sp)
   101e8:	05010413          	addi	s0,sp,80
   101ec:	fca43423          	sd	a0,-56(s0)
   101f0:	fcb43023          	sd	a1,-64(s0)
   101f4:	fac43c23          	sd	a2,-72(s0)
   101f8:	fe042623          	sw	zero,-20(s0)
   101fc:	06400793          	li	a5,100
   10200:	fef43023          	sd	a5,-32(s0)
   10204:	fc843703          	ld	a4,-56(s0)
   10208:	100737af          	lr.d	a5,(a4)
   1020c:	fef43023          	sd	a5,-32(s0)
   10210:	fe043783          	ld	a5,-32(s0)
   10214:	0007b783          	ld	a5,0(a5)
   10218:	fb843703          	ld	a4,-72(s0)
   1021c:	00f70863          	beq	a4,a5,1022c <CAS+0x4c>
   10220:	fe042623          	sw	zero,-20(s0)
   10224:	fec42783          	lw	a5,-20(s0)
   10228:	02c0006f          	j	10254 <CAS+0x74>
   1022c:	fc043703          	ld	a4,-64(s0)
   10230:	fc843683          	ld	a3,-56(s0)
   10234:	18e6b7af          	sc.d	a5,a4,(a3)
   10238:	fcf43c23          	sd	a5,-40(s0)
   1023c:	fd843783          	ld	a5,-40(s0)
   10240:	00078463          	beqz	a5,10248 <CAS+0x68>
   10244:	fc1ff06f          	j	10204 <CAS+0x24>
   10248:	00100793          	li	a5,1
   1024c:	fef42623          	sw	a5,-20(s0)
   10250:	fec42783          	lw	a5,-20(s0)
   10254:	00078513          	mv	a0,a5
   10258:	04813403          	ld	s0,72(sp)
   1025c:	05010113          	addi	sp,sp,80
   10260:	00008067          	ret

0000000000010264 <main>:
   10264:	fe010113          	addi	sp,sp,-32
   10268:	00113c23          	sd	ra,24(sp)
   1026c:	00813823          	sd	s0,16(sp)
   10270:	02010413          	addi	s0,sp,32
   10274:	00600713          	li	a4,6
   10278:	f8e1bc23          	sd	a4,-104(gp) # 11ff0 <dst>
   1027c:	fe042623          	sw	zero,-20(s0)
   10280:	0800006f          	j	10300 <main+0x9c>
   10284:	fec42783          	lw	a5,-20(s0)
   10288:	00078613          	mv	a2,a5
   1028c:	0d300593          	li	a1,211
   10290:	f9818513          	addi	a0,gp,-104 # 11ff0 <dst>
   10294:	f4dff0ef          	jal	ra,101e0 <CAS>
   10298:	00050793          	mv	a5,a0
   1029c:	fef42423          	sw	a5,-24(s0)
   102a0:	fe842783          	lw	a5,-24(s0)
   102a4:	0007879b          	sext.w	a5,a5
   102a8:	00078a63          	beqz	a5,102bc <main+0x58>
   102ac:	000117b7          	lui	a5,0x11
   102b0:	82078513          	addi	a0,a5,-2016 # 10820 <__errno+0x8>
   102b4:	0a4000ef          	jal	ra,10358 <print_s>
   102b8:	0100006f          	j	102c8 <main+0x64>
   102bc:	000117b7          	lui	a5,0x11
   102c0:	83078513          	addi	a0,a5,-2000 # 10830 <__errno+0x18>
   102c4:	094000ef          	jal	ra,10358 <print_s>
   102c8:	fe842783          	lw	a5,-24(s0)
   102cc:	00078513          	mv	a0,a5
   102d0:	05c000ef          	jal	ra,1032c <print_d>
   102d4:	00a00513          	li	a0,10
   102d8:	0a8000ef          	jal	ra,10380 <print_c>
   102dc:	f981b783          	ld	a5,-104(gp) # 11ff0 <dst>
   102e0:	0007879b          	sext.w	a5,a5
   102e4:	00078513          	mv	a0,a5
   102e8:	044000ef          	jal	ra,1032c <print_d>
   102ec:	00a00513          	li	a0,10
   102f0:	090000ef          	jal	ra,10380 <print_c>
   102f4:	fec42783          	lw	a5,-20(s0)
   102f8:	0017879b          	addiw	a5,a5,1
   102fc:	fef42623          	sw	a5,-20(s0)
   10300:	fec42783          	lw	a5,-20(s0)
   10304:	0007871b          	sext.w	a4,a5
   10308:	00900793          	li	a5,9
   1030c:	f6e7dce3          	bge	a5,a4,10284 <main+0x20>
   10310:	09c000ef          	jal	ra,103ac <exit_proc>
   10314:	00000793          	li	a5,0
   10318:	00078513          	mv	a0,a5
   1031c:	01813083          	ld	ra,24(sp)
   10320:	01013403          	ld	s0,16(sp)
   10324:	02010113          	addi	sp,sp,32
   10328:	00008067          	ret

000000000001032c <print_d>:
   1032c:	fe010113          	addi	sp,sp,-32
   10330:	00813c23          	sd	s0,24(sp)
   10334:	02010413          	addi	s0,sp,32
   10338:	00050793          	mv	a5,a0
   1033c:	fef42623          	sw	a5,-20(s0)
   10340:	00200893          	li	a7,2
   10344:	00000073          	ecall
   10348:	00000013          	nop
   1034c:	01813403          	ld	s0,24(sp)
   10350:	02010113          	addi	sp,sp,32
   10354:	00008067          	ret

0000000000010358 <print_s>:
   10358:	fe010113          	addi	sp,sp,-32
   1035c:	00813c23          	sd	s0,24(sp)
   10360:	02010413          	addi	s0,sp,32
   10364:	fea43423          	sd	a0,-24(s0)
   10368:	00000893          	li	a7,0
   1036c:	00000073          	ecall
   10370:	00000013          	nop
   10374:	01813403          	ld	s0,24(sp)
   10378:	02010113          	addi	sp,sp,32
   1037c:	00008067          	ret

0000000000010380 <print_c>:
   10380:	fe010113          	addi	sp,sp,-32
   10384:	00813c23          	sd	s0,24(sp)
   10388:	02010413          	addi	s0,sp,32
   1038c:	00050793          	mv	a5,a0
   10390:	fef407a3          	sb	a5,-17(s0)
   10394:	00100893          	li	a7,1
   10398:	00000073          	ecall
   1039c:	00000013          	nop
   103a0:	01813403          	ld	s0,24(sp)
   103a4:	02010113          	addi	sp,sp,32
   103a8:	00008067          	ret

00000000000103ac <exit_proc>:
   103ac:	ff010113          	addi	sp,sp,-16
   103b0:	00813423          	sd	s0,8(sp)
   103b4:	01010413          	addi	s0,sp,16
   103b8:	00300893          	li	a7,3
   103bc:	00000073          	ecall
   103c0:	00000013          	nop
   103c4:	00813403          	ld	s0,8(sp)
   103c8:	01010113          	addi	sp,sp,16
   103cc:	00008067          	ret

00000000000103d0 <read_char>:
   103d0:	fe010113          	addi	sp,sp,-32
   103d4:	00813c23          	sd	s0,24(sp)
   103d8:	02010413          	addi	s0,sp,32
   103dc:	00400893          	li	a7,4
   103e0:	00000073          	ecall
   103e4:	00050793          	mv	a5,a0
   103e8:	fef407a3          	sb	a5,-17(s0)
   103ec:	fef44783          	lbu	a5,-17(s0)
   103f0:	00078513          	mv	a0,a5
   103f4:	01813403          	ld	s0,24(sp)
   103f8:	02010113          	addi	sp,sp,32
   103fc:	00008067          	ret

0000000000010400 <read_num>:
   10400:	fe010113          	addi	sp,sp,-32
   10404:	00813c23          	sd	s0,24(sp)
   10408:	02010413          	addi	s0,sp,32
   1040c:	00500893          	li	a7,5
   10410:	00000073          	ecall
   10414:	00050793          	mv	a5,a0
   10418:	fef43423          	sd	a5,-24(s0)
   1041c:	fe843783          	ld	a5,-24(s0)
   10420:	00078513          	mv	a0,a5
   10424:	01813403          	ld	s0,24(sp)
   10428:	02010113          	addi	sp,sp,32
   1042c:	00008067          	ret

0000000000010430 <__libc_init_array>:
   10430:	fe010113          	addi	sp,sp,-32
   10434:	00813823          	sd	s0,16(sp)
   10438:	000127b7          	lui	a5,0x12
   1043c:	00012437          	lui	s0,0x12
   10440:	01213023          	sd	s2,0(sp)
   10444:	84078793          	addi	a5,a5,-1984 # 11840 <__init_array_start>
   10448:	84040713          	addi	a4,s0,-1984 # 11840 <__init_array_start>
   1044c:	00113c23          	sd	ra,24(sp)
   10450:	00913423          	sd	s1,8(sp)
   10454:	40e78933          	sub	s2,a5,a4
   10458:	02e78263          	beq	a5,a4,1047c <__libc_init_array+0x4c>
   1045c:	40395913          	srai	s2,s2,0x3
   10460:	84040413          	addi	s0,s0,-1984
   10464:	00000493          	li	s1,0
   10468:	00043783          	ld	a5,0(s0)
   1046c:	00148493          	addi	s1,s1,1
   10470:	00840413          	addi	s0,s0,8
   10474:	000780e7          	jalr	a5
   10478:	ff24e8e3          	bltu	s1,s2,10468 <__libc_init_array+0x38>
   1047c:	00012437          	lui	s0,0x12
   10480:	000127b7          	lui	a5,0x12
   10484:	85078793          	addi	a5,a5,-1968 # 11850 <__do_global_dtors_aux_fini_array_entry>
   10488:	84040713          	addi	a4,s0,-1984 # 11840 <__init_array_start>
   1048c:	40e78933          	sub	s2,a5,a4
   10490:	40395913          	srai	s2,s2,0x3
   10494:	02e78063          	beq	a5,a4,104b4 <__libc_init_array+0x84>
   10498:	84040413          	addi	s0,s0,-1984
   1049c:	00000493          	li	s1,0
   104a0:	00043783          	ld	a5,0(s0)
   104a4:	00148493          	addi	s1,s1,1
   104a8:	00840413          	addi	s0,s0,8
   104ac:	000780e7          	jalr	a5
   104b0:	ff24e8e3          	bltu	s1,s2,104a0 <__libc_init_array+0x70>
   104b4:	01813083          	ld	ra,24(sp)
   104b8:	01013403          	ld	s0,16(sp)
   104bc:	00813483          	ld	s1,8(sp)
   104c0:	00013903          	ld	s2,0(sp)
   104c4:	02010113          	addi	sp,sp,32
   104c8:	00008067          	ret

00000000000104cc <memset>:
   104cc:	00f00313          	li	t1,15
   104d0:	00050713          	mv	a4,a0
   104d4:	02c37a63          	bgeu	t1,a2,10508 <memset+0x3c>
   104d8:	00f77793          	andi	a5,a4,15
   104dc:	0a079063          	bnez	a5,1057c <memset+0xb0>
   104e0:	06059e63          	bnez	a1,1055c <memset+0x90>
   104e4:	ff067693          	andi	a3,a2,-16
   104e8:	00f67613          	andi	a2,a2,15
   104ec:	00e686b3          	add	a3,a3,a4
   104f0:	00b73023          	sd	a1,0(a4)
   104f4:	00b73423          	sd	a1,8(a4)
   104f8:	01070713          	addi	a4,a4,16
   104fc:	fed76ae3          	bltu	a4,a3,104f0 <memset+0x24>
   10500:	00061463          	bnez	a2,10508 <memset+0x3c>
   10504:	00008067          	ret
   10508:	40c306b3          	sub	a3,t1,a2
   1050c:	00269693          	slli	a3,a3,0x2
   10510:	00000297          	auipc	t0,0x0
   10514:	005686b3          	add	a3,a3,t0
   10518:	00c68067          	jr	12(a3)
   1051c:	00b70723          	sb	a1,14(a4)
   10520:	00b706a3          	sb	a1,13(a4)
   10524:	00b70623          	sb	a1,12(a4)
   10528:	00b705a3          	sb	a1,11(a4)
   1052c:	00b70523          	sb	a1,10(a4)
   10530:	00b704a3          	sb	a1,9(a4)
   10534:	00b70423          	sb	a1,8(a4)
   10538:	00b703a3          	sb	a1,7(a4)
   1053c:	00b70323          	sb	a1,6(a4)
   10540:	00b702a3          	sb	a1,5(a4)
   10544:	00b70223          	sb	a1,4(a4)
   10548:	00b701a3          	sb	a1,3(a4)
   1054c:	00b70123          	sb	a1,2(a4)
   10550:	00b700a3          	sb	a1,1(a4)
   10554:	00b70023          	sb	a1,0(a4)
   10558:	00008067          	ret
   1055c:	0ff5f593          	zext.b	a1,a1
   10560:	00859693          	slli	a3,a1,0x8
   10564:	00d5e5b3          	or	a1,a1,a3
   10568:	01059693          	slli	a3,a1,0x10
   1056c:	00d5e5b3          	or	a1,a1,a3
   10570:	02059693          	slli	a3,a1,0x20
   10574:	00d5e5b3          	or	a1,a1,a3
   10578:	f6dff06f          	j	104e4 <memset+0x18>
   1057c:	00279693          	slli	a3,a5,0x2
   10580:	00000297          	auipc	t0,0x0
   10584:	005686b3          	add	a3,a3,t0
   10588:	00008293          	mv	t0,ra
   1058c:	f98680e7          	jalr	-104(a3)
   10590:	00028093          	mv	ra,t0
   10594:	ff078793          	addi	a5,a5,-16
   10598:	40f70733          	sub	a4,a4,a5
   1059c:	00f60633          	add	a2,a2,a5
   105a0:	f6c374e3          	bgeu	t1,a2,10508 <memset+0x3c>
   105a4:	f3dff06f          	j	104e0 <memset+0x14>

00000000000105a8 <__call_exitprocs>:
   105a8:	fb010113          	addi	sp,sp,-80
   105ac:	03413023          	sd	s4,32(sp)
   105b0:	f481ba03          	ld	s4,-184(gp) # 11fa0 <_global_impure_ptr>
   105b4:	03213823          	sd	s2,48(sp)
   105b8:	04113423          	sd	ra,72(sp)
   105bc:	1f8a3903          	ld	s2,504(s4)
   105c0:	04813023          	sd	s0,64(sp)
   105c4:	02913c23          	sd	s1,56(sp)
   105c8:	03313423          	sd	s3,40(sp)
   105cc:	01513c23          	sd	s5,24(sp)
   105d0:	01613823          	sd	s6,16(sp)
   105d4:	01713423          	sd	s7,8(sp)
   105d8:	01813023          	sd	s8,0(sp)
   105dc:	04090063          	beqz	s2,1061c <__call_exitprocs+0x74>
   105e0:	00050b13          	mv	s6,a0
   105e4:	00058b93          	mv	s7,a1
   105e8:	00100a93          	li	s5,1
   105ec:	fff00993          	li	s3,-1
   105f0:	00892483          	lw	s1,8(s2)
   105f4:	fff4841b          	addiw	s0,s1,-1
   105f8:	02044263          	bltz	s0,1061c <__call_exitprocs+0x74>
   105fc:	00349493          	slli	s1,s1,0x3
   10600:	009904b3          	add	s1,s2,s1
   10604:	040b8463          	beqz	s7,1064c <__call_exitprocs+0xa4>
   10608:	2084b783          	ld	a5,520(s1)
   1060c:	05778063          	beq	a5,s7,1064c <__call_exitprocs+0xa4>
   10610:	fff4041b          	addiw	s0,s0,-1
   10614:	ff848493          	addi	s1,s1,-8
   10618:	ff3416e3          	bne	s0,s3,10604 <__call_exitprocs+0x5c>
   1061c:	04813083          	ld	ra,72(sp)
   10620:	04013403          	ld	s0,64(sp)
   10624:	03813483          	ld	s1,56(sp)
   10628:	03013903          	ld	s2,48(sp)
   1062c:	02813983          	ld	s3,40(sp)
   10630:	02013a03          	ld	s4,32(sp)
   10634:	01813a83          	ld	s5,24(sp)
   10638:	01013b03          	ld	s6,16(sp)
   1063c:	00813b83          	ld	s7,8(sp)
   10640:	00013c03          	ld	s8,0(sp)
   10644:	05010113          	addi	sp,sp,80
   10648:	00008067          	ret
   1064c:	00892783          	lw	a5,8(s2)
   10650:	0084b703          	ld	a4,8(s1)
   10654:	fff7879b          	addiw	a5,a5,-1
   10658:	06878263          	beq	a5,s0,106bc <__call_exitprocs+0x114>
   1065c:	0004b423          	sd	zero,8(s1)
   10660:	fa0708e3          	beqz	a4,10610 <__call_exitprocs+0x68>
   10664:	31092783          	lw	a5,784(s2)
   10668:	008a96bb          	sllw	a3,s5,s0
   1066c:	00892c03          	lw	s8,8(s2)
   10670:	00d7f7b3          	and	a5,a5,a3
   10674:	0007879b          	sext.w	a5,a5
   10678:	02079263          	bnez	a5,1069c <__call_exitprocs+0xf4>
   1067c:	000700e7          	jalr	a4
   10680:	00892703          	lw	a4,8(s2)
   10684:	1f8a3783          	ld	a5,504(s4)
   10688:	01871463          	bne	a4,s8,10690 <__call_exitprocs+0xe8>
   1068c:	f92782e3          	beq	a5,s2,10610 <__call_exitprocs+0x68>
   10690:	f80786e3          	beqz	a5,1061c <__call_exitprocs+0x74>
   10694:	00078913          	mv	s2,a5
   10698:	f59ff06f          	j	105f0 <__call_exitprocs+0x48>
   1069c:	31492783          	lw	a5,788(s2)
   106a0:	1084b583          	ld	a1,264(s1)
   106a4:	00d7f7b3          	and	a5,a5,a3
   106a8:	0007879b          	sext.w	a5,a5
   106ac:	00079c63          	bnez	a5,106c4 <__call_exitprocs+0x11c>
   106b0:	000b0513          	mv	a0,s6
   106b4:	000700e7          	jalr	a4
   106b8:	fc9ff06f          	j	10680 <__call_exitprocs+0xd8>
   106bc:	00892423          	sw	s0,8(s2)
   106c0:	fa1ff06f          	j	10660 <__call_exitprocs+0xb8>
   106c4:	00058513          	mv	a0,a1
   106c8:	000700e7          	jalr	a4
   106cc:	fb5ff06f          	j	10680 <__call_exitprocs+0xd8>

00000000000106d0 <__libc_fini_array>:
   106d0:	fe010113          	addi	sp,sp,-32
   106d4:	00813823          	sd	s0,16(sp)
   106d8:	000127b7          	lui	a5,0x12
   106dc:	00012437          	lui	s0,0x12
   106e0:	85078793          	addi	a5,a5,-1968 # 11850 <__do_global_dtors_aux_fini_array_entry>
   106e4:	85840413          	addi	s0,s0,-1960 # 11858 <impure_data>
   106e8:	40f40433          	sub	s0,s0,a5
   106ec:	00913423          	sd	s1,8(sp)
   106f0:	00113c23          	sd	ra,24(sp)
   106f4:	40345493          	srai	s1,s0,0x3
   106f8:	02048063          	beqz	s1,10718 <__libc_fini_array+0x48>
   106fc:	ff840413          	addi	s0,s0,-8
   10700:	00f40433          	add	s0,s0,a5
   10704:	00043783          	ld	a5,0(s0)
   10708:	fff48493          	addi	s1,s1,-1
   1070c:	ff840413          	addi	s0,s0,-8
   10710:	000780e7          	jalr	a5
   10714:	fe0498e3          	bnez	s1,10704 <__libc_fini_array+0x34>
   10718:	01813083          	ld	ra,24(sp)
   1071c:	01013403          	ld	s0,16(sp)
   10720:	00813483          	ld	s1,8(sp)
   10724:	02010113          	addi	sp,sp,32
   10728:	00008067          	ret

000000000001072c <atexit>:
   1072c:	00050593          	mv	a1,a0
   10730:	00000693          	li	a3,0
   10734:	00000613          	li	a2,0
   10738:	00000513          	li	a0,0
   1073c:	0040006f          	j	10740 <__register_exitproc>

0000000000010740 <__register_exitproc>:
   10740:	f481b703          	ld	a4,-184(gp) # 11fa0 <_global_impure_ptr>
   10744:	1f873783          	ld	a5,504(a4)
   10748:	06078063          	beqz	a5,107a8 <__register_exitproc+0x68>
   1074c:	0087a703          	lw	a4,8(a5)
   10750:	01f00813          	li	a6,31
   10754:	08e84663          	blt	a6,a4,107e0 <__register_exitproc+0xa0>
   10758:	02050863          	beqz	a0,10788 <__register_exitproc+0x48>
   1075c:	00371813          	slli	a6,a4,0x3
   10760:	01078833          	add	a6,a5,a6
   10764:	10c83823          	sd	a2,272(a6)
   10768:	3107a883          	lw	a7,784(a5)
   1076c:	00100613          	li	a2,1
   10770:	00e6163b          	sllw	a2,a2,a4
   10774:	00c8e8b3          	or	a7,a7,a2
   10778:	3117a823          	sw	a7,784(a5)
   1077c:	20d83823          	sd	a3,528(a6)
   10780:	00200693          	li	a3,2
   10784:	02d50863          	beq	a0,a3,107b4 <__register_exitproc+0x74>
   10788:	00270693          	addi	a3,a4,2
   1078c:	00369693          	slli	a3,a3,0x3
   10790:	0017071b          	addiw	a4,a4,1
   10794:	00e7a423          	sw	a4,8(a5)
   10798:	00d787b3          	add	a5,a5,a3
   1079c:	00b7b023          	sd	a1,0(a5)
   107a0:	00000513          	li	a0,0
   107a4:	00008067          	ret
   107a8:	20070793          	addi	a5,a4,512
   107ac:	1ef73c23          	sd	a5,504(a4)
   107b0:	f9dff06f          	j	1074c <__register_exitproc+0xc>
   107b4:	3147a683          	lw	a3,788(a5)
   107b8:	00000513          	li	a0,0
   107bc:	00c6e6b3          	or	a3,a3,a2
   107c0:	30d7aa23          	sw	a3,788(a5)
   107c4:	00270693          	addi	a3,a4,2
   107c8:	00369693          	slli	a3,a3,0x3
   107cc:	0017071b          	addiw	a4,a4,1
   107d0:	00e7a423          	sw	a4,8(a5)
   107d4:	00d787b3          	add	a5,a5,a3
   107d8:	00b7b023          	sd	a1,0(a5)
   107dc:	00008067          	ret
   107e0:	fff00513          	li	a0,-1
   107e4:	00008067          	ret

00000000000107e8 <_exit>:
   107e8:	05d00893          	li	a7,93
   107ec:	00000073          	ecall
   107f0:	00054463          	bltz	a0,107f8 <_exit+0x10>
   107f4:	0000006f          	j	107f4 <_exit+0xc>
   107f8:	ff010113          	addi	sp,sp,-16
   107fc:	00813023          	sd	s0,0(sp)
   10800:	00050413          	mv	s0,a0
   10804:	00113423          	sd	ra,8(sp)
   10808:	4080043b          	negw	s0,s0
   1080c:	00c000ef          	jal	ra,10818 <__errno>
   10810:	00852023          	sw	s0,0(a0)
   10814:	0000006f          	j	10814 <_exit+0x2c>

0000000000010818 <__errno>:
   10818:	f581b503          	ld	a0,-168(gp) # 11fb0 <_impure_ptr>
   1081c:	00008067          	ret

Disassembly of section .rodata:

0000000000010820 <.rodata>:
   10820:	20534143          	.4byte	0x20534143
   10824:	43435553          	.4byte	0x43435553
   10828:	5345                	.2byte	0x5345
   1082a:	00000a53          	.4byte	0xa53
   1082e:	0000                	.2byte	0x0
   10830:	20534143          	.4byte	0x20534143
   10834:	4146                	.2byte	0x4146
   10836:	4c49                	.2byte	0x4c49
   10838:	000a                	.2byte	0xa

Disassembly of section .eh_frame:

000000000001183c <__FRAME_END__>:
   1183c:	0000                	.2byte	0x0
	...

Disassembly of section .init_array:

0000000000011840 <__init_array_start>:
   11840:	0118                	.2byte	0x118
   11842:	0001                	.2byte	0x1
   11844:	0000                	.2byte	0x0
	...

0000000000011848 <__frame_dummy_init_array_entry>:
   11848:	01c0                	.2byte	0x1c0
   1184a:	0001                	.2byte	0x1
   1184c:	0000                	.2byte	0x0
	...

Disassembly of section .fini_array:

0000000000011850 <__do_global_dtors_aux_fini_array_entry>:
   11850:	017c                	.2byte	0x17c
   11852:	0001                	.2byte	0x1
   11854:	0000                	.2byte	0x0
	...

Disassembly of section .data:

0000000000011858 <impure_data>:
	...
   11860:	1d90                	.2byte	0x1d90
   11862:	0001                	.2byte	0x1
   11864:	0000                	.2byte	0x0
   11866:	0000                	.2byte	0x0
   11868:	1e40                	.2byte	0x1e40
   1186a:	0001                	.2byte	0x1
   1186c:	0000                	.2byte	0x0
   1186e:	0000                	.2byte	0x0
   11870:	1ef0                	.2byte	0x1ef0
   11872:	0001                	.2byte	0x1
	...
   11940:	0001                	.2byte	0x1
   11942:	0000                	.2byte	0x0
   11944:	0000                	.2byte	0x0
   11946:	0000                	.2byte	0x0
   11948:	330e                	.2byte	0x330e
   1194a:	abcd                	.2byte	0xabcd
   1194c:	1234                	.2byte	0x1234
   1194e:	e66d                	.2byte	0xe66d
   11950:	deec                	.2byte	0xdeec
   11952:	0005                	.2byte	0x5
   11954:	0000000b          	.4byte	0xb
	...

Disassembly of section .sdata:

0000000000011fa0 <_global_impure_ptr>:
   11fa0:	1858                	.2byte	0x1858
   11fa2:	0001                	.2byte	0x1
   11fa4:	0000                	.2byte	0x0
	...

0000000000011fa8 <__dso_handle>:
	...

0000000000011fb0 <_impure_ptr>:
   11fb0:	1858                	.2byte	0x1858
   11fb2:	0001                	.2byte	0x1
   11fb4:	0000                	.2byte	0x0
	...

Disassembly of section .bss:

0000000000011fb8 <completed.1>:
	...

0000000000011fc0 <object.0>:
	...

0000000000011ff0 <dst>:
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
