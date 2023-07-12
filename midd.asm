.data
str1: .space 10000 
str2: .space 10000
dem1: .space 26 	#Mang tuan suat cua chuoi 1 có toi da 26 phan tu la 26 chu cai trong bang chu cai
dem2: .space 26		#Mang tuan suat cua chuoi 1 có toi da 26 phan tu la 26 chu cai trong bang chu cai
prompt1: .asciiz "Chuoi 1: "
prompt2: .asciiz "Chuoi 2: "
result: .asciiz "So ky tu chung la: "

.text
.globl main

main:
#Khai bao chuoi 1 tu ban phim
li	$v0, 4
la 	$a0, prompt1
syscall
li	$v0, 8
la	$a0, str1
li	$a1, 10000
syscall

#Khai bao chuoi 2 tu ban phim
li	$v0, 4
la 	$a0, prompt2
syscall
li	$v0, 8
la	$a0, str2
li	$a1, 10000
syscall

#Tinh tan suat xuat hien cac chu cai trong chuoi 1
la $t0, str1
lb $t1, 0($t0)
beqz $t1, count_done1
count1_loop:
        sub $t1, $t1, 97   # Chuy?n ??i ký t? thành ch? s? trong m?ng t?n su?t
        sll $t2, $t1, 2    # Nhân ch? s? v?i 4 ?? tính offset
        la $t3, dem1
        add $t3, $t3, $t2  # ??a ch? m?ng t?n su?t
        lw $t4, 0($t3)     # ??c giá tr? t?n su?t
        addi $t4, $t4, 1   # T?ng giá tr? t?n su?t lên 1
        sw $t4, 0($t3)     # L?u l?i giá tr? t?n su?t
        addi $t0, $t0, 1   # Chuy?n ??n ký t? ti?p theo trong chu?i
        lb $t1, 0($t0)
        bnez $t1, count1_loop
count_done1:
la $t0, str2
    lb $t1, 0($t0)
    beqz $t1, count_done2
    count2_loop:
        sub $t1, $t1, 97   # Chuy?n ??i ký t? thành ch? s? trong m?ng t?n su?t
        sll $t2, $t1, 2    # Nhân ch? s? v?i 4 ?? tính offset
        la $t3, dem2
        add $t3, $t3, $t2  # ??a ch? m?ng t?n su?t
        lw $t4, 0($t3)     # ??c giá tr? t?n su?t
        addi $t4, $t4, 1   # T?ng giá tr? t?n su?t lên 1
        sw $t4, 0($t3)     # L?u l?i giá tr? t?n su?t
        addi $t0, $t0, 1   # Chuy?n ??n ký t? ti?p theo trong chu?i
        lb $t1, 0($t0)
        bnez $t1, count2_loop

    count_done2:
 # Tính s? ký t? chung
    li $t5, 0
    li $t6, 0
    loop_common:
        lw $t7, dem1($t6)   # ??c giá tr? t?n su?t trong m?ng dem1
        lw $t8, dem2($t6)   # ??c giá tr? t?n su?t trong m?ng dem2
        slt $t9, $t7, $t8   # So sánh giá tr? t?n su?t
        bnez $t9, else      # N?u t?n su?t trong dem1 l?n h?n ho?c b?ng dem2
        move $t10, $t7      # Gán giá tr? t?n su?t trong dem1 vào t10
        j end_if
        else:
        move $t10, $t8      # Gán giá tr? t?n su?t trong dem2 vào t10
        end_if:
        add $t5, $t5, $t10  # T?ng giá tr? commonchars lên t10
        addiu $t6, $t6, 4   # T?ng offset trong m?ng t?n su?t
        blt $t6, 104, loop_common  # L?p l?i n?u ch?a h?t m?ng t?n su?t