.MODEL SMALL
.STACK 100H 
.DATA   

ARRAY DW 16 DUP(?)   
MASK DW 0
MSG1 DB "Enter Input Array: $" 
MSG2 DB "Enter n: $"  
MSG3 DB " was not found in the array$"
MSG4 DB " was found in the array$"      
MSG5 DB 10,13,"Thanks!!!$"
.CODE
     MAIN PROC  
    
     MOV AX,@DATA
     MOV DS,AX
     MOV AH,9
     LEA DX,MSG1
     INT 21H
     
     DEC MASK
     DEC MASK  
     
     MOV CX,0
     MOV SI,0
     
     TOP1:
     CALL INDEC 
     CMP AL,'X'
     JE _NEXT
     MOV ARRAY[SI],AX
     ADD SI,2 
     INC CX
     JMP TOP1
     
     _NEXT:
     MOV BX,CX
     LEA SI,ARRAY 
     CALL SELECT  
     
     
     MOV AH,2
     PUSH DX
     MOV DL,10
     INT 21H
     MOV DL,13
     INT 21H
     POP DX
     
    

     TOP2: 
     MOV AH,9
     PUSH DX
     LEA DX,MSG2
     INT 21H
     POP DX
     CALL INDEC 
     CMP AL,'X'
     JE _NEXT2
     PUSH AX 
     
     MOV AH,2
     PUSH DX
     MOV DL,10
     INT 21H
     MOV DL,13
     INT 21H
     POP DX 
     POP AX
     
     XCHG CX,AX
     
     LEA SI,ARRAY 
     CALL BSEARCH
     MOV CX,AX
     MOV AH,2
     PUSH DX
     MOV DL,10
     INT 21H
     MOV DL,13
     INT 21H
     POP DX
     
     JMP TOP2
     
       
     _NEXT2: 
        MOV AH,9
        LEA DX,MSG5
        INT 21H
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
             PUSH AX
             PUSH BX
             PUSH CX
             PUSH DX
             PUSH SI
              
              DEC AX       
              MOV DX,0 
              MOV BX,2
              MUL BX
              
              
              SEARCH:
              CMP DX,AX
              JG FINISH0_
              MOV BX,DX 
              ADD BX,AX 
              
              SHR BX, 1
              AND BX,MASK
              
              
              CMP CX,[SI+BX] 
              JE FINISH0_
              JG BIG
              JMP LESS
              BIG:  
              MOV DX,BX
              ADD DX,2
              JMP SEARCH
              
              LESS: 
              MOV AX,BX
              SUB AX,2
              JMP SEARCH
              
               FINISH0_: 
               PUSH AX
               MOV AX,CX
               CALL OUTDEC 
               POP AX
               CMP DX,AX  
               JG PRINTNOT_
               
             
              PRINT_:
              PUSH AX
              PUSH DX
              MOV AH,9
              LEA DX,MSG4
              INT 21H
              POP AX
              POP DX 
                      
                  JMP FINISH_    
              PRINTNOT_:
              
                    PUSH AX
              PUSH DX
              MOV AH,9
              LEA DX,MSG3
              INT 21H
              POP AX
              POP DX 
             
             
              
              FINISH_:
              POP SI 
              POP DX
              POP CX
              POP BX 
              POP AX
              RET
        
        BSEARCH ENDP    
        
        
     
     
END MAIN