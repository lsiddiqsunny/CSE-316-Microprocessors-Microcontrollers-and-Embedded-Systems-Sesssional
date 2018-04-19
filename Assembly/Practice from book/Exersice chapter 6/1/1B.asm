
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    
    MOV AL,-5 
    MOV AH,0h 
    
    CMP AL,0
    JL CND 
    JMP EXIT_
    CND: 
    
    MOV AH,1
    NEG AH
  
    EXIT_:
   
MAIN ENDP
    END MAIN
    
    