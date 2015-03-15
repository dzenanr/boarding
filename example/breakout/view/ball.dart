part of breakout;

class Ball {
  static const num radius = 10;

  Board board;
  num x, y;
  String color, outline;

  Ball(this.board, this.color, [this.outline]) {
    x = board.width / 4;
    y = board.height / 4;
  }

  draw() {
    drawCircle(board.canvas, x, y, radius, color: color, borderColor: outline);
  }
}