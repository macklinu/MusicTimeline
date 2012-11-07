class MusicObject {
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
  int roundAmt;
  float xPos, yPos;

  boolean hasSong;

  PFont StagBook, StagBold, StagSans;

  MusicObject(String s) {

    song = minim.loadFile(s);
    trackLength = song.getMetaData().length();

    StagBook = loadFont("StagBook.vlw");
    StagBold = loadFont("StagBold.vlw");
    StagSans = loadFont("StagSans.vlw");

    roundAmt = 20;
    tempImgLoc = "img/_na.jpg";
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
    if (imgName.length() > 0) finalImgLoc = "img/" + imgName;
    else finalImgLoc = tempImgLoc;
    PImage tempImg = loadImage(finalImgLoc);
    albumArt = roundImageCorners(tempImg, roundAmt);
  }

  void setSongFile(String s) {
    if (s.length() > 0) hasSong = true;
    else hasSong = false;
    songFile = "mp3/" + s;
  }

  void setTrackLength(float f) {
    trackLength = f;
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


  // =======================

  void drawPopUp() {
    noStroke();
    fill(240);
    rect(width/2, height/2, 400, 175, 10);
    image(albumArt, width/2 - 100, height/2, 150, 150);
    fill(0);
    textFont(StagBold, 14);
    text(artist, width/2, height/2 - 70);
    textFont(StagBook, 12);
    text('"' + title + '"', width/2, height/2 - 55);
    text(year, width/2, height/2 - 40);
    textAlign(LEFT);
    text(info, width/2 + 100, height/2 + 160, width/2 - 200, height/2 - 20);
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

  /*
  void loadSong(String s) {
   song = minim.loadFile(s);
   trackLength = song.getMetaData().length();
   }
   */
}

