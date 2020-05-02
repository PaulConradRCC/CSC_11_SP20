.global clear_keyboard
.global string_length
.global display_message

.text
.align 4
/// function: clear_keyboard
/// input: none
/// output: none
///
.align 4
clear_keyboard:
	push {LR}
WHL_R0_NE_10:		// ASCII code for '\n' is 13 decimal
	bl getchar	// read in a char from keyboard, ascii code of char is in R0
	and R0, #255	// mask out all irrelevant bits
	cmp R0, #10	// compare R0 to #10
	bne WHL_R0_NE_10 // branch if not equal back to start of while loop read next character
	pop {PC}	// otherwise, return from the function, we are all done

//////////////////////////////////////////////////////////////////////////////////////////////
/// end of clear_keyboard function ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

/// function: string_length
/// input: address of the string in R0
/// return: the length of the string in R0
///
.align 4
string_length:
	push {LR}

	mov R1, #0
	ldrb R2, [R0,R1]	// load byte into R2 from *(R0+R1)
WHL_R2_NE_NULL:
	cmp R2, #0		// ASCII code 0 is NULL
	beq END_WHL_R2_NE_NULL
	add R1, #1
	ldrb R2, [R0,R1]
	bal WHL_R2_NE_NULL
END_WHL_R2_NE_NULL:
	mov R0, R1
	pop {PC}
//////////////////////////////////////////////////////////////////////////////////////////////
/// end of string_length function ////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

/// function: display_message
/// input: address of string in R0
///	   length of string in R1
/// return: nothing, just outputs the string
///
/// special note: if ASCII code of character is less than 32 or greater than 127,
/// the function will just print the ASCII code as anything outside of the range is
/// likely to be unprintable.
///
.align 4
display_message:
	push {LR}	// save LR
	mov R2, #0
WHL_R2_LT_R1:
	cmp R2, R1
	bge END_WHL_R2_LT_R1
	ldrb R3, [R0,R2]
IF_R3_LT_32_OR_R3_GT_127:
	cmp R3, #32
	blt OUTPUT_ASCII_CODE
	cmp R3, #127
	blt OUTPUT_CHAR
OUTPUT_ASCII_CODE:		// when R3 < 32 or R3 > 127, output ascii code
	push {R0,R1,R2}		// save our R0, R1, R2 content as printf will not preserve them
	ldr R0, =ASCII_STR
	mov R1, R3
	bl printf
	pop {R0,R1,R2}		// restore our R0, R1, R2 that we had prior to printing
	bal END_IF_R3_LT_32_OR_R3_GT_127 // jump to end of our if block
OUTPUT_CHAR:			// this is essentially the "else" part of our IF statement
	push {R0,R1,R2}		// save our R0, R1, R2 content
	ldr R0, =CHAR_STR
	mov R1, R3
	bl printf
	pop {R0,R1,R2}		// restore our saved R0,R1,R2 for continued use
				// no branch and end of else block as execution falls through
END_IF_R3_LT_32_OR_R3_GT_127:
	add R2, #1
	bal WHL_R2_LT_R1

END_WHL_R2_LT_R1:
	ldr R0, =NEWLINE_STR
	bl printf

	pop {PC}		// exit function

/// local labels for display_message
ASCII_STR:	.asciz	"|%d|"
CHAR_STR:	.asciz 	"%c"
NEWLINE_STR:	.asciz	"\n"
//////////////////////////////////////////////////////////////////////////////////////////////
/// end of display_message function //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
