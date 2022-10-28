float zoom = 1.0;
final static float inc = .001;

// Length in seconds.
int[] length = new int[20];
// Color, will later be frequency.
int[] reds = new int[20];
int[] greens = new int[20];
int[] blues = new int[20];

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
    reds[i] = floor(random(1) * 255);
    greens[i] = floor(random(1) * 255);
    blues[i] = floor(random(1) * 255);
  }

  println("Lengths: ");
  println(length);

  // Box.
  int boxLeft = 0;
  int boxRight = 0;
  int boxTop = 0;
  int boxBottom = 0;

  // Compute ratios.
  boolean horizontal = true;
  boolean negative = false;
  for (int i = 0; i < 20; i++) {
    if (horizontal) {
      if (negative) {
        boxLeft -= length[i];
      } else {
        boxRight += length[i];
      }
    } else {
      if (negative) {
        boxTop -= length[i];
      } else {
        boxBottom += length[i];
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
  println("Box w: " + boxWidth + " h:" + boxHeight);

  // Ratio of size to pixels.
  float hRatio = (float) (width + 20) / boxWidth;
  float vRatio = (float) (height + 20) / boxHeight;

  println("Ratios: " + hRatio + " " + vRatio);

  // Default values.
  boxLeft = 0;
  boxRight = 0;
  boxTop = 0;
  boxBottom = 0;

  horizontal = true;
  negative = false;
  
  // Draw.
  for (int i = 0; i < 20; i++) {
    // Default center position.
    int x = startX(boxLeft, boxRight, boxTop, boxBottom, horizontal, negative);
    int y = startY(boxLeft, boxRight, boxTop, boxBottom, horizontal, negative);

    x = displaceX(x, length[i], horizontal, negative);
    y = displaceY(y, length[i], horizontal, negative);

    // Set color.
    fill(reds[i], greens[i], blues[i]);
    // translate(width>>1, height>>1);
    
    if (horizontal) {
      print("Horizontal, ");
    } else {
      print("Vertical, ");
    }
    
    if (negative) {
      println("Negative");
    } else {
      println("Positive");
    }

    if (horizontal) {
      println("Rect: (" + x + ", " + y + ") w: " + length[i] + " h:" + (boxBottom - boxTop));
      drawWithRatio(x, y, length[i], boxBottom - boxTop, hRatio, vRatio);
    } else {
      println("Rect: (" + x + ", " + y + ") w: " + (boxRight - boxLeft) + " h:" + length[i]);
      drawWithRatio(x, y, boxRight - boxLeft, length[i], hRatio, vRatio);
    }

    // Update box.
    if (horizontal) {
      if (negative) {
        boxLeft -= length[i];
      } else {
        boxRight += length[i];
      }
    } else {
      if (negative) {
        boxTop -= length[i];
      } else {
        boxBottom += length[i];
      }
    }

    println("Box is now L:" + boxLeft + " R:" + boxRight + " T:" + boxTop + " B:" + boxBottom);

    // Prepare for next iteration.
    horizontal = !horizontal;
    // - Change orientation when back in horizontal.
    if (horizontal) {
      negative = !negative;
    }
  }

  noLoop();
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

void drawWithRatio(int x, int y, int w, int h , float hRatio, float vRatio) {
  int centerX = (width>>1) + floor(hRatio * x);
  int centerY = (height>>1) + floor(vRatio * y);
  
  rect(centerX, centerY, floor(hRatio * w), floor(vRatio * h));
}
