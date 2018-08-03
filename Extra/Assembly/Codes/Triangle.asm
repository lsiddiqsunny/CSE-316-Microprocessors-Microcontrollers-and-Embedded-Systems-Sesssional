.model small

.stack 100h

.data

n dw 10

.code

main proc
    
    mov ax, @data
    mov ds, ax
    
    OuterLoop:
    mov cx, n
    
    InnerLoop:
    mov ah, 2
    mov dl, '*'
    int 21h
    loop InnerLoop
    
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    dec n
    cmp n, 0
    jnz OuterLoop
    
    mov ah, 4ch
    int 21h
    main endp

end main