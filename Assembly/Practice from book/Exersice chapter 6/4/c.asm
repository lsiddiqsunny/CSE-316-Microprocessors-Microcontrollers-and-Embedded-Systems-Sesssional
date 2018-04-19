
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
  
   
   MOV CX,1 
  
   
   TOP:   
   MOV AH,1
   INT 21H
   
  
   ADD CX,1
   CMP CX,6
   
    JE NEW
  
    JMP TOP
    
  
   
   NEW:  
   
   MOV CX,1 
   MOV AH,2
   MOV DL,10
   INT 21H
   MOV DL,13
   INT 21H
   TOP2: 
   
    MOV AH,2
    MOV DL,'X'
   INT 21H
   
  
   ADD CX,1
   CMP CX,6
   
    JE EXIT_
  
    JMP TOP2
    
    EXIT_:
    
   
   
  
             
  
   
MAIN ENDP
    END MAIN
    
                          