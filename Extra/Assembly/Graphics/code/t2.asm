.model small
.stack 100h
.code
main proc
; set graphics mode 4
	mov ah,0h
	mov al,4h
	int 10h
; set bgd color to cyan
	mov ah, 0bh
	mov bh, 00h
	mov bl, 3
    	int 10h
; select palette 0
	mov bh, 1
	mov bl, 0
	int 10h
; move cursor to page 0, row 12, col 19
    	mov ah, 02
    	mov bh, 0
    	mov dh, 12
    	mov dl, 19
    	int 10h
; write char    	
    	mov ah, 9
    	mov al, 'A'
    	mov bl, 2 ; color value from palette
    	mov cx, 1
    	int 10h
; getch    	
    	mov ah, 0
    	int 16h
; return to text mode
    	mov ax, 3
    	int 10h
    	
; return to dos
    	mov ah, 4ch
    	int 21h
main endp
     end main