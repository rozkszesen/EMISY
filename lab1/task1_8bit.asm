LCD_BUS equ P1
LCD_E	equ P3.0
LCD_RS 	equ P3.1

start:
;configuring the display:

	;set E and RS to 0
	clr	LCD_E
	clr	LCD_RS
	
	;wait for more than 30ms
	
	
	;prepare function set to be sent
	
	;send command with function set
	
	;short wait (39us+)
	
	
	;prepare display ON/OFF control command
	
	;send command
	
	;short wait (39us+)
	
	
	;prepare display clear command
	
	;send command and long wait (1.53ms+)
	
	
	;prepare entry mode set
	
	
wait_long:



wait_short:
