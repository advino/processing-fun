class Compass {
  int x;
  int y;
  int d;
  int dice;
  float raw_val;
  float map_val;
  float a;

  Compass(int _x, int _y) {
    x = _x;
    y = _y;
    d = 100;
    dice = 0;
    raw_val = 0;
    map_val = 0;
    a = random(1);
  }

  void update() {
    dice = floor(random(24));
    if (dice > 18) {
      raw_val = random(360);
      map_val = map(raw_val, 0, 10, 0, TWO_PI);
    }

    a = lerp(a, map_val, .01);
  }

  void liner() {
    for (int i = Comps.size() -1; i >= 0; i --) {
      float thisComp = Comps.get(i).a;
      float nextComp = 0;
      float thisCompX = Comps.get(i).x;
      float thisCompY = Comps.get(i).y;
      float nextCompX = 0;
      float nextCompY = 0;
      if (i > 0) {

        nextComp = Comps.get(i-1).a;
        nextCompX = Comps.get(i-1).x;
        nextCompY = Comps.get(i-1).y;
      } else {
        nextComp = Comps.get(Comps.size() - 1).a;
        nextCompX = Comps.get(Comps.size() - 1).x;
        nextCompY = Comps.get(Comps.size() - 1).y;
      }

      strokeWeight(.75);
      stroke(255, 0, 0);
      line(thisCompX + (d/2)*sin(.05*thisComp), thisCompY + (-d/2)*cos(.05*thisComp), nextCompX + (d/2)*sin(.05*nextComp), nextCompY + (-d/2)*cos(.05*nextComp));
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    fill(225);
    stroke(0);
    fill(255);
    stroke(0);
    ellipse(0, 0, d, d);
    noStroke();
    fill(0);
    ellipse(0, 0, d/10, d/10);
    fill(0);
    ellipse((d/2)*sin(.05*a), (-d/2)*cos(.05*a), d/10, d/10);
    stroke(0);
    line(0, 0, (d/2)*sin(.05*a), (-d/2)*cos(.05*a));
    popMatrix();
  }
}
