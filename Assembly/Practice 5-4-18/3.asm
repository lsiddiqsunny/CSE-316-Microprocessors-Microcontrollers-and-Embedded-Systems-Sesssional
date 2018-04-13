;swapping two number without intermediate registers.

.MODEL SMALL

.DATA
      
MSG1 DB 'Enter first number: $'
MSG2 DB 'Enter second number: $'
MSG3 DB 'You have entered: $'    
MSG4 DB 'After swaping: $' 

.CODE

MAIN PROC 
    
     MOV AX,@DATA
     MOV DS,AX 
     ;Showing promot   
     MOV AH,9
     LEA DX,MSG1
     INT 21H  
     
     ;Input the first number 
     MOV AH,1
     INT 21H 
     MOV CH, AL 

               
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H    
     
     
     
     ;Showing promot   
     MOV AH,9
     LEA DX,MSG2
     INT 21H  
     
     ;Input the seocnd number 
     MOV AH,1
     INT 21H 
     MOV CL, AL 

               
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H   
     
     ;Showing output promot before swap
     MOV AH,9
     LEA DX,MSG3
     INT 21H  
     
     ;Output
     MOV AH, 2 
     MOV DL,CH
     INT 21h 
     
     MOV DL,' '
     INT 21h  
     
     MOV DL,CL
     INT 21h 
     
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H    
             
     XCHG CH,CL      
     ;Showing output promot after swap
     MOV AH,9
     LEA DX,MSG4
     INT 21H  
     
     ;Output
     MOV AH, 2 
     MOV DL,CH
     INT 21h 
     
     MOV DL,' '
     INT 21h  
     
     MOV DL,CL
     INT 21h 
     
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H    
             
     
      
             
             
     MOV AH,4CH
     INT 21h
                     
                
MAIN ENDP

END MAIN