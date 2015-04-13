part of gold_digger;

class DCell extends CellPiece {
  DCell(DGrid grid, Cell cell) {
    this.grid = grid;
    this.cell = cell;
    line.width = 0;
    color.main = sevenColorMap()[randomElement(sevenColorNameList())];
    color.border = color.main;
  }
}

class DGrid extends Grid {
  DGrid(Table table): super(table);

  CellPiece newCellPiece(Grid grid, Cell cell) => new DCell(this, cell);
}