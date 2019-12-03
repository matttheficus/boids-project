class BetaBoid extends Boid {
  private float viewDistance = 200;
  private ArrayList<Boid> boids;
  
  public BetaBoid() {
    randomize(); 
  }
  
  public BetaBoid(int x, int y) {
    randomize();
    this.x = x;
    this.y = y;
  }
  
  void update() {
    boids = new ArrayList<Boid>();
    for(Boid b: BoidDriver3.boids)
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
      
      allignment();
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
      
      if(distance(b) != 0) a = -1/distance(b);
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
    averageX /= (boids.size() + 1);
    averageY /= (boids.size() + 1);
    if(averageX != 0) nextTheta = atan(averageY/averageX);
    if(nextTheta < 0) nextTheta += TWO_PI;
    if(averageX < 0) nextTheta += PI;
    
    a = sqrt(sq(averageX) + sq(averageY))/200;
    ax += a * cos(nextTheta);
    ay += a * sin(nextTheta);
  }
  
  private void allignment() {
    float sinSum = sin(nextTheta);
    float cosSum = cos(nextTheta);
    for(int i = 0; i < boids.size(); i++) {
      sinSum += sin(boids.get(i).getTheta());
      cosSum += cos(boids.get(i).getTheta());
    }
    
    sinSum /= (boids.size() + 1);
    cosSum /= (boids.size() + 1);
    float averageAngle = (float) Math.atan2(sinSum, cosSum); //<>//
    
    sinSum = (sin(averageAngle) + sin(nextTheta)) / 2;
    cosSum = (cos(averageAngle) + sin(nextTheta)) / 2;
    
    nextTheta = (float) Math.atan2(sinSum, cosSum);
  }
  
  private float distance(Boid b) {
    return sqrt(sq(b.wrapX(this)) + sq(b.wrapY(this)));
  }
  
  private boolean sees(Boid b) {
    return distance(b) < viewDistance;
  }
}
