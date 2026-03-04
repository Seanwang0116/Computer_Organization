.data
	input_msg:	.asciiz "Please input a number: "
	output_msg:	.asciiz "The result of fibonacci(n) is "
	newline:    .asciiz "\n"

.text
.globl main
main:
	li      $v0, 4				
	la      $a0, input_msg		
	syscall                 	
 
	li      $v0, 5          	
	syscall                 	
	move    $a0, $v0      		

	move	$v0, $zero
	jal		fib
	move	$t0, $v0

	li      $v0, 4				
	la      $a0, output_msg		
	syscall                 	
 	
 	move	$a0, $t0
 	li		$v0, 1
 	syscall

	li      $v0, 4
    la      $a0, newline
    syscall

	li 		$v0, 10				
	syscall

.text
fib:
	addi	$sp, $sp, -8
	sw		$ra, 4($sp)
	sw		$a0, 0($sp)

	li      $t0, 1
	blt     $t0, $a0, loop

	add		$v0, $v0, $a0
	addi	$sp, $sp, 8
	jr 		$ra

loop:
	addi	$a0, $a0, -1
	jal		fib

	addi	$a0, $a0, -1
	jal		fib

	lw		$a0, 0($sp)
	lw		$ra, 4($sp)
	
	addi	$sp, $sp, 8
	jr		$ra
