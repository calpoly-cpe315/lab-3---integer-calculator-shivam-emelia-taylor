    // intsub function in this file

    .arch armv8-a
    .global intsub

intsub:
	/*negate x2 and x1, x2 carry*/
	stp    x29, x30, [sp, -16]!
	add    x29, sp, 0

	ldp    x29, x30, [sp], 16
	ret

