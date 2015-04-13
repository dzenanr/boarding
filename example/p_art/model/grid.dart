part of p_art;

class ArtCell extends CellPiece {
  ArtCell(ArtGrid grid, Cell cell) {
    this.grid = grid;
    this.cell = cell;
    line.width = 0;
    color.main = randomColor();
    color.border = color.main;
  }
}

class ArtGrid extends Grid {
  ArtGrid(Table table): super(table);

  CellPiece newCellPiece(Grid grid, Cell cell) => new ArtCell(this, cell);
}