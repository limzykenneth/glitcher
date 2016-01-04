import processing.video.*;
import ddf.minim.*;
Minim minim;
AudioInput in;
Capture video;

PImage img;
PImage temp;

int cyan = 0xff00ffff;
int magenta = 0xffff00ff;
int yellow = 0xffffff00;

void setup() {
  size(800, 600);
  background(255);
  video = new Capture(this, width, height);
  video.start();
  minim = new Minim(this);
  colorMode(RGB, 255, 255, 255, 100);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  temp = createImage(width, height, RGB);
}

void captureEvent(Capture camera) {
  camera.read();

  img = createImage(width, height, RGB);
  video.loadPixels();
  arrayCopy(video.pixels, img.pixels);
}


void draw() {
  
  float volume = 0;
  for (int i = 0; i < in.bufferSize() - 1; i++) {
    volume += abs(in.left.get(i)) + abs(in.right.get(i));
  }

  loadPixels();


  //int randPosY = (int)map(volume, 0, 2000, 20, 50);
  //int randPos = (int)map(volume, 0, 2000, 20, 500);

  int pHeight = (int)random(600);
  int pRandPos = (int)random(20, 500);
  // Begin a loop for displaying pixel rows of 4 pixels height
  for (int y = 0; y < pHeight; y++) {
    if (img != null) {
      img.loadPixels();

      for (int x = 0; x < width; x++) {

        //int randPosX = (int)map(volume, 20, 2000, 20, 50);

        if (y < height) {

          // Fetch the current color in that location, and also the color
          // of the background in that spot
          pixels[x + (y) * width] = img.pixels[y * width + pRandPos + x];
          //pixels[x + randPosX + y * width] = img.pixels[ y * video.width + randPos + x];
          //pixels[x + (y + 1 + randPosY) * width] = img.pixels[ (y + 1) * video.width + randPos + 1 + x];
          //pixels[x + (y + 2 + randPosY) * width] = img.pixels[ (y + 2) * video.width + randPos + 2 + x];
          //pixels[x + (y + 3 + randPosY) * width] = img.pixels[ (y + 3) * video.width + randPos + 3 + x];
          //pixels[x + (y + 4 + randPosY) * width] = img.pixels[ (y + 4) * video.width + randPos + 4 + x];
          //pixels[x + (y + 5 + randPosY) * width] = img.pixels[ (y + 5) * video.width + randPos + 5 + x];
          //pixels[x + (y + 6 + randPosY) * width] = img.pixels[ (y + 6) * video.width + randPos + 6 + x];
          //pixels[x + (y + 7 + randPosY) * width] = img.pixels[ (y + 7) * video.width + randPos + 7 + x];
          //pixels[x + (y + 8 + randPosY) * width] = img.pixels[ (y + 8) * video.width + randPos + 8 + x];
        }
      }
    } else {
      break;
    }
  }
  
  updatePixels();
  temp.loadPixels();
  temp.pixels = pixels;
  
  int c = 0xffffff;
  int r = (int)random(3);
  
  switch (r){
    case 0:
      c = cyan;
      break;
    case 1:
      c = magenta;
      break;
    case 2:
      c = yellow;
      break;
  }
  temp.updatePixels();
  tint(c);
  image(temp,0,0,width, height);
}

boolean looping = true;
void mouseClicked(){
  if (looping){
    noLoop();
  }else{
    loop();
  }
  
  looping = !looping;
}