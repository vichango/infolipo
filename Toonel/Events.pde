/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();

  switch (message) {
    case "/A":
      int lastANoteTmp = lastNote;

      // float freq, int note, float ampl
      lastFreq = theOscMessage.get(0).floatValue();
      lastNote = theOscMessage.get(1).intValue();
      lastAmplitude = gain * theOscMessage.get(2).floatValue();

      if (-999 < lastNote && (lastANoteTmp != lastNote || silenceThresh > lastAmplitude)) {
        mainSet.addBlock(lastFreq, lastNote, lastAmplitude);
      }

      break;
    case "/B":
      int lastBNoteTmp = lastNote;

      // float freq, int note, float ampl
      lastFreq = theOscMessage.get(0).floatValue();
      lastNote = theOscMessage.get(1).intValue();
      lastAmplitude = gain * theOscMessage.get(2).floatValue();

      if (-999 < lastNote && (lastBNoteTmp != lastNote || silenceThresh > lastAmplitude)) {
        secondarySet.addBlock(lastFreq, lastNote, lastAmplitude);
      }

      break;
  }
}
