import processing.pdf.*;

PGraphicsPDF pdf;

ArrayList<comp> Comp;
int counterFries;
float[][] selectedData = new float[2][];
int generation;


void setup() {
  size(400, 400); 
  //noCursor();
  generation = 0;
  Comp = new ArrayList<comp>();
  frameRate(30);
  for (int i = 50; i < width; i += 60) {
    for (int j = 55; j < height; j += 60) {

      float DNA[] = {floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18)), floor(random(18))};
      Comp.add(new comp(i, j, DNA));
    }
  }
  
  pdf = (PGraphicsPDF)beginRecord(PDF, "Matrix.pdf");
}

void draw() {
  background(255);

  noStroke();
  fill(255, 0, 0, 25);
  //ellipse(mouseX, mouseY, 45, 45);

  for (comp c : Comp) {
    c.display();
    if (mousePressed) {
      c.selectComp();
    }
  }

  if (counterFries == 2) {
    pdf.nextPage();
    generate(selectedData[0], selectedData[1]);
    counterFries = 0;
  }

  fill(0);
  text("Composition Maker", 25, 20);
  text("Generation: " + generation, 298, 20);
}


float[] crossData(float[] setOne, float[] setTwo) {
  float[] crossedSet = new float[setOne.length];
  for (int i = 0; i < setOne.length; i++) {
    float num = random(1);
    if (num > .5) {
      crossedSet[i] = setOne[i];
    } else {
      crossedSet[i] = setTwo[i];
    }
  }
  for (int i = 0; i < crossedSet.length; i++) {
    float randNum = random(1);
    if (randNum < .05) {
      crossedSet[i] = random(18);
    }
  }

  return crossedSet;
}

void generate(float[] setOne, float[] setTwo) {

  if (Comp.size() > 0) {
    Comp.clear();
  }
  for (int i = 50; i < width; i += 60) {
    for (int j = 50; j < height; j += 60) {

      float[] DNA = crossData(setOne, setTwo);
      Comp.add(new comp(i, j, DNA));
    }
  }

  generation++;
}


void removeAll() {
  
  for (int i = Comp.size() - 1; i >= 0; i--) {
    Comp.remove(i);
  }
}

void keyPressed() {
 if(key == 's') {
   endRecord();
 }
}
