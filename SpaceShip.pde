class SpaceShip {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float rotation;

  float maxVelocity = 5;  // Maximum velocity
  float accelerationIncrement = 0.1;  // Increment for acceleration
  float friction = 0.95;  // Friction coefficient to slow down the triangle
  float rotationSpeed = 0.05;  // Increment for rotation
  float vertexMovementIncrement = 1;  // Increment for moving the selected vertex

  HashMap<Integer, PVector> keyMapping = new HashMap<Integer, PVector>();  // HashMap to map key codes to acceleration vectors
  ArrayList<Integer> activeKeys = new ArrayList<Integer>();  // ArrayList to store active key codes

  SpaceShip() {
    position = new PVector(width / 2, height / 2);  // Initialize position at the center
    velocity = new PVector(0, 0);  // Initialize velocity
    acceleration = new PVector(0, 0);  // Initialize acceleration
    rotation = 0;  // Initialize rotation angle

    // Map arrow keys to acceleration vectors
    keyMapping.put(UP, new PVector(0, -accelerationIncrement));
    keyMapping.put(DOWN, new PVector(0, accelerationIncrement));
    keyMapping.put(LEFT, new PVector(-rotationSpeed, 0));  // Rotate counterclockwise
    keyMapping.put(RIGHT, new PVector(rotationSpeed, 0));  // Rotate clockwise

    print("Space ship created");
  }

  void draw() {
    // Apply friction to the velocity
    velocity.mult(friction);

    // Update the velocity and position
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);

    // Update rotation
    rotation += velocity.x;  // Rotate based on horizontal velocity

    // Reset acceleration each frame
    acceleration.mult(0);

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
    triangle(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y, vertices[2].x, vertices[2].y);  // Draw the triangle
    popMatrix();
  }

  void update_position(Integer keyCode) {
  }
}
