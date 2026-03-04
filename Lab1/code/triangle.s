.data
    input_msg_1:    .asciiz "Please enter option (1: triangle, 2: inverted triangle): "
    input_msg_2:    .asciiz "Please input a triangle size: "
    newline:        .asciiz "\n"
    star:           .asciiz "*"
    space:          .asciiz " "

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

    li      $t2, 0

loop:
    bge     $t2, $t1, end

    beq     $t0, 1, tri
    beq     $t0, 2, inv_tri

    j       end

tri:
    move    $t3, $t2        # $t3 = l = i

    j       print_layer

inv_tri:
    sub     $t3, $t1, $t2
    sub     $t3, $t3, 1     # $t3 = l = n - i - 1

    j       print_layer

print_layer:
    li      $t4, 1

    sub     $t5, $t1, $t3   # $t5 = j = n - l

loop_space:
    bge     $t4, $t5, print_star

    li      $v0, 4
    la      $a0, space
    syscall

    addi    $t4, $t4, 1
    j       loop_space

print_star:
    li      $t6, 0

    add     $t6, $t1, $t3   # $t6 = j = n + l

loop_star:
    bgt     $t5, $t6, end_print

    li      $v0, 4
    la      $a0, star
    syscall

    addi    $t5, $t5, 1
    j       loop_star

end_print:
    li      $v0, 4
    la      $a0, newline
    syscall

    addi    $t2, $t2, 1
    j       loop

end:
    li      $v0, 10
    syscall
