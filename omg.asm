.data
A: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
SEVENSEG_LEFT: .word 0xFFFF0011
SEVENSEG_RIGHT: .word 0xFFFF0010

.text
main:
  li $t0, 0       # Kh?i t?o bi?n t0 ?? l?u ch? s? c?a ph?n t? trong m?ng A
  li $t1, 36      # Kh?i t?o bi?n t1 ?? l?u ch? s? ??o ng??c c?a ph?n t? trong m?ng A

  
  loop:
    lw $t2, SEVENSEG_LEFT
    lw $t3, A($t0)
    sb $t3, 0($t2)

    lw $t4, SEVENSEG_RIGHT
    lw $t5, A($t1)
    sb $t5, 0($t4)

    addiu $t0, $t0, 4
    addiu $t1, $t1, -4

    bgez $t1, loop

  exit:
    li $v0, 10     # Thoát ch??ng trình
    syscall
