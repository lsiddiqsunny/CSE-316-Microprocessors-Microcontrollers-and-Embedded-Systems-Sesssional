.model small

.stack 100h

.data
n dw 6
r dw 4
.code

main proc
    
    mov ax, @data
    mov ds, ax   
    
    ;multiply from n to n-r         
    mov ax,1            
    mov bx,n
    mov cx,n
    sub cx,r            
    
    TOP1:
    mul bx
    dec bx
    loop TOP1
    
    ;calculate (n-r)!
    mov bx,ax
    mov ax,1
    mov cx,n
    sub cx,r
    
    TOP2:
    mul cx
    loop TOP2
                
    ;do the division
    xchg ax,bx
    div bx
    
    main endp

end main