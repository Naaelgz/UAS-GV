float x, y;
float rotation = 0;
float scaleFactor = 3.0;
float letterSpacing = 50; // Jarak antara huruf N dan Z

void setup() {
  size(700, 700);
  // menentukan penempatan huruf
  x = width / 2;
  y = height / 2;
}

void draw() {
  background(255);
  pushMatrix();
  translate(x, y);
  rotate(radians(rotation));
  scale(scaleFactor);
  fill(0);
  textSize(64);
  textAlign(CENTER, CENTER); // Center text alignment
  text("N", -letterSpacing / 2, 0); // Menggambar huruf N
  text("Z", letterSpacing / 2, 0);  // Menggambar huruf Z
  popMatrix();
}

void keyPressed() {
  // Move huruf menggunakan Arrow 
  if (keyCode == UP) {
    y -= 5; // Corrected to move up
  } else if (keyCode == DOWN) {
    y += 5;
  } else if (keyCode == LEFT) {
    x -= 5; // Corrected to move left
  } else if (keyCode == RIGHT) {
    x += 5;
  }
  
  // Rotate huruf menggunaan WASD 
  if (key == 'w' || key == 'W') {
    rotation -= 10;
  } else if (key == 'a' || key == 'A') {
    rotation -= 10; // Corrected to rotate counter-clockwise
  } else if (key == 's' || key == 'S') {
    rotation += 10;
  } else if (key == 'd' || key == 'D') {
    rotation += 10; // Corrected to rotate clockwise
  }

  // Zoom in dan out menggunakan + dan - 
  if (key == '+') {
    scaleFactor += 0.1;
  } else if (key == '-') {
    scaleFactor -= 0.1;
    // Ensure scale factor doesn't become negative or zero
    if (scaleFactor < 0.1) {
      scaleFactor = 0.1;
    }
  }
}
