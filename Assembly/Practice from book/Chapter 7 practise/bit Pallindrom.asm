.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       
       MOV BL,11000011b
       MOV CL,1
       SHL CL,7
       MOV CH,1
       
       MOV BH,4 
       
       LOOP:
       CMP BH,0 
       JE _EXIT
       TEST BL,CL
       JZ ZERO
       JMP ONE
       
       OK: 
       DEC BH
       SHL CH,1
       JMP LOOP
       
       ZERO:
       SHR CL,1
       TEST BL,CH
       JZ OK
       JMP _EXIT 
       
       ONE:
       SHR CL,1
       TEST BL,CH
       JNZ OK
       JMP _EXIT
       
      _EXIT: 
      
      CMP BH,0
      JE PRINTYES
   MOV AH,2
   MOV DL,'N'
   INT 21H 
   JMP _EXT
   PRINTYES:
      MOV AH,2
   MOV DL,'Y'
   INT 21H 
   _EXT:
 
     MOV AH,4CH
     INT 21H
  
             
  
   
MAIN ENDP
    END MAIN