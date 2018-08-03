.model small
.stack 100h
.code
main proc
; set VGA 320x200 256 color mode
	mov ah, 0h
	mov al, 13h
	int 10h
; draw 256 color band	
	mov ah, 0ch ; write pixel function
	mov al, 0 ; start pixel color 0
	mov bh, 0 ; page 0
	mov dx, 50 ; row
OL1:	mov cx, 31 ; col
L1:	int 10h
	inc al	; next color
	inc cx	; next col
	cmp cx, 287
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
