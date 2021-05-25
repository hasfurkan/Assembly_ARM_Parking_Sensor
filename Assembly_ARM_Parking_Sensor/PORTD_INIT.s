GPIO_PORTC_DATA		EQU			0x400063FC 	;Data Register 
GPIO_PORTC_IM 		EQU 		0x40006010 	;Interrupt Mask 
GPIO_PORTC_DIR 		EQU 		0x40006400 	;Port Direction 
GPIO_PORTC_AFSEL 	EQU 		0x40006420 	;Alt Function enable 
GPIO_PORTC_DEN 		EQU 		0x4000651C 	;Digital Enable 
GPIO_PORTC_AMSEL 	EQU 		0x40006528 	;Analog enable 
GPIO_PORTC_PCTL 	EQU 		0x4000652C 	;Alternate Functions
GPIO_PORTC_LOCK 	EQU 		0x40006520 	;Lock
GPIO_PORTC_CR	 	EQU 		0x40006524 	;Commit
	
SYSCTL_RCGCGPIO 	EQU 		0x400FE608
	
					AREA		INIT, READONLY, CODE
					THUMB
					EXPORT		PORTC_INIT
PORTC_INIT			PROC
					ldr				r1,=SYSCTL_RCGCGPIO	
					ldr				r0,[r1]
					orr				r0,r0,#0x04			;Initializing clock for port C
					str				r0,[r1]
					nop		
					nop
					nop								;Waiting to stabilize
								
					LDR 			R1, =GPIO_PORTC_DIR 
					LDR 			R0, [R1] 
					MOV 			R0, #0xC0 ; Set bits 7:6 for output
					STR 			R0, [R1]
 
; enable alternate function 
					LDR 			R1, =GPIO_PORTC_AFSEL 
					LDR 			R0, [R1] 
					ORR 			R0, R0, #0x00 		;set bit 4 for alternate fuction on PB4 
					STR	 			R0, [R1]
					
					ldr				r1,=GPIO_PORTC_DEN
					orr				r0,#0xff			
					str				r0,[r1]

;disable analog 
					LDR 			R1, =GPIO_PORTC_AMSEL 
					MOV 			R0, #0 				;clear AMSEL to diable analog 
					STR 			R0, [R1] 
					
					BX				LR
					END