class Boullerec {
  int diameter;
  float r;
  float g;
  float b;
  float x;
  float y;
  float x1;
  float y1;
  PVector location;
  PVector velocity;
  PVector acceleration;
  Boullerec() {
    diameter = 15;
    r = random(500);
    g = random(500);
    b = random(500);
    x = random(width/3, width*.66);
    y = random(height/3, height*.66);
    location = new PVector(x, y);
    //x1 = random(width/3,width*.66);
    //y1 = random(height/3,height*.66);
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-.5, .5), random(-.5, .5));
  }

  void update() {
    location.add(velocity);
    velocity.add(acceleration);
    if(abs(velocity.x) > 5 || abs(velocity.y) > 5) {
     velocity.mult(0);
     acceleration.mult(0);
    }
  }

  void display() {
    noStroke();
    colorMode(HSB);
    color c = color(r, g, b);
    fill(c, 95);
    ellipse(x, y, 20, 20);
    ellipse(location.x, location.y, 20, 20);
    stroke(r, g, b, 95);
    strokeWeight(20);
    line(x, y, location.x, location.y);
  }
}