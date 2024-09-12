; ==========================
; Group member 01: Mpho Martha_Siminya_u21824241
; Group member 02: Amantle_Temo_u23539764
; Group member 03: Yohali_Malaika_Kamangu_u23618583
; ==========================

;section .data
    ;num_one: dd 1.0 
    
section .text
    global multiplyScalarToMatrix 

multiplyScalarToMatrix:
    ; Set up stack frame
    push rbp                       ; Save base pointer of prev stack 
    mov rbp, rsp                   ; Set new base pointer to curr stack 

    ; Remember:
    ; rdi: pointer to matrix 
    ; xmm0: scalar value 
    ; rsi: number of rows
    ; rdx: number of columns 

    ; Check if matrix pointer valid
    ; test rdi, rdi                  ; Test if the matrix pointer is NULL
    ; jz ending_point                ; If rdi NULL, jump to func

    ; Check if scalar is 1.0
    movss xmm1, [rel num_one]          ; Load 1.0 into xmm1
    ucomiss xmm0, xmm1             ; Compare scalar
    je .ending_point                ; If scalar 1.0, skip and exit

    ; Check if rows or cols is zero
    test rsi, rsi                  ; Test if number of rows == 0
    jz .ending_point                ; If rowsn == 0, exit the func
    test rdx, rdx                  ; Test if the number of columns is 0
    jz .ending_point                ; If cols == 0, exit func

    ; Start row processing (matrix traversal)
    xor rcx, rcx                    ; Initialize  (i = 0)
.the_row_loop:
    ; cmp r8, rsi                    ; Compare r(r8) with  (rsi)
    ; jge ending_point               ; If row counter >= rows, exit the func

    ; ; Load pointer to the current row
    ; mov r9, [rdi + r8*8]           ; Load address of matrix[i] into r9

    ; ; Start column processing for the current row
    ; xor r10, r10                   ; Initialize col counter (j = 0)
    xor r8, r8
    mov r9, [rdi + rcx*8]           ; Load address of matrix[i] into r9


.col_loop:
    ; cmp r10, rdx                   ; Compare col counter (r10) with total col (rdx)
    ; jge next_row                   ; If col counter >= cols, move to next row

    ; Perform scalar mul on matrix[i][j]
    movss xmm1, [r9 + r8*4]       ; Load val in matrix[i][j] into xmm1
    mulss xmm1, xmm0               ; Multiply matrix value by the scalar
    movss [r9 + r8*4], xmm1       ; Store result back to matrix[i][j]

    ; Increment column counter and process the next column
    inc r8                        ; I(j++)
    cmp r8, rdx
    jl .col_loop
    inc rcx
    cmp rcx, rsi
    jl .the_row_loop                 ; Repeat 

.ending_point:
    ; Restore stack frame and return
    pop rbp                        ; Restore the prev base pointer
    ret                            ; Return from the func

section .data
    num_one: dd 1.0 
    