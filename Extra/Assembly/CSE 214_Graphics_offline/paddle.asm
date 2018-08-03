.MODEL	SMALL
       
DRAW_ROW	MACRO	X
	LOCAL	L1
;draws a line in row X from column 10 to column  300
	MOV	AH,0CH	;draw pixel
	MOV	AL,1	;cyan
	MOV	CX,10	;column 10
	MOV	DX,X	;row X
L1:	INT	10H
	INC	CX	;next column
	CMP	CX,301	;beyond column 300?
	JL	L1	;no, repeat
	ENDM
;
DRAW_COLUMN	MACRO	Y
	LOCAL	L2
;draws a line in column Y from row 10 to row 189
	MOV	AH,0CH	;draw pixel
	MOV	AL,1	;cyan
	MOV	CX,Y	;column Y
	MOV	DX,10	;row 10
L2:	INT	10H	
	INC	DX	;next row
	CMP	DX,190	;beyond row 189?
	JL	L2	;no, repeat
	ENDM
;
       
       
.DATA
;
NEW_TIMER_VEC	DW	?,?
OLD_TIMER_VEC	DW	?,?
NEW_KEY_VEC	DW	?,?
OLD_KEY_VEC	DW	?,?
SCAN_CODE	DB	0
KEY_FLAG	DB	0
TIMER_FLAG	DB	0
PADDLE_TOP	DW	45
PADDLE_BOTTOM	DW	54
VEL_X		DW	-6
VEL_Y		DW	-1
;scan codes
UP_ARROW = 72
DOWN_ARROW = 80
ESC_KEY = 1
;


	
	
.CODE
SET_DISPLAY_MODE	PROC
;sets display mode and draws boundary
	MOV  AH,0	;set mode
	MOV  AL,04H	;modå 4¬ 32°x20° ´ color
	INT  10H
	MOV  AH,0BH	;selecô palettå 
	MOV  BH,1
	MOV  BL,1	;palettå 1
	INT  10H	;
	MOV  BH,0	;seô backgrounä coloò 
	MOV  BL,2	;green
	INT  10H
;draw boundary
	DRAW_ROW	10	;drwaw row 10
	DRAW_ROW	189	;draw row 189
	DRAW_COLUMN	10	;draw column 10
	DRAW_COLUMN	300	;draw column 300
	RET
SET_DISPLAY_MODE    ENDP
;
DISPLAY_BALL	PROC
;displays ball at column CX and row DX with color given in AL
;inputº AÌ ½ coloò oæ ball
;	CØ ½ column
;	DØ ½ row
	MOV  AH,0CH	;writå pixel
	INT  10H
	INC  CX		;pixeì  oî nexô column
	INT  10H
	INC  DX		;dowî ± row
	INT  10H
	DEC  CX		;previouó column
	INT  10H
	DEC  DX		;restorå DX
	RET
DISPLAY_BALL	ENDP
	
	


BEEP	PROC
;generate beeping sound
	PUSH	CX		;save CX
;initialize timer
	MOV	AL,0B6H		;specify mode of operation
	OUT	43H,AL		;write to port 43h
;load count
	MOV	AX,1193		;count for 1000 Hz
	OUT	42H,AL		;low byte
	MOV	AL,AH		;high byte
	OUT	42H,AL
;activate speaker
	IN	AL,61H		;read control port
	MOV	AH,AL		;save value in AH
	OR	AL,11B		;set control bits
	OUT	61H,AL		;activate speaker
;500 ms delay loop
	MOV	CX,9		;do 9 times
B_1:	CMP	TIMER_FLAG,1	;check timer flag
	JNE	B_1		;not set, loop back
	MOV	TIMER_FLAG,0	;flag set, clear it
	LOOP	B_1		;repeat for next tick
;turn off tone
	MOV	AL,AH		;return old control value to AL
	OUT	61H,AL		;restore control value
;
	POP	CX		;restore CX
	RET
BEEP	ENDP
	


MOVE_BALL_A PROC
;erase ball at current position and display ball at new position
;inputº  CX = column
;        DX = row
;output: CX = column
;	DX = row
	MOV	AL,0	           ;color 0 is background color
	CALL	DISPLAY_BALL       ;erase ball
;get new position
      	ADD	CX,VEL_X
	ADD	DX,VEL_Y
;check boundary
        CALL    CHECK_BOUNDARY_A
;wait for 1 timer tick
TEST_TIMER_1:
	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	TEST_TIMER_1	;no¬ keep testing
	MOV	TIMER_FLAG,0	;yes, clear flag
	MOV	AL,3		;white color
	CALL	DISPLAY_BALL	;show ball
        RET
