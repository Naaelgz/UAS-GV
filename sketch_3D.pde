PShape init;
float pitch = 0;
float yaw = 0;
float roll = 0;
boolean upPressed, downPressed, leftPressed, rightPressed, ltPressed, gtPressed;

void setup() {
  size(1230, 700, P3D);
  init = createShape(GROUP);
  
  // Letter N
  // Front face
  PShape nf = createShape();
  nf.beginShape();
  nf.vertex(320, 200, 0);
  nf.vertex(370, 200, 0);
  nf.vertex(470, 400, 0);
  nf.vertex(470, 200, 0);
  nf.vertex(520, 200, 0);
  nf.vertex(520, 500, 0);
  nf.vertex(470, 500, 0);
  nf.vertex(370, 300, 0);
  nf.vertex(370, 500, 0);
  nf.vertex(320, 500, 0);
  nf.endShape(CLOSE);
  init.addChild(nf);
  
  // Back face
  PShape nb = createShape();
  nb.beginShape();
  nb.vertex(320, 200, -50);
  nb.vertex(370, 200, -50);
  nb.vertex(470, 400, -50);
  nb.vertex(470, 200, -50);
  nb.vertex(520, 200, -50);
  nb.vertex(520, 500, -50);
  nb.vertex(470, 500, -50);
  nb.vertex(370, 300, -50);
  nb.vertex(370, 500, -50);
  nb.vertex(320, 500, -50);
  nb.endShape(CLOSE);
  init.addChild(nb);
  
  // Connect front and back faces
  connectFaces(nf, nb);
  
  // Letter Z
  // Front face
  PShape zf = createShape();
  zf.beginShape();
  zf.vertex(650, 200, 0);
  zf.vertex(850, 200, 0);
  zf.vertex(850, 260, 0);
  zf.vertex(720, 420, 0);
  zf.vertex(850, 420, 0);
  zf.vertex(850, 500, 0);
  zf.vertex(650, 500, 0);
  zf.vertex(650, 440, 0);
  zf.vertex(780, 280, 0);
  zf.vertex(650, 280, 0);
  zf.endShape(CLOSE);
  init.addChild(zf);
  
  // Back face
  PShape zb = createShape();
  zb.beginShape();
  zb.vertex(650, 200, -50);
  zb.vertex(850, 200, -50);
  zb.vertex(850, 260, -50);
  zb.vertex(720, 420, -50);
  zb.vertex(850, 420, -50);
  zb.vertex(850, 500, -50);
  zb.vertex(650, 500, -50);
  zb.vertex(650, 440, -50);
  zb.vertex(780, 280, -50);
  zb.vertex(650, 280, -50);
  zb.endShape(CLOSE);
  init.addChild(zb);
  
  // Connect front and back faces
  connectFaces(zf, zb);
  
  // Center Object
  centerObject(init);
}

void draw() {
  background(155);
  text("x: "+mouseX+" y: "+mouseY, 10, 15);
  translate(width / 2, height / 2, 0);
  
  if (upPressed) {
    pitch -= radians(1);
  }
  if (downPressed) {
    pitch += radians(1);
  }
  if (leftPressed) {
    yaw -= radians(1);
  }
  if (rightPressed) {
    yaw += radians(1);
  }
  if (ltPressed) {
    roll -= radians(1);
  }
  if (gtPressed) {
    roll += radians(1);
  }

  pitch = pitch % TWO_PI;
  yaw = yaw % TWO_PI;
  roll = roll % TWO_PI;
  
  pushMatrix();
  rotateX(pitch);
  rotateY(yaw);
  rotateZ(roll);
  shape(init);
  popMatrix();
}

void keyPressed() {
  if (key == 's') {
    upPressed = true;
  }
  if (key == 'w') {
    downPressed = true;
  }
  if (key == 'a') {
    leftPressed = true;
  }
  if (key == 'd') {
    rightPressed = true;
  }
  if (key == 'q') {
    ltPressed = true;
  }
  if (key == 'e') {
    gtPressed = true;
  }
}

void keyReleased() {
  if (key == 's') {
    upPressed = false;
  }
  if (key == 'w') {
    downPressed = false;
  }
  if (key == 'a') {
    leftPressed = false;
  }
  if (key == 'd') {
    rightPressed = false;
  }
  if (key == 'q') {
    ltPressed = false;
  }
  if (key == 'e') {
    gtPressed = false;
  }
}

void centerObject(PShape obj) {
  float minX = Float.MAX_VALUE;
  float minY = Float.MAX_VALUE;
  float minZ = Float.MAX_VALUE;
  float maxX = Float.MIN_VALUE;
  float maxY = Float.MIN_VALUE;
  float maxZ = Float.MIN_VALUE;
  
  for (int i = 0; i < obj.getChildCount(); i++) {
    PShape child = obj.getChild(i);
    for (int j = 0; j < child.getVertexCount(); j++) {
      PVector v = child.getVertex(j);
      if (v.x < minX) minX = v.x;
      if (v.y < minY) minY = v.y;
      if (v.z < minZ) minZ = v.z;
      if (v.x > maxX) maxX = v.x;
      if (v.y > maxY) maxY = v.y;
      if (v.z > maxZ) maxZ = v.z;
    }
  }
  
  PVector center = new PVector((maxX + minX) / 2, (maxY + minY) / 2, (maxZ + minZ) / 2);
  for (int i = 0; i < obj.getChildCount(); i++) {
    PShape child = obj.getChild(i);
    child.translate(-center.x, -center.y, -center.z);
  }
}

void connectFaces(PShape front, PShape back) {
  int vertexCount = front.getVertexCount();
  for (int i = 0; i < vertexCount; i++) {
    PShape side = createShape();
    side.beginShape();
    PVector v1 = front.getVertex(i);
    PVector v2 = front.getVertex((i + 1) % vertexCount);
    PVector v3 = back.getVertex((i + 1) % vertexCount);
    PVector v4 = back.getVertex(i);
    side.vertex(v1.x, v1.y, v1.z);
    side.vertex(v2.x, v2.y, v2.z);
    side.vertex(v3.x, v3.y, v3.z);
    side.vertex(v4.x, v4.y, v4.z);
    side.endShape(CLOSE);
    init.addChild(side);
  }
}
