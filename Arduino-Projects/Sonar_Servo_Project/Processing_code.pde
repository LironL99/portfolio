import processing.serial.*; // Imports library for serial communication
import java.awt.event.KeyEvent; // Imports library for handling keyboard events
import java.io.IOException; // Imports library for handling input-output exceptions
Serial myPort; // Defines Object Serial for communication

// Variables to store angle and distance data received from the Arduino
String angle = "";
String distance = "";
String data = "";
String noObject; // String to indicate if an object is out of range
float pixsDistance; // Variable for converting distance from cm to pixels
int iAngle, iDistance; // Variables for storing integer values of angle and distance
int index1 = 0;
int index2 = 0;
PFont orcFont; // Variable to store font

void setup() {
  size(1200, 700); // Set the window size (adjust for your screen resolution)
  smooth(); // Enables anti-aliasing for smoother visuals
  myPort = new Serial(this, "COM5", 9600); // Initialize the serial communication (adjust COM port accordingly)
  myPort.bufferUntil('.'); // Read data from the serial port until the character '.' (angle,distance format)
}

void draw() {
  fill(98,245,31); // Set the fill color to green for the radar
  // Creates motion blur effect by covering the previous frame with a transparent rectangle
  noStroke();
  fill(0,4);
  rect(0, 0, width, height - height * 0.065);
  
  fill(98,245,31); // Set the fill color back to green
  // Calls the functions responsible for drawing the radar, line, and detected objects
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

// Function to handle serial events (data from Arduino)
void serialEvent(Serial myPort) {
  // Read the data from the Serial Port until the '.' character
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1); // Remove the '.' character
  
  // Find the position of the ',' in the data and separate angle and distance
  index1 = data.indexOf(",");
  angle = data.substring(0, index1); // Extract the angle value
  distance = data.substring(index1 + 1, data.length()); // Extract the distance value
  
  // Convert the String values to integers
  iAngle = int(angle);
  iDistance = int(distance);
}

// Function to draw the radar arc and lines
void drawRadar() {
  pushMatrix(); // Save the current drawing matrix
  translate(width / 2, height - height * 0.074); // Move the origin to the center-bottom of the window
  noFill(); // Disable filling for the arcs and lines
  strokeWeight(2); // Set stroke thickness
  
  // Draw radar arcs
  stroke(98,245,31); // Set stroke color to green
  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);
  
  // Draw radar angle lines
  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  popMatrix(); // Restore the previous drawing matrix
}

// Function to draw detected objects based on angle and distance
void drawObject() {
  pushMatrix(); // Save the current drawing matrix
  translate(width / 2, height - height * 0.074); // Move the origin to the center-bottom of the window
  strokeWeight(9); // Set the thickness of the stroke for the object
  stroke(255,10,10); // Set stroke color to red for detected objects
  
  // Convert distance to pixels and limit it to 40 cm
  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);
  if (iDistance < 40) {
    // Draw the line representing the object detected by the sensor
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)),
         (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix(); // Restore the previous drawing matrix
}

// Function to draw the scanning line based on the current angle
void drawLine() {
  pushMatrix(); // Save the current drawing matrix
  strokeWeight(9); // Set stroke thickness
  stroke(30,250,60); // Set stroke color to green
  translate(width / 2, height - height * 0.074); // Move the origin to the center-bottom of the window
  // Draw the scanning line based on the current angle
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix(); // Restore the previous drawing matrix
}

// Function to draw the text on the screen
void drawText() {
  pushMatrix(); // Save the current drawing matrix
  
  // Check if the object is out of range
  if (iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  
  // Draw the background for the text
  fill(0,0,0); // Set fill color to black
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  
  // Set text size and color
  fill(98,245,31); // Set fill color to green
  textSize(25);
  
  // Draw distance markers
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);
  
  // Draw the main sonar information
  textSize(40);
  text("Liron's Sonar ", width - width * 0.875, height - height * 0.0277);
  text("Angle: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
  text("Distance: ", width - width * 0.26, height - height * 0.0277);
  
  // Display the distance if within range, otherwise display "Out of Range"
  if (iDistance < 40) {
    text("        " + iDistance + " cm", width - width * 0.180, height - height * 0.0277);
  }
  
  // Draw the angle markers around the radar
  textSize(25);
  fill(98,245,60); // Set fill color for angle markers
  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60)); // Rotate to align the text
  text("30°", 0, 0);
  resetMatrix();
  
  // Repeat for other angles (60°, 90°, 120°, 150°)
  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  
  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  
  translate((width - width * 0.512) + width / 2 * cos(radians(120)), (height - height * 0.0888) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  
  translate((width - width * 0.518) + width / 2 * cos(radians(150)), (height - height * 0.0925) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  resetMatrix();
  
  popMatrix(); // Restore the previous drawing matrix
}
