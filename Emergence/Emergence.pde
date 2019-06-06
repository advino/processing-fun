
ArrayList<Ant> ants;
ArrayList<Ant> workers;
ArrayList<Ant> farmers;
ArrayList<Ant> soldiers;
FlowField flow;

String type1, type2, type3;

int time;

void setup() {
  size(500, 500, OPENGL);
  smooth();
  flow = new FlowField(20);

  time = 0;

  type1 = "Soldier";
  type2 = "Worker";
  type3 = "Farmer";

  ants = new ArrayList<Ant>();
  workers = new ArrayList<Ant>();
  soldiers = new ArrayList<Ant>();
  farmers = new ArrayList<Ant>();


  for (int i = 0; i < 10; i++) {
    ants.add(new Ant(random(width), random(height), type1)); 
    ants.add(new Ant(random(width), random(height), type2)); 
    ants.add(new Ant(random(width), random(height), type3));
  }


  println("Inital Population Size: " + ants.size());
  //checkPopulation();
}






void draw() {

  background(255);



  for (Ant a : ants) {
    a.run(); 
    a.follow(flow);
    a.aging();
    a.exchangeMessage();
  }

  checkPopulation();
  mate();
  lifeTime();

  time ++;




  text("Total: " + ants.size(), 10, 80);
}


void lifeTime() {

  for (int i = 0; i < ants.size(); i ++) {
    Ant currentAnt = ants.get(i);
    int currentAntAge = currentAnt.age;

    if (currentAntAge == 1500) {
      ants.remove(i);
    }
  }
}


void mate() {

  if ( time % 500 == 0 && time != 0) {

    for (int i = 0; i < ants.size(); i ++) {
      Ant parentAntMale = ants.get(i);
      Ant parentAntFemale = ants.get(floor(random(ants.size())));
      PVector parentAntMaleLoc = parentAntMale.location;
      PVector parentAntFemaleLoc = parentAntFemale.location;
      String parentAntMaleType = parentAntMale.type;
      String parentAntFemaleType = parentAntFemale.type;

      float d = PVector.dist(parentAntMaleLoc, parentAntFemaleLoc);

      if (d < 10) {
        println("Baby " + parentAntFemaleType + " is born!");
        ants.add(new Ant(parentAntFemaleLoc.x, parentAntFemaleLoc.y, parentAntFemaleType));
      }
    }
  }
}



void checkPopulation() {

  for (int i = 0; i < ants.size(); i ++) {
    String category = ants.get(i).type;
    Ant currentAnt = ants.get(i);

    if (i < ants.size() - 1) {

      switch(category) {

      case "Farmer":
        //farmerCount ++;
        farmers.add(currentAnt);
        break;  

      case "Worker":
        //workerCount ++;
        workers.add(currentAnt);
        break;

      case "Soldier":
        //soliderCount ++;
        soldiers.add(currentAnt);
        break;

      default:
        break;
      }
    } else {

      switch(category) {

      case "Farmer":
        //farmerCount ++;
        farmers.add(currentAnt);
        break;  

      case "Worker":
        //workerCount ++;
        workers.add(currentAnt);
        break;

      case "Soldier":
        //soliderCount ++;
        soldiers.add(currentAnt);
        break;

      default:
        break;
      }

      float antTotal = ants.size();

      text("Workers: " + workers.size(), 10, 40);
      float worker = workers.size(); 
      float workerPercent = (worker/antTotal)*100;
      text((worker/antTotal)*100 + "%",90,40);
      
      if (workerPercent < 30) {

         ants.get(floor(random(ants.size()))).type = "Worker";
      }
      
      text("Farmers: " + farmers.size(), 10, 60);
      float farmer = farmers.size(); 
      float farmerPercent = (farmer/antTotal)*100;
      text((farmer/antTotal)*100 + "%", 90, 60);
      
      if (farmerPercent < 30) {

         ants.get(floor(random(ants.size()))).type = "Farmer";
      }
      
      
      text("Soliders: " + soldiers.size(), 10, 20);
      float soldier = soldiers.size(); 
      float soldierPercent = (soldier/antTotal)*100;
      text((soldier/antTotal)*100 + "%", 90, 20);
     
     
      if (soldierPercent < 30) {

         ants.get(floor(random(ants.size()))).type = "Soldier";
      }


      for (int j = 0; j < workers.size(); i++) {
        workers.remove(j);
      }
      for (int j = 0; j < farmers.size(); i++) {
        farmers.remove(j);
      }
      for (int j = 0; j < soldiers.size(); i++) {
        soldiers.remove(j);
      }
    }
  }
}