.MODEL SMALL
.STACK 100H
.DATA 

A DB 2,3,4,5,6,7,8,9

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA SI,A
    MOV DI,SI
    
    MOV CX,8
    SHR CX,1   
    
    MOV BX,8
    DEC BX    
    
    ADD DI,BX
    XOR AX,AX 
  
    TOP:         ;HERE AL SHOULD BE USED BECAUSE THE ARRAY IS IN BYTE TYPE
    MOV AL,[SI]
    XCHG AL,[DI] 
    MOV DL,[DI]
    MOV [SI],AL
    
    SUB DI,1
    ADD SI,1
    
    LOOP TOP
    
    MOV CX,8
    MOV AH,2
    XOR BX,BX
    P:
     MOV DX,A+BX  
     ADD DX,48
     INT 21H
     
     ADD BX,1
     
     MOV DX,' '
     INT 21H
     
     LOOP P
     
     MOV AH,4CH
     INT 21H
     
     MAIN ENDP
END MAIN