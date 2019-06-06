class Chroma {
  int x;
  int y;
  float r;
  float value;
  color Pixel;
  color inter;
 Chroma(int _x, int _y, color pix) {
   x = _x;
   y = _y;
   Pixel = pix;
   r = 0;
   inter = color(255);
 }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y; 
  }
  
  String getPix() {
   return hex(inter); 
  }
  
  void changeColor(color newColor) {
   Pixel = newColor;
  }
  
  void checkLoc() {
   print(getX(), getY()); 
  }
  
  void update() {
   inter = lerpColor(inter, Pixel, .05);
   float value = map(brightness(inter),0,255,0,20);
   r = lerp(r, value, .05);
  }
  
  void display() {
   pushMatrix();
   translate(x,y);
   noStroke();
   fill(inter);
   ellipse(0,0,r,r);
   fill(hue(inter));
   ellipse(0,0,r/2,r/2);
   popMatrix();
  }
  
}
