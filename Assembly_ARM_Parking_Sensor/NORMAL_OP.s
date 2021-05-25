

				AREA			display, READONLY, CODE
				THUMB
MSG		DCB		0x00, 0x7f, 0x04, 0x08, 0x10, 0x7f ;// 4e N
		DCB		0x00, 0x38, 0x44, 0x44, 0x44, 0x38 ;// 6f o
		DCB		0x00, 0x7c, 0x08, 0x04, 0x04, 0x08 ;// 72 r
		DCB		0x00, 0x7c, 0x04, 0x18, 0x04, 0x78 ;// 6d m
		DCB		0x00, 0x20, 0x54, 0x54, 0x54, 0x78 ;// 61 a
		DCB		0x00, 0x00, 0x41, 0x7f, 0x40, 0x00 ;// 6c l
		DCB		0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ;// 20
		DCB		0x00, 0x3e, 0x41, 0x41, 0x41, 0x3e ;// 4f O
		DCB		0x00, 0x7c, 0x14, 0x14, 0x14, 0x08 ;// 70 p
		DCB		0x00, 0x00, 0x60, 0x60, 0x00, 0x00 ;// 2e .
		
					
				EXPORT			NORMAL_OP
				EXTERN			WRITE_COM
				EXTERN			WRITE_ASCII

NORMAL_OP		PROC
				PUSH			{LR}
				
				LDR				R3, =0x43	;Y=3
				BL				WRITE_COM
				
				LDR				R3, =0x92	;X=18
				BL				WRITE_COM
				
				LDR				R2, =MSG
				BL				WRITE_ASCII	;N
				
				LDR				R2, =MSG
				ADD				R2,#6		;o
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#12		;r
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#18		;m
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#24		;a
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#30		;l
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#36		;' '
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#42		;O
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#48		;p
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#54		;.
				BL				WRITE_ASCII
				
				POP				{PC}
				END