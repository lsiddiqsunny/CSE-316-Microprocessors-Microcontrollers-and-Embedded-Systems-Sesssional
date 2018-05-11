;Store a number, x in the register CL (i.e., directly in the code). Show the character in the console of which the ASCII value is x.
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