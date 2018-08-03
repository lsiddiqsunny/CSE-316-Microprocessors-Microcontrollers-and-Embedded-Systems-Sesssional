.model small
.stack 100h

.code
main proc

; set video mode
	mov ah, 0
	mov al, 3
	int 10h
; clear window to red
	mov ah, 6	; scroll up function
	mov cx, 081Ah	; upper left corner (1Ah, 08h)
	mov dx, 1034h	; lower right corner (34h, 10h)
	mov bh, 43h	; cyan chars on red background
	mov al, 0	; scroll all lines
	int 10h		; clear window
; move cursor
	mov ah, 2	; move cursor function
	mov dx, 0C27h	; center of screen
	xor bh, bh	; page 0
	int 10h		; move cursor
	
; display character with attribute
	mov ah, 09	; display character function
	mov bh, 0	; page 0
	mov bl, 0CBh	; blinking cyan char, red back
	mov cx, 1	; display one character
	mov al, 'A'	; character is 'A'
	int 10h
; move cursor
	mov ah, 2	; move cursor function
	mov dx, 1827h	; center of screen
	xor bh, bh	; page 0
	int 10h		; move cursor
; dos exit
	mov ah, 4ch
	int 21h
main endp
	end main