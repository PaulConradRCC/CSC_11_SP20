//
// assemble with: g++ if_else4.s -g -o if_else4
// note: you can remove the -g if you do not want debugger info in executable.
//
/* how to do if/else statements in ARM Assembly.

assume: r0 = #10, r1 = #8, r2 = #9

if ( (r0 > r1) && (r1 != r2) )
     r3 = #123
else
     r3 = #234

this is also (?):

if ( r0 > r1 )
{
	if ( r1 != r2 )
		r3 = #123
	else
		r3 = #234
}
else
	r3 = #234
*/

.global main

.text
main:
	mov r0, #10
	mov r1, #8
	mov r2, #9

	// if ( (r0 > r1) && (r1 != r2) )
	cmp r0, r1		// Q: What are we comparing? A: register r0, and r1
	cmpgt r1, r2		// Compare R1 and R2 only if R0 > R1
	movne r3, #123
	moveq r3, #234

	mov pc, lr		// since we did not use bl to call printf, LR did not change in our code's execution


