#Laboratory Exercise 4, Assignment 1.text
.text 
addi $s1, $0, 20213333333
addi $s2, $0, 21100333333323
start:
li   $t0, 0		# Thi?t l?p trong thái m?c ??nh (khi không b? tràn)	
addu $s3,$s1,$s2	# s3 = s1 + s2
xor  $t1,$s1,$s2	# So sánh s1 và s2 cùng d?u hay khác d?u
bltz $t1,EXIT		# N?u t1<0 thì chuy?n ??n EXIT
slt  $t2,$s3,$s1	# N?u s3 < s1 thì t2 b?ng 1, n?u không t2 b?ng 0
bltz $s1,NEGATIVE	# So sáng s1 v?i 0, n?u s1 < 0 thì chuy?n ??n NEGATIVE
beq  $t2,$zero,EXIT	# N?u t2=0 thì chuy?n ??n EXIT
# Khi t2=0 thì s3>s1, vì ?ây là 2 s? d??ng nên khi s3>s1 thì k?t qu? là không b? tràn
j    OVERFLOW		# Nh?y t?i OVERFLOW
NEGATIVE:
bne  $t2,$zero,EXIT	# Khi này s1 và s2 cùng là s? âm
			# N?u s3<s1 thì k?t qu? không b? tràn
OVERFLOW:
li   $t0,1
EXIT:

# Ch?y 2 s? 2021333 và 21100333, ?ây là 2 s? mà t?ng c?a chúng < 2^31
# Khi ch?y ch??ng trình ta nh?n ???c k?t qu? là t0=0
# li   $t0, 0 là thi?t l?p tr?ng thái ban ??u
# s3 là t?ng 2 s? trên
# L?nh xor ?ê so sánh, xét xem s1 và s2 cùng d?u hay khác d?u
# N?u t1<0, 2 s? khác d?u, nh?y t?i EXIT, n?u không ti?p t?c ch?y ch??ng trình
# Khi s1 và s2 d??ng, s3 > s1 ( t2 = 0 ) thì k?t qu? không b? tràn, n?u không thì b? tràn
# Khi s1 và s2 âm, s3 < s1 (t2 = 1 ) thì k?t qu? không b? tràn, n?u không thì b? tràn


##Laboratory Exercise 4, Assignment 2.text

.text
addi 	$s0, $0, 0x20215150


srl 	$s1, $s0, 24 #d?ch sang bit sang ph?i, các bit l?u t?i s1
andi 	$s3, $s0, 0xffffff00 #xóa các bit khác f thành 0, các bit cùng f thì gi? nguyên
xori 	$s4, $s3, 0x00000011 #chuy?n LSB thành 11
andi  	$s0, $s0, 0x00000000 #xóa s0 v? b?ng 0

# srl $s1, $s0, 24 là l?nh d?ch bit sang ph?i 24 bit, là 6 s?, khi ?ó s0 thành 00000020, MSB là 20
# Ta th?c hi?n so sánh t?ng bit v?i nhau , n?u là f thì ta gi? nguyên các bit s0, n?u nh? b?ng 0 thì ta ??i các bit ?ó thành 0 vè l?u vào s3	
# L?nh ti?p theo ?? chuy?n LSB (50) thành s? 1
# Dùng l?nh andi, n?u ?ang ? s? 0 thì gi? nguyên, n?u là 1 thì chuy?n v? 0

#Laboratory Exercise 4, Assignment 3.text
#a
.text
addi 	$s1, $0, -210
bltz 	$s1, NEXT 	#so sánh s1 v?i 0, n?u s1<0 thì chuy?n ??n NEXT
j 	END
NEXT:
sub 	$s1, $0, $s1
j	END
END: 
add 	$s0, $s1, $0

# Khai giá tr? b?t kì cho s1, so sánh giá tr? ?ó v?i 0, ? ?ây giá tr? là -210 <0
# N?u s1 > 0 thì th?c hi?n gán luôn
# N?u s1 < 0 thì ta dùng phép toán l?y 0 tr? ?i s1, ? ?ây 0-(-210)=210, l?u giá tr? ?ó vào s1
# Sau ?ó chuy?n ??n END và th?c hi?n gán vào s0

#b
addi 	$s1, $0, 30
addu	$s0, $0, $s1

#Ta khai cho s1 b?ng 30, sau ?ó c?ng s1 v?i 0 và gán vào s0

#c
.text 
addi 	$s1, $0, 9
nor 	$s1, $s1, $0
addu 	$s0, $s1, $0


