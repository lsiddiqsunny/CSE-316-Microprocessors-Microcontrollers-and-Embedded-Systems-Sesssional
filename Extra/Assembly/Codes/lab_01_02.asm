.model small

.stack 100h

.data                   
msg db 'hello$'
    
.code

main proc
    mov ax,@data
    mov ds,ax ;ds can't take the address data segment directly. convensionally ax is used
               
    mov ah,9
    lea dx,msg                                                            
    int 21h                                                               
    
    mov ah,4ch
    int 21h
    
    main endp ;last line of program

;others procedurews will be inserted here

end main ;last line of code