part of d2048;

class Tile extends CellPiece {
  
  Tile(TileGrid grid, int row, int column): super(grid, row, column) {
    color.main = 'lightyellow';
    isTagged = true;
    tag.size = 32;
    tag.color.main = 'blue';
  }
}

class TileGrid extends SquareGrid {
  
  TileGrid(int size): super(size) {
    addTwoRandomAvailableCells();
  }
  
  addTwoRandomAvailableCells() {
    randomAvailableCell();
    randomAvailableCell();
  }
  
  CellPiece newCell(Grid grid, int row, int column) => new Tile(this, row, column);

  CellPiece randomAvailableCell() {
    var c = cells.randomAvailableCell();
    if (c != null) {
      c.number = new Random().nextDouble() < 0.9 ? 2 : 4;
    }
    return c;
  }
}