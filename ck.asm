.data
expression: .space 100
postfix: .space 100

.text
main:
    # Xin m?ng bi?u th?c trung t? t? ng??i dùng
    li $v0, 8
    la $a0, expression
    li $a1, 100
    syscall

    # Chu?n b? ng?n x?p r?ng
    la $t0, stack
    li $t1, -1
    sw $t1, 0($t0)

    # Chuy?n ??i bi?u th?c trung t? sang bi?u th?c h?u t?
    la $t2, expression
    la $t3, postfix
    jal infixToPostfix

    # In bi?u th?c h?u t?
    li $v0, 4
    la $a0, postfix
    syscall

    # Tính toán k?t qu? t? bi?u th?c h?u t?
    la $a0, postfix
    jal evaluatePostfix

    # In k?t qu?
    move $a0, $v0
    li $v0, 1
    syscall

    # K?t thúc ch??ng trình
    li $v0, 10
    syscall

# Hàm chuy?n ??i bi?u th?c trung t? sang bi?u th?c h?u t?
infixToPostfix:
    move $t4, $t2  # $t4: con tr? duy?t bi?u th?c trung t?
    move $t5, $t3  # $t5: con tr? ghi bi?u th?c h?u t?

    # Vòng l?p duy?t qua t?ng ký t? trong bi?u th?c trung t?
    loop:
        lb $t6, ($t4)
        beqz $t6, end_loop  # K?t thúc n?u g?p ký t? null

        # N?u là toán h?ng, ghi vào bi?u th?c h?u t?
        addiu $t7, $t6, -48
        bltz $t7, not_operand  # Ki?m tra xem ký t? có ph?i là toán h?ng không
        sb $t6, ($t5)
        addiu $t5, $t5, 1
        j next_iteration

        # N?u là d?u m? ngo?c, ??y vào ng?n x?p
        not_operand:
            beq $t6, '(', push_to_stack  # Ki?m tra xem ký t? có ph?i là d?u m? ngo?c không

        # N?u là d?u ?óng ngo?c, l?y các ph?n t? t? ng?n x?p cho ??n khi g?p d?u m? ngo?c
        beq $t6, ')', pop_from_stack  # Ki?m tra xem ký t? có ph?i là d?u ?óng ngo?c không

        # N?u là toán t?, l?y các ph?n t? t? ng?n x?p có ?? ?u tiên cao h?n ho?c b?ng và thêm vào bi?u th?c h?u t?
        beq $t6, '+', process_operator  # Ki?m tra xem ký t? có ph?i là toán t? không
        beq $t6, '-', process_operator
        beq $t6, '*', process_operator
        beq $t6, '/', process_operator
        beq $t6, '^', process_operator

        j next_iteration

    push_to_stack:
        addiu $t8, $t0, 4
        lw $t9, ($t0)
        addiu $t9, $t9, 1
        sw $t9, ($t0)
        sw $t6, ($t8)
        j next_iteration

    pop_from_stack:
        addiu $t8, $t0, 4
        lw $t9, ($t0)
        beqz $t9, next_iteration  # K?t thúc n?u ng?n x?p r?ng
        addiu $t9, $t9, -1
        sw $t9, ($t0)
        lw $t6, ($t8)
        sb $t6, ($t5)
        addiu $t5, $t5, 1
        j next_iteration

    process_operator:
        addiu $t10, $t0, 4
        lw $t11, ($t0)
        beqz $t11, push_operator  # ??y toán t? vào ng?n x?p n?u ng?n x?p r?ng
        lb $t12, ($t10)
        sub $t13, $t6, $t12
        slt $t14, $t13, 0
        beqz $t14, next_iteration  # Thêm toán t? vào bi?u th?c h?u t? n?u ?? ?u tiên th?p h?n

        push_operator:
            sw $t6, ($t10)
            addiu $t11, $t11, 1
            sw $t11, ($t0)

        j next_iteration

    next_iteration:
        addiu $t4, $t4, 1
        j loop

    end_loop:
        sb $zero, ($t5)  # K?t thúc bi?u th?c h?u t? b?ng ký t? null
        jr $ra

# Hàm tính toán k?t qu? t? bi?u th?c h?u t?
evaluatePostfix:
    move $t15, $a0  # $t15: con tr? duy?t bi?u th?c h?u t?
    la $t16, stack
    li $t17, -1
    sw $t17, 0($t16)

    # Vòng l?p duy?t qua t?ng ký t? trong bi?u th?c h?u t?
    loop:
        lb $t18, ($t15)
        beqz $t18, end_loop2  # K?t thúc n?u g?p ký t? null

        # N?u là toán h?ng, ??y vào ng?n x?p
        addiu $t19, $t18, -48
        bltz $t19, not_operand2  # Ki?m tra xem ký t? có ph?i là toán h?ng không
        move $a0, $t18
        jal push_to_stack2
        j next_iteration2

        # N?u là toán t?, l?y hai toán h?ng t? ng?n x?p, th?c hi?n phép toán và ??y k?t qu? vào ng?n x?p
        not_operand2:
            move $a0, $t18
            jal pop_from_stack2
            move $t20, $v0
            move $a0, $t18
            jal pop_from_stack2
            move $t21, $v0

            jal perform_operation

            move $a0, $v0
            jal push_to_stack2

        j next_iteration2

    perform_operation:
        beq $a0, '+', addition  # Ki?m tra xem toán t? có ph?i là c?ng không
        beq $a0, '-', subtraction
        beq $a0, '*', multiplication
        beq $a0, '/', division
        beq $a0, '^', power

    addition:
        add $v0, $t21, $t20
        jr $ra

    subtraction:
        sub $v0, $t21, $t20
        jr $ra

    multiplication:
        mult $t21, $t20
        mflo $v0
        jr $ra

    division:
        div $t21, $t20
        mflo $v0
        jr $ra

    power:
        li $v0, 1
        move $t22, $t21  # $t22: l?u giá tr? c?a toán h?ng ??u tiên
        move $t23, $t20  # $t23: l?u giá tr? c?a toán h?ng th? hai

        power_loop:
            beqz $t23, end_power_loop  # K?t thúc n?u s? m? là 0
            mult $v0, $t22
            mflo $v0
            addiu $t23, $t23, -1
            j power_loop

        end_power_loop:
        jr $ra

    next_iteration2:
        addiu $t15, $t15, 1
        j loop

    end_loop2:
        lw $v0, 4($t16)  # K?t qu? cu?i cùng n?m trên ??nh ng?n x?p
        jr $ra

push_to_stack2:
    addiu $t24, $t16, 4
    lw $t25, ($t16)
    addiu $t25, $t25, 1
    sw $t25, ($t16)
    sw $a0, ($t24)
    jr $ra

pop_from_stack2:
    addiu $t26, $t16, 4
    lw $t27, ($t16)
    beqz $t27, return_zero2  # K?t thúc n?u ng?n x?p r?ng
    addiu $t27, $t27, -1
    sw $t27, ($t16)
    lw $v0, ($t26)
    jr $ra

return_zero2:
    li $v0, 0
    jr $ra

# D? li?u ng?n x?p
stack: .space 8
