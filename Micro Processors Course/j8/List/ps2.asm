
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega1280
;Program type             : Application
;Clock frequency          : 11.059200 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega1280
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8703
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0200
	.EQU __SRAM_END=0x21FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _x=R3
	.DEF _y=R5
	.DEF __lcd_x=R8
	.DEF __lcd_y=R7
	.DEF __lcd_maxx=R10

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x38:
	.DB  0x0,0x0,0x0,0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x03
	.DW  _0x38*2

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.3 Standard
;Automatic Program Generator
;© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 5/7/2019
;Author  : admin
;Company : IUST
;Comments:
;
;
;Chip type               : ATmega1280
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 2048
;*****************************************************/
;
;#include <mega1280.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <stdlib.h>
;
;// Alphanumeric LCD functions
;#include <alcd.h>
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Declare your global variables here
;int x = 0;
;int y =0;
;
;void updatePos(int flag)
; 0000 0026 {

	.CSEG
_updatePos:
; 0000 0027     if (flag) {
	ST   -Y,R27
	ST   -Y,R26
;	flag -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BREQ _0x3
; 0000 0028         if(1 + x > 15) {
	__GETW2R 3,4
	ADIW R26,1
	SBIW R26,16
	BRLT _0x4
; 0000 0029             if (y == 1) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R5
	CPC  R31,R6
	BRNE _0x5
; 0000 002A                 lcd_clear();
	CALL _lcd_clear
; 0000 002B                 x = 0;
	CLR  R3
	CLR  R4
; 0000 002C                 y = 0;
	CLR  R5
	CLR  R6
; 0000 002D                 return ;
	JMP  _0x20C0002
; 0000 002E             }
; 0000 002F             y = 1;
_0x5:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__PUTW1R 5,6
; 0000 0030             x = 0;
	CLR  R3
	CLR  R4
; 0000 0031         }
; 0000 0032         else {
	RJMP _0x6
_0x4:
; 0000 0033                 x ++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 3,4,30,31
; 0000 0034         }
_0x6:
; 0000 0035     } else {
	RJMP _0x7
_0x3:
; 0000 0036         if(x == 0) {
	MOV  R0,R3
	OR   R0,R4
	BRNE _0x8
; 0000 0037             if (y == 1) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R5
	CPC  R31,R6
	BRNE _0x9
; 0000 0038                 y = 0;
	CLR  R5
	CLR  R6
; 0000 0039                 x = 15;
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	__PUTW1R 3,4
; 0000 003A             }
; 0000 003B         } else{
_0x9:
	RJMP _0xA
_0x8:
; 0000 003C             x --;
	__GETW1R 3,4
	SBIW R30,1
	__PUTW1R 3,4
; 0000 003D         }
_0xA:
; 0000 003E 
; 0000 003F 
; 0000 0040 
; 0000 0041     }
_0x7:
; 0000 0042 
; 0000 0043 }
	JMP  _0x20C0002
