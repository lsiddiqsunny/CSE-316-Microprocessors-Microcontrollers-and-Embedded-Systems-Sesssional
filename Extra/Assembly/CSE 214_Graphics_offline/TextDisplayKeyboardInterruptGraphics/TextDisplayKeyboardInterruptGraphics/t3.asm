.Model Small
.Stack 100h
.Code
main Proc
; set EGA 640x200 high res mode
	MOV AX, 0Eh
	INT 10h

; draw 16 color band	
	MOV AH, 0CH ; write pixel function
	MOV AL, 0 ; start pixel color 0
	MOV BH, 0 ; page 0
	MOV DX, 50 ; row
OL1:	MOV CX, 192 ; col
	XOR SI, SI
L1:	INT 10h
	INC SI	
	CMP SI, 16
	JL col
	INC AL ; next color
	XOR SI, SI
col:	INC CX	; next col
	CMP CX, 448
	JL L1
	INC DX; next row
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
