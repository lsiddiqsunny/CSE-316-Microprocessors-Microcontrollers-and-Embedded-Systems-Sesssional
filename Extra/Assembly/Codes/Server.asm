.model small

.stack 100h

.data
d db ?
s db ?    
i db ?      

.code

main proc
    mov ax,@data
    mov ds,ax
             
    mov ah,1
    int 21h                
    sub al,30h
    mov d,al          
                      
    mov ah,1
    int 21h   
    sub al,30h
    mov s,al          
    
    mov dh,0FFh
    
    dec d     
    mov dl,s     
    mov i,dl  
    mov bh,0
    FIRST_INNER_TOP:
    dec i
    cmp i,0
    jl END_FIRST_INNER
    mov ah,1
    int 21h  
    cmp al,35h
    jl FIRST_INNER_TOP
    mov dl,1
    mov cl,i
    shl dl,cl  
    or bh,dl    
    jmp FIRST_INNER_TOP
    END_FIRST_INNER:
    
    OUTER_TOP:
    dec d
    cmp d,0
    jl END_OUTER    
    mov dl,s
    mov i,dl  
    mov bl,0
    INNER_TOP:
    dec i
    cmp i,0
    jl END_INNER
    mov ah,1
    int 21h  
    cmp al,35h
    jl INNER_TOP
    mov dl,1
    mov cl,i
    shl dl,cl  
    or bl,dl    
    jmp INNER_TOP
    END_INNER:
    mov dl,bh
    xor dl,bl
    and dh,dl
    mov bh,bl 
    jmp OUTER_TOP
    END_OUTER:
        
    mov d,0   
    mov dl,s   
    mov i,dl
    RESULT_TOP:
    dec i
    cmp i,0       
    jl END_RESULT 
    shr dh,1
    jnc RESULT_TOP
    add d,1
    jmp RESULT_TOP
    END_RESULT:
    
    mov dl,d     
    add dl,30h
    mov ah,2         
    int 21h  
          
    mov ah,4ch 
    int 21h  
    main endp

end main