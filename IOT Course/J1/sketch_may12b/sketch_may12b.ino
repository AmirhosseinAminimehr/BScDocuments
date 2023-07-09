#include <Adafruit_GFX.h>
#include <Adafruit_SPITFT.h>
#include <Adafruit_SPITFT_Macros.h>


#include <Adafruit_PCD8544.h>



Adafruit_PCD8544 display = Adafruit_PCD8544(7, 6, 5, 4, 3);




void setup() {
  // put your setup code here, to run once:
   Serial.begin(9600);

  
  
  display.begin();
  display.setTextSize(2);

  display.setContrast(50);
  display.clearDisplay();
  display.print("$NOOP  ");
  display.display(); // show splashscreen
  delay(2000);

 
  
  

}
unsigned long time;
void loop() {
  // put your main code here, to run repeatedly:
  drawrect(display.height());
  drawrect(display.height()/3);
  display.display();
   
 //prints time since program started
  delay(1000); 
    // read all the available characters
    while (Serial.available() > 0) {
      // display each character to the LCD
      
      display.write(Serial.read());
      
    }
    

    display.display();
  

}

void drawrect (uint8_t h) {
  display.drawRect(0,0,display.width() , h , BLACK);
}
