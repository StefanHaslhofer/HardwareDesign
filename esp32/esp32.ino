// the setup function runs once when you press reset or power the board
void setup() {
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  Serial.print("Hello world! Blink on port = ");
  delay(1000);                       // wait for a second
}
