part of grid;

class Composition {
  Cell currentCell;
  Cell startCell;
  String orientation; // h, v, /, \, L
  bool isSelected = false;
  CellPieces cellPieces;
  Grid _grid;

  Grid get grid => _grid;
  set grid(Grid grid) {
    _grid = grid;
    cellPieces = new CellPieces();
    cellPieces.grid = grid;
  }

  CellPiece cellPiece(int column, int row) {
    for (CellPiece cp in cellPieces) {
      if (cp.cell.isIn(column, row)) return cp;
    }
    return null;
  }

  bool isIn(int column, int row) =>
      cellPieces.any((CellPiece cp) => cp.cell.isIn(column, row));
  bool isLeftOf(int column, int row) =>
      cellPieces.any((CellPiece cp) => cp.cell.isLeftOf(column, row));
  bool isRightOf(int column, int row) =>
      cellPieces.any((CellPiece cp) => cp.cell.isRightOf(column, row));
  bool isUpOf(int column, int row) =>
      cellPieces.any((CellPiece cp) => cp.cell.isUpOf(column, row));
  bool isDownOf(int column, int row) =>
      cellPieces.any((CellPiece cp) => cp.cell.isDownOf(column, row));

  select() => cellPieces.forEach((CellPiece cp) => cp.isSelected = true);
  deselect() => cellPieces.forEach((CellPiece cp) => cp.isSelected = false);

  moveToCell(Cell c) {
    currentCell = c;
  }

  moveToColumnRow(int column, int row) {
    currentCell.column = column;
    currentCell.row = row;
  }
}