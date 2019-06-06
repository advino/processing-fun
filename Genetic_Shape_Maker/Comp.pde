class comp {
  int x;
  int y;
  int  a;
  
  
  float r;
  float w ;
  float h;
  float w1;
  float w2;
  float h1;
  float h2;
  float w3;
  float w4;
  float h3;
  float h4;
  comp(int _x, int _y, float[] data) {
    x = _x;
    y =_y;
    a = 1;

    //DNA
    r = data[0];
    w = data[1];
    h = data[2];
    w1 = data[3];
    w2 = data[4];
    h1 = data[5];
    h2 = data[6];
    w3 = data[7];
    w4 = data[8];
    h3 = data[9];
    h4 = data[10];
  }

  float[] getData() {
    float data[] = {r, w, h, w1, w2, h1, h2, w3, w4, h3, 4};
    return data;
  }

  void selectComp() {
    float d = dist(mouseX, mouseY, this.x, this.y);
    if (d <= 25) {
      //println(this.x + " " + this.y);
      //println(d);
      if (a >= 5) {
        a = 1;
      } else {
        a = 5;
        selectedData[counterFries] = getData();
        counterFries++;
      }
      delay(100);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);

    noFill();
    stroke(0, 75);
    strokeWeight(a);
    rectMode(CENTER);
    rect(0, 0, 50, 50);

    fill(255, 0, 0);
    noStroke();
    rotate(r);
    rect(w1, h1, w, h);

    fill(0, 0, 255);
    noStroke();
    ellipse(w2, h2, r, r);

    fill(0);
    noStroke();
    rotate(r);
    rect(w3, h3, w/2, h/2);

    noFill();
    stroke(0);
    strokeWeight(1);
    line(w, h, w2, h2);

    rotate(r/2);
    fill(0, 255, 0);
    noStroke();
    beginShape();
    curveVertex(w, h);
    curveVertex(w1, h2);
    curveVertex(h3, w2);
    curveVertex(w1, w);
    curveVertex(h3, w3);
    curveVertex(h1, h);
    curveVertex(h, w);
    endShape();

    popMatrix();
  }
}
