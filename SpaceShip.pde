class SpaceShip {

  // internal variables
  PVector position;
  PVector velocity;
  PVector acceleration;
  float rotationAcceleration;
  float rotationVelocity;
  float rotation;
  HashMap<Integer, PVector> keyMapping = new HashMap<Integer, PVector>();  // HashMap to map key codes to acceleration vectors
  ArrayList<Integer> activeKeys = new ArrayList<Integer>();  // ArrayList to store active key codes
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  // constants and max values
  float maxVelocity = 8;  // Maximum velocity
  float maxRotation = 0.05; // Maximum rotation
  float accelerationIncrement = 0.08;  // Increment for acceleration
  float friction = 0.95;  // Friction coefficient to slow down the ship
  float rotationIncrement = 0.001;

  // spawn point and texture
  PVector bulletSpawn = new PVector(0, -25);
  PShape space_ship;

  SpaceShip() {
    position = new PVector(width / 2, height / 2);  // Initialize position at the center
    velocity = new PVector(0, 0);  // Initialize velocity
    acceleration = new PVector(0, 0);  // Initialize acceleration

    // Map arrow keys to acceleration vectors
    keyMapping.put(UP, new PVector(0, accelerationIncrement));  // Accelerate forward
    keyMapping.put(DOWN, new PVector(0, -accelerationIncrement));  // Accelerate backward
    keyMapping.put(LEFT, new PVector(-rotationIncrement, 0));  // Accelerate left
    keyMapping.put(RIGHT, new PVector(rotationIncrement, 0));  // Accelerate right


    PImage space_ship_base_texture = loadImage("Assets/SpaceShip/Ship/Bases/FullHealth.png");
    PShape space_ship_base = createShape();
    space_ship_base = createShape();
    space_ship_base.beginShape();
    space_ship_base.texture(space_ship_base_texture);
    space_ship_base.noStroke();
    space_ship_base.vertex(-24, -24, 0, 0);
    space_ship_base.vertex(24, -24, space_ship_base_texture.width, 0);
    space_ship_base.vertex(24, 24, space_ship_base_texture.width, space_ship_base_texture.height);
    space_ship_base.vertex(-24, 24, 0, space_ship_base_texture.height);
    space_ship_base.endShape();
    
    PImage space_ship_engine_texture = loadImage("Assets/SpaceShip/Ship/Engines/BaseEngine.png");
    PShape space_ship_engine = createShape();
    space_ship_engine = createShape();
    space_ship_engine.beginShape();
    space_ship_engine.texture(space_ship_engine_texture);
    space_ship_engine.noStroke();
    space_ship_engine.vertex(-24, -24, 0, 0);
    space_ship_engine.vertex(24, -24, space_ship_engine_texture.width, 0);
    space_ship_engine.vertex(24, 24, space_ship_engine_texture.width, space_ship_engine_texture.height);
    space_ship_engine.vertex(-24, 24, 0, space_ship_engine_texture.height);
    space_ship_engine.endShape();
    
    space_ship = createShape(GROUP);
    space_ship.addChild(space_ship_base);
    space_ship.addChild(space_ship_engine);
    
    print("Space ship created");
  }

  void draw() {

    // Apply friction to the velocity and rotation
    velocity.mult(friction);
    rotationVelocity *= friction;

    // Update the angle
    rotationVelocity += rotationAcceleration;
    rotationVelocity = constrain(rotationVelocity, -maxRotation, maxRotation);
    rotation += rotationVelocity;
    rotation %= TWO_PI;

    // Update the velocity and position
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);

    // Wrap around the edges
    //if (position.x > width) position.x = 0;
    //if (position.x < 0) position.x = width;
    //if (position.y > height) position.y = 0;
    //if (position.y < 0) position.y = height;

    // Translate to the triangle's position
    pushMatrix();
    translate(width/2, height/2);
    rotate(rotation);
    shape(space_ship, 0,0);
    
    popMatrix();

    println("=-=-=-=-=-=-=-=-=-");
    println("rotation: "+ rotation);
    //println("rotation velocity: "+ rotationVelocity);
    //println("rotation acceleration: "+ rotationAcceleration);
    //println("velocity: " + velocity);
    //println("velocity acceleration: " + acceleration);
    println("position: " + position);

    // Calculate the tip position
    fill(255);
    circle(position.x, position.y, 5);

    update_position();
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
    if (keyCode == 32) {
      PVector bulletStart = bulletSpawn.copy();
      bulletStart.rotate(rotation);
      bulletStart.add(position);
      bullets.add(new Bullet(bulletStart, rotation));
    }
  }

  void on_key_release() {
    acceleration.mult(0);
    rotationAcceleration = 0;
    if (activeKeys.contains(keyCode)) {
      activeKeys.remove(activeKeys.indexOf(keyCode));
    }
  }
}
