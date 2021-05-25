GPIO_PORTD_DATA		EQU			0x400073FC 	;Data Register 
GPIO_PORTD_IM 		EQU 		0x40007010 	;Interrupt Mask 
GPIO_PORTD_DIR 		EQU 		0x40007400 	;Port Direction 
GPIO_PORTD_AFSEL 	EQU 		0x40007420 	;Alt Function enable 
GPIO_PORTD_DEN 		EQU 		0x4000751C 	;Digital Enable 
GPIO_PORTD_AMSEL 	EQU 		0x40007528 	;Analog enable 
GPIO_PORTD_PCTL 	EQU 		0x4000752C 	;Alternate Functions
GPIO_PORTD_LOCK 	EQU 		0x40007520 	;Lock
GPIO_PORTD_CR	 	EQU 		0x40007524 	;Commit
	
SYSCTL_RCGCGPIO 	EQU 		0x400FE608
	
					AREA		INIT, READONLY, CODE
					THUMB
					EXPORT		PORTD_INIT
PORTD_INIT			PROC
					ldr				r1,=SYSCTL_RCGCGPIO	
					ldr				r0,[r1]
					orr				r0,r0,#0x08			;Initializing clock for port D
					str				r0,[r1]
					nop		
					nop
					nop								;Waiting to stabilize
					
					LDR 			R1, =GPIO_PORTD_LOCK 
					LDR 			R0, =0x4C4F434B
					STR 			R0, [R1]
					
					LDR 			R1, =GPIO_PORTD_CR 
					MOV 			R0, #0x0F
					STR 			R0, [R1]
			
					LDR 			R1, =GPIO_PORTD_DIR 
					LDR 			R0, [R1] 
					MOV 			R0, #0x0F ; Set bits 3:0 for output
					STR 			R0, [R1]
 
; enable alternate function 
					LDR 			R1, =GPIO_PORTD_AFSEL 
					LDR 			R0, [R1] 
					ORR 			R0, R0, #0x00 		 
					STR	 			R0, [R1]
					
					ldr				r1,=GPIO_PORTD_DEN
					orr				r0,#0xff			
					str				r0,[r1]

;disable analog 
					LDR 			R1, =GPIO_PORTD_AMSEL 
					MOV 			R0, #0 				;clear AMSEL to diable analog 
					STR 			R0, [R1] 
					
					BX				LR
					END