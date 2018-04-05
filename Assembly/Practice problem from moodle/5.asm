;Input a lowercase character, convert it to uppercase, and show it to the console.

.MODEL SMALL

.DATA
      
MSG1 DB 'Enter first number: $'


.CODE

MAIN PROC 
    
     MOV AX,@DATA
     MOV DS,AX 
     
     
     MOV CL,48
     
     MOV AH,2
     MOV DL,CL
     INT 21H
     
      
             
             
     MOV AH,4CH
     INT 21h
                     
                
MAIN ENDP

END MAIN