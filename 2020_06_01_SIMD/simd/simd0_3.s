.fpu neon

.align 4
.data
a: .short 1,2,3,4,5,6,7,8
b: .short -1,-2,-3,-4,-5,-6,-7,-8
c: .short 0,0,0,0,0,0,0,0

.align 4
.text
.global main
main:
	push {lr}

	ldr r0, =a
	vld4.16 {q0,q1}, [r0]
	vadd.i16 q2,q0,q1
	ldr r0, =c
	vst1.16 {q2},[r0]

	pop {pc}
