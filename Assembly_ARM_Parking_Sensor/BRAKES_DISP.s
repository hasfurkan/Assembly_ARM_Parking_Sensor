

				AREA			display, READONLY, CODE
				THUMB
MSG		DCB		0x00, 0x7f, 0x49, 0x49, 0x49, 0x36 ;// 42 B
		DCB		0x00, 0x7f, 0x09, 0x19, 0x29, 0x46 ;// 52 R
		DCB		0x00, 0x7e, 0x11, 0x11, 0x11, 0x7e ;// 41 A
		DCB		0x00, 0x7f, 0x08, 0x14, 0x22, 0x41 ;// 4b K
		DCB		0x00, 0x7f, 0x49, 0x49, 0x49, 0x41 ;// 45 E
		DCB		0x00, 0x46, 0x49, 0x49, 0x49, 0x31 ;// 53 S
		DCB		0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ;// 20
		DCB		0x00, 0x3e, 0x41, 0x41, 0x41, 0x3e ;// 4f O
		DCB		0x00, 0x7f, 0x04, 0x08, 0x10, 0x7f ;// 4e N
					
				EXPORT			BRAKES_DISP
				EXTERN			WRITE_COM
				EXTERN			WRITE_ASCII

BRAKES_DISP		PROC
				PUSH			{LR}
				
				LDR				R3, =0x43	;Y=3
				BL				WRITE_COM
				
				LDR				R3, =0x92	;X=18
				BL				WRITE_COM
				
				LDR				R2, =MSG	;B
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#6		;R
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#12		;A
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#18		;K
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#24		;E
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#30		;S
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#36		;' '
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#42		;O
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#48		;N
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#36		;' '
				BL				WRITE_ASCII
				
				POP				{PC}
				END