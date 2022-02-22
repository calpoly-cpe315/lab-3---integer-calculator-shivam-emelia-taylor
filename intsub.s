    // intsub function in this file

    .arch armv8-a
    .global intsub

intsub:
   /* x0 = num 1 and return location, x2 = num2
   /* x3 = x, x4 =y, x5=borrow, x6=notX
	/*negate x2 and x1, x2 carry*/
	stp    x29, x30, [sp, -16]!
	
   mov   x3, x0
   mov   x4, x2

subloop: 
   
   mvn   x6, x3
   and   x5, x6, x4
   eor   x3, x3, x4
   lsl   x4, x5, #1

   cmp   x4, #0
   b.ne  subloop

   mov   x0, x3


	ldp    x29, x30, [sp], 16
	ret

