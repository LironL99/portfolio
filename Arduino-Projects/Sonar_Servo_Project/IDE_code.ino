// Includes the Servo library for controlling the servo motor
#include <Servo.h>

// Defines the pins for the Ultrasonic Sensor (Trig and Echo)
const int trigPin = 7;
const int echoPin = 8;

// Defines the pin for the potentiometer (used to control speed)
const int potPin = A0;

// Defines the pin for the servo motor
const int servoPin = 9;

// Defines the pins for the three LEDs
const int led1Pin = 10;
const int led2Pin = 11;
const int led3Pin = 12;

// Variables used to control the servo and measure distance
long duration;         // Time taken for ultrasonic pulse to return
int distance;          // Calculated distance from the object
int delayTime = 15;    // Delay between servo movements (adjustable by potentiometer)
int potValue = 0;      // Potentiometer reading value
Servo myServo;         // Creates a servo object to control the servo motor

void setup() {
  // Configures pins for the ultrasonic sensor, LEDs, and initializes serial communication
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an output to send ultrasonic pulses
  pinMode(echoPin, INPUT);  // Sets the echoPin as an input to receive the pulse response
  pinMode(led1Pin, OUTPUT); // Sets LED 1 pin as output
  pinMode(led2Pin, OUTPUT); // Sets LED 2 pin as output
  pinMode(led3Pin, OUTPUT); // Sets LED 3 pin as output
  Serial.begin(9600);       // Initializes serial communication for debugging and data display
  myServo.attach(servoPin); // Attaches the servo motor to the specified pin
}

void loop() {
  // Reads the potentiometer value to control the servo motor's speed
  potValue = analogRead(potPin);  // Reads the potentiometer value (0-1023)
  delayTime = map(potValue, 0, 1023, 10, 100); // Maps the potentiometer value to delay time (10-100ms)

  // Moves the servo motor from 15 degrees to 165 degrees
  moveServo(15, 165, delayTime);
  
  // Moves the servo motor back from 165 degrees to 15 degrees
  moveServo(165, 15, delayTime);
}

// Function to move the servo from startAngle to endAngle, with speed controlled by delayTime
void moveServo(int startAngle, int endAngle, int delayTime) {
  if (startAngle < endAngle) {
    // Moving servo from startAngle to endAngle
    for (int i = startAngle; i <= endAngle; i++) {
      myServo.write(i);                  // Moves the servo to the current angle 'i'
      delay(delayTime);                  // Delay between each step, adjusted by the potentiometer
      distance = calculateDistance();    // Calculate distance using the ultrasonic sensor
      Serial.print(i);                   // Print the current servo angle to the Serial Monitor
      Serial.print(",");                 
      Serial.print(distance);            // Print the measured distance to the Serial Monitor
      Serial.print(".");
      ledControl();                      // Control LEDs based on the distance

      // Dynamically adjust the speed by reading the potentiometer again
      potValue = analogRead(potPin);
      delayTime = map(potValue, 0, 1023, 35, 100); // Map pot value to delay
    }
  } else {
    // Moving servo back from endAngle to startAngle
    for (int i = startAngle; i >= endAngle; i--) {
      myServo.write(i);                  // Moves the servo to the current angle 'i'
      delay(delayTime);                  // Delay between each step, adjusted by the potentiometer
      distance = calculateDistance();    // Calculate distance using the ultrasonic sensor
      Serial.print(i);                   // Print the current servo angle to the Serial Monitor
      Serial.print(",");
      Serial.print(distance);            // Print the measured distance to the Serial Monitor
      Serial.print(".");
      ledControl();                      // Control LEDs based on the distance

      // Dynamically adjust the speed by reading the potentiometer again
      potValue = analogRead(potPin);
      delayTime = map(potValue, 0, 1023, 35, 100); // Map pot value to delay
    }
  }
}

// Function to calculate the distance using the Ultrasonic sensor
int calculateDistance() {  
  // Sends a 10-microsecond pulse to the trigPin to trigger the sensor
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Measures the time taken for the pulse to return
  duration = pulseIn(echoPin, HIGH);  
  // Converts the time (duration) into distance (in cm)
  distance = duration * 0.034 / 2;
  
  return distance;  // Returns the measured distance
}

// Function to control the LEDs based on the distance to the object
void ledControl() {
  // Turns off all LEDs before making any decision
  digitalWrite(led1Pin, LOW);
  digitalWrite(led2Pin, LOW);
  digitalWrite(led3Pin, LOW);

  // Control the LEDs based on distance ranges
  if (distance < 10) {             // Very close distance, turn on all 3 LEDs
      digitalWrite(led1Pin, HIGH);
      digitalWrite(led2Pin, HIGH);
      digitalWrite(led3Pin, HIGH);
  } else if (distance < 25) {      // Close distance, turn on 2 LEDs
      digitalWrite(led1Pin, HIGH);
      digitalWrite(led2Pin, HIGH);
      digitalWrite(led3Pin, LOW);
  } else if (distance < 40) {      // Moderate distance, turn on 1 LED
      digitalWrite(led1Pin, HIGH);
      digitalWrite(led2Pin, LOW);
      digitalWrite(led3Pin, LOW);
  } else {                         // Far distance, no LEDs on
      // No action needed, all LEDs remain LOW
  }
}
