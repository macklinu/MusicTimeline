class MusicObject {

  int yOFFSET;

  AudioPlayer song;
  AudioMetaData meta;
  TextArea screenText;

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

  boolean active;
  boolean hasSong;
  boolean isPlaying;

  boolean updatePlayerPositionVariables;
  float boxWidth, boxHeight;
  float lineStartPos, lineEndPos, lineLength;
  float buttonStartPos, buttonEndPos;

  PFont RobotoBlack, RobotoBold, RobotoCondensed, RobotoMedium, RobotoThin, RobotoItalic;

  MusicObject() {
    screenText = new TextArea("", 23, 45, 1);



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
  }

  void setAlbumArt(String imgName) {
    if (imgName.length() > 0) finalImgLoc = "/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/img/" + imgName;
    else finalImgLoc = tempImgLoc;
    PImage tempImg = loadImage(finalImgLoc);
    albumArt = tempImg;
    //    albumArt = roundImageCorners(tempImg, roundAmt);
  }

  void setSongFile(String s) {
    if (s.length() > 0) {
      hasSong = true; 
      songFile = "/Users/macklinu/git/MusicTimeline/data/" + EXAM_NUMBER + "/mp3/" + s;
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

  boolean hasSong() {
    return hasSong;
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

  void mouseEvents(float x, float y) {
    if (dist(x, y, xPos - boxWidth/2 + 10, yPos + boxHeight/2 + 8) < 5) {
      playSong();
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
    else {
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
    song.rewind();
  }

  void skipPosition() {
  }

  // =======================

  // borrowed from http://processing.org/discourse/beta/num_1201879926.html  
  private PImage roundImageCorners(PImage img, int radius) {

    PImage rounded = createImage(img.height, img.width, ARGB);

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        float d;

        if (i < radius && j < radius )
          d = dist(i, j, radius, radius);
        else if (i > img.width - radius - 1 && j < radius )
          d = dist(i+1, j, img.width-radius, radius);
        else if ( i<radius && j>img.height-radius-1 )
          d = dist(i, j+1, radius, img.height-radius);
        else if ( i>img.width-radius-1 && j>img.height-radius-1 )
          d = dist(i+1, j+1, img.width-radius, img.height-radius);
        else
          d = 0;

        color pixel = img.pixels[i + img.width*j];
        float opacity = constrain(255*(1+radius-d), 0, 255);
        opacity = min( alpha(pixel), opacity ); // preserve the transparency of the original image.
        rounded.pixels[i + img.width*j] = color( red(pixel), green(pixel), blue(pixel), opacity );
      }
    }
    return rounded;
  }

  void stop() {
    song.pause();
    song.close();
  }
}

