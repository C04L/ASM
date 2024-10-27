.model small ; chuong trinh nay chon bo nho small
.stack 100h ;kich thuoc ngan xep la 256 bytes
.data
    MsgN db "Nhap n (n<=5): $"  ; Thong diep nhap n
    MsgArray db "Nhap cac so nguyen duong (<=9):$"  ; Thong diep nhap mang
    MsgEven db "Cac so chan va vi tri:$"  ; Thong diep in cac so chan va vi tri
    MsgSum db "Tong cac so chan: $"  ; Thong diep in tong cac so chan
    MsgOrder db "Thu tu day so: $"  ; Thong diep in thu tu day so
    Newline db 13, 10, '$'  ; Ky tu xuong dong
    Space db " $"  ; Ky tu cach
    N db ?  ; Bien luu gia tri n
    Array db 5 dup(?)  ; Mang luu cac so
    Sum dw 0  ; Bien luu tong cac so chan
    Increasing db "Tang$"  ; Thong diep thu tu tang
    Decreasing db "Giam$"  ; Thong diep thu tu giam
    Unordered db "Khong co trat tu$"  ; Thong diep khong co trat tu

.code
Main proc
    mov ax, @data  ; Lay dia chi segment du lieu
    mov ds, ax  ; Khoi tao segment du lieu

    ; Nhap n
    lea dx, MsgN  ; Lay dia chi thong diep nhap n
    mov ah, 9  ; Dinh nghia ham in thong diep
    int 21h  ; Thuc hien ham

    mov ah, 1  ; Dinh nghia ham nhap mot ky tu
    int 21h  ; Thuc hien ham
    sub al, '0'  ; Chuyen tu ASCII sang so
    mov N, al  ; Luu gia tri n

    ; In xuong dong
    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    ; Nhap mang
    lea dx, MsgArray  ; Lay dia chi thong diep nhap mang
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    
    mov cx, 0  ; Khoi tao bien dem
    mov cl, N  ; Gan gia tri n cho bien dem
    lea si, Array  ; Lay dia chi mang

InputLoop:
    mov ah, 1  ; Dinh nghia ham nhap mot ky tu
    int 21h  ; Thuc hien ham
    sub al, '0'  ; Chuyen tu ASCII sang so
    mov [si], al  ; Luu gia tri vao mang
    inc si  ; Tang dia chi mang
    
    lea dx, Space  ; Lay dia chi ky tu cach
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    
    loop InputLoop  ; Lap lai cho den khi het so phan tu

    ; In xuong dong
    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    ; In cac so chan va vi tri
    lea dx, MsgEven  ; Lay dia chi thong diep in so chan va vi tri
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    mov cx, 0  ; Khoi tao bien dem
    mov cl, N  ; Gan gia tri n cho bien dem
    lea si, Array  ; Lay dia chi mang
    mov bx, 0  ; Bien dem vi tri

EvenLoop:
    mov al, [si]  ; Lay gia tri tu mang
    test al, 1  ; Kiem tra bit cuoi cung
    jnz NotEven  ; Neu khong phai so chan, nhay den NotEven

    ; In so chan
    add al, '0'  ; Chuyen tu so sang ASCII
    mov dl, al  ; Gan gia tri ASCII cho dl
    mov ah, 2  ; Dinh nghia ham in ky tu
    int 21h  ; Thuc hien ham 
    
    ;In ky tu '-'
    mov ah, 2  ;Dinh nghia ham in ky tu
    mov dl, '-';Gan gia tri '-' cho dl
    int 21h    ;Ngat de thuc hien ham

    ; In vi tri
    mov ax, bx  ; Gan vi tri cho ax
    add ax, 1  ; Vi tri bat dau tu 1
    add ax, '0'  ; Chuyen tu so sang ASCII
    mov dl, al  ; Gan gia tri ASCII cho dl
    mov ah, 2  ; Dinh nghia ham in ky tu
    int 21h  ; Thuc hien ham

    lea dx, Space  ; Lay dia chi ky tu cach
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    ; Cong vao tong
    mov al, [si]  ; Lay gia tri tu mang
    mov ah, 0  ; Gan ah = 0
    add Sum, ax  ; Cong gia tri vao tong

