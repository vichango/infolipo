// This value is set by the OSC event handler
float wait = 0;
float zoom = 1.0;
final static float inc = .001;
final static int sz  = 30;

int[] zooms = new int[3];
int[] sizes = new int[3];

int index = 2;

void setup() {
  size(240, 240);
  smooth();
  rectMode(CENTER);
  
  zooms[0] = 130;
  zooms[1] = 150;
  zooms[2] = 180;
  
  sizes[0] = 80;
  sizes[1] = 30;
  sizes[2] = 50;
  
  noStroke();
}
void draw() {
  background(200);
  
  //println(index);
  //println(zooms[index]);
  
    if (0 == zooms[index]) {
      index--;
      fill(random(256), random(256), random(256));
    }
  
    if (0 > index) {
      exit();
    } else {
      if (0 == index % 2) {
        zoom = zoom - inc;
      } else {
        zoom = zoom + inc;
      }
      
      translate(width>>1, height>>1);
      scale(zoom);
      
      square(0, 0, sizes[index]);
      
      zooms[index]--;
    }
}
