.MODEL SMALL


.DATA

MSG DB 'INPUT A CHARACTER: $'
MSG2 DB 'You entered: $'


.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    
    LEA DX, MSG
    MOV AH,9
    INT 21h   
    
    
    MOV AH,1
    INT 21h
    
    MOV BL, AL
    
    MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    
    LEA DX, MSG2
    MOV AH,9
    INT 21h
    
    MOV DL, BL
    MOV AH, 2
    INT 21h
    
    
    MOV AH,4Ch
    INT 21h
    
MAIN ENDP

END MAIN