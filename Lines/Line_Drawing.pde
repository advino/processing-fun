//import processing.pdf.*;

Line[] lines = new Line[3];

void settings() {
 size(500,500); 
}

void setup() {
  background(255);
  for (int i = 0; i < lines.length; i++) {
    lines[i] = new Line();
  }
//beginRecord(PDF, "line_drawing6.pdf");
}


void draw() {
  
  for (int i = 0; i < lines.length; i++) {

    lines[i].display();
    lines[i].update();
  }
  //fill(0,5);
  //noStroke();
  //rect(0,0,width,height);
}

void mousePressed() {
  endRecord();
  exit();
  
}
