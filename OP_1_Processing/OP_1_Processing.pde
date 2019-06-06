import themidibus.*;

MidiBus myBus;
color bg;
int r, g, b = 0;
int c, p, v;

void setup() {
  size(400, 400);
  background(0);
  MidiBus.list();
  myBus = new MidiBus(this, 4, "OP-1 Midi Device");
}

void draw() {
  background(r, g, b);
  textSize(65);
  textAlign(CENTER);
  text(str(p), width/2, height/2);
}

void noteOn(int channel, int pitch, int velocity) {
  p = pitch;
}


void controllerChange(int channel, int number, int value) {
  switch(number) {
    case 1:
      r = value*2;
      break;
    
    case 2:
      g = value*2;
      break;
    case 3:
      b = value*2;
      break;
    case 4:
      println(value);
      break;
    default:
      break;
  }
}
