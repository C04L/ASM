.MODEL SMALL
.STACK 100H
.DATA
    message DB 'Nhap chuoi ky tu (max 30 ky tu, ket thuc bang Enter): $'
    newline DB 13, 10, '$'      
    maxLength EQU 30 
.CODE
MAIN PROC
    MOV AX, @DATA               ; Kh?i t?o con tr? d? li?u
    MOV DS, AX
    MOV ES, AX

    ; Thong bao
    MOV DX, OFFSET message
    MOV AH, 9
    INT 21H

    ; Set thanh ghi CX = 0
    XOR cx,cx

input_loop:
    MOV AH, 1                   ; Nap 01h vao thanh ghi ah chuan bi cho viec nhap ky tu
    INT 21H
    CMP AL, 13                  ; Kiem tra xem co nhap enter khong
    JE display_reverse          ; Neu nhan enter thi bat dau dao
    PUSH AX                     ; Nap ky tu vua nhap vao stack
    INC CX                      ; Tang b? d?m s? ký t?
    CMP CX, maxLength           ; Ki?m tra n?u d?t d? dài t?i da
    JAE display_reverse         ; N?u d?t t?i da, nh?y d?n ph?n in ngu?c
    JMP input_loop              ; Quay l?i nh?n ký t? ti?p theo

display_reverse:
    ; Xu?ng dòng tru?c khi in chu?i d?o ngu?c
    MOV DX, OFFSET newline
    MOV AH, 9
    INT 21H

    ; In ra các ký t? theo th? t? d?o ngu?c
print_loop:
    POP DX                      ; L?y ký t? t? stack ra
    MOV AH, 2                   ; Hàm 2 c?a INT 21H d? in m?t ký t?
    INT 21H
    LOOP print_loop             ; L?p l?i cho d?n khi CX = 0

    ; K?t thúc chuong trình
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
21h