.data
    prompt:    .asciiz "Please input a number: "
    prime_msg: .asciiz "It's a prime\n"
    not_prime_msg: .asciiz "It's not a prime\n"

.text
main:
    li      $v0, 4
    la      $a0, prompt
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0         

    jal     prime

    beq     $v0, $zero, not_prime_label
    j       prime_label

not_prime_label:
    li      $v0, 4
    la      $a0, not_prime_msg
    syscall
    j       exit

prime_label:
    li      $v0, 4
    la      $a0, prime_msg
    syscall
    j       exit


prime:
    move    $t0, $a0

    li      $t1, 1
    beq     $t0, $t1, return_not_prime

    li      $t2, 2           
    sqrt_loop:
        mul     $t3, $t2, $t2   
        bgt     $t3, $t0, return_prime  

        div     $t4, $t0, $t2    
        mfhi    $t5              
        beq     $t5, $zero, return_not_prime  

        addi    $t2, $t2, 1      
        j       sqrt_loop
    
    return_prime:
        li      $v0, 1
        jr      $ra

    return_not_prime:
        li      $v0, 0
        jr      $ra

exit:
    li      $v0, 10
    syscall
