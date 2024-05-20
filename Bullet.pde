class Bullet {
  PVector velocity = new PVector(5, 5);
  PVector position;

  Bullet(PVector spawnPoint, float direction) {
    this.position = spawnPoint.copy();
    float speed = 5;  // Speed of the bullet
    velocity = new PVector(cos(direction - HALF_PI), sin(direction - HALF_PI));
    velocity.mult(speed);
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rect(-5, -5, 10, 10);
    popMatrix();
    position.add(velocity);
  }
}