NotEven:
    inc si  ; Tang dia chi mang
    inc bx  ; Tang vi tri
    loop EvenLoop  ; Lap lai cho den khi het so phan tu

    ; In xuong dong
    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    ; In tong cac so chan
    lea dx, MsgSum  ; Lay dia chi thong diep in tong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    mov ax, Sum  ; Lay gia tri tong
    call PrintNumber  ; Goi ham in so

    ; In xuong dong
    lea dx, Newline  ; Lay dia chi ky tu xuong dong
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    ; Kiem tra trat tu cua day
    lea dx, MsgOrder  ; Lay dia chi thong diep in thu tu
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

    mov cx, 0  ; Khoi tao bien dem
    mov cl, N  ; Gan gia tri n cho bien dem
    dec cl  ; So lan so sanh = n - 1
    lea si, Array  ; Lay dia chi mang
    mov bl, 1  ; 1 = tang, 2 = giam, 3 = khong trat tu

OrderLoop:
    mov al, [si]  ; Lay gia tri tu mang
    mov ah, [si+1]  ; Lay gia tri phan tu ke tiep
    cmp al, ah  ; So sanh hai gia tri
    je OrderNext  ; Neu bang nhau, tiep tuc
    jl IncreasingCheck  ; Neu al < ah, kiem tra tang
    jg DecreasingCheck  ; Neu al > ah, kiem tra giam
    jmp UnorderedCheck  ; Neu khong phai tang hay giam, kiem tra khong trat tu
    
IncreasingCheck:
    cmp bl, 2  ; Neu da la giam, chuyen sang khong trat tu
    je UnorderedCheck  ; Neu giam, kiem tra khong trat tu
    mov bl, 1  ; Gan bl = 1
    jmp OrderNext  ; Tiep tuc

DecreasingCheck:
    cmp bl, 1  ; Neu da la tang, chuyen sang khong trat tu
    je UnorderedCheck  ; Neu tang, kiem tra khong trat tu
    mov bl, 2  ; Gan bl = 2
    jmp OrderNext  ; Tiep tuc

UnorderedCheck:
    mov bl, 3  ; Gan bl = 3

OrderNext:
    inc si  ; Tang dia chi mang
    loop OrderLoop  ; Lap lai cho den khi het so phan tu

    ; In thu tu

    cmp bl, 1  ; Kiem tra thu tu
    je PrintIncreasing  ; Neu tang, in thong diep
    cmp bl, 2  ; Kiem tra thu tu
    je PrintDecreasing  ; Neu giam, in thong diep
    cmp bl, 3  ; Kiem tra khong trat tu
    je PrintUnordered  ; Neu khong trat tu, in thong diep

    jmp Exit  ; Ket thuc

PrintIncreasing:
    lea dx, Increasing  ; Lay dia chi thong diep tang
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    jmp Exit  ; Ket thuc

PrintDecreasing:
    lea dx, Decreasing  ; Lay dia chi thong diep giam
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham
    jmp Exit  ; Ket thuc

PrintUnordered:
    lea dx, Unordered  ; Lay dia chi thong diep khong trat tu
    mov ah, 9  ; Dinh nghia ham in
    int 21h  ; Thuc hien ham

Exit:
    ; Thoat chuong trinh
    mov ax, 4C00h  ; Thoat chuong trinh
    int 21h  ; Thuc hien ham

; Ham in so
PrintNumber proc
    push ax  ; Luu ax vao stack
    mov bx, 10  ; Co so 10
    xor cx, cx  ; Khoi tao cx

PrintNumberLoop:
    xor dx, dx  ; Gan dx = 0
    div bx  ; Chia ax cho bx
    push dx  ; Luu phan du vao stack
    inc cx  ; Tang so luong chu so
    test ax, ax  ; Kiem tra ax
    jnz PrintNumberLoop  ; Neu khong bang 0, lap lai

PrintNumberOutputLoop:
    pop dx  ; Lay phan du tu stack
    add dl, '0'  ; Chuyen tu so sang ASCII
    mov ah, 2  ; Dinh nghia ham in ky tu
    int 21h  ; Thuc hien ham
    loop PrintNumberOutputLoop  ; Lap lai cho den khi het so chu so

    pop ax  ; Lay ax tu stack
    ret  ; Tro ve

PrintNumber endp ; Ket thuc phan dinh nghia cua ham in so
end Main ; Ket thuc chuong trinh, mac dinh tro ve main