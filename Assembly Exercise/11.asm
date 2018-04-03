    .MODEL SMALL
    
    
    .DATA
      
    MSG1 DB '**********$'
    
    
    
    .CODE
    
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX 
        
        MOV AH,9
        LEA DX,MSG1
        INT 21H  
        MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
        
          
        MOV AH,9
        LEA DX,MSG1
        INT 21H     
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
            
        MOV AH,9
          LEA DX,MSG1
        INT 21H   
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
           
        MOV AH,9
          LEA DX,MSG1
        INT 21H 
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
            
        MOV AH,9
          LEA DX,MSG1
        INT 21H  
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
           
        MOV AH,9
          LEA DX,MSG1
        INT 21H  
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
           
        MOV AH,9
          LEA DX,MSG1
        INT 21H    
          MOV AH,2              
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
           
        MOV AH,9
          LEA DX,MSG1
        INT 21H   
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
           
        MOV AH,9
          LEA DX,MSG1
        INT 21H 
          MOV AH,2
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H 
            
        MOV AH,9
          LEA DX,MSG1
        INT 21H
                
                    
    MAIN ENDP
    
    END MAIN