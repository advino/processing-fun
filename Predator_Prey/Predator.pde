class predator {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  float r;
  int f;

  predator(float x, float y, float n) {

    location = new PVector(x, y);
    velocity = new PVector(random(-2, 5), random(-2, 5));
    velocity.mult(0);
    acceleration = new PVector(0, 0);
    maxspeed = n;
    maxforce = .075;
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
    fill(f, 0, 0);
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

  void chase() {
   for(int i =  zebras.size() - 1; i >= 0; i--) {
    PVector preyLocation = zebras.get(i).location; 
    float d = PVector.dist(location, preyLocation);
    //println("in the chase");
    if( d < 100) {
     arrive(preyLocation); 
     stroke(0);
     line(location.x, location.y, preyLocation.x, preyLocation.y);
    }
    if( d < 15) {
     zebras.remove(i);
     r = r + 1;
    }
   }
}

}