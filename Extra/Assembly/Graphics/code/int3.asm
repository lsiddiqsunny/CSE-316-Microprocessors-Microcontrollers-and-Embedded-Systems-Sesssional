.model small
.stack 100h
.data
time_buf 	db 	'00:00:00$'	; time buffer hh:mm:ss
cursor_pos 	dw 	? 		; (row:col)
new_vec 	dw 	?,?
old_vec 	dw 	?,?

.code
main proc
	mov ax, @data
	mov ds, ax
; save cursor position
	mov ah, 3
	mov bh, 0
	int 10h
	mov cursor_pos, dx
; setup int proc by placing seg:off time_int in new_vec
	mov new_vec, offset time_int	; offset
	mov new_vec+2, seg time_int	; segment
	lea di, old_vec			; di points to vector buffer
	lea si, new_vec			; si points to new vector
	mov al, 1ch			; timer interrupt
	call setup_int		
; read keyboard
	mov ah, 0
	int 16h
; restore old int vec
	lea di, new_vec			; di points to vector buffer
	lea si, old_vec			; si points to old vec
	mov al, 1ch			; timer interrupt
	call setup_int
	
	mov ah, 4ch
	int 21h
main endp

time_int proc
; interrupt procedure activated by the timer
	push ds
	mov ax, @data
	mov ds, ax
; get new time
	lea bx, time_buf
	call get_time
; display time
	lea dx, time_buf
	mov ah, 09h
	int 21h
; restore cursor
	mov ah, 2	; move cursor
	mov bh, 0
	mov dx, cursor_pos
	int 10h
	pop ds
	iret
time_int endp

get_time proc
; get time of day and store ascii digits in time buffer
; input bx = address of time buffer
	mov ah, 2ch		; get time
	int 21h			; ch = hr, cl = min, dh = sec
; convert hr to ascii and store
	mov al, ch
	call convert
	mov [bx], ax
; convert mm to ascii and store
	mov al, cl
	call convert
	mov [bx+3], ax
; convert ss to ascii and store
	mov al, dh
	call convert
	mov [bx+6], ax
	ret
get_time endp

convert proc
	mov ah, 0
	mov dl, 10
	div dl
	or ax, 3030h
	ret
convert endp

setup_int proc
; save old vector and set up new vector
; input: al = interrupt number
;	 di = address of buffer for old vector
;	 si = address of buffer containing new vector
; save old interrupt vector
	mov ah, 35h	; get vector
	int 21h
	mov [di], bx	; save offset
	mov [di+2], es  ; save segment
; setup new vector
	mov dx, [si]	; dx has offset
	push ds		; save ds
	mov ds, [si+2]	; ds has the segment number
	mov ah, 25h	; set vector
	int 21h
	pop ds
	ret
setup_int endp

end main