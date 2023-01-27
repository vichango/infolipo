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

      println("Freq: " + lastFreq + " Note: " + lastNote + " Amp:" + lastAmplitude);

      // if (!started && 0.5 < lastAmplitude) {
      //   started = true;
      //   println("Started draw loop");
      //   loop();
      // }

      // if (60 > lastNote) {
      //   mainSet.addBlock(lastFreq, lastNote, lastAmplitude);
      // }

      if (lastNoteTmp != lastNote || 0.001 > lastAmplitude) {
        println("Add block");
        mainSet.addBlock(lastFreq, lastNote, lastAmplitude);
      }

      break;
  }
}
