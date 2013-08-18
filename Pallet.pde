class Pallet {
  // Drag and drop shapes from this.
  
  int x,y; // x,y position of upper left corner
  int h = 160; // height
  int w = 40; // width
  int bar = 15; // height of menu bar
  final int NUM_BUTTONS = 3; // hardcoded  for F,M,N
  float buttonH = (h - bar) / float(NUM_BUTTONS); // Height of button
  boolean grabbed = false;
  int offX = 0;
  int offY = 0;
  
  
  Pallet(int tempX, int tempY) {
    x = tempX;
    y = tempY;
    
  }
  
  void display() {
    pushMatrix();
    translate(x,y);
    
    noStroke();
    fill(100,30);
    rect(0,0, w,h); // background
    
    fill(100,70);
    rect(0,0, w,bar); // menu bar
    
    noFill();
    stroke(20,200,20);
    strokeWeight(2);
    translate( (w-SIZE)/2.0, bar-1 + (buttonH-SIZE)/2.0);    
    ellipseMode(CORNERS);
    ellipse(0,0, SIZE, SIZE);
    translate(0,buttonH);
    rect(0,0, SIZE, SIZE);
    translate(0,buttonH);
    triangle(0,SIZE, SIZE,SIZE, SIZE/2,0);
    
    popMatrix();
  }
  
  void move() {
    x = mouseX - offX;
    y = mouseY - offY;
    if ( x < 0 ) {
      x = 0;
    } else if ( x > width-w ) {
      x = width - w;
    }
    if ( y < 0 ) {
      y = 0;
    } else if ( y > height-bar ) {
      y = height - bar;
    }
  }
  
  void highlight() {
//    int relY() = mouseY - y - bar; // Y position of mouse, relative to menu bar
    if ((relY() > 0) && (relY() < h-bar) ){
      // mouse NOT over menu bar
      pushMatrix();
      onButton = floor(relY() / buttonH);
      translate(x,y+bar + (buttonH * onButton ) );
      fill(255,120);
      noStroke();
      rect(0,0, w,buttonH);
      
      popMatrix();
    }
  }
  
  boolean onPallet() {
    // True if mouse over pallet
    if ( (mouseX > myPallet.x - 1) && (mouseX < myPallet.x + myPallet.w + 1) &&
       (mouseY > myPallet.y - 1) && (mouseY < myPallet.y + myPallet.h + 1) ) {
         return true;
       } else {
         return false;
       }
  }
  
  boolean onBar() {
    // True if mouse over menu bar
    if ( (mouseX > myPallet.x - 1) && (mouseX < myPallet.x + myPallet.w + 1) &&
       (mouseY > myPallet.y - 1) && (mouseY < myPallet.y + myPallet.bar + 1) ) {
         return true;
       } else {
         return false;
       }
  }

  
  int relY() {
    // Relative y position of the mouse.
    return mouseY - y - bar;
  }
  
}
