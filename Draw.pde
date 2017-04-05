import processing.serial.*;
//
boolean doSerialConnect = true;
boolean SerialOnline = false;
Serial myPort;
int penUp = 90;
int penDown = 75;
boolean penIsDown = false;
PVector minBounds = new PVector(0, 0);
PVector maxBounds = new PVector(300, 310); // 10 more are for signature
boolean hasChanged = false;
//
boolean isBusy = false;
boolean isPlay = false;
ArrayList<PDraw> path = new ArrayList<PDraw>();
float pauser = 0;
//
void keyPressed() {
  if (key == ' ') {
    isPlay = !isPlay;
  } 
  if (key == 'f') {
    SetFrame();
  } 
  if (key == 'l') {
    LoadDraw();
  }
  if (key == 'o') {
    LoadOneLine();
  }
  if (key == 'x') {
    Free();
  }
  if (key == 's') {
    SetSign();
  }
  if (key == 't') {
    SetFlower();
  }
}
void SetDraw() {
  float radius = 100;
  float reduct = 0.2;
  float angle = 0;
  float decal = PI/5+PI/50;
  boolean first = true;
  while (radius > 1) {
    PDraw p = new PDraw();
    p.x = cos(angle)*radius+width/2;
    p.y = sin(angle)*radius+height/2;
    p.z = 0;
    path.add(p);
    //
    if (first) {
      p = new PDraw();
      first = false;
      p.z = -1;
      path.add(p);
    }
    //
    angle += decal;
    radius -= reduct;
  }
}
void step() {
  if (isPlay) {
    if (isBusy == false) {
      isBusy = true;
      //
      if (path.size() > 0) {
        PDraw temp = path.get(0);
        if (temp.z == -1) {
          DrawTo(temp);
          temp.z = -2;
          pauser = 0;
        }  else if (temp.z == 1) {
          DrawTo(temp); 
          temp.z = 2;
          pauser = 0;
        } else if (temp.z == -2) {
          PenDown();
          path.remove(0);
          pauser = 0.2;
        } else if (temp.z == 2) {
          PenUp();
          path.remove(0);
          pauser = 0.2;
        } else {
          /*if(temp.w > 0) {
            Write("M1 "+(penDown+temp.w));
          }*/
          DrawTo(temp);
          path.remove(0);
          pauser = 0;
        }
      }
    }
  }
}

void showDraw() {
  for (PDraw p : path)  {
    if (p.z == -1) {
      beginShape();
      //println("BEGIN");
    }
    ellipse(p.x*3, p.y*3, p.w, p.w);
    vertex(p.x*3, p.y*3);
    //println(p.x+" "+p.y);
    if (p.z == 1) {
      endShape();
      //println("END");
    }
  }
}

void PenUp() {
  penIsDown = false; 
  Write("M1 "+penUp);
}
void PenDown() {
  penIsDown = true;
  Write("M1 "+penDown);
}
void DrawTo(PVector temp) {
  if (temp.x >= minBounds.x && temp.x <= maxBounds.x && temp.y >= minBounds.y && temp.y <= maxBounds.y) {
    Write("G00 X"+temp.x+" Y"+temp.y);
  } else {
    // simply ignore out of borders
    isBusy = false;
  }
}
void Write(String msg) {
  println("SEND: "+msg+"\\n");
  myPort.write(msg+"\n");
}

void mousePressed() {
  println(penIsDown);
  if (!penIsDown) {
    PenDown();
  } else {
    PenUp();
  }
}