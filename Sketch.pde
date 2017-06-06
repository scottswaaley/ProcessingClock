int deg,cx,cy;
float orbRot,sec,inc;
Pulley[] pulleys = new Pulley[10];
Pulley p1;
color hand1 = color(0,0,255);
color hand0 = color(0,255,0);


void setup() {
  frameRate(30);
  cx = width/2;
  cy = height/2;
  inc =1;
  //stroke(0,100);
  strokeWeight(10);
  fill(255,50);
  textSize(60);
  
  sec = 0;
  
  pulleys[0]=new Pulley(20,null,0,0,0,hand0);
  pulleys[1]=new Pulley(-20,pulleys[0],0,500,0,hand0);
  pulleys[2]=new Pulley(20,pulleys[0],0,500,PI/2,hand1);
  pulleys[3]=new Pulley(60,pulleys[2],1,500,0,hand0);
  pulleys[4]=new Pulley(12,pulleys[3],0,0,0,hand0);
  pulleys[5]=new Pulley(48,pulleys[4],1,0,0,hand0);
  pulleys[6]=new Pulley(12,pulleys[5],0,500,3*PI/2,hand1);
}

void draw(){
  background(#334E6F);
  orbRot = 2 * PI * sec / 86400;
  sec += inc;
  for(int i = 0; i < pulleys.length && pulleys[i] != null; i++){
    pulleys[i].show();
    pulleys[i].rot();
    //if(pulleys[i].orbTrans > 0) pulleys[i].orbRotate();
  }
  fill(0);
  text(sec,50,height - 50);
  text(degrees(orbRot),50,height - 100);
  
  if(mousePressed){
    //sec =0;
    inc = map(mouseY,height,0,1/30,500);
    if(mouseX > width - 200 && mouseY > height - 200) sec = 0;
  }
  for(int i = 0; i < pulleys.length && pulleys[i] != null; i++){
    text(i + ":" + round(degrees(pulleys[i].rot +orbRot)),50,50+50*i);
  }
  fill(255,50);
}

class Pulley {
  float rot, srot, orbTrans;
  int x,y,n,d,type;
  Pulley master;
  int BELT = 0; // enums defining relationship with master
  int COMP = 1; // enums defining relationship with master
  color handColor;
  
  Pulley(int _n,Pulley _master,int _type, int _orbTrans, float _srot, color _hands){
    rot = 0;
    n = _n;
    d = n * 10;
    master = _master;
    type = _type;
    orbTrans = _orbTrans;
    srot = _srot;
    handColor = _hands;
   
  }
  void rot(){
    
    if(master == null) rot = 0;
    else if(master.master == null) rot = orbRot * master.n/n;
    else if(type == COMP) rot = master.rot;
    else rot = (master.rot+orbRot) * (master.n/n);//+orbRot;// + orbRot;
  }
  
  void show(){
    
    pushMatrix();
    translate(cx,cy);
    if(orbTrans>0) rotate(orbRot);
    pushMatrix();
    translate(orbTrans,0);
    rotate(srot+rot);
    stroke(0,255);
    ellipse(0,0,d,d);
    stroke(handColor);
    line(0,0,d/2,0);
    popMatrix();
    popMatrix();
  }
  
}
