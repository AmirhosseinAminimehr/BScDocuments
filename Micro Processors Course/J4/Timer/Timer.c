/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 3/12/2019
Author  : admin
Company : IUST
Comments: 


Chip type               : ATmega1280
Program type            : Application
AVR Core Clock frequency: 11.059200 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 2048
*****************************************************/

#include <mega1280.h>

unsigned int counter = 0;
int numbers[] = {0,0,0,0};
int turn = 0;
unsigned char segments[] = {0XEB,0X88,0XB3,0XBA,0XD8,0X7A,0X7B,0XA8,0XFB,0XFA};

// Timer 0 output compare A interrupt service routine
interrupt [TIM0_COMPA] void timer0_compa_isr(void)
{
    if (turn == 0){
        PORTK = segments[numbers[0]];
        PORTF = 0x80;  
        }       
    if (turn == 1){
        PORTK = segments[numbers[1]];
        PORTF = 0x40;  
        }
    if (turn == 2){
        PORTK = segments[numbers[2]] | 0x04 ;
        PORTF = 0x20;  
        }
    if (turn == 3){
        PORTK = segments[numbers[3]];
        PORTF = 0x10;  
        }       
    turn ++;
    if (turn == 4){
        turn = 0;
    }

}

interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
    numbers[0]++;
    if(numbers[0] == 10){
        numbers[1]++;
        numbers[0] = 0;
    }
    
    if(numbers[1] == 6){
        numbers[2]++;
        numbers[1] = 0;
    }
    
    if(numbers[2] == 10){
        numbers[3]++;
        numbers[2] = 0;
    }
    
    if(numbers[3] == 6){
        numbers[3] = 0;
    }

}

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif





// Port F initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=0 State6=0 State5=0 State4=0 State3=T State2=T State1=T State0=T 
PORTF=0x00;
DDRF=0xF0;

// Port K initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTK=0x00;
DDRK=0xFF;


// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 10.800 kHz
// Mode: CTC top=OCR0A
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x02;
TCCR0B=0x05;
TCNT0=0x00;
OCR0A=0x16;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 10.800 kHz
// Mode: CTC top=OCR1A
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x0D;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x2A;
OCR1AL=0x30;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x02;

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x02;

// Global enable interrupts
#asm("sei")

while (1)
      {
      // Place your code here

      }
}
