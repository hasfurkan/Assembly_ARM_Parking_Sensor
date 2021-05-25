GPIO_PORTD_DATA 	EQU 	0x400073FC
TIMER0_ICR			EQU 	0x40030024 ; Timer Interrupt Clear

					AREA		right, READONLY, CODE
					THUMB
					EXPORT		StepRight
				
StepRight			PROC
	
					ldr			r1,=GPIO_PORTD_DATA
					ldr			r0,[r1]
					and			r0,0x0F

					cmp			r0,#8
					ldreq		r0,=0x04
					streq		r0,[r1]
					beq			to_end

					cmp			r0,#4
					ldreq		r0,=0x02
					streq		r0,[r1]
					beq			to_end
					
					cmp			r0,#2
					ldreq		r0,=0x01
					streq		r0,[r1]
					beq			to_end
					
					cmp			r0,#1
					ldreq		r0,=0x08
					streq		r0,[r1]					
to_end					
					LDR 		R1, = TIMER0_ICR 
					LDR 		R2, [R1] 
					mov 		R2, #0x01
					STR 		R2, [R1] 
					
					bx			lr
					endp