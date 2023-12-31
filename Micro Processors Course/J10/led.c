/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/21/2019
Author  : admin
Company : IUST
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/

#include <mega32.h>
#include <delay.h>

// Declare your global variables here

/*
    Matrix Coder by Fattah-Tafreshi
    VAF-O-T
    2011
    Email:fattah.roland@gmail.com
 
    Code For C & C++
    Display: X=40  Y=8
    Text: ABCDEF
    Font: Tahoma
    Size: 7
 
    5/21/2019 5:13:36 PM
*/
 
const unsigned char Code[]=
{
    0x70,    //    .###....
    0x1C,    //    ...###..
    0x13,    //    ...#..##
    0x13,    //    ...#..##
    0x1C,    //    ...###..
    0x70,    //    .###....
    0x00,    //    ........
    0x7F,    //    .#######
    0x49,    //    .#..#..#
    0x49,    //    .#..#..#
    0x4E,    //    .#..###.
    0x30,    //    ..##....
    0x00,    //    ........
    0x1C,    //    ...###..
    0x22,    //    ..#...#.
    0x41,    //    .#.....#
    0x41,    //    .#.....#
    0x41,    //    .#.....#
    0x22,    //    ..#...#.
    0x00,    //    ........
    0x7F,    //    .#######
    0x41,    //    .#.....#
    0x41,    //    .#.....#
    0x41,    //    .#.....#
    0x22,    //    ..#...#.
    0x1C,    //    ...###..
    0x00,    //    ........
    0x7F,    //    .#######
    0x49,    //    .#..#..#
    0x49,    //    .#..#..#
    0x49,    //    .#..#..#
    0x41,    //    .#.....#
    0x00,    //    ........
    0x7F,    //    .#######
    0x09,    //    ....#..#
    0x09,    //    ....#..#
    0x09,    //    ....#..#
    0x01,    //    .......#
    0x00,    //    ........
    0x00,    //    ........
    0x00,    //    ........
    0x00,    //    ........
    0x00     //    ........
};

int i=0;
int base = 0;
int counter = 0;

void main(void)
{
// Declare your local variables here

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
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

while (1)
      {        while(counter < 5) {
                PORTD = 0x01;  
                for(i=0; i< 8; i++){
                    PORTC = ~Code[base + i];
                    delay_ms(5);
                    PORTD = PORTD*2;
                }                   
                counter++;
                }
            base++;
            delay_ms(20);
            if (base > 44)
                base = 0;
            counter = 0;
            
      }
}
