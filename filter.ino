void setup() {
  pinMode(2, INPUT);
  pinMode(3, INPUT); 
  pinMode(4, INPUT); 
  pinMode(5, INPUT); 
  pinMode(6, INPUT); 
  pinMode(7, INPUT); 
  pinMode(8, INPUT); 
  pinMode(9, INPUT);
  Serial.begin(115200);
}



void loop() {
  if(Serial.available()){
        float b = Serial.parseFloat();
        int a = int(b) ;
        digitalWrite(13,a%2);
        a = (a>>1);
        digitalWrite(12,a%2);
        a = (a>>1);
        digitalWrite(11,a%2);
        a = (a>>1);
        digitalWrite(10,a%2);
        a = (a>>1);
        
        int z0 = digitalRead(2);
        int z1 = digitalRead(3);
        int z2 = digitalRead(4);
        int z3 = digitalRead(5);
        int z4 = digitalRead(6);
        int z5 = digitalRead(7);
        int z6 = digitalRead(8);
        int z7 = digitalRead(9);
        int no = (z7<<7)+(z6<<6)+(z5<<5)+(z4<<4)+(z3<<3)+(z2<<2)+(z1<<1)+z0;
        
        Serial.println(no);
      
  }

}
