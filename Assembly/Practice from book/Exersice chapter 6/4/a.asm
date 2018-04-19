
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV CX,0
   
   MOV BX,1 
   MOV DX,1
   
   TOP:
   
   ADD CX,BX
   ADD BX,4 
   ADD DX,1
   CMP DX,51
   
    JE EXIT_
  
    JMP TOP
    
  
   
   EXIT_:  
  
             
  
   
MAIN ENDP
    END MAIN
    
                   