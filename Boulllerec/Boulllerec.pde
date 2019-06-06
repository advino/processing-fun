Boullerec[] strokes = new Boullerec[15];
void setup() {
size(600,600);  
for(int x = 0; x < strokes.length; x++) {
   strokes[x] = new Boullerec(); 
}
}


void draw() {
background(40,255,255);
for( int x = 0; x < strokes.length; x++) {
  strokes[x].display(); 
  strokes[x].update();
}
  
}