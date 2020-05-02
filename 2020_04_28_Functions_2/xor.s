.global exclusive_or

//
// this function xor's the content of register r0 and r1, returning the result in r0
//

.text
exclusive_or:
	eor r0, r0, r1
	mov pc, lr
