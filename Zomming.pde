float zoom = 1.0;
final static float inc = .001;

int total = 100;

// Length in seconds.
int[] lengths = new int[total];
// Color, will later be frequency.
int[] reds = new int[total];
int[] greens = new int[total];
int[] blues = new int[total];

int timer = 0;
int counter = 1;

void setup() {
  size(640, 480);
  rectMode(CENTER);

  for (int i = 0; i < total; i++) {
    lengths[i] = 0;
    reds[i] = floor(random(1) * 255);
    greens[i] = floor(random(1) * 255);
    blues[i] = floor(random(1) * 255);
  }
}

void draw() {
  background(0);

  lengths[counter - 1]++;

  if (counter >= lengths.length) {
    noLoop();
  }

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

  // println("Ratios: " + hRatio + " " + vRatio);

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
    int x = startX(boxLeft, boxRight, boxTop, boxBottom, horizontal, negative);
    int y = startY(boxLeft, boxRight, boxTop, boxBottom, horizontal, negative);

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

void mouseClicked() {
  counter++;
}

int startX(int boxLeft, int boxRight, int boxTop, int boxBottom, boolean horizontal, boolean negative) {
  if (horizontal) {
    if (negative) {
      return boxLeft;
    } else {
      return boxRight;
    }
  } else {
    return boxLeft + floor((boxRight - boxLeft) / 2);
  }
}

int startY(int boxLeft, int boxRight, int boxTop, int boxBottom, boolean horizontal, boolean negative) {
  if (horizontal) {
    return boxTop + floor((boxBottom - boxTop) / 2);
  } else {
    if (negative) {
      return boxTop;
    } else {
      return boxBottom;
    }
  }
}

int displaceX(int x, int length, boolean horizontal, boolean negative) {
  // Displace x of width + half length if the given direction is horizontal.
  if (horizontal) {
    if (negative) {
      x -= floor(length / 2);
    } else {
      x += floor(length / 2);
    }
  }

  return x;
}

int displaceY(int y, int length, boolean horizontal, boolean negative) {
  // Displace y of height + half length if the given direction is vertical (not horizontal).
  if (!horizontal) {
    if (negative) {
      y -= floor(length / 2);
    } else {
      y += floor(length / 2);
    }
  }

  return y;
}

void drawWithRatio(int x, int y, int w, int h , float hRatio, float vRatio, float deltaX, float deltaY) {
  int centerX = (width>>1) + floor(hRatio * (x - deltaX));
  int centerY = (height>>1) + floor(vRatio * (y - deltaY));

  rect(centerX, centerY, floor(hRatio * w), floor(vRatio * h));
}
