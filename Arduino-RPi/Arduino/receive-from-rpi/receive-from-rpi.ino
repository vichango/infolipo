/**
 * Echo back a string received over serial port and match LED with silences.
 */

void setup(){
  Serial.begin(9600);
}
 
void loop(){
  if(Serial.available() > 0) {
    String allData = Serial.readStringUntil('\n');

    // Header.
    int firstSpace = allData.indexOf(' ');
    String message = allData.substring(0, firstSpace);

    // From message.
    String firstSubData = allData.substring(firstSpace + 1);

    // Frequency.
    int secondSpace = firstSubData.indexOf(' ');
    String frequency = firstSubData.substring(0, secondSpace);
    
    // From frequency.
    String secondSubData = firstSubData.substring(secondSpace + 1);

    // Midi.
    int thirdSpace = secondSubData.indexOf(' ');
    int midi = secondSubData.substring(0, thirdSpace).toInt();
    
    // From Midi.
    String thirdSubData = secondSubData.substring(0, thirdSpace);
    
    // Amplitude.
    String amplitude = secondSubData.substring(thirdSpace + 1);
    
    Serial.print("Echo: ");
    Serial.println(allData);

    int test = 1;
    if (-999 < midi) {
      digitalWrite(LED_BUILTIN, HIGH);
    } else {
      digitalWrite(LED_BUILTIN, LOW);
    }
  }
}
