abstract class Boid {
  protected float x;
  protected float y;
  protected float vx;
  protected float vy;
  protected float v = 5;
  protected final static float maxv = 10;
  protected final static float minv = 2;
  protected float ax;
  protected float ay;
  protected float a;
  protected float theta;
  protected float nextTheta;
  protected final static float maxTurn = PI/50;
  protected final static float r = 10;
  
  public float getX() {
   return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float wrapX(Boid b) {
    float min = x - b.getX();
    for(int i = -1; i <= 1; i++) {
      float temp = (x + i * width) - b.getX();
      if(abs(temp) < abs(min)) min = temp;
    }
    return min;
  }
  
  public float getTheta() {
    return theta; 
  }
  
  public float wrapY(Boid b) {
    float min = y - b.getY();
    for(int i = -1; i <= 1; i++) {
      float temp = (y + i * height) - b.getY();
      if(abs(temp) < abs(min)) min = temp;
    }
    return min;
  }
  
  protected void randomize() {
     x = random(width);
     y = random(height);
     theta = random(TWO_PI);
     vx = v * cos(theta);
     vy = v * sin(theta);
  }
  
  protected void wrapAround() {
     if(x > width) x = 0;
     if(x < 0) x = width;
     if(y > height) y = 0;
     if(y < 0) y = height;
  }
  
  public abstract void update();
  
  public void display() { 
   pushMatrix();
   translate(x,y);
   rotate(theta);
   
   beginShape();
   vertex(r,0);
   vertex(-r, r/2);
   vertex(-r/2,0);
   vertex(-r, -r/2);
   endShape();
   
   popMatrix(); 
  }
  
}
