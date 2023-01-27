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
    float hue = 0; // 0 - 12
    float saturation = 0; // 0 - 1
    float brightness = 0; // 0 - 100

    switch(coloringSt) {
      case "norm":
        // Accepted notes only between A4 and A6.
        hue = note % 12;
        saturation = 1;
        brightness = pow(amplitude, brightGain);
        break;
      case "cont":
        float fNoteNum = 12 * log(freq / 440)/log(2) + 49;
        float fNote = fNoteNum - 12 * floor(fNoteNum / 12);

        float fOct = (fNoteNum + 8) / (12 * 8);

        println("Fnote: " + fNote + " Foct: " + fOct);

        hue = fNote; // 0 - 12
        saturation = fOct; // 0 - 1
        brightness = 100; // 0 - 100
        break;
    }

    return color(hue, saturation, brightness);
  }
}
