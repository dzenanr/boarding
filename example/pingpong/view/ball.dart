part of pingpong;

class Ball {
  Board board;
  num x, y, r;
  String color, outline;

  Ball(this.board, this.x, this.y, this.r) {
    draw();
  }

  draw() {
    drawCircle(board.canvas, x, y, r);
  }
}