class Room {
  public String ID;
  public float x, y;
  public float w, h;
  public float[] wRange = new float[2];
  public float[] hRange = new float[2];
  public float angle;
  public color col = color(255, 255, 255);
  
  
  public Room (float px, float py, float miw, float maw, float mih, float mah) {
    x = px; y = py;
    wRange[0] = miw; wRange[1] = maw;
    hRange[0] = mih; hRange[1] = mah;
    randomize();
  } 
  
  boolean info = false; // Whether it displayed info in the previous frame 
  public void display (){
    float a = 64;
    float ecc = w/h;
    if (ecc > 1){
      ecc = h/w;
    }
    
    if ((mouseX-offx < x+w && mouseX-offx > x-w) && (mouseY-offy < y+h && mouseY-offy > y-h)){
      a = 255;
      
      if (!info){
        println("\nRoom: "+ID+" ---------------");
        println ("x="+x+" ; y="+y);
        println ("w="+w+" ; h="+h);
        println ("wonk: "+(1-ecc));
        println ("slide-angle: "+angle);
        info = true;
      }
    }
    else{ 
      info = false;
    }
    
    rectMode(RADIUS);
    strokeWeight(1);  
    stroke(255, 255, 255);
    //noStroke();
    fill (red(col), green(col), blue(col), a);
    rect(x+offx, y+offy, w, h);
    strokeWeight(5);
    
    stroke(255, 255, 0);
    //point (x-w, y-h);
    stroke(255, 0, 255);
    //point (x+w, y+h);
    
  }
  
  private void randomize (){
    w = int(random(wRange[0], wRange[1]));
    h = int(random(hRange[0], hRange[1]));
    
    //angle = random(2*PI);
    angle = int(random(0,4))*(PI/2);
    
  }
  
  public boolean overlaps (Room t) { // Checks if self overlaps t room
    
    float l1x = x-w;
    float l1y = y-h;
    float r1x = x+w;
    float r1y = y+h;
    
    float l2x = t.x-t.w;
    float l2y = t.y-t.h;
    float r2x = t.x+t.w;
    float r2y = t.y+t.h;
    
    // One is on left side of other
    if (l1x > r2x || l2x > r1x)
      return false;
    
    
    // One is below other
    if (l1y > r2y || l2y > r1y)
      return false;
    
    return true;
  }
}  
