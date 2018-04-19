TITLE Findpout sign
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    
    MOV AX,5
    
    CMP AX,0
    JL NEGATIVE
    JE ZERO
    JG POSITIVE
    NEGATIVE:
    MOV BX,-1
   JMP END_CASE
    
    POSITIVE:
    MOV BX,1
   JMP END_CASE
    
    ZERO:
    MOV BX,0
  
    
  
  
  
  END_CASE:
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN
    
    