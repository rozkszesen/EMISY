LCD_BUS equ P1
LCD_E	equ P3.0
LCD_RS 	equ P3.1

start:
;configuring the display:

;set E and RS to 0
clr	LCD_E
clr	LCD_RS

;wait for more than 30ms
lcall wait_30ms

;prepare function set to be sent

;send command with function set

;short wait (39us+)


;prepare display ON/OFF control command

;send command

;short wait (39us+)


;prepare display clear command

;send command and long wait (1.53ms+)


;prepare entry mode set


wait_30ms:
	mov 	r2,		#0x13 	;r2 will be decremented to repeat the loop 20 times
	
wait_30ms_L1:	
	lcall	wait_long				;call the wait_long function
	djnz	r2, 	wait_30ms_L1	;repeat 20*1.53ms = 30.6 ms

ret

wait_long:
	mov		r1, 	#0x2	;r1 will be decremented to repeat the loop 3 times
	
wait_long_L1:	
	mov		r0,		#0xff			;move 255 to register r0
	djnz	r0, 	$				;decrement 255, each djnz takes 2us, so in total: 512us	
	djnz	r1,		wait_long_L1	;decrement 2, so the loop is repeated 3 times
									;512us * 3 = 1536us = 1.53ms
ret		

wait_short:
