import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BoidDriver3 extends PApplet {

static ArrayList<Boid> boids = new ArrayList<Boid>();

public static PApplet sketch;


public void setup() {
  
  noStroke();
  for(int i = 0; i < 100; i++)
    boids.add(new BetaBoid());
}

public void draw() {
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

public void mousePressed() {
   AlphaBoid alpha = new AlphaBoid(mouseX, mouseY);
   for(int i = 0; i < 100; i++)
     boids.add(alpha);
}

  public void settings() {  size(1000, 1000, FX2D); }
  static public void main(String[] passedArgs) {
	  
	  String[] processingArgs = {"BoidDriver3"};
	  BoidDriver3 driver = new BoidDriver3();
	  sketch = driver;
	  PApplet.runSketch(processingArgs, sketch);
  }
}
