import oscP5.*;
import java.util.Map;

OscP5 oscP5;

HashMap<String, Set> sets = new HashMap<String, Set>();

Set mainSet;
Set secondarySet;

int lastNote;
float lastFreq;
float lastAmplitude;

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
  // Screen size.
  // size(640, 400);
  size(1280, 800);

  rectMode(CENTER);
  colorMode(HSB, 13, 1, 100);

  // Init block set.
  int setWidth = floor(.5 * width - statsWidth);

  mainSet = new Set(setWidth, height);
  secondarySet = new Set(setWidth, height);

  // Initialize an instance listening to port 12000.
  oscP5 = new OscP5(this, 12000);

  background(0);

  // Start not looping.
  if (!looping) {
    noLoop();
  }
}

void draw() {
  background(0);

  if (mainSet.isEmpty()) {
    return;
  }

  int setWidth = floor(.5 * width - statsWidth);

  translate(floor(-.5 * setWidth), 0);
  mainSet.nextLoop();
  mainSet.display();

  translate(setWidth, 0);
  secondarySet.nextLoop();
  secondarySet.display();

  translate(floor(-.5 * setWidth), 0);
  textSize(12);
  fill(12, 0, 100);
  text("f: " + lastFreq, 10, 26);
  fill(12, 0, 100);
  text("n: " + lastNote, 10, 46);
  fill(12, 0, 100);
  text("a: " + lastAmplitude, 10, 66);

  if (looping) {
    text("looping!", 20, 96);
  }
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
