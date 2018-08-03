;set the CGA adapter for 80 * 25 color text display

mov ah,0
mov al,3
int 10h

;clear the screen to black for the 80 * 25 display

mov ah,6
mov al,0
mov cx,0
mov dh,24d
mov dl,79d
mov bh,7
int 10h

;move the cursor to the lower left corner 

mov ah,2
mov bh,0
mov dh,24d
mov dl,0
int 10h

;take input and count space

mov cx,0
mov ah,1
int 21h
input:
    cmp al,0dh
    je end_input
    cmp al,' '
    je space
    push ax
    inc cl
back:
    int 21h
    jmp input
space:
    inc ch
    jmp back 
end_input:  

;clear the input line

mov ah,6
mov al,0
mov dh,24d
mov dl,cl
push cx
mov ch,24d
mov cl,0d
mov bh,7
int 10h 

;move the cursor to the row 12 column 0

mov ah,2
mov bh,0
mov dh,12d
mov dl,0
int 10h

;make the window white

mov ah,6
mov al,0
mov cx,0
mov dh,24d
mov dl,79d
mov bh,0F0h
int 10h

;move the cursor to the row 12 column 39

mov ah,2
mov bh,0
mov dh,12d
mov dl,39d
int 10h

;display the number of spaces

pop cx
mov ah,2
mov dl,ch
add dl,30h 
int 21h

;display the letters

print:
    dec cl
    mov ah,2
    mov bh,0
    mov bl,1
    and bl,cl
    mov dh,12d
    add dh,bl
    mov dl,cl
    int 10h
    pop ax
    and al,11011111b
    mov ah,09h
    mov bh,0
    cmp bl,1
    je red
    mov bl,0fch
    jmp green
red:
    mov bl,0fah
green:
    push cx
    mov cx,1
    int 10h
    pop cx 
    cmp cl,0
    jg print
    
  

