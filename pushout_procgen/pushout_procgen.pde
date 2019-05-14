ArrayList<Room> rooms = new ArrayList<Room>();
int roomCount = 1000;
int offx = 0;
int offy = 0;

void setup() {  
  size(1000, 1000);
  Room inRoom = nRoom(); // Inital room REMOVING THIS WILL BREAK THE PROGRAM
  inRoom.col = color(255, 255, 0);
  inRoom.ID = "MOMMY";

  for (int i = 0; i < roomCount; i++)
    build().ID = str(i);
}

int pmx;
int pmy;
void draw () {
  
  background(0);
  
  grid (20, 20, offx, offy);
  for (Room r : rooms) {
    r.display();
  }
  
  boolean hover = false;
  for (Room r : rooms){
     if ((mouseX-offx < r.x+r.w && mouseX-offx > r.x-r.w) && (mouseY-offy < r.y+r.h && mouseY-offy > r.y-r.h)){
       hover = true;
     }
  }
  
  if (hover)
    cursor(HAND);
  else
    cursor(ARROW);

  if (mouseButton == LEFT){
    cursor(MOVE);
    offx += mouseX-pmx;
    offy += mouseY-pmy;
  }

  float timec = 2;
  //if (frameCount % timec == 0 ){
   
  //}
  //build();
  
  pmx = mouseX;
  pmy = mouseY;
}


Room build () {
  Room curRoom = nRoom ();
  curRoom.col = color(0, 255, 0);
  boolean overlapping = true;

  while (overlapping) {
    curRoom.x += cos(curRoom.angle);
    curRoom.y += sin(curRoom.angle);

    overlapping = false;
    for (Room r : rooms) {
      if (curRoom.overlaps(r) && r != curRoom) {
        overlapping = true;
      }
    }
  }

  if (curRoom.angle+(PI/2) > PI)
    curRoom.x = ceil(curRoom.x);
  else
    curRoom.x = floor(curRoom.x);

  if (curRoom.angle > PI)
    curRoom.y = ceil(curRoom.y);
  else
    curRoom.y = floor(curRoom.y);
  return curRoom;
}

// Draw a grid
void grid (int stepx, int stepy, int offx, int offy) {
  strokeWeight (1);
  stroke(64, 64, 64);

  for (int i = 0; i*stepx < width; i++) {
    line (stepx * i + offx, 0, stepx * i + offx, height);
  }

  for (int j = 0; j * stepy < height; j++) {
    line (0, stepy * j + offy, width, stepy * j + offy);
  }
}

Room nRoom () {
  Room newRoom = new Room (width / 2, height / 2, 10.0, 50.0, 10.0, 50.0);
  rooms.add(newRoom);
  return newRoom;
}