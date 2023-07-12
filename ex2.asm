
.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.eqv BLACK 0x00000000
.text
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
	
 	li $s0,0
 	loop:
 		add $t2, $s0, $s0 #x2 index
 		add $t2, $t2, $t2 #x4 index
 		add $t3, $k0, $t2	# dia chi phan tu hien tai = s0 + 4 x index
 		li $t0, BLUE
 		sw $t0, 0($t3) 
 		
 		li $a0, 1000 # delay 1s
		li $v0, 32
		syscall
		li $t0, BLACK
 		sw $t0, 0($t3) 
 		addi $s0,$s0,1
 		j loop
 
 
