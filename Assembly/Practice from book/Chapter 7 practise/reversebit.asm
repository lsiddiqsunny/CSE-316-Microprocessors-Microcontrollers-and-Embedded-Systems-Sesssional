.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       
       MOV BL,11000011b  
       MOV BH,4
       
       LOOP:
       CMP BH,0 
       JE _EXIT
       ROL BL,1 
       DEC BH
       JMP LOOP
       
 
      _EXIT:
      MOV AH,4CH
      INT 21H
  
             
  
   
MAIN ENDP
    END MAIN