import processing.pdf.*;



ArrayList<Chroma> patch;
PImage img;
int spacing;
void setup() {
  noCursor();
  size(600, 600, OPENGL);
  patch = new ArrayList<Chroma>();
  img = loadImage("5.jpg");
  img.resize(400, 400);
  spacing = 20;
  for (int i = 0; i < img.width; i+= spacing) {
    for (int j = 0; j < img.height; j+= spacing) {
      patch.add(new Chroma(i+100, j+100, img.get(i, j)));
    }
  }
  
  beginRecord(PDF, "DOTS1.pdf");
}   

void draw() {
  background(255);
  for (Chroma c : patch) {
    c.display();
    c.update();
  }
}


void mousePressed() {
  int label = floor(random(1,6));
  println(label);
  img = loadImage(label + ".jpg");
 for(Chroma c: patch) {
  c.changeColor(img.get(floor(random(img.width)), floor(random(img.height))));
 }
}

void keyPressed() {
 endRecord();
 exit();
}

//void mousePressed() {
//  fill(255);
//  rect(0, 0, width, height);

//  println(patch.size());
//  int label = floor(random(1, 5));
//  img = loadImage(label + ".jpg");
//  img.resize(400, 300);

//  while(patch.size() > 0) {
//   for(int i = 0; i < patch.size(); i++) {
//    patch.remove(i); 
//   }
//  }

//  println(patch.size());

//  for(int i = 0; i < img.width; i+= spacing) {
//   for(int j = 0; j < img.height; j+= spacing) {
//    patch.add(new Chroma(i+100,j+100, img.get(i,j)));
//   }
//  }
//}
