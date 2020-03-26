// assemble: g++ printf_1.s -g -o printf_1
//
// program purpose: demonstrate simple usage of printf, only 1 parameter, the format
// string with no format specifiers
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
my_string: .asciz "Hello, this is my string....\n"


.align 4
.text
main: 	push {lr} // we need to save LR's content for later and call to printf
		  // will overwrite it, if we do not save it, our program cannot properly terminate

	ldr r0, =my_string	// printf requires address of format string to be in register r0
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

