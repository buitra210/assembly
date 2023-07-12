#Laboratory Exercise 4, Assignment 1.text
.text 
addi $s1, $0, 20213333333
addi $s2, $0, 21100333333323
start:
li   $t0, 0		# Thi?t l?p trong th�i m?c ??nh (khi kh�ng b? tr�n)	
addu $s3,$s1,$s2	# s3 = s1 + s2
xor  $t1,$s1,$s2	# So s�nh s1 v� s2 c�ng d?u hay kh�c d?u
bltz $t1,EXIT		# N?u t1<0 th� chuy?n ??n EXIT
slt  $t2,$s3,$s1	# N?u s3 < s1 th� t2 b?ng 1, n?u kh�ng t2 b?ng 0
bltz $s1,NEGATIVE	# So s�ng s1 v?i 0, n?u s1 < 0 th� chuy?n ??n NEGATIVE
beq  $t2,$zero,EXIT	# N?u t2=0 th� chuy?n ??n EXIT
# Khi t2=0 th� s3>s1, v� ?�y l� 2 s? d??ng n�n khi s3>s1 th� k?t qu? l� kh�ng b? tr�n
j    OVERFLOW		# Nh?y t?i OVERFLOW
NEGATIVE:
bne  $t2,$zero,EXIT	# Khi n�y s1 v� s2 c�ng l� s? �m
			# N?u s3<s1 th� k?t qu? kh�ng b? tr�n
OVERFLOW:
li   $t0,1
EXIT:

# Ch?y 2 s? 2021333 v� 21100333, ?�y l� 2 s? m� t?ng c?a ch�ng < 2^31
# Khi ch?y ch??ng tr�nh ta nh?n ???c k?t qu? l� t0=0
# li   $t0, 0 l� thi?t l?p tr?ng th�i ban ??u
# s3 l� t?ng 2 s? tr�n
# L?nh xor ?� so s�nh, x�t xem s1 v� s2 c�ng d?u hay kh�c d?u
# N?u t1<0, 2 s? kh�c d?u, nh?y t?i EXIT, n?u kh�ng ti?p t?c ch?y ch??ng tr�nh
# Khi s1 v� s2 d??ng, s3 > s1 ( t2 = 0 ) th� k?t qu? kh�ng b? tr�n, n?u kh�ng th� b? tr�n
# Khi s1 v� s2 �m, s3 < s1 (t2 = 1 ) th� k?t qu? kh�ng b? tr�n, n?u kh�ng th� b? tr�n


##Laboratory Exercise 4, Assignment 2.text

.text
addi 	$s0, $0, 0x20215150


srl 	$s1, $s0, 24 #d?ch sang bit sang ph?i, c�c bit l?u t?i s1
andi 	$s3, $s0, 0xffffff00 #x�a c�c bit kh�c f th�nh 0, c�c bit c�ng f th� gi? nguy�n
xori 	$s4, $s3, 0x00000011 #chuy?n LSB th�nh 11
andi  	$s0, $s0, 0x00000000 #x�a s0 v? b?ng 0

# srl $s1, $s0, 24 l� l?nh d?ch bit sang ph?i 24 bit, l� 6 s?, khi ?� s0 th�nh 00000020, MSB l� 20
# Ta th?c hi?n so s�nh t?ng bit v?i nhau , n?u l� f th� ta gi? nguy�n c�c bit s0, n?u nh? b?ng 0 th� ta ??i c�c bit ?� th�nh 0 v� l?u v�o s3	
# L?nh ti?p theo ?? chuy?n LSB (50) th�nh s? 1
# D�ng l?nh andi, n?u ?ang ? s? 0 th� gi? nguy�n, n?u l� 1 th� chuy?n v? 0

#Laboratory Exercise 4, Assignment 3.text
#a
.text
addi 	$s1, $0, -210
bltz 	$s1, NEXT 	#so s�nh s1 v?i 0, n?u s1<0 th� chuy?n ??n NEXT
j 	END
NEXT:
sub 	$s1, $0, $s1
j	END
END: 
add 	$s0, $s1, $0

# Khai gi� tr? b?t k� cho s1, so s�nh gi� tr? ?� v?i 0, ? ?�y gi� tr? l� -210 <0
# N?u s1 > 0 th� th?c hi?n g�n lu�n
# N?u s1 < 0 th� ta d�ng ph�p to�n l?y 0 tr? ?i s1, ? ?�y 0-(-210)=210, l?u gi� tr? ?� v�o s1
# Sau ?� chuy?n ??n END v� th?c hi?n g�n v�o s0

#b
addi 	$s1, $0, 30
addu	$s0, $0, $s1

#Ta khai cho s1 b?ng 30, sau ?� c?ng s1 v?i 0 v� g�n v�o s0

#c
.text 
addi 	$s1, $0, 9
nor 	$s1, $s1, $0
addu 	$s0, $s1, $0


