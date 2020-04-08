//
// assemble with: g++ if_else3.s -g -o if_else3
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
if_r0_ge_r1:			// suggested naming of labels for if statements: if_{your test condition}
	cmp r0, r1		// Q: What are we comparing? A: register r0, and r1
	blt else_r0_lt_r1

	mov r2, #123		// Q: How are we comparing? A: is r0 >= r1
	mov r3, #137
	add r4, r2, r3
	b end_if_r0_ge_r1

else_r0_lt_r1:
	mov r2, #234
	mov r3, #170
	sub r4, r2, r3

end_if_r0_ge_r1:

	mov pc, lr		// since we did not use bl to call printf, LR did not change in our code's execution


