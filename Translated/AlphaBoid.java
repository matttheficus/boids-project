import processing.core.*;

class AlphaBoid extends Boid {
	
	
  public AlphaBoid(double x, double y) {
     randomize();
     this.x = x;
     this.y = y;
  }
  
  
  public void update() {
   if(BoidDriver3.sketch.mouseX - x != 0) nextTheta = Math.atan((BoidDriver3.sketch.mouseY - y)/(BoidDriver3.sketch.mouseX - x));
   if(nextTheta < 0) nextTheta += (Math.PI * 2);
   if(BoidDriver3.sketch.mouseX - x < 0) nextTheta += Math.PI;
   
   a = Math.sqrt(Math.pow(BoidDriver3.sketch.mouseX - x, 2) + Math.pow(BoidDriver3.sketch.mouseY - y,2))/1000;
   
   thrust();
   turn();
   
   if(Math.sqrt(Math.pow(BoidDriver3.sketch.mouseX - x, 2) + Math.pow(BoidDriver3.sketch.mouseY - y,2)) > v) {
     x += vx;
     y += vy;
   }
   
   display();
  }
  
  public void display() {
    BoidDriver3.sketch.fill(255, 0, 0);
    super.display();
    BoidDriver3.sketch.fill(255);
  }
}
