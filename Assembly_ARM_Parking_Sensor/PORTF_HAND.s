GPIO_PORTF_DATA		EQU			0x400253FC 	;Data Register
STAT				EQU			0x20000100	;Memory location for free use
GPIO_PORTD_DATA 	EQU 		0x400073FC
GPIO_PORTF_ICR		EQU			0x4002541C 	;Interrupt clear

					
					AREA			hand, READONLY, CODE
					THUMB
					EXPORT			PORTF_HAND
PORTF_HAND			PROC
					PUSH			{LR}
					LDR				R1, =GPIO_PORTF_DATA
					LDR				R0, [R1]
					AND				R0, #0x11
					CMP				R0, #0x10
					BEQ				SW2_PRESSED
					B				SW1_PRESSED
SW1_PRESSED
					LDR				R1, =STAT
					LDR				R0, [R1]
					CMP				R0, #0x02
					BEQ				TO_END
					EOR				R0, #0x01
					STR				R0, [R1]
					B				TO_END
SW2_PRESSED
					LDR				R1, =STAT
					LDR				R0, [R1]
					CMP				R0, #0x02
					BNE				TO_END
					LDR				R1,=GPIO_PORTD_DATA
					LDR				R0,=0x01
					STR				R0,[R1]
					
					LDR				R1, =STAT
					LDR				R0, =0x00
					STR				R0,[R1]
TO_END
					LDR				R1,=GPIO_PORTF_ICR
					LDR				R0,=0x11
					STR				R0,[R1]
					POP				{PC}
					ENDP