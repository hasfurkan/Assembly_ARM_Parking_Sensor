LIMIT				EQU			0x200000C0	;Memory location for free use

					AREA			meas, READONLY, CODE
					THUMB
					EXPORT			UPDATE_MEAS
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
		DCB		0x00, 0x08, 0x08, 0x08, 0x08, 0x08 ;// 2d -
		DCB		0x00, 0x63, 0x14, 0x08, 0x14, 0x63 ;// 58 X
  		DCB		0x00, 0x00, 0x00, 0x7f, 0x00, 0x00 ;// 7c |

UPDATE_MEAS			PROC
					PUSH			{LR}
					PUSH			{R4}
					
					BL				DELAY1
					
					LDR			R3, =0x41	;Y=1
					BL			WRITE_COM
					
					LDR			R3, =0xB0	;X=48	;coordinates are choosen to display the desired numbers
					BL			WRITE_COM			;on desired locations
					
					MOV				R0, #6			;Displayed measured value is changed
					MOV				R1, #10			;Measured distance is in R4 and every digit is obtained by dividing
					UDIV			R3,R4,R1		;R4 by 10
					MUL				R3,R1
					SUB				R3,R4,R3
					UDIV			R4, R1
					
					MUL				R3,R3,R0					
					LDR				R2, =NUMBERS	;Beginnig address of the digit to display is calculated
					ADD				R2,R3
					BL				WRITE_ASCII		;WRITE_ASCII is called to display the number on screen
					
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
					
					LDR			R3, =0xA4	;X=36
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