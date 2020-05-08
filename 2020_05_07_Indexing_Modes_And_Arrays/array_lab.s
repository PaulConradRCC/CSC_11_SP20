.global main

// read only section
.align 4
.section .rodata

intro:		.asciz "Welcome to the Array Lab\n\n"
prompt:		.asciz "Enter an integer for a[%d]: "
output_1:	.asciz "Array before sorting....\n\n"
output_2:	.asciz "Array after sorting....\n\n"
output_int:	.asciz "%d, "
back_space:	.asciz "\b\b "
scan_s: 	.asciz "%d"

// data section with our array
.align 4
.section .data

// array a will hold 10 integers, so we need to skip 4 * 10 = 40 bytes
// each int takes up 4 bytes, we have 10 of them.
a:	.skip	40

// bubble_sort - input: R0 holds address of the array
//			R1 holds the number of elements in array (size)
.align 4
.text
bubble_sort:
	push {r4, r5, r6, r7, r8, lr}
				/// bool R2;  <- use register R2 for swapped
do_bubble_sort:			/// do {
	mov R2, #0		///	R2 = #0  (int representation false=0);
	mov R3, #0		/// 	for(int R3=0; R3<R1-1; R3++)
	sub R4, R1, #1
for_lp:	cmp R3, R4		/// 	{
	beq end_for_lp
	// R5 holds a[R3], and R6 holds a[R3+1] (we'll use R7 for R3+1)
	add R7, R3, #1		///		R7 = R3+1;
if_st:	ldr R5, [R0,+R3,LSL #2] ///		if ( a[R3] > a[R7] )
	ldr R6, [R0,+R7,LSL #2]	///		{
	cmp R5, R6
	ble end_if_st
	mov R2, #1		///			swapped = true;
	mov R8, R6		///			int R8 = a[R7];
	str R5, [R0,+R7,LSL #2]	///			a[R7] = a[R3];
	str R8, [R0,+R3,LSL #2]	///			a[R3] = R8;
end_if_st:			///		}
	add R3, #1		///	}
	b for_lp
end_for_lp:
	cmp R2, #1		/// } while(swapped);
	beq do_bubble_sort	/// branch back to do_bubble_sort label
	pop {r4, r5, r6, r7, r8, pc}

.align 4
main:
	push {r4, r5, lr}

	ldr R0, =intro
	bl printf

	ldr R5, =a		/// R5 holds base address of the array
	mov R4, #0
main_for_lp:
	cmp R4, #10
	beq end_main_for_lp	/// for(int R4=0; R4<10; R4++) {
				/// 	printf( prompt, R4 );
	ldr R0, =prompt
	mov R1, R4
	bl printf
				///	scanf( scan_s, a[R4] );
	ldr R0, =scan_s
	add R1, R5, R4, LSL #2	//	R1 = R5 + R4 * 4 to calculate address
	bl scanf

	add R4, #1
	b main_for_lp
end_main_for_lp:
				/// }
	ldr R0, =output_1
	bl printf

	mov R0, R5		// address of array copied to R0
	mov R1, #10		// 10 integer array
	bl display_array

	mov R0, R5		// address of array copied to R0
	mov R1, #10		// 10 integer array
	bl bubble_sort

	ldr R0, =output_2
	bl printf

	mov R0, R5		// address of array copied to R0
	mov R1, #10		// 10 integer array
	bl display_array


	pop {r4, r5, pc}

// display_array - input: R0 holds address of the array
//			  R1 holds the size of the array
.align 4
display_array:	push {r4, r5, lr}	///
		mov R4, R0		// make copy of R0 in R4
		mov R5, R1		// make copy of R1 in R5
		mov R2, #0
display_for_lp:	cmp R2, R5
		beq end_display_for_lp
				/// for(int R2=0; R2<R5; R2++)
		ldr R0, =output_int
		ldr R1, [R4, +R2, LSL #2]
		push {R2}
		bl printf 	///	printf( output_int, R4[R2] );
		pop {R2}
		add R2, #1
		b display_for_lp
end_display_for_lp:
		ldr R0, =back_space
		bl printf	/// printf( back_space );
		pop {r4, r5, pc}
