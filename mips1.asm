.data
str: .space 10000 
prompt: .asciiz "Nh?p chu?i ch?a ch? s?: "
result: .asciiz "Chu?i ch?a ch? s?: "
error: .asciiz "Chu?i kh�ng ch?a ch? s?"

.text
.globl main

main:
    # Hi?n th? th�ng b�o y�u c?u nh?p chu?i t? b�n ph�m
    li  $v0, 4
    la  $a0, prompt
    syscall
    
    # Nh?n chu?i t? ng??i d�ng
    li  $v0, 8
    la  $a0, str
    li  $a1, 10000
    syscall
    
    # Ki?m tra xem chu?i ch? ch?a c�c ch? s? hay kh�ng
    addi $t0, $zero, 0   # G�n $t0 = 0, $t0 l?u tr? s? l??ng k� t? trong chu?i
    
    loop:
        lbu $t1, str($t0)     # G�n $t1 = str[$t0], l?y k� t? th? $t0 t? chu?i str
        beqz $t1, convert     # N?u k� t? l� null (k?t th�c chu?i), chuy?n ??n b??c chuy?n ??i
        blt $t1, 48, error    # N?u k� t? l� nh? h?n 48 ('0' trong b?ng ASCII), chu?i kh�ng ch?a ch? s?
        bgt $t1, 57, error    # N?u k� t? l� l?n h?n 57 ('9' trong b?ng ASCII), chu?i kh�ng ch?a ch? s?
        addi $t0, $t0, 1      # T?ng s? l??ng k� t? l�n 1 v� ti?p t?c v�ng l?p
        j loop
    
    convert:
    # Chuy?n ??i chu?i th�nh s? nguy�n
    addi $t2, $zero, 0   # $t2 l� ??a ch? chu?i
    addi $t3, $zero, 10  # $t3 l� h? s?
    addi $t4, $zero, 0   # $t4 l� k?t qu?
    
    loop_convert:
        lbu $t1, str($t2)       # L?y k� t? th? $t2 t? chu?i str
        beqz $t1, print_result  # N?u k� t? l� null (k?t th�c chu?i), hi?n th? k?t qu?
        subu $t1, $t1, 48      # Chuy?n ??i k� t? ASCII th�nh s? nguy�n
        mul $t4, $t4, $t3      # Nh�n k?t qu? hi?n t?i v?i h? s?
        addu $t4, $t4, $t1     # C?ng k� t? s? v�o k?t qu?
        
        addi $t2, $t2, 1       # T?ng ??a ch? chu?i l�n 1 v� ti?p t?c v�ng l?p
        j loop_convert
    
    print_result:
    # Hi?n th? k?t qu?
    li $v0, 4
    la $a0, result
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    # Tho�t ch??ng tr�nh
    li $v0, 10
    syscall
