/**
 * Event functions.
 */

void oscEvent(OscMessage theOscMessage) {
  message = theOscMessage.addrPattern();
  
  if (theOscMessage.checkAddrPattern("/start")) {
    println("Looping");
    loop();
  }

  if (theOscMessage.checkAddrPattern("/stop")) {
    println("Stop looping");
    noLoop();
  }

  if (theOscMessage.checkAddrPattern("/bang")) {
    frequence = theOscMessage.get(0).floatValue();

    // Normalize.s
    // - Between two A.
    int maxA = 1760;
    int minA = 440;
    frequence = min(maxA, max(minA, frequence));
    
    // Compute gray level between 0 and 255
    int grayLevel = floor(255 * (frequence - minA) / (maxA - minA));

    reds[counter] = grayLevel;
    greens[counter] = grayLevel;
    blues[counter] = grayLevel;

    counter++;

    println(message + " freq:" + frequence + " gray:" + grayLevel);
  }
}
