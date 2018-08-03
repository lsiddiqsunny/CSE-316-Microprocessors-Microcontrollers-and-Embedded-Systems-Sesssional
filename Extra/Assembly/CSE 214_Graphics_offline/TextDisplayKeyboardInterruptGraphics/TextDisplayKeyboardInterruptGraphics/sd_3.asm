.Model Small
.Stack 100h
.Data
mychar db 20 dup (?)
count db 0
count2 db 0
cur_pos_r db 0CH
cur_pos_c db 27h
.Code
main Proc
	MOV AX, @data
	MOV DS, AX
	LEA DI, mychar
getch:
	MOV AH, 0
	INT 16h
	
	CMP AL, 0
	JE _chk
; store char
	MOV [DI], AL
	INC DI
	INC count2
	JMP getch
_chk:
	MOV byte[DI], '$'
; set video mode
	MOV AH, 0
	MOV AL, 3
	INT 10h
	MOV CX, 0C27h
	MOV DX, 0C27h
	SHR count2, 1
	SUB CH, count2
	SUB CL, count2
	MOV cur_pos_r, CH
	MOV cur_pos_c, CL
	ADD DH, count2
	ADD DL, count2
; clear window to red
	MOV AH, 6	; scroll up function
	;mov cx, 081Ah	; upper left corner (1Ah, 08h)
	;mov dx, 1034h	; lower right corner (34h, 10h)
	MOV BH, 43h	; cyan chars on red background
	MOV AL, 0	; scroll all lines
	INT 10h		; clear window
	
	LEA SI, mychar
_display:
; move cursor
	MOV AH, 2	; move cursor function
	;mov dx, 0C27h	; center of screen
	MOV DH, cur_pos_r
	MOV DL, cur_pos_c
	ADD DH, count
	ADD DL, count
	XOR BH, BH	; page 0
	INT 10h		; move cursor
	
	
; display character with attribute
	MOV AH, 09	; display character function
	MOV BH, 0	; page 0
	MOV BL, 0CBh	; blinking cyan char, red back
	MOV CX, 1	; display one character
	MOV AL, [SI]	; character is 'A'
	INT 10h
	INC SI
	INC count
	CMP byte[SI], '$'
	JNE _display
; move cursor
	MOV AH, 2	; move cursor function
	MOV DX, 1827h	; row 24, col 39
	XOR BH, BH	; page 0
	INT 10h		; move cursor

; dos exit
	MOV AH, 4CH
	INT 21h
main EndP
	End main