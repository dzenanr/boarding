part of grids;

class Grid {
  int columnCount;  
  int rowCount; 

  var cells = new Cells();

  Grid(this.columnCount, this.rowCount) {
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

  Cell cell(int row, int column) {
    if (0 <= row && row < rowCount && 0 <= column && column < columnCount) {
      for (Cell cell in cells) {
        if (cell.intersects(row, column)) return cell;
      }
    } else throw new Exception(
        'cell out of grid - row: $row, column: $column');
    return null;
  }
}

class SquareGrid extends Grid {
  int size; // in cells
  
  SquareGrid(int s) : size = s, super(s, s);
}