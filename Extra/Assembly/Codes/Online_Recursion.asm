.model small

.stack 100h

.data
x dw ?     
newline db 0dh,0ah,'$'

.code

main proc
    mov ax,@data
    mov ds,ax        
        
    mov ah,1
    int 21h          
    mov cl,al
    sub cl,30h
    mov ch,0
    
    lea dx,newline
    mov ah,9
    int 21h          
           
    push cx
    call G
    mov dx,ax
    call cout
    
    mov ah,4ch 
    int 21h  
main endp

G proc
    push bp
    mov bp,sp
    mov cx,[bp+4]
    cmp cx,0
    jle G_BASE
    sub cx,2
    push cx
    call F
    mov cx,ax
    mov ax,[bp+4]
    inc ax
    mul cl
    add ax,3
    jmp END_G
    G_BASE:
    mov ax,1 
    END_G:
    pop bp
    ret 2
G endp

F proc     
    push bp
    mov bp,sp
    mov cx,[bp+4]
    cmp cx,0
    jle F_BASE
    sub cx,1
    push cx
    call G
    mov cx,ax       
    mov ax,[bp+4]
    mul cl
    add ax,4
    jmp END_F
    F_BASE:
    mov ax,2 
    END_F:
    pop bp 
    ret 2
F endp

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