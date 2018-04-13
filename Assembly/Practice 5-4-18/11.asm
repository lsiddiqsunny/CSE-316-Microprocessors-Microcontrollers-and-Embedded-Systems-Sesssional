;Input a lowercase character, convert it to uppercase, and show it to the console.

.MODEL SMALL
   
.DATA 
    NUM1 DB ? 
    NUM2 DB ? 
    NUM3 DB ?
    RESULT DB ?
    MSG1 DB 10,13,"ENTER FIRST NUMBER TO ADD : $"
    MSG2 DB 10,13,"ENTER SECOND NUMBER TO ADD : $"  
    MSG3 DB 10,13,"ENTER THIRD NUMBER TO ADD : $"
    MSG4 DB 10,13,"RESULT OF ADDITION IS : $"


.CODE 
 MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H  
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL 
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL  
    
     
    LEA DX,MSG3
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM3,AL 
    
    SUB AL,NUM2
    MOV AH,0   
    
    AAS ;ASCII Adjust after Addition
       
    ADD AL,NUM1  
    
    AAA
    
    ADD AH,30H
    ADD AL,30H
    
     
    
    MOV BX,AX  
    
    LEA DX,MSG4
    MOV AH,9
    INT 21H 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL  
    INT 21H 
    
    MOV AH,4CH
    INT 21H
 MAIN ENDP
    
END MAIN