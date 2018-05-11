.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    MOV CX,0  
    MOV AH,1
    INT 21H
    WHILE_:
    CMP AL,13
    JE END_WHILE
    PUSH AX
    INC CX
    INT 21H
    JMP WHILE_   
    
    END_WHILE:   
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    JCXZ END_  
    TOP:
    POP DX
    INT 21H
    DEC CX
    JZ END_
    JMP TOP
    
    
    
    
    END_:
    MOV AH,4CH
    INT 21H
    
  
    
MAIN ENDP
END MAIN