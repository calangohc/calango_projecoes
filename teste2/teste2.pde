
class TestAtor implements Projectable {
  PVector p1,p2,p3;
  TestAtor() {
    p1 = new PVector(100,100);
    p2 = new PVector(150,150);
    p3 = new PVector(100,200);
  }
  
  void update() {    
    p1 = new PVector(p1.x + 5, p1.y);
    p2 = new PVector(p2.x + 5, p2.y);
    p3 = new PVector(p3.x + 5, p3.y);
    if (p2.x > width) {
      p1 = new PVector(0, p1.y);
      p2 = new PVector(50, p2.y);
      p3 = new PVector(0, p3.y);    
    } 
  }
  
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.stroke(255);
    pg.strokeWeight(4);
    
    int x,y;
    for (x=0;x<500;x=x+20) { 
      pg.line(x,0, x,500);     
    }
    for (y=0;y<500;y=y+20) {
      pg.line(0,y, width,y);
    }
        
    pg.line(p1.x,p1.y, p2.x,p2.y);
    pg.line(p2.x,p2.y, p3.x,p3.y);
    pg.line(p3.x,p3.y, p1.x,p1.y); 
    pg.endDraw();
  }
  
}

Projectable a;
ISpace espaco;

void setup() {
  size(500,500,P3D);
  frameRate(20);
  espaco = new Space(new PVector(100,100), new PVector(300,120), new PVector(304,300), new PVector(120,404));
  a = new TestAtor();  
}

void draw() {
  a.update();
  
  background(0);
  espaco.reset();
  espaco.render_projectable(a);
  espaco.draw();
}
