; ==========================
; Group member 01: Mpho Martha_Siminya_u21824241
; Group member 02: Amantle_Temo_u23539764
; Group member 03: Yohali_Malaika_Kamangu_u23618583
; ==========================


; float** addMatrices(float **matrix1, float **matrix2, int rows, int cols) ;check the fun.c file
; rdi -> matrix1 (pointer to first matrix)
; rsi -> matrix2 (pointer to second matrix)
; rdx -> rows (int)
; rcx -> cols (int)
;and registers must be preserved across function calls
;rbx, r12, r13, r14, r15 ;push them on the stack 


section .data
    ;fmt db "%.2f ", 0                ; format string for printing floats
    ;err_msg db "Memory access out of bounds", 0
    ;//for debugging purposes


section .text
    extern malloc
    extern free
    extern printf
    global addMatrices



addMatrices:
    ; push in
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi  
    mov r13, rsi  
    mov r14, rdx  
    mov r15, rcx 

    ; nullity?
    test r14, r14
    jz ._null
    test r15, r15
    jz ._null

    
    mov rdi, r14
    shl rdi, 3 
    call malloc
    test rax, rax
    jz ._null
    mov rbx, rax  
    xor r8, r8  
    
    
._rows:
    mov rdi, r15
    shl rdi, 2  
    call malloc
    test rax, rax
    jz ._null  ;else null


    mov [rbx + r8 * 8], rax  ;pointer
    inc r8
    cmp r8, r14
    jl ._rows
    xor r8, r8  


.add_rows:

    xor r9, r9  
    mov rdi, [r12 + r8 * 8]  
    mov rsi, [r13 + r8 * 8]  
    mov rdx, [rbx + r8 * 8]  
    
.add_cols:

    movss xmm0, [rdi + r9 * 4]  
    addss xmm0, [rsi + r9 * 4] 
    movss [rdx + r9 * 4], xmm0 

    ;for cols
    inc r9
    cmp r9, r15
    jl .add_cols

    ;for rows
    inc r8
    cmp r8, r14
    jl .add_rows

    
    mov rax, rbx
    jmp .completed

._null:
    mov rax,0

.completed:

    ; deallocate
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
