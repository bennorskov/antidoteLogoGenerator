import processing.svg.*; // so we can export SVGs

PShape logoText;
boolean doAnimation = true;
boolean saveSVG = false; // press space to save one frame

//////// //////// //////// //////// Build Dream Swooshes 
DreamSwoosh duskyYellow, red, perriwinkle, purple, green;

void setup() {
  size(800, 400);

  //////// ///// (number of Points, color, thickness(min,max), right most point, waviness, speed, curveOffset)
  duskyYellow =new DreamSwoosh(40, #f5c102, new PVector(12, 14), new PVector(725, 200), 2, .001, 200); 
  red =        new DreamSwoosh(50, #f25847, new PVector(4, 9), new PVector(600, 200), 3, .00001, 100); 
  perriwinkle =new DreamSwoosh(10, #4d91c9, new PVector(8, 10), new PVector(625, 200), 3, .0005, 240 );
  purple =     new DreamSwoosh(14, #8557ac, new PVector(6, 11), new PVector(525, 130), 1, .0006, 200 );
  green =      new DreamSwoosh(30, #00926c, new PVector(4, 8), new PVector(775, 200), 4, .0005, 100 );
  
  red.isDotted = true;

  //////// //////// //////// //////// Styles
  smooth();
  noStroke();

  logoText = loadShape("logoText.svg");
  if (!doAnimation) {
    noLoop();
  }
}
void draw() {
  if (saveSVG) {
    beginRecord(SVG, "logoExportFile-####.svg");
    // Recording will say "textMode(SHAPE) is not supported by this renderer." but it doesn't affect the output
    // files are placed in the sketch folder
  }

  background(#FFFfff);
  noStroke();
  duskyYellow.draw();
  red.draw();
  perriwinkle.draw();
  purple.draw();
  green.draw();
  
  pushMatrix();
  scale(2);
  translate(0, 50);
  shape(logoText, 0, 0);
  popMatrix();

  if (saveSVG) {
    saveSVG = false;
    endRecord();
  }
}

void keyPressed() {
  if (key == ' ') {
    saveSVG = true;
  }
}
