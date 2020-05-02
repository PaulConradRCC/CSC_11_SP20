/*

Shift Left: we can shift bits to left #n of bits. This is
effectively multiplying a number by 2^n

Ex: 0011 1110 -> shift left 1 bit -> 0111 1100
    62 decimal			     124 decimal

Shift Right: we shift bits to right #n of bits. This is
effectively diving by 2^n

Ex: 0111 1100 -> shift right 1 bit -> 0011 1110
    124 decimal			      62 decimal

Ex: 0011 1110 -> shift right 3 bit -> 0000 1111
    124 decimal			      15 decimal

ARM chip only has Rotate Right, no Rotate Left like Intel
or old Commodore Computers

Rotate the bits to the right, instead of least signifcant
bit being dropped off, we place the into both the carry flag
and the register's most signficant bit.

8 bit example (as seen on Intel or C64/C128):

0110 1101, rotate right 1 bit -> 1011 0110

ARM (32 bit register)

1100 0011 0110 1001 0101 1010 1100 0011 rotate right 4 bits yield:
0011 1100 0011 0110 1001 0101 1010 1100

"Rotate Left" (do a rotate right [32-n] bits) on ARM:

1100 0011 0110 1001 0101 1010 1100 0011 rotate left 4 bits
(it is same as rotate right 32-4=28 bits) yields:

0011 0110 1001 0101 1010 1100 0011 1100

Model to emulate the Rotate Left on ARM Chip:

Assume our binary number is in register R0, and the number bits (n)
is in register R1:

	rsb r1, r1, #32		// r1 = 32 - r1
	mov r0, r0, ror r1

the following function emulates rotate left for the ARM CPU
*/

.text	// section for the code
.global rotate_left

rotate_left:
	rsb r1, r1, #32	// r1 = #32 - r1
	mov r0, r0, ror r1
	mov pc, lr
