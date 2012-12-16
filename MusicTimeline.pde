import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
PFont font, bold;

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
color bgColor = color(30);

int artSize = 50;


void setup() {
  minim = new Minim(this);
  font = loadFont("RobotoThin.vlw");
  bold = loadFont("RobotoBold.vlw");

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

  size(1000, 400);
  smooth(4);

  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  background(bgColor);
  fill(255, 200);
  textAlign(LEFT);
  textFont(font, 12);
  text("Detroit: The Birthplace of Techno", 10, 15);
  text("Exam 2", 10, 30);
  text("Hold 'h' for help", 10, 45);
  fill(255, 100);
  text(str(a+1) + " of " + rowCount, 10, 60);
  for (int i = 0; i < MO.length; i++) {
    MO[i].drawArtArray((i * artSize) + artSize/2, height-artSize*1.5, artSize);
  }

  // draw white box around the active track
  noFill();
  stroke(255, 175);
  strokeWeight(5);
  rectMode(CENTER);
  rect(MO[a].xA, MO[a].yA, artSize, artSize);

  if (MO[a].isPlaying == true && MO[a].songIsPlaying() == false) {
    MO[a].isPlaying = false;
    MO[a].rewindSong();
  }
  for (int i = 0; i < MO.length; i++) {
    if (MO[i].hasSong) {
      if (MO[i].songIsPlaying()) {
        fill(255, 100);
        textAlign(LEFT);
        textFont(font, 12);
        text(MO[i].artist + " - " + MO[i].title + " (" + MO[i].year + ")", 10, height - 10);
      }
    }
  }

  if (mousePressed) MO[a].mouseHold(mouseX, mouseY);

  MO[a].drawPopUp(width/2, height/2 - 50);

  if (keyPressed) {
    if (key == 'h' || key == 'H') {
      rectMode(CENTER);
      fill(240, 235);
      rect(width/2, height/2 - 50 + 15, MO[a].boxWidth, MO[a].boxHeight+ 20);
      fill(0);
      textFont(bold, 14);
      textAlign(CENTER);
      text("How to use", MO[a].xPos, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 5);
      textFont(font, 12);
      textAlign(LEFT);
      text("SPACEBAR -- Play/Pause current track", MO[a].xPos-MO[a].boxWidth/2 + 5, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 20);
      text("ENTER -- Stop current track and return to 0:00", MO[a].xPos-MO[a].boxWidth/2 + 5, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 35);
      text("LEFT/RIGHT ARROW KEYS -- Switch between tracks", MO[a].xPos-MO[a].boxWidth/2 + 5, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 50);
      text("Clicking the small album art photos on the bottom will also select a different track", MO[a].xPos-MO[a].boxWidth/2 + 5, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 65);
      text("h -- Show help menu", MO[a].xPos-MO[a].boxWidth/2 + 5, MO[a].yPos-MO[a].boxHeight/2 + textAscent() + 80);
    }
  }
}


void keyPressed() {
  if (key == 's') {
    // save("example.png");
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
  for (int i = 0; i < MO.length; i++) {
    if (dist(mouseX, mouseY, MO[i].xA, MO[i].yA) < MO[i].sizeA/2) a = i;
  }
}

void stop() {
  for (int i = 0; i < MO.length; i++) {
    MO[i].stop();
  } 
  minim.stop();
  super.stop();
}

