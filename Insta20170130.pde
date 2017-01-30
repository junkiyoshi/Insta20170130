import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Box box;
Obstacle[] obstacles;

void setup()
{
  size(512, 512);
  background(255);
  frameRate(30);
  colorMode(HSB);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  
  box = new Box();
  
  particles = new ArrayList<Particle>();
  obstacles = new Obstacle[8];
  obstacles[0] = new Obstacle(width / 6 * 1, height / 6 * 1);
  obstacles[1] = new Obstacle(width / 6 * 1, height / 6 * 3);
  obstacles[2] = new Obstacle(width / 6 * 1, height / 6 * 5);
  obstacles[3] = new Obstacle(width / 6 * 5, height / 6 * 1);
  obstacles[4] = new Obstacle(width / 6 * 5, height / 6 * 3);
  obstacles[5] = new Obstacle(width / 6 * 5, height / 6 * 5);
  obstacles[6] = new Obstacle(width / 6 * 3, height / 6 * 1);
  obstacles[7] = new Obstacle(width / 6 * 3, height / 6 * 5);
}

void draw()
{
  box2d.step();
  background(0);
  
  for(Obstacle obs : obstacles)
  {
    obs.display();
  }
  
  if(frameCount % 15 == 0)
  {
    float power = random(50, 150);
    float x = power * cos(radians(random(360)));
    float y = power * sin(radians(random(360)));
    Particle p = new Particle(width / 2, height / 2, 25, color(random(255), 255, 255));
    p.body.setLinearVelocity(new Vec2(x, y));
    particles.add(p);
  }  
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.display();
    
    if(p.isDead())
    {
      it.remove();
    }
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 3600)
  {
     exit();
  }
  */
}

void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o1;
    Particle p = (Particle)o2;
    o.changeColor(p.bodyColor);
  }
  else if(o2.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o2;
    Particle p = (Particle)o1;
    o.changeColor(p.bodyColor);
  }
}