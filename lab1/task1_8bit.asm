LCD_BUS equ P1
LCD_E  equ P3.0
LCD_RS equ P3.1

;initialization:

;set E and RS to 0
clr	LCD_E
clr	LCD_RS

;wait for more than 30ms
lcall 	wait_30ms

;prepare function set to be sent
mov 	LCD_BUS, 	#00111000B
;send command with function set
lcall 	send_command
;short wait (39us+)
lcall 	wait_short

;display ON/OFF control command, short wait
mov 	LCD_BUS, 	#00001110B
lcall 	send_command
lcall 	wait_short


;prepare display clear command
mov 	LCD_BUS,	#00000001B
;send command and long wait (1.53ms+)
lcall 	send_command
lcall 	wait_long

;prepare entry mode set
mov 	LCD_BUS,	#00000110B	;increment mode, no shift
lcall 	send_command
lcall 	wait_short

;send data: character 'L' to display
mov	LCD_BUS, 	#01001100B
lcall 	send_data

;infinite loop
jmp	$

;----
send_command:
	;set and clear the E pin to send the command
	setb 	LCD_E
	clr	LCD_E

ret
;----
send_data:
	;set the RS pin to 1, to inform about sending data
	setb 	LCD_RS 
	setb	LCD_E
	clr	LCD_E

ret
;----
wait_30ms:
	mov 	r2,	#20 	;move 20 to r2
	
wait_30ms_L1:	
	lcall	wait_long		;call the wait_long function
	djnz	r2, 	wait_30ms_L1	;decrement r2 20 times, so 20*1.53ms (wait_long) = 30.6 ms

ret
;----
wait_long:
	mov	r1, 	#3	;r1 will be decremented to repeat the loop 3 times
	
wait_long_L1:	
	mov	r0,	#0xff		;move 255 to register r0
	djnz	r0, 	$		;decrement 255, each djnz takes 2us, so in total: 256*2us = 512us	
	djnz	r1,	wait_long_L1	;decrement r1, so the loop is repeated 3 times
					;512us * 3 = 1536us = 1.53ms
ret		
;----
wait_short:
;waits for 40us + call, mov, ret overhead 
	mov	r0, 	#20	;move 20 to register r0
	djnz	r0, 	$	;decrement r0 20 times, so wait 2us*20 = 40us
ret
