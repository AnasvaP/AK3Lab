.global lab4
.syntax unified


#define X1 #12
#define X2 #2
#define X3 #-10
#define X4 #15

lab4:
	push {lr}
	bl task1
	bl task2
	pop {pc}

task1:
	push {lr}
	mov r0, X1
	mov r1, #0
	mov r2, X2
	mov r3, #0
	mov r4, X3
	mov r5, #0xFFFFFFFF
	mov r6, X4
	mov r7, #0
	
	add r4, #1 // X3+1
	adc r5, #0 

	sub r4, r6 //X3-X4
	sbc r5, r7
	
	lsr r4, #1 // (X3+1-X4) : 4
	lsr r4, #1
	lsr r0, #1 // X1/2
	
	asr r5, #1
	asr r5, #1
	asr r1, #1
	
	add r0, r2 // X1/2 + X2
	adc r1, r3 
	
	lsl r0, #1
	lsl r0, #1 // 4* (X1/2 + X2)

	orr r0, r4  // (X3+1-X4) : 4 v 4(X1/2 + X2)
	orr r1, r5
	
	bl program_for_result_correction
	pop {pc}
	

program_for_result_correction:
	push {lr}
	bvc step2
	lsr r0, #1
	lsr r1, #1
step2:
	orr r0, #0	
	bne step4
	orr r1, #0	
	bne step4
	mov r0, #0b00011001
step4:
	add r1, #0b00011001
	and r5, r1, #0xc0000000
	beq step7
	eor r5, #0xc0000000
	beq step7
	lsr r0, #1
	lsr r1, #1
step7:
	bvs end_program_for_result_correction
	push {r0}
	push {r1}
	pop {r1}
	pop {r0}

end_program_for_result_correction:
	pop {pc}


task2:
	push {lr}

	mov r0, #0
	mov r1, #32
	mov r2, #4
	mov r3, #3

program_A:
	// 1
	add r0, r1, r2
	// 2
	udiv r0, r1, r2
t3:
	// 3
	sub r0, r1
	// 4
	bvs t1
	// 6
	add r2, r0, r1
	
	bl program_B
	b t2
t1:
	// 5
	udiv r1, r0, r3
	// 7
	add r1, 15
	
	bl program_B
t2:
	// 8
	beq t3
	// 9
	and r0, r1
	
	pop {pc}

program_B:
	push {lr}
t5:
	// 10
	mul r2, r0, r3
	// 11
	bcs t4
	bl program_C
	// 12
	eor r2, r1
t4:
	// 13
	bvs t5
	// 14
	sub r0, r1, r2
	// 15
	sub r1, r2
	
	pop {pc}

program_C:
	push {lr}
	
	// 17
	udiv r0, r2, r1
	// 18
	adds r0, r1, r2
	
	pop {pc}
