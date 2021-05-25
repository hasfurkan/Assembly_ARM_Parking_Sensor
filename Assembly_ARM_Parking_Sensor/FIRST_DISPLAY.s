					AREA			display, READONLY, CODE
					THUMB
						
ASCII	DCB		0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ;// 20
		DCB		0x00, 0x14, 0x08, 0x3e, 0x08, 0x14 ;// 2a *
		DCB		0x00, 0x08, 0x08, 0x08, 0x08, 0x08 ;// 2d -
		DCB		0x00, 0x00, 0x60, 0x60, 0x00, 0x00 ;// 2e .
		DCB		0x00, 0x00, 0x36, 0x36, 0x00, 0x00 ;// 3a :
		DCB		0x00, 0x00, 0x41, 0x22, 0x14, 0x08 ;// 3e >
  		DCB		0x00, 0x00, 0x00, 0x7f, 0x00, 0x00 ;// 7c |
		DCB		0x00, 0x3e, 0x51, 0x49, 0x45, 0x3e ;// 30 0
		DCB		0x00, 0x00, 0x42, 0x7f, 0x40, 0x00 ;// 31 1
		DCB		0x00, 0x42, 0x61, 0x51, 0x49, 0x46 ;// 32 2
		DCB		0x00, 0x21, 0x41, 0x45, 0x4b, 0x31 ;// 33 3
		DCB		0x00, 0x18, 0x14, 0x12, 0x7f, 0x10 ;// 34 4
		DCB		0x00, 0x27, 0x45, 0x45, 0x45, 0x39 ;// 35 5
		DCB		0x00, 0x3c, 0x4a, 0x49, 0x49, 0x30 ;// 36 6
		DCB		0x00, 0x01, 0x71, 0x09, 0x05, 0x03 ;// 37 7
		DCB		0x00, 0x36, 0x49, 0x49, 0x49, 0x36 ;// 38 8
		DCB		0x00, 0x06, 0x49, 0x49, 0x29, 0x1e ;// 39 9
		DCB		0x00, 0x7e, 0x11, 0x11, 0x11, 0x7e ;// 41 A
		DCB		0x00, 0x7f, 0x49, 0x49, 0x49, 0x36 ;// 42 B
		DCB		0x00, 0x3e, 0x41, 0x41, 0x41, 0x22 ;// 43 C
		DCB		0x00, 0x7f, 0x49, 0x49, 0x49, 0x41 ;// 45 E
		DCB		0x00, 0x7f, 0x02, 0x0c, 0x02, 0x7f ;// 4d M
		DCB		0x00, 0x7f, 0x04, 0x08, 0x10, 0x7f ;// 4e N
		DCB		0x00, 0x3e, 0x41, 0x41, 0x41, 0x3e ;// 4f O
		DCB		0x00, 0x7f, 0x08, 0x14, 0x22, 0x41 ;// 4b K
		DCB		0x00, 0x7f, 0x09, 0x19, 0x29, 0x46 ;// 52 R
		DCB		0x00, 0x46, 0x49, 0x49, 0x49, 0x31 ;// 53 S
		DCB		0x00, 0x63, 0x14, 0x08, 0x14, 0x63 ;// 58 X
		DCB		0x00, 0x20, 0x54, 0x54, 0x54, 0x78 ;// 61 a
		DCB		0x00, 0x38, 0x54, 0x54, 0x54, 0x18 ;// 65 e
		DCB		0x00, 0x7f, 0x08, 0x04, 0x04, 0x78 ;// 68 h
		DCB		0x00, 0x7c, 0x08, 0x04, 0x04, 0x08 ;// 72 r
  		DCB		0x00, 0x48, 0x54, 0x54, 0x54, 0x20 ;// 73 s
		DCB		0x00, 0x38, 0x44, 0x44, 0x48, 0x7f ;// 64 d
		DCB		0x00, 0x7c, 0x04, 0x18, 0x04, 0x78 ;// 6d m
		DCB		0x00, 0x38, 0x44, 0x44, 0x44, 0x38 ;// 6f o
		DCB		0x00, 0x00, 0x41, 0x7f, 0x40, 0x00 ;// 6c l
		DCB		0x00, 0x20, 0x40, 0x44, 0x3d, 0x00 ;// 6a j
		DCB		0x00, 0x01, 0x01, 0x7f, 0x01, 0x01 ;// 54 T
		DCB		0x00, 0x7c, 0x14, 0x14, 0x14, 0x08 ;// 70 p

					EXPORT			FIRST_DISPLAY
					EXTERN			WRITE_DISP
					EXTERN			WRITE_COM
					EXTERN			WRITE_ASCII
											
FIRST_DISPLAY		PROC
				PUSH			{LR}
				
