# Ultrasonic Sensor Servo Control Project

## Table of Contents
1. [Project Overview](#project-overview)
2. [Components Used](#components-used)
3. [Wiring Diagram](#wiring-diagram)
4. [Code Explanation](#code-explanation)
5. [Integration of Components](#integration-of-components)
6. [Difficulties Encountered](#difficulties-encountered)
7. [Future Improvements](#future-improvements)
8. [Conclusion](#conclusion)
9. [References](#references)
10. [Project Functionality GIF](#project-functionality-gif)

## Project Overview
This project aims to create a distance measurement system using an ultrasonic sensor and a servo motor, providing visual feedback through red LEDs based on the measured distance. Additionally, it features a radar-like display using Processing, which visually represents the distance readings in real time. The system allows users to adjust the scanning speed via a potentiometer. This was my first independent project (besides digital circuits labs), where I enhanced my skills in wiring, using a breadboard, integrating components, debugging, and interfacing with a microcontroller. I also gained experience in programming within the Arduino IDE environment using C++.

## Components Used
- **Arduino UNO R3**: A popular microcontroller board based on the ATmega328P. It features 14 digital input/output pins (6 of which can be used as PWM outputs), 6 analog inputs, a USB connection for programming, a power jack, an ICSP header, and a reset button. The board is widely used for building electronics projects due to its simplicity and ease of use.
  - **Advantages of Arduino**:
    - **User-Friendly**: Easy to program using the Arduino IDE, which offers a simplified programming environment.
    - **Versatile**: Compatible with a wide range of sensors, motors, and other components, making it suitable for various projects.
    - **Large Community**: Extensive community support provides resources, tutorials, and libraries for learning and troubleshooting.
    - **Affordable**: Cost-effective for hobbyists and students, allowing for experimentation without a significant investment.

- **Ultrasonic Sensor (HC-SR04)**: Used for measuring distance. It sends ultrasonic pulses and calculates the time it takes for them to return, converting this time into distance. This component requires two digital pins for triggering and receiving signals.

- **Servo Motor (SG90)**: A small servo motor that rotates between specified angles to scan the environment. It requires a PWM-capable digital pin for precise control of its position.

- **Potentiometer (B10K)**: A variable resistor with a total resistance of 10k ohms, allowing users to adjust the scanning speed of the servo motor. It is connected to an analog pin for reading the resistance value, which helps in mapping the servo's delay time.

- **Red LEDs**: Three red LEDs provide visual feedback about the distance to an object. They are connected to digital pins for control.

- **Processing Environment**: Used to create a radar-like visual display that represents the measured distance in real time. The Processing sketch connects to the Arduino via serial communication to receive distance data and update the display accordingly.

## Wiring Diagram
![Wiring Diagram](/Arduino-Projects/Sonar_Servo_Project/Wiring-Diagram.png)

## Code Explanation
The provided code utilizes various components to create a distance measurement and feedback system using an ultrasonic sensor, servo motor, potentiometer, LEDs, and a Processing display. Below is a breakdown of how these components work together.

### 1. Component Initialization
- **Servo Motor (SG90)**: Controlled via a PWM-capable digital pin (pin 9) to adjust the angle based on distance measurements.
- **Ultrasonic Sensor (HC-SR04)**: Connected to pins 7 and 8 (trigPin and echoPin) to measure distance. The trigger pin sends a pulse, and the echo pin receives the reflected signal.
- **Potentiometer (B10K)**: Connected to analog pin A0 to dynamically control the delay time between servo movements, allowing user input to adjust the speed of scanning.
- **Red LEDs**: Connected to pins 10, 11, and 12 to provide visual feedback based on the measured distance.
- **Processing Environment**: Used to visualize the distance data. The sketch continuously reads distance data from the serial port and updates a radar-like display that shows the current distance in a circular format.

### 2. Main Functionality
- The **`setup()`** function initializes the pins for input and output, attaches the servo motor, and starts serial communication for debugging.
- The **`loop()`** function continuously reads the potentiometer value, maps it to a delay time, and moves the servo motor between 15 degrees and 165 degrees to scan the environment.

### 3. Moving the Servo
The **`moveServo()`** function handles the movement of the servo motor. It takes the start and end angles along with the delay time as arguments:
- The servo moves incrementally between the defined angles while measuring distance using the ultrasonic sensor.
- Each movement prints the current angle and measured distance to the Serial Monitor for real-time tracking.
- The function also calls **`ledControl()`** to update the LEDs based on distance feedback.

### 4. Distance Measurement
The **`calculateDistance()`** function uses the HC-SR04 to measure the distance to an object:
- A 10-microsecond pulse is sent to the trigger pin, and the duration of the received echo pulse is measured.
- The duration is converted into distance using the speed of sound (0.034 cm/µs), providing the distance in centimeters.

### 5. LED Control Logic
The **`ledControl()`** function controls the state of the red LEDs based on the distance measured:
- If the distance is less than 10 cm, all three LEDs are turned on.
- If the distance is between 10 cm and 25 cm, two LEDs are lit.
- If the distance is between 25 cm and 40 cm, only one LED is activated.
- If the distance is greater than 40 cm, all LEDs remain off.

This logic provides immediate visual feedback about the proximity of objects detected by the ultrasonic sensor.

### 6. Processing Display
The Processing sketch provides a radar-like visualization of the distance readings. It displays the current distance as a circular indicator, updating in real time as the servo scans the environment. This visualization enhances the user experience and provides an engaging way to interpret the sensor data.

## Integration of Components
The project successfully integrates the components to perform the following tasks:
- Measure distance using the HC-SR04 sensor and adjust the position of the SG90 servo motor based on that measurement.
- Use a potentiometer to adjust the scanning speed of the servo motor, allowing for user customization.
- Provide visual feedback through red LEDs that indicate how close an object is to the sensor, enhancing the interactivity of the project.
- Present a radar-like visualization of distance readings using Processing, making the data more accessible and visually appealing.

## Difficulties Encountered
During the project development, several challenges were encountered:
- Ensuring accurate distance measurements required careful calibration of the ultrasonic sensor.
- Synchronizing the movements of the servo motor with the LED feedback and Processing display was complex but was resolved through careful timing in the code.
- Debugging the code for correct LED behavior based on distance measurements took additional iterations.

## Future Improvements
Future iterations of this project could include:
- Integrating an LCD display to show distance measurements for clearer output.
- Adding a buzzer to provide audio feedback based on distance ranges.
- Enhancing the LED control logic to allow for more nuanced feedback, possibly using more colors or patterns.
- Improving the Processing visualization with additional features, such as graphs or data logging.

## Conclusion
This project demonstrates the integration of an ultrasonic sensor, servo motor, potentiometer, LEDs, and a radar-like Processing display to create an interactive distance measurement system. Throughout the process, I improved my techniques in wiring, using a breadboard, integrating components, debugging, and interfacing with a microcontroller. The experience gained from tackling the challenges and implementing the components will serve as a solid foundation for future projects, particularly in the VLSI field. This project is designed to showcase practical skills and knowledge to potential recruiters and during job interviews.

## References
- Arduino documentation for the Servo library.
- Datasheets for HC-SR04 ultrasonic sensor and SG90 servo motor.
- Online tutorials on integrating sensors and motors with Arduino.
- Processing documentation for creating visual displays.

## Project Functionality GIF
![Project Functionality GIF](path_to_your_gif.gif)  <!-- Replace with the actual path to your GIF -->

## Code Paths
- **Arduino Code**: [Path to Arduino Code](path_to_your_arduino_code.ino) <!-- Replace with the actual path to your Arduino code -->
- **Processing Code**: [Path to Processing Code](path_to_your_processing_code.pde) <!-- Replace with the actual path to your Processing code -->
