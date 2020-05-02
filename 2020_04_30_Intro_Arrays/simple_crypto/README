You will see that you have several files in this directory named simple_crypto.
Download all of the files.  You will be writing code in the file named:

simple_crypto_functions.s

You are to implement the ARM Assembly Language instruction for the given
steps in the functions: encrypt and decrypt only.  The steps will be
denoted in the encrypt function as:  // step #X_en where X is the step
number and _en denotes this is for the encrypt function (this is for
easier reference if you need help with a particular step).  Each one of
these steps can be done in one instruction each.  

Some important points for both encrypt and decrypt:

1. Saving a series of registers can be done in a single push pseudo-
instruction, as long as the registers being pushed are in order from
smallest to largest in terms of the register's number (if you try to
list them out of order, an assemble error will occur).

e.g. If we want to save registers R0, R4, R8, R12, and LR (which is R14),
we would do the following:  push { R0, R4, R8, R12, LR }  -or-
                            push { R0, R4, R8, R12, R14 }

2. Restoring a series of registers that we did in #1 (above), we do the 
same idea with a single pop pseudoinstruction.

e.g. If we want to restore the saved registers we did in #1, we would do
the following:	pop { R0, R4, R8, R12, LR }  -or-
		pop { R0, R4, R8, R12, R14 }

3. Our encrypt and decrypt functions work with 8-bit char arrays so, you
will see two new instructions:

ldrb - load register byte, loads an 8-bit byte into lowest 8 bits of register
strb - store register byte, stores an 8-bit byte from lowest 8 bits of register

Example usage of ldrb (R0 has address where we want to read from memory):

ldrb R1, [R0]  <- this loads an 8 bit byte from the address in R0, into R1

Example usage of strb (R0 has address where we want to write to memory):

strb R1, [R0]  <- this stores the lowest 8 bits from R1 into address in R0

IMPORTANT: read up on the following blogs:

thinkingeek - Indexing Modes

https://thinkingeek.com/2013/01/26/arm-assembler-raspberry-pi-chapter-7/

thinkingeek - Arrays and More on Indexing Modes

https://thinkingeek.com/2013/01/27/arm-assembler-raspberry-pi-chapter-8/

The following models, you want to use for reading data from / writing data to, 
arrays:

Reading an integer array element:

LDR Rd, [ Rs, Ri, LSL #2 ] <- Rd is destination register, Rs holds base address of array
		              Ri is the register you are using for array index/subscript
			      (note: integers are 4 bytes, LSL #2 is "multiplying" the Ri
			      by four as part of the address calculation (content of Ri is
			      not changed)

Writing an integer back to array:

STR Rd, [ Rs, Ri, LSL #2 ] <- Rd is data register holding value to write back, Rs holds base
			      address of array Ri is the register you are using for array
			      index/subscript (note: integers are 4 bytes, LSL #2 is
			      "multiplying" the Ri by four as part of the address calculation
			      (content of Ri is not changed)

Reading a byte from a byte array:

LDRB Rd, [ Rs, Ri ]           <- Rd is destination register, Rs holds base address of array
		              Ri is the register you are using for array index/subscript
			      (note: with bytes [size is 1 byte], LSL #2 "multiplying" the Ri
			      by four as part of the address calculation IS NOT NEEDED!

Writing a byte back to array:

STRB Rd, [ Rs, Ri ]           <- Rd is data register holding value to write back, Rs holds base
			      address of array Ri is the register you are using for array
			      index/subscript (note: with bytes [1 byte in size], LSL #2
			      "multiplying" the Ri by four as part of the address calculation
			      IS NOT NEEDED!

----------------------------------------------------------------------------------------------
DO NOT MODIFY, DELETE, OR ADD to the following files:

Makefile
simple_crypto_test.cpp
util_functions.s
