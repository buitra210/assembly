.data
str1: .space 10000
str2: .space 10000
dem: .word 0        # Bi?n ??m
prompt1: .asciiz "Chuoi 1: "
prompt2: .asciiz "Chuoi 2: "
result: .asciiz "So ky tu chung la: "

.text
.globl main

main:
    # Khai b�o chu?i 1 t? b�n ph�m
    li  $v0, 4
    la  $a0, prompt1
    syscall
    li  $v0, 8
    la  $a0, str1
    li  $a1, 10000
    syscall
    
    # Khai b�o chu?i 2 t? b�n ph�m
    li  $v0, 4
    la  $a0, prompt2
    syscall
    li  $v0, 8
    la  $a0, str2
    li  $a1, 10000
    syscall
    
    # V�ng l?p v� so s�nh
    li $t0, 0    # G�n gi� tr? kh?i t?o cho bi?n ??m
    li $t1, 0    # G�n gi� tr? kh?i t?o cho bi?n i
    li $t2, 0    # G�n gi� tr? kh?i t?o cho bi?n j
    
    Dem1:
    li $t3, 0 # Kh?i t?o cho bi?n ??m s? ph?n t? chu?i 1
    lb $t4, str1($t1) 
    beqz $t4, end1
    addi $t3, $t3, 1
    j Dem1
    
   end1:
   Dem2:
    li $t5, 0 # Kh?i t?o cho bi?n ??m s? ph?n t? chu?i 2
    lb $t6, str2($t2) 
    beqz $t6, end2
    addi $t5, $t5, 1
    j Dem2
   end2:
    
    outloop:
    lb $t4, str1($t1) 
    beqz $t4, end
    addi $t1, $t1, 1
    
    li $t2, 0
    
    inloop:
    lb $t6, str2($t2) 
    beqz $t6, endinloop
    sub $t8, $t5, $t2
    bltz $t8, endinloop
    beq $t4, $t6, match
    addi $t2, $t2, 1
    j inloop
    
    match:
    addi $t0, $t0, 1
    sb $zero, str2($t2)
    j endinloop
    
    endinloop:
    addi $t2, $t2, 1
    sub $t7, $t3, $t1
    bltz $t7, end
    j outloop
    
    end:
    li $v0, 4
    la $a0, result
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    # Tho�t ch??ng tr�nh
    li $v0, 10
    syscall
