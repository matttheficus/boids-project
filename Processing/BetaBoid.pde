class BetaBoid extends Boid {
  private float viewDistance = 200;
  private ArrayList<Boid> boids;
  
  public BetaBoid() {
    randomize(); 
  }
  
  void update() {
    boids = new ArrayList<Boid>();
    for(Boid b: BoidDriver2.boids)
      if(b != this && sees(b)) boids.add(b);
    
    if(!boids.isEmpty()) {
      ax = 0;
      ay = 0;
      
      separation();
      cohesion();   
      
      a = sqrt(sq(ax) + sq(ay));
      if(ax != 0) nextTheta = atan(ay/ax);
      if(nextTheta < 0) nextTheta += TWO_PI;
      if(ax < 0) nextTheta += PI;
      
      thrust();
      
      //allignment();
      turn();
    }
    
    x += vx;
    y += vy;
    wrapAround();
  }
  
  private void separation() {
    for(Boid b: boids) {
      if(b.wrapX(this) != 0) nextTheta = atan((b.wrapY(this))/(b.wrapX(this)));
      if(nextTheta < 0) nextTheta += TWO_PI;
      if(b.wrapX(this) < 0) nextTheta += PI;
      
      if(distance(b) != 0) a = -3/sq(distance(b));
      ax += a * cos(nextTheta);
      ay += a * sin(nextTheta);
    }
  }
  
  private void cohesion() {
    float averageX = 0; //both of these are relative
    float averageY = 0;
    for(Boid b: boids) {
      averageX += b.wrapX(this);
      averageY += b.wrapY(this);
    }
    averageX /= boids.size();
    averageY /= boids.size();
    if(averageX != 0) nextTheta = atan(averageY/averageX);
    if(nextTheta < 0) nextTheta += TWO_PI;
    if(averageX < 0) nextTheta += PI;
    
    a = sqrt(sq(averageX) + sq(averageY))/10000;
    ax += a * cos(nextTheta);
    ay += a * sin(nextTheta);
  }
  
  //private void allignment() { // (((angle/size + angle/size) + angle/size) + angle/size)...
  //  float averageAngle = boids.get(0).getTheta() / boids.size();
  //  for(int i = 1; i < boids.size(); i++) {
  //    float temp = boids.get(i).getTheta();
  //    if(abs(averageAngle - temp) > PI) 
  //  }
  //}
  
  private void turn() {
    float diff = nextTheta - theta;
   if(abs(diff) > PI) diff -= sign(diff)*TWO_PI;
   if(abs(diff) > maxTurn) theta += sign(diff)*maxTurn; else theta = nextTheta;
   
   if(theta < 0) theta += TWO_PI;
   theta = theta % TWO_PI;
  }
  
  private void thrust() {
   float diff = nextTheta - theta;
   if(abs(diff) > PI) diff -= sign(diff)*TWO_PI;
   diff = abs(diff);
   boolean decelerate = false;
   if(diff > PI/2) {
     diff = PI - diff;
     decelerate = true;
   }
   float thrust = a * cos(diff);
   if(decelerate) thrust = -2*thrust;
   
   v += thrust;
   if(v < minv) v = minv;
   if(v > maxv) v = maxv;
   vx = v * cos(theta);
   vy = v * sin(theta);
  }
  
  private int sign(float f) {
   if(f < 0) return -1;
   return 1;
  }
  
  private float distance(Boid b) {
    return sqrt(sq(b.wrapX(this)) + sq(b.wrapY(this)));
  }
  
  private boolean sees(Boid b) {
    return distance(b) < viewDistance;
  }
  
  //public void display() {
  // stroke(255);
  //   noFill();
  //   for(int i = -1; i <= 1; i++)
  //    for(int j = -1; j <= 1; j++)
  //      ellipse(i*width + x, j*height + y, 2*viewDistance, 2*viewDistance);
     
  //   noStroke();
  //   fill(255);
  //   super.display();
  //}
  
}