MOVE_BALL_A ENDP
;
CHECK_BOUNDARY_A PROC
;determine if ball is outside screen, if so move it back in and 
;change the ball direction
;inputº  CX = column
;        DX = row
;outputº  CX = column
;        DX = row
;check column value
	CMP	CX,11	;left of 11?
	JG	L1	;no, go check right margin
	MOV	CX,11	;yes¬ set to 11
	NEG	VEL_X	;change direction
	CALL	BEEP	;sound beep
	JMP	L2	;go test row boundary
L1:	CMP	CX,299	;beyond right margin?
	JL	L2	;no, go test row boundary
	MOV	CX,298	;set column to 298
	NEG	VEL_X	;change direction
	CALL	BEEP	;sound beep
;check row value
L2:	CMP	DX,11	;above top margin?
	JG	L3	;no, check bottom margin
	MOV	DX,11	;set to 11
	NEG	VEL_Y	;change direction
	CALL	BEEP	;sound beep
	JMP	DONE	;done
L3:	CMP	DX,188	;below bottom margin?
	JL	DONE	;no, done
	MOV	DX,187	;yes¬ set to 187
	NEG	VEL_Y	;change direction
	CALL	BEEP	;sound beep
DONE:
	RET
CHECK_BOUNDARY_A	ENDP
;

KEYBOARD_INT	PROC
;keyboard interrupt routine
;save registers
	PUSH	DS
	PUSH	AX
;set up DS
	MOV	AX,SEG SCAN_CODE
	MOV	DS,AX
;input scan code
	IN	AL,60H		;read scan code
	PUSH	AX		;save it
	IN	AL,61H		;control port
	MOV	AH,AL		;save in AH
	OR	AL,80H		;set bit for keyboard
	OUT	61H,AL		;write back
	XCHG	AH,AL		;get back control value
	OUT	61H,AL		;reset control port
	POP	AX		;recover scan code
	MOV	AH,AL		;save scan code in AH
	TEST	AL,80H		;test for break code
	JNE	KEY_0		;yes, clear flags, goto KEY_0
;make code
	MOV	SCAN_CODE,AL	;save in variable
	MOV	KEY_FLAG,1	;set key flag
KEY_0:	MOV	AL,20H		;reset interrupt
	OUT	20H,AL
;restore registers
	POP	AX
	POP	DS
	IRET
KEYBOARD_INT	ENDP		;end KEYBOARD routine
;


DRAW_PADDLE	PROC
;draw paddle in column 11
;input: AL contains pixel value
;	2 (red) for display and 0 (green) to erase
;save registers
	PUSH	CX
	PUSH	DX
;
	MOV	AH,0CH		;write pixel function
	MOV	CX,11		;column 11
	MOV	DX,PADDLE_TOP	;top row
DP1:	INT	10H
	INC	DX		;next row
	CMP	DX,PADDLE_BOTTOM ;done?
	JLE	DP1		;no, repeat
;restore registers
	POP	DX
	POP	CX
	RET
DRAW_PADDLE	ENDP
;
MOVE_PADDLE	PROC
;move paddle up or down
;input:	AX = 2 (to move paddle down 2 pixels)
;	   = -2 (to move paddle up 2 pixels)
	MOV	BX,AX		;copy to BX
;check direction
	CMP	AX,0	
	JL	UP		;neg, move up
;move down, check paddle position
	CMP	PADDLE_BOTTOM,188	;at bottom?
	JGE	DONE		;yes, cannot move
	JMP	UPDATE		;no, update paddle
;move up, check if at top
UP:	CMP	PADDLE_TOP,11	;at top?
	JLE	DONE1		;yes, cannot move
;move paddle
UPDATE:	
;--erase paddle
	MOV	AL,0		;green color
	CALL	DRAW_PADDLE
;--change paddle position
	ADD	PADDLE_TOP,BX
	ADD	PADDLE_BOTTOM,BX
;--display paddle at new position
	MOV	AL,2		;red
	CALL	DRAW_PADDLE
DONE1:	RET
MOVE_PADDLE	ENDP
 
;timer routine
TIMER_TICK	PROC
;save registers
	PUSH	DS		;save DS
	PUSH	AX		
;
	MOV	AX,SEG TIMER_FLAG	;get segment of flag
	MOV	DS,AX		;put in DS
	MOV	TIMER_FLAG,1	;set flag
;restore registers
	POP	AX
	POP	DS		;restore DS
	IRET
