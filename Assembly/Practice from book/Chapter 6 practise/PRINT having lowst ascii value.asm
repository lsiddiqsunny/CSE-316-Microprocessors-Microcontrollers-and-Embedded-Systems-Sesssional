TITLE PRINT having lowst ascii value
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC  
    
   MOV AH,2
   MOV BL,'a'
   MOV CL,'A'
   
   CMP BL,CL
   JNBE PRINT_C
   MOV DL,BL
   JMP DISP
   
   
   PRINT_C:
   MOV DL,CL
   

   
   
   DISP:
   INT 21H
   
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN
    
    