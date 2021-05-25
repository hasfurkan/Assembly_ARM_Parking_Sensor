MEMO			EQU				0x200000D0

				AREA			clear, READONLY, CODE
				THUMB
				EXPORT			CLEAR_SCREEN
				EXTERN			WRITE_DISP
				EXTERN			WRITE_COM
					
CLEAR_SCREEN	PROC
				PUSH			{LR}
				
				LDR				R3, =0x40	;Y=0
				BL				WRITE_COM
				
				LDR				R3, =0x80	;X=0
				BL				WRITE_COM	;Start from first row first column

				MOV				R1, #504	;Screen consists of 504 columns(6 rows*84 columns)
				LDR				R0,	=MEMO	;Store it in memory to keep it unchanged during the subroutine calls
				STR				R1, [R0]
				
AGAIN			
				LDR				R3, =0x00	;Display blank columns to clear the screen
				BL				WRITE_DISP
				LDR				R0,	=MEMO
				LDR				R1, [R0]	;obtain current value of the count
				SUBS			R1,#1		;decrement count
				STR				R1, [R0]
				BNE				AGAIN		;if 0 reached break loop
				
				POP				{PC}
				END