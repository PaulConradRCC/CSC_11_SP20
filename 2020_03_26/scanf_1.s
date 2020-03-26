// assemble: g++ scanf_1.s -g -o scanf_1
//
// program purpose: demonstrate simple usage of scanf using a 
// scan string with one format specifiers
//
// key points to keep in mind:
// 1. put all format strings and string literals in .section .rodata
// 2. adhere to the ARM Architecture Procedure Call Standard
// 3. keep number of format specifiers to no more than 3.
//

.global main

.align 4
.section .rodata
// all constant data goes here - such as named constants
// put our format string(s) in this section
// syntax for the format string:
// format_string_label: .asciz " .... your string literal inside the quotes .... "
my_string: 	.asciz "Hello, this program demonstrates using scanf with one input....\n"
prompt:	   	.asciz "Enter a signed 32-bit integer: "
scan_str:  	.asciz "%d"	// scan string for scanning in one 32 bit signed integer

output:		.asciz "You have entered %d from the keyboard!\n"

.align 4
.section .data
value1:		.word	0

.align 4
.text
main: 	push {lr} // we need to save LR's content for later and call to printf
		  // will overwrite it, if we do not save it, our program cannot properly terminate

	ldr r0, =my_string	// printf requires address of format string to be in register r0
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	ldr r0, =prompt		// load address of prompt into r0
	bl printf		// print the prompt out to the screen

	ldr r0, =scan_str	// load address of scan_str for scanf
	ldr r1, =value1		// load address of location to store input, scanf needs to know where to
				// store the user input!
	bl scanf		// call scanf and get the user input

	ldr r0, =output		// load into r0 address of our output format string
	ldr r1, =value1		// load into R1 the address of value1
	ldr r1, [r1]		// load into R1 the data stored at address in old R1
	bl printf		// call printf

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

