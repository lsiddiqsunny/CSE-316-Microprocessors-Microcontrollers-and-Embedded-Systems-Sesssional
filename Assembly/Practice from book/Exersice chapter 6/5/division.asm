
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
    MOV CX,0
    MOV AX,12
    MOV BX,3
    
    TOP: 
    
    CMP AX,BX
    JL EXIT_
    
    INC CX
    SUB AX,BX
    JMP TOP
              
              
   


   
    EXIT_:
    MOV AH,4CH
    INT 21H
  
             
  
   
MAIN ENDP
    END MAIN
    
                          