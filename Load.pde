String s[];
void LoadDraw()  {
  s = loadStrings("NewD.txt");
  //
  for (int i=0; i<s.length; i++) {
    String[] line = split(s[i], '/');
    PDraw p = new PDraw();
    p.x = float(line[0])/2f;
    p.y = float(line[1])/2f;
    if (i%2 == 0) {
      p.z = -1;
    } else {
      p.z = 1;
    }
    path.add(p);
  }
  //
}
void LoadOneLine()  {
  s = loadStrings("circles.txt");
  boolean first = true;
  //
  for (int i=0; i<s.length; i++) {
    String[] line = split(s[i], '/');
    PDraw p = new PDraw();
    p.x = float(line[0])/2f;
    p.y = float(line[1])/2f;
    if (first) {
      p.z = -1;
      first = false;
    }
    if(i == s.length-1) {
      p.z = 1;
    }
    path.add(p);
  }
}
void SetFlower() {
  float r = 1;
  float a = 0;
  float ccc = 0;
  PDraw p = new PDraw(150, 150, -1);
  path.add(new PDraw(p)); // ajoute à 0, 0 !
  PVector vel = new PVector();
  while(r < 10) {
    vel.x = cos(a)*r;
    vel.y = sin(a)*r;
    a+=PI/30f;
    r+=0.01f;
    ccc+=0.1;
    if(vel.mag() >= 1) {
      p.add(vel);
      p.z = 0;
      p.w = round(sin(ccc)*20-10);
      path.add(new PDraw(p));
      vel = new PVector();
    }
  }
  p = new PDraw(0, 0, 1);
  path.add(new PDraw(p)); // ajoute à 0, 0 !
}
void SetSign() {
  path.add(new PDraw(0, 301, -1));
  path.add(new PDraw(2, 301, 0));
  path.add(new PDraw(2, 303, 1));
  path.add(new PDraw(2, 302, -1));
  path.add(new PDraw(1, 302, 1));
}
void SetFrame() {
  path.add(new PDraw(0, 0, -1));
  path.add(new PDraw(300, 0, 0));
  path.add(new PDraw(300, 300, 0));
  path.add(new PDraw(0, 300, 0));
  path.add(new PDraw(0, 0, 1));
}