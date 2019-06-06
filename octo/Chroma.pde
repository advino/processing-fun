class Chroma {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  float r;
  float value;
  color pix;
  color inter;

  Chroma(int _x, int _y, color _pix) {

    location = new PVector(_x, _y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxspeed = 20;
    maxforce = .65;
    pix = _pix;
    r = 5;
    inter = color(255);
  }

  String getPix() {
    return hex(inter);
  }

  PVector currentLoc() {
    return location;
  }

  void changeColor(color newColor) {
    pix = newColor;
  }

  void update() {
    
    inter = lerpColor(inter, pix, .05);
     float value = map(brightness(inter), 0, width, 2, 12);
    r = lerp(r, value, .5);

    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void addForce(PVector force) {
    acceleration.add(force);
  }

  PVector arrive(PVector target) {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
   
    desired.normalize();
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxspeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    
   return steer;
  }
  
  PVector cohesion(ArrayList<Chroma> neighbors) {
    PVector sum = new PVector();
    int count = 0;
    for(Chroma other : neighbors) {
     float desiredDist = (r/2) + (other.r/2);
     float d = PVector.dist(location,other.location);
     if((d >0) && (d < desiredDist)) {
      sum.add(other.location);
      count++;
     }
    }
    
    if(count > 0) {
     sum.div(count);
     return arrive(sum);
    }
    return sum;
  }

  PVector separate(ArrayList<Chroma> neighbors) {
    
    PVector sum = new PVector();
    
    int count = 0;
    
    for (Chroma other : neighbors) {
      float desiredSeparation = (r/2) + (other.r/2);
      float d = PVector.dist(this.location, other.location);

      if ((d > 0) && (d < desiredSeparation)) {
        PVector diff = PVector.sub(this.location, other.location);

        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count ++;
      } 
    }

    if (count > 0) {
      sum.div(count); 
      sum.normalize();
      sum.mult(maxspeed);
      
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    
    return sum;
  }
  
  void applyBehaviors(ArrayList<Chroma> nodes, PVector target) {
   PVector separate = separate(nodes); 
   PVector coh = cohesion(nodes);
   PVector seek = arrive(target);
   separate.mult(2);
   coh.mult(1);
   seek.mult(1);
   addForce(seek);
   addForce(separate);
   addForce(coh);
  }

  void render() {
    pushMatrix();
    translate(location.x, location.y);
    noStroke();
    fill(inter);
    ellipse(0, 0, r, r);
    popMatrix();
  }
}
