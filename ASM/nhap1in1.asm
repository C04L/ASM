.model small
.stack 100h
.data
    msg1 db "Nhap gia tri: $"
    msg db 009,"Gia tri vua nhap: $"    
    value db ?
    
.code 
main proc 
    mov ax, @data
    mov ds, ax   
    
    ;hien thi thong bao nhap
    lea dx, msg1   
    mov ah, 09h
    int 21h  
    
    ;nhap ky tu
    mov ah, 01h
    int 21h
    mov value, al              
    
    ;in ra thong bao
    lea dx, msg
    mov ah, 09h
    int 21h
    
    ;in ra man hinh
    mov dl, value
    mov ah, 02h
    int 21h 
    
main endp 