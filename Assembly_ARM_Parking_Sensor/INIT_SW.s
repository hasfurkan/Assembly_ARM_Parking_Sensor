GPIO_PORTF_DATA		EQU			0x400253FC 	;Data Register 
GPIO_PORTF_DIR 		EQU 		0x40025400 	;Port Direction 
GPIO_PORTF_AFSEL 	EQU 		0x40025420 	;Alt Function enable 
GPIO_PORTF_DEN 		EQU 		0x4002551C 	;Digital Enable 
GPIO_PORTF_LOCK 	EQU 		0x40025520 	;Lock
GPIO_PORTF_CR	 	EQU 		0x40025524 	;Commit
GPIO_PORTF_AMSEL 	EQU 		0x40025528 	;Analog enable 
GPIO_PORTF_PCTL 	EQU 		0x4002552C 	;Alternate Functions
GPIO_PORTF_PUR	 	EQU 		0x40025510 	;Pull up
GPIO_PORTF_IS		EQU			0x40025404 	;Interrupt sense
GPIO_PORTF_IBE		EQU			0x40025408 	;Interrupt both edges
GPIO_PORTF_IEV		EQU			0x4002540C 	;Interrupt event
GPIO_PORTF_IM		EQU			0x40025410 	;Interrupt Mask
GPIO_PORTF_ICR		EQU			0x4002541C 	;Interrupt clear

NVIC_EN0			EQU 		0xE000E100 ; IRQ 0 to 31 Set Enable Register
	
SYSCTL_RCGCGPIO 	EQU 		0x400FE608
	
STAT				EQU			0x20000100	;Memory location for free use

					AREA		INIT, READONLY, CODE
					THUMB
					EXPORT		INIT_SW
						
INIT_SW				PROC
					ldr				r1,=SYSCTL_RCGCGPIO	
					ldr				r0,[r1]
					orr				r0,r0,#0x20			;Initializing clock for port F
					str				r0,[r1]
					nop		
					nop
					nop								;Waiting to stabilize
					
					LDR 			R1, =GPIO_PORTF_LOCK 
					LDR 			R0, =0x4C4F434B
					STR 			R0, [R1]
					
					LDR 			R1, =GPIO_PORTF_CR 
					MOV 			R0, #0x11
					STR 			R0, [R1]
			
					LDR 			R1, =GPIO_PORTF_DIR 
					MOV 			R0, #0x00 ; clear bit 4,0 for input
					STR 			R0, [R1]
										
					LDR 			R1, =GPIO_PORTF_PUR 
					MOV 			R0, #0x11
					STR 			R0, [R1]
 
; enable alternate function 
					LDR 			R1, =GPIO_PORTF_AFSEL 
					LDR 			R0, =0x10 		;clear bits 
					STR	 			R0, [R1]
					
					ldr				r1,=GPIO_PORTF_DEN
					orr				r0,#0xff			
					str				r0,[r1]
					
					ldr				r1, =GPIO_PORTF_PCTL
					ldr				r0, =0x70000
					str				r0, [r1]

;disable analog 
					LDR 			R1, =GPIO_PORTF_AMSEL 
					MOV 			R0, #0 				;clear AMSEL to diable analog 
					STR 			R0, [R1]
					
					LDR 			R1, =GPIO_PORTF_IS
					LDR 			R2, =GPIO_PORTF_IBE
					LDR 			R3, =GPIO_PORTF_IEV
					LDR 			R4, =GPIO_PORTF_IM
					MOV 			R0, #0x00
					STR 			R0, [R1] 	; PF is edge-sensitive
					STR 			R0, [R2] 	; PF is not both edges
					STR 			R0, [R3]	; PF is falling edge
					MOV 			R0, #0x11 	
					STR 			R0, [R4] 	; enable interrupt for PB4
					
					LDR				R1, =NVIC_EN0
					LDR				R0, [R1]
					ORR				R0, #0x40000000
					STR				R0, [R1]
					
					LDR				R1, =STAT
					LDR				R0, =0x00
					STR				R0,[R1]
					
					BX				LR
					END