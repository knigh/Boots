

int rows = 5;
int columns = 5;
float tileWidth;
float tileHeight;

Position litTile;
Grid g;

void setup()
{
  float sideLength = float(screen.height) / float(rows);
  
  tileWidth = sideLength;
  tileHeight = sideLength;
  
  size(int(tileWidth * rows), int(tileHeight * columns));
  smooth();

  g = new Grid(rows, columns, tileWidth, tileHeight);
  litTile = new Position(int(random(0, rows)), int(random(0, columns)));
  g.setColor(litTile, color(255,255,255));
}

void updateGame() {
  Position[] pos = new Position[1];
  pos[0] = new Position(int(mouseX/tileWidth), int(mouseY/tileHeight));
  print("x: " + int(mouseX/tileWidth) + ", y: " + int(mouseY/tileHeight) + "\n");
  print("the lit tile is at " + litTile.getRow() + ", " + litTile.getColumn() + "\n");
  g.setPositions(pos);
  if (g.personIsPresent(litTile.getRow(), litTile.getColumn())) {
     g.setColor(litTile, color(0,0,0));
     litTile = new Position(int(random(0, rows)), int(random(0, columns)));
     g.setColor(litTile, color(255,255,255));
  }
  g.update();
}

void draw() {
   updateGame();
}

class Grid
{
  color baseColor = color(0,0,0);
  int rows;
  int columns;
  float tileHeight;
  float tileWidth;
  
  boolean[][] personPresent;
  Tile[][] tiles;
  
  Grid(int rows, int columns, float tileWidth, float tileHeight) 
  {
    this.rows = rows;
    this.columns = columns;
    this.tileHeight = tileHeight;
    this.tileWidth = tileWidth;
    
    personPresent = new boolean[rows][columns];
    tiles = new Tile[rows][columns];
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < columns; c++) {
            float x = r * tileWidth;
            float y = c * tileHeight;
            tiles[r][c] = new Tile(tileWidth, tileHeight, x, y, baseColor);
        }
    }
  }
  
  void update()
  {
     for (int r = 0; r < rows; r++) {
        for (int c = 0; c < columns; c++) {
            tiles[r][c].display();
        }
    }
  }
  
  void setPositions(Position[] positions) {
    boolean[][] tempPositions = new boolean[rows][columns];
    for (int i = 0; i < positions.length; i++) {
      tempPositions[positions[i].getRow()][positions[i].getColumn()] = true;
      print ("there is a person at " + positions[i].getRow() + ", " + positions[i].getColumn() + "\n");
    }
    // can compare to previous state here
    personPresent = tempPositions; // replace previous state with current state
  }
  
  boolean personIsPresent(int row, int col) {
    return personPresent[row][col];
  }
  
  void setColor(Position pos, color newColor) {
    tiles[pos.getRow()][pos.getColumn()].setColor(newColor);
  }
}

class Tile
{
  color tileColor;
  float tileHeight;
  float tileWidth;
  float xCoord;
  float yCoord;
  
  Tile(float tileWidth, float tileHeight, float xCoord, float yCoord, color tileColor)
  {
    this.tileHeight = tileHeight;
    this.tileWidth = tileWidth;
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.tileColor = tileColor;
  }
  
  void display() {
    stroke(200);
    fill(tileColor);
    rect(xCoord, yCoord, tileWidth, tileHeight);
  }
  
  void setColor(color newColor) {
    this.tileColor = newColor;
  }
}
  
class Position {
  int row;
  int column;
  
  Position(int row, int column)
  {
    this.row = row;
    this.column = column;
  }
  
  int getRow() {
    return row;
  }
  
  int getColumn() {
    return column;
  }
}
