#Laboratory Exercise 7 Assignment 1
.text
main:
li $a0, 5
jal 	abs
nop
add     $s0, $zero, $v0
li      $v0, 10
syscall
endmain:
abs:
sub 	$v0, $zero, $a0
bltz	$a0, done
nop
add 	$v0, $a0, $zero
done:
jr	$ra

# Dau tien ta gan gia tri a0 
# Sau do ta nhay toi abs
# O abs, ta luu v0=-a0 ( v0 la so doi cua a0 )
# Neu ma a0<0, tuc la v0>0, nhay toi lenh done
# Lenh jr $ra thuc hien nhay toi lenh nop dau tien, o day to gan s0=v0 va ket thuc chuong trinh
# Neu ma a0>0, tuc la v0<0, ta thuc hien gan v0=a0+0 tuc la v0=a0
# Sau do ta lai den lenh done va gan v0=s0 sau do ket thuc chuong trinh.
# O day em thay a0=5 va la a0>0, ket qua in ra la 5.

#Laboratory Exercise 7 Assignment 2
.text
main:
li	$a0, 3
li	$a1, 5
li 	$a2, 7
jal 	max
nop
endmain:
max:
add	$v0,$a0,$zero
sub	$t0, $a1, $v0
bltz	$t0, okay
nop
add	$v0,$a1,$zero
okay:
sub	$t0, $a2,$v0
bltz	$t0, done
nop
add $v0,$a2,$zero
done:
jr	$ra

#Dau tien ta gan gia tri a0, a1, a2
# Coi nhu v0 la max
# Dau tien gan v0 voi a0, v0=a0
# Gan t0=a1-v0=a1-a0
# Neu t0<0, tuc la a1<a0, thi  nhay den okay de tiep tuc so sanh a0 voi a2
# Neu t0>0, tuc la a1>a0, thi gan v0=a1, va nhay den okay de so sanh a1 voi a2
# O okay, So sanh a2 voi v0
# Neu t0<0, tuc la a2<v0, ta nhay den lenh done, nhay ve lenh nop dau tien va ket thuc chuong trinh
# Khi nay v0 la lon nhat ( co the la a0 hoac a1 2 truong hop nhu da noi o tren )
# Neu t0>0, tuc la a2>v0, gan a2=v0, sau do nhay den done, nhay ve nop va ket thuc chuong trinh.
# Khi nay v0 la lon nhat ( a2 )

#Laboratory Exercise 7 Assignment 3
.text
li	$s0, 5
li	$s1, 7
push:
addi 	$sp,$sp,-8
sw	$s0, 4($sp)
sw	$s1, 0($sp)
work:
nop
nop
nop
pop:
lw	$s0,0($sp)
lw	$s1,4($sp)
addi	$sp,$sp,8

#Lenh addi $sp $sp 8 giam gia tri cua con tro ngan xep duoc luu tru trong thanh ghi $sp di 8 byte,
#tao ra mot khoang trong moi tren dinh ngan xep de luu tru du lieu moi.
#Lenh sw $s0 4 $sp luu tru gia tri cua thanh ghi $s0 vao dinh ngan xep tai vi tri ma con tro ngan xep dang tro toi
#tru di 4 byte. Tuong tu lenh sw $s1 0 $sp luu tru gia tri cua thanh ghi $s1 tai vi tri con tro dang
#tro toi tru di 0 byte (vi tri dau tien tren dinh ngan xep).
#Ba lenh nop la cac lenh khong thuc hien bat ky thao tac nao chi dung
#de tao ra mot khoang thoi gian trong cho cho cac lenh khac hoan thanh .
#Lenh lw $s0 0 $sp lay gia tri dau tien tren dinh ngan xep va luu vao thanh ghi $s0.
#Tuong tu lenh lw $s1 4 $sp lay gia tri tiep theo tren dinh ngan xep va luu vao thanh ghi $s1.
#Cuoi cung sau khi hoan thanh cac thao tac tren con tro ngan xep duoc cap nhat lai,
#bang cach them 8 byte vao no de tra lai trang thai nhu ban dau bang lenh addi $sp $sp 8.

#Laboratory Exercise 7 Assignment 4
.data
Message: .asciiz  "Ket qua tinh giai thua la: "

