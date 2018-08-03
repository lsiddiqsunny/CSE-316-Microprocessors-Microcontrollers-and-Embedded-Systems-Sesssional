.model small

.stack 100h

.data
a dw 2
b db 2                                                 
sum db 0
    
.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov cx,a
    mov bl,b
    
    Top:
    add sum,bl
    loop Top
               
    mov dl,sum
    mov ah,2 
    int 21h    
        
    mov ah,4ch 
    int 21h
    main endp ;last line of program

;others procedurews will be inserted here

end main ;last line of code