TIMER_TICK	ENDP		;end timer routine


setup_int proc   
; save old vector and set up new vector
; input: al = interrupt number
;	 di = address of buffer for old vector
;	 si = address of buffer containing new vector
; save old interrupt vector
	MOV AH, 35h	; get vector
	INT 21h
	MOV [DI], BX	; save offset
	MOV [DI+2], ES  ; save segment
; setup new vector
	MOV DX, [SI]	; dx has offset
	PUSH DS		; save ds
	MOV DS, [SI+2]	; ds has the segment number
	MOV AH, 25h	; set vector
	INT 21h
	POP DS
	RET
setup_int EndP  
  
  
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX		;initialize DS
;
;set graphics mode
	CALL	SET_DISPLAY_MODE
;draw paddle
	MOV	AL,2		;display red paddle
	CALL	DRAW_PADDLE
;set up timer interrupt vector
	MOV	NEW_TIMER_VEC,OFFSET TIMER_TICK  ;offset
	MOV	NEW_TIMER_VEC+2,CS		;segment
	MOV	AL,1CH		;interrupt number
	LEA	DI,OLD_TIMER_VEC
	LEA	SI,NEW_TIMER_VEC
	CALL	SETUP_INT
;set up keyboard interrupt vector
	MOV	NEW_KEY_VEC,OFFSET KEYBOARD_INT	;offset
	MOV	NEW_KEY_VEC+2,CS		;segment
	MOV	AL,9H		;interrupt number
	LEA	DI,OLD_KEY_VEC
	LEA	SI,NEW_KEY_VEC
	CALL	SETUP_INT
;start ball at column = 298, row = 100
	MOV	CX,298		;column
	MOV	DX,100		;row
	MOV	AL,3		;white
	CALL	DISPLAY_BALL
;check key flag
TEST_KEY:
	CMP	KEY_FLAG,1	;check key flag
	JNE	TEST_TIMER	;not set, go check timer flag
	MOV	KEY_FLAG,0	;flag set, clear it and check
	CMP	SCAN_CODE,ESC_KEY	;Esc key?
	JNE	TK_1		;no, check arrow keys
	JMP	DONE2		;Esc, terminate
TK_1:	CMP	SCAN_CODE,UP_ARROW	;up arrow?
	JNE	TK_2		;no, check down arrow
	MOV	AX,-2		;yes, move up 2 pixels
	CALL	MOVE_PADDLE	;
	JMP	TEST_TIMER	;go check timer flag
TK_2:	CMP	SCAN_CODE,DOWN_ARROW	;down arrow?
	JNE	TEST_TIMER	;no, check timer flag
	MOV	AX,2		;yes, move down 2 pixels
	CALL	MOVE_PADDLE	;
;check timer flag
TEST_TIMER:
	CMP	TIMER_FLAG,1	;flag set?
	JNE	TEST_KEY	;no, check key flag
	MOV	TIMER_FLAG,0	;yes, clear it
	CALL	MOVE_BALL_A	;move ball to new position
;check if paddle missed ball
	CMP	CX,11		;at column 11?
	JNE	TEST_KEY	;no, check key flag
	CMP	DX,PADDLE_TOP	;yes, check paddle
	JL	CP_1		;missed, ball above
	CMP	DX,PADDLE_BOTTOM	
	JG	CP_1		;missed, ball below
;paddle hit the ball, delay one tick then
;move the ball and redraw paddle
DELAY:	CMP	TIMER_FLAG,1	;timer ticked?
	JNE	DELAY		;no, keep checking
	MOV	TIMER_FLAG,0	;yes, reset flag
	CALL	MOVE_BALL_A
	MOV	AL,2		;display red paddle
	CALL	DRAW_PADDLE
	JMP	TEST_KEY	;check key flag
;paddle missed the ball, erase the ball and terminate
CP_1:	MOV	AL,0		;erase ball
	CALL	DISPLAY_BALL
;--reset timer interrupt vector
DONE2:	LEA	DI,NEW_TIMER_VEC
	LEA	SI,OLD_TIMER_VEC
	MOV	AL,1CH
	CALL	SETUP_INT
;--reset keyboard interrupt vector
	LEA	DI,NEW_KEY_VEC
	LEA	SI,OLD_KEY_VEC
	MOV	AL,9H
	CALL	SETUP_INT
;read key
	MOV	AH,0
	INT	16H
;reset to text mode
	MOV	AH,0
	MOV	AL,3
	INT	10H
;return to DOS
	MOV	AH,4CH
	INT	21H
MAIN	ENDP
	END	MAIN
