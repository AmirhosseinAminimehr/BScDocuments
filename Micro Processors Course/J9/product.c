/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/14/2019
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

// Alphanumeric LCD functions
#include <alcd.h>
#include <delay.h>
#include <stdlib.h>

// Declare your global variables here

int operand1 = -1;
int operand2 = -1;
char flag = 0;
char operation;
char result_char[4];
int result;

void calc(char a){

    if(a == 1 || a == 2 || a == 3 || a == 4 || a == 5 || a == 6 || a == 7 || a == 8 || a == 9 || a == 0){
        if(!flag){ 
            if ( operand1 != -1){
            operand1 = operand1 * 10 + a;
            }  
            else{
                operand1 = a; 
            }
        }
        else{
            if ( operand2 != -1){
                operand2 = operand2 * 10 + a;   
            }  
            else{
                operand2 = a;
            }
        }  
    }
    else if( a == '='){
        if (operation == '+'){
            result = operand1 + operand2;
        }   
        else if (operation == '-'){
            result = operand1 - operand2;
        }                                
        else if (operation == '*'){
            result = operand1 * operand2;
        }                               
        else if (operation == '/'){
            result = operand1 / operand2;
        } 
        operand1 = -1;
        operand2 = -1;
        flag = 0;
        itoa(result, result_char);
    }  
    else if (a == 'c') {
        operand1 = operand2 = -1; 
       flag = 0;
    }
        
    else {
        operation = a; 
        flag = !flag;
    }
        
    
    

}


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
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=0 State6=0 State5=0 State4=0 State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x0F;

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTC Bit 0
// RD - PORTC Bit 1
// EN - PORTC Bit 2
// D4 - PORTC Bit 4
// D5 - PORTC Bit 5
// D6 - PORTC Bit 6
// D7 - PORTC Bit 7
// Characters/line: 16
lcd_init(16);

while (1)
      {   
        int i;
        for(i = 0; i < 4; i++) {      
                if(i == 0){
                
        
                    PORTD.0 = 1;
                    if(PIND.4 == 1 ){
                
                        lcd_putchar('7');
                        calc(7); 
                           
                    }      
                    if(PIND.5 == 1 ){
                
                        lcd_putchar('8');
                        calc(8);    
                    }
                    if(PIND.6 == 1 ){
                
                        lcd_putchar('9'); 
                        calc(9);   
                    }
                    if(PIND.7 == 1 ){
                
                        lcd_putchar('/');
                        calc('/');
                            
                    }
                
                      
                    
                }
                else if(i == 1){
                
        
                    PORTD.1 = 1;
                    if(PIND.4 == 1 ){
                
                        lcd_putchar('4'); 
                        calc(4);   
                    }      
                    if(PIND.5 == 1 ){
                
                        lcd_putchar('5');
                        calc(5);    
                    }
                    if(PIND.6 == 1 ){
                
                        lcd_putchar('6');
                        calc(6);    
                    }
                    if(PIND.7 == 1 ){
                
                        lcd_putchar('*');
                        calc('*');    
                    }
                
                      
                    
                }    
                else if(i == 2){
                
        
                    PORTD.2 = 1;
                    if(PIND.4 == 1 ){
                
                        lcd_putchar('1');
                        calc(1);    
                    }      
                    if(PIND.5 == 1 ){
                
                        lcd_putchar('2');
                        calc(2);    
                    }
                    if(PIND.6 == 1 ){
                
                        lcd_putchar('3');   
                        calc(3); 
                    }
                    if(PIND.7 == 1 ){
                
                        lcd_putchar('-');   
                        calc('-'); 
                    }
                
                      
                    
                }    
                else if(i == 3){
                
        
                    PORTD.3 = 1;
                    if(PIND.4 == 1 ){
                
                        lcd_clear();
                        calc('c');   
                        
                    }      
                    if(PIND.5 == 1 ){
                
                        lcd_putchar('0');
                        calc(0);    
                    }
                    if(PIND.6 == 1 ){
                
                         
                        calc('=');
                        lcd_clear();
                        lcd_puts(result_char);   
                    }
                    if(PIND.7 == 1 ){
                
                        lcd_putchar('+');    
                        calc('+');
                    }
                }
                PORTD = 0;  
                
         } 
         delay_ms(200);   
            
            
        

      }
}
