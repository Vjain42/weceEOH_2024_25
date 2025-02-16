#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include <Servo.h>

// PCA9685 Servo Driver
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);

// Servo Pulse Constants (Adjust as needed)
#define SERVOMIN  150   // Min pulse length
#define SERVOMAX  600   // Max pulse length
#define MIDPOINT  375   // Neutral position

// Define Directly Connected Servos
Servo coxaServos[6];  // Coxa servos connected to Arduino Mega

// Servo Pin Assignments
const int coxaPins[6] = {2, 3, 4, 5, 6, 7};  // Pins on Arduino Mega
const int femurPins[6] = {0, 1, 2, 3, 4, 5}; // Channels on PCA9685 Servo driver
const int tibiaPins[6] = {6, 7, 8, 9, 10, 11}; // Channels on PCA9685 Servo driver

//We have six legs - legs 0, 1, 2, 3, 4, 5
// Leg Groups for Tripod Gait
const int groupA[3] = {0, 2, 4}; // Legs {0, 2, 4}
const int groupB[3] = {1, 3, 5}; // Legs {1, 3, 5}
int servosApos;
int servosBpos;
int currServoPos;

// Move Servo Function (for PCA9685)
void moveServo(int channel, int angle) {
  //OG code
  //int pulse = map(angle, 0, 180, SERVOMIN, SERVOMAX);
  //pwm.setPWM(channel, 0, pulse);

  //setting current pos based on groupA or groupB  servos
  if (channel % 2 == 0) {
    currServoPos = servosApos;
  }
  else {
    currServoPos = servosBpos;
  }
  
  //changing angle 1 degree at a time 
  while (currServoPos != angle) {
    currServoPos = currServoPos + 1;
    int pulse = map(currServoPos, 0, 180, SERVOMIN, SERVOMAX);
    pwm.setPWM(channel, 0, pulse);
    delay(15);
  }
  
  //updating group servo

  if (channel % 2 == 0){
    servosApos = angle;
  }
  else{
    servosBpos = angle;
  }
  

}

// Set Coxa Position (for Arduino Mega)
void moveCoxa(int leg, int angle) {
  //setting current pos based on groupA or groupB  servos
  if (leg % 2 == 0) {
    currServoPos = servosApos;
  }
  else {
    currServoPos = servosBpos;
  }
  //changing angle 1 degree at a time 
  while (currServoPos != angle) {
    currServoPos = currServoPos + 1;
    coxaServos[leg].write(currServoPos);

  }
  //updating group position based off of legno
  if (leg % 2 == 0){
    servosApos = angle;
  }
  else{
    servosBpos = angle;
  }
}

// lower all legs closer to ground to 'sit'
void sitDown() {
  for (int leg = 0; leg < 6; leg++) {
    // Move coxa to neutral position (90 degrees)
    moveCoxa(leg, 90);
    
    // Bend femur and tibia to lower the body
    // may need to adjust these angles based on physical geometry
    moveServo(femurPins[leg], 45);   // femur down
    moveServo(tibiaPins[leg], 135);  // tibia up
  }
}

// Lift and Lower Leg
void liftLeg(int leg) {
  if(legLiftDistance==0 &&)
  {
    moveServo(femurPins[leg], 90);
    moveServo(tibiaPins[leg], 90);
  }

  moveServo(femurPins[leg], 90);  // Lower femur
  moveServo(tibiaPins[leg], 90);  // Lower tibia
}

// Move Leg Forward
void moveLegForward(int leg) {
  moveCoxa(leg, 60);
}

// Move Leg Backward
void moveLegBackward(int leg) {
  moveCoxa(leg, 120);
}

// Walking Motion - Tripod Gait
void walkForward() {
  // Lift Group A
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);
  delay(200);
  for (int i = 0; i < 3; i++) moveLegForward(groupA[i]);
  delay(200);
  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);
  delay(200);

  // Lift Group B
  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);
  delay(200);
  for (int i = 0; i < 3; i++) moveLegForward(groupB[i]);
  delay(200);
  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);
  delay(200);
}

// // Rotate Hexapod Left
// void turnLeft() {
//   for (int i = 0; i < 6; i++) liftLeg(i);
//   delay(200);
//   for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 60);
//   for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 120);
//   delay(200);
//   for (int i = 0; i < 6; i++) lowerLeg(i);
//   delay(200);
// }

// Rotate Hexapod Left - Smoother Movement
void turnLeft() {
  //int stepDivisions = 3; //ed. 2.9
  // Step 1: Lift Group A & Rotate
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);  // Lift Group A
  delay(200);
  
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 60);  // Group A turns
  
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 90);  // Group B slightly shifts (stays on ground)
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);  // Lower Group A
  delay(200);

  // Step 2: Lift Group B & Rotate
  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);  // Lift Group B
  delay(200);

  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 60);  // Group B turns
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 90);  // Group A slightly shifts (stays on ground)
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);  // Lower Group B
  delay(200);
}

// Rotate Hexapod Right - Smoother Movement
void turnRight() {
  // Step 1: Lift Group A & Rotate
  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);  // Lift Group B
  delay(200);
  
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 60);  // Group B turns
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 90);  // Group A slightly shifts (stays on ground)
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);  // Lower Group B
  delay(200);

  // Step 2: Lift Group A & Rotate
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);  // Lift Group A
  delay(200);

  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 60);  // Group A turns
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 90);  // Group B slightly shifts (stays on ground)
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);  // Lower Group A
  delay(200);
}


// // Rotate Hexapod Right
// void turnRight() {
//   for (int i = 0; i < 6; i++) liftLeg(i);
//   delay(200);
//   for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 120);
//   for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 60);
//   delay(200);
//   for (int i = 0; i < 6; i++) lowerLeg(i);
//   delay(200);
// }

