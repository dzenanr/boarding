part of grid;

class Composition {
  int currentRow;
  int currentColumn;
  int startRow;
  int startColumn;
  String orientation; // h, v, /, \, L
  bool isSelected = false;
  var cells;  
  Grid grid;
  
  Composition(this.grid) {
    cells = new Cells(grid);
  }
  
  CellPiece cell(int row, int column) {
    for (CellPiece c in cells) {
      if (c.isIn(row, column)) return c;
    }
    return null;
  }
  
  bool isIn(int row, int column) => cells.any((CellPiece c) => c.isIn(row, column)); 
  bool isUpOf(int row, int column) => cells.any((CellPiece c) => c.isUpOf(row, column)); 
  bool isDownOf(int row, int column) => cells.any((CellPiece c) => c.isDownOf(row, column));
  bool isLeftOf(int row, int column) => cells.any((CellPiece c) => c.isLeftOf(row, column));  
  bool isRightOf(int row, int column) => cells.any((CellPiece c) => c.isRightOf(row, column));
  
  select() => cells.forEach((CellPiece c) => c.isSelected = true);
  deselect() => cells.forEach((CellPiece c) => c.isSelected = false);
  
  moveToCell(int row, int column) {
    currentRow = row;
    currentColumn = column;
  }
}