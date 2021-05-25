			AREA		main, READONLY, CODE
			THUMB
			
			EXPORT		DELAY1
Num			EQU			0xCD055		;Processors operation frequency is equal to 16MHz.
									;The loop below takes 3 cycles everytime.
DELAY1		PROC						;If 16,000,000 cycles take 1 second then
			PUSH		{LR}
			ldr			r9,=Num		;16000000/3=533,333.3333 loops will take the same amount
loop1		subs		r9,#1		;of time to finish. 100ms = 0.1 sec = 53,333.3333 loops
			bne			loop1
			POP			{PC}
			endp