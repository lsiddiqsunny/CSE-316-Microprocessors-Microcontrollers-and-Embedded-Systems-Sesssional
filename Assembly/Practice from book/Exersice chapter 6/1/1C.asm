
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    MOV AH,2 
    MOV DL,'C'
    
    CMP DL,'A'
    JB EXIT_
    CMP DL,'Z'
    JNBE EXIT_ 
    INT 21H
    
    
    
    
    
    EXIT_:
    
    MOV AH,4CH
    INT 21H
    
  
  
   
MAIN ENDP
    END MAIN
    
    