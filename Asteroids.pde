int posx = 0;
int posy = 0;

int windowWidth = 500;
int windowHeight = 500;

void setup() {
  
  size(500, 500);
}

void draw() {
  
  // draw background for now is only a white space
  background(255);
  
  
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      fill(0);
    }
  } else {
    fill(255);
  }
  
  // draw the player space ship
  translate(windowWidth/2, windowWidth/2);
  fill(0);
  circle(posx, posy, 10);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      posy--;
    } else if (keyCode == DOWN) {
      posy++;
    } else if (keyCode == RIGHT) {
      posx++;
    } else if (keyCode == LEFT) {
      posx--;
    }
  }
}
