// rename this file to the name that best suites your assignment.
//
// how to assemble: g++ lab_042320.s -g -o lab_042320
//

.align 4
.section .rodata  // this section contains read only data
/* Prompt message */
greet:	.ascii "Demonstrate functions in assembly language with division and modulus.\n"
	.ascii "Our program has three functions, divmod, div and mod. The div and mod\n"
	.asciz "functions will call the divmod functions internally for their tasks.\n"

prompt: .asciz "Enter two integers (seperate with a space between values): "

// Output message(s) */
output_1: .asciz "%d / %d = %d\n"
output_2: .asciz "%d %% %d = %d\n"

// Format pattern for scanf */
pat_2int: .asciz "%d %d"

.align 4
.section .data
// this section contains readable/writeable data
// If you need to store inputs from scanf, they go here
a: .word 0
b: .word 0

// any additional data here

.align 4
.section .text
.global main
main:
	push {lr}		// save our return address

	ldr r0, =greet		// output greetings/instructions
	bl printf

    	ldr r0, =prompt		// output your prompt
    	bl printf

    	ldr r0, =pat_2int 	// r0 contains pointer to format string for our scan pattern */
    	ldr r1, =a	  	// r1 contains pointer to variable label where our first number is stored */
	ldr r2, =b		// r2 contains pointer to variable label where our second number is stored */

	mov r4, r1		// r4 holds the copy of the address of a
	mov r5, r2		// r5 holds the copy of the address of b

    	bl scanf              	// call to scanf */
bp1:				// bp1 used as a breakpoint with the debugger if needed

/////////////////////////////////////////////////////////////////////////////////////
/////										/////
/////	Your program code for assignments goes below this comment block		/////
/////										/////
/////////////////////////////////////////////////////////////////////////////////////

	// test the div function
	ldr r0, [r4]		// r4 has address of a, load the data into r0
	ldr r1, [r5]		// r5 has address of b, load the data into r1
	bl div			// call the div function, r0 will hold a/b

	mov r3, r0		// copy the return value of div into r3 for output
	ldr r0, =output_1	// r0 must have address of output_1
	ldr r1, [r4]		// r1 holds value of a (r4 has a's address)
	ldr r2, [r5]		// r2 holds value of b (r5 has b's address)
	bl printf

	// test the mod function
	ldr r0, [r4]		// r4 has address of a, load the data into r0
	ldr r1, [r5]		// r5 has address of b, load the data into r1
	bl mod			// call the mod function, r0 will hold a%b

	mov r3, r0		// copy the return value of mod into r3 for output
	ldr r0, =output_2	// r0 must have address of output_2
	ldr r1, [r4]		// r1 holds value of a (r4 has a's address)
	ldr r2, [r5]		// r2 holds value of b (r5 has b's address)
	bl printf


/////////////////////////////////////////////////////////////////////////////////////
/////										/////
/////	Your program code for assignments goes above this comment block		/////
/////										/////
/////////////////////////////////////////////////////////////////////////////////////

	mov r0, #0		/* exit code 0 = program terminated normally */
	pop {pc}		/* exit our main function */

/////////////////////////////////////////////////////////////////////////////////////
/////										/////
/////	Function: divmod							/////
/////	Purpose: find the integer division and modulus of two integers a, and b /////
/////	Input Parameters: R0 = a, R1 = b					/////
/////	Return Values: R0 = a/b, R1 = a%b					/////
/////										/////
/////////////////////////////////////////////////////////////////////////////////////
divmod:
	push {lr}	// save our return address in the link register
	mov r3, r0	// r3 is our scratch register holding "a"
	mov r2, r1	// r2 is our scratch register holding "b"
	mov r0, #0	// r0 is our loop counter register, will count the number of subtractions for our division

divmod_while_r3_gte_r2:	// while r3 is greater than or equal to r2, we loop
	cmp r3, r2	// compare numerator (r3) and denominator (r2)
	blt end_divmod_while_r3_gte_r2 // if r3 is less than r2, then we are done and exit loop!
	add r0, r0, #1	// increment our counter variable by 1
	sub r3, r3, r2	// r3 = r3 - r2
	bal divmod_while_r3_gte_r2     // jump back to beginning of the loop and compare r3, r2 again

end_divmod_while_r3_gte_r2: // end of while loop for r3 greater than or equal to r2

	// at this point, r0 holds "a/b" and r3 holds the remainder of a/b or a%b
	mov r1, r3
	pop {pc}

/////////////////////////////////////////////////////////////////////////////////////
/////										/////
/////	Function: div   							/////
/////	Purpose: find the integer division of two integers a, and b             /////
/////	Input Parameters: R0 = a, R1 = b					/////
/////	Return Values: R0 = a/b							/////
/////										/////
/////////////////////////////////////////////////////////////////////////////////////
div:
	push {lr}
	bl divmod
	pop {pc}

/////////////////////////////////////////////////////////////////////////////////////
/////										/////
/////	Function: mod   							/////
/////	Purpose: find the integer modulus of two integers a, and b              /////
/////	Input Parameters: R0 = a, R1 = b					/////
/////	Return Values: R0 = a%b							/////
/////										/////
/////////////////////////////////////////////////////////////////////////////////////
mod:
	push {lr}
	bl divmod
	mov r0, r1	// r1 has a%b from divmod
	pop {pc}
