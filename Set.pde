/**
 * The whole set of blocks.
 */
 class Set {
  boolean initialHorizonal = true;
  boolean initialNegative = false;

  float zoomFactor = 0.95;

  ArrayList<Block> blocks = new ArrayList<Block>();

  Set () {}

  boolean isEmpty() {
    return blocks.isEmpty();
  }

  Block getCurrentBlock() {
    int size = blocks.size();

    return blocks.get(size - 1);
  }

  void addBlock(float frequency) {
    // Zoom out.
    zoomOut();

    Block newBlock = new Block(frequency);
    blocks.add(newBlock);
  }

  void nextLoop() {
    if (!isEmpty()) {
      // Increase duration of current block.
      Block current = getCurrentBlock();
      current.incrementDuration();
    }
  }

  void display() {
    // Compute the size to pixel ratio.
    // - Pre-compute boundaries.
    int[] boundaries = boxBoundaries();

    int boxWidth = boundaries[1] - boundaries[3];
    int boxHeight = boundaries[2] - boundaries[0];

    float boxCenterX = boxLeft + (float) boxWidth / 2;
    float boxCenterY = boxTop + (float) boxHeight / 2;

    // - Default valuese.
    float hRatio = 1.0;
    float vRatio = 1.0;

    if (0 < boxWidth) {
      hRatio = (float) width / boxWidth;
    }
    if (0 < boxHeight) {
      vRatio = (float) height / boxHeight;
    }

    // Actual drawing.
    int boxLeft = 0;
    int boxRight = 0;
    int boxTop = 0;
    int boxBottom = 0;

    boolean horizontal = initialHorizonal;
    boolean negative = initialNegative;

    for (int i = 0; i < blocks.size(); i++) {
      Block current = blocks.get(i);

      // Default center position.
      int x = startX(boxLeft, boxRight, horizontal, negative);
      int y = startY(boxTop, boxBottom, horizontal, negative);

      x = displaceX(x, current.duration, horizontal, negative);
      y = displaceY(y, current.duration, horizontal, negative);

      // Set rect style.
      noStroke();
      fill(current.getColor());

      // Start drawing when we have two blocks.
      if (1 < blocks.size()) {
        if (horizontal) {
          int rectW = current.duration;
          int rectH = boxBottom - boxTop;

          drawWithRatio(x, y, rectW, rectH, hRatio, vRatio, boxCenterX, boxCenterY);
        } else {
          int rectW = boxRight - boxLeft;
          int rectH = current.duration;

          drawWithRatio(x, y, rectW, rectH, hRatio, vRatio, boxCenterX, boxCenterY);
        }
      }

      // Update box.
      if (horizontal) {
        if (negative) {
          boxLeft -= current.duration;
        } else {
          boxRight += current.duration;
        }
      } else {
        if (negative) {
          boxTop -= current.duration;
        } else {
          boxBottom += current.duration;
        }
      }

      // Prepare for next iteration.
      horizontal = !horizontal;
      if (horizontal) {
        negative = !negative;
      }
    }
  }

  private void zoomOut() {
    for (int i = 0; i < blocks.size(); i++) {
      Block current = blocks.get(i);
      current.zoomOutDuration(zoomFactor);
    }

    // Remove oldest pack of 4 if duration reaches already 0.
    if (4 < blocks.size()) {
      boolean clean = true;
      for (int i = 0; clean && i < 4; i++) {
        Block current = blocks.get(i);

        if (0 < current.duration) {
          clean = false;
        }
      }

      if (clean) {
        for (int i = 3; i >= 0; i--) {
          blocks.remove(i);
        }

        // println("Cleaned, " + blocks.size() + " remaining.");
      }
    }
  }

  private int[] boxBoundaries() {
    // Box.
    int boxTop = 0;
    int boxRight = 0;
    int boxBottom = 0;
    int boxLeft = 0;

    // Default direction.
    boolean horizontal = initialHorizonal;
    boolean negative = initialNegative;

    for (int i = 0; i < blocks.size(); i++) {
      Block current = blocks.get(i);

      if (horizontal) {
        if (negative) {
          boxLeft -= current.duration;
        } else {
          boxRight += current.duration;
        }
      } else {
        if (negative) {
          boxTop -= current.duration;
        } else {
          boxBottom += current.duration;
        }
      }

      // Prepare for next iteration.
      horizontal = !horizontal;
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

    int[] boundaries = int[4];
    boundaries[0] = boxTop;
    boundaries[1] = boxRight;
    boundaries[2] = boxBottom;
    boundaries[3] = boxLeft;

    return boundaries;
  }

  private int startX(int boxLeft, int boxRight, boolean horizontal, boolean negative) {
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

  private int startY(int boxTop, int boxBottom, boolean horizontal, boolean negative) {
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

  private int displaceX(int x, int length, boolean horizontal, boolean negative) {
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

  private int displaceY(int y, int length, boolean horizontal, boolean negative) {
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

  private void drawWithRatio(int x, int y, int w, int h , float hRatio, float vRatio, float deltaX, float deltaY) {
    int centerX = (width>>1) + floor(hRatio * (x - deltaX));
    int centerY = (height>>1) + floor(vRatio * (y - deltaY));

    rect(centerX, centerY, floor(hRatio * w), floor(vRatio * h));
  }
}
