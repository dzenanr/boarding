part of tint;

class Tile extends CellPiece {
  Tile(TileGrid grid, Cell cell) {
    this.grid = grid;
    this.cell = cell;
    line.width = 0;
  }
}

class TileGrid extends Grid {
  TileGrid(Table table): super(table);

  CellPiece newCellPiece(Grid grid, Cell cell) => new Tile(this, cell);
}