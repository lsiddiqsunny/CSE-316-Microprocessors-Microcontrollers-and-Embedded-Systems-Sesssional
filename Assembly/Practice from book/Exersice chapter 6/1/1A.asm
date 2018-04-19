
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    
    MOV AX,-5 
    MOV BX,0  
    
    CMP AX,0
    JLE CND 
    JMP EXIT_
    CND:
    MOV BX,-1
  
    EXIT_:
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN
    
    