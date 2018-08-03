.model small

.stack 100h

.data                 
n dw ?
m dw ?
count_alive dw ?
alive db 50 dup(01h)
newline db 0dh,0ah,'$'

.code

main proc
    mov ax,@data
    mov ds,ax        
                       
    call cin     
    mov n,dx
    mov count_alive,dx   
    
    lea dx,newline
    mov ah,9
    int 21h
    
    call cin                
    inc dx
    mov m,dx
    mov bx,0h
    
    mov cx,m
    DEATH_LOOP:
    cmp count_alive,0h
    je END_DEATH
    cmp cx,m
    je DIE
    inc bx
    cmp bx,n
    jne DONT_MAKE_ZERO
    mov bx,0h
    DONT_MAKE_ZERO:
    cmp alive[bx],01h
    jne DONT_INCREASE_COUNT
    inc cx
    DONT_INCREASE_COUNT:
    jmp DEATH_LOOP
    DIE:          
    dec count_alive
    mov cx,0h
    xchg cl,[alive+bx] 
    mov cx,0h
    jmp DEATH_LOOP
    END_DEATH:
    
    lea dx,newline
    mov ah,9
    int 21h
    mov dx,bx                                                      
    inc dx
    call cout
    
    mov ah,4ch 
    int 21h  
main endp

cin proc 
    mov dx,0
    WHILE_CIN:
    mov ah,1
    int 21h  
    cmp al,0dh
    jz END_CIN
    sub al,30h
    mov cl,al 
    mov ch,0ah
    mov ax,dx
    mul ch
    mov dx,ax
    mov ch,0
    add dx,cx
    jmp WHILE_CIN
    END_CIN:     
    ret
cin endp

cout proc      
    mov dh,0ah
    mov cx,0
    WHILE_COUT:
    cmp dl,0      
    jz END_COUT
    mov al,dl 
    mov ah,0
    div dh   
    mov bl,ah
    mov bh,0
    push bx
    inc cx
    mov dl,al
    jmp WHILE_COUT
    END_COUT:
    mov ah,2
    PRINT:    
    pop bx
    mov dl,bl
    add dl,30h
    int 21h
    LOOP PRINT
    ret
cout endp
    
end main