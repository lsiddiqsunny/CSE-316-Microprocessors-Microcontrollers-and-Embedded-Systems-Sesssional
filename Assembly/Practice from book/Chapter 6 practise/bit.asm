.MODEL SMALL
.STACK 100H  
.DATA
 
 NUM1 DB ?
 NUM2 DB ?
 

.CODE
MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX 
        MOV NUM1,0   
       
         MOV AH,1
         INT 21H  
         SUB AL,30H
         MOV CH,AL
         
         MOV BL,8 
         MOV CL,1 
         SHL CL,7 
         
         MOV AH,2
         MOV DL,':'
         INT 21H
         
         _LOOP:
         
         TEST CH, CL
         JZ _PRINT0
         JMP _PRINT1
         
         _TECH:
         
         DEC BL
         CMP BL,0
         JE _NEXT
         SHR CL,1 
         JMP _LOOP
         
         
         _PRINT0:
         MOV AH,2
         MOV DL,'0'
         INT 21H
         JMP _TECH
         
         _PRINT1:
         MOV AH,2
         MOV DL,'1'
         INT 21H 
         INC NUM1
         JMP _TECH  

             
  
   
MAIN ENDP
    END MAIN