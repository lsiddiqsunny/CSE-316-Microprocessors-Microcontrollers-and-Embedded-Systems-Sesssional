
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    MOV CX,0
    MOV AX,5
    MOV BX,3
    
    TOP: 
    
    ADD CX,AX
    DEC BX
    
    CMP BX,0
    JE EXIT_
    JMP TOP 
              
   


   
    EXIT_:
    MOV AH,4CH
    INT 21H
  
             
  
   
MAIN ENDP
    END MAIN
    
                          