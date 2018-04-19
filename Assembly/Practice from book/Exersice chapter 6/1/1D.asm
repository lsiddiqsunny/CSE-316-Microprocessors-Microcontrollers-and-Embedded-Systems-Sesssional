
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AX,1
   MOV BX,2
   MOV CX,3  
   
   CMP AX,BX
   JGE EXIT_
   CMP BX,CX
   JGE CHG
   
   MOV AX,0
   JMP EXIT_
   CHG:
   MOV BX,0
            
            
            
            
     
   EXIT_:
    
   MOV AH,4CH
   INT 21H
             
  
   
MAIN ENDP
    END MAIN
    
    