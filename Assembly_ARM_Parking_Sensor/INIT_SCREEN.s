GPIO_PORTC_DATA		EQU			0x400063FC 	;Data Register


SSI0_SR					EQU					0x4000800C
SSI0_DR					EQU					0x40008008

	
					AREA		INIT, READONLY, CODE
					THUMB
					EXPORT		INIT_SCREEN
					EXTERN		DELAY100
					EXTERN		WRITE_COM
					EXTERN		WRITE_DISP
					EXTERN		FIRST_DISPLAY
					EXTERN		CLEAR_SCREEN
						
INIT_SCREEN			PROC
					PUSH		{LR}
					
					LDR			R1, =GPIO_PORTC_DATA
					LDR			R0, [R1]
					BIC			R0,#0xC0
					STR			R0, [R1]
					BL			DELAY100
					BL			DELAY100
					
					LDR			R1, =GPIO_PORTC_DATA
					LDR			R0, [R1]
					ORR			R0, #0x40
					STR			R0, [R1]

					LDR			R3, =0x21	;H=1 V=0
					BL			WRITE_COM
					
					LDR			R3, =0xB6	;VOP
					BL			WRITE_COM
					
					LDR			R3, =0x05	;TEMP
					BL			WRITE_COM
					
					LDR			R3, =0x13	;BIAS
					BL			WRITE_COM
					
					LDR			R3, =0x20	;H=0 V=0
					BL			WRITE_COM
					
					LDR			R3, =0x0C	;NORMAL DISPLAY
					BL			WRITE_COM
					
					LDR			R3, =0x40	;Y=0
					BL			WRITE_COM
					
					LDR			R3, =0x80	;X=0
					BL			WRITE_COM
					
					BL			CLEAR_SCREEN	;Clears the whole screen by displaying blank bits
					BL			FIRST_DISPLAY	;Creates the structure of the screen such as Meas:  mm, Thre:   mm
					
					POP			{PC}
					END