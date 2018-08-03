
.model small
.stack 100h

.data
time_buf db '00:00:00$'	; time buffer hh:mm:ss

.Code
main Proc
	MOV AX, @data
	MOV DS, AX
; get and display time
	LEA BX, time_buf	; bx points to time_buf
	CALL get_time		; put current time in time_buf
	LEA DX, time_buf	; dx points to time_buf
	MOV AH, 09h		; display time
	INT 21h
; exit
	MOV AH, 4CH
	INT 21h
main EndP

get_time Proc
; get time of day and store ascii digits in time buffer
; input bx = address of time buffer
	MOV AH, 2CH		; get time
	INT 21h			; ch = hr, cl = min, dh = sec
; convert hr to ascii and store
	MOV AL, CH
	CALL convert
	MOV [BX], Al
	MOV [BX+1], Ah
; convert mm to ascii and store
	MOV AL, CL
	CALL convert
	MOV [BX+3], Al
	MOV [BX+4], Ah
; convert ss to ascii and store
	MOV AL, DH
	CALL convert
	MOV [BX+6], Al
	MOV [BX+7], Ah
	RET
get_time EndP

convert Proc
	MOV AH, 0
	MOV DL, 10
	DIV DL
	OR AX, 3030h
	RET
convert EndP

End main