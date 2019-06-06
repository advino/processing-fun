class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;

  int r;
  int maxSpeed;
  float maxForce;
  String type;

  int age;

  int message;

  Ant(float x, float y, String a) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    type = a;

    age = 0;

    message = floor(random(0, 9));

    r = 15; 
    maxSpeed = 3;
    maxForce = .05;
  }

  void run() {
    update();
    display();
    borders();
  }

  void update() {

    location.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    acceleration.mult(0);
  }

  void addForce(PVector force) {

    acceleration.add(force);
  }

  void checkType() {
    switch(type) {

    case "Worker":
      fill(250, 187, 45);
      break;

    case "Farmer":
      fill(58, 167, 86);
      break;

    case "Soldier":
      fill(52, 109, 241);
      break;

    default: 
      break;
    }
  }

  void aging() {

    age ++;
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  } 

  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    addForce(steer);
  }

  void exchangeMessage() {
    for (int i = 0; i < ants.size(); i++) {
      Ant currentAnt = ants.get(i);
      PVector currentAntLoc = currentAnt.location;
      int currentAntMess = currentAnt.message;

      float d = PVector.dist(location, currentAntLoc);

      if (d < r/2) {

        

        switch(currentAntMess) {
        case 5:
          println("Important message exchanged between " + this.type + " and " + currentAnt.type);
          println("(" + this.message + " , " + currentAnt.message + ")");
          break;

        default: 

          break;
        }
      }
    }
  }


  void display() {
    float theta = velocity.heading() + PI/2;
    noStroke();
    checkType();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipse(0, 0, r, r);
    stroke(0);
    line(0, 0, 0, -r/2);
    line(0, 0, -r*.75, r);
    line(0, 0, r*.75, r);
    fill(0);
    ellipse(0, -r/2, 2, 2);
    ellipse(-r*.75, r, 2, 2);
    ellipse(r*.75, r, 2, 2);
    popMatrix();
  }
}