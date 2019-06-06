import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
OpenCV eyeFinder;

PImage image;
PImage memoryImage;
PImage capturedImage;
PImage pix;
int count;
int chromaCount;
Organism org;

PVector mLoc;
boolean toggleFace;

float a;
float b;

void setup() {
  size(640,480, P2D);
  //fullScreen(OPENGL);
  noCursor();
  frameRate(60);
  video = new Capture(this, width/2, height/2);
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  org = new Organism(250);
  memoryImage = new PImage();
  mLoc = new PVector();
  count = 1;
  chromaCount = 0;
  toggleFace = false;
  video.start();
  video.loadPixels();
}

void draw() {
  background(0);
  scale(2);
  opencv.loadImage(video);
  opencv.flip(OpenCV.HORIZONTAL);
  opencv.useColor();
  capturedImage = opencv.getOutput();

  scale(1);
  Rectangle[] faces = opencv.detect();

  if (faces.length > 0) {
    renderOcto(faces);
  } else {
    autonomous();
  }
}  

void autonomous() {
 if (frameCount % 700 == 0) {
      if (count > 0) {
        memoryImage = recallFace(int(random(count)));
        memoryImage.resize(200, 200);
      }
    }

    if (count > 0) { 
      for (Chroma c : org.chroma) {
        int lX = int(map(c.location.x, 0, width, 0, memoryImage.width));
        int lY = int(map(c.location.y, 0, height, 0, memoryImage.height));
        c.changeColor(memoryImage.get(lX, lY));
      }
    }

    if (frameCount % 300 == 0) {
      mLoc = new PVector(int(random(width/2)), int(random(height/2)));
    }

    org.run(mLoc); 
}


void keyPressed() {
  if (key == 'f') {
    toggleFace = !toggleFace;
  }
}

void renderOcto(Rectangle[] faces) {
  for (int i = 0; i < faces.length; i++) {
    pix = capturedImage.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

    if (frameCount % 600 == 0) {
      captureFaces(pix);
    }

    for (Chroma c : org.chroma) {
      int lX = int(c.location.x);
      int lY = int(c.location.y);
      c.changeColor(capturedImage.get(lX, lY));
    }

    if (toggleFace) {
      image(pix, faces[i].x, faces[i].y);
    }

    PVector cLoc = new PVector(faces[i].x+(faces[i].width/2), faces[i].y+(faces[i].height/2));
    org.run(cLoc);
  }
}


PImage recallFace(int index) {
  PImage memory = loadImage("image/output_" + index + ".jpg");
  println(memory);
  return memory;
}


void captureFaces(PImage img) {
  println("capturing faces");
  img.save("image/output_" + count + ".jpg");
  count++;
}


void captureEvent(Capture c) {
  c.read();
}
