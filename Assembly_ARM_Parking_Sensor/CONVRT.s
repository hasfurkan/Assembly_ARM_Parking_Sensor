			AREA		main, READONLY, CODE
			THUMB		
			
			EXTERN		OutStr
			EXPORT		CONVRT
CONVRT		PROC
			
			PUSH		{LR}
			PUSH		{R0,R1,R3,R6,R7,R8}
			LDR			R5,=0x20000050
			MOV			R0,#0
			LDR			R6,=0x20000051
			MOV			R8,R4
			LDR			R7,=0x04
			MOV			R1,#10
loop		MOV			R3,R4
			UDIV		R3,R1
			CMP			R0,R3
			MULMI		R3,R1
			SUBMI		R3,R4,R3
			ADDMI		R3,#48
			STRBMI		R3,[R5]
			SUBMI		R5,#1
			UDIVMI		R4,R1
			ADDEQ		R4,#48
			STRBEQ		R4,[R5]
			BMI			loop
			STRB		R7,[R6]
			MOV			R4,R8
			POP			{R0,R1,R3,R6,R7,R8}
			BL			OutStr
			POP			{PC}