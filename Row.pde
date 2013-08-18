/* Protects vertical spacing of items.
If an item is placed into a row, that item snaps vertically.
display()
move(int tempPos)
addMember(Person tempA)
removeMember(Person tempA)
*/

class Row {

  int yPos; // Y position of top of row
//  int ID; // unique identifier for each row
  int ySnap = int ((GRID - SIZE) / 2.0); // relative to yPos
  boolean isActive = false; // set to true if placing onto an existing row
  ArrayList members;
  
  Row(int tempPos) {
    yPos = tempPos;
    members = new ArrayList();
  }
  
  void display() {
    noFill();
    if (isActive() ) {
      stroke(200,20,20);
    } else {
      stroke(150);
    }
    strokeWeight(2);
    
    pushMatrix();
    
    translate(0,yPos);
    line(0,0, width,0);
    line(0,GRID, width,GRID);
    
    strokeWeight(1);
    line(0,ySnap, width,ySnap);
    
    popMatrix();
  }
  
  void move(int tempPos) {
    // Moves an existing Row.
    yPos = tempPos;
    // update y position of all members
    for (int i=0; i<members.size(); i++) {
      Person thisPerson = (Person) members.get(i);
      thisPerson.lockY = yPos + ySnap;
    }
  }
  
  void addMember(Person tempA) {
    Person A = tempA;
    if (!members.contains(A) ) {  // avoids duplication
      members.add(A);
      // Lock into row
      A.vLocked = true;
      A.lockY = yPos + ySnap;
    } 
  }
  
  void removeMember(Person tempA) {
    Person A = tempA;
    members.remove(A);
  }
  
}
