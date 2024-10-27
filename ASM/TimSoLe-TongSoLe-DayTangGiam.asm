.MODEL SMALL
.STACK 100h
.DATA
 ; Thong bao nhap n
 TB1 DB 'Nhap n (n<=5): $'
 ; Thong bao nhap cac so
 TB2 DB 10, 13, 'Nhap cac so (<=9): $'
 ; Thong bao cac so le va vi tri
 TB3 DB 10, 13, 'Cac so le va vi tri: $'
 ; Thong bao tong cac so le
 TB4 DB 10, 13, 'Tong cac so le: $'
 ; Thong bao day so
 TB5 DB 10, 13, 'Day so la: $'
 ; Thong bao cac trang thai cua day so
 TB_Tang DB 'tang$'
 TB_Giam DB 'giam$'
 TB_KhongTratTu DB 'khong co trat tu$'
 ; Mang luu cac so
 Array DB 5 DUP(?)
 ; Bien luu gia tri n
 N DB ?
 ; Bien luu tong cac so le
 Sum DB 0
.CODE
main PROC
    ; Khoi tao doan du lieu
    mov ax, @data
    mov ds, ax

    ; In thong bao nhap n
    lea dx, TB1
    mov ah, 09h
    int 21h

    ; Nhap gia tri n
    mov ah, 01h
    int 21h
    sub al, '0'
    mov N, al

    ; In thong bao nhap day so
    lea dx, TB2
    mov ah, 09h
    int 21h

    ; Nhap day so vao mang
    mov cx, 0
    mov cl, N
    lea si, Array

input_loop:
    mov ah, 01h
    int 21h
    sub al, '0'
    mov [si], al
    inc si

    ; In khoang cach
    mov dl, ' '
    mov ah, 02h
    int 21h
    loop input_loop

    ; In cac so le va vi tri
    lea dx, TB3
    mov ah, 09h
    int 21h
    mov cx, 0
    mov cl, N
    lea si, Array
    mov bx, 1

odd_loop:
    mov al, [si]
    test al, 1
    jz not_odd
    add Sum, al
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    mov dl, '('
    int 21h
    mov al, bl
    add al, '0'
    mov dl, al
    int 21h
    mov dl, ')'
    int 21h
    mov dl, ' '
    int 21h

not_odd:
    inc si
    inc bx
    loop odd_loop

    ; In tong cac so le
    lea dx, TB4
    mov ah, 09h
    int 21h
    mov al, Sum
    aam
    add ax, 3030h
    mov bx, ax
    mov dl, bh
    mov ah, 02h
    int 21h
    mov dl, bl
    int 21h

    ; Kiem tra day tang/giam/khong trat tu
    lea dx, TB5
    mov ah, 09h
    int 21h
    mov cx, 0
    mov cl, N
    dec cl
    lea si, Array
    mov bl, 0

check_order:
    mov al, [si]
    mov ah, [si+1]
    cmp al, ah
    je continue
    jl check_increasing

    ; Giam
    cmp bl, 1
    je not_ordered
    mov bl, 2
    jmp continue

check_increasing:
    ; Tang
    cmp bl, 2
    je not_ordered
    mov bl, 1
    jmp continue

not_ordered:
    mov bl, 3
    jmp end_check

continue:
    inc si
    loop check_order

end_check:
    cmp bl, 1
    je print_tang
    cmp bl, 2
    je print_giam

    ; Khong trat tu hoac chua xac dinh
    lea dx, TB_KhongTratTu
    jmp print_result

print_tang:
    lea dx, TB_Tang
    jmp print_result

print_giam:
    lea dx, TB_Giam

print_result:
    mov ah, 09h
    int 21h
    mov ah, 4Ch
    int 21h

main ENDP
END main