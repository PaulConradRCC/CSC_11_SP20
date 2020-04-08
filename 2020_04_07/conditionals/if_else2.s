//
// assemble with: g++ if_else2.s -g -o if_else2
// note: you can remove the -g if you do not want debugger info in executable.
//
/* how to do if/else statements in ARM Assembly.

assume: r0 = #10, r1 = #8

if ( r0 >= r1 )
{
     r2 = #123
     r3 = #137
     r4 = r2 + r3
}
else
{
     r2 = #234
     r3 = #170
     r4 = r2 - r3
}
*/

.global main

.text
main:
	mov r0, #10
	mov r1, #8

	// if ( r0 >= r1 )
	cmp r0, r1		// Q: What are we comparing? A: register r0, and r1

	movge r2, #123		// Q: How are we comparing? A: is r0 >= r1
	movge r3, #137
	addge r4, r2, r3

	movlt r2, #234
	movlt r3, #170
	sublt r4, r2, r3

	mov pc, lr		// since we did not use bl to call printf, LR did not change in our code's execution


