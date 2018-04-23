.MODEL SMALL
.STACK 100H  
.DATA
 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX 
       
       MOV DL,'a'
       AND DL,0DFH
       MOV AH,2
       INT 21H
   
 
    MOV AH,4CH
    INT 21H
  
             
  
   
MAIN ENDP
    END MAIN