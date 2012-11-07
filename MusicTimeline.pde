// Currently nonworking version that attempts to include Minim library
// Want to upload this version to look at another time, but will build
// other features until I figure this out.

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

String myFile = "/Users/macklinu/git/MusicTimeline/data/list.csv";
Table Data = new Table(myFile, "|");
int rowCount = Data.getRowCount();
MusicObject[] MO = new MusicObject[rowCount];

boolean play = true;

int a = 24;

Minim minim;

void setup() {
  Minim minim = new Minim(this);
  for (int i = 0; i < rowCount; i++) {
    MO[i] = new MusicObject(Data.getString(i, 5));
  }
  for (int i = 0; i < rowCount; i++) {
    MO[i].setArtist(Data.getString(i, 0));
    MO[i].setTitle(Data.getString(i, 1));
    MO[i].setYear(Data.getString(i, 2));
    MO[i].setInfo(Data.getString(i, 3));
    MO[i].setAlbumArt(Data.getString(i, 4));
    MO[i].setSongFile(Data.getString(i, 5));
  }

  size(800, 800);
  smooth(4);

  background(0);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  MO[a].drawPopUp();
}

void keyPressed() {
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

/*
void stop() {
 // the AudioPlayer you got from Minim.loadFile()
 song.close();
 // the AudioInput you got from Minim.getLineIn()
 minim.stop();
 
 // this calls the stop method that
 // you are overriding by defining your own
 // it must be called so that your application
 // can do all the cleanup it would normally do
 super.stop();
 }
 */
