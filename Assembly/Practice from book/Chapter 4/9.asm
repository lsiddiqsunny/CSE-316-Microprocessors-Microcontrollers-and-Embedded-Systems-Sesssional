.MODEL SMALL


.DATA


MSG1 DB 'ENTER THREE INITIALS: $'

VAR1 DB '?'
VAR2 DB '?'
VAR3 DB '?'


.CODE

MAIN PROC
     MOV AX,@DATA
     MOV DS,AX
       
     MOV AH,9
     LEA DX,MSG1
     INT 21h  
     
     MOV AH,1
     INT 21h
     MOV VAR1,AL 
     
     INT 21h
     MOV VAR2,AL 
     
     INT 21h
     MOV VAR3,AL 
     
     
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H
     
     MOV AH,2
     MOV DL,VAR1
     INT 21h 
     
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H
     
     MOV DL,VAR2
     INT 21h
     
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H
     
     MOV DL,VAR3
     INT 21h
     
     
     MOV AH,4CH
     INT 21H
            
                
MAIN ENDP

END MAIN