;------------------------------------------------------------------------------------
;WRITING Meas:     mm ON SCREEN
				LDR				R3, =0x41	;Y=1
				BL				WRITE_COM
				
				LDR				R3, =0x86	;X=6
				BL				WRITE_COM
				
				LDR				R2, =ASCII
				ADD				R2,#126
				BL				WRITE_ASCII	;'M'
				
				LDR				R2, =ASCII
				ADD				R2,#174
				BL				WRITE_ASCII	;'e'
				
				LDR				R2, =ASCII
				ADD				R2,#168
				BL				WRITE_ASCII	;'a'
				
				LDR				R2, =ASCII
				ADD				R2,#192
				BL				WRITE_ASCII	;'s'
				
				LDR				R2, =ASCII
				ADD				R2,#24
				BL				WRITE_ASCII	;':'
												
				LDR				R3, =0xB6	;X=54
				BL				WRITE_COM				
				
				LDR				R2, =ASCII
				ADD				R2,#204
				BL				WRITE_ASCII	;'m'
				
				LDR				R2, =ASCII
				ADD				R2,#204
				BL				WRITE_ASCII	;'m'
;------------------------------------------------------------------------------------
;WRITING Thre:000mm ON SCREEN				
				LDR				R3, =0x42	;Y=2
				BL				WRITE_COM
				
				LDR				R3, =0x86	;X=6
				BL				WRITE_COM
				
				LDR				R2, =ASCII
				ADD				R2,#228
				BL				WRITE_ASCII	;'T'
				
				LDR				R2, =ASCII
				ADD				R2,#180
				BL				WRITE_ASCII	;'h'
				
				LDR				R2, =ASCII
				ADD				R2,#186
				BL				WRITE_ASCII	;'r'
				
				LDR				R2, =ASCII
				ADD				R2,#174
				BL				WRITE_ASCII	;'e'
				
				LDR				R2, =ASCII
				ADD				R2,#24
				BL				WRITE_ASCII	;':'				
				
				LDR				R2, =ASCII
				ADD				R2,#42
				BL				WRITE_ASCII	;'0'			
				
				LDR				R2, =ASCII
				ADD				R2,#42
				BL				WRITE_ASCII	;'0'			
				
				LDR				R2, =ASCII
				ADD				R2,#42
				BL				WRITE_ASCII	;'0'			
				
				LDR				R2, =ASCII
				ADD				R2,#204
				BL				WRITE_ASCII	;'m'
				
				LDR				R2, =ASCII
				ADD				R2,#204
				BL				WRITE_ASCII	;'m'
;------------------------------------------------------------------------------------
;WRITING ->Normal Op. ON SCREEN

				LDR				R3, =0x43	;Y=3
				BL				WRITE_COM
				
				LDR				R3, =0x86	;X=6
				BL				WRITE_COM
				
				LDR				R2, =ASCII
				ADD				R2,#12
				BL				WRITE_ASCII	;'-'
				
				LDR				R2, =ASCII
				ADD				R2,#30
				BL				WRITE_ASCII	;'>'
				
				LDR				R2, =ASCII
				ADD				R2,#132
				BL				WRITE_ASCII	;'N'
				
				LDR				R2, =ASCII
				ADD				R2,#210
				BL				WRITE_ASCII	;'o'
				
				LDR				R2, =ASCII
				ADD				R2,#186
				BL				WRITE_ASCII	;'r'
				
				LDR				R2, =ASCII
				ADD				R2,#204
				BL				WRITE_ASCII	;'m'
				
				LDR				R2, =ASCII
				ADD				R2,#168
				BL				WRITE_ASCII	;'a'
				
				LDR				R2, =ASCII
				ADD				R2,#216
				BL				WRITE_ASCII	;'l'
				
				LDR				R2, =ASCII
				BL				WRITE_ASCII	;' '
				
				LDR				R2, =ASCII
				ADD				R2,#138
				BL				WRITE_ASCII	;'O'
				
				LDR				R2, =ASCII
				ADD				R2,#234
				BL				WRITE_ASCII	;'p'
				
				LDR				R2, =ASCII
				ADD				R2,#18
				BL				WRITE_ASCII	;'.'
;------------------------------------------------------------------------------------
;WRITING CAR X||||||||| ON SCREEN

				LDR				R3, =0x45	;Y=5
				BL				WRITE_COM
				
				LDR				R3, =0x80	;X=0
				BL				WRITE_COM
				
				LDR				R2, =ASCII
				ADD				R2,#114
				BL				WRITE_ASCII	;'C'
				
				LDR				R2, =ASCII
				ADD				R2,#102
				BL				WRITE_ASCII	;'A'
				
				LDR				R2, =ASCII
				ADD				R2,#150
				BL				WRITE_ASCII	;'R'
				
				LDR				R2, =ASCII
				BL				WRITE_ASCII	;' '
				
				LDR				R2, =ASCII
				ADD				R2,#162
				BL				WRITE_ASCII	;'X'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'
				
				LDR				R2, =ASCII
				ADD				R2,#36
				BL				WRITE_ASCII	;'|'


				POP				{PC}
				END