/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();

  switch (message) {
    case "/A":
    case "/B":
      // float freq, int note, float ampl
      currMessage = message;
      currFreq = theOscMessage.get(0).floatValue();
      currNote = theOscMessage.get(1).intValue();
      currAmplitude = gain * theOscMessage.get(2).floatValue();

      break;
  }
}
