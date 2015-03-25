part of gold_digger;

class BCell extends CellPiece {
  BCell(BGrid grid, int row, int column): super(grid, row, column) {
    line.width = 0; 
    color.main = sevenColorMap()[randomElement(sevenColorNameList())];
    color.border = color.main;
  }
}

class BGrid extends Grid {
  BGrid(int columnCount, int rowCount): super(columnCount, rowCount);
  
  CellPiece newCell(Grid grid, int row, int column) => new BCell(this, row, column);
}