.Model Small
.Stack 100h
.Code
main Proc
; set CGA 320x200 medium res mode
	MOV AX, 4
	INT 10h

; draw palette 0 color band
	MOV AH, 0BH
	MOV BH, 1
	MOV BL, 0
	INT 10h	
	MOV AH, 0CH ; write pixel function
	MOV AL, 0 ; start pixel color 0
	MOV BH, 0 ; page 0
	MOV DX, 50 ; row
OL1:	MOV CX, 96 ; col
	XOR SI, SI
L1:	INT 10h
	INC SI	
	CMP SI, 16
	JL col
	INC AL ; next color
	XOR SI, SI
	CMP AL, 4
	JL col
	
	XOR AL, AL
	PUSH AX
	MOV AH, 0 
	INT 16h
	PUSH BX
	MOV AH, 0BH
	MOV BH, 1
	MOV BL, 1
	INT 10h
	POP BX
	POP AX
col:	INC CX	; next col
	CMP CX, 224
	JL L1
	INC DX; next row
	PUSH AX
	PUSH BX
	MOV AH, 0BH
	MOV BH, 1
	MOV BL, 0
	INT 10h
	POP BX
	POP AX
	CMP DX, 151
	JL OL1
; getch    	
    	MOV AH, 0
    	INT 16h
; return to text mode    	
    	MOV AX, 3
    	INT 10h
; return to DOS
    	MOV AH, 4CH
    	INT 21h
main EndP
     End main
