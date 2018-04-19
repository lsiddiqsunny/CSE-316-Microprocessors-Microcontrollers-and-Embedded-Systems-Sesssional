.MODEL SMALL


.DATA


.CODE

MAIN PROC
   
    MOV AH,1
    INT 21H 
    MOV DL, AL
    MOV AH, 2
    INT 21h            
                
MAIN ENDP

END MAIN