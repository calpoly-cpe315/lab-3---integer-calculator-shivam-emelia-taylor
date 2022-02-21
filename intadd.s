    // intadd function in this file

    .arch armv8-a
    .global intadd

intadd:
	/*and - carry*/
	stp    x29, x30, [sp, -16]!
	add    x29, sp, 0

	ldp    x29, x30, [sp], 16
	ret



	