# ??u tiên ta khai báo giá tr? s1, ? ?ây là 9
# Sau ?ó chúng ta dùng l?nh nor 0 v?i s1 ?? chuy?n 0 thành 1 và t? 1 thành 0 ( vì khi nor thì 1+0=0 và 0+0=1)
# Cu?i cùng ta gán giá tr? v?a nh?n ???c vào s0 b?ng cách c?ng s1 v?i 0 và gán vào s0

#d
addi 	$s1, $0, 20
addi	$s2, $0, 30
label:
slt 	$t1, $s2, $s1 #N?u s1<s2 thì t1=0
beq 	$t1, $zero, True #N?u t1=0 thì nh?y ??n True
j 	End
True:
j	label
End: 

# ??u tiên ta khai báo giá tr? cho s1 và s2 là 20 và 30
# N?u s2 < s1 thì k?t thúc ch??ng trình
# N?u s1 <= s2 thì là nh?y ??n Tue, khi ??y vòng l?p s? ti?p t?c mãi


#Laboratory Exercise 4, Assignment 4.text
.text 
addi $s1, $0, 202133
addi $s2, $0, 211003
start:
li   $t0, 0		# Thi?t l?p trong thái m?c ??nh (khi không b? tràn)	
addu $s3,$s1,$s2	# s3 = s1 + s2
xor  $t1,$s1,$s2	# So sánh s1 và s2 cùng d?u hay khác d?u
bltz $t1,EXIT		# N?u t1<0 thì chuy?n ??n EXIT
xor  $t2, $s1, $s3	# So sánh s1 và s3 cùng d?u hay khác d?u
bltz $t2, OVERFLOW	# N?u khác d?u chuy?n ??n OVERFLOW
j    EXIT
OVERFLOW:
li	$t0, 1		#N?u tràn thì k?t qu? t0 hi?n 1
EXIT:

# Gán giá tr? vào s1 và s2
# Thi?t l?p tr?ng thái m?c ??nh n?u không tràn thì t0=0
# Thi?t l?p s3=s1+s2
# So sánh s1 và s2 cùng d?u hay khác d?u, n?u khác d?u thì k?t thúc ch??ng trình, cùng d?u thì ch?y ti?p
# Sau ?ó so sánh s3 và s1, n?u cùng d?u thì không b? tràn, k?t qu? t0=0, n?u không cùng d?u thì b? tràn, k?t qu? t0=1

#Laboratory Exercise 4, Assignment 5.
.text

li	$s1, 7 #Giá tr? c?n tính l?y th?a
li	$s2, 1 #Giá tr? b??c nh?y
add	$s3, $s1, $0 #Gán s3 vào s1
loop:
add	$s1, $s1, $s3 #Gán s3 vào s1, th?c hi?n vòng l?p
addi	$s2, $s2, 1   #M?i vòng l?p th?c hi?n t?ng bi?n ??m
bne	$s2, $s3, loop
j 	next
next: 

#Ta kh?i t?o giá tr? c?n tính l?u vào s1 
#Ta kh?i t?o step ?? b??c nh?y 
#Giá thu?t toán s? là : 2^2 = 2+2 | 5^2 = 5+5+5+5+5
#V?y ta c?n 1 b??c nh?y ??m t? 1 ??n n 
#Và m?i vòng l?p ta th?c hi?n c?ng s? ?ó v?i s? nguyên th?y c?a nó t?c là n 
#V?y n^2 = n+….+n (n s? n )
#Ta c?n 1 câu l?nh ?? ki?m soát vòng l?p, n?u nh? i != n thì ta th?c hi?n quay l?i còn n?u = 1 thì ta th?c hi?n thoát ch??ng trình


# What is the difference between SLLV and SLL instructions?

#- L?nh sll $s1, $s2, i: D?ch trái $s2 s? bit ???c quy ??nh ? ph?n immediate,sau ?ó l?u k?t qu? vào $s1.
#- L?nh sllv $s1, $s2, $s3: D?ch trái $s2 s? bit ???c quy ??nh b?i 5 bit tr?t t? th?p (low-order) c?a $s3, mang giá tr? t? 0-31 và l?u k?t qu? vào $s1.

# What is the difference between SRLV and SRL instructions?
#- L?nh srl $s1, $s2, i: D?ch ph?i $s2 s? bit ???c quy ??nh ? ph?n intermediate, sau ?ó l?u k?t qu? vào $s1.
#- L?nh srlv $s1, $s2, $s3: D?ch ph?i $s2 s? bit ???c quy ??nh b?i 5 bit tr?t t? th?p (low-order) c?a $s3, mang giá tr? t? 0-31 và l?u k?t qu? vào $s1.

