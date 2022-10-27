float zoom = 1.0;
final static float inc = .001;

// Length in seconds.
int[] length = new int[20];
// Grays, will later be frequency.
int[] grays = new int[20];

void setup() {
  size(640, 480);
  
  smooth();
  rectMode(CENTER);
  
  noStroke();
}

void draw() {
  background(0);

  for (int i = 0; i < 20; i++) {
    length[i] = floor(random(1) * 50);
    grays[i] = floor(random(1) * 255);
  }

  // With in seconds.
  int timeWidth = 0;
  int timeHeight = 0;

  // Compute ratios.
  boolean horizontal = true;
  for (int i = 0; i < 20; i++) {
    if (horizontal) {
      timeWidth += length[i];
    } else {
      timeHeight += length[i];
    }

    // Prepare for next iteration.
    horizontal = !horizontal;
  }

  // Seconds over pixels.
  float hRatio = (float) timeWidth / width;
  float vRatio = (float) timeHeight / width;

  // println("Ratios: " + hRatio + " " + vRatio);

  // Draw.
  timeWidth = 0;
  timeHeight = 0;
  horizontal = true;
  for (int i = 0; i < 20; i++) {
    // Compute size.
    int w = timeWidth;
    int h = timeHeight;

    if (horizontal) {
      w += length[i];
      w = floor(hRatio * w);

      timeWidth += length[i];
    } else {
      h += length[i];
      h = floor(vRatio * h);

      timeHeight += length[i];
    }

    // println("Size: " + w + " " + h);

    fill(grays[i], grays[i], grays[i]);
    // translate(width>>1, height>>1);
    rect(width>>1, height>>1, w, h);

    // Prepare for next iteration.
    horizontal = !horizontal;
  }

  noLoop();
}
