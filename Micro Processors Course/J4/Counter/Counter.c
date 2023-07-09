/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
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
#include <delay.h>

// Declare your global variables here

unsigned int counter = 0;
int res = 0;
unsigned char segments[] = {0XEB,0X88,0XB3,0XBA,0XD8,0X7A,0X7B,0XA8,0XFB,0XFA};


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




while (1)
      { 
        PORTK = segments[counter%10];
        PORTF = 0x80; 
        delay_ms(5);  
         
        PORTK = segments[(counter/10)%10];
        PORTF = 0x40; 
        delay_ms(5);  
        
        PORTK = segments[(counter/100)%10];
        PORTF = 0x20; 
        delay_ms(5);  
        
        PORTK = segments[(counter/1000)%10];
        PORTF = 0x10; 
        delay_ms(5);
        if (res == 60){
            res = 0;
            counter++;
            }  
        res++;   
        
        
          

      }
}
