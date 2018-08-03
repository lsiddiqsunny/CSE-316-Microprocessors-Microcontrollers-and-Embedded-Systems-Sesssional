.model small
.stack 100h
.data

;add 0ah and 0dh after message to go to new line
;dont forget to use $ at the end

msg DB "HELLO WORLD ",0ah,0dh,"$"
digits Dw ?
ARR DB 10 DUP(?)

.code    



MAIN proc
    
    ;load data segment
    mov ax,@data
    mov ds,ax
    
    ;print from data segment
    ;lea dx,msg 
    ;mov ah,9
    ;int 21h
    
    ;normal prinf function
    MOV AH,2
    MOV DL,3
    ADD DL,30H
    ;INT 21H 
    
    mov bx,'{' 
    push bx
    call pdec  
    
    MOV AH,4CH
    INT 21H

MAIN ENDP

    proc pdec
    
    pop ax
    mov digits,0
    mov dx,0 
    
    find_digits:
        mov bx,10
        
        div bx
        push dx  
        inc digits 
        
        mov dx,0
        cmp ax,0
        je end_find  
        jmp find_digits     
        
        
    end_find: 
    
    
    mov ah,2
    mov cx,digits   
    mov dx,cx  
    add dx,30h
    int 21h 
    
    ;lea dx,msg 
    ;mov ah,9
    ;int 21h 
    mov ah,2
    
    while:
        pop dx
        add dl,30h
        int 21h
    loop while  
  
    ret
    
pdec endp

END MAIN