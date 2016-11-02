interface Projected {
  void set_transform(float o_x1, float o_y1, float o_x2, float o_y2, PVector tl, PVector tr, PVector br, PVector bl);
  float trans(float n, float lo1, float hi1, float lo2, float hi2);
  PVector trans(PVector in);
  void showBoundary();
  void noBoundary();
  void draw();
}

class AProjected implements Projected {
  /* Subclasses of projected know how to project themselves into a space */

  class LineHelper {
    /* Handy line geometry functions */
    float gradient(PVector start, PVector end) {
      if (end.x == start.x) { return 99999999; } // catch potential division by zero
      return (end.y - start.y) / (end.x - start.x);
    }
  
    float offset(PVector start, float grad) {
      return start.y - (grad * start.x);
    }
  
  
    PVector intersect(PVector line1_start, PVector line1_end, PVector line2_start, PVector line2_end) {
      float m1, a1, m2, a2;
      m1 = gradient(line1_start, line1_end);
      a1 = offset(line1_start, m1);
      m2 = gradient(line2_start, line2_end);
      a2 = offset(line2_start, m2);
      float x = (a2-a1)/(m1-m2);
      float y = m1*x + a1;
      return new PVector(x,y);
    }
  }

  float o_x1, o_y1, o_x2, o_y2;
  PVector top_left, top_right, bottom_right, bottom_left;
  boolean transforming, draw_boundaries;
  LineHelper line_helper;

  AProjected() {
    transforming = false;
    draw_boundaries = false;
    line_helper = new LineHelper();
  }

  void set_transform(float o_x1, float o_y1, float o_x2, float o_y2, PVector tl, PVector tr, PVector br, PVector bl) {
    this.o_x1 = o_x1;
    this.o_y1 = o_y1;
    this.o_x2 = o_x2;
    this.o_y2 = o_y2;

    top_left = tl;
    top_right = tr;
    bottom_right = br;
    bottom_left = bl;
    transforming = true;
  }

  float trans(float n, float lo1, float hi1, float lo2, float hi2) {
    return ((n/(hi1-lo1)) * (hi2-lo2))+lo2;
  }


  PVector trans(PVector in) {
    if (!transforming) { 
      return in;
    } // don't transform if a transform space hasn't been set up

    // x and y as proportion of overall width and height
    float x_r, y_r;
    x_r = (in.x-o_x1) / (o_x2-o_x1);
    y_r = (in.y-o_y1) / (o_y2-o_y1);

    // find unit vectors for each side
    PVector top = PVector.sub(top_right,top_left);
    PVector right = PVector.sub(bottom_right,top_right);
    PVector bottom = PVector.sub(bottom_right, bottom_left);
    PVector left = PVector.sub(bottom_left, top_left);

    float top_length = top.mag();
    top.normalize();
    top.mult(top_length*x_r);

    float right_length = right.mag();
    right.normalize();
    right.mult(right_length * y_r);

    float bottom_length = bottom.mag();
    bottom.normalize();
    bottom.mult(bottom_length * x_r);

    float left_length = left.mag();
    left.normalize();
    left.mult(left_length * y_r);


    // now find actual mid-points
    PVector mid_top = new PVector(top_left.x, top_left.y);
    mid_top.add(top);

    PVector mid_right = new PVector(top_right.x, top_right.y);
    mid_right.add(right);

    PVector mid_bottom = new PVector(bottom_left.x, bottom_left.y);
    mid_bottom.add(bottom);

    PVector mid_left = new PVector(top_left.x, top_left.y);
    mid_left.add(left);

    // now we have the x_r and y_r  proportioned points on all the sides. Need to find where the two transversals cross
    if (draw_boundaries) { 
      strokeWeight(1);
      stroke(255);
      //line(mid_left.x,mid_left.y, mid_right.x,mid_right.y);
      //line(mid_top.x,mid_top.y, mid_bottom.x, mid_bottom.y);
    }
    return line_helper.intersect(mid_left,mid_right,mid_top,mid_bottom);
  }

  void showBoundary() { draw_boundaries = true; }
  void noBoundary() { draw_boundaries = false; }
  
  void draw() {
    if (draw_boundaries) { 
      pushMatrix();
        strokeWeight(2);
        stroke(150,255,200);
        line(top_left.x,top_left.y,top_right.x,top_right.y);
        line(top_right.x,top_right.y,bottom_right.x,bottom_right.y);
        line(bottom_right.x,bottom_right.y,bottom_left.x,bottom_left.y);
        line(bottom_left.x,bottom_left.y,top_left.x,top_left.y);
      popMatrix();
    }
  }
}

