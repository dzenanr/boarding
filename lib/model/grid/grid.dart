part of grid;

class Grid {
  String color = 'white';
  int columnCount;  
  int rowCount; 

  Cells cells;

  Grid(this.columnCount, this.rowCount) {
    cells = new Cells(this);
    var cell;
    for (var row = 0; row < rowCount; row++) {
      for (var column = 0; column < columnCount; column++) {
        cell = newCell(this, row, column);
        cells.add(cell);
      }
    }
  }
  
  Cell newCell(Grid grid, int row, int column) {
    return new Cell(grid, row, column);
  }

  bool contains(int row, int column) {
    return 0 <= row && row < rowCount && 0 <= column && column < columnCount;
  }
}

class SquareGrid extends Grid {
  int size; // in cells
  
  SquareGrid(int s): size = s, super(s, s);
}