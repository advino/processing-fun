import processing.video.*;

Capture myCap;
ArrayList<Slice> slices;
FlowField flow;

void setup() {
  size(640, 480, P2D);
  smooth(10);
  frameRate(300);
  myCap = new Capture(this, width, height);
  myCap.start();

  flow = new FlowField(50);
  slices = new ArrayList<Slice>();
  for (int i = 0; i < 10; i ++) {
    slices.add(new Slice(myCap, width * i * .05));
  }

  background(0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  for (Slice s : slices) {
    s.display();
    s.follow(flow);
    s.borders();
    s.update();
  }

  if (frameCount % 2000 == 0) {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
  }
}
