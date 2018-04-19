
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   MOV AH,1
   INT 21H
   CMP AL,'A'
   JE CRETURN
   CMP AL,'B'
   JE LFEED
   JMP EXIT_
   
   CRETURN:
   MOV AH,2  
   MOV DL,10
   JMP EXIT_
   
   LFEED:
   MOV AH,2
   MOV DL,13
   JMP EXIT_
  
   
   EXIT_:  
   MOV AH,4CH
   INT 21H
             
  
   
MAIN ENDP
    END MAIN
    
                          