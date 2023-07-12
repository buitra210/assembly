.data
str: .space 10000 
prompt: .asciiz "Chuoi chu so la: "
result: .asciiz "So la: "
sai: .ascii "Bi sai"

.text
.globl main

main:
    #Khai bao chuoi tu ban phim
    li  $v0, 4 		# Dat gia tri 4 vao v0, lenh in chuoi
    la  $a0, prompt	# Tai dia chi chuoi prompt vao a0, yeu cau nguoi dung nhap du lieu
    syscall		# Goi he thong in prompt
    li  $v0, 8		# Dat gia tri 8 vao v0, lenh doc chuoi tu nguoi dung
    la  $a0, str	# Tai dia chi chuoi str vao a0, chuoi nay chua du lieu dc nhap boi nguoi dung
    li  $a1, 10000	#  Do dai toi da chuoi la 10000 ky tu
    syscall		# Goi he thong doc 1 chuoi tu nguoi dung va luu chuoi vao str
    
    #kiem tra xem chuoi chi co chu so hay ko
    addi $t1, $t1, 0         # t1=i
    CheckCharacte:
    lb $t2, str($t1)	# Gan t2 = str [i] trong do i la t1, tuc la gan gia tri thu i cua chuoi str vao t2

    beqz $t2, abc		# Neu chuoi ket thuc, nhay den abc
    addi $t6, $zero, 10		# Gan t6=10, day la gia tri ASCII
    bne $t6, $t2, check 	# Kiem tra $t2 co phai enter khong, neu khong thi nhay den check
    nop
    sb $zero, str($t1)		# Xoa gia tri enter neu t2 là enter
    j abc
    
    check: 
    li $t7, 48		# Gan t7=48, chinh la "0"
    li $t8, 57		# Gan t8=122, chinh la "9"	
    blt $t2, $t7, error		# Neu t2<0, sai, nhay den error
    nop
    bgt $t2, $t8, error		# Neu t2>9, sai, nhay den error	
    nop
    addi $t1, $t1, 1		# Tang gia tri i len 1, tiep tuc vong lap
    j CheckCharacte
    error:
    li $v0, 4		# Dat gia tri 4 vao v0, lenh in chuoi	
    la $a0, sai		# Tai dia chi chuoi sai vao a0, in ra man hinh
    syscall		# Goi he thong de in
    j main        
    #Vong lap va so sanh
   abc: 
   li $t1, 0    
   li $t0, 0    # $t0 la string address
   li $t2, 10
   li $t3, 0	# $t3 la ket qua 
    
    loop: 
        lb $t1, str($t0)       # Gan t1= str[i]     
        beq $t1, 0, end		# Neu t1=0, ket thuc chuoi, nhay den end
        subu $t1, $t1, 48      # Chuyen gia tri Ascii ve integer
    	mul $t3, $t3, $t2      # Nhan gia tri t3 voi 10, tang gia tri t3 len mot bac khi them ky tu so moi
    	addu $t3, $t3, $t1    # Them gia tri t1 vao t3, tinh tong cac ky tu

    	addi $t0, $t0, 1      # Tang i len 1, tiep tuc vong lap
    	j loop
   
    end:
     # In ket qua
    li $v0, 4
    la $a0, result		# In tin nhan result
    syscall

    move $a0, $t3	# Di chuyen gia tri o t3 vao a0 de in gia tri cua t3
    li $v0, 1 	# In gia tri mot thanh ghi
    syscall  # Goi he thong in gia tri trong thanh ghi a0 ( gia tri cua t3)

    # Thoát ch??ng trình
     li $v0, 10		# Ma he thong thoat chuong trinh
    syscall		# Goi he thong de thoat chuong trinh
