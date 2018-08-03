.model small

.stack 100h

.data
a db 0
len db 0
sum db 0
temp_len db 0       
temp_sum db 0

.code
main proc
    mov ax,@data
    mov ds,ax
    ;while loop
    WHILE:                
    ;take input
    mov ah,1
    int 21h   
    ;check $
    cmp al,'$'  
    JE END_WHILE
    ;check order                
    sub al,30H
    cmp al,a
    JGE SKIP_UPDATE
    ;update
    mov bl,len                  
    cmp bl,temp_len
    JG REFRESH
    ;update with new sequence
    mov bl,temp_len
    mov len,bl
    mov bl,temp_sum
    mov sum,bl
    ;refresh values
    REFRESH:
    mov temp_sum,al
    mov temp_len,1
    mov a,al
    jmp WHILE
    ;routine task    
    SKIP_UPDATE:
    inc temp_len
    add temp_sum,al
    mov a,al
    jmp WHILE
    ;last check
    END_WHILE:  
    mov bl,temp_len
    cmp len,bl
    JG OUTPUT
    ;update answer
    mov bl,temp_len
    mov len,bl
    mov bl,temp_sum
    mov sum,bl
    ;output
    OUTPUT:   
    mov ah,2
    mov dl,len 
    add dl,30H
    int 21h   
    mov dl,' '
    int 21h   
    mov dl,sum
    add dl,30H
    int 21h 
    
    mov ah,4ch
    int 21h
    main endp
end main