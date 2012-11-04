// Need to declare all this as a global variable
// Or else I can't do things in the draw() loop
String myFile = "/Users/macklinu/Dropbox/Programming/Processing/DataVis/MusicTimeline/data/ListeningList.csv";
Table Data = new Table(myFile, "|");
int rowCount = Data.getRowCount();
MusicObject[] MO = new MusicObject[rowCount];

boolean play = true;

int a = 24;

void setup() {

  for (int i = 0; i < MO.length; i++) {
    MO[i] = new MusicObject();
  }

  for (int i = 1; i < rowCount; i++) {
    MO[i].setArtist(Data.getString(i, 0));
    MO[i].setTitle(Data.getString(i, 1));
    MO[i].setYear(Data.getString(i, 2));
    MO[i].setInfo(Data.getString(i, 3));
    MO[i].setAlbumArt(Data.getString(i, 4));
  }

  size(800, 800);
  smooth();

  background(0);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  MO[a].drawPopUp();
  if (keyPressed) {
    if (key == 'a') {
      noStroke();
      fill(240, 240, 240, 220);
      ellipse(width/2 - 100, height/2, 60, 60);
      fill(0, 0, 0, 180);
      triangle(width/2 - 108, height/2 -15, width/2 - 108, height/2 + 15, width/2 - 85, height/2);
      a = 20;
    }
    if (key == 's') {
      stroke(200);
      strokeWeight(1);
      fill(230, 230, 230, 220);
      ellipse(width/2 - 100, height/2, 60, 60);
      noStroke();
      fill(0, 0, 0, 180);
      rect(width/2 - 100, height/2, 25, 25);
      a = 10;
    }
    if (key == 'd') {
      noStroke();
      fill(240, 240, 240, 220);
      ellipse(width/2 - 100, height/2, 60, 60);
      fill(0, 0, 0, 180);
      rect(width/2 - 100, height/2, 25, 25, 0);
      a = 14;
    }
  }
}

