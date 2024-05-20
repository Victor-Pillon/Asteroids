SpaceShip space_ship;

void setup() {
  size(800, 600);  // Set the size of the canvas
  
  space_ship = new SpaceShip();
}

void draw() {
  background(255);  // Clear the background
  space_ship.draw();
}

void keyPressed() {
  space_ship.on_key_pressed();
}

void keyReleased() {
  space_ship.on_key_release();
}
