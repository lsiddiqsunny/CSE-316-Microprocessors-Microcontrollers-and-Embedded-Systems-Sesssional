
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AX,3
   MOV BX,2
   MOV CX,1  
   
  CMP AX,BX
  JL CHG1 
  CMP BX,CX
  JL CHG2
  
  CMP BX,CX
  
  JNL CHG3
  JMP NCHG          
            
   
   CHG1:  
   MOV AX,0 
   JMP EXIT_ 
   
   CHG2:  
   MOV BX,0 
   JMP EXIT_
    CHG3:  
   MOV CX,0 
   JMP EXIT_
  
   NCHG:  
   MOV DX,1 
   
   
   EXIT_:  
   MOV AH,4CH
   INT 21H
             
  
   
MAIN ENDP
    END MAIN
    
                          