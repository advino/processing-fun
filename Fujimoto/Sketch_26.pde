
ArrayList<Compass> Comps;
int diam = 100;

void setup() {
  size(600, 600, OPENGL);
  frameRate(30);

  Comps = new ArrayList<Compass>();

  for (int i = 0; i < width - diam; i += diam) {
    for (int j = 0; j < height - diam; j+= diam) {
      Comps.add(new Compass(i+diam, j+diam));
    }
  }
}

void draw() {
  background(255);

  for (Compass c : Comps) {
    c.display(); 
    c.update();
    c.liner();
  }
}
