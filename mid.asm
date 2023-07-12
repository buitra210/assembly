.data
str1: .space 10000 
str2: .space 10000
dem: .word 0        # Bien dem
prompt1: .asciiz "Nhap Chuoi 1: "
prompt2: .asciiz "Nhap Chuoi 2: "
result: .asciiz "So ky tu chung la: "
sai: .ascii "Chuoi nhap vao khong hop le!"

.text
.globl main

main:
    #Khai bao chuoi 1 tu ban phim
    li  $v0, 4			# Dat gia tri 4 vao v0, lenh in chuoi	
    la  $a0, prompt1		# Tai dia chi chuoi prompt1 vao a0, yeu cau nguoi dung nhap du lieu
    syscall			# Goi he thong in prompt1
    li  $v0, 8			# Dat gia tri 8 vao v0, lenh doc chuoi tu nguoi dung
    la  $a0, str1		# Tai dia chi chuoi str1 vao a0, chuoi nay chua du lieu dc nhap boi nguoi dung	
    li  $a1, 10000		# Do dai toi da chuoi la 10000 ky tu
    syscall			# Goi he thong doc 1 chuoi tu nguoi dung va luu chuoi vao str1
    #kiem tra xem xau A chi co character hay k
    addi $t1, $t1, 0		# t1 la i
    loopA:
    lb $t2, str1($t1)		# Gan t2 = str1 [i] trong do i la t1, tuc la gan gia tri thu i cua chuoi str1 vao t2
    beqz $t2, nhapB		# Neu str1[i], chuoi ket thuc, nhay den nhapB
    addi $t6, $zero, 10		# Gan t6=10, day la gia tri ASCII cho Enter
    bne $t6, $t2, checkA 	# Neu t2 khong la Enter thi nhay den checkA
    nop
    sb $zero, str1($t1)		# Xoa dau enter neu t2=enter	
    j nhapB
    checkA:
     #Kiem tra co thuoc A -> z ko
    li $t7, 65			# Gan t7=65, chinh la "A"	
    li $t8, 122			# Gan t8=122, chinh la "z"
    blt $t2, $t7, error		# Neu t2<A, phan tu khong thuoc tu A-> z, nhay den error
    nop
    bgt $t2, $t8, error		# Neu t2>z, phan tu khong thuoc tu A-> z, nhay den error
    nop
    # Kiem tra xem 91 < $t2 < 96 
    li $t7, 91			# Gan t7=91, chinh la ky tu sau Z trong bang ASCII
    li $t8, 96			# Gan t8=96, chinh la ky tu tr??c a trong bang ASCII
    blt $t2, $t7, countinuecheckA	#Neu t2 < 91, nam trong khoang tu A-> Z
    bgt $t2, $t8, countinuecheckA	#Neu t2 > 96, nam trong khoang tu a-> z
    j error	#Neu khong nhay den error
    countinuecheckA:
    addi $t1, $t1, 1		# Tang gia tri i len 1, tiep tuc vong lap
    j loopA
    
    nhapB:
    #Khai bao chuoi 2 tu ban phim
    li  $v0, 4			# Dat gia tri 4 vao v0, lenh in chuoi	
    la  $a0, prompt2		# Tai dia chi chuoi prompt2 vao a0, yeu cau nguoi dung nhap du lieu		
    syscall			# Goi he thong in prompt2
    li  $v0, 8			# Dat gia tri 8 vao v0, lenh doc chuoi tu nguoi dung
    la  $a0, str2		# Tai dia chi chuoi str2 vao a0, chuoi nay chua du lieu dc nhap boi nguoi dung	
    li  $a1, 10000		# Do dai toi da chuoi la 10000 ky tu
    syscall			# Goi he thong doc 1 chuoi tu nguoi dung va luu chuoi vao str2
    
    #kiem tra xem xau B chi co character hay k
    addi $t3, $t3, 0		# t3 la j
    loopB:
    lb $t4, str2($t3)		# Gan t4 = str2 [i] trong do j la t3, tuc la gan gia tri thu j cua chuoi str2 vao t4
    beqz $t4, continue		# Neu str2[j]=0, chuoi ket thuc, nhay den continue
    addi $t9, $zero, 10		# Gan t9=10, day la gia tri ASCII cho Enter
    bne $t9, $t4, checkB	# Neu t4 khong la Enter thi nhay den checkB
    sb $zero, str2($t3)		# Xoa dau enter neu t4=enter
    j continue
    checkB:
     #Kiem tra co thuoc a -> z ko
    li $t7, 65			# Gan t7=65, chinh la "A"
    li $t8, 122			# Gan t8=122, chinh la "z"
    blt $t4, $t7, error		# Neu t4<A, phan tu khong thuoc tu A_-> z, nhay den error
    nop
    bgt $t4, $t8, error		# Neu t4>z, phan tu khong thuoc tu A_-> z, nhay den error
    nop
    # Kiem tra xem 91 < $t2 < 96
    li $t7, 91			# Gan t7=91, chinh la ky tu sau Z trong bang ASCII
    li $t8, 96			# Gan t8=96, chinh la ky tu tr??c a trong bang ASCII
    blt $t4, $t7, countinuecheckB 	#Neu t4 < 91, nam trong khoang tu A-> Z
    bgt $t4, $t8, countinuecheckB	#Neu t4 > 96, nam trong khoang tu a-> z
    j error	#Neu khong nhay den error
    countinuecheckB:
    addi $t3, $t3, 1		# Tang gia tri j len 1, tiep tuc vong lap
    j loopB
    
    error:
    
    li $v0, 4		# Dat gia tri 4 vao v0, lenh in chuoi	
    la $a0, sai		# Tai dia chi chuoi sai vao a0, in ra man hinh
    syscall		# Goi he thong de in
    j main      
    
    
    continue:
    #Vong lap va so sanh
    li $t0, 0    # Gan gia tri khoi tao cho bien dem -> t0
    li $t1, 0    # Gan gia tri khoi tao cho bien i -> t1
    
    outer_loop: 
        lb $t2, str1($t1)              # Gan phan tu thu i cua chuoi 1 vao t2
        beqz $t2, end_outer_loop	# Neu t2 = 0, ket thuc chuoi, ket thuc vong lap ngoai ( kiem tra dieu kien )
        li $t3, 0                      # Gan gia tri khoi tao cho j -> t3
        
        inner_loop: 
            lb $t4, str2($t3)              # Gan phan tu thu j cua chuoi 2 vao t4
            beqz $t4, end_inner_loop       # Neu t4 = 0, ket thuc chuoi, ket thuc vong lap trong ( kiem tra dieu kien )
            beq $t2, $t4, match_found      # So sanh t2 va t4, neu t2=t4, tuc la phan tu thu i cua str1 va phan tu thu j cua str2 bang nhau, nhay den match_found
            nop
            addi $t3, $t3, 1               # Tang bien j len 1
            j inner_loop                   # Tiep tuc vong lap
            
        match_found: 
            addi $t0, $t0, 1               # Tang bien dem len 1
            addi $t5, $t5, 1	  	    # Gan t5=1
            sb $t5, str2($t3) 		    # Gan phan tu thu j cua str2=t5=1, khi nay o vong lap sau, phan tu do se khong duoc so sanh nua
            j end_inner_loop               # Nhay den ket thuc vong lap trong
            
        end_inner_loop: 
        addi $t1, $t1, 1                   # Tang i len 1
        j outer_loop                       # Quay lai vong lap ngoai
    end_outer_loop:
    # In ket qua
    li $v0, 4
    la $a0, result		# In tin nhan result
    syscall

    move $a0, $t0	#Di chuyen gia tri o t0 vao a0 de in gia tri cua t0
    li $v0, 1		# In gia tri mot thanh ghi
    syscall		# Goi he thong in gia tri trong thanh ghi a0 ( gia tri cua t0)

    # Thoat chuong trinh
    li $v0, 10		# Ma he thong thoat chuong trinh
    syscall		# Goi he thong de thoat chuong trinh