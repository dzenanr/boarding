part of d2048;

class Tile extends CellPiece {
  
  Tile(TileGrid grid, Cell cell): super(grid, cell) {
    color.main = 'lightyellow';
    isTagged = true;
    tag.size = 32;
    tag.color.main = 'blue';
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