;
;void main(void)
; 0000 0046 {
_main:
; 0000 0047 // Declare your local variables here
; 0000 0048 char a, b[3];
; 0000 0049 // Crystal Oscillator division factor: 1
; 0000 004A #pragma optsize-
; 0000 004B CLKPR=0x80;
	SBIW R28,3
;	a -> R17
;	b -> Y+0
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 004C CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 004D #ifdef _OPTIMIZE_SIZE_
; 0000 004E #pragma optsize+
; 0000 004F #endif
; 0000 0050 
; 0000 0051 // Input/Output Ports initialization
; 0000 0052 // Port A initialization
; 0000 0053 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0054 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0055 PORTA=0x00;
	OUT  0x2,R30
; 0000 0056 DDRA=0x00;
	OUT  0x1,R30
; 0000 0057 
; 0000 0058 // Port B initialization
; 0000 0059 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005B PORTB=0x00;
	OUT  0x5,R30
; 0000 005C DDRB=0x00;
	OUT  0x4,R30
; 0000 005D 
; 0000 005E // Port C initialization
; 0000 005F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0060 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0061 PORTC=0x00;
	OUT  0x8,R30
; 0000 0062 DDRC=0x00;
	OUT  0x7,R30
; 0000 0063 
; 0000 0064 // Port D initialization
; 0000 0065 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0066 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0067 PORTD=0x00;
	OUT  0xB,R30
; 0000 0068 DDRD=0x00;
	OUT  0xA,R30
; 0000 0069 
; 0000 006A // Port E initialization
; 0000 006B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006D PORTE=0x00;
	OUT  0xE,R30
; 0000 006E DDRE=0x00;
	OUT  0xD,R30
; 0000 006F 
; 0000 0070 // Port F initialization
; 0000 0071 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0072 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0073 PORTF=0x00;
	OUT  0x11,R30
; 0000 0074 DDRF=0x00;
	OUT  0x10,R30
; 0000 0075 
; 0000 0076 // Port G initialization
; 0000 0077 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0078 // State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0079 PORTG=0x00;
	OUT  0x14,R30
; 0000 007A DDRG=0x00;
	OUT  0x13,R30
; 0000 007B 
; 0000 007C // Port H initialization
; 0000 007D // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 007E // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 007F PORTH=0x00;
	STS  258,R30
; 0000 0080 DDRH=0x00;
	STS  257,R30
; 0000 0081 
; 0000 0082 // Port J initialization
; 0000 0083 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0084 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0085 PORTJ=0x00;
	STS  261,R30
; 0000 0086 DDRJ=0x00;
	STS  260,R30
; 0000 0087 
; 0000 0088 // Port K initialization
; 0000 0089 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 008A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 008B PORTK=0x00;
	STS  264,R30
; 0000 008C DDRK=0x00;
	STS  263,R30
; 0000 008D 
; 0000 008E // Port L initialization
; 0000 008F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0090 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0091 PORTL=0x00;
	STS  267,R30
; 0000 0092 DDRL=0x00;
	STS  266,R30
; 0000 0093 
; 0000 0094 // USART0 initialization
; 0000 0095 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0096 // USART0 Receiver: On
; 0000 0097 // USART0 Transmitter: Off
; 0000 0098 // USART0 Mode: Sync. Slave UCPOL=0
; 0000 0099 UCSR0A=0x00;
	STS  192,R30
; 0000 009A UCSR0B=0x10;
	LDI  R30,LOW(16)
	STS  193,R30
; 0000 009B UCSR0C=0x46;
	LDI  R30,LOW(70)
	STS  194,R30
; 0000 009C // Alphanumeric LCD initialization
; 0000 009D // Connections are specified in the
; 0000 009E // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 009F // RS - PORTA Bit 0
; 0000 00A0 // RD - PORTA Bit 1
; 0000 00A1 // EN - PORTA Bit 2
; 0000 00A2 // D4 - PORTA Bit 4
; 0000 00A3 // D5 - PORTA Bit 5
; 0000 00A4 // D6 - PORTA Bit 6
; 0000 00A5 // D7 - PORTA Bit 7
; 0000 00A6 // Characters/line: 16
; 0000 00A7 lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 00A8 
; 0000 00A9 while (1)
_0xB:
; 0000 00AA       {
; 0000 00AB         // Place your code here
; 0000 00AC         a = getchar();
	CALL _getchar
	MOV  R17,R30
; 0000 00AD         itoa(a, b);
	MOV  R30,R17
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,2
	CALL _itoa
; 0000 00AE         switch(a){
	MOV  R30,R17
	LDI  R31,0
; 0000 00AF             case 0x1C:
	CPI  R30,LOW(0x1C)
	LDI  R26,HIGH(0x1C)
	CPC  R31,R26
	BRNE _0x11
; 0000 00B0                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00B1                 lcd_putchar('A');
	LDI  R26,LOW(65)
	CALL _lcd_putchar
; 0000 00B2                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00B3                 getchar();getchar();
; 0000 00B4                 break;
; 0000 00B5             case 0x32:
_0x11:
	CPI  R30,LOW(0x32)
	LDI  R26,HIGH(0x32)
	CPC  R31,R26
	BRNE _0x12
; 0000 00B6                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00B7                 lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL _lcd_putchar
; 0000 00B8                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00B9                 getchar();getchar();
; 0000 00BA                 break;
; 0000 00BB             case 0x21:
_0x12:
	CPI  R30,LOW(0x21)
	LDI  R26,HIGH(0x21)
	CPC  R31,R26
	BRNE _0x13
; 0000 00BC                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00BD                 lcd_putchar('C');
	LDI  R26,LOW(67)
	CALL _lcd_putchar
; 0000 00BE                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00BF                 getchar();getchar();
; 0000 00C0                 break;
; 0000 00C1             case 0x23:
_0x13:
	CPI  R30,LOW(0x23)
	LDI  R26,HIGH(0x23)
	CPC  R31,R26
	BRNE _0x14
; 0000 00C2                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00C3                 lcd_putchar('D');
	LDI  R26,LOW(68)
	CALL _lcd_putchar
; 0000 00C4                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00C5                 getchar();getchar();
; 0000 00C6                 break;
; 0000 00C7             case 0x24:
_0x14:
	CPI  R30,LOW(0x24)
	LDI  R26,HIGH(0x24)
	CPC  R31,R26
	BRNE _0x15
; 0000 00C8                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00C9                 lcd_putchar('E');
	LDI  R26,LOW(69)
	CALL _lcd_putchar
; 0000 00CA                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00CB                 getchar();getchar();
; 0000 00CC                 break;
; 0000 00CD             case 0x2B:
_0x15:
	CPI  R30,LOW(0x2B)
	LDI  R26,HIGH(0x2B)
	CPC  R31,R26
	BRNE _0x16
; 0000 00CE                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00CF                 lcd_putchar('F');
	LDI  R26,LOW(70)
	CALL _lcd_putchar
; 0000 00D0                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00D1                 getchar();getchar();
; 0000 00D2                 break;
; 0000 00D3             case 0x34:
_0x16:
	CPI  R30,LOW(0x34)
	LDI  R26,HIGH(0x34)
	CPC  R31,R26
	BRNE _0x17
; 0000 00D4                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00D5                 lcd_putchar('G');
	LDI  R26,LOW(71)
	CALL _lcd_putchar
; 0000 00D6                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00D7                 getchar();getchar();
; 0000 00D8                 break;
; 0000 00D9             case 0x33:
_0x17:
	CPI  R30,LOW(0x33)
	LDI  R26,HIGH(0x33)
	CPC  R31,R26
	BRNE _0x18
; 0000 00DA                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00DB                 lcd_putchar('H');
	LDI  R26,LOW(72)
	CALL _lcd_putchar
; 0000 00DC                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00DD                 getchar();getchar();
; 0000 00DE                 break;
; 0000 00DF             case 0x43:
_0x18:
	CPI  R30,LOW(0x43)
	LDI  R26,HIGH(0x43)
	CPC  R31,R26
	BRNE _0x19
; 0000 00E0                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00E1                 lcd_putchar('I');
	LDI  R26,LOW(73)
	CALL _lcd_putchar
; 0000 00E2                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00E3                 getchar();getchar();
; 0000 00E4                 break;
; 0000 00E5             case 0x3B:
_0x19:
	CPI  R30,LOW(0x3B)
	LDI  R26,HIGH(0x3B)
	CPC  R31,R26
	BRNE _0x1A
; 0000 00E6                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00E7                 lcd_putchar('J');
	LDI  R26,LOW(74)
	CALL _lcd_putchar
; 0000 00E8                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00E9                 getchar();getchar();
; 0000 00EA                 break;
; 0000 00EB             case 0x42:
_0x1A:
	CPI  R30,LOW(0x42)
	LDI  R26,HIGH(0x42)
	CPC  R31,R26
	BRNE _0x1B
; 0000 00EC                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00ED                 lcd_putchar('K');
	LDI  R26,LOW(75)
	CALL _lcd_putchar
; 0000 00EE                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00EF                 getchar();getchar();
; 0000 00F0                 break;
; 0000 00F1             case 0x4B:
_0x1B:
	CPI  R30,LOW(0x4B)
	LDI  R26,HIGH(0x4B)
	CPC  R31,R26
	BRNE _0x1C
; 0000 00F2                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00F3                 lcd_putchar('L');
	LDI  R26,LOW(76)
	CALL _lcd_putchar
; 0000 00F4                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00F5                 getchar();getchar();
; 0000 00F6                 break;
; 0000 00F7             case 0x3A:
_0x1C:
	CPI  R30,LOW(0x3A)
	LDI  R26,HIGH(0x3A)
	CPC  R31,R26
	BRNE _0x1D
; 0000 00F8                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00F9                 lcd_putchar('M');
	LDI  R26,LOW(77)
	CALL _lcd_putchar
; 0000 00FA                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 00FB                 getchar();getchar();
; 0000 00FC                 break;
; 0000 00FD             case 0x31:
_0x1D:
	CPI  R30,LOW(0x31)
	LDI  R26,HIGH(0x31)
	CPC  R31,R26
	BRNE _0x1E
; 0000 00FE                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 00FF                 lcd_putchar('N');
	LDI  R26,LOW(78)
	CALL _lcd_putchar
; 0000 0100                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0101                 getchar();getchar();
; 0000 0102                 break;
; 0000 0103             case 0x44:
_0x1E:
	CPI  R30,LOW(0x44)
	LDI  R26,HIGH(0x44)
	CPC  R31,R26
	BRNE _0x1F
; 0000 0104                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0105                 lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL _lcd_putchar
; 0000 0106                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0107                 getchar();getchar();
; 0000 0108                 break;
; 0000 0109             case 0x4D:
_0x1F:
	CPI  R30,LOW(0x4D)
	LDI  R26,HIGH(0x4D)
	CPC  R31,R26
	BRNE _0x20
; 0000 010A                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 010B                 lcd_putchar('P');
	LDI  R26,LOW(80)
	CALL _lcd_putchar
; 0000 010C                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 010D                 getchar();getchar();
; 0000 010E                 break;
; 0000 010F             case 0x15:
_0x20:
	CPI  R30,LOW(0x15)
	LDI  R26,HIGH(0x15)
	CPC  R31,R26
	BRNE _0x21
; 0000 0110                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0111                 lcd_putchar('Q');
	LDI  R26,LOW(81)
	CALL _lcd_putchar
; 0000 0112                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0113                 getchar();getchar();
; 0000 0114                 break;
; 0000 0115             case 0x2D:
_0x21:
	CPI  R30,LOW(0x2D)
	LDI  R26,HIGH(0x2D)
	CPC  R31,R26
	BRNE _0x22
; 0000 0116                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0117                 lcd_putchar('R');
	LDI  R26,LOW(82)
	CALL _lcd_putchar
; 0000 0118                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0119                 getchar();getchar();
; 0000 011A                 break;
; 0000 011B             case 0x1B:
_0x22:
	CPI  R30,LOW(0x1B)
	LDI  R26,HIGH(0x1B)
	CPC  R31,R26
	BRNE _0x23
; 0000 011C                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 011D                 lcd_putchar('S');
	LDI  R26,LOW(83)
	CALL _lcd_putchar
; 0000 011E                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 011F                 getchar();getchar();
; 0000 0120                 break;
; 0000 0121             case 0x2C:
_0x23:
	CPI  R30,LOW(0x2C)
	LDI  R26,HIGH(0x2C)
	CPC  R31,R26
	BRNE _0x24
; 0000 0122                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0123                 lcd_putchar('T');
	LDI  R26,LOW(84)
	CALL _lcd_putchar
; 0000 0124                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0125                 getchar();getchar();
; 0000 0126                 break;
; 0000 0127             case 0x3C:
_0x24:
	CPI  R30,LOW(0x3C)
	LDI  R26,HIGH(0x3C)
	CPC  R31,R26
	BRNE _0x25
; 0000 0128                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0129                 lcd_putchar('U');
	LDI  R26,LOW(85)
	CALL _lcd_putchar
; 0000 012A                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 012B                 getchar();getchar();
; 0000 012C                 break;
; 0000 012D             case 0x2A:
_0x25:
	CPI  R30,LOW(0x2A)
	LDI  R26,HIGH(0x2A)
	CPC  R31,R26
	BRNE _0x26
; 0000 012E                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 012F                 lcd_putchar('V');
	LDI  R26,LOW(86)
	CALL _lcd_putchar
; 0000 0130                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0131                 getchar();getchar();
; 0000 0132                 break;
; 0000 0133             case 0x1D:
_0x26:
	CPI  R30,LOW(0x1D)
	LDI  R26,HIGH(0x1D)
	CPC  R31,R26
	BRNE _0x27
; 0000 0134                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0135                 lcd_putchar('W');
	LDI  R26,LOW(87)
	CALL _lcd_putchar
; 0000 0136                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0137                 getchar();getchar();
; 0000 0138                 break;
; 0000 0139             case 0x22:
_0x27:
	CPI  R30,LOW(0x22)
	LDI  R26,HIGH(0x22)
	CPC  R31,R26
	BRNE _0x28
; 0000 013A                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 013B                 lcd_putchar('X');
	LDI  R26,LOW(88)
	CALL _lcd_putchar
; 0000 013C                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 013D                 getchar();getchar();
; 0000 013E                 break;
; 0000 013F             case 0x35:
_0x28:
	CPI  R30,LOW(0x35)
	LDI  R26,HIGH(0x35)
	CPC  R31,R26
	BRNE _0x29
; 0000 0140                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0141                 lcd_putchar('Y');
	LDI  R26,LOW(89)
	CALL _lcd_putchar
; 0000 0142                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0143                 getchar();getchar();
; 0000 0144                 break;
; 0000 0145             case 0x1A:
_0x29:
	CPI  R30,LOW(0x1A)
	LDI  R26,HIGH(0x1A)
	CPC  R31,R26
	BRNE _0x2A
; 0000 0146                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0147                 lcd_putchar('Z');
	LDI  R26,LOW(90)
	CALL _lcd_putchar
; 0000 0148                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0149                 getchar();getchar();
; 0000 014A                 break;
; 0000 014B             case 0x45:
_0x2A:
	CPI  R30,LOW(0x45)
	LDI  R26,HIGH(0x45)
	CPC  R31,R26
	BRNE _0x2B
; 0000 014C                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 014D                 lcd_putchar('0');
	LDI  R26,LOW(48)
	CALL _lcd_putchar
; 0000 014E                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 014F                 getchar();getchar();
; 0000 0150                 break;
; 0000 0151             case 0x16:
_0x2B:
	CPI  R30,LOW(0x16)
	LDI  R26,HIGH(0x16)
	CPC  R31,R26
	BRNE _0x2C
; 0000 0152                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0153                 lcd_putchar('1');
	LDI  R26,LOW(49)
	CALL _lcd_putchar
; 0000 0154                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0155                 getchar();getchar();
; 0000 0156                 break;
; 0000 0157             case 0x1E:
_0x2C:
	CPI  R30,LOW(0x1E)
	LDI  R26,HIGH(0x1E)
	CPC  R31,R26
	BRNE _0x2D
; 0000 0158                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0159                 lcd_putchar('2');
	LDI  R26,LOW(50)
	CALL _lcd_putchar
; 0000 015A                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 015B                 getchar();getchar();
; 0000 015C                 break;
; 0000 015D             case 0x26:
_0x2D:
	CPI  R30,LOW(0x26)
	LDI  R26,HIGH(0x26)
	CPC  R31,R26
	BRNE _0x2E
; 0000 015E                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 015F                 lcd_putchar('3');
	LDI  R26,LOW(51)
	CALL _lcd_putchar
; 0000 0160                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0161                 getchar();getchar();
; 0000 0162                 break;
; 0000 0163             case 0x25:
_0x2E:
	CPI  R30,LOW(0x25)
	LDI  R26,HIGH(0x25)
	CPC  R31,R26
	BRNE _0x2F
; 0000 0164                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0165                 lcd_putchar('4');
	LDI  R26,LOW(52)
	CALL _lcd_putchar
; 0000 0166                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0167                 getchar();getchar();
; 0000 0168                 break;
; 0000 0169             case 0x2E:
_0x2F:
	CPI  R30,LOW(0x2E)
	LDI  R26,HIGH(0x2E)
	CPC  R31,R26
	BRNE _0x30
; 0000 016A                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 016B                 lcd_putchar('5');
	LDI  R26,LOW(53)
	CALL _lcd_putchar
; 0000 016C                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 016D                 getchar();getchar();
; 0000 016E                 break;
; 0000 016F             case 0x36:
_0x30:
	CPI  R30,LOW(0x36)
	LDI  R26,HIGH(0x36)
	CPC  R31,R26
	BRNE _0x31
; 0000 0170                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0171                 lcd_putchar('6');
	LDI  R26,LOW(54)
	CALL _lcd_putchar
; 0000 0172                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0173                 getchar();getchar();
; 0000 0174                 break;
; 0000 0175             case 0x3D:
_0x31:
	CPI  R30,LOW(0x3D)
	LDI  R26,HIGH(0x3D)
	CPC  R31,R26
	BRNE _0x32
; 0000 0176                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0177                 lcd_putchar('7');
	LDI  R26,LOW(55)
	CALL _lcd_putchar
; 0000 0178                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0179                 getchar();getchar();
; 0000 017A                 break;
; 0000 017B             case 0x3E:
_0x32:
	CPI  R30,LOW(0x3E)
	LDI  R26,HIGH(0x3E)
	CPC  R31,R26
	BRNE _0x33
; 0000 017C                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 017D                 lcd_putchar('8');
	LDI  R26,LOW(56)
	CALL _lcd_putchar
; 0000 017E                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 017F                 getchar();getchar();
; 0000 0180                 break;
; 0000 0181             case 0x46:
_0x33:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x34
; 0000 0182                 lcd_gotoxy(x, y);
	CALL SUBOPT_0x0
; 0000 0183                 lcd_putchar('9');
	LDI  R26,LOW(57)
	CALL _lcd_putchar
; 0000 0184                 updatePos(1);
	LDI  R26,LOW(1)
	RJMP _0x37
; 0000 0185                 getchar();getchar();
; 0000 0186                 break;
; 0000 0187 
; 0000 0188             case 0x66:
_0x34:
	CPI  R30,LOW(0x66)
	LDI  R26,HIGH(0x66)
	CPC  R31,R26
	BRNE _0x10
; 0000 0189                 updatePos(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _updatePos
; 0000 018A                 lcd_gotoxy(x,y);
	CALL SUBOPT_0x0
; 0000 018B                 updatePos(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _updatePos
; 0000 018C                 lcd_putchar(32);
	LDI  R26,LOW(32)
	CALL _lcd_putchar
; 0000 018D                 updatePos(0);
	LDI  R26,LOW(0)
_0x37:
	LDI  R27,0
	RCALL _updatePos
; 0000 018E                 getchar();getchar();
	CALL _getchar
	CALL _getchar
; 0000 018F                 break;
; 0000 0190         }
_0x10:
; 0000 0191       }
	RJMP _0xB
; 0000 0192 }
_0x36:
	RJMP _0x36

	.CSEG
_itoa:
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
	ST   -Y,R26
	IN   R30,0x2
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x2,R30
	__DELAY_USB 7
	SBI  0x2,2
	__DELAY_USB 18
	CBI  0x2,2
	__DELAY_USB 18
	RJMP _0x20C0001
__lcd_write_data:
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 184
	RJMP _0x20C0001
_lcd_gotoxy:
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R8,Y+1
	LDD  R7,Y+0
_0x20C0002:
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R26,LOW(2)
	CALL SUBOPT_0x1
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x1
	LDI  R30,LOW(0)
	MOV  R7,R30
	MOV  R8,R30
	RET
_lcd_putchar:
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020005
	CP   R8,R10
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R7
	MOV  R26,R7
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x20C0001
_0x2020004:
	INC  R8
	SBI  0x2,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x2,0
	RJMP _0x20C0001
_lcd_init:
	ST   -Y,R26
	IN   R30,0x1
	ORI  R30,LOW(0xF0)
	OUT  0x1,R30
	SBI  0x1,2
	SBI  0x1,0
	SBI  0x1,1
	CBI  0x2,2
	CBI  0x2,0
	CBI  0x2,1
	LDD  R10,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x2
	CALL SUBOPT_0x2
	CALL SUBOPT_0x2
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 276
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_getchar:
_0x2040003:
	LDS  R30,192
	ANDI R30,LOW(0x80)
	BREQ _0x2040003
	LDS  R30,198
	RET

	.CSEG

	.CSEG

	.CSEG

	.DSEG
__seed_G100:
	.BYTE 0x4
__base_y_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 37 TIMES, CODE SIZE REDUCTION:69 WORDS
SUBOPT_0x0:
	ST   -Y,R3
	MOV  R26,R5
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G101
	__DELAY_USW 276
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xACD
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
