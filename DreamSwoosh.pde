class DreamSwoosh {
  
  PVector startP, endP, dist;
  int resolution;
  color swooshColor;
  float noiseRandomOffset, noiseRange, noiseSpeed;
  // noiseRange is how wavvvvy the swoosh is. Higher is more wavy
  float currentNoiseStep = 0;
  
  int maxThickness;
  float[] thickness;
  
  float curveHeightOffset;
  
  PVector[] points;
  DreamSwoosh (int _res, color _c, PVector _T, PVector _eP, float _noiseRange, float _spd, float _curveH) {
    // end points setup
    startP = new PVector(5, 200);
    endP   = _eP;
    dist = new PVector(endP.x - startP.x, endP.y - startP.y);
    
    // how many curve vertexes?
    resolution = _res;
    points = new PVector[resolution]; // used to draw bottoms of swooshes
    
    curveHeightOffset = _curveH;
   
    swooshColor = _c;
    
    // each swoosh starts at the not same place. We can start them exactly the same here for more parallel movement.
    noiseRandomOffset = random(100);
    noiseRange = _noiseRange;
    noiseSpeed = _spd;
    
    // track the thickness at every point of the curve
    thickness = new float[resolution];
    for (int i = 0; i<resolution; i++) {
      thickness[i] = random(_T.x, _T.y);
    }
    // starting point is smaller
    thickness[resolution - 1] = _T.x;
  }
  void draw() {
    currentNoiseStep += noiseSpeed;
    
    fill(swooshColor);
    beginShape();
    curveVertex(startP.x, startP.y);
    for (int i = 0; i<resolution; i++) {
      float percent = float(i)/float(resolution);
      float noiseX = noiseRange * percent + noiseRandomOffset + currentNoiseStep;
      PVector p = new PVector(startP.x + dist.x * percent, startP.y + noise(noiseX) * curveHeightOffset - curveHeightOffset*.5);
      points[i] = p;
      curveVertex(p.x, p.y - thickness[i]*.5);
    }
    for (int i = resolution-1; i>=0; i--) {
        curveVertex(points[i].x, points[i].y + thickness[i]*.5);
    }
    curveVertex(startP.x, startP.y);
    endShape();
    
  }
}
