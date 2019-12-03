static ArrayList<Boid> boids = new ArrayList<Boid>();

void setup() {
  size(1000, 1000, FX2D);
  noStroke();
  for(int i = 0; i < 100; i++)
    boids.add(new BetaBoid());
}

void draw() {
  background(0);
  int i;
  for(i = 0; i < boids.size(); i++) {
    if(boids.get(i) instanceof AlphaBoid) break;
    boids.get(i).update();
    boids.get(i).display();
  }
  
  if(i < boids.size() && boids.get(i) instanceof AlphaBoid){
    boids.get(i).update();
    boids.get(i).display();
  }
}

void mousePressed() {
   AlphaBoid alpha = new AlphaBoid(mouseX, mouseY);
   for(int i = 0; i < 100; i++)
     boids.add(alpha);
}
