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

  void addBlock(float frequency) {
    Block newBlock = new Block(frequency);
    blocks.add(newBlock);
  }

  void zoomOut() {
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

  private Block getCurrentBlock() {
    int size = blocks.size();

    return blocks.get(size - 1);
  }

  void nextLoop() {
    if (!isEmpty()) {
      // Increase duration of current block.
      Block current = getCurrentBlock();
      current.incrementDuration();
    }
  }

  void display() {
    // Box.
    int boxLeft = 0;
    int boxRight = 0;
    int boxTop = 0;
    int boxBottom = 0;

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

    // Default values.
    boxLeft = 0;
    boxRight = 0;
    boxTop = 0;
    boxBottom = 0;

    horizontal = true;
    negative = false;

    // Draw.
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
}
