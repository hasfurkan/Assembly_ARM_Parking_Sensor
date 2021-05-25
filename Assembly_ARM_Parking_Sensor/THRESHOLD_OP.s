

				AREA			display, READONLY, CODE
				THUMB
MSG		DCB		0x00, 0x01, 0x01, 0x7f, 0x01, 0x01 ;// 54 T
		DCB		0x00, 0x7f, 0x08, 0x04, 0x04, 0x78 ;// 68 h
		DCB		0x00, 0x7c, 0x08, 0x04, 0x04, 0x08 ;// 72 r
		DCB		0x00, 0x38, 0x54, 0x54, 0x54, 0x18 ;// 65 e
		DCB		0x00, 0x00, 0x60, 0x60, 0x00, 0x00 ;// 2e .
		DCB		0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ;// 20
		DCB		0x00, 0x7e, 0x11, 0x11, 0x11, 0x7e ;// 41 A
		DCB		0x00, 0x38, 0x44, 0x44, 0x48, 0x7f ;// 64 d
		DCB		0x00, 0x20, 0x40, 0x44, 0x3d, 0x00 ;// 6a j
		DCB		0x00, 0x14, 0x08, 0x3e, 0x08, 0x14 ;// 2a *

					
				EXPORT			THRESHOLD_OP
				EXTERN			WRITE_COM
				EXTERN			WRITE_ASCII

THRESHOLD_OP	PROC
				PUSH			{LR}
;---------------------------------------------------------------------------
;WRITING ->Thre. Adj.				
				LDR				R3, =0x43	;Y=3
				BL				WRITE_COM
				
				LDR				R3, =0x92	;X=18
				BL				WRITE_COM
				
				LDR				R2, =MSG	;T
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#6		;h
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#12		;r
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#18		;e
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#24		;.
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#30		;' '
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#36		;A
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#42		;d
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#48		;j
				BL				WRITE_ASCII
				
				LDR				R2, =MSG
				ADD				R2,#24		;.
				BL				WRITE_ASCII
;---------------------------------------------------------------------------
;WRITING ************
				LDR				R3, =0x45	;Y=5
				BL				WRITE_COM
				
				LDR				R3, =0x80	;X=0
				BL				WRITE_COM
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				LDR				R2, =MSG
				ADD				R2,#54
				BL				WRITE_ASCII	;*
				
				POP				{PC}
				END