.text
main: jal WARP
print: add $a1, $v0, $zero 
li 	$v0, 56
la 	$a0, Message
syscall
endmain:
WARP:
	sw $fp, -4($sp)
	addi $fp, $sp, 0
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	
	li $a0,6
	jal FACT
	nop
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	lw $fp, -4($sp)
	jr $ra
FACT:
	sw $fp, -4($sp)
	addi $fp,$sp,0
top
	addi $sp,$sp,-12
stack 
	sw $ra,4($sp)
	sw $a0,0($sp)
	
	slti $t0,$a0,2
	beq $t0, $zero, recursive
	nop
	li $v0,1
	j done
	nop
recursive:
	addi $a0, $a0, -1
	jal FACT
	nop
	lw $v1, 0($sp)
	mult $v1, $v0
	mflo $v0
done:
	lw $ra, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $fp, 0
	lw $fp, -4($sp)
	jr $ra
fact_end: 

#Chuong trinh bat dau chay tu ham main Sau do ta goi ham WARP
#bang lenh jal. Ham WARP se tinh giai thua cua so 6 va tra ve ket qua 
#Sau khi ham WARP thuc thi xong ket qua cua no duoc luu tru trong thanh ghi 
#$v0 Trong phan print ta dua gia tri nay vao thanh ghi $a1 bang lenh add Sau do ta su dung lenh li de dua gia tri 56 
#vao thanh ghi $v0 Lenh la duoc su dung de load dia chi cua chuoi Message vao thanh ghi $a0
#Cuoi cung ta su dung lenh syscall de in ra ket qua tinh toan.
#ta khai bao ham WARP Dau tien ta luu gia tri cua thanh ghi $fp vao o nho co dia chi la $sp 4 
#Sau do ta luu gia tri cua thanh ghi $sp vao thanh ghi $fp de luu gia tri cua stack frame hien tai 
#Ta giam gia tri cua thanh ghi $sp di 8 don vi de danh cho cho cac gia tri cua stack frame moi 
#Tiep theo ta luu gia tri cua thanh ghi $ra vao o nho co dia chi la $sp 0 de luu dia chi tro lai cua chuong trinh sau khi ket thuc ham

#Laboratory Exercise 7 Assignment 5
.text
li $s0,2
li $s1,-1
li $s2,3
li $s3,4
li $s4,-4
li $s5,3
li $s6,2
li $s7,-2

find_largest_smallest:
    addi $sp, $sp, -36     # allocate 8 words on the stack for arguments and results
    sw $ra, 32($sp)        # save return address on the stack
    sw $s0, 28($sp)        # save $s0 on the stack
    sw $s1, 24($sp)        # save $s1 on the stack
    sw $s2, 20($sp)         # save $s2 on the stack
    sw $s3, 16($sp)         # save $s3 on the stack
    sw $s4, 12($sp)         # save $s4 on the stack
    sw $s5, 8($sp)         # save $s5 on the stack
    sw $s6, 4($sp)         # save $s4 on the stack
    sw $s7, 0($sp)         # save $s4 on the stack
    
    move $s0, $zero        # initialize $s0 to 0 (largest value)
    move $s1, $zero        # initialize $s1 to 0 (largest position)
    move $s2, $zero        # initialize $s2 to 0 (smallest value)
    move $s3, $zero        # initialize $s3 to 0 (smallest position)

    li $t0, 8              # set $t0 to the number of elements in the list
loop:
    beq $t0, $zero, done   # exit loop when all elements have been processed
    nop
    addi $t0, $t0, -1      # decrement loop counter

    lw $t1, 0($sp)         # load next element from the stack
    addi $sp, $sp, 4       # pop the element from the stack

    # compare with largest value
    bge $t1, $s0, larger   # branch if current element is greater than or equal to largest value
    nop
    bge $t1,$s2, next 
    nop
    move $s2, $t1          # otherwise, update smallest value
    move $s3, $t0          # and store its position
    j next

larger:
    move $s0, $t1          # update largest value
    move $s1, $t0          # and store its position
    j loop
next:
    j loop

done:
  
    lw $ra, 32($sp)        # restore return address from the stack
    addi $sp, $sp, 36      # deallocate the stack space

    jr $ra                 # return from the procedure

# $s0 (largest value)
#  $s1 (largest position)
# $s2 (smallest value)
# $s3 (smallest position)


