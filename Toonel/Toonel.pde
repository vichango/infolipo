import oscP5.*;
import java.util.Map;

OscP5 oscP5;

HashMap<String, Set> sets = new HashMap<String, Set>();

String firstInst = "/A";
String secondInst = "/B";

Set mainSet;
Set secondarySet;

String currMessage = "";
int currNote = 0;
float currFreq = 0;
float currAmplitude = 0;

// Variables.
boolean looping = true;
float gain = 1;
float brightGain = -3;
boolean tunneling = false;
float tunnelingFactor = 1.25;
float zoomFactor = 0.975; // 0.95
String coloringSt = "cont"; // norm, cont
float silenceThresh = 0.010; // 0.001
int statsWidth = 80;

void setup() {
  // Initialize an instance listening to port 12000.
  oscP5 = new OscP5(this, 12000);

  // Screen size.
  // size(640, 400);
  size(1280, 800);
  // size(2560, 1600);

  rectMode(CENTER);
  colorMode(HSB, 13, 1, 100);

  // Init block set.
  // FIXME Keep only the left stats window.
  int setWidth = floor(.5 * width - statsWidth);

  sets.put(firstInst, new Set(setWidth, height));
  sets.put(secondInst, new Set(setWidth, height));

  background(0);

  // Start not looping.
  if (!looping) {
    noLoop();
  }
}

void draw() {
  background(0);

  // Process.
  switch (currMessage) {
    case "/A":
      sets.get(firstInst).processs(currFreq, currNote, currAmplitude);
      break;
    case "/B":
      sets.get(secondInst).processs(currFreq, currNote, currAmplitude);
      break;
  }

  int setWidth = floor(.5 * width - statsWidth);

  translate(floor(-.5 * setWidth), 0);
  if (!sets.get(firstInst).isEmpty()) {
    sets.get(firstInst).nextLoop();
    sets.get(firstInst).display();
  }

  translate(setWidth, 0);
  if (!sets.get(secondInst).isEmpty()) {
    sets.get(secondInst).nextLoop();
    sets.get(secondInst).display();
  }

  translate(floor(-.5 * setWidth), 0);
  textSize(12);
  fill(12, 0, 100);
  text("f: " + currFreq, 10, 26);
  fill(12, 0, 100);
  text("n: " + currNote, 10, 46);
  fill(12, 0, 100);
  text("a: " + currAmplitude, 10, 66);
  text("m: " + currMessage, 10, 86);
}

void mouseClicked() {
  if (looping) {
    noLoop();
    looping = false;
    println("Stop looping");
  } else {
    loop();
    looping = true;
    println("Looping");
  }
}
