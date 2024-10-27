.model small
.stack 100h

.data
    nthaMSG1 db "Ho ten ban la: $"
    nthaMSG2 db 10, 13, "Que quan cua ban la: $"
    nthaMSG3 db 10, 13, "Ban: $"
    nthaMSG4 db " Chao mung que ban: $"
    nthaMSG5 db 10, 13, "Que quan dao nguoc: $"
    nthaTBName db 50, ?, 50 dup('$')
    nthaTBHometown db 50, ?, 50 dup('$')
    nthaTBRHometown db 50 dup('$')
    nthaTBNewline db 10, 13, '$'

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display "Ho ten ban la: " and input name
    lea dx, nthaMSG1
    mov ah, 9
    int 21h
    lea dx, nthaTBName
    mov ah, 0Ah
    int 21h

    ; Display "Que quan cua ban la: " and input hometown
    lea dx, nthaMSG2
    mov ah, 9
    int 21h
    lea dx, nthaTBHometown
    mov ah, 0Ah
    int 21h

    ; Display "Ban: " and print name in uppercase
    lea dx, nthaMSG3
    mov ah, 9
    int 21h
    lea si, nthaTBName + 2
    call nthaPrintUppercase

    ; Display "Chao mung que ban: " and print hometown in uppercase
    lea dx, nthaMSG4
    mov ah, 9
    int 21h
    lea si, nthaTBHometown + 2
    call nthaPrintUppercase

    ; Display "Que quan dao nguoc: " and print reversed hometown
    lea dx, nthaMSG5
    mov ah, 9
    int 21h
    call nthaReverseHometown
    lea dx, nthaTBRHometown
    mov ah, 9
    int 21h

    ; End program
    mov ah, 4Ch
    int 21h
main endp

; Procedure to print string in uppercase
nthaPrintUppercase proc
print_loop:
    lodsb
    cmp al, 13
    je done_print
    cmp al, 'a'
    jb print_char
    cmp al, 'z'
    ja print_char
    sub al, 32
print_char:
    mov dl, al
    mov ah, 2
    int 21h
    jmp print_loop
done_print:
    ret
nthaPrintUppercase endp

; Procedure to reverse hometown string
nthaReverseHometown proc
    lea si, nthaTBHometown + 1
    mov cl, [si]
    xor ch, ch
    lea si, nthaTBHometown + 2
    add si, cx
    dec si
    lea di, nthaTBRHometown
reverse_loop:
    mov al, [si]
    mov [di], al
    dec si
    inc di
    loop reverse_loop
    mov byte ptr [di], '$'
    ret
nthaReverseHometown endp

end main