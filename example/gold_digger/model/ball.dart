part of gold_digger;

class Ball extends MovablePiece { 
  BCell _cell;
  
  Ball(BCell cell) {
    this.cell = cell;
    shape = PieceShape.FACE;
    color.main = 'black';
    color.border = 'white';
  }
  
  BCell get cell => _cell;
  set cell(BCell cell) {
    _cell = cell;
    x = cell.width * cell.column;
    y = cell.height * cell.row;
    width = cell.width;
    height = cell.height;
  }
}