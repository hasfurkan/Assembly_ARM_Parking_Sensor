STAT				EQU			0x20000100	;Memory location for free use

				AREA		main, READONLY, CODE
				THUMB
				EXPORT		__main
				EXTERN		PORTA_INIT
				EXTERN		PORTB4_INIT
				EXTERN		PORTC_INIT
				EXTERN		PORTD_INIT
				EXTERN		INIT_PORTE3_ADC
				EXTERN		INIT_SW
				EXTERN		INIT_SSI0
				EXTERN		DELAY100
				EXTERN		DELAY1
				EXTERN		INIT_TIMER_0A
				EXTERN		INIT_TIMER_1A
				EXTERN		INIT_SCREEN
				EXTERN 		MEAS_2
				EXTERN		SAVE_SAMPLE
				EXTERN		NORMAL_OP
				EXTERN		THRESHOLD_OP
					
__main
				bl			INIT_SW			;Initializations
				bl			PORTA_INIT
				bl			PORTB4_INIT
				bl			PORTC_INIT
				bl			PORTD_INIT
				bl			INIT_PORTE3_ADC
				bl			DELAY100
				bl			INIT_SSI0
				bl			INIT_TIMER_1A
				bl			INIT_TIMER_0A
				bl			INIT_SCREEN
LOOP				
				BL			DELAY1				;Wait at the beginning of every loop
				LDR			R1,=STAT			;Check the value in STAT
				LDR			R0,[R1]				;i.e check mode of operation
				CMP			R0,#0
				BEQ			NORMAL_STATE		;If 0 then Normal Op., branch to NORMAL_STATE
				CMP			R0,#1
				BEQ			THRESHOLD			;If 1 then Threshold Op., branch to THRESHOLD
				B			LOOP				;If 2 then brakes are on, loop again
NORMAL_STATE
				BL			NORMAL_OP			;Display message "->Normal Op."
				BL			MEAS_2				;Measure distance, check if limit is exceeded, update bar, update speed
				B			LOOP				;loop back
THRESHOLD		
				BL			SAVE_SAMPLE			;Measure analog value with pot, transform it between 0-999, display measurement
				BL			THRESHOLD_OP		;Display message "->Thre. Adj." and replace bar with "*"s
				B			LOOP				;loop back
		
				
				end