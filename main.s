    // Template main.s file for Lab 3
    // Emelia, Shivam, Taylor

    .arch armv8-a

    // --------------------------------
    .global main
main:
    // driver function main lives here, modify this for your other functions
	stp    x29, x30, [sp, -48]!
	add    x29, sp, 0
	stp    x0, x1, [sp, 16]
	stp    x2, x3, [sp, 32]
	bl     loop
	
loop:
	/*num 1*/
	ldr    w0, =num1
	bl     printf
	ldr    w0, =scanint
	add    x1, sp, 16
	bl     scanf
	ldr    x0, [sp, 16]
	str    x0, [sp, 16]

	/*num 2*/
	ldr    w0, =num2
	bl     printf
	ldr    w0, =scanint
	add    x1, sp, 16
	bl     scanf
	ldr    x2, [sp, 16]
	str    x2, [sp, 32]

	/*operation*/
	ldr    w0, =operation
	bl     printf
	ldr    w0, =scanchar
	add    x1, sp, 16
	bl     scanf
	ldr    x3, [sp, 16]
	str    x3, [sp, 32]

	/*branch to operation*/
	/*comp to each op type*/

	/* + */
	ldr    x1, =addchar
	ldrb   w1, [x1]
	cmp    w1, w3
	ldr    x0, [sp, 16]
	ldr    x2, [sp, 32]
	b.ne   sub
	b.eq   intadd /*intadd*/
	bl     output
sub:	
	/* - */
	ldr    x1, =subchar
	ldrb   w1, [x1]
	cmp    w1, w3
	b.ne   mul
	b.eq   intsub /*intsub*/
	bl     output

mul:	
	/* * */
	ldr    x1, =mulchar
	ldrb   w1, [x1]
	cmp    w1, w3
	b.ne   no
	b.eq   intmul /*intmul*/

output:	
	/*result*/
	/*load result*/
	mov    x2, x0
	ldr    x0, =result
	/*some how put in result*/
	bl     printf
	
    // You'll need to scan characters for the operation and to determine
    // if the program should repeat.
    // To scan a character, and compare it to another, do the following
	ldr    x0, =again
	bl     printf
	ldr    w0, =scanchar
	mov    x1, x0
	mov    x1, sp          // Save stack pointer to x1, you must create space
	bl     scanf           // Scan user's answer
	ldr    x1, =yes        // Put address of 'y' in x1
	ldrb   w1, [x1]        // Load the actual character 'y' into x1
	ldrb   w0, [sp]        // Put the user's value in r0
	cmp    w0, w1          // Compare user's answer to char 'y'
	b.ne   end
	b.eq   loop            // branch to appropriate location

no:
	ldr    x0, =error
	bl     printf
end:
	ldp    x29, x30, [sp], 32
	ret

yes:
    .byte   'y'
addchar:
	.byte    '+'
subchar:
	.byte     '-'
mulchar:
	.byte     '*'
scanchar:
    .asciz  " %c"

scanint:
	.asciz    "%d"
	.space    1
num1:
	.asciz    "Enter Number 1: "
num2:
	.asciz    "Enter Number 2: "
operation:
	.asciz    "Enter Operation: "
result:
	.asciz    "Result is: %d\n"
again:
	.asciz    "Again? "
error:
	.asciz    "Invalid Operation Entered.\n"
