/**
 * The music between silences.
 *
 * NOTE Currently a single frequency only.
 */
class Block {
  float frequency;

  // Temporarily duration is in loops.
  int duration;

  Block (float tempFrequency) {
    duration = 0;
    frequency = tempFrequency;
  }

  void incrementDuration() {
    duration += 1;
  }

  void zoomOutDuration(float factor) {
    duration = floor(duration * factor);
  }

  /**
   * Temporary method returning the color based on the frequency.
   */
  color getColor() {
    // Accepted frequencies only between A4 and A6.
    int maxA = 1760;
    int minA = 440;

    float normalised = min(maxA, max(minA, frequency));

    // Compute gray level between 0 and 255
    int grayLevel = floor(255 * (normalised - minA) / (maxA - minA));

    return color(grayLevel, grayLevel, grayLevel);
  }
}
