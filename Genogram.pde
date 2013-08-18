/*
Lets you draw a genogram.

*/

final int GRID = 40; // controls vertical snap location, via Row class
final int SIZE = 18; // icon fits in square this size
final int H_SPACING = 40; // controls horizontal spacing within a row

int shapeCount = 0;
ArrayList myPeople; // all people
Structure myStructure;
Pallet myPallet;

boolean dragging = false;
boolean adding = false;
int onButton = 0;
boolean counting = false;
int counter = 0;
boolean snapOverride = false; // Used to override adding a new row.
final int DWELL = 30;

char[] gMatrix = new char[3];


void setup() {
  size(900,600);
  background(200);
  smooth();
  
  myStructure = new Structure();
  
  gMatrix[0] = 'F';
  gMatrix[1] = 'M';
  gMatrix[2] = 'N';
  
  myPeople = new ArrayList();
  
  myPallet = new Pallet(width - 100, 40);  
}


void draw() {
  background(200);
  myStructure.display();
  if( myPallet.onPallet() && !dragging ) {
    myPallet.highlight();
  }
  for (int i=0; i<shapeCount; i++) {
    Person thisPerson = (Person) myPeople.get(i);
    if (thisPerson.dragOverIcon() ) {
      counting = true;
    }
    thisPerson.display();
  }
  myPallet.display();
}
  
void mousePressed() {
  if (mouseButton == LEFT) {
    if (myPallet.onPallet() ) {
      if (myPallet.onBar() ) {
        myPallet.grabbed = true;
        myPallet.offX = mouseX - myPallet.x;
        myPallet.offY = mouseY - myPallet.y;
      } else { // Adding a new Person
        myPallet.grabbed = false;
        // Drag and drop an icon
        adding = true;
        dragging = true;
        addPerson();
        int last = myPeople.size() - 1;
        Person thisPerson = (Person) myPeople.get(last);
        thisPerson.grabbed = true;
        thisPerson.offX = mouseX - thisPerson.x;
        thisPerson.offY = mouseY - thisPerson.y;
      }
    } else { // mouse NOT clicked over menu pallet
      for (int i=0; i<shapeCount; i++) {
        Person thisPerson = (Person) myPeople.get(i);
        if ( thisPerson.onIcon() ) {
          dragging = true;
          thisPerson.grabbed = true;
          thisPerson.offX = mouseX - thisPerson.x;
          thisPerson.offY = mouseY - thisPerson.y;
        } else {
          thisPerson.grabbed = false;        
        }
      }
    }
  }
}


void mouseDragged() {
//  dragging = true;
  for (int i=0; i<shapeCount; i++) {
    Person thisPerson = (Person) myPeople.get(i);
    if (thisPerson.grabbed) {
      thisPerson.vLocked = false;
      thisPerson.move(); //offX, offY);
      if (thisPerson.linking) {
        // re-evaluate link
        for (int j=0; j<myStructure.myLinks.size(); j++) {
          Link thisLink = (Link) myStructure.myLinks.get(j);
          if (thisLink.forming) {
//            println("Forming link... " + thisLink);
            thisLink.update();
          }
        }
      }
    }
  }
  if (myPallet.grabbed) {
    myPallet.move(); //offX, offY);
  }
}


void mouseReleased() {
  if ( ( adding ) && (!snapOverride) ){ 
    int limitedY = mouseY - int(SIZE/2) ;
    if (limitedY < 1) {limitedY = 0;}
    else if (limitedY > height-SIZE) {limitedY = height-GRID;}
    myStructure.addRow( limitedY );    
  }
  if ( dragging && !adding && !snapOverride ) {
    /// update row position
    
    myStructure.moveRow();
  }
  
  if (snapOverride) {
//    println("check check");
    for (int i=0; i<myStructure.myLinks.size(); i++) {
      Link thisLink = (Link) myStructure.myLinks.get(i);
      if (thisLink.forming && (thisLink.type == 'M')) {
        Person A = (Person) thisLink.linked.get(1); // dragging
        Person B = (Person) thisLink.linked.get(0); // stationary
        myStructure.addIntoRow( A, B );
      }
    }
    
    for (int i=0; i<shapeCount; i++) {
      Person thisPerson = (Person) myPeople.get(i);
      
      if (thisPerson.grabbed) {
        thisPerson.vLocked = true;
      }
      
    }
  }
  
  // Reset all dragging, adding, grabbed flags.
  dragging = false;
  adding = false;
  for (int i=0; i<shapeCount; i++) {
    Person thisPerson = (Person) myPeople.get(i);
    thisPerson.linking = false;
    thisPerson.grabbed = false;
  }
  
  myStructure.allInactive();
  myPallet.grabbed = false;
  snapOverride = false;
  myStructure.rowClean();
}


void addPerson() {
  shapeCount += 1;
//  palButton = Pallet.onButton;
  print("Button: " + onButton);
  char g = gMatrix[ onButton ];
  print(", new " + g);
  Person newPerson = new Person(mouseX - SIZE/2, mouseY - SIZE/2, g);
  myPeople.add(newPerson);
  println(". Total people charted: " + myPeople.size() + "." );
}


void delPerson() {
  // It'll happen. :(
}
