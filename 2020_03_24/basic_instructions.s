// assemble: g++ basic_instructions.s -g -o basic_instructions

.global main

.align 4
.text
main:
	// since this program does not make any function calls, we will not need
	// to save LR (link register) with push {LR}

	/*
		Data Movement Instructions:

		(operation){condition}{S} Dest_reg, Operand2
		Operand2 can be a register or immediate value.

		operation: MOV - move, Operand2 can be either a register or an immediate value
		operation: MVN - move not, Operand2 = 0xFFFFFFFF EOR Operand2
	*/

	MOV R0, #42	// moves into the R0 register the integer literal 42
	MOV R1, R0	// moves into R1 the contents in register R0, copy into R1, R0's data
	MOV R0, R0	// moves into R0 the contents of register R0, does nothing, "NOP" no operation

	/*
	Arithmetic Instructions:

	(operation){condition}{S} Dest_reg, Source_reg, Operand2

	operations:
	*/

	ADD R2, R1, R0	// R2 = R1+R0
	SUB R3, R2, R0	// R3 = R2-R0
	RSB R4, R1, R2  // R4 = R2-R1

	/*
		Logical Instructions:

		(operation){condition}{S} Dest_reg, Source_reg, Operand2

		operations:
	*/

	AND R5, R2, #15	// R5 = R2 AND #15
	ORR R6, R2, #15 // R6 = R2 OR #15
	EOR R7, R2, #15 // R7 = R2 EOR #15
	BIC R8, R2, #15 // R8 = R2 AND NOT(#15)

	/*
		Comparison Instructions:

		(operator){condition} Source_reg, Operand2

		operations:
	*/

	CMP R5, R6	// compare R5 and R6, set CPSR flags based on (R5 - R6), R5 and R6 contents remain unchanged
	CMN R6, R7	// compare R6 and R7, set CPSR flags based on (R6 + R7), R6 and R7 contents remain unchanged
	TST R6, #1	// compare R6 and #1 (tests for even/odd), set CPSR flags set to result of (R6 AND #1)
	TEQ R7, R8	// test equivalence, CPSR flags set to result of (R7 EOR R8)

	MOV PC, LR
