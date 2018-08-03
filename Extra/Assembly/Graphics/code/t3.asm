.model small
.stack 100h
.code
main proc
; set EGA 640x200 high res mode
	mov ax, 0Eh
	int 10h

; draw 16 color band	
	mov ah, 0ch ; write pixel function
	mov al, 0 ; start pixel color 0
	mov bh, 0 ; page 0
	mov dx, 50 ; row
OL1:	mov cx, 192 ; col
	xor si, si
L1:	int 10h
	inc si	
	cmp si, 16
	jl col
	inc al ; next color
	xor si, si
col:	inc cx	; next col
	cmp cx, 448
	jl L1
	inc dx; next row
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
