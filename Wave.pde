class Wave
{
  PVector center;
  float radius;
  color bodyColor;
  
  Wave(float x, float y, float r, color c)
  {
    center = new PVector(x, y);
    radius = r;
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
  }
  
  void display()
  {
    pushMatrix();
    translate(center.x, center.y);
    noFill();
    stroke(bodyColor);
    strokeWeight(1.5);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  boolean isDead(float value)
  {
    if(radius > value)
    {
      return true;
    }
    
    return false;
  }
}