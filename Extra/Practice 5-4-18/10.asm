;Input a lowercase character, convert it to uppercase, and show it to the console.

.MODEL SMALL

.DATA
      
MSG1 DB 'Enter first number: $'


.CODE

MAIN PROC 
    
     MOV AX,@DATA
     MOV DS,AX 
     
     
     MOV AX,9
     MOV BX,9
     ADD AX,BX  
     
     AAA  
     
     MOV CX,AX
     
     ADD CH,30H
     ADD CL,30H
     
     MOV AH,2
     MOV DL,CH
     INT 21H
     
     MOV DL,CL
     INT 21H 
     
      
    
     
      
             
             
     MOV AH,4CH
     INT 21h
                     
                
MAIN ENDP

END MAIN