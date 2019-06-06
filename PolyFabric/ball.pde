class ball {
  float x; 
  float y;
  float raw_val;
  int count;
  float a;
  float b;
  int d;
  float x_pos;
  float y_pos;
  int index;

  ball(float _x, float _y, int _index) { 
    x = _x;
    y = _y;
    a = 0;
    b = 0;
    d = 10;
    count = 50;
    x_pos = 0;
    y_pos = 0;
    index = _index;
  } 

  void update() {
    //float x_pos = 0;
    //float y_pos = 0;
    if (frameCount % 60 == 0) {
      x_pos = random(((-3*count)/4), ((3*count)/4));
      y_pos = random(((-3*count)/4), ((3*count)/4));
    }
    a = lerp(a, x_pos, .04);
    b = lerp(b, y_pos, .04);
  }

  void liner() {
    y_line();
    x_line();
  }
  
  void x_line() {
    int dest_index = index + 10;
    float destx = 0;
    float desty = 0;
    float desta = 0;
    float destb = 0;

    if (dest_index < 100) {
      destx = balls.get(dest_index).x;
      desty = balls.get(dest_index).y;
      desta = balls.get(dest_index).a;
      destb = balls.get(dest_index).b;
    } else {
      destx = x+a;
      desty = y+b;
    }
    stroke(255);
    strokeWeight(.5);
    strokeCap(ROUND);
    line(x+a, y+b, destx+desta, desty+destb);
  }
  
  void y_line() {
    int dest_index = index + 1;
    float destx = 0;
    float desty = 0;
    float desta = 0;
    float destb = 0;

    if (dest_index % 10 == 0) {
      destx = x;
      desty = y;
      desta = a;
      destb = b;
    } else if (dest_index < 100) {
      destx = balls.get(dest_index).x;
      desty = balls.get(dest_index).y;
      desta = balls.get(dest_index).a;
      destb = balls.get(dest_index).b;
    } else {
      destx = x+a;
      desty = y+b;
    }
    stroke(255);
    strokeWeight(.5);
    strokeCap(ROUND);
    line(x+a, y+b, destx+desta, desty+destb);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    noFill();
    stroke(255);
    strokeWeight(3);
    point(0+a, 0+b);
    popMatrix();
  }
}
