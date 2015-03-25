part of grid;

class Grid {
  int columnCount;  
  int rowCount; 
  Size _size;
  var color = new Color('white');

  Cells cells;

  Grid(this.columnCount, this.rowCount) {
    color.border = color.main;
    cells = new Cells(this);
    var cell;
    for (var row = 0; row < rowCount; row++) {
      for (var column = 0; column < columnCount; column++) {
        cell = newCell(this, row, column);
        cells.add(cell);
      }
    }
  }
  
  Size get size => _size;
  set size(Size size) {
    _size = size;
    var cellWidth = size.width / columnCount;
    var cellHeight = size.height / rowCount;
    for (CellPiece cellPiece in cells) {
      cellPiece.width = cellWidth;
      cellPiece.height = cellHeight;
      cellPiece.x = cellPiece.width * cellPiece.column;
      cellPiece.y = cellPiece.height * cellPiece.row;
    }
  }

  CellPiece newCell(Grid grid, int row, int column) {
    return new CellPiece(grid, row, column);
  }

  bool contains(int row, int column) {
    return 0 <= row && row < rowCount && 0 <= column && column < columnCount;
  }
  
  get cellWidth => size.width / columnCount;
  get cellHeight => size.height / rowCount;
}

class SquareGrid extends Grid {
  int length; // in cells
  
  SquareGrid(int s): length = s, super(s, s);
}