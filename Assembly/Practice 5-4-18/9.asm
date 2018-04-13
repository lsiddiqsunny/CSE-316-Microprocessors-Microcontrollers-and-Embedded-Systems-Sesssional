;Sum two numbers

.MODEL SMALL

.DATA
      
MSG1 DB 'Enter first number: $'
MSG2 DB 'Enter second number: $'  
MSG3 DB 'Enter third number: $'
MSG4 DB 'Result: $'    


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
     SUB AL,30h
     MOV CL, AL 

               
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
     SUB AL,30h
     ADD CL, AL 

               
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H  
     
       
      ;Showing promot   
     MOV AH,9
     LEA DX,MSG3
     INT 21H    
     ;Input the third number
   
     MOV AH,1
     INT 21H  
     SUB AL,30h
     ADD CL, AL 
   MOV AH,4CH
     INT 21h
                     
                
MAIN ENDP

END MAIN