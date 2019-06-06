//creates a table for the data
Table volume;
//calculates the total number of data rows
int totalValues;
//value for the sinusodal pulse
float value;
//value for the frequency of the pulse
int size; 

int lineColor;

void setup() {
  size(600, 600,P2D);
  volume = loadTable("jollySing.csv", "header");
  totalValues = volume.getRowCount();
  frameRate(150);
  background(255,255, 255);
}



void draw() {

 
  
  
  stroke(255,255,255,60);
  strokeWeight(.5);
  line(0, height/2, width, height/2);
  //line(0,height/4,width,height/4);
  for (int i = 0; i < totalValues; i++) {

    // showing the sinusodal value for the circle expansion
    //value = value + .00001*volume.getRow(i).getInt("value");
    value = value + .000020;
    //this determines the intensty of the pulse based on the cateogory of the sound.
    String category = volume.getRow(i).getString("category"); 
    switch(category) {
    case "Low": 
      size = 30;
      println("low");
      break;
    case "Medium":
      size = 60;
      println("medium");
      break;
    case "High":
      size = 90;
      println("high");
      break;
    default:
      break;
    }
    //creates the outer circle, diameter is the value of the row
    noFill();
    ellipse(i*20, height/2, 80*sin(value*size)+volume.getRow(i).getInt("value"), 80*sin(value*size)+volume.getRow(i).getInt("value"));
    fill(255);

    //creates the center points
    ellipse(i*20, height/2, 2, 2);

    //creates second set of points 
    ellipse(i*20, height/2, 2, 2);

    //strokeWeight(.5);
    //line(i*20,400,i*20,400-volume.getRow(i).getInt("value"));
  }
  noStroke();
  fill(0,0,0,25);
  rect(0,0,width,height);
}