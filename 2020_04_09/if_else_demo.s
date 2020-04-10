// assemble: g++ if_else_demo.s -g -o if_else_demo

.global main

.align 4
.section .rodata
/* Prompt message */
prompt: .asciz "Please type in two integer values (seperated by a space): "

/* Response message */
message_1: .asciz "%d is greater than %d!\n"
message_2: .asciz "%d is not greater than %d!\n"

/* Format pattern for scanf */
pattern: .asciz "%d %d"

.align 4
.section .data
/* Where scanf will store the number read */
value_read1: .word 0
value_read2: .word 0

.align 4
.section .text
main:
	push {lr}		/* save our return address */

	// use r4, r5 as registers holding pointers to value_read1, and value_read2
	ldr r4, =value_read1
	ldr r5, =value_read2

    	ldr r0, =prompt		/* r0 contains pointer to prompt message */
    	bl printf		/* call printf to output our prompt */

    	ldr r0, =pattern 	/* r0 contains pointer to format string for our scan pattern */
    	mov r1, r4	  	/* r1 contains pointer to variable label where our first number is stored */
	mov r2, r5		/* r2 contains pointer to variable label where our second number is stored */
    	bl scanf              	/* call to scanf */
next:
	// do whatever it is we need

	// demonstrate:
	// if ( value_read1 > value_read2 )
	//  	printf("%d is greater than %d!\n");
	// else
	//	printf("%d is not greater than %d!\n");

	ldr r1, [r4]		// holds the value of value_read1 in r1
	ldr r2, [r5]		// holds the value of value_read2 in r2

	cmp r1, r2		// compare r1 and r2, this is comparing value_read1 and value_read2
	ldrgt r0, =message_1	// message for when value_read1 > value_read2
	ldrle r0, =message_2	// message for when value_read1 <= value_read2
	bl printf

	mov r0, #0		/* exit code 0 = program terminated normally */
	pop {pc}		/* exit our main function */
