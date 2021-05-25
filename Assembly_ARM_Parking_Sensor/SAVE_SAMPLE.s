ADC0_RIS  	 	EQU 0x40038004 ; Interrupt status 
ADC0_PSSI   	EQU 0x40038028 ; Initiate sample 
ADC0_SSFIFO3   	EQU 0x400380A8 ; Channel 3 results  
ADC0_ISC 	 	EQU 0x4003800C  

TIMER2_ICR 		EQU 0x40032024 	;Interrupt Clear Register 

LIMIT			EQU	0x200000C0	;Memory location for free use
 	 	 	 
				AREA  	sample, READONLY, CODE 
				THUMB 
				EXPORT  	SAVE_SAMPLE
				EXTERN		CONVRT
				EXTERN		DELAY1
				EXTERN		UPDATE_SAMP
 
 
SAVE_SAMPLE 	PROC 
				PUSH	{LR}
 	 	 	; start sampling routine 
				LDR 	R3, =ADC0_RIS ; interrupt address 
				LDR 	R5, =ADC0_SSFIFO3 ; result address 
				LDR 	R2, =ADC0_PSSI ; sample sequence initiate address 
				LDR 	R6,= ADC0_ISC 
 	 	 	; initiate sampling  
				LDR 	R0, [R2] 
				ORR 	R0, R0, #0x08 ; set bit 3 for SS3 
				STR 	R0, [R2] 
 	 	 	; check for sample complete  
Cont   			LDR 	R0, [R3] 
				ANDS 	R0, R0, #8 ; CHECK IF THE RIS FLAG IS SET 
				BEQ 	Cont 
	 	 	; GO OUT OF THE LOOP IF THE END IS REACHED 
				LDR 	R4,[R5] ; OBTAIN THE DIGITAL INFORMATION 
				MOV 	R0, #8
				STR 	R0, [R6] ; clear flag 
			; R4 HAS THE CONVERTED ANANLOG SIGNAL
				LDR				R1,=0xFFF
				LDR				R2,=0x3E7
				MUL				R4,R2
				UDIV			R4,R1
				LDR				R1,=LIMIT	;Store obtained value in memory to make it accessible
				STR				R4,[R1]		;for other subroutines
				BL				UPDATE_SAMP	;Update displayed value of threshold
				BL				CONVRT
				BL				DELAY1
				
				POP				{PC}
				END
 
