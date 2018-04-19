
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
   
   
   MOV CL,80H
   MOV BL,0
   MOV AH,2
   
   LOOP: 
   MOV DL,CL
   INT 21H
   INC CL 
   INC BL
   CMP CL,255
   JE EXIT_  
   CMP BL,10
   JNE LOOP
   MOV DL,10
   INT 21H
   MOV DL,13
   INT 21H 
   MOV BL,0
   JMP LOOP       
           
   


    
    
    EXIT_:
    MOV AH,4CH
    INT 21H
  
             
  
   
MAIN ENDP
    END MAIN