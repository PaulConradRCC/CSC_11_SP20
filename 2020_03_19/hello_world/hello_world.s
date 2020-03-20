/* our C++ version of hello_world

#include <cstdio>

const char * greeting = "Hello World!!!\n";

int main()
{
        printf( greeting );

        return 0;
}
*/

// bare bones source file
.global main

.align 4
.section .rodata
// all constant data goes here - such as named constants
greeting: .asciz "Hello World!!!\n" // .asciz = ascii string, zero(nul) terminated

.align 4
.section .bss
// all uninitialized data goes here - will not really use this much until dynamic arrays
// any uninitialized data that is put in this section WILL NOT BE included in the final
// binary file image that is stored on the storage media.

.align 4
.section .data
// all non-constant, initialized data goes here

.align 4
.text
main: 	push {lr} // save link register, this is one of many ways this can be done

	// assembly program here

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

