.MODEL SMALL
.STACK 100H 
.DATA   

ARRAY DW 5 DUP(?)

.CODE
     MAIN PROC  
    
     MOV AX,@DATA
     MOV DS,AX  
     
     MOV CX,5 
     MOV SI,0
     
     TOP1:
     CALL INDEC 
     MOV ARRAY[SI],AX
     ADD SI,2
     LOOP TOP1
     
     MOV BX,5
     LEA SI,ARRAY 
     CALL SELECT
     
     MOV BX,5 
     MOV CX,10
     CALL BSEARCH
     
     MOV CX,5   
     
     TOP2:
     MOV AX,[SI]
     CALL OUTDEC
     ADD SI,2  
     MOV AH,2
     MOV DL,' '
     INT 21H
     LOOP TOP2
     
     
     
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
       
       SELECT PROC 
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        DEC BX
        JZ END_SORT 
        MOV DX,SI
        
        SORT_LOOP:
        MOV SI,DX
        MOV CX,BX
        MOV DI,SI
        MOV AX,[DI] 
        FIND_BIG:
        ADD SI,2
        CMP [SI],AX
        JNG NEXT
        MOV DI,SI
        MOV AX,[DI]
        NEXT:
        LOOP FIND_BIG
        CALL SWAP
        DEC BX
        JNZ SORT_LOOP
        
        END_SORT: 
        POP SI 
        POP DX
        POP CX
        POP BX 
       
        RET
        
        
       SELECT ENDP   
        SWAP PROC    
            
            PUSH AX
            MOV AX,[SI]
            XCHG AX,[DI]
            MOV [SI],AX
            POP AX
            RET
        
        SWAP ENDP 
        
        BSEARCH PROC 
             PUSH BX
             PUSH CX
             PUSH DX
             PUSH SI 
             
             MOV DX,0
             MOV AX,2 
             DEC BX
             MUL BX 
             
             
             _WHILE:
             CMP DX,AX
             JG FINISH_ 
             PUSH DX
             ADD DX,AX
             SHR DX,1 
             PUSH SI
             ADD SI,DX
             CMP CX,[SI]
             JE FINISH_
             JG BIG
             JL LESS
             BIG:
               POP SI
             POP BX 
            
             JMP _WHILE
             
             LESS: 
              
             MOV AX,DX 
              POP SI
             POP DX 
             JMP _WHILE
              
              FINISH_:
              POP SI 
              POP DX
              POP CX
              POP BX 
              RET
        
        BSEARCH ENDP    
        
        
     
     
END MAIN