import java.util.ArrayList;
import processing.core.*;

class BetaBoid extends Boid {
  private double viewDistance = 200;
  private ArrayList<Boid> boids;
  
  public BetaBoid() {
    randomize(); 
  }
  
  public BetaBoid(int x, int y) {
    randomize();
    this.x = x;
    this.y = y;
  }
  
  PApplet sketch;
  
  public void update() {
    boids = new ArrayList<Boid>();
    for(Boid b: BoidDriver3.boids)
      if(b != this && sees(b)) boids.add(b);
    
    if(!boids.isEmpty()) {
      ax = 0;
      ay = 0;
      
      separation();
      cohesion();   
      
      a = Math.pow(Math.pow(ax,2) + Math.pow(ay,2),2);
      if(ax != 0) nextTheta = Math.atan(ay/ax);
      if(nextTheta < 0) nextTheta += Math.PI * 2;
      if(ax < 0) nextTheta += Math.PI;
      
      thrust();
      
      allignment();
      turn();
    }
    
    x += vx;
    y += vy;
    wrapAround();
  }
  
  private void separation() {
    for(Boid b: boids) {
      if(b.wrapX(this) != 0) nextTheta = Math.atan((b.wrapY(this))/(b.wrapX(this)));
      if(nextTheta < 0) nextTheta += Math.PI * 2;
      if(b.wrapX(this) < 0) nextTheta += Math.PI;
      
      if(distance(b) != 0) a = -1/distance(b);
      ax += a * Math.cos(nextTheta);
      ay += a * Math.sin(nextTheta);
    }
  }
  
  private void cohesion() {
    double averageX = 0; //both of these are relative
    double averageY = 0;
    for(Boid b: boids) {
      averageX += b.wrapX(this);
      averageY += b.wrapY(this);
    }
    averageX /= (boids.size() + 1);
    averageY /= (boids.size() + 1);
    if(averageX != 0) nextTheta = Math.atan(averageY/averageX);
    if(nextTheta < 0) nextTheta += Math.PI * 2;
    if(averageX < 0) nextTheta += Math.PI;
    
    a = Math.pow(Math.pow(averageX, 2) + Math.pow(averageY,2),2)/200;
    ax += a * Math.cos(nextTheta);
    ay += a * Math.sin(nextTheta);
  }
  
  private void allignment() {
    double sinSum = Math.sin(nextTheta);
    double cosSum = Math.cos(nextTheta);
    for(int i = 0; i < boids.size(); i++) {
      sinSum += Math.sin(boids.get(i).getTheta());
      cosSum += Math.cos(boids.get(i).getTheta());
    }
    
    sinSum /= (boids.size() + 1);
    cosSum /= (boids.size() + 1);
    double averageAngle = (double) Math.atan2(sinSum, cosSum); //<>//
    
    sinSum = (Math.sin(averageAngle) + Math.sin(nextTheta)) / 2;
    cosSum = (Math.cos(averageAngle) + Math.sin(nextTheta)) / 2;
    
    nextTheta = (double) Math.atan2(sinSum, cosSum);
  }
  
  private double distance(Boid b) {
    return Math.pow(Math.pow(b.wrapX(this),2) + Math.pow(b.wrapY(this),2),2);
  }
  
  private boolean sees(Boid b) {
    return distance(b) < viewDistance;
  }
}