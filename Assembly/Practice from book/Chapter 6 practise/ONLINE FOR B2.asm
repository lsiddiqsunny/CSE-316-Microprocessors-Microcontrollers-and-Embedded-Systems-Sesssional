.MODEL SMALL
.STACK 100H  
.DATA
 
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX    
       
    FIX:
    MOV DX,1
    MOV BX,1
    MOV CX,0 
    
    MOV AH,1
    INT 21H
    
    CMP AL,'X'
    JE _EXIT 
    
    SUB AL,30H
    CMP AL,1
    JE FIX
    CMP AL,2
    JE FIX
    DEC AL
    DEC AL
    
    _LOOP: 
    MOV CX,DX
    ADD DX,BX 
    MOV BX,CX
    DEC AL
    CMP AL,0
    JE FIX
    JMP _LOOP
    
    _EXIT:
    MOV AH,4CH
    INT 21H
  
    MAIN ENDP
END MAIN