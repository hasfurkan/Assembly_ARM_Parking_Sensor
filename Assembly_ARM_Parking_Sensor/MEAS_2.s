GPIO_PORTF_DATA		EQU			0x400253FC 	;Data Register 
GPIO_PORTB_DATA		EQU			0x400053FC 	;Data Register 
GPIO_PORTD_DATA		EQU			0x400073FC 	;Data Register 


TIMER1_RIS 			EQU 		0x4003101C 	;Raw interrupt Status 
TIMER1_TAR 			EQU 		0x40031048 	;Counter Register 
TIMER1_ICR 			EQU 		0x40031024 	;Interrupt Clear Register 
TIMER1_CTL 			EQU 		0x4003100C 	;Control Register 
	

TIME				EQU			0x20000080	;Memory location for free use
LIMIT				EQU			0x200000C0	;Memory location for free use
STAT				EQU			0x20000100	;Memory location for free use
	

					AREA		MEAS2, READONLY, CODE
					THUMB
DIST				DCB			" DISTANCE\t"
					DCB			0x04
THRE				DCB			" THRESHOLD\n"
					DCB			0x04
BRAKEMSG			DCB			"BRAKES ON"
					DCB			0x04

					
					EXPORT		MEAS_2
					EXTERN		CONVRT
					EXTERN 		OutStr
					EXTERN		DELAY100
					EXTERN		UPDATE_MEAS
					EXTERN		BRAKES_DISP
					EXTERN		UPDATE_BAR
						
MEAS_2				PROC
					PUSH 			{LR}
loop3					
					LDR 			R1, = TIMER1_ICR 
					mov 			R2, #0x04		;CAERIS	bit is cleared by writing the corresponding bit in ICR
					STR 			R2, [R1] 	

					LDR				R1, =GPIO_PORTB_DATA	;Address of data register B
					ORR				R2, #0x20
					STR				R2, [R1]
					MOV				R2, #0
					BL				DELAY100
					STR				R2, [R1]
					
					MOV				R7, #0				;COUNT
					LDR				R6, =TIME			;Address of memory location
loop2				
					LDR 			R1, =TIMER1_RIS 
loop 				
					LDR 			R2, [R1] 
					CMP 			R2, #0x04 			;isolate CAERIS bit 
					BNE 			loop 				;if no capture, then loop 

; Need to clear CAERIS bit of TIMER1_RIS. 

					LDR 			R1, =TIMER1_TAR 		;address of timer register 
					LDR 			R0, [R1] 				;Get timer register value
					
					STR				R0, [R6], #4			;Store timer register value
					
					ADD				R7, #1			;Increment count
					CMP				R7, #2			;2 detection means 2 edge is counted and pulse
													;width can be calculated now	

					BEQ				to_end
					
					LDR 			R1, = TIMER1_ICR
					mov 			R2, #0x04		;CAERIS	bit is cleared by writing the corresponding bit in ICR
					STR 			R2, [R1] 	
					
					B				loop2
to_end
					LDR				R6, =TIME
					LDR				R4, [R6], #4	;load detected points
					LDR				R3, [R6]
					
					CMP				R4, R3
					BMI				loop3
					SUB				R4, R3				;Pulse Width
					
					MOV				R8,#625			;1 cycle = 62.5 nsec
					MUL				R4,R8			;R4 holds the pulse width
					MOV				R8,#100		;distance (mm) = pulse width(nsec) * 17 * 10^-5
					MOV				R9,#17
					UDIV			R4,R8
					MUL				R4, R9
					MOV				R8,#10000
					UDIV			R4, R8
					MOV				R8,#999
					CMP				R8, R4
					MOVMI			R4,#999		;R4 has the calculated distance value in mm
					BL				CONVRT
					
					BL				UPDATE_MEAS	;call UPDATE_MEAS to change the displayed value
					BL				UPDATE_BAR	;call UPDATE_BAR to change the displayed state of bar
					
					MOV				R2, R4		;R2 has measured distance
					LDR				R1, =LIMIT
					LDR				R4, [R1]	;R4 has the threshold value
					CMP				R2,R4		;measured - threshold
					BMI				LIMIT_EXCEED
					B				TO_POP
LIMIT_EXCEED		
					BL				BRAKES_DISP		;Display "BRAKES ON" message on screen
					
					LDR				R1, =GPIO_PORTD_DATA
					LDR				R0, [R1]
					AND				R0,#0xF0
					STR				R0, [R1]		;Store 0x0 value in PORTD DATA to stop rotation
										
					LDR				R1,=STAT		;Change value in STAT to 0x02
					LDR				R0,=0x02
					STR				R0,[R1]
					
					LDR				R5, =BRAKEMSG
					BL				OutStr
TO_POP
					POP				{PC}
					END