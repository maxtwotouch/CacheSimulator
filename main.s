	.file	"main.c"
	.text
.Ltext0:
	.file 0 "/src" "main.c"
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
.LFB6:
	.file 1 "main.c"
	.loc 1 11 35
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
1:	call	*mcount@GOTPCREL(%rip)
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 13 12
	movl	$0, -12(%rbp)
	.loc 1 13 5
	jmp	.L2
.L6:
	.loc 1 14 16
	movl	$0, -8(%rbp)
	.loc 1 14 9
	jmp	.L3
.L5:
	.loc 1 15 20
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	.loc 1 15 29
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	.loc 1 15 16
	cmpl	%eax, %edx
	jle	.L4
	.loc 1 16 27
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 16 22
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	.loc 1 17 29
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 17 20
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	.loc 1 17 29
	movl	(%rax), %eax
	.loc 1 17 24
	movl	%eax, (%rdx)
	.loc 1 18 20
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	.loc 1 18 26
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
.L4:
	.loc 1 14 33 discriminator 2
	addl	$1, -8(%rbp)
.L3:
	.loc 1 14 26 discriminator 1
	movl	-28(%rbp), %eax
	subl	-12(%rbp), %eax
	.loc 1 14 28 discriminator 1
	subl	$1, %eax
	.loc 1 14 23 discriminator 1
	cmpl	%eax, -8(%rbp)
	jl	.L5
	.loc 1 13 27 discriminator 2
	addl	$1, -12(%rbp)
.L2:
	.loc 1 13 22 discriminator 1
	movl	-28(%rbp), %eax
	subl	$1, %eax
	.loc 1 13 19 discriminator 1
	cmpl	%eax, -12(%rbp)
	jl	.L6
	.loc 1 22 1
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bubble_sort, .-bubble_sort
	.section	.rodata
	.align 8
.LC1:
	.string	"C Bubble sort took %f seconds to execute \n"
	.align 8
