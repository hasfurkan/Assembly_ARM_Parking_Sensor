GPIO_PORTA_DATA		EQU			0x400043FC 	;Data Register 
GPIO_PORTA_IM 		EQU 		0x40004010 	;Interrupt Mask 
GPIO_PORTA_DIR 		EQU 		0x40004400 	;Port Direction 
GPIO_PORTA_AFSEL 	EQU 		0x40004420 	;Alt Function enable 
GPIO_PORTA_DEN 		EQU 		0x4000451C 	;Digital Enable 
GPIO_PORTA_AMSEL 	EQU 		0x40004528 	;Analog enable 
GPIO_PORTA_PCTL 	EQU 		0x4000452C 	;Alternate Functions
GPIO_PORTA_LOCK 	EQU 		0x40004520 	;Lock
GPIO_PORTA_CR	 	EQU 		0x40004524 	;Commit
	
SYSCTL_RCGCGPIO 	EQU 		0x400FE608
SYSCTL_RCGCSSI 		EQU 		0x400FE61C
					
					AREA			init, READONLY, CODE
					THUMB
					EXPORT			PORTA_INIT
						
PORTA_INIT			PROC
					PUSH			{LR}
					
											
				
					ldr				r1,=SYSCTL_RCGCGPIO	
					ldr				r0,[r1]
					orr				r0,r0,#0x01			;Initializing clock for port A
					str				r0,[r1]
					nop		
					nop
					nop								;Waiting to stabilize
							
					
					ldr				r1,=GPIO_PORTA_DEN
					orr				r0,#0xff			
					str				r0,[r1]
					
					LDR 			R1, =GPIO_PORTA_DIR 
					LDR 			R0, [R1] 
					MOV 			R0, #0x00 ; Set bits for input
					STR 			R0, [R1]
 
; enable alternate function 
					LDR 			R1, =GPIO_PORTA_AFSEL 
					LDR 			R0, =0x3C 		
					STR	 			R0, [R1]
					
					LDR				R1,=GPIO_PORTA_PCTL
					LDR				R0,=0x222200
					STR				R0,[R1]

;disable analog 
					LDR 			R1, =GPIO_PORTA_AMSEL 
					MOV 			R0, #0 				;clear AMSEL to diable analog 
					STR 			R0, [R1]
					
					LDR				R1, =SYSCTL_RCGCSSI ;START SYSTEM CLOCK AND WAIT TO STABILIZE
					LDR				R0, [R1]
					ORR				R0, #0x01
					STR				R0, [R1]
					NOP
					NOP
					NOP
					NOP
					
					POP				{PC}
					END