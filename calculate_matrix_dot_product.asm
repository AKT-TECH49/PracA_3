; ==========================
; Group member 01: Mpho Martha_Siminya_u21824241
; Group member 02: Amantle_Temo_u23539764
; Group member 03: Yohali_Malaika_Kamangu_u23618583
; ==========================

segment .text
        global calculateMatrixDotProduct

calculateMatrixDotProduct:
        ; My code below

        ; Save the base pointer and set up the stack frame
        push rbp
        mov rbp, rsp
        sub rsp, 16                 ; Allocate space for local variables

        ; Initialize the accumulator for the dot product result (float) to 0.0
        xorps xmm0, xmm0            ; xmm0 will accumulate the dot product

        ; Prepare for outer loop (loop over rows)
        xor r8d, r8d                ; r8d is the row index, starting at 0

outer_loop:
    cmp r8d, edx                ; Check if row index (i) is less than the number of rows
    jge end_dot_product         ; If i >= rows, jump to end

    ; Inner loop (loop over columns)
    xor r9d, r9d                ; r9d is the column index, starting at 0

inner_loop:
    cmp r9d, ecx                ; Check if column index (j) is less than the number of columns
    jge next_row                ; If j >= cols, move to the next row

    ; Load the element matrix1[i][j]
    mov rax, [rdi + r8*8]       ; Load the address of matrix1[i]
    movss xmm1, [rax + r9*4]    ; Load the value of matrix1[i][j] into xmm1 (float)

    ; Load the element matrix2[i][j]
    mov rbx, [rsi + r8*8]       ; Load the address of matrix2[i]
    movss xmm2, [rbx + r9*4]    ; Load the value of matrix2[i][j] into xmm2 (float)

    ; Multiply the two matrix elements
    mulss xmm1, xmm2            ; xmm1 = matrix1[i][j] * matrix2[i][j]

    ; Accumulate the product in xmm0
    addss xmm0, xmm1            ; xmm0 += matrix1[i][j] * matrix2[i][j]

    ; Move to the next column
    inc r9d                     ; Increment column index (j)
    jmp inner_loop              ; Repeat the inner loop

next_row:
    ; Move to the next row
    inc r8d                     ; Increment row index (i)
    jmp outer_loop              ; Repeat the outer loop

end_dot_product:
    ; Return the accumulated dot product in xmm0
    leave
    ret