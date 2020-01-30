import processing.svg.*; // so we can export SVGs

PShape logoText;
boolean doAnimation = true;
boolean saveSVG = false; // press space to save one frame

//////// //////// //////// //////// Build Dream Swooshes 
DreamSwoosh duskyYellow, red, perriwinkle, purple, green;

void setup() {
  size(800, 400);

  // see Detailed Explanation at the bottom of this file
  // (number of Points, color, thickness(min,max), right most point, waviness, speed, curveOffset, [dotted Gap], [dotted Length])
  duskyYellow =new DreamSwoosh(40, #f5c102, new PVector(12, 14),new PVector(725, 200), 6, .001,   200); 
  red =        new DreamSwoosh(200,#f25847, new PVector(9, 9),  new PVector(600, 200), 1, .00001, 300, 1, 25); 
  perriwinkle =new DreamSwoosh(10, #4d91c9, new PVector(8, 10), new PVector(625, 200), 3, .0005,  240 );
  purple =     new DreamSwoosh(14, #8557ac, new PVector(6, 11), new PVector(525, 130), 1, .0006,  200 );
  green =      new DreamSwoosh(30, #00926c, new PVector(4, 8),  new PVector(775, 200), 4, .0005,  100 );

  float noiseOffsetAmount = .000002;
  duskyYellow.noiseRandomOffset = 0;//noiseOffsetAmount+=noiseOffsetAmount;
  red.noiseRandomOffset = 0;//noiseOffsetAmount+=noiseOffsetAmount;
  perriwinkle.noiseRandomOffset = 0;//noiseOffsetAmount+=noiseOffsetAmount;
  purple.noiseRandomOffset = 0;//noiseOffsetAmount+=noiseOffsetAmount;
  green.noiseRandomOffset = 0;//noiseOffsetAmount+=noiseOffsetAmount;
  

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
  
  // —————————— —————————— —————————— Drawing Order. First things drawn are at the back. 
  duskyYellow.draw();
  red.draw();
  perriwinkle.draw();
  purple.draw();
  green.draw();
  
  // Logo placement
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

/* 
Detailed Explaination of DreamSwoosh constructor
number of Points: 
The resolution the swoosh has. It's the number of points along a curve. The illustrator analogy is using the pen tool to add points +;
A Higher number is more points. Minimum is 4;

color:
Color in hex. Can also be color(red, green, blue)

thickness(min,max):
The swoosh will pick a random thickness between the two numbers. For no variation, put the same number twice

right most point:
This is where the swoosh starts on the right. It's the head of the swoosh

waviness
Higher numbers here make more jittery looking swooshes. 10-15 is probably as high as we want, but put any (positive) number!

speed
This moves the noise field. Any number higher than about .01 looks very fast. 

curveOffset:
This is the vertical range that each point of the curve will cover. A higher number will mean greater valleys and peaks for the curve.
Anything below 30 will be pretty flat. 

[dotted Gap], [dotted Length]: 
These are optional values. Leave them out for a normal swoosh
If you'd like a dotted line, fill these two values out. The first is the space between dots, and the second is the length of the dots
The minimum number for the gap is 1, but it looks a lot bigger than that because of math reasons. I'm not quite sure what to do to get it smaller than 1. 
*/
