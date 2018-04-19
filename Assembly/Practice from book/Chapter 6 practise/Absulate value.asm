TITLE Absulate value
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC  
    
    MOV BX,-2
    
    CMP BX,0
    JNL EXIT_

    NEG BX
    
 
 
    
    EXIT_:
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN
    
    