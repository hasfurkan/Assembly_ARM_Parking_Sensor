GPIO_PORTC_DATA		EQU			0x400063FC 	;Data Register


SSI0_SR					EQU					0x4000800C
SSI0_DR					EQU					0x40008008

					AREA			write, READONLY, CODE
					THUMB
					EXPORT			WRITE_DISP

WRITE_DISP			PROC
					PUSH			{LR}

WAIT					
					LDR				R1, =SSI0_SR		;Check state register to see if there is any ongoing transmition
					LDR				R0, [R1]
					AND				R0, #0x10
					CMP				R0, #0
					BEQ				NOT_TRANSMIT		;If no transmit then branch
					B				WAIT				;If there is wait for it to finish
NOT_TRANSMIT										
					LDR				R1, =GPIO_PORTC_DATA
					LDR				R0, =0xC0			;Set PC7 to indicate that a command is going to be transmitted
					STR				R0, [R1]
					
					LDR				R1, =SSI0_DR		;R3 has the data to be transmitted
					STR				R3, [R1]			;Store the data to be transmitted into data register
WAIT2					
					LDR				R1, =SSI0_SR		;Check state register to see if there is any ongoing transmition
					LDR				R0, [R1]
					AND				R0, #0x10
					CMP				R0, #0
					BEQ				NOT_TRANSMIT2		;If no transmit then branch to end
					B				WAIT2				;If there is wait for it to finish
NOT_TRANSMIT2
					POP				{PC}
					END