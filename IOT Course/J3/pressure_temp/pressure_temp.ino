#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>

#include <Adafruit_GFX.h>
#include <Adafruit_SPITFT.h>
#include <Adafruit_SPITFT_Macros.h>


#include <Adafruit_PCD8544.h>


#define BMP_SCK  (13)
#define BMP_MISO (12)
#define BMP_MOSI (11)
#define BMP_CS   (10)

Adafruit_BMP280 bmp;

Adafruit_PCD8544 display = Adafruit_PCD8544(7, 6, 5, 4, 3);




void setup() {
  
  // put your setup code here, to run once:
   Serial.begin(9600);
  
  bmp.begin();

  display.setTextSize(0);
  char text[7] = {' ','$','n','o','o','p'};
  display.setContrast(50);
  display.clearDisplay();
  display.display(); // show splashscreen
  delay(2000);
  for (int i;i < 7; i++)
  {
    display.write(text[i]);
  }
  
   display.println(F("BMP280 test"));

  if (!bmp.begin()) {
    display.println(F("Could not find a valid BMP280 sensor, check wiring!"));
    
  }
  display.display();

    bmp.setSampling(Adafruit_BMP280::MODE_NORMAL,     /* Operating Mode. */
                  Adafruit_BMP280::SAMPLING_X2,     /* Temp. oversampling */
                  Adafruit_BMP280::SAMPLING_X16,    /* Pressure oversampling */
                  Adafruit_BMP280::FILTER_X16,      /* Filtering. */
                  Adafruit_BMP280::STANDBY_MS_500);

}

void loop() {
  // put your main code here, to run repeatedly:
  drawrect(display.height());
  drawrect(display.height()/3);
 

    display.print(F("Temperature = "));
    display.print(bmp.readTemperature());
    display.println(" *C");

    display.print(F("Pressure = "));
    display.print(bmp.readPressure());
    display.println(" Pa");

    display.print(F("Approx altitude = "));
    display.print(bmp.readAltitude(1013.25)); /* Adjusted to local forecast! */
    display.println(" m");

    display.println();
    display.display();
    delay(2000);
  
  

}

void drawrect (uint8_t h) {
  display.drawRect(0,0,display.width() , h , BLACK);
}
