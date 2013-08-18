class Link {
  ArrayList linked; // the people connected by this link
  // M -> Marriage/partner, C -> Child, P -> Parent, S -> Sibling
  char type;
  final int LEADER = 20;
  boolean forming = false; // type can be changed while dragging
  
  Link() {
    linked = new ArrayList();
  }
  
  void addPerson(Person tempAdd) {
    Person toAdd = tempAdd;
    linked.add( toAdd );
  }
  
  void display() {
    // Based on type of link...
    Person startP = (Person) linked.get(0);
    // Need to distinguish for parent/child.
    Person endP = (Person) linked.get(1);
    float startX = startP.x + SIZE/2.0;
    float endX = endP.x + SIZE/2.0;
    stroke(100,100,200);
    strokeWeight(3);
    
    if (type == 'M') { // Marriage/partner
      float startY = startP.y + SIZE;
      float endY = endP.y + SIZE;
      line(startX,startY, startX, startY+LEADER);
      line(startX, startY+LEADER, endX, endY+LEADER);
      line(endX,endY, endX, endY+LEADER);
    } else if (type == 'C') { // Child
      float startY = startP.y + SIZE;
      float endY = endP.y;// + SIZE;
      line(startX,startY, startX, startY+LEADER);
      line(startX, startY+LEADER, endX, startY+LEADER);
      line(endX,endY, endX, startY+LEADER);
    } else if (type == 'P') { // Parent
      float startY = startP.y;// + SIZE;
      float endY = endP.y + SIZE;
      line(startX,startY, startX, endY+LEADER);
      line(startX, endY+LEADER, endX, endY+LEADER);
      line(endX,endY, endX, endY+LEADER);
    } // ...Sibling

  }
  
  void update() {
    // Change type of link during formation.
    if (!forming) {
      println("Error... cannot update link that isn't being formed.");
    } else {
      Person A = (Person) linked.get(0); // stationary
      Person B = (Person) linked.get(1); // dragging
      int p1 = int(B.y - SIZE/2); 
      int p2; // Most recent local min/max
      int p3 = int(A.y - SIZE/2); // Current position. Might just use 
      int rowMax = int(p1 + GRID/2);
      int rowMin = int(p1 - GRID/2);
      
      if (p3 < rowMin) {
        type = 'C';
        snapOverride = false;
//        B.vLocked = false;
//        println("Child! " + frameCount);
      } else if (p3 > rowMax) {
        type = 'P';
        snapOverride = false;
//        B.vLocked = false;
//        println("Parent! " + frameCount);
      } else {
        type = 'M';
        snapOverride = true;
//        B.vLocked = true;
//        println("Marriage! " + frameCount);
      }
    }
  }
  
  
  
}
