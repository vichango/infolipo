/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();
  
  switch (message) {
    case "/start":
      println("Started draw loop");
      loop();
      break;
    case "/stop":
      println("Stopped draw loop");
      noLoop();
      break;
    // case "/block":
    //   println("Add block");
    //   mainSet.addBlock(lastNote, lastAmplitude);
    //   break;
    case "/note":
      int lastNoteTmp = lastNote;
      
      // lastFreq = theOscMessage.get(0).floatValue();
      lastNote = theOscMessage.get(1).intValue();
      // lastAmplitude = pow(theOscMessage.get(1).floatValue(), 0.25);
      lastAmplitude = theOscMessage.get(2).floatValue();
      
      println("Note: " + lastNote + " Amp:" + lastAmplitude);
      
      if (lastNoteTmp != lastNote || 0.001 > lastAmplitude) {
        println("Add block");
        mainSet.addBlock(lastNote, lastAmplitude);
      }

      break;
  }
}
