;Input a lowercase character, convert it to uppercase, and show it to the console.

.MODEL SMALL

.DATA
      
MSG1 DB 'Input a uppercase character:$'
MSG2 DB 'The converted lowercase character is: $'
    


.CODE

MAIN PROC 
    
     MOV AX,@DATA
     MOV DS,AX 
     ;Showing promot   
     MOV AH,9
     LEA DX,MSG1
     INT 21H  
     
     ;Input the number and convert and kept in BL 
    MOV AH,1
    INT 21H 
    MOV BL, AL 
    ADD BL,20h
               
     ;Print new line          
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H   
     
     ;Showing output promot
      MOV AH,9
     LEA DX,MSG1
     INT 21H  
     
        ;Output
    MOV AH, 2 
    MOV DL,BL
    INT 21h  
             
             
    MOV AH,4CH
    INT 21h
                     
                
MAIN ENDP

END MAIN