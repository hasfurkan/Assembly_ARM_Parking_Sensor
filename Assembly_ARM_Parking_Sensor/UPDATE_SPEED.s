TIMER0_TAILR		EQU 		0x40030028 ; Timer interval
DEC					EQU			0x200000E0	;Memory location for free use
LIMIT_UP			EQU			0x4E20
LIMIT_INTERVAL		EQU			0xB1DF
					
					AREA		update, READONLY, CODE
					THUMB
					EXPORT		UPDATE_SPEED
UPDATE_SPEED		PROC
					PUSH		{LR}
					PUSH		{R0,R1,R2,R3}
					
					LDR			R0, =DEC
					LDRB		R1, [R0], #1	;Measured distance divided by 100
					LDRB		R2, [R0]		;Limit divided by 100
					MOV			R3, #9
					SUB			R3, R2			;9-limit to obtain scale
												;i.e limit = 320 ->R2 = 3-> 9-3=6 divide top speed by 6
					LDR			R0, =LIMIT_INTERVAL
					UDIV		R0, R3			;Divide interval by scale
					CMP			R1, R2
					BMI			NEGATIVE
					SUB			R1, R2			;Difference between distance and threshold DIVIDED BY 100
					SUB			R3, R1			;Substract distance difference from scale to obtain slowing factor
					MUL			R3, R0
					
					LDR			R2, =LIMIT_UP
					ADD			R3, R2
					
					LDR			R0, =TIMER0_TAILR
					STR			R3, [R0]
NEGATIVE
					POP			{R0,R1,R2,R3}
					POP			{PC}
					END