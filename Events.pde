/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  String message = theOscMessage.addrPattern();
  
  if (theOscMessage.checkAddrPattern("/start")) {
    println("Looping");
    loop();
  }

  if (theOscMessage.checkAddrPattern("/stop")) {
    println("Stop looping");
    noLoop();
  }

  if (theOscMessage.checkAddrPattern("/bang")) {
    float frequence = theOscMessage.get(0).floatValue();

    mainSet.addBlock(frequence);
  }
}
