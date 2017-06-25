import java.util.Arrays; 

Circle[] circles;
int numCircles = 15;
int displayWidth = 1000;
int displayHeight = 600;

int stepLength = 2;

class Circle {
  float[] path;
  float[] diameters;
  
  float[] pathWeights;
  int numPathWeights = 10;
  
  float[] diameterWeights;
  int numDiameterWeights = 4;
  
  float amplitude;
  int step;
  boolean done = false;
  
  void start() {
    step = 0; //<>//
    amplitude = random(100, 200);
    //initialize the array to store the y-coords of the sine wave
    path = new float[displayWidth/stepLength];
    diameters = new float[path.length];
    
    //start at the center of the screen
    Arrays.fill(path, displayHeight/2);
    Arrays.fill(diameters, 10);
    
    //determine which direction the circle should start moving
    int flip = (floor(random(2)) == 1) ? 1 : -1;
    
    pathWeights = new float[floor(random(2, numPathWeights))];
    for (int i = 0; i < pathWeights.length; i++) {
      pathWeights[i] = random(10, 40);
    }
    
    diameterWeights = new float[floor(random(2, numDiameterWeights))];
    for (int i = 0; i < diameterWeights.length; i++) {
      diameterWeights[i] = random(4, 10); 
    }
    
    for (int i = 1; i < path.length; i++) {
      float theta = i * 0.0025;
      
      for (int j = 0; j < pathWeights.length; j++) {
        path[i] += (pathWeights[j] * sin(pathWeights[j] * theta)) * flip; 
      }
      
      for (int j = 0; j < diameterWeights.length; j++) {
        diameters[i] += diameterWeights[j] * sin(diameterWeights[j] * theta);
      }
    }
  }
  
  void move() {
    step += floor(random(1, 5));
  }
  
  void display() {
    noFill();
    if (step < path.length) {
      ellipse(step * stepLength, path[step], diameters[step], diameters[step]);  
    } else {
      step = 0;
      start();
    }
  }
}  

void setup() {
  size(displayWidth, displayHeight);
  circles = new Circle[numCircles];
  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle();
    circles[i].start();
  }
}


void draw() {
  background(255);
  for (int i = 0; i < circles.length; i++) {
    circles[i].move();
    circles[i].display();
  }
}