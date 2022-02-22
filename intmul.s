    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:
   /* x0 = num 1 and return location, x2 = num2
   /* x3 = a, x4 =b, x1=c, x5 = additionC x6=b and result, x7 is temp b
	/*and - carry*/
	stp    x29, x30, [sp, -16]!

   mov   x3, x0
   mov   x4, x2
   mov   x1, #0
multloop:
   and   x6, x4, #1
   cmp   x6, #0
   b.eq  cont
   mov   x7, x1
   mov   x2, x3

multaddloop: 
   and   x5, x7, x2
   eor   x7, x7, x2
   lsl   x2, x5, #1

   cmp   x2, #0
   b.ne  multaddloop
   mov   x1, x7

cont:
   lsl   x3, x3, #1
   lsr   x4, x4, #1   
   
   cmp   x4, #0
   b.eq  multloop

   mov   x0, x1

	ldp    x29, x30, [sp], 16
	ret
   