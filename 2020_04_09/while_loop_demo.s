.global main

.align 4
.section .rodata
/* Prompt message */
prompt: .asciz "Hi there! Please type an integer number: "

/* Response message */
response: .asciz "Sum of integers from 1 to %d is %d\n"

/* Format pattern for scanf */
pattern: .asciz "%d"

.align 4
.section .data
/* Where scanf will store the number read */
value_read: .word 0

.align 4
.text
.global main
main:
	push {lr}		/* save our return address */

	// register r4 holds address to value_read
	ldr r4, =value_read

    	ldr r0, =prompt		/* r0 contains pointer to prompt message */
    	bl printf		/* call printf to output our prompt */

    	ldr r0, =pattern 	/* r0 contains pointer to format string for our scan pattern */
    	mov r1, r4	  	/* r1 contains pointer to variable label where our number is stored */
    	bl scanf              	/* call to scanf */
next:

	// to be implemented together in lab
	// our loop to sum all integers from 1 to value_read (in reg r4)
	// sum is stored in register r5
	// loop_counter is register r0
	//
	// r5=0;
	// while ( r0 < r4 )
	// {
	//	r5 = r5 + r0;
	//	r0++;
	// }

	ldr r0, =response	/* r0 contains pointer to response message */
	mov r1, r4		/* r1 contains pointer to value_read */
	mov r2, r5
	bl printf		/* call printf to output our response */

	mov r0, #0		/* exit code 0 = program terminated normally */
	pop {pc}		/* exit our main function */
