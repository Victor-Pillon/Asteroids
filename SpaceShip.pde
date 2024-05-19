class SpaceShip {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float rotationAcceleration;
  float rotationVelocity;
  float rotation;

  float maxVelocity = 8;  // Maximum velocity
  float maxRotation = 0.05; // Maximum rotation
  float accelerationIncrement = 0.08;  // Increment for acceleration
  float friction = 0.95;  // Friction coefficient to slow down the ship
  float rotationIncrement = 0.001;

  HashMap<Integer, PVector> keyMapping = new HashMap<Integer, PVector>();  // HashMap to map key codes to acceleration vectors
  ArrayList<Integer> activeKeys = new ArrayList<Integer>();  // ArrayList to store active key codes

  SpaceShip() {
    position = new PVector(width / 2, height / 2);  // Initialize position at the center
    velocity = new PVector(0, 0);  // Initialize velocity
    acceleration = new PVector(0, 0);  // Initialize acceleration

    // Map arrow keys to acceleration vectors
    keyMapping.put(UP, new PVector(0, -accelerationIncrement));  // Accelerate forward
    keyMapping.put(DOWN, new PVector(0, accelerationIncrement));  // Accelerate backward
    keyMapping.put(LEFT, new PVector(-rotationIncrement, 0));  // Accelerate left
    keyMapping.put(RIGHT, new PVector(rotationIncrement, 0));  // Accelerate right

    print("Space ship created");
  }

  void draw() {
    background(0);  // Clear the background

    // Apply friction to the velocity and rotation
    velocity.mult(friction);
    rotationVelocity *= friction;
    
    // Update the angle
    rotationVelocity += rotationAcceleration;
    
    if(rotationVelocity > maxRotation)
      rotationVelocity = maxRotation;
    else if(rotationVelocity < -maxRotation)
      rotationVelocity = -maxRotation;
      
    rotation += rotationVelocity;
    rotation %= TWO_PI;
    
    // Update the velocity and position
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);

    // Wrap around the edges
    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;

    // Translate to the triangle's position
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);

    // Draw the triangle
    fill(150, 0, 255);  // Set the fill color
    noStroke();  // No outline
    triangle(-50, 50, 50, 50, 0, -50);  // Draw the main spaceship frame
    fill(0);
    triangle(-25, 25, 25, 25, 0, -50);
    popMatrix();
    
    
    println("rotation: "+ rotation);
    println("rotation velocity: "+ rotationVelocity);
    println("rotation acceleration: "+ rotationAcceleration);
    println("velocity" + velocity);
  }

  void update_position() {
    
    for (Integer key : activeKeys) {
      if (key == LEFT || key == RIGHT)
      {
        PVector keyAcceleration = keyMapping.get(key);
        rotationAcceleration += keyAcceleration.x;
      } else {
        PVector keyAcceleration = keyMapping.get(key);
        // Rotate the key acceleration vector based on the current rotation angle
        PVector rotatedAcceleration = new PVector(
          keyAcceleration.x * cos(rotation) - keyAcceleration.y * sin(rotation),
          keyAcceleration.x * sin(rotation) + keyAcceleration.y * cos(rotation)
          );
        acceleration.add(rotatedAcceleration);
      }
    }
  }

  void on_key_pressed() {
    if (keyMapping.containsKey(keyCode)) {
      if (!activeKeys.contains(keyCode)) {
        activeKeys.add(keyCode);
      }
    }
    update_position();
  }

  void on_key_release() {
    acceleration.mult(0);
    rotationAcceleration = 0;
    if (activeKeys.contains(keyCode)) {
      activeKeys.remove(activeKeys.indexOf(keyCode));
    }
    update_position();
  }
}
