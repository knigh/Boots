
void setup()
{
  int rows = 5;
  int columns = 5;
  float sideLength = float(screen.height) / float(rows);
  
  size(int(rows * sideLength), int(columns * sideLength));
  smooth();

  Grid g = new Grid(rows, columns, sideLength, sideLength);

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
  
  Grid(int rows, int columns, float tileHeight, float tileWidth) 
  {
    this.rows = rows;
    this.columns = columns;
    this.tileHeight = tileHeight;
    this.tileWidth = tileWidth;
    
    personPresent = new boolean[rows][columns];
    tiles = new Tile[rows][columns];
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < columns; c++) {
            personPresent[r][c] = false;
            float x = c * tileWidth;
            float y = r * tileWidth;
            tiles[r][c] = new Tile(tileHeight, tileWidth, x, y, baseColor);
            tiles[r][c].display();
        }
    }
  }
}

class Tile
{
  color tileColor;
  float tileHeight;
  float tileWidth;
  float xCoord;
  float yCoord;
  
  Tile(float tileHeight, float tileWidth, float xCoord, float yCoord, color tileColor)
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
    rect(xCoord, yCoord, tileHeight, tileWidth);
  }
}
  
