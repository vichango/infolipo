/**
 * Echo back a string received over serial port.
 */

void setup(){
  Serial.begin(9600);
}
 
void loop(){
  if(Serial.available() > 0) {
    String data = Serial.readStringUntil('\n');
    Serial.print("Hi RPi! Echo: ");
    Serial.println(data);
  }
}
