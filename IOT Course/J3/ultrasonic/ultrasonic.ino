#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_PCD8544.h>

long duration, distanceCm, distanceIn;
#define TRIG_PIN 9
#define ECHO_PIN 8

Adafruit_PCD8544 display = Adafruit_PCD8544(7, 6, 5, 4, 3);


void setup() {

  display.begin();
  // init done

  // you can change the contrast around to adapt the display
  // for the best viewing!
  display.setContrast(50);

  display.display(); // show splashscreen
  delay(2000);
  display.clearDisplay();   // clears the screen and buffer

  Serial.begin(9600);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
}

void loop() {
  display.clearDisplay();
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  duration = pulseIn(ECHO_PIN,HIGH);

  distanceCm = duration / 29.1 / 2 ;
  distanceIn = duration / 74 / 2;
  if (distanceCm <= 0){
     Serial.println("Out of range");
  }
  else {
    display.println(distanceCm);
 }
 display.display();
}
