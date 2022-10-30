/**
 * Drawing functions.
 */

int startX(int boxLeft, int boxRight, boolean horizontal, boolean negative) {
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

int startY(int boxTop, int boxBottom, boolean horizontal, boolean negative) {
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
