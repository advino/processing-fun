
ArrayList<prey> zebras;
ArrayList<predator> lions;
FlowField flow;


float distance;
void setup() {
  size(600, 600, P2D);
  flow = new FlowField(20);
  zebras = new ArrayList<prey>();
  lions = new ArrayList<predator>();
  
  for (int i = 0; i < 5; i++) {
   lions.add(new predator(random(width), random(height), random(5, 8)));
  }
  
  for (int i = 0; i < 75; i++) {
    zebras.add(new prey(random(width), random(height), random(1, 5)));
  }
}

void draw() {
  background(72, 202, 253);
  //randomSeed(0);
  for (predator l : lions) {
   l.run(); 
   l.follow(flow);
   l.chase();
  }
  for (prey z : zebras) {
    z.run();
    z.follow(flow);
  }
  
  
}