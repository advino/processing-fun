class prey {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  float r;
  int f;

  prey(float x, float y, float n) {

    location = new PVector(x, y);
    velocity = new PVector(random(-2, 5), random(-2, 5));
    velocity.mult(0);
    acceleration = new PVector(0, 0);
    maxspeed = n;
    maxforce = .01;
    r = 6;
    f = 255;
  }

  void run() {
    update();
    display();
    borders();
  }

  void update() {
    velocity.add(acceleration); 
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading() + PI/2;
    fill(f, f, f);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }

  void addForce(PVector force) {
    acceleration.add(force);
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    addForce(steer);
  }

  void arrive(PVector target) {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    if (d<100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxspeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    addForce(steer);
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  } 

  void death() {
    for (int i = lions.size() - 1; i >= 0; i--) {
      PVector predatorLocation = lions.get(i).location;
      float d = PVector.dist(location, predatorLocation);

      
    }
  }
}