#Laboratory Exercise 5, Assignment 1
.data
test: .asciiz "hello world"
.text
	li $v0, 4
	la $a0, test
	syscall 

#.data ?? ??nh ngh?a ph?n d? li?u c?a ch??ng tr�nh
#test: .asciiz "Hello World": ??nh ngh?a m?t chu?i k� t? ???c l?u tr? trong b? nh?, v?i t�n bi?n l� "test"
#v� gi� tr? l� "Hello World". Trong ?�, ".asciiz" l� m?t t? kh�a ?? ??nh ngh?a chu?i k� t?, v� "z" cu?i c�ng
#??m b?o r?ng chu?i k?t th�c b?ng k� t? null.
#.text: ??nh ngh?a ph?n m� c?a ch??ng tr�nh
#li $v0, 4: l?nh n�y g�n gi� tr? 4 cho thanh ghi $v0, x�c ??nh lo?i h? th?ng g?i, ho?c "syscall", s? ???c g?i. .
#Gi� tr? ???c g�n cho thanh ghi $v0 (gi� tr? 4) x�c ??nh r?ng ch??ng tr�nh s? g?i h? th?ng g?i in chu?i
#la $a0, test: l?nh n�y l?y ??a ch? c?a bi?n "test" (chu?i "Hello World") v� l?u n� v�o thanh ghi $a0. Thanh
#ghi $a0 l� thanh ghi ??c bi?t trong MIPS, ???c s? d?ng ?? truy?n ??i s? cho c�c h? th?ng g?i.
#syscall: l?nh n�y g?i h? th?ng g?i ?? hi?n th? chu?i "Hello World" tr�n m�n h�nh console. N?i dung chu?i
#c?n ???c in ???c truy?n v�o h? th?ng g?i th�ng qua thanh ghi $a0.

#Laboratory Exercise 5, Assignment 2
.data
	theSum: .asciiz "The Sum of "
	andd: 	.asciiz " and "
	is: 	.asciiz " is "
.text
	addi	$s0, $0, 2
	addi	$s1, $0, 5
	add	$t0, $s0, $s1 
	
	li 	$v0, 4 
	la 	$a0, theSum
	syscall 
	
	li	$v0, 1
	move 	$a0, $s0
	syscall 
	
	li 	$v0, 4 
	la 	$a0, andd
	syscall 
	
	li	$v0, 1
	move 	$a0, $s1
	syscall 
	
	li 	$v0, 4 
	la 	$a0, is
	syscall 
	
	li	$v0, 1
	move 	$a0, $t0
	syscall 
	
	li	$v0, 10
	syscall 

# G�n gi� tr? s0, s1 b?ng l?nh addi
# T�nh t?ng s1, s2
# Khai b�o c�c chu?i ch?a th�ng ?i?p c?n in ra m�n h�nh v� c�c bi?n ?? l?u gi� tr? ??u v�o v� k?t qu? t�nh to�n.
# L?n l??t in c�c chu?i th�ng thi?p, s0, s1 v� t?ng s0, s1 ra m�n h�nh b?ng l?nh syscall
# K?t th�c ch??ng tr�nh b?ng l?nh syscall.


#Laboratory Exercise 5, Assignment 3
.data			
x: 	.space 1000 			#khai bao chuoi rong
y: 	.asciiz "Hello" 		#Khai bao chuoi y

.text
	la $a0, x
	la $a1, y
	li $v0, 4
	
strcpy: 
	add $s0, $zero, $zero		#s0=i=0
L1:
	add $t1, $s0, $a1		#t1 = s0+a1= i+y[0]
# Address of y[i]
	lb  $t2,0($t1)
	add $t3, $s0, $a0		#t3= s0+a0= i+x[0]
	
# Address of x[i]
	sb $t2,0($t3)			#x[i]=t2=y[i]
 	beq $t2,$zero,end		#y[i]=0, exit
 	nop
 	addi $s0,$s0,1			#s0=S0+1 ->i=i+1
 	j L1				#vong lap tiep theo
 	nop
 end:
 	syscall 
 	
 #D�ng ??u ti�n ??t thanh ghi $a0 tr? ??n v? tr� ??u ti�n c?a x�u ?�ch x
 #D�ng ??u ti�n ??t thanh ghi $a1 tr? ??n v? tr� ??u ti�n c?a x�u ?�ch y
 #G�n i=s0, t1 l� l?u v? tr� c?a y[i], t3 l?u v? tr? c?a x[i], t2 l?u k?t qu? c?a t1
 #Gi� tr? t??ng ?ng c?a y[i] b�n chu?i x s? nh?n gi� tr? gi?ng y[i]
 #Ti?p t?c t?ng gi� tr? c?a i m?i v�ng l?p l�n 1 v� b?t ??u v�ng l?p
 
 
 #Laboratory Exercise 5, Assignment 4
 .data
 string: 	.space 50
 Message1: 	.asciiz "Nhap xau: "
 Message2: 	.asciiz "Do dai la: "
 .text
 main:
 get_string:
 	li $v0, 4
 	la $a0, Message1
 	syscall 
 	
 	li $v0, 8 #read string
 	la $a0, string
 	li $a1, 50
 	syscall 
 	jal get_length