// Setup Function
void setup() {
  Serial.begin(115200);
  pwm.begin();
  pwm.setPWMFreq(60); // Set frequency to 60Hz

  // Attach Coxa Servos
  for (int i = 0; i < 6; i++) {
    coxaServos[i].attach(coxaPins[i]);
    coxaServos[i].write(90); // Set to neutral position
  }

  // Initialize all servos to neutral position
  for (int i = 0; i < 6; i++) {
    moveServo(femurPins[i], 90);
    moveServo(tibiaPins[i], 90);
  }

  servosApos = 90;
  servosBpos = 90;

  delay(1000);
}

// Loop Function - Basic Control Example
void loop() {
  Serial.println("Walking Forward...");
  walkForward();
  delay(1000);

  Serial.println("Turning Left...");
  turnLeft();
  delay(1000);

  Serial.println("Turning Right...");
  turnRight();
  delay(1000);
}



//////////////////////////////////////


#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include <Servo.h>
#include <math.h>

// PCA9685 Servo Driver
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);

// Servo Pulse Constants
#define SERVOMIN  150   // Min pulse length
#define SERVOMAX  600   // Max pulse length
#define MIDPOINT  375   // Neutral position

// Leg Geometry (Adjust as needed)
#define FEMUR_LENGTH 50  // Length of Femur
#define TIBIA_LENGTH 80  // Length of Tibia
#define COXA_LENGTH 30   // Length of Coxa
 
#define M_PI 3.14

// Define Directly Connected Servos
Servo coxaServos[6];  // Coxa servos connected to Arduino Mega

// Servo Pin Assignments
const int coxaPins[6] = {2, 3, 4, 5, 6, 7};  // Pins on Arduino Mega
const int femurPins[6] = {0, 1, 2, 3, 4, 5}; // Channels on PCA9685 Servo driver
const int tibiaPins[6] = {6, 7, 8, 9, 10, 11}; // Channels on PCA9685 Servo driver

//We have six legs - legs 0, 1, 2, 3, 4, 5
// Leg Groups for Tripod Gait
const int groupA[3] = {0, 2, 4}; // Legs {0, 2, 4}
const int groupB[3] = {1, 3, 5}; // Legs {1, 3, 5}

// Move Servo Function (for PCA9685)
void moveServo(int channel, int angle) {
  int pulse = map(angle, 0, 180, SERVOMIN, SERVOMAX);
  pwm.setPWM(channel, 0, pulse);
}

// Inverse Kinematics - Computes Leg Angles
void computeIK(int leg, float x, float y, float z) {
  // Coxa Angle
  float theta1 = atan2(x, y) * 180.0 / M_PI;
  moveCoxa(leg, theta1);

  // Distance from Coxa Joint
  float D = sqrt(x * x + y * y);
  float L = sqrt(D * D + z * z);

  // Femur and Tibia Angles (Law of Cosines)
  float theta3 = acos((L * L - FEMUR_LENGTH * FEMUR_LENGTH - TIBIA_LENGTH * TIBIA_LENGTH) / (2 * FEMUR_LENGTH * TIBIA_LENGTH)) * 180.0 / M_PI;
  float theta2 = atan2(z, D) * 180.0 / M_PI + acos((FEMUR_LENGTH * FEMUR_LENGTH + L * L - TIBIA_LENGTH * TIBIA_LENGTH) / (2 * FEMUR_LENGTH * L)) * 180.0 / M_PI;

  moveServo(femurPins[leg], theta2);
  moveServo(tibiaPins[leg], theta3);
}

// Move Coxa (Arduino Mega)
void moveCoxa(int leg, int angle) {
  coxaServos[leg].write(angle);
}

// Lift and Lower Leg
void liftLeg(int leg) {
  computeIK(leg, 0, 0, 40);  // Raise leg by 40mm
}

void lowerLeg(int leg) {
  computeIK(leg, 0, 0, 0);  // Lower leg to ground
}

// Move Leg Forward/Backward
void moveLegForward(int leg) {
  computeIK(leg, 50, 0, 0);  // Move forward
}

void moveLegBackward(int leg) {
  computeIK(leg, -50, 0, 0);  // Move backward
}

// Walking Motion - Tripod Gait
void walkForward() {
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);
  delay(200);
  
  for (int i = 0; i < 3; i++) moveLegForward(groupA[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 100);
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);
  delay(200);

  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);
  delay(200);

  for (int i = 0; i < 3; i++) moveLegForward(groupB[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 100);
  delay(200);

  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);
  delay(200);
}

void turnLeft() {
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 60);
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 90);
  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);
  delay(200);
  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 60);
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 90);
  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);
  delay(200);
}

void turnRight() {
  for (int i = 0; i < 3; i++) liftLeg(groupB[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 120);
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 90);
  for (int i = 0; i < 3; i++) lowerLeg(groupB[i]);
  delay(200);
  for (int i = 0; i < 3; i++) liftLeg(groupA[i]);
  for (int i = 0; i < 3; i++) moveCoxa(groupA[i], 120);
  for (int i = 0; i < 3; i++) moveCoxa(groupB[i], 90);
  for (int i = 0; i < 3; i++) lowerLeg(groupA[i]);
  delay(200);
}

// Setup Function
void setup() {
  Serial.begin(115200);
  pwm.begin();
  pwm.setPWMFreq(60);

  for (int i = 0; i < 6; i++) {
    coxaServos[i].attach(coxaPins[i]);
    coxaServos[i].write(90);
  }
}

// Loop Function - Basic Control
void loop() {
  Serial.println("Walking Forward...");
  walkForward();
  delay(1000);
}



