int cellSize = 10;
int columns = 600/cellSize;
int rows = 600/cellSize;
int [][] grid = new int[columns][rows];

int livingNeighbourCount;
boolean isAlive;

color aliveColour = color(0, 200, 0);
color deadColour = color(0);

void setup() { 
  size(600, 600);
  initialiseGrid();//board now exists with random 0 and 1 inputs in grid
}

void draw() {
  frameRate(5);
  background(0);
  int [][] grid2 = new int[columns][rows];
  for (int y=1; y<rows-1; y++) {
    for (int x=1; x<columns-1; x++) {
      int neighbourCount = countNeighbours(x, y);
      grid2[x][y] = applyRulesOfLife(grid[x][y], neighbourCount);
    }//grid 2 used so that the rules of life arent applied to the board until all cells considered
  }
  grid = grid2;
  drawGrid();
}

void initialiseGrid() {
  for (int y=0; y<rows; y++) {
    for (int x=0; x<columns; x++) {
      grid[x][y] = int(random(2));
    }
  }
}

void drawGrid() {
  for (int y=0; y<rows; y++) {
    for (int x=0; x<columns; x++) {
      if (grid[x][y] == 1) {
        fill(aliveColour);
      } else {
        fill(deadColour);
      }
      strokeWeight(0);
      ellipse(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}

int countNeighbours(int x, int y) {
  int neighbourCount = 0;
  for (int i=-1; i<=1; i++) {
    for (int j=-1; j<=1; j++) {
      neighbourCount += grid[x+j][y+i];
    }
  }
  neighbourCount -= grid[x][y]; // dont count cell being checked in neighbourCount
  return(neighbourCount);
}


int applyRulesOfLife(int isAlive, int neighbourCount) {
  if (isAlive == 1 && neighbourCount > 3) // death by overpopulation
    return 0;
  else if (isAlive == 1 && neighbourCount < 2) //death by underpopulation
    return(0); 
  else if (isAlive == 0 && neighbourCount == 3) //repopulation 
    return(1);
  else return(isAlive);
}
