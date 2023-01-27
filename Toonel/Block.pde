/**
 * The music between silences.
 *
 * NOTE Currently a single note only.
 */
class Block {
  float freq;
  int note;
  float amplitude;

  float duration;

  Block (float tempFreq, int tempNote, float tempAmplitude) {
    duration = 0;

    freq = tempFreq;
    note = tempNote;
    amplitude = tempAmplitude;
  }

  void incrementDuration() {
    duration += 1;
  }

  void zoomOutDuration(float factor) {
    duration *= factor;
  }

  /**
   * Temporary method returning the color based on the block's frequency.
   */
  color getColor() {
    // Accepted notes only between A4 and A6.
    float hue = note % 12;
    float saturation = 1;
    float brightness = pow(amplitude, brightGain);

    return color(hue, saturation, brightness);
  }
}
