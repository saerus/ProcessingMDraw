void scanSerial() {  
  // Serial port search string:  
  int PortCount = 0;
  int PortNumber = -1;
  String portName;
  String str1, str2;
  int j;


  int OpenPortList[]; 
  OpenPortList = new int[0]; 


  SerialOnline = false;
  boolean serialErr = false;


  try {
    PortCount = Serial.list().length;
  } 
  catch (Exception e) {
    e.printStackTrace(); 
    serialErr = true;
  }


  if (serialErr == false)
  {

    println("\nI found "+PortCount+" serial ports, which are:");
    println(Serial.list());


    String  os=System.getProperty("os.name").toLowerCase();
    boolean isMacOs = os.startsWith("mac os x");
    boolean isWin = os.startsWith("win");




    if (isMacOs) 
    {
      str1 = "/dev/tty.wchusbserialfd120";       // Can change to be the name of the port you want, e.g., COM5.
      // The default value is "/dev/cu.usbmodem"; which works on Macs.

      str1 = str1.substring(0, 14);

      j = 0;
      while (j < PortCount) {
        str2 = Serial.list()[j].substring(0, 14);
        if (str1.equals(str2) == true) 
          OpenPortList =  append(OpenPortList, j);

        j++;
      }
    } else if  (isWin) 
    {    
      // All available ports will be listed.

      j = 0;
      while (j < PortCount) {
        OpenPortList =  append(OpenPortList, j);
        j++;
      }
    } else {
      // Assume linux

      str1 = "/dev/ttyACM"; 
      str1 = str1.substring(0, 11);

      j = 0;
      while (j < PortCount) {
        str2 = Serial.list()[j].substring(0, 11);
        if (str1.equals(str2) == true)
          OpenPortList =  append(OpenPortList, j);
        j++;
      }
    }




    boolean portErr;

    j = 0;
    while (j < OpenPortList.length) {

      portErr = false;
      portName = Serial.list()[OpenPortList[j]];

      try
      {    
        myPort = new Serial(this, portName, 115200);
      }
      catch (Exception e)
      {
        SerialOnline = false;
        portErr = true;
        println("Serial port "+portName+" could not be activated.");
      }

      if (portErr == false)
      {
        myPort.bufferUntil('\n');
        myPort.buffer(1);
        myPort.clear(); 
        println("Serial port "+portName+" found and activated.");

        SerialOnline = true;
        j = OpenPortList.length;
        myPort.write("P\r");
          //Request version number
        /*delay(50);  // Delay for EBB to respond!
         
         while (myPort.available () > 0) {
         inBuffer = myPort.readString();   
         if (inBuffer != null) {
         println("Version Number: "+inBuffer);
         }
         }
         
         str1 = "EBB";
         if (inBuffer.length() > 2)
         {
         str2 = inBuffer.substring(0, 3); 
         if (str1.equals(str2) == true)
         {
         // EBB Identified! 
         SerialOnline = true;    // confirm that this port is good
         j = OpenPortList.length; // break out of loop
         
         println("Serial port "+portName+" confirmed to have EBB.");
         } else
         {
         myPort.clear(); 
         myPort.stop();
         println("Serial port "+portName+": No EBB detected.");
         }
         }*/
      }
      j++;
    }
  }
}