import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
float t = 0;
//
void setup() {
  size(900, 900);
  Ani.init(this);
  //LoadDraw();
  //SetDraw();
}
void draw() {
  strokeWeight(0.5);
  background(255);
  noFill();
  stroke(0);
  step();
  showDraw();
  if (doSerialConnect) {
    // FIRST RUN ONLY:  Connect here, so that 
    doSerialConnect = false;
    scanSerial();
    if (SerialOnline) {
      delay(1000);
      Write("M10");
      delay(1000);
      Write("G28");
      PenUp();
    } else {
      println("ERROR CONNECTING SERIAL");
    }
  }
  //println(myPort);
  if (myPort.available() > 0) {  // If data is available,
    String receive = myPort.readString();
    //println("RECEIVE: "+receive);         // read it and store it in val
    //if (receive == "OK") {
      
      println("will free");
      new Ani(this, pauser, "t", 0, Ani.EXPO_IN_OUT, "onEnd:Free");
    //}
  }
  noStroke();
  fill(255, 0, 0);
  text("size"+path.size(), 10, 20);
}
void Free() {
  println("free");
  isBusy = false;
}
void stop() {
  myPort.stop();
}