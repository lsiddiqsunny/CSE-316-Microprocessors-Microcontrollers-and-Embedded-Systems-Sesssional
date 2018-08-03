.model small
      
.stack 100h      
      
.data      
a db 30
b db 7
ans db 0
   
.code      
main proc  
    mov ax,@data
    mov ds,ax
    mov bl,b                                   
            
    START:
    mov al,a
    sub a,bl 
    cmp a,0
    jng END
    inc ans
    jmp START
    END:    
    
    main endp
end main