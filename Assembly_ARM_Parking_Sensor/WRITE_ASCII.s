MEMO				EQU				0x200000D0

					AREA			write, READONLY, CODE
					THUMB			
					EXPORT			WRITE_ASCII
					EXTERN			WRITE_DISP
						
WRITE_ASCII			PROC
					PUSH			{LR}
					
					MOV				R1, #6			;Number of loops
					LDR				R0,	=MEMO		;stored in memory to keep it unchanged during the subroutine calls
					STR				R1, [R0]
					CMP				R1, #6
AGAIN			
					LDR				R3, [R2],#1		;R2 has the beginning address of the 6-bit wide character
					PUSH			{R2}			;Keep R2 in stack
					BL				WRITE_DISP		;Display corresponding column
					LDR				R0,	=MEMO		
					LDR				R1, [R0]		;Obtain loop count
					SUBS			R1,#1			;decrement count
					STR				R1, [R0]
					POP				{R2}			;Obtain R2 before loop ends
					BNE				AGAIN			;Break loop if 0 is reached
					
					POP				{PC}
					END