.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       MOV DX,100H
       MOV BX,1000H
       XOR BX,BX
      MOV AH,4CH
      INT 21H
  
             
  
   
MAIN ENDP
    END MAIN