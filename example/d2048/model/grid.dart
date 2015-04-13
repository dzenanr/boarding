part of d2048;

class Tile extends CellPiece {
  static const String tileColor = 'lightyellow';
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
  TileGrid(Table table): super(table) {
    addTwoRandomAvailableCellPieces();
  }

  addTwoRandomAvailableCellPieces() {
    randomAvailableCellPiece();
    randomAvailableCellPiece();
  }

  CellPiece newCellPiece(Grid grid, Cell cell) => new Tile(this, cell);

  CellPiece randomAvailableCellPiece() {
    var cp = cellPieces.randomAvailableCellPiece();
    if (cp != null) {
      cp.tag.number = new Random().nextDouble() < 0.9 ? 2 : 4;
    }
    return cp;
  }
}