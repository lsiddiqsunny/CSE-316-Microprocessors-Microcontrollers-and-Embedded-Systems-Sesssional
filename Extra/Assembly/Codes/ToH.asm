.model small

.stack 100h

.data
n dw ?     
msg1 db 'move disk $'
msg2 db ' from $'
msg3 db ' to $'
newline db 0dh,0ah,'$'

.code

main proc
    mov ax,@data
    mov ds,ax        
    
    call cin
    mov n,dx 
    
    lea dx,newline
    mov ah,9
    int 21h          
    
    mov ax,1
    mov bx,3
    mov cx,2
    mov dx,n
    push ax
    push bx
    push cx
    push dx
    
    call move

    mov ah,4ch 
    int 21h  
main endp

move proc  
    push bp
    mov bp,sp
    cmp [bp+4],0
    jz END_TASK
    mov ax,[bp+10]
    mov bx,[bp+6]
    mov cx,[bp+8]
    mov dx,[bp+4]
    dec dx
    push ax
    push bx
    push cx
    push dx
    call move
    
    lea dx,msg1
    mov ah,9
    int 21h
    mov dx,[bp+4]
    call cout
    lea dx,msg2
    mov ah,9
    int 21h
    mov dx,[bp+10]
    call cout
    lea dx,msg3
    mov ah,9
    int 21h
    mov dx,[bp+8]
    call cout
    lea dx,newline
    mov ah,9
    int 21h          
    
    mov ax,[bp+6]
    mov bx,[bp+8]
    mov cx,[bp+10]
    mov dx,[bp+4]
    dec dx
    push ax
    push bx
    push cx
    push dx
    call move
       
    END_TASK:   
    pop bp
    ret 8
move endp    
    
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