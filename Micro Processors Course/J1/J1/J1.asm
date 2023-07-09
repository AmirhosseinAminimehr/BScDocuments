.include "m1280def.inc"

LDI 	R16, HIGH(RAMEND)
OUT		SPH, R16
LDI		R16, LOW(RAMEND)
OUT 	SPL, R16


LDI		R16, 0xFF
STS		DDRJ, R16
LDI		R16, 0x01

BOTTOMUP:
STS		PORTJ, R16
CALL DELAY
LSL		R16
CPI		R16, 0x80
BREQ	TOPDOWN
RJMP	BOTTOMUP


TOPDOWN:
STS		PORTJ, R16
CALL DELAY
LSR		R16
CPI		R16, 0x01
BREQ	BOTTOMUP
RJMP	TOPDOWN


DELAY:	LDI		R20,0xFF
L1:		LDI		R21,0xFF
L2:		LDI		R22,0x10
L3:		NOP
		DEC R22
		BRNE	L3
		DEC		R21
		BRNE	L2
		DEC		R20
		BRNE	L1
		RET





HERE: RJMP HERE





