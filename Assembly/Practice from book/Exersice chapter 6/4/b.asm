
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AH,1
   INT 21H
   MOV BL,AL
   
   MOV AH,2
   MOV DL,10
   INT 21H
   MOV DL,13
   INT 21H
   
   
   MOV CX,1 
  
   
   TOP:
   
   MOV DL,BL
   INT 21H
   ADD CX,1
   CMP CX,81
   
    JE EXIT_
  
    JMP TOP
    
  
   
   EXIT_:  
  
             
  
   
MAIN ENDP
    END MAIN
    
                          