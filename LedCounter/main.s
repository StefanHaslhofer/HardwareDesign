	.file	"main.c"
	.option nopic
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB0:
	addi	sp,sp,-32
.LCFI0:
	sw	ra,28(sp)
	sw	s0,24(sp)
.LCFI1:
	addi	s0,sp,32
.LCFI2:
	li	a5,255
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	li	a4,33
	sw	a4,0(a5)
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
.LCFI3:
	lw	s0,24(sp)
.LCFI4:
	addi	sp,sp,32
.LCFI5:
	jr	ra
.LFE0:
	.size	main, .-main
	.section	.eh_frame,"aw",@progbits
.Lframe1:
	.4byte	.LECIE1-.LSCIE1
.LSCIE1:
	.4byte	0
	.byte	0x3
	.string	"zR"
	.byte	0x1
	.byte	0x7c
	.byte	0x1
	.byte	0x1
	.byte	0x1b
	.byte	0xc
	.byte	0x2
	.byte	0
	.align	2
.LECIE1:
.LSFDE1:
	.4byte	.LEFDE1-.LASFDE1
.LASFDE1:
	.4byte	.LASFDE1-.Lframe1
	.4byte	.LFB0-.
	.4byte	.LFE0-.LFB0
	.byte	0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x81
	.byte	0x1
	.byte	0x88
	.byte	0x2
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xc
	.byte	0x8
	.byte	0
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0xc1
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xc8
	.byte	0xc
	.byte	0x2
	.byte	0x20
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xe
	.byte	0
	.align	2
.LEFDE1:
	.ident	"GCC: (GNU) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
