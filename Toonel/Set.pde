/**
 * The whole set of blocks.
 */
 class Set {
  final boolean initialHorizonal = true;
  final boolean initialNegative = false;

  ArrayList<Block> blocks = new ArrayList<Block>();

  Set () {}

  boolean isEmpty() {
    return blocks.isEmpty();
  }

  Block getCurrentBlock() {
    int size = blocks.size();

    if (0 < size) {
      return blocks.get(size - 1);
    }

    return null;
  }

  void addBlock(float freq, int note, float amplitude) {
    // Zoom out.
    zoomOut();

    Block newBlock = new Block(freq, note, amplitude);
    blocks.add(newBlock);
  }

  void nextLoop() {
    // Increase duration of current block.
    Block current = getCurrentBlock();

    if (null != current) {
      current.incrementDuration();
    }
  }

  void display() {
    // Compute the size to pixel ratio.
    // - Pre-compute boundaries.
    FloatDict boundaries = boxBoundaries();

    float boxWidth = boundaries.get("right") - boundaries.get("left");
    float boxHeight = boundaries.get("bottom") - boundaries.get("top");

    float boxCenterX = boundaries.get("left") + boxWidth / 2;
    float boxCenterY = boundaries.get("top") + boxHeight / 2;

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
    float boxLeft = 0;
    float boxRight = 0;
    float boxTop = 0;
    float boxBottom = 0;

    boolean horizontal = initialHorizonal;
    boolean negative = initialNegative;

    for (int i = 0; i < blocks.size(); i++) {
      Block current = blocks.get(i);

      // Default center position.
      float x = startX(boxLeft, boxRight, horizontal, negative);
      float y = startY(boxTop, boxBottom, horizontal, negative);

      x = displaceX(x, current.duration, horizontal, negative);
      y = displaceY(y, current.duration, horizontal, negative);

      // Set rect style.
      noStroke();
      // - Get color from block.
      color blockColor = current.getColor();

      float hue = hue(blockColor);
      float saturation = saturation(blockColor);
      float brightness = brightness(blockColor);

      // - Tunnel effect.
      if (tunneling) {
        brightness = brightness * pow((float) i / blocks.size(), 2);
      }

      fill(hue, saturation, brightness);

      // Start drawing when we have two blocks.
      if (1 < blocks.size()) {
        if (horizontal) {
          float rectW = current.duration;
          float rectH = boxBottom - boxTop;

          drawWithRatio(x, y, rectW, rectH, hRatio, vRatio, boxCenterX, boxCenterY);
        } else {
          float rectW = boxRight - boxLeft;
          float rectH = current.duration;

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

      // Factor will get stronger the deeper we go.
      // NOTE An exponential of (0.25 * depth) works well for zoom factor 0.95.
      float currentFactor = pow(zoomFactor, 0.25 * (blocks.size() - i));

      current.zoomOutDuration(currentFactor);
    }

    // Remove oldest pack of 4 if their duration is short enough.
    if (4 < blocks.size()) {
      boolean clean = true;
      for (int i = 0; clean && i < 4; i++) {
        Block current = blocks.get(i);

        if (1 < current.duration) {
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

  private FloatDict boxBoundaries() {
    // Box.
    float boxTop = 0;
    float boxRight = 0;
    float boxBottom = 0;
    float boxLeft = 0;

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
    float boxWidth = boxRight - boxLeft;
    float boxHeight = boxBottom - boxTop;
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

    FloatDict boundaries = new FloatDict();
    boundaries.set("top", boxTop);
    boundaries.set("right", boxRight);
    boundaries.set("bottom", boxBottom);
    boundaries.set("left", boxLeft);

    return boundaries;
  }

  private float startX(float boxLeft, float boxRight, boolean horizontal, boolean negative) {
    if (horizontal) {
      if (negative) {
        return boxLeft;
      } else {
        return boxRight;
      }
    } else {
      return boxLeft + (boxRight - boxLeft) / 2;
    }
  }

  private float startY(float boxTop, float boxBottom, boolean horizontal, boolean negative) {
    if (horizontal) {
      return boxTop + (boxBottom - boxTop) / 2;
    } else {
      if (negative) {
        return boxTop;
      } else {
        return boxBottom;
      }
    }
  }

  private float displaceX(float x, float length, boolean horizontal, boolean negative) {
    // Displace x of width + half length if the given direction is horizontal.
    if (horizontal) {
      if (negative) {
        x -= length / 2;
      } else {
        x += length / 2;
      }
    }

    return x;
  }

  private float displaceY(float y, float length, boolean horizontal, boolean negative) {
    // Displace y of height + half length if the given direction is vertical (not horizontal).
    if (!horizontal) {
      if (negative) {
        y -= length / 2;
      } else {
        y += length / 2;
      }
    }

    return y;
  }

  private void drawWithRatio(float x, float y, float w, float h , float hRatio, float vRatio, float deltaX, float deltaY) {
    int centerX = (width>>1) + floor(hRatio * (x - deltaX));
    int centerY = (height>>1) + floor(vRatio * (y - deltaY));

    rect(centerX, centerY, floor(hRatio * w), floor(vRatio * h));
  }
}
