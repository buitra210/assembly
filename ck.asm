.data
expression: .space 100
postfix: .space 100

.text
main:
    # Xin m?ng bi?u th?c trung t? t? ng??i d�ng
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

    # T�nh to�n k?t qu? t? bi?u th?c h?u t?
    la $a0, postfix
    jal evaluatePostfix

    # In k?t qu?
    move $a0, $v0
    li $v0, 1
    syscall

    # K?t th�c ch??ng tr�nh
    li $v0, 10
    syscall

# H�m chuy?n ??i bi?u th?c trung t? sang bi?u th?c h?u t?
infixToPostfix:
    move $t4, $t2  # $t4: con tr? duy?t bi?u th?c trung t?
    move $t5, $t3  # $t5: con tr? ghi bi?u th?c h?u t?

    # V�ng l?p duy?t qua t?ng k� t? trong bi?u th?c trung t?
    loop:
        lb $t6, ($t4)
        beqz $t6, end_loop  # K?t th�c n?u g?p k� t? null

        # N?u l� to�n h?ng, ghi v�o bi?u th?c h?u t?
        addiu $t7, $t6, -48
        bltz $t7, not_operand  # Ki?m tra xem k� t? c� ph?i l� to�n h?ng kh�ng
        sb $t6, ($t5)
        addiu $t5, $t5, 1
        j next_iteration

        # N?u l� d?u m? ngo?c, ??y v�o ng?n x?p
        not_operand:
            beq $t6, '(', push_to_stack  # Ki?m tra xem k� t? c� ph?i l� d?u m? ngo?c kh�ng

        # N?u l� d?u ?�ng ngo?c, l?y c�c ph?n t? t? ng?n x?p cho ??n khi g?p d?u m? ngo?c
        beq $t6, ')', pop_from_stack  # Ki?m tra xem k� t? c� ph?i l� d?u ?�ng ngo?c kh�ng

        # N?u l� to�n t?, l?y c�c ph?n t? t? ng?n x?p c� ?? ?u ti�n cao h?n ho?c b?ng v� th�m v�o bi?u th?c h?u t?
        beq $t6, '+', process_operator  # Ki?m tra xem k� t? c� ph?i l� to�n t? kh�ng
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
        beqz $t9, next_iteration  # K?t th�c n?u ng?n x?p r?ng
        addiu $t9, $t9, -1
        sw $t9, ($t0)
        lw $t6, ($t8)
        sb $t6, ($t5)
        addiu $t5, $t5, 1
        j next_iteration

    process_operator:
        addiu $t10, $t0, 4
        lw $t11, ($t0)
        beqz $t11, push_operator  # ??y to�n t? v�o ng?n x?p n?u ng?n x?p r?ng
        lb $t12, ($t10)
        sub $t13, $t6, $t12
        slt $t14, $t13, 0
        beqz $t14, next_iteration  # Th�m to�n t? v�o bi?u th?c h?u t? n?u ?? ?u ti�n th?p h?n

        push_operator:
            sw $t6, ($t10)
            addiu $t11, $t11, 1
            sw $t11, ($t0)

        j next_iteration

    next_iteration:
        addiu $t4, $t4, 1
        j loop

    end_loop:
        sb $zero, ($t5)  # K?t th�c bi?u th?c h?u t? b?ng k� t? null
        jr $ra

# H�m t�nh to�n k?t qu? t? bi?u th?c h?u t?
evaluatePostfix:
    move $t15, $a0  # $t15: con tr? duy?t bi?u th?c h?u t?
    la $t16, stack
    li $t17, -1
    sw $t17, 0($t16)

    # V�ng l?p duy?t qua t?ng k� t? trong bi?u th?c h?u t?
    loop:
        lb $t18, ($t15)
        beqz $t18, end_loop2  # K?t th�c n?u g?p k� t? null

        # N?u l� to�n h?ng, ??y v�o ng?n x?p
        addiu $t19, $t18, -48
        bltz $t19, not_operand2  # Ki?m tra xem k� t? c� ph?i l� to�n h?ng kh�ng
        move $a0, $t18
        jal push_to_stack2
        j next_iteration2

        # N?u l� to�n t?, l?y hai to�n h?ng t? ng?n x?p, th?c hi?n ph�p to�n v� ??y k?t qu? v�o ng?n x?p
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
        beq $a0, '+', addition  # Ki?m tra xem to�n t? c� ph?i l� c?ng kh�ng
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
        move $t22, $t21  # $t22: l?u gi� tr? c?a to�n h?ng ??u ti�n
        move $t23, $t20  # $t23: l?u gi� tr? c?a to�n h?ng th? hai

        power_loop:
            beqz $t23, end_power_loop  # K?t th�c n?u s? m? l� 0
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
        lw $v0, 4($t16)  # K?t qu? cu?i c�ng n?m tr�n ??nh ng?n x?p
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
    beqz $t27, return_zero2  # K?t th�c n?u ng?n x?p r?ng
    addiu $t27, $t27, -1
    sw $t27, ($t16)
    lw $v0, ($t26)
    jr $ra

return_zero2:
    li $v0, 0
    jr $ra

# D? li?u ng?n x?p
stack: .space 8