# ??u ti�n ta khai b�o gi� tr? s1, ? ?�y l� 9
# Sau ?� ch�ng ta d�ng l?nh nor 0 v?i s1 ?? chuy?n 0 th�nh 1 v� t? 1 th�nh 0 ( v� khi nor th� 1+0=0 v� 0+0=1)
# Cu?i c�ng ta g�n gi� tr? v?a nh?n ???c v�o s0 b?ng c�ch c?ng s1 v?i 0 v� g�n v�o s0

#d
addi 	$s1, $0, 20
addi	$s2, $0, 30
label:
slt 	$t1, $s2, $s1 #N?u s1<s2 th� t1=0
beq 	$t1, $zero, True #N?u t1=0 th� nh?y ??n True
j 	End
True:
j	label
End: 

# ??u ti�n ta khai b�o gi� tr? cho s1 v� s2 l� 20 v� 30
# N?u s2 < s1 th� k?t th�c ch??ng tr�nh
# N?u s1 <= s2 th� l� nh?y ??n Tue, khi ??y v�ng l?p s? ti?p t?c m�i


#Laboratory Exercise 4, Assignment 4.text
.text 
addi $s1, $0, 202133
addi $s2, $0, 211003
start:
li   $t0, 0		# Thi?t l?p trong th�i m?c ??nh (khi kh�ng b? tr�n)	
addu $s3,$s1,$s2	# s3 = s1 + s2
xor  $t1,$s1,$s2	# So s�nh s1 v� s2 c�ng d?u hay kh�c d?u
bltz $t1,EXIT		# N?u t1<0 th� chuy?n ??n EXIT
xor  $t2, $s1, $s3	# So s�nh s1 v� s3 c�ng d?u hay kh�c d?u
bltz $t2, OVERFLOW	# N?u kh�c d?u chuy?n ??n OVERFLOW
j    EXIT
OVERFLOW:
li	$t0, 1		#N?u tr�n th� k?t qu? t0 hi?n 1
EXIT:

# G�n gi� tr? v�o s1 v� s2
# Thi?t l?p tr?ng th�i m?c ??nh n?u kh�ng tr�n th� t0=0
# Thi?t l?p s3=s1+s2
# So s�nh s1 v� s2 c�ng d?u hay kh�c d?u, n?u kh�c d?u th� k?t th�c ch??ng tr�nh, c�ng d?u th� ch?y ti?p
# Sau ?� so s�nh s3 v� s1, n?u c�ng d?u th� kh�ng b? tr�n, k?t qu? t0=0, n?u kh�ng c�ng d?u th� b? tr�n, k?t qu? t0=1

#Laboratory Exercise 4, Assignment 5.
.text

li	$s1, 7 #Gi� tr? c?n t�nh l?y th?a
li	$s2, 1 #Gi� tr? b??c nh?y
add	$s3, $s1, $0 #G�n s3 v�o s1
loop:
add	$s1, $s1, $s3 #G�n s3 v�o s1, th?c hi?n v�ng l?p
addi	$s2, $s2, 1   #M?i v�ng l?p th?c hi?n t?ng bi?n ??m
bne	$s2, $s3, loop
j 	next
next: 

#Ta kh?i t?o gi� tr? c?n t�nh l?u v�o s1 
#Ta kh?i t?o step ?? b??c nh?y 
#Gi� thu?t to�n s? l� : 2^2 = 2+2 | 5^2 = 5+5+5+5+5
#V?y ta c?n 1 b??c nh?y ??m t? 1 ??n n 
#V� m?i v�ng l?p ta th?c hi?n c?ng s? ?� v?i s? nguy�n th?y c?a n� t?c l� n 
#V?y n^2 = n+�.+n (n s? n )
#Ta c?n 1 c�u l?nh ?? ki?m so�t v�ng l?p, n?u nh? i != n th� ta th?c hi?n quay l?i c�n n?u = 1 th� ta th?c hi?n tho�t ch??ng tr�nh


# What is the difference between SLLV and SLL instructions?

#- L?nh sll $s1, $s2, i: D?ch tr�i $s2 s? bit ???c quy ??nh ? ph?n immediate,sau ?� l?u k?t qu? v�o $s1.
#- L?nh sllv $s1, $s2, $s3: D?ch tr�i $s2 s? bit ???c quy ??nh b?i 5 bit tr?t t? th?p (low-order) c?a $s3, mang gi� tr? t? 0-31 v� l?u k?t qu? v�o $s1.

# What is the difference between SRLV and SRL instructions?
#- L?nh srl $s1, $s2, i: D?ch ph?i $s2 s? bit ???c quy ??nh ? ph?n intermediate, sau ?� l?u k?t qu? v�o $s1.
#- L?nh srlv $s1, $s2, $s3: D?ch ph?i $s2 s? bit ???c quy ??nh b?i 5 bit tr?t t? th?p (low-order) c?a $s3, mang gi� tr? t? 0-31 v� l?u k?t qu? v�o $s1.

