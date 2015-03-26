part of grid;

class Grid {
  Table table;
  var color = new Color('white');

  CellPieces cellPieces;

  Grid(this.table) {
    color.border = color.main;
    cellPieces = new CellPieces(this);
    var cellPiece;
    for (var column = 0; column < table.columnCount; column++) {
      for (var row = 0; row < table.rowCount; row++) {
        cellPiece = newCellPiece(this, new Cell(column, row));
        cellPieces.add(cellPiece);
      }
    }
    for (CellPiece cp in cellPieces) {
      cp.width = table.cellWidth;
      cp.height = table.cellHeight;
      cp.x = cp.width * cp.cell.column;
      cp.y = cp.height * cp.cell.row;
    }
  }
  
  Position get position => table.position;
  num get x => table.position.x;
  num get y => table.position.y;
  Area get area => table.area;
  num get width => table.area.width;
  num get height => table.area.height;
  Size get size => table.size;
  int get columnCount => table.size.columnCount;
  int get rowCount => table.size.columnCount;
  num get cellWidth => table.cellWidth;
  num get cellHeight => table.cellHeight;

  CellPiece newCellPiece(Grid grid, Cell cell) => new CellPiece(grid, cell);

  bool contains(Cell cell) => table.contains(cell);
}

