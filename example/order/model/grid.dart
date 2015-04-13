part of order;

class Tile extends CellPiece {
  static const String tileColor = 'lightyellow';
  static const String markedTileColor = 'orange';
  static const String tagColor = 'blue';

  Tile(TileGrid grid, Cell cell) {
    this.grid = grid;
    this.cell = cell;
    color.main = tileColor;
    isTagged = true;
    tag.size = 32;
    tag.color.main = tagColor;
  }
}

class TileGrid extends Grid {
  int maxNumber;

  TileGrid(Table table): super(table) {
    maxNumber = table.size.columnCount * table.size.rowCount;
    randomAvailableCellPiece();
  }

  CellPiece newCellPiece(Grid grid, Cell cell) => new Tile(this, cell);

  CellPiece randomAvailableCellPiece() {
    var cp = cellPieces.randomAvailableCellPiece();
    if (cp != null) {
      cp.tag.number = randomInt(maxNumber);
    }
    return cp;
  }
}