.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       
       MOV BL ,0h
       MOV BH,10000001b
       OR BL,BH
      MOV AH,4CH
      INT 21H
  
             
  
   
MAIN ENDP
    END MAIN