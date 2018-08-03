.model small
.stack 100h
.data
mychar db 20 dup (?)
count db 0
count2 db 0
cur_pos_r db 0Ch
cur_pos_c db 27h
.code
main proc
	mov ax, @data
	mov ds, ax
	lea di, mychar
getch:
	mov ah, 0
	int 16h
	
	cmp al, 0
	je _chk
; store char
	mov [di], al
	inc di
	inc count2
	jmp getch
_chk:
	mov byte[di], '$'
; set video mode
	mov ah, 0
	mov al, 3
	int 10h
	mov cx, 0C27h
	mov dx, 0C27h
	shr count2, 1
	sub ch, count2
	sub cl, count2
	mov cur_pos_r, ch
	mov cur_pos_c, cl
	add dh, count2
	add dl, count2
; clear window to red
	mov ah, 6	; scroll up function
	;mov cx, 081Ah	; upper left corner (1Ah, 08h)
	;mov dx, 1034h	; lower right corner (34h, 10h)
	mov bh, 43h	; cyan chars on red background
	mov al, 0	; scroll all lines
	int 10h		; clear window
	
	lea si, mychar
_display:
; move cursor
	mov ah, 2	; move cursor function
	;mov dx, 0C27h	; center of screen
	mov dh, cur_pos_r
	mov dl, cur_pos_c
	add dh, count
	add dl, count
	xor bh, bh	; page 0
	int 10h		; move cursor
	
	
; display character with attribute
	mov ah, 09	; display character function
	mov bh, 0	; page 0
	mov bl, 0CBh	; blinking cyan char, red back
	mov cx, 1	; display one character
	mov al, [si]	; character is 'A'
	int 10h
	inc si
	inc count
	cmp byte[si], '$'
	jne _display
; move cursor
	mov ah, 2	; move cursor function
	mov dx, 1827h	; row 24, col 39
	xor bh, bh	; page 0
	int 10h		; move cursor

; dos exit
	mov ah, 4ch
	int 21h
main endp
	end main