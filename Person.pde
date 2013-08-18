/*
display()
move()
onIcon()
dragOverIcon()
glow()
inRow()... not used
*/


class Person {
  
  char gender; // F, M, N maps to Circle, Square, Triangle
  int x, y; // upper left corner of icon square
  color c = color(20);
  boolean grabbed = false;
  int offX = 0;
  int offY = 0;
//  final int DWELL = 60;
  boolean vLocked = false; // Aligned onto a row.
  boolean linking = false; // grabbed and forming a new link
  int lockY = 0; // Y position for alignment into a row.
  
  Person(int tempX, int tempY, char tempG) {
    gender = tempG;
    x = tempX;
    y = tempY;
  }
  
  void display() {
    if (vLocked) {
      y = lockY;
    }
    noFill();
    strokeWeight(2);
    stroke(c);
    
    pushMatrix();
    translate(x,y);
    
    if (gender == 'F') {
      ellipseMode(CORNERS);
      ellipse(0,0, SIZE, SIZE);
      
    } else if (gender == 'M') {
      rect(0,0, SIZE, SIZE);
      
    } else if (gender == 'N') {
      triangle(0,SIZE, SIZE,SIZE, SIZE/2,0);
      
    } else {
      println("Gender Error!");
    }
    
    popMatrix();
  }
  
  void move() {     
    x = mouseX - offX;
    if (!vLocked) {
      y = mouseY - offY;
    } else {
      y = lockY;
    }
    if ( x < 0 ) {
      x = 0;
    } else if ( x > width-SIZE ) {
      x = width - SIZE;
    }
    if ( y < 0 ) {
      y = 0;
    } else if ( y > height-GRID ) {
      y = height - GRID;
    }
  }
  
  boolean onIcon() {
    if ( (mouseX > x - 1) && (mouseX < x + SIZE + 1) &&
         (mouseY > y - 1) && (mouseY < y + SIZE + 1) ) {
           return true;
         } else {
           return false;
         }
  }
  
  boolean dragOverIcon() {
    // true if dragging one icon over another,
    // for alignment and building links.
    if (grabbed) { // Person object is being dragged
//      this.vLocked = false;
      for (int i=0; i<shapeCount; i++) {
        Person thisPerson = (Person) myPeople.get(i);
        if ( (this != thisPerson) && (thisPerson.onIcon() )) {
          myStructure.hoverLink(this, thisPerson);
          return true;
        } else {
          counting = false;
        }
      }
      counter = 0;
    }
    return false;
  }
  
  void glow() {
    noStroke();
    fill(255, 243, 5, 40);
    ellipseMode(CENTER);
    ellipse( x+(SIZE/2.0), y+(SIZE/2.0), 100,100);
  }
  
//  boolean inRow() {
//    // True if a member of a Row.
//    for (int i=0; i<myRows.size(); i++) {
//      Row thisRow = (Row) myRows.get(i);
//      if (thisRow.members.contains(this) ) {
//        vLocked = true;
//        lockY = thisRow.yPos;
//        return true;
//      }
//    }
//    return false;
//  }

  
}
