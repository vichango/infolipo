import oscP5.*;
import java.util.Map;

OscP5 oscP5;

String firstInst = "/A";
String secondInst = "/B";
HashMap<String, Instrument> instruments = new HashMap<String, Instrument>();

String currMessage = "";
int currNote = 0;
float currFreq = 0;
float currAmplitude = 0;

// Variables.
boolean looping = true;
float gain = 1;
float brightGain = -3;
boolean tunneling = true;
float tunnelingFactor = 1.125;
float zoomFactor = 0.975; // 0.95
String coloringSt = "cont"; // norm, cont
float silenceThresh = 0.010; // 0.001
int statsHeight = 80;

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
  int setWidth = floor(.5 * width);
  int setHeight = height - statsHeight;

  instruments.put(firstInst, new Instrument(firstInst, setWidth, setHeight));
  instruments.put(secondInst, new Instrument(secondInst, setWidth, setHeight));

  background(0);

  // Start not looping.
  if (!looping) {
    noLoop();
  }
}

void draw() {
  background(0);

  // Check last read message and process.
  if (currMessage.equals(firstInst)) {
    instruments.get(firstInst).processs(currFreq, currNote, currAmplitude);
  } else if (currMessage.equals(secondInst)) {
    instruments.get(secondInst).processs(currFreq, currNote, currAmplitude);
  }

  int setWidth = floor(.5 * width);
  int setHeight = height - statsHeight;

  // Animation.
  translate(floor(-.5 * setWidth), floor(-.5 * statsHeight));
  instruments.get(firstInst).display();
  translate(setWidth, 0);
  instruments.get(secondInst).display();

  // Stats.
  translate(floor(-.5 * setWidth), setHeight + floor(.5 * statsHeight));
  instruments.get(firstInst).displayStats();
  translate(setWidth, 0);
  instruments.get(secondInst).displayStats();
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
