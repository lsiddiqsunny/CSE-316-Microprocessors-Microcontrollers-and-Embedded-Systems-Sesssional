TITLE Compare two signed number
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC  
    MOV AX,-100H
    MOV BX,00H
    MOV CX,AX ;AX MOVES TO CX 
    CMP BX,CX
    JLE NEXT
    MOV CX,BX
    NEXT:
    
 
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN
    
    