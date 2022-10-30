import oscP5.*;

// OSC receiver?
OscP5 oscP5;

Set mainSet;

void setup() {
  size(640, 480);
  rectMode(CENTER);

  // Init block set.
  mainSet = new Set();

  // Initialize an instance listening to port 12000.
  oscP5 = new OscP5(this,12000);

  // Start not looping.
  background(0);
  noLoop();
}

void draw() {
  background(0);

  if (mainSet.isEmpty()) {
    return;
  }

  mainSet.nextLoop();
  mainSet.display();
}
