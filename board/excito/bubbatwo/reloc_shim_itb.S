/*
	This shim is used to move the kernel and device tree
	blob (DTB) in memory, so that they can boot successfully
	on an Excito B2 miniserver with the default U-Boot
	environment, when booting with the rear button pressed
	(which uses a flattened image tree).

	It copies the DTB from its current location (passed in r3)
	to the 15MiB boundary, fixes up r3 so it points to the new
	DTB address, and then copies the kernel itself (whose
	uncompressed code is inlined after the shim) to the required
	0MiB boundary, and then jumps to it.

	The kernel will of course reclaim all the additional memory
	used, on startup.

	None of the registers used to pass information into the
	kernel by U-Boot are affected by this shim (other than r3).

	Copyright (c) 2015 sakaki <sakaki@deciban.com>
	License: GPL 3.0+
	NO WARRANTY
*/
	.machine ppc
	.text
	.align 2
	.p2align 4,,15
	.globl _main
	.set dtbdst,    0x00f00000		# move DTB to 15MiB
	.set kerneldst, 0x00000000		# move kernel to 0MiB
	.set kernelsrcoffset, kernel_start-marker
						# short offset to kernel
						# start location
	.set kernellen,   kernel_end-kernel_start
						# length of kernel image
	.set wordlen,   0x04			# word = 32 bits = 4 bytes
	.set dtblenoff, 0x04			# length is second word in
						# DTB
_main:
/*
	first, relocate the (modified & already moved by U-Boot) DTB to
	dtbdst (current ptr in r3); it will be safe there
	from being overwritten
	then modify r3, so it points to the new location
*/
	la r16, 0(r3)				# set src to passed DTB ptr
	addis r17, 0, dtbdst@h			# set dst to 15MiB boundary
	ori r17, r17, dtbdst@l
	lwz r18, dtblenoff(r3)			# set len of passed DTB
	la r3, 0(r17)				# patch r3 pointer to new loc
	bl copy_mem				# do copy

/*	next, move the kernel itself */
	bl marker				# store &marker in link reg
marker:
	mflr r16				# move to copy_mem's src ptr
	addi r16, r16, kernelsrcoffset		# add offset, so r16 now points
						# to absolute address of
						# kernel_start
	addis r17, 0, kerneldst@h		# set dst to 0MiB boundary
	ori r17, r17, kerneldst@l
	addis r18, 0, kernellen@h		# setup kernel length
	ori r18, r18, kernellen@l
	bl copy_mem				# do copy

/*	copy complete - pass control to kernel */
	addis r20, 0, kerneldst@h		# kernel target ptr
	ori r20, r20, kerneldst@l
	mtlr r20
	blr					# ikinasai!

copy_mem:
/*
	subroutine: on entry, source address should be in r16,
	destination in r17, and length in r18; return address
	should be in lr
	on exit, r18 will be next usable destination address (word
	aligned); r16/r17/r19 overwritten; no stack is used
*/
	add r18, r18, r17			# r18 := first non-dst addr
copy_next_word:
	lwz r19, 0(r16)				# load 4 bytes from src...
	stw r19, 0(r17)				# and save them to dst
	addi r16, r16, wordlen			# inc source
	addi r17, r17, wordlen			# inc dest
	cmpl 0, 0, r17, r18			# compare with fencepost
	blt copy_next_word			# if < fence, keep going
	blr					# return

	.align 2
kernel_start:
	.incbin "./vmlinux.bin"			# inline a copy of the kernel
kernel_end:
