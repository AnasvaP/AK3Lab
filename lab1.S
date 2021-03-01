.global lab1
.syntax unified
#define a #11
#define b #15
#define c #3

lab1:
	push {lr}
	mov r0, a
	mov r1, b
	mov r2, c
	mov r4, #1
	mov r5, #1
	and r4, r0, r1
	lsr r5, r4, #1
	mov r3, #1
	factorial:
		cmp r2, #1
		beq sum
		mul r3, r2
		sub r2, #1
		bne factorial
	sum:
		add r5, r3
		pop {pc}

