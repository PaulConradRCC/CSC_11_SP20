// like simd0.s but in strides of 2
.fpu neon

.align 4
.data
a: .float 1.1,2.2,3.3,4.4
b: .float 5.5,6.6,7.7,8.8
c: .float 0,0,0,0,0,0,0,0

.align 4
.text
.global main
main:
	push {lr}

	ldr r0, =a
	vld2.32 {q0,q1}, [r0]
	vadd.f32 q2,q0,q1
	ldr r0, =c
	vst2.32 {q2},[r0]

	pop {pc}
