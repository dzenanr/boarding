part of breakout;

class Bricks {
  static const num rowCount = 5, colCount = 5;
  static const padding = 1;
  
  Board board;
  Wall wall;
 
  Bricks(this.board) {
    wall = new Wall(rowCount, colCount, board.width);
  }

  bool draw() {
    var count = 0;
    for (var i = 0; i < rowCount; i++) {
      for (var j = 0; j < colCount; j++) {
        Brick brick = wall.bricks[i][j];
        if (brick.isVisible) {
          new Rect(board, 
              (j * (brick.width + padding)) + padding, 
              (i * (brick.height + padding)) + padding, 
              brick.width, brick.height, color: brick.colorCode).draw();  
          count++;
        }
      }
    }
    if (count == 0) return false;
    else return true;
  }
}