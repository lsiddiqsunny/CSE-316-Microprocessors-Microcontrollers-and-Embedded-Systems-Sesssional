.model small
draw_row macro x
	local l1
; draws a line in row x from col 10 to col 300
	mov ah, 0ch
	mov al, 1
	mov cx, 10
	mov dx, x
L1:	int 10h
	inc cx
	cmp cx, 301
	jl L1
	endm

draw_col macro y
	local l2
; draws a line col y from row 10 to row 189
	mov ah, 0ch
	mov al, 1
	mov cx, y
	mov dx, 10
L2:	int 10h
	inc dx
	cmp dx, 190
	jl L2
	endm

.stack 100h
.data
new_timer_vec	dw	?,?
old_timer_vec 	dw	?,?
timer_flag 	db	0
vel_x 		dw 	1
vel_y 		dw 	1
.code

set_display_mode proc
; sets display mode and draws boundary
	mov ah, 0
	mov al, 04h; 320x200 4 color
	int 10h
; select palette	
	mov ah, 0bh
	mov bh, 1
	mov bl, 1
	int 10h
; set bgd color
	mov bh, 0
	mov bl, 1; cyan
	int 10h
; draw boundary
	draw_row 10
	draw_row 189
	draw_col 10
	draw_col 300
	
	ret
set_display_mode endp

display_ball proc
; displays ball at col CX and row DX with color given in AL
; input: AL = color of ball
;	 CX = col
;	 DX = row
	mov ah, 0ch	; write pixel
	int 10h
	inc cx		; pixel on next col
	int 10h
	inc dx		; down 1 row
	int 10h
	dec cx		; prev col
	int 10h
	dec dx		; restore dx
	ret 
display_ball endp

timer_tick proc
	push ds
	push ax
	
	mov ax, seg timer_flag
	mov ds, ax
	mov timer_flag, 1
	
	pop ax
	pop ds
	
	iret
timer_tick endp

move_ball proc
; erase ball at current position and display at new position
; input: CX = col of ball position
;	 DX = rwo of ball position
; erase ball
	mov al, 0
	call display_ball
; get new position
	add cx, vel_x
	add dx, vel_y
; check boundary
	call check_boundary
; wait for 1 timer tick to display ball
test_timer:
	cmp timer_flag, 1
	jne test_timer
	mov timer_flag, 0
	mov al, 3
	call display_ball
	ret	
move_ball endp

check_boundary proc
; determine if ball is outside screen, if so move it back in and 
; change ball direction
; input: CX = col of ball
;	 DX = row of ball
; output: CX = valid col of ball
;	  DX = valid row of ball
; check col value
	cmp cx, 11
	jg LP1
	mov cx, 11
	neg vel_x
	jmp LP2 
LP1:	cmp cx, 298
	jl LP2
	mov cx, 298
	neg vel_x
; check row value
LP2:	cmp dx, 11
	jg LP3
	mov dx, 11
	neg vel_y
	jmp done
LP3:	cmp dx, 187
	jl done
	mov dx, 187
	neg vel_y
done:
	ret 
check_boundary endp

setup_int proc
; save old vector and set up new vector
; input: al = interrupt number
;	 di = address of buffer for old vector
;	 si = address of buffer containing new vector
; save old interrupt vector
	mov ah, 35h	; get vector
	int 21h
	mov [di], bx	; save offset
	mov [di+2], es  ; save segment
; setup new vector
	mov dx, [si]	; dx has offset
	push ds		; save ds
	mov ds, [si+2]	; ds has the segment number
	mov ah, 25h	; set vector
	int 21h
	pop ds
	ret
setup_int endp

main proc
	mov ax, @data
	mov ds, ax
	
; set graphics display mode & draw border
	call set_display_mode
; set up timer interrupt vector
	mov new_timer_vec, offset timer_tick
	mov new_timer_vec+2, cs
	mov al, 1ch; interrupt type
	lea di, old_timer_vec
	lea si, new_timer_vec
	call setup_int
; start ball at col = 298, row = 100
; for the rest of the program CX = ball row, DX = ball col
	mov cx, 298
	mov dx, 100
	mov al, 3
	call display_ball
; wait for timer tick before moving the ball
tt:
	cmp timer_flag, 1
	jne tt
	mov timer_flag, 0
	call move_ball
tt2:
	cmp timer_flag, 1
	jne tt2
	mov timer_flag, 0
	jmp tt
main endp
end main
