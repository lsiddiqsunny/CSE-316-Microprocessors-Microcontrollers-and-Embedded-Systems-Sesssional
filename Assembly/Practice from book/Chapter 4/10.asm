.MODEL SMALL


.DATA
  
MSG1 DB 'ENTER A HEX DIGIT: $'
MSG2 DB 'IN DECIMAL IT IS 1$'



.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AH,1
    INT 21H
    
    MOV BL,AL
    SUB BL,'A'
    ADD BL,'0'
               
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
    
     
    MOV AH,9
    LEA DX,MSG2
    INT 21H 
    
               
    MOV AH,2
    MOV DL,BL
    INT 21H
   
     MOV AH,4CH
     INT 21
            
                
MAIN ENDP

END MAIN