#define INPUT_PIN 35 // GP13 on ULX3S <-> GPIO35 on ESP32

void setup() {
  Serial.begin(115200);

  pinMode(INPUT_PIN, INPUT_PULLUP);
  pinMode(LED_BUILTIN, OUTPUT); // LED_BUILTIN = 5, this is D22 on the ULX3S
}

void loop() {
  int pinState = digitalRead(INPUT_PIN);

  if (pinState == HIGH) {
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW); 
  }                   

  delay(25);
}
