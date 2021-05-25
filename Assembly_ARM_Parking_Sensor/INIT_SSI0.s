SSI0_CR0				EQU					0x40008000
SSI0_CR1				EQU					0x40008004
SSI0_CPSR				EQU					0x40008010
	
SYSCTL_RCGCSSI 			EQU 				0x400FE61C

						AREA		init, READONLY, CODE
						THUMB
						EXPORT		INIT_SSI0
							
INIT_SSI0				PROC
						PUSH 		{LR}
						
						LDR			R1, =SSI0_CR1	;DISABLE
						LDR			R0, [R1]
						BIC			R0, 0x02
						STR			R0, [R1]
						
						LDR			R1, =SSI0_CR0
						LDR			R0, [R1]
						ORR			R0, 0x0100
						STR			R0, [R1]
						
						LDR			R1, =SSI0_CPSR	;DETERMINE CLOCK RATE (16/(8*(1+1))=1 MHz)
						LDR			R0, =0x08
						STR			R0, [R1]
						
						LDR			R1, =SSI0_CR0	;Bits 5:4 0x0 for Freescale mode
						LDR			R0, [R1]		;bits 3:0 0x7 for 8-bit data
						ORR			R0, 0x07
						STR			R0, [R1]
						
						LDR			R1, =SSI0_CR1	;ENABLE
						LDR			R0, [R1]
						ORR			R0, 0x02
						STR			R0, [R1]
						
						POP	 		{PC}
						END