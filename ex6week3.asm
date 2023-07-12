#Laboratory Exercise 3, Assignment 6.
.data
A: .word 1, 2, 3, -8, 5, -7
.text
	addi $s1, $zero, 1	#i=1
	la $s2, A		#$s2 = ??a ch? ??u tiên c?a ph?n t? ??u tiên m?ng A
	addi $s3, $zero, 5	#n = 5
	addi $s4, $zero, 1	#step = 1
	addi $s5, $zero, 0	#sum = 0
	add $t1, $zero, 0
	add $t1, $t1, $s2
	lw $s6, 0($t1) 
	abs $s6, $s6 #max = $s6
	j loop
setmax:
	addi $s6, $t0, 0
loop:
	add $s1, $s1, $s4	#i = i + step
	#add $t1, $s1, $s1	
	#add $t1, $s1, $s1
	add $t1, $t1, 4
	lw $t0, 0($t1)
	abs $t0, $t0
	slt $t2, $s6, $t0 #neu $s6 < $t0 thi $t2 = 1
	beq $t2, 1, setmax
	bne $s1, $s3, loop
	
	
