.model small

.stack 100h

.data
a dw 100
b dw 105
.code

main proc
    
    mov ax,@data
    mov ds,ax   
           
    mov bx,b         
    cmp a,bx
    jg SKIP
    xchg a,bx
    mov b,bx
    SKIP:        
    add bx,1
    
    TOP:       
    dec bx
    cmp bx,0
    jz END_LOOP
    mov ax,a
    div bl
    cmp ah,0
    jnz TOP
    mov ax,b
    div bl
    cmp ah,0            
    jnz TOP  
    END_LOOP:
            
    main endp

end main