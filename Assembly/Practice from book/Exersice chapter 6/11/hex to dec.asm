
.MODEL SMALL
.STACK 100H  
.DATA
MSG1 DB 10,13,'ENTER A HEX DIGIT: $'
MSG2 DB 10,13,'IN DECIMAL IT IS : $' 
MSG3 DB 10,13,'DO YOU WANT TO DO IT AGAIN? PRESS Y OT y TO CONTINUE.$' 
MSG4 DB 10,13,'ILLIGAL CHARACTER. ONLY PRESS 0..9 AND A..F.. $'  

MSG5 DB 10,13,'You tried three times and failed.$' 


.CODE
MAIN PROC 
       MOV AX,@DATA
       MOV DS,AX
   
   MOV CL,0
   LOOP:
   MOV AH,9
   LEA DX,MSG1
   INT 21H 
   
   MOV AH,1
   INT 21H
   CMP AL,'1'
   JE PRINT
   
   CMP AL,'2'
     JE PRINT
  CMP AL,'3'
    JE PRINT
   CMP AL,'4'
    JE PRINT
   CMP AL,'5'
    JE PRINT
  CMP AL,'6'
     JE PRINT
    CMP AL,'7'
    JE PRINT
   CMP AL,'8'
    JE PRINT
  CMP AL,'9'
     JE PRINT
    CMP AL,'A'
     JE PRINTSEP
    CMP AL,'B'
     JE PRINTSEP
    CMP AL,'C'
     JE PRINTSEP
    CMP AL,'D'
     JE PRINTSEP
    CMP AL,'E'
    JE PRINTSEP
    CMP AL,'F'
     JE PRINTSEP
   JMP ERROR
   
   
      
   
   
   


    PRINT:
    MOV BL,AL 
    MOV AH,9
    LEA DX,MSG2
    INT 21H 
    MOV AH,2
    MOV DL,BL
    INT 21H 
    JMP PROMOT
    
    PRINTSEP:
    MOV BL,AL 
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    MOV AH,2
    MOV DL,'1'
    INT 21H
    SUB BL,'A'
    ADD BL,'0' 
    MOV AH,2
    MOV DL,BL
    INT 21H 
    JMP PROMOT
    
    PROMOT: 
    
     MOV AH,9
    LEA DX,MSG3
    INT 21H 
    
    MOV AH,1
    INT 21H
    
    CMP AL,'Y'
    JE LOOP
    CMP AL,'y'
    JE LOOP
    
    
    JMP EXIT_
    
    ERROR: 
    
    INC CL 
    CMP CL,3 
    JE EXIT_SEP
    MOV AH,9
    LEA DX,MSG4
    INT 21H 
   
   
    
    JMP LOOP
    
    EXIT_SEP:
    MOV AH,9
    LEA DX,MSG5
    INT 21H 
    
    EXIT_:
    MOV AH,4CH
    INT 21H
  
             
  
   
MAIN ENDP
    END MAIN