.LC2:
	.string	"Assembly Bubble sort took %f seconds to execute \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.loc 1 25 33
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-798720(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$1344, %rsp
1:	call	*mcount@GOTPCREL(%rip)
	movl	%edi, -800052(%rbp)
	movq	%rsi, -800064(%rbp)
	.loc 1 25 33
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 27 11
	movl	$0, %edi
	call	time@PLT
	.loc 1 27 5
	movl	%eax, %edi
	call	srand@PLT
.LBB2:
	.loc 1 30 13
	movl	$0, -800044(%rbp)
	.loc 1 30 5
	jmp	.L8
.L9:
	.loc 1 31 18 discriminator 3
	call	rand@PLT
	.loc 1 31 25 discriminator 3
	movslq	%eax, %rdx
	imulq	$274877907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$6, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$1000, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	.loc 1 31 16 discriminator 3
	movl	-800044(%rbp), %eax
	cltq
	movl	%edx, -800016(%rbp,%rax,4)
	.loc 1 32 22 discriminator 3
	movl	-800044(%rbp), %eax
	cltq
	movl	-800016(%rbp,%rax,4), %edx
	.loc 1 32 17 discriminator 3
	movl	-800044(%rbp), %eax
	cltq
	movl	%edx, -400016(%rbp,%rax,4)
	.loc 1 30 31 discriminator 3
	addl	$1, -800044(%rbp)
.L8:
	.loc 1 30 22 discriminator 1
	cmpl	$99999, -800044(%rbp)
	jle	.L9
.LBE2:
	.loc 1 36 21
	call	clock@PLT
	movq	%rax, -800040(%rbp)
	.loc 1 37 5
	leaq	-800016(%rbp), %rax
	movl	$100000, %esi
	movq	%rax, %rdi
	call	bubble_sort
	.loc 1 38 19
	call	clock@PLT
	movq	%rax, -800032(%rbp)
	.loc 1 41 26
	pxor	%xmm0, %xmm0
	cvtsi2sdq	-800032(%rbp), %xmm0
	.loc 1 41 38
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-800040(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	.loc 1 41 12
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -800024(%rbp)
	.loc 1 42 5
	movq	-800024(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	.loc 1 45 13
	call	clock@PLT
	movq	%rax, -800040(%rbp)
	.loc 1 46 5
	leaq	-400016(%rbp), %rax
	movl	$100000, %esi
	movq	%rax, %rdi
	call	asm_function@PLT
	.loc 1 47 11
	call	clock@PLT
	movq	%rax, -800032(%rbp)
	.loc 1 50 19
	pxor	%xmm0, %xmm0
	cvtsi2sdq	-800032(%rbp), %xmm0
	.loc 1 50 31
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-800040(%rbp), %xmm1
	subsd	%xmm1, %xmm0
	.loc 1 50 16
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -800024(%rbp)
	.loc 1 51 5
	movq	-800024(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	.loc 1 53 12
	movl	$0, %eax
	.loc 1 54 1
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.text
.Letext0:
	.file 2 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types/clock_t.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/time_t.h"
	.file 5 "/usr/include/time.h"
	.file 6 "/usr/include/stdlib.h"
	.file 7 "/usr/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x25b
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x9
	.long	.LASF29
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x5
	.long	.LASF9
	.byte	0x2
	.byte	0x9c
	.byte	0x1b
	.long	0x5f
	.uleb128 0x5
	.long	.LASF10
	.byte	0x2
	.byte	0xa0
	.byte	0x1a
	.long	0x5f
	.uleb128 0x2
	.long	0x83
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0xb
	.long	0x83
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.long	.LASF12
	.uleb128 0x5
	.long	.LASF13
	.byte	0x3
	.byte	0x7
	.byte	0x13
	.long	0x66
	.uleb128 0x5
	.long	.LASF14
	.byte	0x4
	.byte	0xa
	.byte	0x12
	.long	0x72
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.long	.LASF15
	.uleb128 0x2
	.long	0x8a
	.uleb128 0xc
	.long	.LASF18
	.byte	0x1
	.byte	0x8
	.byte	0xd
	.long	0xd1
	.uleb128 0x3
	.long	0xd1
	.uleb128 0x3
	.long	0x58
	.byte	0
	.uleb128 0x2
	.long	0x58
	.uleb128 0xd
	.long	.LASF20
	.byte	0x7
	.value	0x164
	.byte	0xc
	.long	0x58
	.long	0xee
	.uleb128 0x3
	.long	0xb5
	.uleb128 0xe
	.byte	0
	.uleb128 0xf
	.long	.LASF16
	.byte	0x5
	.byte	0x48
	.byte	0x10
	.long	0x96
	.uleb128 0x10
	.long	.LASF17
	.byte	0x6
	.value	0x1c6
	.byte	0xc
	.long	0x58
	.uleb128 0x11
	.long	.LASF19
	.byte	0x6
	.value	0x1c8
	.byte	0xd
	.long	0x11a
	.uleb128 0x3
	.long	0x35
	.byte	0
	.uleb128 0x12
	.long	.LASF21
	.byte	0x5
	.byte	0x4c
	.byte	0xf
	.long	0xa2
	.long	0x130
	.uleb128 0x3
	.long	0x130
	.byte	0
	.uleb128 0x2
	.long	0xa2
	.uleb128 0x13
	.long	.LASF30
	.byte	0x1
	.byte	0x19
	.byte	0x5
	.long	0x58
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x1e6
	.uleb128 0x7
	.long	.LASF22
	.byte	0xe
	.long	0x58
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800068
	.uleb128 0x7
	.long	.LASF23
	.byte	0x1b
	.long	0x1e6
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800080
	.uleb128 0x4
	.string	"arr"
	.byte	0x1a
	.byte	0x9
	.long	0x1eb
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800032
	.uleb128 0x6
	.long	.LASF24
	.byte	0x1a
	.byte	0x14
	.long	0x1eb
	.uleb128 0x4
	.byte	0x91
	.sleb128 -400032
	.uleb128 0x6
	.long	.LASF25
	.byte	0x24
	.byte	0xd
	.long	0x96
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800056
	.uleb128 0x4
	.string	"end"
	.byte	0x26
	.byte	0xd
	.long	0x96
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800048
	.uleb128 0x6
	.long	.LASF26
	.byte	0x29
	.byte	0xc
	.long	0x1fe
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800040
	.uleb128 0x14
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x4
	.string	"i"
	.byte	0x1e
	.byte	0xd
	.long	0x58
	.uleb128 0x4
	.byte	0x91
	.sleb128 -800060
	.byte	0
	.byte	0
	.uleb128 0x2
	.long	0x7e
	.uleb128 0x15
	.long	0x58
	.long	0x1fe
	.uleb128 0x16
	.long	0x2e
	.long	0x1869f
	.byte	0
	.uleb128 0x1
	.byte	0x8
	.byte	0x4
	.long	.LASF27
	.uleb128 0x17
	.long	.LASF31
	.byte	0x1
	.byte	0xb
	.byte	0x6
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x8
	.string	"arr"
	.byte	0x17
	.long	0xd1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"n"
	.byte	0x20
	.long	0x58
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x4
	.string	"i"
	.byte	0xc
	.byte	0x9
	.long	0x58
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x4
	.string	"j"
	.byte	0xc
	.byte	0xc
	.long	0x58
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x6
	.long	.LASF28
	.byte	0xc
	.byte	0xf
	.long	0x58
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 25
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF24:
	.string	"arr2"
.LASF25:
	.string	"start"
.LASF31:
	.string	"bubble_sort"
.LASF13:
	.string	"clock_t"
.LASF4:
	.string	"unsigned char"
.LASF2:
	.string	"long unsigned int"
.LASF28:
	.string	"temp"
.LASF5:
	.string	"short unsigned int"
.LASF10:
	.string	"__time_t"
.LASF16:
	.string	"clock"
.LASF27:
	.string	"double"
.LASF19:
	.string	"srand"
.LASF30:
	.string	"main"
.LASF29:
	.string	"GNU C17 11.4.0 -masm=att -mtune=generic -march=x86-64 -g -O0 -p -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF26:
	.string	"time_taken"
.LASF3:
	.string	"unsigned int"
.LASF15:
	.string	"long long unsigned int"
.LASF14:
	.string	"time_t"
.LASF21:
	.string	"time"
.LASF22:
	.string	"argc"
.LASF9:
	.string	"__clock_t"
.LASF12:
	.string	"long long int"
.LASF11:
	.string	"char"
.LASF20:
	.string	"printf"
.LASF18:
	.string	"asm_function"
.LASF7:
	.string	"short int"
.LASF23:
	.string	"argv"
.LASF8:
	.string	"long int"
.LASF6:
	.string	"signed char"
.LASF17:
	.string	"rand"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"main.c"
.LASF1:
	.string	"/src"
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
