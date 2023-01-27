import oscP5.*;

OscP5 oscP5;

Set mainSet;

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

void setup() {
  // Screen size.
  // size(640, 480);
  size(1280, 960);

  rectMode(CENTER);
  colorMode(HSB, 13, 1, 100);

  // Init block set.
  mainSet = new Set();

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

  mainSet.nextLoop();
  mainSet.display();

  textSize(16);
  fill(12, 0, 100);
  text("freq: " + lastFreq, 20, 36);
  fill(12, 0, 100);
  text("midi: " + lastNote, 20, 56);
  fill(12, 0, 100);
  text("amp: " + lastAmplitude, 20, 76);

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
