class Space {
  ArrayList<PVector> stars_position = new ArrayList<PVector>();
  int frame_count;
  int max_stars_quantity;
  int size;
  
  PShape star_shape;

  Space(int size, int max_stars_quantity) {
    this.max_stars_quantity = max_stars_quantity;
    
    
    PImage star_texture = loadImage("star.png");
    star_shape = createShape();
    star_shape.beginShape();
    star_shape.texture(star_texture);
    star_shape.noStroke();
    star_shape.vertex(-8, -8, 0, 0);
    star_shape.vertex(8, -8, star_texture.width, 0);
    star_shape.vertex(8, 8, star_texture.width, star_texture.height);
    star_shape.vertex(-8, 8, 0, star_texture.height);
    star_shape.endShape();
    
    generateStars();
  }

  void draw(PVector center_position, float rotation) {
    pushMatrix();
    translate(center_position.x, center_position.y);
    
    fill(255);
    for (PVector star_position : stars_position)
    {
      translate(star_position.x, star_position.y);
      rotate(random(TWO_PI));
      shapeMode(CENTER);
      shape(star_shape, 0, 0);
    }
    popMatrix();
  }

  void generateStars() {
    stars_position.clear();
    for (int i=0; i<max_stars_quantity; i++)
    {
      PVector pos = new PVector(int(random(width)), int(random(height)));
      //if (!stars_position.contains(pos))
        stars_position.add(pos);
    }
  }
}
