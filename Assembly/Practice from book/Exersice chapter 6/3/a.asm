
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AX,0
   
   MOV CX,1
   
   TOP:
    ADD AX,CX  
    CMP CX,148
    JE EXIT_
    ADD CX,3 
    JMP TOP
    
  
   
   EXIT_:  
  
             
  
   
MAIN ENDP
    END MAIN
    
                          