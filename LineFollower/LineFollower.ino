int rmotorpin1=5;
int rmotorpin2=6;

int lmotorpin1=10;
int lmotorpin2=11;
int sensor=2;
int sensorstate=0;

void setup(){
  pinMode(sensor,INPUT);
  pinMode(lmotorpin1,OUTPUT);
  pinMode(lmotorpin2,OUTPUT);
  pinMode(rmotorpin1,OUTPUT);
  pinMode(rmotorpin2,OUTPUT);
}

void loop(){
  sensorstate=digitalRead(sensor);
  if(sensorstate==HIGH){//left
    digitalWrite(rmotorpin1,100);
    digitalWrite(rmotorpin2,0);
    digitalWrite(lmotorpin1,0);
    digitalWrite(lmotorpin2,0);
  }
  else{
    digitalWrite(rmotorpin1,0);
    digitalWrite(rmotorpin2,0);
    digitalWrite(lmotorpin1,100);
    digitalWrite(lmotorpin2,0);
    
  }
}
