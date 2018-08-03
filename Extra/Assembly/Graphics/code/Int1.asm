.model small
.stack 100h
.data
time_buf db '00:00:00$'	; time buffer hh:mm:ss

.code
main proc
	mov ax, @data
	mov ds, ax
; get and display time
	lea bx, time_buf	; bx points to time_buf
	call get_time		; put current time in time_buf
	lea dx, time_buf	; dx points to time_buf
	mov ah, 09h		; display time
	int 21h
; exit
	mov ah, 4ch
	int 21h
main endp

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

end main