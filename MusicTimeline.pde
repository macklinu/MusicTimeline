import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
PFont font;

String EXAM_NUMBER = "exam2";

String myFile = sketchPath("/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/list.csv");
Table Data = new Table(myFile, "|");
int rowCount = Data.getRowCount();
MusicObject[] MO = new MusicObject[rowCount];

boolean play = true;
boolean mainScreen = false;

int a = 0;
int b = 0;
int cur;

void setup() {
  minim = new Minim(this);
  font = loadFont("RobotoThin.vlw");

  for (int i = 0; i < rowCount; i++) {
    MO[i] = new MusicObject();
  }

  for (int i = 0; i < rowCount; i++) {
    MO[i].ID = Data.getString(i, 0);
    MO[i].artist = Data.getString(i, 1);
    MO[i].title = Data.getString(i, 2);
    MO[i].year = Data.getString(i, 3);
    MO[i].info = Data.getString(i, 4);
    MO[i].setAlbumArt(Data.getString(i, 0));
    MO[i].setSongFile(Data.getString(i, 0));
  }

  size(600, 400);
  smooth(4);

  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);

  //  println(int(MO[rowCount - 1].getYear()) - int(MO[0].getYear()));
}

void draw() {
  background(0);
  fill(255, 200);
  textAlign(LEFT);
  text("Detroit: The Birthplace of Techno", 10, 15);
  text("Exam 2", 10, 30);
  text("11/19/2012", 10, 45);
  fill(255, 100);
  text(str(a+1) + " of " + rowCount, 10, 60);
  MO[a].drawPopUp(width/2, height/2);
  if (MO[a].isPlaying == true && MO[a].songIsPlaying() == false) {
    MO[a].isPlaying = false;
    MO[a].rewindSong();
  }
  for (int i = 0; i < MO.length; i++) {
    if (MO[i].hasSong) {
      if (MO[i].songIsPlaying()) {
        fill(255, 100);
        textAlign(LEFT);
        text(MO[i].artist + " - " + MO[i].title + " (" + MO[i].year + ")", 10, height - 10);
      }
    }
  }

  if (mousePressed) MO[a].mouseHold(mouseX, mouseY);

  if (keyPressed) {
    if (key == 'h') {
      rectMode(CORNERS);
      fill(240, 235);
      rect(width/2 - 450/2, height/2 - 175/2, width/2 + 450/2, (height/2 + 175/2) + 25);
    }
  }
}

void keyPressed() {
  if (key == 's') {
    if (!mainScreen) mainScreen = true;
  }
  if (keyCode == ENTER) {
    for (int i = 0; i < MO.length; i++) {
      if (MO[i].hasSong) {
        if (MO[i].songIsPlaying()) {
          MO[cur].rewindSong();
          if (cur == a) MO[a].playSong();
        }
      }
    }
  }
  if (key == ' ') {
    for (int i = 0; i < MO.length; i++) {
      if (MO[i].hasSong) {
        if (MO[i].songIsPlaying()) {
          MO[cur].playSong();
          if (cur == a) MO[a].playSong();
        }
      }
    }
    MO[a].playSong();
    cur = a;
  }
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
  MO[a].mouseClick(mouseX, mouseY);
}

void stop() {
  for (int i = 0; i < MO.length; i++) {
    MO[i].stop();
  } 
  minim.stop();
  super.stop();
}
