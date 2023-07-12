.data
str: .space 10000 
prompt: .asciiz "Nh?p chu?i ch?a ch? s?: "
result: .asciiz "Chu?i ch?a ch? s?: "
error: .asciiz "Chu?i không ch?a ch? s?"

.text
.globl main

main:
    # Hi?n th? thông báo yêu c?u nh?p chu?i t? bàn phím
    li  $v0, 4
    la  $a0, prompt
    syscall
    
    # Nh?n chu?i t? ng??i dùng
    li  $v0, 8
    la  $a0, str
    li  $a1, 10000
    syscall
    
    # Ki?m tra xem chu?i ch? ch?a các ch? s? hay không
    addi $t0, $zero, 0   # Gán $t0 = 0, $t0 l?u tr? s? l??ng ký t? trong chu?i
    
    loop:
        lbu $t1, str($t0)     # Gán $t1 = str[$t0], l?y ký t? th? $t0 t? chu?i str
        beqz $t1, convert     # N?u ký t? là null (k?t thúc chu?i), chuy?n ??n b??c chuy?n ??i
        blt $t1, 48, error    # N?u ký t? là nh? h?n 48 ('0' trong b?ng ASCII), chu?i không ch?a ch? s?
        bgt $t1, 57, error    # N?u ký t? là l?n h?n 57 ('9' trong b?ng ASCII), chu?i không ch?a ch? s?
        addi $t0, $t0, 1      # T?ng s? l??ng ký t? lên 1 và ti?p t?c vòng l?p
        j loop
    
    convert:
    # Chuy?n ??i chu?i thành s? nguyên
    addi $t2, $zero, 0   # $t2 là ??a ch? chu?i
    addi $t3, $zero, 10  # $t3 là h? s?
    addi $t4, $zero, 0   # $t4 là k?t qu?
    
    loop_convert:
        lbu $t1, str($t2)       # L?y ký t? th? $t2 t? chu?i str
        beqz $t1, print_result  # N?u ký t? là null (k?t thúc chu?i), hi?n th? k?t qu?
        subu $t1, $t1, 48      # Chuy?n ??i ký t? ASCII thành s? nguyên
        mul $t4, $t4, $t3      # Nhân k?t qu? hi?n t?i v?i h? s?
        addu $t4, $t4, $t1     # C?ng ký t? s? vào k?t qu?
        
        addi $t2, $t2, 1       # T?ng ??a ch? chu?i lên 1 và ti?p t?c vòng l?p
        j loop_convert
    
    print_result:
    # Hi?n th? k?t qu?
    li $v0, 4
    la $a0, result
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    # Thoát ch??ng trình
    li $v0, 10
    syscall
