void setup() {

  //right
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  
  //left
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  
  
}

void loop() {

  analogWrite(5,100); analogWrite(6, 0);//right forward
  analogWrite(10, 100); analogWrite(11, 0);//left forward

  delay(1000);

  
  analogWrite(5,0); analogWrite(6, 0);//right forward
  analogWrite(10, 0); analogWrite(11, 0);//left forward
  delay(1000);

  while(true);
  
  
  
  
  
  
}
