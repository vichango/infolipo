/**
 * The variables and values per instrument.
 */
class Instrument {
  String key;
  Set set;

  float lastFreq;
  int lastNote;
  float lastAmplitude;

  Instrument(String pKey, int pWidth, int pHeight) {
    key = pKey;
    set = new Set(pWidth, pHeight);

    lastFreq = 0;
    lastNote = 0;
    lastAmplitude = 0;
  }

  void processs(float freq, int note, float amplitude) {
    int lastNoteTemp = lastNote;

    lastFreq = freq;
    lastNote = note;
    lastAmplitude = amplitude;

    // Add a new block if the note changes or a silence is detected.
    if (-999 < lastNote && (lastNoteTemp != lastNote || silenceThresh > lastAmplitude)) {
      set.addBlock(lastFreq, lastNote, lastAmplitude);
    } else {
      set.updateLastBlock(lastFreq, lastNote, lastAmplitude);
    }
  }

  void display() {
    if (!set.isEmpty()) {
      set.nextLoop();
      set.display();
    }
  }

  void displayStats() {
    fill(12, 0, 100);

    textSize(16);
    text(key, 10, 26);

    textSize(12);
    text("f: " + lastFreq, 10, 38);
    fill(12, 0, 100);
    text("n: " + lastNote, 10, 50);
    fill(12, 0, 100);
    text("a: " + lastAmplitude, 10, 62);
  }
}
