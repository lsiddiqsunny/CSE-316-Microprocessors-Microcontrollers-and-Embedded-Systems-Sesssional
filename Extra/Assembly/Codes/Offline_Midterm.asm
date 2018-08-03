.model small

.stack 100h

.data                 
len dw ?
i db ?     
j db ?      
k db ?  
start db ?
sublen db ?
string db 20 dup(?)
newline db 0dh,0ah,'$'

.code

main proc
    mov ax,@data
    mov ds,ax        
             
    mov bx,0
    INPUT_LOOP:
    mov ah,1
    int 21h          
    cmp al,0dh
    je END_INPUT
    xchg al,[string+bx]
    inc bx
    jmp INPUT_LOOP
    END_INPUT:         
    mov al,'$'
    xchg al,[string+bx]
    mov len,bx
    mov i,bl
    inc i  
    LENGTH_LOOP:
    dec i
    mov ax,len
    div i
    cmp ah,0h
    jne LENGTH_LOOP
    mov sublen,al
    mov j,0h
    SEGMENT_LOOP:   
    mov bl,i
    cmp j,bl
    je END_SEGMENT
    mov al,sublen
    mul j
    mov start,al 
    mov k,0h
    CHECK_LOOP: 
    mov bl,sublen
    cmp k,bl
    je END_CHECK                                                             
    mov bh,0h
    mov bl,start
    mov si,bx
    mov bl,k
    add si,bx 
    mov di,bx
    mov bl,[string+si]
    cmp bl,[string+di]
    jne LENGTH_LOOP
    inc k
    jmp CHECK_LOOP
    END_CHECK:
    inc j
    jmp SEGMENT_LOOP
    END_SEGMENT:
    
    lea dx,newline
    mov ah,9
    int 21h          
    
    mov bx,0h
    mov bl,sublen
    mov si,0h   
    mov ah,2
    PRINT_LOOP:
    cmp si,bx
    je END_PRINT
    mov dl,[string+si]
    int 21h 
    inc si
    jmp PRINT_LOOP
    END_PRINT:
    mov dl,' '
    int 21h
    mov dh,0h
    mov dl,i
    call cout
    
    mov ah,4ch 
    int 21h  
main endp

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