/**
 * The music between silences.
 *
 * NOTE Currently a single note only.
 */
class Block {
  int note;
  float amplitude;
  float duration;
  
  String coloring;

  Block (int tempNote, float tempAmplitude) {
    duration = 0;
    note = tempNote;
    amplitude = tempAmplitude;

    coloring = 'tunnel';
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
    int brightness = 1;
    
    // int brightness = floor(amplitude * 100);
    
    return color(hue, 1, brightness);
  }
}
