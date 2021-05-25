

					AREA			meas, READONLY, CODE
					THUMB
					EXPORT			UPDATE_SAMP
					EXTERN			WRITE_COM
					EXTERN			WRITE_ASCII
					EXTERN			DELAY1
NUMBERS		DCB		0x00, 0x3e, 0x51, 0x49, 0x45, 0x3e ;// 30 0
		DCB		0x00, 0x00, 0x42, 0x7f, 0x40, 0x00 ;// 31 1
		DCB		0x00, 0x42, 0x61, 0x51, 0x49, 0x46 ;// 32 2
		DCB		0x00, 0x21, 0x41, 0x45, 0x4b, 0x31 ;// 33 3
		DCB		0x00, 0x18, 0x14, 0x12, 0x7f, 0x10 ;// 34 4
		DCB		0x00, 0x27, 0x45, 0x45, 0x45, 0x39 ;// 35 5
		DCB		0x00, 0x3c, 0x4a, 0x49, 0x49, 0x30 ;// 36 6
		DCB		0x00, 0x01, 0x71, 0x09, 0x05, 0x03 ;// 37 7
		DCB		0x00, 0x36, 0x49, 0x49, 0x49, 0x36 ;// 38 8
		DCB		0x00, 0x06, 0x49, 0x49, 0x29, 0x1e ;// 39 9

UPDATE_SAMP			PROC
					PUSH			{LR}
					PUSH			{R4}
					
					BL				DELAY1
					BL				DELAY1
					
					LDR			R3, =0x42	;Y=2
					BL			WRITE_COM
					
					LDR			R3, =0xB0	;X=48
					BL			WRITE_COM
					
					MOV				R0, #6		;R4 has the obtained value
					MOV				R1, #10		;Determined threshold value is displayed on the screen
					UDIV			R3,R4,R1	;Digits found by dividing R4 by 10
					MUL				R3,R1
					SUB				R3,R4,R3
					UDIV			R4, R1
					
					MUL				R3,R3,R0					
					LDR				R2, =NUMBERS
					ADD				R2,R3		;Beginning address of characters are found by adding number*6 to base address
					BL				WRITE_ASCII	;WRITE_ASCII is called to display character
					
					LDR			R3, =0xAA	;X=42
					BL			WRITE_COM
					
					MOV				R0, #6
					MOV				R1, #10
					UDIV			R3,R4,R1
					MUL				R3,R1
					SUB				R3,R4,R3
					UDIV			R4, R1
					
					MUL				R3,R3,R0					
					LDR				R2, =NUMBERS
					ADD				R2,R3
					BL				WRITE_ASCII
					
					LDR			R3, =0xA4	;X=48
					BL			WRITE_COM
					
					MOV				R0, #6
					MOV				R1, #10
					UDIV			R3,R4,R1
					MUL				R3,R1
					SUB				R3,R4,R3
					UDIV			R4, R1
					
					MUL				R3,R3,R0					
					LDR				R2, =NUMBERS
					ADD				R2,R3
					BL				WRITE_ASCII
					
					POP				{R4}
					POP				{PC}
					END