static ArrayList<Boid> boids = new ArrayList<Boid>();

void setup() {
  size(1000, 1000, FX2D);
  noStroke();
  for(int i = 0; i < 100; i++)
    boids.add(new BetaBoid());
}

void draw() {
  background(0);
  for(Boid b: boids) {
   b.update();
   b.display();
  }
}

//void keyPressed() {
//  if(key == 'K') frameRate(60);
//  else if(key == 'D') frameRate(1);
//}
