//import Serial communication library
import processing.serial.*;

// Declare variable "a" of type PImage
PImage a;  

// Variable declaration
PFont font22, font44, font48;
PFont font12;
float tempC, tempF, RH;
float y, h, MS_Byte, LS_Byte;
Serial Dev_Board;
PrintWriter output;
int[] PC_Time = new int[3];
int[] MM_DD_YY = new int[3];
int i, j, xx=-15;
String curr_time, X_Time, curr_date, row_data, filename;

// Button
int rectX, rectY;      // Position of square button
int rectSize = 90;     // Diameter of rect
color rectColor, baseColor;
color rectHighlight;
color currentColor;
boolean rectOver = false, data_logg = false ;


void setup() {

// Define size of window
size(350, 350);

  //setup fonts for use throughout the application
  font22 = loadFont("MicrosoftYaHei-22.vlw");
  font12 = loadFont("MicrosoftYaHei-12.vlw");  
  font44 = loadFont("FranklinGothic-Demi-32.vlw");
  font48 = loadFont("GillSansMT-48.vlw");
  //init serial communication port
  println(Serial.list());
  Dev_Board = new Serial(this, Serial.list()[4], 9600);
  Dev_Board.bufferUntil(10);
  
  smooth();
  rectColor = color(0, 90, 140);
  rectHighlight = color(80);
  rectX = 220;
  rectY = 250;
  ellipseMode(CENTER);
  a=loadImage("waterdrop.jpg");
 
}

void draw() {
 
 while (Dev_Board.available() > 0)
 {
   String read = Dev_Board.readStringUntil(10);
   if (read != null ) {
     String[] s = split(read, " ");
     if (s.length == 2) {
       print("Read: ");
       println(read);
       MS_Byte = float(s[0]);
       print("MS_BYTE: ");
       println(MS_Byte);
       
       delay(10);
       LS_Byte = float(s[1]);
       print("LS_BYTE: ");
       println(LS_Byte);
       
       background(255, 255, 255); 
       fill(200, 6, 0);
       smooth();
       stroke(0);
       strokeWeight(2);
       ellipse(100, 280, 58, 50);
       noStroke();
       fill(0, 46, 200);
       arc(100, 60, 30, 20, PI, PI+PI);
       rect(85,60,30,200);
       // Capillary
       fill(250,250, 250);
       //stroke(0);
       rect(95,60,10,200);
      
       // Marks on thermometer
       stroke(0);
       strokeWeight(1);
       textAlign(RIGHT);
       fill(0,46,250);
       for (int i = 0; i < 5; i += 1) {
        line(70, 230-40*i, 80, 230-40*i);
        if(i < 4) line(75, 210-40*i, 80, 210-40*i);
        textFont(font12); 
        text(str(40+20*i), 65, 235-40*i); 
       }
       image(a, 180, 130);
       // Centigrade
       textAlign(LEFT);
       for (int i = 0; i < 6; i += 1) {
        line(118, 242-35*i, 128, 242-35*i);
        if(i < 5) line(118, 225-35*i, 123, 225-35*i);
        textFont(font12); 
        text(str(0+10*i), 135, 247-35*i);
       }
      
       noStroke();
       // text font
       fill(0,46,250);
      
       textFont(font22); 
       textAlign(LEFT);
       text("F", 57, 46);
       text("C", 135, 46);
       textFont(font12);
       text("o", 45, 35);
       text("o", 125, 35);
      
       fill(0,102,153);
       textFont(font22);
       text("o", 300+xx, 45);
       text("o", 300+xx, 85);
      
       // DHT11
       tempC = LS_Byte;
       RH = MS_Byte;
       tempF = ((tempC*9)/5) + 32;
       textFont(font44); 
       text(nfc(tempC, 1), 220+xx, 60);
       text(nfc(tempF, 1), 220+xx, 100);
       text("C", 320+xx, 60);
       text("F", 320+xx, 100);
       
       // Print Relative Humidity
       textFont(font48);
       text(nfc(RH, 0), 245, 190);
       text("%",295 , 190);
       // Raise mercury level
       fill(200,0, 0);
       y = -2.0*tempF + 310;
       h = 270-y;
       rect(95, y, 10, h);
       curr_time = PC_Time();
       curr_date = PC_Date();
       //println(curr_date);
      
       if (data_logg){
       row_data = curr_date + "  "+ curr_time + "  " + nfc(tempC, 1) + "  " + nfc(tempF, 1) + "  " + nfc(RH, 0);
       println(row_data); 
       output.println(row_data); 
       }
     }  
   }
}

update(mouseX, mouseY);
  if(rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(210);
  rect(rectX, rectY, rectSize, rectSize-45);
  textFont(font12);
  textSize(14);
  if(data_logg){
   fill(250,255,252);
   
   text("Stop Log", rectX+15, rectY+25);
  }
  if(!data_logg){
  fill(250,255,252);
  text("Start Log", rectX+15, rectY+25);
  }
 
}

void update(int x, int y)
{
  if ( overRect(rectX, rectY, rectSize, rectSize-45) ) {
    rectOver = true;
    } else {
    rectOver = false;
  }
}

void mousePressed()
{
  if(rectOver) {
    if(data_logg){
     data_logg = false;
     output.flush(); // Write the remaining data
     output.close(); // Finish the file

  } else {
    data_logg = true;
   // Create a new file in the sketch directory
   curr_date = PC_Date();
   curr_time = PC_Time();
   String[] temp = split(curr_date, "  ");
   filename = "DataLogger_"+join(temp, "");
   temp = split(curr_time, "  ");
   filename = filename+join(temp, "")+".txt";
   output = createWriter(filename);
   output.println("MM  DD  YYYY  HH  MM  SS    C     F   RH(%)");
      
  }
  }
}

boolean overRect(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

String PC_Time()
{
  
 PC_Time[2] = second();  // Values from 0 - 59
 PC_Time[1] = minute();  // Values from 0 - 59
 PC_Time[0] = hour();    // Values from 0 - 23
 return join(nf(PC_Time, 2), "  ");

}

String PC_Date()
{
  
 MM_DD_YY[2] = year();  
 MM_DD_YY[1] = day();  
 MM_DD_YY[0] = month();   
 return join(nf(MM_DD_YY, 2), "  ");
}


