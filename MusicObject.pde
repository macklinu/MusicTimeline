class MusicObject {

  float OFFSET;

  AudioPlayer song;
  AudioMetaData meta;

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

  boolean hasSong;
  boolean isPlaying;


  PFont StagBook, StagBold, StagSans;

  MusicObject() {
    OFFSET = radians(90);

    StagBook = loadFont("StagBook.vlw");
    StagBold = loadFont("StagBold.vlw");
    StagSans = loadFont("StagSans.vlw");

    isPlaying = false;

    roundAmt = 20;
    tempImgLoc = "/Users/macklinu/git/MusicTimeline/data/exam1/img/_na.jpg";
  }

  void setArtist(String s) {
    artist = s;
  }

  void setTitle(String s) {
    title = s;
  }

  void setYear(String s) {
    year = s;
  }

  void setInfo(String s) {
    info = s;
  }

  void setAlbumArt(String imgName) {
    if (imgName.length() > 0) finalImgLoc = "/Users/macklinu/git/MusicTimeline/data/exam1/img/" + imgName;
    else finalImgLoc = tempImgLoc;
    PImage tempImg = loadImage(finalImgLoc);
    albumArt = roundImageCorners(tempImg, roundAmt);
  }

  void setSongFile(String s) {
    if (s.length() > 0) {
      hasSong = true; 
      songFile = "/Users/macklinu/git/MusicTimeline/data/exam1/mp3/" + s;
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

  void drawPopUp(float x, float y) {
    xPos = x;
    yPos = y;
    drawBackgroundBox();
    drawAlbumArt();
    drawText();
  }

  private void drawBackgroundBox() {
    rectMode(CENTER);
    noStroke();
    fill(240);
    rect(xPos, yPos, 450, 175, 10);
  }

  private void drawAlbumArt() {
    image(albumArt, xPos - 135, yPos, 150, 150);
  }

  private void drawText() {
    fill(0);
    textFont(StagBold, 14);
    text(artist, xPos - 35, yPos - 70);
    textFont(StagBook, 12);
    text('"' + title + '"', xPos - 35, yPos - 55);
    text(year, xPos - 35, yPos - 40);
    rectMode(CORNERS);
    text(info, xPos - 35, yPos - 30, xPos + 220, yPos + 100);
  }

  private void drawArc() {
    noFill();
    strokeWeight(3);
    stroke(41, 134, 203, 200);
    arc(xPos - 135, yPos, 60, 60, radians(0) - OFFSET, radians(359.9999 * arcPosition) - OFFSET);
  }

  void drawPlayButton() {
    if (!isPlaying) {
      noStroke();
      fill(240, 240, 240, 220);
      ellipse(xPos - 135, yPos, 60, 60);
      fill(0, 0, 0, 180);
      triangle(xPos - 143, yPos - 15, xPos - 143, yPos + 15, xPos - 120, yPos);
      drawArc();
    }
    if (isPlaying) {
      arcPosition = song.position() / trackLength;
      noStroke();
      fill(240, 240, 240, 220);
      ellipse(xPos - 135, yPos, 60, 60);
      fill(0, 0, 0, 180);
      rectMode(CENTER);
      rect(xPos - 135, yPos, 25, 25, 0);
      drawArc();
    }
  }

  void playSong() {
    isPlaying = !isPlaying;
    if (isPlaying) song.play();
    if (!isPlaying) song.pause();
  }

  void stopSong() {
    isPlaying = false;
    song.pause();
  }

  void rewindSong() {
    song.rewind();
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

