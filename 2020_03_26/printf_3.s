// assemble: g++ printf_3.s -g -o printf_3
//
// program purpose: demonstrate usage of printf with one or more format specifiers
// using variables (labels)
//
// key points to keep in mind:
// 1. put all format strings and string literals in .section .rodata
// 2. adhere to the ARM Architecture Procedure Call Standard
// 3. keep number of format specifiers to no more than 3.
// 4. this demo program also discusses how to load data from variables into registers

// to load data from variables (labels) into registers, we must use the following model:
//
// ldr dest_reg1, =your_label_name	(1)
// ldr dest_reg2, [dest_reg1]		(2)
//
// where we have the following: dest_reg1, dest_reg2 are destination registers (they can be same register)
// (1) loads the address of the label into dest_reg1,
// (2) loads the data stored at the address stored in dest_reg1, this is dereferencing a pointer in C/C++
//
// You'll often see your instructor use same register for dest_reg1 and dest_reg2. This is okay to do
// if we do not plan on keeping the address of the label in register memory. Be cautious of this when
// we cover arrays.

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
.section .data
// the .word directive tells the assembler that the memory location is to hold a 32 bit integer word
value1:	.word 12345	// similar to int value1 = 12345; in C/C++
value2: .word 23456	// simliar to int value2 = 23456; in C/C++
value3: .word 34567	// similar to int value3 = 34567; in C/C++

.align 4
.text
main: 	push {lr} // we need to save LR's content for later and call to printf
		  // will overwrite it, if we do not save it, our program cannot properly terminate

	ldr r0, =string_1	// printf requires address of format string to be in register r0
	mov r1, r0
	ldr r2, =value1		// load the address of value1 into r2
	ldr r2, [r2]		// load the data into r2 from the address in the original r2
				// this is how we dereference addresses in assembly langauge
				// think of this like: r2 = *r2; in C/C++ where r2 on the right side
				// of the = contains the address of the variable value1
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	ldr r0, =string_2	// printf requires address of format string to be in register r0
	mov r1, r0
	ldr r2, =value1		// r2 holds address of value1
	ldr r3, =value2		// r3 holds address of value2
	ldr r2, [r2]		// dereference r2, and store value1's value in r2
	ldr r3, [r3]		// dereference r3, and store value2's value in r3
	bl printf		// call printf, we use the bl (branch with link) instruction to do this

	ldr r0, =string_3	// printf requires address of format string to be in register r0
	mov r1, r0
	ldr r2, =value1		// r1 holds address of value1
	ldr r3, =value2		// r2 holds address of value2
	ldr r4,	=value3		// r3 holds address of value3
	ldr r2, [r2]		// dereference r2, and store value1's value in r2
	ldr r3, [r3]		// dereference r3, and store value2's value in r3
	ldr r4, [r4]		// dereference r4, and store value3's value in r4
	push {r4}
	bl printf		// call printf, we use the bl (branch with link) instruction to do this
	pop {r4}

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

