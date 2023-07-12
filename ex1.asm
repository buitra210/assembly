.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 ben trai.
 						
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 ben phai
.data
A: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text

main:
	li $s2, 0
 	la $s0, A # Gan dia chi mang A cho $s0
 	loop:
 		add $t2, $s2, $s2 #x2 index
 		add $t2, $t2, $t2 #x4 index
 		add $t3, $s0, $t2 # dia chi phan tu hien tai = s0 + 4 x index
 		
 		lw $a0,($t3)  
 		jal SHOW_7SEG_LEFT 
 		nop
 		subi $t3, $t2, 36 # lay 4 x index -36 de ra index con lai ( tong 2 so = 9 )
 		abs $t3, $t3 # dang nhe la phai 36 - 4 x index
 		add $t4, $t3, $s0 # dia chi phan tu hien tai
 		lw $a0,($t4) # set value for segments
 		jal SHOW_7SEG_RIGHT # show 
		nop	
		addi $s2,$s2,1 # tang index len 1
		beq $s2,10, exit
		
		li $a0, 1000 # delay 1s
		li $v0, 32
		syscall
		
	
		j loop
exit: 
	li $v0, 10
 	syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown 
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT # assign port's address
 	sb $a0, 0($t0) # assign new value 
 	nop
	jr $ra
	nop
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown 
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT # assign port's address
 	sb $a0, 0($t0) # assign new value
 	nop
	jr $ra 
 	nop
