class Organism {
  ArrayList<Chroma> chroma; 
  int size;
  Organism(int _size) {
    size = _size;
    chroma = new ArrayList<Chroma>();
    for (int i = 0; i < size; i++) {
      chroma.add(new Chroma(floor(random(width)), floor(random(height)), color(255, 255, 255)));
    }
  }

  void run(PVector target) {
    render();
    update();
    arrive(target);
    
  }

  void render() {
    for (Chroma c : chroma) {
      c.render();
    }
  }

  void update() {
    for (Chroma c : chroma) {
      c.update();
    }
  }

  void arrive(PVector target) {
    for (Chroma c : chroma) {
      c.applyBehaviors(chroma, target);
      
    }
  }
}
