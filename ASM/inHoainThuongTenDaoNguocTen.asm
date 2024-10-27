.model small ; chuong trinh nay chon bo nho small
.stack 100h ;kich thuoc ngan xep la 256 bytes
.data
    vdlongMsg1 db "Ho ten ban la: $" ; Chuoi in ra yeu cau nguoi dung nhap ho ten
    vdlongMsg2 db 10, 13, "Chao ban: $" ; Chuoi in ra chao mung
    vdlongMsg3 db 10, 13, "Ten dao nguoc: $" ; Chuoi in ra yeu cau in ten dao nguoc
    vdlongBuffer db 100 dup('$') ; Bo dem luu tru chuoi nhap vao
    vdlongLen dw ? ; Bien luu do dai chuoi nhap vao

.code
vdlongMain proc
    mov ax, @data ; Nap dia chi segment data vao thanh ghi ax
    mov ds, ax ; Gan ds bang ax

    ; Hien thi "Ho ten ban la:"
    mov ah, 09h ; Chon ham in chuoi
    lea dx, vdlongMsg1 ; Lay dia chi chuoi yeu cau
    int 21h ; Goi ngat 21h de in chuoi

    ; Nhap ho ten
    mov ah, 0Ah ; Chon ham nhap chuoi
    lea dx, vdlongBuffer ; Lay dia chi bo dem
    int 21h ; Goi ngat 21h de nhap chuoi

    ; Tinh do dai chuoi nhap vao
    mov si, offset vdlongBuffer + 2 ; Gan si bang dia chi bat dau chuoi nhap
    mov cx, 0 ; Khoi tao cx la 0
    vdlongCountLoop:
        cmp byte ptr [si], 0Dh ; So sanh ky tu hien tai voi ky tu ket thuc
        je vdlongEndCount ; Neu la ky tu ket thuc, thoat ra
        inc cx ; Tang do dai chuoi
        inc si ; Di chuyen den ky tu tiep theo
        jmp vdlongCountLoop ; Quay ve lap

    vdlongEndCount:
    mov vdlongLen, cx ; Luu do dai chuoi vao bien vdlongLen

    ; In "Chao ban:" + ho ten in thuong
    mov ah, 09h ; Chon ham in chuoi
    lea dx, vdlongMsg2 ; Lay dia chi chuoi chao mung
    int 21h ; Goi ngat 21h de in chuoi

    mov si, offset vdlongBuffer + 2 ; Gan si bang dia chi bat dau chuoi nhap
    mov cx, vdlongLen ; Gan cx bang do dai chuoi
    vdlongPrintLower:
        mov al, [si] ; Lay ky tu hien tai
        cmp al, 'A' ; So sanh ky tu voi 'A'
        jb vdlongPrintChar ; Neu nho hon 'A', in ky tu
        cmp al, 'Z' ; So sanh ky tu voi 'Z'
        ja vdlongPrintChar ; Neu lon hon 'Z', in ky tu
        add al, 32 ; Chuyen doi ky tu hoa sang thuong
    vdlongPrintChar:
        mov dl, al ; Chuyen ky tu vao dl de in
        mov ah, 02h ; Chon ham in ky tu
        int 21h ; Goi ngat 21h de in
        inc si ; Di chuyen den ky tu tiep theo
        loop vdlongPrintLower ; Lap lai cho den khi het ky tu

    ; In "Chao ban:" + ho ten in hoa
    mov ah, 09h ; Chon ham in chuoi
    lea dx, vdlongMsg2 ; Lay dia chi chuoi chao mung
    int 21h ; Goi ngat 21h de in chuoi

    mov si, offset vdlongBuffer + 2 ; Gan si bang dia chi bat dau chuoi nhap
    mov cx, vdlongLen ; Gan cx bang do dai chuoi
    vdlongPrintUpper:
        mov al, [si] ; Lay ky tu hien tai
        cmp al, 'a' ; So sanh ky tu voi 'a'
        jb vdlongPrintChar2 ; Neu nho hon 'a', in ky tu
        cmp al, 'z' ; So sanh ky tu voi 'z'
        ja vdlongPrintChar2 ; Neu lon hon 'z', in ky tu
        sub al, 32 ; Chuyen doi ky tu thuong sang hoa
    vdlongPrintChar2:
        mov dl, al ; Chuyen ky tu vao dl de in
        mov ah, 02h ; Chon ham in ky tu
        int 21h ; Goi ngat 21h de in
        inc si ; Di chuyen den ky tu tiep theo
        loop vdlongPrintUpper ; Lap lai cho den khi het ky tu

    ; In ho ten dao nguoc
    mov ah, 09h ; Chon ham in chuoi
    lea dx, vdlongMsg3 ; Lay dia chi chuoi yeu cau in dao nguoc
    int 21h ; Goi ngat 21h de in chuoi

    mov si, offset vdlongBuffer + 2 ; Gan si bang dia chi bat dau chuoi nhap
    add si, vdlongLen ; Di chuyen den cuoi chuoi
    dec si ; Di chuyen lui 1 vi tri
    mov cx, vdlongLen ; Gan cx bang do dai chuoi
    vdlongPrintReverse:
        mov dl, [si] ; Lay ky tu hien tai
        mov ah, 02h ; Chon ham in ky tu
        int 21h ; Goi ngat 21h de in
        dec si ; Di chuyen lui 1 vi tri
        loop vdlongPrintReverse ; Lap lai cho den khi het ky tu

    ; Ket thuc chuong trinh
    mov ah, 4Ch ; Chon ham ket thuc
    int 21h ; Goi ngat 21h de ket thuc
vdlongMain endp ; Ket thuc dinh nghia thu tuc chinh
end vdlongMain ; Ket thuc chuong trinh va chi dinh diem vao
