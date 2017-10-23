import javax.swing.JOptionPane;


//Global Variables
StopWatchTimer  sw;
CountDownTimer cd;
int highscore = 0;

void setup() {
  size(600, 600);
  frameRate(120);
  sw = new StopWatchTimer();
  sw.start();
  cd = new CountDownTimer();
  cd.start();
}

int circleX = 300; //x-value starting position of circle
int circleY = 300; //y-value starting position of circle

void draw() {
  background(#00FFFF);  
  countdown();
  time();
  textAlign(RIGHT);
  text("Highscore: " + highscore + " Seconds", 550, 50);
  circleX = (circleX*9 + mouseX)/10;
  circleY = (circleY*9 + mouseY)/10;
  fill(#EA2DE8);
  ellipse(circleX, circleY, 25, 25);
  float distance = dist(mouseX, mouseY, circleX, circleY);
  
  if (sw.second() == 3) {  //stops countdown at 0 seconds
    cd.stop();
  }
    

  if (distance < 8 && sw.second() > 3) {
    sw.stop();
     
    if (sw.second() > highscore) {
      highscore = sw.second();
      JOptionPane.showMessageDialog(null, " Your score is " + sw.second() + " seconds. Click to try again! \n Your new highscore is " + highscore + " seconds!");
    }
    else {
      JOptionPane.showMessageDialog(null, " Your score is " + sw.second() + " seconds. Click to try again! \n Your highscore is currently " + highscore + " seconds!");

    }
    noLoop();
  }

  /*PRINT TO CONSOLE TESTING
   println("-------------");
   println("mouseX " + mouseX);
   println("circleX "+ circleX); 
   println("distance " + distance); 
   println("millis " + millis()); 
   */
  // println(highscore);
}   

void mousePressed() {
  loop();
  sw.start();
  cd.start();
}

void countdown() {
  fill(#000000);
  textAlign(CENTER);
  if (sw.second() < 3) {       //Only show countdown for 3 seconds
    text("You are invulnerable for " + cd.second() + " more second(s)", 300, 100);
  }
// println(cd.second()); 
}

void time() {
  fill(#000000);
  textAlign(LEFT);
  text(nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 50, 50);
}

//ALL CLASSES BEGIN HERE ----------------

class StopWatchTimer {
  int startTime = 0, stopTime = 0;
  boolean running = false;  


  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    } else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  int minute() {
    return (getElapsedTime() / (1000*60)) % 60;
  }
}


class CountDownTimer {
  int startCount = 0, stopCount = 0;
  boolean running = false;  


  void start() {
    startCount = millis();
    running = true;
  }
  void stop() {
    stopCount = millis();
    running = false;
  }
  int getCountDown() {
    int count;
    if (running) {
      count = (startCount - millis());
    } else {
      count = (startCount - stopCount);
    }
    return count;
  }
  int second() {
    return (getCountDown() / 1000) % 60 + 3;
  }
}