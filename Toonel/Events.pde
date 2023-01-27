/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();

  switch (message) {
    // case "/start":
    //   println("Started draw loop");
    //   loop();
    //   break;
    // case "/stop":
    //   println("Stopped draw loop");
    //   noLoop();
    //   break;
    // case "/block":
    //   println("Add block");
    //   mainSet.addBlock(lastNote, lastAmplitude);
    //   break;
    case "/A":
      int lastNoteTmp = lastNote;

      // float freq, int note, float ampl
      lastFreq = theOscMessage.get(0).floatValue();
      lastNote = theOscMessage.get(1).intValue();
      lastAmplitude = gain * theOscMessage.get(2).floatValue();
      // lastAmplitude = pow(theOscMessage.get(1).floatValue(), 0.25);

      // lastFreq = 157.34265;
      // lastNote = 51;
      // lastAmplitude = 0.393984;

      // Freq: 157.34265 Note: 51 Amp:0.429824
      // Freq: 157.16487 Note: 51 Amp:0.429824
      // Freq: 157.11948 Note: 51 Amp:0.429824
      // Freq: 157.4344 Note: 51 Amp:0.399616
      // Freq: 157.11948 Note: 51 Amp:0.393984

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
        // mainSet.addBlock(157.34265, 51, 0.429824);
      }

      break;
  }
}
