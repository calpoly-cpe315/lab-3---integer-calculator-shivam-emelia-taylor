    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:
	stp   x29, x30, [sp, -16]!
	add   x29, sp, 0

	ldp   x29, x30, [sp], 16
	ret
