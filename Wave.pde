class Wave
{
  PVector center;
  float radius;
  float lifespan;
  color bodyColor;
  
  Wave(float x, float y, float r, color c)
  {
    center = new PVector(x, y);
    radius = r;
    lifespan = 255;
    bodyColor = c;
  }
  
  void run()
  {
    update();
    display();
  }
  
  void update()
  {
    radius += 1;
    lifespan -= 3;
  }
  
  void display()
  {
    pushMatrix();
    translate(center.x, center.y);
    noFill();
    stroke(bodyColor, lifespan);
    strokeWeight(2);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  boolean isDead()
  {
    if(lifespan < 0)
    {
      return true;
    }
    
    return false;
  }
}