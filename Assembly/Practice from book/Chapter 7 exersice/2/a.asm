.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       
       MOV AX ,255
       MOV BH,8
       MOV CX,2
       
       LOOP:
       CMP BH,0 
       JE _EXIT
       XOR AX,CX
       SHL CX,2
       
       DEC BH
       JMP LOOP
       
 
      _EXIT:
      MOV AH,4CH
      INT 21H
  
             
  
   
MAIN ENDP
    END MAIN