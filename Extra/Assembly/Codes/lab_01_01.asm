.model small

.stack 100h

.data
a db 4
b dw 11   
    
.code

main proc
    mov ax,@data
    mov ds,ax ;ds can't take the address data segment directly. convensionally ax is used
               
    mov ah,1
    int 21h           
    
    mov bl,al
    
    mov ah,2
    mov dl,0dh ;carriage return
    int 21h   
            
    mov ah,2
    mov dl,0ah ;new line
    int 21h
           
    ;oops..al has been changed to 0dh and then 0ah      
     
    mov ah,2
    mov dl,bl
    int 21h           
               
    mov ah,4ch 
    int 21h ;interrupter. used for different functions which depends on the value of ah. ah=1, Takes AL. ah=2, shows DL, ah=9 outputs string. 4ch returns control to OS.
    main endp ;last line of program

;others procedurews will be inserted here

end main ;last line of code