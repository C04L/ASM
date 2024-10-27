.model small
.stack 100h
.data                              
    msg db "Hello World!$"
.code
main proc
    mov ax, @data          
    mov ds, ax             
    
    ;In helloworld
    lea dx, msg
    mov ah, 09h
    int 21h
main endp