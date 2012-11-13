import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import java.awt.TextArea;
import java.awt.event.*;

String EXAM_NUMBER = "exam2";

String myFile = sketchPath("/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/list.csv");
Table Data = new Table(myFile, "|");
int rowCount = Data.getRowCount();
MusicObject[] MO = new MusicObject[rowCount];

boolean play = true;

int a = 0;
int b = 0;

Minim minim;

void setup() {

  addMouseWheelListener(new MouseWheelListener() {
    public void mouseWheelMoved(MouseWheelEvent mwe) {
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );

  minim = new Minim(this);

  for (int i = 0; i < rowCount; i++) {
    MO[i] = new MusicObject();
  }

  for (int i = 0; i < rowCount; i++) {
    MO[i].artist = Data.getString(i, 0);
    MO[i].title = Data.getString(i, 1);
    MO[i].year = Data.getString(i, 2);
    MO[i].info = Data.getString(i, 3);
    MO[i].setAlbumArt(Data.getString(i, 4));
    MO[i].setSongFile(Data.getString(i, 5));
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
  MO[a].drawPopUp(width/2, height/2);
  if (MO[a].isPlaying == true && MO[a].songIsPlaying() == false) {
    MO[a].isPlaying = false;
    MO[a].rewindSong();
  }
  for (int i = 0; i < MO.length; i++) {
    if (MO[i].hasSong) {
      if (MO[i].songIsPlaying()) {
        println(MO[i].artist + " - " + MO[i].title); 
      }
    }
  }
}

void keyPressed() {
  //  if (key == ' ') {
  //    save(a + "_" + b + ".png"); 
  //    b++;
  //  }
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
  MO[a].mouseEvents(mouseX, mouseY);
}

void mouseWheel(int i) {
  println("mouse has moved by " + i + " units.");
}


void stop() {
  for (int i = 0; i < MO.length; i++) {
    MO[i].stop();
  } 
  minim.stop();
  super.stop();
}

