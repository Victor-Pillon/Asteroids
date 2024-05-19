SpaceShip space_ship;

void setup() {
  size(800, 600);  // Set the size of the canvas
  
  space_ship = new SpaceShip();
}

void draw() {
  background(255);  // Clear the background

  
}

void keyPressed() {
  if (keyMapping.containsKey(keyCode)) {
    if (!activeKeys.contains(keyCode)) {
      activeKeys.add(keyCode);
    }
  }
  updateAcceleration();
}

void keyReleased() {
  if (activeKeys.contains(keyCode)) {
    activeKeys.remove(activeKeys.indexOf(keyCode));
  }
  updateAcceleration();
}

void updateAcceleration() {
  acceleration.mult(0);
  for (Integer key : activeKeys) {
    acceleration.add(keyMapping.get(key));
  }
}
