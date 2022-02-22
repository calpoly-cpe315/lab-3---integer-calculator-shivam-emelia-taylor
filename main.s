    // Template main.s file for Lab 3
    // Emelia, Shivam, Taylor

    .arch armv8-a
 
    // --------------------------------
    .global main
main:
    // driver function main lives here, modify this for your other functions
	stp    x29, x30, [sp, -48]!
	add    x29, sp, 0
	bl     loop
	
loop:
	/*num 1*/
	ldr    w0, =num1
	bl     printf
	ldr    w0, =scanint
	add    x1, x29, 40
	bl     scanf
	ldr    x0, [x29, 40]
	str    x0, [x29, 32]

	/*num 2*/
	ldr    w0, =num2
	bl     printf
	ldr    w0, =scanint
	add    x1, x29, 40
	bl     scanf
	ldr    x2, [x29, 40]
	str    x2, [x29, 24]

	/*operation*/
	ldr    w0, =operation
	bl     printf
	ldr    w0, =scanchar
	add    x1, x29, 40
	bl     scanf
	ldr    x3, [x29, 40]

	/*branch to operation*/
	/*comp to each op type*/

	/* + */
	ldr    x1, =addchar
	ldrb   w1, [x1]
	cmp    w1, w3
	ldr    x0, [sp, 32]
	ldr    x2, [sp, 24]
	b.ne   sub
	bl     intadd /*intadd*/
	bl     output
sub:	
	/* - */
	ldr    x1, =subchar
	ldrb   w1, [x1]
	cmp    w1, w3
	b.ne   mul
	bl     intsub /*intsub*/
	bl     output

mul:	
	/* * */
	ldr    x1, =mulchar
	ldrb   w1, [x1]
	cmp    w1, w3
	b.ne   no
	bl     intmul /*intmul*/

output:	
	/*result*/
	/*load result*/
	
	mov    x3, x0
	ldr    w0, words
	/*some how put in result*/
	mov    x1, x3
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
	mov    x0, #0
	mov    x2, #0
	mov    x3, #0
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
words:
	.word    result
result:
	.asciz    "Result is: %d\n"
again:
	.asciz    "Again? "
error:
	.asciz    "Invalid Operation Entered.\n"
