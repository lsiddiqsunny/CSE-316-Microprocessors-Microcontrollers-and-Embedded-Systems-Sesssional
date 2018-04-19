
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AX,0
   
   MOV CX,100
   
   TOP:
    ADD AX,CX  
    CMP CX,5
    JE EXIT_
    SUB CX,5 
    JMP TOP
    
  
   
   EXIT_:  
  
             
  
   
MAIN ENDP
    END MAIN
    
                  