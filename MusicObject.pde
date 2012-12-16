class MusicObject {

  int yOFFSET;

  AudioPlayer song; // hey there!
  AudioMetaData meta;

  String ID;
  String artist;
  String title;
  String year;
  String info;
  PImage albumArt;
  String finalImgLoc;
  String tempImgLoc;
  String songFile;
  float trackLength;
  float position;
  float arcPosition;
  int roundAmt;
  float xPos, yPos;
  float xA, yA;
  int sizeA;

  boolean active;
  boolean hasSong;
  boolean isPlaying;

  boolean updatePlayerPositionVariables;
  float boxWidth, boxHeight;
  float lineStartPos, lineEndPos, lineLength;
  float buttonStartPos, buttonEndPos;

  PFont RobotoBlack, RobotoBold, RobotoCondensed, RobotoMedium, RobotoThin, RobotoItalic;

  MusicObject() {    
    yOFFSET = 25;

    RobotoBlack = loadFont("RobotoBlack.vlw");
    RobotoBold = loadFont("RobotoBold.vlw");
    RobotoCondensed = loadFont("RobotoCondensed.vlw");
    RobotoMedium = loadFont("RobotoMedium.vlw");
    RobotoThin = loadFont("RobotoThin.vlw");
    RobotoItalic = loadFont("RobotoItalic.vlw");

    isPlaying = false;

    roundAmt = 20;
    tempImgLoc = "/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/img/_na.jpg";

    boxWidth = 450;
    boxHeight = 175;

    updatePlayerPositionVariables = true;
    
    active = false;
  }

  void setAlbumArt(String s) {
    if (s.length() > 0) finalImgLoc = "/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/img/" + s + ".jpg";
    else finalImgLoc = tempImgLoc;
    PImage tempImg = loadImage(finalImgLoc);
    albumArt = tempImg;
    //    albumArt = roundImageCorners(tempImg, roundAmt);
  }

  void setSongFile(String s) {
    if (s.length() > 0) {
      hasSong = true; 
      songFile = "/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/mp3/" + s + ".mp3";
      song = minim.loadFile(songFile);
      trackLength = float(song.getMetaData().length());
    }
    else hasSong = false;
  }

  void setIsPlaying(boolean b) {
    isPlaying = b;
  }

  // =======================

  String getArtist() {
    return artist;
  }

  String getTitle() {
    return title;
  }

  String getYear() {
    return year;
  }

  String getAlbumArt() {
    return finalImgLoc;
  }

  String getInfo() {
    return info;
  }

  String getSongFile() {
    return songFile;
  }

  PImage displayAlbumArt() {
    return albumArt;
  }

  float getTrackLength() {
    return trackLength;
  }

  float getPosition() {
    return song.position();
  }

  boolean getIsPlaying() {
    return isPlaying;
  }

  boolean songIsPlaying() {
    return song.isPlaying();
  }

  // =======================
  
  void drawArtArray(float tempX, float tempY, int tempSize) {
    xA = tempX;
    yA = tempY;
    sizeA = tempSize;
    image(albumArt, xA, yA, sizeA, sizeA);
  }

  void mouseClick(int x, int y) {
    if (dist(x, y, xPos - boxWidth/2 + 10, yPos + boxHeight/2 + 12) < 5) {
      playSong();
    }
  }

  void mouseHold(int x, int y) {
    if (x >= lineStartPos && x <= lineEndPos) {
      if (abs(y - (yPos + boxHeight/2 + 8 + 5)) <= 7) {
        song.cue((int)map(x, lineStartPos, lineEndPos, 0, trackLength-1));
      }
    }
  }

  void drawPopUp(float x, float y) {
    xPos = x;
    yPos = y;
    drawBackgroundBox();
    drawAlbumArt();
    drawText();
    drawPlayBar();
  }

  private void drawBackgroundBox() {
    rectMode(CORNERS);
    noStroke();
    fill(240);
    rect(xPos - boxWidth/2, yPos - boxHeight/2, xPos + boxWidth/2, yPos + boxHeight/2 + yOFFSET);
  }

  private void drawAlbumArt() {
    image(albumArt, xPos - 135, yPos, 150, 150);
  }

  private void drawText() {
    fill(0);
    textFont(RobotoBold, 14);
    text(artist, xPos - 40, yPos - 70);
    textFont(RobotoMedium, 12);
    text('"' + title + '"', xPos - 40, yPos - 55);
    textFont(RobotoItalic, 12);
    text(year, xPos - 40, yPos - 40);
    rectMode(CORNERS);
    textFont(RobotoMedium, 12);
    textLeading(16);
    text(info, xPos - 40, yPos - 30, xPos + 210, yPos + 100);
  }

  private void drawPlayBar() {
    if (hasSong) {
      if (!isPlaying) {
        noStroke();
        fill(0);
        triangle(xPos - boxWidth/2 + 6, yPos + boxHeight/2 + 3 + 5, xPos - boxWidth/2 + 6, yPos + boxHeight/2 + 13 + 5, xPos - boxWidth/2 + 15, yPos + boxHeight/2 + 8 + 5);
      }
      if (isPlaying) {
        arcPosition = song.position() / trackLength;
        noStroke();
        fill(0);
        rectMode(CENTER);
        rect(xPos - boxWidth/2 + 10, yPos + boxHeight/2 + 8 + 5, 10, 10);
      }
      stroke(140);
      strokeWeight(1);
      line(xPos - boxWidth/2 + 19, yPos + boxHeight/2 + 3 + 5, xPos - boxWidth/2 + 19, yPos + boxHeight/2 + 13 + 5);
      drawPlayerPosition();
    }
  }

  private void drawPlayerPosition() {
    while (updatePlayerPositionVariables) {
      lineStartPos = (xPos - boxWidth/2 + 27);
      lineEndPos = (xPos + boxWidth/2 - 15);
      lineLength = lineEndPos - lineStartPos;
      buttonStartPos = (xPos - boxWidth/2 + 27);
      buttonEndPos = (xPos + boxWidth/2 - 15); 
      updatePlayerPositionVariables = false;
    }
    strokeWeight(4);
    stroke(41, 134, 203, 220);
    line(lineStartPos, yPos + boxHeight/2 + 8 + 5, lineEndPos, yPos + boxHeight/2 + 8 + 5);
    noStroke();
    fill(41, 134, 203, 180);
    ellipse(buttonStartPos + (arcPosition * lineLength), yPos + boxHeight/2 + 8 + 5, 10, 10);
    if (song.position() == trackLength) rewindSong();
  }

  void playSong() {
    if (hasSong) {
      isPlaying = !isPlaying;
      if (isPlaying) song.play();
      if (!isPlaying) song.pause();
    }
  }

  void stopSong() {
    if (hasSong) {
      isPlaying = false;
      song.pause();
    }
  }

  void rewindSong() {
    song.pause();
    song.rewind();
    arcPosition = 0;
  }

  // =======================

  void stop() {
    song.pause();
    song.close();
  }
}

