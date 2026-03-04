.data
    input_msg_1: .asciiz "Please enter option (1: add, 2: sub, 3: mul): "
    input_msg_2: .asciiz "Please enter the first number: "
    input_msg_3: .asciiz "Please enter the second number: "
    output_msg:  .asciiz "The calculation result is: "
    newline:    .asciiz "\n"

.text
.globl main
main:

    li      $v0, 4
    la      $a0, input_msg_1
    syscall

    li      $v0, 5
    syscall
    move    $t0, $v0

    li      $v0, 4
    la      $a0, input_msg_2
    syscall

    li      $v0, 5
    syscall
    move    $t1, $v0

    li      $v0, 4
    la      $a0, input_msg_3
    syscall

    li      $v0, 5
    syscall
    move    $t2, $v0

    beq     $t0, 1, add_f
    beq     $t0, 2, sub_f
    beq     $t0, 3, mul_f
    j       end

add_f:
    add     $t3, $t1, $t2
    j       print

sub_f:
    sub     $t3, $t1, $t2
    j       print

mul_f:
    mul     $t3, $t1, $t2
    j       print
    
print:
    li      $v0, 4
    la      $a0, output_msg
    syscall

    li      $v0, 1
    move    $a0, $t3
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall

end:
    li      $v0, 10
    syscall
