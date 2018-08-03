.model small
.stack 100h
.code
main proc
; set CGA 320x200 medium res mode
	mov ax, 4
	int 10h

; draw palette 0 color band
	mov ah, 0bh
	mov bh, 1
	mov bl, 0
	int 10h	
	mov ah, 0ch ; write pixel function
	mov al, 0 ; start pixel color 0
	mov bh, 0 ; page 0
	mov dx, 50 ; row
OL1:	mov cx, 96 ; col
	xor si, si
L1:	int 10h
	inc si	
	cmp si, 16
	jl col
	inc al ; next color
	xor si, si
	cmp al, 4
	jl col
	
	xor al, al
	push ax
	mov ah, 0 
	int 16h
	push bx
	mov ah, 0bh
	mov bh, 1
	mov bl, 1
	int 10h
	pop bx
	pop ax
col:	inc cx	; next col
	cmp cx, 224
	jl L1
	inc dx; next row
	push ax
	push bx
	mov ah, 0bh
	mov bh, 1
	mov bl, 0
	int 10h
	pop bx
	pop ax
	cmp dx, 151
	jl OL1
; getch    	
    	mov ah, 0
    	int 16h
; return to text mode    	
    	mov ax, 3
    	int 10h
; return to DOS
    	mov ah, 4ch
    	int 21h
main endp
     end main
