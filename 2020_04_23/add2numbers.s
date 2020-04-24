.global main

.align 4
.section .rodata
prompt: 	.asciz "Enter two integer values: "
scan_str:	.asciz "%d %d"
output:		.asciz "The sum of %d and %d is %d\n"

.align 4
.section .data
a:	.word	0
b:	.word	0

.align 4
.text
add2numbers:		// int add2numbers(int x, int y)
			// {
	/// the value of x is in R0, and the value of y is in R1
	add r0, r0, r1	// "x+y"
			//	return x+y;
			// }
	mov pc, lr

	// note: this is a simple function. this "simple" function does not
	// call any other functions and LR is unchanged, so we do not
	// need to save it!

main:
			// int main()
	push {lr}	// {
			// 	int a, b; // see .section .data
			// 	printf("Enter two integer values: ");

	ldr r0, =prompt // r0 must hold the address of the string literal
	bl printf	// call printf

			// scanf("%d %d", &a, &b);
	ldr r0, =scan_str
	ldr r1, =a
	ldr r2, =b
	bl scanf
b2:	// a label we can uses as a breakpoint to keep gdb from finishing
	// program's execution after we input values.

			//int c = add2numbers(a,b); // we will use r0 for "c"
	ldr r0, =a	// we need to get value stored in "a", get its address
	ldr r0, [r0]	// r0 now holds value of "a"
	ldr r1, =b	// we need "b" address
	ldr r1, [r1]	// r1 now holds value of "b"
	bl add2numbers

			// printf("The sum of %d and %d is %d\n", a, b, c);
	mov r3, r0	// r3 = r0
	ldr r0, =output
	ldr r1, =a
	ldr r1, [r1]
	ldr r2, =b
	ldr r2, [r2]
	bl printf
			// 	return 0;
	mov r0, #0
	pop {pc}
			// }

