interface Projectable {
  void update();
  void draw(PGraphics pg);
}

interface ISpace {
   void reset();
   void render_projectable(Projectable p);
   PGraphics get_final_pg();
   void draw();
}

class Space implements ISpace {
  PVector tl,tr,br,bl;
  PGraphics pg;
  Space(PVector _tl, PVector _tr, PVector _br, PVector _bl) {
    tl = _tl;
    tr = _tr;
    br = _br;
    bl = _bl;    
  
  }
  
  PGraphics get_final_pg() { return pg; }
  
  void render_projectable(Projectable p) {
     p.draw(pg);
  }
  
  void reset() {
    pg = createGraphics(500,500);    
  }
  
  void draw() {
    int w = pg.width;
    int h = pg.height;
    beginShape();
     texture(pg);
     vertex(tl.x,tl.y, 0,0);
     vertex(tr.x,tr.y, w,0);
     vertex(br.x,br.y, w,h);
     vertex(bl.x,bl.y, 0,h);
    endShape();
  }
  
  
}
