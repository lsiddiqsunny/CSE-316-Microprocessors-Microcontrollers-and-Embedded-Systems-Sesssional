.model small

.stack 100h

.data                                                 
    
.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,1 
    int 21h           
    
    add al,20H
    
    mov dl,al
    mov ah,2 
    int 21h           
    
    mov ah,4ch 
    int 21h
    main endp

end main ;last line of code    