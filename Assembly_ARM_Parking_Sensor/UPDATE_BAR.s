LIMIT				EQU			0x200000C0	;Memory location for free use
DEC					EQU			0x200000E0	;Memory location for free use
						
					AREA			bar, READONLY, CODE
					THUMB
ASCII	DCB		0x00, 0x08, 0x08, 0x08, 0x08, 0x08 ;// 2d -
		DCB		0x00, 0x63, 0x14, 0x08, 0x14, 0x63 ;// 58 X
		DCB		0x00, 0x00, 0x00, 0x7f, 0x00, 0x00 ;// 7c |
		DCB		0x00, 0x3e, 0x41, 0x41, 0x41, 0x22 ;// 43 C
		DCB		0x00, 0x7e, 0x11, 0x11, 0x11, 0x7e ;// 41 A
		DCB		0x00, 0x7f, 0x09, 0x19, 0x29, 0x46 ;// 52 R
		DCB		0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ;// 20
					EXPORT			UPDATE_BAR
					EXTERN			WRITE_COM
					EXTERN			WRITE_ASCII
					EXTERN			UPDATE_SPEED
							
UPDATE_BAR			PROC
					PUSH			{LR}
					PUSH			{R4}
					
					LDR				R3, =0x45	;Y=5
					BL				WRITE_COM
				
					LDR				R3, =0x80	;X=0
					BL				WRITE_COM
					
					LDR				R2, =ASCII
					ADD				R2, #18
					BL				WRITE_ASCII
					
					LDR				R2, =ASCII
					ADD				R2, #24
					BL				WRITE_ASCII
					
					LDR				R2, =ASCII
					ADD				R2, #30
					BL				WRITE_ASCII
					
					LDR				R2, =ASCII
					ADD				R2, #36
					BL				WRITE_ASCII
					
					
					LDR				R1, =LIMIT
					LDR				R2, [R1]
					MOV				R1, #100
					UDIV			R2, R1
					UDIV			R4, R1		;Divide measurement and limit by 100 and compare
					LDR				R1, =DEC
					STRB			R4, [R1], #1	;Store divided values in memory
					STRB			R2, [R1]
					BL				UPDATE_SPEED
					CMP				R2, R4
					BMI				ABOVE_LIMIT
					B				BELOW_LIMIT
ABOVE_LIMIT
					LDR				R1, =DEC
					LDRB			R3, [R1,#1]	;Divided value of limit is loaded
AGAIN1					
					CMP				R3, #0			;Write '-' until divided limit value is not 0
					PUSH			{R3}			;write 'X' when it is zero
					LDRNE			R2, =ASCII		;i.e divided limit = 3 -› ---X
					BLNE			WRITE_ASCII
					POP				{R3}
					CMP				R3, #0
					SUBNE			R3, #1			
					BNE				AGAIN1
					LDR				R2, =ASCII
					ADD				R2, #6
					BL				WRITE_ASCII
					
					LDR				R1, =DEC
					LDRB			R3, [R1], #1	;Divided value of measurement is loaded
					LDRB			R0, [R1]		;Divided value of limit is loaded
					PUSH			{R3}
					SUB				R3, R0			
					SUB				R3, #1			;R3 = divided measurement-divided limit-1
AGAIN2					
					CMP				R3, #0			;Write '-' until (divided measurement-divided limit-1) value is not 0
					PUSH			{R3}
					LDRNE			R2, =ASCII
					BLNE			WRITE_ASCII
					POP				{R3}
					CMP				R3, #0
					SUBNE			R3, #1	
					BNE				AGAIN2
					
					POP				{R3}
					MOV				R1,#10
					SUB				R3, R1, R3		;Substract divided measurement value from 10 to indicate number of '|'
													;limit =350, measurement =420 -> ---X|||||| ->10-4 = 6 '|'
AGAIN3
					CMP				R3, #0
					PUSH			{R3}
					LDRNE			R2, =ASCII
					ADDNE			R2, #12
					BLNE			WRITE_ASCII
					POP				{R3}
					CMP				R3, #0
					SUBNE			R3, #1	
					BNE				AGAIN3
					B				TO_END
BELOW_LIMIT
					LDR				R1, =DEC
					LDRB			R3, [R1,#1]	;Divided value of limit is loaded
AGAIN4					
					CMP				R3, #0			;Write '-' until divided limit value is not 0
					PUSH			{R3}			;write '|' when it is zero
					LDRNE			R2, =ASCII		;i.e divided limit = 3 -› ---|
					BLNE			WRITE_ASCII
					POP				{R3}
					CMP				R3, #0
					SUBNE			R3, #1			
					BNE				AGAIN4
					LDR				R2, =ASCII
					ADD				R2, #12
					BL				WRITE_ASCII
					
					LDR				R1, =DEC
					LDRB			R3, [R1,#1]	;Divided value of limit is loaded
					
					MOV				R1, #10
					SUB				R3, R1, R3
					SUB				R3, #1			;Substract divided limit value from 10 to indicate number of '|'
													;limit =350, measurement =370 -> ---||||||| ->10-4 = 6 '|'
AGAIN5
					CMP				R3, #0
					PUSH			{R3}
					LDRNE			R2, =ASCII
					ADDNE			R2, #12
					BLNE			WRITE_ASCII
					POP				{R3}
					CMP				R3, #0
					SUBNE			R3, #1	
					BNE				AGAIN5
					
TO_END	
					POP				{R4}
					POP				{PC}
					END