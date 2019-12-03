import processing.core.*;

abstract class Boid {
  protected double x;
  protected double y;
  protected double vx;
  protected double vy;
  protected double v = 5;
  protected final static double maxv = 7;
  protected final static double minv = 2;
  protected double ax;
  protected double ay;
  protected double a;
  protected double theta;
  protected double nextTheta;
  protected final static double maxTurn = Math.PI/50;
  protected final static double r = 10;
  
  public double getX() {
   return x;
  }
  
  public double getY() {
    return y;
  }
  
  public double wrapX(Boid b) {
    double min = x - b.getX();
    for(int i = -1; i <= 1; i++) {
      double temp = (x + i * BoidDriver3.sketch.width) - b.getX();
      if(Math.abs(temp) < Math.abs(min)) min = temp;
    }
    return min;
  }
  
  public double getTheta() {
    return theta; 
  }
  
  public double wrapY(Boid b) {
    double min = y - b.getY();
    for(int i = -1; i <= 1; i++) {
      double temp = (y + i * BoidDriver3.sketch.height) - b.getY();
      if(Math.abs(temp) < Math.abs(min)) min = temp;
    }
    return min;
  }
  
  protected void randomize() {
     x = BoidDriver3.sketch.random(BoidDriver3.sketch.width);
     y = BoidDriver3.sketch.random(BoidDriver3.sketch.height);
     theta = BoidDriver3.sketch.random((float)Math.PI * 2);
     vx = v * Math.cos(theta);
     vy = v * Math.sin(theta);
  }
  
  protected void wrapAround() {
     if(x > BoidDriver3.sketch.width) x = 0;
     if(x < 0) x = BoidDriver3.sketch.width;
     if(y > BoidDriver3.sketch.height) y = 0;
     if(y < 0) y = BoidDriver3.sketch.height;
  }
  
  public abstract void update();
  
  protected int sign(double f) {
   if(f < 0) return -1;
   return 1;
  }
  
  protected void turn() {
   double diff = nextTheta - theta;
   if(Math.abs(diff) > Math.PI) diff -= sign(diff)* (Math.PI * 2);
   double partMaxTurn = sigmoid(a)*maxTurn;
   if(Math.abs(diff) > partMaxTurn) theta += sign(diff)*partMaxTurn; else theta = nextTheta;
   if(theta < 0) theta += (Math.PI * 2);
   theta = theta % (Math.PI * 2);
  }
  
  protected void thrust() {
   double diff = nextTheta - theta;
   if(Math.abs(diff) > Math.PI) diff -= sign(diff)* (Math.PI * 2);
   diff = Math.abs(diff);
   boolean decelerate = false;
   if(diff > Math.PI/2) {
     diff = Math.PI - diff;
     decelerate = true;
   }
   double thrust = a * Math.cos(diff);
   if(decelerate) thrust = -1*thrust; //-2*thrust
   
   v += thrust;
   if(v < minv) v = minv;
   if(v > maxv) v = maxv;
   vx = v * Math.cos(theta);
   vy = v * Math.sin(theta);
  }
  
  private double sigmoid(double n) {
     return 1/(1+Math.pow((double)Math.E,-(10*n-2)));
  }
  
  public void display() { 
	  BoidDriver3.sketch.pushMatrix();
	  BoidDriver3.sketch.translate((float)x,(float)y);
   
	  BoidDriver3.sketch.rotate((float) theta);
   
	  BoidDriver3.sketch.beginShape();
	  BoidDriver3.sketch.vertex((float)r,0);
	  BoidDriver3.sketch.vertex((float)-r,(float) r/2);
	  BoidDriver3.sketch.vertex((float)-r/2,0);
	  BoidDriver3.sketch.vertex((float)-r,(float) -r/2);
	  BoidDriver3.sketch.endShape();
   
	  BoidDriver3.sketch.popMatrix(); 
  }
  
}