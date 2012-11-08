import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;



// Need to declare all this as a global variable
// Or else I can't do things in the draw() loop
String myFile = sketchPath("/Users/macklinu/git/MusicTimeline/data/exam1/list.csv");
Table Data = new Table(myFile, "|");
int rowCount = Data.getRowCount();
MusicObject[] MO = new MusicObject[rowCount];

boolean play = true;

int a = 3;
int b = 0;

Minim minim;

void setup() {
  minim = new Minim(this);

  for (int i = 0; i < rowCount; i++) {
    MO[i] = new MusicObject();
  }

  for (int i = 0; i < rowCount; i++) {
    MO[i].setArtist(Data.getString(i, 0));
    MO[i].setTitle(Data.getString(i, 1));
    MO[i].setYear(Data.getString(i, 2));
    MO[i].setInfo(Data.getString(i, 3));
    MO[i].setAlbumArt(Data.getString(i, 4));
    MO[i].setSongFile(Data.getString(i, 5));
  }

  size(600, 300);
  smooth(4);

  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  
  println(int(MO[rowCount - 1].getYear()) - int(MO[0].getYear()));
}

void draw() {
  background(0);
  MO[a].drawPopUp(width/2, height/2);
  MO[a].drawPlayButton();
  if (MO[a].getIsPlaying() == true && MO[a].songIsPlaying() == false) {
    MO[a].setIsPlaying(false);
    MO[a].rewindSong();
  }
}

void keyPressed() {
  if (key == ' ') MO[a].playSong();
  if (keyCode == RIGHT) {
    a++;
    a = constrain(a, 0, rowCount - 1);
  }
  if (keyCode == LEFT) {
    a--;
    a = constrain(a, 0, rowCount - 1);
  }
}

void mousePressed() {
 save(a + "_" + b + ".png");
 b++;
}

void stop() {
  for (int i = 0; i < MO.length; i++) {
    MO[i].stop();
  } 
  minim.stop();
  super.stop();
}

