import processing.svg.*; // so we can export SVGs

PShape logoText;
boolean doAnimation = true;
boolean saveSVG = false; // press space to save one frame

//////// //////// //////// //////// Build Dream Swooshes 
DreamSwoosh duskyYellow, red, perriwinkle, purple, green;

void setup() {
  size(800, 400);

  //////// ///// (number of Points, color, thickness(min,max), right most point, waviness, speed, curveOffset)
  duskyYellow =new DreamSwoosh(40, #f5c102, new PVector(2, 15), new PVector(640, 200), 2, .001, 200); 
  red =        new DreamSwoosh(20, #f25847, new PVector(8, 9), new PVector(740, 200), 8, .01, 100); 
  perriwinkle =new DreamSwoosh(20, #4d91c9, new PVector(5, 10), new PVector(540, 200), 3, .01, 40 );
  purple =     new DreamSwoosh(10, #8557ac, new PVector(2, 30), new PVector(350, 200), .3, .003, 100 );
  green =      new DreamSwoosh(30, #00926c, new PVector(4, 20), new PVector(700, 200), 4, .005, 300 );

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
