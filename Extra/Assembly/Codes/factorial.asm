.MODEL SMALL
.STACK 100h
.CODE

MAIN PROC
    
    mov ax,5
    push ax
    call fact
    
    
    ;exit  
    mov ah,4ch
    int 21h
MAIN ENDP

fact PROC
    push bp
    mov bp,sp
    
    cmp word ptr[bp+4],1
    jg end_if
    
    mov ax,1
    jmp return
      
      
      
end_if:
    mov cx,[bp+4]
    dec cx
    
    push cx
    call fact
    
    mul word ptr[bp+4]
    
return:
    
    pop bp
    ret 2
          
    
    
fact ENDP


END MAIN
