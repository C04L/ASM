.model small
.stack 100h
.data
    MsgN db "Nhap n (n<=5): $"
    MsgArray db "Nhap cac so nguyen duong (<=9):$"
    MsgEven db "Cac so chan va vi tri:$"
    MsgSum db "Tong cac so chan: $"
    MsgOrder db "Thu tu day so: $"
    Newline db 13, 10, '$'
    Space db " $"
    N db ?
    Array db 5 dup(?)
    Sum dw 0
    Increasing db "Tang$"
    Decreasing db "Giam$"
    Unordered db "Khong co trat tu$"

.code
Main proc
    mov ax, @data
    mov ds, ax

    lea dx, MsgN
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'
    mov N, al

    lea dx, Newline
    mov ah, 9
    int 21h
    lea dx, MsgArray
    mov ah, 9
    int 21h
    lea dx, Newline
    mov ah, 9
    int 21h
    
    mov cx, 0
    mov cl, N
    lea si, Array

InputLoop:
    mov ah, 1
    int 21h
    sub al, '0'
    mov [si], al
    inc si
    
    lea dx, Space
    mov ah, 9
    int 21h
    
    loop InputLoop

    lea dx, Newline
    mov ah, 9
    int 21h

    lea dx, MsgEven
    mov ah, 9
    int 21h

    lea dx, Newline
    mov ah, 9
    int 21h

    mov cx, 0
    mov cl, N
    lea si, Array
    mov bx, 0

EvenLoop:
    mov al, [si]
    test al, 1
    jnz NotEven

    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h
    
    mov ah, 2
    mov dl, '-'
    int 21h

    mov ax, bx
    add ax, 1
    add ax, '0'
    mov dl, al
    mov ah, 2
    int 21h

    lea dx, Space
    mov ah, 9
    int 21h

    mov al, [si]
    mov ah, 0
    add Sum, ax

NotEven:
    inc si
    inc bx
    loop EvenLoop

    lea dx, Newline
    mov ah, 9
    int 21h

    lea dx, MsgSum
    mov ah, 9
    int 21h

    mov ax, Sum
    call PrintNumber

    lea dx, Newline
    mov ah, 9
    int 21h

    lea dx, MsgOrder
    mov ah, 9
    int 21h

    mov cx, 0
    mov cl, N
    dec cl
    lea si, Array
    mov bl, 1

OrderLoop:
    mov al, [si]
    mov ah, [si+1]
    cmp al, ah
    je OrderNext
    jl IncreasingCheck
    jg DecreasingCheck
    jmp UnorderedCheck
    
IncreasingCheck:
    cmp bl, 2
    je UnorderedCheck
    mov bl, 1
    jmp OrderNext

DecreasingCheck:
    cmp bl, 1
    je UnorderedCheck
    mov bl, 2
    jmp OrderNext

UnorderedCheck:
    mov bl, 3

OrderNext:
    inc si
    loop OrderLoop

    cmp bl, 1
    je PrintIncreasing
    cmp bl, 2
    je PrintDecreasing
    cmp bl, 3
    je PrintUnordered

    jmp Exit

PrintIncreasing:
    lea dx, Increasing
    mov ah, 9
    int 21h
    jmp Exit

PrintDecreasing:
    lea dx, Decreasing
    mov ah, 9
    int 21h
    jmp Exit

PrintUnordered:
    lea dx, Unordered
    mov ah, 9
    int 21h

Exit:
    mov ax, 4C00h
    int 21h

PrintNumber proc
    push ax
    mov bx, 10
    xor cx, cx

PrintNumberLoop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz PrintNumberLoop

PrintNumberOutputLoop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop PrintNumberOutputLoop

    pop ax
    ret

PrintNumber endp
end Main
