.MODEL small
.STACK
.DATA
tb1 DB 'Nhap vao 1 chuoi: $'
tb2 DB 10,13,'Doi thanh chu thuong: $'
tb3 DB 10,13,'Doi thanh chu hoa: $'
s DB 100,?,101 dup('$')
.CODE
BEGIN:
    ;chuyen du lieu vao thanh ghi ax,ds
    MOV AX, @DATA
    MOV DS,AX
    ;xuat chuoi tb1
    MOV AH,09h
    LEA DX,tb1
    INT 21h
    ;nhap chuoi s
    MOV AH,0AH
    LEA DX,s
    INT 21h
    ;xuat chuoi tb2
    MOV AH,09h
    LEA DX,tb2
    INT 21h
    ; Goi chuong trinh con in chuoi thuong
    CALL InChuoiThuong
    ; xuat chuoi tb3
    MOV AH,09h
    LEA DX,tb3
    INT 21h
    ; Goi chuong trinh con in chuoi thuong
    CALL InChuoiHoa
    MOV AH,4ch
    INT 21h
;**************************************
; Doi thanh chuoi ky tu thuong
InChuoiThuong PROC
    LEA SI,s+1 ;Luu dia chi phan tu thu 2 vao thanh ghi SI (phan tu 1 chua do dai chuoi)
    XOR CX,CX  ;Khoi tao thanh ghi cx = 0
    MOV CL,[SI];Lay gia tri byte tai dia chi SI luu vao thanh ghi CL (luu do dai chuoi vao cl)
    INC SI     ;Tang gia tri SI them 1
    LapThuong: ;Danh dau diem bat dau cua vong lap LapThuong
    MOV AH,02h ;Chuyen gia tri 02h vao thanh ghi ah (lenh in ky tu ra man hinh)
    MOV DL,[SI];Chuyen gia tri byte tai dia chi SI luu vao thanh ghi DL (ky tu can chuyen doi)
    CMP DL,'A' ;So sanh voi "A" de kiem tra xem co phai chu hoa khong
    JB LT1     ;Neu nho hon "A" thi nhay den LT1(khong phai in hoa) 
    CMP DL,'Z' ;So sanh voi "Z" de kiem tra co phai chu in hoa khong
    JA LT1     ;Neu lon hon "Z" thi nhay den LT1(khong phai in hoa)
    ADD DL,32  ;Neu la chu in hoa thi cong them 32 de chuyen thanh chu thuong
    LT1:       ;Danh dau label LT1 
    INC SI     ;Tang gia tri cua SI them 1 
    INT 21h    ;In ra man hinh ky tu
    LOOP LapThuong ;Giam CX di 1 neu CX != 0 thi quay lai LapThuong
    RET            ;Quay lai LapThuong
InChuoiThuong ENDP ;Ket thuc chuong trinh con InChuoiThuong
; Doi thanh chuoi ky tu hoa
InChuoiHoa PROC    ;Chuong trinh con InChuoiHoa
    LEA SI,s+1     ;Luu dia chi phan tu thu 2 vao thanh ghi SI
    XOR CX,CX      ;Khoi tao thanh ghi cx = 0
    MOV CL,[SI]    ;Luu do dai chuoi vao CL
    INC SI         ;Tang SI them 1
    LapHoa:        ;Danh dau label LapHoa
    MOV AH,02h     ;Chuyen 02h vao Ah, chuan bi in ky tu
    MOV DL,[SI]    ;Luu ky tu can chuyen doi vao DL
    CMP DL,'a'     ;So sanh voi 'a' de xem co phai la chu thuong khong
    JB LH1         ;In ra neu la chu hoa
    CMP DL,'z'     ;So sanh voi "z" de xem co phai la chu cai khong
    JA LH1         ;In ra neu khong phai chu cai
    SUB DL,32      ;Tru di 32 neu la chu thuong de doi thanh in hoa
    LH1:           ;Label LH1
    INC SI         ;Tang SI them 1
    INT 21h        ;Ngat de in ky tu
    LOOP LapHoa    ;Giam cx di 1, neu cx != 0 thi quay lai Laphoa
    RET
InChuoiHoa ENDP
END BEGIN
