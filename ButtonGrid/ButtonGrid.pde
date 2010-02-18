/**
 * ButtonGrid
 * Andrew Hershberger
 * Boots, Stanford CS 247
 * 2/14/2010
 *
 * Click and drag to paint
 *
 * Use the following keys to change colors:
 * b - blue
 * g - green
 * o - orange
 * p - pink
 * r - red
 * v - violet
 * w - white
 * x - black
 * y - yellow
 *
 */

ArrayList buttons;

// rows defines the length of each square's sides:
// sideLength = screen.height / rows
int rows = 10;

int pressedCount = MIN_INT;
color drawColor = color(0,0,255);

void setup()
{
  float sideLength = float(screen.height) / float(rows);
  
  int columns = floor(screen.width / sideLength);
  
  size(screen.width, screen.height);
  smooth();
  
  buttons = new ArrayList(rows*columns);
  
  for ( int x=0; x<columns; x++)
    for ( int y=0; y<rows; y++) {
      // Define and create rectangle button
      RectButton r = new RectButton(x*sideLength, y*sideLength, sideLength);
      buttons.add(r);
    }
}

void draw()
{
  // update all the buttons
  RectButton r;
  for ( int i=0; i < buttons.size(); i++) {
    r = (RectButton) buttons.get(i);
    r.update();
    r.display();
  }
}

void mousePressed() {
  pressedCount++;
}

void keyPressed() {
  switch (key) {
    case 'r':
      drawColor = color(255,0,0);
      break;
    case 'g':
      drawColor = color(0,255,0);
      break;
    case 'b':
      drawColor = color(0,0,255);
      break;
    case 'v':
      drawColor = color(127,0,127);
      break;
    case 'o':
      drawColor = color(255,127,0);
      break;
    case 'y':
      drawColor = color(255,255,0);
      break;
    case 'w':
      drawColor = color(255,255,255);
      break;
    case 'x':
      drawColor = color(0,0,0);
      break;
    case 'p':
      drawColor = color(255,111,207);
      break;
  }
}

class RectButton
{
  float x, y;
  float size;
  
  color baseColor = color(255,255,255);
  color currentColor = baseColor;
  
  boolean over = false;
  int lastRespondedToPress = MIN_INT;

  RectButton(float ix, float iy, float isize) 
  {
    x = ix;
    y = iy;
    size = isize;
  }

  void update() 
  {
    // check to see if the cursor is over this button
    if( mouseX >= x && mouseX <= x+size && mouseY >= y && mouseY <= y+size ) {
      over = true;
    }
    else {
      over = false;
    }

    if(over && mousePressed & pressedCount != lastRespondedToPress) {
      baseColor = drawColor;
      lastRespondedToPress = pressedCount;
    }

    if(over) {
      currentColor = lerpColor(baseColor, color(200,200,200), .4);
    } 
    else {
      currentColor = baseColor;
    }
  }
  
  void display() 
  {
    stroke(200);
    fill(currentColor);
    rect(x, y, size, size);
  }
}

