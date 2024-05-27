SpaceShip space_ship;
Space space;
PImage space_texture;
float[] angles = {0, HALF_PI, PI, PI + HALF_PI};
float cur_rotation = 0;
int frame_count = 0;

void setup() {
  size(800, 600, P2D);  // Set the size of the canvas
  space_ship = new SpaceShip();
  space = new Space(1000, 1000);
  
  
  println("finsihed star");
}

void draw() {
  background(0);  // Clear the background
  
  
  
  
  
  //shape(star, 400, 300);
  //space.draw(space_ship.position, space_ship.rotation);
  space_ship.draw();
  
}

void keyPressed() {
  space_ship.on_key_pressed();
}

void keyReleased() {
  space_ship.on_key_release();
}
