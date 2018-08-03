.MODEL SMALL
.STACK 100H
.DATA

A DW 0

MS1 DB ' NOT A PALINDROME.$'
MS2 DB ' PALINDROME.$'
MS3 DB ' OVERFLOW. NO PALINDROME FOUND.$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
   
    CALL INPUT_DEC 
    
    CALL PAL_TEST
    
    MOV AH,4CH    ;EXIT TO DOS
    INT 21H 
    
    MAIN ENDP

NEWLINE PROC
    ;INPUT :NONE
    ;OUTPUT:NONE
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX 
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET  
    
NEWLINE ENDP
    

OUTPUT_DEC PROC
    ;INPUT: AX
    ;OUTPUT: NONE
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    OR AX,AX
    JGE @END_IF
    PUSH AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX
    NEG AX  
    @END_IF:
        XOR CX,CX ;DIGIT COUNT
        MOV BX,10
    @REPEAT1:
        XOR DX,DX
        DIV BX
        PUSH DX
        INC CX
        OR AX,AX
        JNE @REPEAT1
        
        MOV AH,2
    @PRINT:
        POP DX
        OR DL,30H
        INT 21H
        LOOP @PRINT       
    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTPUT_DEC ENDP        
        
        
INPUT_DEC PROC
    ;OUTPUT: AX = BINARY EQUIVALENT OF NUMBER
    
    PUSH BX
    PUSH CX
    PUSH DX
    
    @BEGIN:
        MOV AH,2
        MOV DL, '?'
        INT 21H
    
        XOR BX,BX
        XOR CX,CX
        
        MOV AH,1
        INT 21H
        
        CMP AL,'-'
        JE @MINUS
        
        CMP AL,'+'
        JE @PLUS
        
        JMP @REPEAT2
       
     @MINUS:
        MOV CX,1       ; HOLD SIGN 
           
     @PLUS:
        INT 21H
        
     @REPEAT2:
        CMP AL,'0'
        JNGE @NOT_DIGIT
        CMP AL,'9'
        JNLE @NOT_DIGIT
        
        AND AX, 000FH ; CONVERT TO DIGIT
        PUSH AX
        
        MOV AX,10    ;APPLYING ALGO BX=BX*10+AX (INPUT DIGIT)
        MUL BX
        POP BX
        ADD BX,AX
        
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JNE @REPEAT2
        
        MOV AX,BX
        
        OR CX,CX 
        JE @EXIT
        NEG AX
        
     @EXIT:
        POP DX
        POP CX
        POP BX
        
        RET
        
     @NOT_DIGIT:
        MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H
        JMP @BEGIN
 INPUT_DEC ENDP
        
 REV_NUM PROC
    ;INPUT: AX         
    ;OUTPUT: BX (REVERSE OF AX)
    
    PUSH AX
    PUSH CX
    PUSH DX
    
    MOV A,10
    MOV BX,0      
    
    @REPEAT3:
        XOR DX,DX
        DIV A
 
        PUSH AX 
        PUSH DX
        
        MOV AX,10
        MUL BX
        MOV BX,AX
       
        POP DX 
        POP AX
       
        ADD BX,DX  
        
        CMP BX,0
        JL EXIT3  
        
        OR AX,AX
        JNE @REPEAT3 
        JMP TO  
        
        EXIT3:   
         CALL NEWLINE
         LEA DX,MS3
         MOV AH,9
         INT 21H 
          
         MOV AH,4CH
         INT 21H  
    TO:        
    POP DX
    POP CX
    POP AX
    RET      
 REV_NUM ENDP   
 
 PAL_TEST PROC  
    ; INPUT : AX,BX
    ; OUTPUT: NONE
     
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
     
    TOP: 
        CALL NEWLINE    
        CALL NEWLINE
        CALL OUTPUT_DEC
        CALL REV_NUM
        CALL NEWLINE 
     
        PUSH AX
        MOV AX,BX
        CALL OUTPUT_DEC
        POP AX  
      
        CALL NEWLINE
    
    CHECK:
         CMP AX,BX
         JE JUMP
         
         PUSH AX
         LEA DX,MS1
         MOV AH,9
         INT 21H 
         POP AX
          
         ADD AX,BX
         JO EXIT2
         JMP TOP
    
    JMP EXIT
    
    JUMP:
        LEA DX,MS2
        MOV AH,9
        INT 21H  
        JMP EXIT
    EXIT2:   
        CALL NEWLINE
        LEA DX,MS3
        MOV AH,9
        INT 21H     
    EXIT:   
    POP DX
    POP CX
    POP BX
    POP AX
    RET  

END MAIN