get_length:
	la $a0, string	#a0=address of string[0]
	xor $v0,$zero, $zero #v0=length=0
	xor $t0,$zero,$zero #t0=i=0
check_char: 
	add $t1, $a0,$t0 #t1=a0+t0= address of string[0]+i
	lb $t2, 0($t1) #t2= string[i]
	beq $t2, $zero, endd
	addi $s0, $s0, 1 
	addi $t0, $t0, 1
	j check_char
endd:
	addi $s0, $s0, -1
	la $a1, ($s0)
	li $v0, 56
	la $a0, Message2
	syscall
#Laboratory Exercise 5, Assignment 5
.data 
string : .space 20  
rstring : .space 20  
message1 : .asciiz " nhap xau chuoi "
message2 : .asciiz "chuoi dao nguoc la" 
#khai bao chuoi va thanh ghi 
.text 
get_string:   # TODO
li $v0 , 4
la $a0 , message1
syscall 

la $v0 ,8 
la $a0 , string 
la $a1 , 20 
syscall 
#tuong tu bai 4 nhap chuoi tu ban phim 
get_length:   la   $a0, string       # a0 = Address(string[0])
              xor  $s0, $zero, $zero # s0 = length = 0 
              xor  $t0, $zero, $zero    # t0 = i = 0
              #tuong tu nhu bai 4 khoi tao 2 gia tri s0 va t0 = 0 
check_char:   add  $t1, $a0, $t0        # t1 = a0 + t0 
                                        #= Address(string[0]+i) 
              #khoi tao $t1 
              lb   $t2, 0($t1)          # t2 = string[i]
              #tai bit dau tien cua $t1  
              beq  $t2,$zero,end_of_str # Is null char?
              #neu $t2 gap null thi ket thuc chuoi 
              addi $s0, $s0 ,1       
              #tang dan $s0 = $s0+1 (length + length +1 )
              addi $t0, $t0, 1          # t0=t0+1->i = i + 1
              j    check_char
end_of_str :
print_reverse:

la $a1 , rstring 
add $s0 , $s0 , -1 
addi $s1 , $s1 , 0 #khoi tao $s1 
L1 :

             add  $t3, $s0 , $a0 
             lb $t4 , 0($t3)
             add $t5 , $s1 , $a1 
             sb $t4 , 0($t5)
             beq $t4 , $zero , end_of_printfreverse 
             nop 
             addi $s0 , $s0 , -1 
             addi $s1, $s1 , 1
             j L1
             nop  
end_of_printfreverse:
li $v0 , 59 
la $a0 , message2
syscall 

#Ban ??u, ch??ng tr�nh s? y�u c?u ng??i d�ng nh?p v�o m?t chu?i b?ng c�ch s? d?ng h�m syscall v?i m�
#s? 8. Chu?i n�y s? ???c l?u tr? trong v�ng nh? c� t�n l� string v� c� ?? d�i t?i ?a l� 50 k� t?. Sau khi
#nh?p chu?i xong, ch??ng tr�nh ti?p t?c th?c hi?n h�m get_length ?? t�nh ?? d�i c?a chu?i v?a nh?p.
#H�m get_length b?t ??u b?ng vi?c kh?i t?o gi� tr? ?? d�i chu?i l� 0, r?i ki?m tra t?ng k� t? trong chu?i
#b?ng c�ch s? d?ng v�ng l?p while. N?u k� t? hi?n t?i l� null character (k?t th�c chu?i), v�ng l?p s? d?ng
#l?i.
#Ng??c l?i, ch??ng tr�nh s? t?ng bi?n ??m ?? d�i c?a chu?i l�n 1 v� ti?p t?c ki?m tra k� t? ti?p theo.
#Sau khi t�nh ???c ?? d�i c?a chu?i, ch??ng tr�nh s? b?t ??u in chu?i ?� theo th? t? ng??c l?i. Ban ??u,
#ch??ng tr�nh t?o m?t v�ng nh? m?i c� t�n l� rstring ?? l?u tr? chu?i ??o ng??c. Sau ?�, ch??ng tr�nh
#s? duy?t chu?i ban ??u t? cu?i v? ??u, m?i l?n ??c m?t k� t?, k� t? ?� s? ???c ghi v�o v�ng nh? m?i
#???c t?o ? b??c tr??c. Cu?i c�ng, ch??ng tr�nh s? in chu?i ??o ng??c ra m�n h�nh b?ng c�ch s? d?ng
#h�m syscall v?i m� s? 59.	