/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/7/2019
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
#include <stdlib.h>

// Alphanumeric LCD functions
#include <alcd.h>

// Standard Input/Output functions
#include <stdio.h>

// Declare your global variables here
int x = 0;
int y =0;

void updatePos(int flag)
{
    if (flag) {
        if(1 + x > 15) {
            if (y == 1) {
                lcd_clear();
                x = 0;
                y = 0;
                return ;
            }
            y = 1;
            x = 0;    
        }  
        else {
                x ++;
        }
    } else {
        if(x == 0) {
            if (y == 1) { 
                y = 0;
                x = 15;
            }    
        } else{
            x --;
        }       
        
        
        
    }

}

void main(void)
{
// Declare your local variables here
char a, b[3];
// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x00;

// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTE=0x00;
DDRE=0x00;

// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTF=0x00;
DDRF=0x00;

// Port G initialization
// Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State5=T State4=T State3=T State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x00;

// Port H initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTH=0x00;
DDRH=0x00;

// Port J initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTJ=0x00;
DDRJ=0x00;

// Port K initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTK=0x00;
DDRK=0x00;

// Port L initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTL=0x00;
DDRL=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: Off
// USART0 Mode: Sync. Slave UCPOL=0
UCSR0A=0x00;
UCSR0B=0x10;
UCSR0C=0x46;
// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 16
lcd_init(16);

while (1)
      {
        // Place your code here
        a = getchar();
        itoa(a, b);
        switch(a){
            case 0x1C:               
                lcd_gotoxy(x, y);
                lcd_putchar('A');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x32:               
                lcd_gotoxy(x, y);
                lcd_putchar('B');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x21:               
                lcd_gotoxy(x, y);
                lcd_putchar('C');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x23:               
                lcd_gotoxy(x, y);
                lcd_putchar('D');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x24:               
                lcd_gotoxy(x, y);
                lcd_putchar('E');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x2B:               
                lcd_gotoxy(x, y);
                lcd_putchar('F');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x34:               
                lcd_gotoxy(x, y);
                lcd_putchar('G');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x33:               
                lcd_gotoxy(x, y);
                lcd_putchar('H');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x43:               
                lcd_gotoxy(x, y);
                lcd_putchar('I');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x3B:               
                lcd_gotoxy(x, y);
                lcd_putchar('J');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x42:               
                lcd_gotoxy(x, y);
                lcd_putchar('K');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x4B:               
                lcd_gotoxy(x, y);
                lcd_putchar('L');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x3A:               
                lcd_gotoxy(x, y);
                lcd_putchar('M');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x31:               
                lcd_gotoxy(x, y);
                lcd_putchar('N');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x44:               
                lcd_gotoxy(x, y);
                lcd_putchar('O');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x4D:               
                lcd_gotoxy(x, y);
                lcd_putchar('P');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x15:               
                lcd_gotoxy(x, y);
                lcd_putchar('Q');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x2D:               
                lcd_gotoxy(x, y);
                lcd_putchar('R');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x1B:               
                lcd_gotoxy(x, y);
                lcd_putchar('S');
                updatePos(1);
                getchar();getchar();  
                break;                    
            case 0x2C:               
                lcd_gotoxy(x, y);
                lcd_putchar('T');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x3C:               
                lcd_gotoxy(x, y);
                lcd_putchar('U');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x2A:               
                lcd_gotoxy(x, y);
                lcd_putchar('V');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x1D:               
                lcd_gotoxy(x, y);
                lcd_putchar('W');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x22:               
                lcd_gotoxy(x, y);
                lcd_putchar('X');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x35:               
                lcd_gotoxy(x, y);
                lcd_putchar('Y');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x1A:               
                lcd_gotoxy(x, y);
                lcd_putchar('Z');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x45:               
                lcd_gotoxy(x, y);
                lcd_putchar('0');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x16:               
                lcd_gotoxy(x, y);
                lcd_putchar('1');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x1E:               
                lcd_gotoxy(x, y);
                lcd_putchar('2');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x26:               
                lcd_gotoxy(x, y);
                lcd_putchar('3');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x25:               
                lcd_gotoxy(x, y);
                lcd_putchar('4');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x2E:               
                lcd_gotoxy(x, y);
                lcd_putchar('5');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x36:               
                lcd_gotoxy(x, y);
                lcd_putchar('6');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x3D:               
                lcd_gotoxy(x, y);
                lcd_putchar('7');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x3E:               
                lcd_gotoxy(x, y);
                lcd_putchar('8');
                updatePos(1);
                getchar();getchar();  
                break;
            case 0x46:               
                lcd_gotoxy(x, y);
                lcd_putchar('9');
                updatePos(1);
                getchar();getchar();  
                break;
            
            case 0x66:
                updatePos(0);
                lcd_gotoxy(x,y);
                updatePos(1);
                lcd_putchar(32);
                updatePos(0);
                getchar();getchar();    
                break;
        }
      }
}
