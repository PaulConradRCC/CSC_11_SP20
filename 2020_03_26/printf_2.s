// assemble: g++ printf_2.s -g -o printf_2
//
// program purpose: demonstrate usage of printf with one or more format specifiers
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
string_1: .asciz "Reg R0 holds %d, Reg R1 holds %d....\n"
string_2: .asciz "Reg R0 holds %d, Reg R1 holds %d, Reg R2 holds %d....\n"
string_3: .asciz "Reg R0 holds %d, Reg R1 holds %d, Reg R2 holds %d, Reg R3 holds %d....\n"

.align 4
.text
main: 	push {lr} // we need to save LR's content for later and call to printf
		  // will overwrite it, if we do not save it, our program cannot properly terminate

	ldr r0, =string_1	// printf requires address of format string to be in register r0
	mov r1, r0		// R1 hold value for first format specifier
	mov r2, #123		// put some example number in register r2, this is value for second spec
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	ldr r0, =string_2	// printf requires address of format string to be in register r0
	mov r1, r0
	mov r2, #123		// put some example number in register r1
	mov r3, #178		// put some example number in register r2
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	ldr r0, =string_3	// printf requires address of format string to be in register r0
	mov r1, r0
	mov r2, #150		// put some example number in register r1
	mov r3, #175		// put some example number in register r2
	mov r4, #220		// put some example number in register r3
	push {r4}		// more than four parameters, we have to push fifth parameter on stack
	bl printf		// call printf, we use the bl (branch with link) instruction to do this
	pop {r4}		// everytime we push a value on the stack, we need to pop the value off the
				// stack to put the stack memory back into the state it was before the
				// push was done

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

