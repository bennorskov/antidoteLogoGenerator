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

  boolean isDotted = false;
  int dottedGap = 1;
  int dottedLength = 1;

  DreamSwoosh (int _res, color _c, PVector _T, PVector _eP, float _noiseRange, float _spd, float _curveH) {
    // end points setup
    startP = new PVector(0, 200);
    endP   = _eP;
    dist = new PVector(endP.x - startP.x, endP.y - startP.y);
    
    // how many curve vertexes?
    resolution = (_res > 3) ? _res : 4;
    
    curveHeightOffset = _curveH;
   
    swooshColor = _c;
    
    /* each swoosh starts at the not same place in the noise field. 
     * They would have the exact same curve without this code
     * We can start them exactly the same here for more parallel movement. */
    noiseRandomOffset = 0;// random(100);

    noiseRange = _noiseRange; // how granular or not the noise field is
    noiseSpeed = _spd; // how fast to traverse the noise field
    
    // track the thickness at every point of the curve
    thickness = new float[resolution];
    for (int i = 0; i<resolution; i++) {
      thickness[i] = random(_T.x, _T.y);
    }
    // starting point is smaller
    thickness[resolution - 1] = _T.x;
  }
  DreamSwoosh(int _res, color _c, PVector _T, PVector _eP, float _noiseRange, float _spd, float _curveH, int _dGap, int _dLength) {
    this(_res, _c, _T, _eP, _noiseRange, _spd, _curveH);
    convertToDotted(_dGap, _dLength, _T);
    // resolution is reset in convert() above
  }
  void draw() {
    currentNoiseStep += noiseSpeed;
    
    fill(swooshColor);
    // ——————— ——————— ——————— ——————— ——————— ——————— ——————— ——————— Solid Swoosh
    if (!isDotted) {
      beginShape();
      curveVertex(startP.x, startP.y);
      PVector[] points = new PVector[resolution]; // used to draw bottoms of swooshes
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
    } else {
      // ——————— ——————— ——————— ——————— ——————— ——————— ——————— ——————— Dotted Swoosh
      for (int i = 0; i<resolution; i++) {
        if (i < resolution) {  
          beginShape();
          int begin = i;
          PVector[] smPoints = new PVector[dottedLength];
          int smPointsIndex = 0;
          for (i = begin; i<begin+dottedLength; i++) {
            currentNoiseStep += noiseSpeed;
            float percent = float(i)/float(resolution);
            float noiseX = noiseRange * percent + noiseRandomOffset + currentNoiseStep;
            PVector p = new PVector(startP.x + dist.x * percent, startP.y + noise(noiseX) * curveHeightOffset - curveHeightOffset*.5);
            smPoints[smPointsIndex] = p; 
            smPointsIndex++;
            curveVertex(p.x, p.y - thickness[i%resolution]*.5);
          }
          for (int j = smPoints.length-1; j>=0; j--) {
            curveVertex(smPoints[j].x, smPoints[j].y + thickness[(i-j-1)%resolution]*.5);
          }
          endShape();
          i+=dottedGap;
        }
      } // end dotted swoosh for loop
    } // end swoosh if(!dotted) statement
  }
  void convertToDotted(int _gap, int _length, PVector _T) {
    dottedGap = (_gap > 1) ? _gap : 1;
    dottedLength = (_length > 0) ? _length : 1;
    isDotted = true;
    
    println(resolution);
    // make sure the length of the swoosh is exactly the right length. 
    while (resolution%(dottedLength+dottedGap) != 0) {
      resolution++;
    }
    println(resolution);
    
     // track the thickness at every point of the curve
    thickness = new float[resolution];
    for (int i = 0; i<resolution; i++) {
      thickness[i] = random(_T.x, _T.y);
    }
    // starting point is smaller
    thickness[resolution - 1] = _T.x;
  }
  
}
