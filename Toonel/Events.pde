/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();

  switch (message) {
    case "/A":
      int lastNoteTmp = lastNote;

      // float freq, int note, float ampl
      lastFreq = theOscMessage.get(0).floatValue();
      lastNote = theOscMessage.get(1).intValue();
      lastAmplitude = gain * theOscMessage.get(2).floatValue();

      if (lastNoteTmp != lastNote || (-999 < lastNote && silenceThresh > lastAmplitude)) {
        mainSet.addBlock(lastFreq, lastNote, lastAmplitude);
      }

      break;
  }
}
