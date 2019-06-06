int count = 50;
int indexer = 0;
ArrayList<ball> balls;

void setup() {
  size(600, 600, P2D);
  frameRate(30);
  balls = new ArrayList<ball>();
  for (int i = 0; i < width - (count/2 + 2*count); i += count) {
    for (int j = 0; j < height - (count/2 + 2*count); j += count) {
      balls.add(new ball(i+count + count/2, j+count + count/2, indexer));
      indexer ++;
    }
  }
  // background(0);
}

void draw() {
  background(0);
  createGrid();

  for (ball b : balls) {
    b.display(); 
    b.update();
    b.liner();
  }
}

void createGrid() {
  for (int i = 0; i < width - count; i += count) {
    for (int j = 0; j < height - count; j += count) {
      int x = i + count;
      int y = j + count;
      stroke(255);
      strokeWeight(4);
      point(x, y);
      if (i < width - (2*count)) {
        strokeWeight(.5);
        line(x, y, x+count, y);
      }

      if (j < height - (2*count)) {
        strokeWeight(.5);
        noFill();
        line(x, y, x, y+count);
      }
    }
  }
}
