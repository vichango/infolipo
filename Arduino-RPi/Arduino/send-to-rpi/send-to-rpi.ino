/**
 * Send strings to Raspberry Pi.
 */
 
void setup(){
  // Set the baud rate  
  Serial.begin(9600); 
}
 
void loop(){ 
  // Print message over serial every second.
  Serial.println("Hello RPi!");
  delay(5000);
}
