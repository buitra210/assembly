#Laboratory Exercise 5, Assignment 1
.data
test: .asciiz "hello world"
.text
	li $v0, 4
	la $a0, test
	syscall 

#.data ?? ??nh ngh?a ph?n d? li?u c?a ch??ng trình
#test: .asciiz "Hello World": ??nh ngh?a m?t chu?i ký t? ???c l?u tr? trong b? nh?, v?i tên bi?n là "test"
#và giá tr? là "Hello World". Trong ?ó, ".asciiz" là m?t t? khóa ?? ??nh ngh?a chu?i ký t?, và "z" cu?i cùng
#??m b?o r?ng chu?i k?t thúc b?ng ký t? null.
#.text: ??nh ngh?a ph?n mã c?a ch??ng trình
#li $v0, 4: l?nh này gán giá tr? 4 cho thanh ghi $v0, xác ??nh lo?i h? th?ng g?i, ho?c "syscall", s? ???c g?i. .
#Giá tr? ???c gán cho thanh ghi $v0 (giá tr? 4) xác ??nh r?ng ch??ng trình s? g?i h? th?ng g?i in chu?i
#la $a0, test: l?nh này l?y ??a ch? c?a bi?n "test" (chu?i "Hello World") và l?u nó vào thanh ghi $a0. Thanh
#ghi $a0 là thanh ghi ??c bi?t trong MIPS, ???c s? d?ng ?? truy?n ??i s? cho các h? th?ng g?i.
#syscall: l?nh này g?i h? th?ng g?i ?? hi?n th? chu?i "Hello World" trên màn hình console. N?i dung chu?i
#c?n ???c in ???c truy?n vào h? th?ng g?i thông qua thanh ghi $a0.

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

# Gán giá tr? s0, s1 b?ng l?nh addi
# Tính t?ng s1, s2
# Khai báo các chu?i ch?a thông ?i?p c?n in ra màn hình và các bi?n ?? l?u giá tr? ??u vào và k?t qu? tính toán.
# L?n l??t in các chu?i thông thi?p, s0, s1 và t?ng s0, s1 ra màn hình b?ng l?nh syscall
# K?t thúc ch??ng trình b?ng l?nh syscall.


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
 	
 #Dòng ??u tiên ??t thanh ghi $a0 tr? ??n v? trí ??u tiên c?a xâu ?ích x
 #Dòng ??u tiên ??t thanh ghi $a1 tr? ??n v? trí ??u tiên c?a xâu ?ích y
 #Gán i=s0, t1 là l?u v? trí c?a y[i], t3 l?u v? tr? c?a x[i], t2 l?u k?t qu? c?a t1
 #Giá tr? t??ng ?ng c?a y[i] bên chu?i x s? nh?n giá tr? gi?ng y[i]
 #Ti?p t?c t?ng giá tr? c?a i m?i vòng l?p lên 1 và b?t ??u vòng l?p
 
 
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

#Ban ??u, ch??ng trình s? yêu c?u ng??i dùng nh?p vào m?t chu?i b?ng cách s? d?ng hàm syscall v?i mã
#s? 8. Chu?i này s? ???c l?u tr? trong vùng nh? có tên là string và có ?? dài t?i ?a là 50 ký t?. Sau khi
#nh?p chu?i xong, ch??ng trình ti?p t?c th?c hi?n hàm get_length ?? tính ?? dài c?a chu?i v?a nh?p.
#Hàm get_length b?t ??u b?ng vi?c kh?i t?o giá tr? ?? dài chu?i là 0, r?i ki?m tra t?ng ký t? trong chu?i
#b?ng cách s? d?ng vòng l?p while. N?u ký t? hi?n t?i là null character (k?t thúc chu?i), vòng l?p s? d?ng
#l?i.
#Ng??c l?i, ch??ng trình s? t?ng bi?n ??m ?? dài c?a chu?i lên 1 và ti?p t?c ki?m tra ký t? ti?p theo.
#Sau khi tính ???c ?? dài c?a chu?i, ch??ng trình s? b?t ??u in chu?i ?ó theo th? t? ng??c l?i. Ban ??u,
#ch??ng trình t?o m?t vùng nh? m?i có tên là rstring ?? l?u tr? chu?i ??o ng??c. Sau ?ó, ch??ng trình
#s? duy?t chu?i ban ??u t? cu?i v? ??u, m?i l?n ??c m?t ký t?, ký t? ?ó s? ???c ghi vào vùng nh? m?i
#???c t?o ? b??c tr??c. Cu?i cùng, ch??ng trình s? in chu?i ??o ng??c ra màn hình b?ng cách s? d?ng
#hàm syscall v?i mã s? 59.	