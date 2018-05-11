.MODEL SMALL
.STACK 100H 
.DATA 
.CODE
     MAIN PROC  
    
     MOV AX,@DATA
     MOV DS,AX 
    
    
     CALL INDEC 
     CALL OUTDEC
     
     
     MOV AH,4CH
     INT 21H
     MAIN ENDP  
     
     INDEC PROC
        PUSH BX
        PUSH CX
        PUSH DX
        MOV BX,0
        MOV CX,0
        MOV AH,1
        INT 21H
        CMP AL,'-'
        JE MINUS 
        CMP AL,'X'
        JE EXIT_
        JMP TOP
        
        MINUS:
        MOV CX,1
        INT 21H
        JMP TOP
        
        TOP:
        SUB AX,30H 
        MOV AH,0
        PUSH AX
        MOV AX,10
        MUL BX   
        POP BX
        ADD BX,AX
        
        MOV AH,1
        INT 21H
        CMP AL,' '
        JNE TOP
        MOV AX,BX
        
        OR CX,CX
        JZ EXIT_
        NEG AX
        
        EXIT_:  
        POP DX
        POP CX
        POP BX
        RET
      INDEC ENDP  
     
       OUTDEC PROC   
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX 
        CMP AX,0
        JGE BEGIN
        PUSH AX
        MOV DL,'-'
        MOV AH,2
        INT 21H
        POP AX
        NEG AX
        
        BEGIN:
        XOR CX,CX
        MOV BX,10
        
        REPEAT:
        XOR DX,DX
        DIV BX
        PUSH DX
        INC CX
        OR AX,AX
        JNE REPEAT
        MOV AH,2
        
        PRINT_LOOP:
        POP DX
        ADD DL,30H
        INT 21H
        LOOP PRINT_LOOP
        
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        OUTDEC ENDP
        
        
     
     
END MAIN