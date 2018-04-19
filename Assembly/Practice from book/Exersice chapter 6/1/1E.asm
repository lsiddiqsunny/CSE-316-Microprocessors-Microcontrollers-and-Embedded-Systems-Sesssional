
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AX,3
   MOV BX,2
   MOV CX,1  
   
  CMP AX,BX
  JL CHG 
  CMP BX,CX
  JL CHG
  JMP NCHG
            
            
   
   CHG:  
   MOV DX,0 
   JMP EXIT_ 
   
  
   NCHG:  
   MOV DX,1 
   
   
   EXIT_:  
   MOV AH,4CH
   INT 21H
             
  
   
MAIN ENDP
    END MAIN
    
                          