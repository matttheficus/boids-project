abstract class Boid {
  protected float x;
  protected float y;
  protected float vx;
  protected float vy;
  protected float v = 5;
  protected final static float maxv = 7;
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
  
  protected int sign(float f) {
   if(f < 0) return -1;
   return 1;
  }
  
  protected void turn() {
   float diff = nextTheta - theta;
   if(abs(diff) > PI) diff -= sign(diff)*TWO_PI;
   float partMaxTurn = sigmoid(a)*maxTurn;
   if(abs(diff) > partMaxTurn) theta += sign(diff)*partMaxTurn; else theta = nextTheta;
   if(theta < 0) theta += TWO_PI;
   theta = theta % TWO_PI;
  }
  
  protected void thrust() {
   float diff = nextTheta - theta;
   if(abs(diff) > PI) diff -= sign(diff)*TWO_PI;
   diff = abs(diff);
   boolean decelerate = false;
   if(diff > PI/2) {
     diff = PI - diff;
     decelerate = true;
   }
   float thrust = a * cos(diff);
   if(decelerate) thrust = -1*thrust; //-2*thrust
   
   v += thrust;
   if(v < minv) v = minv;
   if(v > maxv) v = maxv;
   vx = v * cos(theta);
   vy = v * sin(theta);
  }
  
  private float sigmoid(float n) {
     return 1/(1+pow((float)Math.E,-(10*n-2)));
  }
  
  public void display() { 
   pushMatrix();
   translate(x,y);
   
   //stroke(255);
   //line(0,0, 20*cos(averageAngle), 20*sin(averageAngle));
   //noStroke();
   
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
