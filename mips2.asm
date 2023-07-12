.data
A: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
SEVENSEG_LEFT: .word 0xFFFF0011
SEVENSEG_RIGHT: .word 0xFFFF0010

.text
main:
  li $a0, 0x6F
  jal SHOW_7SEG_LEFT
  nop

  li $a0, 0xFF
  jal SHOW_7SEG_RIGHT
  nop
  
  li $a0, 0x3F
  jal SHOW_7SEG_LEFT
  nop
  
   li $a0, 0x6F
  jal SHOW_7SEG_RIGHT
  nop
  
  

  exit:
    li $v0, 10
    syscall

endmain:

SHOW_7SEG_LEFT:
  la $t0, SEVENSEG_LEFT
  sb $a0, 0($t0)
  nop
  jr $ra

SHOW_7SEG_RIGHT:
  la $t0, SEVENSEG_RIGHT
  sb $a0, 0($t0)
  nop
  li $a0, 1000
  syscall
  jr $ra
