.model small
.stack 100h
.data
    msg db "Nhap ky tu: $"
    msg1 db 10,"Ky tu truoc: $"
    msg2 db 10,"Ky tu sau: $"  
    value db ?
.code
 main proc
    mov ax,@data
    mov ds, ax        
    
    ;yeu cau nhap gia tri
    lea dx, msg
    mov ah, 09h
    int 21h 
    
    ;nhap ky tu
    mov ah, 01h
    int 21h
    mov value, al
    
    ;tru 1 gia tri
    sub value,1
    
    ;in gia tri truoc
    lea dx, msg1
    mov ah, 09h
    int 21h
    mov dl, value
    mov ah, 02h
    int 21h   
    
    ;in gia tri sau
    add value,2 
    lea dx, msg2
    mov ah, 09h  
    int 21h
    mov dl, value
    mov ah, 02h
    int 21h
    
    
     
     
 main endp