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

  String coloring;

  Block (float tempFreq, int tempNote, float tempAmplitude) {
    duration = 0;

    freq = tempFreq;
    note = tempNote;
    amplitude = tempAmplitude;

    coloring = "tunnel";
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
    int hue = note % 12;
    int saturation = 1;
    int brightness = 100;

    // int brightness = floor(amplitude * 100);

    return color(hue, saturation, brightness);
  }
}
