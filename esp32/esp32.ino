#define INPUT_PIN 35 // GP13 on ULX3S <-> GPIO35 on ESP32
#define OUTPUT_PIN 26 // GP11 on ULX3S <-> GPIO26 on ESP32
#define OUTPUT_PIN_2 33 // GP12 on ULX3S <-> GPIO33 on ESP32

void setup() {
  Serial.begin(115200);

  delay(10000);
  pinMode(INPUT_PIN, INPUT_PULLUP);
  pinMode(OUTPUT_PIN, OUTPUT);
  pinMode(OUTPUT_PIN_2, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  int pinState = digitalRead(INPUT_PIN);
  
  if (pinState == HIGH) {
    Serial.println("HIGH");
    digitalWrite(OUTPUT_PIN, HIGH);
    digitalWrite(OUTPUT_PIN_2, HIGH);
  } else {
    Serial.println("LOW");
    digitalWrite(OUTPUT_PIN, LOW);
    digitalWrite(OUTPUT_PIN_2, LOW); 
  }

  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);                 
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
