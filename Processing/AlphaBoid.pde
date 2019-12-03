class AlphaBoid extends Boid {
  public AlphaBoid(float x, float y) {
     randomize();
     this.x = x;
     this.y = y;
  }
  
  public void update() {
   if(mouseX - x != 0) nextTheta = atan((mouseY - y)/(mouseX - x));
   if(nextTheta < 0) nextTheta += TWO_PI;
   if(mouseX - x < 0) nextTheta += PI;
   
   a = sqrt(sq(mouseX - x) + sq(mouseY - y))/1000;
   
   thrust();
   turn();
   
   if(sqrt(sq(mouseX - x) + sq(mouseY - y)) > v) {
     x += vx;
     y += vy;
   }
   
   display();
  }
  
  public void display() {
    fill(255, 0, 0);
    super.display();
    fill(255);
  }
}
