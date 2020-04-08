//
// assemble with: g++ if_else.s -g -o if_else
// note: you can remove the -g if you do not want debugger info in executable.
//
/* how to do if/else statements in ARM Assembly.

assume: r0 = #10, r1 = #8

if ( r0 > r1 )
     r2 = #123
else
     r2 = #234

*/

.global main

.text
main:
	mov r0, #10
	mov r1, #8

	// if ( r0 > r1 )
	cmp r0, r1		// Q: What are we comparing? A: register r0, and r1
	movgt r2, #123		// Q: How are we comparing? A: is r0 > r1, if so, mov into r2, the value #123
	movle r2, #234

	mov pc, lr		// since we did not use bl to call printf, LR did not change in our code's execution


