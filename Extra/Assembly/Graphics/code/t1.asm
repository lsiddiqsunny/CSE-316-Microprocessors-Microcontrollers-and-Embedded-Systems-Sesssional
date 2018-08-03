.model small
.stack 100h
.code
main proc
; set CGA 640x200 high res mode
	mov ax, 6
	int 10h    

; draw line pixel by pixel	
	mov ah, 0ch
	mov al, 1
	
	mov cx, 50 ; beginning col
	mov dx, 99 ; beginning row
	
    L1: int 10h
    	inc cx
    	cmp cx, 438
    	jle L1
    	
    	mov ah, 0
    	int 16h
    	
    	mov ax, 3
    	int 10h
    	
    	mov ah, 4ch
    	int 21h
main endp
     end main
