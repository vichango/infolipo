import oscP5.*;

// OSC receiver?
OscP5 oscP5;

int total = 100;

// Length in seconds.
int[] lengths = new int[total];
// Color, will later be frequency.
int[] reds = new int[total];
int[] greens = new int[total];
int[] blues = new int[total];

int timer = 0;
int counter = 1;

String message = "";
float frequence = 440;
float amplitude = 0;

void setup() {
  size(640, 480);
  rectMode(CENTER);

  for (int i = 0; i < total; i++) {
    lengths[i] = 0;
    reds[i] = floor(random(1) * 255);
    greens[i] = floor(random(1) * 255);
    blues[i] = floor(random(1) * 255);
  }

  // Initialize an instance listening to port 12000.
  oscP5 = new OscP5(this,12000);

  // Start not looping.
  background(0);
  noLoop();
}

void draw() {
  background(0);

  // Stop draw loop when counter reaches our table limit.
  if (counter >= total) {
    noLoop();
  }

  // Increase length of current "bit".
  lengths[counter - 1]++;

  // Box.
  int boxLeft = 0;
  int boxRight = 0;
  int boxTop = 0;
  int boxBottom = 0;

  // Default direction.
  boolean horizontal = true;
  boolean negative = false;

  // Compute ratios.
  for (int i = 0; i < counter; i++) {
    if (horizontal) {
      if (negative) {
        boxLeft -= lengths[i];
      } else {
        boxRight += lengths[i];
      }
    } else {
      if (negative) {
        boxTop -= lengths[i];
      } else {
        boxBottom += lengths[i];
      }
    }

    // Prepare for next iteration.
    horizontal = !horizontal;
    // - Change orientation when back in horizontal.
    if (horizontal) {
      negative = !negative;
    }
  }

  // Box size.
  int boxWidth = boxRight - boxLeft;
  int boxHeight = boxBottom - boxTop;
  float boxCenterX = boxLeft + (float) boxWidth / 2;
  float boxCenterY = boxTop + (float) boxHeight / 2;

  // Ratio of size to pixels.
  float hRatio = 1.0;
  float vRatio = 1.0;
  
  if (0 < boxWidth) {
    hRatio = (float) width / boxWidth;
  }
  if (0 < boxHeight) {
    vRatio = (float) height / boxHeight;
  }

  // Default values.
  boxLeft = 0;
  boxRight = 0;
  boxTop = 0;
  boxBottom = 0;

  horizontal = true;
  negative = false;
  
  // Draw.
  for (int i = 0; i < counter; i++) {
    // Default center position.
    int x = startX(boxLeft, boxRight, horizontal, negative);
    int y = startY(boxTop, boxBottom, horizontal, negative);

    x = displaceX(x, lengths[i], horizontal, negative);
    y = displaceY(y, lengths[i], horizontal, negative);

    // Set rect style.
    noStroke();
    fill(reds[i], greens[i], blues[i]);
    
    if (1 < counter) {
      if (horizontal) {
        int rectW = lengths[i];
        int rectH = boxBottom - boxTop;

        drawWithRatio(x, y, rectW, rectH, hRatio, vRatio, boxCenterX, boxCenterY);
      } else {
        int rectW = boxRight - boxLeft;
        int rectH = lengths[i];

        drawWithRatio(x, y, rectW, rectH, hRatio, vRatio, boxCenterX, boxCenterY);
      }
    }

    // Update box.
    if (horizontal) {
      if (negative) {
        boxLeft -= lengths[i];
      } else {
        boxRight += lengths[i];
      }
    } else {
      if (negative) {
        boxTop -= lengths[i];
      } else {
        boxBottom += lengths[i];
      }
    }

    // Prepare for next iteration.
    horizontal = !horizontal;
    // - Change orientation when back in horizontal.
    if (horizontal) {
      negative = !negative;
    }
  }
}
