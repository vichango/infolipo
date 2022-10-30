/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();
  
  switch (message) {
    case "/start":
      loop();
      println("Started draw loop");
      break;
    case "/stop":
      noLoop();
      println("Stopped draw loop");
      break;
    case "/block":
      mainSet.addBlock(lastNote, lastAmplitude);
      // println("Add block");
      break;
    case "/note":
      lastNote = theOscMessage.get(0).intValue();
      lastAmplitude = pow(theOscMessage.get(1).floatValue(), 0.25);
      // println("Note: " + lastNote + " Amp:" + lastAmplitude);
      break;
  }
}
