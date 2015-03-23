part of p_art;

class ArtCell extends CellPiece {
  ArtCell(ArtGrid grid, int row, int column): super(grid, row, column) {
    line.width = 0;
    color.main = randomColor();
    color.border = color.main;
  }
}

class ArtGrid extends Grid {
  ArtGrid(int columnCount, int rowCount): super(columnCount, rowCount);
  
  CellPiece newCell(Grid grid, int row, int column) => new ArtCell(this, row, column);
}