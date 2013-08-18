/*
display()
addRow( int tempY)
moveRow()
rowClean()
allInactive()
setActiveRow... not used
areLinked(Person tempA, Person tempB)
hoverLink(Person tempA, Person tempB)
addIntoRow(Person tempA, Person tempB)
*/

class Structure {
  
  ArrayList myRows;
  ArrayList myLinks; // all links
  
  Structure() {
    myRows = new ArrayList();
    myLinks = new ArrayList();
  }
  
  void display() {
//    for (int i=0; i < myRows.size(); i++) {
//      Row thisRow = (Row) myRows.get(i);
//      thisRow.display();
//    }
    for (int i=0; i < myLinks.size(); i++) {
      Link thisLink = (Link) myLinks.get(i);
      thisLink.display();
    }
  }
  
  void addRow( int tempY) {
    // Adds a new row. Assigns membership to rows.
    // Removes members from rows they no longer belong to.
    int rowY = tempY;
    Row newRow = new Row(rowY);
    myRows.add(newRow);
//    println("Rows: " + myRows.size() );
    for (int i=0; i<shapeCount; i++) {
      Person thisPerson = (Person) myPeople.get(i);
      if (thisPerson.grabbed) {
        newRow.addMember( thisPerson );
        // Remove former membership:
        for (int j=0; j<myRows.size(); j++) {
          Row thisRow = (Row) myRows.get(j); // former row
          if (j != myRows.indexOf(newRow) ) { 
            thisRow.members.remove(thisPerson);
          }
        }
      }
    }
//    for (int i=0; i<newRow.members.size(); i++) {
//      println(newRow.members.get(i) );
//    }
  }
  
  void moveRow() {
    // for moving a row of an existing icon that is being dragged
    for (int i=0; i<shapeCount; i++) {
      Person thisPerson = (Person) myPeople.get(i);
      if (thisPerson.grabbed) {
        for (int j=0; j<myRows.size(); j++) {
          Row thisRow = (Row) myRows.get(j);
          if (thisRow.members.contains(thisPerson) ) {
            int limitedY = mouseY - thisPerson.offY - int(SIZE/2) ;
            if (limitedY < 1) {
              limitedY = int( (SIZE - GRID)/2);
            }
            else if (limitedY > height-SIZE) {limitedY = height-GRID;}
            
            thisRow.move( limitedY);
            thisPerson.vLocked = true;
          }
        }
      }
    }
  }
  
  void rowClean() {
    for (int i=0; i<myRows.size(); i++) {
      Row thisRow = (Row) myRows.get(i);
      // Remove all empty rows
      if (thisRow.members.isEmpty() ) {
        myRows.remove(thisRow);
      }
    }
    
    //////// Print after updating...
    println();
    for (int i=0; i<myRows.size(); i++) {
      Row thisRow = (Row) myRows.get(i);
      println("Row " + (i+1) + ", position: " + thisRow.yPos );
      for (int j=0; j<thisRow.members.size(); j++) {
        println(thisRow.members.get(j) );
      }
    }
  }
  
  void allInactive() {
    // resets all rows to be inactive
    // resets all links to not "forming"
    for (int i=0; i < myRows.size(); i++) {
      Row thisRow = (Row) myRows.get(i);
      thisRow.isActive = false;
    }
    for (int i=0; i < myLinks.size(); i++) {
      Link thisLink = (Link) myLinks.get(i);
      thisLink.forming = false;
    }
  }
  
  void setActiveRow() {
    // sets a row as active
  }
  
  boolean areLinked(Person tempA, Person tempB) {
    // Looks to see if two icons are already linked.
    Person A = tempA;
    Person B = tempB;
    for (int i=0; i<myLinks.size(); i++) {
      Link thisLink = (Link) myLinks.get(i);
      if (thisLink.linked.contains(A) && thisLink.linked.contains(B) ) {
        println("Already linked.");
        return true;
      }
    }
    return false;
  }
  
  void hoverLink(Person tempA, Person tempB) {
    Person A = tempA; // dragging
    Person B = tempB; // stationary
    counting = true;
    B.glow(); // Icon being dragged over.
    counter += 1;
    if ( counter > DWELL ) {
      if (!areLinked(A, B) ) {
      
        snapOverride = true; // Default snapping into row
        Link newLink = new Link();
        newLink.addPerson(B); // existing person
        newLink.addPerson(A); // new person
        
        A.linking = true;
        newLink.forming = true;
        myLinks.add(newLink);
        println("Link established! Total links: " + myLinks.size() );
      }
      counter = 0;
      counting = false;
    }
  }
  
  void addIntoRow(Person tempA, Person tempB) {
    // Adds A into the row of B.
    Person A = tempA; // dragging
    Person B = tempB; // stationary
    int toIndex = -1;
    int fromIndex = -1;
    for (int i=0; i<myRows.size(); i++) {
      Row thisRow = (Row) myRows.get(i);
      if (thisRow.members.contains(B) ) {
        toIndex = i;
        thisRow.addMember(A);
      } else if (thisRow.members.contains(A) ) {
        fromIndex = i;
        thisRow.removeMember(A);
      }
    }
    if ( (fromIndex >= 0) && (toIndex >= 0) ) {
      println("Transferring from "+fromIndex+" to "+toIndex);
      Row toRow = (Row) myRows.get(toIndex);
      Row fromRow = (Row) myRows.get(fromIndex);
//      for (int i=0; i<fromRow.members.size(); i++) {
      while (fromRow.members.size() > 0) {
        Person thisMember = (Person) fromRow.members.get(0);
        toRow.addMember( thisMember );
        fromRow.removeMember( thisMember );
      }
    }
  }
  
//  void removeFromRow(Person tempA, Row tempR) {
//    Person A = tempA;
//    Row R = tempR;
//    R.removeMember(A);
//  }
  
}
