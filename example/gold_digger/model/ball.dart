part of gold_digger;

class Ball extends Object with Piece {
  DCell _dCell;

  Ball(DCell dCell) {
    this.dCell = dCell;
    shape = PieceShape.FACE;
    color.main = 'black';
    color.border = 'white';
  }

  DCell get dCell => _dCell;
  set dCell(DCell dCell) {
    _dCell = dCell;
    x = dCell.width * dCell.cell.column;
    y = dCell.height * dCell.cell.row;
    width = dCell.width;
    height = dCell.height;
  }
}