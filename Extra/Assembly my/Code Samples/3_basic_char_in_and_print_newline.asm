.MODEL SMALL


.DATA


.CODE

MAIN PROC
    MOV DL, '?'
    MOV AH, 2
    INT 21h
                
    
    MOV AH,1
    INT 21h  
    
    MOV BL, AL 
    
    MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    
    MOV DL, BL
    MOV AH, 2
    INT 21h            
                
MAIN ENDP

END MAIN