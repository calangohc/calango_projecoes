interface Ator {
  void atualizar();
  void draw();
}

class Coisa implements Ator {
  PVector p1,p2,p3;
  
  Coisa() {
    p1 = new PVector(30,30);
    p2 = new PVector(60,60);
    p3 = new PVector(30,90);
  }
  
  void atualizar() {
    p1 = new PVector((p1.x+2)%width,(p1.y+1)%height);
    p2 = new PVector((p2.x+2)%width,(p2.y+1)%height);
    p3 = new PVector((p3.x+2)%width,(p3.y+1)%height);
  }


  void draw() {
    stroke(0,255,0);
    strokeWeight(2);
    fill(255,0,255);

    PVector p1 = espaco.trans(this.p1);
    PVector p2 = espaco.trans(this.p2);
    PVector p3 = espaco.trans(this.p3); 
    ellipse(p1.x,p1.y,3,3);
    ellipse(p2.x,p2.y,3,3);
    ellipse(p3.x,p3.y,3,3);
    line(p1.x,p1.y, p2.x,p2.y);
    line(p2.x,p2.y, p3.x,p3.y);
    line(p3.x,p3.y, p1.x,p1.y);

  }
}


Ator a;
Projected espaco;

void setup() {
  // inicializar todo
  size(700,700,P2D);
  a = new Coisa();
  
  espaco = new AProjected();
  espaco.showBoundary();
  espaco.set_transform(0, 0, width, height,  new PVector(200,200), new PVector(400,200), new PVector(450,500), new PVector(190,580));

}

void draw() {
  // atualizar estado
  a.atualizar();
  
  // renderizar mundo 
  background(0);
  a.draw(); 
  espaco.draw();
}


