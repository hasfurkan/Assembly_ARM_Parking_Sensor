GPIO_PORTB_DATA		EQU			0x400053FC 	;Data Register 
GPIO_PORTB_IM 		EQU 		0x40005010 	;Interrupt Mask 
GPIO_PORTB_DIR 		EQU 		0x40005400 	;Port Direction 
GPIO_PORTB_AFSEL 	EQU 		0x40005420 	;Alt Function enable 
GPIO_PORTB_DEN 		EQU 		0x4000551C 	;Digital Enable 
GPIO_PORTB_AMSEL 	EQU 		0x40005528 	;Analog enable 
GPIO_PORTB_PCTL 	EQU 		0x4000552C 	;Alternate Functions
	
SYSCTL_RCGCGPIO 	EQU 		0x400FE608
	
					AREA		INIT, READONLY, CODE
					THUMB
					EXPORT		PORTB4_INIT
PORTB4_INIT			PROC
					ldr				r1,=SYSCTL_RCGCGPIO	
					ldr				r0,[r1]
					orr				r0,r0,#0x02			;Initializing clock for port B
					str				r0,[r1]
					nop		
					nop
					nop								;Waiting to stabilize
			
					LDR 			R1, =GPIO_PORTB_DIR 
					LDR 			R0, [R1] 
					MOV 			R0, #0x20 ; clear bit 4 for input, set bits 5 and 3:0 for output
					STR 			R0, [R1]
 
; enable alternate function 
					LDR 			R1, =GPIO_PORTB_AFSEL 
					LDR 			R0, [R1] 
					ORR 			R0, R0, #0x10 		;set bit 4 for alternate fuction on PB4 
					STR	 			R0, [R1]
					
					ldr				r1,=GPIO_PORTB_DEN
					orr				r0,#0xff			
					str				r0,[r1]
 
; set alternate function to T0CCP1 (7) 
					LDR 			R1, =GPIO_PORTB_PCTL 
					LDR 			R0, [R1] 
					ORR 			R0, R0, #0x00070000 	;set bits 16:19 of PCTL to 7 
					STR 			R0, [R1] 			;to enable T0CCP1 on PB4 

;disable analog 
					LDR 			R1, =GPIO_PORTB_AMSEL 
					MOV 			R0, #0 				;clear AMSEL to diable analog 
					STR 			R0, [R1] 
					
					BX				LR
					END